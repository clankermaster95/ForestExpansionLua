-- Disabled in the original map.
function Trig_Name_Change_II_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("n00G"))))) then
        do return false end
    end
    do return true end
end

function Trig_Name_Change_Actions_II()
    DisplayTextToForce(GetPlayersAll(), (__jconcat(GetPlayerName(GetOwningPlayer(GetSoldUnit())), (__jconcat(" has selected ", GetUnitName(GetSoldUnit()))))))
    SetPlayerName(GetOwningPlayer(GetSoldUnit()), (__jconcat(GetUnitName(GetSoldUnit()), (__jconcat(udg_PlayerColorHex[GetConvertedPlayerId(GetOwningPlayer(GetSoldUnit()))], GetPlayerNameWithoutTag(GetOwningPlayer(GetSoldUnit())))))))
end

function InitTrig_Name_Change_II()
    gg_trg_Name_Change_II = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Name_Change_II, EVENT_PLAYER_UNIT_SELL)
    TriggerAddCondition(gg_trg_Name_Change_II, Condition(Trig_Name_Change_II_Conditions))
    TriggerAddAction(gg_trg_Name_Change_II, Trig_Name_Change_II_Actions)
end
