-- races / forgotten
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 64 Soul_Hammer
-- Original JASS function: Trig_Soul_Hammer_Conditions (line 8030)
function Trig_Soul_Hammer_Conditions()
    if ((not ((GetItemTypeId(GetManipulatedItem()) == FourCC("I01E"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Soul_Hammer_Func002Func002Func001Func001C (line 8037)
function Trig_Soul_Hammer_Func002Func002Func001Func001C()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("u00B"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Soul_Hammer_Func002Func002Func001C (line 8044)
function Trig_Soul_Hammer_Func002Func002Func001C()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("u009"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Soul_Hammer_Func002Func002C (line 8051)
function Trig_Soul_Hammer_Func002Func002C()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("u007"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Soul_Hammer_Func002C (line 8058)
function Trig_Soul_Hammer_Func002C()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("u00A"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Soul_Hammer_Actions (line 8065)
function Trig_Soul_Hammer_Actions()
    if (Trig_Soul_Hammer_Func002C()) then
        DoNothing()
    else
        if (Trig_Soul_Hammer_Func002Func002C()) then
            DoNothing()
        else
            if (Trig_Soul_Hammer_Func002Func002Func001C()) then
                DoNothing()
            else
                if (Trig_Soul_Hammer_Func002Func002Func001Func001C()) then
                    DoNothing()
                else
                    UnitDropItemPointLoc(GetTriggerUnit(), GetManipulatedItem(), GetUnitLoc(GetTriggerUnit()))
                end
            end
        end
    end
end

-- Original JASS function: InitTrig_Soul_Hammer (line 8086)
function InitTrig_Soul_Hammer()
    gg_trg_Soul_Hammer = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Soul_Hammer, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    TriggerAddCondition(gg_trg_Soul_Hammer, Condition(Trig_Soul_Hammer_Conditions))
    TriggerAddAction(gg_trg_Soul_Hammer, Trig_Soul_Hammer_Actions)
end
-- END FOREST SECTION 64
