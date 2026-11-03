-- combat / common
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 20 Ancient_In_Combat
-- Original JASS function: Trig_Ancient_In_Combat_Conditions (line 5393)
function Trig_Ancient_In_Combat_Conditions()
    if ((not ((udg_DamageEventAmount >= __jreal(100.00))))) then
        do return false end
    end
    if ((not ((udg_DamageEventTarget == udg_AncientUnit)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Ancient_In_Combat_Actions (line 5403)
function Trig_Ancient_In_Combat_Actions()
    udg_AncientInCombat = __jreal(1.00)
end

-- Original JASS function: InitTrig_Ancient_In_Combat (line 5408)
function InitTrig_Ancient_In_Combat()
    gg_trg_Ancient_In_Combat = CreateTrigger()
    h__TriggerRegisterVariableEvent(gg_trg_Ancient_In_Combat, "udg_DamageModifierEvent", EQUAL, __jreal(1.00))
    TriggerAddCondition(gg_trg_Ancient_In_Combat, Condition(Trig_Ancient_In_Combat_Conditions))
    TriggerAddAction(gg_trg_Ancient_In_Combat, Trig_Ancient_In_Combat_Actions)
end
-- END FOREST SECTION 20

-- BEGIN FOREST SECTION 27 Detonate
-- Original JASS function: Trig_Detonate_Func001001 (line 6247)
function Trig_Detonate_Func001001()
    do return ((GetSpellAbilityId() == FourCC("A08G"))) end
end

-- Original JASS function: Trig_Detonate_Func001002 (line 6251)
function Trig_Detonate_Func001002()
    do return ((GetSpellAbilityId() == FourCC("A0F2"))) end
end

-- Original JASS function: Trig_Detonate_Conditions (line 6255)
function Trig_Detonate_Conditions()
    if ((not GetBooleanOr(((GetSpellAbilityId() == FourCC("A08G"))), ((GetSpellAbilityId() == FourCC("A0F2")))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Detonate_Actions (line 6262)
function Trig_Detonate_Actions()
    KillUnit(GetTriggerUnit())
end

-- Original JASS function: InitTrig_Detonate (line 6267)
function InitTrig_Detonate()
    gg_trg_Detonate = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Detonate, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Detonate, Condition(Trig_Detonate_Conditions))
    TriggerAddAction(gg_trg_Detonate, Trig_Detonate_Actions)
end
-- END FOREST SECTION 27

-- BEGIN FOREST SECTION 28 Expander_Hero_XP
-- Original JASS function: Trig_Expander_Hero_XP_Conditions (line 6277)
function Trig_Expander_Hero_XP_Conditions()
    if ((not ((IsUnitType(udg_DamageEventSource, UNIT_TYPE_HERO) == true)))) then
        do return false end
    end
    if ((not ((IsUnitType(udg_DamageEventTarget, UNIT_TYPE_HERO) == true)))) then
        do return false end
    end
    if ((not ((udg_IsDamageAttack == true)))) then
        do return false end
    end
    if ((not ((IsUnitAlly(udg_DamageEventTarget, FE_Roles.ancient()) == true)))) then
        do return false end
    end
    if ((not ((IsUnitEnemy(udg_DamageEventSource, FE_Roles.ancient()) == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Expander_Hero_XP_Actions (line 6296)
function Trig_Expander_Hero_XP_Actions()
    AddHeroXPSwapped(50, udg_DamageEventSource, true)
end

-- Original JASS function: InitTrig_Expander_Hero_XP (line 6301)
function InitTrig_Expander_Hero_XP()
    gg_trg_Expander_Hero_XP = CreateTrigger()
    h__TriggerRegisterVariableEvent(gg_trg_Expander_Hero_XP, "udg_DamageEvent", EQUAL, __jreal(1.00))
    TriggerAddCondition(gg_trg_Expander_Hero_XP, Condition(Trig_Expander_Hero_XP_Conditions))
    TriggerAddAction(gg_trg_Expander_Hero_XP, Trig_Expander_Hero_XP_Actions)
end
-- END FOREST SECTION 28
