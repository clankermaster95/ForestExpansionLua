-- races / elf_engineer
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 46 Lightning_Strike_TowerVers
function Trig_Lightning_Strike_TowerVers_Conditions()
    return GetSpellAbilityId() == FourCC("A0C2")
end

function Trig_Lightning_Strike_TowerVers_Actions()
end

function InitTrig_Lightning_Strike_TowerVers()
    gg_trg_Lightning_Strike_TowerVers = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Lightning_Strike_TowerVers, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Lightning_Strike_TowerVers, Condition(Trig_Lightning_Strike_TowerVers_Conditions))
    TriggerAddAction(gg_trg_Lightning_Strike_TowerVers, Trig_Lightning_Strike_TowerVers_Actions)
end
-- END FOREST SECTION 46

-- BEGIN FOREST SECTION 47 Blizzard
function Trig_Blizzard_Conditions()
    if (not (IsUnitType(udg_DamageEventSource, UNIT_TYPE_HERO) == true)) then
        return false
    end
    if (not (IsUnitType(udg_DamageEventTarget, UNIT_TYPE_HERO) == true)) then
        return false
    end
    if (not (udg_IsDamageAttack == true)) then
        return false
    end
    return true
end

function Trig_Blizzard_Actions()
end

function InitTrig_Blizzard()
    gg_trg_Blizzard = CreateTrigger()
    h__TriggerRegisterVariableEvent(gg_trg_Blizzard, "udg_DamageEvent", EQUAL, __jreal(1.00))
    TriggerAddCondition(gg_trg_Blizzard, Condition(Trig_Blizzard_Conditions))
    TriggerAddAction(gg_trg_Blizzard, Trig_Blizzard_Actions)
end
-- END FOREST SECTION 47
