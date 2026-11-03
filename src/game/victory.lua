-- game / victory
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 351 Ignite_Dies
-- Original JASS function: Trig_Ignite_Dies_Conditions (line 19435)
function Trig_Ignite_Dies_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("O004"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Ignite_Dies_Actions (line 19442)
function Trig_Ignite_Dies_Actions()
    DisableTrigger(gg_trg_Ancient_Leaves)
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_302")
    PlayThematicMusicBJ("HeroicVictory")
    TriggerSleepAction(__jreal(3.00))
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_5283")
    DisplayTimedTextToForce(GetPlayersAll(), __jreal(120.00), "TRIGSTR_9243")
    TriggerSleepAction(__jreal(120.00))
    FE_Roles.finishMatch(false, "TRIGSTR_4301")
end

-- Original JASS function: InitTrig_Ignite_Dies (line 19463)
function InitTrig_Ignite_Dies()
    gg_trg_Ignite_Dies = CreateTrigger()
    FE_Roles.registerAncientUnitEvent(gg_trg_Ignite_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Ignite_Dies, Condition(Trig_Ignite_Dies_Conditions))
    TriggerAddAction(gg_trg_Ignite_Dies, Trig_Ignite_Dies_Actions)
end
-- END FOREST SECTION 351

-- BEGIN FOREST SECTION 352 Avalanche_Dies
-- Original JASS function: Trig_Avalanche_Dies_Conditions (line 19473)
function Trig_Avalanche_Dies_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("O008"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Avalanche_Dies_Actions (line 19480)
function Trig_Avalanche_Dies_Actions()
    DisableTrigger(gg_trg_Ancient_Leaves)
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_446")
    PlayThematicMusicBJ("HeroicVictory")
    TriggerSleepAction(__jreal(3.00))
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_5283")
    DisplayTimedTextToForce(GetPlayersAll(), __jreal(120.00), "TRIGSTR_9243")
    TriggerSleepAction(__jreal(120.00))
    FE_Roles.finishMatch(false, "TRIGSTR_4301")
end

-- Original JASS function: InitTrig_Avalanche_Dies (line 19501)
function InitTrig_Avalanche_Dies()
    gg_trg_Avalanche_Dies = CreateTrigger()
    FE_Roles.registerAncientUnitEvent(gg_trg_Avalanche_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Avalanche_Dies, Condition(Trig_Avalanche_Dies_Conditions))
    TriggerAddAction(gg_trg_Avalanche_Dies, Trig_Avalanche_Dies_Actions)
end
-- END FOREST SECTION 352

-- BEGIN FOREST SECTION 353 Paranoia_Dies
-- Original JASS function: Trig_Paranoia_Dies_Conditions (line 19511)
function Trig_Paranoia_Dies_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("O00A"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Paranoia_Dies_Actions (line 19518)
function Trig_Paranoia_Dies_Actions()
    DisableTrigger(gg_trg_Ancient_Leaves)
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_418")
    PlayThematicMusicBJ("HeroicVictory")
    TriggerSleepAction(__jreal(3.00))
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_5283")
    DisplayTimedTextToForce(GetPlayersAll(), __jreal(120.00), "TRIGSTR_9243")
    TriggerSleepAction(__jreal(120.00))
    FE_Roles.finishMatch(false, "TRIGSTR_4301")
end

-- Original JASS function: InitTrig_Paranoia_Dies (line 19539)
function InitTrig_Paranoia_Dies()
    gg_trg_Paranoia_Dies = CreateTrigger()
    FE_Roles.registerAncientUnitEvent(gg_trg_Paranoia_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Paranoia_Dies, Condition(Trig_Paranoia_Dies_Conditions))
    TriggerAddAction(gg_trg_Paranoia_Dies, Trig_Paranoia_Dies_Actions)
end
-- END FOREST SECTION 353

-- BEGIN FOREST SECTION 354 Eternity_Dies
-- Original JASS function: Trig_Eternity_Dies_Conditions (line 19549)
function Trig_Eternity_Dies_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("O00D"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Eternity_Dies_Actions (line 19556)
function Trig_Eternity_Dies_Actions()
    DisableTrigger(gg_trg_Ancient_Leaves)
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_680")
    PlayThematicMusicBJ("HeroicVictory")
    TriggerSleepAction(__jreal(3.00))
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_5283")
    DisplayTimedTextToForce(GetPlayersAll(), __jreal(120.00), "TRIGSTR_9243")
    TriggerSleepAction(__jreal(120.00))
    FE_Roles.finishMatch(false, "TRIGSTR_4301")
end

-- Original JASS function: InitTrig_Eternity_Dies (line 19577)
function InitTrig_Eternity_Dies()
    gg_trg_Eternity_Dies = CreateTrigger()
    FE_Roles.registerAncientUnitEvent(gg_trg_Eternity_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Eternity_Dies, Condition(Trig_Eternity_Dies_Conditions))
    TriggerAddAction(gg_trg_Eternity_Dies, Trig_Eternity_Dies_Actions)
end
-- END FOREST SECTION 354

-- BEGIN FOREST SECTION 355 Dragos_Dies
-- Original JASS function: Trig_Dragos_Dies_Conditions (line 19587)
function Trig_Dragos_Dies_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("O00S"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Dragos_Dies_Actions (line 19594)
function Trig_Dragos_Dies_Actions()
    DisableTrigger(gg_trg_Ancient_Leaves)
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_2030")
    PlayThematicMusicBJ("HeroicVictory")
    TriggerSleepAction(__jreal(3.00))
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_5283")
    DisplayTimedTextToForce(GetPlayersAll(), __jreal(120.00), "TRIGSTR_9243")
    TriggerSleepAction(__jreal(120.00))
    FE_Roles.finishMatch(false, "TRIGSTR_4301")
end

-- Original JASS function: InitTrig_Dragos_Dies (line 19616)
function InitTrig_Dragos_Dies()
    gg_trg_Dragos_Dies = CreateTrigger()
    FE_Roles.registerAncientUnitEvent(gg_trg_Dragos_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Dragos_Dies, Condition(Trig_Dragos_Dies_Conditions))
    TriggerAddAction(gg_trg_Dragos_Dies, Trig_Dragos_Dies_Actions)
end
-- END FOREST SECTION 355

-- BEGIN FOREST SECTION 356 Tremor_Dies
-- Original JASS function: Trig_Tremor_Dies_Conditions (line 19626)
function Trig_Tremor_Dies_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("O00L"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Tremor_Dies_Actions (line 19633)
function Trig_Tremor_Dies_Actions()
    DisableTrigger(gg_trg_Ancient_Leaves)
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_1475")
    PlayThematicMusicBJ("HeroicVictory")
    TriggerSleepAction(__jreal(3.00))
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_5283")
    DisplayTimedTextToForce(GetPlayersAll(), __jreal(120.00), "TRIGSTR_9243")
    TriggerSleepAction(__jreal(120.00))
    FE_Roles.finishMatch(false, "TRIGSTR_4301")
end

-- Original JASS function: InitTrig_Tremor_Dies (line 19655)
function InitTrig_Tremor_Dies()
    gg_trg_Tremor_Dies = CreateTrigger()
    FE_Roles.registerAncientUnitEvent(gg_trg_Tremor_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Tremor_Dies, Condition(Trig_Tremor_Dies_Conditions))
    TriggerAddAction(gg_trg_Tremor_Dies, Trig_Tremor_Dies_Actions)
end
-- END FOREST SECTION 356

-- BEGIN FOREST SECTION 357 Zalxon_Dies
-- Original JASS function: Trig_Zalxon_Dies_Conditions (line 19665)
function Trig_Zalxon_Dies_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("O016"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Zalxon_Dies_Actions (line 19672)
function Trig_Zalxon_Dies_Actions()
    DisableTrigger(gg_trg_Ancient_Leaves)
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_3657")
    PlayThematicMusicBJ("HeroicVictory")
    TriggerSleepAction(__jreal(3.00))
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_5283")
    DisplayTimedTextToForce(GetPlayersAll(), __jreal(120.00), "TRIGSTR_9243")
    TriggerSleepAction(__jreal(120.00))
    FE_Roles.finishMatch(false, "TRIGSTR_4301")
end

-- Original JASS function: InitTrig_Zalxon_Dies (line 19694)
function InitTrig_Zalxon_Dies()
    gg_trg_Zalxon_Dies = CreateTrigger()
    FE_Roles.registerAncientUnitEvent(gg_trg_Zalxon_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Zalxon_Dies, Condition(Trig_Zalxon_Dies_Conditions))
    TriggerAddAction(gg_trg_Zalxon_Dies, Trig_Zalxon_Dies_Actions)
end
-- END FOREST SECTION 357

-- BEGIN FOREST SECTION 358 Divinity_Dies
-- Original JASS function: Trig_Divinity_Dies_Conditions (line 19704)
function Trig_Divinity_Dies_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("O01V"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Divinity_Dies_Actions (line 19711)
function Trig_Divinity_Dies_Actions()
    DisableTrigger(gg_trg_Ancient_Leaves)
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_7140")
    PlayThematicMusicBJ("HeroicVictory")
    TriggerSleepAction(__jreal(3.00))
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_5283")
    DisplayTimedTextToForce(GetPlayersAll(), __jreal(120.00), "TRIGSTR_9243")
    TriggerSleepAction(__jreal(120.00))
    FE_Roles.finishMatch(false, "TRIGSTR_4301")
end

-- Original JASS function: InitTrig_Divinity_Dies (line 19733)
function InitTrig_Divinity_Dies()
    gg_trg_Divinity_Dies = CreateTrigger()
    FE_Roles.registerAncientUnitEvent(gg_trg_Divinity_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Divinity_Dies, Condition(Trig_Divinity_Dies_Conditions))
    TriggerAddAction(gg_trg_Divinity_Dies, Trig_Divinity_Dies_Actions)
end
-- END FOREST SECTION 358

-- BEGIN FOREST SECTION 359 Pharoah_Dies
-- Original JASS function: Trig_Pharoah_Dies_Conditions (line 19743)
function Trig_Pharoah_Dies_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("O01X"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Pharoah_Dies_Actions (line 19750)
function Trig_Pharoah_Dies_Actions()
    DisableTrigger(gg_trg_Ancient_Leaves)
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_8363")
    PlayThematicMusicBJ("HeroicVictory")
    TriggerSleepAction(__jreal(3.00))
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_5283")
    DisplayTimedTextToForce(GetPlayersAll(), __jreal(120.00), "TRIGSTR_9243")
    TriggerSleepAction(__jreal(120.00))
    FE_Roles.finishMatch(false, "TRIGSTR_4301")
end

-- Original JASS function: InitTrig_Pharoah_Dies (line 19772)
function InitTrig_Pharoah_Dies()
    gg_trg_Pharoah_Dies = CreateTrigger()
    FE_Roles.registerAncientUnitEvent(gg_trg_Pharoah_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Pharoah_Dies, Condition(Trig_Pharoah_Dies_Conditions))
    TriggerAddAction(gg_trg_Pharoah_Dies, Trig_Pharoah_Dies_Actions)
end
-- END FOREST SECTION 359

-- BEGIN FOREST SECTION 360 Nebula_Dies
-- Original JASS function: Trig_Nebula_Dies_Conditions (line 19782)
function Trig_Nebula_Dies_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("O01Z"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Nebula_Dies_Actions (line 19789)
function Trig_Nebula_Dies_Actions()
    DisableTrigger(gg_trg_Ancient_Leaves)
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_9096")
    PlayThematicMusicBJ("HeroicVictory")
    TriggerSleepAction(__jreal(3.00))
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_5283")
    DisplayTimedTextToForce(GetPlayersAll(), __jreal(120.00), "TRIGSTR_9243")
    TriggerSleepAction(__jreal(120.00))
    FE_Roles.finishMatch(false, "TRIGSTR_4301")
end

-- Original JASS function: InitTrig_Nebula_Dies (line 19811)
function InitTrig_Nebula_Dies()
    gg_trg_Nebula_Dies = CreateTrigger()
    FE_Roles.registerAncientUnitEvent(gg_trg_Nebula_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Nebula_Dies, Condition(Trig_Nebula_Dies_Conditions))
    TriggerAddAction(gg_trg_Nebula_Dies, Trig_Nebula_Dies_Actions)
end
-- END FOREST SECTION 360

-- BEGIN FOREST SECTION 361 Wispari_Dies
-- Original JASS function: Trig_Wispari_Dies_Conditions (line 19821)
function Trig_Wispari_Dies_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("O01D"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Wispari_Dies_Actions (line 19828)
function Trig_Wispari_Dies_Actions()
    DisableTrigger(gg_trg_Ancient_Leaves)
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_4300")
    PlayThematicMusicBJ("HeroicVictory")
    TriggerSleepAction(__jreal(3.00))
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_5283")
    DisplayTimedTextToForce(GetPlayersAll(), __jreal(120.00), "TRIGSTR_9243")
    TriggerSleepAction(__jreal(120.00))
    FE_Roles.finishMatch(false, "TRIGSTR_4301")
end

-- Original JASS function: InitTrig_Wispari_Dies (line 19850)
function InitTrig_Wispari_Dies()
    gg_trg_Wispari_Dies = CreateTrigger()
    FE_Roles.registerAncientUnitEvent(gg_trg_Wispari_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Wispari_Dies, Condition(Trig_Wispari_Dies_Conditions))
    TriggerAddAction(gg_trg_Wispari_Dies, Trig_Wispari_Dies_Actions)
end
-- END FOREST SECTION 361

-- BEGIN FOREST SECTION 362 Remove_Resources_new
-- Original JASS function: Trig_Remove_Resources_new_Func001Func001C (line 19862)
function Trig_Remove_Resources_new_Func001Func001C()
    if ((not ((GetEnumPlayer() ~= FE_Roles.ancient())))) then
        do return false end
    end
    if ((not ((IsPlayerAlly(GetEnumPlayer(), FE_Roles.ancient()) == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Remove_Resources_new_Func001A (line 19872)
function Trig_Remove_Resources_new_Func001A()
    if (Trig_Remove_Resources_new_Func001Func001C()) then
        SetPlayerStateBJ(GetEnumPlayer(), PLAYER_STATE_RESOURCE_GOLD, 0)
        SetPlayerStateBJ(GetEnumPlayer(), PLAYER_STATE_RESOURCE_LUMBER, 0)
    else
        DoNothing()
    end
end

-- Original JASS function: Trig_Remove_Resources_new_Actions (line 19881)
function Trig_Remove_Resources_new_Actions()
    ForForce(GetPlayersAll(), Trig_Remove_Resources_new_Func001A)
end

-- Original JASS function: InitTrig_Remove_Resources_new (line 19886)
function InitTrig_Remove_Resources_new()
    gg_trg_Remove_Resources_new = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(gg_trg_Remove_Resources_new, __jreal(0.50))
    TriggerAddAction(gg_trg_Remove_Resources_new, Trig_Remove_Resources_new_Actions)
end
-- END FOREST SECTION 362

-- BEGIN FOREST SECTION 363 DVIC_1
-- Original JASS function: Trig_DVIC_1_Conditions (line 19895)
function Trig_DVIC_1_Conditions()
    if ((not ((GetUnitLevel(GetLevelingUnit()) == 20)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_DVIC_1_Actions (line 19902)
function Trig_DVIC_1_Actions()
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_7267")
    PlayThematicMusicBJ("UndeadVictory")
    TriggerSleepAction(__jreal(3.00))
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_7268")
    DisplayTimedTextToForce(GetPlayersAll(), __jreal(120.00), "TRIGSTR_9243")
    TriggerSleepAction(__jreal(120.00))
    FE_Roles.finishMatch(true, "TRIGSTR_7269")
end

-- Original JASS function: InitTrig_DVIC_1 (line 19923)
function InitTrig_DVIC_1()
    gg_trg_DVIC_1 = CreateTrigger()
    FE_Roles.registerAncientUnitEvent(gg_trg_DVIC_1, EVENT_PLAYER_HERO_LEVEL)
    TriggerAddCondition(gg_trg_DVIC_1, Condition(Trig_DVIC_1_Conditions))
    TriggerAddAction(gg_trg_DVIC_1, Trig_DVIC_1_Actions)
end
-- END FOREST SECTION 363

-- BEGIN FOREST SECTION 364 Ext_On
-- Original JASS function: Trig_Ext_On_Actions (line 19933)
function Trig_Ext_On_Actions()
    EnableTrigger(gg_trg_Extermination)
end

-- Original JASS function: InitTrig_Ext_On (line 19938)
function InitTrig_Ext_On()
    gg_trg_Ext_On = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_Ext_On, __jreal(65.00))
    TriggerAddAction(gg_trg_Ext_On, Trig_Ext_On_Actions)
end
-- END FOREST SECTION 364

-- BEGIN FOREST SECTION 365 Extermination
-- Original JASS function: Trig_Extermination_Conditions (line 19947)
function Trig_Extermination_Conditions()
    if ((not ((udg_StillAlive == 0)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Extermination_Actions (line 19954)
function Trig_Extermination_Actions()
    PlayThematicMusicBJ("UndeadVictory")
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_7280")
    DisplayTimedTextToForce(GetPlayersAll(), __jreal(120.00), "TRIGSTR_9243")
    DisableTrigger(GetTriggeringTrigger())
    TriggerSleepAction(__jreal(120.00))
    FE_Roles.finishMatch(true, "TRIGSTR_7269")
end

-- Original JASS function: InitTrig_Extermination (line 19974)
function InitTrig_Extermination()
    gg_trg_Extermination = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(gg_trg_Extermination, __jreal(10.00))
    TriggerAddCondition(gg_trg_Extermination, Condition(Trig_Extermination_Conditions))
    TriggerAddAction(gg_trg_Extermination, Trig_Extermination_Actions)
end
-- END FOREST SECTION 365
