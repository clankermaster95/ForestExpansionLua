-- Disabled in the original map.
function Trig_Lunar_Crystal_Conditions()
    if ((not ((GetItemTypeId(GetManipulatedItem()) == FourCC("I01I"))))) then
        do return false end
    end
    do return true end
end

function Trig_Lunar_Crystal_Func001C()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("h010"))))) then
        do return false end
    end
    do return true end
end

function Trig_Lunar_Crystal_Actions()
    if (Trig_Lunar_Crystal_Func001C()) then
        DoNothing()
    else
        UnitDropItemPointLoc(GetTriggerUnit(), GetManipulatedItem(), GetUnitLoc(GetTriggerUnit()))
    end
end

function InitTrig_Lunar_Crystal()
    gg_trg_Lunar_Crystal = CreateTrigger()
    DisableTrigger(gg_trg_Lunar_Crystal)
    TriggerRegisterAnyUnitEventBJ(gg_trg_Lunar_Crystal, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    TriggerAddCondition(gg_trg_Lunar_Crystal, Condition(Trig_Lunar_Crystal_Conditions))
    TriggerAddAction(gg_trg_Lunar_Crystal, Trig_Lunar_Crystal_Actions)
end
