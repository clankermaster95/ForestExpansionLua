from pathlib import Path
import json,os,subprocess,sys
from jass_model import VM
ROOT=Path(__file__).resolve().parents[1]
def lua(v):
    if v is None:return 'nil'
    if v is True:return 'true'
    if v is False:return 'false'
    if isinstance(v,(int,float)):return repr(v)
    if isinstance(v,str):return '"'+v.replace('\\','\\\\').replace('"','\\"').replace('\n','\\n').replace('\r','\\r')+'"'
    if isinstance(v,list):return '{'+','.join(map(lua,v))+'}'
    return '{'+','.join('['+lua(k)+']='+lua(x) for k,x in v.items())+'}'
def main():
    api=json.loads((ROOT/'build/converted/api.json').read_text())
    model=json.loads((ROOT/'build/reference-model.json').read_text())
    vm=VM(model,api); reference=vm.startup(); startup_count=len(reference)
    cases=[]
    def add(name,*args):cases.append({'name':name,'args':list(args)})
    for n in [-333,-101,-1,0,1,49,50,75,99,100,101,125,250,500,999,10000,2147483647]:
        add('FeedRate_Clamp',n);add('SetFeedPercentToMultiplierText',n)
    for n in [-10,0,49.9999,50,50.125,99.9999,100,300.01,10000]:add('SetFeedClampRate',n)
    for v in [0,1,3,100,1023,100000]:
        for rate in [0,0.1,12.5,33.3333,99.9,100,150]:add('FR_ScaledInt',v,rate)
    for text in ['', '  ', 'a b', '  75 red', '100', 'test:250','00010','12x','-42','  hello  [hidden] world ']:
        for name in ['SetFeedTrimLeft','SetFeedFirstToken','SetFeedRestAfterFirstToken','SetFeedIsUnsignedInteger','FeedRate_ParseRate','Ancient_CollapseSpaces','Ancient_RemoveSquareBracketBlocks']:
            add(name,text)
        for char in [':',' ','x']:add('FeedRate_FindChar',text,char)
    for event in ['Modifier','Pre','Armor','Damage','After','Lethal','AOE','Source','unknown','']:
        add('s__DamageTrigger_getVerboseStr',event)
    for level in [0,1,2,3,5,10]:add('SpellLeech__GetDuration',level)
    for name in ['CHEMICAL_RAGE_ABILITY','DUMMY_UNIT_ID','DUMMY_ABILITY']:add(name)
    for id_ in [0,vm.g['BURST_DRAGONIC_ABIL_ID'],vm.g['BURST_LICH_ABIL_ID']]:
        add('BURST_IsSupportedAbility',id_);add('BURST_GetMissileModel',id_)
        for level in [0,1,2,3,7]:
            for func in ['BURST_GetMissileSpeed','BURST_GetMissileHeight','BURST_GetMissileScale','BURST_GetHitRange','BURST_GetDamage','BURST_GetAoE']:add(func,id_,level)
    expected=[vm.encode(vm.call(c['name'],c['args'])) for c in cases]
    (ROOT/'build/jass-startup.trace').write_text('\n'.join(reference)+'\n')
    (ROOT/'build/behavior-cases.lua').write_text('return '+lua(cases))
    (ROOT/'build/mock-metadata.lua').write_text('return '+lua(api))
    script=sys.argv[1] if len(sys.argv)>1 else 'map/ForestExpansion.w3x/war3map.lua'
    interpreter=os.environ.get('FOREST_LUA',str(ROOT/'.tools/lua-5.3.6/src/lua'))
    subprocess.run([interpreter,'tests/lua_mock.lua','build/mock-metadata.lua',script,'build/lua-startup.trace','build/behavior-cases.lua'],cwd=ROOT,check=True)
    results=(ROOT/'build/lua-behavior.results').read_text().splitlines()
    assert len(results)==len(expected)
    for i,(want,got) in enumerate(zip(expected,results)):
        assert want==got,(cases[i],want,got)
    actual=(ROOT/'build/lua-startup.trace').read_text().splitlines()
    for i in range(max(len(reference),len(actual))):
        want=reference[i] if i<len(reference) else '<end>'
        got=actual[i] if i<len(actual) else '<end>'
        if want!=got:
            print('Mismatch at call',i+1,'\nJASS:',want,'\nLua: ',got)
            for line in reference[max(0,i-3):i]:print('before:',line)
            raise AssertionError('Startup differential mismatch')
    print('PASS:',startup_count,'startup calls and',len(cases),'behavior cases match the independent JASS evaluator; total native/BJ calls:',len(reference))
    (ROOT/'reports/startup-differential.json').write_text(json.dumps({'startup_calls_compared':startup_count,'behavior_cases':len(cases),'total_calls_compared':len(reference),'result':'exact match','scope':'deterministic engine double; config/main, trigger registration and initial actions; waits suspend; timers are registered but not advanced','engine_test':False},indent=2)+'\n')
if __name__=='__main__':main()
