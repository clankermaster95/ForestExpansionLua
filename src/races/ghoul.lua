-- races / ghoul
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 59 Ghoul_Units
-- Original JASS function: Trig_Ghoul_Units_Func003001 (line 7848)
function Trig_Ghoul_Units_Func003001()
    do return ((GetUnitTypeId(GetConstructedStructure()) == FourCC("h01S"))) end
end

-- Original JASS function: Trig_Ghoul_Units_Func003002 (line 7852)
function Trig_Ghoul_Units_Func003002()
    do return ((GetUnitTypeId(GetConstructedStructure()) == FourCC("h01T"))) end
end

-- Original JASS function: Trig_Ghoul_Units_Conditions (line 7856)
function Trig_Ghoul_Units_Conditions()
    if ((not GetBooleanOr(((GetUnitTypeId(GetConstructedStructure()) == FourCC("h01S"))), ((GetUnitTypeId(GetConstructedStructure()) == FourCC("h01T")))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Ghoul_Units_Actions (line 7863)
function Trig_Ghoul_Units_Actions()
    BlzSetUnitBooleanFieldBJ(GetConstructedStructure(), UNIT_BF_IS_A_BUILDING, false)
end

-- Original JASS function: InitTrig_Ghoul_Units (line 7868)
function InitTrig_Ghoul_Units()
    gg_trg_Ghoul_Units = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Ghoul_Units, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
    TriggerAddCondition(gg_trg_Ghoul_Units, Condition(Trig_Ghoul_Units_Conditions))
    TriggerAddAction(gg_trg_Ghoul_Units, Trig_Ghoul_Units_Actions)
end
-- END FOREST SECTION 59

-- BEGIN FOREST SECTION 60 Ghoul_lumber
-- Original JASS function: Trig_Ghoul_lumber_Conditions (line 7878)
function Trig_Ghoul_lumber_Conditions()
    do return (GetResearched() == FourCC("R05K")) end
end

-- Original JASS function: Trig_Ghoul_lumber_ApplyToUnit (line 7882)
function Trig_Ghoul_lumber_ApplyToUnit(u)
    local p = nil
    local upgradeLevel = 0
    if (GetUnitTypeId(u) == FourCC("o005")) then
        p = GetOwningPlayer(u)
        upgradeLevel = GetPlayerTechCount(p, FourCC("R05K"), true)
        if (upgradeLevel >= 2) then
            UnitRemoveAbility(u, FourCC("A08Y"))
            UnitRemoveAbility(u, FourCC("A08Z"))
            UnitAddAbility(u, FourCC("A005"))
        elseif (upgradeLevel == 1) then
            UnitRemoveAbility(u, FourCC("A08Y"))
            UnitRemoveAbility(u, FourCC("A005"))
            UnitAddAbility(u, FourCC("A08Z"))
        end
        p = nil
    end
end

-- Original JASS function: Trig_Ghoul_lumber_Actions (line 7904)
function Trig_Ghoul_lumber_Actions()
    local p = GetOwningPlayer(GetResearchingUnit())
    local g = CreateGroup()
    local u = nil
    GroupEnumUnitsOfPlayer(g, p, nil)
    while true do
        u = FirstOfGroup(g)
        if (u == nil) then break end
        GroupRemoveUnit(g, u)
        Trig_Ghoul_lumber_ApplyToUnit(u)
    end
    DestroyGroup(g)
    u = nil
    g = nil
    p = nil
end

-- Original JASS function: Trig_Ghoul_lumber_Enter_Actions (line 7926)
function Trig_Ghoul_lumber_Enter_Actions()
    Trig_Ghoul_lumber_ApplyToUnit(GetTriggerUnit())
end

-- Original JASS function: InitTrig_Ghoul_lumber (line 7931)
function InitTrig_Ghoul_lumber()
    local enterTrig = CreateTrigger()
    local worldRegion = CreateRegion()
    gg_trg_Ghoul_lumber = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Ghoul_lumber, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Ghoul_lumber, Condition(Trig_Ghoul_lumber_Conditions))
    TriggerAddAction(gg_trg_Ghoul_lumber, Trig_Ghoul_lumber_Actions)
    RegionAddRect(worldRegion, GetWorldBounds())
    TriggerRegisterEnterRegion(enterTrig, worldRegion, nil)
    TriggerAddAction(enterTrig, Trig_Ghoul_lumber_Enter_Actions)
    enterTrig = nil
    worldRegion = nil
end
-- END FOREST SECTION 60
