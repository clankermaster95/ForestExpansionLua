"""Retry deletion of exact obsolete play copies after Warcraft unlocks them."""
from pathlib import Path
import sys,time
import data_store as ds
from install_map import MANAGED,install_lock

def clean(job):
    folder=Path(job['directory']).resolve(); keep=Path(job['keep']).resolve()
    pending=[];removed=[];changed=[]
    for entry in job['pending']:
        path=Path(entry['path'])
        if path.resolve().parent!=folder or path.resolve()==keep or not MANAGED.fullmatch(path.name):
            raise ValueError('Refusing map cleanup outside its exact reviewed scope')
        if not path.exists():continue
        try:
            if ds.digest(path.read_bytes())!=entry['sha256']:changed.append(str(path));continue
            path.unlink();removed.append(str(path))
        except PermissionError:pending.append(entry)
    return pending,removed,changed

def main():
    path=Path(sys.argv[1]); job=ds.read(path); removed=[];changed=[]
    for _ in range(1440): # At most twelve hours; the next build also prunes.
        # Serialize with the installer so a newer replacement cannot arrive
        # between checksum verification and deletion of an obsolete copy.
        with install_lock(path.parent.parent):job['pending'],done,superseded=clean(job)
        removed+=done;changed+=superseded
        ds.write(path.with_suffix('.status.json'),{'removed':removed,'changed_and_preserved':changed,'pending':job['pending']})
        if not job['pending']:return
        time.sleep(30)

if __name__=='__main__':main()
