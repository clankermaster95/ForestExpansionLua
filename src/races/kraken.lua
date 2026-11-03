-- races / kraken
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 61 Dutchmen_Trained
function Trig_Dutchmen_Trained_Conditions()
    return GetUnitTypeId(GetTrainedUnit()) == FourCC("H03P")
end

function Trig_Dutchmen_Trained_Actions()
    GroupAddUnitSimple(GetTrainedUnit(), udg_Dutchmen)
end

function InitTrig_Dutchmen_Trained()
    gg_trg_Dutchmen_Trained = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Dutchmen_Trained, EVENT_PLAYER_UNIT_TRAIN_FINISH)
    TriggerAddCondition(gg_trg_Dutchmen_Trained, Condition(Trig_Dutchmen_Trained_Conditions))
    TriggerAddAction(gg_trg_Dutchmen_Trained, Trig_Dutchmen_Trained_Actions)
end
-- END FOREST SECTION 61

-- BEGIN FOREST SECTION 62 Dutchmen
function Trig_Dutchmen_Func001A()
    BlzSetUnitBaseDamage(GetEnumUnit(), (__jint(GetPlayerState(GetOwningPlayer(GetEnumUnit()), PLAYER_STATE_RESOURCE_GOLD) + (__jint(49 + GetHeroStatBJ(bj_HEROSTAT_STR, GetEnumUnit(), true))))), 0)
end

function Trig_Dutchmen_Actions()
    ForGroupBJ(udg_Dutchmen, Trig_Dutchmen_Func001A)
end

function InitTrig_Dutchmen()
    gg_trg_Dutchmen = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(gg_trg_Dutchmen, __jreal(2))
    TriggerAddAction(gg_trg_Dutchmen, Trig_Dutchmen_Actions)
end
-- END FOREST SECTION 62
