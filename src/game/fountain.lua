-- game / fountain
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 19 Fountain_Heal
-- Original JASS function: Trig_Fountain_Heal_Func001Func001Func001C (line 5346)
function Trig_Fountain_Heal_Func001Func001Func001C()
    if ((not ((IsUnitType(GetEnumUnit(), UNIT_TYPE_STRUCTURE) == false)))) then
        do return false end
    end
    if ((not ((IsUnitAlly(GetEnumUnit(), FE_Roles.ancient()) == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Fountain_Heal_Func001Func001A (line 5356)
function Trig_Fountain_Heal_Func001Func001A()
    if (Trig_Fountain_Heal_Func001Func001Func001C()) then
        SetUnitLifePercentBJ(GetEnumUnit(), (__jreal(GetUnitLifePercent(GetEnumUnit()) + (__jreal(GetUnitLifePercent(GetEnumUnit()) * __jreal(0.25))))))
        SetUnitManaPercentBJ(GetEnumUnit(), (__jreal(GetUnitManaPercent(GetEnumUnit()) + (__jreal(GetUnitManaPercent(GetEnumUnit()) * __jreal(0.25))))))
        udg_TSEAttachPoint = "overhead"
        udg_TSEEffectName = "Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl"
        udg_TSETargetUnit = GetEnumUnit()
        ConditionalTriggerExecute(udg_TSE_RegisterTrigger)
    else
    end
end

-- Original JASS function: Trig_Fountain_Heal_Func001C (line 5368)
function Trig_Fountain_Heal_Func001C()
    if ((not ((udg_AncientInCombat == __jreal(0.00))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Fountain_Heal_Actions (line 5375)
function Trig_Fountain_Heal_Actions()
    if (Trig_Fountain_Heal_Func001C()) then
        ForGroupBJ(GetUnitsInRectAll(gg_rct_Fountain), Trig_Fountain_Heal_Func001Func001A)
    else
        udg_AncientInCombat = __jreal(0.00)
    end
end

-- Original JASS function: InitTrig_Fountain_Heal (line 5384)
function InitTrig_Fountain_Heal()
    gg_trg_Fountain_Heal = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(gg_trg_Fountain_Heal, __jreal(4.00))
    TriggerAddAction(gg_trg_Fountain_Heal, Trig_Fountain_Heal_Actions)
end
-- END FOREST SECTION 19
