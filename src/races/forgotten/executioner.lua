-- races / forgotten / executioner
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 65 Coup_de_grace
-- Original JASS function: Trig_Coup_de_grace_Conditions (line 8096)
function Trig_Coup_de_grace_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A05X"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Coup_de_grace_Actions (line 8103)
function Trig_Coup_de_grace_Actions()
    SetUnitLifeBJ(GetSpellTargetUnit(), (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, GetSpellTargetUnit()) - (__jreal(GetUnitStateSwap(UNIT_STATE_MAX_LIFE, GetSpellTargetUnit()) * __jreal(0.10))))))
end

-- Original JASS function: InitTrig_Coup_de_grace (line 8108)
function InitTrig_Coup_de_grace()
    gg_trg_Coup_de_grace = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Coup_de_grace, EVENT_PLAYER_UNIT_SPELL_CAST)
    TriggerAddCondition(gg_trg_Coup_de_grace, Condition(Trig_Coup_de_grace_Conditions))
    TriggerAddAction(gg_trg_Coup_de_grace, Trig_Coup_de_grace_Actions)
end
-- END FOREST SECTION 65

-- BEGIN FOREST SECTION 66 Surge_of_Darkness
-- Original JASS function: Trig_Surge_of_Darkness_Conditions (line 8118)
function Trig_Surge_of_Darkness_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A060"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Surge_of_Darkness_Actions (line 8125)
function Trig_Surge_of_Darkness_Actions()
    UnitAddAbilityBJ(FourCC("A079"), GetTriggerUnit())
    TriggerSleepAction(__jreal(5.00))
    UnitRemoveAbilityBJ(FourCC("A079"), GetTriggerUnit())
end

-- Original JASS function: InitTrig_Surge_of_Darkness (line 8132)
function InitTrig_Surge_of_Darkness()
    gg_trg_Surge_of_Darkness = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Surge_of_Darkness, EVENT_PLAYER_UNIT_SPELL_CAST)
    TriggerAddCondition(gg_trg_Surge_of_Darkness, Condition(Trig_Surge_of_Darkness_Conditions))
    TriggerAddAction(gg_trg_Surge_of_Darkness, Trig_Surge_of_Darkness_Actions)
end
-- END FOREST SECTION 66

-- BEGIN FOREST SECTION 67 Focused_Anger_1
-- Original JASS function: Trig_Focused_Anger_1_Conditions (line 8142)
function Trig_Focused_Anger_1_Conditions()
    if ((not ((GetUnitTypeId(GetAttacker()) == FourCC("u00B"))))) then
        do return false end
    end
    if ((not ((GetOwningPlayer(GetAttacker()) == Player(0))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Focused_Anger_1_Func001C (line 8152)
function Trig_Focused_Anger_1_Func001C()
    return FE_FocusedAnger.count(GetAttacker()) >= 15
end

-- Original JASS function: Trig_Focused_Anger_1_Actions (line 8159)
function Trig_Focused_Anger_1_Actions()
    FE_FocusedAnger.add(GetAttacker())
end

-- Original JASS function: InitTrig_Focused_Anger_1 (line 8172)
function InitTrig_Focused_Anger_1()
    gg_trg_Focused_Anger_1 = CreateTrigger()
    DisableTrigger(gg_trg_Focused_Anger_1)
    FE_Roles.registerAncientUnitEvent(gg_trg_Focused_Anger_1, EVENT_PLAYER_UNIT_ATTACKED)
    TriggerAddCondition(gg_trg_Focused_Anger_1, Condition(Trig_Focused_Anger_1_Conditions))
    TriggerAddAction(gg_trg_Focused_Anger_1, Trig_Focused_Anger_1_Actions)
end
-- END FOREST SECTION 67

-- BEGIN FOREST SECTION 68 Focused_Anger_2
-- Original JASS function: Trig_Focused_Anger_2_Conditions (line 8183)
function Trig_Focused_Anger_2_Conditions()
    if ((not ((GetUnitTypeId(GetAttacker()) == FourCC("u00B"))))) then
        do return false end
    end
    if ((not ((GetOwningPlayer(GetAttacker()) == Player(1))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Focused_Anger_2_Func001C (line 8193)
function Trig_Focused_Anger_2_Func001C()
    return FE_FocusedAnger.count(GetAttacker()) >= 15
end

-- Original JASS function: Trig_Focused_Anger_2_Actions (line 8200)
function Trig_Focused_Anger_2_Actions()
    FE_FocusedAnger.add(GetAttacker())
end

-- Original JASS function: InitTrig_Focused_Anger_2 (line 8213)
function InitTrig_Focused_Anger_2()
    gg_trg_Focused_Anger_2 = CreateTrigger()
    DisableTrigger(gg_trg_Focused_Anger_2)
    FE_Roles.registerAncientUnitEvent(gg_trg_Focused_Anger_2, EVENT_PLAYER_UNIT_ATTACKED)
    TriggerAddCondition(gg_trg_Focused_Anger_2, Condition(Trig_Focused_Anger_2_Conditions))
    TriggerAddAction(gg_trg_Focused_Anger_2, Trig_Focused_Anger_2_Actions)
end
-- END FOREST SECTION 68

-- BEGIN FOREST SECTION 69 Focused_Anger_3
-- Original JASS function: Trig_Focused_Anger_3_Conditions (line 8224)
function Trig_Focused_Anger_3_Conditions()
    if ((not ((GetUnitTypeId(GetAttacker()) == FourCC("u00B"))))) then
        do return false end
    end
    if ((not ((GetOwningPlayer(GetAttacker()) == Player(2))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Focused_Anger_3_Func001C (line 8234)
function Trig_Focused_Anger_3_Func001C()
    return FE_FocusedAnger.count(GetAttacker()) >= 15
end

-- Original JASS function: Trig_Focused_Anger_3_Actions (line 8241)
function Trig_Focused_Anger_3_Actions()
    FE_FocusedAnger.add(GetAttacker())
end

-- Original JASS function: InitTrig_Focused_Anger_3 (line 8254)
function InitTrig_Focused_Anger_3()
    gg_trg_Focused_Anger_3 = CreateTrigger()
    DisableTrigger(gg_trg_Focused_Anger_3)
    FE_Roles.registerAncientUnitEvent(gg_trg_Focused_Anger_3, EVENT_PLAYER_UNIT_ATTACKED)
    TriggerAddCondition(gg_trg_Focused_Anger_3, Condition(Trig_Focused_Anger_3_Conditions))
    TriggerAddAction(gg_trg_Focused_Anger_3, Trig_Focused_Anger_3_Actions)
end
-- END FOREST SECTION 69

-- BEGIN FOREST SECTION 70 Focused_Anger_4
-- Original JASS function: Trig_Focused_Anger_4_Conditions (line 8265)
function Trig_Focused_Anger_4_Conditions()
    if ((not ((GetUnitTypeId(GetAttacker()) == FourCC("u00B"))))) then
        do return false end
    end
    if ((not ((GetOwningPlayer(GetAttacker()) == Player(3))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Focused_Anger_4_Func001C (line 8275)
function Trig_Focused_Anger_4_Func001C()
    return FE_FocusedAnger.count(GetAttacker()) >= 15
end

-- Original JASS function: Trig_Focused_Anger_4_Actions (line 8282)
function Trig_Focused_Anger_4_Actions()
    FE_FocusedAnger.add(GetAttacker())
end

-- Original JASS function: InitTrig_Focused_Anger_4 (line 8295)
function InitTrig_Focused_Anger_4()
    gg_trg_Focused_Anger_4 = CreateTrigger()
    DisableTrigger(gg_trg_Focused_Anger_4)
    FE_Roles.registerAncientUnitEvent(gg_trg_Focused_Anger_4, EVENT_PLAYER_UNIT_ATTACKED)
    TriggerAddCondition(gg_trg_Focused_Anger_4, Condition(Trig_Focused_Anger_4_Conditions))
    TriggerAddAction(gg_trg_Focused_Anger_4, Trig_Focused_Anger_4_Actions)
end
-- END FOREST SECTION 70

-- BEGIN FOREST SECTION 71 Focused_Anger_5
-- Original JASS function: Trig_Focused_Anger_5_Conditions (line 8306)
function Trig_Focused_Anger_5_Conditions()
    if ((not ((GetUnitTypeId(GetAttacker()) == FourCC("u00B"))))) then
        do return false end
    end
    if ((not ((GetOwningPlayer(GetAttacker()) == Player(4))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Focused_Anger_5_Func001C (line 8316)
function Trig_Focused_Anger_5_Func001C()
    return FE_FocusedAnger.count(GetAttacker()) >= 15
end

-- Original JASS function: Trig_Focused_Anger_5_Actions (line 8323)
function Trig_Focused_Anger_5_Actions()
    FE_FocusedAnger.add(GetAttacker())
end

-- Original JASS function: InitTrig_Focused_Anger_5 (line 8336)
function InitTrig_Focused_Anger_5()
    gg_trg_Focused_Anger_5 = CreateTrigger()
    DisableTrigger(gg_trg_Focused_Anger_5)
    FE_Roles.registerAncientUnitEvent(gg_trg_Focused_Anger_5, EVENT_PLAYER_UNIT_ATTACKED)
    TriggerAddCondition(gg_trg_Focused_Anger_5, Condition(Trig_Focused_Anger_5_Conditions))
    TriggerAddAction(gg_trg_Focused_Anger_5, Trig_Focused_Anger_5_Actions)
end
-- END FOREST SECTION 71

-- BEGIN FOREST SECTION 72 Focused_Anger_6
-- Original JASS function: Trig_Focused_Anger_6_Conditions (line 8347)
function Trig_Focused_Anger_6_Conditions()
    if ((not ((GetUnitTypeId(GetAttacker()) == FourCC("u00B"))))) then
        do return false end
    end
    if ((not ((GetOwningPlayer(GetAttacker()) == Player(5))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Focused_Anger_6_Func001C (line 8357)
function Trig_Focused_Anger_6_Func001C()
    return FE_FocusedAnger.count(GetAttacker()) >= 15
end

-- Original JASS function: Trig_Focused_Anger_6_Actions (line 8364)
function Trig_Focused_Anger_6_Actions()
    FE_FocusedAnger.add(GetAttacker())
end

-- Original JASS function: InitTrig_Focused_Anger_6 (line 8377)
function InitTrig_Focused_Anger_6()
    gg_trg_Focused_Anger_6 = CreateTrigger()
    DisableTrigger(gg_trg_Focused_Anger_6)
    FE_Roles.registerAncientUnitEvent(gg_trg_Focused_Anger_6, EVENT_PLAYER_UNIT_ATTACKED)
    TriggerAddCondition(gg_trg_Focused_Anger_6, Condition(Trig_Focused_Anger_6_Conditions))
    TriggerAddAction(gg_trg_Focused_Anger_6, Trig_Focused_Anger_6_Actions)
end
-- END FOREST SECTION 72

-- BEGIN FOREST SECTION 73 Focused_Anger_7
-- Original JASS function: Trig_Focused_Anger_7_Conditions (line 8388)
function Trig_Focused_Anger_7_Conditions()
    if ((not ((GetUnitTypeId(GetAttacker()) == FourCC("u00B"))))) then
        do return false end
    end
    if ((not ((GetOwningPlayer(GetAttacker()) == Player(7))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Focused_Anger_7_Func001C (line 8398)
function Trig_Focused_Anger_7_Func001C()
    return FE_FocusedAnger.count(GetAttacker()) >= 15
end

-- Original JASS function: Trig_Focused_Anger_7_Actions (line 8405)
function Trig_Focused_Anger_7_Actions()
    FE_FocusedAnger.add(GetAttacker())
end

-- Original JASS function: InitTrig_Focused_Anger_7 (line 8418)
function InitTrig_Focused_Anger_7()
    gg_trg_Focused_Anger_7 = CreateTrigger()
    DisableTrigger(gg_trg_Focused_Anger_7)
    FE_Roles.registerAncientUnitEvent(gg_trg_Focused_Anger_7, EVENT_PLAYER_UNIT_ATTACKED)
    TriggerAddCondition(gg_trg_Focused_Anger_7, Condition(Trig_Focused_Anger_7_Conditions))
    TriggerAddAction(gg_trg_Focused_Anger_7, Trig_Focused_Anger_7_Actions)
end
-- END FOREST SECTION 73

-- BEGIN FOREST SECTION 74 Focused_Anger_8
-- Original JASS function: Trig_Focused_Anger_8_Conditions (line 8429)
function Trig_Focused_Anger_8_Conditions()
    if ((not ((GetUnitTypeId(GetAttacker()) == FourCC("u00B"))))) then
        do return false end
    end
    if ((not ((GetOwningPlayer(GetAttacker()) == Player(8))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Focused_Anger_8_Func001C (line 8439)
function Trig_Focused_Anger_8_Func001C()
    return FE_FocusedAnger.count(GetAttacker()) >= 15
end

-- Original JASS function: Trig_Focused_Anger_8_Actions (line 8446)
function Trig_Focused_Anger_8_Actions()
    FE_FocusedAnger.add(GetAttacker())
end

-- Original JASS function: InitTrig_Focused_Anger_8 (line 8459)
function InitTrig_Focused_Anger_8()
    gg_trg_Focused_Anger_8 = CreateTrigger()
    DisableTrigger(gg_trg_Focused_Anger_8)
    FE_Roles.registerAncientUnitEvent(gg_trg_Focused_Anger_8, EVENT_PLAYER_UNIT_ATTACKED)
    TriggerAddCondition(gg_trg_Focused_Anger_8, Condition(Trig_Focused_Anger_8_Conditions))
    TriggerAddAction(gg_trg_Focused_Anger_8, Trig_Focused_Anger_8_Actions)
end
-- END FOREST SECTION 74

-- BEGIN FOREST SECTION 75 Focused_Anger_9
-- Original JASS function: Trig_Focused_Anger_9_Conditions (line 8470)
function Trig_Focused_Anger_9_Conditions()
    if ((not ((GetUnitTypeId(GetAttacker()) == FourCC("u00B"))))) then
        do return false end
    end
    if ((not ((GetOwningPlayer(GetAttacker()) == Player(9))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Focused_Anger_9_Func001C (line 8480)
function Trig_Focused_Anger_9_Func001C()
    return FE_FocusedAnger.count(GetAttacker()) >= 15
end

-- Original JASS function: Trig_Focused_Anger_9_Actions (line 8487)
function Trig_Focused_Anger_9_Actions()
    FE_FocusedAnger.add(GetAttacker())
end

-- Original JASS function: InitTrig_Focused_Anger_9 (line 8500)
function InitTrig_Focused_Anger_9()
    gg_trg_Focused_Anger_9 = CreateTrigger()
    DisableTrigger(gg_trg_Focused_Anger_9)
    FE_Roles.registerAncientUnitEvent(gg_trg_Focused_Anger_9, EVENT_PLAYER_UNIT_ATTACKED)
    TriggerAddCondition(gg_trg_Focused_Anger_9, Condition(Trig_Focused_Anger_9_Conditions))
    TriggerAddAction(gg_trg_Focused_Anger_9, Trig_Focused_Anger_9_Actions)
end
-- END FOREST SECTION 75

-- BEGIN FOREST SECTION 76 Focused_Anger_10
-- Original JASS function: Trig_Focused_Anger_10_Conditions (line 8511)
function Trig_Focused_Anger_10_Conditions()
    if ((not ((GetUnitTypeId(GetAttacker()) == FourCC("u00B"))))) then
        do return false end
    end
    if ((not ((GetOwningPlayer(GetAttacker()) == Player(10))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Focused_Anger_10_Func001C (line 8521)
function Trig_Focused_Anger_10_Func001C()
    return FE_FocusedAnger.count(GetAttacker()) >= 15
end

-- Original JASS function: Trig_Focused_Anger_10_Actions (line 8528)
function Trig_Focused_Anger_10_Actions()
    FE_FocusedAnger.add(GetAttacker())
end

-- Original JASS function: InitTrig_Focused_Anger_10 (line 8541)
function InitTrig_Focused_Anger_10()
    gg_trg_Focused_Anger_10 = CreateTrigger()
    DisableTrigger(gg_trg_Focused_Anger_10)
    FE_Roles.registerAncientUnitEvent(gg_trg_Focused_Anger_10, EVENT_PLAYER_UNIT_ATTACKED)
    TriggerAddCondition(gg_trg_Focused_Anger_10, Condition(Trig_Focused_Anger_10_Conditions))
    TriggerAddAction(gg_trg_Focused_Anger_10, Trig_Focused_Anger_10_Actions)
end
-- END FOREST SECTION 76

-- BEGIN FOREST SECTION 77 Focused_Anger_Trigger
-- Original JASS function: Trig_Focused_Anger_Trigger_Conditions (line 8552)
function Trig_Focused_Anger_Trigger_Conditions()
    if ((not ((GetResearched() == FourCC("R04T"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Focused_Anger_Trigger_Actions (line 8559)
function Trig_Focused_Anger_Trigger_Actions()
    EnableTrigger(gg_trg_Focused_Anger_1)
end

-- Original JASS function: InitTrig_Focused_Anger_Trigger (line 8564)
function InitTrig_Focused_Anger_Trigger()
    gg_trg_Focused_Anger_Trigger = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Focused_Anger_Trigger, Player(0), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Focused_Anger_Trigger, Condition(Trig_Focused_Anger_Trigger_Conditions))
    TriggerAddAction(gg_trg_Focused_Anger_Trigger, Trig_Focused_Anger_Trigger_Actions)
end
-- END FOREST SECTION 77

-- BEGIN FOREST SECTION 78 Focused_Anger_Trigger_Copy
-- Original JASS function: Trig_Focused_Anger_Trigger_Copy_Conditions (line 8574)
function Trig_Focused_Anger_Trigger_Copy_Conditions()
    if ((not ((GetResearched() == FourCC("R04T"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Focused_Anger_Trigger_Copy_Actions (line 8581)
function Trig_Focused_Anger_Trigger_Copy_Actions()
    EnableTrigger(gg_trg_Focused_Anger_2)
end

-- Original JASS function: InitTrig_Focused_Anger_Trigger_Copy (line 8586)
function InitTrig_Focused_Anger_Trigger_Copy()
    gg_trg_Focused_Anger_Trigger_Copy = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Focused_Anger_Trigger_Copy, Player(1), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Focused_Anger_Trigger_Copy, Condition(Trig_Focused_Anger_Trigger_Copy_Conditions))
    TriggerAddAction(gg_trg_Focused_Anger_Trigger_Copy, Trig_Focused_Anger_Trigger_Copy_Actions)
end
-- END FOREST SECTION 78

-- BEGIN FOREST SECTION 79 Focused_Anger_Trigger_Copy_2
-- Original JASS function: Trig_Focused_Anger_Trigger_Copy_2_Conditions (line 8596)
function Trig_Focused_Anger_Trigger_Copy_2_Conditions()
    if ((not ((GetResearched() == FourCC("R04T"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Focused_Anger_Trigger_Copy_2_Actions (line 8603)
function Trig_Focused_Anger_Trigger_Copy_2_Actions()
    EnableTrigger(gg_trg_Focused_Anger_3)
end

-- Original JASS function: InitTrig_Focused_Anger_Trigger_Copy_2 (line 8608)
function InitTrig_Focused_Anger_Trigger_Copy_2()
    gg_trg_Focused_Anger_Trigger_Copy_2 = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Focused_Anger_Trigger_Copy_2, Player(2), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Focused_Anger_Trigger_Copy_2, Condition(Trig_Focused_Anger_Trigger_Copy_2_Conditions))
    TriggerAddAction(gg_trg_Focused_Anger_Trigger_Copy_2, Trig_Focused_Anger_Trigger_Copy_2_Actions)
end
-- END FOREST SECTION 79

-- BEGIN FOREST SECTION 80 Focused_Anger_Trigger_Copy_3
-- Original JASS function: Trig_Focused_Anger_Trigger_Copy_3_Conditions (line 8618)
function Trig_Focused_Anger_Trigger_Copy_3_Conditions()
    if ((not ((GetResearched() == FourCC("R04T"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Focused_Anger_Trigger_Copy_3_Actions (line 8625)
function Trig_Focused_Anger_Trigger_Copy_3_Actions()
    EnableTrigger(gg_trg_Focused_Anger_4)
end

-- Original JASS function: InitTrig_Focused_Anger_Trigger_Copy_3 (line 8630)
function InitTrig_Focused_Anger_Trigger_Copy_3()
    gg_trg_Focused_Anger_Trigger_Copy_3 = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Focused_Anger_Trigger_Copy_3, Player(3), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Focused_Anger_Trigger_Copy_3, Condition(Trig_Focused_Anger_Trigger_Copy_3_Conditions))
    TriggerAddAction(gg_trg_Focused_Anger_Trigger_Copy_3, Trig_Focused_Anger_Trigger_Copy_3_Actions)
end
-- END FOREST SECTION 80

-- BEGIN FOREST SECTION 81 Focused_Anger_Trigger_Copy_4
-- Original JASS function: Trig_Focused_Anger_Trigger_Copy_4_Conditions (line 8640)
function Trig_Focused_Anger_Trigger_Copy_4_Conditions()
    if ((not ((GetResearched() == FourCC("R04T"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Focused_Anger_Trigger_Copy_4_Actions (line 8647)
function Trig_Focused_Anger_Trigger_Copy_4_Actions()
    EnableTrigger(gg_trg_Focused_Anger_5)
end

-- Original JASS function: InitTrig_Focused_Anger_Trigger_Copy_4 (line 8652)
function InitTrig_Focused_Anger_Trigger_Copy_4()
    gg_trg_Focused_Anger_Trigger_Copy_4 = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Focused_Anger_Trigger_Copy_4, Player(4), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Focused_Anger_Trigger_Copy_4, Condition(Trig_Focused_Anger_Trigger_Copy_4_Conditions))
    TriggerAddAction(gg_trg_Focused_Anger_Trigger_Copy_4, Trig_Focused_Anger_Trigger_Copy_4_Actions)
end
-- END FOREST SECTION 81

-- BEGIN FOREST SECTION 82 Focused_Anger_Trigger_Copy_5
-- Original JASS function: Trig_Focused_Anger_Trigger_Copy_5_Conditions (line 8662)
function Trig_Focused_Anger_Trigger_Copy_5_Conditions()
    if ((not ((GetResearched() == FourCC("R04T"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Focused_Anger_Trigger_Copy_5_Actions (line 8669)
function Trig_Focused_Anger_Trigger_Copy_5_Actions()
    EnableTrigger(gg_trg_Focused_Anger_6)
end

-- Original JASS function: InitTrig_Focused_Anger_Trigger_Copy_5 (line 8674)
function InitTrig_Focused_Anger_Trigger_Copy_5()
    gg_trg_Focused_Anger_Trigger_Copy_5 = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Focused_Anger_Trigger_Copy_5, Player(5), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Focused_Anger_Trigger_Copy_5, Condition(Trig_Focused_Anger_Trigger_Copy_5_Conditions))
    TriggerAddAction(gg_trg_Focused_Anger_Trigger_Copy_5, Trig_Focused_Anger_Trigger_Copy_5_Actions)
end
-- END FOREST SECTION 82

-- BEGIN FOREST SECTION 83 Focused_Anger_Trigger_Copy_6
-- Original JASS function: Trig_Focused_Anger_Trigger_Copy_6_Conditions (line 8684)
function Trig_Focused_Anger_Trigger_Copy_6_Conditions()
    if ((not ((GetResearched() == FourCC("R04T"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Focused_Anger_Trigger_Copy_6_Actions (line 8691)
function Trig_Focused_Anger_Trigger_Copy_6_Actions()
    EnableTrigger(gg_trg_Focused_Anger_7)
end

-- Original JASS function: InitTrig_Focused_Anger_Trigger_Copy_6 (line 8696)
function InitTrig_Focused_Anger_Trigger_Copy_6()
    gg_trg_Focused_Anger_Trigger_Copy_6 = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Focused_Anger_Trigger_Copy_6, Player(7), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Focused_Anger_Trigger_Copy_6, Condition(Trig_Focused_Anger_Trigger_Copy_6_Conditions))
    TriggerAddAction(gg_trg_Focused_Anger_Trigger_Copy_6, Trig_Focused_Anger_Trigger_Copy_6_Actions)
end
-- END FOREST SECTION 83

-- BEGIN FOREST SECTION 84 Focused_Anger_Trigger_Copy_7
-- Original JASS function: Trig_Focused_Anger_Trigger_Copy_7_Conditions (line 8706)
function Trig_Focused_Anger_Trigger_Copy_7_Conditions()
    if ((not ((GetResearched() == FourCC("R04T"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Focused_Anger_Trigger_Copy_7_Actions (line 8713)
function Trig_Focused_Anger_Trigger_Copy_7_Actions()
    EnableTrigger(gg_trg_Focused_Anger_8)
end

-- Original JASS function: InitTrig_Focused_Anger_Trigger_Copy_7 (line 8718)
function InitTrig_Focused_Anger_Trigger_Copy_7()
    gg_trg_Focused_Anger_Trigger_Copy_7 = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Focused_Anger_Trigger_Copy_7, Player(8), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Focused_Anger_Trigger_Copy_7, Condition(Trig_Focused_Anger_Trigger_Copy_7_Conditions))
    TriggerAddAction(gg_trg_Focused_Anger_Trigger_Copy_7, Trig_Focused_Anger_Trigger_Copy_7_Actions)
end
-- END FOREST SECTION 84

-- BEGIN FOREST SECTION 85 Focused_Anger_Trigger_Copy_8
-- Original JASS function: Trig_Focused_Anger_Trigger_Copy_8_Conditions (line 8728)
function Trig_Focused_Anger_Trigger_Copy_8_Conditions()
    if ((not ((GetResearched() == FourCC("R04T"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Focused_Anger_Trigger_Copy_8_Actions (line 8735)
function Trig_Focused_Anger_Trigger_Copy_8_Actions()
    EnableTrigger(gg_trg_Focused_Anger_9)
end

-- Original JASS function: InitTrig_Focused_Anger_Trigger_Copy_8 (line 8740)
function InitTrig_Focused_Anger_Trigger_Copy_8()
    gg_trg_Focused_Anger_Trigger_Copy_8 = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Focused_Anger_Trigger_Copy_8, Player(9), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Focused_Anger_Trigger_Copy_8, Condition(Trig_Focused_Anger_Trigger_Copy_8_Conditions))
    TriggerAddAction(gg_trg_Focused_Anger_Trigger_Copy_8, Trig_Focused_Anger_Trigger_Copy_8_Actions)
end
-- END FOREST SECTION 85

-- BEGIN FOREST SECTION 86 Focused_Anger_Trigger_Copy_9
-- Original JASS function: Trig_Focused_Anger_Trigger_Copy_9_Conditions (line 8750)
function Trig_Focused_Anger_Trigger_Copy_9_Conditions()
    if ((not ((GetResearched() == FourCC("R04T"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Focused_Anger_Trigger_Copy_9_Actions (line 8757)
function Trig_Focused_Anger_Trigger_Copy_9_Actions()
    EnableTrigger(gg_trg_Focused_Anger_10)
end

-- Original JASS function: InitTrig_Focused_Anger_Trigger_Copy_9 (line 8762)
function InitTrig_Focused_Anger_Trigger_Copy_9()
    gg_trg_Focused_Anger_Trigger_Copy_9 = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Focused_Anger_Trigger_Copy_9, Player(10), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Focused_Anger_Trigger_Copy_9, Condition(Trig_Focused_Anger_Trigger_Copy_9_Conditions))
    TriggerAddAction(gg_trg_Focused_Anger_Trigger_Copy_9, Trig_Focused_Anger_Trigger_Copy_9_Actions)
end
-- END FOREST SECTION 86
