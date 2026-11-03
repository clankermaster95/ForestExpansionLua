-- players / lackeys
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 317 Lackey_Respawn
-- Original JASS function: LackeyRespawn_IsValidType (line 18016)
function LackeyRespawn_IsValidType(unitType)
    do return (((((((((((unitType == FourCC("e00E")) or (unitType == FourCC("e00C"))) or (unitType == FourCC("e002"))) or (unitType == FourCC("e009"))) or (unitType == FourCC("e00A"))) or (unitType == FourCC("e00G"))) or (unitType == FourCC("e00J"))) or (unitType == FourCC("e00O"))) or (unitType == FourCC("e00H"))) or (unitType == FourCC("e00N"))) or (unitType == FourCC("e00S"))) end
end

-- Original JASS function: LackeyRespawn_IsPlayerPresent (line 18020)
function LackeyRespawn_IsPlayerPresent(playerId)
    do return (GetPlayerSlotState(Player(playerId)) == PLAYER_SLOT_STATE_PLAYING) end
end

-- Original JASS function: LackeyRespawn_OnTimer (line 18024)
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

-- Original JASS function: Trig_Lackey_Respawn_Conditions (line 18048)
function Trig_Lackey_Respawn_Conditions()
    do return LackeyRespawn_IsValidType(GetUnitTypeId(GetTriggerUnit())) end
end

-- Original JASS function: Trig_Lackey_Respawn_Actions (line 18052)
function Trig_Lackey_Respawn_Actions()
    local dying = GetTriggerUnit()
    local owner = GetOwningPlayer(dying)
    local unitType = GetUnitTypeId(dying)
    local playerId = GetPlayerId(owner)
    local t = nil
    local td = nil
    local id = 0
    if (not ((GetPlayerSlotState(Player((playerId))) == PLAYER_SLOT_STATE_PLAYING))) then
        dying = nil
        owner = nil
        do return end
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

-- Original JASS function: InitTrig_Lackey_Respawn (line 18090)
function InitTrig_Lackey_Respawn()
    gg_trg_Lackey_Respawn = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Lackey_Respawn, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Lackey_Respawn, Condition(Trig_Lackey_Respawn_Conditions))
    TriggerAddAction(gg_trg_Lackey_Respawn, Trig_Lackey_Respawn_Actions)
end
-- END FOREST SECTION 317

-- BEGIN FOREST SECTION 318 Death_start
-- Original JASS function: Trig_Death_start_Conditions (line 18099)
function Trig_Death_start_Conditions()
    if ((not ((IsUnitType(GetTriggerUnit(), UNIT_TYPE_STRUCTURE) == false)))) then
        do return false end
    end
    if ((not ((IsUnitType(GetTriggerUnit(), UNIT_TYPE_ANCIENT) == true)))) then
        do return false end
    end
    if ((not ((IsUnitEnemy(GetDyingUnit(), FE_Roles.ancient()) == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Death_start_Func002002 (line 18112)
function Trig_Death_start_Func002002()
    RemoveUnit(GetEnumUnit())
end

-- Original JASS function: Trig_Death_start_Func010Func001C (line 18116)
function Trig_Death_start_Func010Func001C()
    if ((not ((IsPlayerAlly(udg_DeadPlayer, GetEnumPlayer()) == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Death_start_Func010A (line 18123)
function Trig_Death_start_Func010A()
    if (Trig_Death_start_Func010Func001C()) then
        SetPlayerAllianceStateBJ(udg_DeadPlayer, GetEnumPlayer(), bj_ALLIANCE_UNALLIED)
        SetPlayerAllianceStateBJ(GetEnumPlayer(), udg_DeadPlayer, bj_ALLIANCE_UNALLIED)
    else
    end
end

-- Original JASS function: Trig_Death_start_Func011Func001C (line 18131)
function Trig_Death_start_Func011Func001C()
    do return true end
end

-- Original JASS function: Trig_Death_start_Func011A (line 18135)
function Trig_Death_start_Func011A()
    if ((true)) then
        SetPlayerAllianceStateBJ(udg_DeadPlayer, GetEnumPlayer(), bj_ALLIANCE_ALLIED_VISION)
        SetPlayerAllianceStateBJ(GetEnumPlayer(), udg_DeadPlayer, bj_ALLIANCE_ALLIED_VISION)
    else
    end
end

-- Original JASS function: Trig_Death_start_Actions (line 18143)
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

-- Original JASS function: InitTrig_Death_start (line 18161)
function InitTrig_Death_start()
    gg_trg_Death_start = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Death_start, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Death_start, Condition(Trig_Death_start_Conditions))
    TriggerAddAction(gg_trg_Death_start, Trig_Death_start_Actions)
end
-- END FOREST SECTION 318

-- BEGIN FOREST SECTION 319 Spawn_Lackey
-- Original JASS function: SpawnLackey_EnsureSetup (line 18171)
function SpawnLackey_EnsureSetup()
    if (SpawnLackey_Hash == nil) then
        SpawnLackey_Hash = InitHashtable()
    end
    if (SpawnLackey_GameTimer == nil) then
        SpawnLackey_GameTimer = CreateTimer()
        TimerStart(SpawnLackey_GameTimer, __jreal(999999.00), false, nil)
    end
end

-- Original JASS function: SpawnLackey_GetFountainCenterX (line 18182)
function SpawnLackey_GetFountainCenterX()
    do return __jreal((__jreal(GetRectMinX(gg_rct_Fountain) + GetRectMaxX(gg_rct_Fountain))) * __jreal(0.50)) end
end

-- Original JASS function: SpawnLackey_GetFountainCenterY (line 18186)
function SpawnLackey_GetFountainCenterY()
    do return __jreal((__jreal(GetRectMinY(gg_rct_Fountain) + GetRectMaxY(gg_rct_Fountain))) * __jreal(0.50)) end
end

-- Original JASS function: SpawnLackey_PanCameraToFountainForPlayer (line 18190)
function SpawnLackey_PanCameraToFountainForPlayer(whichPlayer)
    local x = (__jreal((__jreal(GetRectMinX(gg_rct_Fountain) + GetRectMaxX(gg_rct_Fountain))) * __jreal(0.50)))
    local y = (__jreal((__jreal(GetRectMinY(gg_rct_Fountain) + GetRectMaxY(gg_rct_Fountain))) * __jreal(0.50)))
    if (GetLocalPlayer() == whichPlayer) then
        PanCameraToTimed(x, y, __jreal(0.00))
    end
end

-- Original JASS function: SpawnLackey_GetLackeyType (line 18199)
function SpawnLackey_GetLackeyType()
    local ancientUnitType = GetUnitTypeId(udg_AncientUnit)
    if (ancientUnitType == FourCC("O00A")) then
        do return FourCC("e00C") end
    end
    if (ancientUnitType == FourCC("O00S")) then
        do return FourCC("e002") end
    end
    if (ancientUnitType == FourCC("O00L")) then
        do return FourCC("e009") end
    end
    if (ancientUnitType == FourCC("O004")) then
        do return FourCC("e00A") end
    end
    if (ancientUnitType == FourCC("O008")) then
        do return FourCC("e00N") end
    end
    if (ancientUnitType == FourCC("O01V")) then
        do return FourCC("e00G") end
    end
    if (ancientUnitType == FourCC("O016")) then
        do return FourCC("e00J") end
    end
    if (ancientUnitType == FourCC("O00D")) then
        do return FourCC("e00O") end
    end
    if (ancientUnitType == FourCC("O01X")) then
        do return FourCC("e00H") end
    end
    if (ancientUnitType == FourCC("O01Z")) then
        do return FourCC("e00E") end
    end
    if (ancientUnitType == FourCC("O01D")) then
        do return FourCC("e00S") end
    end
    do return 0 end
end

-- Original JASS function: SpawnLackey_CreateAtXY (line 18239)
function SpawnLackey_CreateAtXY(deadPlayer, lackeyType, x, y)
    local lackey = nil
    if (lackeyType == 0) then
        do return end
    end
    lackey = CreateUnit(deadPlayer, lackeyType, x, y, bj_UNIT_FACING)
    if (lackey ~= nil) then
        DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl", GetUnitX(lackey), GetUnitY(lackey)))
    end
    lackey = nil
end

-- Original JASS function: SpawnLackey_CreateAtLoc (line 18255)
function SpawnLackey_CreateAtLoc(deadPlayer, lackeyType, spawnLoc)
    SpawnLackey_CreateAtXY(deadPlayer, lackeyType, GetLocationX(spawnLoc), GetLocationY(spawnLoc))
end

-- Original JASS function: SpawnLackey_DelayedTimerExpires (line 18259)
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

-- Original JASS function: SpawnLackey_StartDelayedTimer (line 18286)
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

-- Original JASS function: Trig_Spawn_Lackey_Actions (line 18326)
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

-- Original JASS function: InitTrig_Spawn_Lackey (line 18356)
function InitTrig_Spawn_Lackey()
    SpawnLackey_EnsureSetup()
    gg_trg_Spawn_Lackey = CreateTrigger()
    TriggerAddAction(gg_trg_Spawn_Lackey, Trig_Spawn_Lackey_Actions)
end
-- END FOREST SECTION 319

-- BEGIN FOREST SECTION 320 MiniMinis
-- Original JASS function: Trig_MiniMinis_Conditions (line 18365)
function Trig_MiniMinis_Conditions()
    if ((not ((IsUnitEnemy(GetDyingUnit(), FE_Roles.ancient()) == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_MiniMinis_Func003C (line 18372)
function Trig_MiniMinis_Func003C()
    if ((not ((GetUnitTypeId(GetKillingUnitBJ()) == FourCC("e00C"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_MiniMinis_Func005C (line 18379)
function Trig_MiniMinis_Func005C()
    if ((not ((GetUnitTypeId(GetKillingUnitBJ()) == FourCC("e00G"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_MiniMinis_Func007C (line 18386)
function Trig_MiniMinis_Func007C()
    if ((not ((GetUnitTypeId(GetKillingUnitBJ()) == FourCC("e00A"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_MiniMinis_Func009C (line 18393)
function Trig_MiniMinis_Func009C()
    if ((not ((GetUnitTypeId(GetKillingUnitBJ()) == FourCC("e00N"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_MiniMinis_Func011C (line 18400)
function Trig_MiniMinis_Func011C()
    if ((not ((GetUnitTypeId(GetKillingUnitBJ()) == FourCC("e009"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_MiniMinis_Func013C (line 18407)
function Trig_MiniMinis_Func013C()
    if ((not ((GetUnitTypeId(GetKillingUnitBJ()) == FourCC("e00J"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_MiniMinis_Func015C (line 18414)
function Trig_MiniMinis_Func015C()
    if ((not ((GetUnitTypeId(GetKillingUnitBJ()) == FourCC("e00O"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_MiniMinis_Func017C (line 18421)
function Trig_MiniMinis_Func017C()
    if ((not ((GetUnitTypeId(GetKillingUnitBJ()) == FourCC("e00H"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_MiniMinis_Actions (line 18428)
function Trig_MiniMinis_Actions()
    if (Trig_MiniMinis_Func003C()) then
        AddSpecialEffectLocBJ(GetUnitLoc(GetDyingUnit()), "Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl")
        CreateNUnitsAtLoc(1, FourCC("e00D"), GetOwningPlayer(GetKillingUnitBJ()), GetUnitLoc(GetDyingUnit()), bj_UNIT_FACING)
    else
    end
    if (Trig_MiniMinis_Func005C()) then
        CreateNUnitsAtLoc(1, FourCC("e00F"), GetOwningPlayer(GetKillingUnitBJ()), GetUnitLoc(GetDyingUnit()), bj_UNIT_FACING)
    else
    end
    if (Trig_MiniMinis_Func007C()) then
        CreateNUnitsAtLoc(1, FourCC("e00B"), GetOwningPlayer(GetKillingUnitBJ()), GetUnitLoc(GetDyingUnit()), bj_UNIT_FACING)
    else
    end
    if (Trig_MiniMinis_Func009C()) then
        CreateNUnitsAtLoc(1, FourCC("e00P"), GetOwningPlayer(GetKillingUnitBJ()), GetUnitLoc(GetDyingUnit()), bj_UNIT_FACING)
    else
    end
    if (Trig_MiniMinis_Func011C()) then
        CreateNUnitsAtLoc(1, FourCC("e008"), GetOwningPlayer(GetKillingUnitBJ()), GetUnitLoc(GetDyingUnit()), bj_UNIT_FACING)
    else
    end
    if (Trig_MiniMinis_Func013C()) then
        CreateNUnitsAtLoc(1, FourCC("e00K"), GetOwningPlayer(GetKillingUnitBJ()), GetUnitLoc(GetDyingUnit()), bj_UNIT_FACING)
    else
    end
    if (Trig_MiniMinis_Func015C()) then
        CreateNUnitsAtLoc(1, FourCC("e00M"), GetOwningPlayer(GetKillingUnitBJ()), GetUnitLoc(GetDyingUnit()), bj_UNIT_FACING)
    else
    end
    if (Trig_MiniMinis_Func017C()) then
        CreateNUnitsAtLoc(1, FourCC("e00I"), GetOwningPlayer(GetKillingUnitBJ()), GetUnitLoc(GetDyingUnit()), bj_UNIT_FACING)
    else
    end
end

-- Original JASS function: InitTrig_MiniMinis (line 18472)
function InitTrig_MiniMinis()
    gg_trg_MiniMinis = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_MiniMinis, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_MiniMinis, Condition(Trig_MiniMinis_Conditions))
    TriggerAddAction(gg_trg_MiniMinis, Trig_MiniMinis_Actions)
end
-- END FOREST SECTION 320
