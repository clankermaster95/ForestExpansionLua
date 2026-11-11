-- commands / player
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 17 Hardmode
function Hardmode_GiveResources()
    local i = 0
    local p = nil
    if (FE_Roles.ancient() == nil) then
        return
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

function Hardmode_PlayActivationIndicator()
    DisplayTimedTextToPlayer(GetLocalPlayer(), __jreal(0.00), __jreal(0.00), __jreal(10.00), "|cffffcc00Ancient activated hardmode.|r Expanders will now receive extra |cff80ff8050 lumber|r and |cffffff001 gold|r every 6 seconds after ancient spawn.")
    if (udg_HardmodeSound ~= nil) then
        SetSoundVolume(udg_HardmodeSound, 127)
        StartSound(udg_HardmodeSound)
    end
end

function Hardmode_Start()
    local t = GetExpiredTimer()
    udg_HardmodeCanBeEnabled = false
    PauseTimer(t)
    FE_Timers.destroy(t)
    if udg_HardmodeEnabled then
        Hardmode_GiveResources()
        udg_HardmodePeriodicTimer = FE_Timers.create()
        TimerStart(udg_HardmodePeriodicTimer, __jreal(6.00), true, Hardmode_GiveResources)
    end
    t = nil
end

function Hardmode_Chat()
    if (udg_HardmodeCanBeEnabled and (GetTriggerPlayer() == FE_Roles.ancient())) then
        if (not udg_HardmodeEnabled) then
            udg_HardmodeEnabled = true
            Hardmode_PlayActivationIndicator()
        end
    end
end

function InitTrig_Hardmode()
    local i = 0
    local t = CreateTrigger()
    local tm = FE_Timers.create()
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
function Ancient_ReplaceAll(source, findText, replaceText)
    if source == nil then return "" end
    if findText == nil or findText == "" then return source end
    local result, start = {}, 1
    while true do
        local first, last = string.find(source, findText, start, true)
        if not first then
            result[#result + 1] = string.sub(source, start)
            return table.concat(result)
        end
        result[#result + 1] = string.sub(source, start, first - 1)
        result[#result + 1] = replaceText or ""
        start = last + 1
    end
end

function Ancient_CollapseSpaces(source)
    if source == nil then return "" end
    -- Only literal spaces collapse; leading/trailing spaces and other whitespace remain.
    return (string.gsub(source, " +", " "))
end

function Ancient_IsHexChar(c)
    return type(c) == "string" and string.match(c, "^[0-9a-fA-F]$") ~= nil
end

function Ancient_RemoveColorCodes(source)
    if source == nil then return "" end
    local result, index = {}, 1
    while index <= #source do
        local marker = string.sub(source, index, index + 1)
        local color = string.sub(source, index + 2, index + 9)
        if (marker == "|c" or marker == "|C") and #color == 8 and not string.find(color, "[^0-9a-fA-F]") then
            index = index + 10
        elseif marker == "|r" or marker == "|R" then
            index = index + 2
        else
            result[#result + 1] = string.sub(source, index, index)
            index = index + 1
        end
    end
    -- A single scan preserves malformed tags and does not rescan joined fragments.
    return table.concat(result)
end

function Ancient_RemoveSquareBracketBlocks(source)
    if source == nil then return "" end
    local result, insideBracket = {}, false
    for index = 1, #source do
        local character = string.sub(source, index, index)
        if character == "[" then
            insideBracket = true
        elseif character == "]" then
            insideBracket = false
        elseif not insideBracket then
            result[#result + 1] = character
        end
    end
    return Ancient_CollapseSpaces(table.concat(result))
end

function Ancient_CleanTrailingSeparators(source)
    if source == nil then return "" end
    return (string.gsub(Ancient_CollapseSpaces(source), "[ :\x25-]+$", ""))
end

function Ancient_FormatTooltipText(text, level)
    if (text == nil) then
        return ""
    end
    text = Ancient_ReplaceAll(text, "|n", " ")
    text = Ancient_ReplaceAll(text, "|N", " ")
    text = Ancient_ReplaceAll(text, "\n", " ")
    text = Ancient_ReplaceAll(text, "/n", " ")
    text = Ancient_ReplaceAll(text, "/N", " ")
    text = Ancient_ReplaceAll(text, "\x25d", I2S(level))
    text = Ancient_CollapseSpaces(text)
    return text
end

function Ancient_ClearMessagesForPlayer(p)
    if (GetLocalPlayer() == p) then
        ClearTextMessages()
    end
end

function Ancient_IsCommand(chat)
    local s = StringCase(chat, false)
    local len = StringLength(s)
    if (len < 8) then
        return false
    end
    if (SubString(s, 0, 8) ~= "-ancient") then
        return false
    end
    if (len == 8) then
        return true
    end
    return (SubString(s, 8, 9) == " ")
end

function Ancient_GetArgumentText(chat)
    local len = StringLength(chat)
    local i = 8
    while true do
        if ((i >= len) or (SubString(chat, i, __jint(i + 1)) ~= " ")) then break end
        i = __jint(i + 1)
    end
    if (i >= len) then
        return ""
    end
    return SubString(chat, i, len)
end

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
        return ""
    end
    return SubString(text, start, i)
end

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
        return ""
    end
    return SubString(text, i, len)
end

-- Preview metadata is ordered explicitly; object discovery must not change the
-- displayed abilities or the historical command aliases.
local ancientPreviewTypes = {
    {raw="O00A", name="Darkness / Paranoia",
     aliases={"darkness", "paranoia"}, abilities={"A0E9", "A05F", "A058", "A05C", "A05E"}},
    {raw="O00S", name="Dragon",
     aliases={"dragon", "dragons", "dragos", "drago"}, abilities={"A02B", "A06P", "A02A", "A01J", "A02D"}},
    {raw="O00L", name="Earth / Tremor",
     aliases={"earth", "tremor"}, abilities={"A06D", "A088", "A05Q", "A01T", "A06F"}},
    {raw="O004", name="Fire / Ignite",
     aliases={"fire", "ignite"}, abilities={"A002", "A000", "A07A", "A003", "A004"}},
    {raw="O008", name="Ice / Avalanche",
     aliases={"ice", "avalanche", "avalanch"}, abilities={"A008", "A0EX", "A074", "A00A", "A075"}},
    {raw="O01V", name="Light / Divinity",
     aliases={"light", "divinity"}, abilities={"A06X", "A06W", "A06V", "A06U", "A06Y"}},
    {raw="O016", name="Lightning / Zalxon",
     aliases={"lightning", "lighting", "zalxon"}, abilities={"A03U", "A09L", "A03R", "A07B", "A03S", "A03T"}},
    {raw="O00D", name="Nature / Eternity",
     aliases={"nature", "eternity"}, abilities={"A01M", "A012", "A070", "A06Z", "A013"}},
    {raw="O01X", name="Sand / Pharaoh",
     aliases={"sand", "pharaoh", "pharaon"}, abilities={"A07Y", "A07X", "A07Z", "A080", "A082"}},
    {raw="O01Z", name="Space / Nebula",
     aliases={"space", "nebula"}, abilities={"A08R", "A08I", "A08K", "A0F1", "A08S"}},
    {raw="O01D", name="Wind / Wispari",
     aliases={"wind", "wispari", "whispari", "whisperi", "wisperi"}, abilities={"A0EL", "A0EO", "A0EP", "A0ES", "A048"}},
}
local ancientPreviewByKeyword = {}
for _, entry in ipairs(ancientPreviewTypes) do
    for _, alias in ipairs(entry.aliases) do ancientPreviewByKeyword[alias] = entry end
end

-- Keep module loading free of native calls; rawcodes resolve when queried.
local function ancientPreviewForType(unitTypeId)
    for _, entry in ipairs(ancientPreviewTypes) do
        if unitTypeId == FourCC(entry.raw) then return entry end
    end
end

function Ancient_GetUnitTypeIdByKeyword(keyword)
    local entry = ancientPreviewByKeyword[keyword]
    return entry and FourCC(entry.raw) or 0
end

function Ancient_GetUnitTypeDisplayName(unitTypeId)
    local entry = ancientPreviewForType(unitTypeId)
    return entry and entry.name or "Unknown Ancient"
end

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
    return page
end

function Ancient_ShowPreviewUsage(p)
    Ancient_ClearMessagesForPlayer(p)
    DisplayTimedTextToPlayer(p, __jreal(0.00), __jreal(0.00), __jreal(20.00), "|cffffcc00Ancient preview:|r |cffffffffUse |r|cffffcc00-ancient darkness|r|cffffffff, |r|cffffcc00-ancient dragon|r|cffffffff, |r|cffffcc00-ancient earth|r|cffffffff, |r|cffffcc00-ancient fire|r|cffffffff, |r|cffffcc00-ancient ice|r|cffffffff, |r|cffffcc00-ancient light|r|cffffffff, |r|cffffcc00-ancient lightning|r|cffffffff, |r|cffffcc00-ancient nature|r|cffffffff, |r|cffffcc00-ancient sand|r|cffffffff, |r|cffffcc00-ancient space|r|cffffffff, or |r|cffffcc00-ancient wind|r|cffffffff. Add page number after the name if needed, for example |r|cffffcc00-ancient darkness 2|r|cffffffff.|r")
end

function Ancient_GetAbilityCount(unitTypeId)
    local entry = ancientPreviewForType(unitTypeId)
    return entry and #entry.abilities or 0
end

function Ancient_GetAbilityIdByIndex(unitTypeId, index)
    local entry = ancientPreviewForType(unitTypeId)
    local raw = entry and entry.abilities[index]
    return raw and FourCC(raw) or 0
end

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
    return __jconcat(__jconcat(__jconcat(__jconcat("|cff00ccff", abilityName), "|r |cffffffff"), abilityDescription), "|r")
end

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
        return
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

function Ancient_ShowAbilityPage(p, ancient, page)
    Ancient_ShowAbilityPageByType(p, ancient, GetUnitTypeId(ancient), GetUnitName(ancient), page, false)
end

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
        return
    end
    argument = Ancient_GetArgumentText(chat)
    firstWordOriginal = Ancient_GetFirstWord(argument)
    firstWord = StringCase(firstWordOriginal, false)
    previewUnitTypeId = Ancient_GetUnitTypeIdByKeyword(firstWord)
    if (FE_Roles.ancient() == nil) then
        Ancient_ClearMessagesForPlayer(p)
        DisplayTimedTextToPlayer(p, __jreal(0.00), __jreal(0.00), __jreal(10.00), "|cffffcc00Ancient:|r Ancient player is not set.")
        p = nil
        return
    end
    if (p == FE_Roles.ancient()) then
        if (previewUnitTypeId ~= 0) then
            page = Ancient_ParsePageFromArgument(argument)
            Ancient_ShowAbilityPageByType(p, nil, previewUnitTypeId, Ancient_GetUnitTypeDisplayName(previewUnitTypeId), page, true)
            p = nil
            return
        end
        if (((StringLength(firstWordOriginal) > 0) and (S2I(firstWord) <= 0)) and (firstWord ~= "0")) then
            Ancient_ClearMessagesForPlayer(p)
            DisplayTimedTextToPlayer(p, __jreal(0.00), __jreal(0.00), __jreal(10.00), __jconcat(__jconcat("|cffffcc00Ancient preview:|r Cannot find Ancient called |cffff0000", firstWordOriginal), "|r|cffffffff.|r"))
            p = nil
            return
        end
        Ancient_ShowPreviewUsage(p)
        p = nil
        return
    end
    if (previewUnitTypeId ~= 0) then
        Ancient_ClearMessagesForPlayer(p)
        DisplayTimedTextToPlayer(p, __jreal(0.00), __jreal(0.00), __jreal(10.00), "|cffffcc00Ancient:|r Only the Ancient player can preview Ancient abilities by name.")
        p = nil
        return
    end
    if (((StringLength(firstWordOriginal) > 0) and (S2I(firstWord) <= 0)) and (firstWord ~= "0")) then
        Ancient_ClearMessagesForPlayer(p)
        DisplayTimedTextToPlayer(p, __jreal(0.00), __jreal(0.00), __jreal(10.00), "|cffffcc00Ancient:|r Invalid page. Use |cffffcc00-ancient|r|cffffffff or |r|cffffcc00-ancient 2|r|cffffffff.|r")
        p = nil
        return
    end
    page = Ancient_ParsePageFromArgument(argument)
    if (not IsPlayerEnemy(p, FE_Roles.ancient())) then
        Ancient_ClearMessagesForPlayer(p)
        DisplayTimedTextToPlayer(p, __jreal(0.00), __jreal(0.00), __jreal(10.00), "|cffffcc00Ancient:|r This command is only available to enemies of the Ancient.")
        p = nil
        return
    end
    if (udg_AncientUnit == nil) then
        Ancient_ClearMessagesForPlayer(p)
        DisplayTimedTextToPlayer(p, __jreal(0.00), __jreal(0.00), __jreal(10.00), "|cffffcc00Ancient:|r There is currently no living Ancient unit.")
        p = nil
        return
    end
    if ((GetUnitTypeId(udg_AncientUnit) == 0) or (GetWidgetLife(udg_AncientUnit) <= __jreal(0.405))) then
        Ancient_ClearMessagesForPlayer(p)
        DisplayTimedTextToPlayer(p, __jreal(0.00), __jreal(0.00), __jreal(10.00), "|cffffcc00Ancient:|r There is currently no living Ancient unit.")
        p = nil
        return
    end
    Ancient_ShowAbilityPage(p, udg_AncientUnit, page)
    p = nil
end

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
