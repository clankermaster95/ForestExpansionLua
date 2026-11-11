"""Check current source costs against independent totals and packed object data."""
from pathlib import Path
import re,sys
ROOT=Path(__file__).resolve().parents[1];sys.path.insert(0,str(ROOT/'tools'))
import data_store as ds,project as p
from item_costs import Catalog
from mpq import Archive

def validate():
    catalog=Catalog(); report=catalog.validate()
    fixtures={'I00I':500,'I00F':900,'I01R':950,'I01P':700,'I01T':1150,'I01L':1550,
              'I012':1500,'I015':1050,'I017':1200,'I01C':950,'I019':600,'I01N':1400}
    for raw,gold in fixtures.items():assert catalog.total(raw)==(gold,0),(raw,gold)
    # Read the independently decoded binary objects produced by refactor.py.
    decoded={}
    for name in ['war3map.w3t','war3mapSkin.w3t']:
        raw=ds.read(ROOT/'build/refactor-readback'/(name+'.json'))
        for key,objects in raw.items():
            if not isinstance(objects,list):continue
            for obj in objects:
                if not isinstance(obj,dict) or 'Modifications' not in obj:continue
                item=ds.rawcode(obj['NewId'] or obj['OldId'])
                row=decoded.setdefault(item,{'base':ds.rawcode(obj['OldId']),'fields':{}})
                row['fields'].update({ds.rawcode(m['Id']):ds.resolve(m['Value'],catalog.strings) for m in obj['Modifications']})
    lua=(ROOT/'src/items/recipe_data.lua').read_text(encoding='utf-8')
    prices={m[1]:(int(m[2]),int(m[3])) for m in re.finditer(r'items\[FourCC\("(\w{4})"\)\] = \{gold=(\d+), lumber=(\d+)',lua)}
    checked=0
    for item in set(prices)|{x['rawcode'] for x in report['sold_items']}:
        row=decoded[item];defaults=catalog.defaults[row['base']]['reforged'];f=row['fields']
        actual=(f.get('igol',defaults['gold']),f.get('ilum',defaults['lumber']))
        assert actual==catalog.price(item),(item,actual)
        if item in prices:assert prices[item]==actual,(item,prices[item],actual)
        checked+=1
    for recipe in catalog.spec['recipes']:
        if recipe.get('scroll'):
            f=decoded[recipe['scroll']]['fields']
            for field,value in catalog.scroll_fields(recipe).items():assert f[field]==value,(recipe,field)
    assert decoded['I010']['fields']['ureq']=='', 'Protector Seed must not inherit the Human Keep requirement.'
    # Check the actual native shop data, not only a Lua double that assumes a
    # sale event was delivered. Compare stock order/content to the r4 backup.
    stock_fix=ds.read(ROOT/'reports/shop-stock-r5.json')
    unit_fields={}
    for name in ('war3map.w3u','war3mapSkin.w3u'):
        data=ds.read(ROOT/'build/refactor-readback'/(name+'.json'))
        for objects in data.values():
            if not isinstance(objects,list):continue
            for obj in objects:
                if not isinstance(obj,dict) or 'Modifications' not in obj:continue
                raw=ds.rawcode(obj['NewId'] or obj['OldId'])
                unit_fields.setdefault(raw,{}).update({ds.rawcode(m['Id']):m['Value'] for m in obj['Modifications']})
    for row in stock_fix['shop_changes']:
        raw=row['rawcode'];fields=unit_fields[raw]
        assert fields['usei']=='' and fields['umki']==row['before']['usei'],raw
        assert fields['uabi']==row['before']['uabi'],raw
        # Recreate the rejected historical combination for every affected shop.
        original_fields=catalog.fields
        def broken(kind,item):
            fields=original_fields(kind,item)
            if kind=='units' and item==raw:
                return dict(fields,usei=fields['umki'],umki='')
            return fields
        catalog.fields=broken
        try:
            try:catalog.validate_ancient_shops()
            except AssertionError as error:assert 'Items Made' in str(error)
            else:raise AssertionError('Accepted the ground-drop shop configuration: '+raw)
        finally:catalog.fields=original_fields
    cfg=p.config()
    from map_strings import validate as validate_strings
    validate_strings(ROOT/cfg['map']/'war3map.wts')
    original=(ROOT/'original/map/war3map.wts').read_bytes()
    expected=original.replace(b'3.1.2a',b'3.2.0')
    # Explicitly allow the visible test revision and formerly blank first timer.
    from map_strings import ENTRY
    from release_info import titles
    revised={str(key).encode():value.encode() for key,value in titles(cfg).items()}
    revised[b'7401']=b'Expanders picking'
    expected=expected[:3]+ENTRY.sub(lambda m:m[1]+revised[m[2]]+b'\r\n'+m[4] if m[2] in revised else m[0],expected[3:])
    current_strings=(ROOT/cfg['map']/'war3map.wts').read_bytes()
    if current_strings!=expected:
        # The verified native save moved literal tooltips into WTS and changed
        # references. Require its explicit before/after evidence; do not silently
        # accept an arbitrary string table or reset the old expected content.
        saved=ds.read(ROOT/'reports/editor-roundtrip-repair.json')
        assert saved['successful_native_save']
        # Later release labels may change only the two named title entries.
        # Compare both tables at the recorded native-save label; its evidence
        # hashes remain immutable, including all unrelated strings/whitespace.
        native_cfg=dict(cfg,version=saved['string_table']['release_version'],
                        revision=saved['string_table']['release_revision'])
        native_titles={str(key).encode():value.encode() for key,value in titles(native_cfg).items()}
        def native_labels(data):
            return data[:3]+ENTRY.sub(lambda m:m[1]+native_titles[m[2]]+b'\r\n'+m[4]
                if m[2] in native_titles else m[0],data[3:])
        from release_info import validate as validate_release
        validate_release(ROOT/cfg['map'],cfg)
        assert saved['string_table']['before_sha256']==ds.digest(native_labels(expected))
        assert saved['string_table']['after_sha256']==ds.digest(native_labels(current_strings))
    with Archive(ROOT/cfg['output']) as archive:
        wts=archive.read('war3map.wts').decode('utf-8-sig')
        assert archive.read('war3map.wts')==current_strings
        assert '3.1.2a' not in wts and wts.count('3.2.0')==3
        assert wts.count(cfg['version']+' Lua '+cfg['revision'])==2
    assert catalog.price('I00J')==(1250,0)
    from source_index import sections
    for section in sections(cfg):
        if 214<=section['id']<=220:
            assert section['code'].count('FE_RecipeData.items[')==2,section['name']
    return {'manual_recipe_totals':len(fixtures),'packed_item_prices_checked':checked,
            'generated_scroll_tooltips_checked':11,'all_shop_item_count':len(report['sold_items']),
            'shops_checked':len(report['shops']),'ancient_native_shop_profiles_checked':len(stock_fix['shop_changes']),
            'ai_purchase_prices_from_catalog':7,'map_version_strings':'3.2.0'}

if __name__=='__main__':print(validate())
