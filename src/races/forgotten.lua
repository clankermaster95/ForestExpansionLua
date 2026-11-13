-- races / forgotten
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 64 Soul_Hammer
function Trig_Soul_Hammer_Conditions()
    return GetItemTypeId(GetManipulatedItem()) == FourCC("I01E")
end

function Trig_Soul_Hammer_Func002Func002Func001Func001C()
    return GetUnitTypeId(GetTriggerUnit()) == FourCC("u00B")
end

function Trig_Soul_Hammer_Func002Func002Func001C()
    return GetUnitTypeId(GetTriggerUnit()) == FourCC("u009")
end

function Trig_Soul_Hammer_Func002Func002C()
    return GetUnitTypeId(GetTriggerUnit()) == FourCC("u007")
end

function Trig_Soul_Hammer_Func002C()
    return GetUnitTypeId(GetTriggerUnit()) == FourCC("u00A")
end

function Trig_Soul_Hammer_Actions()
    if (Trig_Soul_Hammer_Func002C()) then
    else
        if (Trig_Soul_Hammer_Func002Func002C()) then
        else
            if (Trig_Soul_Hammer_Func002Func002Func001C()) then
            else
                if (Trig_Soul_Hammer_Func002Func002Func001Func001C()) then
                else
                    local point = GetUnitLoc(GetTriggerUnit())
                    UnitDropItemPointLoc(GetTriggerUnit(), GetManipulatedItem(), point)
                    RemoveLocation(point)
                end
            end
        end
    end
end

function InitTrig_Soul_Hammer()
    gg_trg_Soul_Hammer = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Soul_Hammer, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    TriggerAddCondition(gg_trg_Soul_Hammer, Condition(Trig_Soul_Hammer_Conditions))
    TriggerAddAction(gg_trg_Soul_Hammer, Trig_Soul_Hammer_Actions)
end
-- END FOREST SECTION 64
