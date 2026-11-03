-- ancients / zalxon
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 158 Thunderstruck
function Trig_Thunderstruck_Conditions()
    if (not (GetUnitTypeId(udg_DamageEventTarget) == FourCC("O016"))) then
        return false
    end
    if (not (udg_IsDamageAttack == true)) then
        return false
    end
    return true
end

function Trig_Thunderstruck_Func003C()
    return GetRandomReal(__jreal(0.00), __jreal(100.00)) <= (__jreal((__jreal(__jreal(0.75) * I2R(GetUnitLevel(udg_DamageEventTarget)))) + __jreal(0.00)))
end

function Trig_Thunderstruck_Actions()
    udg_ThunderstruckLevel = GetUnitAbilityLevelSwapped(FourCC("A03S"), udg_DamageEventTarget)
    udg_ThunderstruckTarget = GetUnitLoc(udg_DamageEventSource)
    if (Trig_Thunderstruck_Func003C()) then
        CreateNUnitsAtLoc(1, FourCC("h04L"), GetOwningPlayer(BlzGetEventDamageTarget()), udg_ThunderstruckTarget, bj_UNIT_FACING)
        UnitAddAbilityBJ(FourCC("A03S"), GetLastCreatedUnit())
        SetUnitAbilityLevelSwapped(FourCC("A03S"), GetLastCreatedUnit(), udg_ThunderstruckLevel)
        UnitApplyTimedLifeBJ(__jreal(2.00), FourCC("BTLF"), GetLastCreatedUnit())
        IssuePointOrderLocBJ(GetLastCreatedUnit(), "flamestrike", udg_ThunderstruckTarget)
    end
end

function InitTrig_Thunderstruck()
    gg_trg_Thunderstruck = CreateTrigger()
    h__TriggerRegisterVariableEvent(gg_trg_Thunderstruck, "udg_DamageEvent", EQUAL, __jreal(1.00))
    TriggerAddCondition(gg_trg_Thunderstruck, Condition(Trig_Thunderstruck_Conditions))
    TriggerAddAction(gg_trg_Thunderstruck, Trig_Thunderstruck_Actions)
end
-- END FOREST SECTION 158

-- BEGIN FOREST SECTION 159 Lightning_Strike
function Trig_Lightning_Strike_Conditions()
    if (not (GetSpellAbilityId() == FourCC("A03S"))) then
        return false
    end
    if (not (GetUnitTypeId(GetTriggerUnit()) == FourCC("O016"))) then
        return false
    end
    return true
end

function Trig_Lightning_Strike_Actions()
    local timer = CreateTimer()
    TimerStart(timer, 25, false, nil)
    local dialog = CreateTimerDialog(timer)
    TimerDialogSetTitle(dialog, "TRIGSTR_7242")
    TimerDialogDisplay(dialog, true)
    TriggerSleepAction(__jreal(25))
    DestroyTimerDialog(dialog)
    DestroyTimer(timer)
end

function InitTrig_Lightning_Strike()
    gg_trg_Lightning_Strike = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Lightning_Strike, EVENT_PLAYER_UNIT_SPELL_FINISH)
    TriggerAddCondition(gg_trg_Lightning_Strike, Condition(Trig_Lightning_Strike_Conditions))
    TriggerAddAction(gg_trg_Lightning_Strike, Trig_Lightning_Strike_Actions)
end
-- END FOREST SECTION 159
