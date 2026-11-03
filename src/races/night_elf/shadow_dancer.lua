-- races / night_elf / shadow_dancer
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 52 ConjureRefreshment
-- Original JASS function: Trig_ConjureRefreshment_Conditions (line 7605)
function Trig_ConjureRefreshment_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A0C8"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_ConjureRefreshment_Actions (line 7612)
function Trig_ConjureRefreshment_Actions()
    CreateItemLoc(FourCC("I021"), GetSpellTargetLoc())
end

-- Original JASS function: InitTrig_ConjureRefreshment (line 7617)
function InitTrig_ConjureRefreshment()
    gg_trg_ConjureRefreshment = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_ConjureRefreshment, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_ConjureRefreshment, Condition(Trig_ConjureRefreshment_Conditions))
    TriggerAddAction(gg_trg_ConjureRefreshment, Trig_ConjureRefreshment_Actions)
end
-- END FOREST SECTION 52

-- BEGIN FOREST SECTION 53 ShadowDancers
-- Original JASS function: Trig_ShadowDancers_Conditions (line 7627)
function Trig_ShadowDancers_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A0A5"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_ShadowDancers_Actions (line 7634)
function Trig_ShadowDancers_Actions()
    GroupAddUnitSimple(GetTriggerUnit(), udg_ShadowDancers)
end

-- Original JASS function: InitTrig_ShadowDancers (line 7639)
function InitTrig_ShadowDancers()
    gg_trg_ShadowDancers = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_ShadowDancers, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_ShadowDancers, Condition(Trig_ShadowDancers_Conditions))
    TriggerAddAction(gg_trg_ShadowDancers, Trig_ShadowDancers_Actions)
end
-- END FOREST SECTION 53

-- BEGIN FOREST SECTION 54 Mana_Burn
-- Original JASS function: Trig_Mana_Burn_Conditions (line 7649)
function Trig_Mana_Burn_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A0AR"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Mana_Burn_Func003C (line 7656)
function Trig_Mana_Burn_Func003C()
    if ((not ((GetUnitStateSwap(UNIT_STATE_MANA, GetSpellTargetUnit()) <= __jreal(10.00))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Mana_Burn_Actions (line 7663)
function Trig_Mana_Burn_Actions()
    BlzSetUnitRealFieldBJ(GetSpellTargetUnit(), UNIT_RF_MANA, (__jreal(BlzGetUnitRealField(GetSpellTargetUnit(), UNIT_RF_MANA) - (__jreal(GetUnitStateSwap(UNIT_STATE_MANA, GetSpellAbilityUnit()) * __jreal(0.40))))))
    BlzSetUnitRealFieldBJ(GetSpellAbilityUnit(), UNIT_RF_MANA, (__jreal(GetUnitStateSwap(UNIT_STATE_MANA, GetSpellAbilityUnit()) * __jreal(0.80))))
    if (Trig_Mana_Burn_Func003C()) then
        CreateNUnitsAtLoc(1, FourCC("h04L"), GetOwningPlayer(GetSpellAbilityUnit()), GetUnitLoc(GetSpellTargetUnit()), bj_UNIT_FACING)
        UnitAddAbilityBJ(FourCC("A0CW"), GetLastCreatedUnit())
        UnitApplyTimedLifeBJ(__jreal(2.00), FourCC("BTLF"), GetLastCreatedUnit())
        IssueTargetOrderBJ(GetLastCreatedUnit(), "thunderbolt", GetSpellTargetUnit())
    else
    end
end

-- Original JASS function: InitTrig_Mana_Burn (line 7676)
function InitTrig_Mana_Burn()
    gg_trg_Mana_Burn = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Mana_Burn, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Mana_Burn, Condition(Trig_Mana_Burn_Conditions))
    TriggerAddAction(gg_trg_Mana_Burn, Trig_Mana_Burn_Actions)
end
-- END FOREST SECTION 54

-- BEGIN FOREST SECTION 55 Mana_Steal_Dancer
-- Original JASS function: Trig_Mana_Steal_Dancer_Conditions (line 7686)
function Trig_Mana_Steal_Dancer_Conditions()
    if ((not ((GetUnitTypeId(udg_DamageEventSource) == FourCC("h05E"))))) then
        do return false end
    end
    if ((not ((IsPlayerAlly(GetOwningPlayer(udg_DamageEventTarget), GetOwningPlayer(udg_DamageEventSource)) == false)))) then
        do return false end
    end
    if ((not ((BlzGetUnitMaxMana(udg_DamageEventTarget) ~= 0)))) then
        do return false end
    end
    if ((not ((GetPlayerTechCountSimple(FourCC("R064"), GetOwningPlayer(udg_DamageEventSource)) == 1)))) then
        do return false end
    end
    if ((not ((udg_IsDamageAttack == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Mana_Steal_Dancer_Actions (line 7705)
function Trig_Mana_Steal_Dancer_Actions()
    local source, target = udg_DamageEventSource, udg_DamageEventTarget
    local steal = math.min(20, BlzGetUnitMaxMana(target))
    local actualSteal = math.min(steal, GetUnitState(target, UNIT_STATE_MANA))
    local sourceMana = GetUnitState(source, UNIT_STATE_MANA)
    local targetMana = GetUnitState(target, UNIT_STATE_MANA)
    BlzSetUnitMaxMana(source, BlzGetUnitMaxMana(source) + steal)
    BlzSetUnitMaxMana(target, BlzGetUnitMaxMana(target) - steal)
    SetUnitState(source, UNIT_STATE_MANA, sourceMana + actualSteal)
    SetUnitState(target, UNIT_STATE_MANA, targetMana - actualSteal)
    TriggerSleepAction(__jreal(180.00))
    -- Dead heroes can revive; restore their capacity too, but not removed units.
    if GetUnitTypeId(source) ~= 0 then
        BlzSetUnitMaxMana(source, math.max(0, BlzGetUnitMaxMana(source) - steal))
    end
    if GetUnitTypeId(target) ~= 0 then
        BlzSetUnitMaxMana(target, BlzGetUnitMaxMana(target) + steal)
    end
end

-- Original JASS function: InitTrig_Mana_Steal_Dancer (line 7749)
function InitTrig_Mana_Steal_Dancer()
    gg_trg_Mana_Steal_Dancer = CreateTrigger()
    h__TriggerRegisterVariableEvent(gg_trg_Mana_Steal_Dancer, "udg_DamageEvent", EQUAL, __jreal(1.00))
    TriggerAddCondition(gg_trg_Mana_Steal_Dancer, Condition(Trig_Mana_Steal_Dancer_Conditions))
    TriggerAddAction(gg_trg_Mana_Steal_Dancer, Trig_Mana_Steal_Dancer_Actions)
end
-- END FOREST SECTION 55

-- BEGIN FOREST SECTION 56 Mana_Steal_Mages
-- Original JASS function: Trig_Mana_Steal_Mages_Conditions (line 7758)
function Trig_Mana_Steal_Mages_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("o023"))))) then
        do return false end
    end
    if ((not ((IsPlayerAlly(GetOwningPlayer(udg_DamageEventTarget), GetOwningPlayer(udg_DamageEventSource)) == false)))) then
        do return false end
    end
    if ((not ((BlzGetUnitMaxMana(udg_DamageEventTarget) ~= 0)))) then
        do return false end
    end
    if ((not ((GetPlayerTechCountSimple(FourCC("R063"), GetOwningPlayer(udg_DamageEventSource)) == 1)))) then
        do return false end
    end
    if ((not ((udg_IsDamageAttack == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Mana_Steal_Mages_Actions (line 7777)
function Trig_Mana_Steal_Mages_Actions()
    SetUnitManaBJ(udg_DamageEventSource, (__jreal(GetUnitStateSwap(UNIT_STATE_MANA, udg_DamageEventSource) + __jreal(20.00))))
end

-- Original JASS function: InitTrig_Mana_Steal_Mages (line 7782)
function InitTrig_Mana_Steal_Mages()
    gg_trg_Mana_Steal_Mages = CreateTrigger()
    h__TriggerRegisterVariableEvent(gg_trg_Mana_Steal_Mages, "udg_DamageEvent", EQUAL, __jreal(1.00))
    TriggerAddCondition(gg_trg_Mana_Steal_Mages, Condition(Trig_Mana_Steal_Mages_Conditions))
    TriggerAddAction(gg_trg_Mana_Steal_Mages, Trig_Mana_Steal_Mages_Actions)
end
-- END FOREST SECTION 56

-- BEGIN FOREST SECTION 57 ConjureMana
-- Original JASS function: Trig_ConjureMana_Conditions (line 7792)
function Trig_ConjureMana_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A0AQ"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_ConjureMana_Actions (line 7799)
function Trig_ConjureMana_Actions()
    local caster = GetSpellAbilityUnit()
    BlzSetUnitBaseDamage(GetTriggerUnit(), (__jint(199 + R2I(GetUnitStateSwap(UNIT_STATE_MANA, GetTriggerUnit())))), 0)
    TriggerSleepAction(__jreal(1.00))
    SetUnitManaBJ(caster, (__jreal(GetUnitStateSwap(UNIT_STATE_MANA, caster) / __jreal(2.00))))
    TriggerSleepAction(__jreal(60.00))
    BlzSetUnitBaseDamage(GetTriggerUnit(), 199, 0)
end

-- Original JASS function: InitTrig_ConjureMana (line 7808)
function InitTrig_ConjureMana()
    gg_trg_ConjureMana = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_ConjureMana, EVENT_PLAYER_UNIT_SPELL_FINISH)
    TriggerAddCondition(gg_trg_ConjureMana, Condition(Trig_ConjureMana_Conditions))
    TriggerAddAction(gg_trg_ConjureMana, Trig_ConjureMana_Actions)
end
-- END FOREST SECTION 57

-- BEGIN FOREST SECTION 58 Blur
-- Original JASS function: Trig_Blur_Conditions (line 7818)
function Trig_Blur_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A0BG"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Blur_Actions (line 7825)
function Trig_Blur_Actions()
    UnitAddAbilityBJ(FourCC("A0AS"), GetSpellAbilityUnit())
    TriggerSleepAction(__jreal(GetUnitStateSwap(UNIT_STATE_MAX_MANA, GetTriggerUnit()) * __jreal(0.001)))
    UnitRemoveAbilityBJ(FourCC("A0AS"), GetTriggerUnit())
    UnitRemoveBuffBJ(FourCC("B03G"), GetTriggerUnit())
end

-- Original JASS function: InitTrig_Blur (line 7833)
function InitTrig_Blur()
    gg_trg_Blur = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Blur, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    TriggerAddCondition(gg_trg_Blur, Condition(Trig_Blur_Conditions))
    TriggerAddAction(gg_trg_Blur, Trig_Blur_Actions)
end
-- END FOREST SECTION 58
