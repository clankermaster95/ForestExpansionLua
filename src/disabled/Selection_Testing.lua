-- Disabled in the original map.
function Trig_Selection_Testing_Conditions()
    if ((not ((GetUnitTypeId(GetSellingUnit()) == FourCC("n00G"))))) then
        do return false end
    end
    do return true end
end

function Trig_Selection_Testing_Actions()
    MultiboardSetItemWidthBJ(GetLastCreatedMultiboard(), 1, 1, __jreal(13.00))
    MultiboardSetItemWidthBJ(GetLastCreatedMultiboard(), 2, 1, __jreal(13.00))
    MultiboardSetItemStyleBJ(GetLastCreatedMultiboard(), 0, 1, true, false)
    MultiboardSetItemIconBJ(GetLastCreatedMultiboard(), 0, 2, "UI\\Feedback\\Resources\\ResourceGold.blp")
    MultiboardSetItemValueBJ(GetLastCreatedMultiboard(), 0, 1, "TRIGSTR_146")
end

function InitTrig_Selection_Testing()
    gg_trg_Selection_Testing = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Selection_Testing, EVENT_PLAYER_UNIT_SELL)
    TriggerAddCondition(gg_trg_Selection_Testing, Condition(Trig_Selection_Testing_Conditions))
    TriggerAddAction(gg_trg_Selection_Testing, Trig_Selection_Testing_Actions)
end
