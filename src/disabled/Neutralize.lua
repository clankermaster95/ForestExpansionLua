-- Disabled in the original map.
function Trig_Neutralize_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A03U"))))) then
        do return false end
    end
    do return true end
end

function Trig_Neutralize_Actions()
    CreateNUnitsAtLoc(1, FourCC("h04L"), GetOwningPlayer(GetSpellAbilityUnit()), GetSpellTargetLoc(), bj_UNIT_FACING)
    UnitAddAbilityBJ(FourCC("A0B1"), GetLastCreatedUnit())
    UnitApplyTimedLifeBJ(__jreal(2.00), FourCC("BTLF"), GetLastCreatedUnit())
    IssueTargetOrderBJ(GetLastCreatedUnit(), "purge", GetSpellTargetUnit())
end

function InitTrig_Neutralize()
    gg_trg_Neutralize = CreateTrigger()
    DisableTrigger(gg_trg_Neutralize)
    TriggerRegisterAnyUnitEventBJ(gg_trg_Neutralize, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Neutralize, Condition(Trig_Neutralize_Conditions))
    TriggerAddAction(gg_trg_Neutralize, Trig_Neutralize_Actions)
end
