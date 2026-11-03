-- ancients / pharaoh
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 172 Sandstorm
-- Original JASS function: Trig_Sandstorm_Conditions (line 11892)
function Trig_Sandstorm_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A07Y"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Sandstorm_Actions (line 11899)
function Trig_Sandstorm_Actions()
    SetUnitLifePercentBJ(GetSpellAbilityUnit(), (__jreal(GetUnitLifePercent(GetSpellAbilityUnit()) - __jreal(5.00))))
end

-- Original JASS function: InitTrig_Sandstorm (line 11904)
function InitTrig_Sandstorm()
    gg_trg_Sandstorm = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Sandstorm, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Sandstorm, Condition(Trig_Sandstorm_Conditions))
    TriggerAddAction(gg_trg_Sandstorm, Trig_Sandstorm_Actions)
end
-- END FOREST SECTION 172

-- BEGIN FOREST SECTION 173 Sandstorm_2
-- Original JASS function: Trig_Sandstorm_2_Conditions (line 11914)
function Trig_Sandstorm_2_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A07Y"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Sandstorm_2_Actions (line 11921)
function Trig_Sandstorm_2_Actions()
    local timer = CreateTimer()
    TimerStart(timer, 45, false, nil)
    local dialog = CreateTimerDialog(timer)
    TimerDialogSetTitle(dialog, "TRIGSTR_8327")
    TimerDialogDisplay(dialog, true)
    TriggerSleepAction(__jreal(45))
    DestroyTimerDialog(dialog)
    DestroyTimer(timer)
end

-- Original JASS function: InitTrig_Sandstorm_2 (line 11929)
function InitTrig_Sandstorm_2()
    gg_trg_Sandstorm_2 = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Sandstorm_2, EVENT_PLAYER_UNIT_SPELL_FINISH)
    TriggerAddCondition(gg_trg_Sandstorm_2, Condition(Trig_Sandstorm_2_Conditions))
    TriggerAddAction(gg_trg_Sandstorm_2, Trig_Sandstorm_2_Actions)
end
-- END FOREST SECTION 173

-- BEGIN FOREST SECTION 174 Ancient_Grasp
-- Original JASS function: Trig_Ancient_Grasp_Conditions (line 11939)
function Trig_Ancient_Grasp_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A07Z"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Ancient_Grasp_Actions (line 11946)
function Trig_Ancient_Grasp_Actions()
    local caster = GetSpellAbilityUnit()
    SetUnitLifePercentBJ(caster, (__jreal(GetUnitLifePercent(caster) - __jreal(10.00))))
    TriggerSleepAction(__jreal(1.00))
    SetUnitLifePercentBJ(caster, (__jreal(GetUnitLifePercent(caster) + __jreal(2.00))))
    TriggerSleepAction(__jreal(1.00))
    SetUnitLifePercentBJ(caster, (__jreal(GetUnitLifePercent(caster) + __jreal(2.00))))
    TriggerSleepAction(__jreal(1.00))
    SetUnitLifePercentBJ(caster, (__jreal(GetUnitLifePercent(caster) + __jreal(2.00))))
    TriggerSleepAction(__jreal(1.00))
    SetUnitLifePercentBJ(caster, (__jreal(GetUnitLifePercent(caster) + __jreal(2.00))))
    TriggerSleepAction(__jreal(1.00))
    SetUnitLifePercentBJ(caster, (__jreal(GetUnitLifePercent(caster) + __jreal(2.00))))
    TriggerSleepAction(__jreal(1.00))
    SetUnitLifePercentBJ(caster, (__jreal(GetUnitLifePercent(caster) + __jreal(2.00))))
    TriggerSleepAction(__jreal(1.00))
    SetUnitLifePercentBJ(caster, (__jreal(GetUnitLifePercent(caster) + __jreal(2.00))))
    TriggerSleepAction(__jreal(1.00))
    SetUnitLifePercentBJ(caster, (__jreal(GetUnitLifePercent(caster) + __jreal(2.00))))
    TriggerSleepAction(__jreal(1.00))
    SetUnitLifePercentBJ(caster, (__jreal(GetUnitLifePercent(caster) + __jreal(2.00))))
    TriggerSleepAction(__jreal(1.00))
    SetUnitLifePercentBJ(caster, (__jreal(GetUnitLifePercent(caster) + __jreal(2.00))))
end

-- Original JASS function: InitTrig_Ancient_Grasp (line 11971)
function InitTrig_Ancient_Grasp()
    gg_trg_Ancient_Grasp = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Ancient_Grasp, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Ancient_Grasp, Condition(Trig_Ancient_Grasp_Conditions))
    TriggerAddAction(gg_trg_Ancient_Grasp, Trig_Ancient_Grasp_Actions)
end
-- END FOREST SECTION 174

-- BEGIN FOREST SECTION 175 Deserts_Veil
-- Original JASS function: Trig_Deserts_Veil_Conditions (line 11981)
function Trig_Deserts_Veil_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A080"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Deserts_Veil_Actions (line 11988)
function Trig_Deserts_Veil_Actions()
    SetUnitLifePercentBJ(GetSpellAbilityUnit(), (__jreal(GetUnitLifePercent(GetSpellAbilityUnit()) + __jreal(30.00))))
end

-- Original JASS function: InitTrig_Deserts_Veil (line 11993)
function InitTrig_Deserts_Veil()
    gg_trg_Deserts_Veil = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Deserts_Veil, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Deserts_Veil, Condition(Trig_Deserts_Veil_Conditions))
    TriggerAddAction(gg_trg_Deserts_Veil, Trig_Deserts_Veil_Actions)
end
-- END FOREST SECTION 175
