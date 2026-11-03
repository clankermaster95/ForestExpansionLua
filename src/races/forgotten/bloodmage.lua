-- races / forgotten / bloodmage
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 90 Acidic_Blood
-- Original JASS function: Trig_Acidic_Blood_Conditions (line 8843)
function Trig_Acidic_Blood_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A05L"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Acidic_Blood_Func001C (line 8850)
function Trig_Acidic_Blood_Func001C()
    if ((not ((GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) <= __jreal(150.00))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Acidic_Blood_Actions (line 8857)
function Trig_Acidic_Blood_Actions()
    if (Trig_Acidic_Blood_Func001C()) then
        IssueImmediateOrderBJ(GetSpellAbilityUnit(), "stop")
    else
        SetUnitLifeBJ(GetSpellAbilityUnit(), (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) - __jreal(150.00))))
    end
end

-- Original JASS function: InitTrig_Acidic_Blood (line 8866)
function InitTrig_Acidic_Blood()
    gg_trg_Acidic_Blood = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Acidic_Blood, EVENT_PLAYER_UNIT_SPELL_CAST)
    TriggerAddCondition(gg_trg_Acidic_Blood, Condition(Trig_Acidic_Blood_Conditions))
    TriggerAddAction(gg_trg_Acidic_Blood, Trig_Acidic_Blood_Actions)
end
-- END FOREST SECTION 90

-- BEGIN FOREST SECTION 91 Binding_Shadows
-- Original JASS function: Trig_Binding_Shadows_Conditions (line 8876)
function Trig_Binding_Shadows_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A05M"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Binding_Shadows_Func001C (line 8883)
function Trig_Binding_Shadows_Func001C()
    if ((not ((GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) <= __jreal(200.00))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Binding_Shadows_Actions (line 8890)
function Trig_Binding_Shadows_Actions()
    if (Trig_Binding_Shadows_Func001C()) then
        IssueImmediateOrderBJ(GetSpellAbilityUnit(), "stop")
    else
        SetUnitLifeBJ(GetSpellAbilityUnit(), (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) - __jreal(200.00))))
    end
end

-- Original JASS function: InitTrig_Binding_Shadows (line 8899)
function InitTrig_Binding_Shadows()
    gg_trg_Binding_Shadows = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Binding_Shadows, EVENT_PLAYER_UNIT_SPELL_CAST)
    TriggerAddCondition(gg_trg_Binding_Shadows, Condition(Trig_Binding_Shadows_Conditions))
    TriggerAddAction(gg_trg_Binding_Shadows, Trig_Binding_Shadows_Actions)
end
-- END FOREST SECTION 91

-- BEGIN FOREST SECTION 92 Cobalt_Blood
-- Original JASS function: Trig_Cobalt_Blood_Conditions (line 8909)
function Trig_Cobalt_Blood_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A068"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Cobalt_Blood_Func001C (line 8916)
function Trig_Cobalt_Blood_Func001C()
    if ((not ((GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) <= __jreal(200.00))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Cobalt_Blood_Actions (line 8923)
function Trig_Cobalt_Blood_Actions()
    if (Trig_Cobalt_Blood_Func001C()) then
        IssueImmediateOrderBJ(GetSpellAbilityUnit(), "stop")
    else
        SetUnitLifeBJ(GetSpellAbilityUnit(), (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) - __jreal(200.00))))
    end
end

-- Original JASS function: InitTrig_Cobalt_Blood (line 8932)
function InitTrig_Cobalt_Blood()
    gg_trg_Cobalt_Blood = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Cobalt_Blood, EVENT_PLAYER_UNIT_SPELL_CAST)
    TriggerAddCondition(gg_trg_Cobalt_Blood, Condition(Trig_Cobalt_Blood_Conditions))
    TriggerAddAction(gg_trg_Cobalt_Blood, Trig_Cobalt_Blood_Actions)
end
-- END FOREST SECTION 92

-- BEGIN FOREST SECTION 93 Glowing_Blood
-- Original JASS function: Trig_Glowing_Blood_Conditions (line 8942)
function Trig_Glowing_Blood_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A064"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Glowing_Blood_Func001C (line 8949)
function Trig_Glowing_Blood_Func001C()
    if ((not ((GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) <= __jreal(50.00))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Glowing_Blood_Actions (line 8956)
function Trig_Glowing_Blood_Actions()
    if (Trig_Glowing_Blood_Func001C()) then
        IssueImmediateOrderBJ(GetSpellAbilityUnit(), "stop")
    else
        SetUnitLifeBJ(GetSpellAbilityUnit(), (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) - __jreal(50.00))))
    end
end

-- Original JASS function: InitTrig_Glowing_Blood (line 8965)
function InitTrig_Glowing_Blood()
    gg_trg_Glowing_Blood = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Glowing_Blood, EVENT_PLAYER_UNIT_SPELL_CAST)
    TriggerAddCondition(gg_trg_Glowing_Blood, Condition(Trig_Glowing_Blood_Conditions))
    TriggerAddAction(gg_trg_Glowing_Blood, Trig_Glowing_Blood_Actions)
end
-- END FOREST SECTION 93

-- BEGIN FOREST SECTION 94 Psychic_Slam
-- Original JASS function: Trig_Psychic_Slam_Conditions (line 8975)
function Trig_Psychic_Slam_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A063"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Psychic_Slam_Func001C (line 8982)
function Trig_Psychic_Slam_Func001C()
    if ((not ((GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) <= __jreal(300.00))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Psychic_Slam_Actions (line 8989)
function Trig_Psychic_Slam_Actions()
    if (Trig_Psychic_Slam_Func001C()) then
        IssueImmediateOrderBJ(GetSpellAbilityUnit(), "stop")
    else
        SetUnitLifeBJ(GetSpellAbilityUnit(), (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) - __jreal(300.00))))
    end
end

-- Original JASS function: InitTrig_Psychic_Slam (line 8998)
function InitTrig_Psychic_Slam()
    gg_trg_Psychic_Slam = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Psychic_Slam, EVENT_PLAYER_UNIT_SPELL_CAST)
    TriggerAddCondition(gg_trg_Psychic_Slam, Condition(Trig_Psychic_Slam_Conditions))
    TriggerAddAction(gg_trg_Psychic_Slam, Trig_Psychic_Slam_Actions)
end
-- END FOREST SECTION 94

-- BEGIN FOREST SECTION 95 Soul_Rend
-- Original JASS function: Trig_Soul_Rend_Conditions (line 9008)
function Trig_Soul_Rend_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A069"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Soul_Rend_Func001C (line 9015)
function Trig_Soul_Rend_Func001C()
    if ((not ((GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) <= __jreal(350.00))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Soul_Rend_Actions (line 9022)
function Trig_Soul_Rend_Actions()
    if (Trig_Soul_Rend_Func001C()) then
        IssueImmediateOrderBJ(GetSpellAbilityUnit(), "stop")
    else
        SetUnitLifeBJ(GetSpellAbilityUnit(), (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) - __jreal(350.00))))
        SetUnitLifeBJ(GetSpellTargetUnit(), (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, GetSpellTargetUnit()) - __jreal(500.00))))
    end
end

-- Original JASS function: InitTrig_Soul_Rend (line 9032)
function InitTrig_Soul_Rend()
    gg_trg_Soul_Rend = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Soul_Rend, EVENT_PLAYER_UNIT_SPELL_CAST)
    TriggerAddCondition(gg_trg_Soul_Rend, Condition(Trig_Soul_Rend_Conditions))
    TriggerAddAction(gg_trg_Soul_Rend, Trig_Soul_Rend_Actions)
end
-- END FOREST SECTION 95

-- BEGIN FOREST SECTION 96 Dark_Blood
-- Original JASS function: Trig_Dark_Blood_Conditions (line 9042)
function Trig_Dark_Blood_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A062"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Dark_Blood_Func001C (line 9049)
function Trig_Dark_Blood_Func001C()
    if ((not ((GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) <= __jreal(400.00))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Dark_Blood_Actions (line 9056)
function Trig_Dark_Blood_Actions()
    if (Trig_Dark_Blood_Func001C()) then
        IssueImmediateOrderBJ(GetSpellAbilityUnit(), "stop")
    else
        SetUnitLifeBJ(GetSpellAbilityUnit(), (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) - __jreal(400.00))))
    end
end

-- Original JASS function: InitTrig_Dark_Blood (line 9065)
function InitTrig_Dark_Blood()
    gg_trg_Dark_Blood = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Dark_Blood, EVENT_PLAYER_UNIT_SPELL_CAST)
    TriggerAddCondition(gg_trg_Dark_Blood, Condition(Trig_Dark_Blood_Conditions))
    TriggerAddAction(gg_trg_Dark_Blood, Trig_Dark_Blood_Actions)
end
-- END FOREST SECTION 96

-- BEGIN FOREST SECTION 97 Shadowlings
-- Original JASS function: Trig_Shadowlings_Conditions (line 9075)
function Trig_Shadowlings_Conditions()
    if ((not ((GetUnitTypeId(GetSummonedUnit()) == FourCC("o01T"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Shadowlings_Actions (line 9082)
function Trig_Shadowlings_Actions()
    local summoned = GetSummonedUnit()
    TriggerSleepAction(__jreal(20.00))
    if summoned and GetUnitTypeId(summoned) ~= 0 then KillUnit(summoned) end
end

-- Original JASS function: InitTrig_Shadowlings (line 9088)
function InitTrig_Shadowlings()
    gg_trg_Shadowlings = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Shadowlings, EVENT_PLAYER_UNIT_SUMMON)
    TriggerAddCondition(gg_trg_Shadowlings, Condition(Trig_Shadowlings_Conditions))
    TriggerAddAction(gg_trg_Shadowlings, Trig_Shadowlings_Actions)
end
-- END FOREST SECTION 97

-- BEGIN FOREST SECTION 98 Levelled_Drain
-- Original JASS function: Trig_Levelled_Drain_Conditions (line 9098)
function Trig_Levelled_Drain_Conditions()
    if ((not ((GetResearched() == FourCC("R043"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Levelled_Drain_Func001002 (line 9105)
function Trig_Levelled_Drain_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A065"), GetEnumUnit())
end

-- Original JASS function: Trig_Levelled_Drain_Actions (line 9109)
function Trig_Levelled_Drain_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(0), FourCC("u009")), Trig_Levelled_Drain_Func001002)
end

-- Original JASS function: InitTrig_Levelled_Drain (line 9114)
function InitTrig_Levelled_Drain()
    gg_trg_Levelled_Drain = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Drain, Player(0), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Levelled_Drain, Condition(Trig_Levelled_Drain_Conditions))
    TriggerAddAction(gg_trg_Levelled_Drain, Trig_Levelled_Drain_Actions)
end
-- END FOREST SECTION 98

-- BEGIN FOREST SECTION 99 Levelled_Drain_Copy
-- Original JASS function: Trig_Levelled_Drain_Copy_Conditions (line 9124)
function Trig_Levelled_Drain_Copy_Conditions()
    if ((not ((GetResearched() == FourCC("R043"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Levelled_Drain_Copy_Func001002 (line 9131)
function Trig_Levelled_Drain_Copy_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A065"), GetEnumUnit())
end

-- Original JASS function: Trig_Levelled_Drain_Copy_Actions (line 9135)
function Trig_Levelled_Drain_Copy_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(1), FourCC("u009")), Trig_Levelled_Drain_Copy_Func001002)
end

-- Original JASS function: InitTrig_Levelled_Drain_Copy (line 9140)
function InitTrig_Levelled_Drain_Copy()
    gg_trg_Levelled_Drain_Copy = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Drain_Copy, Player(1), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Levelled_Drain_Copy, Condition(Trig_Levelled_Drain_Copy_Conditions))
    TriggerAddAction(gg_trg_Levelled_Drain_Copy, Trig_Levelled_Drain_Copy_Actions)
end
-- END FOREST SECTION 99

-- BEGIN FOREST SECTION 100 Levelled_Drain_Copy_2
-- Original JASS function: Trig_Levelled_Drain_Copy_2_Conditions (line 9150)
function Trig_Levelled_Drain_Copy_2_Conditions()
    if ((not ((GetResearched() == FourCC("R043"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Levelled_Drain_Copy_2_Func001002 (line 9157)
function Trig_Levelled_Drain_Copy_2_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A065"), GetEnumUnit())
end

-- Original JASS function: Trig_Levelled_Drain_Copy_2_Actions (line 9161)
function Trig_Levelled_Drain_Copy_2_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(2), FourCC("u009")), Trig_Levelled_Drain_Copy_2_Func001002)
end

-- Original JASS function: InitTrig_Levelled_Drain_Copy_2 (line 9166)
function InitTrig_Levelled_Drain_Copy_2()
    gg_trg_Levelled_Drain_Copy_2 = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Drain_Copy_2, Player(2), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Levelled_Drain_Copy_2, Condition(Trig_Levelled_Drain_Copy_2_Conditions))
    TriggerAddAction(gg_trg_Levelled_Drain_Copy_2, Trig_Levelled_Drain_Copy_2_Actions)
end
-- END FOREST SECTION 100

-- BEGIN FOREST SECTION 101 Levelled_Drain_Copy_3
-- Original JASS function: Trig_Levelled_Drain_Copy_3_Conditions (line 9176)
function Trig_Levelled_Drain_Copy_3_Conditions()
    if ((not ((GetResearched() == FourCC("R043"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Levelled_Drain_Copy_3_Func001002 (line 9183)
function Trig_Levelled_Drain_Copy_3_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A065"), GetEnumUnit())
end

-- Original JASS function: Trig_Levelled_Drain_Copy_3_Actions (line 9187)
function Trig_Levelled_Drain_Copy_3_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(3), FourCC("u009")), Trig_Levelled_Drain_Copy_3_Func001002)
end

-- Original JASS function: InitTrig_Levelled_Drain_Copy_3 (line 9192)
function InitTrig_Levelled_Drain_Copy_3()
    gg_trg_Levelled_Drain_Copy_3 = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Drain_Copy_3, Player(3), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Levelled_Drain_Copy_3, Condition(Trig_Levelled_Drain_Copy_3_Conditions))
    TriggerAddAction(gg_trg_Levelled_Drain_Copy_3, Trig_Levelled_Drain_Copy_3_Actions)
end
-- END FOREST SECTION 101

-- BEGIN FOREST SECTION 102 Levelled_Drain_Copy_4
-- Original JASS function: Trig_Levelled_Drain_Copy_4_Conditions (line 9202)
function Trig_Levelled_Drain_Copy_4_Conditions()
    if ((not ((GetResearched() == FourCC("R043"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Levelled_Drain_Copy_4_Func001002 (line 9209)
function Trig_Levelled_Drain_Copy_4_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A065"), GetEnumUnit())
end

-- Original JASS function: Trig_Levelled_Drain_Copy_4_Actions (line 9213)
function Trig_Levelled_Drain_Copy_4_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(4), FourCC("u009")), Trig_Levelled_Drain_Copy_4_Func001002)
end

-- Original JASS function: InitTrig_Levelled_Drain_Copy_4 (line 9218)
function InitTrig_Levelled_Drain_Copy_4()
    gg_trg_Levelled_Drain_Copy_4 = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Drain_Copy_4, Player(4), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Levelled_Drain_Copy_4, Condition(Trig_Levelled_Drain_Copy_4_Conditions))
    TriggerAddAction(gg_trg_Levelled_Drain_Copy_4, Trig_Levelled_Drain_Copy_4_Actions)
end
-- END FOREST SECTION 102

-- BEGIN FOREST SECTION 103 Levelled_Drain_Copy_5
-- Original JASS function: Trig_Levelled_Drain_Copy_5_Conditions (line 9228)
function Trig_Levelled_Drain_Copy_5_Conditions()
    if ((not ((GetResearched() == FourCC("R043"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Levelled_Drain_Copy_5_Func001002 (line 9235)
function Trig_Levelled_Drain_Copy_5_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A065"), GetEnumUnit())
end

-- Original JASS function: Trig_Levelled_Drain_Copy_5_Actions (line 9239)
function Trig_Levelled_Drain_Copy_5_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(5), FourCC("u009")), Trig_Levelled_Drain_Copy_5_Func001002)
end

-- Original JASS function: InitTrig_Levelled_Drain_Copy_5 (line 9244)
function InitTrig_Levelled_Drain_Copy_5()
    gg_trg_Levelled_Drain_Copy_5 = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Drain_Copy_5, Player(5), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Levelled_Drain_Copy_5, Condition(Trig_Levelled_Drain_Copy_5_Conditions))
    TriggerAddAction(gg_trg_Levelled_Drain_Copy_5, Trig_Levelled_Drain_Copy_5_Actions)
end
-- END FOREST SECTION 103

-- BEGIN FOREST SECTION 104 Levelled_Drain_Copy_6
-- Original JASS function: Trig_Levelled_Drain_Copy_6_Conditions (line 9254)
function Trig_Levelled_Drain_Copy_6_Conditions()
    if ((not ((GetResearched() == FourCC("R043"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Levelled_Drain_Copy_6_Func001002 (line 9261)
function Trig_Levelled_Drain_Copy_6_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A065"), GetEnumUnit())
end

-- Original JASS function: Trig_Levelled_Drain_Copy_6_Actions (line 9265)
function Trig_Levelled_Drain_Copy_6_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(7), FourCC("u009")), Trig_Levelled_Drain_Copy_6_Func001002)
end

-- Original JASS function: InitTrig_Levelled_Drain_Copy_6 (line 9270)
function InitTrig_Levelled_Drain_Copy_6()
    gg_trg_Levelled_Drain_Copy_6 = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Drain_Copy_6, Player(7), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Levelled_Drain_Copy_6, Condition(Trig_Levelled_Drain_Copy_6_Conditions))
    TriggerAddAction(gg_trg_Levelled_Drain_Copy_6, Trig_Levelled_Drain_Copy_6_Actions)
end
-- END FOREST SECTION 104

-- BEGIN FOREST SECTION 105 Levelled_Drain_Copy_7
-- Original JASS function: Trig_Levelled_Drain_Copy_7_Conditions (line 9280)
function Trig_Levelled_Drain_Copy_7_Conditions()
    if ((not ((GetResearched() == FourCC("R043"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Levelled_Drain_Copy_7_Func001002 (line 9287)
function Trig_Levelled_Drain_Copy_7_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A065"), GetEnumUnit())
end

-- Original JASS function: Trig_Levelled_Drain_Copy_7_Actions (line 9291)
function Trig_Levelled_Drain_Copy_7_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(8), FourCC("u009")), Trig_Levelled_Drain_Copy_7_Func001002)
end

-- Original JASS function: InitTrig_Levelled_Drain_Copy_7 (line 9296)
function InitTrig_Levelled_Drain_Copy_7()
    gg_trg_Levelled_Drain_Copy_7 = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Drain_Copy_7, Player(8), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Levelled_Drain_Copy_7, Condition(Trig_Levelled_Drain_Copy_7_Conditions))
    TriggerAddAction(gg_trg_Levelled_Drain_Copy_7, Trig_Levelled_Drain_Copy_7_Actions)
end
-- END FOREST SECTION 105

-- BEGIN FOREST SECTION 106 Levelled_Drain_Copy_8
-- Original JASS function: Trig_Levelled_Drain_Copy_8_Conditions (line 9306)
function Trig_Levelled_Drain_Copy_8_Conditions()
    if ((not ((GetResearched() == FourCC("R043"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Levelled_Drain_Copy_8_Func001002 (line 9313)
function Trig_Levelled_Drain_Copy_8_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A065"), GetEnumUnit())
end

-- Original JASS function: Trig_Levelled_Drain_Copy_8_Actions (line 9317)
function Trig_Levelled_Drain_Copy_8_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(9), FourCC("u009")), Trig_Levelled_Drain_Copy_8_Func001002)
end

-- Original JASS function: InitTrig_Levelled_Drain_Copy_8 (line 9322)
function InitTrig_Levelled_Drain_Copy_8()
    gg_trg_Levelled_Drain_Copy_8 = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Drain_Copy_8, Player(9), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Levelled_Drain_Copy_8, Condition(Trig_Levelled_Drain_Copy_8_Conditions))
    TriggerAddAction(gg_trg_Levelled_Drain_Copy_8, Trig_Levelled_Drain_Copy_8_Actions)
end
-- END FOREST SECTION 106

-- BEGIN FOREST SECTION 107 Levelled_Drain_Copy_9
-- Original JASS function: Trig_Levelled_Drain_Copy_9_Conditions (line 9332)
function Trig_Levelled_Drain_Copy_9_Conditions()
    if ((not ((GetResearched() == FourCC("R043"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Levelled_Drain_Copy_9_Func001002 (line 9339)
function Trig_Levelled_Drain_Copy_9_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A065"), GetEnumUnit())
end

-- Original JASS function: Trig_Levelled_Drain_Copy_9_Actions (line 9343)
function Trig_Levelled_Drain_Copy_9_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(10), FourCC("u009")), Trig_Levelled_Drain_Copy_9_Func001002)
end

-- Original JASS function: InitTrig_Levelled_Drain_Copy_9 (line 9348)
function InitTrig_Levelled_Drain_Copy_9()
    gg_trg_Levelled_Drain_Copy_9 = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Drain_Copy_9, Player(10), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Levelled_Drain_Copy_9, Condition(Trig_Levelled_Drain_Copy_9_Conditions))
    TriggerAddAction(gg_trg_Levelled_Drain_Copy_9, Trig_Levelled_Drain_Copy_9_Actions)
end
-- END FOREST SECTION 107

-- BEGIN FOREST SECTION 108 Drain_Setup
-- Original JASS function: Trig_Drain_Setup_Actions (line 9369)
function Trig_Drain_Setup_Actions()
    udg_ncld_Ability = FourCC("A065")
    udg_ncld_DrainHP = __jreal(20.00)
    udg_ncld_DrainHPUp = __jreal(5.00)
    udg_ncld_DrainMP = __jreal(0.00)
    udg_ncld_DrainMPUp = __jreal(0.00)
    udg_ncld_Duration = __jreal(5.00)
    udg_ncld_Duration_Up = __jreal(0.00)
    udg_ncld_Range = __jreal(950.00)
    udg_ncld_RangeUp = __jreal(0.00)
    udg_ncld_LightningArt = "DRAB"
    udg_ncld_TargetSFXArt = "Abilities\\Spells\\Other\\Drain\\DrainTarget.mdl"
    udg_ncld_CasterSFXArt = "Abilities\\Spells\\Other\\Drain\\DrainCaster.mdl"
    udg_ncld_FreqDrain = 1
    udg_ncld_FreqDistance = 20
    udg_ncld_EtherealBonus = __jreal(1.50)
    udg_ncld_buffId = (__jint(udg_ncld_buffId + 1))
    udg_ncld_BuffList[udg_ncld_buffId] = FourCC("BOwk")
    udg_ncld_CheckImmune = false
    udg_ncld_CheckResistant = false
    udg_ncld_CheckVisibile = false
    udg_tempReal = (__jreal(I2R(udg_ncld_FreqDrain) * __jreal(0.03)))
    udg_ncld_DrainHP = (__jreal(udg_ncld_DrainHP * udg_tempReal))
    udg_ncld_DrainHPUp = (__jreal(udg_ncld_DrainHPUp * udg_tempReal))
    udg_ncld_DrainMP = (__jreal(udg_ncld_DrainMP * udg_tempReal))
    udg_ncld_DrainMPUp = (__jreal(udg_ncld_DrainMPUp * udg_tempReal))
end

-- Original JASS function: InitTrig_Drain_Setup (line 9403)
function InitTrig_Drain_Setup()
    gg_trg_Drain_Setup = CreateTrigger()
    TriggerAddAction(gg_trg_Drain_Setup, Trig_Drain_Setup_Actions)
end
-- END FOREST SECTION 108

-- BEGIN FOREST SECTION 109 Drain_Cast
-- Original JASS function: Trig_Drain_Cast_Conditions (line 9411)
function Trig_Drain_Cast_Conditions()
    if ((not ((GetSpellAbilityId() == udg_ncld_Ability)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Drain_Cast_Func031C (line 9418)
function Trig_Drain_Cast_Func031C()
    if ((not ((IsTriggerEnabled(gg_trg_Drain_Loop) == false)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Drain_Cast_Actions (line 9425)
function Trig_Drain_Cast_Actions()
    udg_tempUnit = GetTriggerUnit()
    udg_Key = GetUnitUserData(udg_tempUnit)
    udg_ncld_Target[udg_Key] = GetSpellTargetUnit()
    GroupAddUnitSimple(udg_tempUnit, udg_ncld_Group)
    udg_ncld_Tick[udg_Key] = 0
    udg_ncld_TicksRemaining[udg_Key] = R2I((__jreal((__jreal(udg_ncld_Duration + (__jreal(udg_ncld_Duration_Up * I2R((__jint(GetUnitAbilityLevelSwapped(udg_ncld_Ability, udg_tempUnit) - 1))))))) * __jreal(33.00))))
    udg_ncld_Hp[udg_Key] = (__jreal(udg_ncld_DrainHP + (__jreal(udg_ncld_DrainHPUp * I2R((__jint(GetUnitAbilityLevelSwapped(udg_ncld_Ability, udg_tempUnit) - 1)))))))
    udg_ncld_Mp[udg_Key] = (__jreal(udg_ncld_DrainMP + (__jreal(udg_ncld_DrainMPUp * I2R((__jint(GetUnitAbilityLevelSwapped(udg_ncld_Ability, udg_tempUnit) - 1)))))))
    udg_ncld_Rng[udg_Key] = (__jreal(udg_ncld_Range + (__jreal(udg_ncld_RangeUp * I2R((__jint(GetUnitAbilityLevelSwapped(udg_ncld_Ability, udg_tempUnit) - 1)))))))
    udg_tempLoc1 = GetUnitLoc(udg_tempUnit)
    udg_tempX1 = GetLocationX(udg_tempLoc1)
    udg_tempY1 = GetLocationY(udg_tempLoc1)
    udg_tempZ1 = __jreal(__jreal(GetLocationZ(udg_tempLoc1) + GetUnitFlyHeight(udg_tempUnit)) + __jreal(60))
    RemoveLocation(udg_tempLoc1)
    udg_tempLoc1 = GetUnitLoc(udg_ncld_Target[udg_Key])
    udg_tempX2 = GetLocationX(udg_tempLoc1)
    udg_tempY2 = GetLocationY(udg_tempLoc1)
    udg_tempZ2 = __jreal(__jreal(GetLocationZ(udg_tempLoc1) + GetUnitFlyHeight(udg_ncld_Target[udg_Key])) + __jreal(60))
    RemoveLocation(udg_tempLoc1)
    udg_ncld_Lightning[udg_Key] = AddLightningEx(udg_ncld_LightningArt, true, udg_tempX1, udg_tempY1, udg_tempZ1, udg_tempX2, udg_tempY2, udg_tempZ2)
    AddSpecialEffectTargetUnitBJ("chest", udg_tempUnit, udg_ncld_CasterSFXArt)
    udg_ncld_CasterSFX[udg_Key] = GetLastCreatedEffectBJ()
    AddSpecialEffectTargetUnitBJ("chest", udg_ncld_Target[udg_Key], udg_ncld_TargetSFXArt)
    udg_ncld_TargetSFX[udg_Key] = GetLastCreatedEffectBJ()
    if (Trig_Drain_Cast_Func031C()) then
        EnableTrigger(gg_trg_Drain_Loop)
    else
    end
end

-- Original JASS function: InitTrig_Drain_Cast (line 9463)
function InitTrig_Drain_Cast()
    gg_trg_Drain_Cast = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Drain_Cast, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Drain_Cast, Condition(Trig_Drain_Cast_Conditions))
    TriggerAddAction(gg_trg_Drain_Cast, Trig_Drain_Cast_Actions)
end
-- END FOREST SECTION 109

-- BEGIN FOREST SECTION 110 Drain_Loop
-- Original JASS function: Trig_Drain_Loop_Func001Func005Func023Func001Func002C (line 9473)
function Trig_Drain_Loop_Func001Func005Func023Func001Func002C()
    if ((not ((IsUnitType(udg_ncld_Target[udg_Key], UNIT_TYPE_ETHEREAL) == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Drain_Loop_Func001Func005Func023Func001C (line 9480)
function Trig_Drain_Loop_Func001Func005Func023Func001C()
    if ((not ((IsUnitType(udg_ncld_Target[udg_Key], UNIT_TYPE_MAGIC_IMMUNE) == false)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Drain_Loop_Func001Func005Func023C (line 9487)
function Trig_Drain_Loop_Func001Func005Func023C()
    if ((not ((ModuloInteger(udg_ncld_Tick[udg_Key], udg_ncld_FreqDrain) == 0)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Drain_Loop_Func001Func005Func025Func002Func001C (line 9494)
function Trig_Drain_Loop_Func001Func005Func025Func002Func001C()
    if ((not ((UnitHasBuffBJ(udg_ncld_Target[udg_Key], udg_ncld_BuffList[udg_LoopBuffs]) == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Drain_Loop_Func001Func005Func025Func003Func002C (line 9501)
function Trig_Drain_Loop_Func001Func005Func025Func003Func002C()
    if ((not ((IsUnitType(udg_ncld_Target[udg_Key], UNIT_TYPE_MAGIC_IMMUNE) == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Drain_Loop_Func001Func005Func025Func003C (line 9508)
function Trig_Drain_Loop_Func001Func005Func025Func003C()
    if ((not ((udg_ncld_CheckImmune == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Drain_Loop_Func001Func005Func025Func004Func002C (line 9515)
function Trig_Drain_Loop_Func001Func005Func025Func004Func002C()
    if ((not ((IsUnitType(udg_ncld_Target[udg_Key], UNIT_TYPE_RESISTANT) == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Drain_Loop_Func001Func005Func025Func004C (line 9522)
function Trig_Drain_Loop_Func001Func005Func025Func004C()
    if ((not ((udg_ncld_CheckResistant == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Drain_Loop_Func001Func005Func025Func005Func002C (line 9529)
function Trig_Drain_Loop_Func001Func005Func025Func005Func002C()
    if ((not ((IsUnitVisible(udg_ncld_Target[udg_Key], GetOwningPlayer(udg_tempUnit)) == false)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Drain_Loop_Func001Func005Func025Func005C (line 9536)
function Trig_Drain_Loop_Func001Func005Func025Func005C()
    if ((not ((udg_ncld_CheckVisibile == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Drain_Loop_Func001Func005Func025Func006Func001C (line 9543)
function Trig_Drain_Loop_Func001Func005Func025Func006Func001C()
    if (((udg_CheckBool == false))) then
        do return true end
    end
    if (((IsUnitDeadBJ(udg_ncld_Target[udg_Key]) == true))) then
        do return true end
    end
    if (((IsUnitHiddenBJ(udg_ncld_Target[udg_Key]) == true))) then
        do return true end
    end
    do return false end
end

-- Original JASS function: Trig_Drain_Loop_Func001Func005Func025Func006C (line 9556)
function Trig_Drain_Loop_Func001Func005Func025Func006C()
    if ((not Trig_Drain_Loop_Func001Func005Func025Func006Func001C())) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Drain_Loop_Func001Func005Func025Func008C (line 9563)
function Trig_Drain_Loop_Func001Func005Func025Func008C()
    if ((not ((udg_tempDistance > udg_ncld_Rng[udg_Key])))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Drain_Loop_Func001Func005Func025C (line 9570)
function Trig_Drain_Loop_Func001Func005Func025C()
    if ((not ((ModuloInteger(udg_ncld_Tick[udg_Key], udg_ncld_FreqDistance) == 0)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Drain_Loop_Func001Func005C (line 9577)
function Trig_Drain_Loop_Func001Func005C()
    if ((not ((udg_ncld_TicksRemaining[udg_Key] >= 0)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Drain_Loop_Func001A (line 9584)
function Trig_Drain_Loop_Func001A()
    udg_tempUnit = GetEnumUnit()
    udg_Key = GetUnitUserData(udg_tempUnit)
    udg_ncld_TicksRemaining[udg_Key] = (__jint(udg_ncld_TicksRemaining[udg_Key] - 1))
    if (Trig_Drain_Loop_Func001Func005C()) then
        udg_ncld_Tick[udg_Key] = (__jint(udg_ncld_Tick[udg_Key] + 1))
        udg_tempLoc1 = GetUnitLoc(udg_tempUnit)
        udg_tempLoc2 = GetUnitLoc(udg_ncld_Target[udg_Key])
        udg_tempX1 = GetLocationX(udg_tempLoc1)
        udg_tempY1 = GetLocationY(udg_tempLoc1)
        udg_tempZ1 = __jreal(__jreal(GetLocationZ(udg_tempLoc1) + GetUnitFlyHeight(udg_tempUnit)) + __jreal(60))
        udg_tempX2 = GetLocationX(udg_tempLoc2)
        udg_tempY2 = GetLocationY(udg_tempLoc2)
        udg_tempZ2 = __jreal(__jreal(GetLocationZ(udg_tempLoc2) + GetUnitFlyHeight(udg_ncld_Target[udg_Key])) + __jreal(60))
        MoveLightningEx(udg_ncld_Lightning[udg_Key], true, udg_tempX1, udg_tempY1, udg_tempZ1, udg_tempX2, udg_tempY2, udg_tempZ2)
        if (Trig_Drain_Loop_Func001Func005Func023C()) then
            if (Trig_Drain_Loop_Func001Func005Func023Func001C()) then
                UnitDamageTargetBJ(udg_tempUnit, udg_ncld_Target[udg_Key], __jreal(0.00), ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL)
                if (Trig_Drain_Loop_Func001Func005Func023Func001Func002C()) then
                    SetUnitLifeBJ(udg_ncld_Target[udg_Key], (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, udg_ncld_Target[udg_Key]) - (__jreal(udg_ncld_Hp[udg_Key] * udg_ncld_EtherealBonus)))))
                    SetUnitManaBJ(udg_ncld_Target[udg_Key], (__jreal(GetUnitStateSwap(UNIT_STATE_MANA, udg_ncld_Target[udg_Key]) - (__jreal(udg_ncld_Mp[udg_Key] * udg_ncld_EtherealBonus)))))
                    SetUnitLifeBJ(udg_tempUnit, (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, udg_tempUnit) + (__jreal(udg_ncld_Hp[udg_Key] * udg_ncld_EtherealBonus)))))
                    SetUnitManaBJ(udg_tempUnit, (__jreal(GetUnitStateSwap(UNIT_STATE_MANA, udg_tempUnit) + (__jreal(udg_ncld_Mp[udg_Key] * udg_ncld_EtherealBonus)))))
                else
                    SetUnitLifeBJ(udg_ncld_Target[udg_Key], (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, udg_ncld_Target[udg_Key]) - udg_ncld_Hp[udg_Key])))
                    SetUnitManaBJ(udg_ncld_Target[udg_Key], (__jreal(GetUnitStateSwap(UNIT_STATE_MANA, udg_ncld_Target[udg_Key]) - udg_ncld_Mp[udg_Key])))
                    SetUnitLifeBJ(udg_tempUnit, (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, udg_tempUnit) + udg_ncld_Hp[udg_Key])))
                    SetUnitManaBJ(udg_tempUnit, (__jreal(GetUnitStateSwap(UNIT_STATE_MANA, udg_tempUnit) + udg_ncld_Mp[udg_Key])))
                end
            else
            end
        else
        end
        if (Trig_Drain_Loop_Func001Func005Func025C()) then
            udg_tempDistance = DistanceBetweenPoints(udg_tempLoc1, udg_tempLoc2)
            if (Trig_Drain_Loop_Func001Func005Func025Func008C()) then
                udg_ncld_Tick[udg_Key] = 0
                udg_ncld_TicksRemaining[udg_Key] = 0
                GroupRemoveUnitSimple(udg_tempUnit, udg_ncld_Group)
                udg_ncld_Target[udg_Key] = nil
                DestroyLightningBJ(udg_ncld_Lightning[udg_Key])
                DestroyEffectBJ(udg_ncld_CasterSFX[udg_Key])
                DestroyEffectBJ(udg_ncld_TargetSFX[udg_Key])
            else
            end
        else
            udg_CheckBool = true
            udg_LoopBuffs = 1
            while true do
                if (udg_LoopBuffs > udg_ncld_buffId) then break end
                if (Trig_Drain_Loop_Func001Func005Func025Func002Func001C()) then
                    udg_CheckBool = false
                else
                end
                udg_LoopBuffs = __jint(udg_LoopBuffs + 1)
            end
            if (Trig_Drain_Loop_Func001Func005Func025Func003C()) then
                if (Trig_Drain_Loop_Func001Func005Func025Func003Func002C()) then
                    udg_CheckBool = false
                else
                end
            else
            end
            if (Trig_Drain_Loop_Func001Func005Func025Func004C()) then
                if (Trig_Drain_Loop_Func001Func005Func025Func004Func002C()) then
                    udg_CheckBool = false
                else
                end
            else
            end
            if (Trig_Drain_Loop_Func001Func005Func025Func005C()) then
                if (Trig_Drain_Loop_Func001Func005Func025Func005Func002C()) then
                    udg_CheckBool = false
                else
                end
            else
            end
            if (Trig_Drain_Loop_Func001Func005Func025Func006C()) then
                udg_ncld_Tick[udg_Key] = 0
                udg_ncld_TicksRemaining[udg_Key] = 0
                GroupRemoveUnitSimple(udg_tempUnit, udg_ncld_Group)
                udg_ncld_Target[udg_Key] = nil
                DestroyLightningBJ(udg_ncld_Lightning[udg_Key])
                DestroyEffectBJ(udg_ncld_CasterSFX[udg_Key])
                DestroyEffectBJ(udg_ncld_TargetSFX[udg_Key])
            else
            end
        end
        RemoveLocation(udg_tempLoc1)
        RemoveLocation(udg_tempLoc1)
    else
        udg_ncld_Tick[udg_Key] = 0
        GroupRemoveUnitSimple(udg_tempUnit, udg_ncld_Group)
        udg_ncld_Target[udg_Key] = nil
        DestroyLightningBJ(udg_ncld_Lightning[udg_Key])
        DestroyEffectBJ(udg_ncld_CasterSFX[udg_Key])
        DestroyEffectBJ(udg_ncld_TargetSFX[udg_Key])
    end
end

-- Original JASS function: Trig_Drain_Loop_Func002C (line 9694)
function Trig_Drain_Loop_Func002C()
    if ((not ((IsUnitGroupEmptyBJ(udg_ncld_Group) == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Drain_Loop_Actions (line 9701)
function Trig_Drain_Loop_Actions()
    ForGroupBJ(udg_ncld_Group, Trig_Drain_Loop_Func001A)
    if (Trig_Drain_Loop_Func002C()) then
        DisableTrigger(GetTriggeringTrigger())
    else
    end
end

-- Original JASS function: InitTrig_Drain_Loop (line 9710)
function InitTrig_Drain_Loop()
    gg_trg_Drain_Loop = CreateTrigger()
    DisableTrigger(gg_trg_Drain_Loop)
    TriggerRegisterTimerEventPeriodic(gg_trg_Drain_Loop, __jreal(0.03))
    TriggerAddAction(gg_trg_Drain_Loop, Trig_Drain_Loop_Actions)
end
-- END FOREST SECTION 110

-- BEGIN FOREST SECTION 111 Levelled_Slam
-- Original JASS function: Trig_Levelled_Slam_Conditions (line 9720)
function Trig_Levelled_Slam_Conditions()
    if ((not ((GetResearched() == FourCC("R043"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Levelled_Slam_Func001002 (line 9727)
function Trig_Levelled_Slam_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A063"), GetEnumUnit())
end

-- Original JASS function: Trig_Levelled_Slam_Actions (line 9731)
function Trig_Levelled_Slam_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(0), FourCC("u009")), Trig_Levelled_Slam_Func001002)
end

-- Original JASS function: InitTrig_Levelled_Slam (line 9736)
function InitTrig_Levelled_Slam()
    gg_trg_Levelled_Slam = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Slam, Player(0), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Levelled_Slam, Condition(Trig_Levelled_Slam_Conditions))
    TriggerAddAction(gg_trg_Levelled_Slam, Trig_Levelled_Slam_Actions)
end
-- END FOREST SECTION 111

-- BEGIN FOREST SECTION 112 Levelled_Slam_Copy
-- Original JASS function: Trig_Levelled_Slam_Copy_Conditions (line 9746)
function Trig_Levelled_Slam_Copy_Conditions()
    if ((not ((GetResearched() == FourCC("R043"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Levelled_Slam_Copy_Func001002 (line 9753)
function Trig_Levelled_Slam_Copy_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A063"), GetEnumUnit())
end

-- Original JASS function: Trig_Levelled_Slam_Copy_Actions (line 9757)
function Trig_Levelled_Slam_Copy_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(1), FourCC("u009")), Trig_Levelled_Slam_Copy_Func001002)
end

-- Original JASS function: InitTrig_Levelled_Slam_Copy (line 9762)
function InitTrig_Levelled_Slam_Copy()
    gg_trg_Levelled_Slam_Copy = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Slam_Copy, Player(1), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Levelled_Slam_Copy, Condition(Trig_Levelled_Slam_Copy_Conditions))
    TriggerAddAction(gg_trg_Levelled_Slam_Copy, Trig_Levelled_Slam_Copy_Actions)
end
-- END FOREST SECTION 112

-- BEGIN FOREST SECTION 113 Levelled_Slam_Copy_2
-- Original JASS function: Trig_Levelled_Slam_Copy_2_Conditions (line 9772)
function Trig_Levelled_Slam_Copy_2_Conditions()
    if ((not ((GetResearched() == FourCC("R043"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Levelled_Slam_Copy_2_Func001002 (line 9779)
function Trig_Levelled_Slam_Copy_2_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A063"), GetEnumUnit())
end

-- Original JASS function: Trig_Levelled_Slam_Copy_2_Actions (line 9783)
function Trig_Levelled_Slam_Copy_2_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(2), FourCC("u009")), Trig_Levelled_Slam_Copy_2_Func001002)
end

-- Original JASS function: InitTrig_Levelled_Slam_Copy_2 (line 9788)
function InitTrig_Levelled_Slam_Copy_2()
    gg_trg_Levelled_Slam_Copy_2 = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Slam_Copy_2, Player(2), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Levelled_Slam_Copy_2, Condition(Trig_Levelled_Slam_Copy_2_Conditions))
    TriggerAddAction(gg_trg_Levelled_Slam_Copy_2, Trig_Levelled_Slam_Copy_2_Actions)
end
-- END FOREST SECTION 113

-- BEGIN FOREST SECTION 114 Levelled_Slam_Copy_3
-- Original JASS function: Trig_Levelled_Slam_Copy_3_Conditions (line 9798)
function Trig_Levelled_Slam_Copy_3_Conditions()
    if ((not ((GetResearched() == FourCC("R043"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Levelled_Slam_Copy_3_Func001002 (line 9805)
function Trig_Levelled_Slam_Copy_3_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A063"), GetEnumUnit())
end

-- Original JASS function: Trig_Levelled_Slam_Copy_3_Actions (line 9809)
function Trig_Levelled_Slam_Copy_3_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(3), FourCC("u009")), Trig_Levelled_Slam_Copy_3_Func001002)
end

-- Original JASS function: InitTrig_Levelled_Slam_Copy_3 (line 9814)
function InitTrig_Levelled_Slam_Copy_3()
    gg_trg_Levelled_Slam_Copy_3 = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Slam_Copy_3, Player(3), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Levelled_Slam_Copy_3, Condition(Trig_Levelled_Slam_Copy_3_Conditions))
    TriggerAddAction(gg_trg_Levelled_Slam_Copy_3, Trig_Levelled_Slam_Copy_3_Actions)
end
-- END FOREST SECTION 114

-- BEGIN FOREST SECTION 115 Levelled_Slam_Copy_4
-- Original JASS function: Trig_Levelled_Slam_Copy_4_Conditions (line 9824)
function Trig_Levelled_Slam_Copy_4_Conditions()
    if ((not ((GetResearched() == FourCC("R043"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Levelled_Slam_Copy_4_Func001002 (line 9831)
function Trig_Levelled_Slam_Copy_4_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A063"), GetEnumUnit())
end

-- Original JASS function: Trig_Levelled_Slam_Copy_4_Actions (line 9835)
function Trig_Levelled_Slam_Copy_4_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(4), FourCC("u009")), Trig_Levelled_Slam_Copy_4_Func001002)
end

-- Original JASS function: InitTrig_Levelled_Slam_Copy_4 (line 9840)
function InitTrig_Levelled_Slam_Copy_4()
    gg_trg_Levelled_Slam_Copy_4 = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Slam_Copy_4, Player(4), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Levelled_Slam_Copy_4, Condition(Trig_Levelled_Slam_Copy_4_Conditions))
    TriggerAddAction(gg_trg_Levelled_Slam_Copy_4, Trig_Levelled_Slam_Copy_4_Actions)
end
-- END FOREST SECTION 115

-- BEGIN FOREST SECTION 116 Levelled_Slam_Copy_5
-- Original JASS function: Trig_Levelled_Slam_Copy_5_Conditions (line 9850)
function Trig_Levelled_Slam_Copy_5_Conditions()
    if ((not ((GetResearched() == FourCC("R043"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Levelled_Slam_Copy_5_Func001002 (line 9857)
function Trig_Levelled_Slam_Copy_5_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A063"), GetEnumUnit())
end

-- Original JASS function: Trig_Levelled_Slam_Copy_5_Actions (line 9861)
function Trig_Levelled_Slam_Copy_5_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(5), FourCC("u009")), Trig_Levelled_Slam_Copy_5_Func001002)
end

-- Original JASS function: InitTrig_Levelled_Slam_Copy_5 (line 9866)
function InitTrig_Levelled_Slam_Copy_5()
    gg_trg_Levelled_Slam_Copy_5 = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Slam_Copy_5, Player(5), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Levelled_Slam_Copy_5, Condition(Trig_Levelled_Slam_Copy_5_Conditions))
    TriggerAddAction(gg_trg_Levelled_Slam_Copy_5, Trig_Levelled_Slam_Copy_5_Actions)
end
-- END FOREST SECTION 116

-- BEGIN FOREST SECTION 117 Levelled_Slam_Copy_6
-- Original JASS function: Trig_Levelled_Slam_Copy_6_Conditions (line 9876)
function Trig_Levelled_Slam_Copy_6_Conditions()
    if ((not ((GetResearched() == FourCC("R043"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Levelled_Slam_Copy_6_Func001002 (line 9883)
function Trig_Levelled_Slam_Copy_6_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A063"), GetEnumUnit())
end

-- Original JASS function: Trig_Levelled_Slam_Copy_6_Actions (line 9887)
function Trig_Levelled_Slam_Copy_6_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(7), FourCC("u009")), Trig_Levelled_Slam_Copy_6_Func001002)
end

-- Original JASS function: InitTrig_Levelled_Slam_Copy_6 (line 9892)
function InitTrig_Levelled_Slam_Copy_6()
    gg_trg_Levelled_Slam_Copy_6 = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Slam_Copy_6, Player(7), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Levelled_Slam_Copy_6, Condition(Trig_Levelled_Slam_Copy_6_Conditions))
    TriggerAddAction(gg_trg_Levelled_Slam_Copy_6, Trig_Levelled_Slam_Copy_6_Actions)
end
-- END FOREST SECTION 117

-- BEGIN FOREST SECTION 118 Levelled_Slam_Copy_7
-- Original JASS function: Trig_Levelled_Slam_Copy_7_Conditions (line 9902)
function Trig_Levelled_Slam_Copy_7_Conditions()
    if ((not ((GetResearched() == FourCC("R043"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Levelled_Slam_Copy_7_Func001002 (line 9909)
function Trig_Levelled_Slam_Copy_7_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A063"), GetEnumUnit())
end

-- Original JASS function: Trig_Levelled_Slam_Copy_7_Actions (line 9913)
function Trig_Levelled_Slam_Copy_7_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(8), FourCC("u009")), Trig_Levelled_Slam_Copy_7_Func001002)
end

-- Original JASS function: InitTrig_Levelled_Slam_Copy_7 (line 9918)
function InitTrig_Levelled_Slam_Copy_7()
    gg_trg_Levelled_Slam_Copy_7 = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Slam_Copy_7, Player(8), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Levelled_Slam_Copy_7, Condition(Trig_Levelled_Slam_Copy_7_Conditions))
    TriggerAddAction(gg_trg_Levelled_Slam_Copy_7, Trig_Levelled_Slam_Copy_7_Actions)
end
-- END FOREST SECTION 118

-- BEGIN FOREST SECTION 119 Levelled_Slam_Copy_8
-- Original JASS function: Trig_Levelled_Slam_Copy_8_Conditions (line 9928)
function Trig_Levelled_Slam_Copy_8_Conditions()
    if ((not ((GetResearched() == FourCC("R043"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Levelled_Slam_Copy_8_Func001002 (line 9935)
function Trig_Levelled_Slam_Copy_8_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A063"), GetEnumUnit())
end

-- Original JASS function: Trig_Levelled_Slam_Copy_8_Actions (line 9939)
function Trig_Levelled_Slam_Copy_8_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(9), FourCC("u009")), Trig_Levelled_Slam_Copy_8_Func001002)
end

-- Original JASS function: InitTrig_Levelled_Slam_Copy_8 (line 9944)
function InitTrig_Levelled_Slam_Copy_8()
    gg_trg_Levelled_Slam_Copy_8 = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Slam_Copy_8, Player(9), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Levelled_Slam_Copy_8, Condition(Trig_Levelled_Slam_Copy_8_Conditions))
    TriggerAddAction(gg_trg_Levelled_Slam_Copy_8, Trig_Levelled_Slam_Copy_8_Actions)
end
-- END FOREST SECTION 119

-- BEGIN FOREST SECTION 120 Levelled_Slam_Copy_9
-- Original JASS function: Trig_Levelled_Slam_Copy_9_Conditions (line 9954)
function Trig_Levelled_Slam_Copy_9_Conditions()
    if ((not ((GetResearched() == FourCC("R043"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Levelled_Slam_Copy_9_Func001002 (line 9961)
function Trig_Levelled_Slam_Copy_9_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A063"), GetEnumUnit())
end

-- Original JASS function: Trig_Levelled_Slam_Copy_9_Actions (line 9965)
function Trig_Levelled_Slam_Copy_9_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(10), FourCC("u009")), Trig_Levelled_Slam_Copy_9_Func001002)
end

-- Original JASS function: InitTrig_Levelled_Slam_Copy_9 (line 9970)
function InitTrig_Levelled_Slam_Copy_9()
    gg_trg_Levelled_Slam_Copy_9 = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Slam_Copy_9, Player(10), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Levelled_Slam_Copy_9, Condition(Trig_Levelled_Slam_Copy_9_Conditions))
    TriggerAddAction(gg_trg_Levelled_Slam_Copy_9, Trig_Levelled_Slam_Copy_9_Actions)
end
-- END FOREST SECTION 120
