"""Gameplay values and native object wiring, independent of Lua event doubles."""
from pathlib import Path
import sys,math,re
ROOT=Path(__file__).resolve().parents[1];sys.path.insert(0,str(ROOT/'tools'))
import data_store as ds

def validate():
    rows=ds.read(ROOT/'data/object-index.json');checks=0
    strings=ds.strings(ROOT/'map/ForestExpansion.w3x/war3map.wts')
    def obj(kind,raw):
        entry=next(x for x in rows if x['kind']==kind and x['rawcode']==raw)
        return ds.read(ROOT/entry['path'])
    def value(kind,raw,field,level=0):
        return ds.resolve(next(m['Value'] for m in obj(kind,raw)['Modifications'] if m['_field']==field and m.get('Level',0)==level),strings)
    def equal(a,b,label):
        nonlocal checks
        same=math.isclose(a,b,rel_tol=0,abs_tol=0.000001) if isinstance(a,float) and isinstance(b,(int,float)) else a==b
        assert same,(label,a,b);checks+=1
    equal(tuple(value('units','h03X',f) for f in ['ubba','ubdi','ubsi']),(20,0,0),'Aethyr wall deterministic feed')
    flags_source=(ROOT/'src/economy/base_flags.lua').read_text(encoding='utf-8')
    refund=int(re.search(r'FE_BaseFlags\s*=\s*\{\s*lumberCost\s*=\s*(\d+)',flags_source)[1])
    for raw in ['h04Z','h050','h05P','h04Y','h04V','h04W','h05N','h04X','h051','h052']:
        equal(value('units',raw,'ugol'),0,'flag has no omitted gold refund '+raw)
        equal(value('units',raw,'ulum'),refund,'flag rejection refunds its actual cost '+raw)
    equal(value('units','h063','ua1r'),200,'Cultist base range')
    equal(value('units','h063','ua1w'),'missile','Cultist ranged weapon')
    # Resolve the weapon field IDs independently from Blizzard's native API.
    # ua1s is dice sides, NOT projectile speed; the former test repeated that
    # authoring mistake and therefore accepted both instant missiles and 1d900.
    api=(ROOT/'tools/reference-api/common.j').read_text(encoding='utf-8')
    def weapon_field(constant,field_type):
        return re.search(r'\b'+constant+r"\s*=\s*ConvertUnitWeapon"+field_type+r"Field\('([^']+)'\)",api)[1]
    speed=weapon_field('UNIT_WEAPON_RF_ATTACK_PROJECTILE_SPEED','Real')
    sides=weapon_field('UNIT_WEAPON_IF_ATTACK_DAMAGE_SIDES_PER_DIE','Integer')
    dice=weapon_field('UNIT_WEAPON_IF_ATTACK_DAMAGE_NUMBER_OF_DICE','Integer')
    for kind in ('units','units_skin'):
        equal(value(kind,'h063',speed),900,'Cultist missile flight speed '+kind)
        equal(value(kind,'h063',sides),1,'Cultist damage dice sides '+kind)
    equal(value('units','h063','ua1b')+value('units','h063',dice),100,'minimum unupgraded Cultist damage')
    equal(value('units','h063','ua1b')+value('units','h063',dice)*value('units','h063',sides),100,'maximum unupgraded Cultist damage')
    equal(value('units_skin','h063','ua1m'),'Abilities\\Weapons\\ChimaeraAcidMissile\\ChimaeraAcidMissile.mdl','green missile')
    equal(value('units','h063','uabi').endswith('AFCT'),True,'Cultist command-card spellbook')
    book=value('abilities','AFCT','spb1',1).split(',')
    equal(book,['AFCA','AFCS','AFCB','A0E4','A0EJ'],'researched abilities and passive descriptions in Blood Rites')
    for field in ('spb3','spb4'):equal(value('abilities','AFCT',field,1),len(book),'entire book available')
    main=value('units','h063','uabi').split(',')
    equal(set(book)&set(main),set(),'passive icons do not crowd the worker card')
    assert 'A0EI' in main;checks+=1 # Functional magic resistance remains attached.
    equal(value('abilities','A0EI','isr2',1),0.75,'unchanged magic resistance')
    def distinct_buttons(buttons,reserved):
        positions=set(reserved);keys=set()
        for kind,raw,xfield,yfield,keyfield in buttons:
            pos=(value(kind,raw,xfield),value(kind,raw,yfield))
            assert 0<=pos[0]<=3 and 0<=pos[1]<=2,(raw,pos)
            equal(pos in positions,False,'free command-card cell '+raw);positions.add(pos)
            for m in obj(kind,raw)['Modifications']:
                if m['_field']==keyfield and m['Value']:
                    # All levels of one research intentionally share a key.
                    key=m['Value'].upper()
                    assert key not in keys,(raw,'duplicate hotkey',key)
            keys.update(m['Value'].upper() for m in obj(kind,raw)['Modifications'] if m['_field']==keyfield and m['Value'])
    altar=value('units','h06D','ures').split(',')
    distinct_buttons([('upgrades_skin',raw,'gbpx','gbpy','ghk1') for raw in altar]+
                     [('units_skin','H064','ubpx','ubpy','uhot')],{(3,1),(3,2)})
    for building in ('h065','h06A','u00L'):
        research=value('units',building,'ures').split(',')
        fields={m['_field']:m['Value'] for m in obj('units',building)['Modifications']}
        trained=fields.get('utra','').split(',') if fields.get('utra') else []
        distinct_buttons([('upgrades_skin',raw,'gbpx','gbpy','ghk1') for raw in research]+
                         [('units_skin',raw,'ubpx','ubpy','uhot') for raw in trained],{(3,1),(3,2)})
    distinct_buttons([('abilities_skin',raw,'abpx','abpy','ahky') for raw in book],{(3,2)})
    distinct_buttons([('abilities_skin',raw,'abpx','abpy','ahky') for raw in ['A0EG','A0EH','AFCT']],
                     {(x,y) for y in (0,1) for x in range(4)}|{(0,2)})
    for ability,research in [('AFCA','RFCA'),('AFCS','RFCS'),('AFCB','RFCB')]:
        equal(value('abilities',ability,'areq'),research,'research unlock '+ability)
        assert research in altar;checks+=1
    equal('RFAT' in value('units','h063','upgr').split(','),True,'attack research affects Cultist')
    equal(value('units','h063','udup'),10,'native armor research uses unit bonus')
    equal(value('abilities','A0E4','Uau1',1),0.4,'night movement preserved in book')
    equal(value('abilities','A0E4','Uau2',1),15,'night regeneration preserved in book')
    equal(value('abilities','A0E4','areq'),'R07L','night prerequisite preserved')
    for raw in ('AFCS','AFCB'):
        equal(tuple(value('abilities_skin',raw,f) for f in ('aubx','auby')),
              tuple(value('abilities_skin',raw,f) for f in ('abpx','abpy')),'toggle keeps button position')
    for raw,cost in {'RFCA':(30,750),'RFCS':(25,750),'RFCB':(35,1000)}.items():
        equal((value('upgrades',raw,'gglb'),value('upgrades',raw,'glmb')),cost,raw+' research cost')
        equal(value('upgrades',raw,'glvl'),1,raw+' one level')
    gold=[value('upgrades','RFAT','gglb')+i*value('upgrades','RFAT','gglm') for i in range(5)]
    lumber=[value('upgrades','RFAT','glmb')+i*value('upgrades','RFAT','glmm') for i in range(5)]
    equal(gold,[5,20,35,50,65],'five independent gold prices')
    equal(lumber,[250,1000,1750,2500,3250],'five independent lumber prices')
    for level in range(1,6):equal(value('upgrades','RFAT','greq',level),'','no inherited Keep/Castle prerequisites')
    equal((sum(gold),sum(lumber)),(175,8750),'complete research cost')
    equal(value('upgrades','RFAT','gef1'),'ratx','native attack damage research')
    equal(value('upgrades','RFAT','gef2'),'ratr','native attack range research')
    for f in ['gba1','gmo1','gba2','gmo2']:equal(value('upgrades','RFAT',f),75,f)
    equal(value('units','h06D','ures').split(',')[-4:],['RFCA','RFCS','RFCB','RFAT'],'all upgrades in Altar')
    for raw in ['A04C','A0CO']:
        equal(ds.rawcode(obj('abilities',raw)['OldId']),'AItg',raw+' has no native orb base')
        equal(any(m['_field'].startswith('Spo') for m in obj('abilities',raw)['Modifications']),False,raw+' has no poison/orb fields')
    for raw in ['AFBL','AFPB']:
        equal(ds.rawcode(obj('abilities',raw)['OldId']),'AOae',raw+' retains non-dispellable poison behavior')
        equal(value('abilities',raw,'atar',1),'self,air,ground,vulnerable,invulnerable','slow applies only to the poisoned unit')
    for level in range(1,8):
        equal(value('abilities','A03S','Hfs1',level),20+5*level,'Lightning damage '+str(level))
        equal(value('abilities','AFLT','amcs',level),0,'proc needs no mana')
    # A zero Flame Strike damage interval has a first-hand delayed-freeze repro.
    # Guard authored values and every Lightning/Sand level independently of Lua.
    intervals=[re.search(r'\bABILITY_RLF_'+name+r"\s*=\s*ConvertAbilityRealLevelField\('([^']+)'\)",api)[1]
               for name in ('FULL_DAMAGE_INTERVAL','HALF_DAMAGE_INTERVAL')]
    for raw in ('A03S','AFLT','A07Y'):
        for level in range(1,value('abilities',raw,'alev')+1):
            for field in intervals:
                interval=value('abilities',raw,field,level)
                assert math.isfinite(interval) and interval>0,(raw,field,level);checks+=1
    for row in rows:
        if row['kind'] not in ('abilities','abilities_skin'):continue
        for mod in ds.read(ROOT/row['path'])['Modifications']:
            if mod['_field'] in intervals:
                assert math.isfinite(mod['Value']) and mod['Value']>0,(row['rawcode'],mod);checks+=1
    for level in range(1,5):
        equal(value('abilities','AFVA','Idef',level),10+5*level,'Vanguard armor')
        equal(value('abilities','A06U','Ufa2',level),0,'no additional dispellable armor')
    for level in range(1,4):equal(value('abilities','A06W','atar',level),'none','native spin does not suppress attacks')
    equal(value('abilities','AFIS','Oae1',1),-0.2,'Ice movement slow')
    equal(value('abilities','AFIS','Oae2',1),0,'Ice does not slow attack speed')
    for level in range(1,10):
        equal(value('abilities','AFAS','Oae1',level),0.05*level,'Cultist movement tier')
        equal(value('abilities','AFAS','Oae2',level),0.05*level,'Cultist attack tier')
    factions=ds.read(ROOT/'data/gameplay/factions.json')
    equal(len(factions['expanders']),21,'Cultist retained in catalog for solo testing')
    equal([entry['key'] for entry in factions['expanders']+factions['ancients'] if entry.get('soloOnly')],['Cultist'],'only Cultist is restricted to solo testing')
    for entry in factions['expanders']+factions['ancients']:
        assert 'RFPK' in value('units',entry['raw'],'ureq').split(',');checks+=1
        equal(entry['stock'],1,'purchasable stock after unlock')
        equal(value('units',entry['raw'],'usma'),0,'native preview cap prevents early replenishment')
    for entry in factions['ancients']:
        assert 'RFPA' in value('units',entry['raw'],'ureq').split(',');checks+=1
    for selector in ('nmer','n00G','nmr2'):
        equal(value('units',selector,'usei'),'','random stock is owned by the picking phase')
        equal('Asid' in value('units',selector,'uabi').split(','),True,'selector supports dynamic item sales')
    equal(value('abilities_skin','A01N','atp1',1),"Nature's Grasp",'single hotkey label')
    equal(value('abilities_skin','A014','aub1',1),'Increases the armor of nearby friendly units by 5.','Spirit Tree actual armor')
    assert 'Health: 300' in value('units_skin','e00R','utub');checks+=1
    # New objects must be compiled, use a valid rawcode, and have no duplicate
    # field/level/pointer entries which could silently override a chosen value.
    index=ds.read(ROOT/'data/index.json')
    listed={'data/'+p for spec in index.values() if spec['kind']=='objects' for paths in spec['lists'].values() for p in paths}
    for row in rows:
        equal(row['path'] in listed,True,'object listed '+row['rawcode'])
        record=ds.read(ROOT/row['path']);equal(ds.rawcode(record['NewId'] or record['OldId']),row['rawcode'],'rawcode '+row['rawcode'])
        if row['rawcode'].startswith(('AF','BF','RF','hF')):
            keys=[(m['Id'],m.get('Level',0),m.get('Pointer',0)) for m in record['Modifications']]
            equal(len(keys),len(set(keys)),'unique fields '+row['rawcode'])
    print('gameplay objects:',checks,'assertions passed')
    return {'assertions':checks,'result':'passed'}

if __name__=='__main__':validate()
