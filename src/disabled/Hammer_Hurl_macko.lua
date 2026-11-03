-- Disabled in the original map.
function Trig_Hammer_Hurl_macko_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A0E7"))))) then
        do return false end
    end
    do return true end
end

function Trig_Hammer_Hurl_macko_Actions()
    UnitAddTypeBJ(UNIT_TYPE_STUNNED, GetSpellTargetUnit())
    TriggerSleepAction(__jreal(1.50))
    UnitRemoveTypeBJ(UNIT_TYPE_STUNNED, GetSpellTargetUnit())
end

function InitTrig_Hammer_Hurl_macko()
    gg_trg_Hammer_Hurl_macko = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Hammer_Hurl_macko, EVENT_PLAYER_UNIT_SPELL_CAST)
    TriggerAddCondition(gg_trg_Hammer_Hurl_macko, Condition(Trig_Hammer_Hurl_macko_Conditions))
    TriggerAddAction(gg_trg_Hammer_Hurl_macko, Trig_Hammer_Hurl_macko_Actions)
end
