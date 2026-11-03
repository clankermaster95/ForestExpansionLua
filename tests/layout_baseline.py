"""Run the unchanged JASS preservation suite against the layout-only archive.

Keep this separate from intentional Ancient fixes; never relax original parity
checks to make changed behavior look identical to the source map.
"""
from pathlib import Path
import json, os, shutil, subprocess, sys, tempfile
ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/'tools'))
import project as p
import data_store as ds
from mpq import unpack

def main():
    with tempfile.TemporaryDirectory(prefix='layout-baseline-',dir=ROOT/'build') as temp:
        stage=Path(temp)/'project'
        shutil.copytree(ROOT,stage,ignore=shutil.ignore_patterns('.tools','.venv','build','backups','bin','obj','__pycache__','.git','src','dist','map','local-build.json'))
        shutil.copytree(ROOT/'original/map',stage/'original/map')
        for target,source in [(stage/'.tools',ROOT/'.tools'),(stage/'tools/MapTool/bin',ROOT/'tools/MapTool/bin')]:
            if os.name=='nt':subprocess.run(['cmd','/c','mklink','/J',str(target),str(source)],check=True,capture_output=True)
            else:target.symlink_to(source,target_is_directory=True)
        cfg=p.config()
        cfg['name']='Forest Expansion 3.1.2a Lua'
        cfg['output']='dist/Forest_Expansion_3.1.2a_Lua.w3x'
        cfg.pop('version',None)
        cfg.pop('revision',None)
        (stage/cfg['output']).parent.mkdir(parents=True)
        shutil.copy2(ROOT/'dist/Forest_Expansion_3.1.2a_Organized.w3x',stage/cfg['output'])
        unpack(stage/cfg['output'],stage/cfg['map'])
        metadata=stage/'editor-code.json'; p.tool('editor-code',stage/cfg['map'],metadata)
        text=ds.read(metadata)['Text']
        cfg['header']=[match[1] for match in p.blocks(text['GlobalCustomScriptCode']['Code'].rstrip('\0'))]
        # Reconstruct the historical manifest from the historical archive,
        # independent of the current consolidated source layout.
        cfg['triggers']=[];cfg['disabled']=[]
        metadata_value=ds.read(metadata)
        items=[item for item in metadata_value['Triggers']['TriggerItems'] if 'IsEnabled' in item]
        for item,entry in zip(items,text['CustomTextTriggers']):
            for match in p.blocks((entry['Code'] or '').rstrip('\0')):
                if match[1]==cfg['bootstrap']:continue
                cfg['triggers' if item['IsEnabled'] else 'disabled'].append(match[1])
        ds.write(stage/'project.json',cfg)
        # The current release intentionally changed item definitions. Restore
        # historical JSON views from this archive before strict parity checks.
        exported=stage/'build/layout-data'; exported.mkdir(parents=True)
        p.tool('export',stage/cfg['map'],exported)
        ds.export(stage,exported,stage/cfg['map'])
        codes=[text['GlobalCustomScriptCode']]+text['CustomTextTriggers']; baseline={}
        for code in codes:
            for match in p.blocks((code['Code'] or '').rstrip('\0')):
                path=stage/match[1]; assert path.resolve().is_relative_to(stage/'src')
                path.parent.mkdir(parents=True,exist_ok=True)
                path.write_text(match[2].rstrip()+'\n',encoding='utf-8',newline='\n')
                baseline[match[1]]=ds.digest(match[2].rstrip().encode())
        assert set(baseline)==set(cfg['header']+cfg['triggers']+cfg['disabled']+[cfg['bootstrap']])
        ds.write(stage/'data/code-baseline.json',baseline)
        env=dict(os.environ,PYTHONUTF8='1',FOREST_TEST_TMP=str(ROOT/'build'))
        for args in [('tools/prepare_tests.py',),('tests/verify.py','--baseline')]:
            subprocess.run([sys.executable,'-X','utf8',*args],cwd=stage,env=env,check=True)
        report=ds.read(stage/'reports/validation.json')
        report['tested_archive']='dist/Forest_Expansion_3.1.2a_Organized.w3x'
        report['tested_archive_sha256']=ds.digest((ROOT/report['tested_archive']).read_bytes())
        report['scope']='Layout-only stage. Ancient-role changes are tested separately by tests/refactor.py.'
        ds.write(ROOT/'reports/layout-only-validation.json',report)
    print('Complete original preservation suite passed for the layout-only archive.')

if __name__=='__main__':main()
