"""Readable, lossless JSON views of the World Editor binaries."""
from pathlib import Path
import json,hashlib,re,shutil

def read(path): return json.loads(Path(path).read_text(encoding='utf-8'))
def write(path,obj):
    path=Path(path); path.parent.mkdir(parents=True,exist_ok=True)
    path.write_text(json.dumps(obj,indent=2,ensure_ascii=False)+'\n',encoding='utf-8',newline='\n')
def digest(data): return hashlib.sha256(data).hexdigest()
def canonical(obj):
    if isinstance(obj,dict): return {k:canonical(v) for k,v in obj.items() if not k.startswith('_')}
    if isinstance(obj,list): return [canonical(v) for v in obj]
    return obj
def content_hash(obj): return digest(json.dumps(canonical(obj),sort_keys=True,ensure_ascii=False).encode())
def rawcode(value): return int(value & 0xffffffff).to_bytes(4,'little').decode('latin1')
def strings(wts):
    text=Path(wts).read_text(encoding='utf-8-sig')
    return {int(m[1]):m[2].rstrip('\r\n') for m in re.finditer(r'(?ms)^STRING (\d+)[ \t]*\n(?:[ \t]*//[^\n]*\n)*[ \t]*\{\n(.*?)^\}',text)}
def resolve(value,table):
    if isinstance(value,str) and re.fullmatch(r'TRIGSTR_\d+',value): return table.get(int(value[8:]),value)
    return value

KINDS={'.w3u':'units','.w3t':'items','.w3a':'abilities','.w3b':'destructables','.w3d':'doodads','.w3h':'buffs','.w3q':'upgrades'}
def export(root,raw,mapdir):
    data=root/'data'; index={}; names=[]; table=strings(mapdir/'war3map.wts')
    for path in sorted(raw.glob('*.json')):
        if path.name.startswith('_') or path.name.endswith(('.wtg.json','.wct.json')): continue
        filename=path.name[:-5]; obj=read(path); ext=Path(filename).suffix
        spec={'binary_sha256':digest((mapdir/filename).read_bytes()),'content_sha256':content_hash(obj)}
        if ext in KINDS:
            folder='objects/'+KINDS[ext]+('_skin' if 'Skin' in filename else '')
            spec.update(kind='objects',meta={k:v for k,v in obj.items() if not isinstance(v,list)},lists={})
            for key,values in obj.items():
                if not isinstance(values,list): continue
                paths=[]
                for i,record in enumerate(values):
                    code=rawcode(record['NewId'] or record['OldId']); base=rawcode(record['OldId'])
                    record['_rawcode']=code; record['_base']=base
                    display=code
                    for mod in record['Modifications']:
                        mod['_field']=rawcode(mod['Id'])
                        value=resolve(mod['Value'],table)
                        if value!=mod['Value']: mod['_resolvedText']=value
                        if mod['_field'] in ['unam','anam','fnam','bnam','dnam','gnam']: display=value
                    record['_name']=display
                    rel=f'{folder}/{key}/{code}.json'; write(data/rel,record); paths.append(rel)
                    names.append({'kind':folder[8:],'rawcode':code,'base':base,'name':display,'path':'data/'+rel})
                spec['lists'][key]=paths
        elif filename=='war3map.w3e':
            spec.update(kind='terrain',meta='terrain/map.json',rows=[])
            tiles=obj.pop('TerrainTiles'); width=obj['Width']; write(data/spec['meta'],obj)
            for y in range(obj['Height']):
                rel=f'terrain/rows/{y:03}.json'; write(data/rel,tiles[y*width:(y+1)*width]); spec['rows'].append(rel)
        else:
            rel='editor/'+filename+'.json'; write(data/rel,obj); spec.update(kind='file',path=rel)
        index[filename]=spec
    displays={(r['kind'].removesuffix('_skin'),r['rawcode']):r['name'] for r in names if r['name']!=r['rawcode']}
    for r in names:
        display=displays.get((r['kind'].removesuffix('_skin'),r['rawcode']),r['name'])
        if display!=r['name']:
            r['name']=display; path=root/r['path']; obj=read(path); obj['_name']=display; write(path,obj)
    write(data/'index.json',index); write(data/'object-index.json',names)
    return index

def assemble(data,spec):
    if spec['kind']=='file': return canonical(read(data/spec['path']))
    if spec['kind']=='terrain':
        obj=read(data/spec['meta']); rows=[read(data/p) for p in spec['rows']]
        if len(rows)!=obj['Height'] or any(len(r)!=obj['Width'] for r in rows): raise ValueError('Terrain dimensions changed inconsistently')
        obj['TerrainTiles']=[tile for row in rows for tile in row]; return canonical(obj)
    obj=dict(spec['meta'])
    for key,paths in spec['lists'].items(): obj[key]=[canonical(read(data/p)) for p in paths]
    return obj

def changes(root,mapdir):
    data=root/'data'; index=read(data/'index.json'); result=[]
    for filename,spec in index.items():
        obj=assemble(data,spec); modified=content_hash(obj)!=spec['content_sha256']
        binary_modified=digest((mapdir/filename).read_bytes())!=spec['binary_sha256']
        if modified and binary_modified: raise RuntimeError(f'Both World Editor and JSON changed {filename}; import/export explicitly before building.')
        if modified: result.append((filename,obj))
        elif binary_modified: raise RuntimeError(f'World Editor changed {filename}. Run project.py export-data before building.')
    return result
