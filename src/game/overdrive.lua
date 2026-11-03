-- game / overdrive
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 14 Enable_Overdrive
function Trig_Enable_Overdrive_Func004C()
    return GetUnitTypeId(GetSpellAbilityUnit()) == FourCC("n011")
end

function Trig_Enable_Overdrive_Conditions()
    if (not (GetSpellAbilityId() == FourCC("A0CY"))) then
        return false
    end
    if (not Trig_Enable_Overdrive_Func004C()) then
        return false
    end
    return true
end

function Trig_Enable_Overdrive_Actions()
    SetPlayerTechResearchedSwap(FourCC("R06X"), 1, GetOwningPlayer(GetSpellAbilityUnit()))
    AdjustPlayerStateBJ(10000, GetOwningPlayer(GetSpellAbilityUnit()), PLAYER_STATE_RESOURCE_LUMBER)
end

function InitTrig_Enable_Overdrive()
    gg_trg_Enable_Overdrive = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Enable_Overdrive, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Enable_Overdrive, Condition(Trig_Enable_Overdrive_Conditions))
    TriggerAddAction(gg_trg_Enable_Overdrive, Trig_Enable_Overdrive_Actions)
end
-- END FOREST SECTION 14

-- BEGIN FOREST SECTION 15 Disable_Overdrive
function Trig_Disable_Overdrive_Func003C()
    return GetUnitTypeId(GetSpellAbilityUnit()) == FourCC("n011")
end

function Trig_Disable_Overdrive_Conditions()
    if (not (GetSpellAbilityId() == FourCC("A0CZ"))) then
        return false
    end
    if (not Trig_Disable_Overdrive_Func003C()) then
        return false
    end
    return true
end

function Trig_Disable_Overdrive_Actions()
    SetPlayerTechResearchedSwap(FourCC("R06X"), 0, GetOwningPlayer(GetSpellAbilityUnit()))
end

function InitTrig_Disable_Overdrive()
    gg_trg_Disable_Overdrive = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Disable_Overdrive, EVENT_PLAYER_UNIT_SPELL_CAST)
    TriggerAddCondition(gg_trg_Disable_Overdrive, Condition(Trig_Disable_Overdrive_Conditions))
    TriggerAddAction(gg_trg_Disable_Overdrive, Trig_Disable_Overdrive_Actions)
end
-- END FOREST SECTION 15

-- BEGIN FOREST SECTION 16 Death
function Trig_Death_Conditions()
    return GetUnitTypeId(GetDyingUnit()) == FourCC("n011")
end

function Trig_Death_Actions()
    SetPlayerTechResearchedSwap(FourCC("R06X"), 0, GetOwningPlayer(GetDyingUnit()))
end

function InitTrig_Death()
    gg_trg_Death = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Death, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Death, Condition(Trig_Death_Conditions))
    TriggerAddAction(gg_trg_Death, Trig_Death_Actions)
end
-- END FOREST SECTION 16
