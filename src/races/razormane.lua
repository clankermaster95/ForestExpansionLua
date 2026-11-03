-- races / razormane
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 134 Wood_Income
-- Original JASS function: Trig_Wood_Income_Func001002 (line 10445)
function Trig_Wood_Income_Func001002()
    AdjustPlayerStateBJ((__jdiv(GetPlayerState(GetEnumPlayer(), PLAYER_STATE_RESOURCE_FOOD_USED), 2)), GetEnumPlayer(), PLAYER_STATE_RESOURCE_LUMBER)
end

-- Original JASS function: Trig_Wood_Income_Actions (line 10449)
function Trig_Wood_Income_Actions()
    ForForce(udg_Razormane, Trig_Wood_Income_Func001002)
end

-- Original JASS function: InitTrig_Wood_Income (line 10454)
function InitTrig_Wood_Income()
    gg_trg_Wood_Income = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(gg_trg_Wood_Income, __jreal(10.00))
    TriggerAddAction(gg_trg_Wood_Income, Trig_Wood_Income_Actions)
end
-- END FOREST SECTION 134

-- BEGIN FOREST SECTION 135 Enter_Wood_Income
-- Original JASS function: Trig_Enter_Wood_Income_Conditions (line 10463)
function Trig_Enter_Wood_Income_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("o01E"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Enter_Wood_Income_Actions (line 10470)
function Trig_Enter_Wood_Income_Actions()
    ForceAddPlayerSimple(GetOwningPlayer(GetTriggerUnit()), udg_Razormane)
end

-- Original JASS function: InitTrig_Enter_Wood_Income (line 10475)
function InitTrig_Enter_Wood_Income()
    gg_trg_Enter_Wood_Income = CreateTrigger()
    TriggerRegisterEnterRectSimple(gg_trg_Enter_Wood_Income, gg_rct_Spawn_all)
    TriggerAddCondition(gg_trg_Enter_Wood_Income, Condition(Trig_Enter_Wood_Income_Conditions))
    TriggerAddAction(gg_trg_Enter_Wood_Income, Trig_Enter_Wood_Income_Actions)
end
-- END FOREST SECTION 135
