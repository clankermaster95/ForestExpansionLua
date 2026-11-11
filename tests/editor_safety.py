"""Check editor-safe spelling preserves Lua strings and integer arithmetic."""
from pathlib import Path
import importlib.util, json, subprocess, sys, tempfile, zipfile

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / 'tools'))
from lua_source import tokens
spec = importlib.util.spec_from_file_location('editor_source_guard', ROOT / 'tools/editor_safety.py')
guard = importlib.util.module_from_spec(spec)
spec.loader.exec_module(guard)


def validate():
    cfg = json.loads((ROOT / 'project.json').read_text())
    report = guard.validate(ROOT, cfg)
    literals = []
    for path in cfg['header'] + cfg['triggers'] + cfg['disabled'] + [cfg['bootstrap']]:
        for token in tokens((ROOT / path).read_text(encoding='utf-8')):
            if token.kind == 'string' and '\\x25' in token.text:
                literals.append(token.text)
    assert len(literals) >= 17, 'Expected the command patterns and displayed percentage strings'
    with zipfile.ZipFile(ROOT / 'tests/fixtures/gameplay-r8.zip') as archive:
        old_runtime = archive.read('src/runtime.lua').decode()
    script = old_runtime + '\nlocal oldDiv = __jdiv\n' + (ROOT / 'src/runtime.lua').read_text()
    script += '\nlocal checks = 0\n'
    for literal in literals:
        original = literal.replace('\\x25', '%')
        script += f'assert({literal} == {original}); checks = checks + 1\n'
    script += '''
local values = {(-2147483647 - 1), -2147483647, -1000000, -65537, -32769,
    -100, -7, -5, -4, -1, 0, 1, 4, 5, 7, 100, 32769, 65537, 1000000, 2147483647}
for _, a in ipairs(values) do
    for _, b in ipairs(values) do
        if b ~= 0 then assert(__jdiv(a,b) == oldDiv(a,b), tostring(a)..' / '..tostring(b)); checks = checks + 1 end
    end
    assert((a % 4 == 0) == (math.fmod(a,4) == 0)); checks = checks + 1
end
for index = 1,20 do
    assert(64*((index-1)%5+1) == 64*(math.fmod(index-1,5)+1)); checks = checks + 1
end
assert(not pcall(__jdiv,1,0)); checks = checks + 1
print('editor-safe Lua: '..checks..' assertions passed')
'''
    results = []
    (ROOT / 'build').mkdir(exist_ok=True)
    with tempfile.TemporaryDirectory(prefix='editor-safety-', dir=ROOT / 'build') as temporary:
        path = Path(temporary) / 'semantics.lua'
        path.write_text(script, encoding='utf-8')
        for kind in ('lua-5.3.6', 'lua-5.3.6-32'):
            exe = ROOT / '.tools' / kind / 'src' / ('lua.exe' if sys.platform == 'win32' else 'lua')
            result = subprocess.run([str(exe), str(path)], capture_output=True, text=True)
            assert result.returncode == 0, result.stdout + result.stderr
            results.append({'runtime': kind, 'result': result.stdout.strip()})
        # A new unsafe source must fail before serializing editor input.
        bad = Path(temporary) / 'bad.lua'
        bad.write_text('return string.match("x", "%s")', encoding='utf-8')
        try:
            guard.validate(Path(temporary), {'header': ['bad.lua'], 'triggers': [], 'disabled': [], 'bootstrap': 'bad.lua'})
        except RuntimeError as error:
            assert 'bad.lua:1' in str(error)
        else:
            raise AssertionError('Unsafe editor source was accepted')
    return {**report, 'literal_equivalence_checks': len(literals), 'behavior': results, 'unsafe_source_rejected': True}


if __name__ == '__main__':
    print(json.dumps(validate(), indent=2))
