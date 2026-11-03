"""Copy a verified build to the user's configured Warcraft Maps directory."""
from pathlib import Path
import os,shutil,tempfile,re,subprocess,sys
import data_store as ds
from contextlib import contextmanager

MANAGED=re.compile(r'^Forest_Expansion_[0-9][A-Za-z0-9_.-]*_Lua(?:-build-[0-9a-f]{12})?\.w3x$')

@contextmanager
def install_lock(root):
    parent=Path(root)/'build';parent.mkdir(exist_ok=True)
    with (parent/'maps-install.lock').open('a+b') as lock:
        lock.seek(0,2)
        if lock.tell()==0:lock.write(b'0');lock.flush()
        lock.seek(0)
        if os.name=='nt':
            import msvcrt
            msvcrt.locking(lock.fileno(),msvcrt.LK_LOCK,1)
        else:
            import fcntl
            fcntl.flock(lock.fileno(),fcntl.LOCK_EX)
        try:yield
        finally:
            lock.seek(0)
            if os.name=='nt':msvcrt.locking(lock.fileno(),msvcrt.LK_UNLCK,1)
            else:fcntl.flock(lock.fileno(),fcntl.LOCK_UN)

def prune(root,folder,destination):
    """Remove older generated play copies only; never touch source/backups."""
    removed=[];pending=[]
    for path in folder.iterdir():
        if path==destination or not path.is_file() or not MANAGED.fullmatch(path.name):continue
        if path.resolve().parent!=folder:raise ValueError('Old map resolves outside configured Maps directory')
        sha=ds.digest(path.read_bytes())
        try:path.unlink();removed.append(str(path))
        except PermissionError:pending.append({'path':str(path),'sha256':sha})
    result={'removed':removed,'locked_pending':pending}
    if pending:
        parent=root/'build';parent.mkdir(exist_ok=True)
        handle,job=tempfile.mkstemp(prefix='maps-cleanup-',suffix='.json',dir=parent);os.close(handle)
        ds.write(Path(job),{'directory':str(folder),'keep':str(destination),'pending':pending})
        # A bounded hidden worker retries only these exact old checksums. It
        # never closes Warcraft and will not delete a newer file at an old path.
        flags=subprocess.CREATE_NO_WINDOW if os.name=='nt' else 0
        subprocess.Popen([sys.executable,str(root/'tools/cleanup_maps.py'),job],cwd=root,
                         stdin=subprocess.DEVNULL,stdout=subprocess.DEVNULL,stderr=subprocess.DEVNULL,
                         creationflags=flags)
        result['cleanup_job']=job
    return result

def install(root,source):
    with install_lock(root):return _install(root,source)

def _install(root,source):
    root=Path(root); source=Path(source)
    settings=root/'local-build.json'
    if os.environ.get('FOREST_SKIP_INSTALL')=='1':return {'status':'skipped for isolated validation'}
    if not settings.exists():return {'status':'not configured'}
    config=ds.read(settings)
    if not config.get('copy_to_maps',False):return {'status':'disabled'}
    folder=Path(config['maps_directory']).expanduser()
    if not folder.is_absolute():raise ValueError('maps_directory must be an absolute path')
    folder=folder.resolve(); folder.mkdir(parents=True,exist_ok=True)
    destination=folder/source.name
    if destination.resolve()==source.resolve():raise ValueError('Maps copy must be separate from the build output')
    expected=ds.digest(source.read_bytes())
    if destination.is_file() and ds.digest(destination.read_bytes())==expected:
        return {'status':'already current','path':str(destination),'sha256':expected,'old_copies':prune(root,folder,destination)}
    handle,tmp=tempfile.mkstemp(prefix=source.stem+'-',suffix='.tmp',dir=folder)
    os.close(handle); tmp=Path(tmp)
    try:
        shutil.copyfile(source,tmp)
        if ds.digest(tmp.read_bytes())!=expected:raise RuntimeError('Maps copy checksum mismatch')
        # Keep the previous playable file intact until the complete copy is ready.
        locked_target=None
        try:
            os.replace(tmp,destination)
        except PermissionError:
            if not destination.exists():raise
            # Warcraft locks an archive used by the current game. Publish a
            # separate build without disturbing that match or forcing a close.
            locked_target=str(destination)
            destination=folder/(source.stem+'-build-'+expected[:12]+source.suffix)
            if destination.exists() and ds.digest(destination.read_bytes())==expected:tmp.unlink()
            else:os.replace(tmp,destination)
        if ds.digest(destination.read_bytes())!=expected:raise RuntimeError('Installed map checksum mismatch')
    finally:
        if tmp.exists():tmp.unlink()
    report={'status':'copied','path':str(destination),'sha256':expected}
    if locked_target:report['locked_previous_copy']=locked_target
    report['old_copies']=prune(root,folder,destination)
    return report
