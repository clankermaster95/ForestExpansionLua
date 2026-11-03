-- races / ratling
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 125 Chemical_Rage
-- Original JASS function: CHEMICAL_RAGE_ABILITY (line 10125)
function CHEMICAL_RAGE_ABILITY()
    do return FourCC("A0CU") end
end

-- Original JASS function: DUMMY_ABILITY (line 10129)
function DUMMY_ABILITY()
    do return FourCC("A0CV") end
end

-- Original JASS function: DUMMY_UNIT_ID (line 10133)
function DUMMY_UNIT_ID()
    do return FourCC("h04L") end
end

-- Original JASS function: ChemicalRageCondition (line 10140)
function ChemicalRageCondition()
    do return (GetSpellAbilityId() == (FourCC("A0CU"))) end
end

-- Original JASS function: ChemicalRageActions (line 10147)
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
        do return end
    end
    if ((caster ~= nil) and (not IsUnitType(caster, UNIT_TYPE_DEAD))) then
        BlzSetUnitWeaponRealField(caster, UNIT_WEAPON_RF_ATTACK_BASE_COOLDOWN, 0, __jreal(1.75))
    end
    caster = nil
    p = nil
end

-- Original JASS function: InitTrig_Chemical_Rage (line 10187)
function InitTrig_Chemical_Rage()
    local t = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_SPELL_FINISH)
    TriggerAddCondition(t, Condition(ChemicalRageCondition))
    TriggerAddAction(t, ChemicalRageActions)
end
-- END FOREST SECTION 125

-- BEGIN FOREST SECTION 126 ReduceMagicResist
-- Original JASS function: Trig_ReduceMagicResist_Conditions (line 10196)
function Trig_ReduceMagicResist_Conditions()
    if ((not ((UnitHasBuffBJ(udg_DamageEventTarget, FourCC("B03O")) == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_ReduceMagicResist_Actions (line 10203)
function Trig_ReduceMagicResist_Actions()
    UnitAddAbilityBJ(FourCC("A0CT"), udg_DamageEventTarget)
    GroupAddUnitSimple(udg_DamageEventTarget, udg_Acided)
end

-- Original JASS function: InitTrig_ReduceMagicResist (line 10209)
function InitTrig_ReduceMagicResist()
    gg_trg_ReduceMagicResist = CreateTrigger()
    h__TriggerRegisterVariableEvent(gg_trg_ReduceMagicResist, "udg_DamageEvent", EQUAL, __jreal(1.00))
    TriggerAddCondition(gg_trg_ReduceMagicResist, Condition(Trig_ReduceMagicResist_Conditions))
    TriggerAddAction(gg_trg_ReduceMagicResist, Trig_ReduceMagicResist_Actions)
end
-- END FOREST SECTION 126

-- BEGIN FOREST SECTION 127 ReduceMagicResist2
-- Original JASS function: Trig_ReduceMagicResist2_Func001Func001C (line 10219)
function Trig_ReduceMagicResist2_Func001Func001C()
    if ((not ((UnitHasBuffBJ(GetEnumUnit(), FourCC("B03O")) == false)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_ReduceMagicResist2_Func001A (line 10226)
function Trig_ReduceMagicResist2_Func001A()
    if (Trig_ReduceMagicResist2_Func001Func001C()) then
    else
        UnitRemoveAbilityBJ(FourCC("A0CT"), GetEnumUnit())
        GroupRemoveUnitSimple(GetEnumUnit(), udg_Acided)
    end
end

-- Original JASS function: Trig_ReduceMagicResist2_Actions (line 10234)
function Trig_ReduceMagicResist2_Actions()
    ForGroupBJ(udg_Acided, Trig_ReduceMagicResist2_Func001A)
end

-- Original JASS function: InitTrig_ReduceMagicResist2 (line 10239)
function InitTrig_ReduceMagicResist2()
    gg_trg_ReduceMagicResist2 = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(gg_trg_ReduceMagicResist2, __jreal(0.50))
    TriggerAddAction(gg_trg_ReduceMagicResist2, Trig_ReduceMagicResist2_Actions)
end
-- END FOREST SECTION 127

-- BEGIN FOREST SECTION 128 TargetAcquired
-- Original JASS function: Trig_TargetAcquired_Conditions (line 10248)
function Trig_TargetAcquired_Conditions()
    if ((not ((GetPlayerTechCountSimple(FourCC("R06S"), GetOwningPlayer(udg_DamageEventSource)) == 1)))) then
        do return false end
    end
    if ((not ((udg_IsDamageAttack == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_TargetAcquired_Func004C (line 10258)
function Trig_TargetAcquired_Func004C()
    if ((not ((GetRandomReal(__jreal(0.00), __jreal(100.00)) <= __jreal(30.00))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_TargetAcquired_Actions (line 10265)
function Trig_TargetAcquired_Actions()
    if (Trig_TargetAcquired_Func004C()) then
        if (not s__DamageTrigger_configured[s__DamageTrigger_eventIndex]) then
            udg_DamageFilterSourceT = FourCC("o026")
            s__DamageTrigger_configure(s__DamageTrigger_eventIndex)
        end
        if (not s__DamageTrigger_checkConfig(s__DamageTrigger_eventIndex)) then
            do return end
        end
        udg_DamageEventAttackT = udg_ATTACK_TYPE_CHAOS
        udg_DamageEventArmorPierced = __jreal(10.00)
        udg_TSEDuration = __jreal(1.00)
        udg_TSEScale = __jreal(0.75)
        udg_TSEAttachPoint = "overhead"
        udg_TSEEffectName = "war3mapImported\\SnipingTarget.mdx"
        udg_TSETargetUnit = udg_DamageEventTarget
        ConditionalTriggerExecute(udg_TSE_RegisterTrigger)
    else
    end
end

-- Original JASS function: InitTrig_TargetAcquired (line 10291)
function InitTrig_TargetAcquired()
    gg_trg_TargetAcquired = CreateTrigger()
    h__TriggerRegisterVariableEvent(gg_trg_TargetAcquired, "udg_PreDamageEvent", LESS_THAN, __jreal(1.00))
    TriggerAddCondition(gg_trg_TargetAcquired, Condition(Trig_TargetAcquired_Conditions))
    TriggerAddAction(gg_trg_TargetAcquired, Trig_TargetAcquired_Actions)
end
-- END FOREST SECTION 128

-- BEGIN FOREST SECTION 129 Poisoned_Bullets2
-- Original JASS function: Trig_Poisoned_Bullets2_Conditions (line 10301)
function Trig_Poisoned_Bullets2_Conditions()
    if ((not ((GetPlayerTechCountSimple(FourCC("R06R"), GetOwningPlayer(GetAttacker())) >= 1)))) then
        do return false end
    end
    if ((not ((GetUnitTypeId(GetAttacker()) == FourCC("o026"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Poisoned_Bullets2_Actions (line 10311)
function Trig_Poisoned_Bullets2_Actions()
    if ((GetUnitAbilityLevel(GetAttackedUnitBJ(), FourCC("Bspo")) == 0)) then
        SetUnitAbilityLevelSwapped(FourCC("A0CQ"), GetAttackedUnitBJ(), 1)
    end
    SetUnitAbilityLevelSwapped(FourCC("A0CO"), GetAttacker(), GetUnitAbilityLevel((GetAttackedUnitBJ()), FourCC("A0CQ")))
end

-- Original JASS function: InitTrig_Poisoned_Bullets2 (line 10319)
function InitTrig_Poisoned_Bullets2()
    gg_trg_Poisoned_Bullets2 = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Poisoned_Bullets2, EVENT_PLAYER_UNIT_ATTACKED)
    TriggerAddCondition(gg_trg_Poisoned_Bullets2, Condition(Trig_Poisoned_Bullets2_Conditions))
    TriggerAddAction(gg_trg_Poisoned_Bullets2, Trig_Poisoned_Bullets2_Actions)
end
-- END FOREST SECTION 129

-- BEGIN FOREST SECTION 130 Poisoned_Bullets
-- Original JASS function: Trig_Poisoned_Bullets_Conditions (line 10330)
function Trig_Poisoned_Bullets_Conditions()
    if ((not ((GetPlayerTechCountSimple(FourCC("R06R"), GetOwningPlayer(udg_DamageEventSource)) >= 1)))) then
        do return false end
    end
    if ((not ((GetUnitTypeId(udg_DamageEventSource) == FourCC("o026"))))) then
        do return false end
    end
    if ((not ((udg_IsDamageAttack == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Poisoned_Bullets_Actions (line 10343)
function Trig_Poisoned_Bullets_Actions()
    local var = 0
    if ((GetUnitAbilityLevel(udg_DamageEventTarget, FourCC("Bspo")) > 0)) then
        if ((GetUnitAbilityLevel(udg_DamageEventTarget, FourCC("A0CQ")) == 0)) then
            UnitAddAbility(udg_DamageEventTarget, FourCC("A0CQ"))
        end
        var = GetUnitAbilityLevel((udg_DamageEventTarget), FourCC("A0CQ"))
        IncUnitAbilityLevelSwapped(FourCC("A0CQ"), udg_DamageEventTarget)
    end
end

-- Original JASS function: InitTrig_Poisoned_Bullets (line 10355)
function InitTrig_Poisoned_Bullets()
    gg_trg_Poisoned_Bullets = CreateTrigger()
    h__TriggerRegisterVariableEvent(gg_trg_Poisoned_Bullets, "udg_PreDamageEvent", EQUAL, __jreal(1.00))
    TriggerAddCondition(gg_trg_Poisoned_Bullets, Condition(Trig_Poisoned_Bullets_Conditions))
    TriggerAddAction(gg_trg_Poisoned_Bullets, Trig_Poisoned_Bullets_Actions)
end
-- END FOREST SECTION 130

-- BEGIN FOREST SECTION 131 Permanent_Invisibility
-- Original JASS function: Trig_Permanent_Invisibility_Conditions (line 10366)
function Trig_Permanent_Invisibility_Conditions()
    if ((not ((GetResearched() == FourCC("R06K"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Permanent_Invisibility_Func001A (line 10373)
function Trig_Permanent_Invisibility_Func001A()
    UnitAddAbilityBJ(FourCC("A0CK"), GetEnumUnit())
    udg_SilentStrider[GetConvertedPlayerId(GetOwningPlayer(GetResearchingUnit()))] = true
end

-- Original JASS function: Trig_Permanent_Invisibility_Actions (line 10378)
function Trig_Permanent_Invisibility_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(GetOwningPlayer(GetResearchingUnit()), FourCC("o026")), Trig_Permanent_Invisibility_Func001A)
end

-- Original JASS function: InitTrig_Permanent_Invisibility (line 10383)
function InitTrig_Permanent_Invisibility()
    gg_trg_Permanent_Invisibility = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Permanent_Invisibility, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Permanent_Invisibility, Condition(Trig_Permanent_Invisibility_Conditions))
    TriggerAddAction(gg_trg_Permanent_Invisibility, Trig_Permanent_Invisibility_Actions)
end
-- END FOREST SECTION 131

-- BEGIN FOREST SECTION 132 Permanent_Invisibility_2
-- Original JASS function: Trig_Permanent_Invisibility_2_Conditions (line 10393)
function Trig_Permanent_Invisibility_2_Conditions()
    if ((not ((udg_SilentStrider[GetConvertedPlayerId(GetOwningPlayer(GetEnteringUnit()))] == true)))) then
        do return false end
    end
    if ((not ((GetUnitTypeId(GetEnteringUnit()) == FourCC("o026"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Permanent_Invisibility_2_Func002A (line 10403)
function Trig_Permanent_Invisibility_2_Func002A()
    UnitAddAbilityBJ(FourCC("A0CK"), GetEnumUnit())
end

-- Original JASS function: Trig_Permanent_Invisibility_2_Actions (line 10407)
function Trig_Permanent_Invisibility_2_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(GetOwningPlayer(GetResearchingUnit()), FourCC("o026")), Trig_Permanent_Invisibility_2_Func002A)
end

-- Original JASS function: InitTrig_Permanent_Invisibility_2 (line 10412)
function InitTrig_Permanent_Invisibility_2()
    gg_trg_Permanent_Invisibility_2 = CreateTrigger()
    TriggerRegisterEnterRectSimple(gg_trg_Permanent_Invisibility_2, GetPlayableMapRect())
    TriggerAddCondition(gg_trg_Permanent_Invisibility_2, Condition(Trig_Permanent_Invisibility_2_Conditions))
    TriggerAddAction(gg_trg_Permanent_Invisibility_2, Trig_Permanent_Invisibility_2_Actions)
end
-- END FOREST SECTION 132

-- BEGIN FOREST SECTION 133 Sticky_Glue
-- Original JASS function: Trig_Sticky_Glue_Conditions (line 10422)
function Trig_Sticky_Glue_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A0CL"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Sticky_Glue_Actions (line 10429)
function Trig_Sticky_Glue_Actions()
    CreateNUnitsAtLoc(1, FourCC("n010"), GetOwningPlayer(GetSpellAbilityUnit()), GetSpellTargetLoc(), bj_UNIT_FACING)
    UnitApplyTimedLifeBJ(__jreal(6.00), FourCC("BTLF"), GetLastCreatedUnit())
end

-- Original JASS function: InitTrig_Sticky_Glue (line 10435)
function InitTrig_Sticky_Glue()
    gg_trg_Sticky_Glue = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Sticky_Glue, EVENT_PLAYER_UNIT_SPELL_CAST)
    TriggerAddCondition(gg_trg_Sticky_Glue, Condition(Trig_Sticky_Glue_Conditions))
    TriggerAddAction(gg_trg_Sticky_Glue, Trig_Sticky_Glue_Actions)
end
-- END FOREST SECTION 133
