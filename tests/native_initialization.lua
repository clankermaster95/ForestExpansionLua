-- The old JASS declaration initializers must not allocate native handles while
-- Lua is loading. This test checks the real declarations and bootstrap, while
-- engine behavior/garbage collection still require live multiplayer testing.
local checks, phase, calls, order = 0, 'loading', {}, {}
local function check(value, message) assert(value,message);checks=checks+1 end
local expected = {
    {'PassiveMissiles__PM_Casters','group'},
    {'PassiveMissiles__PM_EnumGroup','group'},
    {'PassiveMissiles__PM_CastTimer','timer'},
    {'PassiveMissiles__PM_MoveTimer','timer'},
    {'PassiveMissiles__PM_Hash','hashtable'},
    {'SpellLeech__SL_Clock','timer'},
    {'SpellLeech__SL_Hash','hashtable'},
    {'SNIPESHOT_Hash','hashtable'},
    {'SNIPESHOT_Group','group'},
    {'DashHash','hashtable'},
    {'UPG_TempGroup','group'},
    {'BURST_ENUM_GROUP','group'},
    {'BURST_TIMER','timer'},
    {'WW_Hash','hashtable'},
    {'DAS_Hash','hashtable'},
    {'DAS_EnumGroup','group'},
    {'LackeyRespawn_Hash','hashtable'},
}
local function allocate(kind)
    check(phase=='initializing','native constructor must not run at Lua chunk load')
    local handle={kind=kind,id=#calls+1}
    calls[#calls+1]=handle
    return handle
end
function CreateGroup() return allocate('group') end
function CreateTimer() return allocate('timer') end
function InitHashtable() return allocate('hashtable') end
function FourCC(value) return value end
function Player(slot) return {slot=slot} end
dofile('src/runtime.lua')
dofile('src/globals.lua')
dofile('src/bootstrap.lua')
check(#calls==0,'loading source creates no native handles')
for _,entry in ipairs(expected) do check(_G[entry[1]]==nil,'handle is deferred: '..entry[1]) end
local function verifyHandles()
    check(#calls==#expected,'all seventeen allocations occur exactly once')
    for index,entry in ipairs(expected) do
        check(_G[entry[1]]==calls[index] and calls[index].kind==entry[2],
            'allocation identity/order preserved: '..entry[1])
    end
end
function ExecuteFunc(name)
    verifyHandles()
    order[#order+1]=name
end
function FE_InitGlobals() verifyHandles();order[#order+1]='globals' end
function FE_InitCustomTriggers() verifyHandles();order[#order+1]='triggers' end
FE_Recipes={init=function() order[#order+1]='recipes' end}
FE_Shops={init=function() order[#order+1]='shops' end}
FE_Test={init=function() order[#order+1]='test' end}
function FE_RunInitializationTriggers() verifyHandles();order[#order+1]='startup' end
phase='initializing'
InitTrig_FE_Bootstrap()
verifyHandles()
check(table.concat(order,',')=='jasshelper__initstructs149790140,PassiveMissiles__Init,SpellLeech__Init,globals,triggers,recipes,shops,test,startup',
    'relative library, variable, trigger, shopping and startup order unchanged')
FE_InitNativeGlobals()
verifyHandles()
print('Native initialization passed: '..checks..' assertions; no chunk-load allocations, seventeen ordered runtime handles')
