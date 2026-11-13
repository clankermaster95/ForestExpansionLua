-- economy / base_flags
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 366 Base_List_Init
local baseFlagRawcodes = {
    "h04Z", "h050", "h05P", "h04Y", "h04V",
    "h04W", "h05N", "h04X", "h051", "h052",
}

local function IsBaseFlagType(unitType)
    for _, rawcode in ipairs(baseFlagRawcodes) do
        if unitType == FourCC(rawcode) then return true end
    end
    return false
end

FE_BaseFlags = { lumberCost = 2000, completed = {} }

function FE_BaseFlags.refreshOwners()
    local owners = {}
    for flag in pairs(FE_BaseFlags.completed) do
        if IsBaseFlagType(GetUnitTypeId(flag)) and GetWidgetLife(flag) > 0.405 and
            not IsUnitType(flag, UNIT_TYPE_DEAD) then
            owners[GetConvertedPlayerId(GetOwningPlayer(flag))] = true
        else
            -- RemoveUnit has no death event. Prune its retained reference before
            -- the next income payment; only completed flags enter this table.
            FE_BaseFlags.completed[flag] = nil
        end
    end
    FE_Roles.forEachPlayer(function(player)
        local index = GetConvertedPlayerId(player)
        udg_Flags[index] = owners[index] == true
    end)
end

function FE_BaseFlags.baseFor(flag)
    -- Solo skip can start construction before the old five-second setup timer.
    if udg_GARATHORbaseList[1] == nil then Trig_Base_List_Init_Actions() end
    for i = 1, 10 do
        if RectContainsUnit(udg_GARATHORbaseList[i], flag) then
            return udg_GARATHORbaseList[i]
        end
    end
    return nil
end

function FE_BaseFlags.ownerHasOtherFlag(owner, newFlag)
    local group = CreateGroup()
    GroupEnumUnitsOfPlayer(group, owner, nil)
    local found = false
    while true do
        local unit = FirstOfGroup(group)
        if unit == nil then break end
        GroupRemoveUnit(group, unit)
        if unit ~= newFlag and IsBaseFlagType(GetUnitTypeId(unit)) and
            GetWidgetLife(unit) > 0.405 and not IsUnitType(unit, UNIT_TYPE_DEAD) then
            found = true
            break
        end
    end
    DestroyGroup(group)
    return found
end

function FE_BaseFlags.reject(flag, message)
    local owner, x, y = GetOwningPlayer(flag), GetUnitX(flag), GetUnitY(flag)
    -- This is the only rejection/refund path and runs only for paid construction.
    -- Remove directly: stop/cancel orders can generate a separate native refund,
    -- and killing leaves a corpse and dispatches unrelated death/bounty events.
    RemoveUnit(flag)
    AdjustPlayerStateBJ(FE_BaseFlags.lumberCost, owner, PLAYER_STATE_RESOURCE_LUMBER)
    local effect = AddSpecialEffect("Abilities\\Spells\\Human\\ThunderClap\\ThunderClapCaster.mdl", x, y)
    DestroyEffect(effect)
    DisplayTimedTextToPlayer(owner, 0, 0, 2, message)
end

function FE_BaseFlags.validateConstruction(flag)
    if flag == nil or not IsBaseFlagType(GetUnitTypeId(flag)) then return end
    local base = FE_BaseFlags.baseFor(flag)
    if base == nil then
        FE_BaseFlags.reject(flag, "TRIGSTR_6233")
    elseif FE_BaseFlags.ownerHasOtherFlag(GetOwningPlayer(flag), flag) then
        FE_BaseFlags.reject(flag, "You have already constructed a base flag!")
    elseif Trig_Flagstack_Deny_BaseHasOtherFlag(base, flag) then
        FE_BaseFlags.reject(flag, "TRIGSTR_6274")
    end
end

function Trig_Base_List_Init_Actions()
    udg_GARATHORbaseList[1] = gg_rct_Base_1
    udg_GARATHORbaseList[2] = gg_rct_Base_2
    udg_GARATHORbaseList[3] = gg_rct_Base_3
    udg_GARATHORbaseList[4] = gg_rct_Base_4
    udg_GARATHORbaseList[5] = gg_rct_Base_5
    udg_GARATHORbaseList[6] = gg_rct_Base_6
    udg_GARATHORbaseList[7] = gg_rct_Base_7
    udg_GARATHORbaseList[8] = gg_rct_Base_8
    udg_GARATHORbaseList[9] = gg_rct_Base_9
    udg_GARATHORbaseList[10] = gg_rct_Base_10
end

function InitTrig_Base_List_Init()
    gg_trg_Base_List_Init = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_Base_List_Init, __jreal(5))
    TriggerAddAction(gg_trg_Base_List_Init, Trig_Base_List_Init_Actions)
end
-- END FOREST SECTION 366

-- BEGIN FOREST SECTION 367 Flagstack_Deny
function Trig_Flagstack_Deny_IsFlag(u)
    return IsBaseFlagType(GetUnitTypeId(u))
end

function Trig_Flagstack_Deny_Conditions()
    return Trig_Flagstack_Deny_IsFlag(GetTriggerUnit())
end

function Trig_Flagstack_Deny_BaseHasOtherFlag(r, newFlag)
    local g = CreateGroup()
    local u = nil
    local result = false
    GroupEnumUnitsInRect(g, r, nil)
    while true do
        u = FirstOfGroup(g)
        if ((u == nil) or result) then break end
        GroupRemoveUnit(g, u)
        if ((((u ~= newFlag) and (GetWidgetLife(u) > __jreal(0.405))) and (not IsUnitType(u, UNIT_TYPE_DEAD))) and Trig_Flagstack_Deny_IsFlag(u)) then
            result = true
        end
    end
    DestroyGroup(g)
    g = nil
    u = nil
    newFlag = nil
    return result
end

function Trig_Flagstack_Deny_Actions()
    -- Validation moved to the single construction-start handler below.
end

function InitTrig_Flagstack_Deny()
    -- Retain the named handle for editor compatibility, without an enter event.
    -- A spawned/loaded flag is not a paid construction and must never refund.
    gg_trg_Flagstack_Deny = CreateTrigger()
end
-- END FOREST SECTION 367

-- BEGIN FOREST SECTION 368 Flag_no_base_Deny
function Trig_Flag_no_base_Deny_Func001C()
    return IsBaseFlagType(GetUnitTypeId(GetConstructingStructure()))
end

function Trig_Flag_no_base_Deny_Conditions()
    return not not (Trig_Flag_no_base_Deny_Func001C())
end

function Trig_Flag_no_base_Deny_Func002C()
    return FE_BaseFlags.baseFor(GetConstructingStructure()) == nil
end

function Trig_Flag_no_base_Deny_Actions()
    FE_BaseFlags.validateConstruction(GetConstructingStructure())
end

function InitTrig_Flag_no_base_Deny()
    gg_trg_Flag_no_base_Deny = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Flag_no_base_Deny, EVENT_PLAYER_UNIT_CONSTRUCT_START)
    TriggerAddCondition(gg_trg_Flag_no_base_Deny, Condition(Trig_Flag_no_base_Deny_Conditions))
    TriggerAddAction(gg_trg_Flag_no_base_Deny, Trig_Flag_no_base_Deny_Actions)
end
-- END FOREST SECTION 368

-- BEGIN FOREST SECTION 369 NewFlag
function Trig_NewFlag_Conditions()
    local unitId = GetUnitTypeId(GetConstructedStructure())
    if not IsBaseFlagType(unitId) then
        return false
    end
    return true
end

function Trig_NewFlag_Actions()
    FE_BaseFlags.completed[GetConstructedStructure()] = true
    FE_BaseFlags.refreshOwners()
    local point = GetUnitLoc(GetConstructedStructure())
    PingMinimapLocForForce(GetPlayersAll(), point, __jreal(5.00))
    RemoveLocation(point)
    local enemies = GetPlayersEnemies(FE_Roles.ancient())
    local allies = GetPlayersAllies(FE_Roles.ancient())
    DisplayTextToForce(enemies, "A base flag has been constructed! You will receive 1 gold and 50 lumber every 6 seconds. However, should the base fall, the Ancient will receive 1000 gold!")
    DisplayTextToForce(allies, "A base flag has been constructed! The enemy expanders will receive 1 gold and 50 lumber every 6 seconds. However, should you destroy this base, you will receive 1000 gold! Destroy the base before the expanders get too strong.")
    DestroyForce(enemies)
    DestroyForce(allies)
end

function InitTrig_NewFlag()
    gg_trg_NewFlag = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_NewFlag, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
    TriggerAddCondition(gg_trg_NewFlag, Condition(Trig_NewFlag_Conditions))
    TriggerAddAction(gg_trg_NewFlag, Trig_NewFlag_Actions)
end
-- END FOREST SECTION 369

-- BEGIN FOREST SECTION 370 NewFlag2
function Trig_NewFlag2_Func001Func001Func001A()
    AdjustPlayerStateBJ(1, GetEnumPlayer(), PLAYER_STATE_RESOURCE_GOLD)
    AdjustPlayerStateBJ(50, GetEnumPlayer(), PLAYER_STATE_RESOURCE_LUMBER)
end

function Trig_NewFlag2_Func001Func001C()
    return udg_Flags[GetConvertedPlayerId(GetEnumPlayer())] == true
end

function Trig_NewFlag2_Func001A()
    if (Trig_NewFlag2_Func001Func001C()) then
        local allies = GetPlayersAllies(GetEnumPlayer())
        ForForce(allies, Trig_NewFlag2_Func001Func001Func001A)
        DestroyForce(allies)
    end
end

function Trig_NewFlag2_Actions()
    -- Takeover can preserve multiple flags under one owner. Pay one stream for
    -- that owner while any completed flag survives, using current ownership.
    FE_BaseFlags.refreshOwners()
    ForForce(GetPlayersAll(), Trig_NewFlag2_Func001A)
end

function InitTrig_NewFlag2()
    gg_trg_NewFlag2 = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(gg_trg_NewFlag2, __jreal(6.00))
    TriggerAddAction(gg_trg_NewFlag2, Trig_NewFlag2_Actions)
end
-- END FOREST SECTION 370

-- BEGIN FOREST SECTION 371 NewFlag3
function Trig_NewFlag3_Conditions()
    return IsBaseFlagType(GetUnitTypeId(GetDyingUnit()))
end

function Trig_NewFlag3_Actions()
    local flag = GetDyingUnit()
    local completed = FE_BaseFlags.completed[flag]
    FE_BaseFlags.completed[flag] = nil
    FE_BaseFlags.refreshOwners()
    if not completed or GetUnitTypeId(GetKillingUnitBJ()) == 0 then return end
    local point = GetUnitLoc(GetDyingUnit())
    PingMinimapLocForForce(GetPlayersAll(), point, __jreal(5.00))
    RemoveLocation(point)
    local enemies = GetPlayersEnemies(FE_Roles.ancient())
    local allies = GetPlayersAllies(FE_Roles.ancient())
    DisplayTextToForce(enemies, "TRIGSTR_1774")
    DisplayTextToForce(allies, "TRIGSTR_1824")
    DestroyForce(enemies)
    DestroyForce(allies)
end

function InitTrig_NewFlag3()
    gg_trg_NewFlag3 = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_NewFlag3, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_NewFlag3, Condition(Trig_NewFlag3_Conditions))
    TriggerAddAction(gg_trg_NewFlag3, Trig_NewFlag3_Actions)
end
-- END FOREST SECTION 371

-- BEGIN FOREST SECTION 372 NewFlag4
function Trig_NewFlag4_Conditions()
    local unitId = GetUnitTypeId(GetConstructingStructure())
    if (not (udg_Flags[GetConvertedPlayerId(GetOwningPlayer(GetConstructingStructure()))] == true)) then
        return false
    end
    if not IsBaseFlagType(unitId) then
        return false
    end
    return true
end

function Trig_NewFlag4_Actions()
    -- Owner and region limits share the single construction-start handler.
end

function InitTrig_NewFlag4()
    gg_trg_NewFlag4 = CreateTrigger()
end
-- END FOREST SECTION 372

-- BEGIN FOREST SECTION 373 NewFlag5
function Trig_NewFlag5_Conditions()
    local unitId = GetUnitTypeId(GetAttackedUnitBJ())
    if not IsBaseFlagType(unitId) then
        return false
    end
    return true
end

function Trig_NewFlag5_Func001C()
    return GetOwningPlayer(GetAttacker()) == FE_Roles.ancient()
end

function Trig_NewFlag5_Actions()
    if (Trig_NewFlag5_Func001C()) then
    else
        IssueImmediateOrderBJ(GetAttacker(), "stop")
    end
end

function InitTrig_NewFlag5()
    gg_trg_NewFlag5 = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_NewFlag5, EVENT_PLAYER_UNIT_ATTACKED)
    TriggerAddCondition(gg_trg_NewFlag5, Condition(Trig_NewFlag5_Conditions))
    TriggerAddAction(gg_trg_NewFlag5, Trig_NewFlag5_Actions)
end
-- END FOREST SECTION 373
