-- races / ratling
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 125 Chemical_Rage
function CHEMICAL_RAGE_ABILITY()
    return FourCC("A0CU")
end

function DUMMY_ABILITY()
    return FourCC("A0CV")
end

function DUMMY_UNIT_ID()
    return FourCC("h04L")
end

function ChemicalRageCondition()
    return (GetSpellAbilityId() == (FourCC("A0CU")))
end

function ChemicalRageActions()
    local caster = GetTriggerUnit()
    local p = GetOwningPlayer(caster)
    local dummy = nil
    local i = 0
    dummy = CreateUnit(p, (FourCC("h04L")), GetUnitX(caster), GetUnitY(caster), __jreal(0))
    UnitAddAbility(dummy, (FourCC("A0CV")))
    IssueTargetOrder(dummy, "bloodlust", caster)
    BlzSetUnitWeaponRealField(caster, UNIT_WEAPON_RF_ATTACK_BASE_COOLDOWN, 0, __jreal(1.25))
    TriggerSleepAction(__jreal(20.0))
    RemoveUnit(dummy)
    dummy = nil
    if ((caster == nil) or IsUnitType(caster, UNIT_TYPE_DEAD)) then
        caster = nil
        p = nil
        return
    end
    if ((caster ~= nil) and (not IsUnitType(caster, UNIT_TYPE_DEAD))) then
        BlzSetUnitWeaponRealField(caster, UNIT_WEAPON_RF_ATTACK_BASE_COOLDOWN, 0, __jreal(1.75))
    end
    caster = nil
    p = nil
end

function InitTrig_Chemical_Rage()
    local t = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_SPELL_FINISH)
    TriggerAddCondition(t, Condition(ChemicalRageCondition))
    TriggerAddAction(t, ChemicalRageActions)
end
-- END FOREST SECTION 125

-- BEGIN FOREST SECTION 126 ReduceMagicResist
function Trig_ReduceMagicResist_Conditions()
    return UnitHasBuffBJ(udg_DamageEventTarget, FourCC("B03O")) == true
end

function Trig_ReduceMagicResist_Actions()
    UnitAddAbilityBJ(FourCC("A0CT"), udg_DamageEventTarget)
    GroupAddUnitSimple(udg_DamageEventTarget, udg_Acided)
end

function InitTrig_ReduceMagicResist()
    gg_trg_ReduceMagicResist = CreateTrigger()
    h__TriggerRegisterVariableEvent(gg_trg_ReduceMagicResist, "udg_DamageEvent", EQUAL, __jreal(1.00))
    TriggerAddCondition(gg_trg_ReduceMagicResist, Condition(Trig_ReduceMagicResist_Conditions))
    TriggerAddAction(gg_trg_ReduceMagicResist, Trig_ReduceMagicResist_Actions)
end
-- END FOREST SECTION 126

-- BEGIN FOREST SECTION 127 ReduceMagicResist2
function Trig_ReduceMagicResist2_Func001Func001C()
    return UnitHasBuffBJ(GetEnumUnit(), FourCC("B03O")) == false
end

function Trig_ReduceMagicResist2_Func001A()
    if (Trig_ReduceMagicResist2_Func001Func001C()) then
    else
        UnitRemoveAbilityBJ(FourCC("A0CT"), GetEnumUnit())
        GroupRemoveUnitSimple(GetEnumUnit(), udg_Acided)
    end
end

function Trig_ReduceMagicResist2_Actions()
    ForGroupBJ(udg_Acided, Trig_ReduceMagicResist2_Func001A)
end

function InitTrig_ReduceMagicResist2()
    gg_trg_ReduceMagicResist2 = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(gg_trg_ReduceMagicResist2, __jreal(0.50))
    TriggerAddAction(gg_trg_ReduceMagicResist2, Trig_ReduceMagicResist2_Actions)
end
-- END FOREST SECTION 127

-- BEGIN FOREST SECTION 128 TargetAcquired
function Trig_TargetAcquired_Conditions()
    if (not (GetPlayerTechCountSimple(FourCC("R06S"), GetOwningPlayer(udg_DamageEventSource)) == 1)) then
        return false
    end
    if (not (udg_IsDamageAttack == true)) then
        return false
    end
    return true
end

function Trig_TargetAcquired_Func004C()
    return GetRandomReal(__jreal(0.00), __jreal(100.00)) <= __jreal(30.00)
end

function Trig_TargetAcquired_Actions()
    if (Trig_TargetAcquired_Func004C()) then
        if (not s__DamageTrigger_configured[s__DamageTrigger_eventIndex]) then
            udg_DamageFilterSourceT = FourCC("o026")
            s__DamageTrigger_configure(s__DamageTrigger_eventIndex)
        end
        if (not s__DamageTrigger_checkConfig(s__DamageTrigger_eventIndex)) then
            return
        end
        udg_DamageEventAttackT = udg_ATTACK_TYPE_CHAOS
        udg_DamageEventArmorPierced = __jreal(10.00)
        udg_TSEDuration = __jreal(1.00)
        udg_TSEScale = __jreal(0.75)
        udg_TSEAttachPoint = "overhead"
        udg_TSEEffectName = "war3mapImported\\SnipingTarget.mdx"
        udg_TSETargetUnit = udg_DamageEventTarget
        ConditionalTriggerExecute(udg_TSE_RegisterTrigger)
    end
end

function InitTrig_TargetAcquired()
    gg_trg_TargetAcquired = CreateTrigger()
    h__TriggerRegisterVariableEvent(gg_trg_TargetAcquired, "udg_PreDamageEvent", LESS_THAN, __jreal(1.00))
    TriggerAddCondition(gg_trg_TargetAcquired, Condition(Trig_TargetAcquired_Conditions))
    TriggerAddAction(gg_trg_TargetAcquired, Trig_TargetAcquired_Actions)
end
-- END FOREST SECTION 128

-- BEGIN FOREST SECTION 129 Poisoned_Bullets2
function Trig_Poisoned_Bullets2_Conditions()
    if (not (GetPlayerTechCountSimple(FourCC("R06R"), GetOwningPlayer(GetAttacker())) >= 1)) then
        return false
    end
    if (not (GetUnitTypeId(GetAttacker()) == FourCC("o026"))) then
        return false
    end
    return true
end

function Trig_Poisoned_Bullets2_Actions()
    -- On-hit poison is owned by FE_Combat; attack-start events must not add stacks.
end

function InitTrig_Poisoned_Bullets2()
    gg_trg_Poisoned_Bullets2 = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Poisoned_Bullets2, EVENT_PLAYER_UNIT_ATTACKED)
    TriggerAddCondition(gg_trg_Poisoned_Bullets2, Condition(Trig_Poisoned_Bullets2_Conditions))
    TriggerAddAction(gg_trg_Poisoned_Bullets2, Trig_Poisoned_Bullets2_Actions)
end
-- END FOREST SECTION 129

-- BEGIN FOREST SECTION 130 Poisoned_Bullets
function Trig_Poisoned_Bullets_Conditions()
    if (not (GetPlayerTechCountSimple(FourCC("R06R"), GetOwningPlayer(udg_DamageEventSource)) >= 1)) then
        return false
    end
    if (not (GetUnitTypeId(udg_DamageEventSource) == FourCC("o026"))) then
        return false
    end
    if (not (udg_IsDamageAttack == true)) then
        return false
    end
    return true
end

function Trig_Poisoned_Bullets_Actions()
    -- On-hit poison is owned by FE_Combat; attack-start events must not add stacks.
end

function InitTrig_Poisoned_Bullets()
    gg_trg_Poisoned_Bullets = CreateTrigger()
    h__TriggerRegisterVariableEvent(gg_trg_Poisoned_Bullets, "udg_PreDamageEvent", EQUAL, __jreal(1.00))
    TriggerAddCondition(gg_trg_Poisoned_Bullets, Condition(Trig_Poisoned_Bullets_Conditions))
    TriggerAddAction(gg_trg_Poisoned_Bullets, Trig_Poisoned_Bullets_Actions)
end
-- END FOREST SECTION 130

-- BEGIN FOREST SECTION 131 Permanent_Invisibility
function Trig_Permanent_Invisibility_Conditions()
    return GetResearched() == FourCC("R06K")
end

function Trig_Permanent_Invisibility_Func001A()
    UnitAddAbilityBJ(FourCC("A0CK"), GetEnumUnit())
    udg_SilentStrider[GetConvertedPlayerId(GetOwningPlayer(GetResearchingUnit()))] = true
end

function Trig_Permanent_Invisibility_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(GetOwningPlayer(GetResearchingUnit()), FourCC("o026")), Trig_Permanent_Invisibility_Func001A)
end

function InitTrig_Permanent_Invisibility()
    gg_trg_Permanent_Invisibility = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Permanent_Invisibility, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Permanent_Invisibility, Condition(Trig_Permanent_Invisibility_Conditions))
    TriggerAddAction(gg_trg_Permanent_Invisibility, Trig_Permanent_Invisibility_Actions)
end
-- END FOREST SECTION 131

-- BEGIN FOREST SECTION 132 Permanent_Invisibility_2
function Trig_Permanent_Invisibility_2_Conditions()
    if (not (udg_SilentStrider[GetConvertedPlayerId(GetOwningPlayer(GetEnteringUnit()))] == true)) then
        return false
    end
    if (not (GetUnitTypeId(GetEnteringUnit()) == FourCC("o026"))) then
        return false
    end
    return true
end

function Trig_Permanent_Invisibility_2_Func002A()
    UnitAddAbilityBJ(FourCC("A0CK"), GetEnumUnit())
end

function Trig_Permanent_Invisibility_2_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(GetOwningPlayer(GetResearchingUnit()), FourCC("o026")), Trig_Permanent_Invisibility_2_Func002A)
end

function InitTrig_Permanent_Invisibility_2()
    gg_trg_Permanent_Invisibility_2 = CreateTrigger()
    TriggerRegisterEnterRectSimple(gg_trg_Permanent_Invisibility_2, GetPlayableMapRect())
    TriggerAddCondition(gg_trg_Permanent_Invisibility_2, Condition(Trig_Permanent_Invisibility_2_Conditions))
    TriggerAddAction(gg_trg_Permanent_Invisibility_2, Trig_Permanent_Invisibility_2_Actions)
end
-- END FOREST SECTION 132

-- BEGIN FOREST SECTION 133 Sticky_Glue
function Trig_Sticky_Glue_Conditions()
    return GetSpellAbilityId() == FourCC("A0CL")
end

function Trig_Sticky_Glue_Actions()
    CreateNUnitsAtLoc(1, FourCC("n010"), GetOwningPlayer(GetSpellAbilityUnit()), GetSpellTargetLoc(), bj_UNIT_FACING)
    UnitApplyTimedLifeBJ(__jreal(6.00), FourCC("BTLF"), GetLastCreatedUnit())
end

function InitTrig_Sticky_Glue()
    gg_trg_Sticky_Glue = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Sticky_Glue, EVENT_PLAYER_UNIT_SPELL_CAST)
    TriggerAddCondition(gg_trg_Sticky_Glue, Condition(Trig_Sticky_Glue_Conditions))
    TriggerAddAction(gg_trg_Sticky_Glue, Trig_Sticky_Glue_Actions)
end
-- END FOREST SECTION 133
