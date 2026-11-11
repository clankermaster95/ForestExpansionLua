-- Focused state/event tests for the intentional gameplay patch. Native combat,
-- command cards, AI autocast and engine crash behavior still need live testing.
local checks, now, event = 0, 0, {}
local players, units, timers, messages = {}, {}, {}, {}
local function check(value, message) assert(value, message); checks=checks+1 end
local function eq(actual, expected, message) check(math.abs(actual-expected)<0.001, message..': '..tostring(actual)..' ~= '..tostring(expected)) end
function FourCC(s) return s end
function Player(id)
    if not players[id] then players[id]={id=id,playing=true,gold=100,lumber=100,tech={},allies={}} end
    return players[id]
end
function GetPlayerId(p) return p.id end
function GetConvertedPlayerId(p) return p.id+1 end
function GetPlayerName(p) return 'Player '..(p.id+1) end
function GetPlayerSlotState(p) return p.playing and 'playing' or 'left' end
function GetPlayerController() return 'user' end
function GetPlayerState(p,s) return p[s] end
function SetPlayerState(p,s,n) p[s]=n end
function AdjustPlayerStateBJ(n,p,s) p[s]=p[s]+n end
function GetPlayerTechCount(p,id) return p.tech[id] or 0 end
function SetPlayerTechResearched(p,id,n) p.tech[id]=n end
function SetPlayerTechMaxAllowed(p,id,n) p.limits=p.limits or {};p.limits[id]=n end
function SetPlayerTechMaxAllowedSwap(id,n,p) SetPlayerTechMaxAllowed(p,id,n) end
function GetPlayerAlliance(a,b) return a==b or a.allies[b]==true end
function SetPlayerAlliance(a,b,kind,value) if kind=='passive' then a.allies[b]=value end end
function IsUnitAlly(u,p) return GetPlayerAlliance(u.owner,p) end
function IsUnitEnemy(u,p) return not IsUnitAlly(u,p) end
function GetOwningPlayer(u) return u.owner end
function SetUnitOwner(u,p) u.owner=p end
function CreateUnit(p,raw,x,y)
    local u={owner=p,raw=raw,x=x or 0,y=y or 0,life=1000,maxhp=1000,abilities={},buffExpires={},damage=0,armorFactor=1,magicFactor=1}
    units[#units+1]=u;return u
end
function GetUnitTypeId(u) return u and not u.removed and u.raw or 0 end
function GetUnitX(u) return u.x end
function GetUnitY(u) return u.y end
function GetWidgetLife(u) return u.life end
function SetWidgetLife(u,n) u.life=math.min(n,u.maxhp) end
local nativeLife=SetWidgetLife
function SetUnitState(u,state,n) if state=='life' then SetWidgetLife(u,n) else u[state]=n end end
function GetUnitState(u,state) return state=='life' and u.life or u[state] end
function BlzGetUnitMaxHP(u) return u.maxhp end
function IsUnitType(u,kind) return u[kind] or false end
function RemoveUnit(u) u.removed=true end
function UnitAddAbility(u,id) u.abilities[id]=1;return true end
function UnitRemoveAbility(u,id) u.abilities[id]=nil end
function GetUnitAbilityLevel(u,id)
    if u.buffExpires[id] and u.buffExpires[id]<=now then u.abilities[id]=nil end
    return u.abilities[id] or 0
end
function SetUnitAbilityLevel(u,id,n) u.abilities[id]=n end
function UnitMakeAbilityPermanent() end
function BlzUnitHideAbility(u,id,hide) u.hidden=u.hidden or {};u.hidden[id]=hide end
function GetUnitLevel() return 10 end
function GetHandleId(v) return v end
function OrderId(s) return s end
function GetTriggerUnit() return event.unit end
function GetTriggerPlayer() return event.player end
function GetIssuedOrderId() return event.order end
function GetOrderTargetUnit() return event.target end
function GetEventPlayerChatString() return event.chat end
function GetSpellAbilityUnit() return event.unit end
function GetSpellAbilityId() return event.spell end
function CreateGroup() return {} end
function DestroyGroup() end
function FirstOfGroup(g) return g[1] end
function GroupRemoveUnit(g,u) for i,v in ipairs(g) do if v==u then table.remove(g,i);return end end end
function GroupEnumUnitsOfPlayer(g,p)
    for _,u in ipairs(units) do if not u.removed and u.owner==p then g[#g+1]=u end end
end
function GroupEnumUnitsInRange(g,x,y,r)
    for _,u in ipairs(units) do if not u.removed and (u.x-x)^2+(u.y-y)^2<=r*r then g[#g+1]=u end end
end
function CreateTimer() local t={id=#timers+1};timers[#timers+1]=t;return t end
function TimerStart(t,delay,repeats,fn) t.due=now+delay;t.period=repeats and delay or nil;t.fn=fn;t.paused=false end
function PauseTimer(t) t.paused=true end
function DestroyTimer(t) t.dead=true end
local function advance(dt)
    local untilTime=now+dt
    while true do
        local nextTimer
        for _,t in ipairs(timers) do
            if not t.dead and not t.paused and t.due and t.due<=untilTime+0.000001 and
                (not nextTimer or t.due<nextTimer.due) then nextTimer=t end
        end
        if not nextTimer then break end
        now=nextTimer.due
        if nextTimer.period then nextTimer.due=nextTimer.due+nextTimer.period else nextTimer.due=nil end
        nextTimer.fn()
    end
    now=untilTime
end
function UnitApplyTimedLife(u,_,seconds) local t=CreateTimer();TimerStart(t,seconds,false,function() RemoveUnit(u);DestroyTimer(t) end) end
function IssueTargetOrder(u,_,target)
    local raw=u.abilities.AFBL and 'AFBL' or 'AFPB'
    local buff=raw=='AFBL' and 'B015' or 'B03M'
    target.abilities[buff]=u.abilities[raw]
    target.buffExpires[buff]=now+(raw=='AFBL' and 3.1 or 4.1)
end
function IssuePointOrder(u,order,x,y) u.order={order,x,y} end
function GetRandomReal() return 0 end
function DisplayTextToForce(_,text) messages[#messages+1]=text end
function DisplayTimedTextToForce(_,_,text) messages[#messages+1]=text end
function DisplayTextToPlayer(_,_,_,text) messages[#messages+1]=text end
function GetPlayersAll() return players end
function CreateForce() return {} end
function ForceClear() end
function ForceAddPlayer() end
function CustomVictoryBJ(p) p.won=true end
function CustomDefeatBJ(p) p.lost=true end
function CreateTrigger() return {actions={}} end
function TriggerAddAction(t,action) t.actions[#t.actions+1]=action end
function TriggerAddCondition() end
function Condition(fn) return fn end
function DisableTrigger(t) if t then t.disabled=true end end
function h__TriggerRegisterVariableEvent() end
function TriggerRegisterAnyUnitEventBJ() end
function TriggerRegisterPlayerChatEvent() end
function TriggerRegisterEnterRegion() end
function CreateRegion() return {} end
function RegionAddRect() end
function GetPlayableMapRect() return {} end
function I2S(n) return tostring(n) end
function I2R(n) return n end
function PlayThematicMusicBJ() end
function AddUnitToStockBJ(raw,shop,n,maximum) shop.stock[raw]=n;shop.maximum=shop.maximum or {};shop.maximum[raw]=maximum end
function RemoveUnitFromStock(shop,raw) shop.stock[raw]=nil;shop.maximum[raw]=nil end
function GetEnumPlayer() return event.player end
PLAYER_SLOT_STATE_PLAYING='playing';MAP_CONTROL_USER='user';MAP_CONTROL_COMPUTER='computer'
PLAYER_STATE_RESOURCE_GOLD='gold';PLAYER_STATE_RESOURCE_LUMBER='lumber'
UNIT_TYPE_STRUCTURE='structure';UNIT_TYPE_MAGIC_IMMUNE='immune';UNIT_TYPE_ANCIENT='ancient';UNIT_TYPE_MECHANICAL='mechanical';UNIT_STATE_LIFE='life'
ATTACK_TYPE_NORMAL='normal';DAMAGE_TYPE_UNIVERSAL='pure';DAMAGE_TYPE_MAGIC='magic';DAMAGE_TYPE_POISON='poison';DAMAGE_TYPE_SLOW_POISON='slowpoison';DAMAGE_TYPE_ENHANCED='enhanced';WEAPON_TYPE_WHOKNOWS='weapon';ALLIANCE_PASSIVE='passive'
dofile('src/runtime.lua')
for _,path in ipairs({'players/roles','players/roster','players/participation','combat/common','races/cultist','ancients/avalanche','ancients/divinity','ancients/zalxon','races/wildkin','economy/income','game/selection','game/startup','game/victory'}) do dofile('src/'..path..'.lua') end
udg_AncientPlayer=Player(6);udg_Selectors='ewsp';udg_Flags={};udg_SeedOfRebirth=setmetatable({},{__index=function()return 0 end})
FE_Roster.initialize()
for slot=0,10 do udg_Flags[slot+1]=false end
local depth=0
function UnitDamageTarget(source,target,amount,attack,_,attackType,damageType)
    local oldType=udg_DamageEventType
    udg_DamageEventType=udg_NextDamageType or 0;udg_NextDamageType=0
    local old={udg_DamageEventSource,udg_DamageEventTarget,udg_DamageEventAmount,udg_IsDamageAttack,udg_DamageEventAttackT,udg_DamageEventDamageT,s__Damage_index}
    depth=depth+1;s__Damage_index=depth
    udg_DamageEventSource,udg_DamageEventTarget,udg_DamageEventAmount,udg_IsDamageAttack=source,target,amount,attack
    udg_DamageEventAttackT,udg_DamageEventDamageT=attackType,damageType
    FE_Ice.beforeDamage();FE_Cultist.beforeDamage()
    if udg_DamageEventDamageT~='pure' then
        udg_DamageEventAmount=udg_DamageEventAmount*(attack and target.armorFactor or target.magicFactor)
    end
    FE_Combat.attackLanded();FE_Combat.limitPoison();FE_Ice.onDamage()
    target.life=target.life-udg_DamageEventAmount;target.damage=target.damage+udg_DamageEventAmount
    FE_Cultist.afterDamage()
    udg_DamageEventSource,udg_DamageEventTarget,udg_DamageEventAmount,udg_IsDamageAttack,udg_DamageEventAttackT,udg_DamageEventDamageT,s__Damage_index=table.unpack(old)
    depth=depth-1
    udg_DamageEventType=oldType
end
local function hit(source,target,amount) UnitDamageTarget(source,target,amount,true,false,'normal','physical') end
local function order(unit,id,target) event={unit=unit,order=id,target=target};FE_Cultist.onOrder() end

-- Visibility, banning and the real prerequisite unlock are separate states.
for _,kind in ipairs({'expanders','ancients'}) do for _,entry in ipairs(FE_Factions[kind]) do
    _G[entry.ban]=0;_G[entry.shop]=_G[entry.shop] or {stock={}}
end end
udg_Bans=2
FE_Test={initialized=true,player=Player(0)}
FE_Factions.showStock()
check(gg_unit_n00G_0035.stock.h063==0 and gg_unit_n00G_0035.maximum.h063==0,'Cultist visible but cannot be bought or restock during bans')
check(GetPlayerTechCount(Player(0),'RFPK')==0,'picking locked during bans')
FE_Factions.ban('Cultist');check(gg_unit_n00G_0035.stock.h063==nil,'ban removes visible stock')
FE_Factions.unlockPicking();check(GetPlayerTechCount(Player(10),'RFPK')==1,'all slots unlock')
FE_Factions.ban('Worgen');check(udg_BannedWorgen==0 and udg_Bans==1,'late bans rejected')
FE_Test=nil

-- Wildkin restores every learned spell and leaves missing abilities missing.
local wildkin=CreateUnit(Player(1),'h010');wildkin.abilities={A07F=1,A07H=1,A07I=1}
Player(1).tech.R051=4;FE_Wildkin.restoreResearch(wildkin)
check(wildkin.abilities.A07F==5 and wildkin.abilities.A07I==5 and wildkin.abilities.A07N==nil,'Wildkin research survives rebirth')
local oldGold=Player(6).gold
check(not FE_Income.bringItOn(Player(1)),'non-Red rejected')
check(FE_Income.bringItOn(Player(0)) and not FE_Income.bringItOn(Player(0)),'bringiton only doubles once')
Trig_Ancient_Gold_income_Actions();eq(Player(6).gold-oldGold,20,'Ancient income doubled')

-- Claimed units and pre-existing units survive the old 60-second deadline.
local leaver,taker=Player(2),Player(3)
local building=CreateUnit(leaver,'tower');local survivor=CreateUnit(taker,'lackey')
CreateUnit(leaver,'h063').ancient=true
leaver.tech.R051=4;taker.tech.R051=2
leaver.playing=false;FE_Takeover.begin(leaver);FE_Roster.defeat(taker)
advance(59);check(not building.removed,'leaver army survives 59 seconds')
check(FE_Takeover.claim(taker,2),'dead player can take over')
advance(2);check(building.owner==taker and not building.removed and not survivor.removed,'expiry canceled without deleting either army')
check(taker.tech.R051==4 and FE_Roster.isAlive(taker),'research and expander membership transferred')
local living=Player(4);local another=Player(5);another.playing=false
local abandoned=CreateUnit(another,'tower');FE_Takeover.begin(another)
CreateUnit(another,'h063').ancient=true
check(not FE_Takeover.claim(living,5),'living picked player cannot take over')
local token=CreateUnit(living,'ewsp');check(FE_Takeover.claim(living,5),'unpicked player can take over')
check(token.removed,'takeover cannot retain a second race-picking token')
local expiring=Player(7);expiring.playing=false;local expired=CreateUnit(expiring,'tower');FE_Takeover.begin(expiring)
CreateUnit(expiring,'h063').ancient=true
check(not Trig_Extermination_Conditions(),'pending army prevents premature victory')
advance(60);check(expired.removed and not FE_Takeover.pending[7],'unclaimed army removed at deadline')
local ancient=Player(6);ancient.playing=false;udg_AncientUnit=CreateUnit(ancient,'O004')
FE_Takeover.begin(ancient);advance(59);check(not Player(0).won,'Ancient gets full 60 seconds')
FE_Roster.defeat(Player(8));check(FE_Takeover.claim(Player(8),6),'Ancient can be taken over')
advance(1);check(FE_Roles.ancient()==Player(8) and not Player(0).won,'Ancient role changes and victory is canceled')
local deadLeaver=Player(10);deadLeaver.playing=false
local deadBuilder=CreateUnit(deadLeaver,'h063');deadBuilder.ancient=true
FE_Takeover.begin(deadLeaver);deadBuilder.life=0;FE_Roster.defeat(Player(9))
check(not FE_Takeover.claim(Player(9),10),'dead builder cannot be revived by taking over its buildings')
check(not FE_Takeover.hasPendingExpander(),'dead builder cannot indefinitely hold the win condition')
event={player=Player(0)};Trig_LimitedTraining_Func002A();check(Player(0).limits.H064==1,'native limit includes queued Amalgamations')

-- On-hit effects: no attack-start stack, independent debuffs, refresh, nonlethal.
local attacker=CreateUnit(Player(0),'o026',5000,5000);local victim=CreateUnit(Player(9),'target',5000,5000)
attacker.owner.tech.R06R=1
FE_Combat.applyDot(attacker,victim,'poison',1);FE_Combat.applyDot(attacker,victim,'poison',1)
check(FE_Combat.dotByTarget[victim].poison.level==2,'poison increases per hit')
for i=1,10 do FE_Combat.applyDot(attacker,victim,'poison',1) end
check(FE_Combat.dotByTarget[victim].poison.level==6,'poison capped at six stacks')
FE_Combat.applyDot(attacker,victim,'bleed',3)
for i=1,4 do FE_Combat.tickDots() end
eq(victim.damage,275,'poison and bleed deal independent damage')
UnitRemoveAbility(victim,'B03M');FE_Combat.tickDots()
check(FE_Combat.dotByTarget[victim].poison and FE_Combat.dotByTarget[victim].bleed,'dispel cannot stop poison or bleed')
for i=1,11 do FE_Combat.tickDots() end
check(FE_Combat.dotByTarget[victim]==nil,'expired DoT releases unit references')
eq(victim.life,2,'poison damage over time retains its nonlethal floor')

-- Cultist strongest aura, allied range, self cost and pure attack conversion.
local cultist=CreateUnit(Player(0),'h063',10000,10000);local ally=CreateUnit(Player(0),'ally',10500,10000)
local enemy=CreateUnit(Player(9),'enemy',10020,10000)
cultist.owner.tech.RFCA=1;cultist.owner.tech.RFCS=1;cultist.owner.tech.RFCB=1
UnitAddAbility(cultist,'A0EI')
FE_Cultist.track(cultist)
check(cultist.hidden.A0EI and GetUnitAbilityLevel(cultist,'A0EI')==1,'resistance icon hidden without removing its effect')
cultist.life=500;FE_Cultist.tick()
check(ally.abilities.AFAS==5 and cultist.abilities.AFAS==5 and enemy.abilities.AFAS==nil,'aura allies only, including self')
local second=CreateUnit(Player(0),'h063',10000,10000);second.life=800;FE_Cultist.track(second);FE_Cultist.tick()
check(ally.abilities.AFAS==5,'auras use strongest instead of stacking')
cultist.x=20000;FE_Cultist.tick();check(ally.abilities.AFAS==2,'weaker aura remains after strong source leaves')
second.life=0;FE_Cultist.tick();check(ally.abilities.AFAS==nil,'last aura source death cleans buff')
cultist.x=10000;ally.x=10200;ally.life=500;cultist.life=500
order(cultist,'immolation');FE_Cultist.ticks=3;FE_Cultist.tick()
eq(ally.life,550,'Bloody Sacrifice heals allies');eq(cultist.life,400,'Bloody Sacrifice charges self without healing self')
order(cultist,'unimmolation');FE_Cultist.ticks=3;FE_Cultist.tick();eq(cultist.life,400,'toggle off stops self damage')
enemy.armorFactor=0.2;enemy.magicFactor=0.5;enemy.life=1000;enemy.damage=0
order(cultist,'flamingarrows');hit(cultist,enemy,100)
eq(enemy.damage,100,'Chaotic Burst bypasses armor');eq(cultist.life,384,'Chaotic Burst costs four percent current HP')
hit(cultist,enemy,0);eq(cultist.life,384,'missed/zero hit has no HP cost')
order(cultist,'unflamingarrows');hit(cultist,enemy,100);eq(enemy.damage,120,'ordinary attack uses armor after autocast off')
order(cultist,'flamingarrowstarg',enemy);hit(cultist,enemy,100);eq(enemy.damage,220,'manual empowered attack works')
hit(cultist,enemy,100);eq(enemy.damage,240,'manual attack only empowers one hit')
FE_Cultist.empowered[1]=cultist
local beforeStale=cultist.life
hit(cultist,enemy,100);eq(cultist.life,beforeStale,'recycled damage index cannot charge a stale empowered attack')

-- Ice rejects scripted heals, tracks native healing after damage, follows the
-- caster and releases targets immediately on expiry/death. Two casts coexist.
FE_Ice.init()
local ice=CreateUnit(Player(8),'O008',30000,30000);ice.maxhp=20000;ice.life=10000
local frozen=CreateUnit(Player(9),'enemy',31000,30000);frozen.life=500
local friendly=CreateUnit(Player(8),'ally',31000,30000);friendly.life=500
FE_Ice.start(ice);eq(ice.life,6000,'Sadism retains 40 percent initial HP cost')
check(frozen.abilities.AFIS==1 and friendly.abilities.AFIS==nil,'Ice slows enemies only')
SetWidgetLife(frozen,700);eq(frozen.life,500,'scripted widget heal blocked')
SetUnitState(frozen,UNIT_STATE_LIFE,700);eq(frozen.life,500,'scripted unit-state heal blocked')
SetWidgetLife(friendly,700);eq(friendly.life,700,'allies can still heal')
nativeLife(frozen,800);advance(0.03125);eq(frozen.life,500,'native healing removed next frame')
UnitDamageTarget(ice,frozen,100,false,false,'normal','magic');nativeLife(frozen,550)
advance(0.03125);eq(frozen.life,400,'damage plus native heal cannot hide healing')
nativeLife(frozen,550);UnitDamageTarget(ice,frozen,100,false,false,'normal','magic')
eq(frozen.life,300,'native heal capped before a subsequent hit')
frozen.x=40000;advance(0.03125);SetWidgetLife(frozen,700)
eq(frozen.life,700,'leaving radius restores healing');check(frozen.abilities.AFIS==nil,'leaving radius clears slow')
advance(25-0.09375);eq(ice.life,16000,'Sadism heals exactly 25 times for 400')
check(#FE_Ice.casts==0,'Sadism expires after 25 seconds')
FE_Ice.start(ice);frozen.x=31000;advance(0.03125);ice.life=0;advance(0.03125)
check(frozen.abilities.AFIS==nil and FE_Ice.health[frozen]==nil,'caster death releases enemy effects')
ice.life=10000
local iceTwo=CreateUnit(Player(8),'O008',30000,30000);iceTwo.life=1000
FE_Ice.start(ice);FE_Ice.start(iceTwo);advance(0.03125);ice.life=0;advance(0.03125)
check(frozen.abilities.AFIS==1,'second Ice keeps anti-heal active after first caster dies')
iceTwo.life=0;advance(0.03125);check(frozen.abilities.AFIS==nil,'final Ice death removes shared effect')

-- Vanguard uses a hidden item armor ability, which buff dispel does not remove.
local light=CreateUnit(Player(8),'O01V',50000,50000);light.life=100;light.maxhp=2000;light.abilities.A06U=2
FE_Light.vanguardCast(light);check(light.abilities.AFVA==2,'Vanguard grants armor')
UnitRemoveAbility(light,'B029');advance(3);check(light.abilities.AFVA==2,'dispel does not end armor')
FE_Light.vanguardCast(light);advance(3);check(light.abilities.AFVA==2,'recast old timer cannot remove new armor')
advance(3);check(light.abilities.AFVA==nil,'Vanguard armor removed after six seconds')
light.abilities.A06W=1;local nukeTarget=CreateUnit(Player(9),'enemy',50030,50000);nukeTarget.maxhp=10000;nukeTarget.life=10000
FE_Light.nukeCast(light);hit(light,nukeTarget,100);advance(5)
eq(nukeTarget.damage,600,'Nuke AoE and ordinary attack both deal damage')

-- Lightning does not use a nested native event target or a level-zero spell.
function BlzGetEventDamageTarget() error('native damage context must not be read by Thunderstruck') end
local lightning=CreateUnit(Player(8),'O016',60000,60000);local foe=CreateUnit(Player(9),'enemy',60100,60000)
udg_DamageEventTarget,udg_DamageEventSource=lightning,foe
local before=#units;Trig_Thunderstruck_Actions();check(#units==before,'unlearned Lightning Strike creates no dummy')
lightning.abilities.A03S=7;Trig_Thunderstruck_Actions()
local dummy=units[#units];check(dummy.raw=='hFDM' and dummy.owner==lightning.owner and dummy.abilities.AFLT==7,'Lightning uses safe owner and bounded spell level')
advance(3);check(dummy.removed,'Lightning dummy expires')
print('gameplay patch: '..checks..' assertions passed')
