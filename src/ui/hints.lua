-- ui / hints
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 192 Sit_tight
-- Original JASS function: Trig_Sit_tight_Actions (line 12760)
function Trig_Sit_tight_Actions()
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_549")
end

-- Original JASS function: InitTrig_Sit_tight (line 12765)
function InitTrig_Sit_tight()
    gg_trg_Sit_tight = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_Sit_tight, __jreal(25.00))
    TriggerAddAction(gg_trg_Sit_tight, Trig_Sit_tight_Actions)
end
-- END FOREST SECTION 192

-- BEGIN FOREST SECTION 193 ClearOnEsc
-- Original JASS function: Trig_ClearMessagesOnEsc_Actions (line 12774)
function Trig_ClearMessagesOnEsc_Actions()
    if (GetLocalPlayer() == GetTriggerPlayer()) then
        ClearTextMessages()
    end
end

-- Original JASS function: InitTrig_ClearOnEsc (line 12780)
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
-- Original JASS function: Trig_InitialText_Actions (line 12797)
function Trig_InitialText_Actions()
    local redForce = CreateForce()
    ForceAddPlayer(redForce, Player(0))
    ForceEnumAllies(redForce, Player(0), nil)
    DisplayTimedTextToPlayer(FE_Roles.ancient(), __jreal(0.00), __jreal(0.00), __jreal(40.00), "The Ancient can enable trade by typing -tradeon during pick phase")
    DisplayTimedTextToPlayer(FE_Roles.ancient(), __jreal(0.00), __jreal(0.00), __jreal(40.00), "The Ancient can make enemies stronger by typing -hardmode during pick phase")
    DisplayTimedTextToForce(redForce, __jreal(40.00), "Player 1 (Red) can change feedrate% of all players to any value within 50 and 200, example: '-setfeed 120'")
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

-- Original JASS function: InitTrig_InitialText (line 12821)
function InitTrig_InitialText()
    gg_trg_InitialText = CreateTrigger()
    TriggerAddAction(gg_trg_InitialText, Trig_InitialText_Actions)
end
-- END FOREST SECTION 194

-- BEGIN FOREST SECTION 195 Welcome
-- Original JASS function: Trig_Welcome_Actions (line 12830)
function Trig_Welcome_Actions()
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_336")
end

-- Original JASS function: InitTrig_Welcome (line 12835)
function InitTrig_Welcome()
    gg_trg_Welcome = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_Welcome, __jreal(20.00))
    TriggerAddAction(gg_trg_Welcome, Trig_Welcome_Actions)
end
-- END FOREST SECTION 195

-- BEGIN FOREST SECTION 196 Info_Copy
-- Original JASS function: Trig_Info_Copy_Actions (line 12844)
function Trig_Info_Copy_Actions()
    DisplayTimedTextToForce(bj_FORCE_PLAYER[6], __jreal(20.00), "TRIGSTR_469")
end

-- Original JASS function: InitTrig_Info_Copy (line 12849)
function InitTrig_Info_Copy()
    gg_trg_Info_Copy = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_Info_Copy, __jreal(40.00))
    TriggerAddAction(gg_trg_Info_Copy, Trig_Info_Copy_Actions)
end
-- END FOREST SECTION 196

-- BEGIN FOREST SECTION 197 Info
-- Original JASS function: Trig_Info_Actions (line 12858)
function Trig_Info_Actions()
    DisplayTimedTextToForce(bj_FORCE_PLAYER[6], __jreal(45.00), "TRIGSTR_7352")
end

-- Original JASS function: InitTrig_Info (line 12863)
function InitTrig_Info()
    gg_trg_Info = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_Info, __jreal(70.00))
    TriggerAddAction(gg_trg_Info, Trig_Info_Actions)
end
-- END FOREST SECTION 197

-- BEGIN FOREST SECTION 198 Ping_Hint
-- Original JASS function: Trig_Ping_Hint_Actions (line 12872)
function Trig_Ping_Hint_Actions()
    DisplayTextToForce(GetPlayersEnemies(FE_Roles.ancient()), "TRIGSTR_3139")
end

-- Original JASS function: InitTrig_Ping_Hint (line 12877)
function InitTrig_Ping_Hint()
    gg_trg_Ping_Hint = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_Ping_Hint, __jreal(70.00))
    TriggerAddAction(gg_trg_Ping_Hint, Trig_Ping_Hint_Actions)
end
-- END FOREST SECTION 198

-- BEGIN FOREST SECTION 199 Hint2x2
-- Original JASS function: Trig_Hint2x2_Actions (line 12886)
function Trig_Hint2x2_Actions()
    DisplayTextToForce(GetPlayersEnemies(FE_Roles.ancient()), "TRIGSTR_5110")
end

-- Original JASS function: InitTrig_Hint2x2 (line 12891)
function InitTrig_Hint2x2()
    gg_trg_Hint2x2 = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_Hint2x2, __jreal(90.00))
    TriggerAddAction(gg_trg_Hint2x2, Trig_Hint2x2_Actions)
end
-- END FOREST SECTION 199

-- BEGIN FOREST SECTION 200 HintInvisibility
-- Original JASS function: Trig_HintInvisibility_Actions (line 12900)
function Trig_HintInvisibility_Actions()
    DisplayTextToForce(GetPlayersEnemies(FE_Roles.ancient()), "TRIGSTR_5166")
end

-- Original JASS function: InitTrig_HintInvisibility (line 12905)
function InitTrig_HintInvisibility()
    gg_trg_HintInvisibility = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_HintInvisibility, __jreal(110.00))
    TriggerAddAction(gg_trg_HintInvisibility, Trig_HintInvisibility_Actions)
end
-- END FOREST SECTION 200

-- BEGIN FOREST SECTION 201 HintFeed
-- Original JASS function: Trig_HintFeed_Actions (line 12914)
function Trig_HintFeed_Actions()
    DisplayTextToForce(GetPlayersEnemies(FE_Roles.ancient()), "TRIGSTR_5775")
end

-- Original JASS function: InitTrig_HintFeed (line 12919)
function InitTrig_HintFeed()
    gg_trg_HintFeed = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_HintFeed, __jreal(260.00))
    TriggerAddAction(gg_trg_HintFeed, Trig_HintFeed_Actions)
end
-- END FOREST SECTION 201

-- BEGIN FOREST SECTION 202 Resource_Hint
-- Original JASS function: Trig_Resource_Hint_Actions (line 12928)
function Trig_Resource_Hint_Actions()
    DisplayTextToForce(FE_Roster.expanderForce(), "TRIGSTR_7317")
end

-- Original JASS function: InitTrig_Resource_Hint (line 12933)
function InitTrig_Resource_Hint()
    gg_trg_Resource_Hint = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(gg_trg_Resource_Hint, __jreal(300.00))
    TriggerAddAction(gg_trg_Resource_Hint, Trig_Resource_Hint_Actions)
end
-- END FOREST SECTION 202

-- BEGIN FOREST SECTION 203 Ping
-- Original JASS function: Trig_Ping_Actions (line 12942)
function Trig_Ping_Actions()
    PingMinimapLocForForce(GetPlayersAllies(GetTriggerPlayer()), GetRectCenter(gg_rct_Ping1), __jreal(3.00))
    PingMinimapLocForForce(GetPlayersAllies(GetTriggerPlayer()), GetRectCenter(gg_rct_Ping2), __jreal(3.00))
    PingMinimapLocForForce(GetPlayersAllies(GetTriggerPlayer()), GetRectCenter(gg_rct_Ping3), __jreal(3.00))
    PingMinimapLocForForce(GetPlayersAllies(GetTriggerPlayer()), GetRectCenter(gg_rct_Ping4), __jreal(3.00))
    PingMinimapLocForForce(GetPlayersAllies(GetTriggerPlayer()), GetRectCenter(gg_rct_Ping5), __jreal(3.00))
    PingMinimapLocForForce(GetPlayersAllies(GetTriggerPlayer()), GetRectCenter(gg_rct_Ping6), __jreal(3.00))
    PingMinimapLocForForce(GetPlayersAllies(GetTriggerPlayer()), GetRectCenter(gg_rct_Ping7), __jreal(3.00))
end

-- Original JASS function: InitTrig_Ping (line 12953)
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
-- Original JASS function: Trig_PingForAncient_Actions (line 12971)
function Trig_PingForAncient_Actions()
    PingMinimapLocForForce(GetPlayersAllies(FE_Roles.ancient()), GetRectCenter(gg_rct_Ping1), __jreal(3.00))
    PingMinimapLocForForce(GetPlayersAllies(FE_Roles.ancient()), GetRectCenter(gg_rct_Ping2), __jreal(3.00))
    PingMinimapLocForForce(GetPlayersAllies(FE_Roles.ancient()), GetRectCenter(gg_rct_Ping3), __jreal(3.00))
    PingMinimapLocForForce(GetPlayersAllies(FE_Roles.ancient()), GetRectCenter(gg_rct_Ping4), __jreal(3.00))
    PingMinimapLocForForce(GetPlayersAllies(FE_Roles.ancient()), GetRectCenter(gg_rct_Ping5), __jreal(3.00))
    PingMinimapLocForForce(GetPlayersAllies(FE_Roles.ancient()), GetRectCenter(gg_rct_Ping6), __jreal(3.00))
    PingMinimapLocForForce(GetPlayersAllies(FE_Roles.ancient()), GetRectCenter(gg_rct_Ping7), __jreal(3.00))
end

-- Original JASS function: InitTrig_PingForAncient (line 12982)
function InitTrig_PingForAncient()
    gg_trg_PingForAncient = CreateTrigger()
    FE_Roles.registerAncientChatEvent(gg_trg_PingForAncient, "-gold", true)
    TriggerAddAction(gg_trg_PingForAncient, Trig_PingForAncient_Actions)
end
-- END FOREST SECTION 204
