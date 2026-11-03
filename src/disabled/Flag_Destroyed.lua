-- Disabled in the original map.
function Trig_Flag_Destroyed_Func003C()
    if (((GetUnitTypeId(GetTriggerUnit()) == FourCC("h04Z")))) then
        do return true end
    end
    if (((GetUnitTypeId(GetTriggerUnit()) == FourCC("h050")))) then
        do return true end
    end
    if (((GetUnitTypeId(GetTriggerUnit()) == FourCC("h05P")))) then
        do return true end
    end
    if (((GetUnitTypeId(GetTriggerUnit()) == FourCC("h04Y")))) then
        do return true end
    end
    if (((GetUnitTypeId(GetTriggerUnit()) == FourCC("h04V")))) then
        do return true end
    end
    if (((GetUnitTypeId(GetTriggerUnit()) == FourCC("h04W")))) then
        do return true end
    end
    if (((GetUnitTypeId(GetTriggerUnit()) == FourCC("h05N")))) then
        do return true end
    end
    if (((GetUnitTypeId(GetTriggerUnit()) == FourCC("h04X")))) then
        do return true end
    end
    if (((GetUnitTypeId(GetTriggerUnit()) == FourCC("h051")))) then
        do return true end
    end
    if (((GetUnitTypeId(GetTriggerUnit()) == FourCC("h052")))) then
        do return true end
    end
    do return false end
end

function Trig_Flag_Destroyed_Conditions()
    if ((not Trig_Flag_Destroyed_Func003C())) then
        do return false end
    end
    do return true end
end

function Trig_Flag_Destroyed_Func001Func001C()
    if ((not ((RectContainsUnit(udg_GARATHORbaseList[GetForLoopIndexA()], GetTriggerUnit()) == true)))) then
        do return false end
    end
    do return true end
end

function Trig_Flag_Destroyed_Actions()
    bj_forLoopAIndex = 1
    bj_forLoopAIndexEnd = 10
    while true do
        if (bj_forLoopAIndex > bj_forLoopAIndexEnd) then break end
        if (Trig_Flag_Destroyed_Func001Func001C()) then
            udg_GARATHORflagCounters[GetForLoopIndexA()] = (__jint(udg_GARATHORflagCounters[GetForLoopIndexA()] - 1))
        else
        end
        bj_forLoopAIndex = __jint(bj_forLoopAIndex + 1)
    end
end

function InitTrig_Flag_Destroyed()
    gg_trg_Flag_Destroyed = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Flag_Destroyed, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Flag_Destroyed, Condition(Trig_Flag_Destroyed_Conditions))
    TriggerAddAction(gg_trg_Flag_Destroyed, Trig_Flag_Destroyed_Actions)
end
