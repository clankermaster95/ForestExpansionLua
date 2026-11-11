-- players / participation
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 13 Takeover
function Trig_Takeover_MaxPlayerSlots()
    return 11
end

function Trig_Takeover_AncientHasController(ancient)
    if (ancient == nil) then
        return false
    end
    if (GetPlayerSlotState(ancient) ~= PLAYER_SLOT_STATE_PLAYING) then
        return false
    end
    if (GetPlayerController(ancient) == MAP_CONTROL_USER) then
        return true
    end
    if (GetPlayerController(ancient) == MAP_CONTROL_COMPUTER) then
        return true
    end
    return false
end

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

function Trig_Takeover_ShouldInvertAlliances(oldAncient, taker)
    if GetPlayerAlliance(taker, oldAncient, ALLIANCE_PASSIVE) then
        return false
    end
    if GetPlayerAlliance(oldAncient, taker, ALLIANCE_PASSIVE) then
        return false
    end
    return true
end

function Trig_Takeover_CopyAncientResources(oldAncient, newAncient)
    SetPlayerState(newAncient, PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(oldAncient, PLAYER_STATE_RESOURCE_GOLD))
    SetPlayerState(newAncient, PLAYER_STATE_RESOURCE_LUMBER, GetPlayerState(oldAncient, PLAYER_STATE_RESOURCE_LUMBER))
end

-- Leaver state is consumed before transferring ownership. The expiry callback
-- checks the same record, so it cannot delete a claimed army or a taker's units.
FE_Takeover = { pending = {}, research = {} }
-- Research IDs from object data; reviewed again when adding research.
FE_Takeover.research = {"R000", "R001", "R002", "R003", "R004", "R005", "R006", "R007", "R008", "R009", "R00A", "R00B", "R00C", "R00D", "R00E", "R00F", "R00G", "R00H", "R00I", "R00J", "R00K", "R00L", "R00M", "R00N", "R00O", "R00P", "R00Q", "R00R", "R00S", "R00T", "R00U", "R00V", "R00W", "R00X", "R00Y", "R00Z", "R010", "R011", "R012", "R013", "R014", "R015", "R016", "R017", "R018", "R019", "R01A", "R01B", "R01C", "R01D", "R01E", "R01F", "R01G", "R01H", "R01I", "R01J", "R01K", "R01L", "R01M", "R01N", "R01O", "R01P", "R01Q", "R01R", "R01S", "R01T", "R01U", "R01V", "R01W", "R01X", "R01Y", "R01Z", "R020", "R021", "R022", "R023", "R024", "R025", "R026", "R027", "R028", "R029", "R02A", "R02B", "R02C", "R02D", "R02E", "R02F", "R02G", "R02H", "R02I", "R02J", "R02K", "R02L", "R02M", "R02N", "R02O", "R02P", "R02Q", "R02R", "R02S", "R02T", "R02U", "R02V", "R02W", "R02X", "R02Y", "R02Z", "R030", "R031", "R032", "R033", "R034", "R035", "R036", "R037", "R038", "R039", "R03A", "R03B", "R03C", "R03D", "R03E", "R03F", "R03G", "R03H", "R03I", "R03J", "R03K", "R03L", "R03M", "R03N", "R03O", "R03P", "R03Q", "R03R", "R03S", "R03T", "R03U", "R03V", "R03W", "R03X", "R03Y", "R03Z", "R040", "R041", "R042", "R043", "R044", "R045", "R046", "R047", "R048", "R049", "R04A", "R04B", "R04C", "R04D", "R04E", "R04F", "R04G", "R04H", "R04I", "R04J", "R04K", "R04L", "R04M", "R04N", "R04O", "R04P", "R04Q", "R04R", "R04S", "R04T", "R04U", "R04V", "R04W", "R04X", "R04Y", "R04Z", "R050", "R051", "R052", "R053", "R054", "R055", "R056", "R057", "R058", "R059", "R05A", "R05B", "R05C", "R05D", "R05E", "R05F", "R05G", "R05H", "R05I", "R05J", "R05K", "R05L", "R05M", "R05N", "R05O", "R05P", "R05Q", "R05R", "R05S", "R05T", "R05U", "R05V", "R05W", "R05X", "R05Y", "R05Z", "R060", "R061", "R062", "R063", "R064", "R065", "R066", "R067", "R068", "R069", "R06A", "R06B", "R06C", "R06D", "R06E", "R06F", "R06G", "R06H", "R06I", "R06J", "R06K", "R06L", "R06M", "R06N", "R06O", "R06P", "R06Q", "R06R", "R06S", "R06T", "R06U", "R06V", "R06W", "R06X", "R06Y", "R06Z", "R070", "R071", "R072", "R073", "R074", "R075", "R076", "R077", "R078", "R079", "R07A", "R07B", "R07C", "R07D", "R07E", "R07F", "R07G", "R07H", "R07I", "R07J", "R07K", "R07L", "R07M", "R07N", "R07O", "R07P", "R07Q", "R07R", "R07S", "R07T", "R07U", "R07V", "R07W", "R07X", "R07Y", "R07Z", "R080", "R081", "R082", "R083", "R084", "R085", "R086", "R087", "R088", "R089", "RFAT", "RFCA", "RFCB", "RFCS", "RFPK", "Rhlh", "Rosp"}

function FE_Takeover.forUnits(player, action)
    local group = CreateGroup()
    GroupEnumUnitsOfPlayer(group, player, nil)
    while true do
        local unit = FirstOfGroup(group)
        if not unit then break end
        GroupRemoveUnit(group, unit)
        action(unit)
    end
    DestroyGroup(group)
end

function FE_Takeover.unpicked(player)
    local selector = false
    FE_Takeover.forUnits(player, function(unit)
        if GetUnitTypeId(unit) == udg_Selectors and GetWidgetLife(unit) > 0.405 then selector = true end
    end)
    return selector
end

function FE_Takeover.eligible(player)
    if GetPlayerSlotState(player) ~= PLAYER_SLOT_STATE_PLAYING then return false end
    if FE_Roles.isAncient(player) then return false end
    return not FE_Roster.isAlive(player) or FE_Takeover.unpicked(player)
end

function FE_Takeover.hasPendingExpander()
    for slot = 0, FE_Roles.playerSlotCount - 1 do
        local record = FE_Takeover.pending[slot]
        if record and not record.ancient and record.alive and FE_Takeover.hasBuilder(record.player) then return true end
    end
    return false
end

function FE_Takeover.hasBuilder(player)
    local found = false
    FE_Takeover.forUnits(player, function(unit)
        if GetWidgetLife(unit) > 0.405 and
            (GetUnitTypeId(unit) == udg_Selectors or
                (IsUnitType(unit, UNIT_TYPE_ANCIENT) and not IsUnitType(unit, UNIT_TYPE_STRUCTURE))) then found = true end
    end)
    return found
end

function FE_Takeover.begin(player)
    local slot = GetPlayerId(player)
    if FE_Takeover.pending[slot] then return end
    local record = {player=player, ancient=FE_Roles.isAncient(player), alive=FE_Roster.isAlive(player), timer=CreateTimer()}
    FE_Takeover.pending[slot] = record
    FE_Roster.defeat(player)
    DisplayTimedTextToForce(GetPlayersAll(), 20, GetPlayerName(player) ..
        " has left. Their units remain for 60 seconds. Dead or unpicked players may type -takeover " ..
        tostring(slot + 1) .. " to take control (-takeover lists available players).")
    TimerStart(record.timer, 60, false, function()
        if FE_Takeover.pending[slot] ~= record then return end
        FE_Takeover.pending[slot] = nil
        DestroyTimer(record.timer)
        FE_Takeover.forUnits(player, RemoveUnit)
        udg_Flags[slot + 1] = false
        if record.ancient and FE_Roles.isAncient(player) then
            DisplayTextToForce(GetPlayersAll(), "The Ancient was not taken over within 60 seconds.")
            FE_Roles.otherPlayersWin()
        end
    end)
end

function FE_Takeover.copyResearch(from, to)
    -- Includes built-in and custom upgrades from the object-data catalog.
    -- Keeping the greater level preserves research on the taker's own survivors.
    for _, raw in ipairs(FE_Takeover.research) do
        local id = FourCC(raw)
        local level = GetPlayerTechCount(from, id, true)
        if level > GetPlayerTechCount(to, id, true) then SetPlayerTechResearched(to, id, level) end
    end
end

function FE_Takeover.claim(taker, slot)
    local record = FE_Takeover.pending[slot]
    if not record or not FE_Takeover.eligible(taker) or record.player == taker then
        DisplayTextToPlayer(taker, 0, 0, "Takeover unavailable. You must be dead or have not picked a race, and the player must still be in their 60-second window.")
        return false
    end
    if record.ancient and udg_AncientUnit and GetWidgetLife(udg_AncientUnit) <= 0.405 then
        DisplayTextToPlayer(taker, 0, 0, "The Ancient has died and cannot be taken over.")
        return false
    end
    if record.alive and not record.ancient and not FE_Takeover.hasBuilder(record.player) then
        DisplayTextToPlayer(taker, 0, 0, "That player's builder has died; their army cannot be taken over as a living Expander.")
        return false
    end
    FE_Takeover.pending[slot] = nil
    PauseTimer(record.timer)
    DestroyTimer(record.timer)
    local oldOwner = record.player
    -- The old race-selection token is UI state, not part of the surviving army.
    -- Removing only this token prevents an unpicked taker buying a second race.
    FE_Takeover.forUnits(taker, function(unit)
        if GetUnitTypeId(unit) == udg_Selectors then RemoveUnit(unit) end
    end)
    -- Preserve the taker's surviving units, resources and research.
    for _, resource in ipairs({PLAYER_STATE_RESOURCE_GOLD, PLAYER_STATE_RESOURCE_LUMBER}) do
        SetPlayerState(taker, resource, GetPlayerState(taker, resource) + GetPlayerState(oldOwner, resource))
        SetPlayerState(oldOwner, resource, 0)
    end
    FE_Takeover.copyResearch(oldOwner, taker)
    -- Copy the departed player's relationships before changing the role handle.
    FE_Roles.forEachPlayer(function(other)
        if other ~= taker and other ~= oldOwner then
            Trig_Takeover_SetAllianceBothWays(taker, other, GetPlayerAlliance(oldOwner, other, ALLIANCE_PASSIVE))
        end
    end)
    Trig_Takeover_SetAllianceBothWays(taker, oldOwner, true)
    local oldIndex, newIndex = slot + 1, GetPlayerId(taker) + 1
    for _, name in ipairs({"udg_SilentStrider", "udg_DeepWater1"}) do
        local flags = _G[name]
        if flags then flags[newIndex] = flags[newIndex] or flags[oldIndex] end
    end
    if udg_SeedOfRebirth[oldIndex] ~= 0 then udg_SeedOfRebirth[newIndex] = udg_SeedOfRebirth[oldIndex] end
    udg_Flags[newIndex] = udg_Flags[newIndex] or udg_Flags[oldIndex]
    udg_Flags[oldIndex] = false
    if record.ancient then FE_Roles.setAncient(taker)
    elseif record.alive then FE_Roster.revive(taker) end
    Trig_Takeover_TransferAllUnits(oldOwner, taker)
    DisplayTimedTextToForce(GetPlayersAll(), 20, GetPlayerName(taker) .. " has taken over " .. GetPlayerName(oldOwner) .. ". The game continues.")
    return true
end

function Trig_Takeover_Actions()
    local taker = GetTriggerPlayer()
    local argument = GetEventPlayerChatString():match("^\x25-takeover\x25s+(\x25d+)\x25s*$")
    if argument then FE_Takeover.claim(taker, tonumber(argument) - 1); return end
    if not GetEventPlayerChatString():match("^\x25-takeover\x25s*$") then
        DisplayTextToPlayer(taker, 0, 0, "Use -takeover or -takeover <player slot>.")
        return
    end
    local count, available = 0, nil
    for slot = 0, FE_Roles.playerSlotCount - 1 do
        if FE_Takeover.pending[slot] then count, available = count + 1, slot end
    end
    if count == 1 then FE_Takeover.claim(taker, available); return end
    if count == 0 then DisplayTextToPlayer(taker, 0, 0, "No leaving player is available for takeover."); return end
    for slot = 0, FE_Roles.playerSlotCount - 1 do
        local record = FE_Takeover.pending[slot]
        if record then DisplayTextToPlayer(taker, 0, 0, "-takeover " .. tostring(slot + 1) .. ": " .. GetPlayerName(record.player)) end
    end
end

function InitTrig_Takeover()
    local i = 0
    gg_trg_Takeover = CreateTrigger()
    while true do
        if (i >= (11)) then break end
        TriggerRegisterPlayerChatEvent(gg_trg_Takeover, Player(i), "-takeover", false)
        i = __jint(i + 1)
    end
    TriggerAddAction(gg_trg_Takeover, Trig_Takeover_Actions)
end
-- END FOREST SECTION 13

-- BEGIN FOREST SECTION 316 Player_group

function Trig_Player_group_Actions()
    FE_Roster.initialize()
    DisplayTextToForce(GetPlayersAll(), "Loaded " .. I2S(udg_StillAlive) .. " expanders")
end

function InitTrig_Player_group()
    gg_trg_Player_group = CreateTrigger()
    TriggerAddAction(gg_trg_Player_group, Trig_Player_group_Actions)
end
-- END FOREST SECTION 316
