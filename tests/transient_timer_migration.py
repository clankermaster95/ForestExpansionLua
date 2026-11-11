"""Prove that timer ownership edits preserve legacy callback bodies otherwise."""
from pathlib import Path
import hashlib,sys,zipfile
ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/'tools'))
from lua_source import functions

def without_cosmic(source):
    span=next(f for f in functions(source) if f['name']=='Trig_Cosmic_Strike_2_Actions')
    return source[:span['start']]+source[span['end']:]

def validate():
    path=ROOT/'tests/fixtures/transient-timers-r10.zip'
    assert hashlib.sha256(path.read_bytes()).hexdigest()=='8786cef3801d1de324ab68ad55b3361c8be016ceb0128f5a434a03778668252d'
    calls=0
    with zipfile.ZipFile(path) as archive:
        assert len(archive.namelist())==9
        for name in archive.namelist():
            old=archive.read(name).decode().replace('\r\n','\n')
            current=(ROOT/name).read_text(encoding='utf-8')
            calls+=current.count('FE_Timers.create(')+current.count('FE_Timers.destroy(')
            restored=current.replace('FE_Timers.create(', 'CreateTimer(').replace('FE_Timers.destroy(', 'DestroyTimer(')
            # This independent context bug is exercised in cosmic_context.lua.
            if name=='src/ancients/nebula.lua':old,restored=without_cosmic(old),without_cosmic(restored)
            assert restored==old,'Nonmechanical timer change: '+name
    return {'result':'passed','modules':9,'native_calls_replaced':calls,'other_callback_logic':'byte-identical after newline normalization; separate Cosmic Strike fix excluded and behavior-tested'}

if __name__=='__main__':print(validate())
