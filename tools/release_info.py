"""Keep visible map names and runtime release labels tied to project.json."""
import argparse
import data_store as ds
import project as p
from map_strings import replace

def titles(cfg):
    suffix=cfg['version']+' Lua '+cfg['revision']
    return {116:'|cff08BD5AForest Expansion|r '+suffix,121:'Forest Expansion '+suffix}

def validate(mapdir,cfg):
    if 'revision' not in cfg:return
    actual=ds.strings(mapdir/'war3map.wts')
    for key,value in titles(cfg).items():
        if actual.get(key)!=value:raise ValueError('Release title mismatch; run tools/release_info.py --write after changing project.json.')

if __name__=='__main__':
    parser=argparse.ArgumentParser();parser.add_argument('--write',action='store_true');args=parser.parse_args()
    cfg=p.config();mapdir=p.ROOT/cfg['map']
    if args.write:replace(mapdir/'war3map.wts',titles(cfg))
    validate(mapdir,cfg)
