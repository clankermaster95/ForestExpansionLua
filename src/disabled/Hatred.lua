-- Disabled in the original map.
function I015_UnitHasItem(u)
    local i = 0
    local it = nil
    while true do
        if (i >= bj_MAX_INVENTORY) then break end
        it = UnitItemInSlot(u, i)
        if ((it ~= nil) and (GetItemTypeId(it) == ITEM_IMMOLATION_ID)) then
            it = nil
            do return true end
        end
        i = __jint(i + 1)
    end
    it = nil
    do return false end
end

function I015_IsAlive(u)
    do return (((u ~= nil) and (GetWidgetLife(u) > __jreal(0.405))) and (not IsUnitType(u, UNIT_TYPE_DEAD))) end
end

function I015_UpdateMaxCollision(u)
    local c = 0.0
    if (u ~= nil) then
        c = BlzGetUnitCollisionSize(u)
        if (c > I015_MaxCollision) then
            I015_MaxCollision = c
        end
    end
end

function I015_IsValidTarget(source, target)
    if (target == source) then
        do return false end
    end
    if (not I015_IsAlive(target)) then
        do return false end
    end
    if (not IsUnitEnemy(target, GetOwningPlayer(source))) then
        do return false end
    end
    if IsUnitType(target, UNIT_TYPE_FLYING) then
        do return false end
    end
    do return true end
end

function I015_UpdateCarrier(u)
    if (I015_IsAlive(u) and I015_UnitHasItem(u)) then
        GroupAddUnit(I015_Carriers, u)
        I015_UpdateMaxCollision(u)
    else
        GroupRemoveUnit(I015_Carriers, u)
    end
end

function I015_OnPickup()
    if (GetItemTypeId(GetManipulatedItem()) == ITEM_IMMOLATION_ID) then
        GroupAddUnit(I015_Carriers, GetTriggerUnit())
        I015_UpdateMaxCollision(GetTriggerUnit())
    end
end

function I015_OnDrop()
    if (GetItemTypeId(GetManipulatedItem()) == ITEM_IMMOLATION_ID) then
        I015_UpdateCarrier(GetTriggerUnit())
    end
end

function I015_OnUnitEnterMap()
    local u = GetTriggerUnit()
    I015_UpdateMaxCollision(u)
    I015_UpdateCarrier(u)
    u = nil
end

function I015_InitExistingUnits_Enum()
    local u = GetEnumUnit()
    I015_UpdateMaxCollision(u)
    if (I015_IsAlive(u) and I015_UnitHasItem(u)) then
        GroupAddUnit(I015_Carriers, u)
    end
    u = nil
end

function I015_InitExistingUnits()
    local g = CreateGroup()
    GroupEnumUnitsInRect(g, bj_mapInitialPlayableArea, nil)
    ForGroup(g, I015_InitExistingUnits_Enum)
    DestroyGroup(g)
    g = nil
end

function I015_DamageAroundCarrier()
    local source = GetEnumUnit()
    local target = nil
    local sourceX = 0.0
    local sourceY = 0.0
    local damage = 0.0
    if (I015_IsAlive(source) and I015_UnitHasItem(source)) then
        sourceX = GetUnitX(source)
        sourceY = GetUnitY(source)
        GroupEnumUnitsInRange(I015_Targets, sourceX, sourceY, __jreal(I015_RADIUS + I015_MaxCollision), nil)
        while true do
            target = FirstOfGroup(I015_Targets)
            if (target == nil) then break end
            GroupRemoveUnit(I015_Targets, target)
            if (I015_IsValidTarget(source, target) and IsUnitInRangeXY(target, sourceX, sourceY, I015_RADIUS)) then
                if IsUnitType(target, UNIT_TYPE_STRUCTURE) then
                    damage = I015_DAMAGE_BUILDING
                else
                    damage = I015_DAMAGE_NORMAL
                end
                UnitDamageTarget(source, target, damage, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
                DestroyEffect(AddSpecialEffectTarget(I015_HIT_EFFECT, target, "origin"))
            end
        end
    else
        GroupRemoveUnit(I015_Carriers, source)
    end
    source = nil
    target = nil
end

function I015_Periodic()
    ForGroup(I015_Carriers, I015_DamageAroundCarrier)
end

function InitTrig_Hatred()
    local pickup = CreateTrigger()
    local drop = CreateTrigger()
    local enter = CreateTrigger()
    local i = 0
    while true do
        if (i >= bj_MAX_PLAYER_SLOTS) then break end
        TriggerRegisterPlayerUnitEvent(pickup, Player(i), EVENT_PLAYER_UNIT_PICKUP_ITEM, nil)
        TriggerRegisterPlayerUnitEvent(drop, Player(i), EVENT_PLAYER_UNIT_DROP_ITEM, nil)
        i = __jint(i + 1)
    end
    TriggerAddAction(pickup, I015_OnPickup)
    TriggerAddAction(drop, I015_OnDrop)
    I015_InitExistingUnits()
    TriggerRegisterEnterRectSimple(enter, bj_mapInitialPlayableArea)
    TriggerAddAction(enter, I015_OnUnitEnterMap)
    TimerStart(CreateTimer(), I015_PERIOD, true, I015_Periodic)
    pickup = nil
    drop = nil
    enter = nil
end
