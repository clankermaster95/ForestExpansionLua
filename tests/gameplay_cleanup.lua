-- Current-source vs frozen r7 characterization. Run from the repository root.
-- Fixture SHA256: bee55193eba320476eed9664961c218e1131453984b19a145c42e0d6a438e1dd
-- Extract tests/fixtures/refactor-r7.zip to build/refactor-r7 before running.
-- These native doubles establish controlled traces, not live-engine equivalence.
local baseline = arg[1] or 'build/refactor-r7'
local checks, scenarios, locationCorrections = 0, 0, 0
local modules = {
    'src/races/forgotten/bloodmage.lua', 'src/races/forgotten/executioner.lua',
    'src/economy/base_flags.lua', 'src/players/deaths.lua',
    'src/ancients/pharaoh.lua', 'src/ancients/divinity.lua',
    'src/effects/timed.lua', 'src/ai/behavior.lua',
}
local function check(ok, message) assert(ok, message); checks = checks + 1 end
local function read(path)
    local f = assert(io.open(path, 'rb')); local text = f:read('*a'); f:close()
    return text:gsub('\r\n', '\n')
end
local function encode(value)
    if type(value) == 'table' then
        if value.handle then return value.handle .. '#' .. value.id end
        local keys, parts = {}, {}
        for key in pairs(value) do keys[#keys + 1] = key end
        table.sort(keys, function(a, b) return tostring(a) < tostring(b) end)
        for _, key in ipairs(keys) do parts[#parts + 1] = encode(key) .. '=' .. encode(value[key]) end
        return '{' .. table.concat(parts, ',') .. '}'
    end
    if type(value) == 'number' then return string.format('%.17g', value) end
    return tostring(value)
end
local function world(root)
    local w = {trace = {}, players = {}, units = {}, handles = {}, triggers = {}, queue = {},
        event = {}, now = 0, random = {}, randomAt = 0, nextId = 0, duplicateLocations = 0}
    local E = {}
    w.E = E; E._G = E
    setmetatable(E, {__index = function(_, name)
        if _G[name] ~= nil then return _G[name] end
        if name:match('^gg_snd_') or name:match('^gg_rct_') or
            name:match('^[A-Z][A-Z0-9_]+$') then return name end
        if name:match('^TriggerRegister') then
            local f = function(...) w.log(name, ...); end
            rawset(E, name, f); return f
        end
    end})
    function w.log(name, ...)
        local args = table.pack(...)
        local values = {}
        for i = 1, args.n do values[i] = encode(args[i]) end
        w.trace[#w.trace + 1] = {name = name, args = values}
    end
    function w.handle(kind)
        w.nextId = w.nextId + 1
        local h = {handle = kind, id = w.nextId}
        w.handles[h.id] = h; return h
    end
    function E.FourCC(raw) return raw end
    function E.Player(slot)
        if not w.players[slot] then
            local p = w.handle('player'); p.slot = slot; p.gold = 10000; p.lumber = 2000
            w.players[slot] = p
        end
        return w.players[slot]
    end
    function E.GetPlayerId(p) return p.slot end
    function E.GetConvertedPlayerId(p) return p.slot + 1 end
    function E.GetPlayerController(p) return p.controller or 'MAP_CONTROL_USER' end
    function E.GetPlayerSlotState() return 'PLAYER_SLOT_STATE_PLAYING' end
    function E.GetTriggerPlayer() return w.event.player end
    function E.GetTriggerUnit() return w.event.unit end
    function E.GetDyingUnit() return w.event.unit end
    function E.GetAttackedUnitBJ() return w.event.unit end
    function E.GetConstructedStructure() return w.event.unit end
    function E.GetConstructingStructure() return w.event.unit end
    function E.GetKillingUnitBJ() return w.event.killer end
    function E.GetAttacker() return w.event.attacker end
    function E.GetSpellAbilityUnit() return w.event.caster end
    function E.GetSpellTargetUnit() return w.event.target end
    function E.GetSpellAbilityId() return w.event.ability end
    function E.GetResearched() return w.event.research end
    function E.GetTriggeringTrigger() return w.trigger end
    function E.GetOwningPlayer(u) return u.owner end
    function E.GetUnitTypeId(u) return u and not u.removed and u.raw or 0 end
    function E.GetUnitUserData(u) return u.index end
    function E.GetUnitStateSwap(state, u) return u[state] end
    function E.GetUnitAbilityLevelSwapped(ability, u) return u.abilities[ability] or 0 end
    function E.GetUnitLifePercent(u) return u.life end
    function E.GetWidgetLife(u) return u.life end
    function E.GetUnitCurrentOrder(u) return u.order end
    function E.GetUnitFlyHeight(u) return u.fly or 0 end
    function E.IsUnitAliveBJ(u) return u and not u.removed and u.life > .405 or false end
    function E.IsUnitDeadBJ(u) return not E.IsUnitAliveBJ(u) end
    function E.IsUnitHiddenBJ(u) return u.hidden or false end
    function E.IsUnitVisible(u) return not u.invisible end
    function E.IsUnitType(u, kind) return u.types[kind] or false end
    function E.UnitHasBuffBJ(u, buff) return u.buffs[buff] or false end
    function E.IsUnitEnemy(u, p) return u.owner ~= p end
    function w.unit(slot, raw, life)
        local u = w.handle('unit'); u.owner = E.Player(slot); u.raw = raw; u.index = u.id
        u.life = life or 1000; u.mana = 100; u.abilities = {A065 = 1, A063 = 1, A06K = 1}
        u.x = 0; u.y = 0; u.types = {}; u.buffs = {}; u.order = 'channel'
        w.units[#w.units + 1] = u; return u
    end
    function E.SetUnitLifeBJ(u, amount) w.log('SetUnitLifeBJ', u, amount); u.life = amount end
    function E.SetUnitLifePercentBJ(u, amount) w.log('SetUnitLifePercentBJ', u, amount); u.life = amount end
    function E.SetUnitManaBJ(u, amount) w.log('SetUnitManaBJ', u, amount); u.mana = amount end
    function E.IncUnitAbilityLevelSwapped(ability, u)
        w.log('IncUnitAbilityLevelSwapped', ability, u); u.abilities[ability] = (u.abilities[ability] or 0) + 1
    end
    function E.IncUnitAbilityLevel(u, ability)
        w.log('IncUnitAbilityLevel', u, ability); u.abilities[ability] = (u.abilities[ability] or 0) + 1
    end
    function E.DecUnitAbilityLevel(u, ability)
        w.log('DecUnitAbilityLevel', u, ability); u.abilities[ability] = u.abilities[ability] - 1
    end
    function E.UnitDamageTargetBJ(...) w.log('UnitDamageTargetBJ', ...) end
    function E.IssueImmediateOrderBJ(u, order) w.log('IssueImmediateOrderBJ', u, order); u.order = order end
    function E.IssuePointOrderLocBJ(...) w.log('IssuePointOrderLocBJ', ...) end
    function E.PlaySoundBJ(sound) w.log('PlaySoundBJ', sound) end
    function E.RemoveUnit(u) w.log('RemoveUnit', u); u.removed = true end
    function E.KillUnit(u) w.log('KillUnit', u); u.life = 0 end
    function E.CreateGroup()
        local g = w.handle('group'); g.members = {}; w.log('CreateGroup', g); return g
    end
    local function groupOf(predicate)
        local g = E.CreateGroup()
        for _, u in ipairs(w.units) do if not u.removed and predicate(u) then g.members[#g.members + 1] = u end end
        return g
    end
    function E.GetUnitsOfPlayerAndTypeId(p, raw)
        w.log('GetUnitsOfPlayerAndTypeId', p, raw)
        return groupOf(function(u) return u.owner == p and u.raw == raw end)
    end
    function E.GetUnitsOfPlayerAll(p)
        w.log('GetUnitsOfPlayerAll', p); return groupOf(function(u) return u.owner == p end)
    end
    function E.GetUnitsInRectAll(rect)
        w.log('GetUnitsInRectAll', rect)
        return groupOf(function() return rect ~= 'gg_rct_SpawnDefender' end)
    end
    function E.GetUnitsInRectOfPlayer(rect, p)
        w.log('GetUnitsInRectOfPlayer', rect, p); return groupOf(function(u) return u.owner == p end)
    end
    function E.GetPlayableMapRect() return 'map' end
    function E.IsUnitInGroup(u, g)
        for _, member in ipairs(g.members) do if member == u then return true end end
        return false
    end
    function E.ForGroupBJ(g, action)
        local members = {}; for i, u in ipairs(g.members) do members[i] = u end
        for _, u in ipairs(members) do local old = w.enumUnit; w.enumUnit = u; action(); w.enumUnit = old end
    end
    function E.GetEnumUnit() return w.enumUnit end
    function E.GetFilterUnit() return w.filterUnit end
    function E.GroupAddUnitSimple(u, g)
        w.log('GroupAddUnitSimple', u, g)
        if not E.IsUnitInGroup(u, g) then g.members[#g.members + 1] = u end
    end
    function E.GroupRemoveUnitSimple(u, g)
        w.log('GroupRemoveUnitSimple', u, g)
        for i, member in ipairs(g.members) do if u == member then table.remove(g.members, i); break end end
    end
    function E.IsUnitGroupEmptyBJ(g) return #g.members == 0 end
    function E.GetRandomInt(low, high)
        w.randomAt = w.randomAt + 1; local value = w.random[w.randomAt]
        w.log('GetRandomInt', low, high, value)
        if not value then error('RNG_EXHAUSTED', 0) end
        assert(value >= low and value <= high); return value
    end
    function E.GetRandomSubGroup(count, source)
        w.log('GetRandomSubGroup', count, source)
        local index = E.GetRandomInt(1, #source.members)
        local g = E.CreateGroup(); g.members[1] = source.members[index]; return g
    end
    function E.GetUnitLoc(u)
        local l = w.handle('location'); l.x = u and u.x or 0; l.y = u and u.y or 0
        l.removals = 0; w.log('GetUnitLoc', u, l); return l
    end
    function E.GetRectCenter(rect)
        local l = w.handle('location'); l.x = 50; l.y = 25; l.removals = 0
        w.log('GetRectCenter', rect, l); return l
    end
    function E.GetLocationX(l) return l.x end
    function E.GetLocationY(l) return l.y end
    function E.GetLocationZ() return 0 end
    function E.DistanceBetweenPoints(a, b) return math.sqrt((a.x - b.x)^2 + (a.y - b.y)^2) end
    function E.RemoveLocation(l)
        w.log('RemoveLocation', l)
        if l then
            if l.removals > 0 then w.duplicateLocations = w.duplicateLocations + 1 end
            l.removals = l.removals + 1
        end
    end
    function E.AddLightningEx(...)
        local h = w.handle('lightning'); local args = table.pack(...); args[args.n + 1] = h
        w.log('AddLightningEx', table.unpack(args, 1, args.n + 1)); return h
    end
    function E.MoveLightningEx(...) w.log('MoveLightningEx', ...) end
    function E.DestroyLightningBJ(h) w.log('DestroyLightningBJ', h); if h then h.destroyed = true end end
    function E.AddSpecialEffectTargetUnitBJ(...)
        local h = w.handle('effect'); w.lastEffect = h; local args = table.pack(...); args[args.n + 1] = h
        w.log('AddSpecialEffectTargetUnitBJ', table.unpack(args, 1, args.n + 1))
    end
    function E.AddSpecialEffectLocBJ(...)
        local h = w.handle('effect'); w.lastEffect = h; local args = table.pack(...); args[args.n + 1] = h
        w.log('AddSpecialEffectLocBJ', table.unpack(args, 1, args.n + 1))
    end
    function E.GetLastCreatedEffectBJ() return w.lastEffect end
    function E.DestroyEffectBJ(h) w.log('DestroyEffectBJ', h); if h then h.destroyed = true end end
    function E.BlzSetSpecialEffectScale(...) w.log('BlzSetSpecialEffectScale', ...) end
    function E.CreateTrigger()
        local t = w.handle('trigger'); t.enabled = true; t.conditions = {}; t.actions = {}; t.events = {}
        w.triggers[#w.triggers + 1] = t; w.log('CreateTrigger', t); return t
    end
    function E.EnableTrigger(t) w.log('EnableTrigger', t); t.enabled = true end
    function E.DisableTrigger(t) w.log('DisableTrigger', t); t.enabled = false end
    function E.IsTriggerEnabled(t) return t.enabled end
    function E.Condition(f) return f end
    function E.TriggerAddCondition(t, condition)
        w.log('TriggerAddCondition', t); t.conditions[#t.conditions + 1] = condition
    end
    function E.TriggerAddAction(t, action)
        w.log('TriggerAddAction', t); t.actions[#t.actions + 1] = action
    end
    function E.TriggerRegisterPlayerUnitEventSimple(t, p, event)
        w.log('TriggerRegisterPlayerUnitEventSimple', t, p, event)
        t.events[#t.events + 1] = {player = p, event = event}
    end
    local function execute(t, conditions)
        if not t then return end
        if conditions then for _, f in ipairs(t.conditions) do if not f() then return end end end
        local old = w.trigger; w.trigger = t
        for _, f in ipairs(t.actions) do f() end
        w.trigger = old
    end
    function E.TriggerExecute(t) w.log('TriggerExecute', t); execute(t, false) end
    function E.ConditionalTriggerExecute(t) w.log('ConditionalTriggerExecute', t); execute(t, true) end
    function w.fire(event, context)
        w.event = context
        for _, t in ipairs(w.triggers) do
            if t.enabled then
                for _, registration in ipairs(t.events) do
                    if registration.event == event and registration.player == context.player then execute(t, true); break end
                end
            end
        end
    end
    function E.CreateTimer()
        local t = w.handle('timer'); w.log('CreateTimer', t); return t
    end
    function E.TimerStart(t, delay, periodic, callback)
        w.log('TimerStart', t, delay, periodic); t.periodic = periodic; t.delay = delay
        if callback then w.queue[#w.queue + 1] = {time = w.now + delay, callback = callback, timer = t} end
    end
    function E.DestroyTimer(t) w.log('DestroyTimer', t); t.destroyed = true end
    function E.PauseTimer(t) w.log('PauseTimer', t); t.paused = true end
    function E.GetExpiredTimer() return w.expired end
    function E.StartTimerBJ(t, periodic, duration) w.log('StartTimerBJ', t, periodic, duration); t.paused = false end
    function E.PauseTimerBJ(paused, t) w.log('PauseTimerBJ', paused, t); t.paused = paused end
    function E.TriggerSleepAction(delay) w.log('TriggerSleepAction', w.now, delay); return coroutine.yield(delay) end
    local function resume(co, context)
        local old = w.event; w.event = context
        local ok, delay = coroutine.resume(co); w.event = old; assert(ok, delay)
        if coroutine.status(co) ~= 'dead' then
            local stable = {unit = context.unit, player = context.player}
            w.queue[#w.queue + 1] = {time = w.now + delay, callback = function() resume(co, stable) end}
        end
    end
    function w.start(action, context) resume(coroutine.create(action), context) end
    function w.advance(duration)
        local target = w.now + duration
        while true do
            local index
            for i, job in ipairs(w.queue) do
                if job.time <= target and (not index or job.time < w.queue[index].time) then index = i end
            end
            if not index then break end
            local job = table.remove(w.queue, index); w.now = job.time
            if not job.timer or not job.timer.destroyed then w.expired = job.timer; job.callback() end
        end
        w.now = target
    end
    function E.InitHashtable() return {} end
    function E.String2OrderIdBJ(s) return s end
    function E.ModuloInteger(a, b) return a % b end
    function E.I2R(i) return i + 0.0 end
    function E.R2I(n) return n < 0 and math.ceil(n) or math.floor(n) end
    function E.GetPlayersAll() return 'allPlayers' end
    function E.DisplayTextToForce(...) w.log('DisplayTextToForce', ...) end
    function E.AdjustPlayerStateBJ(amount, p, state) w.log('AdjustPlayerStateBJ', amount, p, state); p[state] = (p[state] or 0) + amount end
    function E.CreateNUnitsAtLoc(count, raw, p, location, facing)
        w.log('CreateNUnitsAtLoc', count, raw, p, location, facing)
        w.lastUnit = w.unit(p.slot, raw); w.lastUnit.x = location.x; w.lastUnit.y = location.y
    end
    function E.GetLastCreatedUnit() return w.lastUnit end
    function E.DoNothing() w.log('DoNothing') end
    function w.load(path) assert(loadfile(root .. '/' .. path, 't', E))() end
    E.UNIT_STATE_LIFE = 'life'; E.UNIT_STATE_MANA = 'mana'
    E.PLAYER_STATE_RESOURCE_GOLD = 'gold'; E.PLAYER_STATE_RESOURCE_LUMBER = 'lumber'
    E.PLAYER_NEUTRAL_PASSIVE = 15; E.PLAYER_NEUTRAL_AGGRESSIVE = 12; E.bj_UNIT_FACING = 270
    w.load('src/runtime.lua'); w.load('src/globals.lua'); w.load('src/players/roles.lua')
    w.load('src/combat/focused_anger.lua'); w.load('src/items/recipe_data.lua')
    for _, path in ipairs(modules) do w.load(path) end
    E.FE_Roles.setAncient(E.Player(6))
    function w.globals(prefix)
        local values = {}
        for name, value in pairs(E) do if name:sub(1, #prefix) == prefix then values[name] = value end end
        return values
    end
    function w.state()
        local units, triggers = {}, {}
        for _, u in ipairs(w.units) do
            units[#units + 1] = {id = u.id, owner = u.owner, raw = u.raw, life = u.life,
                mana = u.mana, abilities = u.abilities, order = u.order, removed = u.removed}
        end
        for _, t in ipairs(w.triggers) do triggers[#triggers + 1] = {id = t.id, enabled = t.enabled, events = t.events} end
        return {units = units, triggers = triggers, randomAt = w.randomAt}
    end
    return w
end
local function compare(label, scenario, allowLocationCorrection)
    local old, new = world(baseline), world('.')
    local oldResult, newResult = scenario(old), scenario(new)
    check(#old.trace == #new.trace, label .. ': trace length')
    local corrections = 0
    for i, a in ipairs(old.trace) do
        local b = new.trace[i]
        if encode(a) ~= encode(b) then
            local previous = old.trace[i - 1]
            local oldId = tonumber((a.args[1] or ''):match('^location#(%d+)$'))
            local newId = tonumber((b.args[1] or ''):match('^location#(%d+)$'))
            check(allowLocationCorrection and a.name == 'RemoveLocation' and b.name == a.name and
                previous.name == a.name and previous.args[1] == a.args[1] and
                oldId and newId == oldId + 1 and old.handles[newId].handle == 'location',
                label .. ': trace mismatch #' .. i .. '\nold ' .. encode(a) .. '\nnew ' .. encode(b))
            corrections = corrections + 1
        else checks = checks + 1 end
    end
    check(encode(oldResult) == encode(newResult), label .. ': result/state mismatch\nold ' .. encode(oldResult) .. '\nnew ' .. encode(newResult))
    check(encode(old.state()) == encode(new.state()), label .. ': unit/trigger state')
    if allowLocationCorrection then
        check(corrections > 0 and old.duplicateLocations == corrections and new.duplicateLocations == 0, label .. ': exact cleanup correction')
        for _, h in pairs(new.handles) do if h.handle == 'location' then check(h.removals == 1, label .. ': each location freed once') end end
        locationCorrections = locationCorrections + corrections
    end
    scenarios = scenarios + 1
end

-- Every initializer in the owned modules, in its unchanged declaration order.
local initializers = {}
for _, path in ipairs(modules) do
    for name in read(baseline .. '/' .. path):gmatch('\nfunction (InitTrig_%w[%w_]*)%(') do initializers[#initializers + 1] = name end
end
compare('all initializers', function(w)
    for _, name in ipairs(initializers) do w.E[name]() end
    return w.state()
end)

local function copySuffix(index) return index == 1 and '' or '_Copy' .. (index == 2 and '' or '_' .. (index - 1)) end
for owner = 0, 10 do for _, ancient in ipairs({6, 2}) do
    compare('research/focus owner ' .. owner .. ' ancient ' .. ancient, function(w)
        local E = w.E; E.FE_Roles.setAncient(E.Player(ancient))
        for i = 1, 10 do
            E['InitTrig_Levelled_Drain' .. copySuffix(i)](); E['InitTrig_Levelled_Slam' .. copySuffix(i)]()
            E['InitTrig_Focused_Anger_' .. i](); E['InitTrig_Focused_Anger_Trigger' .. copySuffix(i)]()
        end
        local a, b = w.unit(owner, 'u009'), w.unit(owner, 'u009')
        w.unit((owner + 1) % 11, 'u009'); w.unit(owner, 'other')
        local attacker, target = w.unit(owner, 'u00B'), w.unit(ancient, 'ancient')
        local context = {player = E.Player(ancient), unit = target, attacker = attacker}
        w.fire(E.EVENT_PLAYER_UNIT_ATTACKED, context)
        check(E.FE_FocusedAnger.count(attacker) == 0, 'research gates stacks')
        for _, research in ipairs({'wrong', 'R043', 'R04V', 'R04T'}) do
            w.fire(E.EVENT_PLAYER_UNIT_RESEARCH_FINISH, {player = E.Player(owner), research = research})
        end
        -- Both inherited upgrade families react to the same research event.
        local slam = read(baseline .. '/src/races/forgotten/bloodmage.lua'):match('function Trig_Levelled_Slam_Conditions.-FourCC%("(.-)"%)')
        check(slam == 'R043', 'preserved shared research ID')
        attacker.raw = 'other'; w.fire(E.EVENT_PLAYER_UNIT_ATTACKED, context)
        check(E.FE_FocusedAnger.count(attacker) == 0, 'wrong attacker type cannot stack')
        attacker.raw = 'u00B'
        for _ = 1, 17 do w.fire(E.EVENT_PLAYER_UNIT_ATTACKED, context) end
        check(a.abilities.A065 == (owner == 6 and 1 or 2) and b.abilities.A065 == a.abilities.A065, 'original research slot coverage')
        check(a.abilities.A063 == a.abilities.A065 and b.abilities.A063 == a.abilities.A063, 'both researched abilities updated')
        check(E.FE_FocusedAnger.count(attacker) == (owner == 6 and 0 or 15), 'original focus owner slots and cap')
        w.advance(6)
        check(E.FE_FocusedAnger.count(attacker) == 0, 'stack expiry retained')
        return w.state()
    end)
end end

local bloodCosts = {Acidic_Blood = 150, Binding_Shadows = 200, Cobalt_Blood = 200,
    Glowing_Blood = 50, Psychic_Slam = 300, Soul_Rend = 350, Dark_Blood = 400}
local costNames = {}; for name in pairs(bloodCosts) do costNames[#costNames + 1] = name end; table.sort(costNames)
for _, name in ipairs(costNames) do for _, delta in ipairs({-0.25, 0, 0.25, 400}) do
    compare('life cost ' .. name .. ' ' .. delta, function(w)
        local caster = w.unit(0, 'u009', bloodCosts[name] + delta); local target = w.unit(1, 'target')
        w.event = {unit = caster, caster = caster, target = target}; w.E['Trig_' .. name .. '_Actions']()
        check(caster.life == (delta > 0 and delta or bloodCosts[name] + delta), 'life-cost equality rule')
        check(target.life == ((name == 'Soul_Rend' and delta > 0) and 500 or 1000), 'Soul Rend gated target cost')
        return w.state()
    end)
end end

compare('all 28 death sounds and ignored predicate side effects', function(w)
    local count, allocated = 0, 0
    for section in read(baseline .. '/src/players/deaths.lua'):gmatch('%-%- BEGIN FOREST SECTION.-%-%- END FOREST SECTION') do
        local name = section:match('function Trig_([%w_]+)_Conditions')
        local raw = section:match('FourCC%("(.-)"%)')
        local u = w.unit(0, raw); w.event = {unit = u}
        check(w.E['Trig_' .. name .. '_Conditions'](), 'matching death type')
        w.E['Trig_' .. name .. '_Actions'](); count = count + 1
        u.raw = 'other'; check(not w.E['Trig_' .. name .. '_Conditions'](), 'wrong death type')
    end
    for _, call in ipairs(w.trace) do if call.name == 'GetUnitsInRectOfPlayer' then allocated = allocated + 1 end end
    check(count == 28 and allocated == 7, 'death families and ignored allocation calls retained')
    return w.state()
end)

compare('six flag classifications and extra event conditions', function(w)
    local E = w.E; local result = {}
    for _, raw in ipairs({'h04Z','h050','h05P','h04Y','h04V','h04W','h05N','h04X','h051','h052','other'}) do
        local u = w.unit(0, raw); local killer = w.unit(6, 'ancient')
        w.event = {unit = u, killer = killer}
        for _, flagged in ipairs({false, true}) do
            E.udg_Flags[1] = flagged
            for _, name in ipairs({'Trig_Flag_no_base_Deny_Func001C','Trig_NewFlag_Conditions','Trig_NewFlag3_Conditions','Trig_NewFlag4_Conditions','Trig_NewFlag5_Conditions'}) do
                result[#result + 1] = E[name]()
            end
            result[#result + 1] = E.Trig_Flagstack_Deny_IsFlag(u)
        end
        w.event.killer = nil; result[#result + 1] = E.Trig_NewFlag3_Conditions()
    end
    return result
end)

compare('overlapping Grasp and Vanguard pulses', function(w)
    local E = w.E; local a, b = w.unit(0, 'caster', 50), w.unit(1, 'caster', 100)
    E.udg_VanguardHeal = E.__jreal(10.25)
    w.start(E.Trig_Ancient_Grasp_Actions, {unit = a, caster = a})
    w.start(E.Trig_Vanguard_Actions, {unit = a, caster = a})
    w.advance(.5)
    w.start(E.Trig_Ancient_Grasp_Actions, {unit = b, caster = b})
    w.start(E.Trig_Vanguard_Actions, {unit = b, caster = b})
    E.udg_VanguardHeal = 999; w.advance(.5); a.removed = true; w.advance(10)
    local waits = 0
    for _, call in ipairs(w.trace) do if call.name == 'TriggerSleepAction' then waits = waits + 1 end end
    check(waits == 30 and #w.queue == 0, 'ten Grasp and five Vanguard waits per cast')
    return w.state()
end)

local function prepareTSE(w)
    local E = w.E
    E.udg_TSE_CTimer = E.CreateTimer()
    E.InitTrig_TSEEmptyEvent(); E.InitTrig_TSELoop(); E.InitTrig_TSERegister(); E.Trig_TSEConfig_Actions()
    E.udg_TSEChanneledOrderID = ''; E.udg_TSEOnIndexEvent = E.udg_TSE_EmptyEvent
    E.udg_TSEOnLoopEvent = E.udg_TSE_EmptyEvent; E.udg_TSEOnEndEvent = E.udg_TSE_EmptyEvent
    E.udg_TSEOnLoopTimer = E.udg_TSE_TIMEOUT; E.udg_TSEEffectName = 'test'; E.udg_TSEAttachPoint = 'origin'
end
for _, mode in ipairs({'compaction', 'nested-index', 'nested-loop', 'death', 'channel'}) do
    compare('TSE ' .. mode, function(w)
        prepareTSE(w); local E = w.E; local source = w.unit(0, 'caster'); local target = w.unit(1, 'target')
        local callback = E.CreateTrigger(); local fired = 0
        E.TriggerAddAction(callback, function()
            fired = fired + 1; w.log('effectCallback', E.udg_TSE__ActiveIndex, E.udg_TSE__RemainingDuration)
            if fired == 1 then
                if mode:match('nested') then
                    E.udg_TSETargetUnit = target; E.udg_TSEDuration = E.__jreal(.0625)
                    E.udg_TSEOnIndexEvent = E.udg_TSE_EmptyEvent; E.udg_TSEOnLoopEvent = E.udg_TSE_EmptyEvent
                    E.Trig_TSERegister_Actions()
                end
                E.udg_TSE__RemainingDuration = E.__jreal(E.udg_TSE__RemainingDuration + .03125)
            end
        end)
        E.udg_TSEDuration = E.__jreal(.0625); E.udg_TSETargetUnit = target; E.udg_TSESourceUnit = source
        E.udg_TSESourceUnitAliveCheck = true; E.udg_TSETargetUnitAliveCheck = true
        if mode == 'nested-index' then E.udg_TSEOnIndexEvent = callback else E.udg_TSEOnLoopEvent = callback end
        if mode == 'channel' then E.udg_TSEChanneledOrderID = 'channel' end
        E.Trig_TSERegister_Actions()
        E.udg_TSEPoint = E.GetUnitLoc(target); E.udg_TSETargetUnit = nil
        E.udg_TSEDuration = E.__jreal(.09375); E.udg_TSELockInstance = true
        E.Trig_TSERegister_Actions()
        E.udg_TSEPoint = nil; E.udg_TSETargetUnit = target; E.udg_TSEDuration = E.__jreal(.15625)
        E.Trig_TSERegister_Actions()
        local states = {}
        for tick = 1, 7 do
            if tick == 2 and mode == 'death' then source.life = 0 end
            if tick == 2 and mode == 'channel' then source.order = 'stop' end
            E.Trig_TSELoop_Actions()
            states[#states + 1] = encode(w.globals('udg_TSE'))
        end
        check(E.udg_TSE_MaxIndex == 0 and not E.udg_TSE_LoopTrigger.enabled, 'TSE drains and pauses')
        return states
    end)
end

for _, mode in ipairs({'normal', 'ethereal', 'range', 'buff', 'immune', 'resistant', 'invisible', 'dead', 'hidden', 'recast'}) do
    compare('Drain ' .. mode, function(w)
        local E = w.E; E.udg_ncld_Group = E.CreateGroup(); E.InitTrig_Drain_Loop(); E.Trig_Drain_Setup_Actions()
        local a, b = w.unit(0, 'u009'), w.unit(1, 'target'); b.x = 10
        local c, d = w.unit(2, 'u009'), w.unit(3, 'target'); d.x = 25
        a.abilities.A065 = 3
        w.event = {unit = a, caster = a, target = b}; E.Trig_Drain_Cast_Actions()
        w.event = {unit = c, caster = c, target = d}; E.Trig_Drain_Cast_Actions()
        if mode == 'recast' then w.event = {unit = a, caster = a, target = d}; E.Trig_Drain_Cast_Actions() end
        if mode == 'ethereal' then b.types[E.UNIT_TYPE_ETHEREAL] = true end
        if mode == 'range' then E.udg_ncld_FreqDistance = 1; b.x = 951 end
        if mode == 'buff' then b.buffs.BOwk = true end
        if mode == 'immune' then E.udg_ncld_CheckImmune = true; b.types[E.UNIT_TYPE_MAGIC_IMMUNE] = true end
        if mode == 'resistant' then E.udg_ncld_CheckResistant = true; b.types[E.UNIT_TYPE_RESISTANT] = true end
        if mode == 'invisible' then E.udg_ncld_CheckVisibile = true; b.invisible = true end
        if mode == 'dead' then b.life = 0 end
        if mode == 'hidden' then b.hidden = true end
        E.udg_ncld_TicksRemaining[a.index] = 2; E.udg_ncld_TicksRemaining[c.index] = 1
        for _ = 1, 4 do w.trigger = E.gg_trg_Drain_Loop; E.Trig_Drain_Loop_Actions() end
        check(E.IsUnitGroupEmptyBJ(E.udg_ncld_Group) and not E.gg_trg_Drain_Loop.enabled, 'Drain teardown completes')
        return {drain = w.globals('udg_ncld'), scratch = w.globals('udg_temp'),
            key = E.udg_Key, checkBool = E.udg_CheckBool, loopBuffs = E.udg_LoopBuffs, state = w.state()}
    end, true)
end

for _, mode in ipairs({'valid', 'retries', 'no-eligible'}) do
    compare('AI target ' .. mode, function(w)
        local E = w.E
        E.InitTrig_Hard_Attack(); E.InitTrig_Hard_Attack_Cont(); E.InitTrig_Hard_attack_2()
        w.unit(6, 'ancient'); w.unit(15, 'neutral'); w.unit(12, 'creep')
        if mode ~= 'no-eligible' then local enemy = w.unit(0, 'expander'); enemy.x = 30 end
        w.random = mode == 'valid' and {4} or {1, 2, 3, mode == 'no-eligible' and 1 or 4}
        local ok, err = pcall(E.Trig_Hard_Attack_Actions)
        if mode == 'no-eligible' then check(not ok and err == 'RNG_EXHAUSTED', 'original retry exhaustion characterized')
        else check(ok, err) end
        return {hardTarget = E.udg_Hardunit, state = w.state()}
    end)
end
for selected = 1, 8 do
    compare('AI existing eight-entry selection ' .. selected, function(w)
        local E = w.E; E.InitTrig_Slot1_Righteous_Armor(); w.random = {selected}
        E.Trig_Select_Actions()
        check(w.randomAt == 1, 'one AI selection draw')
        return {pool = E.udg_Ancients, unit = E.udg_AncientUnit, state = w.state()}
    end)
end

print(string.format('gameplay_cleanup: %d scenarios, %d checks; %d exact Drain location-removal corrections; frozen r7 traces otherwise match', scenarios, checks, locationCorrections))
