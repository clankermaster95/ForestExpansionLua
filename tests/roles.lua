-- Focused event double, not a Warcraft engine simulation.
dofile('src/runtime.lua')
dofile('src/players/roles.lua')
dofile('src/players/roster.lua')
local manifest = dofile('build/role-test-input.lua')
for _, path in ipairs(manifest.modules) do dofile(path) end

local players, triggers, eventPlayer, enumPlayer, eventUnit = {}, {}, nil, nil, nil
local victories, defeats, removed, pings = {}, {}, {}, {}
local checks = 0
local function check(value, message)
    assert(value, message); checks = checks + 1
end
function Player(id)
    if not players[id] then players[id] = {id=id, gold=100, lumber=600, color=0, units={}} end
    return players[id]
end
function GetPlayerId(p) return p.id end
function GetTriggerPlayer() return eventPlayer end
function GetEnumPlayer() return enumPlayer end
function GetTriggerUnit() return eventUnit end
function GetUnitTypeId(u) return u.type end
function GetOwningPlayer(u) return u.owner end
function FourCC(text) return text end
function GetPlayerColor() error('Gameplay queried player color') end
function Condition(f) return f end
function CreateTrigger()
    local t = {events={}, conditions={}, actions={}, enabled=true}
    triggers[#triggers+1] = t; return t
end
function DisableTrigger(t) if t then t.enabled=false end end
function EnableTrigger(t) if t then t.enabled=true end end
function TriggerAddCondition(t,f) t.conditions[#t.conditions+1]=f end
function TriggerAddAction(t,f) t.actions[#t.actions+1]=f end
local function register(t,p,kind,...) t.events[#t.events+1]={player=p,kind=kind,args={...}} end
function TriggerRegisterPlayerUnitEventSimple(t,p,...) register(t,p,'unit',...) end
function TriggerRegisterPlayerChatEvent(t,p,...) register(t,p,'chat',...) end
function TriggerRegisterPlayerStateEvent(t,p,...) register(t,p,'state',...) end
function TriggerRegisterPlayerEventLeave(t,p) register(t,p,'leave') end
function TriggerRegisterTimerEventPeriodic() end
function TriggerRegisterAnyUnitEventBJ() end
function IsPlayerAlly(a,b) return a==b or a.ally==b end
function GetPlayerState(p,s) return p[s] end
function SetPlayerState(p,s,value) p[s]=value end
SetPlayerStateBJ=SetPlayerState
function AdjustPlayerStateBJ(value,p,s) p[s]=p[s]+value end
function GetPlayersAll() return players end
function ForForce(_,action)
    for slot=0,10 do enumPlayer=Player(slot); action() end
end
function DoNothing() end
function CustomVictoryBJ(p) check(not victories[p.id] and not defeats[p.id],'duplicate result'); victories[p.id]=true end
function CustomDefeatBJ(p) check(not victories[p.id] and not defeats[p.id],'duplicate result'); defeats[p.id]=true end
function DisplayTextToForce() end
function DisplayTimedTextToForce() end
function DisplayTextToPlayer() end
function DisplayTimedTextToPlayer() end
function PlayThematicMusicBJ() end
function TriggerSleepAction() end
function GetPlayerName(p) return 'Player '..p.id end
function GetConvertedPlayerId(p) return p.id+1 end
function GetUnitsOfPlayerAll(p) return p.units end
function GetEnumUnit() return eventUnit end
function ForGroupBJ(group,action) for _,u in ipairs(group) do eventUnit=u; action() end end
function RemoveUnit(u) removed[u]=true end
function GetPlayerSlotState(p) return p.playing and 'playing' or 'empty' end
function GetPlayerController(p) return p.controller end
function CreateGroup() return {} end
function GroupEnumUnitsOfPlayer(group,p) for _,u in ipairs(p.units) do group[#group+1]=u end end
function FirstOfGroup(group) return group[1] end
function GroupRemoveUnit(group,u) for i,v in ipairs(group) do if u==v then table.remove(group,i); return end end end
function DestroyGroup() end
function SetUnitOwner(u,p)
    for i,v in ipairs(u.owner.units) do if v==u then table.remove(u.owner.units,i); break end end
    u.owner=p; p.units[#p.units+1]=u
end
function GetPlayerAlliance(a,b) return IsPlayerAlly(a,b) end
function SetPlayerAlliance() end
function GetRectCenter(rect) return rect end
function GetPlayersAllies(p) return p end
function PingMinimapLocForForce(p) pings[#pings+1]=p end
function GetTriggeringTrigger() return {} end
function UnitAddItemByIdSwapped(item,u) u.item=item end
PLAYER_STATE_RESOURCE_GOLD='gold'; PLAYER_STATE_RESOURCE_LUMBER='lumber'
PLAYER_SLOT_STATE_PLAYING='playing'; MAP_CONTROL_USER='human'; MAP_CONTROL_COMPUTER='computer'
EVENT_PLAYER_UNIT_ATTACKED='attacked'; EVENT_PLAYER_UNIT_DEATH='death'
EVENT_PLAYER_UNIT_PICKUP_ITEM='pickup'; EVENT_PLAYER_HERO_LEVEL='level'
GREATER_THAN_OR_EQUAL='gte'
udg_Flags={}
dofile('src/items/recipe_data.lua')

FE_Roles.setAncient(Player(FE_Roles.initialAncientSlot))
check(FE_Roles.ancient()==Player(6),'original lobby default')
check(not FE_Roles.isAncient(nil),'nil is not a role')
check(not pcall(FE_Roles.setAncient,nil),'reject nil')
check(not pcall(FE_Roles.setAncient,Player(11)),'reject observer slot')

-- Exercise every migrated initializer and its actual filter, before/after
-- repeated takeovers, including a return to the default slot.
for _,name in ipairs(manifest.initializers) do _G[name]() end
local roleTriggers={}
for _,t in ipairs(triggers) do
    if t.conditions[1]==FE_Roles.isAncientEvent then
        roleTriggers[#roleTriggers+1]=t
        check(#t.events==11,'all participants registered once')
        local seen={}
        for _,e in ipairs(t.events) do
            check(not seen[e.player.id],'no duplicate subscription'); seen[e.player.id]=true
        end
    end
end
check(#roleTriggers==#manifest.initializers,'every migrated event gets a role filter')
for ancientSlot=0,10 do
    FE_Roles.setAncient(Player(ancientSlot))
    for eventSlot=0,10 do
        eventPlayer=Player(eventSlot)
        for _,t in ipairs(roleTriggers) do
            check(t.conditions[1]()==(eventSlot==ancientSlot),'role evaluated at event time')
        end
    end
    -- Actual income and cleanup actions: same-color allies are still allies,
    -- changing Ancient color never removes its own resources, enemies keep theirs.
    for slot=0,10 do
        local p=Player(slot); p.gold=100; p.lumber=600; p.ally=nil; p.color=0
    end
    Trig_Ancient_Gold_income_Actions()
    for slot=0,10 do check(Player(slot).gold==(slot==ancientSlot and 110 or 100),'income recipient') end
    local ally=Player((ancientSlot+1)%11); ally.ally=FE_Roles.ancient()
    Trig_Remove_Resources_new_Actions()
    check(ally.gold==0 and ally.lumber==0,'same-color ally resources cleared')
    check(FE_Roles.ancient().gold==110 and FE_Roles.ancient().lumber==600,'Ancient resources kept')
    check(Player((ancientSlot+2)%11).gold==100,'enemy resources kept')
    for slot=0,10 do Player(slot).gold=0 end
    Trig_Deliver_Gold_Actions()
    for slot=0,10 do check(Player(slot).gold==(slot==ancientSlot and 1040 or 1),'starting gold once per player') end
    -- Real victory actions, including all eleven Ancient types and the
    -- last player slot omitted by some original functions.
    for _,name in ipairs(manifest.deathActions) do
        victories={}; defeats={}; _G[name]()
        for slot=0,10 do check(slot==ancientSlot and defeats[slot] or slot~=ancientSlot and victories[slot],'death result follows role') end
    end
    for _,action in ipairs({Trig_DVIC_1_Actions,Trig_Extermination_Actions}) do
        victories={}; defeats={}; action()
        for slot=0,10 do check(slot==ancientSlot and victories[slot] or slot~=ancientSlot and defeats[slot],'Ancient win follows role') end
    end
end

local function fire(t,p)
    eventPlayer=p
    if not t.enabled then return false end
    for _,f in ipairs(t.conditions) do if not f() then return false end end
    for _,f in ipairs(t.actions) do f() end
    return true
end
-- Actual takeover command: reject an active Ancient, preserve units for
-- disconnected Ancient, transfer resources/ownership and route existing events.
for takerSlot=0,10 do
    local old=Player(takerSlot==6 and 0 or 6); local taker=Player(takerSlot)
    FE_Roles.setAncient(old); old.playing=true; old.controller='human'
    eventPlayer=taker; Trig_Takeover_Actions()
    check(FE_Roles.ancient()==old,'active Ancient cannot be replaced')
    old.playing=false; old.gold=4321; old.lumber=765; taker.ally=old
    local hero={owner=old,type='O004'}; old.units={hero}; taker.units={{owner=taker}}
    eventPlayer=taker; Trig_Takeover_Actions()
    check(FE_Roles.ancient()==taker and hero.owner==taker,'takeover assigns role and units')
    check(taker.gold==4321 and taker.lumber==765,'takeover copies resources')
    udg_Tradeoff='unchanged'
    check(not fire(gg_trg_Tradeoff_Detection,old) and udg_Tradeoff=='unchanged','old Ancient command rejected')
    check(fire(gg_trg_Tradeoff_Detection,taker) and udg_Tradeoff~='unchanged','new Ancient command accepted')
    eventPlayer=taker; removed={}; Trig_Player_Leaves_Actions()
    check(next(removed)==nil,'generic leave handler retains Ancient units for takeover')
    local remaining={owner=old}; old.units={remaining}
    eventPlayer=old; Trig_Player_Leaves_Actions()
    check(removed[remaining] and not removed[hero],'former Ancient uses ordinary leave handler')
    -- AI resource event is filtered by role as well as its threshold.
    udg_AncientUnit=hero; gg_trg_Slot1_Righteous_Armor.enabled=true
    check(not fire(gg_trg_Slot1_Righteous_Armor,old),'old player state event ignored')
    check(fire(gg_trg_Slot1_Righteous_Armor,taker),'new player state event accepted')
    check(hero.item=='I012' and taker.gold==2821,'item purchase charges current Ancient')
end
print('Ancient role regression checks passed: '..checks..' assertions; '..#roleTriggers..' event initializers')
