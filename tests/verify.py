"""Regression checks for the port and its editable project. No game-engine claims."""
from pathlib import Path
import argparse,collections,copy,hashlib,json,os,random,re,struct,subprocess,sys,tempfile
ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/'tools'))
import project as p
import data_store as ds
from mpq import Archive

def editor_owned_script(script,initializers):
    """Keep creation/config code after either our first build or an editor save."""
    # Module markers live in WCT and survive editor regeneration. The optional
    # outer comment from the initial assembly does not, so never depend on it.
    for match in reversed(p.blocks(script)):
        script=script[:match.start()]+script[match.end():]
    script=re.sub(r'(?m)^-- (?:BEGIN|END) WORLD EDITOR GENERATED FUNCTIONS\s*\n','',script)
    # These empty adapters also live in WCT, and are included in payload already.
    script=re.sub(r'(?m)^-- Editor initializer: gameplay initialization is centrally ordered\.\n','',script)
    script=re.sub(r'(?m)^function InitTrig_FE_\w+\(\)\s*end\s*\n','',script)
    if not re.search(r'(?m)^function InitCustomTriggers\(',script):
        # First assembly used the original main with a direct bootstrap call.
        # Simulate the native editor's generated initializer sequence instead.
        script,count=re.subn(r'(?m)^([ \t]*)InitTrig_FE_Bootstrap\(\)[ \t]*$',
            lambda m:m[1]+'InitGlobals()\n'+m[1]+'InitCustomTriggers()\n'+m[1]+'RunInitializationTriggers()',script)
        assert count==1,'Expected exactly one bootstrap call in the initial main'
        script=('function InitGlobals() end\nfunction InitCustomTriggers()\n'
                +'\n'.join(initializers)+'\nend\nfunction RunInitializationTriggers() end\n'+script)
    return script

def main():
    parser=argparse.ArgumentParser();parser.add_argument('--baseline',action='store_true');args=parser.parse_args()
    cfg=p.config(); mapdir=ROOT/cfg['map']; source=ROOT/'original/Forest_Expansion_3.1.2a.w3x'
    assert ds.digest(source.read_bytes())==cfg['original_sha256']
    assert ds.digest(Path('/Users/amazzetto/Downloads/Forest_Expansion_3.1.2a.w3x').read_bytes())==cfg['original_sha256'] if Path('/Users/amazzetto/Downloads/Forest_Expansion_3.1.2a.w3x').exists() else True
    original=ds.read(ROOT/'original/manifest.json');changed=[]
    with Archive(ROOT/cfg['output']) as archive:
        names=archive.names()
        assert 'war3map.lua' in names and 'war3map.j' not in names
        for name in names:
            if name.startswith('('):continue
            assert archive.read(name)==(mapdir/name.replace('\\','/')).read_bytes(),name
        for name,entry in original.items():
            if name=='war3map.j':continue
            if ds.digest(archive.read(name))!=entry['sha256']:changed.append(name)
        if args.baseline:
            assert sorted(changed)==['war3map.w3i','war3map.wct','war3map.wtg'],changed
            before=(ROOT/'original/map/war3map.w3i').read_bytes();after=archive.read('war3map.w3i')
            assert len(before)==len(after)
            offsets=[i for i,(a,b) in enumerate(zip(before,after)) if a!=b]
            assert offsets==[249] and before[249]==0 and after[249]==1
    print('Archive integrity passed;',len(original)-1-len(changed),'original payload files unchanged.')

    runtimes=[ROOT/'.tools/lua-5.3.6/src',ROOT/'.tools/lua-5.3.6-32/src']
    luac=runtimes[0]/'luac'
    files=list((ROOT/'src').rglob('*.lua'))+[mapdir/'war3map.lua']
    # Separate chunks prevent per-chunk local limits being mistaken for per-project limits.
    for runtime in runtimes:
        for path in files:subprocess.run([str(runtime/'luac'),'-p',str(path)],check=True,capture_output=True)
    assert len(ds.read(ROOT/'reports/function-coverage.json'))==1662
    script=(mapdir/'war3map.lua').read_text()
    declarations=re.findall(r'^function (\w+)\(',script,re.M)
    assert len(declarations)==len(set(declarations)),'Duplicate active Lua function'
    renamed={'InitGlobals':'FE_InitGlobals','InitCustomTriggers':'FE_InitCustomTriggers','RunInitializationTriggers':'FE_RunInitializationTriggers'}
    for f in ds.read(ROOT/'reports/function-coverage.json'):assert renamed.get(f['function'],f['function']) in declarations,f
    print('All 1,662 executable-source functions accounted for;',len(files),'Lua 5.3 chunks compile in both numeric configurations.')
    if args.baseline:subprocess.run([sys.executable,'tests/source_audit.py'],cwd=ROOT,check=True)

    p.tool('export',mapdir,ROOT/'build/verified-data')
    wtg=ds.read(ROOT/'build/verified-data/war3map.wtg.json');wct=ds.read(ROOT/'build/verified-data/war3map.wct.json')
    triggers=[t for t in wtg['TriggerItems'] if 'IsEnabled' in t]
    assert len(triggers)==len(wct['CustomTextTriggers'])==403
    anchors=[t for t in triggers if not t['IsCustomTextTrigger']]
    assert len(anchors)==1 and anchors[0]['Name']=='FE_EditorObjectReferences' and not anchors[0]['IsEnabled']
    references={f['Parameters'][0]['Value'] for f in anchors[0]['Functions']}
    assert references==set(re.findall(r'\bgg_unit_[A-Za-z0-9]{4}_\d+\b',(ROOT/'src/globals.lua').read_text()))
    placements=ds.read(ROOT/'data/editor/war3mapUnits.doo.json')['Units']
    available={f"gg_unit_{ds.rawcode(u['TypeId'])}_{u['CreationNumber']:04}" for u in placements}
    assert references<=available
    assert all(not t['Functions'] for t in triggers if t['IsCustomTextTrigger'])
    assert sum(not t['IsEnabled'] for t in triggers)==27
    assert not wtg['Variables']
    payload=wct['GlobalCustomScriptCode']['Code'].rstrip('\0')+'\n'
    initializers=[]
    for t,code in zip(triggers,wct['CustomTextTriggers']):
        if t['IsEnabled']:
            payload+=code['Code'].rstrip('\0')+'\n';initializers.append('    InitTrig_'+t['Name']+'()')
    # Reconstruct the editor's documented regeneration boundary: it owns main/config
    # and creation functions; custom code comes only from WCT, not war3map.lua.
    world=editor_owned_script(script,initializers)
    payload+=world
    # A second regeneration has generated init functions and no outer marker.
    assert editor_owned_script(payload,initializers).strip()==world.strip()
    simulated=ROOT/'build/editor-resave.lua';simulated.write_text(payload)
    subprocess.run([str(luac),'-p',str(simulated)],check=True)
    assert len(p.blocks(p.update_script(payload,cfg)))==len(cfg['header'])+len(cfg['triggers'])+1
    for runtime in runtimes:
        env=dict(os.environ,FOREST_LUA=str(runtime/'lua'))
        subprocess.run([str(runtime/'luac'),'-p',str(simulated)],check=True)
        subprocess.run([sys.executable,'tests/differential.py'],cwd=ROOT,env=env,check=True)
        subprocess.run([sys.executable,'tests/differential.py',str(simulated)],cwd=ROOT,env=env,check=True)
    print('Both packed script and WCT-only editor reconstruction match the original JASS model.')
    subprocess.run([sys.executable,'tests/events.py'],cwd=ROOT,check=True)

    api=ROOT/'tools/reference-api'
    p.tool('transpile',ROOT/'tests/compiler_semantics.j',api/'common.j',api/'Blizzard.j',ROOT/'build/semantics')
    compiled=''.join((ROOT/'build/semantics'/name).read_text() for name in ['globals.lua']+[f['name']+'.lua' for f in ds.read(ROOT/'build/semantics/functions.json')])
    harness=(ROOT/'src/runtime.lua').read_text()+'\n'+compiled+'''\n
assert(IntegerDivide(-7,3)==-2 and IntegerDivide(7,-3)==-2 and IntegerDivide(-7,-3)==2)
assert(__jdiv(-2147483647-1,-1)==(-2147483647-1))
assert(__jdiv(-2147483647-1,3)==-715827882)
assert(__jdiv(2147483647,-3)==-715827882)
assert(math.type(__jint(42))=="integer" and math.type(__jreal(42))=="float")
assert(IntegerArithmetic(2147483647,2)==2147483643)
assert(MinimumIntegerLiteral()==(-2147483647) and math.type(MinimumIntegerLiteral())=="integer")
assert(RealCancellation()==0.0 and PromoteInteger(16777217)==16777216.0)
assert(RealPrecedence(2.5,1.5)==4.0)
assert(StringEscapes()=="a\\\\b\\n\\\"quote\\\"\\tend")
assert(NullConcatenation(nil)=="[]")
assert(ShortCircuit()==true and counter==0)
assert(UnreachableReturn()==1 and counter==0)
assert(JassDefaults()==true and LuaKeyword(2)==3)
print("Compiler semantic edge cases passed")
'''
    # Independent integer/binary32 oracles exercise both VM configurations.
    rng=random.Random(20261101)
    integer=lambda x:'(-2147483647 - 1)' if x==-2147483648 else str(x)
    i32=lambda x:(x+2**31)%2**32-2**31
    f32=lambda x:struct.unpack('<f',struct.pack('<f',x))[0]
    for i in range(1000):
        a=rng.choice([-2147483648,-2147483647,-1,0,1,2147483647]) if i<100 else rng.randint(-2147483648,2147483647)
        b=rng.randint(-2147483648,2147483647) or 1
        quotient=(abs(a)//abs(b))*(-1 if (a<0)!=(b<0) else 1)
        arithmetic=i32(i32(a*b)+i32(a-b))
        harness+=f'assert(IntegerDivide({integer(a)},{integer(b)})=={integer(i32(quotient))},"integer division {i}")\n'
        harness+=f'assert(IntegerArithmetic({integer(a)},{integer(b)})=={integer(arithmetic)},"integer arithmetic {i}")\n'
        x,y=f32(rng.uniform(-100000,100000)),f32(rng.uniform(-100000,100000))
        expected=f32(f32(x+y)*f32(x-y))
        harness+=f'assert(RealPrecedence(__jreal({x!r}),__jreal({y!r}))==__jreal({expected!r}),"real arithmetic {i}")\n'
    harness+='print("3,000 seeded arithmetic assertions passed")\n'
    (ROOT/'build/semantic-tests.lua').write_text(harness)
    for runtime in runtimes:subprocess.run([str(runtime/'lua'),'build/semantic-tests.lua'],cwd=ROOT,check=True)

    index=ds.read(ROOT/'data/index.json')
    with tempfile.TemporaryDirectory(dir=ROOT/'build',prefix='edit-test-') as tmp:
        tmp=Path(tmp);binary=tmp/'map';binary.mkdir()
        units=ds.assemble(ROOT/'data',index['war3map.w3u'])
        unit=next(u for u in units['NewUnits'] if ds.rawcode(u['NewId'])=='h000')
        hp=next(m for m in unit['Modifications'] if ds.rawcode(m['Id'])=='uhpm');hp['Value']+=123
        ds.write(tmp/'units.json',units);p.tool('import',tmp/'units.json',binary/'war3map.w3u')
        terrain=ds.assemble(ROOT/'data',index['war3map.w3e']);terrain['TerrainTiles'][129*64+64]['Height']+=1/512
        ds.write(tmp/'terrain.json',terrain);p.tool('import',tmp/'terrain.json',binary/'war3map.w3e')
        p.tool('export',binary,tmp/'readback')
        assert ds.read(tmp/'readback/war3map.w3u.json')==units
        assert ds.read(tmp/'readback/war3map.w3e.json')==terrain
    print('Object and terrain edit -> binary -> JSON tests passed.')
    subprocess.run([sys.executable,'tests/workflow.py'],cwd=ROOT,check=True)
    report={'original_preserved':True,'baseline_comparison':args.baseline,'unchanged_original_payload_files':len(original)-1-len(changed),
        'changed_original_payload_files':changed,'original_functions_covered':1662,'disabled_functions_converted':89,'disabled_original_triggers':25,
        'lua53_chunks_compiled':len(files),'lua_numeric_configurations':['64-bit integers/doubles','32-bit integers/floats (LUA_32BITS)'],
        'editor_trigger_storage':'402 custom-text entries plus 1 disabled GUI placed-unit reference trigger; 376 enabled, 27 disabled',
        'placed_unit_references_preserved':sorted(references),
        'binary_json_codecs':'26 byte-exact round trips','object_and_terrain_edit_roundtrip':'passed','compiler_edge_cases':'passed',
        'startup_and_behavior':ds.read(ROOT/'reports/startup-differential.json'),
        'stateful_events':ds.read(ROOT/'reports/event-differential.json'),
        'workflow':ds.read(ROOT/'reports/workflow-validation.json'),
        'seeded_arithmetic_assertions_per_numeric_configuration':3000,
        'editor_save_reconstruction':'passed under deterministic engine double; not a live World Editor save',
        'live_world_editor_test':False,'live_warcraft_test':False,'multiplayer_desync_test':False}
    ds.write(ROOT/'reports/validation.json',report)
    print('All available offline checks passed. See reports/validation.json for the validation boundary.')
if __name__=='__main__':main()
