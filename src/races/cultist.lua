-- races / cultist
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 36 Limb_Throw
function Trig_Limb_Throw_Conditions()
    if (not (GetUnitTypeId(GetSpellAbilityUnit()) == FourCC("H064"))) then
        return false
    end
    if (not (GetSpellAbilityId() == FourCC("A0EE"))) then
        return false
    end
    return true
end

function Trig_Limb_Throw_Actions()
    SetUnitLifeBJ(GetSpellAbilityUnit(), (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, GetSpellAbilityUnit()) - (__jreal(GetUnitStateSwap(UNIT_STATE_MAX_LIFE, GetSpellAbilityUnit()) * __jreal(0.15))))))
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_8758")
end

function InitTrig_Limb_Throw()
    gg_trg_Limb_Throw = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Limb_Throw, EVENT_PLAYER_UNIT_SPELL_CAST)
    TriggerAddCondition(gg_trg_Limb_Throw, Condition(Trig_Limb_Throw_Conditions))
    TriggerAddAction(gg_trg_Limb_Throw, Trig_Limb_Throw_Actions)
end
-- END FOREST SECTION 36

-- BEGIN FOREST SECTION 37 Flesh_Stampede
function FleshStampede_Remove(u)
    local id = 0
    if (u == nil) then
        return
    end
    id = GetHandleId(u)
    GroupRemoveUnit(FleshStampede_Group, u)
    FlushChildHashtable(FleshStampede_Hash, id)
end

function FleshStampede_Add(u)
    local id = 0
    if (u == nil) then
        return
    end
    if (GetUnitAbilityLevel(u, FLESH_STAMPEDE_ABILITY_ID) <= 0) then
        return
    end
    id = GetHandleId(u)
    GroupAddUnit(FleshStampede_Group, u)
    SaveInteger(FleshStampede_Hash, id, FLESH_STAMPEDE_MISS_KEY, 0)
    EnableTrigger(gg_trg_Flesh_Stampede)
end

function FleshStampede_LoopEnum()
    local u = GetEnumUnit()
    local id = GetHandleId(u)
    local missCount = 0
    if (GetUnitState(u, UNIT_STATE_LIFE) <= __jreal(0.405)) then
        FleshStampede_Remove(u)
    elseif (GetUnitAbilityLevel(u, FLESH_STAMPEDE_ABILITY_ID) <= 0) then
        FleshStampede_Remove(u)
    elseif UnitHasBuffBJ(u, FLESH_STAMPEDE_BUFF_ID) then
        SaveInteger(FleshStampede_Hash, id, FLESH_STAMPEDE_MISS_KEY, 0)
        SetUnitLifeBJ(u, __jreal(GetUnitState(u, UNIT_STATE_LIFE) - (__jreal(GetUnitState(u, UNIT_STATE_MAX_LIFE) * FLESH_STAMPEDE_DAMAGE_FACTOR))))
    else
        missCount = __jint(LoadInteger(FleshStampede_Hash, id, FLESH_STAMPEDE_MISS_KEY) + 1)
        if (missCount >= FLESH_STAMPEDE_MISS_LIMIT) then
            FleshStampede_Remove(u)
        else
            SaveInteger(FleshStampede_Hash, id, FLESH_STAMPEDE_MISS_KEY, missCount)
        end
    end
    u = nil
end

function Trig_Flesh_Stampede_Actions()
    ForGroup(FleshStampede_Group, FleshStampede_LoopEnum)
    if (FirstOfGroup(FleshStampede_Group) == nil) then
        DisableTrigger(gg_trg_Flesh_Stampede)
    end
end

function FleshStampede_Order_Conditions()
    return (GetUnitAbilityLevel(GetTriggerUnit(), FLESH_STAMPEDE_ABILITY_ID) > 0)
end

function FleshStampede_Order_Actions()
    local u = GetTriggerUnit()
    local orderId = GetIssuedOrderId()
    if (orderId == OrderId("immolation")) then
        FleshStampede_Add(u)
    elseif (orderId == OrderId("unimmolation")) then
        FleshStampede_Remove(u)
    end
    u = nil
end

function FleshStampede_Death_Actions()
    local u = GetTriggerUnit()
    if IsUnitInGroup(u, FleshStampede_Group) then
        FleshStampede_Remove(u)
    end
    u = nil
end

function InitTrig_Flesh_Stampede()
    local orderTrig = CreateTrigger()
    local deathTrig = CreateTrigger()
    if (FleshStampede_Group == nil) then
        FleshStampede_Group = CreateGroup()
    end
    if (FleshStampede_Hash == nil) then
        FleshStampede_Hash = InitHashtable()
    end
    gg_trg_Flesh_Stampede = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(gg_trg_Flesh_Stampede, FLESH_STAMPEDE_PERIOD)
    TriggerAddAction(gg_trg_Flesh_Stampede, Trig_Flesh_Stampede_Actions)
    DisableTrigger(gg_trg_Flesh_Stampede)
    TriggerRegisterAnyUnitEventBJ(orderTrig, EVENT_PLAYER_UNIT_ISSUED_ORDER)
    TriggerAddCondition(orderTrig, Condition(FleshStampede_Order_Conditions))
    TriggerAddAction(orderTrig, FleshStampede_Order_Actions)
    TriggerRegisterAnyUnitEventBJ(deathTrig, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddAction(deathTrig, FleshStampede_Death_Actions)
    orderTrig = nil
    deathTrig = nil
end
-- END FOREST SECTION 37

-- BEGIN FOREST SECTION 38 Amalgamation
function Trig_Amalgamation_Conditions()
    return GetUnitTypeId(GetTriggerUnit()) == FourCC("H064")
end

function Trig_Amalgamation_Func001Func002C()
    return GetIssuedOrderIdBJ() == String2OrderIdBJ("unimmolation")
end

function Trig_Amalgamation_Func001C()
    return GetIssuedOrderIdBJ() == String2OrderIdBJ("immolation")
end

function Trig_Amalgamation_Actions()
    if (Trig_Amalgamation_Func001C()) then
        SetUnitMoveSpeed(GetTriggerUnit(), (__jreal(GetUnitDefaultMoveSpeed(GetTriggerUnit()) + __jreal(80.00))))
    else
        if (Trig_Amalgamation_Func001Func002C()) then
            SetUnitMoveSpeed(GetTriggerUnit(), GetUnitDefaultMoveSpeed(GetTriggerUnit()))
        end
    end
end

function InitTrig_Amalgamation()
    gg_trg_Amalgamation = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Amalgamation, EVENT_PLAYER_UNIT_ISSUED_ORDER)
    TriggerAddCondition(gg_trg_Amalgamation, Condition(Trig_Amalgamation_Conditions))
    TriggerAddAction(gg_trg_Amalgamation, Trig_Amalgamation_Actions)
end
-- END FOREST SECTION 38

-- BEGIN FOREST SECTION 39 Merge
function Trig_Merge_Func001C()
    return GetSpellAbilityId() == FourCC("A0DZ")
end

function Trig_Merge_Conditions()
    return not not (Trig_Merge_Func001C())
end

function Trig_Merge_Actions()
    KillUnit(GetSpellAbilityUnit())
end

function InitTrig_Merge()
    gg_trg_Merge = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Merge, EVENT_PLAYER_UNIT_SPELL_ENDCAST)
    TriggerAddCondition(gg_trg_Merge, Condition(Trig_Merge_Conditions))
    TriggerAddAction(gg_trg_Merge, Trig_Merge_Actions)
end
-- END FOREST SECTION 39

-- BEGIN FOREST SECTION 40 Husk_Detection
function Trig_Husk_Detection_Conditions()
    return GetUnitTypeId(GetSpellTargetUnit()) == FourCC("H064")
end

function Trig_Husk_Detection_Func001C()
    if (not (GetSpellAbilityId() == FourCC("A0DZ"))) then
        return false
    end
    if (not (GetUnitTypeId(GetTriggerUnit()) == FourCC("u00I"))) then
        return false
    end
    return true
end

function Trig_Husk_Detection_Func002C()
    if (not (GetSpellAbilityId() == FourCC("A0DZ"))) then
        return false
    end
    if (not (GetUnitTypeId(GetTriggerUnit()) == FourCC("u00J"))) then
        return false
    end
    return true
end

function Trig_Husk_Detection_Func004C()
    if (not (GetSpellAbilityId() == FourCC("A0DZ"))) then
        return false
    end
    if (not (GetUnitTypeId(GetTriggerUnit()) == FourCC("u00K"))) then
        return false
    end
    return true
end

function Trig_Husk_Detection_Actions()
    if (Trig_Husk_Detection_Func001C()) then
        ModifyHeroStat(bj_HEROSTAT_STR, GetSpellTargetUnit(), bj_MODIFYMETHOD_ADD, 1)
        BlzSetUnitBaseDamage(GetSpellTargetUnit(), (__jint(BlzGetUnitBaseDamage(GetSpellTargetUnit(), 0) + 4)), 0)
        BlzSetUnitMaxHP(GetSpellTargetUnit(), (__jint(BlzGetUnitMaxHP(GetSpellTargetUnit()) + 10)))
    end
    if (Trig_Husk_Detection_Func002C()) then
        ModifyHeroStat(bj_HEROSTAT_STR, GetSpellTargetUnit(), bj_MODIFYMETHOD_ADD, 3)
        ModifyHeroStat(bj_HEROSTAT_AGI, GetSpellTargetUnit(), bj_MODIFYMETHOD_ADD, 2)
        BlzSetUnitBaseDamage(GetSpellTargetUnit(), (__jint(BlzGetUnitBaseDamage(GetSpellTargetUnit(), 0) + 7)), 0)
        BlzSetUnitMaxHP(GetSpellTargetUnit(), (__jint(BlzGetUnitMaxHP(GetSpellTargetUnit()) + 25)))
    end
    if (Trig_Husk_Detection_Func004C()) then
        ModifyHeroStat(bj_HEROSTAT_STR, GetSpellTargetUnit(), bj_MODIFYMETHOD_ADD, 5)
        ModifyHeroStat(bj_HEROSTAT_AGI, GetSpellTargetUnit(), bj_MODIFYMETHOD_ADD, 5)
        BlzSetUnitBaseDamage(GetSpellTargetUnit(), (__jint(BlzGetUnitBaseDamage(GetSpellTargetUnit(), 0) + 10)), 0)
        BlzSetUnitMaxHP(GetSpellTargetUnit(), (__jint(BlzGetUnitMaxHP(GetSpellTargetUnit()) + 50)))
    end
end

function InitTrig_Husk_Detection()
    gg_trg_Husk_Detection = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Husk_Detection, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Husk_Detection, Condition(Trig_Husk_Detection_Conditions))
    TriggerAddAction(gg_trg_Husk_Detection, Trig_Husk_Detection_Actions)
end
-- END FOREST SECTION 40

-- BEGIN FOREST SECTION 41 Death_Jump
function Trig_Death_Jump_Conditions()
    return GetSpellAbilityId() == FourCC("A0EG")
end

function Trig_Death_Jump_Actions()
    SetUnitLifeBJ(GetSpellAbilityUnit(), (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, GetSpellAbilityUnit()) - (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, GetSpellAbilityUnit()) * __jreal(0.50))))))
end

function InitTrig_Death_Jump()
    gg_trg_Death_Jump = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Death_Jump, EVENT_PLAYER_UNIT_SPELL_CAST)
    TriggerAddCondition(gg_trg_Death_Jump, Condition(Trig_Death_Jump_Conditions))
    TriggerAddAction(gg_trg_Death_Jump, Trig_Death_Jump_Actions)
end
-- END FOREST SECTION 41

-- BEGIN FOREST SECTION 42 Map_Start
function Trig_Map_Start_Actions()
    SetPlayerTechResearchedSwap(FourCC("R07L"), 1, Player(0))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 1, Player(1))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 1, Player(2))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 1, Player(3))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 1, Player(4))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 1, Player(5))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 1, Player(6))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 1, Player(7))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 1, Player(8))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 1, Player(9))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 1, Player(10))
    EnableTrigger(gg_trg_Day)
    EnableTrigger(gg_trg_Night)
end

function InitTrig_Map_Start()
    gg_trg_Map_Start = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_Map_Start, __jreal(5.00))
    TriggerAddAction(gg_trg_Map_Start, Trig_Map_Start_Actions)
end
-- END FOREST SECTION 42

-- BEGIN FOREST SECTION 43 Day
function Trig_Day_Actions()
    SetPlayerTechResearchedSwap(FourCC("R07L"), 0, Player(0))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 0, Player(1))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 0, Player(2))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 0, Player(3))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 0, Player(4))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 0, Player(5))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 0, Player(6))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 0, Player(7))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 0, Player(8))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 0, Player(9))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 0, Player(10))
end

function InitTrig_Day()
    gg_trg_Day = CreateTrigger()
    DisableTrigger(gg_trg_Day)
    TriggerRegisterGameStateEventTimeOfDay(gg_trg_Day, EQUAL, __jreal(6.00))
    TriggerAddAction(gg_trg_Day, Trig_Day_Actions)
end
-- END FOREST SECTION 43

-- BEGIN FOREST SECTION 44 Night
function Trig_Night_Actions()
    SetPlayerTechResearchedSwap(FourCC("R07L"), 1, Player(0))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 1, Player(1))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 1, Player(2))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 1, Player(3))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 1, Player(4))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 1, Player(5))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 1, Player(6))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 1, Player(7))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 1, Player(8))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 1, Player(9))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 1, Player(10))
end

function InitTrig_Night()
    gg_trg_Night = CreateTrigger()
    DisableTrigger(gg_trg_Night)
    TriggerRegisterGameStateEventTimeOfDay(gg_trg_Night, EQUAL, __jreal(18.00))
    TriggerAddAction(gg_trg_Night, Trig_Night_Actions)
end
-- END FOREST SECTION 44
