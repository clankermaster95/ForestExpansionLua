-- ancients / tremor
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 169 Resillience
function Trig_Resillience_Conditions()
    return GetLearnedSkillBJ() == FourCC("A088")
end

function Trig_Resillience_Actions()
    udg_Resillence = __jreal(0.50)
    udg_ResillienceLvler = GetLearningUnit()
    EnableTrigger(gg_trg_Resillience_3)
    DisableTrigger(GetTriggeringTrigger())
end

function InitTrig_Resillience()
    gg_trg_Resillience = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Resillience, EVENT_PLAYER_HERO_SKILL)
    TriggerAddCondition(gg_trg_Resillience, Condition(Trig_Resillience_Conditions))
    TriggerAddAction(gg_trg_Resillience, Trig_Resillience_Actions)
end
-- END FOREST SECTION 169

-- BEGIN FOREST SECTION 170 Resillience_2
function Trig_Resillience_2_Actions()
    SetUnitManaPercentBJ(udg_ResillienceLvler, (__jreal(GetUnitManaPercent(udg_ResillienceLvler) + udg_Resillence)))
end

function InitTrig_Resillience_2()
    gg_trg_Resillience_2 = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(gg_trg_Resillience_2, __jreal(1.00))
    TriggerAddAction(gg_trg_Resillience_2, Trig_Resillience_2_Actions)
end
-- END FOREST SECTION 170

-- BEGIN FOREST SECTION 171 Resillience_3
function Trig_Resillience_3_Conditions()
    return GetLearnedSkillBJ() == FourCC("A088")
end

function Trig_Resillience_3_Actions()
    udg_Resillence = (__jreal(udg_Resillence + __jreal(0.50)))
end

function InitTrig_Resillience_3()
    gg_trg_Resillience_3 = CreateTrigger()
    DisableTrigger(gg_trg_Resillience_3)
    TriggerRegisterAnyUnitEventBJ(gg_trg_Resillience_3, EVENT_PLAYER_HERO_SKILL)
    TriggerAddCondition(gg_trg_Resillience_3, Condition(Trig_Resillience_3_Conditions))
    TriggerAddAction(gg_trg_Resillience_3, Trig_Resillience_3_Actions)
end
-- END FOREST SECTION 171
