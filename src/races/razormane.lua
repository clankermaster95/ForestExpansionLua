-- races / razormane
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 134 Wood_Income
function Trig_Wood_Income_Func001002()
    AdjustPlayerStateBJ((__jdiv(GetPlayerState(GetEnumPlayer(), PLAYER_STATE_RESOURCE_FOOD_USED), 2)), GetEnumPlayer(), PLAYER_STATE_RESOURCE_LUMBER)
end

function Trig_Wood_Income_Actions()
    ForForce(udg_Razormane, Trig_Wood_Income_Func001002)
end

function InitTrig_Wood_Income()
    gg_trg_Wood_Income = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(gg_trg_Wood_Income, __jreal(10.00))
    TriggerAddAction(gg_trg_Wood_Income, Trig_Wood_Income_Actions)
end
-- END FOREST SECTION 134

-- BEGIN FOREST SECTION 135 Enter_Wood_Income
function Trig_Enter_Wood_Income_Conditions()
    return GetUnitTypeId(GetTriggerUnit()) == FourCC("o01E")
end

function Trig_Enter_Wood_Income_Actions()
    ForceAddPlayerSimple(GetOwningPlayer(GetTriggerUnit()), udg_Razormane)
end

function InitTrig_Enter_Wood_Income()
    gg_trg_Enter_Wood_Income = CreateTrigger()
    TriggerRegisterEnterRectSimple(gg_trg_Enter_Wood_Income, gg_rct_Spawn_all)
    TriggerAddCondition(gg_trg_Enter_Wood_Income, Condition(Trig_Enter_Wood_Income_Conditions))
    TriggerAddAction(gg_trg_Enter_Wood_Income, Trig_Enter_Wood_Income_Actions)
end
-- END FOREST SECTION 135
