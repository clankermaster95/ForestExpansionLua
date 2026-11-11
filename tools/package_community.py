"""Package the verified playable map and player-facing notes for sharing."""
from pathlib import Path
import hashlib, json, zipfile

ROOT=Path(__file__).resolve().parents[1]

def main():
    cfg=json.loads((ROOT/'project.json').read_text(encoding='utf-8'))
    report=json.loads((ROOT/'reports/refactor-validation.json').read_text(encoding='utf-8'))
    map_path=ROOT/cfg['output'];map_bytes=map_path.read_bytes()
    checksum=hashlib.sha256(map_bytes).hexdigest()
    assert report['result']=='passed' and report['archive_sha256']==checksum
    assert report['revision']==cfg['revision']
    label=f"Forest Expansion {cfg['version']} Lua {cfg['revision']}"
    notes=(ROOT/'CHANGELOG.md').read_text(encoding='utf-8')
    assert cfg['version'] in notes
    readme=(f"{label}\n\n"
            f"Copy {map_path.name} to your Warcraft III Maps folder.\n"
            "Start a fresh match; replacing a map does not update an ongoing match.\n"
            "Shop debug messages are off by default.\n\n"
            "CHANGELOG.md describes the release. SOLO_TESTING.md lists testing commands.\n"
            "This is a test build; live multiplayer validation is still needed.\n")
    entries={map_path.name:map_bytes,'CHANGELOG.md':notes.encode('utf-8'),
             'SOLO_TESTING.md':(ROOT/'SOLO_TESTING.md').read_bytes(),
            'DEBUG_REFERENCE.md':(ROOT/'DEBUG_REFERENCE.md').read_bytes(),
            'PATCH_TESTING.md':(ROOT/'PATCH_TESTING.md').read_bytes(),
            'README.txt':readme.encode('utf-8'),'SHA256.txt':f'{checksum}  {map_path.name}\n'.encode()}
    output=ROOT/'dist'/f"Forest_Expansion_{cfg['version']}_Community.zip"
    with zipfile.ZipFile(output,'w',compression=zipfile.ZIP_DEFLATED,compresslevel=9) as archive:
        for name,data in entries.items():
            info=zipfile.ZipInfo(name,date_time=(2026,11,2,0,0,0))
            info.compress_type=zipfile.ZIP_DEFLATED
            archive.writestr(info,data,compresslevel=9)
    with zipfile.ZipFile(output) as archive:
        assert archive.testzip() is None and set(archive.namelist())==set(entries)
        for name,data in entries.items():assert archive.read(name)==data
    summary={'revision':cfg['revision'],'file':output.relative_to(ROOT).as_posix(),
             'sha256':hashlib.sha256(output.read_bytes()).hexdigest(),'map_sha256':checksum,
             'contents':list(entries),'verified_readback':True}
    (ROOT/'reports/community-package.json').write_text(json.dumps(summary,indent=2)+'\n',encoding='utf-8')
    print(json.dumps(summary,indent=2))

if __name__=='__main__':main()
