-- races / night_elf
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 49 Deepwater_1
function Trig_Deepwater_1_Conditions()
    return GetResearched() == FourCC("R066")
end

function Trig_Deepwater_1_Func001A()
    UnitRemoveAbilityBJ(FourCC("A0A4"), GetEnumUnit())
    UnitAddAbilityBJ(FourCC("A0BB"), GetEnumUnit())
end

function Trig_Deepwater_1_Actions()
    local player = GetOwningPlayer(GetResearchingUnit())
    udg_DeepWater1[GetConvertedPlayerId(player)] = true
    local units = GetUnitsOfPlayerAndTypeId(player, FourCC("e00R"))
    ForGroupBJ(units, Trig_Deepwater_1_Func001A)
    DestroyGroup(units)
end

function InitTrig_Deepwater_1()
    gg_trg_Deepwater_1 = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Deepwater_1, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Deepwater_1, Condition(Trig_Deepwater_1_Conditions))
    TriggerAddAction(gg_trg_Deepwater_1, Trig_Deepwater_1_Actions)
end
-- END FOREST SECTION 49

-- BEGIN FOREST SECTION 50 Deepwater_2
function Trig_Deepwater_2_Conditions()
    if (not (udg_DeepWater1[GetConvertedPlayerId(GetOwningPlayer(GetConstructedStructure()))] == true)) then
        return false
    end
    if (not (GetUnitTypeId(GetConstructedStructure()) == FourCC("e00R"))) then
        return false
    end
    return true
end

function Trig_Deepwater_2_Actions()
    UnitRemoveAbilityBJ(FourCC("A0A4"), GetConstructedStructure())
    UnitAddAbilityBJ(FourCC("A0BB"), GetConstructedStructure())
end

function InitTrig_Deepwater_2()
    gg_trg_Deepwater_2 = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Deepwater_2, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
    TriggerAddCondition(gg_trg_Deepwater_2, Condition(Trig_Deepwater_2_Conditions))
    TriggerAddAction(gg_trg_Deepwater_2, Trig_Deepwater_2_Actions)
end
-- END FOREST SECTION 50
