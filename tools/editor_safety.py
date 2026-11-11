"""Reject raw format tokens that the native editor corrupts while saving Lua.

The 3.0.1.24371 save on 2026-11-08 dropped the percent operator from the
temporary script, then crashed while writing the custom header. Use Lua hex
escapes inside quoted strings and explicitly reviewed arithmetic outside them.
This is a source guard, not a claim that a native editor save has succeeded.
"""
from pathlib import Path


def validate(root, cfg):
    paths = cfg['header'] + cfg['triggers'] + cfg['disabled'] + [cfg['bootstrap']]
    failures = []
    for path in paths:
        for line, text in enumerate((Path(root) / path).read_text(encoding='utf-8').splitlines(), 1):
            if '%' in text:
                failures.append(f'{path}:{line}')
    if failures:
        raise RuntimeError('Raw percent characters can crash World Editor on save. '
                           'Use Lua \\x25 in quoted strings; review arithmetic separately: '
                           + ', '.join(failures))
    return {'modules_checked': len(paths), 'raw_percent_characters': 0}
