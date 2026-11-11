-- Gameplay identity belongs to player handles, never colors or fixed slots.
-- This is the only default Ancient slot. Native lobby configuration still uses
-- eleven slots, with the Ancient in slot 11 (Dark Green).
FE_Roles = { initialAncientSlot = 10, playerSlotCount = 11 }

function FE_Roles.ancient()
    return udg_AncientPlayer
end

function FE_Roles.isAncient(player)
    return player ~= nil and player == udg_AncientPlayer
end

function FE_Roles.setAncient(player)
    assert(player ~= nil and GetPlayerId(player) >= 0 and
        GetPlayerId(player) < FE_Roles.playerSlotCount, "Ancient must be a participant")
    -- Retain the original global as the sole backing state for legacy triggers.
    local previous = udg_AncientPlayer
    udg_AncientPlayer = player
    if FE_Roster then FE_Roster.onAncientChanged(previous, player) end
end

function FE_Roles.forEachPlayer(action)
    for slot = 0, FE_Roles.playerSlotCount - 1 do action(Player(slot)) end
end

function FE_Roles.isAncientEvent()
    return FE_Roles.isAncient(GetTriggerPlayer())
end

-- Register all participants once. Evaluate ownership at event time, so a
-- takeover does not leave listeners attached to the previous Ancient.
function FE_Roles.registerAncientUnitEvent(trigger, event)
    FE_Roles.forEachPlayer(function(player)
        TriggerRegisterPlayerUnitEventSimple(trigger, player, event)
    end)
    TriggerAddCondition(trigger, Condition(FE_Roles.isAncientEvent))
end

function FE_Roles.registerAncientChatEvent(trigger, text, exact)
    FE_Roles.forEachPlayer(function(player)
        TriggerRegisterPlayerChatEvent(trigger, player, text, exact)
    end)
    TriggerAddCondition(trigger, Condition(FE_Roles.isAncientEvent))
end

function FE_Roles.registerAncientStateEvent(trigger, state, comparison, value)
    FE_Roles.forEachPlayer(function(player)
        TriggerRegisterPlayerStateEvent(trigger, player, state, comparison, value)
    end)
    TriggerAddCondition(trigger, Condition(FE_Roles.isAncientEvent))
end

function FE_Roles.finishMatch(ancientWon, defeatMessage)
    if FE_Test and not FE_Test.matchResultsEnabled() then return end
    local ancient = FE_Roles.ancient()
    assert(ancient ~= nil, "Cannot finish a match without an Ancient")
    FE_Roles.forEachPlayer(function(player)
        local won = (player == ancient) == ancientWon
        if won then CustomVictoryBJ(player, true, true)
        else CustomDefeatBJ(player, defeatMessage) end
    end)
end

function FE_Roles.otherPlayersWin()
    if FE_Test and not FE_Test.matchResultsEnabled() then return end
    FE_Roles.forEachPlayer(function(player)
        if not FE_Roles.isAncient(player) then CustomVictoryBJ(player, true, true) end
    end)
end
