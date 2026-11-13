"""Verify the historical timer migration separately from later gameplay fixes."""
from pathlib import Path
import hashlib,re,sys,zipfile
ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/'tools'))
from lua_source import functions
from revision_audit import FIXTURE, FIXTURE_SHA

def without_cosmic(source):
    span=next(f for f in functions(source) if f['name']=='Trig_Cosmic_Strike_2_Actions')
    return source[:span['start']]+source[span['end']:]

def validate():
    path=ROOT/'tests/fixtures/transient-timers-r10.zip'
    assert hashlib.sha256(path.read_bytes()).hexdigest()=='8786cef3801d1de324ab68ad55b3361c8be016ceb0128f5a434a03778668252d'
    published=ROOT/FIXTURE
    assert hashlib.sha256(published.read_bytes()).hexdigest()==FIXTURE_SHA
    calls=0
    with zipfile.ZipFile(path) as archive, zipfile.ZipFile(published) as frozen:
        assert len(archive.namelist())==9
        for name in archive.namelist():
            old=archive.read(name).decode().replace('\r\n','\n')
            historical=frozen.read(name).decode().replace('\r\n','\n')
            current=(ROOT/name).read_text(encoding='utf-8')
            current_functions={f['name']:current[f['start']:f['end']] for f in functions(current) if f['parent'] is None}
            for span in functions(historical):
                if span['parent'] is not None: continue
                body=historical[span['start']:span['end']]
                operations=re.findall(r'FE_Timers\.(create|destroy)\(',body)
                if operations:
                    assert re.findall(r'FE_Timers\.(create|destroy)\(',current_functions[span['name']])==operations, 'Legacy timer ownership changed: '+name+'/'+span['name']
            for operation in ('FE_Timers.create(', 'FE_Timers.destroy('):
                calls+=historical.count(operation)
            restored=historical.replace('FE_Timers.create(', 'CreateTimer(').replace('FE_Timers.destroy(', 'DestroyTimer(')
            # This independent context bug is exercised in cosmic_context.lua.
            if name=='src/ancients/nebula.lua':old,restored=without_cosmic(old),without_cosmic(restored)
            assert restored==old,'Nonmechanical timer change: '+name
    return {'result':'passed','modules':9,'native_calls_replaced':calls,
            'historical_target':FIXTURE,'historical_target_sha256':FIXTURE_SHA,
            'other_callback_logic':'Frozen r12 is byte-identical to r10 after timer substitution and newline normalization; separate Cosmic Strike fix excluded and behavior-tested.',
            'current_scope':'Historical timer operations retained in each owning callback; current lifetime suites test behavior. Later gameplay changes and new timer sites are audited separately.'}

if __name__=='__main__':print(validate())
