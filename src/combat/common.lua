-- Shared combat utilities. All state and native mutations run synchronously.
FE_Combat = { dots = {}, dotByTarget = {}, initialized = false }

function FE_Combat.alive(unit)
    return unit ~= nil and GetUnitTypeId(unit) ~= 0 and GetWidgetLife(unit) > 0.405
end

function FE_Combat.inRange(unit, x, y, radius)
    local dx, dy = GetUnitX(unit) - x, GetUnitY(unit) - y
    return dx*dx + dy*dy <= radius*radius
end

function FE_Combat.near(unit, radius, action)
    local group = CreateGroup()
    GroupEnumUnitsInRange(group, GetUnitX(unit), GetUnitY(unit), radius, nil)
    while true do
        local target = FirstOfGroup(group)
        if not target then break end
        GroupRemoveUnit(group, target)
        if FE_Combat.alive(target) then action(target) end
    end
    DestroyGroup(group)
end

function FE_Combat.hiddenAbility(unit, raw, level)
    local id = FourCC(raw)
    if level == 0 then UnitRemoveAbility(unit, id); return end
    if GetUnitAbilityLevel(unit, id) == 0 then
        UnitAddAbility(unit, id)
        UnitMakeAbilityPermanent(unit, true, id)
        BlzUnitHideAbility(unit, id, true)
    end
    SetUnitAbilityLevel(unit, id, level)
end

function FE_Combat.damage(source, target, amount, damageType, nonlethal)
    if nonlethal then udg_NextDamageType = 101 end
    UnitDamageTarget(source, target, amount, false, false, ATTACK_TYPE_NORMAL, damageType, WEAPON_TYPE_WHOKNOWS)
end

function FE_Combat.debuff(source, target, ability, buff, level)
    -- A self-only negative aura has no attack/orb slot and retains the original
    -- poison's non-dispellable behavior. Buff removal cannot stop the DoT clock.
    FE_Combat.hiddenAbility(target, ability, level)
end

function FE_Combat.limitPoison()
    if udg_DamageEventType == 101 and udg_DamageEventAmount > 0 then
        udg_DamageEventAmount = math.min(udg_DamageEventAmount, math.max(0, GetWidgetLife(udg_DamageEventTarget) - 2))
    end
end

function FE_Combat.applyDot(source, target, kind, level)
    if not FE_Combat.alive(target) or IsUnitType(target, UNIT_TYPE_STRUCTURE) or IsUnitType(target, UNIT_TYPE_MECHANICAL) then return end
    local byKind = FE_Combat.dotByTarget[target]
    if not byKind then byKind = {}; FE_Combat.dotByTarget[target] = byKind end
    local dot = byKind[kind]
    local poison = kind == "poison"
    local buff = poison and "B03M" or "B015"
    if poison then
        level = dot and math.min(dot.level + 1, 6) or 1
    end
    if not dot then
        dot = {target=target, kind=kind, pulse=0}
        byKind[kind] = dot
        FE_Combat.dots[#FE_Combat.dots+1] = dot
    end
    dot.source, dot.level, dot.remaining, dot.buff = source, level, poison and 4 or 3, buff
    dot.damage = poison and 40*level or 25+5*(level-1)
    FE_Combat.debuff(source, target, poison and "AFPB" or "AFBL", buff, level)
end

function FE_Combat.attackLanded()
    if not udg_IsDamageAttack or udg_DamageEventAmount <= 0 then return end
    local source, target = udg_DamageEventSource, udg_DamageEventTarget
    if not source or not target then return end
    local bleed = GetUnitAbilityLevel(source, FourCC("A04C"))
    if bleed > 0 and GetPlayerTechCount(GetOwningPlayer(source), FourCC("R03H"), true) > 0 then
        FE_Combat.applyDot(source, target, "bleed", math.min(bleed, 21))
    end
    if GetUnitTypeId(source) == FourCC("o026") and GetPlayerTechCount(GetOwningPlayer(source), FourCC("R06R"), true) > 0 then
        FE_Combat.applyDot(source, target, "poison", 1)
    end
end

function FE_Combat.tickDots()
    for index = #FE_Combat.dots, 1, -1 do
        local dot = FE_Combat.dots[index]
        if not FE_Combat.alive(dot.target) or GetUnitTypeId(dot.source) == 0 then
            FE_Combat.hiddenAbility(dot.target, dot.kind == "poison" and "AFPB" or "AFBL", 0)
            UnitRemoveAbility(dot.target, FourCC(dot.buff))
            FE_Combat.dotByTarget[dot.target][dot.kind] = nil
            if not next(FE_Combat.dotByTarget[dot.target]) then FE_Combat.dotByTarget[dot.target] = nil end
            table.remove(FE_Combat.dots, index)
        else
            dot.pulse, dot.remaining = dot.pulse + 0.25, dot.remaining - 0.25
            if dot.pulse >= 1 then
                dot.pulse = dot.pulse - 1
                FE_Combat.damage(dot.source, dot.target, dot.damage, DAMAGE_TYPE_SLOW_POISON, true)
            end
            if dot.remaining <= 0 then
                FE_Combat.dotByTarget[dot.target][dot.kind] = nil
                if not next(FE_Combat.dotByTarget[dot.target]) then FE_Combat.dotByTarget[dot.target] = nil end
                FE_Combat.hiddenAbility(dot.target, dot.kind == "poison" and "AFPB" or "AFBL", 0)
                UnitRemoveAbility(dot.target, FourCC(dot.buff))
                table.remove(FE_Combat.dots, index)
            end
        end
    end
end

function FE_Combat.listen(event, order, action)
    local trigger = CreateTrigger()
    h__TriggerRegisterVariableEvent(trigger, event, EQUAL, order)
    TriggerAddAction(trigger, action)
    return trigger
end

function FE_Combat.init()
    if FE_Combat.initialized then return end
    FE_Combat.initialized = true
    FE_Combat.listen("udg_DamageEvent", 1, FE_Combat.attackLanded)
    FE_Combat.listen("udg_DamageEvent", 99, FE_Combat.limitPoison)
    -- Keep a Lua owner for the repeating native timer and its callback.
    FE_Combat.timer = CreateTimer()
    TimerStart(FE_Combat.timer, 0.25, true, FE_Combat.tickDots)
end

-- combat / common
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 20 Ancient_In_Combat
function Trig_Ancient_In_Combat_Conditions()
    if (not (udg_DamageEventAmount >= __jreal(100.00))) then
        return false
    end
    if (not (udg_DamageEventTarget == udg_AncientUnit)) then
        return false
    end
    return true
end

function Trig_Ancient_In_Combat_Actions()
    udg_AncientInCombat = __jreal(1.00)
end

function InitTrig_Ancient_In_Combat()
    FE_Combat.init()
    gg_trg_Ancient_In_Combat = CreateTrigger()
    h__TriggerRegisterVariableEvent(gg_trg_Ancient_In_Combat, "udg_DamageModifierEvent", EQUAL, __jreal(1.00))
    TriggerAddCondition(gg_trg_Ancient_In_Combat, Condition(Trig_Ancient_In_Combat_Conditions))
    TriggerAddAction(gg_trg_Ancient_In_Combat, Trig_Ancient_In_Combat_Actions)
end
-- END FOREST SECTION 20

-- BEGIN FOREST SECTION 27 Detonate

function Trig_Detonate_Conditions()
    return not not (GetBooleanOr((GetSpellAbilityId() == FourCC("A08G")), (GetSpellAbilityId() == FourCC("A0F2"))))
end

function Trig_Detonate_Actions()
    KillUnit(GetTriggerUnit())
end

function InitTrig_Detonate()
    gg_trg_Detonate = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Detonate, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Detonate, Condition(Trig_Detonate_Conditions))
    TriggerAddAction(gg_trg_Detonate, Trig_Detonate_Actions)
end
-- END FOREST SECTION 27

-- BEGIN FOREST SECTION 28 Expander_Hero_XP
function Trig_Expander_Hero_XP_Conditions()
    if (not (IsUnitType(udg_DamageEventSource, UNIT_TYPE_HERO) == true)) then
        return false
    end
    if (not (IsUnitType(udg_DamageEventTarget, UNIT_TYPE_HERO) == true)) then
        return false
    end
    if (not (udg_IsDamageAttack == true)) then
        return false
    end
    if (not (IsUnitAlly(udg_DamageEventTarget, FE_Roles.ancient()) == true)) then
        return false
    end
    if (not (IsUnitEnemy(udg_DamageEventSource, FE_Roles.ancient()) == true)) then
        return false
    end
    return true
end

function Trig_Expander_Hero_XP_Actions()
    AddHeroXPSwapped(50, udg_DamageEventSource, true)
end

function InitTrig_Expander_Hero_XP()
    gg_trg_Expander_Hero_XP = CreateTrigger()
    h__TriggerRegisterVariableEvent(gg_trg_Expander_Hero_XP, "udg_DamageEvent", EQUAL, __jreal(1.00))
    TriggerAddCondition(gg_trg_Expander_Hero_XP, Condition(Trig_Expander_Hero_XP_Conditions))
    TriggerAddAction(gg_trg_Expander_Hero_XP, Trig_Expander_Hero_XP_Actions)
end
-- END FOREST SECTION 28
