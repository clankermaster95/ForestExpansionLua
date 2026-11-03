-- economy / base_flags
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 366 Base_List_Init
-- Original JASS function: Trig_Base_List_Init_Actions (line 19984)
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

-- Original JASS function: InitTrig_Base_List_Init (line 19998)
function InitTrig_Base_List_Init()
    gg_trg_Base_List_Init = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_Base_List_Init, __jreal(5))
    TriggerAddAction(gg_trg_Base_List_Init, Trig_Base_List_Init_Actions)
end
-- END FOREST SECTION 366

-- BEGIN FOREST SECTION 367 Flagstack_Deny
-- Original JASS function: Trig_Flagstack_Deny_IsFlag (line 20007)
function Trig_Flagstack_Deny_IsFlag(u)
    local id = GetUnitTypeId(u)
    if (id == FourCC("h04Z")) then
        do return true end
    end
    if (id == FourCC("h050")) then
        do return true end
    end
    if (id == FourCC("h05P")) then
        do return true end
    end
    if (id == FourCC("h04Y")) then
        do return true end
    end
    if (id == FourCC("h04V")) then
        do return true end
    end
    if (id == FourCC("h04W")) then
        do return true end
    end
    if (id == FourCC("h05N")) then
        do return true end
    end
    if (id == FourCC("h04X")) then
        do return true end
    end
    if (id == FourCC("h051")) then
        do return true end
    end
    if (id == FourCC("h052")) then
        do return true end
    end
    do return false end
end

-- Original JASS function: Trig_Flagstack_Deny_Conditions (line 20044)
function Trig_Flagstack_Deny_Conditions()
    do return Trig_Flagstack_Deny_IsFlag(GetTriggerUnit()) end
end

-- Original JASS function: Trig_Flagstack_Deny_BaseHasOtherFlag (line 20048)
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
    do return result end
end

-- Original JASS function: Trig_Flagstack_Deny_Actions (line 20075)
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
            do return end
        end
        i = __jint(i + 1)
    end
    e = nil
    newFlag = nil
end

-- Original JASS function: InitTrig_Flagstack_Deny (line 20105)
function InitTrig_Flagstack_Deny()
    gg_trg_Flagstack_Deny = CreateTrigger()
    TriggerRegisterEnterRectSimple(gg_trg_Flagstack_Deny, GetPlayableMapRect())
    TriggerAddCondition(gg_trg_Flagstack_Deny, Condition(Trig_Flagstack_Deny_Conditions))
    TriggerAddAction(gg_trg_Flagstack_Deny, Trig_Flagstack_Deny_Actions)
end
-- END FOREST SECTION 367

-- BEGIN FOREST SECTION 368 Flag_no_base_Deny
-- Original JASS function: Trig_Flag_no_base_Deny_Func001C (line 20115)
function Trig_Flag_no_base_Deny_Func001C()
    if (((GetUnitTypeId(GetConstructingStructure()) == FourCC("h04Z")))) then
        do return true end
    end
    if (((GetUnitTypeId(GetConstructingStructure()) == FourCC("h050")))) then
        do return true end
    end
    if (((GetUnitTypeId(GetConstructingStructure()) == FourCC("h05P")))) then
        do return true end
    end
    if (((GetUnitTypeId(GetConstructingStructure()) == FourCC("h04Y")))) then
        do return true end
    end
    if (((GetUnitTypeId(GetConstructingStructure()) == FourCC("h04V")))) then
        do return true end
    end
    if (((GetUnitTypeId(GetConstructingStructure()) == FourCC("h04W")))) then
        do return true end
    end
    if (((GetUnitTypeId(GetConstructingStructure()) == FourCC("h05N")))) then
        do return true end
    end
    if (((GetUnitTypeId(GetConstructingStructure()) == FourCC("h04X")))) then
        do return true end
    end
    if (((GetUnitTypeId(GetConstructingStructure()) == FourCC("h051")))) then
        do return true end
    end
    if (((GetUnitTypeId(GetConstructingStructure()) == FourCC("h052")))) then
        do return true end
    end
    do return false end
end

-- Original JASS function: Trig_Flag_no_base_Deny_Conditions (line 20149)
function Trig_Flag_no_base_Deny_Conditions()
    if ((not Trig_Flag_no_base_Deny_Func001C())) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Flag_no_base_Deny_Func002C (line 20156)
function Trig_Flag_no_base_Deny_Func002C()
    if ((not ((RectContainsUnit(udg_GARATHORbaseList[1], GetConstructingStructure()) == false)))) then
        do return false end
    end
    if ((not ((RectContainsUnit(udg_GARATHORbaseList[2], GetConstructingStructure()) == false)))) then
        do return false end
    end
    if ((not ((RectContainsUnit(udg_GARATHORbaseList[3], GetConstructingStructure()) == false)))) then
        do return false end
    end
    if ((not ((RectContainsUnit(udg_GARATHORbaseList[4], GetConstructingStructure()) == false)))) then
        do return false end
    end
    if ((not ((RectContainsUnit(udg_GARATHORbaseList[5], GetConstructingStructure()) == false)))) then
        do return false end
    end
    if ((not ((RectContainsUnit(udg_GARATHORbaseList[6], GetConstructingStructure()) == false)))) then
        do return false end
    end
    if ((not ((RectContainsUnit(udg_GARATHORbaseList[7], GetConstructingStructure()) == false)))) then
        do return false end
    end
    if ((not ((RectContainsUnit(udg_GARATHORbaseList[8], GetConstructingStructure()) == false)))) then
        do return false end
    end
    if ((not ((RectContainsUnit(udg_GARATHORbaseList[9], GetConstructingStructure()) == false)))) then
        do return false end
    end
    if ((not ((RectContainsUnit(udg_GARATHORbaseList[10], GetConstructingStructure()) == false)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Flag_no_base_Deny_Actions (line 20190)
function Trig_Flag_no_base_Deny_Actions()
    if (Trig_Flag_no_base_Deny_Func002C()) then
        AddSpecialEffectLocBJ(GetUnitLoc(GetConstructingStructure()), "Abilities\\Spells\\Human\\ThunderClap\\ThunderClapCaster.mdl")
        SetPlayerStateBJ(GetOwningPlayer(GetTriggerUnit()), PLAYER_STATE_RESOURCE_LUMBER, (__jint(GetPlayerState(Player(0), PLAYER_STATE_RESOURCE_LUMBER) + 2000)))
        DisplayTextToForce(GetForceOfPlayer(GetOwningPlayer(GetTriggerUnit())), "TRIGSTR_6233")
        RemoveUnit(GetConstructingStructure())
    else
    end
end

-- Original JASS function: InitTrig_Flag_no_base_Deny (line 20201)
function InitTrig_Flag_no_base_Deny()
    gg_trg_Flag_no_base_Deny = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Flag_no_base_Deny, EVENT_PLAYER_UNIT_CONSTRUCT_START)
    TriggerAddCondition(gg_trg_Flag_no_base_Deny, Condition(Trig_Flag_no_base_Deny_Conditions))
    TriggerAddAction(gg_trg_Flag_no_base_Deny, Trig_Flag_no_base_Deny_Actions)
end
-- END FOREST SECTION 368

-- BEGIN FOREST SECTION 369 NewFlag
-- Original JASS function: Trig_NewFlag_Conditions (line 20211)
function Trig_NewFlag_Conditions()
    local unitId = GetUnitTypeId(GetConstructedStructure())
    if ((not (((((((((((unitId == FourCC("h04Z")) or (unitId == FourCC("h050"))) or (unitId == FourCC("h04Y"))) or (unitId == FourCC("h04V"))) or (unitId == FourCC("h04W"))) or (unitId == FourCC("h05N"))) or (unitId == FourCC("h04X"))) or (unitId == FourCC("h051"))) or (unitId == FourCC("h052"))) or (unitId == FourCC("h05P")))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_NewFlag_Actions (line 20219)
function Trig_NewFlag_Actions()
    PingMinimapLocForForce(GetPlayersAll(), GetUnitLoc(GetConstructedStructure()), __jreal(5.00))
    DisplayTextToForce(GetPlayersEnemies(FE_Roles.ancient()), "A base flag has been constructed! You will receive 1 gold and 50 lumber every 6 seconds. However, should the base fall, the Ancient will receive 1000 gold!")
    DisplayTextToForce(GetPlayersAllies(FE_Roles.ancient()), "A base flag has been constructed! The enemy expanders will recieve 1 gold and 50 lumber every 6 seconds. However, should you destroy this base, you will recieve 1000 gold! Destroy the base before the expanders get too strong.")
    udg_Flags[GetConvertedPlayerId(GetTriggerPlayer())] = true
end

-- Original JASS function: InitTrig_NewFlag (line 20227)
function InitTrig_NewFlag()
    gg_trg_NewFlag = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_NewFlag, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
    TriggerAddCondition(gg_trg_NewFlag, Condition(Trig_NewFlag_Conditions))
    TriggerAddAction(gg_trg_NewFlag, Trig_NewFlag_Actions)
end
-- END FOREST SECTION 369

-- BEGIN FOREST SECTION 370 NewFlag2
-- Original JASS function: Trig_NewFlag2_Func001Func001Func001A (line 20238)
function Trig_NewFlag2_Func001Func001Func001A()
    AdjustPlayerStateBJ(1, GetEnumPlayer(), PLAYER_STATE_RESOURCE_GOLD)
    AdjustPlayerStateBJ(50, GetEnumPlayer(), PLAYER_STATE_RESOURCE_LUMBER)
end

-- Original JASS function: Trig_NewFlag2_Func001Func001C (line 20243)
function Trig_NewFlag2_Func001Func001C()
    if ((not ((udg_Flags[GetConvertedPlayerId(GetEnumPlayer())] == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_NewFlag2_Func001A (line 20250)
function Trig_NewFlag2_Func001A()
    if (Trig_NewFlag2_Func001Func001C()) then
        ForForce(GetPlayersAllies(GetEnumPlayer()), Trig_NewFlag2_Func001Func001Func001A)
    else
    end
end

-- Original JASS function: Trig_NewFlag2_Actions (line 20257)
function Trig_NewFlag2_Actions()
    ForForce(GetPlayersAll(), Trig_NewFlag2_Func001A)
end

-- Original JASS function: InitTrig_NewFlag2 (line 20262)
function InitTrig_NewFlag2()
    gg_trg_NewFlag2 = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(gg_trg_NewFlag2, __jreal(6.00))
    TriggerAddAction(gg_trg_NewFlag2, Trig_NewFlag2_Actions)
end
-- END FOREST SECTION 370

-- BEGIN FOREST SECTION 371 NewFlag3
-- Original JASS function: Trig_NewFlag3_Conditions (line 20271)
function Trig_NewFlag3_Conditions()
    local unitId = GetUnitTypeId(GetDyingUnit())
    if ((not (((((((((((unitId == FourCC("h04Z")) or (unitId == FourCC("h050"))) or (unitId == FourCC("h04Y"))) or (unitId == FourCC("h04V"))) or (unitId == FourCC("h04W"))) or (unitId == FourCC("h05N"))) or (unitId == FourCC("h04X"))) or (unitId == FourCC("h051"))) or (unitId == FourCC("h052"))) or (unitId == FourCC("h05P")))))) then
        do return false end
    end
    if ((not ((GetUnitTypeId(GetKillingUnitBJ()) ~= 0)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_NewFlag3_Actions (line 20282)
function Trig_NewFlag3_Actions()
    PingMinimapLocForForce(GetPlayersAll(), GetUnitLoc(GetDyingUnit()), __jreal(5.00))
    DisplayTextToForce(GetPlayersEnemies(FE_Roles.ancient()), "TRIGSTR_1774")
    DisplayTextToForce(GetPlayersAllies(FE_Roles.ancient()), "TRIGSTR_1824")
    udg_Flags[GetConvertedPlayerId(GetOwningPlayer(GetDyingUnit()))] = false
end

-- Original JASS function: InitTrig_NewFlag3 (line 20290)
function InitTrig_NewFlag3()
    gg_trg_NewFlag3 = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_NewFlag3, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_NewFlag3, Condition(Trig_NewFlag3_Conditions))
    TriggerAddAction(gg_trg_NewFlag3, Trig_NewFlag3_Actions)
end
-- END FOREST SECTION 371

-- BEGIN FOREST SECTION 372 NewFlag4
-- Original JASS function: Trig_NewFlag4_Conditions (line 20301)
function Trig_NewFlag4_Conditions()
    local unitId = GetUnitTypeId(GetConstructingStructure())
    if ((not ((udg_Flags[GetConvertedPlayerId(GetOwningPlayer(GetConstructingStructure()))] == true)))) then
        do return false end
    end
    if ((not (((((((((((unitId == FourCC("h04Z")) or (unitId == FourCC("h050"))) or (unitId == FourCC("h04Y"))) or (unitId == FourCC("h04V"))) or (unitId == FourCC("h04W"))) or (unitId == FourCC("h05N"))) or (unitId == FourCC("h04X"))) or (unitId == FourCC("h051"))) or (unitId == FourCC("h052"))) or (unitId == FourCC("h05P")))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_NewFlag4_Actions (line 20313)
function Trig_NewFlag4_Actions()
    udg_Flag = GetOwningPlayer(GetTriggerUnit())
    IssueImmediateOrderBJ(GetTriggerUnit(), "stop")
    KillUnit(GetConstructingStructure())
    SetPlayerStateBJ(udg_Flag, PLAYER_STATE_RESOURCE_LUMBER, (__jint(GetPlayerState(udg_Flag, PLAYER_STATE_RESOURCE_LUMBER) + 2000)))
    DisplayTextToForce(GetForceOfPlayer(udg_Flag), "You have already constructed a base flag!")
end

-- Original JASS function: InitTrig_NewFlag4 (line 20322)
function InitTrig_NewFlag4()
    gg_trg_NewFlag4 = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_NewFlag4, EVENT_PLAYER_UNIT_CONSTRUCT_START)
    TriggerAddCondition(gg_trg_NewFlag4, Condition(Trig_NewFlag4_Conditions))
    TriggerAddAction(gg_trg_NewFlag4, Trig_NewFlag4_Actions)
end
-- END FOREST SECTION 372

-- BEGIN FOREST SECTION 373 NewFlag5
-- Original JASS function: Trig_NewFlag5_Conditions (line 20333)
function Trig_NewFlag5_Conditions()
    local unitId = GetUnitTypeId(GetAttackedUnitBJ())
    if ((not (((((((((((unitId == FourCC("h04Z")) or (unitId == FourCC("h050"))) or (unitId == FourCC("h04Y"))) or (unitId == FourCC("h04V"))) or (unitId == FourCC("h04W"))) or (unitId == FourCC("h05N"))) or (unitId == FourCC("h04X"))) or (unitId == FourCC("h051"))) or (unitId == FourCC("h052"))) or (unitId == FourCC("h05P")))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_NewFlag5_Func001C (line 20341)
function Trig_NewFlag5_Func001C()
    if ((not ((GetOwningPlayer(GetAttacker()) == FE_Roles.ancient())))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_NewFlag5_Actions (line 20348)
function Trig_NewFlag5_Actions()
    if (Trig_NewFlag5_Func001C()) then
        DoNothing()
    else
        IssueImmediateOrderBJ(GetAttacker(), "stop")
    end
end

-- Original JASS function: InitTrig_NewFlag5 (line 20357)
function InitTrig_NewFlag5()
    gg_trg_NewFlag5 = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_NewFlag5, EVENT_PLAYER_UNIT_ATTACKED)
    TriggerAddCondition(gg_trg_NewFlag5, Condition(Trig_NewFlag5_Conditions))
    TriggerAddAction(gg_trg_NewFlag5, Trig_NewFlag5_Actions)
end
-- END FOREST SECTION 373
