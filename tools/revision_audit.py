"""Verify successive explicit object migrations from the published r12 snapshot.

Each permitted serialized-field change has an explicit before/after record and
reason. This keeps the historical tooltip-only preservation claim separate from
later gameplay fixes; it does not replace or rewrite either frozen baseline.
"""
from pathlib import Path
import copy,json,zipfile
import data_store as ds

ROOT=Path(__file__).resolve().parents[1]
FIXTURE='tests/fixtures/gameplay-r12.zip'
FIXTURE_SHA='faeb1a46bd99d0d558917cf9e25a661394a20b38b3b598f870fc9d3b56a1bfa5'

def baseline_objects():
    path=ROOT/FIXTURE
    assert ds.digest(path.read_bytes())==FIXTURE_SHA,'Published r12 fixture changed'
    with zipfile.ZipFile(path) as archive:
        return {name:json.loads(archive.read(name)) for name in archive.namelist()
                if name.startswith('data/objects/') and name.endswith('.json')}

def validate_objects():
    old=baseline_objects()
    actual={p.relative_to(ROOT).as_posix():ds.read(p) for p in (ROOT/'data/objects').rglob('*.json')}
    assert actual.keys()==old.keys(),'Unexpected added/removed object'
    expected={path:ds.canonical(value) for path,value in old.items()}
    historical=ROOT/'data/migrations/r13-object-fixes.json'
    assert ds.digest(historical.read_bytes())=='72ca7b78511c7aa4b0b8dfe30fce574853c8b74f7cd15171ec23c4e63c7763e6','Historical r13 migration changed'
    stages=[('data/migrations/r13-object-fixes.json','3908a135c7733444aca1c0a85cf9a1e9236a21bd'),
            ('data/migrations/r14-picker-layout.json','166377721e69e9f29844d2c5d01eef1a505570d0')]
    count=0; base_changes=0; changed=set()
    for manifest,commit in stages:
        migration=ds.read(ROOT/manifest)
        assert migration['baseline_commit']==commit
        allowed={entry['path']:entry for entry in migration['objects']}
        assert len(allowed)==len(migration['objects']) and set(allowed)<=old.keys()
        changed.update(allowed)
        for path,entry in allowed.items():
            obj=expected[path]
            assert entry['reason'],'Object correction must explain its behavior'
            if 'base_change' in entry:
                change=entry['base_change']
                assert change['before']!=change['after']
                assert obj['OldId']==change['before'],(path,'baseline native base mismatch')
                obj['OldId']=change['after']
                base_changes+=1
            for change in entry['changes']:
                prior,after=change['before'],change['after']
                assert prior!=after and after is not None
                matches=[i for i,m in enumerate(obj['Modifications'])
                         if m['Id']==after['Id'] and m.get('Level',0)==after.get('Level',0)]
                if prior is None:
                    assert not matches,(path,'New field already exists',change)
                    obj['Modifications'].append(copy.deepcopy(after))
                else:
                    assert prior['Id']==after['Id'] and prior.get('Level',0)==after.get('Level',0)
                    assert len(matches)==1,(path,change)
                    index=matches[0]
                    assert obj['Modifications'][index]==prior,(path,'baseline record mismatch',change)
                    obj['Modifications'][index]=copy.deepcopy(after)
                count+=1
    for path,obj in expected.items():
        assert obj==ds.canonical(actual[path]),'Unreviewed object change: '+path
    return {'baseline':FIXTURE,'baseline_sha256':FIXTURE_SHA,
            'manifests':[path for path,_ in stages],
            'changed_objects':len(changed),'serialized_field_changes':count,'native_base_changes':base_changes,
            'other_object_fields_unchanged':True}

if __name__=='__main__':print(json.dumps(validate_objects(),indent=2))
