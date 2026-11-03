-- players / leaving
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 321 Player_Leaves
-- Original JASS function: Trig_Player_Leaves_Func003002 (line 18482)
function Trig_Player_Leaves_Func003002()
    RemoveUnit(GetEnumUnit())
end

-- Original JASS function: Trig_Player_Leaves_Actions (line 18486)
function Trig_Player_Leaves_Actions()
    if FE_Roles.isAncient(GetTriggerPlayer()) then return end
    FE_Roster.defeat(GetTriggerPlayer())
    udg_Flags[GetConvertedPlayerId(GetTriggerPlayer())] = false
    DisplayTextToForce(GetPlayersAll(), (__jconcat(GetPlayerName(GetTriggerPlayer()), " has left the game.")))
    local units = GetUnitsOfPlayerAll(GetTriggerPlayer())
    ForGroupBJ(units, Trig_Player_Leaves_Func003002)
    DestroyGroup(units)
end

-- Original JASS function: InitTrig_Player_Leaves (line 18493)
function InitTrig_Player_Leaves()
    gg_trg_Player_Leaves = CreateTrigger()
    FE_Roles.forEachPlayer(function(player)
        TriggerRegisterPlayerEventLeave(gg_trg_Player_Leaves, player)
    end)
    TriggerAddAction(gg_trg_Player_Leaves, Trig_Player_Leaves_Actions)
end
-- END FOREST SECTION 321

-- BEGIN FOREST SECTION 322 Ancient_Leaves
-- Original JASS function: Trig_Ancient_Leaves_Actions (line 18511)
function Trig_Ancient_Leaves_Actions()
    local leavingAncient = GetTriggerPlayer()
    if (leavingAncient ~= FE_Roles.ancient()) then
        leavingAncient = nil
        do return end
    end
    PlayThematicMusicBJ("Tension")
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_436")
    TriggerSleepAction(__jreal(3.00))
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_5283")
    TriggerSleepAction(__jreal(120.00))
    if (FE_Roles.ancient() == leavingAncient) then
        FE_Roles.otherPlayersWin()
    else
        DisplayTextToForce(GetPlayersAll(), "|cff80ff80Ancient was taken over. The game will continue.|r")
    end
    leavingAncient = nil
end

-- Original JASS function: InitTrig_Ancient_Leaves (line 18544)
function InitTrig_Ancient_Leaves()
    local i = 0
    gg_trg_Ancient_Leaves = CreateTrigger()
    while true do
        if (i >= 11) then break end
        TriggerRegisterPlayerEventLeave(gg_trg_Ancient_Leaves, Player(i))
        i = __jint(i + 1)
    end
    TriggerAddAction(gg_trg_Ancient_Leaves, Trig_Ancient_Leaves_Actions)
end
-- END FOREST SECTION 322
