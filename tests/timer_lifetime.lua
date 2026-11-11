-- Model a native scheduler that does not root Lua handle wrappers. This proves
-- explicit Lua ownership and idempotent initialization, not current engine GC
-- behavior or that an unrooted timer caused the reported multiplayer desync.
local checks, timerCount, triggerCount = 0, 0, 0
local active = setmetatable({}, {__mode='k'})
local function check(value, message) assert(value, message); checks=checks+1 end
local function countActive()
    local count=0
    for _ in pairs(active) do count=count+1 end
    return count
end
function CreateTimer() timerCount=timerCount+1;return {id=timerCount} end
function TimerStart(timer, period, repeating, callback)
    active[timer]={period=period,repeating=repeating,callback=callback,pulses=0}
end
function CreateTrigger() triggerCount=triggerCount+1;return {} end
function TriggerRegisterAnyUnitEventBJ() end
function TriggerRegisterPlayerUnitEventSimple() end
function TriggerRegisterEnterRegion() end
function h__TriggerRegisterVariableEvent() end
function TriggerAddAction() end
function CreateRegion() return {} end
function RegionAddRect() end
function GetPlayableMapRect() return {} end
function CreateGroup() return {} end
function GetWorldBounds() return {} end
function GroupEnumUnitsInRect() end
function FirstOfGroup() return nil end
function DestroyGroup() end
function RemoveRect() end
function SetWidgetLife() end
function SetUnitState() end
FE_Roles={forEachPlayer=function() end}
FE_Takeover={forUnits=function() end}
FE_RecipeData={shops={}}

-- A negative control confirms that the double actually collects temporary
-- timers with a static callback, rather than retaining every handle itself.
local function staticCallback() end
local function startTemporary()
    local timer=CreateTimer()
    TimerStart(timer,0.25,true,staticCallback)
end
startTemporary()
collectgarbage('collect');collectgarbage('collect')
check(countActive()==0,'unowned timer is collectable in the weak native model')

dofile('src/combat/common.lua')
dofile('src/ancients/avalanche.lua')
dofile('src/races/cultist.lua')
dofile('src/items/shops.lua')
local modules={'FE_Combat','FE_Ice','FE_Cultist','FE_Shops'}
local periods={0.25,0.03125,0.25,0.25}
for _,name in ipairs(modules) do _G[name].init() end
collectgarbage('collect');collectgarbage('collect')
check(countActive()==4,'all perpetual timers remain reachable after collection')

local created, registered = timerCount, triggerCount
for _,name in ipairs(modules) do _G[name].init() end
check(timerCount==created and triggerCount==registered,'repeated init creates no duplicate timers or listeners')
for index,name in ipairs(modules) do
    local module=_G[name]
    check(active[module.timer]~=nil,'module owns its active timer: '..name)
    check(active[module.timer].repeating and active[module.timer].period==periods[index],'original timer cadence: '..name)
end
for iteration=1,10 do
    collectgarbage('collect');collectgarbage('collect')
    check(countActive()==4,'all timers survive repeated collections')
    for _,name in ipairs(modules) do
        local scheduled=active[_G[name].timer]
        scheduled.callback()
        scheduled.pulses=scheduled.pulses+1
        check(scheduled.pulses==iteration,'callback continues after collection: '..name)
    end
end
check(FE_Cultist.ticks==10,'real Cultist periodic callback remains active')
print('Timer lifetime passed: '..checks..' assertions; weak native registry, forced GC, four periodic systems and idempotent init')
