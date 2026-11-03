"""Apply the reviewed Ancient-role migration once, after the layout migration.

The initial slot remains 6. Slot-wide setup retains its eleven original players.
Event subscriptions become dynamic, and match outcomes include all eleven slots.
"""
import re, shutil
from pathlib import Path
import project as p
import data_store as ds

def main():
    root=p.ROOT; cfg=p.config(); mapdir=root/cfg['map']; role='src/players/roles.lua'
    if role in cfg['header']:raise RuntimeError('Role migration already applied.')
    if p.pending_json_edits():raise RuntimeError('Reconcile pending JSON edits first.')
    embedded,changed=p.code_changes(mapdir,cfg)
    if changed or any(code.rstrip()!=(root/path).read_text().rstrip() for path,code in embedded.items()):
        raise RuntimeError('Reconcile source/editor code before this migration.')
    backup=p.backup_project(include_data=True)
    shutil.copy2(root/cfg['output'],backup/'layout-only.w3x')
    # This archive is a useful independently testable, behavior-preserving stage.
    shutil.copy2(root/cfg['output'],root/'dist/Forest_Expansion_3.1.2a_Organized.w3x')
    records=[]
    for path in cfg['header']+cfg['triggers']:
        source=(root/path).read_text(); code=source; stem=Path(path).stem
        if path=='src/globals.lua':continue
        n=int(stem[:3]) if stem[:3].isdigit() else 0
        if path=='src/initialization.lua':
            code=code.replace('udg_AncientPlayer = Player(6)',
                'FE_Roles.setAncient(Player(FE_Roles.initialAncientSlot))')
        if n==13:
            code=code.replace('udg_AncientPlayer = taker','FE_Roles.setAncient(taker)')
        # Existing dynamic code now uses the same public accessor as migrated code.
        code=re.sub(r'\budg_AncientPlayer\b','FE_Roles.ancient()',code)
        for old,new in [('TriggerRegisterPlayerUnitEventSimple','registerAncientUnitEvent'),
                        ('TriggerRegisterPlayerChatEvent','registerAncientChatEvent'),
                        ('TriggerRegisterPlayerStateEvent','registerAncientStateEvent')]:
            code=re.sub(old+r'\((\w+), Player\(6\), ',r'FE_Roles.'+new+r'(\1, ',code)
        if n==246:
            code,count=re.subn(r'(?m)(?:^    AdjustPlayerStateBJ\([^\n]+\)\n)+',
                '    FE_Roles.forEachPlayer(function(player)\n'
                '        local gold = FE_Roles.isAncient(player) and 1040 or 1\n'
                '        AdjustPlayerStateBJ(gold, player, PLAYER_STATE_RESOURCE_GOLD)\n'
                '    end)\n',code)
            assert count==1
        # These four modules configure ALL slots, including slot 6. They do not
        # infer an Ancient role and must not accidentally apply twice to a taker.
        if n not in (42,43,44,248):code=code.replace('Player(6)','FE_Roles.ancient()')
        if n==362:
            code=code.replace('GetPlayerColor(GetEnumPlayer()) ~= GetPlayerColor(FE_Roles.ancient())',
                'GetEnumPlayer() ~= FE_Roles.ancient()')
        if n==194:
            code=code.replace('Player 7 (Green) can','The Ancient can')
        if n==260:
            code=code.replace('udg_PlayerColorHex[7]','udg_PlayerColorHex[GetPlayerId(FE_Roles.ancient()) + 1]')
        if 351<=n<=361 or n in (363,365):
            won=n in (363,365); message='TRIGSTR_7269' if won else 'TRIGSTR_4301'
            code,count=re.subn(r'(?m)(?:^    Custom(?:Victory|Defeat)BJ\([^\n]+\)\n)+',
                f'    FE_Roles.finishMatch({str(won).lower()}, "{message}")\n',code)
            assert count==1,(path,count)
        if n==322:
            code,count=re.subn(r'(?m)(?:^        CustomVictoryBJ\([^\n]+\)\n)+',
                '        FE_Roles.otherPlayersWin()\n',code)
            assert count==1
        if n==321:
            code=code.replace('function Trig_Player_Leaves_Actions()\n',
                'function Trig_Player_Leaves_Actions()\n'
                '    if FE_Roles.isAncient(GetTriggerPlayer()) then return end\n')
            code,count=re.subn(r'(?m)(?:^    TriggerRegisterPlayerEventLeave\([^\n]+\)\n)+',
                '    FE_Roles.forEachPlayer(function(player)\n'
                '        TriggerRegisterPlayerEventLeave(gg_trg_Player_Leaves, player)\n'
                '    end)\n',code)
            assert count==1
        if code!=source:
            records.append({'module':path,'before_sha256':ds.digest(source.encode()),
                'after_sha256':ds.digest(code.encode())})
            (root/path).write_text(code,encoding='utf-8',newline='\n')
    script=p.update_script((mapdir/'war3map.lua').read_text(),cfg)
    anchor='-- BEGIN FOREST MODULE '+cfg['header'][2]+'\n'
    assert script.count(anchor)==1
    script=script.replace(anchor,p.block(role)+'\n'+anchor)
    cfg['header'].insert(2,role)
    ds.write(root/'project.json',cfg)
    (mapdir/'war3map.lua').write_text(script,encoding='utf-8',newline='\n')
    p.editor_sources(cfg,mapdir)
    p.build()  # The regular verified build maintains the synchronization baseline.
    ds.write(root/'reports/role-refactor.json',{'backup':str(backup),'changed_modules':records,
        'intentional_changes':[
            'Ancient identity follows udg_AncientPlayer through a single role API.',
            'Ancient-only events subscribe to all eleven participants and filter the current role.',
            'Resource cleanup compares player identity instead of color.',
            'Income, victory/defeat, and leaving logic follow a takeover.',
            'Victory/defeat includes slot 11, omitted by four original Ancient death triggers.'
        ],'original_differential_suite':'Applicable to the layout-only baseline; the role change intentionally changes original behavior.',
        'live_engine_test':False})
    print('Applied Ancient-role migration to',len(records),'existing modules.')

if __name__=='__main__':main()
