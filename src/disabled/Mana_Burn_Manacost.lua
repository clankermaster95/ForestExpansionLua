-- Disabled in the original map.
function Trig_Mana_Burn_Manacost_Func001A()
    local u = GetEnumUnit()
    local mana = GetUnitState(u, UNIT_STATE_MANA)
    local cost = R2I(__jreal(mana * __jreal(0.2)))
    local abilLevel = GetUnitAbilityLevel(u, FourCC("A0RL"))
    BlzSetAbilityIntegerLevelField(FourCC("A0RL"), ABILITY_RLF_MANA_COST, abilLevel, cost)
    u = nil
end

function Trig_Mana_Burn_Manacost_Actions()
    ForGroupBJ(udg_ShadowDancers, Trig_Mana_Burn_Manacost_Func001A)
end

function InitTrig_Mana_Burn_Manacost()
    gg_trg_Mana_Burn_Manacost = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(gg_trg_Mana_Burn_Manacost, __jreal(0.50))
    TriggerAddAction(gg_trg_Mana_Burn_Manacost, Trig_Mana_Burn_Manacost_Actions)
end
