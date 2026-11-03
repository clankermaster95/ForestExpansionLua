-- combat / shop_protection
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 303 Prevent_Attack
function Trig_Prevent_Attack_Func002C()
    if (GetUnitTypeId(GetAttackedUnitBJ()) == FourCC("h05B")) then
        return true
    end
    if (GetUnitTypeId(GetAttackedUnitBJ()) == FourCC("h02B")) then
        return true
    end
    if (GetUnitTypeId(GetAttackedUnitBJ()) == FourCC("n000")) then
        return true
    end
    if (GetUnitTypeId(GetAttackedUnitBJ()) == FourCC("n00A")) then
        return true
    end
    if (GetUnitTypeId(GetAttackedUnitBJ()) == FourCC("h060")) then
        return true
    end
    return false
end

function Trig_Prevent_Attack_Conditions()
    return not not (Trig_Prevent_Attack_Func002C())
end

function Trig_Prevent_Attack_Actions()
    IssueImmediateOrderBJ(GetAttacker(), "stop")
end

function InitTrig_Prevent_Attack()
    gg_trg_Prevent_Attack = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Prevent_Attack, EVENT_PLAYER_UNIT_ATTACKED)
    TriggerAddCondition(gg_trg_Prevent_Attack, Condition(Trig_Prevent_Attack_Conditions))
    TriggerAddAction(gg_trg_Prevent_Attack, Trig_Prevent_Attack_Actions)
end
-- END FOREST SECTION 303

-- BEGIN FOREST SECTION 304 No_Attacking_Shops_Copy_3
function Trig_No_Attacking_Shops_Copy_3_Conditions()
    return GetUnitTypeId(GetAttackedUnitBJ()) == FourCC("h05B")
end

function Trig_No_Attacking_Shops_Copy_3_Actions()
    IssueImmediateOrderBJ(GetAttacker(), "stop")
end

function InitTrig_No_Attacking_Shops_Copy_3()
    gg_trg_No_Attacking_Shops_Copy_3 = CreateTrigger()
    DisableTrigger(gg_trg_No_Attacking_Shops_Copy_3)
    TriggerRegisterAnyUnitEventBJ(gg_trg_No_Attacking_Shops_Copy_3, EVENT_PLAYER_UNIT_ATTACKED)
    TriggerAddCondition(gg_trg_No_Attacking_Shops_Copy_3, Condition(Trig_No_Attacking_Shops_Copy_3_Conditions))
    TriggerAddAction(gg_trg_No_Attacking_Shops_Copy_3, Trig_No_Attacking_Shops_Copy_3_Actions)
end
-- END FOREST SECTION 304

-- BEGIN FOREST SECTION 305 No_Attacking_Shops_Copy_2
function Trig_No_Attacking_Shops_Copy_2_Conditions()
    return GetUnitTypeId(GetAttackedUnitBJ()) == FourCC("h02B")
end

function Trig_No_Attacking_Shops_Copy_2_Actions()
    IssueImmediateOrderBJ(GetAttacker(), "stop")
end

function InitTrig_No_Attacking_Shops_Copy_2()
    gg_trg_No_Attacking_Shops_Copy_2 = CreateTrigger()
    DisableTrigger(gg_trg_No_Attacking_Shops_Copy_2)
    TriggerRegisterAnyUnitEventBJ(gg_trg_No_Attacking_Shops_Copy_2, EVENT_PLAYER_UNIT_ATTACKED)
    TriggerAddCondition(gg_trg_No_Attacking_Shops_Copy_2, Condition(Trig_No_Attacking_Shops_Copy_2_Conditions))
    TriggerAddAction(gg_trg_No_Attacking_Shops_Copy_2, Trig_No_Attacking_Shops_Copy_2_Actions)
end
-- END FOREST SECTION 305

-- BEGIN FOREST SECTION 306 No_Attacking_Shops_Copy
function Trig_No_Attacking_Shops_Copy_Conditions()
    return GetUnitTypeId(GetAttackedUnitBJ()) == FourCC("n000")
end

function Trig_No_Attacking_Shops_Copy_Actions()
    IssueImmediateOrderBJ(GetAttacker(), "stop")
end

function InitTrig_No_Attacking_Shops_Copy()
    gg_trg_No_Attacking_Shops_Copy = CreateTrigger()
    DisableTrigger(gg_trg_No_Attacking_Shops_Copy)
    TriggerRegisterAnyUnitEventBJ(gg_trg_No_Attacking_Shops_Copy, EVENT_PLAYER_UNIT_ATTACKED)
    TriggerAddCondition(gg_trg_No_Attacking_Shops_Copy, Condition(Trig_No_Attacking_Shops_Copy_Conditions))
    TriggerAddAction(gg_trg_No_Attacking_Shops_Copy, Trig_No_Attacking_Shops_Copy_Actions)
end
-- END FOREST SECTION 306

-- BEGIN FOREST SECTION 307 No_Attacking_Shops
function Trig_No_Attacking_Shops_Conditions()
    return GetUnitTypeId(GetAttackedUnitBJ()) == FourCC("n00A")
end

function Trig_No_Attacking_Shops_Actions()
    IssueImmediateOrderBJ(GetAttacker(), "stop")
end

function InitTrig_No_Attacking_Shops()
    gg_trg_No_Attacking_Shops = CreateTrigger()
    DisableTrigger(gg_trg_No_Attacking_Shops)
    TriggerRegisterAnyUnitEventBJ(gg_trg_No_Attacking_Shops, EVENT_PLAYER_UNIT_ATTACKED)
    TriggerAddCondition(gg_trg_No_Attacking_Shops, Condition(Trig_No_Attacking_Shops_Conditions))
    TriggerAddAction(gg_trg_No_Attacking_Shops, Trig_No_Attacking_Shops_Actions)
end
-- END FOREST SECTION 307
