-- races / nerubian
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 121 LevelUpAura
-- Original JASS function: Trig_LevelUpAura_Conditions (line 9980)
function Trig_LevelUpAura_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("h059"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_LevelUpAura_Func003A (line 9987)
function Trig_LevelUpAura_Func003A()
    SetUnitAbilityLevelSwapped(FourCC("A09S"), GetEnumUnit(), udg_Ziggurats_Count)
    SetUnitAbilityLevelSwapped(FourCC("A0A1"), GetEnumUnit(), udg_Ziggurats_Count)
end

-- Original JASS function: Trig_LevelUpAura_Actions (line 9992)
function Trig_LevelUpAura_Actions()
    GroupAddUnitSimple(GetTriggerUnit(), udg_Ziggurats)
    udg_Ziggurats_Count = (__jint(udg_Ziggurats_Count + 1))
    ForGroupBJ(udg_Ziggurats, Trig_LevelUpAura_Func003A)
end

-- Original JASS function: InitTrig_LevelUpAura (line 9999)
function InitTrig_LevelUpAura()
    gg_trg_LevelUpAura = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_LevelUpAura, EVENT_PLAYER_UNIT_UPGRADE_FINISH)
    TriggerAddCondition(gg_trg_LevelUpAura, Condition(Trig_LevelUpAura_Conditions))
    TriggerAddAction(gg_trg_LevelUpAura, Trig_LevelUpAura_Actions)
end
-- END FOREST SECTION 121

-- BEGIN FOREST SECTION 122 DowngradeAura
-- Original JASS function: Trig_DowngradeAura_Conditions (line 10009)
function Trig_DowngradeAura_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("h059"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_DowngradeAura_Func003A (line 10016)
function Trig_DowngradeAura_Func003A()
    SetUnitAbilityLevelSwapped(FourCC("A09S"), GetEnumUnit(), udg_Ziggurats_Count)
    SetUnitAbilityLevelSwapped(FourCC("A0A1"), GetEnumUnit(), udg_Ziggurats_Count)
end

-- Original JASS function: Trig_DowngradeAura_Actions (line 10021)
function Trig_DowngradeAura_Actions()
    GroupAddUnitSimple(GetTriggerUnit(), udg_Ziggurats)
    udg_Ziggurats_Count = (__jint(udg_Ziggurats_Count - 1))
    ForGroupBJ(udg_Ziggurats, Trig_DowngradeAura_Func003A)
end

-- Original JASS function: InitTrig_DowngradeAura (line 10028)
function InitTrig_DowngradeAura()
    gg_trg_DowngradeAura = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_DowngradeAura, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_DowngradeAura, Condition(Trig_DowngradeAura_Conditions))
    TriggerAddAction(gg_trg_DowngradeAura, Trig_DowngradeAura_Actions)
end
-- END FOREST SECTION 122

-- BEGIN FOREST SECTION 123 NerubianSpires
-- Original JASS function: IsBaseBuilding (line 10039)
function IsBaseBuilding(baseId, upgradedId)
    if (((baseId == FourCC("hkee")) and (upgradedId == FourCC("hcas")))) then
        do return true end
    elseif (((baseId == FourCC("hbar")) and (upgradedId == FourCC("hbax")))) then
        do return true end
    end
    do return false end
end

-- Original JASS function: CheckNearbyUpgrades (line 10050)
function CheckNearbyUpgrades(u)
    local g = CreateGroup()
    local b = nil
    local result = false
    local newBuildingId = GetUnitTypeId(u)
    GroupEnumUnitsInRange(g, GetUnitX(u), GetUnitY(u), __jreal(2000), nil)
    while true do
        b = FirstOfGroup(g)
        if (b == nil) then break end
        if ((GetUnitTypeId(b) == newBuildingId) and (not (((GetUnitX(u) == GetUnitX(b)) and (GetUnitY(u) == GetUnitY(b)))))) then
            result = true
            if true then break end
        end
        GroupRemoveUnit(g, b)
    end
    DestroyGroup(g)
    do return result end
end

-- Original JASS function: OnConstructionStart (line 10072)
function OnConstructionStart()
    local u = GetTriggerUnit()
    if (GetUnitTypeId(GetTriggerUnit()) == FourCC("h059")) then
        if CheckNearbyUpgrades(u) then
            DisplayTextToPlayer(GetOwningPlayer(u), __jreal(0), __jreal(0), "Upgrading too close to an existing building!")
            TriggerSleepAction(__jreal(0.1))
            IssueImmediateOrderById(u, 851976)
        end
    end
end

-- Original JASS function: InitTrig_NerubianSpires (line 10086)
function InitTrig_NerubianSpires()
    local t = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_UPGRADE_START)
    TriggerAddAction(t, OnConstructionStart)
end
-- END FOREST SECTION 123

-- BEGIN FOREST SECTION 124 Frenzy
-- Original JASS function: Trig_Frenzy_Conditions (line 10097)
function Trig_Frenzy_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A09X"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Frenzy_Actions (line 10104)
function Trig_Frenzy_Actions()
    CreateNUnitsAtLoc(1, FourCC("h04L"), GetOwningPlayer(GetTriggerUnit()), GetUnitLoc(GetTriggerUnit()), bj_UNIT_FACING)
    UnitAddAbilityBJ(FourCC("A09Y"), GetLastCreatedUnit())
    UnitApplyTimedLifeBJ(__jreal(2.00), FourCC("BTLF"), GetLastCreatedUnit())
    IssueTargetOrderBJ(GetLastCreatedUnit(), "unholyfrenzy", GetSpellAbilityUnit())
end

-- Original JASS function: InitTrig_Frenzy (line 10112)
function InitTrig_Frenzy()
    gg_trg_Frenzy = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Frenzy, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Frenzy, Condition(Trig_Frenzy_Conditions))
    TriggerAddAction(gg_trg_Frenzy, Trig_Frenzy_Actions)
end
-- END FOREST SECTION 124
