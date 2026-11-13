"""Native schema regressions, including invalid encodings with correct values."""
from pathlib import Path
import copy, importlib.util, json, zipfile
ROOT = Path(__file__).resolve().parents[1]
import sys
sys.path.insert(0, str(ROOT/'tools'))
spec = importlib.util.spec_from_file_location('native_metadata', ROOT/'tools/object_metadata.py')
native = importlib.util.module_from_spec(spec); spec.loader.exec_module(native)


def validate(packed_dir=ROOT/'build/refactor-readback'):
    report = native.validate(packed_dir=packed_dir)
    reference = native.ds.read(ROOT/native.REFERENCE)
    records = native.authored_records()
    # The frozen pre-fix object archive must fail the independent native schema
    # even though its intended numeric values (for example Iatt=0) look right.
    historical = []
    with zipfile.ZipFile(ROOT/'tests/fixtures/tooltips-r11.zip') as archive:
        for name in archive.namelist():
            parts = Path(name).parts
            if len(parts) >= 3 and parts[2] in ('abilities', 'abilities_skin'):
                historical.append((parts[2], json.loads(archive.read(name))))
    previous = native.inspect_records(historical, reference)
    prior_pointer_errors = sum('Data pointer differs' in i['reason'] for i in previous['issues'])
    assert prior_pointer_errors == 129, prior_pointer_errors

    def obj(raw):
        return next(o for kind, o in records if kind == 'abilities' and native.ds.rawcode(o['NewId'] or o['OldId']) == raw)

    def mod(raw, field, level=1):
        return next(m for m in obj(raw)['Modifications'] if native.ds.rawcode(m['Id']) == field and m.get('Level', 0) == level)

    tests = [
        ('A04C', 'Iatt', 1, 'Pointer', 0, 'Data pointer'),
        ('A0CO', 'Iatt', 6, 'Pointer', 0, 'Data pointer'),
        ('AFCT', 'spb1', 1, 'Pointer', 0, 'Data pointer'),
        ('AFLT', 'Hfs2', 7, 'Pointer', 0, 'Data pointer'),
        ('AFVA', 'Idef', 4, 'Type', 'Unreal', 'Value type'),
        ('AFCA', 'Iatt', 1, 'Level', 0, 'Level index'),
        ('AFCA', 'Iatt', 1, 'Id', int.from_bytes(b'ZZZZ', 'little'), 'Unknown ability field'),
        ('A0CC', 'Idam', 1, 'Value', 76, 'native ability family'),
    ]
    for raw, field, level, key, bad, reason in tests:
        target = mod(raw, field, level); saved = target[key]; target[key] = bad
        try:
            issues = native.inspect_records(records, reference)['issues']
            assert any(i['rawcode'] == raw and reason in i['reason'] for i in issues), (raw, reason)
        finally: target[key] = saved
    target = obj('AFCA'); saved = target['OldId']; target['OldId'] = int.from_bytes(b'Aspb', 'little')
    try:
        assert any('native ability family' in i['reason'] and i['rawcode'] == 'AFCA' for i in native.inspect_records(records, reference)['issues'])
    finally: target['OldId'] = saved
    target['Modifications'].append(copy.deepcopy(mod('AFCA', 'Iatt')))
    try:
        assert any('Duplicate' in i['reason'] and i['rawcode'] == 'AFCA' for i in native.inspect_records(records, reference)['issues'])
    finally: target['Modifications'].pop()
    other = native.type_records()
    field_reference = native.ds.read(ROOT/native.FIELD_TYPES)
    for kind, raw, field, bad_type in [('units', 'hFDM', 'usca', 'Int'),
                                      ('units_skin', 'hFDM', 'uimz', 'Int')]:
        obj = next(o for category, o in other if category == kind and native.ds.rawcode(o['NewId'] or o['OldId']) == raw)
        target = next(m for m in obj['Modifications'] if native.ds.rawcode(m['Id']) == field)
        saved = target['Type']; target['Type'] = bad_type
        try:
            assert any(i['rawcode'] == raw and i['field'] == field for i in native.inspect_types(other, field_reference)['issues'])
        finally: target['Type'] = saved
    target = next(o for kind, o in records if kind == 'abilities_skin' and native.ds.rawcode(o['NewId']) == 'AFBL')
    saved = target['OldId']; target['OldId'] = int.from_bytes(b'Aslo', 'little')
    try:
        try: native.aligned_skin_bases(records)
        except AssertionError: pass
        else: raise AssertionError('Mismatched gameplay/skin base accepted')
    finally: target['OldId'] = saved
    target = next(o['Modifications'][0] for kind, o in other if kind == 'upgrades' and o['Modifications'])
    saved = target.get('Pointer'); target['Pointer'] = 1
    try:
        assert any('data pointer' in i['reason'] for i in native.inspect_types(other, field_reference)['issues'])
    finally:
        if saved is None: target.pop('Pointer')
        else: target['Pointer'] = saved
    report['negative_checks'] = len(tests)+6
    report['historical_bad_pointers_detected'] = prior_pointer_errors
    report.pop('reference_source')
    return report


if __name__ == '__main__': print(json.dumps(validate(), indent=2))
