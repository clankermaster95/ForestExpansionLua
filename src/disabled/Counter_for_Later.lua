-- Disabled in the original map.
function Trig_Counter_for_Later_Actions()
    CreateMultiboardBJ(1, 1, "TRIGSTR_1012")
    CreateMultiboardBJ(1, 1, (__jconcat(udg_Tradeoff, "")))
end

function InitTrig_Counter_for_Later()
    gg_trg_Counter_for_Later = CreateTrigger()
    TriggerRegisterTimerExpireEventBJ(gg_trg_Counter_for_Later, udg_AncientSpawnTimer)
    TriggerAddAction(gg_trg_Counter_for_Later, Trig_Counter_for_Later_Actions)
end
