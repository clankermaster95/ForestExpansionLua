-- A weak native timer registry verifies ownership through the deferred Freeze
-- Zone callback. It models GC exposure, not Warcraft's current GC behavior.
local checks, created, destroyed = 0, 0, 0
local scheduled = setmetatable({}, {__mode='k'})
local wrappers = setmetatable({}, {__mode='v'})
local expired, failCreation = nil, false
local orders, lifetimes, dummies = {}, {}, {}
local function check(ok, message) assert(ok, message);checks=checks+1 end
function FourCC(raw) return raw end
function __jreal(value) return value end
function CreateTimer()
    created=created+1
    local timer={id=created};wrappers[created]=timer
    return timer
end
function TimerStart(timer, delay, repeating, callback)
    scheduled[timer]={delay=delay,repeating=repeating,callback=callback}
end
function DestroyTimer(timer)
    check(not timer.destroyed,'timer destroyed only once')
    timer.destroyed=true;scheduled[timer]=nil;destroyed=destroyed+1
end
function GetExpiredTimer() return expired end
function GetHandleId(handle) return handle.id end
function CreateUnit(owner,raw,x,y,facing)
    if failCreation then return nil end
    local unit={owner=owner,raw=raw,x=x,y=y,facing=facing,life=1,abilities={}}
    dummies[#dummies+1]=unit;return unit
end
function GetUnitX(unit) return unit.x end
function GetUnitY(unit) return unit.y end
function GetWidgetLife(unit) return unit.life end
function UnitAddAbility(unit,raw) unit.abilities[raw]=1 end
function SetUnitAbilityLevel(unit,raw,level) unit.abilities[raw]=level end
function SetUnitState(unit,state,value) unit[state]=value end
function SaveUnitHandle(hash,key,child,value)
    hash[key]=hash[key] or {};hash[key][child]=value
end
function LoadUnitHandle(hash,key,child) return hash[key] and hash[key][child] end
function FlushChildHashtable(hash,key) hash[key]=nil end
function IssueTargetOrder(unit,order,target) orders[#orders+1]={unit,order,target};return true end
function UnitApplyTimedLife(unit,buff,duration) lifetimes[#lifetimes+1]={unit,buff,duration} end
TP_HASH={};TP_DUMMY_OWNER={id=12};TP_DUMMY_ID='h06G';TP_DEBUFF_ID='A0EZ'
TP_DEBUFF_ORDER='slow';TP_DUMMY_LIFETIME=6;TP_DUMMY_CAST_DELAY=0;UNIT_STATE_MANA='mana'
dofile('src/ancients/avalanche.lua')
local function collect() collectgarbage('collect');collectgarbage('collect') end
local function pendingCount()
    local count=0;for _ in pairs(scheduled) do count=count+1 end;return count
end
local function fire(id)
    local timer=wrappers[id]
    check(timer~=nil and scheduled[timer]~=nil,'delayed cast survives collection')
    local event=scheduled[timer]
    check(event.delay==0 and not event.repeating,'original zero-delay one-shot cadence')
    expired=timer;event.callback();expired=nil
end
local first={x=100,y=200,life=100};local second={x=300,y=400,life=100}
TP_CastDebuff(first,3);TP_CastDebuff(second,5)
check(#orders==0 and #lifetimes==0,'casts remain deferred')
collect();check(pendingCount()==2,'both pending timer handles have a Lua owner')
check(dummies[1].x==250 and dummies[1].y==200 and dummies[1].owner==TP_DUMMY_OWNER,'dummy placement and owner unchanged')
check(dummies[1].abilities.A0EZ==3 and dummies[2].abilities.A0EZ==5,'each cast retains its spell level')
-- Execute out of order to catch shared state rather than per-timer ownership.
fire(2);collect()
check(wrappers[2]==nil and wrappers[1]~=nil,'completed timer released while other remains pending')
check(orders[1][1]==dummies[2] and orders[1][2]=='slow' and orders[1][3]==second,'callback uses its own target')
check(TP_HASH[2]==nil and TP_HASH[1]~=nil,'only completed cast hashtable row cleared')
fire(1);collect()
check(wrappers[1]==nil and pendingCount()==0 and next(TP_HASH)==nil,'all completed cast state released')
check(orders[2][1]==dummies[1] and orders[2][3]==first,'first cast unaffected by second completion')
for _,entry in ipairs(lifetimes) do check(entry[2]=='BTLF' and entry[3]==6,'dummy cleanup duration unchanged') end

local deadTarget={x=0,y=0,life=100}
TP_CastDebuff(deadTarget,1);deadTarget.life=0
collect();fire(3);collect()
check(#orders==2 and #lifetimes==3,'dead target skips casting but expires its dummy')
check(wrappers[3]==nil and next(TP_HASH)==nil,'dead-target callback releases timer and row')

failCreation=true
TP_CastDebuff(first,1);collect()
check(wrappers[4]==nil and pendingCount()==0 and next(TP_HASH)==nil,'failed dummy creation retains no timer or row')
check(created==4 and destroyed==4,'all success and failure timers are destroyed exactly once')
print('Freeze timer passed: '..checks..' assertions; deferred casts survive GC and release state on success, dead target and creation failure')
