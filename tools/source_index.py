"""Read independently tracked legacy sections inside consolidated source modules.

Numbers identify historical trigger provenance, not filenames or runtime order.
The original initialization functions remain the authority for execution order.
"""
from pathlib import Path
import re
import project as p

SECTION = re.compile(r'(?ms)^-- BEGIN FOREST SECTION (\d+) ([^\r\n]+)\n(.*?)^-- END FOREST SECTION \1\n?')

def sections(cfg=None):
    result=[]
    for path in (cfg or p.config())['triggers']:
        code=(p.ROOT/path).read_text(encoding='utf-8')
        matches=list(SECTION.finditer(code))
        if matches:
            result.extend({'id':int(m[1]),'name':m[2],'module':path,'code':m[3].rstrip()+'\n'} for m in matches)
        else:
            match=re.fullmatch(r'(\d+)_(.+)',Path(path).stem)
            if not match:raise ValueError('Missing source-section provenance: '+path)
            result.append({'id':int(match[1]),'name':match[2],'module':path,'code':code.rstrip()+'\n'})
    ids=[entry['id'] for entry in result]
    if len(ids)!=len(set(ids)):raise ValueError('Duplicate source-section IDs')
    return sorted(result,key=lambda entry:entry['id'])
