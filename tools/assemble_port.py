"""One-time migration assembly. Normal edits use project.py, not this command."""
from pathlib import Path
import json,re,shutil,hashlib

ROOT=Path(__file__).resolve().parents[1]
def save(path,value):
    path=ROOT/path; path.parent.mkdir(parents=True,exist_ok=True)
    path.write_text(value,encoding='utf-8')
def jsave(path,value): save(path,json.dumps(value,indent=2,ensure_ascii=False)+'\n')
def rename(code):
    names={'InitGlobals':'FE_InitGlobals','InitCustomTriggers':'FE_InitCustomTriggers','RunInitializationTriggers':'FE_RunInitializationTriggers'}
    return re.sub(r'"(?:[^"\\]|\\.)*"|--[^\n]*|[A-Za-z_][A-Za-z0-9_]*',lambda m:names.get(m[0],m[0]),code)
def slug(name): return re.sub(r'[^A-Za-z0-9_]+','_',name).strip('_')
def functions_with_positions(source):
    return list(re.finditer(r'(?m)^[ \t]*(?:constant[ \t]+)?function[ \t]+(\w+)[ \t]+takes',source))
def marker(path,code): return f'-- BEGIN FOREST MODULE {path}\n{code.rstrip()}\n-- END FOREST MODULE {path}\n'

def main():
    project=ROOT/'project.json'
    if project.exists(): raise SystemExit('Migration already assembled. Use tools/project.py build.')
    original=(ROOT/'original/map/war3map.j').read_text()
    converted=ROOT/'build/converted'
    entries=json.loads((converted/'functions.json').read_text())
    matches=functions_with_positions(original)
    assert {m[1] for m in matches}=={e['name'] for e in entries}
    markers=list(re.finditer(r'(?m)^// Trigger: (.+)$',original))
    first_trigger=markers[0].start(); last_trigger=original.index('function InitCustomTriggers takes')
    editor_start=original.index('function Doodad001056_DropItems takes')
    editor_names={'InitCustomPlayerSlots','InitCustomTeams','InitAllyPriorities','main','config'}
    groups={}; world=[]; coverage=[]
    for m in matches:
        name=m[1]; pos=m.start()
        if editor_start<=pos<first_trigger or name in editor_names:
            world.append(name); target='editor'
        elif name in ['InitGlobals','InitCustomTriggers','RunInitializationTriggers']:
            target='src/initialization.lua'
        elif first_trigger<=pos<last_trigger:
            ix=max(i for i,t in enumerate(markers) if t.start()<pos)
            target=f'src/triggers/{ix+1:03}_{slug(markers[ix][1])}.lua'
        else:
            group='prelude'
            if name.startswith(('s__Damage','DamageEngine','TriggerRegisterDamageEngine','RegisterDamageEngine','h__','sc__','sa__','jasshelper')): group='damage_engine'
            elif name.startswith('PassiveMissiles'): group='passive_missiles'
            elif name.startswith('SpellLeech'): group='spell_leech'
            target=f'src/libraries/{group}.lua'
        code=rename((converted/(name+'.lua')).read_text())
        groups.setdefault(target,[]).append(f'-- Original JASS function: {name} (line {original[:pos].count(chr(10))+1})\n'+code)
        coverage.append({'function':name,'original_line':original[:pos].count('\n')+1,'module':target})
    for ix,trigger in enumerate(markers):
        groups.setdefault(f'src/triggers/{ix+1:03}_{slug(trigger[1])}.lua',[
            '-- This trigger has no standalone compiled functions. Library implementations are in src/libraries/.\n'])
    for path,parts in groups.items():
        if path!='editor': save(path,'\n'.join(parts))
    save('src/globals.lua','-- Original global declarations, in their original order.\n'+(converted/'globals.lua').read_text())
    header=['src/runtime.lua','src/globals.lua',*sorted(p for p in groups if p.startswith('src/libraries/')),'src/initialization.lua']
    triggers=sorted(p for p in groups if p.startswith('src/triggers/'))
    assert len(triggers)==375
    main_code=(converted/'main.lua').read_text()
    tail=main_code.index('    ExecuteFunc(')
    startup=rename(main_code[tail:main_code.rfind('\nend')])
    save('src/bootstrap.lua','-- Runs after editor-generated sounds, regions, destructables, units and InitBlizzard.\nfunction InitTrig_FE_Bootstrap()\n'+startup+'\nend\n')

    disabled_source=(ROOT/'build/disabled.j').read_text()
    disabled_dir=ROOT/'build/disabled-converted'
    disabled_markers=list(re.finditer(r'(?m)^// Trigger: (.+)$',disabled_source))
    disabled_groups={}
    for m in functions_with_positions(disabled_source):
        marker_=next(t for t in reversed(disabled_markers) if t.start()<m.start())
        target='src/disabled/'+slug(marker_[1])+'.lua'
        disabled_groups.setdefault(target,[]).append((disabled_dir/(m[1]+'.lua')).read_text())
    for path,parts in disabled_groups.items(): save(path,'-- Disabled in the original map.\n'+'\n'.join(parts))
    save('src/disabled/000_globals.lua','-- Globals for disabled source; this module is also disabled.\n'+(disabled_dir/'globals.lua').read_text())
    disabled=sorted(['src/disabled/000_globals.lua',*disabled_groups])
    assert len(disabled_groups)==25

    mapdir=ROOT/'map/ForestExpansion.w3x'
    shutil.copytree(ROOT/'original/map',mapdir)
    (mapdir/'war3map.j').unlink() # Only the freshly created project copy.
    # Initial engine-generated functions are taken from the executable source verbatim
    # through the same typed emitter; later editor saves can regenerate this section.
    engine='\n'.join(rename((converted/(name+'.lua')).read_text()) for name in world if name!='main')
    initial_main=main_code[:tail]+'    InitTrig_FE_Bootstrap()\nend\n'
    shell='-- Forest Expansion Lua port: generated map script. Edit src/, or save in World Editor.\n'
    shell+='\n'.join(marker(p,(ROOT/p).read_text()) for p in header+triggers+['src/bootstrap.lua'])
    shell+='\n-- BEGIN WORLD EDITOR GENERATED FUNCTIONS\n'+engine+'\n'+initial_main
    save('map/ForestExpansion.w3x/war3map.lua',shell)
    jsave('project.json',{'name':'Forest Expansion 3.1.2a Lua','map':'map/ForestExpansion.w3x',
        'output':'dist/Forest_Expansion_3.1.2a_Lua.w3x','header':header,'triggers':triggers,'disabled':disabled,
        'bootstrap':'src/bootstrap.lua','original_sha256':hashlib.sha256((ROOT/'original/Forest_Expansion_3.1.2a.w3x').read_bytes()).hexdigest()})
    jsave('reports/function-coverage.json',coverage)
    jsave('reports/disabled-original-issues.json',{
        'status':'Preserved as disabled; repair references before enabling.',
        'missing_integer_array':'udg_GARATHORflagCounters (type inferred from OperatorInt in Flag Destroyed)',
        'unresolved_symbols':json.loads((disabled_dir/'api.json').read_text())['unresolved']})
    print(f'Assembled {len(entries)} active-source functions, {len(disabled_groups)} disabled triggers, and {len(world)} editor functions.')

if __name__=='__main__': main()
