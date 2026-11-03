-- combat / shop_protection
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 303 Prevent_Attack
-- Original JASS function: Trig_Prevent_Attack_Func002C (line 17606)
function Trig_Prevent_Attack_Func002C()
    if (((GetUnitTypeId(GetAttackedUnitBJ()) == FourCC("h05B")))) then
        do return true end
    end
    if (((GetUnitTypeId(GetAttackedUnitBJ()) == FourCC("h02B")))) then
        do return true end
    end
    if (((GetUnitTypeId(GetAttackedUnitBJ()) == FourCC("n000")))) then
        do return true end
    end
    if (((GetUnitTypeId(GetAttackedUnitBJ()) == FourCC("n00A")))) then
        do return true end
    end
    if (((GetUnitTypeId(GetAttackedUnitBJ()) == FourCC("h060")))) then
        do return true end
    end
    do return false end
end

-- Original JASS function: Trig_Prevent_Attack_Conditions (line 17625)
function Trig_Prevent_Attack_Conditions()
    if ((not Trig_Prevent_Attack_Func002C())) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Prevent_Attack_Actions (line 17632)
function Trig_Prevent_Attack_Actions()
    IssueImmediateOrderBJ(GetAttacker(), "stop")
end

-- Original JASS function: InitTrig_Prevent_Attack (line 17637)
function InitTrig_Prevent_Attack()
    gg_trg_Prevent_Attack = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Prevent_Attack, EVENT_PLAYER_UNIT_ATTACKED)
    TriggerAddCondition(gg_trg_Prevent_Attack, Condition(Trig_Prevent_Attack_Conditions))
    TriggerAddAction(gg_trg_Prevent_Attack, Trig_Prevent_Attack_Actions)
end
-- END FOREST SECTION 303

-- BEGIN FOREST SECTION 304 No_Attacking_Shops_Copy_3
-- Original JASS function: Trig_No_Attacking_Shops_Copy_3_Conditions (line 17647)
function Trig_No_Attacking_Shops_Copy_3_Conditions()
    if ((not ((GetUnitTypeId(GetAttackedUnitBJ()) == FourCC("h05B"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_No_Attacking_Shops_Copy_3_Actions (line 17654)
function Trig_No_Attacking_Shops_Copy_3_Actions()
    IssueImmediateOrderBJ(GetAttacker(), "stop")
end

-- Original JASS function: InitTrig_No_Attacking_Shops_Copy_3 (line 17659)
function InitTrig_No_Attacking_Shops_Copy_3()
    gg_trg_No_Attacking_Shops_Copy_3 = CreateTrigger()
    DisableTrigger(gg_trg_No_Attacking_Shops_Copy_3)
    TriggerRegisterAnyUnitEventBJ(gg_trg_No_Attacking_Shops_Copy_3, EVENT_PLAYER_UNIT_ATTACKED)
    TriggerAddCondition(gg_trg_No_Attacking_Shops_Copy_3, Condition(Trig_No_Attacking_Shops_Copy_3_Conditions))
    TriggerAddAction(gg_trg_No_Attacking_Shops_Copy_3, Trig_No_Attacking_Shops_Copy_3_Actions)
end
-- END FOREST SECTION 304

-- BEGIN FOREST SECTION 305 No_Attacking_Shops_Copy_2
-- Original JASS function: Trig_No_Attacking_Shops_Copy_2_Conditions (line 17670)
function Trig_No_Attacking_Shops_Copy_2_Conditions()
    if ((not ((GetUnitTypeId(GetAttackedUnitBJ()) == FourCC("h02B"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_No_Attacking_Shops_Copy_2_Actions (line 17677)
function Trig_No_Attacking_Shops_Copy_2_Actions()
    IssueImmediateOrderBJ(GetAttacker(), "stop")
end

-- Original JASS function: InitTrig_No_Attacking_Shops_Copy_2 (line 17682)
function InitTrig_No_Attacking_Shops_Copy_2()
    gg_trg_No_Attacking_Shops_Copy_2 = CreateTrigger()
    DisableTrigger(gg_trg_No_Attacking_Shops_Copy_2)
    TriggerRegisterAnyUnitEventBJ(gg_trg_No_Attacking_Shops_Copy_2, EVENT_PLAYER_UNIT_ATTACKED)
    TriggerAddCondition(gg_trg_No_Attacking_Shops_Copy_2, Condition(Trig_No_Attacking_Shops_Copy_2_Conditions))
    TriggerAddAction(gg_trg_No_Attacking_Shops_Copy_2, Trig_No_Attacking_Shops_Copy_2_Actions)
end
-- END FOREST SECTION 305

-- BEGIN FOREST SECTION 306 No_Attacking_Shops_Copy
-- Original JASS function: Trig_No_Attacking_Shops_Copy_Conditions (line 17693)
function Trig_No_Attacking_Shops_Copy_Conditions()
    if ((not ((GetUnitTypeId(GetAttackedUnitBJ()) == FourCC("n000"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_No_Attacking_Shops_Copy_Actions (line 17700)
function Trig_No_Attacking_Shops_Copy_Actions()
    IssueImmediateOrderBJ(GetAttacker(), "stop")
end

-- Original JASS function: InitTrig_No_Attacking_Shops_Copy (line 17705)
function InitTrig_No_Attacking_Shops_Copy()
    gg_trg_No_Attacking_Shops_Copy = CreateTrigger()
    DisableTrigger(gg_trg_No_Attacking_Shops_Copy)
    TriggerRegisterAnyUnitEventBJ(gg_trg_No_Attacking_Shops_Copy, EVENT_PLAYER_UNIT_ATTACKED)
    TriggerAddCondition(gg_trg_No_Attacking_Shops_Copy, Condition(Trig_No_Attacking_Shops_Copy_Conditions))
    TriggerAddAction(gg_trg_No_Attacking_Shops_Copy, Trig_No_Attacking_Shops_Copy_Actions)
end
-- END FOREST SECTION 306

-- BEGIN FOREST SECTION 307 No_Attacking_Shops
-- Original JASS function: Trig_No_Attacking_Shops_Conditions (line 17716)
function Trig_No_Attacking_Shops_Conditions()
    if ((not ((GetUnitTypeId(GetAttackedUnitBJ()) == FourCC("n00A"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_No_Attacking_Shops_Actions (line 17723)
function Trig_No_Attacking_Shops_Actions()
    IssueImmediateOrderBJ(GetAttacker(), "stop")
end

-- Original JASS function: InitTrig_No_Attacking_Shops (line 17728)
function InitTrig_No_Attacking_Shops()
    gg_trg_No_Attacking_Shops = CreateTrigger()
    DisableTrigger(gg_trg_No_Attacking_Shops)
    TriggerRegisterAnyUnitEventBJ(gg_trg_No_Attacking_Shops, EVENT_PLAYER_UNIT_ATTACKED)
    TriggerAddCondition(gg_trg_No_Attacking_Shops, Condition(Trig_No_Attacking_Shops_Conditions))
    TriggerAddAction(gg_trg_No_Attacking_Shops, Trig_No_Attacking_Shops_Actions)
end
-- END FOREST SECTION 307
