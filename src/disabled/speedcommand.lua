-- Disabled in the original map.
function Trig_speedcommand_Func001A()
    SetUnitMoveSpeed(GetEnumUnit(), __jreal(522.00))
end

function Trig_speedcommand_Actions()
    ForGroupBJ(GetUnitsSelectedAll(Player(0)), Trig_speedcommand_Func001A)
end

function InitTrig_speedcommand()
    gg_trg_speedcommand = CreateTrigger()
    TriggerRegisterPlayerChatEvent(gg_trg_speedcommand, Player(0), "ms", false)
    TriggerAddAction(gg_trg_speedcommand, Trig_speedcommand_Actions)
end
