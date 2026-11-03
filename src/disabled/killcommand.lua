-- Disabled in the original map.
function Trig_killcommand_Func001A()
    KillUnit(GetEnumUnit())
end

function Trig_killcommand_Actions()
    ForGroupBJ(GetUnitsSelectedAll(Player(0)), Trig_killcommand_Func001A)
end

function InitTrig_killcommand()
    gg_trg_killcommand = CreateTrigger()
    TriggerRegisterPlayerChatEvent(gg_trg_killcommand, Player(0), "kill", false)
    TriggerAddAction(gg_trg_killcommand, Trig_killcommand_Actions)
end
