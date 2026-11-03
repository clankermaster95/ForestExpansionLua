-- Controlled event/coroutine regression double; no live engine claim.
local checks=0
local function check(value,message) assert(value,message); checks=checks+1 end
local players, timers, dialogs, queue, event, now, expired = {}, {}, {}, {}, {}, 0, nil
local enumUnit,enumPlayer,filterUnit,localSlot=nil,nil,nil,6
local nextId=0
function FourCC(s) return s end
function GetBooleanOr(a,b) return a or b end
function Player(i)
    if not players[i] then players[i]={id=i,playing=false,controller='human',name='Test'..i..'#123',units={},gold=500,lumber=300,allies={}} end
    return players[i]
end
function GetPlayerId(p) return p.id end
function GetConvertedPlayerId(p) return p.id+1 end
function GetPlayerSlotState(p) return p.playing and 'playing' or 'empty' end
function GetPlayerController(p) return p.controller end
function GetPlayerName(p) return p.name end
function GetLocalPlayer() return Player(localSlot) end
function GetTriggerPlayer() return event.player end
function GetTriggerUnit() return event.unit end
function GetDyingUnit() error('spell must not read a dying-unit response') end
function GetAttacker() return event.attacker end
function GetSpellAbilityUnit() return event.caster end
function GetSpellTargetUnit() return event.target end
function GetSummonedUnit() return event.summoned end
function GetBuyingUnit() return event.buyer end
function KillUnit(u) assert(u,'no stale summon event');u.life=0 end
function GetKillingUnitBJ() return event.killer end
function GetUnitTypeId(u) return u and not u.removed and u.kind or 0 end
function GetWidgetLife(u) return u.life end
function GetOwningPlayer(u) return u.owner end
function GetUnitX(u) return u.x end
function GetUnitY(u) return u.y end
function CreateUnit(p,kind,x,y)
    local u={owner=p,kind=kind,x=x or 0,y=y or 0,life=100,maxmana=100,mana=100,abilities={},index=123,ancient=true}
    p.units[#p.units+1]=u; return u
end
function RemoveUnit(u) u.removed=true end
function SetUnitUserData() error('spell overwrote unit index') end
function IncUnitAbilityLevel(u,raw) u.abilities[raw]=(u.abilities[raw] or 1)+1 end
function DecUnitAbilityLevel(u,raw) u.abilities[raw]=u.abilities[raw]-1 end
function UnitAddAbilityBJ(raw,u) u.abilities[raw]=1 end
function UnitRemoveAbilityBJ(raw,u) u.abilities[raw]=nil end
function UnitRemoveBuffBJ(raw,u) u.abilities[raw]=nil end
function SetUnitLifePercentBJ(u,v) u.life=v end
function GetUnitLifePercent(u) return u.life end
function GetUnitState(u,s) return u[s] end
function GetUnitStateSwap(s,u) return u[s] end
function SetUnitState(u,s,v) u[s]=v end
function SetUnitManaBJ(u,v) u.mana=v end
function SetUnitLifeBJ(u,v) u.life=v end
function BlzGetUnitMaxMana(u) return u.maxmana end
function BlzSetUnitMaxMana(u,n) u.maxmana=n; u.mana=math.min(u.mana,n) end
function BlzSetUnitBaseDamage(u,n) u.damage=n end
function SetPlayerStateBJ(p,s,n) p[s]=n end
function CreateForce() return {} end
function ForceClear(f) for k in pairs(f) do f[k]=nil end end
function ForceAddPlayer(f,p) f[p]=true end
function GetPlayersAll() local f={}; for i=0,10 do f[Player(i)]=true end; return f end
function ForForce(f,action) for i=0,10 do if f[Player(i)] then enumPlayer=Player(i); action() end end end
function GetEnumPlayer() return enumPlayer end
function GetPlayersAllies(p) local f={}; for i=0,10 do if IsPlayerAlly(Player(i),p) then f[Player(i)]=true end end; return f end
function DestroyForce(f) f.destroyed=true end
function SetPlayerAllianceStateBJ(a,b,state) a.allies[b]=state=='allied' end
function IsPlayerAlly(a,b) return a==b or a.allies[b]==true end
function IsUnitEnemy(u,p) return not IsPlayerAlly(u.owner,p) end
function IsUnitType(u,t) return (t=='ancient' and u.ancient) or (t=='structure' and u.structure) or false end
function CreateGroup() return {} end
function GetUnitsOfPlayerAll(p) local g=CreateGroup(); GroupEnumUnitsOfPlayer(g,p); return g end
function GroupEnumUnitsOfPlayer(g,p)
    for k in pairs(g) do g[k]=nil end
    for _,u in ipairs(p.units) do if not u.removed then g[#g+1]=u end end
end
function ForGroupBJ(g,action) for _,u in ipairs(g) do enumUnit=u; action() end end
function GetEnumUnit() return enumUnit end
function GetFilterUnit() return filterUnit end
function DestroyGroup(g) g.destroyed=true end
function FirstOfGroup(g) return g[1] end
function GroupRemoveUnit(g,u) for i,v in ipairs(g) do if v==u then table.remove(g,i); return end end end
function GroupAddUnit(g,u) g[#g+1]=u end
function CountUnitsInGroup(g) return #g end
function GroupPickRandomUnit(g) return g[1] end
function GetUnitLoc(u) return {x=u.x,y=u.y} end
function GetLocationX(l) return l.x end
function GetLocationY(l) return l.y end
function RemoveLocation(l) l.removed=true end
function AddSpecialEffect() return {} end
function DestroyEffect() end
function DisplayTextToForce() end
function DisplayTextToPlayer() end
function IssueImmediateOrderBJ(u,order) u.order=order end
function I2S(i) return tostring(i) end
function I2R(i) return i end
function R2I(n) return n<0 and math.ceil(n) or math.floor(n) end
function StringLength(s) return #s end
function SubString(s,a,b) return s:sub(a+1,b) end
function DialogDisplayBJ(shown,dialog,p) p.dialog=shown end
function BlzGetTriggerSyncData() return event.data end
local preload
function PreloadGenClear() end
function PreloadGenStart() end
function Preload(s) preload=s end
function PreloadGenEnd() end
function Preloader() end
function CreateTimer() nextId=nextId+1; local t={id=nextId}; timers[#timers+1]=t; return t end
function TimerStart(t,d,periodic,f)
    t.started=now; t.callback=f
    if f then queue[#queue+1]={time=now+d,timer=t,callback=f} end
end
function GetHandleId(t) return t.id end
function GetExpiredTimer() return expired end
function TimerGetElapsed(t) return now-t.started end
function DestroyTimer(t) t.destroyed=true end
function PauseTimer(t) t.paused=true end
function CreateTimerDialog(t) local d={timer=t}; dialogs[#dialogs+1]=d; bj_lastCreatedTimerDialog=d; return d end
function TimerDialogSetTitle(d,s) d.title=s end
function TimerDialogDisplay(d,b) d.visible=b end
function DestroyTimerDialog(d) check(not d.destroyed,'dialog destroyed only once'); d.destroyed=true end
DestroyTimerDialogBJ=DestroyTimerDialog
function StartTimerBJ(t,_,duration) TimerStart(t,duration,false,nil); bj_lastStartedTimer=t end
function GetLastCreatedTimerBJ() return bj_lastStartedTimer end
function CreateTimerDialogBJ(t,s) local d=CreateTimerDialog(t); d.title=s end
function GetLastCreatedTimerDialogBJ() return bj_lastCreatedTimerDialog end
function TriggerSleepAction(d) return coroutine.yield(d) end
local function resume(co,context)
    local old=event; event=context
    local ok,delay=coroutine.resume(co); event=old; assert(ok,delay)
    if coroutine.status(co)~='dead' then
        -- GetTriggerUnit survives waits; spell-target/caster/attacker responses do not.
        local stable={unit=context.unit,player=context.player}
        queue[#queue+1]={time=now+delay,callback=function() resume(co,stable) end}
    end
end
local function start(action,context) resume(coroutine.create(action),context or {}) end
local function advance(delta)
    local untilTime=now+delta
    while true do
        local pos
        for i,j in ipairs(queue) do if j.time<=untilTime and (not pos or j.time<queue[pos].time) then pos=i end end
        if not pos then break end
        local job=table.remove(queue,pos); now=job.time
        if not job.timer or not job.timer.destroyed then expired=job.timer; job.callback() end
    end
    now=untilTime
end
function ConditionalTriggerExecute(action) start(action,event) end
function InitHashtable() return {} end
function SaveInteger(h,id,k,v) h[id]=h[id] or {}; h[id][k]=v end
function LoadInteger(h,id,k) return h[id][k] end
function LoadTimerDialogHandle(h,id,k) return h[id][k] end
function FlushChildHashtable(h,id) h[id]=nil end
function GetRectMinX(r) return r.x end
function GetRectMaxX(r) return r.x end
function GetRectMinY(r) return r.y end
function GetRectMaxY(r) return r.y end
function GetRectCenterX(r) return r.x end
function GetRectCenterY(r) return r.y end
function PanCameraToTimed() end
PLAYER_SLOT_STATE_PLAYING='playing'; MAP_CONTROL_USER='human'; UNIT_STATE_MANA='mana'; UNIT_STATE_LIFE='life'
PLAYER_STATE_RESOURCE_GOLD='gold'; PLAYER_STATE_RESOURCE_LUMBER='lumber'
UNIT_TYPE_ANCIENT='ancient'; UNIT_TYPE_STRUCTURE='structure'; bj_MAX_PLAYER_SLOTS=24
bj_ALLIANCE_ALLIED_VISION='allied'; bj_ALLIANCE_UNALLIED='enemy'; bj_UNIT_FACING=0
dofile('src/runtime.lua'); dofile('src/players/roles.lua'); dofile('src/players/roster.lua'); dofile('src/combat/focused_anger.lua')
for _,path in ipairs(dofile('build/role-test-input.lua').modules) do dofile(path) end
FE_Roles.setAncient(Player(6)); for _,i in ipairs({0,1,6,10}) do Player(i).playing=true end
udg_Flags={}; udg_SeedOfRebirth=setmetatable({},{__index=function() return 0 end})
bj_FORCE_PLAYER={[0]={[Player(0)]=true}}
Trig_Player_group_Actions(); check(udg_StillAlive==3,'count present expanders including slot 11')
check(bj_FORCE_PLAYER[0][Player(0)] and not bj_FORCE_PLAYER[0][Player(1)],'Blizzard singleton force preserved')
check(FE_Roster.expanderForce()[Player(10)] and not FE_Roster.expanderForce()[Player(6)],'dedicated expander force')
check(FE_Roster.defeat(Player(0)) and not FE_Roster.defeat(Player(0)) and udg_StillAlive==2,'death counted once')
check(FE_Roster.revive(Player(0)) and not FE_Roster.revive(Player(0)) and udg_StillAlive==3,'rebirth counted once')
event={player=Player(10)}; Trig_Player_Leaves_Actions(); check(udg_StillAlive==2,'leave decrements living count')
FE_Roles.setAncient(Player(1)); check(udg_StillAlive==1,'takeover removes new Ancient from expander count')
FE_Roles.setAncient(Player(6)); FE_Roster.revive(Player(1)); FE_Roster.revive(Player(10))

local a=CreateUnit(Player(0),'u00B'),b
b=CreateUnit(Player(1),'u00B'); local ancient=CreateUnit(Player(6),'O004')
for i=1,20 do event={attacker=a,unit=ancient}; Trig_Focused_Anger_1_Actions() end
event={attacker=b,unit=ancient}; Trig_Focused_Anger_2_Actions()
check(FE_FocusedAnger.count(a)==15 and FE_FocusedAnger.count(b)==1,'per-attacker stack limit')
check(a.index==123 and ancient.index==123,'unit index untouched')
advance(6); check(FE_FocusedAnger.count(a)==0 and a.abilities.A06K==1 and b.abilities.A06K==1,'overlapping stacks expire on their original attackers')
event={attacker=b,unit=ancient}; Trig_Focused_Anger_2_Actions(); b.removed=true; advance(6)
check(FE_FocusedAnger.stacks[b]==nil,'removed attacker state released')

local c=CreateUnit(Player(0),'caster'); local d=CreateUnit(Player(1),'caster')
udg_Selectors='ewsp'
event={buyer=ancient};check(not Trig_Remove_Selector_Conditions(),'buying a unit cannot kill the Ancient buyer')
local selector=CreateUnit(Player(6),'ewsp');event={buyer=selector}
check(Trig_Remove_Selector_Conditions(),'race selection still consumes the selector wisp')
Trig_Remove_Selector_Actions();check(selector.life==0,'selector removed after choosing a unit')
local summon1=CreateUnit(Player(0),'o01T');local summon2=CreateUnit(Player(0),'o01T')
start(Trig_Shadowlings_Actions,{summoned=summon1});advance(5)
start(Trig_Shadowlings_Actions,{summoned=summon2});advance(15)
check(summon1.life==0 and summon2.life==100,'first Shadowling expires without killing newer summons')
advance(5);check(summon2.life==0,'second Shadowling retains its own lifetime across waits')
start(Trig_Ancient_Grasp_Actions,{caster=c,unit=c}); advance(.5)
start(Trig_Ancient_Grasp_Actions,{caster=d,unit=d}); advance(10)
check(math.abs(c.life-110)<.001 and math.abs(d.life-110)<.001,'overlapping spell waits retain each caster')
c.mana=80; d.mana=60
start(Trig_ConjureMana_Actions,{caster=c,unit=c}); start(Trig_ConjureMana_Actions,{caster=d,unit=d}); advance(1)
check(c.mana==40 and d.mana==30,'delayed mana cost uses original caster')
advance(60); check(c.damage==199 and d.damage==199,'timed damage cleanup')
udg_VanguardHeal=10; c.life=0; start(Trig_Vanguard_Actions,{unit=c}); udg_VanguardHeal=99; advance(5)
check(c.life==60,'Vanguard healing amount captured for the cast')
c.abilities.B02U=1; d.abilities.B02U=1
start(Trig_Focused_Strike_Actions,{attacker=c}); start(Trig_Focused_Strike_Actions,{attacker=d}); advance(.5)
check(not c.abilities.B02U and not d.abilities.B02U,'overlapping Worgen attacks retain each attacker')

-- Resource conservation even with <20 maximum mana and dead (revivable) targets.
c.maxmana=100; c.mana=100; d.maxmana=7; d.mana=5
udg_DamageEventSource=c; udg_DamageEventTarget=d; start(Trig_Mana_Steal_Dancer_Actions,{})
check(c.maxmana==107 and c.mana==105 and d.maxmana==0 and d.mana==0,'steal bounded by available capacity/current mana')
c.life=0; d.life=0; advance(180)
check(c.maxmana==100 and d.maxmana==7,'dead heroes regain exact original maximum mana')

local first=#dialogs+1
start(Trig_Lightning_Strike_Actions,{}); start(Trig_Sandstorm_2_Actions,{}); start(Trig_Freeze_Zone_Actions,{})
advance(25); check(dialogs[first].destroyed and not dialogs[first+1].destroyed and not dialogs[first+2].destroyed,'one spell cannot destroy another countdown')
advance(20); check(dialogs[first+1].destroyed and not dialogs[first+2].destroyed,'second countdown independent')
advance(15); check(dialogs[first+2].destroyed,'third countdown cleanup')
udg_ExpanderSpawnTimer=CreateTimer(); start(Trig_TimeToExpanderSpawn_Actions,{})
local own=dialogs[#dialogs]; local unrelated=CreateTimerDialog(CreateTimer()); advance(18)
check(own.destroyed and not unrelated.destroyed,'startup countdown retains its own dialog')

-- Death records the hero type before removing it, snapshots coordinates, and
-- rebirth restores exactly one player without reading later event responses.
udg_AncientUnit=ancient; gg_rct_Fountain={x=100,y=200}; SPAWN_LACKEY_DELAY_MARK=0
SpawnLackey_PlayerDialog={}; SpawnLackey_PlayerTimer={}; gg_trg_Spawn_Lackey=Trig_Spawn_Lackey_Actions
local hero=CreateUnit(Player(0),'hero0',10,20); event={unit=hero,killer=nil}; Trig_Death_start_Actions()
check(udg_SeedOfRebirth[1]=='hero0' and not FE_Roster.isAlive(Player(0)),'capture rebirth type before unit removal')
local countAfterDeath=udg_StillAlive; Trig_Death_start_Actions(); check(udg_StillAlive==countAfterDeath,'duplicate death ignored')
udg_DeadPlayer=Player(10); advance(.5)
local lackey=Player(0).units[#Player(0).units]
check(lackey.kind=='e00A' and lackey.x==10 and lackey.y==20,'delayed spawn retains dead player and environmental-death location')
local seedCaster=CreateUnit(Player(1),'wisp')
start(Trig_SeedOfRebirth_Actions,{caster=seedCaster,target=lackey,unit=seedCaster})
udg_DeadPlayer=Player(10); advance(2)
local reborn=Player(0).units[#Player(0).units]
check(reborn.kind=='hero0' and not reborn.removed and lackey.removed,'rebirth creates captured original type')
check(FE_Roster.isAlive(Player(0)) and udg_StillAlive==countAfterDeath+1,'rebirth count increments once, not once per enemy')
check(not IsPlayerAlly(Player(0),Player(6)) and IsPlayerAlly(Player(0),Player(1)),'reborn player rejoins living expanders')

-- Late picker targets must be allied, living, non-structures.
for i=0,23 do Player(i).units={} end
Player(0).allies={[Player(1)]=true}; Player(1).allies={[Player(0)]=true}
local enemy=CreateUnit(Player(6),'enemy'),ally
ally=CreateUnit(Player(1),'ally'); local dead=CreateUnit(Player(1),'dead'); dead.life=0
local structure=CreateUnit(Player(1),'structure'); structure.structure=true
check(GetRandomAlliedAncient(Player(0))==ally,'late picker never teleports to enemy, dead unit, or structure')
filterUnit=enemy; enumUnit=ally
check(Trig_Realm_of_darkness_Func002001002()==false,'darkness filter uses filter unit (Ancient is not its own enemy)')
filterUnit=ally; check(Trig_Realm_of_darkness_Func002001002(),'darkness includes an enemy expander')
event={unit=ally}; enumUnit=enemy; Trig_Realm_of_darkness_2_Actions()
check(ally.abilities.A0B6==1 and not enemy.abilities.A0B6,'enter event buffs its entering unit')
udg_Bans=0; udg_BannedAncientFire=0; Trig_AncientFire_Actions()
check(udg_Bans==0 and udg_BannedAncientFire==0,'fire ban rejects exhausted budget')
udg_Bans=1; Trig_AncientFire_Actions()
check(udg_Bans==0 and udg_BannedAncientFire==1,'fire ban consumes one available ban')

FEEDRATE_MAX_PLAYERS=11; FEEDRATE_SYNC_PREFIX='feed'; FEEDRATE_NAME_SYNC_PREFIX='name'; FEEDRATE_FILE_PATH='test.txt'
local function clearFeed()
    FeedRate_Loaded={}; FeedRate_PendingRateReceived={}; FeedRate_PendingRate={}; FeedRate_PendingNameReceived={}; FeedRate_PendingName={}; udg_ExperienceRate={}
end
local function sync(p,data,name) event={player=p,data=data}; if name then FeedRate_OnNameSync() else FeedRate_OnRateSync() end end
for _,raw in ipairs({'50x','nan','1e2','101','-50','50:60:70',''}) do check(FeedRate_ParseRate(raw)==0,'malformed feed rate rejected') end
check(FeedRate_ParseRate('75')==75 and FeedRate_ParseRate('1:75')==75,'current and legacy integer payloads')
clearFeed(); sync(Player(0),'75',false); check(not FeedRate_Loaded[0],'wait for matching name')
sync(Player(0),Player(0).name,true); check(udg_ExperienceRate[0]==80,'late name completes synchronized load')
sync(Player(0),'50',false); check(udg_ExperienceRate[0]==80,'duplicate sync cannot overwrite selected rate')
clearFeed(); sync(Player(1),Player(1).name,true); sync(Player(1),'95',false)
check(udg_ExperienceRate[1]==100,'name-first ordering works')
clearFeed(); sync(Player(0),Player(1).name,true); sync(Player(0),'75',false)
check(not FeedRate_Loaded[0] and not FeedRate_Loaded[1],'sender cannot set another lobby player rate')
FeedRate_SelectRate(Player(0),50); sync(Player(0),Player(0).name,true)
check(udg_ExperienceRate[0]==50,'late file never overrides explicit dialog choice')
localSlot=0; Player(0).name='A"\\\n#123'; FeedRate_SaveForPlayer(Player(0),75)
check(preload:find('A\\"\\\\\\n#123',1,true)~=nil,'JASS preload string escapes quote, backslash and newline')
clearFeed(); FE_FeedNames[0]='Original#456'; Player(0).name='Wisp |cffffffffOriginal'
sync(Player(0),'Original#456',true); sync(Player(0),'75',false)
check(udg_ExperienceRate[0]==80 and preload:find('Original#456',1,true),'cosmetic rename cannot break save identity or late loading')
print('Bug regression checks passed: '..checks..' assertions; overlapping waits, roster, rebirth, index integrity, sync ownership')
