-- races / forgotten / soulreaper
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 87 Feast_of_Souls
-- Original JASS function: Trig_Feast_of_Souls_Conditions (line 8772)
function Trig_Feast_of_Souls_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A05Z"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Feast_of_Souls_Actions (line 8779)
function Trig_Feast_of_Souls_Actions()
    SetUnitLifeBJ(GetSpellAbilityUnit(), (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) + __jreal(700.00))))
end

-- Original JASS function: InitTrig_Feast_of_Souls (line 8784)
function InitTrig_Feast_of_Souls()
    gg_trg_Feast_of_Souls = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Feast_of_Souls, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Feast_of_Souls, Condition(Trig_Feast_of_Souls_Conditions))
    TriggerAddAction(gg_trg_Feast_of_Souls, Trig_Feast_of_Souls_Actions)
end
-- END FOREST SECTION 87

-- BEGIN FOREST SECTION 88 Soul_Strike
-- Original JASS function: Trig_Soul_Strike_Conditions (line 8794)
function Trig_Soul_Strike_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A05O"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Soul_Strike_Actions (line 8801)
function Trig_Soul_Strike_Actions()
    SetUnitLifeBJ(GetSpellAbilityUnit(), (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) + __jreal(200.00))))
end

-- Original JASS function: InitTrig_Soul_Strike (line 8806)
function InitTrig_Soul_Strike()
    gg_trg_Soul_Strike = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Soul_Strike, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Soul_Strike, Condition(Trig_Soul_Strike_Conditions))
    TriggerAddAction(gg_trg_Soul_Strike, Trig_Soul_Strike_Actions)
end
-- END FOREST SECTION 88

-- BEGIN FOREST SECTION 89 Avatar
-- Original JASS function: Trig_Avatar_Conditions (line 8816)
function Trig_Avatar_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A078"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Avatar_Actions (line 8823)
function Trig_Avatar_Actions()
    CreateNUnitsAtLoc(1, FourCC("h04L"), GetOwningPlayer(GetTriggerUnit()), GetUnitLoc(GetTriggerUnit()), bj_UNIT_FACING)
    IssueTargetOrderBJ(GetLastCreatedUnit(), "bloodlust", GetSpellAbilityUnit())
    UnitApplyTimedLifeBJ(__jreal(1.00), FourCC("BTLF"), GetLastCreatedUnit())
    SetUnitAbilityLevelSwapped(FourCC("A067"), GetTriggerUnit(), 2)
    TriggerSleepAction(__jreal(10.00))
    SetUnitAbilityLevelSwapped(FourCC("A067"), GetTriggerUnit(), 1)
end

-- Original JASS function: InitTrig_Avatar (line 8833)
function InitTrig_Avatar()
    gg_trg_Avatar = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Avatar, EVENT_PLAYER_UNIT_SPELL_CAST)
    TriggerAddCondition(gg_trg_Avatar, Condition(Trig_Avatar_Conditions))
    TriggerAddAction(gg_trg_Avatar, Trig_Avatar_Actions)
end
-- END FOREST SECTION 89
