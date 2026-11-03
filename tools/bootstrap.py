#!/usr/bin/env python3
"""Install project-local build dependencies on macOS/Linux; no game installation needed."""
from pathlib import Path
import hashlib,os,platform,shutil,subprocess,sys,tarfile,urllib.request,venv
ROOT=Path(__file__).resolve().parents[1]
STORM='116135c27e8c0dcf8ea0a0c549a6d737ce10fc73'
LUA_SHA='fc5fd69bb8736323f026672b1b7235da613d7177e72558893a0bdcd320466d60'
def run(*args): subprocess.run([str(a) for a in args],cwd=ROOT,check=True)
def download(url,target):
    print('Download:',url,flush=True);urllib.request.urlretrieve(url,target)
def main():
    if platform.system()=='Windows':
        raise SystemExit('On Windows install .NET 10, Python 3.11+, Lua 5.3 and StormLib; see README.md. The included automatic bootstrap targets macOS/Linux.')
    cache=ROOT/'.tools';cache.mkdir(exist_ok=True)
    env=dict(os.environ,DOTNET_CLI_TELEMETRY_OPTOUT='1',DOTNET_SKIP_FIRST_TIME_EXPERIENCE='1')
    dotnet=cache/'dotnet/dotnet'
    if not dotnet.exists():
        installer=cache/'dotnet-install.sh';download('https://dot.net/v1/dotnet-install.sh',installer)
        subprocess.run(['bash',str(installer),'--version','10.0.403','--install-dir',str(cache/'dotnet'),'--no-path'],cwd=ROOT,env=env,check=True)
    cmake=ROOT/'.venv/bin/cmake'
    if not cmake.exists():
        venv.create(ROOT/'.venv',with_pip=True)
        run(ROOT/'.venv/bin/python','-m','pip','install','cmake==4.4.4')
    storm=cache/'StormLib'
    if not storm.exists():
        run('git','clone','--filter=blob:none','--no-checkout','https://github.com/ladislav-zezula/StormLib.git',storm)
        run('git','-C',storm,'checkout',STORM)
    actual=subprocess.check_output(['git','-C',str(storm),'rev-parse','HEAD'],text=True).strip()
    if actual!=STORM:raise RuntimeError('Unexpected StormLib checkout; expected '+STORM)
    cm=storm/'CMakeLists.txt';text=cm.read_text();cm.write_text(text.replace('PRIVATE "-framework Carbon"','PRIVATE "SHELL:-framework Carbon"'))
    run(cmake,'-S',storm,'-B',storm/'build','-DBUILD_SHARED_LIBS=ON','-DSTORM_USE_BUNDLED_LIBRARIES=ON','-DCMAKE_BUILD_TYPE=Release')
    run(cmake,'--build',storm/'build','-j','6')
    if not (cache/'lua-5.3.6/src/lua').exists():
        archive=cache/'lua-5.3.6.tar.gz';download('https://www.lua.org/ftp/lua-5.3.6.tar.gz',archive)
        if hashlib.sha256(archive.read_bytes()).hexdigest()!=LUA_SHA:raise RuntimeError('Lua download checksum mismatch')
        with tarfile.open(archive) as tar:tar.extractall(cache,filter='data')
        run('make','-C',cache/'lua-5.3.6','macosx' if platform.system()=='Darwin' else 'generic')
    if not (cache/'lua-5.3.6-32/src/lua').exists():
        narrow=cache/'lua-5.3.6-32'
        if not narrow.exists():shutil.copytree(cache/'lua-5.3.6',narrow)
        run('make','-C',narrow,'clean')
        run('make','-C',narrow,'macosx' if platform.system()=='Darwin' else 'generic','MYCFLAGS=-DLUA_32BITS')
    subprocess.run([str(dotnet),'restore','tools/MapTool/MapTool.csproj','--locked-mode'],cwd=ROOT,env=env,check=True)
    run(dotnet,'build','tools/MapTool/MapTool.csproj','--no-restore','-c','Release')
    print('Ready: python3 tools/project.py build')
if __name__=='__main__':main()
