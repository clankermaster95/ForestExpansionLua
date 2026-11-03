"""Preserve Warcraft's UTF-8 BOM and CRLF string-table structure."""
from pathlib import Path
import re
import data_store as ds

ENTRY=re.compile(rb'(?m)^(STRING (\d+)\r\n(?:[ \t]*//[^\n]*\r\n)*[ \t]*\{\r\n)(.*?)(^\})',re.S)

def validate(path):
    data=Path(path).read_bytes()
    if not data.startswith(b'\xef\xbb\xbf'):
        raise RuntimeError('war3map.wts must retain its UTF-8 BOM; missing encoding markers can blank map text.')
    body=data[3:]; entries=list(ENTRY.finditer(body))
    declarations=re.findall(rb'(?m)^STRING (\d+)',body)
    if len(entries)!=len(declarations) or len({m[2] for m in entries})!=len(entries):
        raise RuntimeError('war3map.wts has invalid/duplicate entries or lost CRLF structural line endings.')
    strings=ds.strings(path)
    for number in (116,117,118,120,121,7400,7401):
        if not strings.get(number):raise RuntimeError(f'Map/title/timer string {number} is missing or blank.')
    return {'entries':len(entries),'encoding':'UTF-8 BOM','structure':'CRLF','required_titles_present':True}

def replace(path,values):
    path=Path(path);validate(path);data=path.read_bytes();found=set()
    def substitute(m):
        number=int(m[2])
        if number not in values:return m[0]
        found.add(number)
        value=values[number].replace('\r\n','\n').replace('\n','\r\n').encode('utf-8')
        return m[1]+value+b'\r\n'+m[4]
    result=data[:3]+ENTRY.sub(substitute,data[3:])
    if found!=set(values):raise ValueError('Unknown string IDs: '+str(set(values)-found))
    path.write_bytes(result);validate(path)
