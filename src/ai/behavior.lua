-- ai / behavior
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 206 Start
-- Original JASS function: Trig_Start_Func001C (line 13720)
function Trig_Start_Func001C()
    if ((not ((GetPlayerController(FE_Roles.ancient()) ~= MAP_CONTROL_USER)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Start_Actions (line 13727)
function Trig_Start_Actions()
    if (Trig_Start_Func001C()) then
        EnableTrigger(gg_trg_Hard_mode_on)
        EnableTrigger(gg_trg_Select)
        EnableTrigger(gg_trg_Abilities)
        EnableTrigger(gg_trg_Attack)
        TriggerSleepAction(__jreal(2))
        DisplayTextToForce(FE_Roster.expanderForce(), "TRIGSTR_7143")
    else
        DoNothing()
    end
end

-- Original JASS function: InitTrig_Start (line 13741)
function InitTrig_Start()
    gg_trg_Start = CreateTrigger()
    TriggerAddAction(gg_trg_Start, Trig_Start_Actions)
end
-- END FOREST SECTION 206

-- BEGIN FOREST SECTION 207 Hard_mode_on
-- Original JASS function: Trig_Hard_mode_on_Actions (line 13749)
function Trig_Hard_mode_on_Actions()
    DisplayTextToForce(FE_Roster.expanderForce(), "TRIGSTR_7144")
    DisableTrigger(gg_trg_Attack)
    EnableTrigger(gg_trg_Hard_Attack)
end

-- Original JASS function: InitTrig_Hard_mode_on (line 13756)
function InitTrig_Hard_mode_on()
    gg_trg_Hard_mode_on = CreateTrigger()
    DisableTrigger(gg_trg_Hard_mode_on)
    TriggerRegisterPlayerChatEvent(gg_trg_Hard_mode_on, Player(0), "-hm", true)
    TriggerAddAction(gg_trg_Hard_mode_on, Trig_Hard_mode_on_Actions)
end
-- END FOREST SECTION 207

-- BEGIN FOREST SECTION 208 Hard_Attack
-- Original JASS function: Trig_Hard_Attack_Conditions (line 13766)
function Trig_Hard_Attack_Conditions()
    if ((not ((IsUnitEnemy(GetTriggerUnit(), FE_Roles.ancient()) == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Hard_Attack_Func002002001 (line 13773)
function Trig_Hard_Attack_Func002002001()
    do return ((GetOwningPlayer(GetEnumUnit()) ~= FE_Roles.ancient())) end
end

-- Original JASS function: Trig_Hard_Attack_Func002002002001 (line 13777)
function Trig_Hard_Attack_Func002002002001()
    do return ((GetOwningPlayer(GetEnumUnit()) ~= Player(PLAYER_NEUTRAL_PASSIVE))) end
end

-- Original JASS function: Trig_Hard_Attack_Func002002002002001 (line 13781)
function Trig_Hard_Attack_Func002002002002001()
    do return ((GetOwningPlayer(GetEnumUnit()) ~= Player(PLAYER_NEUTRAL_AGGRESSIVE))) end
end

-- Original JASS function: Trig_Hard_Attack_Func002002 (line 13785)
function Trig_Hard_Attack_Func002002()
    if (((GetOwningPlayer(GetEnumUnit()) ~= FE_Roles.ancient()))) then
        if (((GetOwningPlayer(GetEnumUnit()) ~= Player(PLAYER_NEUTRAL_PASSIVE)))) then
            if (((GetOwningPlayer(GetEnumUnit()) ~= Player(PLAYER_NEUTRAL_AGGRESSIVE)))) then
                udg_Hardunit = GetUnitLoc(GetEnumUnit())
            else
                TriggerExecute(gg_trg_Hard_attack_2)
            end
        else
            TriggerExecute(gg_trg_Hard_attack_2)
        end
    else
        TriggerExecute(gg_trg_Hard_attack_2)
    end
end

-- Original JASS function: Trig_Hard_Attack_Func003002 (line 13801)
function Trig_Hard_Attack_Func003002()
    IssuePointOrderLocBJ(GetEnumUnit(), "attack", udg_Hardunit)
end

-- Original JASS function: Trig_Hard_Attack_Actions (line 13805)
function Trig_Hard_Attack_Actions()
    ForGroupBJ(GetRandomSubGroup(1, GetUnitsInRectAll(GetPlayableMapRect())), Trig_Hard_Attack_Func002002)
    ForGroupBJ(GetUnitsOfPlayerAll(FE_Roles.ancient()), Trig_Hard_Attack_Func003002)
    EnableTrigger(gg_trg_Hard_Attack_Cont)
end

-- Original JASS function: InitTrig_Hard_Attack (line 13812)
function InitTrig_Hard_Attack()
    gg_trg_Hard_Attack = CreateTrigger()
    DisableTrigger(gg_trg_Hard_Attack)
    TriggerRegisterAnyUnitEventBJ(gg_trg_Hard_Attack, EVENT_PLAYER_UNIT_DEATH)
    TriggerRegisterTimerEventPeriodic(gg_trg_Hard_Attack, __jreal(35.00))
    TriggerAddCondition(gg_trg_Hard_Attack, Condition(Trig_Hard_Attack_Conditions))
    TriggerAddAction(gg_trg_Hard_Attack, Trig_Hard_Attack_Actions)
end
-- END FOREST SECTION 208

-- BEGIN FOREST SECTION 209 Hard_Attack_Cont
-- Original JASS function: Trig_Hard_Attack_Cont_Conditions (line 13824)
function Trig_Hard_Attack_Cont_Conditions()
    if ((not ((IsUnitEnemy(GetDyingUnit(), FE_Roles.ancient()) == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Hard_Attack_Cont_Func003002001 (line 13831)
function Trig_Hard_Attack_Cont_Func003002001()
    do return ((GetOwningPlayer(GetEnumUnit()) ~= FE_Roles.ancient())) end
end

-- Original JASS function: Trig_Hard_Attack_Cont_Func003002002001 (line 13835)
function Trig_Hard_Attack_Cont_Func003002002001()
    do return ((GetOwningPlayer(GetEnumUnit()) ~= Player(PLAYER_NEUTRAL_PASSIVE))) end
end

-- Original JASS function: Trig_Hard_Attack_Cont_Func003002002002001 (line 13839)
function Trig_Hard_Attack_Cont_Func003002002002001()
    do return ((GetOwningPlayer(GetEnumUnit()) ~= Player(PLAYER_NEUTRAL_AGGRESSIVE))) end
end

-- Original JASS function: Trig_Hard_Attack_Cont_Func003002 (line 13843)
function Trig_Hard_Attack_Cont_Func003002()
    if (((GetOwningPlayer(GetEnumUnit()) ~= FE_Roles.ancient()))) then
        if (((GetOwningPlayer(GetEnumUnit()) ~= Player(PLAYER_NEUTRAL_PASSIVE)))) then
            if (((GetOwningPlayer(GetEnumUnit()) ~= Player(PLAYER_NEUTRAL_AGGRESSIVE)))) then
                udg_Hardunit = GetUnitLoc(GetEnumUnit())
            else
                TriggerExecute(gg_trg_Hard_attack_2)
            end
        else
            TriggerExecute(gg_trg_Hard_attack_2)
        end
    else
        TriggerExecute(gg_trg_Hard_attack_2)
    end
end

-- Original JASS function: Trig_Hard_Attack_Cont_Func004002 (line 13859)
function Trig_Hard_Attack_Cont_Func004002()
    IssuePointOrderLocBJ(GetEnumUnit(), "attack", udg_Hardunit)
end

-- Original JASS function: Trig_Hard_Attack_Cont_Actions (line 13863)
function Trig_Hard_Attack_Cont_Actions()
    ForGroupBJ(GetRandomSubGroup(1, GetUnitsInRectAll(GetPlayableMapRect())), Trig_Hard_Attack_Cont_Func003002)
    ForGroupBJ(GetUnitsOfPlayerAll(FE_Roles.ancient()), Trig_Hard_Attack_Cont_Func004002)
end

-- Original JASS function: InitTrig_Hard_Attack_Cont (line 13869)
function InitTrig_Hard_Attack_Cont()
    gg_trg_Hard_Attack_Cont = CreateTrigger()
    DisableTrigger(gg_trg_Hard_Attack_Cont)
    TriggerRegisterAnyUnitEventBJ(gg_trg_Hard_Attack_Cont, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Hard_Attack_Cont, Condition(Trig_Hard_Attack_Cont_Conditions))
    TriggerAddAction(gg_trg_Hard_Attack_Cont, Trig_Hard_Attack_Cont_Actions)
end
-- END FOREST SECTION 209

-- BEGIN FOREST SECTION 210 Hard_attack_2
-- Original JASS function: Trig_Hard_attack_2_Func001002001 (line 13880)
function Trig_Hard_attack_2_Func001002001()
    do return ((GetOwningPlayer(GetEnumUnit()) ~= FE_Roles.ancient())) end
end

-- Original JASS function: Trig_Hard_attack_2_Func001002002001 (line 13884)
function Trig_Hard_attack_2_Func001002002001()
    do return ((GetOwningPlayer(GetEnumUnit()) ~= Player(PLAYER_NEUTRAL_PASSIVE))) end
end

-- Original JASS function: Trig_Hard_attack_2_Func001002002002001 (line 13888)
function Trig_Hard_attack_2_Func001002002002001()
    do return ((GetOwningPlayer(GetEnumUnit()) ~= Player(PLAYER_NEUTRAL_AGGRESSIVE))) end
end

-- Original JASS function: Trig_Hard_attack_2_Func001002 (line 13892)
function Trig_Hard_attack_2_Func001002()
    if (((GetOwningPlayer(GetEnumUnit()) ~= FE_Roles.ancient()))) then
        if (((GetOwningPlayer(GetEnumUnit()) ~= Player(PLAYER_NEUTRAL_PASSIVE)))) then
            if (((GetOwningPlayer(GetEnumUnit()) ~= Player(PLAYER_NEUTRAL_AGGRESSIVE)))) then
                udg_Hardunit = GetUnitLoc(GetEnumUnit())
            else
                TriggerExecute(gg_trg_Hard_attack_2)
            end
        else
            TriggerExecute(gg_trg_Hard_attack_2)
        end
    else
        TriggerExecute(gg_trg_Hard_attack_2)
    end
end

-- Original JASS function: Trig_Hard_attack_2_Func002002 (line 13908)
function Trig_Hard_attack_2_Func002002()
    IssuePointOrderLocBJ(GetEnumUnit(), "attack", GetUnitLoc(GetFilterUnit()))
end

-- Original JASS function: Trig_Hard_attack_2_Actions (line 13912)
function Trig_Hard_attack_2_Actions()
    ForGroupBJ(GetRandomSubGroup(1, GetUnitsInRectAll(GetPlayableMapRect())), Trig_Hard_attack_2_Func001002)
    ForGroupBJ(GetUnitsOfPlayerAll(FE_Roles.ancient()), Trig_Hard_attack_2_Func002002)
end

-- Original JASS function: InitTrig_Hard_attack_2 (line 13918)
function InitTrig_Hard_attack_2()
    gg_trg_Hard_attack_2 = CreateTrigger()
    DisableTrigger(gg_trg_Hard_attack_2)
    TriggerAddAction(gg_trg_Hard_attack_2, Trig_Hard_attack_2_Actions)
end
-- END FOREST SECTION 210

-- BEGIN FOREST SECTION 211 Select
-- Original JASS function: Trig_Select_Func026002 (line 13927)
function Trig_Select_Func026002()
    RemoveUnit(GetEnumUnit())
end

-- Original JASS function: Trig_Select_Actions (line 13931)
function Trig_Select_Actions()
    udg_Ancients[1] = FourCC("O004")
    udg_Ancients[2] = FourCC("O004")
    udg_Ancients[3] = FourCC("O004")
    udg_Ancients[4] = FourCC("O00A")
    udg_Ancients[5] = FourCC("O00A")
    udg_Ancients[6] = FourCC("O00A")
    udg_Ancients[7] = FourCC("O00S")
    udg_Ancients[8] = FourCC("O00S")
    udg_Ancients[9] = FourCC("O00S")
    udg_Ancients[10] = FourCC("O00L")
    udg_Ancients[11] = FourCC("O00L")
    udg_Ancients[12] = FourCC("O00L")
    udg_Ancients[13] = FourCC("O008")
    udg_Ancients[14] = FourCC("O008")
    udg_Ancients[15] = FourCC("O008")
    udg_Ancients[16] = FourCC("O00D")
    udg_Ancients[17] = FourCC("O00D")
    udg_Ancients[18] = FourCC("O00D")
    udg_Ancients[19] = FourCC("O016")
    udg_Ancients[20] = FourCC("O016")
    udg_Ancients[21] = FourCC("O016")
    udg_Ancients[22] = FourCC("O01D")
    udg_Ancients[23] = FourCC("O01V")
    udg_Ancients[24] = FourCC("O01V")
    udg_Ancients[25] = FourCC("O01V")
    ForGroupBJ(GetUnitsInRectAll(gg_rct_SpawnDefender), Trig_Select_Func026002)
    AdjustPlayerStateBJ(__jint(-(1000)), FE_Roles.ancient(), PLAYER_STATE_RESOURCE_GOLD)
    CreateNUnitsAtLoc(1, udg_Ancients[GetRandomInt(1, 8)], FE_Roles.ancient(), GetRectCenter(gg_rct_Spawner), bj_UNIT_FACING)
    udg_AncientUnit = GetLastCreatedUnit()
    EnableTrigger(gg_trg_Slot1_Righteous_Armor)
end

-- Original JASS function: InitTrig_Select (line 13965)
function InitTrig_Select()
    gg_trg_Select = CreateTrigger()
    DisableTrigger(gg_trg_Select)
    TriggerRegisterTimerEventSingle(gg_trg_Select, __jreal(100.00))
    TriggerAddAction(gg_trg_Select, Trig_Select_Actions)
end
-- END FOREST SECTION 211

-- BEGIN FOREST SECTION 212 Attack
-- Original JASS function: Trig_Attack_Func017002 (line 13975)
function Trig_Attack_Func017002()
    IssuePointOrderLocBJ(GetEnumUnit(), "attack", GetRectCenter(udg_Moveto[GetRandomInt(1, 16)]))
end

-- Original JASS function: Trig_Attack_Actions (line 13979)
function Trig_Attack_Actions()
    udg_Moveto[1] = gg_rct_Ping1
    udg_Moveto[2] = gg_rct_Ping2
    udg_Moveto[3] = gg_rct_Ping3
    udg_Moveto[4] = gg_rct_Ping4
    udg_Moveto[5] = gg_rct_Ping5
    udg_Moveto[6] = gg_rct_Ping6
    udg_Moveto[7] = gg_rct_AI_Move_1
    udg_Moveto[8] = gg_rct_AI_Move_10
    udg_Moveto[9] = gg_rct_AI_Move_2
    udg_Moveto[10] = gg_rct_AI_Move_3
    udg_Moveto[11] = gg_rct_AI_Move_4
    udg_Moveto[12] = gg_rct_AI_Move_5
    udg_Moveto[13] = gg_rct_AI_Move_6
    udg_Moveto[14] = gg_rct_AI_Move_7
    udg_Moveto[15] = gg_rct_AI_Move_8
    udg_Moveto[16] = gg_rct_AI_Move_9
    ForGroupBJ(GetUnitsOfPlayerAll(FE_Roles.ancient()), Trig_Attack_Func017002)
end

-- Original JASS function: InitTrig_Attack (line 14000)
function InitTrig_Attack()
    gg_trg_Attack = CreateTrigger()
    DisableTrigger(gg_trg_Attack)
    TriggerRegisterTimerEventPeriodic(gg_trg_Attack, __jreal(65.00))
    TriggerAddAction(gg_trg_Attack, Trig_Attack_Actions)
end
-- END FOREST SECTION 212

-- BEGIN FOREST SECTION 213 Run_away
-- Original JASS function: Trig_Run_away_Actions (line 14012)
function Trig_Run_away_Actions()
end

-- Original JASS function: InitTrig_Run_away (line 14016)
function InitTrig_Run_away()
    gg_trg_Run_away = CreateTrigger()
    DisableTrigger(gg_trg_Run_away)
    TriggerAddAction(gg_trg_Run_away, Trig_Run_away_Actions)
end
-- END FOREST SECTION 213

-- BEGIN FOREST SECTION 214 Slot1_Righteous_Armor
-- Original JASS function: Trig_Slot1_Righteous_Armor_Actions (line 14025)
function Trig_Slot1_Righteous_Armor_Actions()
    UnitAddItemByIdSwapped(FourCC("I012"), udg_AncientUnit)
    AdjustPlayerStateBJ(-FE_RecipeData.items[FourCC("I012")].gold, FE_Roles.ancient(), PLAYER_STATE_RESOURCE_GOLD)
    DisableTrigger(GetTriggeringTrigger())
    EnableTrigger(gg_trg_Slot2_Valor_Helmet)
end

-- Original JASS function: InitTrig_Slot1_Righteous_Armor (line 14033)
function InitTrig_Slot1_Righteous_Armor()
    gg_trg_Slot1_Righteous_Armor = CreateTrigger()
    DisableTrigger(gg_trg_Slot1_Righteous_Armor)
    FE_Roles.registerAncientStateEvent(gg_trg_Slot1_Righteous_Armor, PLAYER_STATE_RESOURCE_GOLD, GREATER_THAN_OR_EQUAL, FE_RecipeData.items[FourCC("I012")].gold)
    TriggerAddAction(gg_trg_Slot1_Righteous_Armor, Trig_Slot1_Righteous_Armor_Actions)
end
-- END FOREST SECTION 214

-- BEGIN FOREST SECTION 215 Slot2_Valor_Helmet
-- Original JASS function: Trig_Slot2_Valor_Helmet_Actions (line 14043)
function Trig_Slot2_Valor_Helmet_Actions()
    UnitAddItemByIdSwapped(FourCC("I015"), udg_AncientUnit)
    AdjustPlayerStateBJ(-FE_RecipeData.items[FourCC("I015")].gold, FE_Roles.ancient(), PLAYER_STATE_RESOURCE_GOLD)
    DisableTrigger(GetTriggeringTrigger())
    EnableTrigger(gg_trg_Slot3_Bladed_Gauntlet)
end

-- Original JASS function: InitTrig_Slot2_Valor_Helmet (line 14051)
function InitTrig_Slot2_Valor_Helmet()
    gg_trg_Slot2_Valor_Helmet = CreateTrigger()
    DisableTrigger(gg_trg_Slot2_Valor_Helmet)
    FE_Roles.registerAncientStateEvent(gg_trg_Slot2_Valor_Helmet, PLAYER_STATE_RESOURCE_GOLD, GREATER_THAN_OR_EQUAL, FE_RecipeData.items[FourCC("I015")].gold)
    TriggerAddAction(gg_trg_Slot2_Valor_Helmet, Trig_Slot2_Valor_Helmet_Actions)
end
-- END FOREST SECTION 215

-- BEGIN FOREST SECTION 216 Slot3_Bladed_Gauntlet
-- Original JASS function: Trig_Slot3_Bladed_Gauntlet_Actions (line 14061)
function Trig_Slot3_Bladed_Gauntlet_Actions()
    AdjustPlayerStateBJ(-FE_RecipeData.items[FourCC("I012")].gold, FE_Roles.ancient(), PLAYER_STATE_RESOURCE_GOLD)
    UnitAddItemByIdSwapped(FourCC("I012"), udg_AncientUnit)
    DisableTrigger(GetTriggeringTrigger())
    EnableTrigger(gg_trg_Slot4_Bladed_Gauntlet)
end

-- Original JASS function: InitTrig_Slot3_Bladed_Gauntlet (line 14069)
function InitTrig_Slot3_Bladed_Gauntlet()
    gg_trg_Slot3_Bladed_Gauntlet = CreateTrigger()
    DisableTrigger(gg_trg_Slot3_Bladed_Gauntlet)
    FE_Roles.registerAncientStateEvent(gg_trg_Slot3_Bladed_Gauntlet, PLAYER_STATE_RESOURCE_GOLD, GREATER_THAN_OR_EQUAL, FE_RecipeData.items[FourCC("I012")].gold)
    TriggerAddAction(gg_trg_Slot3_Bladed_Gauntlet, Trig_Slot3_Bladed_Gauntlet_Actions)
end
-- END FOREST SECTION 216

-- BEGIN FOREST SECTION 217 Slot4_Bladed_Gauntlet
-- Original JASS function: Trig_Slot4_Bladed_Gauntlet_Actions (line 14079)
function Trig_Slot4_Bladed_Gauntlet_Actions()
    AdjustPlayerStateBJ(-FE_RecipeData.items[FourCC("I012")].gold, FE_Roles.ancient(), PLAYER_STATE_RESOURCE_GOLD)
    UnitAddItemByIdSwapped(FourCC("I012"), udg_AncientUnit)
    DisableTrigger(GetTriggeringTrigger())
    EnableTrigger(gg_trg_Slot5_Bladed_Gauntlet)
end

-- Original JASS function: InitTrig_Slot4_Bladed_Gauntlet (line 14087)
function InitTrig_Slot4_Bladed_Gauntlet()
    gg_trg_Slot4_Bladed_Gauntlet = CreateTrigger()
    DisableTrigger(gg_trg_Slot4_Bladed_Gauntlet)
    FE_Roles.registerAncientStateEvent(gg_trg_Slot4_Bladed_Gauntlet, PLAYER_STATE_RESOURCE_GOLD, GREATER_THAN_OR_EQUAL, FE_RecipeData.items[FourCC("I012")].gold)
    TriggerAddAction(gg_trg_Slot4_Bladed_Gauntlet, Trig_Slot4_Bladed_Gauntlet_Actions)
end
-- END FOREST SECTION 217

-- BEGIN FOREST SECTION 218 Slot5_Bladed_Gauntlet
-- Original JASS function: Trig_Slot5_Bladed_Gauntlet_Actions (line 14097)
function Trig_Slot5_Bladed_Gauntlet_Actions()
    AdjustPlayerStateBJ(-FE_RecipeData.items[FourCC("I012")].gold, FE_Roles.ancient(), PLAYER_STATE_RESOURCE_GOLD)
    UnitAddItemByIdSwapped(FourCC("I012"), udg_AncientUnit)
    DisableTrigger(GetTriggeringTrigger())
    EnableTrigger(gg_trg_Slot6_Bladed_Gauntlet)
end

-- Original JASS function: InitTrig_Slot5_Bladed_Gauntlet (line 14105)
function InitTrig_Slot5_Bladed_Gauntlet()
    gg_trg_Slot5_Bladed_Gauntlet = CreateTrigger()
    DisableTrigger(gg_trg_Slot5_Bladed_Gauntlet)
    FE_Roles.registerAncientStateEvent(gg_trg_Slot5_Bladed_Gauntlet, PLAYER_STATE_RESOURCE_GOLD, GREATER_THAN_OR_EQUAL, FE_RecipeData.items[FourCC("I012")].gold)
    TriggerAddAction(gg_trg_Slot5_Bladed_Gauntlet, Trig_Slot5_Bladed_Gauntlet_Actions)
end
-- END FOREST SECTION 218

-- BEGIN FOREST SECTION 219 Slot6_Bladed_Gauntlet
-- Original JASS function: Trig_Slot6_Bladed_Gauntlet_Actions (line 14115)
function Trig_Slot6_Bladed_Gauntlet_Actions()
    AdjustPlayerStateBJ(-FE_RecipeData.items[FourCC("I012")].gold, FE_Roles.ancient(), PLAYER_STATE_RESOURCE_GOLD)
    UnitAddItemByIdSwapped(FourCC("I012"), udg_AncientUnit)
    DisableTrigger(GetTriggeringTrigger())
    EnableTrigger(gg_trg_Level_Up_Tomes)
end

-- Original JASS function: InitTrig_Slot6_Bladed_Gauntlet (line 14123)
function InitTrig_Slot6_Bladed_Gauntlet()
    gg_trg_Slot6_Bladed_Gauntlet = CreateTrigger()
    DisableTrigger(gg_trg_Slot6_Bladed_Gauntlet)
    FE_Roles.registerAncientStateEvent(gg_trg_Slot6_Bladed_Gauntlet, PLAYER_STATE_RESOURCE_GOLD, GREATER_THAN_OR_EQUAL, FE_RecipeData.items[FourCC("I012")].gold)
    TriggerAddAction(gg_trg_Slot6_Bladed_Gauntlet, Trig_Slot6_Bladed_Gauntlet_Actions)
end
-- END FOREST SECTION 219

-- BEGIN FOREST SECTION 220 Level_Up_Tomes
-- AI uses a powerup tome with a full inventory, at the player shop tome price.
-- Original JASS function: Trig_Level_Up_Tomes_Actions (line 14133)
function Trig_Level_Up_Tomes_Actions()
    UnitAddItemByIdSwapped(FourCC("I003"), udg_AncientUnit)
    AdjustPlayerStateBJ(-FE_RecipeData.items[FourCC("I00J")].gold, FE_Roles.ancient(), PLAYER_STATE_RESOURCE_GOLD)
end

-- Original JASS function: InitTrig_Level_Up_Tomes (line 14139)
function InitTrig_Level_Up_Tomes()
    gg_trg_Level_Up_Tomes = CreateTrigger()
    DisableTrigger(gg_trg_Level_Up_Tomes)
    FE_Roles.registerAncientStateEvent(gg_trg_Level_Up_Tomes, PLAYER_STATE_RESOURCE_GOLD, GREATER_THAN_OR_EQUAL, FE_RecipeData.items[FourCC("I00J")].gold)
    TriggerAddAction(gg_trg_Level_Up_Tomes, Trig_Level_Up_Tomes_Actions)
end
-- END FOREST SECTION 220

-- BEGIN FOREST SECTION 221 Abilities
-- Original JASS function: Trig_Abilities_Func001Func007Func007Func007Func006Func007Func007Func001Func001C (line 14149)
function Trig_Abilities_Func001Func007Func007Func007Func006Func007Func007Func001Func001C()
    if ((not ((GetUnitTypeId(udg_AncientUnit) == FourCC("O01V"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Abilities_Func001Func007Func007Func007Func006Func007Func007Func001C (line 14156)
function Trig_Abilities_Func001Func007Func007Func007Func006Func007Func007Func001C()
    if ((not ((GetUnitTypeId(udg_AncientUnit) == FourCC("O01D"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Abilities_Func001Func007Func007Func007Func006Func007Func007C (line 14163)
function Trig_Abilities_Func001Func007Func007Func007Func006Func007Func007C()
    if ((not ((GetUnitTypeId(udg_AncientUnit) == FourCC("O016"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Abilities_Func001Func007Func007Func007Func006Func007C (line 14170)
function Trig_Abilities_Func001Func007Func007Func007Func006Func007C()
    if ((not ((GetUnitTypeId(udg_AncientUnit) == FourCC("O00D"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Abilities_Func001Func007Func007Func007Func006C (line 14177)
function Trig_Abilities_Func001Func007Func007Func007Func006C()
    if ((not ((GetUnitTypeId(udg_AncientUnit) == FourCC("O008"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Abilities_Func001Func007Func007Func007C (line 14184)
function Trig_Abilities_Func001Func007Func007Func007C()
    if ((not ((GetUnitTypeId(udg_AncientUnit) == FourCC("O004"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Abilities_Func001Func007Func007C (line 14191)
function Trig_Abilities_Func001Func007Func007C()
    if ((not ((GetUnitTypeId(udg_AncientUnit) == FourCC("O00L"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Abilities_Func001Func007C (line 14198)
function Trig_Abilities_Func001Func007C()
    if ((not ((GetUnitTypeId(udg_AncientUnit) == FourCC("O00S"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Abilities_Func001C (line 14205)
function Trig_Abilities_Func001C()
    if ((not ((GetUnitTypeId(udg_AncientUnit) == FourCC("O00A"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Abilities_Actions (line 14212)
function Trig_Abilities_Actions()
    if (Trig_Abilities_Func001C()) then
        SelectHeroSkill(udg_AncientUnit, FourCC("A05E"))
        SelectHeroSkill(udg_AncientUnit, FourCC("A05C"))
        SelectHeroSkill(udg_AncientUnit, FourCC("A0E9"))
        SelectHeroSkill(udg_AncientUnit, FourCC("A058"))
        SelectHeroSkill(udg_AncientUnit, FourCC("A05F"))
    else
        if (Trig_Abilities_Func001Func007C()) then
            SelectHeroSkill(udg_AncientUnit, FourCC("A02D"))
            SelectHeroSkill(udg_AncientUnit, FourCC("A06P"))
            SelectHeroSkill(udg_AncientUnit, FourCC("A01J"))
            SelectHeroSkill(udg_AncientUnit, FourCC("A02A"))
            SelectHeroSkill(udg_AncientUnit, FourCC("A02B"))
        else
            if (Trig_Abilities_Func001Func007Func007C()) then
                SelectHeroSkill(udg_AncientUnit, FourCC("A06F"))
                SelectHeroSkill(udg_AncientUnit, FourCC("A088"))
                SelectHeroSkill(udg_AncientUnit, FourCC("A05Q"))
                SelectHeroSkill(udg_AncientUnit, FourCC("A01T"))
                SelectHeroSkill(udg_AncientUnit, FourCC("A06D"))
            else
                if (Trig_Abilities_Func001Func007Func007Func007C()) then
                    SelectHeroSkill(udg_AncientUnit, FourCC("A004"))
                    SelectHeroSkill(udg_AncientUnit, FourCC("A000"))
                    SelectHeroSkill(udg_AncientUnit, FourCC("A003"))
                    SelectHeroSkill(udg_AncientUnit, FourCC("A002"))
                else
                    if (Trig_Abilities_Func001Func007Func007Func007Func006C()) then
                        SelectHeroSkill(udg_AncientUnit, FourCC("A075"))
                        SelectHeroSkill(udg_AncientUnit, FourCC("A073"))
                        SelectHeroSkill(udg_AncientUnit, FourCC("A074"))
                        SelectHeroSkill(udg_AncientUnit, FourCC("A00A"))
                        SelectHeroSkill(udg_AncientUnit, FourCC("A008"))
                    else
                        if (Trig_Abilities_Func001Func007Func007Func007Func006Func007C()) then
                            SelectHeroSkill(udg_AncientUnit, FourCC("A013"))
                            SelectHeroSkill(udg_AncientUnit, FourCC("A070"))
                            SelectHeroSkill(udg_AncientUnit, FourCC("A01M"))
                            SelectHeroSkill(udg_AncientUnit, FourCC("A012"))
                            SelectHeroSkill(udg_AncientUnit, FourCC("A06Z"))
                        else
                            if (Trig_Abilities_Func001Func007Func007Func007Func006Func007Func007C()) then
                                SelectHeroSkill(udg_AncientUnit, FourCC("A03R"))
                                SelectHeroSkill(udg_AncientUnit, FourCC("A03S"))
                                SelectHeroSkill(udg_AncientUnit, FourCC("A03U"))
                                SelectHeroSkill(udg_AncientUnit, FourCC("A03T"))
                            else
                                if (Trig_Abilities_Func001Func007Func007Func007Func006Func007Func007Func001C()) then
                                    SelectHeroSkill(udg_AncientUnit, FourCC("A048"))
                                    SelectHeroSkill(udg_AncientUnit, FourCC("A046"))
                                    SelectHeroSkill(udg_AncientUnit, FourCC("A045"))
                                    SelectHeroSkill(udg_AncientUnit, FourCC("A047"))
                                else
                                    if (Trig_Abilities_Func001Func007Func007Func007Func006Func007Func007Func001Func001C()) then
                                        SelectHeroSkill(udg_AncientUnit, FourCC("A06Y"))
                                        SelectHeroSkill(udg_AncientUnit, FourCC("A06X"))
                                        SelectHeroSkill(udg_AncientUnit, FourCC("A06U"))
                                        SelectHeroSkill(udg_AncientUnit, FourCC("A06W"))
                                        SelectHeroSkill(udg_AncientUnit, FourCC("A06V"))
                                    else
                                        DoNothing()
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

-- Original JASS function: InitTrig_Abilities (line 14286)
function InitTrig_Abilities()
    gg_trg_Abilities = CreateTrigger()
    DisableTrigger(gg_trg_Abilities)
    TriggerRegisterTimerEventPeriodic(gg_trg_Abilities, __jreal(30.00))
    TriggerAddAction(gg_trg_Abilities, Trig_Abilities_Actions)
end
-- END FOREST SECTION 221
