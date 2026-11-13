"""Read back a real World Editor save; this tool does not launch the editor/game.

Run only after observing Save Map finish in the native editor. The object diff
is evidence for review, not an assumption that removed overrides are harmless.
"""
from pathlib import Path
import argparse,collections,json,struct,subprocess,tempfile
import data_store as ds
import project
from lua_source import functions,tokens
from mpq import unpack

ROOT=Path(__file__).resolve().parents[1]


def object_records(document, strings):
    records={}
    for group,objects in document.items():
        if not isinstance(objects,list):continue
        for obj in objects:
            key=(group,ds.rawcode(obj['NewId'] or obj['OldId']))
            mods={}
            for mod in obj['Modifications']:
                field=(ds.rawcode(mod['Id']),mod.get('Level',0),mod.get('Pointer',0))
                value=ds.resolve(mod['Value'],strings)
                if mod['Type'] in ('Real','Unreal'):value=struct.pack('<f',value).hex()
                assert field not in mods,(key,field)
                mods[field]={'type':mod['Type'],'value':value,'sanity':mod['SanityCheck']}
            records[key]={'base':ds.rawcode(obj['OldId']),'modifications':mods}
    return records


def verify(saved, editor_version, reopened=False):
    cfg=project.config();source=ROOT/cfg['output'];saved=Path(saved).resolve()
    assert source.resolve()!=saved,'Validate a separate editor copy'
    with tempfile.TemporaryDirectory(prefix='actual-editor-',dir=ROOT/'build') as temporary:
        work=Path(temporary);before=work/'before';after=work/'after'
        a=unpack(source,before);b=unpack(saved,after)
        a={k:v for k,v in a.items() if not k.startswith('(')}
        b={k:v for k,v in b.items() if not k.startswith('(')}
        assert a.keys()==b.keys(),'Editor added or removed map payloads'
        changed=[name for name in a if a[name]['sha256']!=b[name]['sha256']]
        project.tool('export',after,work/'decoded')
        modules=project.editor_modules(after,cfg)
        assert all(code.rstrip()==(ROOT/path).read_text(encoding='utf-8').rstrip() for path,code in modules.items()),'Editor changed module source'
        scripts=[(folder/'war3map.lua').read_text(encoding='utf-8') for folder in (before,after)]
        bodies=[]
        for script in scripts:
            bodies.append({f['name']:[t.text for t in tokens(script[f['start']:f['end']])]
                           for f in functions(script) if f['name'] and f['parent'] is None})
        assert bodies[0]==bodies[1],'Editor changed function logic, including creation/config/bootstrap'
        for runtime in ('lua-5.3.6','lua-5.3.6-32'):
            subprocess.run([str(ROOT/'.tools'/runtime/'src/luac'),'-p',str(after/'war3map.lua')],check=True)
        info=ds.read(work/'decoded/war3map.w3i.json')
        assert info['ScriptLanguage']=='Lua'
        strings_before=ds.strings(before/'war3map.wts');strings_after=ds.strings(after/'war3map.wts')
        assert ds.resolve(info['MapName'],strings_after) and ds.resolve(info['MapDescription'],strings_after)
        deltas=[];objects=0
        for filename,spec in ds.read(ROOT/'data/index.json').items():
            if spec['kind']!='objects':continue
            original=object_records(ds.assemble(ROOT/'data',spec),strings_before)
            written=object_records(ds.read(work/'decoded'/(filename+'.json')),strings_after)
            assert original.keys()==written.keys(),'Editor changed object inventory: '+filename
            objects+=len(original)
            for key,obj in original.items():
                other=written[key]
                if obj['base']!=other['base']:
                    deltas.append({'file':filename,'object':key,'property':'base','before':obj['base'],'after':other['base']})
                x,y=obj['modifications'],other['modifications']
                for field in sorted(x.keys()|y.keys()):
                    if x.get(field)!=y.get(field):
                        deltas.append({'file':filename,'object':key,'field':field,'before':x.get(field),'after':y.get(field)})
        # Metadata, native placements, terrain and imports must survive exactly.
        object_files={name for name,spec in ds.read(ROOT/'data/index.json').items() if spec['kind']=='objects'}
        assert set(changed)<=object_files|{'war3map.lua','war3map.wts'},changed
        report={'revision':cfg['revision'],'editor_version':editor_version,
                'built_map_sha256':ds.digest(source.read_bytes()),'saved_map_sha256':ds.digest(saved.read_bytes()),
                'native_save_observed_by_operator':True,'native_reopen_observed_by_operator':reopened,
                'modules_unchanged':len(modules),'named_functions_unchanged':len(bodies[0]),
                'lua_syntax':'passed in both numeric builds','script_language':info['ScriptLanguage'],
                'map_name':ds.resolve(info['MapName'],strings_after),'map_description_present':True,
                'archive_payloads':len(a),'objects_preserved':objects,'changed_payloads':changed,
                'terrain_placements_imports_metadata_unchanged':True,'object_record_deltas':deltas,
                'object_review':f"See reports/editor-object-roundtrip-{cfg['revision']}.json for reviewed default/serialization normalization; this script does not infer inherited native defaults.",
                'limits':'Native editor load/save and Lua storage checks only. No game/Test Map launch, multiplayer, native rendering, save/load gameplay or desync proof.'}
        return report


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('saved',type=Path)
    parser.add_argument('--editor-version',required=True)
    parser.add_argument('--reopened',action='store_true',help='Operator observed the saved copy reopen successfully')
    args=parser.parse_args()
    report=verify(args.saved,args.editor_version,args.reopened)
    ds.write(ROOT/f"reports/editor-validation-{report['revision']}.json",report)
    print(json.dumps({k:v for k,v in report.items() if k!='object_record_deltas'},indent=2))
