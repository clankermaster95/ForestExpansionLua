#!/usr/bin/env python3
"""Build, synchronize and inspect Forest Expansion without altering the original."""
from pathlib import Path
import argparse,collections,hashlib,json,os,re,shutil,subprocess,sys,tempfile,time
import data_store as ds
from mpq import Archive,pack,unpack

ROOT=Path(__file__).resolve().parents[1]
def config(): return ds.read(ROOT/'project.json')
def run(*args): subprocess.run([str(a) for a in args],cwd=ROOT,check=True)
def tool(*args):
    dotnet=ROOT/('.tools/dotnet/dotnet.exe' if os.name=='nt' else '.tools/dotnet/dotnet')
    if not dotnet.exists(): dotnet=Path(shutil.which('dotnet') or 'dotnet')
    dll=ROOT/'tools/MapTool/bin/Release/net10.0/MapTool.dll'
    if not dll.exists(): run(dotnet,'build',ROOT/'tools/MapTool/MapTool.csproj','-c','Release')
    run(dotnet,dll,*args)
def block(path): return f'-- BEGIN FOREST MODULE {path}\n'+(ROOT/path).read_text().rstrip()+f'\n-- END FOREST MODULE {path}\n'
def blocks(script):
    pattern=r'(?ms)^-- BEGIN FOREST MODULE ([^\r\n]+)\r?\n(.*?)^-- END FOREST MODULE \1\r?\n?'
    return list(re.finditer(pattern,script))
def update_script(script,cfg):
    expected=cfg['header']+cfg['triggers']+[cfg['bootstrap']]
    seen=[m[1] for m in blocks(script)]
    if collections.Counter(seen)!=collections.Counter(expected):
        raise RuntimeError('Map script module markers differ from project.json; refusing to overwrite unknown code.')
    return re.sub(r'(?ms)^-- BEGIN FOREST MODULE ([^\r\n]+)\r?\n(.*?)^-- END FOREST MODULE \1\r?\n?',lambda m:block(m[1]),script)

def backup_project(include_data=False):
    parent=ROOT/'backups';parent.mkdir(exist_ok=True)
    backup=Path(tempfile.mkdtemp(prefix=time.strftime('%Y%m%d-%H%M%S-'),dir=parent))
    shutil.copytree(ROOT/config()['map'],backup/'map')
    shutil.copytree(ROOT/'src',backup/'src')
    shutil.copy2(ROOT/'project.json',backup/'project.json')
    if include_data:shutil.copytree(ROOT/'data',backup/'data')
    return backup

def editor_modules(mapdir,cfg):
    work=ROOT/'build';work.mkdir(exist_ok=True)
    target=work/'editor-code.json';tool('editor-code',mapdir,target);metadata=ds.read(target)
    items=[t for t in metadata['Triggers']['TriggerItems'] if 'IsEnabled' in t]
    entries=metadata['Text']['CustomTextTriggers']
    if len(items)!=len(entries):raise RuntimeError('Editor trigger/code counts differ.')
    codes=[metadata['Text']['GlobalCustomScriptCode']['Code']]+[x['Code'] for x in entries]
    found={}
    for code in codes:
        for match in blocks((code or '').rstrip('\0')):
            if match[1] in found:raise RuntimeError('Duplicate editor module: '+match[1])
            found[match[1]]=match[2].rstrip()+'\n'
    expected=cfg['header']+cfg['triggers']+cfg['disabled']+[cfg['bootstrap']]
    if set(found)!=set(expected):raise RuntimeError('Editor modules differ from project.json; refusing to discard code.')
    remainder=codes[0].rstrip('\0')
    for m in reversed(blocks(remainder)):remainder=remainder[:m.start()]+remainder[m.end():]
    if re.sub(r'(?m)^\s*--[^\n]*','',remainder).strip():raise RuntimeError('Code outside module markers in the map header; move it inside a source module.')
    for item,entry in zip(items,entries):
        if item['Name']=='FE_EditorObjectReferences' and not item['IsEnabled'] and not item['IsCustomTextTrigger']:continue
        matches=blocks(entry['Code'].rstrip('\0'))
        if not item['IsCustomTextTrigger'] or len(matches)!=1:
            raise RuntimeError('Unmanaged editor trigger: '+item['Name']+'. Integrate it into src/project.json before building.')
        if item['IsEnabled']!=(matches[0][1] not in cfg['disabled']):raise RuntimeError('Editor changed enabled state of '+item['Name']+'. Update project.json deliberately before building.')
        remainder=entry['Code'].rstrip('\0')
        for m in reversed(matches):remainder=remainder[:m.start()]+remainder[m.end():]
        remainder=re.sub(r'(?m)^\s*--[^\n]*','',remainder)
        expected_adapter='' if matches[0][1]==cfg['bootstrap'] else 'function InitTrig_'+item['Name']+'() end'
        if re.sub(r'\s+','',remainder)!=re.sub(r'\s+','',expected_adapter):
            raise RuntimeError('Code outside module markers in '+item['Name']+'; move it inside the module before importing.')
    script=(mapdir/'war3map.lua').read_text();update_script(script,cfg)
    for match in blocks(script):
        if match[2].rstrip()!=found[match[1]].rstrip():raise RuntimeError('WCT and executable Lua differ for '+match[1]+'. Save in World Editor before importing.')
    return found

def code_changes(mapdir,cfg):
    found=editor_modules(mapdir,cfg);baseline_path=ROOT/'data/code-baseline.json'
    baseline=ds.read(baseline_path) if baseline_path.exists() else {p:ds.digest((ROOT/p).read_text().rstrip().encode()) for p in found}
    changed=[p for p,code in found.items() if ds.digest(code.rstrip().encode())!=baseline.get(p) and code.rstrip()!=(ROOT/p).read_text().rstrip()]
    return found,changed

def save_code_baseline(modules):
    ds.write(ROOT/'data/code-baseline.json',{p:ds.digest(code.rstrip().encode()) for p,code in modules.items()})

def pending_json_edits():
    index=ds.read(ROOT/'data/index.json')
    return [name for name,spec in index.items() if ds.content_hash(ds.assemble(ROOT/'data',spec))!=spec['content_sha256']]

def editor_sources(cfg,target):
    items=[{'Type':'RootCategory','Id':0,'Name':cfg['name'],'IsComment':False,'IsExpanded':True,'ParentId':-1}]
    for i,name in enumerate(['Lua gameplay','Disabled original triggers'],1):
        items.append({'Type':'Category','Id':(2<<24)+i,'Name':name,'IsComment':False,'IsExpanded':True,'ParentId':0})
    categories={}; next_category=4
    def category(path,enabled):
        nonlocal next_category
        if not enabled:return (2<<24)+2
        parts=Path(path).parent.relative_to('src').parts or ('startup',)
        parent=(2<<24)+1
        for depth,part in enumerate(parts,1):
            key=parts[:depth]
            if key not in categories:
                ident=(2<<24)+next_category; next_category+=1
                categories[key]=ident
                items.append({'Type':'Category','Id':ident,'Name':part.replace('_',' ').title(),
                    'IsComment':False,'IsExpanded':False,'ParentId':parent})
            parent=categories[key]
        return parent
    codes=[]; order=0
    for enabled,paths in [(True,cfg['triggers']),(False,cfg['disabled']),(True,[cfg['bootstrap']])]:
        for path in paths:
            parent=category(path,enabled)
            order+=1
            name='FE_Bootstrap' if path==cfg['bootstrap'] else 'FE_'+Path(path).stem
            code=block(path)
            if path!=cfg['bootstrap']: code+=f'\n-- Editor initializer: gameplay initialization is centrally ordered.\nfunction InitTrig_{name}()\nend\n'
            items.append({'Type':'Gui','Name':name,'Description':path,'IsComment':False,'Id':(3<<24)+order,
                'IsEnabled':enabled,'IsCustomTextTrigger':True,'IsInitiallyOn':True,'RunOnMapInit':False,
                'ParentId':parent,'Functions':[]})
            codes.append({'Code':code+'\0'})
    # Keep editor-visible references to placed objects. Custom Lua references alone
    # are not sufficient to retain generated globals in every editor version.
    text='\n'.join((ROOT/path).read_text() for path in cfg['header']+cfg['triggers'])
    references=sorted(set(re.findall(r'\bgg_unit_[A-Za-z0-9]{4}_\d+\b',text)))
    if references:
        items.append({'Type':'Category','Id':(2<<24)+3,'Name':'Editor object references','IsComment':False,'IsExpanded':False,'ParentId':0})
        functions=[{'Type':'Action','Name':'ResetUnitAnimation','IsEnabled':True,
            'Parameters':[{'Type':'Variable','Value':name}],'ChildFunctions':[]} for name in references]
        items.append({'Type':'Gui','Name':'FE_EditorObjectReferences','Description':'Keep disabled. Retains placed-unit references for editor regeneration; never executes.',
            'IsComment':False,'Id':(3<<24)+order+1,'IsEnabled':False,'IsCustomTextTrigger':False,
            'IsInitiallyOn':False,'RunOnMapInit':False,'ParentId':(2<<24)+3,'Functions':functions})
        codes.append({'Code':''})
    wtg={'FormatVersion':'v7','SubVersion':'v4','GameVersion':2,'Variables':[],'TriggerItems':items,'TriggerItemCounts':{}}
    wct={'FormatVersion':'v1','SubVersion':'v4','GlobalCustomScriptComment':'Lua source lives in src/. See README.md for the editor round trip.',
        'GlobalCustomScriptCode':{'Code':'\n'.join(block(p) for p in cfg['header'])+'\0'},'CustomTextTriggers':codes}
    work=ROOT/'build/editor-source'; work.mkdir(parents=True,exist_ok=True)
    ds.write(work/'war3map.wtg.json',wtg); ds.write(work/'war3map.wct.json',wct)
    tool('import',work/'war3map.wtg.json',target/'war3map.wtg'); tool('import',work/'war3map.wct.json',target/'war3map.wct')
    return wtg,wct

def export_data(accept_code=False):
    cfg=config(); mapdir=ROOT/cfg['map']; out=ROOT/'build/exported-data'
    edits=pending_json_edits()
    if edits:raise RuntimeError('Unbuilt JSON edits would be overwritten: '+', '.join(edits)+'. Build/apply-data or reconcile them first.')
    modules,changed=code_changes(mapdir,cfg)
    if changed and not accept_code:raise RuntimeError('World Editor changed Lua modules. Review and use export-data --accept-code: '+', '.join(changed))
    pending=ROOT/'build/editor-save-required.json'
    if pending.exists():
        state=ds.read(pending)
        if ds.digest((mapdir/'war3map.lua').read_bytes())==state['script_sha256']:
            raise RuntimeError('Creation data was changed with apply-data, but World Editor has not regenerated the script. Open and save the map in World Editor first.')
    if out.exists():shutil.rmtree(out)
    out.mkdir(parents=True,exist_ok=True)
    tool('export',mapdir,out)
    if changed:
        backup_project(include_data=True)
        for path in changed:(ROOT/path).write_text(modules[path])
    ds.export(ROOT,out,mapdir)
    save_code_baseline(modules)
    if pending.exists(): pending.unlink()
    print('Exported lossless JSON views into data/.')

def build():
    (ROOT/'build').mkdir(exist_ok=True)
    cfg=config(); source=ROOT/cfg['map']; edits=ds.changes(ROOT,source)
    if (ROOT/'build/editor-save-required.json').exists(): raise RuntimeError('An editor save and export-data are required after apply-data.')
    from map_strings import validate as validate_strings
    text_validation=validate_strings(source/'war3map.wts')
    from release_info import validate as validate_release
    validate_release(source,cfg)
    _,changed=code_changes(source,cfg)
    if changed:raise RuntimeError('World Editor changed Lua. Use export-data --accept-code after review; build will not overwrite: '+', '.join(changed))
    if 'src/items/recipe_data.lua' in cfg['header']:
        import recipe_data
        from item_costs import Catalog
        Catalog().validate()
        recipe_data.generate()
    if 'src/commands/test_data.lua' in cfg['header']:
        import test_data
        test_data.generate()
        import debug_reference
        debug_reference.generate()
    with tempfile.TemporaryDirectory(prefix='forest-build-',dir=ROOT/'build') as temp:
        staging=Path(temp)/'map'; shutil.copytree(source,staging)
        for filename,obj in edits:
            # Creation scripts are generated by World Editor from these files.
            if filename in ['war3mapUnits.doo','war3map.doo','war3map.w3r','war3map.w3s','war3map.w3c','war3map.w3i']:
                raise RuntimeError(f'{filename} needs editor script regeneration. Use apply-data, then open/save in World Editor, then export-data and build.')
            data=Path(temp)/(filename+'.json'); ds.write(data,obj); tool('import',data,staging/filename)
        script=update_script((staging/'war3map.lua').read_text(),cfg)
        (staging/'war3map.lua').write_text(script)
        editor_sources(cfg,staging)
        tool('lua-flag',staging/'war3map.w3i',staging/'war3map.w3i')
        luac=ROOT/('.tools/lua-5.3.6/src/luac.exe' if os.name=='nt' else '.tools/lua-5.3.6/src/luac')
        run(luac if luac.exists() else (shutil.which('luac') or 'luac'),'-p',staging/'war3map.lua')
        luac32=ROOT/('.tools/lua-5.3.6-32/src/luac.exe' if os.name=='nt' else '.tools/lua-5.3.6-32/src/luac')
        if luac32.exists():run(luac32,'-p',staging/'war3map.lua')
        destination=ROOT/cfg['output']; destination.parent.mkdir(parents=True,exist_ok=True)
        candidate=Path(temp)/'candidate.w3x'; pack(staging,candidate)
        # Read every file back through StormLib and compare to the folder.
        with Archive(candidate) as archive:
            names=archive.names()
            for name in names:
                if name.startswith('('): continue
                p=staging/name.replace('\\','/')
                if archive.read(name)!=p.read_bytes(): raise RuntimeError('MPQ round-trip mismatch: '+name)
        shutil.copy2(candidate,destination)
        for p in staging.rglob('*'):
            if p.is_file():
                q=source/p.relative_to(staging)
                if not q.exists() or q.read_bytes()!=p.read_bytes(): q.parent.mkdir(parents=True,exist_ok=True); shutil.copy2(p,q)
        index=ds.read(ROOT/'data/index.json')
        for filename,obj in edits:
            index[filename]['binary_sha256']=ds.digest((source/filename).read_bytes())
            index[filename]['content_sha256']=ds.content_hash(obj)
        # Script-language bit is the only intentional metadata change.
        if 'war3map.w3i' in index:
            info=ds.assemble(ROOT/'data',index['war3map.w3i']); info['ScriptLanguage']='Lua'
            ds.write(ROOT/'data'/index['war3map.w3i']['path'],info)
            index['war3map.w3i']['binary_sha256']=ds.digest((source/'war3map.w3i').read_bytes())
            index['war3map.w3i']['content_sha256']=ds.content_hash(info)
        ds.write(ROOT/'data/index.json',index)
        save_code_baseline({p:(ROOT/p).read_text() for p in cfg['header']+cfg['triggers']+cfg['disabled']+[cfg['bootstrap']]})
        report={'output':cfg['output'],'sha256':ds.digest(destination.read_bytes()),'archive_files':len(names),
            'version':cfg.get('version'),'revision':cfg.get('revision'),
            'string_table':text_validation,
            'lua_syntax':'passed','archive_roundtrip':'all payloads byte-identical to folder','data_edits':[f for f,_ in edits],
            'engine_test':'not run by this offline build'}
        ds.write(ROOT/'reports/build.json',report)
        from install_map import install
        try:
            report['maps_copy']=install(ROOT,destination)
        except (OSError,ValueError,RuntimeError) as error:
            report['maps_copy']={'status':'failed','error':str(error)}
            ds.write(ROOT/'reports/build.json',report)
            raise RuntimeError('Archive built successfully, but copying to Warcraft Maps failed: '+str(error)) from error
        ds.write(ROOT/'reports/build.json',report)
        print(json.dumps(report,indent=2))

def import_editor(path,accept_code=False):
    (ROOT/'build').mkdir(exist_ok=True)
    cfg=config(); destination=ROOT/cfg['map']; path=Path(path).expanduser().resolve()
    if pending_json_edits():raise RuntimeError('Import would overwrite pending JSON edits. Build/apply-data or reconcile them first.')
    with tempfile.TemporaryDirectory(prefix='forest-import-',dir=ROOT/'build') as tmp:
        stage=Path(tmp)/'map'
        if path.is_dir(): shutil.copytree(path,stage)
        else: unpack(path,stage)
        modules=editor_modules(stage,cfg)
        changes=[p for p,code in modules.items() if code.rstrip()!=(ROOT/p).read_text().rstrip()]
        if changes and not accept_code: raise RuntimeError('Editor changed Lua modules. Review them and import with --accept-code to adopt those edits.')
        # Parse and losslessly validate all editor binaries before replacing anything.
        tool('export',stage,Path(tmp)/'verified')
        backup=backup_project(include_data=True)
        for p in changes:(ROOT/p).write_text(modules[p])
        # Replace the work folder as a unit after its backup, so removed imports stay removed.
        shutil.rmtree(destination); shutil.copytree(stage,destination)
    export_data(); print('Imported editor save; backup: '+str(backup))

def object_set(kind,code,field,value):
    matches=[x for x in ds.read(ROOT/'data/object-index.json') if x['kind']==kind and x['rawcode']==code]
    if len(matches)!=1: raise RuntimeError('Expected one object; inspect data/object-index.json.')
    path=ROOT/matches[0]['path']; obj=ds.read(path)
    mods=[m for m in obj['Modifications'] if m['_field']==field]
    if len(mods)!=1: raise RuntimeError('Field absent or has multiple levels. Edit the object JSON with explicit Type/Level/Pointer.')
    mods[0]['Value']=json.loads(value); mods[0].pop('_resolvedText',None); ds.write(path,obj); print(path)

def apply_data():
    (ROOT/'build').mkdir(exist_ok=True)
    cfg=config(); mapdir=ROOT/cfg['map']; edits=ds.changes(ROOT,mapdir)
    backup_project(include_data=True)
    with tempfile.TemporaryDirectory(prefix='apply-data-',dir=ROOT/'build') as tmp:
        tmp=Path(tmp)
        for filename,obj in edits:
            p=tmp/(filename+'.json');ds.write(p,obj);tool('import',p,tmp/filename)
        for filename,obj in edits:shutil.copy2(tmp/filename,mapdir/filename)
    index=ds.read(ROOT/'data/index.json')
    for filename,obj in edits:
        index[filename]['binary_sha256']=ds.digest((mapdir/filename).read_bytes())
        index[filename]['content_sha256']=ds.content_hash(obj)
    ds.write(ROOT/'data/index.json',index)
    if edits:
        ds.write(ROOT/'build/editor-save-required.json',{'files':[name for name,_ in edits],'script_sha256':ds.digest((mapdir/'war3map.lua').read_bytes())})
    print('Applied binary data. Open and SAVE this folder in current World Editor to regenerate creation scripts, pathing and previews, then export-data and build.')

def main():
    p=argparse.ArgumentParser(description=__doc__); s=p.add_subparsers(dest='command',required=True)
    for c in ['build','apply-data']: s.add_parser(c)
    q=s.add_parser('export-data');q.add_argument('--accept-code',action='store_true')
    q=s.add_parser('import-editor'); q.add_argument('path'); q.add_argument('--accept-code',action='store_true')
    q=s.add_parser('object-set'); q.add_argument('kind'); q.add_argument('rawcode'); q.add_argument('field'); q.add_argument('json_value')
    q=s.add_parser('terrain-rect'); q.add_argument('x',type=int); q.add_argument('y',type=int); q.add_argument('width',type=int); q.add_argument('height',type=int); q.add_argument('--height-delta',type=float,default=0,help='normalized terrain height; 1.0 = 128 game units'); q.add_argument('--texture',type=int)
    a=p.parse_args()
    if a.command=='build': build()
    elif a.command=='export-data': export_data(a.accept_code)
    elif a.command=='apply-data': apply_data()
    elif a.command=='import-editor': import_editor(a.path,a.accept_code)
    elif a.command=='object-set': object_set(a.kind,a.rawcode,a.field,a.json_value)
    elif a.command=='terrain-rect':
        meta=ds.read(ROOT/'data/terrain/map.json')
        if a.x<0 or a.y<0 or a.width<=0 or a.height<=0 or a.x+a.width>meta['Width'] or a.y+a.height>meta['Height']: raise ValueError('Rectangle outside terrain')
        if a.texture is not None and not 0<=a.texture<len(meta['TerrainTypes']): raise ValueError('Texture index outside tileset')
        for y in range(a.y,a.y+a.height):
            path=ROOT/f'data/terrain/rows/{y:03}.json'; row=ds.read(path)
            for tile in row[a.x:a.x+a.width]:
                new_height=round((tile['Height']+a.height_delta)*512)/512
                if not -16<=new_height<=111.998046875: raise ValueError('Height outside the file format range')
                tile['Height']=new_height
                if a.texture is not None: tile['Texture']=a.texture
            ds.write(path,row)
        print('Edited terrain JSON. Build applies terrain; an editor save refreshes derived pathing, shadows and minimap.')

if __name__=='__main__': main()
