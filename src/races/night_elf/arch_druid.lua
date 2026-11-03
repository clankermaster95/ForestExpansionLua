-- races / night_elf / arch_druid
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 51 Genesis
function Trig_Genesis_Conditions()
    return GetSpellAbilityId() == FourCC("A0AO")
end

function Trig_Genesis_Actions()
    local spellLoc = GetSpellTargetLoc()
    local caster = GetSpellAbilityUnit()
    local tree = nil
    local treeLoc = nil
    local treant = nil
    local dummy = nil
    CreateNUnitsAtLoc(1, FourCC("h04L"), GetOwningPlayer(caster), spellLoc, __jreal(0))
    dummy = GetLastCreatedUnit()
    UnitApplyTimedLifeBJ(__jreal(5.00), FourCC("BTLF"), GetLastCreatedUnit())
    CreateDestructableLoc(FourCC("LTlt"), spellLoc, GetRandomDirectionDeg(), __jreal(1), 0)
    tree = GetLastCreatedDestructable()
    SetDestructableAnimation(tree, "birth")
    SetDestructableAnimationSpeed(tree, __jreal(1.2))
    SetUnitAnimation(caster, "Spell Second")
    TriggerSleepAction(__jreal(3.0))
    if ((tree ~= nil) and (GetDestructableLife(tree) > __jreal(0))) then
        treeLoc = GetDestructableLoc(tree)
        SetDestructableAnimationSpeed(tree, __jreal(1))
        KillDestructable(tree)
        CreateNUnitsAtLoc(1, FourCC("e00U"), GetOwningPlayer(caster), treeLoc, __jreal(0))
        treant = GetLastCreatedUnit()
        UnitApplyTimedLife(treant, FourCC("BTLF"), __jreal(60.0))
        SetUnitAnimation(treant, "birth")
        TriggerSleepAction(__jreal(1))
        RemoveDestructable(tree)
        RemoveLocation(treeLoc)
    end
    RemoveLocation(spellLoc)
    caster = nil
    tree = nil
    treant = nil
end

function InitTrig_Genesis()
    gg_trg_Genesis = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Genesis, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Genesis, Condition(Trig_Genesis_Conditions))
    TriggerAddAction(gg_trg_Genesis, Trig_Genesis_Actions)
end
-- END FOREST SECTION 51
