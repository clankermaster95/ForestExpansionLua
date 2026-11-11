-- Native double keeps weak wrappers. Real Lua ownership, expiry, rearming and
-- cancellation are tested; this does not reproduce current Warcraft GC.
local checks, created, destroyed, expired = 0, 0, 0, nil
local active=setmetatable({}, {__mode='k'})
local weak=setmetatable({}, {__mode='v'})
local pulses={0,0,0}
local function check(ok, message) assert(ok,message);checks=checks+1 end
function CreateTimer() created=created+1;return {id=created} end
function TimerStart(t,delay,repeating,callback)
    active[t]={delay=delay,repeating=repeating,callback=callback}
end
function DestroyTimer(t) active[t]=nil;destroyed=destroyed+1 end
function GetExpiredTimer() return expired end
local function count()
    local n=0;for _ in pairs(active) do n=n+1 end;return n
end
local function gc() collectgarbage('collect');collectgarbage('collect') end
dofile('src/runtime.lua')
check(created==0,'ownership helper allocates no timer during source loading')
local function temporary()
    local t=CreateTimer();TimerStart(t,1,false,function() end)
end
temporary();gc();check(count()==0,'negative control: native double does not retain wrappers')
local function single()
    pulses[1]=pulses[1]+1;FE_Timers.destroy(GetExpiredTimer())
end
local function repeating()
    pulses[2]=pulses[2]+1
    if pulses[2]==3 then FE_Timers.destroy(GetExpiredTimer()) end
end
local function rearm()
    pulses[3]=pulses[3]+1
    if pulses[3]<3 then TimerStart(GetExpiredTimer(),0.12,false,rearm)
    else FE_Timers.destroy(GetExpiredTimer()) end
end
local function start(index,delay,repeats,callback)
    local t=FE_Timers.create();weak[index]=t;TimerStart(t,delay,repeats,callback)
end
start(1,60,false,single);start(2,0.03125,true,repeating);start(3,0.12,false,rearm)
gc();check(count()==3,'static callbacks retain all owned timers across collection')
check(active[weak[1]].delay==60 and not active[weak[1]].repeating,'one-shot arguments preserved')
check(active[weak[2]].delay==0.03125 and active[weak[2]].repeating,'periodic arguments preserved')
local function fire(index)
    local t=weak[index];check(t~=nil,'timer wrapper survives until completion')
    expired=t;active[t].callback();expired=nil
end
for iteration=1,3 do
    if iteration==1 then fire(1) end
    fire(2);fire(3);gc()
    check(pulses[1]==1 and pulses[2]==iteration and pulses[3]==iteration,'callback cadence preserved')
    if iteration<3 then check(count()==2 and weak[1]==nil,'completed timer released; others survive rearming') end
end
gc();check(count()==0 and weak[2]==nil and weak[3]==nil,'completion releases every wrapper')
check(destroyed==3,'one native destruction per completed timer')
local function cancel()
    local t=FE_Timers.create();weak[4]=t;TimerStart(t,1,false,single)
    FE_Timers.destroy(t)
end
cancel();gc();check(count()==0 and weak[4]==nil and destroyed==4,'cancel before expiry releases wrapper and native timer')
local function abandonBeforeStart()
    local t=FE_Timers.create();weak[5]=t;FE_Timers.destroy(t)
end
abandonBeforeStart();gc();check(weak[5]==nil and destroyed==5,'failure before start leaves no owner')
print('Transient timer lifetime passed: '..checks..' assertions; static callbacks, forced GC, rearm, completion and cancellation')
