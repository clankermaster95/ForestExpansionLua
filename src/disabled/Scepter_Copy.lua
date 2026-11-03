-- Disabled in the original map.
function Trig_Scepter_Copy_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A0E7"))))) then
        do return false end
    end
    do return true end
end

function Trig_Scepter_Copy_Actions()
    udg_Temp_Point = GetUnitLoc(GetSpellTargetUnit())
    CreateNUnitsAtLocFacingLocBJ(1, FourCC("h04L"), GetOwningPlayer(GetSpellAbilityUnit()), udg_Temp_Point, udg_Temp_Point)
    UnitApplyTimedLifeBJ(__jreal(0.50), FourCC("BTLF"), GetLastCreatedUnit())
    IssueTargetOrderBJ(GetLastCreatedUnit(), "chainlightning", GetSpellTargetUnit())
    RemoveLocation(udg_Temp_Point)
end

function InitTrig_Scepter_Copy()
    gg_trg_Scepter_Copy = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Scepter_Copy, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Scepter_Copy, Condition(Trig_Scepter_Copy_Conditions))
    TriggerAddAction(gg_trg_Scepter_Copy, Trig_Scepter_Copy_Actions)
end
