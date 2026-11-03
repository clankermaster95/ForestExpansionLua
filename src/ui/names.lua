-- ui / names
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 258 Colors
-- Original JASS function: Trig_Colors_Actions (line 15702)
function Trig_Colors_Actions()
    udg_PlayerColorHex[1] = " - |cffff0303"
    udg_PlayerColorHex[2] = " - |cff0042ff"
    udg_PlayerColorHex[3] = " - |cff1ce6b9"
    udg_PlayerColorHex[4] = " - |cff540081"
    udg_PlayerColorHex[5] = " - |cfffffc01"
    udg_PlayerColorHex[6] = " - |cfffe8a0e"
    udg_PlayerColorHex[7] = " - |cff20c000"
    udg_PlayerColorHex[8] = " - |cffe55bb0"
    udg_PlayerColorHex[9] = " - |cff959697"
    udg_PlayerColorHex[10] = " - |cff7ebff1"
    udg_PlayerColorHex[11] = " - |cff106246"
    udg_PlayerColorHex[12] = " - |cff4e2a04"
end

-- Original JASS function: InitTrig_Colors (line 15718)
function InitTrig_Colors()
    gg_trg_Colors = CreateTrigger()
    TriggerAddAction(gg_trg_Colors, Trig_Colors_Actions)
end
-- END FOREST SECTION 258

-- BEGIN FOREST SECTION 259 Name_Change
-- Original JASS function: Trig_Name_Change_Conditions (line 15726)
function Trig_Name_Change_Conditions()
    if ((not (((GetUnitTypeId(GetTriggerUnit()) == FourCC("nmer")) or (GetUnitTypeId(GetTriggerUnit()) == FourCC("n00G")))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: GetPlayerNameWithoutTag (line 15733)
function GetPlayerNameWithoutTag(p)
    local fullName = GetPlayerName(p)
    local result = ""
    local i = 0
    local length = StringLength(fullName)
    while true do
        if (i >= length) then break end
        if ((SubString(fullName, i, __jint(i + 1)) == "#")) then
            do return result end
        end
        result = __jconcat(result, SubString(fullName, i, __jint(i + 1)))
        i = __jint(i + 1)
    end
    do return result end
end

-- Original JASS function: Trig_Name_Change_Actions (line 15751)
function Trig_Name_Change_Actions()
    DisplayTextToForce(GetPlayersAll(), (__jconcat(GetPlayerName(GetOwningPlayer(GetSoldUnit())), (__jconcat(" has selected ", GetUnitName(GetSoldUnit()))))))
    SetPlayerName(GetOwningPlayer(GetSoldUnit()), (__jconcat(GetUnitName(GetSoldUnit()), (__jconcat(udg_PlayerColorHex[GetConvertedPlayerId(GetOwningPlayer(GetSoldUnit()))], GetPlayerNameWithoutTag(GetOwningPlayer(GetSoldUnit())))))))
end

-- Original JASS function: InitTrig_Name_Change (line 15757)
function InitTrig_Name_Change()
    gg_trg_Name_Change = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Name_Change, EVENT_PLAYER_UNIT_SELL)
    TriggerAddCondition(gg_trg_Name_Change, Condition(Trig_Name_Change_Conditions))
    TriggerAddAction(gg_trg_Name_Change, Trig_Name_Change_Actions)
end
-- END FOREST SECTION 259

-- BEGIN FOREST SECTION 260 Name_Change_III
-- Original JASS function: Trig_Name_Change_III_Actions (line 15768)
function Trig_Name_Change_III_Actions()
    SetPlayerName(FE_Roles.ancient(), (__jconcat("Ancient ", (__jconcat(udg_PlayerColorHex[GetPlayerId(FE_Roles.ancient()) + 1], GetPlayerName(FE_Roles.ancient()))))))
end

-- Original JASS function: InitTrig_Name_Change_III (line 15773)
function InitTrig_Name_Change_III()
    gg_trg_Name_Change_III = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_Name_Change_III, __jreal(10.00))
    TriggerAddAction(gg_trg_Name_Change_III, Trig_Name_Change_III_Actions)
end
-- END FOREST SECTION 260
