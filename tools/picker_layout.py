"""Explicit picker command cards, shared by source-data and native-save checks."""
from pathlib import Path
import json
import data_store as ds
import faction_data

ROOT=Path(__file__).resolve().parents[1]


def layout():
    data=faction_data.load();cards=[]
    for kind in ('expanders','ancients'):
        for random in data['randomStock'][kind]:
            choices=[('items',random['raw'],'Random')]
            choices += [('units',r['raw'],r['key']) for r in data[kind] if r['shop']==random['shop']]
            cards.append({'shop':random['shop'],'kind':kind,'buttons':[
                {'category':category,'raw':raw,'name':name,'hotkey':data['pickerHotkeys'][index],
                 'x':index%4,'y':index//4}
                for index,(category,raw,name) in enumerate(choices)]})
    return cards


def fields(category,raw):
    result={}
    for layer in (category,category+'_skin'):
        matches=list((ROOT/'data/objects'/layer).glob('*/'+raw+'.json'))
        assert len(matches)<=1
        if matches:
            for mod in ds.read(matches[0])['Modifications']:
                result[ds.rawcode(mod['Id'])]=mod['Value']
    return result


def validate(read_fields=fields):
    cards=layout();count=0
    for card in cards:
        seen_keys=set();seen_positions=set()
        for index,button in enumerate(card['buttons']):
            actual=read_fields(button['category'],button['raw'])
            position=(actual.get('ubpx'),actual.get('ubpy'))
            key=actual.get('uhot')
            assert position==(button['x'],button['y']),(card['shop'],button['raw'],'button position')
            assert key==button['hotkey'],(card['shop'],button['raw'],'hotkey')
            assert key not in seen_keys and position not in seen_positions,'Picker command-card collision'
            assert actual['utip'].endswith('(|cffffcc00'+key+'|r)'),(button['raw'],'tooltip hotkey')
            if index==0:assert button['category']=='items' and position==(0,0) and key=='Q'
            seen_keys.add(key);seen_positions.add(position);count+=1
        shop=card['shop'].split('_')[2];abilities=read_fields('units',shop)['uabi'].split(',')
        assert 'Asid' in abilities and 'Asud' in abilities and 'Ane2' in abilities
        assert read_fields('units',shop)['usei']=='','Native item stock bypasses phase gate'
    return {'cards':cards,'button_checks':count,'result':'passed',
            'scope':'Explicit native positions/hotkeys and tooltip labels, not a running-game input test.'}


if __name__=='__main__':print(json.dumps(validate(),indent=2))
