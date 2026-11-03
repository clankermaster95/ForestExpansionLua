-- commands / trade
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 11 Tradeoff_Detection
-- Original JASS function: Trig_Tradeoff_Detection_Actions (line 4942)
function Trig_Tradeoff_Detection_Actions()
    udg_Tradeoff = "|cffb79419-tradeoff|r"
end

-- Original JASS function: InitTrig_Tradeoff_Detection (line 4947)
function InitTrig_Tradeoff_Detection()
    gg_trg_Tradeoff_Detection = CreateTrigger()
    FE_Roles.registerAncientChatEvent(gg_trg_Tradeoff_Detection, "-tradeoff", true)
    TriggerAddAction(gg_trg_Tradeoff_Detection, Trig_Tradeoff_Detection_Actions)
end
-- END FOREST SECTION 11

-- BEGIN FOREST SECTION 266 Trade_disabled
-- Original JASS function: Trig_Trade_disabled_Actions (line 16075)
function Trig_Trade_disabled_Actions()
    SetMapFlag(MAP_LOCK_RESOURCE_TRADING, true)
    DisableTrigger(gg_trg_Resource_Hint)
end

-- Original JASS function: InitTrig_Trade_disabled (line 16081)
function InitTrig_Trade_disabled()
    gg_trg_Trade_disabled = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_Trade_disabled, __jreal(0.10))
    TriggerAddAction(gg_trg_Trade_disabled, Trig_Trade_disabled_Actions)
end
-- END FOREST SECTION 266

-- BEGIN FOREST SECTION 267 Trade_enabled
-- Original JASS function: Trig_Trade_enabled_Actions (line 16090)
function Trig_Trade_enabled_Actions()
    SetMapFlag(MAP_LOCK_RESOURCE_TRADING, false)
    EnableTrigger(gg_trg_Resource_Hint)
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_3366")
end

-- Original JASS function: InitTrig_Trade_enabled (line 16097)
function InitTrig_Trade_enabled()
    gg_trg_Trade_enabled = CreateTrigger()
    FE_Roles.registerAncientChatEvent(gg_trg_Trade_enabled, "-tradeon", true)
    TriggerAddAction(gg_trg_Trade_enabled, Trig_Trade_enabled_Actions)
end
-- END FOREST SECTION 267

-- BEGIN FOREST SECTION 268 Disable_trade_enabled
-- Original JASS function: Trig_Disable_trade_enabled_Actions (line 16106)
function Trig_Disable_trade_enabled_Actions()
    DisableTrigger(gg_trg_Trade_disabled)
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_3665")
end

-- Original JASS function: InitTrig_Disable_trade_enabled (line 16112)
function InitTrig_Disable_trade_enabled()
    gg_trg_Disable_trade_enabled = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_Disable_trade_enabled, __jreal(80.00))
    TriggerAddAction(gg_trg_Disable_trade_enabled, Trig_Disable_trade_enabled_Actions)
end
-- END FOREST SECTION 268
