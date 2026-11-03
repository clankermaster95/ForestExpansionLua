-- ui / animations
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 310 Death_anim
-- Original JASS function: Trig_Death_anim_Actions (line 17765)
function Trig_Death_anim_Actions()
    RemoveUnit(GetDecayingUnit())
end

-- Original JASS function: InitTrig_Death_anim (line 17770)
function InitTrig_Death_anim()
    gg_trg_Death_anim = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(gg_trg_Death_anim, __jreal(1.00))
    TriggerAddAction(gg_trg_Death_anim, Trig_Death_anim_Actions)
end
-- END FOREST SECTION 310
