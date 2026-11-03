"""One-time checked consolidation of 375 trigger files into system/race modules.

Back up first; compare old/new compiled functions in both Lua modes before
switching source/editor manifests. Never rerun to overwrite subsequent edits.
"""
from pathlib import Path
import collections,json,re,shutil,subprocess
import project as p
import data_store as ds

DIRECT={'ai':'behavior','combat':'common','commands':'player','economy':'income',
        'items':'effects','players':'participation','ui':'animations'}

def target(path):
    folder=Path(path).parent
    if folder.parent==Path('src'):return (folder/(DIRECT[folder.name]+'.lua')).as_posix()
    return folder.as_posix()+'.lua'

def main():
    root=p.ROOT;cfg=p.config();mapdir=root/cfg['map']
    report_path=root/'reports/consolidation.json'
    if report_path.exists():raise RuntimeError('Consolidation already performed; edit current modules directly.')
    assert len(cfg['triggers'])==375
    assert not p.pending_json_edits() and not ds.changes(root,mapdir)
    embedded,conflicts=p.code_changes(mapdir,cfg);assert not conflicts
    baseline=ds.read(root/'data/code-baseline.json')
    for path,code in embedded.items():
        assert code.rstrip()==(root/path).read_text(encoding='utf-8').rstrip(),path
        assert ds.digest(code.rstrip().encode())==baseline[path],path
    groups=collections.OrderedDict();records=[]
    for old in cfg['triggers']:
        new=target(old)
        assert (root/new).resolve().is_relative_to(root/'src')
        number,name=Path(old).stem.split('_',1)
        code=embedded[old]
        groups.setdefault(new,[]).append(f'-- BEGIN FOREST SECTION {int(number)} {name}\n{code}-- END FOREST SECTION {int(number)}\n')
        records.append({'id':int(number),'name':name,'from':old,'to':new,
                        'before_sha256':ds.digest((root/old).read_bytes()),'body_sha256':ds.digest(code.encode())})
    assert len({Path(path).stem for path in groups})==len(groups),'Editor names collide'
    rendered={path:'-- '+path.removeprefix('src/').removesuffix('.lua').replace('/',' / ')+'\n'
                   '-- Related gameplay callbacks; original initialization order is in src/initialization.lua.\n\n'
                   +'\n'.join(parts) for path,parts in groups.items()}
    for path,code in rendered.items():
        if (root/path).exists():assert (root/path).read_text()==code,'Refuse to overwrite existing source: '+path
    backup=p.backup_project(include_data=True)
    shutil.copy2(root/cfg['output'],backup/'baseline.w3x')
    for path,parts in groups.items():
        (root/path).parent.mkdir(parents=True,exist_ok=True)
        (root/path).write_text(rendered[path],encoding='utf-8',newline='\n')
    old_paths=[(backup/path).as_posix() for path in cfg['triggers']]
    spec=root/'build/consolidation-input.lua'
    array=lambda paths:'{'+','.join(json.dumps(path) for path in paths)+'}'
    spec.write_text('return {before='+array(old_paths)+',after='+array(list(groups))+'}',encoding='utf-8')
    bytecode=[]
    for kind in ('lua-5.3.6','lua-5.3.6-32'):
        result=subprocess.run([str(root/'.tools'/kind/'src/lua'), 'tests/consolidation.lua',str(spec)],cwd=root,capture_output=True,text=True)
        if result.returncode:raise RuntimeError(result.stdout+result.stderr)
        print(result.stdout.strip());bytecode.append({'runtime':kind,'result':result.stdout.strip()})
    script=(mapdir/'war3map.lua').read_text();previous_triggers=set(cfg['triggers'])
    matches=p.blocks(script);output=[];cursor=0;inserted=False
    for match in matches:
        output.append(script[cursor:match.start()]);cursor=match.end()
        if match[1] in previous_triggers:
            if not inserted:output.append('\n'.join(p.block(path) for path in groups));inserted=True
        else:output.append(match[0])
    output.append(script[cursor:]);new_script=''.join(output)
    outside=lambda value:re.sub(r'\s+','',re.sub(r'(?ms)^-- BEGIN FOREST MODULE ([^\r\n]+)\r?\n.*?^-- END FOREST MODULE \1\r?\n?','',value))
    assert outside(script)==outside(new_script),'Editor-owned script changed'
    cfg['triggers']=list(groups);ds.write(root/'project.json',cfg)
    (mapdir/'war3map.lua').write_text(new_script,encoding='utf-8',newline='\n')
    p.editor_sources(cfg,mapdir)
    found=p.editor_modules(mapdir,cfg)
    assert found=={path:(root/path).read_text().rstrip()+'\n' for path in cfg['header']+cfg['triggers']+cfg['disabled']+[cfg['bootstrap']]}
    # A verified structural migration, not a bypass of editor/source conflicts.
    p.save_code_baseline(found)
    for path in previous_triggers:
        candidate=(root/path).resolve();assert candidate.is_relative_to(root/'src')
        candidate.unlink()
    for folder in sorted((root/'src').rglob('*'),key=lambda item:len(item.parts),reverse=True):
        if folder.is_dir() and not any(folder.iterdir()):folder.rmdir()
    relocation={entry['from']:entry['to'] for entry in records}
    coverage=ds.read(root/'reports/function-coverage.json')
    for entry in coverage:entry['module']=relocation.get(entry['module'],entry['module'])
    ds.write(root/'reports/function-coverage.json',coverage)
    report={'backup':backup.relative_to(root).as_posix(),'source_before':375,'source_after':len(groups),
            'sections':records,'modules':[{'module':path,'sha256':ds.digest((root/path).read_bytes())} for path in groups],
            'unchanged_initialization_sha256':ds.digest((root/'src/initialization.lua').read_bytes()),
            'unchanged_bootstrap_sha256':ds.digest((root/'src/bootstrap.lua').read_bytes()),
            'bytecode_comparison':bytecode,'editor_source_verified':True,'behavior_changes':[]}
    ds.write(report_path,report)
    print(f'Consolidated 375 source files into {len(groups)} modules. Backup: {backup}')

if __name__=='__main__':main()
