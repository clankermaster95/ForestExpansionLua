"""Compare stateful combat/timer scenarios against the original JASS AST."""
from pathlib import Path
import json,subprocess,sys
from differential import lua
from event_model import EventVM
from jass_model import Array,default
ROOT=Path(__file__).resolve().parents[1]
def G(name):return {'global':name}
def U(name):return {'unit':name}
def scenarios():
    steps=[]
    def add(**kw):steps.append(kw)
    def call(name,*args):add(call=name,args=list(args),argc=len(args))
    def observe(label,value,expected=None):
        kw={'observe':value,'label':label}
        if expected is not None:kw['expect']=expected
        add(**kw)
    def mutate(unit,**kw):add(mutate=U(unit),data=kw)
    add(unit='caster',data={'owner':{'player':0},'life':40.0,'maxLife':100.0})
    add(unit='target',data={'owner':{'player':1},'x':600.0,'life':500.0,'maxLife':500.0})
    add(unit='ally',data={'owner':{'player':0},'x':50.0})
    add(unit='structure',data={'owner':{'player':1},'x':200.0,'life':1000.0,'maxLife':1000.0})
    add(types=[G('UNIT_TYPE_STRUCTURE')],of=U('structure'))
    add(unit='tornado',data={'owner':{'player':0},'typeid':G('PassiveMissiles__PM_TORNADO_UNIT_ID')})
    add(ability=G('SpellLeech__SL_ABILITY_ID'),of=U('caster'),level=2)
    add(context={'GetSpellAbilityId':G('SpellLeech__SL_ABILITY_ID'),'GetTriggerUnit':U('caster')})
    call('SpellLeech__OnSpellEffect')
    call('SpellLeech__IsLeechActive',U('caster'))
    for damage,attack,target in [(60.0,False,'target'),(200.0,False,'target'),(60.0,True,'target'),(60.0,False,'ally'),(0.0,False,'target'),(-10.0,False,'target')]:
        add(context={'GetTriggerUnit':U(target),'GetEventDamageSource':U('caster'),'GetEventDamage':damage,'BlzGetEventIsAttack':attack,'BlzGetEventDamageType':G('DAMAGE_TYPE_MAGIC')})
        call('SpellLeech__OnDamage')
    observe('leech caps health',{'of':U('caster'),'field':'life'},100.0)
    add(mutate=G('SpellLeech__SL_Clock'),data={'elapsed':100.0})
    call('SpellLeech__IsLeechActive',U('caster'))
    call('SpellLeech__ActivateLeech',U('caster'),0)
    call('SpellLeech__ActivateLeech',None,3)
    call('SpellLeech__ActivateLeech',U('caster'),3)
    add(set='SpellLeech__SL_REQUIRE_DAMAGE_TYPE_MAGIC',value=True)
    add(context={'BlzGetEventIsAttack':False,'BlzGetEventDamageType':G('DAMAGE_TYPE_NORMAL')})
    call('SpellLeech__IsValidLeechDamage',U('caster'),U('target'),25.0)
    add(set='SpellLeech__SL_REQUIRE_DAMAGE_TYPE_MAGIC',value=False)
    for field,value in [('visible',False),('invulnerable',True),('life',0.0)]:
        mutate('target',**{field:value});call('PassiveMissiles__IsValidTargetForCaster',U('caster'),U('target'))
        mutate('target',visible=True,invulnerable=False,life=500.0)
    add(types=[G('UNIT_TYPE_MAGIC_IMMUNE')],of=U('target'))
    call('PassiveMissiles__IsValidTargetForCaster',U('caster'),U('target'))
    add(types=[],of=U('target'))
    call('PassiveMissiles__LaunchMissile',U('caster'),U('target'),True)
    add(tick='PassiveMissiles__MoveMissiles',count=60)
    observe('missile hits',{'of':U('target'),'field':'life'},440.0)
    observe('missile cleanup',G('PassiveMissiles__PM_Count'),0)
    call('PassiveMissiles__LaunchMissile',U('caster'),U('target'),False)
    call('PassiveMissiles__LaunchMissile',U('caster'),U('structure'),True)
    mutate('target',visible=False)
    add(tick='PassiveMissiles__MoveMissiles',count=60)
    observe('invalid target not damaged',{'of':U('target'),'field':'life'},440.0)
    observe('structure damage multiplier',{'of':U('structure'),'field':'life'},970.0)
    mutate('target',visible=True)
    add(ability=G('PassiveMissiles__PM_ABILITY_ID'),of=U('caster'),level=3)
    add(context={'GetSummonedUnit':U('tornado'),'GetSummoningUnit':U('caster')})
    call('PassiveMissiles__OnSummon')
    call('PassiveMissiles__GetProjectileCount',U('tornado'))
    call('PassiveMissiles__GetMissileDamageSource',U('tornado'))
    call('PassiveMissiles__StartVolley',U('tornado'),3)
    add(tick='PassiveMissiles__ContinueVolley',count=2)
    observe('delayed volley creates three missiles',G('PassiveMissiles__PM_Count'),3)
    add(tick='PassiveMissiles__MoveMissiles',count=80)
    observe('volley cleanup',G('PassiveMissiles__PM_Count'),0)
    mutate('caster',life=0.0)
    call('PassiveMissiles__GetMissileDamageSource',U('tornado'))
    mutate('caster',life=100.0)
    # Exercise the original Damage Engine pipeline under controlled event values.
    add(set='udg_ExperienceRate',index=1,value=75.0)
    for damage,kind,attack in [(0.0,'DAMAGE_TYPE_MAGIC',False),(12.5,'DAMAGE_TYPE_MAGIC',False),(80.0,'DAMAGE_TYPE_NORMAL',True),(30.0,'DAMAGE_TYPE_UNKNOWN',False),(10000.0,'DAMAGE_TYPE_MAGIC',False)]:
        add(context={'GetTriggerUnit':U('target'),'GetEventDamageSource':U('caster'),'GetEventDamage':damage,
            'BlzGetEventIsAttack':attack,'BlzGetEventAttackType':G('ATTACK_TYPE_NORMAL'),'BlzGetEventDamageType':G(kind),
            'BlzGetEventWeaponType':G('WEAPON_TYPE_WHOKNOWS')})
        call('s__Damage_onDamagingCallback');call('s__Damage_onDamagedCallback')
        add(tick='s__Damage_asyncCallback')
        observe('damage callback cleanup',G('DamageEngine___callbacksInProgress'),False)
    for rate in [0.0,25.0,50.0,100.0,199.5]:
        for field,value in [('UNIT_IF_GOLD_BOUNTY_AWARDED_BASE',133),('UNIT_IF_GOLD_BOUNTY_AWARDED_NUMBER_OF_DICE',2),('UNIT_IF_GOLD_BOUNTY_AWARDED_SIDES_PER_DIE',6)]:
            call('BlzSetUnitIntegerField',U('target'),G(field),value)
        call('FR_ApplyGoldBountyRate',U('target'),rate)
        for field in ['UNIT_IF_GOLD_BOUNTY_AWARDED_BASE','UNIT_IF_GOLD_BOUNTY_AWARDED_NUMBER_OF_DICE','UNIT_IF_GOLD_BOUNTY_AWARDED_SIDES_PER_DIE']:
            call('BlzGetUnitIntegerField',U('target'),G(field))
    return steps

def snapshot(vm,api):
    lines=[]
    for name,kind in api['globals'].items():
        value=vm.g.get(name)
        if isinstance(value,Array):
            lines.extend('array|'+name+'|'+str(key)+'|'+vm.encode(item) for key,item in value.items() if item!=default(kind))
        else:lines.append('global|'+name+'|'+vm.encode(value))
    return sorted(lines)

def main():
    api=json.loads((ROOT/'build/converted/api.json').read_text());model=json.loads((ROOT/'build/reference-model.json').read_text())
    vm=EventVM(model,api);vm.startup();initial_state=snapshot(vm,api);before=set(vm.calls);steps=scenarios();vm.run(steps)
    (ROOT/'build/event-scenarios.lua').write_text('return '+lua(steps))
    (ROOT/'build/mock-metadata.lua').write_text('return '+lua(api))
    (ROOT/'build/jass-event.trace').write_text('\n'.join(vm.trace)+'\n')
    (ROOT/'build/jass-event.results').write_text('\n'.join(vm.observations)+'\n')
    for runtime in ['lua-5.3.6','lua-5.3.6-32']:
        subprocess.run([str(ROOT/'.tools'/runtime/'src/lua'),'tests/lua_mock.lua','build/mock-metadata.lua','map/ForestExpansion.w3x/war3map.lua','build/lua-event.trace','','build/event-scenarios.lua'],cwd=ROOT,check=True)
        for filename,want in [('lua-event.trace',vm.trace),('lua-event.results',vm.observations),('lua-startup.state',initial_state),('lua-event.state',snapshot(vm,api))]:
            got=(ROOT/'build'/filename).read_text().splitlines()
            for i in range(max(len(want),len(got))):
                a=want[i] if i<len(want) else '<end>';b=got[i] if i<len(got) else '<end>'
                assert a==b,(runtime,filename,i,a,b)
    report={'result':'exact match in both Lua numeric configurations','scenario_steps':len(steps),
        'observations':len(vm.observations),'native_calls_including_startup':len(vm.trace),
        'functions_executed':len(vm.calls),'additional_functions_beyond_startup':sorted(set(vm.calls)-before),
        'global_state_comparison':'all declared globals and nondefault array entries, after startup and after events',
        'state_entries_after_startup':len(initial_state),'state_entries_after_events':len(snapshot(vm,api)),
        'controlled_callbacks':['SpellLeech spell/damage','PassiveMissiles movement/volley','DamageEngine damaging/damaged/async'],
        'limitations':'Controlled native double; no actual Warcraft engine scheduling, combat, rendering, pathfinding, multiplayer or save/load.'}
    (ROOT/'reports/event-differential.json').write_text(json.dumps(report,indent=2)+'\n')
    print('Stateful scenarios passed:',len(steps),'steps,',len(vm.observations),'observations,',len(vm.trace),'native calls.')
if __name__=='__main__':main()
