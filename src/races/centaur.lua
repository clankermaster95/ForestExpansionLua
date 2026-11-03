-- races / centaur
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 45 Iron_Hoove
-- Original JASS function: UPG_MinInt (line 7334)
function UPG_MinInt(a, b)
    if (a < b) then
        do return a end
    end
    do return b end
end

-- Original JASS function: UPG_GetAbilityLevelForPlayer (line 7342)
function UPG_GetAbilityLevelForPlayer(p)
    do return UPG_MinInt(__jint(UPG_BASE_ABILITY_LEVEL + GetPlayerTechCount(p, UPG_UPGRADE_ID, true)), UPG_MAX_ABILITY_LEVEL) end
end

-- Original JASS function: UPG_ApplyToUnit (line 7346)
function UPG_ApplyToUnit(u)
    local wantedLevel = 0
    if (GetUnitAbilityLevel(u, UPG_ABILITY_ID) > 0) then
        wantedLevel = (UPG_MinInt(__jint(UPG_BASE_ABILITY_LEVEL + GetPlayerTechCount((GetOwningPlayer(u)), UPG_UPGRADE_ID, true)), UPG_MAX_ABILITY_LEVEL))
        if (wantedLevel > GetUnitAbilityLevel(u, UPG_ABILITY_ID)) then
            SetUnitAbilityLevel(u, UPG_ABILITY_ID, wantedLevel)
        end
    end
end

-- Original JASS function: UPG_ApplyToAllUnitsOfPlayer (line 7358)
function UPG_ApplyToAllUnitsOfPlayer(p)
    local u = nil
    GroupEnumUnitsOfPlayer(UPG_TempGroup, p, nil)
    while true do
        u = FirstOfGroup(UPG_TempGroup)
        if (u == nil) then break end
        GroupRemoveUnit(UPG_TempGroup, u)
        UPG_ApplyToUnit(u)
    end
    u = nil
end

-- Original JASS function: UPG_OnResearchFinish (line 7374)
function UPG_OnResearchFinish()
    local researchedId = GetResearched()
    local p = nil
    if (researchedId == UPG_UPGRADE_ID) then
        p = GetOwningPlayer(GetTriggerUnit())
        UPG_ApplyToAllUnitsOfPlayer(p)
        p = nil
    end
end

-- Original JASS function: UPG_OnUnitEnterMap (line 7385)
function UPG_OnUnitEnterMap()
    UPG_ApplyToUnit(GetTriggerUnit())
end

-- Original JASS function: InitTrig_Iron_Hoove (line 7389)
function InitTrig_Iron_Hoove()
    UPG_ResearchTrig = CreateTrigger()
    UPG_EnterTrig = CreateTrigger()
    UPG_WorldRegion = CreateRegion()
    TriggerRegisterAnyUnitEventBJ(UPG_ResearchTrig, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddAction(UPG_ResearchTrig, UPG_OnResearchFinish)
    RegionAddRect(UPG_WorldRegion, GetWorldBounds())
    TriggerRegisterEnterRegion(UPG_EnterTrig, UPG_WorldRegion, nil)
    TriggerAddAction(UPG_EnterTrig, UPG_OnUnitEnterMap)
end
-- END FOREST SECTION 45
