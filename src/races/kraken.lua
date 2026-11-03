-- races / kraken
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 61 Dutchmen_Trained
-- Original JASS function: Trig_Dutchmen_Trained_Conditions (line 7950)
function Trig_Dutchmen_Trained_Conditions()
    if ((not ((GetUnitTypeId(GetTrainedUnit()) == FourCC("H03P"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Dutchmen_Trained_Actions (line 7957)
function Trig_Dutchmen_Trained_Actions()
    GroupAddUnitSimple(GetTrainedUnit(), udg_Dutchmen)
end

-- Original JASS function: InitTrig_Dutchmen_Trained (line 7962)
function InitTrig_Dutchmen_Trained()
    gg_trg_Dutchmen_Trained = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Dutchmen_Trained, EVENT_PLAYER_UNIT_TRAIN_FINISH)
    TriggerAddCondition(gg_trg_Dutchmen_Trained, Condition(Trig_Dutchmen_Trained_Conditions))
    TriggerAddAction(gg_trg_Dutchmen_Trained, Trig_Dutchmen_Trained_Actions)
end
-- END FOREST SECTION 61

-- BEGIN FOREST SECTION 62 Dutchmen
-- Original JASS function: Trig_Dutchmen_Func001A (line 7972)
function Trig_Dutchmen_Func001A()
    BlzSetUnitBaseDamage(GetEnumUnit(), (__jint(GetPlayerState(GetOwningPlayer(GetEnumUnit()), PLAYER_STATE_RESOURCE_GOLD) + (__jint(49 + GetHeroStatBJ(bj_HEROSTAT_STR, GetEnumUnit(), true))))), 0)
end

-- Original JASS function: Trig_Dutchmen_Actions (line 7976)
function Trig_Dutchmen_Actions()
    ForGroupBJ(udg_Dutchmen, Trig_Dutchmen_Func001A)
end

-- Original JASS function: InitTrig_Dutchmen (line 7981)
function InitTrig_Dutchmen()
    gg_trg_Dutchmen = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(gg_trg_Dutchmen, __jreal(2))
    TriggerAddAction(gg_trg_Dutchmen, Trig_Dutchmen_Actions)
end
-- END FOREST SECTION 62
