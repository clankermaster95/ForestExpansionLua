-- races / night_elf
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 49 Deepwater_1
-- Original JASS function: Trig_Deepwater_1_Conditions (line 7479)
function Trig_Deepwater_1_Conditions()
    if ((not ((GetResearched() == FourCC("R066"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Deepwater_1_Func001A (line 7486)
function Trig_Deepwater_1_Func001A()
    UnitRemoveAbilityBJ(FourCC("A0A4"), GetEnumUnit())
    UnitAddAbilityBJ(FourCC("A0BB"), GetEnumUnit())
    udg_DeepWater1[GetConvertedPlayerId(GetOwningPlayer(GetResearchingUnit()))] = true
end

-- Original JASS function: Trig_Deepwater_1_Actions (line 7492)
function Trig_Deepwater_1_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(GetOwningPlayer(GetResearchingUnit()), FourCC("e00R")), Trig_Deepwater_1_Func001A)
end

-- Original JASS function: InitTrig_Deepwater_1 (line 7497)
function InitTrig_Deepwater_1()
    gg_trg_Deepwater_1 = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Deepwater_1, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Deepwater_1, Condition(Trig_Deepwater_1_Conditions))
    TriggerAddAction(gg_trg_Deepwater_1, Trig_Deepwater_1_Actions)
end
-- END FOREST SECTION 49

-- BEGIN FOREST SECTION 50 Deepwater_2
-- Original JASS function: Trig_Deepwater_2_Conditions (line 7507)
function Trig_Deepwater_2_Conditions()
    if ((not ((udg_DeepWater1[GetConvertedPlayerId(GetOwningPlayer(GetConstructedStructure()))] == true)))) then
        do return false end
    end
    if ((not ((GetUnitTypeId(GetConstructedStructure()) == FourCC("e00R"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Deepwater_2_Actions (line 7517)
function Trig_Deepwater_2_Actions()
    UnitRemoveAbilityBJ(FourCC("A0A4"), GetConstructedStructure())
    UnitAddAbilityBJ(FourCC("A0BB"), GetConstructedStructure())
end

-- Original JASS function: InitTrig_Deepwater_2 (line 7523)
function InitTrig_Deepwater_2()
    gg_trg_Deepwater_2 = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Deepwater_2, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
    TriggerAddCondition(gg_trg_Deepwater_2, Condition(Trig_Deepwater_2_Conditions))
    TriggerAddAction(gg_trg_Deepwater_2, Trig_Deepwater_2_Actions)
end
-- END FOREST SECTION 50
