-- game / overdrive
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 14 Enable_Overdrive
-- Original JASS function: Trig_Enable_Overdrive_Func004C (line 5152)
function Trig_Enable_Overdrive_Func004C()
    if ((not ((GetUnitTypeId(GetSpellAbilityUnit()) == FourCC("n011"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Enable_Overdrive_Conditions (line 5159)
function Trig_Enable_Overdrive_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A0CY"))))) then
        do return false end
    end
    if ((not Trig_Enable_Overdrive_Func004C())) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Enable_Overdrive_Actions (line 5169)
function Trig_Enable_Overdrive_Actions()
    SetPlayerTechResearchedSwap(FourCC("R06X"), 1, GetOwningPlayer(GetSpellAbilityUnit()))
    AdjustPlayerStateBJ(10000, GetOwningPlayer(GetSpellAbilityUnit()), PLAYER_STATE_RESOURCE_LUMBER)
end

-- Original JASS function: InitTrig_Enable_Overdrive (line 5175)
function InitTrig_Enable_Overdrive()
    gg_trg_Enable_Overdrive = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Enable_Overdrive, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Enable_Overdrive, Condition(Trig_Enable_Overdrive_Conditions))
    TriggerAddAction(gg_trg_Enable_Overdrive, Trig_Enable_Overdrive_Actions)
end
-- END FOREST SECTION 14

-- BEGIN FOREST SECTION 15 Disable_Overdrive
-- Original JASS function: Trig_Disable_Overdrive_Func003C (line 5185)
function Trig_Disable_Overdrive_Func003C()
    if ((not ((GetUnitTypeId(GetSpellAbilityUnit()) == FourCC("n011"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Disable_Overdrive_Conditions (line 5192)
function Trig_Disable_Overdrive_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A0CZ"))))) then
        do return false end
    end
    if ((not Trig_Disable_Overdrive_Func003C())) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Disable_Overdrive_Actions (line 5202)
function Trig_Disable_Overdrive_Actions()
    SetPlayerTechResearchedSwap(FourCC("R06X"), 0, GetOwningPlayer(GetSpellAbilityUnit()))
end

-- Original JASS function: InitTrig_Disable_Overdrive (line 5207)
function InitTrig_Disable_Overdrive()
    gg_trg_Disable_Overdrive = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Disable_Overdrive, EVENT_PLAYER_UNIT_SPELL_CAST)
    TriggerAddCondition(gg_trg_Disable_Overdrive, Condition(Trig_Disable_Overdrive_Conditions))
    TriggerAddAction(gg_trg_Disable_Overdrive, Trig_Disable_Overdrive_Actions)
end
-- END FOREST SECTION 15

-- BEGIN FOREST SECTION 16 Death
-- Original JASS function: Trig_Death_Conditions (line 5217)
function Trig_Death_Conditions()
    if ((not ((GetUnitTypeId(GetDyingUnit()) == FourCC("n011"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Death_Actions (line 5224)
function Trig_Death_Actions()
    SetPlayerTechResearchedSwap(FourCC("R06X"), 0, GetOwningPlayer(GetDyingUnit()))
end

-- Original JASS function: InitTrig_Death (line 5229)
function InitTrig_Death()
    gg_trg_Death = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Death, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Death, Condition(Trig_Death_Conditions))
    TriggerAddAction(gg_trg_Death, Trig_Death_Actions)
end
-- END FOREST SECTION 16
