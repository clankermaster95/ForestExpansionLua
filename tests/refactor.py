"""Validate the current organized/role-aware map, without claiming JASS parity.

The strict original preservation suite remains unchanged for the layout-only
stage. This suite verifies the deliberate role changes and packaging boundary.
"""
from pathlib import Path
import collections, json, os, re, subprocess, sys
ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/'tools'))
import project as p
import data_store as ds
from source_index import sections
from mpq import Archive
from verify import editor_owned_script

def main():
    cfg=p.config(); mapdir=ROOT/cfg['map']; script=(mapdir/'war3map.lua').read_text()
    # Load the test by path: the build also has a tools/editor_safety.py guard.
    import runpy
    editor_safety_report=runpy.run_path(str(ROOT/'tests/editor_safety.py'))['validate']()
    editor_layout_report=runpy.run_path(str(ROOT/'tests/editor_layout.py'))['validate']()
    import readability_audit
    import gameplay_patch_audit
    readability=ds.read(ROOT/'reports/readability-refactor.json')
    readability_audit.prepare()
    patch=gameplay_patch_audit.validate(ds.read(ROOT/'reports/gameplay-patch.json'))
    patch_sections={entry['id']:entry for entry in patch['changed_sections']}
    revised_sections={entry['id']:entry for entry in readability['changed_sections']}
    retired={entry['function'] for entry in readability['retired_functions']}
    modules=cfg['header']+cfg['triggers']+cfg['disabled']+[cfg['bootstrap']]
    assert len(modules)==len(set(modules))
    assert {x.relative_to(ROOT).as_posix() for x in (ROOT/'src').rglob('*.lua')}==set(modules)
    embedded,conflicts=p.code_changes(mapdir,cfg)
    assert not conflicts and not p.pending_json_edits() and not ds.changes(ROOT,mapdir)
    assert embedded=={path:(ROOT/path).read_text().rstrip()+'\n' for path in modules}
    assert ds.read(ROOT/'data/code-baseline.json')=={path:ds.digest(code.rstrip().encode()) for path,code in embedded.items()}
    layout=ds.read(ROOT/'reports/reorganization.json'); edits=ds.read(ROOT/'reports/role-refactor.json')
    consolidation=ds.read(ROOT/'reports/consolidation.json')
    assert cfg['triggers']==[entry['module'] for entry in consolidation['modules']],'consolidated manifest changed'
    indexed=sections(cfg);by_id={entry['id']:entry for entry in indexed}
    assert set(by_id)==set(range(1,376)),'lost/duplicated original trigger section'
    release=ds.read(ROOT/'reports/release-3.2.0.json')
    expected={entry['to']:entry['sha256'] for entry in layout['modules']}
    for revision in [edits,ds.read(ROOT/'reports/shopping-audit.json'),release]:
        for entry in revision['changed_modules']+revision.get('new_modules',[]):
            path=entry['module']
            if path in expected:assert entry['before_sha256']==expected[path],path
            expected[path]=entry['after_sha256']
    assert [entry['from'] for entry in consolidation['sections']]==[entry['to'] for entry in layout['modules']]
    for entry in consolidation['sections']:
        assert expected.pop(entry['from'])==entry['before_sha256'],entry['from']
        current=by_id[entry['id']]
        assert current['module']==entry['to'] and current['name']==entry['name']
        changed=revised_sections.get(entry['id'])
        patched=patch_sections.get(entry['id'])
        expected_body=changed['after_sha256'] if changed else entry['body_sha256']
        if patched:
            assert patched['before_sha256']==expected_body,entry['from']
            expected_body=patched['after_sha256']
        if changed:
            assert changed['before_sha256']==entry['body_sha256'],entry['from']
        assert ds.digest(current['code'].encode())==expected_body,entry['from']
    expected.update({entry['module']:entry['sha256'] for entry in consolidation['modules']})
    for entry in consolidation.get('changed_modules',[]):
        assert expected[entry['module']]==entry['before_sha256'],entry['module']
        expected[entry['module']]=entry['after_sha256']
    delivery=ds.read(ROOT/'reports/shop-delivery-r4.json')
    stock_fix=ds.read(ROOT/'reports/shop-stock-r5.json')
    community=ds.read(ROOT/'reports/community-r6.json')
    reference=ds.read(ROOT/'reports/debug-reference-r7.json')
    for entry in delivery['changed_modules']+stock_fix['changed_modules']+community['changed_modules']+reference['changed_modules']:
        assert expected[entry['module']]==entry['before_sha256'],entry['module']
        expected[entry['module']]=entry['after_sha256']
    for entry in readability['changed_modules']:
        if entry['module'] in expected:
            assert expected[entry['module']]==entry['before_sha256'],entry['module']
        expected[entry['module']]=entry['after_sha256']
    # Runtime was outside the earlier gameplay-module hash chain. Its first
    # intentional change is checked against the immutable r8 fixture plus the
    # arithmetic equivalence suite, not a newly reset baseline.
    expected['src/runtime.lua']=ds.digest(gameplay_patch_audit.frozen()['src/runtime.lua'])
    for entry in patch['changed_modules']:
        assert expected[entry['module']]==entry['before_sha256'],entry['module']
        expected[entry['module']]=entry['after_sha256']
    for path,sha in expected.items():assert ds.digest((ROOT/path).read_bytes())==sha,path
    assert ds.digest((ROOT/'src/initialization.lua').read_bytes())==consolidation['unchanged_initialization_sha256']
    assert ds.digest((ROOT/'src/bootstrap.lua').read_bytes())==consolidation['unchanged_bootstrap_sha256']
    import recipe_data
    assert (ROOT/'src/items/recipe_data.lua').read_text(encoding='utf-8')==recipe_data.render()
    import test_data
    assert (ROOT/'src/commands/test_data.lua').read_text(encoding='utf-8')==test_data.render()
    import faction_data
    catalog=(ROOT/'src/game/selection.lua').read_text(encoding='utf-8')
    assert faction_data.render() in catalog
    import debug_reference
    assert (ROOT/'DEBUG_REFERENCE.md').read_text(encoding='utf-8')==debug_reference.render()
    import sync_audit
    audit=sync_audit.inspect(cfg)
    allowed_slots={42,43,44,248}
    for section in indexed:
        code=section['code'];name=section['name']
        assert 'GetPlayerColor(' not in code,name
        assert 'udg_AncientPlayer' not in code,name
        assert 'Player(6)' not in code or section['id'] in allowed_slots,name
    declarations=re.findall(r'^function (\w+)\(',script,re.M)
    assert len(declarations)==len(set(declarations))
    names={'InitGlobals':'FE_InitGlobals','InitCustomTriggers':'FE_InitCustomTriggers','RunInitializationTriggers':'FE_RunInitializationTriggers'}
    for item in ds.read(ROOT/'reports/function-coverage.json'):
        name=names.get(item['function'],item['function'])
        if item['module']=='editor' and name=='CreateBuildingsForPlayer6' and 'initialAncientSlot = 10' in (ROOT/'src/players/roles.lua').read_text():
            name='CreateBuildingsForPlayer10'  # All five moved buildings are checked by lobby_slot.
        assert (name in declarations) != (name in retired),item
    original=ROOT/'original/Forest_Expansion_3.1.2a.w3x'
    assert ds.digest(original.read_bytes())==cfg['original_sha256']
    changed_payloads={'war3map.j','war3map.lua','war3map.wct','war3map.wtg','war3map.w3i','(attributes)','(listfile)'}
    payloads={entry['file']:dict(entry) for entry in release['payload_changes']}
    # Earlier suites verified the Lua flag directly, outside payload reports.
    # Join that exact one-byte migration before the native v39/slot-11 save.
    original_info=(ROOT/'original/map/war3map.w3i').read_bytes()
    lua_info=bytearray(original_info);assert lua_info[249]==0;lua_info[249]=1
    r8_index=json.loads(gameplay_patch_audit.frozen()['data/index.json'])
    assert ds.digest(lua_info)==r8_index['war3map.w3i']['binary_sha256']
    if 'war3map.w3i' not in payloads:
        payloads['war3map.w3i']={'file':'war3map.w3i','before_sha256':ds.digest(original_info),'after_sha256':ds.digest(lua_info)}
    for entry in consolidation.get('payload_changes',[])+delivery['payload_changes']+stock_fix['payload_changes']+community['payload_changes']+reference['payload_changes']+readability['payload_changes']+patch['payload_changes']:
        if entry['file'] in payloads:
            assert payloads[entry['file']]['after_sha256']==entry['before_sha256']
            payloads[entry['file']]['after_sha256']=entry['after_sha256']
        else:
            assert ds.digest((ROOT/'original/map'/entry['file']).read_bytes())==entry['before_sha256'],entry['file']
            payloads[entry['file']]=dict(entry)
    for entry in payloads.values():
        name=entry['file']
        assert ds.digest((ROOT/'original/map'/name).read_bytes())==entry['before_sha256'],name
        assert ds.digest((mapdir/name).read_bytes())==entry['after_sha256'],name
        changed_payloads.add(name)
    preserved=0
    with Archive(ROOT/cfg['output']) as archive:
        archived={n.replace('\\','/') for n in archive.names() if not n.startswith('(')}
        folder={f.relative_to(mapdir).as_posix() for f in mapdir.rglob('*') if f.is_file() and not f.name.startswith(('(','.'))}
        assert archived==folder
        for name in archive.names():
            if name.startswith('('):continue
            data=archive.read(name); assert data==(mapdir/name.replace('\\','/')).read_bytes()
        for entry in (ROOT/'original/map').rglob('*'):
            name=entry.relative_to(ROOT/'original/map').as_posix()
            if entry.is_file() and name not in changed_payloads:
                assert entry.read_bytes()==(mapdir/name).read_bytes(),name; preserved+=1
    before=(ROOT/'original/map/war3map.w3i').read_bytes(); after=(mapdir/'war3map.w3i').read_bytes()
    slot_report=None
    if 'initialAncientSlot = 10' in (ROOT/'src/players/roles.lua').read_text():
        from lobby_slot import validate as validate_ancient_slot
        slot_report=validate_ancient_slot()
    else:
        assert len(before)==len(after) and [i for i,(a,b) in enumerate(zip(before,after)) if a!=b]==[249]
        assert before[249]==0 and after[249]==1
    p.tool('export',mapdir,ROOT/'build/refactor-readback')
    wtg=ds.read(ROOT/'build/refactor-readback/war3map.wtg.json')
    wct=ds.read(ROOT/'build/refactor-readback/war3map.wct.json')
    items=[x for x in wtg['TriggerItems'] if 'IsEnabled' in x]
    categories={x['Id']:x for x in wtg['TriggerItems'] if 'IsEnabled' not in x}
    assert len({x['Id'] for x in wtg['TriggerItems']})==len(wtg['TriggerItems'])
    assert len(items)==len(wct['CustomTextTriggers'])==len(cfg['triggers'])+len(cfg['disabled'])+2
    assert sum(x['IsEnabled'] for x in items)==len(cfg['triggers'])+1
    for item in items:
        if item['IsEnabled'] and item['Name']!='FE_Bootstrap':
            category=categories[item['ParentId']]
            assert category['Name']==Path(item['Description']).parent.name.replace('_',' ').title()
    anchor=next(x for x in items if x['Name']=='FE_EditorObjectReferences')
    assert not anchor['IsEnabled'] and not anchor['IsCustomTextTrigger'] and len(anchor['Functions'])==5
    initializers=['    InitTrig_'+x['Name']+'()' for x in items if x['IsEnabled']]
    payload=wct['GlobalCustomScriptCode']['Code'].rstrip('\0')+'\n'
    payload+='\n'.join(code['Code'].rstrip('\0') for item,code in zip(items,wct['CustomTextTriggers']) if item['IsEnabled'])
    payload+='\n'+editor_owned_script(script,initializers)
    simulated=ROOT/'build/role-editor-resave.lua'; simulated.write_text(payload,encoding='utf-8',newline='\n')
    assert len(p.blocks(p.update_script(payload,cfg)))==len(cfg['header'])+len(cfg['triggers'])+1
    event_initializers=[];death_actions=[];shopping_initializers=[];solo_initializers=[]
    # Subscription entry points are part of the frozen behavior contract. Shared
    # registration helpers no longer repeat the native call in every section.
    frozen=readability_audit.baseline()
    frozen_sections={}
    for path in cfg['triggers']:
        frozen_sections.update(readability_audit.section_map(frozen[path].decode().replace('\r\n','\n')))
    for section in indexed:
        code=frozen_sections[section['id']][1];number=section['id']
        initializers_in_section=re.findall(r'^function (InitTrig_\w+)\(',code,re.M)
        if re.search(r'FE_Roles\.registerAncient\w+Event\(',code):
            event_initializers+=initializers_in_section
        if 351<=number<=361:
            death_actions+=re.findall(r'^function (Trig_\w+_Actions)\(',code,re.M)
        if 229<=number<=244:shopping_initializers+=initializers_in_section
        if number in (253,254,265,269,270,322) or (351<=number<=365 and number!=362):
            solo_initializers+=initializers_in_section
    assert len(death_actions)==11
    assert len(event_initializers)==34 and len(shopping_initializers)==16 and len(solo_initializers)==20
    assert all(name in declarations for name in event_initializers+shopping_initializers+solo_initializers+death_actions)
    def lua_array(values):return '{'+','.join(json.dumps(x) for x in values)+'}'
    (ROOT/'build/role-test-input.lua').write_text('return {modules='+lua_array(cfg['triggers'])+
        ',initializers='+lua_array(event_initializers)+',deathActions='+lua_array(death_actions)+
        ',shoppingInitializers='+lua_array(shopping_initializers)+',soloInitializers='+lua_array(solo_initializers)+'}',encoding='utf-8')
    historical=gameplay_patch_audit.historical_checks()
    from source_spans import main as validate_source_spans
    from cleanup_syntax import main as validate_cleanup_syntax
    validate_source_spans()
    mechanical=validate_cleanup_syntax()
    results=[]; files=[ROOT/x for x in modules]+[mapdir/'war3map.lua',simulated]
    for kind in ('lua-5.3.6','lua-5.3.6-32'):
        runtime=ROOT/'.tools'/kind/'src'
        for path in files:subprocess.run([str(runtime/'luac'),'-p',str(path)],check=True,capture_output=True)
        for suite in ('shopping','solo_startup','gameplay_patch'):
            result=subprocess.run([str(runtime/'lua'),'tests/'+suite+'.lua'],cwd=ROOT,check=True,capture_output=True,text=True)
            print(result.stdout.strip()); results.append({'runtime':kind,'suite':suite,'result':result.stdout.strip()})
    from costs import validate as validate_costs
    costs=validate_costs()
    from gameplay_objects import validate as validate_gameplay_objects
    gameplay_objects=validate_gameplay_objects()
    report={'result':'passed','version':cfg['version'],'revision':cfg['revision'],'archive_sha256':ds.digest((ROOT/cfg['output']).read_bytes()),
        'unchanged_original_payload_files':preserved,'intentional_noncode_payload_changes':list(payloads.values()),'source_modules':len(modules),
        'lua_chunks_per_numeric_configuration':len(files),'event_initializers_tested':len(event_initializers),
        'regressions':results,'historical_r8_regressions':historical,'gameplay_objects':gameplay_objects,
        'gameplay_patch':patch,'ancient_slot':slot_report,'editor_save_safety':editor_safety_report,'editor_layout':editor_layout_report,'costs':costs,'synchronization_review':audit,'editor_categories':len(categories),'archive_roundtrip':True,
        'source_editor_synchronized':True,'initialization_order_preserved':True,
        'legacy_sections_preserved':len(indexed),'consolidated_gameplay_modules':len(cfg['triggers']),
        'readability_refactor':{'baseline_sha256':readability['baseline_sha256'],
                              'retired_generated_helpers':len(retired),'mechanical_validation':mechanical,
                              'resource_cleanup_changes':readability['intentional_behavior_deltas']},
        'live_engine_test':False,'multiplayer_test':False,
        'scope':'Role, shopping and bug regression doubles; reviewed local-player functions; module hashes, native binary codecs, MPQ readback and WCT regeneration syntax. No claim of full engine behavior or unchanged JASS gameplay after intentional fixes.'}
    ds.write(ROOT/'reports/refactor-validation.json',report)
    print('Current-map checks passed; original payloads preserved:',preserved)

if __name__=='__main__':main()
