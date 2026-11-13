-- Real registered construction callbacks, including overlapping rejection reasons.
-- Native removal/cost/refund behavior still requires a live engine check.
local checks = 0
local function check(value, message) assert(value, message); checks = checks + 1 end
local players, units, triggers, event = {}, {}, {}, nil
local alive = {groups=0,effects=0,locations=0,forces=0}
local refunds, removals, messages = 0, 0, 0
local function resource(kind) alive[kind]=alive[kind]+1; return {kind=kind} end
local function release(handle) check(not handle.released,'resource released once');handle.released=true;alive[handle.kind]=alive[handle.kind]-1 end
function FourCC(s) return s end
function __jreal(n) return n end
function __jint(n) return n end
function Player(i) if not players[i] then players[i]={id=i,lumber=100000+i*701,gold=0} end;return players[i] end
function GetOwningPlayer(u) return u.owner end
function GetConvertedPlayerId(p) return p.id+1 end
function GetUnitTypeId(u)
    -- Event references may still expose a just-removed structure to later
    -- callbacks in the same dispatch. Never rely on removal to suppress them.
    if not u or (u.removed and (not event or event.unit~=u)) then return 0 end
    return u.raw
end
function GetWidgetLife(u) return u.dead and 0 or 100 end
function IsUnitType(u) return u.dead or u.removed or false end
function GetUnitX(u) return u.x end
function GetUnitY(u) return 0 end
function RectContainsUnit(r,u) assert(r,'base list initialized before lookup');return r.id==u.base end
function GetTriggerUnit() return event.unit end
function GetConstructingStructure() return event.unit end
function GetConstructedStructure() return event.unit end
function GetTriggerPlayer() return event.unit.owner end
function GetDyingUnit() return event.unit end
function GetKillingUnitBJ() return event.killer end
function GetPlayableMapRect() return {} end
function CreateTrigger() local t={events={},conditions={},actions={}};triggers[#triggers+1]=t;return t end
function Condition(f) return f end
function TriggerAddCondition(t,f) t.conditions[#t.conditions+1]=f end
function TriggerAddAction(t,f) t.actions[#t.actions+1]=f end
function TriggerRegisterAnyUnitEventBJ(t,e) t.events[e]=true end
function TriggerRegisterEnterRectSimple(t) t.events.enter=true end
function TriggerRegisterTimerEventSingle() end
function TriggerRegisterTimerEventPeriodic() end
function CreateGroup() local g=resource('groups');g.units={};return g end
function GroupEnumUnitsInRect(g,r)
    for u in pairs(units) do if not u.removed and RectContainsUnit(r,u) then g.units[#g.units+1]=u end end
end
function GroupEnumUnitsOfPlayer(g,p)
    for u in pairs(units) do if not u.removed and u.owner==p then g.units[#g.units+1]=u end end
end
function FirstOfGroup(g) return g.units[1] end
function GroupRemoveUnit(g,u) for i,v in ipairs(g.units) do if v==u then table.remove(g.units,i);break end end end
function DestroyGroup(g) release(g) end
function RemoveUnit(u) check(not u.removed,'rejected unit removed once');u.removed=true;units[u]=nil;removals=removals+1 end
function KillUnit() error('rejection must remove, not kill or leave corpses') end
function IssueImmediateOrderBJ() error('rejection must not invoke a native cancel/refund') end
function AdjustPlayerStateBJ(n,p,key) p[key]=p[key]+n;if key=='lumber' and n==2000 then refunds=refunds+1 end end
function GetPlayerState(p,key) return p[key] end
function SetPlayerStateBJ(p,key,n) p[key]=n end
function AddSpecialEffect() return resource('effects') end
function AddSpecialEffectLocBJ() return resource('effects') end
function DestroyEffect(e) release(e) end
function GetUnitLoc() return resource('locations') end
function RemoveLocation(p) release(p) end
function GetPlayersAll() return {permanent=true,players={Player(0),Player(7)}} end
function GetPlayersAllies() local f=resource('forces');f.players={Player(0),Player(7)};return f end
function GetPlayersEnemies() local f=resource('forces');f.players={Player(10)};return f end
function GetForceOfPlayer(p) local f=resource('forces');f.players={p};return f end
function DestroyForce(f) check(not f.permanent,'never destroy shared all-player force');release(f) end
local enumPlayer
function GetEnumPlayer() return enumPlayer end
function ForForce(f,callback) local old=enumPlayer;for _,p in ipairs(f.players) do enumPlayer=p;callback() end;enumPlayer=old end
function DisplayTimedTextToPlayer() messages=messages+1 end
function DisplayTimedTextToForce() messages=messages+1 end
function DisplayTextToForce() messages=messages+1 end
function PingMinimapLocForForce() end
UNIT_TYPE_DEAD='dead';PLAYER_STATE_RESOURCE_LUMBER='lumber';PLAYER_STATE_RESOURCE_GOLD='gold'
EVENT_PLAYER_UNIT_CONSTRUCT_START='start';EVENT_PLAYER_UNIT_CONSTRUCT_FINISH='finish'
EVENT_PLAYER_UNIT_DEATH='death';EVENT_PLAYER_UNIT_ATTACKED='attack'
udg_GARATHORbaseList={};udg_Flags={};FE_Roles={ancient=function() return Player(10) end}
function FE_Roles.forEachPlayer(callback) for slot=0,10 do callback(Player(slot)) end end
for i=1,10 do _G['gg_rct_Base_'..i]={id=i} end
dofile('src/economy/base_flags.lua')
for _,name in ipairs({'Base_List_Init','Flagstack_Deny','Flag_no_base_Deny','NewFlag','NewFlag2','NewFlag3','NewFlag4','NewFlag5'}) do _G['InitTrig_'..name]() end
local function emit(kind,u,killer)
    event={unit=u,killer=killer}
    for _,t in ipairs(triggers) do
        if t.events[kind] then
            local valid=true
            for _,condition in ipairs(t.conditions) do if not condition() then valid=false;break end end
            if valid then for _,action in ipairs(t.actions) do action() end end
        end
    end
    event=nil
end
local function clean() for kind,n in pairs(alive) do check(n==0,'no live '..kind) end end
local function spawn(raw,p,base)
    local u={raw=raw,owner=p,base=base,x=(base or 99)*100};units[u]=true;emit('enter',u);return u
end
local function build(raw,p,base)
    p.lumber=p.lumber-2000
    local u=spawn(raw,p,base);emit('start',u);return u
end
local types={'h04Z','h050','h05P','h04Y','h04V','h04W','h05N','h04X','h051','h052'}
for slot=0,10 do
    for _,raw in ipairs(types) do
        units={};udg_Flags={};udg_GARATHORbaseList={}
        local p=Player(slot);local before=p.lumber
        local outside=build(raw,p,nil)
        check(outside.removed and p.lumber==before,'outside-base rejection refunds owner exactly once, including non-Red')
        local valid=build(raw,p,1)
        check(not valid.removed and p.lumber==before-2000,'valid first flag keeps construction cost')
        local pending=build(raw,p,2)
        check(pending.removed and p.lumber==before-2000,'pending first flag also reserves the owner limit')
        emit('finish',valid)
        check(udg_Flags[p.id+1],'completed flag enables income')
        local count=refunds
        outside=build(raw,p,nil)
        check(outside.removed and p.lumber==before-2000 and refunds==count+1,'outside plus already-owned reasons cannot double refund')
        local other=Player((slot+1)%11);local otherBefore=other.lumber
        local stacked=build(raw,other,1)
        check(stacked.removed and other.lumber==otherBefore,'another owner cannot stack the occupied base')
        local free=spawn(raw,other,1)
        check(not free.removed and other.lumber==otherBefore,'spawn/enter alone can never mint a refund')
        units[free]=nil
        valid.dead=true;emit('death',valid,nil)
        check(not udg_Flags[p.id+1],'killerless death stops income')
        local replacement=build(raw,p,1)
        check(not replacement.removed,'dead flag does not block rebuilding')
        clean()
    end
end
units={};udg_Flags={}
local p=Player(7);local valid=build('h04Z',p,1);emit('finish',valid)
local before,redBefore,count=p.lumber,Player(0).lumber,refunds
for i=1,50000 do build(types[(i-1)%#types+1],p,nil) end
check(p.lumber==before and Player(0).lumber==redBefore,'50,000 rejected flags cannot generate or copy lumber')
check(refunds==count+50000,'one refund per charged invalid construction')
local live=0;for _ in pairs(units) do live=live+1 end
check(live==1,'no rejected structures or corpses retained after stress sequence')
check(udg_Flags[p.id+1],'rejected flags do not disrupt the legitimate completed flag')
Trig_NewFlag2_Actions();check(p.lumber==before+50,'one completed flag still pays its intended income')
valid.dead=true;emit('death',valid,{raw='Ancient',owner=Player(10)})
check(not udg_Flags[p.id+1],'combat death clears income')
clean()
-- Takeover keeps survivors. A pending flag must never cancel another completed
-- flag's income, and two surviving completed flags still pay one owner stream.
for _,pending in ipairs({false,true}) do
    units={};udg_Flags={};FE_BaseFlags.completed={}
    local former,taker=Player(1),Player(7)
    local a=build('h04Z',former,1)
    if not pending then emit('finish',a) end
    local b=build('h050',taker,2);emit('finish',b)
    a.owner=taker
    udg_Flags[taker.id+1]=udg_Flags[taker.id+1] or udg_Flags[former.id+1]
    udg_Flags[former.id+1]=false
    local before=taker.lumber
    Trig_NewFlag2_Actions()
    check(taker.lumber==before+50,'takeover retains one income stream per owner')
    a.dead=true;emit('death',a,nil)
    check(udg_Flags[taker.id+1],'surviving completed flag keeps income after transferred flag dies')
    before=taker.lumber
    Trig_NewFlag2_Actions()
    check(taker.lumber==before+50,'remaining flag continues to pay')
    RemoveUnit(b);before=taker.lumber
    Trig_NewFlag2_Actions()
    check(not udg_Flags[taker.id+1] and taker.lumber==before,'removal without death cannot leave ghost income')
    check(next(FE_BaseFlags.completed)==nil,'removed and dead completed handles released')
    clean()
end
-- Unit-handle hash order may differ across clients. The owner reduction must
-- yield the same result and prune the same references in either direction.
local nativePairs=pairs
local sample={
    {raw='h04Z',owner=Player(0)}, {raw='h050',owner=Player(4)},
    {raw='h05P',owner=Player(4)}, {raw='h04Y',owner=Player(8),dead=true},
    {raw='h04V',owner=Player(3),removed=true},
}
for _,reverse in ipairs({false,true}) do
    FE_BaseFlags.completed={}
    for _,flag in ipairs(sample) do FE_BaseFlags.completed[flag]=true end
    pairs=function(t)
        if t~=FE_BaseFlags.completed then return nativePairs(t) end
        local i=reverse and #sample+1 or 0
        return function()
            i=i+(reverse and -1 or 1)
            if sample[i] then return sample[i],true end
        end
    end
    FE_BaseFlags.refreshOwners()
    pairs=nativePairs
    for slot=0,10 do check(udg_Flags[slot+1]==(slot==0 or slot==4),'owner reduction is independent of handle iteration order') end
    check(FE_BaseFlags.completed[sample[4]]==nil and FE_BaseFlags.completed[sample[5]]==nil,'either traversal prunes dead/removed references')
end
print('Base flags passed: '..checks..' checks; all ten types/eleven owners; 50,000 rejections with no resource growth or retained handles')
