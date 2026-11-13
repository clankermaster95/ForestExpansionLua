"""Review guards for the currently audited synchronization boundary.

The allowlist records manual review; it is not a general Lua desync prover.
Function hashes in shopping-audit.json pin this reviewed source revision.
"""
from pathlib import Path
import re
from lua_source import code_only, functions
ROOT=Path(__file__).resolve().parents[1]
LOCAL_REVIEW={
    'Hardmode_PlayActivationIndicator':'Local player is only the text recipient; sound runs for all clients.',
    'Ancient_ClearMessagesForPlayer':'Local text clearing only.',
    'Trig_ClearMessagesOnEsc_Actions':'Local text clearing only.',
    'SpawnLackey_PanCameraToFountainForPlayer':'Local camera movement only.',
    'SpawnLackey_StartDelayedTimer':'Timer/dialog allocation and timer start are synchronized; only visibility is local.',
    'Trig_Lackey_Respawn_Actions':'Timer/dialog allocation and timer start are synchronized; only visibility is local.',
    'FeedRate_SaveForPlayer':'Local file output only, escaped JASS payload. No local gameplay mutation.',
    'FeedRate_TryLoadForPlayer':'Local Preloader sends sync payloads; only synchronized receivers apply feed settings.',
}
UNORDERED_REVIEW={
    ('src/economy/base_flags.lua','FE_BaseFlags.refreshOwners'):
        'Read-only unit queries form a boolean owner set and prune stale references; '
        'no native mutation or random draw occurs in this traversal. Owner flags '
        'are then written in FE_Roles player order. Reversed traversal is tested.',
}
def review_native_lifetimes(source, path):
    from resource_audit import inspect as inspect_resources
    inspect_resources(source, path)
    code=code_only(source)
    assert not re.search(r'\b(?:StartTimerBJ|CreateTimerBJ|GetLastCreatedTimerBJ)\s*\(',code), \
        'GUI timer global may release a loading-time handle: '+path
    assert not re.search(r'\bTimerStart\s*\(\s*CreateTimer\s*\(',code), \
        'timer requires an explicit lifetime owner: '+path
    # This checks direct chunk-scope allocations, not arbitrary call graphs.
    root=list(code)
    for span in functions(source):
        if span['parent'] is not None:continue
        for index in range(span['start'],span['end']):
            if root[index]!='\n':root[index]=' '
    assert not re.search(r'\b(?:Create[A-Za-z]\w*|InitHashtable|Location|Rect|Condition|Filter)\s*\(',''.join(root)), \
        'native handle allocation during Lua chunk load: '+path

def review_functions(source, path):
    code=code_only(source)
    spans=functions(source)
    found={}; waits=[]
    for match in re.finditer(r'\bGetLocalPlayer\b',code):
        owners=[entry for entry in spans if entry['start'] <= match.start() < entry['end']]
        reviewed=next((entry for entry in owners if entry['name'] in LOCAL_REVIEW),None)
        assert reviewed is not None,'unreviewed local-player expression: '+path+':'+str(source.count('\n',0,match.start())+1)
        name=reviewed['name']
        found[name]={'module':path,'review':LOCAL_REVIEW[name]}
    for entry in spans:
        # Keep nested callback contents: an IIFE, a local function call or
        # ForGroup can execute synchronously after this wait. Declaring a
        # closure does not establish a separate event context/thread. This
        # conservative review gate intentionally retains the old guard's scope.
        body=code[entry['start']:entry['end']]
        wait=re.search(r'\bTriggerSleepAction\s*\(',body)
        if wait:
            cut=wait.start()
            unsafe=re.findall(r'\bGet(?:Spell\w+|Attacker|AttackedUnitBJ|SummonedUnit|ManipulatedItem|Sold\w+|BuyingUnit|SellingUnit|EventDamage\w*|Enum\w+)\s*\(',body[cut:])
            assert not unsafe,(path,entry['name'] or entry['line'],unsafe)
            waits.append(entry['name'] or '<callback:'+str(entry['line'])+'>')
    return found,waits

def inspect(cfg):
    found={}; waits=[]; indexing=[]; unordered=[]
    sources=cfg['header']+cfg['triggers']+[cfg['bootstrap']]
    for path in sources:
        source=(ROOT/path).read_text(encoding='utf-8')
        code=code_only(source)
        review_native_lifetimes(source,path)
        # Disallow new unsynchronized random/time/I/O paths in gameplay.
        assert not re.search(r'\b(?:math\.random(?:seed)?|os\.\w+|io\.\w+)\s*\(',code),path
        for match in re.finditer(r'(?<!i)\bpairs\s*\(',code):
            owners=[entry for entry in functions(source) if entry['start']<=match.start()<entry['end']]
            reviewed=next((entry for entry in owners if (path,entry['name']) in UNORDERED_REVIEW),None)
            assert reviewed is not None,'unordered traversal requires review: '+path
            unordered.append({'module':path,'function':reviewed['name'],
                              'review':UNORDERED_REVIEW[(path,reviewed['name'])]})
        if 'SetUnitUserData(' in code:indexing.append(path)
        reviewed,delayed=review_functions(source,path)
        found.update(reviewed);waits.extend(delayed)
    assert set(found)==set(LOCAL_REVIEW)
    assert indexing==['src/game/startup.lua'],indexing
    # The singleton force is used by Damage Engine's callback and must stay so.
    for path in sources:
        if path!='src/libraries/damage_engine.lua':
            assert 'bj_FORCE_PLAYER[0]' not in (ROOT/path).read_text(),path
    return {'active_modules_scanned':len(sources),'local_player_functions':found,
            'unordered_traversals':unordered,
            'wait_functions_checked':len(waits),'unit_index_single_writer':True,
            'native_lifetime_guards':'No direct chunk-scope allocations or GUI timer-global helpers; perpetual timer reachability tested separately.',
            'limit':'Static review guards, not proof of multiplayer synchronization. Native shop UI, preload and gameplay still require live testing.'}
