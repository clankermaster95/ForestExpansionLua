"""Picker stock timing/prerequisites from authored and independently decoded data.

The Lua model consumes these actual object values. It is deliberately not a
claim that the model reproduces every native shop UI quirk.
"""
from pathlib import Path
import json,sys
ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/'tools'))
import data_store as ds


def catalog():
    data=ds.read(ROOT/'data/gameplay/factions.json')
    return [(kind,entry) for kind in ('expanders','ancients') for entry in data[kind]]


def fields(raw,category='units',group='NewUnits'):
    result={}
    for kind in (category,category+'_skin'):
        path=ROOT/f'data/objects/{kind}/{group}/{raw}.json'
        if not path.exists():continue
        for mod in ds.read(path)['Modifications']:
            result[ds.rawcode(mod['Id'])]=mod
    return result


def check_fields(kind,raw,values):
    for field,expected in (('usst',0),('usrg',1),('usma',0)):
        mod=values[field]
        assert mod['Type']=='Int' and mod['Value']==expected,(raw,field,mod)
    required={'RFPK'}|({'RFPA'} if kind=='ancients' else set())
    assert set(values['ureq']['Value'].split(','))==required,(raw,'phase prerequisites')


def check_random(raw,values):
    for field,expected in (('isst',0),('istr',0),('isto',10)):
        assert values[field]['Type']=='Int' and values[field]['Value']==expected,(raw,field,values[field])


def check_selector(raw,values):
    assert values['usei']['Value']=='',(raw,'native random stock must not bypass phase ownership')
    assert set(values['uabi']['Value'].split(','))=={'Ane2','Asud','Asid','Avul'},(raw,'dynamic unit/item shop capabilities')


def prepare():
    """Call before tests/solo_startup.lua so its stock double reads real values."""
    rows=[]
    for kind,entry in catalog():
        raw=entry['raw'];values=fields(raw);check_fields(kind,raw,values)
        rows.append('['+json.dumps(raw)+']={start='+str(values['usst']['Value'])+
                    ',interval='+str(values['usrg']['Value'])+',maximum='+
                    str(values['usma']['Value'])+'}')
    for raw in ('I00W','I00X'):
        values=fields(raw,'items','NewItems');check_random(raw,values)
        rows.append('['+json.dumps(raw)+']={start='+str(values['isst']['Value'])+
                    ',interval='+str(values['istr']['Value'])+',maximum='+str(values['isto']['Value'])+'}')
    for raw in ('nmer','nmr2'):
        values=fields(raw,'units','BaseUnits');check_selector(raw,values)
        rows.append('['+json.dumps(raw)+']={sellsItems='+str('Asid' in values['uabi']['Value'].split(',')).lower()+'}')
    out=ROOT/'build/picker-stock-test-input.lua'
    out.parent.mkdir(exist_ok=True)
    out.write_text('return {'+','.join(rows)+'}\n',encoding='utf-8',newline='\n')
    return {'picker_types':len(catalog()),'random_items':2,'stock_start_delay':0,'stock_interval':1}


def validate():
    report=prepare();packed={}
    for name in ('war3map.w3u.json','war3mapSkin.w3u.json','war3map.w3t.json','war3mapSkin.w3t.json'):
        data=ds.read(ROOT/'build/refactor-readback'/name)
        for group in data.values():
            if not isinstance(group,list):continue
            for obj in group:
                raw=ds.rawcode(obj['NewId'] or obj['OldId'])
                values=packed.setdefault(raw,{})
                values.update({ds.rawcode(m['Id']):m for m in obj['Modifications']})
    for kind,entry in catalog():check_fields(kind,entry['raw'],packed[entry['raw']])
    for raw in ('I00W','I00X'):check_random(raw,packed[raw])
    for raw in ('nmer','nmr2'):check_selector(raw,packed[raw])
    # The original Worgen delay and interval each independently fail. Also
    # exercise prerequisite and preview-cap checks against a representative row.
    count=0
    for field,value in [('usst',10),('usrg',3600),('usma',1),('ureq','')]:
        values=fields('h00R');values[field]=dict(values[field],Value=value)
        try:check_fields('expanders','h00R',values)
        except AssertionError:count+=1
        else:raise AssertionError('Picker object negative check was accepted: '+field)
    for raw,field,value,checker,category,group in [
        ('I00W','isst',20,check_random,'items','NewItems'),
        ('I00X','isst',60,check_random,'items','NewItems'),
        ('nmer','usei','I00W',check_selector,'units','BaseUnits'),
        ('nmr2','usei','I00X',check_selector,'units','BaseUnits'),
        ('nmer','uabi','Ane2,Asud,Avul',check_selector,'units','BaseUnits'),
        ('nmr2','uabi','Ane2,Asud,Avul',check_selector,'units','BaseUnits'),
    ]:
        values=fields(raw,category,group);values[field]=dict(values[field],Value=value)
        try:checker(raw,values)
        except AssertionError:count+=1
        else:raise AssertionError('Random picker negative check was accepted: '+raw)
    return dict(report,packed_picker_types_checked=len(catalog()),negative_checks=count)


if __name__=='__main__':
    print(json.dumps(prepare() if '--prepare' in sys.argv else validate(),indent=2))
