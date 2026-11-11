-- ui / hints
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 192 Sit_tight
function Trig_Sit_tight_Actions()
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_549")
end

function InitTrig_Sit_tight()
    gg_trg_Sit_tight = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_Sit_tight, __jreal(25.00))
    TriggerAddAction(gg_trg_Sit_tight, Trig_Sit_tight_Actions)
end
-- END FOREST SECTION 192

-- BEGIN FOREST SECTION 193 ClearOnEsc
function Trig_ClearMessagesOnEsc_Actions()
    if (GetLocalPlayer() == GetTriggerPlayer()) then
        ClearTextMessages()
    end
end

function InitTrig_ClearOnEsc()
    local t = CreateTrigger()
    local i = 0
    while true do
        if (i >= bj_MAX_PLAYER_SLOTS) then break end
        TriggerRegisterPlayerEvent(t, Player(i), EVENT_PLAYER_END_CINEMATIC)
        i = __jint(i + 1)
    end
    TriggerAddAction(t, Trig_ClearMessagesOnEsc_Actions)
    t = nil
end
-- END FOREST SECTION 193

-- BEGIN FOREST SECTION 194 InitialText
function Trig_InitialText_Actions()
    local redForce = CreateForce()
    ForceAddPlayer(redForce, Player(0))
    ForceEnumAllies(redForce, Player(0), nil)
    DisplayTimedTextToPlayer(FE_Roles.ancient(), __jreal(0.00), __jreal(0.00), __jreal(40.00), "The Ancient can enable trade by typing -tradeon during pick phase")
    DisplayTimedTextToPlayer(FE_Roles.ancient(), __jreal(0.00), __jreal(0.00), __jreal(40.00), "The Ancient can make enemies stronger by typing -hardmode during pick phase")
    DisplayTimedTextToForce(redForce, __jreal(40.00), "Player 1 (Red) can change feedrate\x25 of all players to any value within 50 and 200, example: '-setfeed 120'")
    DisplayTimedTextToForce(redForce, __jreal(40.00), "Player 1 (Red) can multiply feedrate of all players by typing -setfeed x1.75")
    DisplayTimedTextToForce(redForce, __jreal(40.00), "Player 1 (Red) can also change feedrate of specific player, like: '-setfeed blue 150' or '-setfeed 2 150'")
    DisplayTimedTextToForce(redForce, __jreal(40.00), "Player 1 (Red) can write '-chopchop' to enable tree chopper for Ancient")
    DisplayTimedTextToForce(redForce, __jreal(40.00), "Player 1 (Red) can ban up to four ancients or expanders by typing '-ban name'")
    DisplayTimedTextToForce(redForce, __jreal(40.00), "For races with multiple words to their name, type the first word (e.g. -ban aethyr).")
    DisplayTimedTextToForce(redForce, __jreal(40.00), "Ban ancients by typing their element or given name. Ancient elements: Darkness, Dragon, Earth, Fire, Ice, Light, Lightning, Nature, Sand, Space, Wind")
    DisplayTimedTextToForce(redForce, __jreal(40.00), "Please note that banned races can still be randomed.")
    DisplayTimedTextToForce(redForce, __jreal(40.00), "For more info check F9")
    DestroyForce(redForce)
    redForce = nil
end

function InitTrig_InitialText()
    gg_trg_InitialText = CreateTrigger()
    TriggerAddAction(gg_trg_InitialText, Trig_InitialText_Actions)
end
-- END FOREST SECTION 194

-- BEGIN FOREST SECTION 195 Welcome
function Trig_Welcome_Actions()
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_336")
end

function InitTrig_Welcome()
    gg_trg_Welcome = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_Welcome, __jreal(20.00))
    TriggerAddAction(gg_trg_Welcome, Trig_Welcome_Actions)
end
-- END FOREST SECTION 195

-- BEGIN FOREST SECTION 196 Info_Copy
function Trig_Info_Copy_Actions()
    DisplayTimedTextToForce(bj_FORCE_PLAYER[6], __jreal(20.00), "TRIGSTR_469")
end

function InitTrig_Info_Copy()
    gg_trg_Info_Copy = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_Info_Copy, __jreal(40.00))
    TriggerAddAction(gg_trg_Info_Copy, Trig_Info_Copy_Actions)
end
-- END FOREST SECTION 196

-- BEGIN FOREST SECTION 197 Info
function Trig_Info_Actions()
    DisplayTimedTextToForce(bj_FORCE_PLAYER[6], __jreal(45.00), "TRIGSTR_7352")
end

function InitTrig_Info()
    gg_trg_Info = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_Info, __jreal(70.00))
    TriggerAddAction(gg_trg_Info, Trig_Info_Actions)
end
-- END FOREST SECTION 197

-- BEGIN FOREST SECTION 198 Ping_Hint
function Trig_Ping_Hint_Actions()
    DisplayTextToForce(GetPlayersEnemies(FE_Roles.ancient()), "TRIGSTR_3139")
end

function InitTrig_Ping_Hint()
    gg_trg_Ping_Hint = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_Ping_Hint, __jreal(70.00))
    TriggerAddAction(gg_trg_Ping_Hint, Trig_Ping_Hint_Actions)
end
-- END FOREST SECTION 198

-- BEGIN FOREST SECTION 199 Hint2x2
function Trig_Hint2x2_Actions()
    DisplayTextToForce(GetPlayersEnemies(FE_Roles.ancient()), "TRIGSTR_5110")
end

function InitTrig_Hint2x2()
    gg_trg_Hint2x2 = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_Hint2x2, __jreal(90.00))
    TriggerAddAction(gg_trg_Hint2x2, Trig_Hint2x2_Actions)
end
-- END FOREST SECTION 199

-- BEGIN FOREST SECTION 200 HintInvisibility
function Trig_HintInvisibility_Actions()
    DisplayTextToForce(GetPlayersEnemies(FE_Roles.ancient()), "TRIGSTR_5166")
end

function InitTrig_HintInvisibility()
    gg_trg_HintInvisibility = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_HintInvisibility, __jreal(110.00))
    TriggerAddAction(gg_trg_HintInvisibility, Trig_HintInvisibility_Actions)
end
-- END FOREST SECTION 200

-- BEGIN FOREST SECTION 201 HintFeed
function Trig_HintFeed_Actions()
    DisplayTextToForce(GetPlayersEnemies(FE_Roles.ancient()), "TRIGSTR_5775")
end

function InitTrig_HintFeed()
    gg_trg_HintFeed = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_HintFeed, __jreal(260.00))
    TriggerAddAction(gg_trg_HintFeed, Trig_HintFeed_Actions)
end
-- END FOREST SECTION 201

-- BEGIN FOREST SECTION 202 Resource_Hint
function Trig_Resource_Hint_Actions()
    DisplayTextToForce(FE_Roster.expanderForce(), "TRIGSTR_7317")
end

function InitTrig_Resource_Hint()
    gg_trg_Resource_Hint = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(gg_trg_Resource_Hint, __jreal(300.00))
    TriggerAddAction(gg_trg_Resource_Hint, Trig_Resource_Hint_Actions)
end
-- END FOREST SECTION 202

-- BEGIN FOREST SECTION 203 Ping
-- Resolve the player and region separately for every ping. Both helpers return
-- newly owned handles; release those handles without touching shared forces.
local function pingGoldRegions(playerForPing)
    for index = 1, 7 do
        local allies = GetPlayersAllies(playerForPing())
        local center = GetRectCenter(_G["gg_rct_Ping" .. index])
        PingMinimapLocForForce(allies, center, __jreal(3.00))
        RemoveLocation(center)
        DestroyForce(allies)
    end
end

function Trig_Ping_Actions()
    pingGoldRegions(GetTriggerPlayer)
end

function InitTrig_Ping()
    gg_trg_Ping = CreateTrigger()
    TriggerRegisterPlayerChatEvent(gg_trg_Ping, Player(0), "-gold", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Ping, Player(1), "-gold", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Ping, Player(2), "-gold", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Ping, Player(3), "-gold", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Ping, Player(4), "-gold", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Ping, Player(5), "-gold", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Ping, Player(7), "-gold", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Ping, Player(8), "-gold", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Ping, Player(9), "-gold", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Ping, Player(10), "-gold", true)
    TriggerAddAction(gg_trg_Ping, Trig_Ping_Actions)
end
-- END FOREST SECTION 203

-- BEGIN FOREST SECTION 204 PingForAncient
function Trig_PingForAncient_Actions()
    pingGoldRegions(FE_Roles.ancient)
end

function InitTrig_PingForAncient()
    gg_trg_PingForAncient = CreateTrigger()
    FE_Roles.registerAncientChatEvent(gg_trg_PingForAncient, "-gold", true)
    TriggerAddAction(gg_trg_PingForAncient, Trig_PingForAncient_Actions)
end
-- END FOREST SECTION 204
