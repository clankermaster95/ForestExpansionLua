-- Disabled in the original map.
function Trig_Bonus_XP_Actions()
    AddHeroXPSwapped(udg_XPperSecond, udg_Ledger, true)
end

function InitTrig_Bonus_XP()
    gg_trg_Bonus_XP = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(gg_trg_Bonus_XP, __jreal(1.00))
    TriggerAddAction(gg_trg_Bonus_XP, Trig_Bonus_XP_Actions)
end
