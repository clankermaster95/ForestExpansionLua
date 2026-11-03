-- commands / player
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 17 Hardmode
-- Original JASS function: Hardmode_GiveResources (line 5240)
function Hardmode_GiveResources()
    local i = 0
    local p = nil
    if (FE_Roles.ancient() == nil) then
        do return end
    end
    while true do
        if (i >= bj_MAX_PLAYERS) then break end
        p = Player(i)
        if ((GetPlayerSlotState(p) == PLAYER_SLOT_STATE_PLAYING) and IsPlayerEnemy(p, FE_Roles.ancient())) then
            SetPlayerState(p, PLAYER_STATE_RESOURCE_GOLD, __jint(GetPlayerState(p, PLAYER_STATE_RESOURCE_GOLD) + 1))
            SetPlayerState(p, PLAYER_STATE_RESOURCE_LUMBER, __jint(GetPlayerState(p, PLAYER_STATE_RESOURCE_LUMBER) + 50))
        end
        i = __jint(i + 1)
    end
    p = nil
end

-- Original JASS function: Hardmode_PlayActivationIndicator (line 5263)
function Hardmode_PlayActivationIndicator()
    DisplayTimedTextToPlayer(GetLocalPlayer(), __jreal(0.00), __jreal(0.00), __jreal(10.00), "|cffffcc00Ancient activated hardmode.|r Expanders will now receive extra |cff80ff8050 lumber|r and |cffffff001 gold|r every 6 seconds after ancient spawn.")
    if (udg_HardmodeSound ~= nil) then
        SetSoundVolume(udg_HardmodeSound, 127)
        StartSound(udg_HardmodeSound)
    end
end

-- Original JASS function: Hardmode_Start (line 5272)
function Hardmode_Start()
    local t = GetExpiredTimer()
    udg_HardmodeCanBeEnabled = false
    PauseTimer(t)
    DestroyTimer(t)
    if udg_HardmodeEnabled then
        Hardmode_GiveResources()
        udg_HardmodePeriodicTimer = CreateTimer()
        TimerStart(udg_HardmodePeriodicTimer, __jreal(6.00), true, Hardmode_GiveResources)
    end
    t = nil
end

-- Original JASS function: Hardmode_Chat (line 5290)
function Hardmode_Chat()
    if (udg_HardmodeCanBeEnabled and (GetTriggerPlayer() == FE_Roles.ancient())) then
        if (not udg_HardmodeEnabled) then
            udg_HardmodeEnabled = true
            Hardmode_PlayActivationIndicator()
        end
    end
end

-- Original JASS function: InitTrig_Hardmode (line 5299)
function InitTrig_Hardmode()
    local i = 0
    local t = CreateTrigger()
    local tm = CreateTimer()
    while true do
        if (i >= bj_MAX_PLAYERS) then break end
        TriggerRegisterPlayerChatEvent(t, Player(i), "-hardmode", true)
        i = __jint(i + 1)
    end
    TriggerAddAction(t, Hardmode_Chat)
    udg_HardmodeSound = CreateSound(HARDMODE_SOUND_PATH, false, false, false, 10, 10, "HeroAcksEAX")
    SetSoundVolume(udg_HardmodeSound, 127)
    TimerStart(tm, __jreal(60.00), false, Hardmode_Start)
    t = nil
    tm = nil
end
-- END FOREST SECTION 17

-- BEGIN FOREST SECTION 205 AncientSpells
-- Original JASS function: Ancient_ReplaceAll (line 12991)
function Ancient_ReplaceAll(source, findText, replaceText)
    local result = ""
    local sourceLength = 0
    local findLength = 0
    local i = 0
    if (source == nil) then
        do return "" end
    end
    sourceLength = StringLength(source)
    findLength = StringLength(findText)
    if (findLength <= 0) then
        do return source end
    end
    while true do
        if (i >= sourceLength) then break end
        if ((__jint(i + findLength) <= sourceLength) and (SubString(source, i, __jint(i + findLength)) == findText)) then
            result = __jconcat(result, replaceText)
            i = __jint(i + findLength)
        else
            result = __jconcat(result, SubString(source, i, __jint(i + 1)))
            i = __jint(i + 1)
        end
    end
    do return result end
end

-- Original JASS function: Ancient_CollapseSpaces (line 13023)
function Ancient_CollapseSpaces(source)
    local result = ""
    local length = 0
    local i = 0
    local c = nil
    local lastWasSpace = false
    if (source == nil) then
        do return "" end
    end
    length = StringLength(source)
    while true do
        if (i >= length) then break end
        c = SubString(source, i, __jint(i + 1))
        if (c == " ") then
            if (not lastWasSpace) then
                result = __jconcat(result, c)
            end
            lastWasSpace = true
        else
            result = __jconcat(result, c)
            lastWasSpace = false
        end
        i = __jint(i + 1)
    end
    do return result end
end

-- Original JASS function: Ancient_IsHexChar (line 13057)
function Ancient_IsHexChar(c)
    do return ((((((((((((((((((((((c == "0") or (c == "1")) or (c == "2")) or (c == "3")) or (c == "4")) or (c == "5")) or (c == "6")) or (c == "7")) or (c == "8")) or (c == "9")) or (c == "a")) or (c == "b")) or (c == "c")) or (c == "d")) or (c == "e")) or (c == "f")) or (c == "A")) or (c == "B")) or (c == "C")) or (c == "D")) or (c == "E")) or (c == "F")) end
end

-- Original JASS function: Ancient_RemoveColorCodes (line 13061)
function Ancient_RemoveColorCodes(source)
    local result = ""
    local length = 0
    local i = 0
    local c = nil
    if (source == nil) then
        do return "" end
    end
    length = StringLength(source)
    while true do
        if (i >= length) then break end
        c = SubString(source, i, __jint(i + 1))
        if (((((((((((__jint(i + 10) <= length) and (c == "|")) and (SubString(source, __jint(i + 1), __jint(i + 2)) == "c")) and Ancient_IsHexChar(SubString(source, __jint(i + 2), __jint(i + 3)))) and Ancient_IsHexChar(SubString(source, __jint(i + 3), __jint(i + 4)))) and Ancient_IsHexChar(SubString(source, __jint(i + 4), __jint(i + 5)))) and Ancient_IsHexChar(SubString(source, __jint(i + 5), __jint(i + 6)))) and Ancient_IsHexChar(SubString(source, __jint(i + 6), __jint(i + 7)))) and Ancient_IsHexChar(SubString(source, __jint(i + 7), __jint(i + 8)))) and Ancient_IsHexChar(SubString(source, __jint(i + 8), __jint(i + 9)))) and Ancient_IsHexChar(SubString(source, __jint(i + 9), __jint(i + 10)))) then
            i = __jint(i + 10)
        elseif (((((((((((__jint(i + 10) <= length) and (c == "|")) and (SubString(source, __jint(i + 1), __jint(i + 2)) == "C")) and Ancient_IsHexChar(SubString(source, __jint(i + 2), __jint(i + 3)))) and Ancient_IsHexChar(SubString(source, __jint(i + 3), __jint(i + 4)))) and Ancient_IsHexChar(SubString(source, __jint(i + 4), __jint(i + 5)))) and Ancient_IsHexChar(SubString(source, __jint(i + 5), __jint(i + 6)))) and Ancient_IsHexChar(SubString(source, __jint(i + 6), __jint(i + 7)))) and Ancient_IsHexChar(SubString(source, __jint(i + 7), __jint(i + 8)))) and Ancient_IsHexChar(SubString(source, __jint(i + 8), __jint(i + 9)))) and Ancient_IsHexChar(SubString(source, __jint(i + 9), __jint(i + 10)))) then
            i = __jint(i + 10)
        elseif (((__jint(i + 2) <= length) and (c == "|")) and (SubString(source, __jint(i + 1), __jint(i + 2)) == "r")) then
            i = __jint(i + 2)
        elseif (((__jint(i + 2) <= length) and (c == "|")) and (SubString(source, __jint(i + 1), __jint(i + 2)) == "R")) then
            i = __jint(i + 2)
        else
            result = __jconcat(result, c)
            i = __jint(i + 1)
        end
    end
    do return result end
end

-- Original JASS function: Ancient_RemoveSquareBracketBlocks (line 13095)
function Ancient_RemoveSquareBracketBlocks(source)
    local result = ""
    local length = 0
    local i = 0
    local c = nil
    local insideBracket = false
    if (source == nil) then
        do return "" end
    end
    length = StringLength(source)
    while true do
        if (i >= length) then break end
        c = SubString(source, i, __jint(i + 1))
        if (c == "[") then
            insideBracket = true
        elseif (c == "]") then
            insideBracket = false
        elseif (not insideBracket) then
            result = __jconcat(result, c)
        end
        i = __jint(i + 1)
    end
    do return Ancient_CollapseSpaces(result) end
end

-- Original JASS function: Ancient_CleanTrailingSeparators (line 13127)
function Ancient_CleanTrailingSeparators(source)
    local length = 0
    if (source == nil) then
        do return "" end
    end
    source = Ancient_CollapseSpaces(source)
    length = StringLength(source)
    while true do
        if (length <= 0) then break end
        if (SubString(source, __jint(length - 1), length) == " ") then
            source = SubString(source, 0, __jint(length - 1))
        elseif (SubString(source, __jint(length - 1), length) == "-") then
            source = SubString(source, 0, __jint(length - 1))
        elseif (SubString(source, __jint(length - 1), length) == ":") then
            source = SubString(source, 0, __jint(length - 1))
        else
            do return source end
        end
        source = Ancient_CollapseSpaces(source)
        length = StringLength(source)
    end
    do return source end
end

-- Original JASS function: Ancient_FormatTooltipText (line 13157)
function Ancient_FormatTooltipText(text, level)
    if (text == nil) then
        do return "" end
    end
    text = Ancient_ReplaceAll(text, "|n", " ")
    text = Ancient_ReplaceAll(text, "|N", " ")
    text = Ancient_ReplaceAll(text, "\n", " ")
    text = Ancient_ReplaceAll(text, "/n", " ")
    text = Ancient_ReplaceAll(text, "/N", " ")
    text = Ancient_ReplaceAll(text, "%d", I2S(level))
    text = Ancient_CollapseSpaces(text)
    do return text end
end

-- Original JASS function: Ancient_ClearMessagesForPlayer (line 13173)
function Ancient_ClearMessagesForPlayer(p)
    if (GetLocalPlayer() == p) then
        ClearTextMessages()
    end
end

-- Original JASS function: Ancient_IsCommand (line 13179)
function Ancient_IsCommand(chat)
    local s = StringCase(chat, false)
    local len = StringLength(s)
    if (len < 8) then
        do return false end
    end
    if (SubString(s, 0, 8) ~= "-ancient") then
        do return false end
    end
    if (len == 8) then
        do return true end
    end
    do return (SubString(s, 8, 9) == " ") end
end

-- Original JASS function: Ancient_GetArgumentText (line 13198)
function Ancient_GetArgumentText(chat)
    local len = StringLength(chat)
    local i = 8
    while true do
        if ((i >= len) or (SubString(chat, i, __jint(i + 1)) ~= " ")) then break end
        i = __jint(i + 1)
    end
    if (i >= len) then
        do return "" end
    end
    do return SubString(chat, i, len) end
end

-- Original JASS function: Ancient_GetFirstWord (line 13214)
function Ancient_GetFirstWord(text)
    local len = StringLength(text)
    local i = 0
    local start = 0
    while true do
        if ((i >= len) or (SubString(text, i, __jint(i + 1)) ~= " ")) then break end
        i = __jint(i + 1)
    end
    start = i
    while true do
        if ((i >= len) or (SubString(text, i, __jint(i + 1)) == " ")) then break end
        i = __jint(i + 1)
    end
    if (start >= len) then
        do return "" end
    end
    do return SubString(text, start, i) end
end

-- Original JASS function: Ancient_GetTextAfterFirstWord (line 13238)
function Ancient_GetTextAfterFirstWord(text)
    local len = StringLength(text)
    local i = 0
    while true do
        if ((i >= len) or (SubString(text, i, __jint(i + 1)) ~= " ")) then break end
        i = __jint(i + 1)
    end
    while true do
        if ((i >= len) or (SubString(text, i, __jint(i + 1)) == " ")) then break end
        i = __jint(i + 1)
    end
    while true do
        if ((i >= len) or (SubString(text, i, __jint(i + 1)) ~= " ")) then break end
        i = __jint(i + 1)
    end
    if (i >= len) then
        do return "" end
    end
    do return SubString(text, i, len) end
end

-- Original JASS function: Ancient_GetUnitTypeIdByKeyword (line 13264)
function Ancient_GetUnitTypeIdByKeyword(keyword)
    if ((keyword == "darkness") or (keyword == "paranoia")) then
        do return FourCC("O00A") end
    elseif ((((keyword == "dragon") or (keyword == "dragons")) or (keyword == "dragos")) or (keyword == "drago")) then
        do return FourCC("O00S") end
    elseif ((keyword == "earth") or (keyword == "tremor")) then
        do return FourCC("O00L") end
    elseif ((keyword == "fire") or (keyword == "ignite")) then
        do return FourCC("O004") end
    elseif (((keyword == "ice") or (keyword == "avalanche")) or (keyword == "avalanch")) then
        do return FourCC("O008") end
    elseif ((keyword == "light") or (keyword == "divinity")) then
        do return FourCC("O01V") end
    elseif (((keyword == "lightning") or (keyword == "lighting")) or (keyword == "zalxon")) then
        do return FourCC("O016") end
    elseif ((keyword == "nature") or (keyword == "eternity")) then
        do return FourCC("O00D") end
    elseif (((keyword == "sand") or (keyword == "pharaoh")) or (keyword == "pharaon")) then
        do return FourCC("O01X") end
    elseif ((keyword == "space") or (keyword == "nebula")) then
        do return FourCC("O01Z") end
    elseif (((((keyword == "wind") or (keyword == "wispari")) or (keyword == "whispari")) or (keyword == "whisperi")) or (keyword == "wisperi")) then
        do return FourCC("O01D") end
    end
    do return 0 end
end

-- Original JASS function: Ancient_GetUnitTypeDisplayName (line 13292)
function Ancient_GetUnitTypeDisplayName(unitTypeId)
    if (unitTypeId == FourCC("O00A")) then
        do return "Darkness / Paranoia" end
    elseif (unitTypeId == FourCC("O00S")) then
        do return "Dragon" end
    elseif (unitTypeId == FourCC("O00L")) then
        do return "Earth / Tremor" end
    elseif (unitTypeId == FourCC("O004")) then
        do return "Fire / Ignite" end
    elseif (unitTypeId == FourCC("O008")) then
        do return "Ice / Avalanche" end
    elseif (unitTypeId == FourCC("O01V")) then
        do return "Light / Divinity" end
    elseif (unitTypeId == FourCC("O016")) then
        do return "Lightning / Zalxon" end
    elseif (unitTypeId == FourCC("O00D")) then
        do return "Nature / Eternity" end
    elseif (unitTypeId == FourCC("O01X")) then
        do return "Sand / Pharaoh" end
    elseif (unitTypeId == FourCC("O01Z")) then
        do return "Space / Nebula" end
    elseif (unitTypeId == FourCC("O01D")) then
        do return "Wind / Wispari" end
    end
    do return "Unknown Ancient" end
end

-- Original JASS function: Ancient_ParsePageFromArgument (line 13320)
function Ancient_ParsePageFromArgument(argument)
    local lowerArgument = StringCase(argument, false)
    local firstWord = Ancient_GetFirstWord(lowerArgument)
    local rest = nil
    local page = 0
    if (Ancient_GetUnitTypeIdByKeyword(firstWord) ~= 0) then
        rest = Ancient_GetTextAfterFirstWord(lowerArgument)
        page = S2I(Ancient_GetFirstWord(rest))
    else
        page = S2I(firstWord)
    end
    if (page < 1) then
        page = 1
    end
    do return page end
end

-- Original JASS function: Ancient_ShowPreviewUsage (line 13340)
function Ancient_ShowPreviewUsage(p)
    Ancient_ClearMessagesForPlayer(p)
    DisplayTimedTextToPlayer(p, __jreal(0.00), __jreal(0.00), __jreal(20.00), "|cffffcc00Ancient preview:|r |cffffffffUse |r|cffffcc00-ancient darkness|r|cffffffff, |r|cffffcc00-ancient dragon|r|cffffffff, |r|cffffcc00-ancient earth|r|cffffffff, |r|cffffcc00-ancient fire|r|cffffffff, |r|cffffcc00-ancient ice|r|cffffffff, |r|cffffcc00-ancient light|r|cffffffff, |r|cffffcc00-ancient lightning|r|cffffffff, |r|cffffcc00-ancient nature|r|cffffffff, |r|cffffcc00-ancient sand|r|cffffffff, |r|cffffcc00-ancient space|r|cffffffff, or |r|cffffcc00-ancient wind|r|cffffffff. Add page number after the name if needed, for example |r|cffffcc00-ancient darkness 2|r|cffffffff.|r")
end

-- Original JASS function: Ancient_GetAbilityCount (line 13345)
function Ancient_GetAbilityCount(unitTypeId)
    if (unitTypeId == FourCC("O016")) then
        do return 6 end
    end
    if (unitTypeId == FourCC("O00A")) then
        do return 5 end
    elseif (unitTypeId == FourCC("O00S")) then
        do return 5 end
    elseif (unitTypeId == FourCC("O00L")) then
        do return 5 end
    elseif (unitTypeId == FourCC("O004")) then
        do return 5 end
    elseif (unitTypeId == FourCC("O008")) then
        do return 5 end
    elseif (unitTypeId == FourCC("O01V")) then
        do return 5 end
    elseif (unitTypeId == FourCC("O00D")) then
        do return 5 end
    elseif (unitTypeId == FourCC("O01X")) then
        do return 5 end
    elseif (unitTypeId == FourCC("O01Z")) then
        do return 5 end
    elseif (unitTypeId == FourCC("O01D")) then
        do return 5 end
    end
    do return 0 end
end

-- Original JASS function: Ancient_GetAbilityIdByIndex (line 13375)
function Ancient_GetAbilityIdByIndex(unitTypeId, index)
    if (unitTypeId == FourCC("O00A")) then
        if (index == 1) then
            do return FourCC("A0E9") end
        elseif (index == 2) then
            do return FourCC("A05F") end
        elseif (index == 3) then
            do return FourCC("A058") end
        elseif (index == 4) then
            do return FourCC("A05C") end
        elseif (index == 5) then
            do return FourCC("A05E") end
        end
    elseif (unitTypeId == FourCC("O00S")) then
        if (index == 1) then
            do return FourCC("A02B") end
        elseif (index == 2) then
            do return FourCC("A06P") end
        elseif (index == 3) then
            do return FourCC("A02A") end
        elseif (index == 4) then
            do return FourCC("A01J") end
        elseif (index == 5) then
            do return FourCC("A02D") end
        end
    elseif (unitTypeId == FourCC("O00L")) then
        if (index == 1) then
            do return FourCC("A06D") end
        elseif (index == 2) then
            do return FourCC("A088") end
        elseif (index == 3) then
            do return FourCC("A05Q") end
        elseif (index == 4) then
            do return FourCC("A01T") end
        elseif (index == 5) then
            do return FourCC("A06F") end
        end
    elseif (unitTypeId == FourCC("O004")) then
        if (index == 1) then
            do return FourCC("A002") end
        elseif (index == 2) then
            do return FourCC("A000") end
        elseif (index == 3) then
            do return FourCC("A07A") end
        elseif (index == 4) then
            do return FourCC("A003") end
        elseif (index == 5) then
            do return FourCC("A004") end
        end
    elseif (unitTypeId == FourCC("O008")) then
        if (index == 1) then
            do return FourCC("A008") end
        elseif (index == 2) then
            do return FourCC("A0EX") end
        elseif (index == 3) then
            do return FourCC("A074") end
        elseif (index == 4) then
            do return FourCC("A00A") end
        elseif (index == 5) then
            do return FourCC("A075") end
        end
    elseif (unitTypeId == FourCC("O01V")) then
        if (index == 1) then
            do return FourCC("A06X") end
        elseif (index == 2) then
            do return FourCC("A06W") end
        elseif (index == 3) then
            do return FourCC("A06V") end
        elseif (index == 4) then
            do return FourCC("A06U") end
        elseif (index == 5) then
            do return FourCC("A06Y") end
        end
    elseif (unitTypeId == FourCC("O016")) then
        if (index == 1) then
            do return FourCC("A03U") end
        elseif (index == 2) then
            do return FourCC("A09L") end
        elseif (index == 3) then
            do return FourCC("A03R") end
        elseif (index == 4) then
            do return FourCC("A07B") end
        elseif (index == 5) then
            do return FourCC("A03S") end
        elseif (index == 6) then
            do return FourCC("A03T") end
        end
    elseif (unitTypeId == FourCC("O00D")) then
        if (index == 1) then
            do return FourCC("A01M") end
        elseif (index == 2) then
            do return FourCC("A012") end
        elseif (index == 3) then
            do return FourCC("A070") end
        elseif (index == 4) then
            do return FourCC("A06Z") end
        elseif (index == 5) then
            do return FourCC("A013") end
        end
    elseif (unitTypeId == FourCC("O01X")) then
        if (index == 1) then
            do return FourCC("A07Y") end
        elseif (index == 2) then
            do return FourCC("A07X") end
        elseif (index == 3) then
            do return FourCC("A07Z") end
        elseif (index == 4) then
            do return FourCC("A080") end
        elseif (index == 5) then
            do return FourCC("A082") end
        end
    elseif (unitTypeId == FourCC("O01Z")) then
        if (index == 1) then
            do return FourCC("A08R") end
        elseif (index == 2) then
            do return FourCC("A08I") end
        elseif (index == 3) then
            do return FourCC("A08K") end
        elseif (index == 4) then
            do return FourCC("A0F1") end
        elseif (index == 5) then
            do return FourCC("A08S") end
        end
    elseif (unitTypeId == FourCC("O01D")) then
        if (index == 1) then
            do return FourCC("A0EL") end
        elseif (index == 2) then
            do return FourCC("A0EO") end
        elseif (index == 3) then
            do return FourCC("A0EP") end
        elseif (index == 4) then
            do return FourCC("A0ES") end
        elseif (index == 5) then
            do return FourCC("A048") end
        end
    end
    do return 0 end
end

-- Original JASS function: Ancient_GetSingleAbilityLine (line 13515)
function Ancient_GetSingleAbilityLine(ancient, abilityId)
    local abilityLevel = 1
    local tooltipIndex = 0
    local abilityName = nil
    local abilityDescription = nil
    if (ancient ~= nil) then
        abilityLevel = GetUnitAbilityLevel(ancient, abilityId)
    end
    if (abilityLevel <= 0) then
        abilityLevel = 1
    end
    tooltipIndex = __jint(abilityLevel - 1)
    abilityName = Ancient_FormatTooltipText(BlzGetAbilityResearchTooltip(abilityId, tooltipIndex), abilityLevel)
    abilityName = Ancient_RemoveColorCodes(abilityName)
    abilityName = Ancient_RemoveSquareBracketBlocks(abilityName)
    abilityName = Ancient_CleanTrailingSeparators(abilityName)
    abilityDescription = Ancient_FormatTooltipText(BlzGetAbilityResearchExtendedTooltip(abilityId, tooltipIndex), abilityLevel)
    abilityDescription = Ancient_RemoveColorCodes(abilityDescription)
    abilityDescription = Ancient_CollapseSpaces(abilityDescription)
    if (StringLength(abilityName) == 0) then
        abilityName = "Unknown ability"
    end
    if (StringLength(abilityDescription) == 0) then
        abilityDescription = "No learn tooltip text."
    end
    do return __jconcat(__jconcat(__jconcat(__jconcat("|cff00ccff", abilityName), "|r |cffffffff"), abilityDescription), "|r") end
end

-- Original JASS function: Ancient_ShowAbilityPageByType (line 13551)
function Ancient_ShowAbilityPageByType(p, ancient, unitTypeId, ancientName, page, isPreview)
    local abilityCount = Ancient_GetAbilityCount(unitTypeId)
    local abilitiesPerPage = 3
    local maxPage = 0
    local startIndex = 0
    local endIndex = 0
    local i = 0
    local abilityId = 0
    local pageText = nil
    if (abilityCount <= 0) then
        Ancient_ClearMessagesForPlayer(p)
        DisplayTimedTextToPlayer(p, __jreal(0.00), __jreal(0.00), __jreal(10.00), __jconcat("|cffffcc00Ancient:|r This Ancient unit type is not registered: ", I2S(unitTypeId)))
        do return end
    end
    maxPage = __jdiv((__jint(__jint(abilityCount + abilitiesPerPage) - 1)), abilitiesPerPage)
    if (page > maxPage) then
        page = maxPage
    end
    startIndex = __jint(__jint((__jint(page - 1)) * abilitiesPerPage) + 1)
    endIndex = __jint(page * abilitiesPerPage)
    if (endIndex > abilityCount) then
        endIndex = abilityCount
    end
    if isPreview then
        pageText = __jconcat(__jconcat(__jconcat(__jconcat(__jconcat(__jconcat("|cffffcc00Ancient preview:|r |cffffffff", ancientName), "|r |cffaaaaaaPage "), I2S(page)), "/"), I2S(maxPage)), "|r")
    else
        pageText = __jconcat(__jconcat(__jconcat(__jconcat(__jconcat(__jconcat("|cffffcc00Ancient spells:|r |cffffffff", ancientName), "|r |cffaaaaaaPage "), I2S(page)), "/"), I2S(maxPage)), "|r")
    end
    i = startIndex
    while true do
        if (i > endIndex) then break end
        abilityId = Ancient_GetAbilityIdByIndex(unitTypeId, i)
        if (abilityId ~= 0) then
            pageText = __jconcat(__jconcat(pageText, "\n"), Ancient_GetSingleAbilityLine(ancient, abilityId))
        end
        i = __jint(i + 1)
    end
    if (page < maxPage) then
        if isPreview then
            pageText = __jconcat(__jconcat(__jconcat(__jconcat(__jconcat(pageText, "\n|cffaaaaaaType |r|cffffcc00-ancient "), Ancient_GetFirstWord(Ancient_GetUnitTypeDisplayName(unitTypeId))), " "), I2S(__jint(page + 1))), "|r|cffaaaaaa to show the next page.|r")
        else
            pageText = __jconcat(__jconcat(__jconcat(pageText, "\n|cffaaaaaaType |r|cffffcc00-ancient "), I2S(__jint(page + 1))), "|r|cffaaaaaa to show the next page.|r")
        end
    end
    Ancient_ClearMessagesForPlayer(p)
    DisplayTimedTextToPlayer(p, __jreal(0.00), __jreal(0.00), __jreal(45.00), pageText)
end

-- Original JASS function: Ancient_ShowAbilityPage (line 13611)
function Ancient_ShowAbilityPage(p, ancient, page)
    Ancient_ShowAbilityPageByType(p, ancient, GetUnitTypeId(ancient), GetUnitName(ancient), page, false)
end

-- Original JASS function: Ancient_Command_Actions (line 13615)
function Ancient_Command_Actions()
    local p = GetTriggerPlayer()
    local chat = GetEventPlayerChatString()
    local argument = nil
    local firstWordOriginal = nil
    local firstWord = nil
    local page = 0
    local previewUnitTypeId = 0
    if (not Ancient_IsCommand(chat)) then
        p = nil
        do return end
    end
    argument = Ancient_GetArgumentText(chat)
    firstWordOriginal = Ancient_GetFirstWord(argument)
    firstWord = StringCase(firstWordOriginal, false)
    previewUnitTypeId = Ancient_GetUnitTypeIdByKeyword(firstWord)
    if (FE_Roles.ancient() == nil) then
        Ancient_ClearMessagesForPlayer(p)
        DisplayTimedTextToPlayer(p, __jreal(0.00), __jreal(0.00), __jreal(10.00), "|cffffcc00Ancient:|r Ancient player is not set.")
        p = nil
        do return end
    end
    if (p == FE_Roles.ancient()) then
        if (previewUnitTypeId ~= 0) then
            page = Ancient_ParsePageFromArgument(argument)
            Ancient_ShowAbilityPageByType(p, nil, previewUnitTypeId, Ancient_GetUnitTypeDisplayName(previewUnitTypeId), page, true)
            p = nil
            do return end
        end
        if (((StringLength(firstWordOriginal) > 0) and (S2I(firstWord) <= 0)) and (firstWord ~= "0")) then
            Ancient_ClearMessagesForPlayer(p)
            DisplayTimedTextToPlayer(p, __jreal(0.00), __jreal(0.00), __jreal(10.00), __jconcat(__jconcat("|cffffcc00Ancient preview:|r Cannot find Ancient called |cffff0000", firstWordOriginal), "|r|cffffffff.|r"))
            p = nil
            do return end
        end
        Ancient_ShowPreviewUsage(p)
        p = nil
        do return end
    end
    if (previewUnitTypeId ~= 0) then
        Ancient_ClearMessagesForPlayer(p)
        DisplayTimedTextToPlayer(p, __jreal(0.00), __jreal(0.00), __jreal(10.00), "|cffffcc00Ancient:|r Only the Ancient player can preview Ancient abilities by name.")
        p = nil
        do return end
    end
    if (((StringLength(firstWordOriginal) > 0) and (S2I(firstWord) <= 0)) and (firstWord ~= "0")) then
        Ancient_ClearMessagesForPlayer(p)
        DisplayTimedTextToPlayer(p, __jreal(0.00), __jreal(0.00), __jreal(10.00), "|cffffcc00Ancient:|r Invalid page. Use |cffffcc00-ancient|r|cffffffff or |r|cffffcc00-ancient 2|r|cffffffff.|r")
        p = nil
        do return end
    end
    page = Ancient_ParsePageFromArgument(argument)
    if (not IsPlayerEnemy(p, FE_Roles.ancient())) then
        Ancient_ClearMessagesForPlayer(p)
        DisplayTimedTextToPlayer(p, __jreal(0.00), __jreal(0.00), __jreal(10.00), "|cffffcc00Ancient:|r This command is only available to enemies of the Ancient.")
        p = nil
        do return end
    end
    if (udg_AncientUnit == nil) then
        Ancient_ClearMessagesForPlayer(p)
        DisplayTimedTextToPlayer(p, __jreal(0.00), __jreal(0.00), __jreal(10.00), "|cffffcc00Ancient:|r There is currently no living Ancient unit.")
        p = nil
        do return end
    end
    if ((GetUnitTypeId(udg_AncientUnit) == 0) or (GetWidgetLife(udg_AncientUnit) <= __jreal(0.405))) then
        Ancient_ClearMessagesForPlayer(p)
        DisplayTimedTextToPlayer(p, __jreal(0.00), __jreal(0.00), __jreal(10.00), "|cffffcc00Ancient:|r There is currently no living Ancient unit.")
        p = nil
        do return end
    end
    Ancient_ShowAbilityPage(p, udg_AncientUnit, page)
    p = nil
end

-- Original JASS function: InitTrig_AncientSpells (line 13703)
function InitTrig_AncientSpells()
    local t = CreateTrigger()
    local i = 0
    while true do
        if (i >= bj_MAX_PLAYERS) then break end
        TriggerRegisterPlayerChatEvent(t, Player(i), "-", false)
        i = __jint(i + 1)
    end
    TriggerAddAction(t, Ancient_Command_Actions)
    t = nil
end
-- END FOREST SECTION 205
