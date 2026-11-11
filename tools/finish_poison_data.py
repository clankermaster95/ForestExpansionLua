"""Finalize non-orb poison aura data after the pending lobby editor import.

Only object definitions change; these can then build without another editor
save. The pending save must finish first to avoid conflicting JSON/editor edits.
"""
import data_store as ds
import project as p

def main():
    assert not (p.ROOT/'build/editor-save-required.json').exists(),'Finish the lobby editor save and export-data before changing its object inputs'
    rows=ds.read(p.ROOT/'data/object-index.json')
    def code(text):return int.from_bytes(text.encode('ascii'),'little')
    for raw,buff,levels in [('AFBL','B015',21),('AFPB','B03M',6)]:
        entry=next(row for row in rows if row['kind']=='abilities' and row['rawcode']==raw)
        path=p.ROOT/entry['path'];obj=ds.read(path)
        obj['OldId']=code('AOae');obj['_base']='AOae';entry['base']='AOae'
        obj['Modifications']=[]
        def field(key,value,level=0):
            obj['Modifications'].append({'Id':code(key),'Type':'String' if isinstance(value,str) else 'Int' if isinstance(value,int) else 'Unreal',
                'Level':level,'Pointer':0,'Value':value,'SanityCheck':0,'_field':key})
        for key,value in {'aher':0,'aite':0,'alev':levels,'arac':'other','areq':'','arqa':''}.items():field(key,value)
        for level in range(1,levels+1):
            slow=0.10+0.02*(level-1) if raw=='AFBL' else 0.04*level
            for key,value in {'Oae1':-slow,'Oae2':-slow if raw=='AFBL' else 0.0,'aare':0.0,
                'atar':'self,air,ground,vulnerable,invulnerable','abuf':buff,'adur':0.0,'ahdu':0.0}.items():field(key,value,level)
        ds.write(path,obj)
    ds.write(p.ROOT/'data/object-index.json',rows)
    print('Poison/bleed non-orb self-aura objects finalized; native orb behavior and dispellable Slow base removed.')

if __name__=='__main__':main()
