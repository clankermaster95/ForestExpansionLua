-- races / worgen
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

FE_Worgen = {}

function FE_Worgen.restoreResearch(unit)
    if GetUnitTypeId(unit) ~= FourCC("h00R") then return end
    local level = 1 + GetPlayerTechCount(GetOwningPlayer(unit), FourCC("R030"), true)
    for _, raw in ipairs({"A042", "A04C"}) do
        local ability = FourCC(raw)
        if GetUnitAbilityLevel(unit, ability) > 0 then SetUnitAbilityLevel(unit, ability, level) end
    end
end

-- BEGIN FOREST SECTION 151 Return_lumber
function Trig_Return_lumber_Conditions()
    if (not (GetIssuedOrderIdBJ() == String2OrderIdBJ("harvest"))) then
        return false
    end
    if (not (GetUnitTypeId(GetTriggerUnit()) == FourCC("h00R"))) then
        return false
    end
    return true
end

function Trig_Return_lumber_Actions()
    -- Issuing a harvest order does not prove any work was completed. Paying
    -- here allowed repeated orders to mint gold. World-tree hits pay through
    -- Trig_Worgens_gold_Actions, including the Worgen's two-gold reward.
end

function InitTrig_Return_lumber()
    gg_trg_Return_lumber = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Return_lumber, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER)
    TriggerAddCondition(gg_trg_Return_lumber, Condition(Trig_Return_lumber_Conditions))
    TriggerAddAction(gg_trg_Return_lumber, Trig_Return_lumber_Actions)
end
-- END FOREST SECTION 151

-- BEGIN FOREST SECTION 152 Slash_Leveled
function Trig_Slash_Leveled_Conditions()
    return GetResearched() == FourCC("R030")
end

function Trig_Slash_Leveled_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A042"), GetEnumUnit())
end

function Trig_Slash_Leveled_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(GetTriggerPlayer(), FourCC("h00R")), Trig_Slash_Leveled_Func001002)
end

function InitTrig_Slash_Leveled()
    gg_trg_Slash_Leveled = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Slash_Leveled, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Slash_Leveled, Condition(Trig_Slash_Leveled_Conditions))
    TriggerAddAction(gg_trg_Slash_Leveled, Trig_Slash_Leveled_Actions)
end
-- END FOREST SECTION 152

-- BEGIN FOREST SECTION 153 Bleed_Leveled
function Trig_Bleed_Leveled_Conditions()
    return GetResearched() == FourCC("R030")
end

function Trig_Bleed_Leveled_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A04C"), GetEnumUnit())
end

function Trig_Bleed_Leveled_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(GetTriggerPlayer(), FourCC("h00R")), Trig_Bleed_Leveled_Func001002)
end

function InitTrig_Bleed_Leveled()
    gg_trg_Bleed_Leveled = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Bleed_Leveled, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Bleed_Leveled, Condition(Trig_Bleed_Leveled_Conditions))
    TriggerAddAction(gg_trg_Bleed_Leveled, Trig_Bleed_Leveled_Actions)
end
-- END FOREST SECTION 153

-- BEGIN FOREST SECTION 154 Focused_Strike
function Trig_Focused_Strike_Conditions()
    return GetUnitTypeId(GetAttacker()) == FourCC("h00R")
end

function Trig_Focused_Strike_Actions()
    local attacker = GetAttacker()
    TriggerSleepAction(__jreal(0.50))
    if GetUnitTypeId(attacker) ~= 0 then UnitRemoveBuffBJ(FourCC("B02U"), attacker) end
end

function InitTrig_Focused_Strike()
    gg_trg_Focused_Strike = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Focused_Strike, EVENT_PLAYER_UNIT_ATTACKED)
    TriggerAddCondition(gg_trg_Focused_Strike, Condition(Trig_Focused_Strike_Conditions))
    TriggerAddAction(gg_trg_Focused_Strike, Trig_Focused_Strike_Actions)
end
-- END FOREST SECTION 154
