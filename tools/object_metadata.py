"""Validate native ability record structure independently of intended values.

The reference is derived from Warcraft metadata, not this map's object JSON.
Level and data-pointer integers are part of w3a's binary meaning: a successful
JSON/binary round trip alone does not prove the engine uses the intended slot.
"""
from pathlib import Path
import argparse, collections, json, math, struct
import data_store as ds

ROOT = Path(__file__).resolve().parents[1]
REFERENCE = 'tools/reference-data/ability-metadata.json'
FIELD_TYPES = 'tools/reference-data/object-field-types.json'

# This original-map record uses a field from an older Orb of Venom definition.
# Preserve its exact bytes pending current-engine verification; never treat it
# as evidence that arbitrary fields are valid for arbitrary ability bases.
LEGACY_FIELDS = {('A0CC', 'AIpb', 'Idam', 1):
                 {'Type': 'Unreal', 'Pointer': 1, 'Value': 75}}


def authored_records(root=ROOT):
    records = []
    for kind in ('abilities', 'abilities_skin'):
        for path in sorted((Path(root)/'data/objects'/kind).glob('*/*.json')):
            records.append((kind, ds.read(path)))
    return records


def packed_records(directory):
    records = []
    for filename, kind in [('war3map.w3a.json', 'abilities'),
                           ('war3mapSkin.w3a.json', 'abilities_skin')]:
        data = ds.read(Path(directory)/filename)
        for key in ('BaseAbilities', 'NewAbilities'):
            records.extend((kind, obj) for obj in data[key])
    return records


def inspect_records(records, reference):
    issues = []; counts = collections.Counter(); legacy = []; limited = set()
    global_fields = set(reference['global_fields'])
    for kind, obj in records:
        raw = ds.rawcode(obj['NewId'] or obj['OldId'])
        base = ds.rawcode(obj['OldId'])
        code = reference['base_codes'].get(base)
        allowed = global_fields | set(reference['families'].get(code, []))
        counts[kind+'_objects'] += 1
        seen = set()

        def issue(reason, mod=None):
            record = {'kind': kind, 'rawcode': raw, 'base': base, 'reason': reason}
            if mod is not None:
                record.update(field=ds.rawcode(mod['Id']), level=mod.get('Level', 0),
                              pointer=mod.get('Pointer', 0), type=mod['Type'])
            issues.append(record)

        if code is None:
            if base in reference['unmapped_bases']: limited.add(base)
            else: issue('Unknown native ability base')
        for mod in obj['Modifications']:
            field = ds.rawcode(mod['Id']); level = mod.get('Level', 0)
            pointer = mod.get('Pointer', 0); key = (field, level, pointer)
            counts['modifications'] += 1
            if key in seen: issue('Duplicate field/level/data-pointer record', mod)
            seen.add(key)
            rule = reference['fields'].get(field)
            if rule is None:
                issue('Unknown ability field ID', mod); continue
            if pointer != rule['pointer']:
                issue('Data pointer differs from native metadata', mod)
            if mod['Type'] != rule['type']:
                issue('Value type differs from native metadata', mod)
            if not isinstance(level, int) or level < 0 or (level > 0) != rule['leveled']:
                issue('Level index differs from native metadata', mod)
            value = mod['Value']
            if mod['Type'] == 'String':
                if not isinstance(value, str): issue('String field has non-string value', mod)
            elif not isinstance(value, (int, float)) or not math.isfinite(value):
                issue('Numeric field has non-finite/non-numeric value', mod)
            elif mod['Type'] == 'Int' and (int(value) != value or not -2**31 <= value < 2**31):
                issue('Integer field is not a signed 32-bit integer', mod)
            if code is not None and field not in allowed:
                exception = LEGACY_FIELDS.get((raw, base, field, level))
                if exception is not None and all(mod.get(k) == v for k, v in exception.items()):
                    legacy.append({'kind': kind, 'rawcode': raw, 'base': base,
                                   'field': field, 'level': level,
                                   'reason': 'Original-map Orb of Venom field needs current-engine verification'})
                else: issue('Field is not supported by this native ability family', mod)
    return {'issues': issues, 'counts': dict(counts), 'legacy_fields_preserved': legacy,
            'base_families_outside_reference': sorted(limited)}


def record_projection(kind, obj):
    """Canonical binary-valued projection, with float values rounded to float32."""
    modifications = []
    for mod in obj['Modifications']:
        value = mod['Value']
        if mod['Type'] in ('Real', 'Unreal'): value = struct.pack('<f', value).hex()
        modifications.append((mod['Id'], mod['Type'], mod.get('Level', 0),
                              mod.get('Pointer', 0), value, mod['SanityCheck']))
    return (kind, obj['OldId'], obj['NewId'], tuple(obj.get('Unk', [])),
            tuple(sorted(modifications)))


def type_records(root=ROOT, packed_dir=None):
    records = []
    for extension, kind in [('.w3u', 'units'), ('.w3t', 'items'),
                            ('.w3h', 'buffs'), ('.w3q', 'upgrades')]:
        for skin in (False, True):
            category = kind + ('_skin' if skin else '')
            if packed_dir is None:
                records.extend((category, ds.read(path)) for path in
                    sorted((Path(root)/'data/objects'/category).glob('*/*.json')))
            else:
                filename = 'war3map' + ('Skin' if skin else '') + extension + '.json'
                for objects in ds.read(Path(packed_dir)/filename).values():
                    if isinstance(objects, list):
                        records.extend((category, obj) for obj in objects)
    return records


def inspect_types(records, reference):
    issues = []; count = 0; limited = collections.Counter(); exceptions = []
    for kind, obj in records:
        raw = ds.rawcode(obj['NewId'] or obj['OldId'])
        category = kind.removesuffix('_skin')
        for mod in obj['Modifications']:
            count += 1
            field = ds.rawcode(mod['Id'])
            rule = reference['fields'][category].get(field)
            reason = None
            if rule is None:
                if field in reference['unsupported_fields'].get(category, {}):
                    limited[category+'/'+field] += 1
                else: reason = 'Unknown native object field ID'
            elif mod['Type'] != rule['type']:
                exception = next((e for e in reference['compatibility_exceptions']
                    if (e['kind'], e['rawcode'], e['field'], e['type'], e['value']) ==
                       (kind, raw, field, mod['Type'], mod['Value'])), None)
                if exception: exceptions.append(exception)
                else: reason = 'Value type differs from native metadata'
            if category == 'upgrades' and mod.get('Pointer', 0) != 0:
                reason = 'Upgrade data pointer must be zero'
            if reason: issues.append({'kind': kind, 'rawcode': raw, 'field': field,
                                      'type': mod['Type'], 'reason': reason})
    return {'issues': issues, 'modifications_checked': count,
            'fields_outside_reference': dict(limited), 'compatibility_exceptions': exceptions}


def aligned_skin_bases(records):
    bases = {(kind, obj['NewId'] or obj['OldId']): obj['OldId'] for kind, obj in records}
    for (kind, raw), base in bases.items():
        if kind.endswith('_skin') and (kind[:-5], raw) in bases:
            assert bases[kind[:-5], raw] == base, 'Gameplay/skin native bases differ: '+kind+'/'+ds.rawcode(raw)


def validate(root=ROOT, packed_dir=None):
    root = Path(root)
    reference = ds.read(root/REFERENCE)
    records = authored_records(root)
    other_records = type_records(root)
    aligned_skin_bases(records + other_records)
    report = inspect_records(records, reference)
    assert not report['issues'], json.dumps(report['issues'][:20], ensure_ascii=False)
    report.update(reference=REFERENCE, reference_source=reference['source'],
                  scope='Ability objects and skins: field IDs, value types, native data pointers, level indices, duplicates and base-family compatibility. No live-engine or multiplayer claim.')
    field_reference = ds.read(root/FIELD_TYPES)
    other_report = inspect_types(other_records, field_reference)
    assert not other_report['issues'], json.dumps(other_report['issues'][:20])
    report['other_object_types'] = other_report
    report['other_object_types_reference'] = FIELD_TYPES
    if packed_dir is not None:
        packed = packed_records(packed_dir)
        packed_report = inspect_records(packed, reference)
        assert not packed_report['issues'], json.dumps(packed_report['issues'][:20], ensure_ascii=False)
        assert sorted(record_projection(*r) for r in records) == sorted(record_projection(*r) for r in packed), 'Packed ability records differ from authored values/structure'
        report['packed_modifications_checked'] = packed_report['counts']['modifications']
        other_packed = type_records(root, packed_dir)
        packed_types = inspect_types(other_packed, field_reference)
        assert not packed_types['issues'], json.dumps(packed_types['issues'][:20])
        aligned_skin_bases(packed + other_packed)
        assert sorted(record_projection(*r) for r in other_records) == sorted(record_projection(*r) for r in other_packed), 'Packed unit/item/buff/upgrade records differ from authored values/structure'
        report['other_packed_modifications_checked'] = packed_types['modifications_checked']
    return report


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--packed-dir', type=Path)
    parser.add_argument('--write', action='store_true')
    args = parser.parse_args(); result = validate(packed_dir=args.packed_dir)
    if args.write: ds.write(ROOT/'reports/object-metadata-audit.json', result)
    print(json.dumps(result, indent=2))
