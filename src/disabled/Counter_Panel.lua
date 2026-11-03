-- Disabled in the original map.
function Trig_Counter_Panel_Actions()
    CreateMultiboardBJ(1, 1, (__jconcat((__jconcat("Information  -  ", (__jconcat("|cffcdcd00[|r ", (__jconcat((__jconcat(udg_TreeChopper, " ")), (__jconcat(udg_Tradeoff, "|cffcdcd00 ]  -  |r")))))))), udg_Counterstring)))
    MultiboardSetItemWidthBJ(GetLastCreatedMultiboard(), 1, 1, __jreal(9.00))
    MultiboardSetItemStyleBJ(GetLastCreatedMultiboard(), 1, 1, true, false)
end

function InitTrig_Counter_Panel()
    gg_trg_Counter_Panel = CreateTrigger()
    TriggerRegisterTimerExpireEventBJ(gg_trg_Counter_Panel, udg_AncientSpawnTimer)
    TriggerAddAction(gg_trg_Counter_Panel, Trig_Counter_Panel_Actions)
end
