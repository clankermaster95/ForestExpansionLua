-- Disabled in the original map.
function DAS_DBG_Msg(msg)
    if DAS_DBG_ENABLED then
        BJDebugMsg(__jconcat("[DAS DBG] ", msg))
    end
end

function DAS_DBG_SetSharedControl(flag)
    local i = 0
    local testPlayer = Player(DAS_DBG_TEST_PLAYER_ID)
    while true do
        if (i >= bj_MAX_PLAYER_SLOTS) then break end
        if (i ~= DAS_DBG_TEST_PLAYER_ID) then
            SetPlayerAlliance(Player(i), testPlayer, ALLIANCE_SHARED_CONTROL, flag)
            SetPlayerAlliance(Player(i), testPlayer, ALLIANCE_SHARED_ADVANCED_CONTROL, flag)
        end
        i = __jint(i + 1)
    end
    if flag then
        DAS_DBG_Msg("Shared control enabled. Try selecting enemy units and casting their invisibility abilities manually.")
    else
        DAS_DBG_Msg("Shared control disabled.")
    end
    testPlayer = nil
end

function DAS_DBG_TakeSelectedEnum()
    local u = GetEnumUnit()
    local oldOwner = nil
    if (u ~= nil) then
        oldOwner = GetOwningPlayer(u)
        SavePlayerHandle(DAS_DBG_Hash, GetHandleId(u), DAS_DBG_KEY_OLD_OWNER, oldOwner)
        SetUnitOwner(u, Player(DAS_DBG_TEST_PLAYER_ID), true)
        SelectUnitAddForPlayer(u, Player(DAS_DBG_TEST_PLAYER_ID))
        DAS_DBG_Msg(__jconcat(__jconcat(__jconcat(__jconcat("Took control of ", GetUnitName(u)), ". Old owner stored as Player("), I2S(GetPlayerId(oldOwner))), ")."))
    end
    u = nil
    oldOwner = nil
end

function DAS_DBG_BackSelectedEnum()
    local u = GetEnumUnit()
    local oldOwner = nil
    if (u ~= nil) then
        oldOwner = LoadPlayerHandle(DAS_DBG_Hash, GetHandleId(u), DAS_DBG_KEY_OLD_OWNER)
        if (oldOwner == nil) then
            oldOwner = Player(DAS_DBG_FALLBACK_ENEMY_PLAYER_ID)
            DAS_DBG_Msg(__jconcat(__jconcat(__jconcat(__jconcat("No stored owner found for ", GetUnitName(u)), ". Using fallback Player("), I2S(DAS_DBG_FALLBACK_ENEMY_PLAYER_ID)), ")."))
        end
        SetUnitOwner(u, oldOwner, true)
        RemoveSavedHandle(DAS_DBG_Hash, GetHandleId(u), DAS_DBG_KEY_OLD_OWNER)
        DAS_DBG_Msg(__jconcat(__jconcat(__jconcat(__jconcat("Returned ", GetUnitName(u)), " to Player("), I2S(GetPlayerId(oldOwner))), ")."))
    end
    u = nil
    oldOwner = nil
end

function DAS_DBG_TakeSelected()
    GroupClear(DAS_DBG_Group)
    GroupEnumUnitsSelected(DAS_DBG_Group, Player(DAS_DBG_TEST_PLAYER_ID), nil)
    ForGroup(DAS_DBG_Group, DAS_DBG_TakeSelectedEnum)
    GroupClear(DAS_DBG_Group)
end

function DAS_DBG_BackSelected()
    GroupClear(DAS_DBG_Group)
    GroupEnumUnitsSelected(DAS_DBG_Group, Player(DAS_DBG_TEST_PLAYER_ID), nil)
    ForGroup(DAS_DBG_Group, DAS_DBG_BackSelectedEnum)
    GroupClear(DAS_DBG_Group)
end

function DAS_DBG_Chat()
    local s = GetEventPlayerChatString()
    if (s == "-das control") then
        DAS_DBG_SetSharedControl(true)
    elseif (s == "-das nocontrol") then
        DAS_DBG_SetSharedControl(false)
    elseif (s == "-das take") then
        DAS_DBG_TakeSelected()
    elseif (s == "-das back") then
        DAS_DBG_BackSelected()
    elseif (s == "-das help") then
        DAS_DBG_Msg("Commands: -das control, -das nocontrol, -das take, -das back.")
    end
    s = nil
end

function InitTrig_Debug_Control()
    local t = CreateTrigger()
    TriggerRegisterPlayerChatEvent(t, Player(DAS_DBG_TEST_PLAYER_ID), "-das control", true)
    TriggerRegisterPlayerChatEvent(t, Player(DAS_DBG_TEST_PLAYER_ID), "-das nocontrol", true)
    TriggerRegisterPlayerChatEvent(t, Player(DAS_DBG_TEST_PLAYER_ID), "-das take", true)
    TriggerRegisterPlayerChatEvent(t, Player(DAS_DBG_TEST_PLAYER_ID), "-das back", true)
    TriggerRegisterPlayerChatEvent(t, Player(DAS_DBG_TEST_PLAYER_ID), "-das help", true)
    TriggerAddAction(t, DAS_DBG_Chat)
    DAS_DBG_Msg("Debug control commands loaded. Type -das help.")
    t = nil
end
