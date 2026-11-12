"""Check the tooltip pass, actual packed text, and rejection of bad descriptions."""
from pathlib import Path
import json,re,sys
ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/'tools'))
import data_store as ds
from tooltip_audit import Catalog, TEXT_FIELDS, validate as audit

def validate():
    report=audit(); c=Catalog(); checked=0
    # This baseline compares every object, not just a selected sample. Only
    # presentation strings may differ from the tested r11 gameplay data.
    assert report['gameplay_object_fields_unchanged'] and not report['issues']
    decoded={}
    for path in (ROOT/'build/refactor-readback').glob('*.json'):
        ext=Path(path.stem).suffix
        if ext not in ds.KINDS:continue
        kind=ds.KINDS[ext]+('_skin' if 'Skin' in path.name else '')
        data=ds.read(path)
        for records in data.values():
            if not isinstance(records,list):continue
            for obj in records:
                if not isinstance(obj,dict) or 'Modifications' not in obj:continue
                raw=ds.rawcode(obj['NewId'] or obj['OldId'])
                decoded[kind,raw]={(ds.rawcode(m['Id']),m.get('Level',0)):ds.resolve(m['Value'],c.strings)
                                   for m in obj['Modifications']}
    for row in c.rows():
        assert decoded[row['kind'],row['rawcode']][row['field'],row['level']]==row['text'],row
        checked+=1
    # Regressions for observed stale player-facing descriptions.
    f=c.fields
    assert '25 seconds' in f('abilities','A075')['arut',0]
    assert 'Normal attacks remain available' in f('abilities','A06W')['arut',0]
    assert 'cannot be dispelled' in f('abilities','A06U')['arut',0]
    for level in range(1,22):
        text=f('abilities','A04C')['aub1',level]
        assert str(25+5*(level-1))+' damage per second' in text
        assert str(10+2*(level-1))+'% reduced attack and movement speed' in text
    for level in range(1,7):
        text=f('abilities','A0CO')['aub1',level]
        assert '40 damage per second' in text and '4 seconds' in text
        assert '240 damage per second, 24% slow' in text and 'stacks with orb effects' in text
        assert 'DataA' not in text # Old poison data no longer belongs to this passive.
    assert '24 of your units' in f('items','I00U')['utub',0]
    assert '<A096,DataB1,%>%' in f('items','I01R')['utub',0]
    assert '<A0DX,Dur1>' in f('items','I027')['utub',0]
    assert '<e00U,realHP>' in f('abilities','A0AB')['aub1',1]
    # Cultist research buttons show time beside the name at every level.
    # Slower Decay inherits Rume's 15-second increment from native data;
    # the other four upgrades explicitly define both timing fields.
    research_times={'RFCA':[30], 'RFCS':[30], 'RFCB':[40],
                    'RFAT':[20]*5, 'R07X':[15,30,45,60]}
    for raw,times in research_times.items():
        fields=f('upgrades',raw)
        for level,seconds in enumerate(times,1):
            assert fields['gtp1',level].endswith(f'[{seconds:.1f}]')
            assert fields['gtib',0]+fields.get(('gtim',0),15)*(level-1)==seconds
    # Exercise the general checks with old and deliberately broken input.
    probes=[('units_skin','h01I','utub',0,'Health: 1000','Health differs'),
            ('abilities_skin','A08I','aub1',1,'90 second cooldown.','Cooldown differs'),
            ('abilities_skin','A09E','aub1',1,'Deals <A09Ei,DataA1> damage.','Malformed object reference'),
            ('abilities_skin','A075','arut',0,'TRIGSTR_99999999','Unresolved string'),
            ('abilities_skin','A075','arut',0,'|cff50 seconds cooldown','Malformed color')]
    for kind,raw,field,level,bad,reason in probes:
        obj=c.records[kind,raw][1]
        mod=next(m for m in obj['Modifications'] if m['_field']==field and m.get('Level',0)==level)
        saved=mod['Value'];mod['Value']=bad
        try:assert any(reason in i['reason'] and i['rawcode']==raw for i in c.issues()[0])
        finally:mod['Value']=saved
    return {'packed_text_fields_checked':checked,'changed_objects':report['changed_objects'],
            'changed_text_fields':report['changed_fields'],'negative_checks':len(probes),
            'gameplay_object_fields_unchanged':True,'coverage':report['coverage']}

if __name__=='__main__':print(json.dumps(validate(),indent=2))
