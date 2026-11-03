-- players / alliances
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 308 Ally_neutral
function Trig_Ally_neutral_Actions()
    SetPlayerAllianceStateBJ(FE_Roles.ancient(), Player(PLAYER_NEUTRAL_AGGRESSIVE), bj_ALLIANCE_ALLIED)
end

function InitTrig_Ally_neutral()
    gg_trg_Ally_neutral = CreateTrigger()
    TriggerAddAction(gg_trg_Ally_neutral, Trig_Ally_neutral_Actions)
end
-- END FOREST SECTION 308

-- BEGIN FOREST SECTION 309 Vision
function Trig_Vision_Actions()
    FogMaskEnableOff()
end

function InitTrig_Vision()
    gg_trg_Vision = CreateTrigger()
    TriggerAddAction(gg_trg_Vision, Trig_Vision_Actions)
end
-- END FOREST SECTION 309
