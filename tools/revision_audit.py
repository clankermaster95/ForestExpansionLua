"""Verify intentional r13 object corrections against the published r12 snapshot.

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
    migration=ds.read(ROOT/'data/migrations/r13-object-fixes.json')
    assert migration['baseline_commit']=='3908a135c7733444aca1c0a85cf9a1e9236a21bd'
    allowed={entry['path']:entry for entry in migration['objects']}
    assert len(allowed)==len(migration['objects']) and set(allowed)<=old.keys()
    actual={p.relative_to(ROOT).as_posix():ds.read(p) for p in (ROOT/'data/objects').rglob('*.json')}
    assert actual.keys()==old.keys(),'Unexpected added/removed object'
    count=0; base_changes=0
    for path,before in old.items():
        expected=ds.canonical(before)
        if path in allowed:
            entry=allowed[path]
            assert entry['reason'],'Object correction must explain its behavior'
            if 'base_change' in entry:
                change=entry['base_change']
                assert change['before']!=change['after']
                assert expected['OldId']==change['before'],(path,'baseline native base mismatch')
                expected['OldId']=change['after']
                base_changes+=1
            for change in entry['changes']:
                prior,after=change['before'],change['after']
                assert prior!=after and prior['Id']==after['Id']
                assert prior.get('Level',0)==after.get('Level',0)
                matches=[i for i,m in enumerate(expected['Modifications'])
                         if m['Id']==prior['Id'] and m.get('Level',0)==prior.get('Level',0)]
                assert len(matches)==1,(path,change)
                index=matches[0]
                assert expected['Modifications'][index]==prior,(path,'baseline record mismatch',change)
                expected['Modifications'][index]=copy.deepcopy(after)
                count+=1
        assert expected==ds.canonical(actual[path]),'Unreviewed object change: '+path
    return {'baseline':FIXTURE,'baseline_sha256':FIXTURE_SHA,
            'manifest':'data/migrations/r13-object-fixes.json',
            'changed_objects':len(allowed),'serialized_field_changes':count,'native_base_changes':base_changes,
            'other_object_fields_unchanged':True}

if __name__=='__main__':print(json.dumps(validate_objects(),indent=2))
