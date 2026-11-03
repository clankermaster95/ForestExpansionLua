-- economy / feed
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 21 AutoFeedRate
-- Capture lobby identity before race selection adds colors/titles to names.
FE_FeedNames = {}
function FeedRate_Identity(p)
    return FE_FeedNames[GetPlayerId(p)] or GetPlayerName(p)
end

-- Original JASS function: FeedRate_DebugError (line 5419)
function FeedRate_DebugError(msg)
    DisplayTimedTextToForce(GetPlayersAll(), __jreal(20.00), __jconcat("|cffff0000[FeedRate Debug]|r ", msg))
end

-- Original JASS function: FeedRate_Clamp (line 5423)
function FeedRate_Clamp(rate)
    if (rate < 50) then
        do return 50 end
    end
    if (rate > 100) then
        do return 100 end
    end
    do return rate end
end

-- Original JASS function: FeedRate_FindChar (line 5435)
function FeedRate_FindChar(data, wanted)
    local i = 0
    local len = StringLength(data)
    while true do
        if (i >= len) then break end
        if (SubString(data, i, __jint(i + 1)) == wanted) then
            do return i end
        end
        i = __jint(i + 1)
    end
    do return __jint(-(1)) end
end

-- Original JASS function: FeedRate_ParseRate (line 5452)
function FeedRate_ParseRate(data)
    local digits = data:match("^%d+$") or data:match("^%d+:(%d+)$")
    local rate = digits and tonumber(digits)
    if not rate or rate <= 0 or rate > 100 then return 0 end
    return FeedRate_Clamp(rate)
end

-- Original JASS function: FeedRate_IsValidUser (line 5470)
function FeedRate_IsValidUser(p)
    do return ((GetPlayerController(p) == MAP_CONTROL_USER) and (GetPlayerSlotState(p) == PLAYER_SLOT_STATE_PLAYING)) end
end

-- Original JASS function: FeedRate_CountActiveUsers (line 5474)
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
    do return count end
end

-- Original JASS function: FeedRate_PlayerNameHasBattleTag (line 5491)
function FeedRate_PlayerNameHasBattleTag(p)
    do return (FeedRate_FindChar(FeedRate_Identity(p), "#") >= 0) end
end

-- Original JASS function: FeedRate_FindMatchingPlayerByName (line 5495)
function FeedRate_FindMatchingPlayerByName(playerName)
    local i = 0
    local p = nil
    while true do
        if (i >= FEEDRATE_MAX_PLAYERS) then break end
        p = Player(i)
        if (FeedRate_IsValidUser(p) and (FeedRate_Identity(p) == playerName)) then
            do return p end
        end
        i = __jint(i + 1)
    end
    do return nil end
end

-- Original JASS function: FeedRate_Apply (line 5514)
function FeedRate_Apply(p, rate)
    local pid = GetPlayerId(p)
    rate = FeedRate_Clamp(rate)
    FeedRate_Loaded[pid] = true
    udg_ExperienceRate[pid] = I2R(rate)
end

-- Original JASS function: FeedRate_SaveForPlayer (line 5522)
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

-- Original JASS function: FeedRate_SelectRate (line 5533)
function FeedRate_SelectRate(p, rate)
    FeedRate_Apply(p, rate)
    FeedRate_SaveForPlayer(p, rate)
    p = nil
end

-- Original JASS function: FeedRate_ClickYes (line 5540)
function FeedRate_ClickYes()
    FeedRate_SelectRate(GetTriggerPlayer(), 100)
end

-- Original JASS function: FeedRate_ClickOtherTag (line 5544)
function FeedRate_ClickOtherTag()
    FeedRate_SelectRate(GetTriggerPlayer(), 75)
end

-- Original JASS function: FeedRate_ClickNo (line 5548)
function FeedRate_ClickNo()
    FeedRate_SelectRate(GetTriggerPlayer(), 50)
end

-- Original JASS function: FeedRate_OnRateSync (line 5552)
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

-- Original JASS function: FeedRate_OnNameSync (line 5565)
function FeedRate_OnNameSync()
    local p = GetTriggerPlayer()
    local pid = GetPlayerId(p)
    FeedRate_PendingNameReceived[pid] = true
    FeedRate_PendingName[pid] = BlzGetTriggerSyncData()
    FeedRate_ProcessPendingLoadForPlayer(p)
    p = nil
end

-- Original JASS function: FeedRate_ProcessPendingLoadForPlayer (line 5575)
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

-- Original JASS function: FeedRate_ProcessPendingLoads (line 5621)
function FeedRate_ProcessPendingLoads()
    local t = GetExpiredTimer()
    local i = 0
    DestroyTimer(t)
    while true do
        if (i >= FEEDRATE_MAX_PLAYERS) then break end
        FeedRate_ProcessPendingLoadForPlayer(Player(i))
        i = __jint(i + 1)
    end
    t = nil
end

-- Original JASS function: FeedRate_TryLoadForPlayer (line 5638)
function FeedRate_TryLoadForPlayer(i)
    local p = Player(i)
    if FeedRate_IsValidUser(p) then
        if (GetLocalPlayer() == p) then
            Preloader(FEEDRATE_FILE_PATH)
        end
    end
    p = nil
end

-- Original JASS function: FeedRate_StartLoadAll (line 5650)
function FeedRate_StartLoadAll()
    local t = GetExpiredTimer()
    local i = 0
    DestroyTimer(t)
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

-- Original JASS function: FeedRate_ShowDialogsForMissingLoads (line 5673)
function FeedRate_ShowDialogsForMissingLoads()
    local t = GetExpiredTimer()
    local i = 0
    DestroyTimer(t)
    while true do
        if (i >= FEEDRATE_MAX_PLAYERS) then break end
        if (FeedRate_IsValidUser(Player(i)) and (not FeedRate_Loaded[i])) then
            DialogDisplayBJ(true, udg_StartupDialog, Player(i))
        end
        i = __jint(i + 1)
    end
    t = nil
end

-- Original JASS function: FeedRate_SetupDialog (line 5692)
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

-- Original JASS function: Trig_AutoFeedRate_Actions (line 5713)
function Trig_AutoFeedRate_Actions()
    local i = 0
    local loadTimer = CreateTimer()
    local processTimer = CreateTimer()
    local dialogTimer = CreateTimer()
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

-- Original JASS function: InitTrig_AutoFeedRate (line 5746)
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
-- Original JASS function: Trig_TimeToAncientSpawn_Copy_Actions (line 5754)
function Trig_TimeToAncientSpawn_Copy_Actions()
    DisableTrigger(gg_trg_SetFeed)
end

-- Original JASS function: InitTrig_TimeToAncientSpawn_Copy (line 5759)
function InitTrig_TimeToAncientSpawn_Copy()
    gg_trg_TimeToAncientSpawn_Copy = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_TimeToAncientSpawn_Copy, __jreal(60.00))
    TriggerAddAction(gg_trg_TimeToAncientSpawn_Copy, Trig_TimeToAncientSpawn_Copy_Actions)
end
-- END FOREST SECTION 22

-- BEGIN FOREST SECTION 23 HandleSetRate
-- Original JASS function: SetFeedIsDigit (line 5768)
function SetFeedIsDigit(char)
    local digits = "0123456789"
    local i = 0
    while true do
        if (i >= 10) then break end
        if (char == SubString(digits, i, __jint(i + 1))) then
            do return true end
        end
        i = __jint(i + 1)
    end
    do return false end
end

-- Original JASS function: SetFeedClampRate (line 5783)
function SetFeedClampRate(rate)
    if (rate < __jreal(50.00)) then
        do return __jreal(50.00) end
    end
    if (rate > __jreal(200.00)) then
        do return __jreal(200.00) end
    end
    do return rate end
end

-- Original JASS function: SetFeedErrorRateOutOfRange (line 5793)
function SetFeedErrorRateOutOfRange(whichPlayer, value)
    DisplayTextToPlayer(whichPlayer, __jreal(0), __jreal(0), __jconcat(__jconcat("Error: Feedrate ", value), " is outside allowed range. Use 50 to 200."))
end

-- Original JASS function: SetFeedErrorCannotFindPlayer (line 5797)
function SetFeedErrorCannotFindPlayer(whichPlayer, playerName)
    DisplayTextToPlayer(whichPlayer, __jreal(0), __jreal(0), __jconcat("Error: Cannot find player called ", playerName))
end

-- Original JASS function: SetFeedTrimLeft (line 5801)
function SetFeedTrimLeft(s)
    local i = 0
    local len = StringLength(s)
    while true do
        if ((i >= len) or (SubString(s, i, __jint(i + 1)) ~= " ")) then break end
        i = __jint(i + 1)
    end
    do return SubString(s, i, len) end
end

-- Original JASS function: SetFeedFirstToken (line 5813)
function SetFeedFirstToken(s)
    local i = 0
    local len = StringLength(s)
    while true do
        if ((i >= len) or (SubString(s, i, __jint(i + 1)) == " ")) then break end
        i = __jint(i + 1)
    end
    do return SubString(s, 0, i) end
end

-- Original JASS function: SetFeedRestAfterFirstToken (line 5825)
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
    do return SubString(s, i, len) end
end

-- Original JASS function: SetFeedIsUnsignedInteger (line 5842)
function SetFeedIsUnsignedInteger(s)
    local i = 0
    local len = StringLength(s)
    if (len <= 0) then
        do return false end
    end
    while true do
        if (i >= len) then break end
        if (not SetFeedIsDigit(SubString(s, i, __jint(i + 1)))) then
            do return false end
        end
        i = __jint(i + 1)
    end
    do return true end
end

-- Original JASS function: SetFeedIsUnsignedReal (line 5861)
function SetFeedIsUnsignedReal(s)
    local i = 0
    local len = StringLength(s)
    local dotCount = 0
    local digitCount = 0
    local c = nil
    if (len <= 0) then
        do return false end
    end
    while true do
        if (i >= len) then break end
        c = SubString(s, i, __jint(i + 1))
        if SetFeedIsDigit(c) then
            digitCount = __jint(digitCount + 1)
        elseif (c == ".") then
            dotCount = __jint(dotCount + 1)
            if (dotCount > 1) then
                do return false end
            end
        else
            do return false end
        end
        i = __jint(i + 1)
    end
    do return (digitCount > 0) end
end

-- Original JASS function: SetFeedPercentToMultiplierText (line 5893)
function SetFeedPercentToMultiplierText(percent)
    local whole = __jdiv(percent, 100)
    local frac = __jint(percent - __jint(whole * 100))
    if (frac == 0) then
        do return I2S(whole) end
    end
    if (ModuloInteger(frac, 10) == 0) then
        do return __jconcat(__jconcat(I2S(whole), "."), I2S(__jdiv(frac, 10))) end
    end
    if (frac < 10) then
        do return __jconcat(__jconcat(I2S(whole), ".0"), I2S(frac)) end
    end
    do return __jconcat(__jconcat(I2S(whole), "."), I2S(frac)) end
end

-- Original JASS function: SetFeedColorToPlayerNumber (line 5912)
function SetFeedColorToPlayerNumber(token)
    local c = StringCase(token, false)
    if (c == "red") then
        do return 1 end
    end
    if (c == "blue") then
        do return 2 end
    end
    if (c == "teal") then
        do return 3 end
    end
    if (c == "purple") then
        do return 4 end
    end
    if (c == "yellow") then
        do return 5 end
    end
    if (c == "orange") then
        do return 6 end
    end
    if (c == "green") then
        do return 7 end
    end
    if (c == "pink") then
        do return 8 end
    end
    if ((c == "gray") or (c == "grey")) then
        do return 9 end
    end
    if (((c == "lightblue") or (c == "light-blue")) or (c == "light_blue")) then
        do return 10 end
    end
    if (((c == "darkgreen") or (c == "dark-green")) or (c == "dark_green")) then
        do return 11 end
    end
    do return 0 end
end

-- Original JASS function: SetFeedTwoWordColorToPlayerNumber (line 5952)
function SetFeedTwoWordColorToPlayerNumber(token1, token2)
    local c1 = StringCase(token1, false)
    local c2 = StringCase(token2, false)
    if ((c1 == "light") and (c2 == "blue")) then
        do return 10 end
    end
    if ((c1 == "dark") and (c2 == "green")) then
        do return 11 end
    end
    do return 0 end
end

-- Original JASS function: SetFeedSetAll (line 5967)
function SetFeedSetAll(rate)
    local i = 0
    while true do
        if (i >= 11) then break end
        udg_ExperienceRate[i] = I2R(rate)
        i = __jint(i + 1)
    end
end

-- Original JASS function: HandleSetExp (line 5977)
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
        do return end
    end
    if (((rest == "") and (StringLength(token1) > 1)) and (SubString(token1, 0, 1) == "x")) then
        multText = SubString(token1, 1, StringLength(token1))
        if (not SetFeedIsUnsignedReal(multText)) then
            DisplayTextToPlayer(triggerPlayer, __jreal(0), __jreal(0), "Failed to set feedrate")
            do return end
        end
        multiplier = S2R(multText)
        if (multiplier <= __jreal(0.00)) then
            DisplayTextToPlayer(triggerPlayer, __jreal(0), __jreal(0), "Failed to set feedrate")
            do return end
        end
        if (((multiplier >= __jreal(50.00)) and (multiplier <= __jreal(200.00))) and (multiplier == I2R(R2I(multiplier)))) then
            suggestedPercent = R2I(multiplier)
            DisplayTextToPlayer(triggerPlayer, __jreal(0), __jreal(0), __jconcat(__jconcat(__jconcat(__jconcat(__jconcat(__jconcat(__jconcat(__jconcat("Error: Did you mean -setfeed x", SetFeedPercentToMultiplierText(suggestedPercent)), "? (multiplies every feedrate by "), SetFeedPercentToMultiplierText(suggestedPercent)), ") or did you mean to do -setfeed "), I2S(suggestedPercent)), " (sets everyone's feedrate to "), I2S(suggestedPercent)), "%)"))
            do return end
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
        DisplayTextToPlayer(triggerPlayer, __jreal(0), __jreal(0), __jconcat(__jconcat("Every feedrate was multiplied by ", multText), ". Final values are limited to 50%-200%."))
        do return end
    end
    if (rest == "") then
        if SetFeedIsUnsignedInteger(token1) then
            y = S2I(token1)
            if ((y < 50) or (y > 200)) then
                DisplayTextToPlayer((triggerPlayer), __jreal(0), __jreal(0), __jconcat(__jconcat("Error: Feedrate ", (token1)), " is outside allowed range. Use 50 to 200."))
                do return end
            end
            SetFeedSetAll(y)
            DisplayTextToPlayer(triggerPlayer, __jreal(0), __jreal(0), __jconcat(__jconcat("Feedrate of every player is set to ", I2S(y)), "%"))
            do return end
        end
        if SetFeedIsUnsignedReal(token1) then
            singleReal = S2R(token1)
            if ((singleReal >= __jreal(0.50)) and (singleReal <= __jreal(2.00))) then
                suggestedPercent = R2I(__jreal(__jreal(singleReal * __jreal(100.00)) + __jreal(0.50)))
                DisplayTextToPlayer(triggerPlayer, __jreal(0), __jreal(0), __jconcat(__jconcat(__jconcat(__jconcat(__jconcat(__jconcat(__jconcat(__jconcat("Error: Did you mean -setfeed x", token1), "? (multiplies every feedrate by "), token1), ") or did you mean to -setfeed "), I2S(suggestedPercent)), " (sets everyone's feedrate to "), I2S(suggestedPercent)), "%)."))
                do return end
            end
        end
        DisplayTextToPlayer(triggerPlayer, __jreal(0), __jreal(0), "Failed to set feedrate")
        do return end
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
        do return end
    end
    if (extra ~= "") then
        DisplayTextToPlayer(triggerPlayer, __jreal(0), __jreal(0), "Error: Too many arguments for -setfeed.")
        do return end
    end
    if (not SetFeedIsUnsignedInteger(token2)) then
        if ((playerNumber == 0) and (not SetFeedIsUnsignedInteger(token1))) then
            DisplayTextToPlayer((triggerPlayer), __jreal(0), __jreal(0), __jconcat("Error: Cannot find player called ", (playerNameForError)))
            do return end
        end
        DisplayTextToPlayer(triggerPlayer, __jreal(0), __jreal(0), "Error: Feedrate must be a whole number from 50 to 200.")
        do return end
    end
    y = S2I(token2)
    if ((playerNumber == 0) and (not SetFeedIsUnsignedInteger(token1))) then
        DisplayTextToPlayer((triggerPlayer), __jreal(0), __jreal(0), __jconcat("Error: Cannot find player called ", (playerNameForError)))
        do return end
    end
    if ((y < 50) or (y > 200)) then
        DisplayTextToPlayer((triggerPlayer), __jreal(0), __jreal(0), __jconcat(__jconcat("Error: Feedrate ", (token2)), " is outside allowed range. Use 50 to 200."))
        do return end
    end
    if ((playerNumber < 1) or (playerNumber > 11)) then
        DisplayTextToPlayer(triggerPlayer, __jreal(0), __jreal(0), "Error: Player number must be between 1 and 11.")
        do return end
    end
    udg_ExperienceRate[__jint(playerNumber - 1)] = I2R(y)
    DisplayTextToPlayer(triggerPlayer, __jreal(0), __jreal(0), __jconcat(__jconcat(__jconcat(__jconcat("Feedrate of player ", I2S(playerNumber)), " is set to "), I2S(y)), "%"))
end
-- END FOREST SECTION 23

-- BEGIN FOREST SECTION 24 FeedReduction
-- Original JASS function: FR_ScaledInt (line 6131)
function FR_ScaledInt(value, percent)
    if ((value <= 0) or (percent <= __jreal(0.00))) then
        do return 0 end
    end
    do return R2I(__jreal(__jreal(__jreal(I2R(value) * percent) * __jreal(0.01)) + __jreal(0.50))) end
end

-- Original JASS function: FR_ApplyGoldBountyRate (line 6138)
function FR_ApplyGoldBountyRate(target, percent)
    local base = BlzGetUnitIntegerField(target, UNIT_IF_GOLD_BOUNTY_AWARDED_BASE)
    local dice = BlzGetUnitIntegerField(target, UNIT_IF_GOLD_BOUNTY_AWARDED_NUMBER_OF_DICE)
    local sides = BlzGetUnitIntegerField(target, UNIT_IF_GOLD_BOUNTY_AWARDED_SIDES_PER_DIE)
    local newBase = FR_ScaledInt(base, percent)
    local newSides = FR_ScaledInt(sides, percent)
    if (percent <= __jreal(0.00)) then
        BlzSetUnitIntegerField(target, UNIT_IF_GOLD_BOUNTY_AWARDED_BASE, 0)
        BlzSetUnitIntegerField(target, UNIT_IF_GOLD_BOUNTY_AWARDED_NUMBER_OF_DICE, 0)
        BlzSetUnitIntegerField(target, UNIT_IF_GOLD_BOUNTY_AWARDED_SIDES_PER_DIE, 0)
    else
        BlzSetUnitIntegerField(target, UNIT_IF_GOLD_BOUNTY_AWARDED_BASE, newBase)
        BlzSetUnitIntegerField(target, UNIT_IF_GOLD_BOUNTY_AWARDED_NUMBER_OF_DICE, dice)
        BlzSetUnitIntegerField(target, UNIT_IF_GOLD_BOUNTY_AWARDED_SIDES_PER_DIE, newSides)
    end
end

-- Original JASS function: Trig_FeedReduction_Actions (line 6156)
function Trig_FeedReduction_Actions()
    local target = udg_DamageEventTarget
    local rate = udg_ExperienceRate[(__jint(GetConvertedPlayerId(GetOwningPlayer(target)) - 1))]
    SetPlayerHandicapXPBJ(FE_Roles.ancient(), rate)
    FR_ApplyGoldBountyRate(target, rate)
    target = nil
end

-- Original JASS function: InitTrig_FeedReduction (line 6167)
function InitTrig_FeedReduction()
    gg_trg_FeedReduction = CreateTrigger()
    h__TriggerRegisterVariableEvent(gg_trg_FeedReduction, "udg_LethalDamageEvent", EQUAL, __jreal(1.00))
    TriggerAddAction(gg_trg_FeedReduction, Trig_FeedReduction_Actions)
end
-- END FOREST SECTION 24

-- BEGIN FOREST SECTION 25 SetFeed
-- Original JASS function: Trig_SetFeed_Actions (line 6175)
function Trig_SetFeed_Actions()
    HandleSetExp(GetTriggerPlayer(), GetEventPlayerChatString())
end

-- Original JASS function: InitTrig_SetFeed (line 6180)
function InitTrig_SetFeed()
    gg_trg_SetFeed = CreateTrigger()
    TriggerRegisterPlayerChatEvent(gg_trg_SetFeed, Player(0), "-setfeed", false)
    TriggerAddAction(gg_trg_SetFeed, Trig_SetFeed_Actions)
end
-- END FOREST SECTION 25

-- BEGIN FOREST SECTION 26 CheckFeedRates
-- Original JASS function: Trig_CheckFeedRates_PlayerLabel (line 6189)
function Trig_CheckFeedRates_PlayerLabel(i)
    if (i == 0) then
        do return "|cffff0303Player 1|r" end
    elseif (i == 1) then
        do return "|cff0042ffPlayer 2|r" end
    elseif (i == 2) then
        do return "|cff1ce6b9Player 3|r" end
    elseif (i == 3) then
        do return "|cff540081Player 4|r" end
    elseif (i == 4) then
        do return "|cfffffc01Player 5|r" end
    elseif (i == 5) then
        do return "|cffff8a0ePlayer 6|r" end
    elseif (i == 6) then
        do return "|cff20c000Player 7|r" end
    elseif (i == 7) then
        do return "|cffe55bb0Player 8|r" end
    elseif (i == 8) then
        do return "|cff959697Player 9|r" end
    elseif (i == 9) then
        do return "|cff7ebff1Player 10|r" end
    elseif (i == 10) then
        do return "|cff106246Player 11|r" end
    end
    do return __jconcat("Player ", I2S(__jint(i + 1))) end
end

-- Original JASS function: Trig_CheckFeedRates_Actions (line 6217)
function Trig_CheckFeedRates_Actions()
    local i = 0
    local output = "|cffffcc00Current feed rates:|r"
    while true do
        if (i >= 11) then break end
        output = __jconcat(__jconcat(__jconcat(__jconcat(__jconcat(output, "\n"), Trig_CheckFeedRates_PlayerLabel(i)), ": |cffffffff"), I2S(R2I(__jreal(udg_ExperienceRate[i] + __jreal(0.50))))), "%|r")
        i = __jint(i + 1)
    end
    DisplayTextToPlayer(GetTriggerPlayer(), __jreal(0), __jreal(0), output)
end

-- Original JASS function: InitTrig_CheckFeedRates (line 6231)
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
