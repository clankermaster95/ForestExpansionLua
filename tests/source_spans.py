"""Regression cases that must not disappear when Lua becomes more idiomatic."""
from pathlib import Path
import sys
sys.path.insert(0,str(Path(__file__).resolve().parents[1]/'tools'))
from lua_source import functions, code_only
from sync_audit import review_functions, inspect
from faction_data import load, validate
from source_triage import inspect as triage
from copy import deepcopy
import project


def main():
    source = '''-- function fake() GetLocalPlayer() end
local text = [=[end function GetLocalPlayer()]=]
local function outer()
    for i=1,3 do
        local callback = function()
            repeat if true then break end until true
        end
    end
end
Table.method = function() return "function -- end" end
'''
    spans = functions(source)
    assert len(spans) == 3
    assert spans[0]['name'] == 'outer' and spans[0]['local']
    assert spans[1]['name'] is None and spans[1]['parent'] is spans[0]
    assert 'GetLocalPlayer' not in code_only(source)
    review_functions(source,'fixture')
    denied = [
        'local function f() return GetLocalPlayer() end',
        'local f = function() return GetLocalPlayer() end',
        'T = { run = function() GetLocalPlayer() end }',
        'local f = GetLocalPlayer',
        'local function f() TriggerSleepAction (1); GetSpellTargetUnit() end',
        'TimerStart(t, 0, false, function() TriggerSleepAction(1); GetManipulatedItem() end)',
        'function f() TriggerSleepAction(1); (function() GetSpellTargetUnit() end)() end',
        'function f() TriggerSleepAction(1); local g=function() GetSpellTargetUnit() end; g() end',
        'function f() TriggerSleepAction(1); ForGroup(group,function() GetSpellTargetUnit() end) end',
    ]
    for fixture in denied:
        try:
            review_functions(fixture,'negative fixture')
        except AssertionError:
            pass
        else:
            raise AssertionError('Audit missed: '+fixture)
    result=inspect(project.config())
    catalog = load()
    invalid = []
    wrong_expander = deepcopy(catalog)
    wrong_expander['randomExpanders'][0] = catalog['ancients'][0]['key']
    invalid.append(wrong_expander)
    wrong_ancient = deepcopy(catalog)
    wrong_ancient['randomAncients'][0] = catalog['expanders'][0]['key']
    invalid.append(wrong_ancient)
    missing_ancient = deepcopy(catalog)
    missing_ancient['spellbringerOrder'][0] = missing_ancient['spellbringerOrder'][1]
    invalid.append(missing_ancient)
    missing_ability = deepcopy(catalog)
    del missing_ability['ancients'][0]['spellbringerAbility']
    invalid.append(missing_ability)
    for fixture in invalid:
        try:
            validate(fixture)
        except AssertionError:
            pass
        else:
            raise AssertionError('Faction catalog accepted an invalid role or missing ability')
    triage_source = '''local text = [=[FakeCall() ExecuteFunc("missing")]=]
-- CommentCall()
local function shared()
    MissingShared()
    TriggerSleepAction(1)
    GetSpellTargetUnit()
end
local callback = function() TriggerSleepAction(1); GetManipulatedItem() end
ExecuteFunc -- ignored comment
    ("shared")
-- BEGIN FOREST SECTION 1 Correct
function correct() local event = EVENT_PLAYER_UNIT_ATTACKED; GetAttacker() end
-- END FOREST SECTION 1
-- BEGIN FOREST SECTION 2 Wrong
function wrong() local event = EVENT_PLAYER_UNIT_PICKUP_ITEM; GetAttacker() end
-- END FOREST SECTION 2
'''
    triaged = triage({'triggers':['fixture.lua'], 'disabled':[]},
                     {'fixture.lua':triage_source},
                     {'TriggerSleepAction','GetSpellTargetUnit','GetManipulatedItem','ExecuteFunc','GetAttacker'})
    assert set(triaged['unknown_direct_calls']) == {'MissingShared'}
    assert '#shared' in triaged['unknown_direct_calls']['MissingShared'][0]
    assert [(x['target'],x['defined']) for x in triaged['literal_ExecuteFunc_targets']] == [('shared',True)]
    assert {(x['function'],x['kind']) for x in triaged['wait_review']} == {('shared','local'),('<anonymous>','anonymous')}
    assert [x['scope'] for x in triaged['event_context_review_candidates']] == ['fixture.lua#Wrong']
    print('Source span checks passed; local/anonymous callback guards and '+str(result['active_modules_scanned'])+' active modules')


if __name__=='__main__':main()
