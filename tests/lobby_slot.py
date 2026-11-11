"""Validate lobby metadata, placement ownership and regenerated native script."""
from pathlib import Path
import json,re,sys,zipfile
ROOT=Path(__file__).resolve().parents[1];sys.path.insert(0,str(ROOT/'tools'))
import data_store as ds
from ancient_slot import remap
from lua_source import functions

def validate():
    with zipfile.ZipFile(ROOT/'tests/fixtures/gameplay-r8.zip') as archive:
        original=json.loads(archive.read('data/editor/war3map.w3i.json'))
        placements=json.loads(archive.read('data/editor/war3mapUnits.doo.json'))
    expected,expected_units=remap(original,placements)
    actual=ds.read(ROOT/'data/editor/war3map.w3i.json')
    current_units=ds.read(ROOT/'data/editor/war3mapUnits.doo.json')
    # Native v39 adds per-player HUD preference; all saved defaults are Selectable.
    for old,saved in zip(expected['Players'],actual['Players']):
        if 'RaceHud' not in old and 'RaceHud' in saved:
            assert saved['RaceHud']=='Selectable'
            old['RaceHud']='Selectable'
    for field in ('Players','Forces','ScriptLanguage','CameraBounds','CameraBoundsComplements','PlayableMapAreaWidth','PlayableMapAreaHeight','Tileset','UpgradeData','TechData'):
        assert actual[field]==expected[field],'Unexpected lobby change: '+field
    wanted={u['CreationNumber']:u for u in expected_units['Units']}
    found={u['CreationNumber']:u for u in current_units['Units']}
    assert wanted.keys()==found.keys(),'Placed units added/removed unexpectedly'
    for number,unit in wanted.items():
        saved=found[number]
        for field in ('TypeId','SkinId','OwnerId','HP','MP','HeroLevel','GoldAmount','InventoryData','AbilityData'):
            if field in unit:assert saved[field]==unit[field],(number,field)
        for axis in ('X','Y'):assert abs(saved['Position'][axis]-unit['Position'][axis])<0.001,(number,axis)
    cfg=ds.read(ROOT/'project.json');script=(ROOT/cfg['map']/'war3map.lua').read_text(encoding='utf-8')
    bodies={f['name']:script[f['start']:f['end']] for f in functions(script) if f['parent'] is None and f['name']}
    buildings=bodies.get('CreateBuildingsForPlayer10','')
    assert re.search(r'local\s+p\s*=\s*Player\(\s*10\s*\)',buildings),'Editor has not moved Ancient buildings to slot 11'
    for raw in ('n00A','n000','h02B','h05B','n00B'):
        assert 'FourCC("'+raw+'")' in buildings,'Missing moved Ancient building: '+raw
        assert 'FourCC("'+raw+'")' not in bodies.get('CreateBuildingsForPlayer6',''),'Building remains assigned to old Ancient'
    config='\n'.join(bodies.get(name,'') for name in ('InitCustomPlayerSlots','InitCustomTeams','config'))
    assert re.search(r'SetPlayerRacePreference\(\s*Player\(\s*10\s*\),\s*RACE_PREF_NIGHTELF\s*\)',config),'Ancient race preference stale'
    assert re.search(r'SetPlayerTeam\(\s*Player\(\s*10\s*\),\s*1\s*\)',config),'Ancient force assignment stale'
    assert re.search(r'SetPlayerColor\(\s*Player\(\s*10\s*\),\s*ConvertPlayerColor\(\s*10\s*\)\s*\)',config),'Ancient is not Dark Green'
    assert 'initialAncientSlot = 10' in (ROOT/'src/players/roles.lua').read_text()
    return {'result':'passed','slot':11,'color':'Dark Green','placed_units_checked':len(found),
            'editor_metadata':{key:{'before':original[key],'after':actual[key]} for key in ('FormatVersion','MapVersion','EditorVersion','GameVersion') if original[key]!=actual[key]}}

if __name__=='__main__':print(json.dumps(validate(),indent=2))
