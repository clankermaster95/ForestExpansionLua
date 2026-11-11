"""Compare serialization with the ordering observed in a real native save."""
from pathlib import Path
import sys,tempfile,zipfile
ROOT=Path(__file__).resolve().parents[1];sys.path.insert(0,str(ROOT/'tools'))
import project as p
import data_store as ds


def validate():
    fixture=ROOT/'tests/fixtures/editor-first-save.zip'
    assert ds.digest(fixture.read_bytes())=='4b297bfeb4e2af06e33a31f0c4df6d41a77bb794b1ae48f76bc37ef43641c9c7'
    with tempfile.TemporaryDirectory(prefix='editor-layout-',dir=ROOT/'build') as temporary:
        folder=Path(temporary)
        with zipfile.ZipFile(fixture) as archive:
            for name in ('war3map.wtg','war3map.wct'):(folder/name).write_bytes(archive.read(name))
        p.tool('editor-code',folder,folder/'native-save.json')
        saved=ds.read(folder/'native-save.json')
    native_items=[x for x in saved['Triggers']['TriggerItems'] if 'IsEnabled' in x]
    bad_active=[m[1] for item,entry in zip(native_items,saved['Text']['CustomTextTriggers'])
                if item['IsEnabled'] for m in p.blocks(entry['Code'])]
    assert 'src/bootstrap.lua' not in bad_active and 'src/disabled/000_globals.lua' in bad_active
    generated=ds.read(ROOT/'build/editor-source/war3map.wtg.json')
    codes=ds.read(ROOT/'build/editor-source/war3map.wct.json')
    items=[x for x in generated['TriggerItems'] if 'IsEnabled' in x]
    assert [(x['Id'],x['Name']) for x in items]==[(x['Id'],x['Name']) for x in native_items], 'WCT must follow observed native tree order'
    active=[];disabled=[]
    for item,entry in zip(items,codes['CustomTextTriggers']):
        matches=p.blocks(entry['Code'])
        if item['Name']=='FE_EditorObjectReferences':
            assert not matches and not item['IsEnabled'];continue
        assert len(matches)==1 and matches[0][1]==item['Description'], item['Name']
        (active if item['IsEnabled'] else disabled).append(matches[0][1])
    cfg=p.config()
    assert set(active)==set(cfg['triggers']+[cfg['bootstrap']]) and active.count(cfg['bootstrap'])==1
    assert set(disabled)==set(cfg['disabled'])
    assert not set(active)&set(disabled)
    return {'result':'passed','native_trigger_order_checked':len(items),'active_trigger_modules':len(active),'disabled_modules':len(disabled),'bootstrap_enabled_once':True}


if __name__=='__main__':print(validate())
