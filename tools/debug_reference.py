"""Generate a separate testing reference from the same catalog used in-game."""
from pathlib import Path
import json,re
import test_data

ROOT=Path(__file__).resolve().parents[1]

def render():
    entries=[]
    pattern=r'^FE_TestData\.catalog\[.*\] = \{kind=(".*?"), raw=(".*?"), name=(.*)\}$'
    for line in test_data.render().splitlines():
        match=re.fullmatch(pattern,line)
        if match:
            kind,raw,name=(json.loads(value) for value in match.groups())
            entries.append({'kind':kind,'raw':raw,'name':name})
    assert entries and len({(e['kind'],e['raw']) for e in entries})==len(entries)
    cfg=json.loads((ROOT/'project.json').read_text(encoding='utf-8'))
    guide=(ROOT/'SOLO_TESTING.md').read_text(encoding='utf-8')
    start=guide.index('| Command |');end=guide.index('\n\n',start)
    lines=[f"# Forest Expansion {cfg['version']} — Testing reference",'',
        'A separate reference for solo testing. Use Find (Ctrl+F) to locate an item, unit or code. These lists are not added to the in-game Information menu.','',
        '## How to use','',
        '- Start a new match with exactly one human; computer slots are allowed. Test commands are unavailable in matches that started with multiple humans.',
        '- Select your own unit before issuing commands. Items spawn on the ground nearby; pick them up. Spawned heroes do not replace your chosen role.',
        '- Codes are case-sensitive. A capital `I` is different from the digit `1`.',
        '- `-test help`, `-test items <name>`, `-test units <name>` and `-test find <name>` also work in chat.',
        '- Test recipes by purchasing from the real shop. Spawning a recipe scroll does not simulate paying for it.','',
        '## Commands','',guide[start:end],'']
    def cell(value):return value.replace('|','\\|').replace('\r',' ').replace('\n',' ')
    for kind,title,command in [('items','Items','item'),('units','Units','spawn')]:
        rows=sorted((e for e in entries if e['kind']==kind),key=lambda e:(e['name'].casefold(),e['raw']))
        lines += [f'## {title} ({len(rows)})','',
                  'All entries come from the map catalog, including internal, dummy and legacy objects. A spawnable object is not necessarily a playable race or hero.','',
                  '| Name | Code | Spawn command |','|---|---|---|']
        for entry in rows:
            lines.append(f"| {cell(entry['name'])} | `{entry['raw']}` | `-{command} {entry['raw']}` |")
        lines.append('')
    return '\n'.join(lines)

def generate():
    path=ROOT/'DEBUG_REFERENCE.md';code=render()
    path.write_text(code,encoding='utf-8',newline='\n')
    count=sum(int(value) for value in re.findall(r'^## (?:Items|Units) \((\d+)\)',code,re.M))
    print(f'Generated {path.name}: {count} spawn entries.')

if __name__=='__main__':generate()
