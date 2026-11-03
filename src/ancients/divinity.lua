-- ancients / divinity
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 179 Sadism
-- Original JASS function: Trig_Sadism_Conditions (line 12162)
function Trig_Sadism_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A075"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Sadism_Actions (line 12169)
function Trig_Sadism_Actions()
    local caster = GetSpellAbilityUnit()
    local iterations = 10
    SetUnitLifeBJ(caster, (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) * __jreal(0.60))))
    TriggerSleepAction(__jreal(1.00))
    while true do
        SetUnitLifeBJ(caster, (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, caster) + __jreal(1000.00))))
        iterations = __jint(iterations - 1)
        TriggerSleepAction(__jreal(1.00))
        if (iterations == 0) then break end
    end
end

-- Original JASS function: InitTrig_Sadism (line 12182)
function InitTrig_Sadism()
    gg_trg_Sadism = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Sadism, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Sadism, Condition(Trig_Sadism_Conditions))
    TriggerAddAction(gg_trg_Sadism, Trig_Sadism_Actions)
end
-- END FOREST SECTION 179

-- BEGIN FOREST SECTION 180 Reckoning
-- Original JASS function: Trig_Reckoning_Conditions (line 12193)
function Trig_Reckoning_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A06W"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Reckoning_Actions (line 12200)
function Trig_Reckoning_Actions()
    udg_TSEDuration = __jreal(5.00)
    udg_TSEScale = __jreal(0.45)
    udg_TSEAttachPoint = "origin"
    udg_TSEEffectName = "war3mapImported\\HolyTornado.mdx"
    udg_TSETargetUnit = GetSpellAbilityUnit()
    ConditionalTriggerExecute(udg_TSE_RegisterTrigger)
end

-- Original JASS function: InitTrig_Reckoning (line 12210)
function InitTrig_Reckoning()
    gg_trg_Reckoning = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Reckoning, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Reckoning, Condition(Trig_Reckoning_Conditions))
    TriggerAddAction(gg_trg_Reckoning, Trig_Reckoning_Actions)
end
-- END FOREST SECTION 180

-- BEGIN FOREST SECTION 181 Vanguard_Initial
-- Original JASS function: Trig_Vanguard_Initial_Conditions (line 12221)
function Trig_Vanguard_Initial_Conditions()
    if ((not ((GetLearnedSkillBJ() == FourCC("A06U"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Vanguard_Initial_Actions (line 12228)
function Trig_Vanguard_Initial_Actions()
    udg_VanguardHeal = (__jreal(udg_VanguardHeal + __jreal(100.00)))
    TriggerSleepAction(__jreal(5.00))
    EnableTrigger(gg_trg_Vanguard_Future_Levels)
    DisableTrigger(GetTriggeringTrigger())
end

-- Original JASS function: InitTrig_Vanguard_Initial (line 12236)
function InitTrig_Vanguard_Initial()
    gg_trg_Vanguard_Initial = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Vanguard_Initial, EVENT_PLAYER_HERO_SKILL)
    TriggerAddCondition(gg_trg_Vanguard_Initial, Condition(Trig_Vanguard_Initial_Conditions))
    TriggerAddAction(gg_trg_Vanguard_Initial, Trig_Vanguard_Initial_Actions)
end
-- END FOREST SECTION 181

-- BEGIN FOREST SECTION 182 Vanguard_Future_Levels
-- Original JASS function: Trig_Vanguard_Future_Levels_Conditions (line 12246)
function Trig_Vanguard_Future_Levels_Conditions()
    if ((not ((GetLearnedSkillBJ() == FourCC("A06U"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Vanguard_Future_Levels_Actions (line 12253)
function Trig_Vanguard_Future_Levels_Actions()
    udg_VanguardHeal = (__jreal(udg_VanguardHeal + __jreal(50.00)))
end

-- Original JASS function: InitTrig_Vanguard_Future_Levels (line 12258)
function InitTrig_Vanguard_Future_Levels()
    gg_trg_Vanguard_Future_Levels = CreateTrigger()
    DisableTrigger(gg_trg_Vanguard_Future_Levels)
    TriggerRegisterAnyUnitEventBJ(gg_trg_Vanguard_Future_Levels, EVENT_PLAYER_HERO_SKILL)
    TriggerAddCondition(gg_trg_Vanguard_Future_Levels, Condition(Trig_Vanguard_Future_Levels_Conditions))
    TriggerAddAction(gg_trg_Vanguard_Future_Levels, Trig_Vanguard_Future_Levels_Actions)
end
-- END FOREST SECTION 182

-- BEGIN FOREST SECTION 183 Vanguard
-- Original JASS function: Trig_Vanguard_Conditions (line 12269)
function Trig_Vanguard_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A06U"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Vanguard_Actions (line 12276)
function Trig_Vanguard_Actions()
    local heal = udg_VanguardHeal
    SetUnitLifeBJ(GetTriggerUnit(), (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) + heal)))
    TriggerSleepAction(__jreal(1.00))
    SetUnitLifeBJ(GetTriggerUnit(), (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) + heal)))
    TriggerSleepAction(__jreal(1.00))
    SetUnitLifeBJ(GetTriggerUnit(), (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) + heal)))
    TriggerSleepAction(__jreal(1.00))
    SetUnitLifeBJ(GetTriggerUnit(), (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) + heal)))
    TriggerSleepAction(__jreal(1.00))
    SetUnitLifeBJ(GetTriggerUnit(), (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) + heal)))
    TriggerSleepAction(__jreal(1.00))
    SetUnitLifeBJ(GetTriggerUnit(), (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) + heal)))
end

-- Original JASS function: InitTrig_Vanguard (line 12291)
function InitTrig_Vanguard()
    gg_trg_Vanguard = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Vanguard, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Vanguard, Condition(Trig_Vanguard_Conditions))
    TriggerAddAction(gg_trg_Vanguard, Trig_Vanguard_Actions)
end
-- END FOREST SECTION 183

-- BEGIN FOREST SECTION 184 Omniscience_Initial
-- Original JASS function: Trig_Omniscience_Initial_Conditions (line 12301)
function Trig_Omniscience_Initial_Conditions()
    if ((not ((GetLearnedSkillBJ() == FourCC("A06X"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Omniscience_Initial_Actions (line 12308)
function Trig_Omniscience_Initial_Actions()
    udg_Div = GetLearningUnit()
    udg_Omni = 1
    EnableTrigger(gg_trg_Omniscience)
    EnableTrigger(gg_trg_Omniscience_FL)
    DisableTrigger(GetTriggeringTrigger())
end

-- Original JASS function: InitTrig_Omniscience_Initial (line 12317)
function InitTrig_Omniscience_Initial()
    gg_trg_Omniscience_Initial = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Omniscience_Initial, EVENT_PLAYER_HERO_SKILL)
    TriggerAddCondition(gg_trg_Omniscience_Initial, Condition(Trig_Omniscience_Initial_Conditions))
    TriggerAddAction(gg_trg_Omniscience_Initial, Trig_Omniscience_Initial_Actions)
end
-- END FOREST SECTION 184

-- BEGIN FOREST SECTION 185 Omniscience_FL
-- Original JASS function: Trig_Omniscience_FL_Conditions (line 12327)
function Trig_Omniscience_FL_Conditions()
    if ((not ((GetLearnedSkillBJ() == FourCC("A06X"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Omniscience_FL_Actions (line 12334)
function Trig_Omniscience_FL_Actions()
    udg_Omni = (__jint(udg_Omni + 1))
end

-- Original JASS function: InitTrig_Omniscience_FL (line 12339)
function InitTrig_Omniscience_FL()
    gg_trg_Omniscience_FL = CreateTrigger()
    DisableTrigger(gg_trg_Omniscience_FL)
    TriggerRegisterAnyUnitEventBJ(gg_trg_Omniscience_FL, EVENT_PLAYER_HERO_SKILL)
    TriggerAddCondition(gg_trg_Omniscience_FL, Condition(Trig_Omniscience_FL_Conditions))
    TriggerAddAction(gg_trg_Omniscience_FL, Trig_Omniscience_FL_Actions)
end
-- END FOREST SECTION 185

-- BEGIN FOREST SECTION 186 Omniscience
-- Original JASS function: Trig_Omniscience_Actions (line 12350)
function Trig_Omniscience_Actions()
    AddHeroXPSwapped(udg_Omni, udg_Div, true)
end

-- Original JASS function: InitTrig_Omniscience (line 12355)
function InitTrig_Omniscience()
    gg_trg_Omniscience = CreateTrigger()
    DisableTrigger(gg_trg_Omniscience)
    TriggerRegisterTimerEventPeriodic(gg_trg_Omniscience, __jreal(1.00))
    TriggerAddAction(gg_trg_Omniscience, Trig_Omniscience_Actions)
end
-- END FOREST SECTION 186

-- BEGIN FOREST SECTION 187 Redemption
-- Original JASS function: Trig_Redemption_Conditions (line 12365)
function Trig_Redemption_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A06Y"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Redemption_Actions (line 12372)
function Trig_Redemption_Actions()
    SetUnitLifePercentBJ(GetSpellAbilityUnit(), __jreal(100))
    SetUnitManaPercentBJ(GetSpellAbilityUnit(), __jreal(100))
end

-- Original JASS function: InitTrig_Redemption (line 12378)
function InitTrig_Redemption()
    gg_trg_Redemption = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Redemption, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Redemption, Condition(Trig_Redemption_Conditions))
    TriggerAddAction(gg_trg_Redemption, Trig_Redemption_Actions)
end
-- END FOREST SECTION 187
