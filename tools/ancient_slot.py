"""Prepare/apply the 7 <-> 11 lobby permutation; editor save is still required."""
from copy import deepcopy
import sys
import data_store as ds
import project as p

def swap(slot):return {6:10,10:6}.get(slot,slot)

def mask(value):
    raw=value & 0xffffffff
    low,high=(raw>>6)&1,(raw>>10)&1
    raw=(raw & ~((1<<6)|(1<<10))) | (low<<10) | (high<<6)
    return raw-(1<<32) if value<0 and raw>=(1<<31) else raw

def remap(info,placements):
    info,placements=deepcopy(info),deepcopy(placements)
    slot_names={row['Id']:row['Name'] for row in info['Players']}
    for row in info['Players']:
        row['Id']=swap(row['Id']);row['Name']=slot_names[row['Id']]
        for name in ('AllyLowPriorityFlags','AllyHighPriorityFlags','EnemyLowPriorityFlags','EnemyHighPriorityFlags'):
            row[name]=mask(row[name])
    info['Players'].sort(key=lambda row:row['Id'])
    for row in info['Forces']:row['Players']=mask(row['Players'])
    assert not info['UpgradeData'] and not info['TechData'],'Audit per-player tech overrides before extending this permutation'
    for row in placements['Units']:row['OwnerId']=swap(row['OwnerId'])
    return info,placements

def prepare():
    info_path=p.ROOT/'data/editor/war3map.w3i.json'
    units_path=p.ROOT/'data/editor/war3mapUnits.doo.json'
    info,units=ds.read(info_path),ds.read(units_path)
    assert info['Players'][6]['Race']=='NightElf' and info['Players'][10]['Race']=='Human','Expected original lobby before swap'
    changed_info,changed_units=remap(info,units)
    back_info,back_units=remap(changed_info,changed_units)
    assert back_info==info and back_units==units,'Permutation must be exactly reversible'
    plan={'old_ancient_slot':7,'new_ancient_slot':11,'color':'Dark Green',
        'source_hashes':{str(info_path.relative_to(p.ROOT)):ds.content_hash(info),str(units_path.relative_to(p.ROOT)):ds.content_hash(units)},
        'placements':[{'creation':row['CreationNumber'],'type':ds.rawcode(row['TypeId']),'from':row['OwnerId']+1,'to':swap(row['OwnerId'])+1} for row in units['Units'] if row['OwnerId'] in (6,10)],
        'info':changed_info,'units':changed_units,
        'required_next_step':'After --apply, the maintainer must open/save map/ForestExpansion.w3x in World Editor, then export-data and build. Do not bypass the editor-save guard.'}
    ds.write(p.ROOT/'build/ancient-slot-plan.json',plan)
    return plan

def apply():
    plan=prepare()
    assert not p.pending_json_edits(),'Build the gameplay object changes before applying lobby data'
    backup=p.backup_project(include_data=True)
    ds.write(p.ROOT/'data/editor/war3map.w3i.json',plan['info'])
    ds.write(p.ROOT/'data/editor/war3mapUnits.doo.json',plan['units'])
    path=p.ROOT/'src/players/roles.lua';source=path.read_text(encoding='utf-8')
    assert 'initialAncientSlot = 6' in source
    source=source.replace('initialAncientSlot = 6','initialAncientSlot = 10').replace(
        '-- the original eleven slots. Changing that lobby is a separate editor task.',
        '-- eleven slots, with the Ancient in slot 11 (Dark Green).')
    path.write_text(source,encoding='utf-8',newline='\n')
    p.apply_data()
    print('Prepared slot 11/Dark Green; backup:',backup)
    print(plan['required_next_step'])

if __name__=='__main__':
    if '--apply' in sys.argv:apply()
    else:
        plan=prepare();print('Prepared reviewable lobby change:',len(plan['placements']),'ownership records. No live files changed.')
