-- Disabled in the original map.
function Trig_Empower_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A01T"))))) then
        do return false end
    end
    do return true end
end

function Trig_Empower_Actions()
    SetUnitManaPercentBJ(GetTriggerUnit(), (__jreal(GetUnitManaPercent(GetTriggerUnit()) + __jreal(25.00))))
end

function InitTrig_Empower()
    gg_trg_Empower = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Empower, EVENT_PLAYER_UNIT_SPELL_FINISH)
    TriggerAddCondition(gg_trg_Empower, Condition(Trig_Empower_Conditions))
    TriggerAddAction(gg_trg_Empower, Trig_Empower_Actions)
end
