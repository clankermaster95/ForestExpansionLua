"""Check authored tooltip text against current object data and the r11 baseline.

Only explicit object values are compared; inherited engine defaults and arbitrary
scripted prose are not inferred. Empty hidden/dummy tooltips are intentional.
"""
from pathlib import Path
import argparse, collections, json, re, zipfile
import data_store as ds

ROOT = Path(__file__).resolve().parents[1]
FIXTURE = 'tests/fixtures/tooltips-r11.zip'
FIXTURE_SHA = '91afdb4114662f8906ae85626f524a060d95b78ef006e08caa95bf4914d4789a'
TEXT_FIELDS = set('unam utip utub ides anam atp1 aub1 atp2 aub2 aret arut gnam gtp1 gub1 fnam ftip fube'.split())
UNIT_STATS = {'Health':'uhpm', 'Armor':'udef', 'Build Time':'ubld',
              'Attack Range':'ua1r', 'Attack Cooldown':'ua1c', 'Movement Speed':'umvs', 'Move Speed':'umvs'}
COLOR = re.compile(r'\|c[0-9a-fA-F]{8}|\|r')
COOLDOWNS = [re.compile(x, re.I) for x in (
    r'(\d+(?:\.\d+)?)\s*(?:second|seconds|s)\s*cool\s?down',
    r'(?:cooldown|CD)\s*(?::|-|is|of)\s*(\d+(?:\.\d+)?)\s*(?:seconds?|s)')]

def plain(text):
    return COLOR.sub('', text).replace('|n','\n')

class Catalog:
    def __init__(self):
        self.strings = ds.strings(ROOT/'map/ForestExpansion.w3x/war3map.wts')
        self.records = {}
        for path in sorted((ROOT/'data/objects').rglob('*.json')):
            obj = ds.read(path)
            self.records[(path.parent.parent.name,obj['_rawcode'])] = (path,obj)

    def fields(self, kind, raw):
        result = {}
        for layer in (kind,kind+'_skin'):
            entry = self.records.get((layer,raw))
            if entry:
                for mod in entry[1]['Modifications']:
                    result[(mod['_field'],mod.get('Level',0))] = ds.resolve(mod['Value'],self.strings)
        return result

    def rows(self):
        for (kind,raw),(path,obj) in self.records.items():
            for mod in obj['Modifications']:
                if mod['_field'] in TEXT_FIELDS and isinstance(mod['Value'],str):
                    yield {'path':path.relative_to(ROOT).as_posix(), 'kind':kind,'rawcode':raw,
                           'field':mod['_field'],'level':mod.get('Level',0),
                           'text':ds.resolve(mod['Value'],self.strings)}

    def issues(self):
        issues=[]; checked=collections.Counter()
        for row in self.rows():
            text=row['text']; checked[row['kind']]+=1
            def issue(reason): issues.append(dict(row,reason=reason))
            if re.search(r'TRIGSTR_\d+',text):issue('Unresolved string-table reference')
            if re.search(r'\|c(?![0-9a-fA-F]{8})',text):issue('Malformed color escape')
            if re.search(r'(?:\|[nN]|\n)\s*(?:\|r)?\s*$',text):issue('Trailing line break')
            for match in re.finditer(r'<([^<>]+)>',text):
                if ',' in match[1] and len(match[1].split(',')[0])!=4:
                    issue('Malformed object reference: '+match[0])
            fields=self.fields(row['kind'].removesuffix('_skin'),row['rawcode'])
            clean=plain(text)
            if row['kind']=='units_skin' and row['field']=='utub' and row['rawcode'][0].islower():
                for label,key in UNIT_STATS.items():
                    match=re.search(r'\b'+label+r':\s*(-?\d+(?:\.\d+)?)',clean)
                    if match and (key,0) in fields:
                        checked['explicit_unit_stats']+=1
                        if float(match[1])!=fields[key,0]:issue(label+' differs from '+key)
            if row['kind']=='abilities_skin' and row['field']=='aub1':
                level=row['level']; value=fields.get(('acdn',level))
                if value is None or level>fields.get(('alev',0),100):continue
                for pattern in COOLDOWNS:
                    for match in pattern.finditer(clean):
                        checked['explicit_cooldowns']+=1
                        if float(match[1])!=value:issue('Cooldown differs from acdn')
        return issues,dict(checked)

def gameplay_projection(obj):
    result=ds.canonical(obj)
    result['Modifications']=[m for m in result['Modifications']
                             if ds.rawcode(m['Id']) not in TEXT_FIELDS]
    return result

def inspect():
    catalog=Catalog(); issues,coverage=catalog.issues()
    fixture=ROOT/FIXTURE
    assert ds.digest(fixture.read_bytes())==FIXTURE_SHA,'Tooltip baseline changed'
    changes=[]
    with zipfile.ZipFile(fixture) as archive:
        expected=set(archive.namelist())
        assert expected=={p.relative_to(ROOT).as_posix() for p,_ in catalog.records.values()}
        for path in sorted(expected):
            old=json.loads(archive.read(path)); new=ds.read(ROOT/path)
            assert gameplay_projection(old)==gameplay_projection(new),'Non-tooltip object change: '+path
            def values(obj):
                return {(m['_field'],m.get('Level',0),m.get('Pointer',0)):m['Value']
                        for m in obj['Modifications'] if m['_field'] in TEXT_FIELDS}
            before,after=values(old),values(new)
            for key in sorted(before.keys()|after.keys()):
                if before.get(key)==after.get(key):continue
                changes.append({'path':path,'field':key[0],'level':key[1],
                                'before':ds.resolve(before.get(key),catalog.strings),
                                'after':ds.resolve(after.get(key),catalog.strings)})
    return {'baseline':FIXTURE,'baseline_sha256':FIXTURE_SHA,'coverage':coverage,
            'changed_objects':len({c['path'] for c in changes}),'changed_fields':len(changes),
            'gameplay_object_fields_unchanged':True,'issues':issues,'changes':changes,
            'limits':'Authored text and explicit data checks; hidden blank fields preserved. Inherited engine defaults, live rendering and all scripted interactions require in-game verification.'}

def validate():
    report=inspect()
    assert not report['issues'],json.dumps(report['issues'][:15],ensure_ascii=False)
    return report

if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--write',action='store_true');args=parser.parse_args()
    report=validate()
    if args.write:ds.write(ROOT/'reports/tooltip-audit.json',report)
    print(json.dumps({k:v for k,v in report.items() if k not in ('changes','issues')},indent=2))
