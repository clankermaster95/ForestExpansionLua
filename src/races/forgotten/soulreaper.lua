-- races / forgotten / soulreaper
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 87 Feast_of_Souls
function Trig_Feast_of_Souls_Conditions()
    return GetSpellAbilityId() == FourCC("A05Z")
end

function Trig_Feast_of_Souls_Actions()
    SetUnitLifeBJ(GetSpellAbilityUnit(), (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) + __jreal(700.00))))
end

function InitTrig_Feast_of_Souls()
    gg_trg_Feast_of_Souls = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Feast_of_Souls, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Feast_of_Souls, Condition(Trig_Feast_of_Souls_Conditions))
    TriggerAddAction(gg_trg_Feast_of_Souls, Trig_Feast_of_Souls_Actions)
end
-- END FOREST SECTION 87

-- BEGIN FOREST SECTION 88 Soul_Strike
function Trig_Soul_Strike_Conditions()
    return GetSpellAbilityId() == FourCC("A05O")
end

function Trig_Soul_Strike_Actions()
    SetUnitLifeBJ(GetSpellAbilityUnit(), (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) + __jreal(200.00))))
end

function InitTrig_Soul_Strike()
    gg_trg_Soul_Strike = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Soul_Strike, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Soul_Strike, Condition(Trig_Soul_Strike_Conditions))
    TriggerAddAction(gg_trg_Soul_Strike, Trig_Soul_Strike_Actions)
end
-- END FOREST SECTION 88

-- BEGIN FOREST SECTION 89 Avatar
function Trig_Avatar_Conditions()
    return GetSpellAbilityId() == FourCC("A078")
end

function Trig_Avatar_Actions()
    CreateNUnitsAtLoc(1, FourCC("h04L"), GetOwningPlayer(GetTriggerUnit()), GetUnitLoc(GetTriggerUnit()), bj_UNIT_FACING)
    IssueTargetOrderBJ(GetLastCreatedUnit(), "bloodlust", GetSpellAbilityUnit())
    UnitApplyTimedLifeBJ(__jreal(1.00), FourCC("BTLF"), GetLastCreatedUnit())
    SetUnitAbilityLevelSwapped(FourCC("A067"), GetTriggerUnit(), 2)
    TriggerSleepAction(__jreal(10.00))
    SetUnitAbilityLevelSwapped(FourCC("A067"), GetTriggerUnit(), 1)
end

function InitTrig_Avatar()
    gg_trg_Avatar = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Avatar, EVENT_PLAYER_UNIT_SPELL_CAST)
    TriggerAddCondition(gg_trg_Avatar, Condition(Trig_Avatar_Conditions))
    TriggerAddAction(gg_trg_Avatar, Trig_Avatar_Actions)
end
-- END FOREST SECTION 89
