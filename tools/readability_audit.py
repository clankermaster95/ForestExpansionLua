"""Explicit migration from frozen r7 to the behavior-tested readable source.

Historical reports remain immutable. Mechanical body changes are recognized by
the narrow, tested normalizer; structural changes require named behavior suites.
"""
from pathlib import Path
import collections,hashlib,json,re,zipfile
from lua_source import functions,tokens
from lua_cleanup import normalize,edits
from source_index import SECTION

ROOT=Path(__file__).resolve().parents[1]
BASELINE_SHA='bee55193eba320476eed9664961c218e1131453984b19a145c42e0d6a438e1dd'
SUITES={
    **{p:'gameplay_cleanup' for p in (
        'src/races/forgotten/bloodmage.lua','src/races/forgotten/executioner.lua',
        'src/economy/base_flags.lua','src/players/deaths.lua','src/ancients/pharaoh.lua',
        'src/ancients/divinity.lua','src/effects/timed.lua','src/ai/behavior.lua')},
    **{p:'systems_cleanup' for p in (
        'src/commands/player.lua','src/commands/solo_test.lua','src/items/effects.lua',
        'src/items/recipes.lua','src/items/shops.lua','src/ui/hints.lua')},
    'src/game/selection.lua':'selection_cleanup + game_cleanup',
    'src/game/bans/expanders.lua':'selection_cleanup',
    'src/game/bans/ancients.lua':'selection_cleanup',
    'src/game/victory.lua':'game_cleanup',
    'src/game/fountain.lua':'game_cleanup',
}


def digest(value):return hashlib.sha256(value).hexdigest()


def baseline():
    path=ROOT/'tests/fixtures/refactor-r7.zip'
    assert digest(path.read_bytes())==BASELINE_SHA,'Frozen behavior baseline changed'
    with zipfile.ZipFile(path) as archive:
        return {name:archive.read(name) for name in archive.namelist()}


def prepare():
    target=ROOT/'build/refactor-r7'
    for name,value in baseline().items():
        path=(target/name).resolve()
        assert path.is_relative_to(target.resolve())
        path.parent.mkdir(parents=True,exist_ok=True)
        if not path.exists() or path.read_bytes()!=value:path.write_bytes(value)
    return target


def bodies(source):
    return {entry['name']:source[entry['start']:entry['end']]
            for entry in functions(source) if entry['parent'] is None and entry['name'] and not entry['local']}


def section_map(source):
    return {int(match[1]):(match[2],match[3].rstrip()+'\n') for match in SECTION.finditer(source)}


def normalized(source):
    for _ in range(5):
        updated=normalize(source)
        if updated==source:return updated.strip()
        source=updated
    raise AssertionError('Normalizer did not converge')


def inspect():
    old=baseline();cfg=json.loads(old['project.json'])
    paths=cfg['header']+cfg['triggers']+[cfg['bootstrap']]
    current={path:(ROOT/path).read_text(encoding='utf-8') for path in paths}
    refs=collections.Counter()
    for source in current.values():
        for token in tokens(source):
            if token.kind in ('word','string'):refs.update(re.findall(r'\b[A-Za-z_]\w*\b',token.text))
    modules=[];sections=[];retired=[];changed=[];added=[];classifications=[]
    for path in paths:
        before=old[path].decode('utf-8').replace('\r\n','\n');after=current[path]
        if digest(old[path])!=digest((ROOT/path).read_bytes()):
            modules.append({'module':path,'before_sha256':digest(old[path]),'after_sha256':digest((ROOT/path).read_bytes())})
        old_sections=section_map(before);new_sections=section_map(after)
        assert old_sections.keys()==new_sections.keys(),path
        for ident,(name,body) in old_sections.items():
            new_name,new_body=new_sections[ident];assert name==new_name
            if body!=new_body:sections.append({'id':ident,'module':path,'before_sha256':digest(body.encode()),'after_sha256':digest(new_body.encode())})
        old_bodies=bodies(before);new_bodies=bodies(after)
        old_named={(entry['name'], entry['local']) for entry in functions(before)
                   if entry['parent'] is None and entry['name']}
        for entry in functions(after):
            if entry['parent'] is None and entry['name'] and (entry['name'],entry['local']) not in old_named:
                added.append({'module':path,'function':entry['name'],'local':entry['local']})
        for name,body in old_bodies.items():
            if name not in new_bodies:
                assert name.startswith('Trig_') and '_Func' in name,'Non-helper public callback removed: '+name
                assert refs[name]==0,'Retired callback still referenced: '+name
                retired.append({'module':path,'function':name,'before_sha256':digest(body.encode()),
                                'reason':'generated helper replaced or unreferenced; no active identifier/string references remain'})
            elif body!=new_bodies[name]:
                mechanical=normalized(body)==normalized(new_bodies[name])
                assert mechanical or path in SUITES,'Unclassified semantic change: '+path+'/'+name
                changed.append({'module':path,'function':name,'kind':'mechanical' if mechanical else 'behavioral',
                                'validation':'cleanup_syntax' if mechanical else SUITES[path]})
        # Check the entire module, including top-level initialization, local
        # helpers, anonymous callbacks and added globals. Comparing only old
        # named functions would miss new side effects outside those bodies.
        removed=[(entry['start'],entry['end'],'') for entry in functions(before)
                 if entry['parent'] is None and entry['name'] in old_bodies and entry['name'] not in new_bodies]
        mechanical_module=normalized(edits(before,removed))==normalized(after)
        validation='cleanup_syntax'
        if not mechanical_module:
            if path in SUITES:validation=SUITES[path]
            elif path=='src/commands/test_data.lua':
                import test_data
                assert after==test_data.render(),'Generated test data drift'
                validation='test_data.render + solo_startup'
            else:raise AssertionError('Unclassified module initialization/local/callback changes: '+path)
        classifications.append({'module':path,'kind':'mechanical' if mechanical_module else 'behavioral/generated','validation':validation})
    assert (ROOT/'src/initialization.lua').read_bytes()==old['src/initialization.lua']
    assert (ROOT/'src/bootstrap.lua').read_bytes()==old['src/bootstrap.lua']
    return {'baseline_sha256':BASELINE_SHA,'behavior_target':'3.2.0 r7',
            'changed_modules':modules,'changed_sections':sections,'retired_functions':retired,
            'changed_functions':changed,
            'added_functions':added,'module_classifications':classifications,
            'intentional_behavior_deltas':[
                'Drain frees tempLoc2 instead of removing tempLoc1 twice.',
                'Fountain releases its owned enumeration group after callbacks.',
                'Gold ping actions release each newly allocated location and force.'
            ],'initialization_and_bootstrap_byte_identical':True,
            'limits':'Offline differential doubles and static/compiled checks; no live Warcraft, multiplayer or save/load proof.'}


def validate(report):
    actual=inspect()
    for key,value in actual.items():assert report[key]==value,'Readability migration drift: '+key
    return actual
