-- Cultist research unlocks fixed-strength abilities; Profane Reach is native
-- object research so trained/reborn units inherit all five upgrade levels.
FE_Cultist = { units = {}, known = {}, sacrifice = {}, burst = {}, manual = {}, empowered = {}, auraUnits = {}, auraLevel = {}, ticks = 0, initialized = false }

function FE_Cultist.researched(unit, raw)
    return GetPlayerTechCount(GetOwningPlayer(unit), FourCC(raw), true) > 0
end

function FE_Cultist.track(unit)
    if GetUnitTypeId(unit) ~= FourCC("h063") or FE_Cultist.known[unit] then return end
    -- Keep the functional resistance on the unit; its description is in Blood Rites.
    BlzUnitHideAbility(unit, FourCC("A0EI"), true)
    FE_Cultist.known[unit] = true
    FE_Cultist.units[#FE_Cultist.units+1] = unit
end

function FE_Cultist.onOrder()
    local unit, order = GetTriggerUnit(), GetIssuedOrderId()
    if GetUnitTypeId(unit) ~= FourCC("h063") then return end
    FE_Cultist.track(unit)
    if order == OrderId("immolation") and FE_Cultist.researched(unit, "RFCS") then
        FE_Cultist.sacrifice[unit] = true
    elseif order == OrderId("unimmolation") then
        FE_Cultist.sacrifice[unit] = nil
    elseif order == OrderId("flamingarrowstarg") and FE_Cultist.researched(unit, "RFCB") then
        FE_Cultist.manual[unit] = GetOrderTargetUnit()
    elseif order == OrderId("flamingarrows") and FE_Cultist.researched(unit, "RFCB") then
        FE_Cultist.burst[unit] = true
    elseif order == OrderId("unflamingarrows") then
        FE_Cultist.burst[unit] = nil
    else
        -- A canceled manual attack must not empower some later unrelated hit.
        FE_Cultist.manual[unit] = nil
    end
end

function FE_Cultist.beforeDamage()
    -- Damage Engine recycles event indices between batches. A suppressed event
    -- must never leave a cost marker for the next attack using that index.
    FE_Cultist.empowered[s__Damage_index] = nil
    if not udg_IsDamageAttack or udg_DamageEventAmount <= 0 then return end
    local unit = udg_DamageEventSource
    if GetUnitTypeId(unit) ~= FourCC("h063") or not FE_Cultist.researched(unit, "RFCB") then return end
    if not FE_Cultist.burst[unit] and FE_Cultist.manual[unit] ~= udg_DamageEventTarget then return end
    FE_Cultist.manual[unit] = nil
    FE_Cultist.empowered[s__Damage_index] = unit
    -- Spells attack type has no armor-type multiplier; UNIVERSAL bypasses armor
    -- and magic resistance. Do not add a second damage instance to the victim.
    udg_DamageEventAttackT = GetHandleId(ATTACK_TYPE_NORMAL)
    udg_DamageEventDamageT = GetHandleId(DAMAGE_TYPE_UNIVERSAL)
end

function FE_Cultist.afterDamage()
    local unit = FE_Cultist.empowered[s__Damage_index]
    FE_Cultist.empowered[s__Damage_index] = nil
    if unit and udg_DamageEventAmount > 0 and FE_Combat.alive(unit) then
        FE_Combat.damage(unit, unit, GetWidgetLife(unit)*0.04, DAMAGE_TYPE_UNIVERSAL)
    end
end

function FE_Cultist.tick()
    FE_Cultist.ticks = FE_Cultist.ticks + 1
    local desired, ordered = {}, {}
    for index = #FE_Cultist.units, 1, -1 do
        local unit = FE_Cultist.units[index]
        if not FE_Combat.alive(unit) then
            FE_Cultist.known[unit], FE_Cultist.sacrifice[unit], FE_Cultist.burst[unit], FE_Cultist.manual[unit] = nil, nil, nil, nil
            table.remove(FE_Cultist.units, index)
        else
            local owner = GetOwningPlayer(unit)
            if FE_Cultist.researched(unit, "RFCA") then
                local tier = math.min(9, math.max(0, math.floor((1 - GetWidgetLife(unit)/BlzGetUnitMaxHP(unit))*10 + 0.00001)))
                if tier > 0 then
                    FE_Combat.near(unit, 1000, function(target)
                        if IsUnitAlly(target, owner) then
                            if not desired[target] then ordered[#ordered+1] = target end
                            desired[target] = math.max(desired[target] or 0, tier)
                        end
                    end)
                end
            end
            if math.fmod(FE_Cultist.ticks, 4) == 0 and FE_Cultist.sacrifice[unit] and FE_Cultist.researched(unit, "RFCS") then
                -- Snapshot the source before self damage can trigger death cleanup.
                FE_Combat.near(unit, 400, function(target)
                    if target ~= unit and IsUnitAlly(target, owner) then
                        SetWidgetLife(target, GetWidgetLife(target) + 50)
                    end
                end)
                FE_Combat.damage(unit, unit, 100, DAMAGE_TYPE_MAGIC)
            end
        end
    end
    for _, unit in ipairs(FE_Cultist.auraUnits) do
        if not desired[unit] then
            FE_Combat.hiddenAbility(unit, "AFAS", 0)
            UnitRemoveAbility(unit, FourCC("BFAS"))
            FE_Cultist.auraLevel[unit] = nil
        end
    end
    for _, unit in ipairs(ordered) do
        if FE_Cultist.auraLevel[unit] ~= desired[unit] then
            FE_Combat.hiddenAbility(unit, "AFAS", desired[unit])
            FE_Cultist.auraLevel[unit] = desired[unit]
        end
    end
    FE_Cultist.auraUnits = ordered
end

function FE_Cultist.init()
    if FE_Cultist.initialized then return end
    FE_Cultist.initialized = true
    local orders = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(orders, EVENT_PLAYER_UNIT_ISSUED_ORDER)
    TriggerRegisterAnyUnitEventBJ(orders, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER)
    TriggerRegisterAnyUnitEventBJ(orders, EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
    TriggerAddAction(orders, FE_Cultist.onOrder)
    local region = CreateRegion()
    RegionAddRect(region, GetPlayableMapRect())
    local enter = CreateTrigger()
    TriggerRegisterEnterRegion(enter, region, nil)
    TriggerAddAction(enter, function() FE_Cultist.track(GetEnteringUnit()) end)
    FE_Roles.forEachPlayer(function(player) FE_Takeover.forUnits(player, FE_Cultist.track) end)
    FE_Combat.listen("udg_PreDamageEvent", 0.5, FE_Cultist.beforeDamage)
    FE_Combat.listen("udg_AfterDamageEvent", 1, FE_Cultist.afterDamage)
    -- Keep a Lua owner for the repeating native timer and its callback.
    FE_Cultist.timer = CreateTimer()
    TimerStart(FE_Cultist.timer, 0.25, true, FE_Cultist.tick)
end


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
    FE_Cultist.init()
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
