"""Small, checked StormLib interface. Never writes the source archive."""
from pathlib import Path
import ctypes as C
import os
import sys

ROOT = Path(__file__).resolve().parents[1]

def library():
    candidates = [os.environ.get('STORMLIB_PATH'),
        ROOT / '.tools/StormLib/build/storm.framework/storm',
        ROOT / '.tools/StormLib/build/libstorm.so',
        ROOT / '.tools/StormLib/build/Release/StormLib.dll',
        ROOT / '.tools/stormlib-win/x64/StormLib.dll']
    path = next((str(p) for p in candidates if p and Path(p).exists()), None)
    if not path:
        raise RuntimeError('StormLib missing. Run tools/bootstrap.py or set STORMLIB_PATH.')
    lib = C.WinDLL(path, use_last_error=True) if os.name=='nt' else C.CDLL(path)
    # The official Windows DLL uses wide filesystem paths; archive entry names
    # remain narrow strings on every platform.
    file_path = C.c_wchar_p if os.name=='nt' else C.c_char_p
    signatures = {
        'SFileOpenArchive': ([file_path,C.c_uint32,C.c_uint32,C.POINTER(C.c_void_p)],C.c_bool),
        'SFileCloseArchive': ([C.c_void_p],C.c_bool),
        'SFileOpenFileEx': ([C.c_void_p,C.c_char_p,C.c_uint32,C.POINTER(C.c_void_p)],C.c_bool),
        'SFileGetFileSize': ([C.c_void_p,C.POINTER(C.c_uint32)],C.c_uint32),
        'SFileReadFile': ([C.c_void_p,C.c_void_p,C.c_uint32,C.POINTER(C.c_uint32),C.c_void_p],C.c_bool),
        'SFileCloseFile': ([C.c_void_p],C.c_bool),
        'SFileCreateArchive': ([file_path,C.c_uint32,C.c_uint32,C.POINTER(C.c_void_p)],C.c_bool),
        'SFileAddFileEx': ([C.c_void_p,file_path,C.c_char_p,C.c_uint32,C.c_uint32,C.c_uint32],C.c_bool),
    }
    if os.name!='nt': signatures['SErrGetLastError']=([],C.c_uint32)
    for name,(args,result) in signatures.items():
        fn=getattr(lib,name); fn.argtypes=args; fn.restype=result
    return lib

def filesystem_path(path): return str(path) if os.name=='nt' else os.fsencode(path)

class Archive:
    def __init__(self,path,create=False,count=4096):
        self.lib=library(); self.handle=C.c_void_p()
        if create:
            if Path(path).exists(): raise FileExistsError(path)
            ok=self.lib.SFileCreateArchive(filesystem_path(path),0x00100000,count,C.byref(self.handle))
        else:
            ok=self.lib.SFileOpenArchive(filesystem_path(path),0,0x100,C.byref(self.handle))
        self.check(ok,str(path))
    def check(self,ok,operation):
        if not ok:
            error=C.get_last_error() if os.name=='nt' else self.lib.SErrGetLastError()
            raise RuntimeError(f'StormLib {operation}: error {error}')
    def __enter__(self): return self
    def __exit__(self,*args): self.check(self.lib.SFileCloseArchive(self.handle),'close')
    def read(self,name):
        h=C.c_void_p()
        self.check(self.lib.SFileOpenFileEx(self.handle,name.encode(),0,C.byref(h)),name)
        try:
            size=self.lib.SFileGetFileSize(h,None)
            if size==0xffffffff: raise RuntimeError(f'Invalid file size: {name}')
            buf=C.create_string_buffer(size); read=C.c_uint32()
            if size: self.check(self.lib.SFileReadFile(h,buf,size,C.byref(read),None),name)
            if read.value!=size: raise RuntimeError(f'Short read: {name}')
            return buf.raw[:size]
        finally: self.lib.SFileCloseFile(h)
    def names(self): return self.read('(listfile)').decode('utf-8-sig').splitlines()
    def add(self,path,name):
        self.check(self.lib.SFileAddFileEx(self.handle,filesystem_path(path),name.encode(),0x200,2,2),name)

def unpack(source,dest):
    dest=Path(dest).resolve(); manifest={}
    import hashlib
    with Archive(source) as archive:
        for name in archive.names():
            p=dest / name.replace('\\','/')
            if not p.resolve().is_relative_to(dest): raise ValueError(name)
            data=archive.read(name)
            p.parent.mkdir(parents=True,exist_ok=True); p.write_bytes(data)
            manifest[name]={'bytes':len(data),'sha256':hashlib.sha256(data).hexdigest()}
    return manifest

def pack(source,dest):
    source=Path(source)
    with Archive(dest,create=True) as archive:
        for p in sorted(source.rglob('*')):
            if p.is_file() and p.name not in ['(listfile)','(attributes)','(signature)'] and not p.name.startswith('.'):
                archive.add(p,p.relative_to(source).as_posix().replace('/','\\'))

if __name__=='__main__':
    import json
    manifest=unpack(sys.argv[1],sys.argv[2])
    print(json.dumps(manifest,indent=2))
