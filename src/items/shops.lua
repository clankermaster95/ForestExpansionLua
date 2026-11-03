-- Assign a buyer to the Ancient's shops; never change the player's selection.
FE_Shops = { shops = {}, lastBuyer = {}, lastPlayer = {}, lastOrder = {}, initialized = false,
    traceEnabled = false, diagnostics = {sales=0, delivered=0, ground=0, last='No shop sale observed.'} }

function FE_Shops.raw(id)
    if not id or id == 0 then return 'none' end
    if type(id) == 'string' then return id end -- Offline engine double.
    return string.char((id >> 24) & 255, (id >> 16) & 255, (id >> 8) & 255, id & 255)
end

function FE_Shops.label(unit)
    if not unit or GetUnitTypeId(unit) == 0 then return 'none' end
    return GetUnitName(unit)..' ['..FE_Shops.raw(GetUnitTypeId(unit))..', player '..(GetPlayerId(GetOwningPlayer(unit))+1)..']'
end

function FE_Shops.trace(player, text)
    if FE_Shops.traceEnabled and FE_Test and FE_Test.allowed(player) then
        DisplayTextToPlayer(player, 0, 0, '|cff80d4ff[Shop debug]|r '..text)
    end
end

function FE_Shops.radius(shop)
    local ability = BlzGetUnitAbility(shop, FourCC('Aall')) or BlzGetUnitAbility(shop, FourCC('Aneu'))
    return ability and BlzGetAbilityRealLevelField(ability, ABILITY_RLF_ACTIVATION_RADIUS, 0) or 0
end

function FE_Shops.inRange(shop, ancient)
    if not shop or not ancient or GetUnitTypeId(shop) == 0 or GetUnitTypeId(ancient) == 0 or
       GetWidgetLife(shop) <= 0.405 or GetWidgetLife(ancient) <= 0.405 or
       not FE_Roles.isAncient(GetOwningPlayer(ancient)) then return false end
    if UnitInventorySize(ancient) < 1 then return false end
    local radius = FE_Shops.radius(shop)
    return radius > 0 and IsUnitInRange(ancient, shop, radius)
end

function FE_Shops.assign(shop, force)
    local ancient, player = udg_AncientUnit, FE_Roles.ancient()
    if not FE_Shops.inRange(shop, ancient) then
        FE_Shops.lastBuyer[shop] = nil; FE_Shops.lastPlayer[shop] = nil
        return false
    end
    if force or FE_Shops.lastBuyer[shop] ~= ancient or FE_Shops.lastPlayer[shop] ~= player then
        FE_Shops.lastOrder[shop] = nil
        -- These are player-owned shops. Island Defense uses the ordinary
        -- neutralinteract target order on its owned shop; use the explicit
        -- player form for shared/neutral shops or if the owned order fails.
        -- Both orders execute on every client, never in a local UI branch.
        local accepted = false
        if GetOwningPlayer(shop) == player then
            accepted = IssueTargetOrderById(shop, 852566, ancient)
            FE_Shops.lastOrder[shop] = 'owned target: '..tostring(accepted)
        end
        if not accepted then
            accepted = IssueNeutralTargetOrderById(player, shop, 852566, ancient)
            FE_Shops.lastOrder[shop] = (FE_Shops.lastOrder[shop] or '')..'; player target: '..tostring(accepted)
        end
        if not accepted then return false end
        FE_Shops.lastBuyer[shop] = ancient; FE_Shops.lastPlayer[shop] = player
    end
    return true
end

function FE_Shops.tick()
    for _, shop in ipairs(FE_Shops.shops) do FE_Shops.assign(shop, false) end
end

function FE_Shops.onSelected()
    local shop = GetTriggerUnit()
    if FE_Roles.isAncient(GetTriggerPlayer()) and FE_RecipeData.shops[GetUnitTypeId(shop)] then
        FE_Shops.assign(shop, true)
        -- Let native shop selection settle, then reassert the same buyer.
        local player, timer = GetTriggerPlayer(), CreateTimer()
        TimerStart(timer, 0, false, function()
            DestroyTimer(timer)
            if FE_Roles.isAncient(player) then
                FE_Shops.assign(shop, true)
                FE_Shops.trace(player, FE_Shops.describe(shop))
            end
        end)
    end
end

function FE_Shops.describe(shop)
    local ancient = udg_AncientUnit
    local distance = ancient and math.floor(math.sqrt((GetUnitX(ancient)-GetUnitX(shop))^2 + (GetUnitY(ancient)-GetUnitY(shop))^2)) or -1
    local slots, used = ancient and UnitInventorySize(ancient) or 0, 0
    for slot=0,slots-1 do if UnitItemInSlot(ancient,slot) then used=used+1 end end
    return FE_Shops.label(shop)..'; hero='..FE_Shops.label(ancient)..'; distance='..distance..
        '; radius='..FE_Shops.radius(shop)..'; in range='..tostring(FE_Shops.inRange(shop, ancient))..
        '; inventory='..used..'/'..slots..
        '; order='..(FE_Shops.lastOrder[shop] or 'not issued')
end

function FE_Shops.observeSale(shop, buyer, item)
    if not shop or not FE_RecipeData.shops[GetUnitTypeId(shop)] then return end
    local d = FE_Shops.diagnostics
    d.sales = d.sales + 1
    d.last = 'Sale #'..d.sales..': '..FE_Shops.raw(GetItemTypeId(item))..'; buyer='..FE_Shops.label(buyer)
    FE_Shops.trace(FE_Test and FE_Test.player, d.last)
    -- An accepted order is not proof of the native recipient. Discard a stale
    -- cache when the sale identifies a different buyer.
    if buyer ~= FE_Shops.lastBuyer[shop] then
        FE_Shops.lastBuyer[shop] = nil; FE_Shops.lastPlayer[shop] = nil
    end
end

function FE_Shops.deliver(buyer, item, player)
    -- Only a native sale's actual buyer/item may reach here. Never scan the
    -- ground, invent a payer, duplicate an item, or take another unit's item.
    if not item or GetItemTypeId(item) == 0 then return end
    local d = FE_Shops.diagnostics
    if not buyer or GetUnitTypeId(buyer) == 0 or GetOwningPlayer(buyer) ~= player or GetWidgetLife(buyer) <= 0.405 then
        d.last = 'Delivery stopped: buyer unavailable.'
    elseif UnitHasItem(buyer, item) then
        d.delivered = d.delivered + 1; d.last = 'Delivered to '..FE_Shops.label(buyer)..'.'
    elseif IsItemOwned(item) then
        d.last = 'Delivery stopped: item is held by another unit.'
    else
        local free = false
        for slot=0,UnitInventorySize(buyer)-1 do if not UnitItemInSlot(buyer,slot) then free=true;break end end
        if free then UnitAddItem(buyer, item) end
        if GetItemTypeId(item) == 0 or UnitHasItem(buyer,item) then
            d.delivered = d.delivered + 1; d.last = 'Delivered after native ground placement.'
        else
            d.ground = d.ground + 1
            d.last = free and 'Ground item: inventory insertion rejected.' or 'Ground item: inventory full.'
            DisplayTextToPlayer(player,0,0,d.last)
        end
    end
    FE_Shops.trace(player,d.last)
end

function FE_Shops.initDebug(player)
    if FE_Shops.debugInitialized then return end
    FE_Shops.debugInitialized = true
    local orders = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(orders, EVENT_PLAYER_UNIT_ISSUED_ORDER)
    TriggerAddAction(orders, function()
        local shop, id = GetTriggerUnit(), GetIssuedOrderId()
        local stock = FE_RecipeData.stock[GetUnitTypeId(shop)]
        if not FE_Test.allowed(player) or not FE_Shops.traceEnabled or not stock or not stock[id] then return end
        local before, gold, timer = FE_Shops.diagnostics.sales, GetPlayerState(player,PLAYER_STATE_RESOURCE_GOLD), CreateTimer()
        FE_Shops.trace(player,'Buy order '..FE_RecipeData.items[id].name..' ['..FE_Shops.raw(id)..']. '..FE_Shops.describe(shop))
        TimerStart(timer,0.1,false,function()
            DestroyTimer(timer)
            FE_Shops.trace(player,'After order: sale counter '..before..' -> '..FE_Shops.diagnostics.sales..
                '; gold '..gold..' -> '..GetPlayerState(player,PLAYER_STATE_RESOURCE_GOLD)..'. '..FE_Shops.diagnostics.last)
        end)
    end)
    for _,kind in ipairs({EVENT_PLAYER_UNIT_PICKUP_ITEM,EVENT_PLAYER_UNIT_DROP_ITEM}) do
        local trigger = CreateTrigger()
        TriggerRegisterAnyUnitEventBJ(trigger,kind)
        TriggerAddAction(trigger,function()
            if GetOwningPlayer(GetTriggerUnit()) == player then
                FE_Shops.trace(player,(kind == EVENT_PLAYER_UNIT_PICKUP_ITEM and 'Pickup ' or 'Drop ')..
                    FE_Shops.raw(GetItemTypeId(GetManipulatedItem()))..'; unit='..FE_Shops.label(GetTriggerUnit()))
            end
        end)
    end
end

function FE_Shops.init()
    if FE_Shops.initialized then return end
    FE_Shops.initialized = true
    local group, bounds = CreateGroup(), GetWorldBounds()
    GroupEnumUnitsInRect(group, bounds, nil)
    while true do
        local unit = FirstOfGroup(group)
        if not unit then break end
        GroupRemoveUnit(group, unit)
        if FE_RecipeData.shops[GetUnitTypeId(unit)] then FE_Shops.shops[#FE_Shops.shops + 1] = unit end
    end
    DestroyGroup(group); RemoveRect(bounds)
    local selected = CreateTrigger()
    FE_Roles.forEachPlayer(function(player)
        TriggerRegisterPlayerUnitEventSimple(selected, player, EVENT_PLAYER_UNIT_SELECTED)
    end)
    TriggerAddAction(selected, FE_Shops.onSelected)
    TimerStart(CreateTimer(), 0.25, true, FE_Shops.tick)
end
