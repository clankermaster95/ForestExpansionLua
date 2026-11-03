"""One-time, checked relocation of the original trigger modules; no code edits.

Reject unsynchronized code/data before moving anything. Keep original manifest
order and remap synchronization hashes only after comparing all embedded bodies.
"""
from pathlib import Path
import collections, shutil, tempfile
import project as p
import data_store as ds

GROUPS = [
    (1,2,'combat/damage'), (3,6,'effects/timed'), (7,10,'game/clock'),
    (11,11,'commands/trade'), (12,12,'game/tree_chopper'), (13,13,'players'),
    (14,16,'game/overdrive'), (17,17,'commands'), (18,18,'game/selection'),
    (19,19,'game/fountain'), (20,20,'combat'), (21,26,'economy/feed'),
    (27,28,'combat'), (29,35,'races/bounty_hunter'), (36,41,'races/cultist'),
    (42,44,'races/cultist'), (45,45,'races/centaur'), (46,47,'races/elf_engineer'), (48,48,'races/kobold'),
    (49,50,'races/night_elf'), (51,51,'races/night_elf/arch_druid'), (52,58,'races/night_elf/shadow_dancer'),
    (59,60,'races/ghoul'), (61,62,'races/kraken'), (63,63,'races/aethyr'),
    (64,64,'races/forgotten'), (65,86,'races/forgotten/executioner'), (87,89,'races/forgotten/soulreaper'),
    (90,120,'races/forgotten/bloodmage'), (121,124,'races/nerubian'),
    (125,133,'races/ratling'), (134,135,'races/razormane'),
    (136,136,'races/wisp'), (137,150,'races/wildkin'), (151,154,'races/worgen'),
    (155,155,'combat/spells'), (156,157,'ancients/paranoia'),
    (158,159,'ancients/zalxon'), (160,168,'ancients/nebula'),
    (169,171,'ancients/tremor'), (172,175,'ancients/pharaoh'),
    (176,178,'ancients/avalanche'), (179,187,'ancients/divinity'),
    (188,191,'ancients/wispari'), (192,204,'ui/hints'), (205,205,'commands'), (206,221,'ai'),
    (222,245,'items'), (246,250,'economy'), (251,255,'game/startup'),
    (256,257,'game/selection'), (258,260,'ui/names'), (261,265,'game/selection'),
    (266,268,'commands/trade'), (269,270,'game/selection'),
    (271,291,'game/bans/expanders'), (292,302,'game/bans/ancients'),
    (303,307,'combat/shop_protection'), (308,309,'players/alliances'),
    (310,310,'ui'), (311,311,'ui/quests'), (312,315,'game/selection'),
    (316,316,'players'), (317,320,'players/lackeys'), (321,322,'players/leaving'),
    (323,350,'players/deaths'), (351,365,'game/victory'),
    (366,373,'economy/base_flags'), (374,375,'items/mech_blaster'),
]

def main():
    cfg=p.config(); root=p.ROOT; mapdir=root/cfg['map']
    assert len(cfg['triggers'])==375,'Expected the 375 original trigger modules.'
    if p.pending_json_edits() or ds.changes(root,mapdir):raise RuntimeError('Reconcile data changes first.')
    embedded,conflicts=p.code_changes(mapdir,cfg)
    baseline=ds.read(root/'data/code-baseline.json')
    for path,code in embedded.items():
        if code.rstrip()!=(root/path).read_text().rstrip() or ds.digest(code.rstrip().encode())!=baseline[path]:
            raise RuntimeError('Unsynchronized code: '+path)
    assert not conflicts
    relocation={}
    for path in cfg['triggers']:
        n=int(Path(path).name[:3]); matches=[g for a,b,g in GROUPS if a<=n<=b]
        assert len(matches)==1,(path,matches)
        relocation[path]='src/'+matches[0]+'/'+Path(path).name
    assert len(set(relocation.values()))==375
    for old,new in relocation.items():
        assert (root/new).resolve().is_relative_to(root/'src') and (old==new or not (root/new).exists())
    if all(old==new for old,new in relocation.items()):return
    backup=p.backup_project(include_data=True)
    shutil.copy2(root/cfg['output'],backup/'baseline.w3x')
    records=[]
    for old,new in relocation.items():
        before=(root/old).read_bytes(); (root/new).parent.mkdir(parents=True,exist_ok=True)
        if old!=new:(root/old).rename(root/new)
        assert (root/new).read_bytes()==before
        records.append({'from':'src/triggers/'+Path(old).name,'to':new,'sha256':ds.digest(before)})
    for folder in sorted((root/'src').rglob('*'),key=lambda x:len(x.parts),reverse=True):
        if folder.is_dir() and not any(folder.iterdir()):folder.rmdir()
    cfg['triggers']=[relocation[x] for x in cfg['triggers']]
    script=(mapdir/'war3map.lua').read_text()
    for old,new in relocation.items():
        for marker in ('BEGIN','END'):
            script=script.replace('-- '+marker+' FOREST MODULE '+old+'\n','-- '+marker+' FOREST MODULE '+new+'\n')
    ds.write(root/'project.json',cfg)
    (mapdir/'war3map.lua').write_text(script,encoding='utf-8',newline='\n')
    p.editor_sources(cfg,mapdir)
    moved=p.editor_modules(mapdir,cfg)
    assert moved=={relocation.get(k,k):v for k,v in embedded.items()}
    # Relocation only: every hash value remains the synchronized, verified hash.
    ds.write(root/'data/code-baseline.json',{relocation.get(k,k):v for k,v in baseline.items()})
    coverage=ds.read(root/'reports/function-coverage.json')
    for entry in coverage:entry['module']=relocation.get(entry['module'],entry['module'])
    ds.write(root/'reports/function-coverage.json',coverage)
    p.build()
    ds.write(root/'reports/reorganization.json',{'backup':str(backup),'modules':records,
        'bodies_byte_identical':True,'manifest_order_preserved':True,
        'groups':dict(collections.Counter(str(Path(x).parent) for x in cfg['triggers']))})
    print('Relocated 375 modules without changing source bytes or initialization order.')

if __name__=='__main__':main()
