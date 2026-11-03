"""Audit prices and regenerate recipe cost text from object data.

Scroll costs and component costs are authoritative. Finished-item value is the
recursive recipe total. Run `python tools/item_costs.py sync` after editing them.
"""
from pathlib import Path
from functools import lru_cache
import argparse,re
import data_store as ds
ROOT=Path(__file__).resolve().parents[1]

class Catalog:
    def __init__(self):
        self.rows=ds.read(ROOT/'data/object-index.json')
        self.objects={(x['kind'],x['rawcode']):x for x in self.rows}
        self.defaults=ds.read(ROOT/'tools/reference-api/item-prices.json')['items']
        self.spec=ds.read(ROOT/'data/gameplay/recipes.json')
        self.recipes={x['result']:x for x in self.spec['recipes']}
        self.strings=ds.strings(ROOT/'map/ForestExpansion.w3x/war3map.wts')

    def fields(self,kind,raw):
        result={}
        row=self.objects.get((kind,raw))
        if row and row['base']!=raw and (kind,row['base']) in self.objects:
            result.update(self.fields(kind,row['base']))
        for k in [kind,kind+'_skin']:
            entry=self.objects.get((k,raw))
            if entry:
                result.update({m['_field']:ds.resolve(m['Value'],self.strings) for m in ds.read(ROOT/entry['path'])['Modifications']})
        return result

    def name(self,raw):
        return self.fields('items',raw).get('unam',self.objects['items',raw]['name'])

    def shop_items(self,raw):
        fields=self.fields('units',raw)
        return list(dict.fromkeys(item for field in ('usei','umki')
                                 for item in fields.get(field,'').split(',') if item))

    def validate_ancient_shops(self):
        # Aall uses Items Made. Items Sold with Aall can charge the owner and
        # drop an item without a SELL_ITEM event, even with a visible recipient.
        defaults=ds.read(ROOT/'tools/reference-api/shop-defaults.json')['items']
        for raw in self.spec['shops']:
            fields=self.fields('units',raw); abilities=set(fields.get('uabi','').split(','))
            assert {'Aall','Apit'} <= abilities and 'Aneu' not in abilities, f'{raw}: Ancient shop abilities do not match the owned-shop profile.'
            assert fields.get('umki') and not fields.get('usei'), f'{raw}: Shop Sharing requires Items Made (umki), not Items Sold (usei).'
            for item in self.shop_items(raw):
                base=self.objects['items',item]['base']; item_fields=self.fields('items',item)
                assert base in defaults, f'{item}: review inherited shop requirements for base {base}.'
                requires=item_fields.get('ureq',defaults[base]['requires'])
                assert not requires, f'{item}: inherited shop requirement {requires} would block an Ancient purchase.'

    def price(self,raw):
        fields=self.fields('items',raw); base=self.objects['items',raw]['base']
        defaults=self.defaults[base]
        assert defaults['classic']==defaults['reforged'],f'Ambiguous inherited price for {raw}'
        value=(fields.get('igol',defaults['reforged']['gold']),fields.get('ilum',defaults['reforged']['lumber']))
        assert all(type(x)==int and x>=0 for x in value),(raw,value)
        return value

    def total(self,raw,stack=()):
        if raw not in self.recipes:return self.price(raw)
        assert raw not in stack,'Cyclic recipe: '+raw
        recipe=self.recipes[raw]
        prices=[self.total(x,stack+(raw,)) for x in recipe['components']]
        if recipe.get('scroll'):prices.append(self.price(recipe['scroll']))
        return tuple(sum(x[i] for x in prices) for i in (0,1))

    @staticmethod
    def money(price):
        gold,lumber=price
        return f'{gold:,} gold'+(f', {lumber:,} lumber' if lumber else '')

    def scroll_fields(self,recipe):
        name=self.name(recipe['result']); total=self.total(recipe['result'])
        lines=[f'|cffffcc00Full recipe: {self.money(total)}|r',
               f'Recipe scroll: {self.money(self.price(recipe["scroll"]))}.',
               '|n|cff00d200Requires:|r']
        for part in recipe['components']:
            lines.append(f'- {self.name(part)} ({self.money(self.total(part))})')
        lines+=['|nFor the Ancient: buying this scroll automatically buys missing components, including nested recipes. Owned components reduce the cost.',
                'If completion fails, the scroll is refunded and your ingredients are kept.',
                '|n'+self.fields('items',recipe['result']).get('utub','')]
        description='|n'.join(lines)
        return {'unam':f'[Recipe] {name} ({total[0]})',
                'utip':f'|cff00d200[Recipe]|r {name} |cffdcb900[{self.money(total)} total]|r',
                'utub':description,'ides':description}

    def set_field(self,kind,raw,field,value):
        row=self.objects[kind,raw]; path=ROOT/row['path']; obj=ds.read(path)
        matches=[m for m in obj['Modifications'] if m['_field']==field]
        assert len(matches)<=1,(kind,raw,field)
        if matches: mod=matches[0]
        else:
            mod={'Id':int.from_bytes(field.encode('ascii'),'little'),'Type':'String' if isinstance(value,str) else 'Int',
                 'Value':value,'SanityCheck':0,'_field':field}
            obj['Modifications'].append(mod)
        if mod['Value']==value and matches:return
        mod['Value']=value;mod.pop('_resolvedText',None);ds.write(path,obj)

    def sync(self):
        for recipe in self.spec['recipes']:
            for field,value in zip(('igol','ilum'),self.total(recipe['result'])):
                self.set_field('items',recipe['result'],field,value)
            if recipe.get('scroll'):
                for field,value in self.scroll_fields(recipe).items():
                    self.set_field('items_skin',recipe['scroll'],field,value)
        # Names/index are annotations, but keep them useful after generated edits.
        for row in self.rows:
            if row['kind'] not in ('items','items_skin'):continue
            name=self.name(row['rawcode']); row['name']=name
            path=ROOT/row['path']; obj=ds.read(path); obj['_name']=name; ds.write(path,obj)
        ds.write(ROOT/'data/object-index.json',self.rows)

    def validate(self):
        self.validate_ancient_shops()
        recipes=[]
        for recipe in self.spec['recipes']:
            raw=recipe['result']; total=self.total(raw)
            assert self.price(raw)==total,f'{raw} value differs from recipe total. Run tools/item_costs.py sync.'
            if recipe.get('scroll'):
                actual=self.fields('items',recipe['scroll'])
                for field,expected in self.scroll_fields(recipe).items():
                    assert actual[field]==expected,f'{recipe["scroll"]} {field} is stale. Run tools/item_costs.py sync.'
            recipes.append({'result':raw,'name':self.name(raw),'scroll':recipe.get('scroll'),
                            'scroll_price':self.price(recipe['scroll']) if recipe.get('scroll') else [0,0],
                            'full_price':total,'finished_item_value':self.price(raw)})
        shops=[]; ids=set()
        for row in self.rows:
            if row['kind']!='units':continue
            fields=self.fields('units',row['rawcode'])
            items=self.shop_items(row['rawcode'])
            if items:
                ids.update(items)
                shops.append({'rawcode':row['rawcode'],'items':items})
        items=[]
        for raw in sorted(ids):
            fields=self.fields('items',raw)
            items.append({'rawcode':raw,'name':self.name(raw),'price':self.price(raw),
                          'inherited_gold':'igol' not in fields,'inherited_lumber':'ilum' not in fields})
        return {'recipes':recipes,'shops':shops,'sold_items':items,
                'scope':'All configured shop item prices, recursive crafting totals, crafted values and generated recipe tooltips. Economic consistency, not a complete race/unit balance assessment.',
                'inherited_prices':'Verified against matching Custom-game 1.27.1 and 1.32.8 snapshots in tools/reference-api/item-prices.json; native current-engine validation remains a live check.'}

def main():
    parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('command',choices=['sync','check']);args=parser.parse_args()
    catalog=Catalog()
    if args.command=='sync':catalog.sync()
    report=catalog.validate();ds.write(ROOT/'reports/cost-audit.json',report)
    print(f'Costs checked: {len(report["recipes"])} recipes, {len(report["sold_items"])} distinct items in {len(report["shops"])} shops.')
if __name__=='__main__':main()
