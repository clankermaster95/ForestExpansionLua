-- Disabled in the original map.
function Trig_Gara_2hits1g_2_Func001Func001A()
    SetUnitVertexColorBJ(GetEnumUnit(), __jreal(0.00), __jreal(0.00), __jreal(0.00), __jreal(100.00))
end

function Trig_Gara_2hits1g_2_Func001Func001001002()
    do return ((GetUnitTypeId(GetFilterUnit()) == FourCC("h06I"))) end
end

function Trig_Gara_2hits1g_2_Actions()
    bj_forLoopAIndex = 1
    bj_forLoopAIndexEnd = 11
    while true do
        if (bj_forLoopAIndex > bj_forLoopAIndexEnd) then break end
        ForGroupBJ(GetUnitsOfPlayerMatching(ConvertedPlayer(GetForLoopIndexA()), Condition(Trig_Gara_2hits1g_2_Func001Func001001002)), Trig_Gara_2hits1g_2_Func001Func001A)
        bj_forLoopAIndex = __jint(bj_forLoopAIndex + 1)
    end
end

function InitTrig_Gara_2hits1g_2()
    gg_trg_Gara_2hits1g_2 = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_Gara_2hits1g_2, __jreal(2.00))
    TriggerAddAction(gg_trg_Gara_2hits1g_2, Trig_Gara_2hits1g_2_Actions)
end
