-- items / mech_blaster
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 374 Gobo_Mech_Blaster_pickup
-- Original JASS function: Trig_Gobo_Mech_Blaster_pickup_Conditions (line 20368)
function Trig_Gobo_Mech_Blaster_pickup_Conditions()
    if ((not ((GetItemTypeId(GetManipulatedItem()) == FourCC("I00Q"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Gobo_Mech_Blaster_pickup_Func001C (line 20375)
function Trig_Gobo_Mech_Blaster_pickup_Func001C()
    if ((not ((IsUnitType(GetTriggerUnit(), UNIT_TYPE_MELEE_ATTACKER) == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Gobo_Mech_Blaster_pickup_Actions (line 20382)
function Trig_Gobo_Mech_Blaster_pickup_Actions()
    if (Trig_Gobo_Mech_Blaster_pickup_Func001C()) then
        SetUnitAbilityLevelSwapped(FourCC("A0DP"), GetTriggerUnit(), 2)
    else
        SetUnitAbilityLevelSwapped(FourCC("A0DP"), GetTriggerUnit(), 1)
    end
end

-- Original JASS function: InitTrig_Gobo_Mech_Blaster_pickup (line 20391)
function InitTrig_Gobo_Mech_Blaster_pickup()
    gg_trg_Gobo_Mech_Blaster_pickup = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Gobo_Mech_Blaster_pickup, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    TriggerAddCondition(gg_trg_Gobo_Mech_Blaster_pickup, Condition(Trig_Gobo_Mech_Blaster_pickup_Conditions))
    TriggerAddAction(gg_trg_Gobo_Mech_Blaster_pickup, Trig_Gobo_Mech_Blaster_pickup_Actions)
end
-- END FOREST SECTION 374

-- BEGIN FOREST SECTION 375 Gobo_Mech_Blaster_attack_check
-- Original JASS function: Trig_Gobo_Mech_Blaster_attack_check_Conditions (line 20403)
function Trig_Gobo_Mech_Blaster_attack_check_Conditions()
    if ((not ((UnitHasItemOfTypeBJ(udg_DamageEventSource, FourCC("I00Q")) == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Gobo_Mech_Blaster_attack_check_Func001C (line 20410)
function Trig_Gobo_Mech_Blaster_attack_check_Func001C()
    if ((not ((IsUnitType(udg_DamageFilterSource, UNIT_TYPE_MELEE_ATTACKER) == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Gobo_Mech_Blaster_attack_check_Actions (line 20417)
function Trig_Gobo_Mech_Blaster_attack_check_Actions()
    if (Trig_Gobo_Mech_Blaster_attack_check_Func001C()) then
        SetUnitAbilityLevelSwapped(FourCC("A0DP"), udg_DamageEventSource, 2)
    else
        SetUnitAbilityLevelSwapped(FourCC("A0DP"), udg_DamageEventSource, 1)
    end
end

-- Original JASS function: InitTrig_Gobo_Mech_Blaster_attack_check (line 20426)
function InitTrig_Gobo_Mech_Blaster_attack_check()
    gg_trg_Gobo_Mech_Blaster_attack_check = CreateTrigger()
    h__TriggerRegisterVariableEvent(gg_trg_Gobo_Mech_Blaster_attack_check, "udg_DamageModifierEvent", EQUAL, __jreal(1.00))
    TriggerAddCondition(gg_trg_Gobo_Mech_Blaster_attack_check, Condition(Trig_Gobo_Mech_Blaster_attack_check_Conditions))
    TriggerAddAction(gg_trg_Gobo_Mech_Blaster_attack_check, Trig_Gobo_Mech_Blaster_attack_check_Actions)
end
-- END FOREST SECTION 375
