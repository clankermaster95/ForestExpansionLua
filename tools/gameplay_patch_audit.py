"""Explicit r8 -> gameplay patch evidence. Historical fixtures are immutable."""
from pathlib import Path
import json, re, shutil, subprocess, sys, zipfile
import data_store as ds
from lua_source import functions
from readability_audit import section_map

ROOT=Path(__file__).resolve().parents[1]
FIXTURES={
    'gameplay-r8.zip':'c8d6f02f30e7ea8c8afac3b255c9844caf494c4c319cf4bf47eb02b41964f06c',
    'gameplay-r8-validation.zip':'47c3ad044ee5b3c774431bdace6e427cba84776107437446988bfa9ac83d3bf6',
}
CHANGED_FUNCTIONS={
    'FE_Factions.stock','FE_Factions.ban','FE_Factions.closeBans',
    'Trig_Spawn_Races_Actions','InitTrig_Spawn_Races','FE_Test.skipPicking',
    'Trig_Spawn_Ancients_Actions','InitTrig_Spawn_Ancients',
    'Trig_Ancient_Gold_income_Actions','InitTrig_Ancient_Gold_income',
    'Trig_SeedOfRebirth_Actions','Trig_Thunderstruck_Actions',
    'Trig_Takeover_Actions','InitTrig_Takeover','Trig_Player_Leaves_Actions','Trig_Ancient_Leaves_Actions',
    'Trig_LimitedTraining_Func002A','Trig_Extermination_Conditions',
    'InitTrig_Ancient_In_Combat','InitTrig_Map_Start',
    'Trig_Poisoned_Bullets2_Actions','Trig_Poisoned_Bullets_Actions',
    'Trig_Sadism_Actions','InitTrig_Sadism','Trig_Reckoning_Actions','Trig_Vanguard_Actions',
    '__jdiv','integer','createObjects','FE_Test.run','FE_Test.init',
    'Ancient_CleanTrailingSeparators','Ancient_FormatTooltipText',
    'FeedRate_ParseRate','HandleSetExp','Trig_CheckFeedRates_Actions','Trig_InitialText_Actions',
    'Trig_Limb_Throw_Actions',
}
RATIONALE={
    'src/runtime.lua':'Equivalent nonzero remainder check avoids native editor percent-format corruption.',
    'src/commands/player.lua':'Equivalent Lua hex escapes preserve pattern and tooltip strings during editor saves.',
    'src/economy/feed.lua':'Equivalent Lua hex escapes preserve feed command patterns and displayed percentages.',
    'src/ui/hints.lua':'Equivalent Lua hex escape preserves displayed percentage text during editor saves.',
    'src/game/selection.lua':'Visible initial stock, prerequisite unlock after bans, stock removal, Cultist choice.',
    'src/game/startup.lua':'Native one-Amalgamation training limit.',
    'src/game/victory.lua':'Pending leaver armies keep the match open for takeover.',
    'src/commands/solo_test.lua':'Solo skip also unlocks the native picking prerequisite.',
    'src/commands/test_data.lua':'Generated current release and object catalog.',
    'src/economy/income.lua':'Red-authorized non-stacking passive-income multiplier.',
    'src/races/wildkin.lua':'Restore researched Wildkin ability levels after recreation.',
    'src/races/wisp.lua':'Apply Wildkin research to the reborn unit.',
    'src/players/participation.lua':'Eligibility, research/resources/ownership transfer and cancellation of leaver expiry.',
    'src/players/leaving.lua':'Uniform 60-second takeover window.',
    'src/players/roles.lua':'Ancient lobby slot 11 after synchronized editor regeneration.',
    'src/combat/common.lua':'Shared deterministic effect operations and non-orb on-hit debuffs.',
    'src/races/ratling.lua':'Move poison stacking from attack-start/global buff checks to landed hits.',
    'src/races/cultist.lua':'Research-gated aura, sacrifice toggle and pure-damage autocast; hide duplicate resistance icon and remove stray Limb Throw diagnostic.',
    'src/ancients/avalanche.lua':'Moving enemy-only Sadism slow/anti-heal and lifecycle cleanup.',
    'src/ancients/divinity.lua':'Sadism 400x25; undispellable Vanguard armor; Nuke permits native attacks.',
    'src/ancients/zalxon.lua':'Captured damage-event owner, bounded learned level and purpose-built dummy.',
}

def frozen():
    out={}
    for name,sha in FIXTURES.items():
        path=ROOT/'tests/fixtures'/name
        assert ds.digest(path.read_bytes())==sha,'Frozen patch baseline changed: '+name
        with zipfile.ZipFile(path) as archive:
            for entry in archive.namelist():
                value=archive.read(entry)
                assert entry not in out or out[entry]==value
                out[entry]=value
    return out

def prepare():
    target=ROOT/'build/gameplay-r8'
    for name,value in frozen().items():
        path=(target/name).resolve();assert path.is_relative_to(target.resolve())
        path.parent.mkdir(parents=True,exist_ok=True)
        if not path.exists() or path.read_bytes()!=value:path.write_bytes(value)
    old_fixture=ROOT/'tests/fixtures/refactor-r7.zip'
    (target/'tests/fixtures').mkdir(parents=True,exist_ok=True)
    shutil.copy2(old_fixture,target/'tests/fixtures/refactor-r7.zip')
    prices=ROOT/'tools/reference-api/item-prices.json'
    assert ds.digest(prices.read_bytes())=='042ae7cbdac97884b8c48a5572139a8c8960f1ee2e8b4d0261b976ad7989905d'
    (target/'tools/reference-api').mkdir(parents=True,exist_ok=True)
    shutil.copy2(prices,target/'tools/reference-api/item-prices.json')
    with zipfile.ZipFile(old_fixture) as archive:
        for name in archive.namelist():
            path=(target/'build/refactor-r7'/name).resolve()
            assert path.is_relative_to((target/'build/refactor-r7').resolve())
            path.parent.mkdir(parents=True,exist_ok=True);path.write_bytes(archive.read(name))
    return target

def inspect():
    old=frozen();cfg=ds.read(ROOT/'project.json')
    old_cfg=json.loads(old['project.json'])
    assert cfg['header']==old_cfg['header'] and cfg['triggers']==old_cfg['triggers']
    assert cfg['disabled']==old_cfg['disabled'] and cfg['bootstrap']==old_cfg['bootstrap']
    modules=[];changed_sections=[];function_changes=[]
    paths=cfg['header']+cfg['triggers']+cfg['disabled']+[cfg['bootstrap']]
    for path in paths:
        before=old[path];after=(ROOT/path).read_bytes()
        if before==after:continue
        assert path in RATIONALE,'Unreviewed changed module: '+path
        modules.append({'module':path,'before_sha256':ds.digest(before),'after_sha256':ds.digest(after),'reason':RATIONALE[path]})
        a=before.decode().replace('\r\n','\n');b=after.decode().replace('\r\n','\n')
        a_sections=section_map(a);b_sections=section_map(b)
        assert a_sections.keys()==b_sections.keys(),path
        for number,(name,body) in a_sections.items():
            other_name,other=b_sections[number];assert name==other_name
            if body!=other:changed_sections.append({'id':number,'before_sha256':ds.digest(body.encode()),'after_sha256':ds.digest(other.encode()),'module':path})
        bodies=lambda source:{f['name']:source[f['start']:f['end']] for f in functions(source) if f['name'] and f['parent'] is None}
        a_bodies,b_bodies=bodies(a),bodies(b)
        for name,body in a_bodies.items():
            assert name in b_bodies,'Removed existing callback: '+name
            if body!=b_bodies[name]:
                assert name in CHANGED_FUNCTIONS,'Unreviewed existing function change: '+path+'/'+name
                function_changes.append({'module':path,'function':name})
    payloads=[]
    index=json.loads(old['data/index.json'])
    for name,spec in index.items():
        before=spec['binary_sha256'];after=ds.digest((ROOT/cfg['map']/name).read_bytes())
        if before!=after:payloads.append({'file':name,'before_sha256':before,'after_sha256':after})
    name=cfg['map']+'/war3map.wts';after=ds.digest((ROOT/name).read_bytes());before=ds.digest(old[name])
    if before!=after:payloads.append({'file':'war3map.wts','before_sha256':before,'after_sha256':after})
    object_changes=[]
    for path in sorted((ROOT/'data/objects').rglob('*.json')):
        rel=path.relative_to(ROOT).as_posix();value=path.read_bytes()
        if old.get(rel)==value:continue
        obj=ds.read(path)
        before=json.loads(old[rel]) if rel in old else None
        if before and ds.canonical(before)==ds.canonical(obj):continue
        object_changes.append({'path':rel,'rawcode':obj['_rawcode'],'before_sha256':ds.digest(old[rel]) if before else None,'after_sha256':ds.digest(value)})
    return {'baseline_commit':'a775b1dde3bd65a5e50909b7996c9f222fec7750','fixtures':FIXTURES,
            'changed_modules':modules,'changed_sections':changed_sections,'changed_existing_functions':function_changes,
            'object_changes':object_changes,'payload_changes':payloads,
            'verification':'tests/gameplay_patch.lua and tests/gameplay_objects.py; immutable r8 suites remain independently executable.',
            'limits':'No live Warcraft/editor, native crash reproduction or multiplayer validation.'}

def validate(report):
    assert report==inspect(),'Gameplay patch evidence is stale; inspect changes before updating it.'
    return report

def historical_checks():
    target=prepare()
    subprocess.run([sys.executable,'-X','utf8','-c',
        "import sys,json;sys.path.insert(0,'tools');import readability_audit as a;a.prepare();a.validate(json.load(open('reports/readability-refactor.json')));print('Frozen r7 -> r8 readability evidence verified')"],cwd=target,check=True)
    input_file=ROOT/'build/role-test-input.lua'
    shutil.copy2(input_file,target/'build/role-test-input.lua')
    results=[]
    for kind in ('lua-5.3.6','lua-5.3.6-32'):
        runtime=ROOT/'.tools'/kind/'src/lua'
        for suite in ('selection_cleanup','game_cleanup','gameplay_cleanup','systems_cleanup','roles','shopping','bugfixes','solo_test','solo_startup'):
            result=subprocess.run([str(runtime),'tests/'+suite+'.lua'],cwd=target,check=True,capture_output=True,text=True)
            print('Frozen r8: '+result.stdout.strip())
            results.append({'runtime':kind,'suite':suite,'result':result.stdout.strip(),'source':'frozen r8'})
    return results

if __name__=='__main__':
    if '--write' in sys.argv:ds.write(ROOT/'reports/gameplay-patch.json',inspect())
    else:validate(ds.read(ROOT/'reports/gameplay-patch.json'))
