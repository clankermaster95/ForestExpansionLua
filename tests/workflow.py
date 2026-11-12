"""Exercise editor/data conflicts and portable builds in an isolated project."""
from pathlib import Path
import hashlib,json,re,shutil,subprocess,tempfile,os,sys
ROOT=Path(__file__).resolve().parents[1]
def digest(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def read(p):return json.loads(p.read_text())
def write(p,v):p.write_text(json.dumps(v,indent=2)+'\n')
def main():
    results=[]
    # The layout suite nests this test. Share its outer scratch directory to
    # avoid Windows MAX_PATH failures on long imported texture filenames.
    scratch=Path(os.environ.get('FOREST_TEST_TMP',str(ROOT/'build'))).resolve()
    with tempfile.TemporaryDirectory(prefix='forest-workflow-',dir=scratch) as temp:
        work=Path(temp)/'project'
        shutil.copytree(ROOT,work,ignore=shutil.ignore_patterns('.tools','.venv','build','backups','bin','obj','__pycache__','original','.git','local-build.json'))
        def link_directory(source,target):
            if os.name=='nt':
                subprocess.run(['cmd','/c','mklink','/J',str(target),str(source)],check=True,capture_output=True)
            else:target.symlink_to(source,target_is_directory=True)
        link_directory(ROOT/'.tools',work/'.tools')
        link_directory(ROOT/'tools/MapTool/bin',work/'tools/MapTool/bin')
        cfg=read(work/'project.json');mapdir=work/cfg['map'];output=work/cfg['output']
        installed=Path(temp)/'TestMaps'/Path(cfg['output']).name
        write(work/'local-build.json',{'copy_to_maps':True,'maps_directory':str(installed.parent)})
        def run(*args,fail=None):
            r=subprocess.run([str(a) for a in args],cwd=work,text=True,capture_output=True)
            if fail:
                assert r.returncode and fail in r.stdout+r.stderr,(args,r.stdout,r.stderr)
            else:assert r.returncode==0,(args,r.stdout,r.stderr)
            return r
        def project(*args,**kw):
            previous=digest(installed) if installed.exists() else None
            result=run(sys.executable,'-X','utf8','tools/project.py',*args,**kw)
            if args[0]=='build':
                if kw.get('fail'):assert (digest(installed) if installed.exists() else None)==previous
                else:assert installed.exists() and digest(installed)==digest(output)
            return result
        def tool(*args):return run(work/'.tools/dotnet/dotnet',work/'tools/MapTool/bin/Release/net10.0/MapTool.dll',*args)
        def editor_change(path,comment):
            raw=work/'build/code-edit.json';tool('editor-code',mapdir,raw);metadata=read(raw)
            wct=metadata['Text'];codes=[wct['GlobalCustomScriptCode']]+wct['CustomTextTriggers']
            marker='-- END FOREST MODULE '+path
            for code in codes:
                if marker in (code.get('Code') or ''):code['Code']=code['Code'].replace(marker,comment+'\n'+marker)
            raw=work/'build/changed-wct.json';write(raw,wct);tool('import',raw,mapdir/'war3map.wct')
            script=mapdir/'war3map.lua';script.write_text(script.read_text().replace(marker,comment+'\n'+marker))
        project('build')
        assert digest(output)==digest(ROOT/cfg['output']);results.append('fresh work directory using installed tool dependencies reproduces archive without project build cache')
        if 'revision' in cfg:
            inconsistent=dict(cfg,revision='wrong-test-revision')
            write(work/'project.json',inconsistent)
            project('build',fail='Release title mismatch')
            write(work/'project.json',cfg)
            results.append('mismatched visible/runtime release revisions reject build and preserve installed map')
        if 'src/items/recipe_data.lua' in cfg['header']:
            shop=work/'data/objects/units/NewUnits/h02B.json';original_shop=shop.read_bytes()
            broken=read(shop);fields={m['_field']:m for m in broken['Modifications']}
            fields['usei']['Value']=fields['umki']['Value'];fields['umki']['Value']=''
            write(shop,broken)
            project('build',fail='Shop Sharing requires Items Made')
            shop.write_bytes(original_shop)
            results.append('invalid Ancient shop stock mode rejects build and preserves installed map')
        obsolete=installed.parent/'Forest_Expansion_3.0.0_Lua.w3x';obsolete.write_bytes(b'old generated map')
        unrelated=installed.parent/'MyOtherMap.w3x';unrelated.write_bytes(b'keep')
        project('build');assert not obsolete.exists() and unrelated.read_bytes()==b'keep'
        results.append('installation retains only latest generated Forest map while preserving unrelated maps')
        sys.path.insert(0,str(ROOT/'tools'))
        from cleanup_maps import clean
        obsolete.write_bytes(b'old generated map'); oldsha=digest(obsolete)
        job={'directory':str(installed.parent),'keep':str(installed),'pending':[{'path':str(obsolete),'sha256':oldsha}]}
        obsolete.write_bytes(b'new replacement')
        pending,removed,changed=clean(job)
        assert obsolete.exists() and changed==[str(obsolete)] and not pending and not removed
        job['pending'][0]['sha256']=digest(obsolete)
        pending,removed,changed=clean(job);assert not obsolete.exists() and removed==[str(obsolete)]
        job['pending']=[{'path':str(installed),'sha256':digest(installed)}]
        try:clean(job);raise AssertionError('cleanup accepted newest map')
        except ValueError:pass
        assert installed.exists()
        results.append('deferred cleanup verifies old checksum and refuses to delete the current map')
        strings=mapdir/'war3map.wts'; original_strings=strings.read_bytes()
        strings.write_bytes(original_strings[3:])
        project('build',fail='UTF-8 BOM')
        strings.write_bytes(original_strings.replace(b'\r\n',b'\n'))
        project('build',fail='CRLF')
        strings.write_bytes(original_strings)
        results.append('missing WTS BOM or structural CRLF rejects build and preserves installed map')
        src=work/cfg['triggers'][10];src.write_text(src.read_text()+'\n-- Local source test\n')
        project('build');assert 'Local source test' in (mapdir/'war3map.lua').read_text();results.append('local Lua edits build')
        project('object-set','units','h000','uhpm','778');project('terrain-rect','60','60','1','1','--height-delta','0.25')
        project('export-data',fail='Unbuilt JSON edits');project('import-editor',ROOT/cfg['output'],fail='pending JSON edits')
        if cfg.get('tooltip_validation'):
            # Kraken's picker description does not print health; use a wall's
            # explicit stat block to exercise the stale-tooltip rejection.
            project('object-set','units','h01I','uhpm','778')
            project('build',fail='Tooltip validation failed')
            skin=work/'data/objects/units_skin/NewUnits/h01I.json';obj=read(skin)
            description=next(m for m in obj['Modifications'] if m['_field']=='utub')
            text=description['Value']
            updated,count=re.subn(r'(Health:(?:\s|\|r|\|c[0-9a-fA-F]{8})*)\d+',r'\g<1>778',text)
            assert count==1
            project('object-set','units_skin','h01I','utub',json.dumps(updated))
            results.append('stale numeric tooltip rejects build without replacing installed map; matching text permits intended stat edits')
        project('build');tool('export',mapdir,work/'build/readback')
        units=read(work/'build/readback/war3map.w3u.json')
        obj=next(u for u in units['NewUnits'] if u['NewId']==int.from_bytes(b'h000','little'))
        assert next(m['Value'] for m in obj['Modifications'] if m['Id']==int.from_bytes(b'uhpm','little'))==778
        terrain=read(work/'build/readback/war3map.w3e.json')
        baseline=read(ROOT/'data/terrain/rows/060.json')[60]['Height']
        assert terrain['TerrainTiles'][60*129+60]['Height']==baseline+0.25
        results.append('object/terrain CLI edits compile; imports/exports reject pending JSON')
        disabled=cfg['disabled'][1];editor_change(disabled,'-- Editor disabled-source test')
        project('build',fail='World Editor changed Lua');project('export-data',fail='World Editor changed Lua')
        project('export-data','--accept-code');assert 'Editor disabled-source test' in (work/disabled).read_text()
        project('build');results.append('disabled WCT Lua edits survive explicit adoption and rebuild')
        active=cfg['triggers'][0];editor_change(active,'-- Editor active-source test')
        (work/active).write_text((work/active).read_text()+'\n-- Competing local edit\n')
        project('build',fail='World Editor changed Lua')
        project('export-data','--accept-code');assert 'Editor active-source test' in (work/active).read_text()
        assert any('Competing local edit' in p.read_text() for p in (work/'backups').glob('*/'+active))
        project('build');results.append('conflicting editor/local Lua rejected; explicit adoption backs up local changes')
        placement=work/'data/editor/war3mapUnits.doo.json';units=read(placement)
        units['Units'][0]['Position']['X']+=16;write(placement,units)
        project('build',fail='needs editor script regeneration');project('apply-data')
        project('build',fail='editor save and export-data');project('export-data',fail='World Editor has not regenerated')
        script=mapdir/'war3map.lua';code=script.read_text()
        lines=code.splitlines(True);found=0
        for i,line in enumerate(lines):
            if 'gg_unit_h00Q_0026 = BlzCreateUnitWithSkin' in line:
                assert '4480.0' in line;lines[i]=line.replace('4480.0','4464.0');found+=1
        assert found==1;script.write_text(''.join(lines))
        project('export-data');project('build')
        assert '4464.0' in (mapdir/'war3map.lua').read_text()
        results.append('placement edits require regenerated creation code; regenerated code survives build')
        incoming=Path(temp)/'editor-save.w3x';shutil.copytree(mapdir,incoming)
        marker='-- END FOREST MODULE '+cfg['triggers'][1]
        content=(incoming/'war3map.lua').read_text().replace(marker,'-- inconsistent script-only edit\n'+marker)
        (incoming/'war3map.lua').write_text(content);before=digest(mapdir/'war3map.lua')
        project('import-editor',incoming,'--accept-code',fail='WCT and executable Lua differ')
        assert digest(mapdir/'war3map.lua')==before
        results.append('inconsistent editor archive rejected before replacing work folder')
        results.append('successful builds install matching archives into an isolated Maps folder; rejected builds retain the previous installed map')
    report={'result':'passed','checks':results,'actual_editor_used':False}
    write(ROOT/'reports/workflow-validation.json',report)
    print('Workflow checks passed:',len(results))
if __name__=='__main__':main()
