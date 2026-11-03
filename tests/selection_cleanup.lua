-- Current-r7 differential contract for faction registration, stock and ban state.
-- Native doubles; this does not model Warcraft multiplayer or shop UI.
local checks = 0
local function check(value, message) assert(value, message); checks = checks + 1 end
local paths = {'src/game/selection.lua', 'src/game/bans/expanders.lua', 'src/game/bans/ancients.lua'}
local function fixture(prefix)
    local env, trace, handles = {}, {}, 0
    setmetatable(env, {__index=_G}); env._G = env
    local function record(name, ...)
        local fields = {name}
        for i=1,select('#', ...) do
            local value = select(i, ...)
            if type(value)=='function' then
                local found
                for key, candidate in pairs(env) do if candidate==value then found=key;break end end
                assert(found, 'Unidentified registered callback'); value=found
            end
            fields[#fields+1] = tostring(value)
        end
        trace[#trace+1] = table.concat(fields, '|')
    end
    env.FourCC = function(raw) return raw end
    env.GetBooleanOr = function(a,b) return a or b end
    env.DoNothing = function() end
    env.I2S = tostring
    env.GetPlayersAll = function() return 'all' end
    env.Player = function(slot) return 'player'..slot end
    env.CreateTrigger = function() handles=handles+1;record('create', handles);return 'trigger'..handles end
    for _, name in ipairs({'AddUnitToStockBJ','DisplayTextToForce','TriggerRegisterPlayerChatEvent',
                           'TriggerAddAction','DisableTrigger','TriggerRegisterTimerEventSingle'}) do
        env[name] = function(...) record(name, ...) end
    end
    assert(loadfile(prefix..'src/runtime.lua', 't', env))()
    for _, path in ipairs(paths) do assert(loadfile(prefix..path, 't', env))() end
    return env, trace
end
local old, oldTrace = fixture('build/refactor-r7/')
local new, newTrace = fixture('')
local catalog = {}
for _, kind in ipairs({'expanders','ancients'}) do
    for _, entry in ipairs(new.FE_Factions[kind]) do catalog[#catalog+1]=entry end
end
local function clear()
    for i=#oldTrace,1,-1 do oldTrace[i]=nil end
    for i=#newTrace,1,-1 do newTrace[i]=nil end
end
local function same(label)
    check(table.concat(oldTrace,'\n')==table.concat(newTrace,'\n'), label..' native trace')
    check(old.udg_Bans==new.udg_Bans, label..' budget')
    for _, entry in ipairs(catalog) do check(old[entry.ban]==new[entry.ban], label..' '..entry.key) end
    clear()
end
local function flags(setup)
    for i, entry in ipairs(catalog) do
        old[entry.ban]=setup(i); new[entry.ban]=old[entry.ban]
        old[entry.shop]=entry.shop..'_live'; new[entry.shop]=old[entry.shop]
    end
end
local function stock(label)
    old.Trig_Spawn_Races_Actions(); new.Trig_Spawn_Races_Actions(); same(label..' expanders')
    old.Trig_Spawn_Ancients_Actions(); new.Trig_Spawn_Ancients_Actions(); same(label..' ancients')
end
flags(function() return 0 end); stock('unbanned')
flags(function() return 1 end); stock('all banned')
for i=1,#catalog do
    flags(function(j) return i==j and 1 or 0 end); stock('single ban '..i)
end
for _, value in ipairs({-1,2}) do flags(function() return value end);stock('nonbinary flag '..value) end
flags(function() return nil end); stock('uninitialized flags')
for mask=0,159 do
    flags(function(i) return ((mask * (i+3) + i*i) % 7 < 3) and 0 or 1 end)
    stock('mixed flags '..mask)
end
for _, key in ipairs(new.FE_Factions.banOrder) do
    old['InitTrig_'..key](); new['InitTrig_'..key](); same('registration '..key)
    for _, budget in ipairs({-1,0,1,3,2147483647}) do
        for _, banned in ipairs({0,1,2}) do
            flags(function() return banned end);old.udg_Bans=budget;new.udg_Bans=budget
            old['Trig_'..key..'_Actions']();new['Trig_'..key..'_Actions']()
            same('ban '..key..' budget '..budget..' flag '..banned)
        end
    end
end
old.Trig_DisableExpanderBans_Actions();new.Trig_DisableExpanderBans_Actions();same('cutoff coverage/order')
for _, name in ipairs({'Spawn_Races','Spawn_Ancients','DisableExpanderBans'}) do
    old['InitTrig_'..name]();new['InitTrig_'..name]();same('timer '..name)
end
print('Selection cleanup passed: '..checks..' comparisons; all factions/aliases, stock order, mutable flags, budget and cutoff')
