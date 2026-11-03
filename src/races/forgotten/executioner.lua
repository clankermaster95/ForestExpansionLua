-- races / forgotten / executioner
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 65 Coup_de_grace
-- Keep separate trigger handles and research enablement for the ten original
-- owner slots; only the duplicated bodies are shared.
local function FocusedAngerOwnerCondition(slot)
    return GetUnitTypeId(GetAttacker()) == FourCC("u00B") and
        GetOwningPlayer(GetAttacker()) == Player(slot)
end

local function FocusedAngerAttackEvent(trigger, condition, action)
    DisableTrigger(trigger)
    FE_Roles.registerAncientUnitEvent(trigger, EVENT_PLAYER_UNIT_ATTACKED)
    TriggerAddCondition(trigger, Condition(condition))
    TriggerAddAction(trigger, action)
end

local function FocusedAngerResearchEvent(trigger, slot, condition, action)
    TriggerRegisterPlayerUnitEventSimple(trigger, Player(slot), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(trigger, Condition(condition))
    TriggerAddAction(trigger, action)
end

function Trig_Coup_de_grace_Conditions()
    return GetSpellAbilityId() == FourCC("A05X")
end

function Trig_Coup_de_grace_Actions()
    SetUnitLifeBJ(GetSpellTargetUnit(), (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, GetSpellTargetUnit()) - (__jreal(GetUnitStateSwap(UNIT_STATE_MAX_LIFE, GetSpellTargetUnit()) * __jreal(0.10))))))
end

function InitTrig_Coup_de_grace()
    gg_trg_Coup_de_grace = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Coup_de_grace, EVENT_PLAYER_UNIT_SPELL_CAST)
    TriggerAddCondition(gg_trg_Coup_de_grace, Condition(Trig_Coup_de_grace_Conditions))
    TriggerAddAction(gg_trg_Coup_de_grace, Trig_Coup_de_grace_Actions)
end
-- END FOREST SECTION 65

-- BEGIN FOREST SECTION 66 Surge_of_Darkness
function Trig_Surge_of_Darkness_Conditions()
    return GetSpellAbilityId() == FourCC("A060")
end

function Trig_Surge_of_Darkness_Actions()
    UnitAddAbilityBJ(FourCC("A079"), GetTriggerUnit())
    TriggerSleepAction(__jreal(5.00))
    UnitRemoveAbilityBJ(FourCC("A079"), GetTriggerUnit())
end

function InitTrig_Surge_of_Darkness()
    gg_trg_Surge_of_Darkness = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Surge_of_Darkness, EVENT_PLAYER_UNIT_SPELL_CAST)
    TriggerAddCondition(gg_trg_Surge_of_Darkness, Condition(Trig_Surge_of_Darkness_Conditions))
    TriggerAddAction(gg_trg_Surge_of_Darkness, Trig_Surge_of_Darkness_Actions)
end
-- END FOREST SECTION 66

-- BEGIN FOREST SECTION 67 Focused_Anger_1
function Trig_Focused_Anger_1_Conditions()
    return FocusedAngerOwnerCondition(0)
end

function Trig_Focused_Anger_1_Actions()
    FE_FocusedAnger.add(GetAttacker())
end

function InitTrig_Focused_Anger_1()
    gg_trg_Focused_Anger_1 = CreateTrigger()
    FocusedAngerAttackEvent(gg_trg_Focused_Anger_1, Trig_Focused_Anger_1_Conditions, Trig_Focused_Anger_1_Actions)
end
-- END FOREST SECTION 67

-- BEGIN FOREST SECTION 68 Focused_Anger_2
function Trig_Focused_Anger_2_Conditions()
    return FocusedAngerOwnerCondition(1)
end

function Trig_Focused_Anger_2_Actions()
    FE_FocusedAnger.add(GetAttacker())
end

function InitTrig_Focused_Anger_2()
    gg_trg_Focused_Anger_2 = CreateTrigger()
    FocusedAngerAttackEvent(gg_trg_Focused_Anger_2, Trig_Focused_Anger_2_Conditions, Trig_Focused_Anger_2_Actions)
end
-- END FOREST SECTION 68

-- BEGIN FOREST SECTION 69 Focused_Anger_3
function Trig_Focused_Anger_3_Conditions()
    return FocusedAngerOwnerCondition(2)
end

function Trig_Focused_Anger_3_Actions()
    FE_FocusedAnger.add(GetAttacker())
end

function InitTrig_Focused_Anger_3()
    gg_trg_Focused_Anger_3 = CreateTrigger()
    FocusedAngerAttackEvent(gg_trg_Focused_Anger_3, Trig_Focused_Anger_3_Conditions, Trig_Focused_Anger_3_Actions)
end
-- END FOREST SECTION 69

-- BEGIN FOREST SECTION 70 Focused_Anger_4
function Trig_Focused_Anger_4_Conditions()
    return FocusedAngerOwnerCondition(3)
end

function Trig_Focused_Anger_4_Actions()
    FE_FocusedAnger.add(GetAttacker())
end

function InitTrig_Focused_Anger_4()
    gg_trg_Focused_Anger_4 = CreateTrigger()
    FocusedAngerAttackEvent(gg_trg_Focused_Anger_4, Trig_Focused_Anger_4_Conditions, Trig_Focused_Anger_4_Actions)
end
-- END FOREST SECTION 70

-- BEGIN FOREST SECTION 71 Focused_Anger_5
function Trig_Focused_Anger_5_Conditions()
    return FocusedAngerOwnerCondition(4)
end

function Trig_Focused_Anger_5_Actions()
    FE_FocusedAnger.add(GetAttacker())
end

function InitTrig_Focused_Anger_5()
    gg_trg_Focused_Anger_5 = CreateTrigger()
    FocusedAngerAttackEvent(gg_trg_Focused_Anger_5, Trig_Focused_Anger_5_Conditions, Trig_Focused_Anger_5_Actions)
end
-- END FOREST SECTION 71

-- BEGIN FOREST SECTION 72 Focused_Anger_6
function Trig_Focused_Anger_6_Conditions()
    return FocusedAngerOwnerCondition(5)
end

function Trig_Focused_Anger_6_Actions()
    FE_FocusedAnger.add(GetAttacker())
end

function InitTrig_Focused_Anger_6()
    gg_trg_Focused_Anger_6 = CreateTrigger()
    FocusedAngerAttackEvent(gg_trg_Focused_Anger_6, Trig_Focused_Anger_6_Conditions, Trig_Focused_Anger_6_Actions)
end
-- END FOREST SECTION 72

-- BEGIN FOREST SECTION 73 Focused_Anger_7
function Trig_Focused_Anger_7_Conditions()
    return FocusedAngerOwnerCondition(7)
end

function Trig_Focused_Anger_7_Actions()
    FE_FocusedAnger.add(GetAttacker())
end

function InitTrig_Focused_Anger_7()
    gg_trg_Focused_Anger_7 = CreateTrigger()
    FocusedAngerAttackEvent(gg_trg_Focused_Anger_7, Trig_Focused_Anger_7_Conditions, Trig_Focused_Anger_7_Actions)
end
-- END FOREST SECTION 73

-- BEGIN FOREST SECTION 74 Focused_Anger_8
function Trig_Focused_Anger_8_Conditions()
    return FocusedAngerOwnerCondition(8)
end

function Trig_Focused_Anger_8_Actions()
    FE_FocusedAnger.add(GetAttacker())
end

function InitTrig_Focused_Anger_8()
    gg_trg_Focused_Anger_8 = CreateTrigger()
    FocusedAngerAttackEvent(gg_trg_Focused_Anger_8, Trig_Focused_Anger_8_Conditions, Trig_Focused_Anger_8_Actions)
end
-- END FOREST SECTION 74

-- BEGIN FOREST SECTION 75 Focused_Anger_9
function Trig_Focused_Anger_9_Conditions()
    return FocusedAngerOwnerCondition(9)
end

function Trig_Focused_Anger_9_Actions()
    FE_FocusedAnger.add(GetAttacker())
end

function InitTrig_Focused_Anger_9()
    gg_trg_Focused_Anger_9 = CreateTrigger()
    FocusedAngerAttackEvent(gg_trg_Focused_Anger_9, Trig_Focused_Anger_9_Conditions, Trig_Focused_Anger_9_Actions)
end
-- END FOREST SECTION 75

-- BEGIN FOREST SECTION 76 Focused_Anger_10
function Trig_Focused_Anger_10_Conditions()
    return FocusedAngerOwnerCondition(10)
end

function Trig_Focused_Anger_10_Actions()
    FE_FocusedAnger.add(GetAttacker())
end

function InitTrig_Focused_Anger_10()
    gg_trg_Focused_Anger_10 = CreateTrigger()
    FocusedAngerAttackEvent(gg_trg_Focused_Anger_10, Trig_Focused_Anger_10_Conditions, Trig_Focused_Anger_10_Actions)
end
-- END FOREST SECTION 76

-- BEGIN FOREST SECTION 77 Focused_Anger_Trigger
function Trig_Focused_Anger_Trigger_Conditions()
    return GetResearched() == FourCC("R04T")
end

function Trig_Focused_Anger_Trigger_Actions()
    EnableTrigger(gg_trg_Focused_Anger_1)
end

function InitTrig_Focused_Anger_Trigger()
    gg_trg_Focused_Anger_Trigger = CreateTrigger()
    FocusedAngerResearchEvent(gg_trg_Focused_Anger_Trigger, 0, Trig_Focused_Anger_Trigger_Conditions, Trig_Focused_Anger_Trigger_Actions)
end
-- END FOREST SECTION 77

-- BEGIN FOREST SECTION 78 Focused_Anger_Trigger_Copy
function Trig_Focused_Anger_Trigger_Copy_Conditions()
    return GetResearched() == FourCC("R04T")
end

function Trig_Focused_Anger_Trigger_Copy_Actions()
    EnableTrigger(gg_trg_Focused_Anger_2)
end

function InitTrig_Focused_Anger_Trigger_Copy()
    gg_trg_Focused_Anger_Trigger_Copy = CreateTrigger()
    FocusedAngerResearchEvent(gg_trg_Focused_Anger_Trigger_Copy, 1, Trig_Focused_Anger_Trigger_Copy_Conditions, Trig_Focused_Anger_Trigger_Copy_Actions)
end
-- END FOREST SECTION 78

-- BEGIN FOREST SECTION 79 Focused_Anger_Trigger_Copy_2
function Trig_Focused_Anger_Trigger_Copy_2_Conditions()
    return GetResearched() == FourCC("R04T")
end

function Trig_Focused_Anger_Trigger_Copy_2_Actions()
    EnableTrigger(gg_trg_Focused_Anger_3)
end

function InitTrig_Focused_Anger_Trigger_Copy_2()
    gg_trg_Focused_Anger_Trigger_Copy_2 = CreateTrigger()
    FocusedAngerResearchEvent(gg_trg_Focused_Anger_Trigger_Copy_2, 2, Trig_Focused_Anger_Trigger_Copy_2_Conditions, Trig_Focused_Anger_Trigger_Copy_2_Actions)
end
-- END FOREST SECTION 79

-- BEGIN FOREST SECTION 80 Focused_Anger_Trigger_Copy_3
function Trig_Focused_Anger_Trigger_Copy_3_Conditions()
    return GetResearched() == FourCC("R04T")
end

function Trig_Focused_Anger_Trigger_Copy_3_Actions()
    EnableTrigger(gg_trg_Focused_Anger_4)
end

function InitTrig_Focused_Anger_Trigger_Copy_3()
    gg_trg_Focused_Anger_Trigger_Copy_3 = CreateTrigger()
    FocusedAngerResearchEvent(gg_trg_Focused_Anger_Trigger_Copy_3, 3, Trig_Focused_Anger_Trigger_Copy_3_Conditions, Trig_Focused_Anger_Trigger_Copy_3_Actions)
end
-- END FOREST SECTION 80

-- BEGIN FOREST SECTION 81 Focused_Anger_Trigger_Copy_4
function Trig_Focused_Anger_Trigger_Copy_4_Conditions()
    return GetResearched() == FourCC("R04T")
end

function Trig_Focused_Anger_Trigger_Copy_4_Actions()
    EnableTrigger(gg_trg_Focused_Anger_5)
end

function InitTrig_Focused_Anger_Trigger_Copy_4()
    gg_trg_Focused_Anger_Trigger_Copy_4 = CreateTrigger()
    FocusedAngerResearchEvent(gg_trg_Focused_Anger_Trigger_Copy_4, 4, Trig_Focused_Anger_Trigger_Copy_4_Conditions, Trig_Focused_Anger_Trigger_Copy_4_Actions)
end
-- END FOREST SECTION 81

-- BEGIN FOREST SECTION 82 Focused_Anger_Trigger_Copy_5
function Trig_Focused_Anger_Trigger_Copy_5_Conditions()
    return GetResearched() == FourCC("R04T")
end

function Trig_Focused_Anger_Trigger_Copy_5_Actions()
    EnableTrigger(gg_trg_Focused_Anger_6)
end

function InitTrig_Focused_Anger_Trigger_Copy_5()
    gg_trg_Focused_Anger_Trigger_Copy_5 = CreateTrigger()
    FocusedAngerResearchEvent(gg_trg_Focused_Anger_Trigger_Copy_5, 5, Trig_Focused_Anger_Trigger_Copy_5_Conditions, Trig_Focused_Anger_Trigger_Copy_5_Actions)
end
-- END FOREST SECTION 82

-- BEGIN FOREST SECTION 83 Focused_Anger_Trigger_Copy_6
function Trig_Focused_Anger_Trigger_Copy_6_Conditions()
    return GetResearched() == FourCC("R04T")
end

function Trig_Focused_Anger_Trigger_Copy_6_Actions()
    EnableTrigger(gg_trg_Focused_Anger_7)
end

function InitTrig_Focused_Anger_Trigger_Copy_6()
    gg_trg_Focused_Anger_Trigger_Copy_6 = CreateTrigger()
    FocusedAngerResearchEvent(gg_trg_Focused_Anger_Trigger_Copy_6, 7, Trig_Focused_Anger_Trigger_Copy_6_Conditions, Trig_Focused_Anger_Trigger_Copy_6_Actions)
end
-- END FOREST SECTION 83

-- BEGIN FOREST SECTION 84 Focused_Anger_Trigger_Copy_7
function Trig_Focused_Anger_Trigger_Copy_7_Conditions()
    return GetResearched() == FourCC("R04T")
end

function Trig_Focused_Anger_Trigger_Copy_7_Actions()
    EnableTrigger(gg_trg_Focused_Anger_8)
end

function InitTrig_Focused_Anger_Trigger_Copy_7()
    gg_trg_Focused_Anger_Trigger_Copy_7 = CreateTrigger()
    FocusedAngerResearchEvent(gg_trg_Focused_Anger_Trigger_Copy_7, 8, Trig_Focused_Anger_Trigger_Copy_7_Conditions, Trig_Focused_Anger_Trigger_Copy_7_Actions)
end
-- END FOREST SECTION 84

-- BEGIN FOREST SECTION 85 Focused_Anger_Trigger_Copy_8
function Trig_Focused_Anger_Trigger_Copy_8_Conditions()
    return GetResearched() == FourCC("R04T")
end

function Trig_Focused_Anger_Trigger_Copy_8_Actions()
    EnableTrigger(gg_trg_Focused_Anger_9)
end

function InitTrig_Focused_Anger_Trigger_Copy_8()
    gg_trg_Focused_Anger_Trigger_Copy_8 = CreateTrigger()
    FocusedAngerResearchEvent(gg_trg_Focused_Anger_Trigger_Copy_8, 9, Trig_Focused_Anger_Trigger_Copy_8_Conditions, Trig_Focused_Anger_Trigger_Copy_8_Actions)
end
-- END FOREST SECTION 85

-- BEGIN FOREST SECTION 86 Focused_Anger_Trigger_Copy_9
function Trig_Focused_Anger_Trigger_Copy_9_Conditions()
    return GetResearched() == FourCC("R04T")
end

function Trig_Focused_Anger_Trigger_Copy_9_Actions()
    EnableTrigger(gg_trg_Focused_Anger_10)
end

function InitTrig_Focused_Anger_Trigger_Copy_9()
    gg_trg_Focused_Anger_Trigger_Copy_9 = CreateTrigger()
    FocusedAngerResearchEvent(gg_trg_Focused_Anger_Trigger_Copy_9, 10, Trig_Focused_Anger_Trigger_Copy_9_Conditions, Trig_Focused_Anger_Trigger_Copy_9_Actions)
end
-- END FOREST SECTION 86
