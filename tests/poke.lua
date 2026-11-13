-- Event/cast overlap and native temporary-resource stress regressions.
-- Optional root argument runs the identical scenarios against published source.
local root = arg[1] or "."
local checks, scenarios, failures = 0, 0, {}
local event, enum, world, counts, created, lastEffect, triggers, damage, orders
local contexts = {}
local function check(ok, message) checks=checks+1; assert(ok,message) end
local function context() return contexts[coroutine.running()] or event end
local function reset()
    event, world, counts, created, triggers, damage, orders = {}, {}, {locations=0,groups=0,effects=0}, {}, {}, {}, {}
end
local function test(name, callback)
    scenarios=scenarios+1; reset()
    local ok,message=pcall(callback)
    if not ok then failures[#failures+1]=name..": "..tostring(message) end
end
function FourCC(s) return s end
function __jreal(v) return v end
function __jint(v) return v end
function Condition(f) return f end
function GetSpellAbilityId() return context().ability end
function GetSpellAbilityUnit() return context().unit end
function GetSpellTargetUnit() return context().target end
function GetTriggerUnit() return context().unit end
function GetTriggerEventId() return context().kind end
function GetTriggerPlayer() return context().unit.owner end
function GetResearchingUnit() assert(context().kind=="research"); return context().unit end
function GetResearched() return context().ability end
function GetDyingUnit() return context().unit end
function GetKillingUnitBJ() return context().killer end
function GetManipulatedItem() return context().item end
function GetEnumUnit() return enum end
function GetOwningPlayer(u) return u.owner end
function GetUnitTypeId(u) return u and not u.removed and u.kind or 0 end
function GetWidgetLife(u) return u and not u.removed and u.life or 0 end
function GetUnitLifePercent(u) return u.life end
function SetUnitLifePercentBJ(u,amount) u.life=math.min(amount,100) end
function GetUnitX(u) return u.x end
function GetUnitY(u) return u.y end
function IsUnitEnemy(u,p) return u.owner~=p end
function IsUnitType(u,kind) return kind==UNIT_TYPE_DEAD and u.life<=0 end
function GetUnitAbilityLevel(u,id) return u.abilities[id] or 0 end
function SetUnitAbilityLevel(u,id,level) if u.abilities[id] then u.abilities[id]=level end end
function SetUnitAbilityLevelSwapped(id,u,level) SetUnitAbilityLevel(u,id,level) end
function IncUnitAbilityLevelSwapped(id,u) SetUnitAbilityLevel(u,id,GetUnitAbilityLevel(u,id)+1) end
function UnitAddAbilityBJ(id,u) u.abilities[id]=u.abilities[id] or 1 end
function UnitRemoveAbilityBJ(id,u) assert(not u.removed); u.abilities[id]=nil end
function UnitRemoveBuffBJ(id,u) assert(not u.removed); u.abilities[id]=nil end
function GetPlayerTechCount(p,id) return p.research[id] or 0 end
local function point(x,y) counts.locations=counts.locations+1; return {x=x,y=y} end
function GetUnitLoc(u) return point(u.x,u.y) end
function GetSpellTargetLoc() return point(context().x,context().y) end
function GetRectCenter(r) return point(r.x,r.y) end
function GetRectCenterX(r) return r.x end
function GetRectCenterY(r) return r.y end
function OffsetLocation(p,x,y) return point(p.x+x,p.y+y) end
function RemoveLocation(p) assert(p and not p.removed,'invalid/double location release'); p.removed=true; counts.locations=counts.locations-1 end
function SetUnitPosition(u,x,y) assert(not u.removed); u.x,u.y=x,y end
function SetUnitPositionLoc(u,p) assert(not p.removed); SetUnitPosition(u,p.x,p.y) end
function CreateGroup() counts.groups=counts.groups+1; return {} end
function DestroyGroup(g) assert(not g.destroyed,'group destroyed twice'); g.destroyed=true; counts.groups=counts.groups-1 end
function ForGroupBJ(g,f)
    assert(not g.destroyed); local old=enum
    for _,u in ipairs(g) do enum=u; f() end
    enum=old
end
function IsUnitInGroup(u,g) for _,v in ipairs(g) do if u==v then return true end end; return false end
function GroupAddUnit(g,u) if not IsUnitInGroup(u,g) then g[#g+1]=u end end
local filterUnit
function GetFilterUnit() return filterUnit end
local function groupWhere(predicate)
    local g=CreateGroup(); for _,u in ipairs(world) do if not u.removed and predicate(u) then g[#g+1]=u end end; return g
end
function GetUnitsOfPlayerAndTypeId(p,id) return groupWhere(function(u) return u.owner==p and u.kind==id end) end
function GetUnitsOfPlayerAll(p) return groupWhere(function(u) return u.owner==p end) end
function GetUnitsInRectOfPlayer(r,p) return GetUnitsOfPlayerAll(p) end
function GetUnitsInRectAll(r) return groupWhere(function(u) return not r.selectorOnly or u.selector end) end
function GetUnitsInRectMatching(r,f) return groupWhere(function(u) filterUnit=u;local result=f();filterUnit=nil;return result end) end
function GetUnitsInRangeOfLocAll(radius,p)
    assert(not p.removed); return groupWhere(function(u) return (u.x-p.x)^2+(u.y-p.y)^2<=radius^2 end)
end
function GetPlayableMapRect() return {} end
local function unit(kind,p,x,y)
    local u={kind=kind,owner=p,x=x or 0,y=y or 0,life=100,abilities={}}
    world[#world+1]=u; return u
end
function CreateNUnitsAtLoc(n,id,p,loc,facing)
    assert(n==1 and not loc.removed); local u=unit(id,p,loc.x,loc.y); u.facing=facing
    created[#created+1]=u
end
function CreateUnit(p,id,x,y,facing) local u=unit(id,p,x,y); u.facing=facing; created[#created+1]=u; return u end
function UnitAddAbility(u,id) UnitAddAbilityBJ(id,u) end
function IssueTargetOrder(u,order,target) IssueTargetOrderBJ(u,order,target) end
function GetLastCreatedUnit() return created[#created] end
function RemoveUnit(u) u.removed=true end
function KillUnit(u) u.life=0 end
function CreateItemLoc(id,p) assert(not p.removed); created[#created+1]={kind=id,x=p.x,y=p.y} end
function UnitApplyTimedLifeBJ(duration,buff,u) u.duration=duration end
function IssueTargetOrderBJ(u,order,target) u.order=order; u.target=target end
function IssuePointOrderLocBJ(u,order,p) assert(not p.removed); orders[#orders+1]={u=u,x=p.x,y=p.y,order=order} end
function UnitDropItemPointLoc(u,item,p) assert(not p.removed); item.x,item.y=p.x,p.y; u.dropped=item end
function AddSpecialEffectLocBJ(p,path) assert(not p.removed); counts.effects=counts.effects+1; lastEffect={path=path} end
function GetLastCreatedEffectBJ() return lastEffect end
function DestroyEffect(e) assert(not e.destroyed); e.destroyed=true; counts.effects=counts.effects-1 end
function UnitDamagePointLoc(u,delay,radius,p,amount,attack,kind)
    assert(not p.removed); damage[#damage+1]={source=u,x=p.x,y=p.y,radius=radius,amount=amount}
end
function UnitDamageTargetBJ(u,target,amount) damage[#damage+1]={source=u,target=target,amount=amount} end
function CreateTrigger() local t={events={},conditions={},actions={}}; triggers[#triggers+1]=t; return t end
function TriggerAddCondition(t,f) t.conditions[#t.conditions+1]=f end
function TriggerAddAction(t,f) t.actions[#t.actions+1]=f end
function TriggerRegisterAnyUnitEventBJ(t,kind) t.events[#t.events+1]=kind end
local function emit(kind,u,ability,target)
    event={kind=kind,unit=u,ability=ability,target=target}
    for _,t in ipairs(triggers) do
        for _,registered in ipairs(t.events) do
            if registered==kind then
                local pass=true; for _,f in ipairs(t.conditions) do if not f() then pass=false end end
                if pass then for _,f in ipairs(t.actions) do f() end end
            end
        end
    end
end
function EnableTrigger(t) if t then t.disabled=false end end
function DisableTrigger(t) t.disabled=true end
function AdjustPlayerStateBJ(amount,p) p.gold=(p.gold or 0)+amount end
function GetRandomInt(low,high) return low end
function GetPlayersAll() return {} end
function DisplayTextToForce() end
function TriggerSleepAction(duration) return coroutine.yield(duration) end
EVENT_PLAYER_UNIT_SPELL_CAST="cast"; EVENT_PLAYER_UNIT_SPELL_FINISH="finish"
EVENT_PLAYER_UNIT_SPELL_ENDCAST="endcast"; EVENT_PLAYER_UNIT_SPELL_EFFECT="effect"
EVENT_PLAYER_UNIT_DEATH="death"; UNIT_TYPE_DEAD="dead"; bj_UNIT_FACING=270
ATTACK_TYPE_NORMAL="attack"; DAMAGE_TYPE_NORMAL="normal"
gg_rct_Fountain={x=99,y=101}; gg_rct_ChopChop={x=80,y=90}
gg_rct_Spawner={x=20,y=30}; gg_rct_SpawnDefender={selectorOnly=true}
local owner, other = {research={}},{research={}}
FE_Roles={ancient=function() return owner end}
for _,path in ipairs({"races/worgen","races/wildkin","races/kobold","races/ratling","races/nerubian",
    "races/night_elf/shadow_dancer","races/forgotten/soulreaper","races/forgotten/executioner","races/forgotten",
    "players/deaths","players/lackeys","ai/behavior","ancients/nebula","ancients/paranoia","game/tree_chopper"}) do
    dofile(root.."/src/"..path..".lua")
end
local function clean()
    check(counts.locations==0 and counts.groups==0 and counts.effects==0,
        'temporary handles remain: locations='..counts.locations..', groups='..counts.groups..', effects='..counts.effects)
end
for _,spec in ipairs({
    {"Slash_Leveled","h00R","A042"},{"Bleed_Leveled","h00R","A04C"},
    {"Moonstrike_Leveled","h010","A07F"},{"Moonblast_Leveled","h010","A07H"},
    {"Lunar_Assault_Leveled","h010","A07I"},{"Cascade_Leveled","h010","A07J"},
    {"Nourish_Leveled","h010","A07K"},{"Natural_Vigil_Leveled","h010","A07M"},
    {"Lifebloom_Leveled","h010","A07N"},{"ShovelStrikelevelup","h03Q","A086"},
}) do
    test(spec[1].." research/empty enumeration",function()
        event={kind="research",unit=unit("altar",owner)}
        local action=_G['Trig_'..spec[1]..'_Actions']; action(); clean()
        local right=unit(spec[2],owner);local wrongOwner=unit(spec[2],other);local wrongType=unit('other',owner)
        for _,u in ipairs({right,wrongOwner,wrongType}) do u.abilities[spec[3]]=1 end
        for _=1,100 do right.abilities[spec[3]]=1;action();check(right.abilities[spec[3]]==2,'research must increment once');clean() end
        check(wrongOwner.abilities[spec[3]]==1 and wrongType.abilities[spec[3]]==1,'research must respect owner/type')
    end)
end
for _,race in ipairs({'Human','Wisp','Centaur','Ogre','Kraken','Aethyr','Razormane'}) do
    test(race.." death query",function()
        local flag=unit('flag',owner);_G['udg_'..race..'Flag']=flag;event={unit=unit('builder',owner)}
        local predicate=_G['Trig_'..(race=='Aethyr' and 'Aethyr_Warp' or race)..'_Dies_Func001C']
        for _=1,100 do check(predicate(),'owned flag must remain visible');clean() end
        flag.owner=other;check(not predicate(),'foreign flag must remain excluded');clean()
    end)
end
for _,spec in ipairs({
    {'Sticky_Glue','n010',6,'target'}, {'Frenzy','h04L',2,'caster'},
    {'ConjureRefreshment','I021',nil,'target'}, {'TreeChopper_Detection','h060',nil,'tree'},
}) do
    test(spec[1]..' repeated casts',function()
        event={unit=unit('caster',owner,12,34),x=56,y=78}
        for _=1,100 do
            _G['Trig_'..spec[1]..'_Actions']()
            local u=created[#created];check(u.kind==spec[2] and u.duration==spec[3],'created object/lifetime unchanged')
            local x,y=56,78;if spec[4]=='caster' then x,y=12,34 elseif spec[4]=='tree' then x,y=80,90 end
            check(u.x==x and u.y==y,'created object at wrong point');clean()
        end
    end)
end
test('Soul Hammer drop restrictions',function()
    for _,raw in ipairs({'u00A','u007','u009','u00B','h03Q'}) do
        event={unit=unit(raw,owner,11,22),item={}}
        for _=1,100 do Trig_Soul_Hammer_Actions();check((event.unit.dropped~=nil)==(raw=='h03Q'),'wrong carrier restriction');clean() end
    end
end)
test('Mana Burn stun dummy cleanup',function()
    UNIT_STATE_MANA='mana'; UNIT_RF_MANA='mana'
    function GetUnitStateSwap(field,u) return u[field] end
    function BlzGetUnitRealField(u,field) return u[field] end
    function BlzSetUnitRealFieldBJ(u,field,value) u[field]=value end
    event={unit=unit('caster',owner),target=unit('target',other,45,67)}
    for _=1,100 do
        event.unit.mana=100;event.target.mana=45;Trig_Mana_Burn_Actions()
        local dummy=created[#created];check(dummy.duration==2 and dummy.target==event.target and dummy.order=='thunderbolt','stun behavior changed');clean()
    end
end)
test('all eight MiniMini families release spawn effects',function()
    for _,pair in ipairs({{'e00C','e00D'},{'e00G','e00F'},{'e00A','e00B'},{'e00N','e00P'},
        {'e009','e008'},{'e00J','e00K'},{'e00O','e00M'},{'e00H','e00I'}}) do
        event={unit=unit('victim',other,8,9),killer=unit(pair[1],owner)}
        for _=1,100 do Trig_MiniMinis_Actions();local u=created[#created];check(u.kind==pair[2] and u.owner==owner and u.x==8 and u.y==9,'wrong offspring');clean() end
    end
    event={unit=unit('victim',other),killer=nil};local before=#created;Trig_MiniMinis_Actions();check(#created==before,'environmental death spawned offspring');clean()
end)
test('regular AI selection and roaming cleanup',function()
    udg_Ancients={};udg_Moveto={}
    for i=1,6 do _G['gg_rct_Ping'..i]={x=i,y=i+1} end
    for i=1,10 do _G['gg_rct_AI_Move_'..i]={x=i+6,y=i+7} end
    local selector=unit('selector',other);selector.selector=true
    Trig_Select_Actions();check(udg_AncientUnit.kind=='O004' and udg_AncientUnit.x==20,'AI spawn draw/location changed');clean()
    for _=1,100 do orders={};Trig_Attack_Actions();check(#orders==1 and orders[1].x==1 and orders[1].y==2,'AI army order changed');clean() end
end)
test('Recall simultaneous, cancelled, dead and removed targets',function()
    InitTrig_RecallStart();InitTrig_Recall()
    local a,b=unit('nebula',owner),unit('nebula',owner)
    local x,y=unit('ally',owner,1,2),unit('ally',owner,3,4)
    emit('cast',a,'A0AL',x);emit('cast',b,'A0AL',y);emit('finish',a,'A0AL')
    check(x.x==99 and y.x==3,'first Recall teleported the other caster target');clean()
    emit('finish',b,'A0AL');check(y.x==99,'second Recall target lost');clean()
    x.x,y.x=1,3;emit('cast',a,'A0AL',x);emit('cast',b,'A0AL',y)
    emit('finish',b,'A0AL');check(y.x==99 and x.x==1,'reverse completion moved the first target early')
    emit('finish',a,'A0AL');check(x.x==99,'reverse completion lost the first target');clean()
    for _=1,100 do
        x.x,y.x=1,3;emit('cast',a,'A0AL',x);emit('cast',b,'A0AL',y)
        emit('endcast',a,'A0AL');emit('finish',a,'A0AL');emit('finish',b,'A0AL')
        check(x.x==1 and y.x==99,'cancelled Recall retained state or cleared another cast');clean()
    end
    emit('cast',a,'A0AL',x);x.removed=true;emit('finish',a,'A0AL');check(x.x==1,'removed target moved')
    x.removed=false;x.life=0;emit('cast',a,'A0AL',x);emit('finish',a,'A0AL');check(x.x==1,'dead target moved')
    x.life=100;emit('cast',a,'A0AL',x);emit('death',a);emit('finish',a,'A0AL');check(x.x==1,'dead caster retained Recall');clean()
    emit('cast',a,'A0AL',x);RemoveUnit(a);emit('finish',a,'A0AL');check(x.x==1,'scripted caster removal retained Recall');clean()
end)
test('Galactic Fury heals its finishing caster only',function()
    InitTrig_Galactic_Fury();InitTrig_Galactic_Fury_2()
    local a,b=unit('nebula',owner),unit('nebula',owner);a.life,b.life=30,40
    emit('effect',a,'A0F1');emit('effect',b,'A0F1');emit('finish',a,'A0F1')
    check(a.life==55 and b.life==40,'wrong Fury caster healed')
    emit('finish',b,'A0F1');check(b.life==65,'second Fury heal lost')
    a.life=0;emit('finish',a,'A0F1');check(a.life==0,'dead caster healed');clean()
end)
test('Time Warp cleanup, source and destination filters',function()
    local a=unit('nebula',owner,0,0);udg_AncientUnit=unit('other ancient',owner,2000,2000)
    local foe=unit('enemy',other,1000,1000);unit('ally',owner,1000,1000);unit('far enemy',other,5000,5000)
    event={unit=a,x=1000,y=1000}
    for _=1,100 do
        damage={};Trig_Time_warp_Actions()
        check(#damage==2 and damage[1].source==a and damage[1].radius==500 and damage[1].amount==300,'origin damage source/radius changed')
        check(damage[2].source==a and damage[2].target==foe and damage[2].amount==300,'destination damage/filter changed');clean()
    end
end)
test('Avatar recast and independent casters',function()
    local a,b=unit('soulreaper',owner),unit('soulreaper',other);a.abilities.A067=1;b.abilities.A067=1
    local function cast(u)
        local co=coroutine.create(Trig_Avatar_Actions);contexts[co]={unit=u}
        local ok,delay=coroutine.resume(co);assert(ok,delay);check(delay==10 and u.abilities.A067==2,'Avatar start/duration changed');clean();return co
    end
    local function finish(co) local ok,err=coroutine.resume(co);assert(ok,err);contexts[co]=nil end
    local old=cast(a);local independent=cast(b);local new=cast(a)
    finish(old);check(a.abilities.A067==2,'old Avatar ended newer cast')
    finish(independent);check(b.abilities.A067==1 and a.abilities.A067==2,'independent Avatar affected other caster')
    finish(new);check(a.abilities.A067==1,'latest Avatar did not expire')
    local removed=cast(a);a.removed=true;finish(removed);clean()
end)
test('Chemical Rage recast, corpse expiry and original attack cooldown',function()
    UNIT_WEAPON_RF_ATTACK_BASE_COOLDOWN='cooldown'
    function BlzGetUnitWeaponRealField(u,field) return u[field] end
    function BlzSetUnitWeaponRealField(u,field,index,value) assert(not u.removed);u[field]=value end
    local a,b=unit('ratling',owner),unit('ratling',other);a.cooldown,b.cooldown=1.75,2.25
    local function cast(u)
        local co=coroutine.create(ChemicalRageActions);contexts[co]={unit=u}
        local ok,delay=coroutine.resume(co);assert(ok,delay);check(delay==20 and u.cooldown==1.25,'rage duration/rate changed');return co
    end
    local function finish(co) local ok,err=coroutine.resume(co);assert(ok,err);contexts[co]=nil end
    local old=cast(a);local independent=cast(b);local new=cast(a)
    finish(old);check(a.cooldown==1.25,'old rage ended newer cast')
    b.life=0;finish(independent);check(b.cooldown==2.25,'rage expired on corpse without restoring original attack rate')
    finish(new);check(a.cooldown==1.75,'rage did not restore baseline after recast')
    local removed=cast(a);a.removed=true;finish(removed)
    for _,dummy in ipairs(created) do check(dummy.removed,'rage dummy not removed') end
    clean()
end)
for _,spec in ipairs({{'Blur','A0AS',1},{'Surge_of_Darkness','A079',5}}) do
    test(spec[1]..' recast and separate casters',function()
        UNIT_STATE_MAX_MANA='maxMana'
        function GetUnitStateSwap(field,u) return u[field] end
        local a,b=unit('caster',owner),unit('caster',other);a.maxMana,b.maxMana=1000,1000
        local function cast(u)
            local co=coroutine.create(_G['Trig_'..spec[1]..'_Actions']);contexts[co]={unit=u}
            local ok,delay=coroutine.resume(co);assert(ok,delay);check(delay==spec[3] and u.abilities[spec[2]]==1,'buff start/duration changed');return co
        end
        local function finish(co) local ok,err=coroutine.resume(co);assert(ok,err);contexts[co]=nil end
        local old=cast(a);local independent=cast(b);local new=cast(a)
        finish(old);check(a.abilities[spec[2]]==1,'old cast removed newer buff')
        finish(independent);check(not b.abilities[spec[2]] and a.abilities[spec[2]]==1,'other caster affected')
        finish(new);check(not a.abilities[spec[2]],'latest buff did not end')
        local removed=cast(a);a.removed=true;finish(removed);clean()
    end)
end
test('Conjure Mana recasts retain the latest damage bonus',function()
    UNIT_STATE_MANA='mana'
    function R2I(v) return math.modf(v) end
    function BlzSetUnitBaseDamage(u,v) assert(not u.removed);u.damage=v end
    function SetUnitManaBJ(u,v) assert(not u.removed);u.mana=v end
    local a,b=unit('dancer',owner),unit('dancer',other);a.mana,b.mana=100,80
    local function cast(u)
        local co=coroutine.create(Trig_ConjureMana_Actions);contexts[co]={unit=u}
        local ok,delay=coroutine.resume(co);assert(ok,delay);check(delay==1,'mana charge delay changed');return co
    end
    local function advance(co,expected)
        local ok,delay=coroutine.resume(co);assert(ok,delay);check(delay==expected,'damage bonus duration changed')
        if coroutine.status(co)=='dead' then contexts[co]=nil end
    end
    local old=cast(a);advance(old,60);check(a.damage==299 and a.mana==50,'initial damage/mana formula changed')
    local new=cast(a);advance(new,60);check(a.damage==249 and a.mana==25,'recast damage/mana formula changed')
    local independent=cast(b);advance(independent,60)
    advance(old,nil);check(a.damage==249,'old cast reset newer damage bonus')
    advance(independent,nil);check(b.damage==199 and a.damage==249,'other caster expiry affected bonus')
    advance(new,nil);check(a.damage==199,'latest damage bonus did not end')
    local removed=cast(a);a.removed=true;advance(removed,60);advance(removed,nil);clean()
end)
test('Realm of Darkness overlap and ownership-change cleanup',function()
    gg_trg_Realm_of_darkness_2={disabled=true}
    local enemy=unit('enemy',other);local friendly=unit('ally',owner)
    local function cast()
        local co=coroutine.create(Trig_Realm_of_darkness_Actions)
        local ok,delay=coroutine.resume(co);assert(ok,delay);check(delay==60 and enemy.abilities.A0B6==1 and not friendly.abilities.A0B6,'darkness targeting/duration changed');return co
    end
    local function finish(co) local ok,err=coroutine.resume(co);assert(ok,err) end
    for _=1,100 do
        enemy.owner=other
        local old=cast();local new=cast()
        local entering=unit('entering',other);event={unit=entering};Trig_Realm_of_darkness_2_Actions()
        local removed=unit('removed',other);event={unit=removed};Trig_Realm_of_darkness_2_Actions();RemoveUnit(removed)
        enemy.owner=owner
        finish(old);check(enemy.abilities.A0B6==1 and entering.abilities.A0B6==1 and not gg_trg_Realm_of_darkness_2.disabled,'old darkness prematurely ended newer cast')
        finish(new);check(not enemy.abilities.A0B6 and not entering.abilities.A0B6 and gg_trg_Realm_of_darkness_2.disabled,'darkness retained targets after ownership changes');clean()
    end
    event={unit=friendly};Trig_Realm_of_darkness_2_Actions();check(not friendly.abilities.A0B6,'inactive darkness applied a debuff')
end)
if #failures>0 then for _,f in ipairs(failures) do io.stderr:write(f,'\n') end;error(#failures..' / '..scenarios..' poke scenarios failed') end
print('Poke regressions: '..checks..' assertions across '..scenarios..' scenarios passed')
