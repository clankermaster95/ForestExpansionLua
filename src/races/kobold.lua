-- races / kobold
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 48 ShovelStrikelevelup
function Trig_ShovelStrikelevelup_Conditions()
    return GetResearched() == FourCC("R004")
end

function Trig_ShovelStrikelevelup_Func003002()
    IncUnitAbilityLevelSwapped(FourCC("A086"), GetEnumUnit())
end

function Trig_ShovelStrikelevelup_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(GetOwningPlayer(GetResearchingUnit()), FourCC("h03Q")), Trig_ShovelStrikelevelup_Func003002)
end

function InitTrig_ShovelStrikelevelup()
    gg_trg_ShovelStrikelevelup = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_ShovelStrikelevelup, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_ShovelStrikelevelup, Condition(Trig_ShovelStrikelevelup_Conditions))
    TriggerAddAction(gg_trg_ShovelStrikelevelup, Trig_ShovelStrikelevelup_Actions)
end
-- END FOREST SECTION 48
