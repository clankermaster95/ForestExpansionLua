-- economy / feed
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 21 AutoFeedRate
-- Capture lobby identity before race selection adds colors/titles to names.
FE_FeedNames = {}
function FeedRate_Identity(p)
    return FE_FeedNames[GetPlayerId(p)] or GetPlayerName(p)
end

function FeedRate_DebugError(msg)
    DisplayTimedTextToForce(GetPlayersAll(), __jreal(20.00), __jconcat("|cffff0000[FeedRate Debug]|r ", msg))
end

function FeedRate_Clamp(rate)
    if (rate < 50) then
        return 50
    end
    if (rate > 100) then
        return 100
    end
    return rate
end

function FeedRate_FindChar(data, wanted)
    local i = 0
    local len = StringLength(data)
    while true do
        if (i >= len) then break end
        if (SubString(data, i, __jint(i + 1)) == wanted) then
            return i
        end
        i = __jint(i + 1)
    end
    return __jint(-(1))
end

function FeedRate_ParseRate(data)
    local digits = data:match("^\x25d+$") or data:match("^\x25d+:(\x25d+)$")
    local rate = digits and tonumber(digits)
    if not rate or rate <= 0 or rate > 100 then return 0 end
    return FeedRate_Clamp(rate)
end

function FeedRate_IsValidUser(p)
    return ((GetPlayerController(p) == MAP_CONTROL_USER) and (GetPlayerSlotState(p) == PLAYER_SLOT_STATE_PLAYING))
end

function FeedRate_CountActiveUsers()
    local i = 0
    local count = 0
    while true do
        if (i >= FEEDRATE_MAX_PLAYERS) then break end
        if FeedRate_IsValidUser(Player(i)) then
            count = __jint(count + 1)
        end
        i = __jint(i + 1)
    end
    return count
end

function FeedRate_PlayerNameHasBattleTag(p)
    return (FeedRate_FindChar(FeedRate_Identity(p), "#") >= 0)
end

function FeedRate_FindMatchingPlayerByName(playerName)
    local i = 0
    local p = nil
    while true do
        if (i >= FEEDRATE_MAX_PLAYERS) then break end
        p = Player(i)
        if (FeedRate_IsValidUser(p) and (FeedRate_Identity(p) == playerName)) then
            return p
        end
        i = __jint(i + 1)
    end
    return nil
end

function FeedRate_Apply(p, rate)
    local pid = GetPlayerId(p)
    rate = FeedRate_Clamp(rate)
    FeedRate_Loaded[pid] = true
    udg_ExperienceRate[pid] = I2R(rate)
end

function FeedRate_SaveForPlayer(p, rate)
    if GetLocalPlayer() == p and FeedRate_PlayerNameHasBattleTag(p) then
        -- Preloader files execute JASS even in a Lua map. Escape the JASS
        -- string literal before embedding a player-supplied name.
        local name = FeedRate_Identity(p):gsub('\\', '\\\\'):gsub('"', '\\"'):gsub('\r', '\\r'):gsub('\n', '\\n')
        PreloadGenClear()
        PreloadGenStart()
        Preload('\")\ncall BlzSendSyncData("' .. FEEDRATE_SYNC_PREFIX .. '","' .. tostring(FeedRate_Clamp(rate)) ..
            '")\ncall BlzSendSyncData("' .. FEEDRATE_NAME_SYNC_PREFIX .. '","' .. name .. '")\n//')
        PreloadGenEnd(FEEDRATE_FILE_PATH)
    end
end

function FeedRate_SelectRate(p, rate)
    FeedRate_Apply(p, rate)
    FeedRate_SaveForPlayer(p, rate)
    p = nil
end

function FeedRate_ClickYes()
    FeedRate_SelectRate(GetTriggerPlayer(), 100)
end

function FeedRate_ClickOtherTag()
    FeedRate_SelectRate(GetTriggerPlayer(), 75)
end

function FeedRate_ClickNo()
    FeedRate_SelectRate(GetTriggerPlayer(), 50)
end

function FeedRate_OnRateSync()
    local p = GetTriggerPlayer()
    local pid = GetPlayerId(p)
    local rate = FeedRate_ParseRate(BlzGetTriggerSyncData())
    if (rate > 0) then
        FeedRate_PendingRateReceived[pid] = true
        FeedRate_PendingRate[pid] = rate
        FeedRate_ProcessPendingLoadForPlayer(p)
    end
    p = nil
end

function FeedRate_OnNameSync()
    local p = GetTriggerPlayer()
    local pid = GetPlayerId(p)
    FeedRate_PendingNameReceived[pid] = true
    FeedRate_PendingName[pid] = BlzGetTriggerSyncData()
    FeedRate_ProcessPendingLoadForPlayer(p)
    p = nil
end

function FeedRate_ProcessPendingLoadForPlayer(p)
    local pid = GetPlayerId(p)
    if not FeedRate_IsValidUser(p) or FeedRate_Loaded[pid] or
       not FeedRate_PendingRateReceived[pid] or not FeedRate_PendingNameReceived[pid] then return end
    local rate = FeedRate_PendingRate[pid]
    local savedName = FeedRate_PendingName[pid]
    local offline = not FeedRate_PlayerNameHasBattleTag(p) and FeedRate_CountActiveUsers() <= 1
    -- A synchronized payload belongs only to its sender. Never let another
    -- player's local file choose the feed rate for someone else in the lobby.
    if savedName ~= FeedRate_Identity(p) and not offline then return end
    local finalRate = FeedRate_Clamp(rate + 5)
    FeedRate_Apply(p, finalRate)
    DialogDisplayBJ(false, udg_StartupDialog, p)
    if not offline and finalRate ~= rate then FeedRate_SaveForPlayer(p, finalRate) end
end

function FeedRate_ProcessPendingLoads()
    local t = GetExpiredTimer()
    local i = 0
    FE_Timers.destroy(t)
    while true do
        if (i >= FEEDRATE_MAX_PLAYERS) then break end
        FeedRate_ProcessPendingLoadForPlayer(Player(i))
        i = __jint(i + 1)
    end
    t = nil
end

function FeedRate_TryLoadForPlayer(i)
    local p = Player(i)
    if FeedRate_IsValidUser(p) then
        if (GetLocalPlayer() == p) then
            Preloader(FEEDRATE_FILE_PATH)
        end
    end
    p = nil
end

function FeedRate_StartLoadAll()
    local t = GetExpiredTimer()
    local i = 0
    FE_Timers.destroy(t)
    while true do
        if (i >= FEEDRATE_MAX_PLAYERS) then break end
        FeedRate_Loaded[i] = false
        FeedRate_PendingRateReceived[i] = false
        FeedRate_PendingRate[i] = 0
        FeedRate_PendingNameReceived[i] = false
        FeedRate_PendingName[i] = ""
        FeedRate_TryLoadForPlayer(i)
        i = __jint(i + 1)
    end
    t = nil
end

function FeedRate_ShowDialogsForMissingLoads()
    local t = GetExpiredTimer()
    local i = 0
    FE_Timers.destroy(t)
    while true do
        if (i >= FEEDRATE_MAX_PLAYERS) then break end
        if (FeedRate_IsValidUser(Player(i)) and (not FeedRate_Loaded[i])) then
            DialogDisplayBJ(true, udg_StartupDialog, Player(i))
        end
        i = __jint(i + 1)
    end
    t = nil
end

function FeedRate_SetupDialog()
    DialogClearBJ(udg_StartupDialog)
    DialogSetMessageBJ(udg_StartupDialog, "Did you play this map before?")
    FeedRate_ButtonYes = DialogAddButtonBJ(udg_StartupDialog, "Yes")
    FeedRate_ButtonOtherTag = DialogAddButtonBJ(udg_StartupDialog, "I played other tag maps")
    FeedRate_ButtonNo = DialogAddButtonBJ(udg_StartupDialog, "No / Not Sure")
    FeedRate_YesTrigger = CreateTrigger()
    FeedRate_OtherTagTrigger = CreateTrigger()
    FeedRate_NoTrigger = CreateTrigger()
    TriggerRegisterDialogButtonEvent(FeedRate_YesTrigger, FeedRate_ButtonYes)
    TriggerRegisterDialogButtonEvent(FeedRate_OtherTagTrigger, FeedRate_ButtonOtherTag)
    TriggerRegisterDialogButtonEvent(FeedRate_NoTrigger, FeedRate_ButtonNo)
    TriggerAddAction(FeedRate_YesTrigger, FeedRate_ClickYes)
    TriggerAddAction(FeedRate_OtherTagTrigger, FeedRate_ClickOtherTag)
    TriggerAddAction(FeedRate_NoTrigger, FeedRate_ClickNo)
end

function Trig_AutoFeedRate_Actions()
    local i = 0
    local loadTimer = FE_Timers.create()
    local processTimer = FE_Timers.create()
    local dialogTimer = FE_Timers.create()
    FeedRate_SetupDialog()
    FeedRate_SyncTrigger = CreateTrigger()
    FeedRate_NameSyncTrigger = CreateTrigger()
    TriggerAddAction(FeedRate_SyncTrigger, FeedRate_OnRateSync)
    TriggerAddAction(FeedRate_NameSyncTrigger, FeedRate_OnNameSync)
    while true do
        if (i >= FEEDRATE_MAX_PLAYERS) then break end
        BlzTriggerRegisterPlayerSyncEvent(FeedRate_SyncTrigger, Player(i), FEEDRATE_SYNC_PREFIX, false)
        BlzTriggerRegisterPlayerSyncEvent(FeedRate_NameSyncTrigger, Player(i), FEEDRATE_NAME_SYNC_PREFIX, false)
        i = __jint(i + 1)
    end
    TimerStart(loadTimer, __jreal(0.10), false, FeedRate_StartLoadAll)
    TimerStart(processTimer, __jreal(1.00), false, FeedRate_ProcessPendingLoads)
    TimerStart(dialogTimer, __jreal(1.50), false, FeedRate_ShowDialogsForMissingLoads)
    loadTimer = nil
    processTimer = nil
    dialogTimer = nil
end

function InitTrig_AutoFeedRate()
    for slot = 0, FEEDRATE_MAX_PLAYERS - 1 do
        FE_FeedNames[slot] = GetPlayerName(Player(slot))
    end
    gg_trg_AutoFeedRate = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_AutoFeedRate, __jreal(0.01))
    TriggerAddAction(gg_trg_AutoFeedRate, Trig_AutoFeedRate_Actions)
end
-- END FOREST SECTION 21

-- BEGIN FOREST SECTION 22 TimeToAncientSpawn_Copy
function Trig_TimeToAncientSpawn_Copy_Actions()
    DisableTrigger(gg_trg_SetFeed)
end

function InitTrig_TimeToAncientSpawn_Copy()
    gg_trg_TimeToAncientSpawn_Copy = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_TimeToAncientSpawn_Copy, __jreal(60.00))
    TriggerAddAction(gg_trg_TimeToAncientSpawn_Copy, Trig_TimeToAncientSpawn_Copy_Actions)
end
-- END FOREST SECTION 22

-- BEGIN FOREST SECTION 23 HandleSetRate
function SetFeedIsDigit(char)
    local digits = "0123456789"
    local i = 0
    while true do
        if (i >= 10) then break end
        if (char == SubString(digits, i, __jint(i + 1))) then
            return true
        end
        i = __jint(i + 1)
    end
    return false
end

function SetFeedClampRate(rate)
    if (rate < __jreal(50.00)) then
        return __jreal(50.00)
    end
    if (rate > __jreal(200.00)) then
        return __jreal(200.00)
    end
    return rate
end

function SetFeedErrorRateOutOfRange(whichPlayer, value)
    DisplayTextToPlayer(whichPlayer, __jreal(0), __jreal(0), __jconcat(__jconcat("Error: Feedrate ", value), " is outside allowed range. Use 50 to 200."))
end

function SetFeedErrorCannotFindPlayer(whichPlayer, playerName)
    DisplayTextToPlayer(whichPlayer, __jreal(0), __jreal(0), __jconcat("Error: Cannot find player called ", playerName))
end

function SetFeedTrimLeft(s)
    local i = 0
    local len = StringLength(s)
    while true do
        if ((i >= len) or (SubString(s, i, __jint(i + 1)) ~= " ")) then break end
        i = __jint(i + 1)
    end
    return SubString(s, i, len)
end

function SetFeedFirstToken(s)
    local i = 0
    local len = StringLength(s)
    while true do
        if ((i >= len) or (SubString(s, i, __jint(i + 1)) == " ")) then break end
        i = __jint(i + 1)
    end
    return SubString(s, 0, i)
end

function SetFeedRestAfterFirstToken(s)
    local i = 0
    local len = StringLength(s)
    while true do
        if ((i >= len) or (SubString(s, i, __jint(i + 1)) == " ")) then break end
        i = __jint(i + 1)
    end
    while true do
        if ((i >= len) or (SubString(s, i, __jint(i + 1)) ~= " ")) then break end
        i = __jint(i + 1)
    end
    return SubString(s, i, len)
end

function SetFeedIsUnsignedInteger(s)
    local i = 0
    local len = StringLength(s)
    if (len <= 0) then
        return false
    end
    while true do
        if (i >= len) then break end
        if (not SetFeedIsDigit(SubString(s, i, __jint(i + 1)))) then
            return false
        end
        i = __jint(i + 1)
    end
    return true
end

function SetFeedIsUnsignedReal(s)
    local i = 0
    local len = StringLength(s)
    local dotCount = 0
    local digitCount = 0
    local c = nil
    if (len <= 0) then
        return false
    end
    while true do
        if (i >= len) then break end
        c = SubString(s, i, __jint(i + 1))
        if SetFeedIsDigit(c) then
            digitCount = __jint(digitCount + 1)
        elseif (c == ".") then
            dotCount = __jint(dotCount + 1)
            if (dotCount > 1) then
                return false
            end
        else
            return false
        end
        i = __jint(i + 1)
    end
    return (digitCount > 0)
end

function SetFeedPercentToMultiplierText(percent)
    local whole = __jdiv(percent, 100)
    local frac = __jint(percent - __jint(whole * 100))
    if (frac == 0) then
        return I2S(whole)
    end
    if (ModuloInteger(frac, 10) == 0) then
        return __jconcat(__jconcat(I2S(whole), "."), I2S(__jdiv(frac, 10)))
    end
    if (frac < 10) then
        return __jconcat(__jconcat(I2S(whole), ".0"), I2S(frac))
    end
    return __jconcat(__jconcat(I2S(whole), "."), I2S(frac))
end

function SetFeedColorToPlayerNumber(token)
    local c = StringCase(token, false)
    if (c == "red") then
        return 1
    end
    if (c == "blue") then
        return 2
    end
    if (c == "teal") then
        return 3
    end
    if (c == "purple") then
        return 4
    end
    if (c == "yellow") then
        return 5
    end
    if (c == "orange") then
        return 6
    end
    if (c == "green") then
        return 7
    end
    if (c == "pink") then
        return 8
    end
    if ((c == "gray") or (c == "grey")) then
        return 9
    end
    if (((c == "lightblue") or (c == "light-blue")) or (c == "light_blue")) then
        return 10
    end
    if (((c == "darkgreen") or (c == "dark-green")) or (c == "dark_green")) then
        return 11
    end
    return 0
end

function SetFeedTwoWordColorToPlayerNumber(token1, token2)
    local c1 = StringCase(token1, false)
    local c2 = StringCase(token2, false)
    if ((c1 == "light") and (c2 == "blue")) then
        return 10
    end
    if ((c1 == "dark") and (c2 == "green")) then
        return 11
    end
    return 0
end

function SetFeedSetAll(rate)
    local i = 0
    while true do
        if (i >= 11) then break end
        udg_ExperienceRate[i] = I2R(rate)
        i = __jint(i + 1)
    end
end

function HandleSetExp(triggerPlayer, message)
    local trimmed = SetFeedTrimLeft(SubString(message, 8, StringLength(message)))
    local token1 = SetFeedFirstToken(trimmed)
    local rest = SetFeedRestAfterFirstToken(trimmed)
    local token2 = ""
    local extra = ""
    local multText = ""
    local playerNameForError = ""
    local playerNumber = 0
    local twoWordColorNumber = 0
    local y = 0
    local i = 0
    local suggestedPercent = 0
    local oldRate = __jreal(0.00)
    local multiplier = __jreal(0.00)
    local singleReal = __jreal(0.00)
    if (token1 == "") then
        DisplayTextToPlayer(triggerPlayer, __jreal(0), __jreal(0), "Failed to set feedrate")
        return
    end
    if (((rest == "") and (StringLength(token1) > 1)) and (SubString(token1, 0, 1) == "x")) then
        multText = SubString(token1, 1, StringLength(token1))
        if (not SetFeedIsUnsignedReal(multText)) then
            DisplayTextToPlayer(triggerPlayer, __jreal(0), __jreal(0), "Failed to set feedrate")
            return
        end
        multiplier = S2R(multText)
        if (multiplier <= __jreal(0.00)) then
            DisplayTextToPlayer(triggerPlayer, __jreal(0), __jreal(0), "Failed to set feedrate")
            return
        end
        if (((multiplier >= __jreal(50.00)) and (multiplier <= __jreal(200.00))) and (multiplier == I2R(R2I(multiplier)))) then
            suggestedPercent = R2I(multiplier)
            DisplayTextToPlayer(triggerPlayer, __jreal(0), __jreal(0), __jconcat(__jconcat(__jconcat(__jconcat(__jconcat(__jconcat(__jconcat(__jconcat("Error: Did you mean -setfeed x", SetFeedPercentToMultiplierText(suggestedPercent)), "? (multiplies every feedrate by "), SetFeedPercentToMultiplierText(suggestedPercent)), ") or did you mean to do -setfeed "), I2S(suggestedPercent)), " (sets everyone's feedrate to "), I2S(suggestedPercent)), "\x25)"))
            return
        end
        i = 0
        while true do
            if (i >= 11) then break end
            oldRate = udg_ExperienceRate[i]
            if ((oldRate < __jreal(50.00)) or (oldRate > __jreal(200.00))) then
                oldRate = __jreal(100.00)
            end
            udg_ExperienceRate[i] = SetFeedClampRate(I2R(R2I(__jreal(__jreal(oldRate * multiplier) + __jreal(0.50)))))
            i = __jint(i + 1)
        end
        DisplayTextToPlayer(triggerPlayer, __jreal(0), __jreal(0), __jconcat(__jconcat("Every feedrate was multiplied by ", multText), ". Final values are limited to 50\x25-200\x25."))
        return
    end
    if (rest == "") then
        if SetFeedIsUnsignedInteger(token1) then
            y = S2I(token1)
            if ((y < 50) or (y > 200)) then
                DisplayTextToPlayer((triggerPlayer), __jreal(0), __jreal(0), __jconcat(__jconcat("Error: Feedrate ", (token1)), " is outside allowed range. Use 50 to 200."))
                return
            end
            SetFeedSetAll(y)
            DisplayTextToPlayer(triggerPlayer, __jreal(0), __jreal(0), __jconcat(__jconcat("Feedrate of every player is set to ", I2S(y)), "\x25"))
            return
        end
        if SetFeedIsUnsignedReal(token1) then
            singleReal = S2R(token1)
            if ((singleReal >= __jreal(0.50)) and (singleReal <= __jreal(2.00))) then
                suggestedPercent = R2I(__jreal(__jreal(singleReal * __jreal(100.00)) + __jreal(0.50)))
                DisplayTextToPlayer(triggerPlayer, __jreal(0), __jreal(0), __jconcat(__jconcat(__jconcat(__jconcat(__jconcat(__jconcat(__jconcat(__jconcat("Error: Did you mean -setfeed x", token1), "? (multiplies every feedrate by "), token1), ") or did you mean to -setfeed "), I2S(suggestedPercent)), " (sets everyone's feedrate to "), I2S(suggestedPercent)), "\x25)."))
                return
            end
        end
        DisplayTextToPlayer(triggerPlayer, __jreal(0), __jreal(0), "Failed to set feedrate")
        return
    end
    token2 = SetFeedFirstToken(rest)
    extra = SetFeedRestAfterFirstToken(rest)
    playerNameForError = token1
    if SetFeedIsUnsignedInteger(token1) then
        playerNumber = S2I(token1)
    else
        playerNumber = SetFeedColorToPlayerNumber(token1)
        if (playerNumber == 0) then
            twoWordColorNumber = SetFeedTwoWordColorToPlayerNumber(token1, token2)
            if (twoWordColorNumber > 0) then
                playerNumber = twoWordColorNumber
                playerNameForError = __jconcat(__jconcat(token1, " "), token2)
                token2 = SetFeedFirstToken(extra)
                extra = SetFeedRestAfterFirstToken(extra)
            elseif (((extra ~= "") and SetFeedIsUnsignedInteger(extra)) and (not SetFeedIsUnsignedInteger(token2))) then
                playerNameForError = __jconcat(__jconcat(token1, " "), token2)
                token2 = extra
                extra = ""
            end
        end
    end
    if (token2 == "") then
        DisplayTextToPlayer(triggerPlayer, __jreal(0), __jreal(0), "Error: Missing feedrate value.")
        return
    end
    if (extra ~= "") then
        DisplayTextToPlayer(triggerPlayer, __jreal(0), __jreal(0), "Error: Too many arguments for -setfeed.")
        return
    end
    if (not SetFeedIsUnsignedInteger(token2)) then
        if ((playerNumber == 0) and (not SetFeedIsUnsignedInteger(token1))) then
            DisplayTextToPlayer((triggerPlayer), __jreal(0), __jreal(0), __jconcat("Error: Cannot find player called ", (playerNameForError)))
            return
        end
        DisplayTextToPlayer(triggerPlayer, __jreal(0), __jreal(0), "Error: Feedrate must be a whole number from 50 to 200.")
        return
    end
    y = S2I(token2)
    if ((playerNumber == 0) and (not SetFeedIsUnsignedInteger(token1))) then
        DisplayTextToPlayer((triggerPlayer), __jreal(0), __jreal(0), __jconcat("Error: Cannot find player called ", (playerNameForError)))
        return
    end
    if ((y < 50) or (y > 200)) then
        DisplayTextToPlayer((triggerPlayer), __jreal(0), __jreal(0), __jconcat(__jconcat("Error: Feedrate ", (token2)), " is outside allowed range. Use 50 to 200."))
        return
    end
    if ((playerNumber < 1) or (playerNumber > 11)) then
        DisplayTextToPlayer(triggerPlayer, __jreal(0), __jreal(0), "Error: Player number must be between 1 and 11.")
        return
    end
    udg_ExperienceRate[__jint(playerNumber - 1)] = I2R(y)
    DisplayTextToPlayer(triggerPlayer, __jreal(0), __jreal(0), __jconcat(__jconcat(__jconcat(__jconcat("Feedrate of player ", I2S(playerNumber)), " is set to "), I2S(y)), "\x25"))
end
-- END FOREST SECTION 23

-- BEGIN FOREST SECTION 24 FeedReduction
-- Strong ownership lasts only through the current damage/death turn. A later
-- lethal event (including a revived unit) must read unscaled native values.
local bountyPending, bountyTimers = {}, {}

local function FR_BountyFields()
    return { UNIT_IF_GOLD_BOUNTY_AWARDED_BASE, UNIT_IF_GOLD_BOUNTY_AWARDED_NUMBER_OF_DICE,
        UNIT_IF_GOLD_BOUNTY_AWARDED_SIDES_PER_DIE }
end

function FR_RestoreGoldBounty()
    local timer = GetExpiredTimer()
    local state = bountyTimers[timer]
    if state then
        local target = state.target
        -- Do not overwrite a morph/upgrade or another system's intervening edits.
        if GetUnitTypeId(target) == state.type then
            for index, field in ipairs(FR_BountyFields()) do
                if BlzGetUnitIntegerField(target, field) == state.applied[index] then
                    BlzSetUnitIntegerField(target, field, state.original[index])
                end
            end
        end
        bountyPending[target] = nil
        bountyTimers[timer] = nil
    end
    FE_Timers.destroy(timer)
end

function FR_ScaledInt(value, percent)
    if ((value <= 0) or (percent <= __jreal(0.00))) then
        return 0
    end
    return R2I(__jreal(__jreal(__jreal(I2R(value) * percent) * __jreal(0.01)) + __jreal(0.50)))
end

function FR_ApplyGoldBountyRate(target, percent)
    if target == nil or GetUnitTypeId(target) == 0 then return end
    local state = bountyPending[target]
    local fresh = state == nil
    if fresh then
        state = { target=target, original={}, applied={}, timer=FE_Timers.create() }
        bountyPending[target], bountyTimers[state.timer] = state, state
    end
    local unitType = GetUnitTypeId(target)
    for index, field in ipairs(FR_BountyFields()) do
        local current = BlzGetUnitIntegerField(target, field)
        if state.type ~= unitType or current ~= state.applied[index] then
            state.original[index] = current
        end
        local value = 0
        if percent > __jreal(0.00) then
            value = index == 2 and state.original[index] or FR_ScaledInt(state.original[index], percent)
        end
        state.applied[index] = value
        BlzSetUnitIntegerField(target, field, value)
    end
    state.type = unitType
    if fresh then
        -- Native bounty uses the scaled fields in this death turn; restore on
        -- the next timer turn even if another lethal callback prevented death.
        TimerStart(state.timer, 0, false, FR_RestoreGoldBounty)
    end
end

function Trig_FeedReduction_Actions()
    local target = udg_DamageEventTarget
    local rate = udg_ExperienceRate[(__jint(GetConvertedPlayerId(GetOwningPlayer(target)) - 1))]
    SetPlayerHandicapXPBJ(FE_Roles.ancient(), rate)
    FR_ApplyGoldBountyRate(target, rate)
    target = nil
end

function InitTrig_FeedReduction()
    gg_trg_FeedReduction = CreateTrigger()
    h__TriggerRegisterVariableEvent(gg_trg_FeedReduction, "udg_LethalDamageEvent", EQUAL, __jreal(1.00))
    TriggerAddAction(gg_trg_FeedReduction, Trig_FeedReduction_Actions)
end
-- END FOREST SECTION 24

-- BEGIN FOREST SECTION 25 SetFeed
function Trig_SetFeed_Actions()
    HandleSetExp(GetTriggerPlayer(), GetEventPlayerChatString())
end

function InitTrig_SetFeed()
    gg_trg_SetFeed = CreateTrigger()
    TriggerRegisterPlayerChatEvent(gg_trg_SetFeed, Player(0), "-setfeed", false)
    TriggerAddAction(gg_trg_SetFeed, Trig_SetFeed_Actions)
end
-- END FOREST SECTION 25

-- BEGIN FOREST SECTION 26 CheckFeedRates
function Trig_CheckFeedRates_PlayerLabel(i)
    if (i == 0) then
        return "|cffff0303Player 1|r"
    elseif (i == 1) then
        return "|cff0042ffPlayer 2|r"
    elseif (i == 2) then
        return "|cff1ce6b9Player 3|r"
    elseif (i == 3) then
        return "|cff540081Player 4|r"
    elseif (i == 4) then
        return "|cfffffc01Player 5|r"
    elseif (i == 5) then
        return "|cffff8a0ePlayer 6|r"
    elseif (i == 6) then
        return "|cff20c000Player 7|r"
    elseif (i == 7) then
        return "|cffe55bb0Player 8|r"
    elseif (i == 8) then
        return "|cff959697Player 9|r"
    elseif (i == 9) then
        return "|cff7ebff1Player 10|r"
    elseif (i == 10) then
        return "|cff106246Player 11|r"
    end
    return __jconcat("Player ", I2S(__jint(i + 1)))
end

function Trig_CheckFeedRates_Actions()
    local i = 0
    local output = "|cffffcc00Current feed rates:|r"
    while true do
        if (i >= 11) then break end
        output = __jconcat(__jconcat(__jconcat(__jconcat(__jconcat(output, "\n"), Trig_CheckFeedRates_PlayerLabel(i)), ": |cffffffff"), I2S(R2I(__jreal(udg_ExperienceRate[i] + __jreal(0.50))))), "\x25|r")
        i = __jint(i + 1)
    end
    DisplayTextToPlayer(GetTriggerPlayer(), __jreal(0), __jreal(0), output)
end

function InitTrig_CheckFeedRates()
    local i = 0
    gg_trg_CheckFeedRates = CreateTrigger()
    while true do
        if (i >= 11) then break end
        TriggerRegisterPlayerChatEvent(gg_trg_CheckFeedRates, Player(i), "-feedrates", false)
        i = __jint(i + 1)
    end
    TriggerAddAction(gg_trg_CheckFeedRates, Trig_CheckFeedRates_Actions)
end
-- END FOREST SECTION 26
