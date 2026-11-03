-- combat / common
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 20 Ancient_In_Combat
function Trig_Ancient_In_Combat_Conditions()
    if (not (udg_DamageEventAmount >= __jreal(100.00))) then
        return false
    end
    if (not (udg_DamageEventTarget == udg_AncientUnit)) then
        return false
    end
    return true
end

function Trig_Ancient_In_Combat_Actions()
    udg_AncientInCombat = __jreal(1.00)
end

function InitTrig_Ancient_In_Combat()
    gg_trg_Ancient_In_Combat = CreateTrigger()
    h__TriggerRegisterVariableEvent(gg_trg_Ancient_In_Combat, "udg_DamageModifierEvent", EQUAL, __jreal(1.00))
    TriggerAddCondition(gg_trg_Ancient_In_Combat, Condition(Trig_Ancient_In_Combat_Conditions))
    TriggerAddAction(gg_trg_Ancient_In_Combat, Trig_Ancient_In_Combat_Actions)
end
-- END FOREST SECTION 20

-- BEGIN FOREST SECTION 27 Detonate

function Trig_Detonate_Conditions()
    return not not (GetBooleanOr((GetSpellAbilityId() == FourCC("A08G")), (GetSpellAbilityId() == FourCC("A0F2"))))
end

function Trig_Detonate_Actions()
    KillUnit(GetTriggerUnit())
end

function InitTrig_Detonate()
    gg_trg_Detonate = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Detonate, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Detonate, Condition(Trig_Detonate_Conditions))
    TriggerAddAction(gg_trg_Detonate, Trig_Detonate_Actions)
end
-- END FOREST SECTION 27

-- BEGIN FOREST SECTION 28 Expander_Hero_XP
function Trig_Expander_Hero_XP_Conditions()
    if (not (IsUnitType(udg_DamageEventSource, UNIT_TYPE_HERO) == true)) then
        return false
    end
    if (not (IsUnitType(udg_DamageEventTarget, UNIT_TYPE_HERO) == true)) then
        return false
    end
    if (not (udg_IsDamageAttack == true)) then
        return false
    end
    if (not (IsUnitAlly(udg_DamageEventTarget, FE_Roles.ancient()) == true)) then
        return false
    end
    if (not (IsUnitEnemy(udg_DamageEventSource, FE_Roles.ancient()) == true)) then
        return false
    end
    return true
end

function Trig_Expander_Hero_XP_Actions()
    AddHeroXPSwapped(50, udg_DamageEventSource, true)
end

function InitTrig_Expander_Hero_XP()
    gg_trg_Expander_Hero_XP = CreateTrigger()
    h__TriggerRegisterVariableEvent(gg_trg_Expander_Hero_XP, "udg_DamageEvent", EQUAL, __jreal(1.00))
    TriggerAddCondition(gg_trg_Expander_Hero_XP, Condition(Trig_Expander_Hero_XP_Conditions))
    TriggerAddAction(gg_trg_Expander_Hero_XP, Trig_Expander_Hero_XP_Actions)
end
-- END FOREST SECTION 28
