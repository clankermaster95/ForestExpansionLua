"""Refresh custom Lua after a failed save, retaining the native-save requirement.

Only use while World Editor is closed. No placement/configuration script is
regenerated here, no archive is built, and the pending save is never cleared.
"""
import shutil, tempfile
import project as p
import data_store as ds


def main():
    cfg = p.config()
    mapdir = p.ROOT / cfg['map']
    pending = p.ROOT / 'build/editor-save-required.json'
    state = ds.read(pending)
    script_path = mapdir / 'war3map.lua'
    assert ds.digest(script_path.read_bytes()) == state['script_sha256'], 'Review editor changes before refreshing source'
    _, changed = p.code_changes(mapdir, cfg)
    assert not changed, 'Resolve editor/source conflicts before refreshing source'
    backup = p.backup_project(include_data=True)
    old_baseline = (p.ROOT / 'data/code-baseline.json').read_bytes()
    files = ('war3map.lua', 'war3map.wct', 'war3map.wtg')
    native_before = {name: ds.digest((mapdir/name).read_bytes()) for name in state['files']}
    with tempfile.TemporaryDirectory(prefix='editor-retry-', dir=p.ROOT/'build') as temporary:
        stage = p.ROOT / temporary
        script = p.update_script(script_path.read_text(encoding='utf-8'), cfg)
        (stage/'war3map.lua').write_text(script, encoding='utf-8', newline='\n')
        p.editor_sources(cfg, stage)
        for kind in ('lua-5.3.6', 'lua-5.3.6-32'):
            exe = p.ROOT/'.tools'/kind/'src'/('luac.exe' if p.os.name=='nt' else 'luac')
            p.run(exe, '-p', stage/'war3map.lua')
        modules = p.editor_modules(stage, cfg)
        try:
            for name in files:
                shutil.copy2(stage/name, mapdir/name)
            p.save_code_baseline(modules)
            refreshed = dict(state, script_sha256=ds.digest(script_path.read_bytes()))
            ds.write(pending, refreshed)
            assert native_before == {name: ds.digest((mapdir/name).read_bytes()) for name in state['files']}
        except Exception:
            for name in files:
                shutil.copy2(backup/'map'/name, mapdir/name)
            (p.ROOT/'data/code-baseline.json').write_bytes(old_baseline)
            ds.write(pending, state)
            raise
    ds.write(p.ROOT/'build/editor-retry.json', {
        'backup': str(backup), 'refreshed_files': files,
        'unchanged_pending_native_data': native_before,
        'save_still_required': True, 'script_sha256': refreshed['script_sha256']})
    print('Refreshed editor Lua; native save remains required. Backup:', backup)


if __name__ == '__main__':
    main()
