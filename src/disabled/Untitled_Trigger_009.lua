-- Disabled in the original map.
function Trig_Untitled_Trigger_009_Actions()
end

function InitTrig_Untitled_Trigger_009()
    gg_trg_Untitled_Trigger_009 = CreateTrigger()
    TriggerRegisterPlayerChatEvent(gg_trg_Untitled_Trigger_009, ConvertedPlayer(1), "", true)
    TriggerAddAction(gg_trg_Untitled_Trigger_009, Trig_Untitled_Trigger_009_Actions)
end
