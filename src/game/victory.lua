-- Shared result sequence; original trigger subscriptions remain independently ordered.
FE_MatchResults = {}

function FE_MatchResults.ancientDeath(message)
    DisableTrigger(gg_trg_Ancient_Leaves)
    DisplayTextToForce(GetPlayersAll(), message)
    PlayThematicMusicBJ("HeroicVictory")
    TriggerSleepAction(__jreal(3.00))
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_5283")
    DisplayTimedTextToForce(GetPlayersAll(), __jreal(120.00), "TRIGSTR_9243")
    TriggerSleepAction(__jreal(120.00))
    FE_Roles.finishMatch(false, "TRIGSTR_4301")
end

-- game / victory
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 351 Ignite_Dies
function Trig_Ignite_Dies_Conditions()
    return GetUnitTypeId(GetTriggerUnit()) == FourCC("O004")
end

function Trig_Ignite_Dies_Actions()
    FE_MatchResults.ancientDeath("TRIGSTR_302")
end

function InitTrig_Ignite_Dies()
    gg_trg_Ignite_Dies = CreateTrigger()
    FE_Roles.registerAncientUnitEvent(gg_trg_Ignite_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Ignite_Dies, Condition(Trig_Ignite_Dies_Conditions))
    TriggerAddAction(gg_trg_Ignite_Dies, Trig_Ignite_Dies_Actions)
end
-- END FOREST SECTION 351

-- BEGIN FOREST SECTION 352 Avalanche_Dies
function Trig_Avalanche_Dies_Conditions()
    return GetUnitTypeId(GetTriggerUnit()) == FourCC("O008")
end

function Trig_Avalanche_Dies_Actions()
    FE_MatchResults.ancientDeath("TRIGSTR_446")
end

function InitTrig_Avalanche_Dies()
    gg_trg_Avalanche_Dies = CreateTrigger()
    FE_Roles.registerAncientUnitEvent(gg_trg_Avalanche_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Avalanche_Dies, Condition(Trig_Avalanche_Dies_Conditions))
    TriggerAddAction(gg_trg_Avalanche_Dies, Trig_Avalanche_Dies_Actions)
end
-- END FOREST SECTION 352

-- BEGIN FOREST SECTION 353 Paranoia_Dies
function Trig_Paranoia_Dies_Conditions()
    return GetUnitTypeId(GetTriggerUnit()) == FourCC("O00A")
end

function Trig_Paranoia_Dies_Actions()
    FE_MatchResults.ancientDeath("TRIGSTR_418")
end

function InitTrig_Paranoia_Dies()
    gg_trg_Paranoia_Dies = CreateTrigger()
    FE_Roles.registerAncientUnitEvent(gg_trg_Paranoia_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Paranoia_Dies, Condition(Trig_Paranoia_Dies_Conditions))
    TriggerAddAction(gg_trg_Paranoia_Dies, Trig_Paranoia_Dies_Actions)
end
-- END FOREST SECTION 353

-- BEGIN FOREST SECTION 354 Eternity_Dies
function Trig_Eternity_Dies_Conditions()
    return GetUnitTypeId(GetTriggerUnit()) == FourCC("O00D")
end

function Trig_Eternity_Dies_Actions()
    FE_MatchResults.ancientDeath("TRIGSTR_680")
end

function InitTrig_Eternity_Dies()
    gg_trg_Eternity_Dies = CreateTrigger()
    FE_Roles.registerAncientUnitEvent(gg_trg_Eternity_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Eternity_Dies, Condition(Trig_Eternity_Dies_Conditions))
    TriggerAddAction(gg_trg_Eternity_Dies, Trig_Eternity_Dies_Actions)
end
-- END FOREST SECTION 354

-- BEGIN FOREST SECTION 355 Dragos_Dies
function Trig_Dragos_Dies_Conditions()
    return GetUnitTypeId(GetTriggerUnit()) == FourCC("O00S")
end

function Trig_Dragos_Dies_Actions()
    FE_MatchResults.ancientDeath("TRIGSTR_2030")
end

function InitTrig_Dragos_Dies()
    gg_trg_Dragos_Dies = CreateTrigger()
    FE_Roles.registerAncientUnitEvent(gg_trg_Dragos_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Dragos_Dies, Condition(Trig_Dragos_Dies_Conditions))
    TriggerAddAction(gg_trg_Dragos_Dies, Trig_Dragos_Dies_Actions)
end
-- END FOREST SECTION 355

-- BEGIN FOREST SECTION 356 Tremor_Dies
function Trig_Tremor_Dies_Conditions()
    return GetUnitTypeId(GetTriggerUnit()) == FourCC("O00L")
end

function Trig_Tremor_Dies_Actions()
    FE_MatchResults.ancientDeath("TRIGSTR_1475")
end

function InitTrig_Tremor_Dies()
    gg_trg_Tremor_Dies = CreateTrigger()
    FE_Roles.registerAncientUnitEvent(gg_trg_Tremor_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Tremor_Dies, Condition(Trig_Tremor_Dies_Conditions))
    TriggerAddAction(gg_trg_Tremor_Dies, Trig_Tremor_Dies_Actions)
end
-- END FOREST SECTION 356

-- BEGIN FOREST SECTION 357 Zalxon_Dies
function Trig_Zalxon_Dies_Conditions()
    return GetUnitTypeId(GetTriggerUnit()) == FourCC("O016")
end

function Trig_Zalxon_Dies_Actions()
    FE_MatchResults.ancientDeath("TRIGSTR_3657")
end

function InitTrig_Zalxon_Dies()
    gg_trg_Zalxon_Dies = CreateTrigger()
    FE_Roles.registerAncientUnitEvent(gg_trg_Zalxon_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Zalxon_Dies, Condition(Trig_Zalxon_Dies_Conditions))
    TriggerAddAction(gg_trg_Zalxon_Dies, Trig_Zalxon_Dies_Actions)
end
-- END FOREST SECTION 357

-- BEGIN FOREST SECTION 358 Divinity_Dies
function Trig_Divinity_Dies_Conditions()
    return GetUnitTypeId(GetTriggerUnit()) == FourCC("O01V")
end

function Trig_Divinity_Dies_Actions()
    FE_MatchResults.ancientDeath("TRIGSTR_7140")
end

function InitTrig_Divinity_Dies()
    gg_trg_Divinity_Dies = CreateTrigger()
    FE_Roles.registerAncientUnitEvent(gg_trg_Divinity_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Divinity_Dies, Condition(Trig_Divinity_Dies_Conditions))
    TriggerAddAction(gg_trg_Divinity_Dies, Trig_Divinity_Dies_Actions)
end
-- END FOREST SECTION 358

-- BEGIN FOREST SECTION 359 Pharoah_Dies
function Trig_Pharoah_Dies_Conditions()
    return GetUnitTypeId(GetTriggerUnit()) == FourCC("O01X")
end

function Trig_Pharoah_Dies_Actions()
    FE_MatchResults.ancientDeath("TRIGSTR_8363")
end

function InitTrig_Pharoah_Dies()
    gg_trg_Pharoah_Dies = CreateTrigger()
    FE_Roles.registerAncientUnitEvent(gg_trg_Pharoah_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Pharoah_Dies, Condition(Trig_Pharoah_Dies_Conditions))
    TriggerAddAction(gg_trg_Pharoah_Dies, Trig_Pharoah_Dies_Actions)
end
-- END FOREST SECTION 359

-- BEGIN FOREST SECTION 360 Nebula_Dies
function Trig_Nebula_Dies_Conditions()
    return GetUnitTypeId(GetTriggerUnit()) == FourCC("O01Z")
end

function Trig_Nebula_Dies_Actions()
    FE_MatchResults.ancientDeath("TRIGSTR_9096")
end

function InitTrig_Nebula_Dies()
    gg_trg_Nebula_Dies = CreateTrigger()
    FE_Roles.registerAncientUnitEvent(gg_trg_Nebula_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Nebula_Dies, Condition(Trig_Nebula_Dies_Conditions))
    TriggerAddAction(gg_trg_Nebula_Dies, Trig_Nebula_Dies_Actions)
end
-- END FOREST SECTION 360

-- BEGIN FOREST SECTION 361 Wispari_Dies
function Trig_Wispari_Dies_Conditions()
    return GetUnitTypeId(GetTriggerUnit()) == FourCC("O01D")
end

function Trig_Wispari_Dies_Actions()
    FE_MatchResults.ancientDeath("TRIGSTR_4300")
end

function InitTrig_Wispari_Dies()
    gg_trg_Wispari_Dies = CreateTrigger()
    FE_Roles.registerAncientUnitEvent(gg_trg_Wispari_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Wispari_Dies, Condition(Trig_Wispari_Dies_Conditions))
    TriggerAddAction(gg_trg_Wispari_Dies, Trig_Wispari_Dies_Actions)
end
-- END FOREST SECTION 361

-- BEGIN FOREST SECTION 362 Remove_Resources_new
function Trig_Remove_Resources_new_Func001Func001C()
    if (not (GetEnumPlayer() ~= FE_Roles.ancient())) then
        return false
    end
    if (not (IsPlayerAlly(GetEnumPlayer(), FE_Roles.ancient()) == true)) then
        return false
    end
    return true
end

function Trig_Remove_Resources_new_Func001A()
    if (Trig_Remove_Resources_new_Func001Func001C()) then
        SetPlayerStateBJ(GetEnumPlayer(), PLAYER_STATE_RESOURCE_GOLD, 0)
        SetPlayerStateBJ(GetEnumPlayer(), PLAYER_STATE_RESOURCE_LUMBER, 0)
    end
end

function Trig_Remove_Resources_new_Actions()
    ForForce(GetPlayersAll(), Trig_Remove_Resources_new_Func001A)
end

function InitTrig_Remove_Resources_new()
    gg_trg_Remove_Resources_new = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(gg_trg_Remove_Resources_new, __jreal(0.50))
    TriggerAddAction(gg_trg_Remove_Resources_new, Trig_Remove_Resources_new_Actions)
end
-- END FOREST SECTION 362

-- BEGIN FOREST SECTION 363 DVIC_1
function Trig_DVIC_1_Conditions()
    return GetUnitLevel(GetLevelingUnit()) == 20
end

function Trig_DVIC_1_Actions()
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_7267")
    PlayThematicMusicBJ("UndeadVictory")
    TriggerSleepAction(__jreal(3.00))
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_7268")
    DisplayTimedTextToForce(GetPlayersAll(), __jreal(120.00), "TRIGSTR_9243")
    TriggerSleepAction(__jreal(120.00))
    FE_Roles.finishMatch(true, "TRIGSTR_7269")
end

function InitTrig_DVIC_1()
    gg_trg_DVIC_1 = CreateTrigger()
    FE_Roles.registerAncientUnitEvent(gg_trg_DVIC_1, EVENT_PLAYER_HERO_LEVEL)
    TriggerAddCondition(gg_trg_DVIC_1, Condition(Trig_DVIC_1_Conditions))
    TriggerAddAction(gg_trg_DVIC_1, Trig_DVIC_1_Actions)
end
-- END FOREST SECTION 363

-- BEGIN FOREST SECTION 364 Ext_On
function Trig_Ext_On_Actions()
    EnableTrigger(gg_trg_Extermination)
end

function InitTrig_Ext_On()
    gg_trg_Ext_On = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_Ext_On, __jreal(65.00))
    TriggerAddAction(gg_trg_Ext_On, Trig_Ext_On_Actions)
end
-- END FOREST SECTION 364

-- BEGIN FOREST SECTION 365 Extermination
function Trig_Extermination_Conditions()
    return udg_StillAlive == 0
end

function Trig_Extermination_Actions()
    PlayThematicMusicBJ("UndeadVictory")
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_7280")
    DisplayTimedTextToForce(GetPlayersAll(), __jreal(120.00), "TRIGSTR_9243")
    DisableTrigger(GetTriggeringTrigger())
    TriggerSleepAction(__jreal(120.00))
    FE_Roles.finishMatch(true, "TRIGSTR_7269")
end

function InitTrig_Extermination()
    gg_trg_Extermination = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(gg_trg_Extermination, __jreal(10.00))
    TriggerAddCondition(gg_trg_Extermination, Condition(Trig_Extermination_Conditions))
    TriggerAddAction(gg_trg_Extermination, Trig_Extermination_Actions)
end
-- END FOREST SECTION 365
