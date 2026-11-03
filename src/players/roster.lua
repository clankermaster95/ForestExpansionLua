-- Match membership is independent of Blizzard's singleton player forces.
FE_Roster = { alive = {}, initialized = false, force = nil }

function FE_Roster.expanderForce()
    if not FE_Roster.force then FE_Roster.force = CreateForce() end
    ForceClear(FE_Roster.force)
    FE_Roles.forEachPlayer(function(player)
        if not FE_Roles.isAncient(player) and GetPlayerSlotState(player) == PLAYER_SLOT_STATE_PLAYING then
            ForceAddPlayer(FE_Roster.force, player)
        end
    end)
    return FE_Roster.force
end

function FE_Roster.initialize()
    if FE_Roster.initialized then return end
    FE_Roster.initialized = true
    udg_StillAlive = 0
    FE_Roles.forEachPlayer(function(player)
        local playing = GetPlayerSlotState(player) == PLAYER_SLOT_STATE_PLAYING and not FE_Roles.isAncient(player)
        FE_Roster.alive[GetPlayerId(player)] = playing
        if playing then udg_StillAlive = udg_StillAlive + 1 end
    end)
    FE_Roster.expanderForce()
end

function FE_Roster.isAlive(player)
    return player ~= nil and FE_Roster.alive[GetPlayerId(player)] == true
end

function FE_Roster.defeat(player)
    if not FE_Roster.isAlive(player) then return false end
    FE_Roster.alive[GetPlayerId(player)] = false
    udg_StillAlive = udg_StillAlive - 1
    return true
end

function FE_Roster.revive(player)
    if FE_Roles.isAncient(player) or FE_Roster.isAlive(player) or
       GetPlayerSlotState(player) ~= PLAYER_SLOT_STATE_PLAYING then return false end
    FE_Roster.alive[GetPlayerId(player)] = true
    udg_StillAlive = udg_StillAlive + 1
    return true
end

function FE_Roster.onAncientChanged(_, player)
    if not FE_Roster.initialized then return end
    FE_Roster.defeat(player)
    FE_Roster.expanderForce()
end
