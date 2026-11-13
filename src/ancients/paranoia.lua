-- ancients / paranoia
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 156 Realm_of_darkness
local darknessCast, darknessTargets

function Trig_Realm_of_darkness_Conditions()
    return GetSpellAbilityId() == FourCC("A0B7")
end

function Trig_Realm_of_darkness_Func002001002()
    return (IsUnitEnemy(GetFilterUnit(), FE_Roles.ancient()) == true)
end

function Trig_Realm_of_darkness_Func002A()
    UnitAddAbilityBJ(FourCC("A0B6"), GetEnumUnit())
    GroupAddUnit(darknessTargets, GetEnumUnit())
end

function Trig_Realm_of_darkness_Func005001002()
    return (IsUnitEnemy(GetFilterUnit(), FE_Roles.ancient()) == true)
end

function Trig_Realm_of_darkness_Func005A()
    if GetUnitTypeId(GetEnumUnit()) ~= 0 then UnitRemoveAbilityBJ(FourCC("A0B6"), GetEnumUnit()) end
end

function Trig_Realm_of_darkness_Actions()
    local cast = {}
    darknessCast = cast
    if not darknessTargets then darknessTargets = CreateGroup() end
    EnableTrigger(gg_trg_Realm_of_darkness_2)
    local group002 = GetUnitsInRectMatching(GetPlayableMapRect(), Condition(Trig_Realm_of_darkness_Func002001002))
    ForGroupBJ(group002, Trig_Realm_of_darkness_Func002A)
    DestroyGroup(group002)
    TriggerSleepAction(__jreal(60.00))
    if darknessCast ~= cast then return end
    darknessCast = nil
    DisableTrigger(gg_trg_Realm_of_darkness_2)
    -- Ownership/alliance changes must not leave the applied debuff behind.
    ForGroupBJ(darknessTargets, Trig_Realm_of_darkness_Func005A)
    DestroyGroup(darknessTargets)
    darknessTargets = nil
end

function InitTrig_Realm_of_darkness()
    gg_trg_Realm_of_darkness = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Realm_of_darkness, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Realm_of_darkness, Condition(Trig_Realm_of_darkness_Conditions))
    TriggerAddAction(gg_trg_Realm_of_darkness, Trig_Realm_of_darkness_Actions)
end
-- END FOREST SECTION 156

-- BEGIN FOREST SECTION 157 Realm_of_darkness_2
function Trig_Realm_of_darkness_2_Conditions()
    return IsUnitEnemy(GetTriggerUnit(), FE_Roles.ancient()) == true
end

function Trig_Realm_of_darkness_2_Actions()
    if darknessTargets then
        UnitAddAbilityBJ(FourCC("A0B6"), GetTriggerUnit())
        GroupAddUnit(darknessTargets, GetTriggerUnit())
    end
end

function InitTrig_Realm_of_darkness_2()
    gg_trg_Realm_of_darkness_2 = CreateTrigger()
    DisableTrigger(gg_trg_Realm_of_darkness_2)
    TriggerRegisterEnterRectSimple(gg_trg_Realm_of_darkness_2, GetPlayableMapRect())
    TriggerRegisterAnyUnitEventBJ(gg_trg_Realm_of_darkness_2, EVENT_PLAYER_UNIT_CONSTRUCT_START)
    TriggerAddCondition(gg_trg_Realm_of_darkness_2, Condition(Trig_Realm_of_darkness_2_Conditions))
    TriggerAddAction(gg_trg_Realm_of_darkness_2, Trig_Realm_of_darkness_2_Actions)
end
-- END FOREST SECTION 157
