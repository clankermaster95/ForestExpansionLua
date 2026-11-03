-- players / participation
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 13 Takeover
-- Original JASS function: Trig_Takeover_MaxPlayerSlots (line 4974)
function Trig_Takeover_MaxPlayerSlots()
    do return 11 end
end

-- Original JASS function: Trig_Takeover_AncientHasController (line 4978)
function Trig_Takeover_AncientHasController(ancient)
    if (ancient == nil) then
        do return false end
    end
    if (GetPlayerSlotState(ancient) ~= PLAYER_SLOT_STATE_PLAYING) then
        do return false end
    end
    if (GetPlayerController(ancient) == MAP_CONTROL_USER) then
        do return true end
    end
    if (GetPlayerController(ancient) == MAP_CONTROL_COMPUTER) then
        do return true end
    end
    do return false end
end

-- Original JASS function: Trig_Takeover_RemoveAllUnitsOfPlayer (line 4998)
function Trig_Takeover_RemoveAllUnitsOfPlayer(whichPlayer)
    local g = CreateGroup()
    local u = nil
    GroupEnumUnitsOfPlayer(g, whichPlayer, nil)
    while true do
        u = FirstOfGroup(g)
        if (u == nil) then break end
        GroupRemoveUnit(g, u)
        RemoveUnit(u)
    end
    DestroyGroup(g)
    u = nil
    g = nil
end

-- Original JASS function: Trig_Takeover_TransferAllUnits (line 5016)
function Trig_Takeover_TransferAllUnits(oldOwner, newOwner)
    local g = CreateGroup()
    local u = nil
    GroupEnumUnitsOfPlayer(g, oldOwner, nil)
    while true do
        u = FirstOfGroup(g)
        if (u == nil) then break end
        GroupRemoveUnit(g, u)
        SetUnitOwner(u, newOwner, true)
    end
    DestroyGroup(g)
    u = nil
    g = nil
end

-- Original JASS function: Trig_Takeover_SetAllianceBothWays (line 5034)
function Trig_Takeover_SetAllianceBothWays(a, b, allied)
    SetPlayerAlliance(a, b, ALLIANCE_PASSIVE, allied)
    SetPlayerAlliance(b, a, ALLIANCE_PASSIVE, allied)
    SetPlayerAlliance(a, b, ALLIANCE_HELP_REQUEST, allied)
    SetPlayerAlliance(b, a, ALLIANCE_HELP_REQUEST, allied)
    SetPlayerAlliance(a, b, ALLIANCE_HELP_RESPONSE, allied)
    SetPlayerAlliance(b, a, ALLIANCE_HELP_RESPONSE, allied)
    SetPlayerAlliance(a, b, ALLIANCE_SHARED_XP, allied)
    SetPlayerAlliance(b, a, ALLIANCE_SHARED_XP, allied)
    SetPlayerAlliance(a, b, ALLIANCE_SHARED_SPELLS, allied)
    SetPlayerAlliance(b, a, ALLIANCE_SHARED_SPELLS, allied)
    SetPlayerAlliance(a, b, ALLIANCE_SHARED_VISION, allied)
    SetPlayerAlliance(b, a, ALLIANCE_SHARED_VISION, allied)
    SetPlayerAlliance(a, b, ALLIANCE_SHARED_CONTROL, false)
    SetPlayerAlliance(b, a, ALLIANCE_SHARED_CONTROL, false)
    SetPlayerAlliance(a, b, ALLIANCE_SHARED_ADVANCED_CONTROL, false)
    SetPlayerAlliance(b, a, ALLIANCE_SHARED_ADVANCED_CONTROL, false)
    SetPlayerAlliance(a, b, ALLIANCE_RESCUABLE, false)
    SetPlayerAlliance(b, a, ALLIANCE_RESCUABLE, false)
    SetPlayerAlliance(a, b, ALLIANCE_SHARED_VISION_FORCED, false)
    SetPlayerAlliance(b, a, ALLIANCE_SHARED_VISION_FORCED, false)
end

-- Original JASS function: Trig_Takeover_InvertTakerAlliances (line 5057)
function Trig_Takeover_InvertTakerAlliances(taker)
    local i = 0
    local p = nil
    local wasAlly = false
    while true do
        if (i >= (11)) then break end
        p = Player(i)
        if (p ~= taker) then
            wasAlly = GetPlayerAlliance(taker, p, ALLIANCE_PASSIVE)
            if wasAlly then
                Trig_Takeover_SetAllianceBothWays(taker, p, false)
            else
                Trig_Takeover_SetAllianceBothWays(taker, p, true)
            end
        end
        i = __jint(i + 1)
    end
    p = nil
end

-- Original JASS function: Trig_Takeover_ShouldInvertAlliances (line 5082)
function Trig_Takeover_ShouldInvertAlliances(oldAncient, taker)
    if GetPlayerAlliance(taker, oldAncient, ALLIANCE_PASSIVE) then
        do return false end
    end
    if GetPlayerAlliance(oldAncient, taker, ALLIANCE_PASSIVE) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Takeover_CopyAncientResources (line 5094)
function Trig_Takeover_CopyAncientResources(oldAncient, newAncient)
    SetPlayerState(newAncient, PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(oldAncient, PLAYER_STATE_RESOURCE_GOLD))
    SetPlayerState(newAncient, PLAYER_STATE_RESOURCE_LUMBER, GetPlayerState(oldAncient, PLAYER_STATE_RESOURCE_LUMBER))
end

-- Original JASS function: Trig_Takeover_Actions (line 5099)
function Trig_Takeover_Actions()
    local taker = GetTriggerPlayer()
    local oldAncient = FE_Roles.ancient()
    if (oldAncient == nil) then
        DisplayTextToPlayer(taker, __jreal(0.00), __jreal(0.00), "|cffff2020Takeover failed: AncientPlayer is not set.|r")
        taker = nil
        oldAncient = nil
        do return end
    end
    if Trig_Takeover_AncientHasController(oldAncient) then
        DisplayTextToPlayer(taker, __jreal(0.00), __jreal(0.00), "|cffff2020Takeover failed: Ancient still has an active player or AI controller.|r")
        taker = nil
        oldAncient = nil
        do return end
    end
    Trig_Takeover_RemoveAllUnitsOfPlayer(taker)
    Trig_Takeover_CopyAncientResources(oldAncient, taker)
    if Trig_Takeover_ShouldInvertAlliances(oldAncient, taker) then
        Trig_Takeover_InvertTakerAlliances(taker)
    end
    FE_Roles.setAncient(taker)
    Trig_Takeover_TransferAllUnits(oldAncient, taker)
    DisplayTimedTextToForce(GetPlayersAll(), __jreal(20.00), __jconcat(__jconcat("|cffffcc00", GetPlayerName(taker)), " has taken over Ancient because the previous Ancient has no active controller.|r"))
    taker = nil
    oldAncient = nil
end

-- Original JASS function: InitTrig_Takeover (line 5134)
function InitTrig_Takeover()
    local i = 0
    gg_trg_Takeover = CreateTrigger()
    while true do
        if (i >= (11)) then break end
        TriggerRegisterPlayerChatEvent(gg_trg_Takeover, Player(i), "-takeover", true)
        i = __jint(i + 1)
    end
    TriggerAddAction(gg_trg_Takeover, Trig_Takeover_Actions)
end
-- END FOREST SECTION 13

-- BEGIN FOREST SECTION 316 Player_group
-- Original JASS function: Trig_Player_group_Func001002 (line 17980)
function Trig_Player_group_Func001002()
    ForceAddPlayerSimple(GetEnumPlayer(), FE_Roster.expanderForce())
end

-- Original JASS function: Trig_Player_group_Func003002001001 (line 17984)
function Trig_Player_group_Func003002001001()
    do return ((GetPlayerSlotState(GetFilterPlayer()) == PLAYER_SLOT_STATE_PLAYING)) end
end

-- Original JASS function: Trig_Player_group_Func004C (line 17988)
function Trig_Player_group_Func004C()
    if ((not ((GetPlayerSlotState(FE_Roles.ancient()) == PLAYER_SLOT_STATE_PLAYING)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Player_group_Actions (line 17995)
function Trig_Player_group_Actions()
    FE_Roster.initialize()
    DisplayTextToForce(GetPlayersAll(), "Loaded " .. I2S(udg_StillAlive) .. " expanders")
end

-- Original JASS function: InitTrig_Player_group (line 18007)
function InitTrig_Player_group()
    gg_trg_Player_group = CreateTrigger()
    TriggerAddAction(gg_trg_Player_group, Trig_Player_group_Actions)
end
-- END FOREST SECTION 316
