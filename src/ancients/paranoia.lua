-- ancients / paranoia
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 156 Realm_of_darkness
-- Original JASS function: Trig_Realm_of_darkness_Conditions (line 11384)
function Trig_Realm_of_darkness_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A0B7"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Realm_of_darkness_Func002001002 (line 11391)
function Trig_Realm_of_darkness_Func002001002()
    do return ((IsUnitEnemy(GetFilterUnit(), FE_Roles.ancient()) == true)) end
end

-- Original JASS function: Trig_Realm_of_darkness_Func002A (line 11395)
function Trig_Realm_of_darkness_Func002A()
    UnitAddAbilityBJ(FourCC("A0B6"), GetEnumUnit())
end

-- Original JASS function: Trig_Realm_of_darkness_Func005001002 (line 11399)
function Trig_Realm_of_darkness_Func005001002()
    do return ((IsUnitEnemy(GetFilterUnit(), FE_Roles.ancient()) == true)) end
end

-- Original JASS function: Trig_Realm_of_darkness_Func005A (line 11403)
function Trig_Realm_of_darkness_Func005A()
    UnitRemoveAbilityBJ(FourCC("A0B6"), GetEnumUnit())
end

-- Original JASS function: Trig_Realm_of_darkness_Actions (line 11407)
function Trig_Realm_of_darkness_Actions()
    EnableTrigger(gg_trg_Realm_of_darkness_2)
    local group002 = GetUnitsInRectMatching(GetPlayableMapRect(), Condition(Trig_Realm_of_darkness_Func002001002))
    ForGroupBJ(group002, Trig_Realm_of_darkness_Func002A)
    DestroyGroup(group002)
    TriggerSleepAction(__jreal(60.00))
    DisableTrigger(gg_trg_Realm_of_darkness_2)
    local group005 = GetUnitsInRectMatching(GetPlayableMapRect(), Condition(Trig_Realm_of_darkness_Func005001002))
    ForGroupBJ(group005, Trig_Realm_of_darkness_Func005A)
    DestroyGroup(group005)
end

-- Original JASS function: InitTrig_Realm_of_darkness (line 11416)
function InitTrig_Realm_of_darkness()
    gg_trg_Realm_of_darkness = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Realm_of_darkness, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Realm_of_darkness, Condition(Trig_Realm_of_darkness_Conditions))
    TriggerAddAction(gg_trg_Realm_of_darkness, Trig_Realm_of_darkness_Actions)
end
-- END FOREST SECTION 156

-- BEGIN FOREST SECTION 157 Realm_of_darkness_2
-- Original JASS function: Trig_Realm_of_darkness_2_Conditions (line 11426)
function Trig_Realm_of_darkness_2_Conditions()
    if ((not ((IsUnitEnemy(GetTriggerUnit(), FE_Roles.ancient()) == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Realm_of_darkness_2_Actions (line 11433)
function Trig_Realm_of_darkness_2_Actions()
    UnitAddAbilityBJ(FourCC("A0B6"), GetTriggerUnit())
end

-- Original JASS function: InitTrig_Realm_of_darkness_2 (line 11438)
function InitTrig_Realm_of_darkness_2()
    gg_trg_Realm_of_darkness_2 = CreateTrigger()
    DisableTrigger(gg_trg_Realm_of_darkness_2)
    TriggerRegisterEnterRectSimple(gg_trg_Realm_of_darkness_2, GetPlayableMapRect())
    TriggerRegisterAnyUnitEventBJ(gg_trg_Realm_of_darkness_2, EVENT_PLAYER_UNIT_CONSTRUCT_START)
    TriggerAddCondition(gg_trg_Realm_of_darkness_2, Condition(Trig_Realm_of_darkness_2_Conditions))
    TriggerAddAction(gg_trg_Realm_of_darkness_2, Trig_Realm_of_darkness_2_Actions)
end
-- END FOREST SECTION 157
