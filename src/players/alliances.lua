-- players / alliances
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 308 Ally_neutral
-- Original JASS function: Trig_Ally_neutral_Actions (line 17739)
function Trig_Ally_neutral_Actions()
    SetPlayerAllianceStateBJ(FE_Roles.ancient(), Player(PLAYER_NEUTRAL_AGGRESSIVE), bj_ALLIANCE_ALLIED)
end

-- Original JASS function: InitTrig_Ally_neutral (line 17744)
function InitTrig_Ally_neutral()
    gg_trg_Ally_neutral = CreateTrigger()
    TriggerAddAction(gg_trg_Ally_neutral, Trig_Ally_neutral_Actions)
end
-- END FOREST SECTION 308

-- BEGIN FOREST SECTION 309 Vision
-- Original JASS function: Trig_Vision_Actions (line 17752)
function Trig_Vision_Actions()
    FogMaskEnableOff()
end

-- Original JASS function: InitTrig_Vision (line 17757)
function InitTrig_Vision()
    gg_trg_Vision = CreateTrigger()
    TriggerAddAction(gg_trg_Vision, Trig_Vision_Actions)
end
-- END FOREST SECTION 309
