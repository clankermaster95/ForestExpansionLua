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
    local newFlag = GetTriggerUnit()
    local i = 1
    local e = nil
    while true do
        if (i > 10) then break end
        if RectContainsUnit(udg_GARATHORbaseList[i], newFlag) then
            if Trig_Flagstack_Deny_BaseHasOtherFlag(udg_GARATHORbaseList[i], newFlag) then
                e = AddSpecialEffect("Abilities\\Spells\\Human\\ThunderClap\\ThunderClapCaster.mdl", GetUnitX(newFlag), GetUnitY(newFlag))
                DestroyEffect(e)
                KillUnit(newFlag)
                AdjustPlayerStateBJ(2000, GetOwningPlayer(newFlag), PLAYER_STATE_RESOURCE_LUMBER)
                DisplayTimedTextToForce(GetForceOfPlayer(GetOwningPlayer(newFlag)), __jreal(2.00), "TRIGSTR_6274")
            end
            e = nil
            newFlag = nil
            return
        end
        i = __jint(i + 1)
    end
    e = nil
    newFlag = nil
end

function InitTrig_Flagstack_Deny()
    gg_trg_Flagstack_Deny = CreateTrigger()
    TriggerRegisterEnterRectSimple(gg_trg_Flagstack_Deny, GetPlayableMapRect())
    TriggerAddCondition(gg_trg_Flagstack_Deny, Condition(Trig_Flagstack_Deny_Conditions))
    TriggerAddAction(gg_trg_Flagstack_Deny, Trig_Flagstack_Deny_Actions)
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
    if (not (RectContainsUnit(udg_GARATHORbaseList[1], GetConstructingStructure()) == false)) then
        return false
    end
    if (not (RectContainsUnit(udg_GARATHORbaseList[2], GetConstructingStructure()) == false)) then
        return false
    end
    if (not (RectContainsUnit(udg_GARATHORbaseList[3], GetConstructingStructure()) == false)) then
        return false
    end
    if (not (RectContainsUnit(udg_GARATHORbaseList[4], GetConstructingStructure()) == false)) then
        return false
    end
    if (not (RectContainsUnit(udg_GARATHORbaseList[5], GetConstructingStructure()) == false)) then
        return false
    end
    if (not (RectContainsUnit(udg_GARATHORbaseList[6], GetConstructingStructure()) == false)) then
        return false
    end
    if (not (RectContainsUnit(udg_GARATHORbaseList[7], GetConstructingStructure()) == false)) then
        return false
    end
    if (not (RectContainsUnit(udg_GARATHORbaseList[8], GetConstructingStructure()) == false)) then
        return false
    end
    if (not (RectContainsUnit(udg_GARATHORbaseList[9], GetConstructingStructure()) == false)) then
        return false
    end
    if (not (RectContainsUnit(udg_GARATHORbaseList[10], GetConstructingStructure()) == false)) then
        return false
    end
    return true
end

function Trig_Flag_no_base_Deny_Actions()
    if (Trig_Flag_no_base_Deny_Func002C()) then
        AddSpecialEffectLocBJ(GetUnitLoc(GetConstructingStructure()), "Abilities\\Spells\\Human\\ThunderClap\\ThunderClapCaster.mdl")
        SetPlayerStateBJ(GetOwningPlayer(GetTriggerUnit()), PLAYER_STATE_RESOURCE_LUMBER, (__jint(GetPlayerState(Player(0), PLAYER_STATE_RESOURCE_LUMBER) + 2000)))
        DisplayTextToForce(GetForceOfPlayer(GetOwningPlayer(GetTriggerUnit())), "TRIGSTR_6233")
        RemoveUnit(GetConstructingStructure())
    end
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
    PingMinimapLocForForce(GetPlayersAll(), GetUnitLoc(GetConstructedStructure()), __jreal(5.00))
    DisplayTextToForce(GetPlayersEnemies(FE_Roles.ancient()), "A base flag has been constructed! You will receive 1 gold and 50 lumber every 6 seconds. However, should the base fall, the Ancient will receive 1000 gold!")
    DisplayTextToForce(GetPlayersAllies(FE_Roles.ancient()), "A base flag has been constructed! The enemy expanders will recieve 1 gold and 50 lumber every 6 seconds. However, should you destroy this base, you will recieve 1000 gold! Destroy the base before the expanders get too strong.")
    udg_Flags[GetConvertedPlayerId(GetTriggerPlayer())] = true
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
        ForForce(GetPlayersAllies(GetEnumPlayer()), Trig_NewFlag2_Func001Func001Func001A)
    end
end

function Trig_NewFlag2_Actions()
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
    local unitId = GetUnitTypeId(GetDyingUnit())
    if not IsBaseFlagType(unitId) then
        return false
    end
    if (not (GetUnitTypeId(GetKillingUnitBJ()) ~= 0)) then
        return false
    end
    return true
end

function Trig_NewFlag3_Actions()
    PingMinimapLocForForce(GetPlayersAll(), GetUnitLoc(GetDyingUnit()), __jreal(5.00))
    DisplayTextToForce(GetPlayersEnemies(FE_Roles.ancient()), "TRIGSTR_1774")
    DisplayTextToForce(GetPlayersAllies(FE_Roles.ancient()), "TRIGSTR_1824")
    udg_Flags[GetConvertedPlayerId(GetOwningPlayer(GetDyingUnit()))] = false
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
    udg_Flag = GetOwningPlayer(GetTriggerUnit())
    IssueImmediateOrderBJ(GetTriggerUnit(), "stop")
    KillUnit(GetConstructingStructure())
    SetPlayerStateBJ(udg_Flag, PLAYER_STATE_RESOURCE_LUMBER, (__jint(GetPlayerState(udg_Flag, PLAYER_STATE_RESOURCE_LUMBER) + 2000)))
    DisplayTextToForce(GetForceOfPlayer(udg_Flag), "You have already constructed a base flag!")
end

function InitTrig_NewFlag4()
    gg_trg_NewFlag4 = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_NewFlag4, EVENT_PLAYER_UNIT_CONSTRUCT_START)
    TriggerAddCondition(gg_trg_NewFlag4, Condition(Trig_NewFlag4_Conditions))
    TriggerAddAction(gg_trg_NewFlag4, Trig_NewFlag4_Actions)
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
