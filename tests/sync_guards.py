"""Regression coverage for the native lifetime review gate, not a desync proof."""
from pathlib import Path
import sys
ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/'tools'))
import sync_audit

def validate():
    safe=[
        'local state = {}; function init() state.timer=CreateTimer() end',
        'local init = function() return CreateGroup() end',
        '-- CreateTimer()\nlocal text="StartTimerBJ()"',
        'function init() TimerStart(owned, 1, true, tick) end',
    ]
    unsafe=[
        'timer = CreateTimer()',
        'local group = CreateGroup()',
        'hash = InitHashtable()',
        'local p = Location(0,0)',
        'if true then timer=CreateTimer() end',
        'function init() StartTimerBJ(timer,true,1) end',
        'function init() CreateTimerBJ(false,1) end',
        'function init() return GetLastCreatedTimerBJ() end',
        'function init() TimerStart(CreateTimer(),1,true,tick) end',
    ]
    for source in safe:sync_audit.review_native_lifetimes(source,'safe fixture')
    for source in unsafe:
        try:sync_audit.review_native_lifetimes(source,'unsafe fixture')
        except AssertionError:pass
        else:raise AssertionError('Missed unsafe allocation/helper: '+source)
    return {'result':'passed','cases':len(safe)+len(unsafe)}

if __name__=='__main__':print(validate())
