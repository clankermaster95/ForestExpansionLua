-- races / nerubian
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

FE_Nerubian = { removalHooked = false }

function FE_Nerubian.untrack(unit)
    if unit == nil or udg_Ziggurats == nil or not IsUnitInGroup(unit, udg_Ziggurats) then return end
    GroupRemoveUnitSimple(unit, udg_Ziggurats)
    udg_Ziggurats_Count = math.max(0, __jint(udg_Ziggurats_Count - 1))
    ForGroupBJ(udg_Ziggurats, Trig_DowngradeAura_Func003A)
end

-- BEGIN FOREST SECTION 121 LevelUpAura
function Trig_LevelUpAura_Conditions()
    return GetUnitTypeId(GetTriggerUnit()) == FourCC("h059")
end

function Trig_LevelUpAura_Func003A()
    SetUnitAbilityLevelSwapped(FourCC("A09S"), GetEnumUnit(), udg_Ziggurats_Count)
    SetUnitAbilityLevelSwapped(FourCC("A0A1"), GetEnumUnit(), udg_Ziggurats_Count)
end

function Trig_LevelUpAura_Actions()
    if IsUnitInGroup(GetTriggerUnit(), udg_Ziggurats) then return end
    GroupAddUnitSimple(GetTriggerUnit(), udg_Ziggurats)
    udg_Ziggurats_Count = (__jint(udg_Ziggurats_Count + 1))
    ForGroupBJ(udg_Ziggurats, Trig_LevelUpAura_Func003A)
end

function InitTrig_LevelUpAura()
    if not FE_Nerubian.removalHooked then
        FE_Nerubian.removalHooked = true
        local remove = RemoveUnit
        -- Defeat and unclaimed-leaver cleanup remove units without a death event.
        -- Untrack before the native invalidates the unit/group membership.
        RemoveUnit = function(unit)
            FE_Nerubian.untrack(unit)
            return remove(unit)
        end
    end
    gg_trg_LevelUpAura = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_LevelUpAura, EVENT_PLAYER_UNIT_UPGRADE_FINISH)
    TriggerAddCondition(gg_trg_LevelUpAura, Condition(Trig_LevelUpAura_Conditions))
    TriggerAddAction(gg_trg_LevelUpAura, Trig_LevelUpAura_Actions)
end
-- END FOREST SECTION 121

-- BEGIN FOREST SECTION 122 DowngradeAura
function Trig_DowngradeAura_Conditions()
    return GetUnitTypeId(GetTriggerUnit()) == FourCC("h059")
end

function Trig_DowngradeAura_Func003A()
    SetUnitAbilityLevelSwapped(FourCC("A09S"), GetEnumUnit(), udg_Ziggurats_Count)
    SetUnitAbilityLevelSwapped(FourCC("A0A1"), GetEnumUnit(), udg_Ziggurats_Count)
end

function Trig_DowngradeAura_Actions()
    FE_Nerubian.untrack(GetTriggerUnit())
end

function InitTrig_DowngradeAura()
    gg_trg_DowngradeAura = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_DowngradeAura, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_DowngradeAura, Condition(Trig_DowngradeAura_Conditions))
    TriggerAddAction(gg_trg_DowngradeAura, Trig_DowngradeAura_Actions)
end
-- END FOREST SECTION 122

-- BEGIN FOREST SECTION 123 NerubianSpires
function IsBaseBuilding(baseId, upgradedId)
    if ((baseId == FourCC("hkee")) and (upgradedId == FourCC("hcas"))) then
        return true
    elseif (((baseId == FourCC("hbar")) and (upgradedId == FourCC("hbax")))) then
        return true
    end
    return false
end

function CheckNearbyUpgrades(u)
    local g = CreateGroup()
    local b = nil
    local result = false
    local newBuildingId = GetUnitTypeId(u)
    GroupEnumUnitsInRange(g, GetUnitX(u), GetUnitY(u), __jreal(2000), nil)
    while true do
        b = FirstOfGroup(g)
        if (b == nil) then break end
        if b ~= u and GetUnitTypeId(b) == newBuildingId and
            GetWidgetLife(b) > __jreal(0.405) and not IsUnitType(b, UNIT_TYPE_DEAD) then
            result = true
            if true then break end
        end
        GroupRemoveUnit(g, b)
    end
    DestroyGroup(g)
    return result
end

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

function InitTrig_NerubianSpires()
    local t = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_UPGRADE_START)
    TriggerAddAction(t, OnConstructionStart)
end
-- END FOREST SECTION 123

-- BEGIN FOREST SECTION 124 Frenzy
function Trig_Frenzy_Conditions()
    return GetSpellAbilityId() == FourCC("A09X")
end

function Trig_Frenzy_Actions()
    local point = GetUnitLoc(GetTriggerUnit())
    CreateNUnitsAtLoc(1, FourCC("h04L"), GetOwningPlayer(GetTriggerUnit()), point, bj_UNIT_FACING)
    RemoveLocation(point)
    UnitAddAbilityBJ(FourCC("A09Y"), GetLastCreatedUnit())
    UnitApplyTimedLifeBJ(__jreal(2.00), FourCC("BTLF"), GetLastCreatedUnit())
    IssueTargetOrderBJ(GetLastCreatedUnit(), "unholyfrenzy", GetSpellAbilityUnit())
end

function InitTrig_Frenzy()
    gg_trg_Frenzy = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Frenzy, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Frenzy, Condition(Trig_Frenzy_Conditions))
    TriggerAddAction(gg_trg_Frenzy, Trig_Frenzy_Actions)
end
-- END FOREST SECTION 124
