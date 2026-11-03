-- Disabled in the original map.
function Trig_Seed_of_Rebirth_Conditions()
    if ((not ((GetResearched() == FourCC("R05G"))))) then
        do return false end
    end
    do return true end
end

function Trig_Seed_of_Rebirth_Func001002()
    DoNothing()
end

function Trig_Seed_of_Rebirth_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(GetOwningPlayer(GetResearchingUnit()), FourCC("h02L")), Trig_Seed_of_Rebirth_Func001002)
    udg_SeedO = GetEnumUnit()
end

function InitTrig_Seed_of_Rebirth()
    gg_trg_Seed_of_Rebirth = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Seed_of_Rebirth, EVENT_PLAYER_UNIT_UPGRADE_FINISH)
    TriggerAddCondition(gg_trg_Seed_of_Rebirth, Condition(Trig_Seed_of_Rebirth_Conditions))
    TriggerAddAction(gg_trg_Seed_of_Rebirth, Trig_Seed_of_Rebirth_Actions)
end
