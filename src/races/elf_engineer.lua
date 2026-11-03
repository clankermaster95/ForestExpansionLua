-- races / elf_engineer
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 46 Lightning_Strike_TowerVers
-- Original JASS function: Trig_Lightning_Strike_TowerVers_Conditions (line 7404)
function Trig_Lightning_Strike_TowerVers_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A0C2"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Lightning_Strike_TowerVers_Actions (line 7411)
function Trig_Lightning_Strike_TowerVers_Actions()
end

-- Original JASS function: InitTrig_Lightning_Strike_TowerVers (line 7415)
function InitTrig_Lightning_Strike_TowerVers()
    gg_trg_Lightning_Strike_TowerVers = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Lightning_Strike_TowerVers, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Lightning_Strike_TowerVers, Condition(Trig_Lightning_Strike_TowerVers_Conditions))
    TriggerAddAction(gg_trg_Lightning_Strike_TowerVers, Trig_Lightning_Strike_TowerVers_Actions)
end
-- END FOREST SECTION 46

-- BEGIN FOREST SECTION 47 Blizzard
-- Original JASS function: Trig_Blizzard_Conditions (line 7426)
function Trig_Blizzard_Conditions()
    if ((not ((IsUnitType(udg_DamageEventSource, UNIT_TYPE_HERO) == true)))) then
        do return false end
    end
    if ((not ((IsUnitType(udg_DamageEventTarget, UNIT_TYPE_HERO) == true)))) then
        do return false end
    end
    if ((not ((udg_IsDamageAttack == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Blizzard_Actions (line 7439)
function Trig_Blizzard_Actions()
end

-- Original JASS function: InitTrig_Blizzard (line 7443)
function InitTrig_Blizzard()
    gg_trg_Blizzard = CreateTrigger()
    h__TriggerRegisterVariableEvent(gg_trg_Blizzard, "udg_DamageEvent", EQUAL, __jreal(1.00))
    TriggerAddCondition(gg_trg_Blizzard, Condition(Trig_Blizzard_Conditions))
    TriggerAddAction(gg_trg_Blizzard, Trig_Blizzard_Actions)
end
-- END FOREST SECTION 47
