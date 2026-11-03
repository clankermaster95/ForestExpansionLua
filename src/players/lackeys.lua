-- players / lackeys
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 317 Lackey_Respawn
function LackeyRespawn_IsValidType(unitType)
    return (((((((((((unitType == FourCC("e00E")) or (unitType == FourCC("e00C"))) or (unitType == FourCC("e002"))) or (unitType == FourCC("e009"))) or (unitType == FourCC("e00A"))) or (unitType == FourCC("e00G"))) or (unitType == FourCC("e00J"))) or (unitType == FourCC("e00O"))) or (unitType == FourCC("e00H"))) or (unitType == FourCC("e00N"))) or (unitType == FourCC("e00S")))
end

function LackeyRespawn_IsPlayerPresent(playerId)
    return (GetPlayerSlotState(Player(playerId)) == PLAYER_SLOT_STATE_PLAYING)
end

function LackeyRespawn_OnTimer()
    local t = GetExpiredTimer()
    local id = GetHandleId(t)
    local unitType = LoadInteger(LackeyRespawn_Hash, id, LACK_RESPAWN_KEY_TYPE)
    local playerId = LoadInteger(LackeyRespawn_Hash, id, LACK_RESPAWN_KEY_PLAYER)
    local td = LoadTimerDialogHandle(LackeyRespawn_Hash, id, LACK_RESPAWN_KEY_DIALOG)
    local x = GetRectCenterX(gg_rct_Alarm)
    local y = GetRectCenterY(gg_rct_Alarm)
    if GetPlayerSlotState(Player(playerId)) == PLAYER_SLOT_STATE_PLAYING and
       not FE_Roles.isAncient(Player(playerId)) and not FE_Roster.isAlive(Player(playerId)) then
        CreateUnit(Player(playerId), unitType, x, y, bj_UNIT_FACING)
    end
    TimerDialogDisplay(td, false)
    DestroyTimerDialog(td)
    FlushChildHashtable(LackeyRespawn_Hash, id)
    PauseTimer(t)
    DestroyTimer(t)
    td = nil
    t = nil
end

function Trig_Lackey_Respawn_Conditions()
    return LackeyRespawn_IsValidType(GetUnitTypeId(GetTriggerUnit()))
end

function Trig_Lackey_Respawn_Actions()
    local dying = GetTriggerUnit()
    local owner = GetOwningPlayer(dying)
    local unitType = GetUnitTypeId(dying)
    local playerId = GetPlayerId(owner)
    local t = nil
    local td = nil
    local id = 0
    if (not (GetPlayerSlotState(Player((playerId))) == PLAYER_SLOT_STATE_PLAYING)) then
        dying = nil
        owner = nil
        return
    end
    t = CreateTimer()
    td = CreateTimerDialog(t)
    id = GetHandleId(t)
    SaveInteger(LackeyRespawn_Hash, id, LACK_RESPAWN_KEY_TYPE, unitType)
    SaveInteger(LackeyRespawn_Hash, id, LACK_RESPAWN_KEY_PLAYER, playerId)
    SaveTimerDialogHandle(LackeyRespawn_Hash, id, LACK_RESPAWN_KEY_DIALOG, td)
    TimerDialogSetTitle(td, "Lackey respawn")
    if (GetLocalPlayer() == owner) then
        TimerDialogDisplay(td, true)
    end
    TimerStart(t, LACK_RESPAWN_DELAY, false, LackeyRespawn_OnTimer)
    dying = nil
    owner = nil
    td = nil
    t = nil
end

function InitTrig_Lackey_Respawn()
    gg_trg_Lackey_Respawn = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Lackey_Respawn, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Lackey_Respawn, Condition(Trig_Lackey_Respawn_Conditions))
    TriggerAddAction(gg_trg_Lackey_Respawn, Trig_Lackey_Respawn_Actions)
end
-- END FOREST SECTION 317

-- BEGIN FOREST SECTION 318 Death_start
function Trig_Death_start_Conditions()
    if (not (IsUnitType(GetTriggerUnit(), UNIT_TYPE_STRUCTURE) == false)) then
        return false
    end
    if (not (IsUnitType(GetTriggerUnit(), UNIT_TYPE_ANCIENT) == true)) then
        return false
    end
    if (not (IsUnitEnemy(GetDyingUnit(), FE_Roles.ancient()) == true)) then
        return false
    end
    return true
end

function Trig_Death_start_Func002002()
    RemoveUnit(GetEnumUnit())
end

function Trig_Death_start_Func010Func001C()
    return IsPlayerAlly(udg_DeadPlayer, GetEnumPlayer()) == true
end

function Trig_Death_start_Func010A()
    if (Trig_Death_start_Func010Func001C()) then
        SetPlayerAllianceStateBJ(udg_DeadPlayer, GetEnumPlayer(), bj_ALLIANCE_UNALLIED)
        SetPlayerAllianceStateBJ(GetEnumPlayer(), udg_DeadPlayer, bj_ALLIANCE_UNALLIED)
    end
end

function Trig_Death_start_Func011A()
    if (true) then
        SetPlayerAllianceStateBJ(udg_DeadPlayer, GetEnumPlayer(), bj_ALLIANCE_ALLIED_VISION)
        SetPlayerAllianceStateBJ(GetEnumPlayer(), udg_DeadPlayer, bj_ALLIANCE_ALLIED_VISION)
    end
end

function Trig_Death_start_Actions()
    local dying = GetTriggerUnit()
    local player = GetOwningPlayer(dying)
    if not FE_Roster.defeat(player) then return end
    local killer = GetKillingUnitBJ()
    local location = GetUnitLoc(killer or dying)
    udg_Flags[GetConvertedPlayerId(player)] = false
    udg_DeadPlayer = player
    udg_SeedOfRebirth[GetConvertedPlayerId(player)] = GetUnitTypeId(dying)
    udg_LocationOfDeath = location
    DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl", GetUnitX(dying), GetUnitY(dying)))
    local units = GetUnitsOfPlayerAll(player)
    ForGroupBJ(units, Trig_Death_start_Func002002)
    DestroyGroup(units)
    ConditionalTriggerExecute(gg_trg_Spawn_Lackey)
    RemoveLocation(location)
    udg_LocationOfDeath = nil
    ForForce(GetPlayersAll(), Trig_Death_start_Func010A)
    local allies = GetPlayersAllies(FE_Roles.ancient())
    ForForce(allies, Trig_Death_start_Func011A)
    DestroyForce(allies)
    SetPlayerAllianceStateBJ(player, FE_Roles.ancient(), bj_ALLIANCE_ALLIED_VISION)
    SetPlayerAllianceStateBJ(FE_Roles.ancient(), player, bj_ALLIANCE_ALLIED_VISION)
end

function InitTrig_Death_start()
    gg_trg_Death_start = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Death_start, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Death_start, Condition(Trig_Death_start_Conditions))
    TriggerAddAction(gg_trg_Death_start, Trig_Death_start_Actions)
end
-- END FOREST SECTION 318

-- BEGIN FOREST SECTION 319 Spawn_Lackey
function SpawnLackey_EnsureSetup()
    if (SpawnLackey_Hash == nil) then
        SpawnLackey_Hash = InitHashtable()
    end
    if (SpawnLackey_GameTimer == nil) then
        SpawnLackey_GameTimer = CreateTimer()
        TimerStart(SpawnLackey_GameTimer, __jreal(999999.00), false, nil)
    end
end

function SpawnLackey_GetFountainCenterX()
    return __jreal((__jreal(GetRectMinX(gg_rct_Fountain) + GetRectMaxX(gg_rct_Fountain))) * __jreal(0.50))
end

function SpawnLackey_GetFountainCenterY()
    return __jreal((__jreal(GetRectMinY(gg_rct_Fountain) + GetRectMaxY(gg_rct_Fountain))) * __jreal(0.50))
end

function SpawnLackey_PanCameraToFountainForPlayer(whichPlayer)
    local x = (__jreal((__jreal(GetRectMinX(gg_rct_Fountain) + GetRectMaxX(gg_rct_Fountain))) * __jreal(0.50)))
    local y = (__jreal((__jreal(GetRectMinY(gg_rct_Fountain) + GetRectMaxY(gg_rct_Fountain))) * __jreal(0.50)))
    if (GetLocalPlayer() == whichPlayer) then
        PanCameraToTimed(x, y, __jreal(0.00))
    end
end

function SpawnLackey_GetLackeyType()
    local ancientUnitType = GetUnitTypeId(udg_AncientUnit)
    if (ancientUnitType == FourCC("O00A")) then
        return FourCC("e00C")
    end
    if (ancientUnitType == FourCC("O00S")) then
        return FourCC("e002")
    end
    if (ancientUnitType == FourCC("O00L")) then
        return FourCC("e009")
    end
    if (ancientUnitType == FourCC("O004")) then
        return FourCC("e00A")
    end
    if (ancientUnitType == FourCC("O008")) then
        return FourCC("e00N")
    end
    if (ancientUnitType == FourCC("O01V")) then
        return FourCC("e00G")
    end
    if (ancientUnitType == FourCC("O016")) then
        return FourCC("e00J")
    end
    if (ancientUnitType == FourCC("O00D")) then
        return FourCC("e00O")
    end
    if (ancientUnitType == FourCC("O01X")) then
        return FourCC("e00H")
    end
    if (ancientUnitType == FourCC("O01Z")) then
        return FourCC("e00E")
    end
    if (ancientUnitType == FourCC("O01D")) then
        return FourCC("e00S")
    end
    return 0
end

function SpawnLackey_CreateAtXY(deadPlayer, lackeyType, x, y)
    local lackey = nil
    if (lackeyType == 0) then
        return
    end
    lackey = CreateUnit(deadPlayer, lackeyType, x, y, bj_UNIT_FACING)
    if (lackey ~= nil) then
        DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl", GetUnitX(lackey), GetUnitY(lackey)))
    end
    lackey = nil
end

function SpawnLackey_CreateAtLoc(deadPlayer, lackeyType, spawnLoc)
    SpawnLackey_CreateAtXY(deadPlayer, lackeyType, GetLocationX(spawnLoc), GetLocationY(spawnLoc))
end

function SpawnLackey_DelayedTimerExpires()
    local t = GetExpiredTimer()
    local timerId = GetHandleId(t)
    local playerIndex = LoadInteger(SpawnLackey_Hash, timerId, 0)
    local lackeyType = LoadInteger(SpawnLackey_Hash, timerId, 1)
    local deadPlayer = Player(playerIndex)
    local x = (__jreal((__jreal(GetRectMinX(gg_rct_Fountain) + GetRectMaxX(gg_rct_Fountain))) * __jreal(0.50)))
    local y = (__jreal((__jreal(GetRectMinY(gg_rct_Fountain) + GetRectMaxY(gg_rct_Fountain))) * __jreal(0.50)))
    if GetPlayerSlotState(deadPlayer) == PLAYER_SLOT_STATE_PLAYING and
       not FE_Roles.isAncient(deadPlayer) and not FE_Roster.isAlive(deadPlayer) then
        SpawnLackey_CreateAtXY(deadPlayer, lackeyType, x, y)
        SpawnLackey_PanCameraToFountainForPlayer(deadPlayer)
    end
    if (SpawnLackey_PlayerDialog[playerIndex] ~= nil) then
        TimerDialogDisplay(SpawnLackey_PlayerDialog[playerIndex], false)
        DestroyTimerDialog(SpawnLackey_PlayerDialog[playerIndex])
        SpawnLackey_PlayerDialog[playerIndex] = nil
    end
    SpawnLackey_PlayerTimer[playerIndex] = nil
    FlushChildHashtable(SpawnLackey_Hash, timerId)
    DestroyTimer(t)
    t = nil
    deadPlayer = nil
end

function SpawnLackey_StartDelayedTimer(deadPlayer, lackeyType, remaining)
    local playerIndex = GetPlayerId(deadPlayer)
    local t = CreateTimer()
    SpawnLackey_EnsureSetup()
    if (remaining < __jreal(0.00)) then
        remaining = __jreal(0.00)
    end
    if (SpawnLackey_PlayerTimer[playerIndex] ~= nil) then
        PauseTimer(SpawnLackey_PlayerTimer[playerIndex])
        FlushChildHashtable(SpawnLackey_Hash, GetHandleId(SpawnLackey_PlayerTimer[playerIndex]))
        DestroyTimer(SpawnLackey_PlayerTimer[playerIndex])
        SpawnLackey_PlayerTimer[playerIndex] = nil
    end
    if (SpawnLackey_PlayerDialog[playerIndex] ~= nil) then
        TimerDialogDisplay(SpawnLackey_PlayerDialog[playerIndex], false)
        DestroyTimerDialog(SpawnLackey_PlayerDialog[playerIndex])
        SpawnLackey_PlayerDialog[playerIndex] = nil
    end
    SpawnLackey_PlayerTimer[playerIndex] = t
    SpawnLackey_PlayerDialog[playerIndex] = CreateTimerDialog(t)
    TimerDialogSetTitle(SpawnLackey_PlayerDialog[playerIndex], "Time till lackey spawn")
    if (GetLocalPlayer() == deadPlayer) then
        TimerDialogDisplay(SpawnLackey_PlayerDialog[playerIndex], true)
    end
    SaveInteger(SpawnLackey_Hash, GetHandleId(t), 0, playerIndex)
    SaveInteger(SpawnLackey_Hash, GetHandleId(t), 1, lackeyType)
    TimerStart(t, remaining, false, SpawnLackey_DelayedTimerExpires)
    t = nil
end

function Trig_Spawn_Lackey_Actions()
    local deadPlayer = udg_DeadPlayer
    local x, y = GetLocationX(udg_LocationOfDeath), GetLocationY(udg_LocationOfDeath)
    SpawnLackey_EnsureSetup()
    local lackeyType = SpawnLackey_GetLackeyType()
    local killer = GetKillingUnitBJ()
    local killerName = killer and GetPlayerName(GetOwningPlayer(killer)) or "the environment"
    DisplayTextToForce(GetPlayersAll(), GetPlayerName(deadPlayer) .. " was killed by " .. killerName)
    SetPlayerStateBJ(deadPlayer, PLAYER_STATE_RESOURCE_GOLD, 0)
    SetPlayerStateBJ(deadPlayer, PLAYER_STATE_RESOURCE_LUMBER, 0)
    TriggerSleepAction(__jreal(0.50))
    if lackeyType == 0 or GetPlayerSlotState(deadPlayer) ~= PLAYER_SLOT_STATE_PLAYING or
       FE_Roles.isAncient(deadPlayer) or FE_Roster.isAlive(deadPlayer) then return end
    local remaining = SPAWN_LACKEY_DELAY_MARK - TimerGetElapsed(SpawnLackey_GameTimer)
    if remaining > 0 then SpawnLackey_StartDelayedTimer(deadPlayer, lackeyType, remaining)
    else SpawnLackey_CreateAtXY(deadPlayer, lackeyType, x, y) end
end

function InitTrig_Spawn_Lackey()
    SpawnLackey_EnsureSetup()
    gg_trg_Spawn_Lackey = CreateTrigger()
    TriggerAddAction(gg_trg_Spawn_Lackey, Trig_Spawn_Lackey_Actions)
end
-- END FOREST SECTION 319

-- BEGIN FOREST SECTION 320 MiniMinis
function Trig_MiniMinis_Conditions()
    return IsUnitEnemy(GetDyingUnit(), FE_Roles.ancient()) == true
end

function Trig_MiniMinis_Func003C()
    return GetUnitTypeId(GetKillingUnitBJ()) == FourCC("e00C")
end

function Trig_MiniMinis_Func005C()
    return GetUnitTypeId(GetKillingUnitBJ()) == FourCC("e00G")
end

function Trig_MiniMinis_Func007C()
    return GetUnitTypeId(GetKillingUnitBJ()) == FourCC("e00A")
end

function Trig_MiniMinis_Func009C()
    return GetUnitTypeId(GetKillingUnitBJ()) == FourCC("e00N")
end

function Trig_MiniMinis_Func011C()
    return GetUnitTypeId(GetKillingUnitBJ()) == FourCC("e009")
end

function Trig_MiniMinis_Func013C()
    return GetUnitTypeId(GetKillingUnitBJ()) == FourCC("e00J")
end

function Trig_MiniMinis_Func015C()
    return GetUnitTypeId(GetKillingUnitBJ()) == FourCC("e00O")
end

function Trig_MiniMinis_Func017C()
    return GetUnitTypeId(GetKillingUnitBJ()) == FourCC("e00H")
end

function Trig_MiniMinis_Actions()
    if (Trig_MiniMinis_Func003C()) then
        AddSpecialEffectLocBJ(GetUnitLoc(GetDyingUnit()), "Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl")
        CreateNUnitsAtLoc(1, FourCC("e00D"), GetOwningPlayer(GetKillingUnitBJ()), GetUnitLoc(GetDyingUnit()), bj_UNIT_FACING)
    end
    if (Trig_MiniMinis_Func005C()) then
        CreateNUnitsAtLoc(1, FourCC("e00F"), GetOwningPlayer(GetKillingUnitBJ()), GetUnitLoc(GetDyingUnit()), bj_UNIT_FACING)
    end
    if (Trig_MiniMinis_Func007C()) then
        CreateNUnitsAtLoc(1, FourCC("e00B"), GetOwningPlayer(GetKillingUnitBJ()), GetUnitLoc(GetDyingUnit()), bj_UNIT_FACING)
    end
    if (Trig_MiniMinis_Func009C()) then
        CreateNUnitsAtLoc(1, FourCC("e00P"), GetOwningPlayer(GetKillingUnitBJ()), GetUnitLoc(GetDyingUnit()), bj_UNIT_FACING)
    end
    if (Trig_MiniMinis_Func011C()) then
        CreateNUnitsAtLoc(1, FourCC("e008"), GetOwningPlayer(GetKillingUnitBJ()), GetUnitLoc(GetDyingUnit()), bj_UNIT_FACING)
    end
    if (Trig_MiniMinis_Func013C()) then
        CreateNUnitsAtLoc(1, FourCC("e00K"), GetOwningPlayer(GetKillingUnitBJ()), GetUnitLoc(GetDyingUnit()), bj_UNIT_FACING)
    end
    if (Trig_MiniMinis_Func015C()) then
        CreateNUnitsAtLoc(1, FourCC("e00M"), GetOwningPlayer(GetKillingUnitBJ()), GetUnitLoc(GetDyingUnit()), bj_UNIT_FACING)
    end
    if (Trig_MiniMinis_Func017C()) then
        CreateNUnitsAtLoc(1, FourCC("e00I"), GetOwningPlayer(GetKillingUnitBJ()), GetUnitLoc(GetDyingUnit()), bj_UNIT_FACING)
    end
end

function InitTrig_MiniMinis()
    gg_trg_MiniMinis = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_MiniMinis, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_MiniMinis, Condition(Trig_MiniMinis_Conditions))
    TriggerAddAction(gg_trg_MiniMinis, Trig_MiniMinis_Actions)
end
-- END FOREST SECTION 320
