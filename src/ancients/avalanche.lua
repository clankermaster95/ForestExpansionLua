-- Sadism: moving enemy slow and anti-heal for the same 25-second duration.
-- Warcraft exposes damage events but no general native healing event. Scripted
-- heals are rejected at their write; native healing/regen is capped every frame
-- and before damage so it cannot be spent as extra HP on a following hit.
FE_Ice = { casts = {}, targets = {}, health = {}, ticks = 0, initialized = false }

function FE_Ice.blocked(unit)
    if not FE_Combat.alive(unit) then return false end
    for _, cast in ipairs(FE_Ice.casts) do
        if FE_Combat.alive(cast.unit) and IsUnitEnemy(unit, GetOwningPlayer(cast.unit)) and
            FE_Combat.inRange(unit, GetUnitX(cast.unit), GetUnitY(cast.unit), 2000) then return true end
    end
    return false
end

function FE_Ice.cap(unit)
    local cap = FE_Ice.health[unit]
    if not cap then return end
    local life = GetWidgetLife(unit)
    if FE_Combat.alive(unit) and FE_Ice.blocked(unit) then
        if life > cap then FE_Ice.setLife(unit, cap) else FE_Ice.health[unit] = life end
    end
end

function FE_Ice.beforeDamage()
    FE_Ice.cap(udg_DamageEventTarget)
end

function FE_Ice.onDamage()
    local unit = udg_DamageEventTarget
    local cap = FE_Ice.health[unit]
    if cap and FE_Ice.blocked(unit) then
        if udg_DamageEventAmount < 0 then udg_DamageEventAmount = 0 end
        -- OnDamage runs after armor but before HP is deducted. Record that loss
        -- now, so a native heal between damage and the next timer isn't missed.
        if udg_DamageEventAmount > 0 then
            FE_Ice.health[unit] = math.max(0, math.min(cap, GetWidgetLife(unit)) - udg_DamageEventAmount)
        end
    end
end

function FE_Ice.start(unit)
    for index = #FE_Ice.casts, 1, -1 do
        if FE_Ice.casts[index].unit == unit then table.remove(FE_Ice.casts, index) end
    end
    SetWidgetLife(unit, GetWidgetLife(unit)*0.60)
    FE_Ice.casts[#FE_Ice.casts+1] = {unit=unit, remaining=800, pulse=0}
    FE_Ice.refreshTargets()
end

function FE_Ice.refreshTargets()
    local desired, ordered = {}, {}
    for _, cast in ipairs(FE_Ice.casts) do
        if FE_Combat.alive(cast.unit) then
            FE_Combat.near(cast.unit, 2000, function(unit)
                if IsUnitEnemy(unit, GetOwningPlayer(cast.unit)) and not desired[unit] then
                    desired[unit] = true
                    ordered[#ordered+1] = unit
                    if not FE_Ice.health[unit] then
                        FE_Ice.health[unit] = GetWidgetLife(unit)
                        FE_Combat.hiddenAbility(unit, "AFIS", 1)
                    else FE_Ice.cap(unit) end
                end
            end)
        end
    end
    for _, unit in ipairs(FE_Ice.targets) do
        if not desired[unit] then
            FE_Ice.health[unit] = nil
            FE_Combat.hiddenAbility(unit, "AFIS", 0)
            UnitRemoveAbility(unit, FourCC("BFIS"))
        end
    end
    FE_Ice.targets = ordered
end

function FE_Ice.tick()
    for index = #FE_Ice.casts, 1, -1 do
        local cast = FE_Ice.casts[index]
        if not FE_Combat.alive(cast.unit) then table.remove(FE_Ice.casts, index)
        else
            cast.remaining, cast.pulse = cast.remaining - 1, cast.pulse + 1
            if cast.pulse == 32 then
                cast.pulse = 0
                SetWidgetLife(cast.unit, GetWidgetLife(cast.unit) + 400)
            end
            if cast.remaining <= 0 then table.remove(FE_Ice.casts, index) end
        end
    end
    FE_Ice.refreshTargets()
end

function FE_Ice.init()
    if FE_Ice.initialized then return end
    FE_Ice.initialized = true
    FE_Ice.setLife = SetWidgetLife
    local setState = SetUnitState
    SetWidgetLife = function(widget, life)
        -- Widget may also be an item/destructable: only inspect known units.
        if FE_Ice.health[widget] and FE_Ice.blocked(widget) and life > GetWidgetLife(widget) then return end
        FE_Ice.setLife(widget, life)
        if FE_Ice.health[widget] and life < FE_Ice.health[widget] then FE_Ice.health[widget] = math.max(0, life) end
    end
    SetUnitState = function(unit, state, value)
        if state == UNIT_STATE_LIFE and FE_Ice.blocked(unit) and value > GetWidgetLife(unit) then return end
        setState(unit, state, value)
        if state == UNIT_STATE_LIFE and FE_Ice.health[unit] and value < FE_Ice.health[unit] then FE_Ice.health[unit] = math.max(0, value) end
    end
    FE_Combat.listen("udg_PreDamageEvent", -100, FE_Ice.beforeDamage)
    FE_Combat.listen("udg_DamageEvent", 100, FE_Ice.onDamage)
    local timer = CreateTimer()
    TimerStart(timer, 0.03125, true, FE_Ice.tick)
end


-- ancients / avalanche
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 176 Chill
function Trig_Chill_Conditions()
    return GetSpellAbilityId() == FourCC("A00A")
end

function Trig_Chill_Actions()
    local caster = GetSpellAbilityUnit()
    TriggerSleepAction(__jreal(0.80))
    SetUnitLifeBJ(caster, (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, caster) + (__jreal(__jreal(0.50) * GetUnitStateSwap(UNIT_STATE_MAX_MANA, caster))))))
end

function InitTrig_Chill()
    gg_trg_Chill = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Chill, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Chill, Condition(Trig_Chill_Conditions))
    TriggerAddAction(gg_trg_Chill, Trig_Chill_Actions)
end
-- END FOREST SECTION 176

-- BEGIN FOREST SECTION 177 Freeze_Zone
function Trig_Freeze_Zone_Conditions()
    return GetSpellAbilityId() == FourCC("A0EX")
end

function Trig_Freeze_Zone_Actions()
    local timer = CreateTimer()
    TimerStart(timer, 60, false, nil)
    local dialog = CreateTimerDialog(timer)
    TimerDialogSetTitle(dialog, "TRIGSTR_7241")
    TimerDialogDisplay(dialog, true)
    TriggerSleepAction(__jreal(60))
    DestroyTimerDialog(dialog)
    DestroyTimer(timer)
end

function InitTrig_Freeze_Zone()
    gg_trg_Freeze_Zone = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Freeze_Zone, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Freeze_Zone, Condition(Trig_Freeze_Zone_Conditions))
    TriggerAddAction(gg_trg_Freeze_Zone, Trig_Freeze_Zone_Actions)
end
-- END FOREST SECTION 177

-- BEGIN FOREST SECTION 178 Freeze_Zone_V2
function TP_IsValidTarget(caster, target)
    return (((((((target ~= nil) and (target ~= caster)) and (GetWidgetLife(target) > __jreal(0.405))) and IsUnitEnemy(target, GetOwningPlayer(caster))) and (not IsUnitType(target, UNIT_TYPE_DEAD))) and (not IsUnitType(target, UNIT_TYPE_STRUCTURE))) and (not IsUnitType(target, UNIT_TYPE_MAGIC_IMMUNE)))
end

function TP_DummyCastDelayed()
    local t = GetExpiredTimer()
    local tid = GetHandleId(t)
    local dummy = LoadUnitHandle(TP_HASH, tid, 0)
    local target = LoadUnitHandle(TP_HASH, tid, 1)
    if (((dummy ~= nil) and (target ~= nil)) and (GetWidgetLife(target) > __jreal(0.405))) then
        IssueTargetOrder(dummy, TP_DEBUFF_ORDER, target)
        UnitApplyTimedLife(dummy, FourCC("BTLF"), TP_DUMMY_LIFETIME)
    elseif (dummy ~= nil) then
        UnitApplyTimedLife(dummy, FourCC("BTLF"), TP_DUMMY_LIFETIME)
    end
    FlushChildHashtable(TP_HASH, tid)
    DestroyTimer(t)
    target = nil
    dummy = nil
    t = nil
end

function TP_CastDebuff(target, level)
    local t = CreateTimer()
    local tid = GetHandleId(t)
    local dummy = CreateUnit(TP_DUMMY_OWNER, TP_DUMMY_ID, __jreal(GetUnitX(target) + __jreal(150.00)), GetUnitY(target), __jreal(0.00))
    if (dummy == nil) then
        DestroyTimer(t)
        dummy = nil
        t = nil
        return
    end
    UnitAddAbility(dummy, TP_DEBUFF_ID)
    SetUnitAbilityLevel(dummy, TP_DEBUFF_ID, level)
    SetUnitState(dummy, UNIT_STATE_MANA, __jreal(9999.00))
    SaveUnitHandle(TP_HASH, tid, 0, dummy)
    SaveUnitHandle(TP_HASH, tid, 1, target)
    TimerStart(t, TP_DUMMY_CAST_DELAY, false, TP_DummyCastDelayed)
    dummy = nil
    t = nil
end

function TP_OnCast()
    local caster = GetTriggerUnit()
    local g = CreateGroup()
    local target = nil
    local x = GetUnitX(caster)
    local y = GetUnitY(caster)
    local level = GetUnitAbilityLevel(caster, TP_SPELL_ID)
    local damage = __jreal(TP_DAMAGE_BASE + __jreal(TP_DAMAGE_PER_LEVEL * I2R(__jint(level - 1))))
    GroupEnumUnitsInRange(g, x, y, TP_AOE, nil)
    while true do
        target = FirstOfGroup(g)
        if (target == nil) then break end
        GroupRemoveUnit(g, target)
        if TP_IsValidTarget(caster, target) then
            UnitDamageTarget(caster, target, damage, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
            if (GetWidgetLife(target) > __jreal(0.405)) then
                TP_CastDebuff(target, level)
            end
        end
    end
    DestroyGroup(g)
    target = nil
    g = nil
    caster = nil
end

function TP_Condition()
    return (GetSpellAbilityId() == TP_SPELL_ID)
end

function InitTrig_Freeze_Zone_V2()
    local t = CreateTrigger()
    local i = 0
    if (TP_HASH == nil) then
        TP_HASH = InitHashtable()
    end
    while true do
        if (i >= bj_MAX_PLAYER_SLOTS) then break end
        TriggerRegisterPlayerUnitEvent(t, Player(i), EVENT_PLAYER_UNIT_SPELL_EFFECT, nil)
        i = __jint(i + 1)
    end
    TriggerAddCondition(t, Condition(TP_Condition))
    TriggerAddAction(t, TP_OnCast)
    t = nil
end
-- END FOREST SECTION 178
