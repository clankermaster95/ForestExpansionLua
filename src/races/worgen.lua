-- races / worgen
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 151 Return_lumber
-- Original JASS function: Trig_Return_lumber_Conditions (line 11019)
function Trig_Return_lumber_Conditions()
    if ((not ((GetIssuedOrderIdBJ() == String2OrderIdBJ("harvest"))))) then
        do return false end
    end
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("h00R"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Return_lumber_Actions (line 11029)
function Trig_Return_lumber_Actions()
    SetPlayerStateBJ(GetOwningPlayer(GetTriggerUnit()), PLAYER_STATE_RESOURCE_GOLD, (__jint(GetPlayerState(GetOwningPlayer(GetTriggerUnit()), PLAYER_STATE_RESOURCE_GOLD) + 1)))
end

-- Original JASS function: InitTrig_Return_lumber (line 11034)
function InitTrig_Return_lumber()
    gg_trg_Return_lumber = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Return_lumber, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER)
    TriggerAddCondition(gg_trg_Return_lumber, Condition(Trig_Return_lumber_Conditions))
    TriggerAddAction(gg_trg_Return_lumber, Trig_Return_lumber_Actions)
end
-- END FOREST SECTION 151

-- BEGIN FOREST SECTION 152 Slash_Leveled
-- Original JASS function: Trig_Slash_Leveled_Conditions (line 11044)
function Trig_Slash_Leveled_Conditions()
    if ((not ((GetResearched() == FourCC("R030"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Slash_Leveled_Func001002 (line 11051)
function Trig_Slash_Leveled_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A042"), GetEnumUnit())
end

-- Original JASS function: Trig_Slash_Leveled_Actions (line 11055)
function Trig_Slash_Leveled_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(GetTriggerPlayer(), FourCC("h00R")), Trig_Slash_Leveled_Func001002)
end

-- Original JASS function: InitTrig_Slash_Leveled (line 11060)
function InitTrig_Slash_Leveled()
    gg_trg_Slash_Leveled = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Slash_Leveled, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Slash_Leveled, Condition(Trig_Slash_Leveled_Conditions))
    TriggerAddAction(gg_trg_Slash_Leveled, Trig_Slash_Leveled_Actions)
end
-- END FOREST SECTION 152

-- BEGIN FOREST SECTION 153 Bleed_Leveled
-- Original JASS function: Trig_Bleed_Leveled_Conditions (line 11070)
function Trig_Bleed_Leveled_Conditions()
    if ((not ((GetResearched() == FourCC("R030"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Bleed_Leveled_Func001002 (line 11077)
function Trig_Bleed_Leveled_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A04C"), GetEnumUnit())
end

-- Original JASS function: Trig_Bleed_Leveled_Actions (line 11081)
function Trig_Bleed_Leveled_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(GetTriggerPlayer(), FourCC("h00R")), Trig_Bleed_Leveled_Func001002)
end

-- Original JASS function: InitTrig_Bleed_Leveled (line 11086)
function InitTrig_Bleed_Leveled()
    gg_trg_Bleed_Leveled = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Bleed_Leveled, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Bleed_Leveled, Condition(Trig_Bleed_Leveled_Conditions))
    TriggerAddAction(gg_trg_Bleed_Leveled, Trig_Bleed_Leveled_Actions)
end
-- END FOREST SECTION 153

-- BEGIN FOREST SECTION 154 Focused_Strike
-- Original JASS function: Trig_Focused_Strike_Conditions (line 11096)
function Trig_Focused_Strike_Conditions()
    if ((not ((GetUnitTypeId(GetAttacker()) == FourCC("h00R"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Focused_Strike_Actions (line 11103)
function Trig_Focused_Strike_Actions()
    local attacker = GetAttacker()
    TriggerSleepAction(__jreal(0.50))
    if GetUnitTypeId(attacker) ~= 0 then UnitRemoveBuffBJ(FourCC("B02U"), attacker) end
end

-- Original JASS function: InitTrig_Focused_Strike (line 11111)
function InitTrig_Focused_Strike()
    gg_trg_Focused_Strike = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Focused_Strike, EVENT_PLAYER_UNIT_ATTACKED)
    TriggerAddCondition(gg_trg_Focused_Strike, Condition(Trig_Focused_Strike_Conditions))
    TriggerAddAction(gg_trg_Focused_Strike, Trig_Focused_Strike_Actions)
end
-- END FOREST SECTION 154
