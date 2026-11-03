-- ancients / pharaoh
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 172 Sandstorm
function Trig_Sandstorm_Conditions()
    return GetSpellAbilityId() == FourCC("A07Y")
end

function Trig_Sandstorm_Actions()
    SetUnitLifePercentBJ(GetSpellAbilityUnit(), (__jreal(GetUnitLifePercent(GetSpellAbilityUnit()) - __jreal(5.00))))
end

function InitTrig_Sandstorm()
    gg_trg_Sandstorm = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Sandstorm, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Sandstorm, Condition(Trig_Sandstorm_Conditions))
    TriggerAddAction(gg_trg_Sandstorm, Trig_Sandstorm_Actions)
end
-- END FOREST SECTION 172

-- BEGIN FOREST SECTION 173 Sandstorm_2
function Trig_Sandstorm_2_Conditions()
    return GetSpellAbilityId() == FourCC("A07Y")
end

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

function InitTrig_Sandstorm_2()
    gg_trg_Sandstorm_2 = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Sandstorm_2, EVENT_PLAYER_UNIT_SPELL_FINISH)
    TriggerAddCondition(gg_trg_Sandstorm_2, Condition(Trig_Sandstorm_2_Conditions))
    TriggerAddAction(gg_trg_Sandstorm_2, Trig_Sandstorm_2_Actions)
end
-- END FOREST SECTION 173

-- BEGIN FOREST SECTION 174 Ancient_Grasp
function Trig_Ancient_Grasp_Conditions()
    return GetSpellAbilityId() == FourCC("A07Z")
end

function Trig_Ancient_Grasp_Actions()
    local caster = GetSpellAbilityUnit()
    SetUnitLifePercentBJ(caster, (__jreal(GetUnitLifePercent(caster) - __jreal(10.00))))
    for pulse = 1, 10 do
        TriggerSleepAction(__jreal(1.00))
        SetUnitLifePercentBJ(caster, (__jreal(GetUnitLifePercent(caster) + __jreal(2.00))))
    end
end

function InitTrig_Ancient_Grasp()
    gg_trg_Ancient_Grasp = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Ancient_Grasp, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Ancient_Grasp, Condition(Trig_Ancient_Grasp_Conditions))
    TriggerAddAction(gg_trg_Ancient_Grasp, Trig_Ancient_Grasp_Actions)
end
-- END FOREST SECTION 174

-- BEGIN FOREST SECTION 175 Deserts_Veil
function Trig_Deserts_Veil_Conditions()
    return GetSpellAbilityId() == FourCC("A080")
end

function Trig_Deserts_Veil_Actions()
    SetUnitLifePercentBJ(GetSpellAbilityUnit(), (__jreal(GetUnitLifePercent(GetSpellAbilityUnit()) + __jreal(30.00))))
end

function InitTrig_Deserts_Veil()
    gg_trg_Deserts_Veil = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Deserts_Veil, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Deserts_Veil, Condition(Trig_Deserts_Veil_Conditions))
    TriggerAddAction(gg_trg_Deserts_Veil, Trig_Deserts_Veil_Actions)
end
-- END FOREST SECTION 175
