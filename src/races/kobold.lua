-- races / kobold
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 48 ShovelStrikelevelup
-- Original JASS function: Trig_ShovelStrikelevelup_Conditions (line 7453)
function Trig_ShovelStrikelevelup_Conditions()
    if ((not ((GetResearched() == FourCC("R004"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_ShovelStrikelevelup_Func003002 (line 7460)
function Trig_ShovelStrikelevelup_Func003002()
    IncUnitAbilityLevelSwapped(FourCC("A086"), GetEnumUnit())
end

-- Original JASS function: Trig_ShovelStrikelevelup_Actions (line 7464)
function Trig_ShovelStrikelevelup_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(GetOwningPlayer(GetResearchingUnit()), FourCC("h03Q")), Trig_ShovelStrikelevelup_Func003002)
end

-- Original JASS function: InitTrig_ShovelStrikelevelup (line 7469)
function InitTrig_ShovelStrikelevelup()
    gg_trg_ShovelStrikelevelup = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_ShovelStrikelevelup, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_ShovelStrikelevelup, Condition(Trig_ShovelStrikelevelup_Conditions))
    TriggerAddAction(gg_trg_ShovelStrikelevelup, Trig_ShovelStrikelevelup_Actions)
end
-- END FOREST SECTION 48
