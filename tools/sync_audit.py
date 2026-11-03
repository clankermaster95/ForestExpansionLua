"""Review guards for the currently audited synchronization boundary.

The allowlist records manual review; it is not a general Lua desync prover.
Function hashes in shopping-audit.json pin this reviewed source revision.
"""
from pathlib import Path
import re
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
def inspect(cfg):
    found={}; waits=[]; indexing=[]
    sources=cfg['header']+cfg['triggers']+[cfg['bootstrap']]
    for path in sources:
        code=(ROOT/path).read_text(encoding='utf-8')
        # Disallow new unsynchronized random/time/I/O paths in gameplay.
        assert not re.search(r'\b(?:math\.random(?:seed)?|os\.\w+|io\.\w+)\s*\(',code),path
        assert not re.search(r'(?<!i)\bpairs\s*\(',code),'unordered traversal requires review: '+path
        if 'SetUnitUserData(' in code:indexing.append(path)
        for m in re.finditer(r'(?ms)^function ([\w.]+)\([^\n]*\)\n(.*?)^end\s*$',code):
            name,body=m[1],m[2]
            body=re.sub(r'--[^\n]*','',body)
            if 'GetLocalPlayer(' in body:
                assert name in LOCAL_REVIEW,'unreviewed local-player function: '+name
                found[name]={'module':path,'review':LOCAL_REVIEW[name]}
            cut=body.find('TriggerSleepAction(')
            if cut>=0:
                after=body[cut:]
                unsafe=re.findall(r'\bGet(?:Spell\w+|Attacker|AttackedUnitBJ|SummonedUnit|ManipulatedItem|Sold\w+|BuyingUnit|SellingUnit|EventDamage\w*|Enum\w+)\s*\(',after)
                assert not unsafe,(path,unsafe)
                waits.append(name)
    assert set(found)==set(LOCAL_REVIEW)
    assert indexing==['src/game/startup.lua'],indexing
    # The singleton force is used by Damage Engine's callback and must stay so.
    for path in sources:
        if path!='src/libraries/damage_engine.lua':
            assert 'bj_FORCE_PLAYER[0]' not in (ROOT/path).read_text(),path
    return {'active_modules_scanned':len(sources),'local_player_functions':found,
            'wait_functions_checked':len(waits),'unit_index_single_writer':True,
            'limit':'Static review guards, not proof of multiplayer synchronization. Native shop UI, preload and gameplay still require live testing.'}
