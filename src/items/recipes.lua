-- Deterministic inventory planning. All mutation runs in synchronized events.
FE_Recipes = { byScroll = {}, byResult = {}, busy = {}, pending = {}, pickupCrafted = {}, initialized = false }
FE_Recipes.diagnostics = {sales=0, completed=0, refunded=0, last='No recipe purchase observed.'}
for _, recipe in ipairs(FE_RecipeData.recipes) do
    FE_Recipes.byResult[recipe.result] = recipe
    if recipe.scroll then FE_Recipes.byScroll[recipe.scroll] = recipe end
end

local function inventory(unit)
    local entries = {}
    for slot = 0, UnitInventorySize(unit) - 1 do
        local item = UnitItemInSlot(unit, slot)
        if item then entries[#entries + 1] = {item=item, kind=GetItemTypeId(item), remaining=math.max(1,GetItemCharges(item))} end
    end
    return entries
end

function FE_Recipes.plan(unit, recipe, buyMissing, paidScroll)
    if not unit or not recipe then return nil, 'Unknown recipe.' end
    local plan = {entries=inventory(unit), consumed={}, gold=0, lumber=0, result=recipe.result, scroll=paidScroll}
    for _, entry in ipairs(plan.entries) do
        if entry.item == paidScroll then entry.remaining = entry.remaining - 1 end
    end
    local function reserve(kind)
        for _, entry in ipairs(plan.entries) do
            if entry.remaining > 0 and entry.item ~= paidScroll and entry.kind == kind then
                entry.remaining = entry.remaining - 1; plan.consumed[#plan.consumed + 1] = entry.item
                return true
            end
        end
        return false
    end
    local function purchase(kind)
        local price = FE_RecipeData.items[kind]
        if not buyMissing or not price then return false end
        plan.gold = plan.gold + price.gold; plan.lumber = plan.lumber + price.lumber
        return true
    end
    local ensure
    local function requirements(current, paid, visiting)
        if visiting[current.result] then return false end
        visiting[current.result] = true
        if current.scroll and not paid and not reserve(current.scroll) and not purchase(current.scroll) then return false end
        for _, component in ipairs(current.components) do
            if not ensure(component, visiting) then return false end
        end
        visiting[current.result] = nil
        return true
    end
    ensure = function(kind, visiting)
        if reserve(kind) then return true end
        local nested = FE_Recipes.byResult[kind]
        if nested then return requirements(nested, false, visiting) end
        return purchase(kind)
    end
    if not requirements(recipe, paidScroll ~= nil, {}) then return nil, 'Missing components.' end
    local free = UnitInventorySize(unit) - #plan.entries
    for _, entry in ipairs(plan.entries) do if entry.remaining == 0 then free = free + 1 end end
    if free < 1 then return nil, 'Inventory full.' end
    return plan
end

local function consume(item)
    -- A charged scroll can remain a valid handle after a pickup-first craft.
    -- Remember that this pickup already paid for a result until SELL_ITEM runs.
    if FE_Recipes.byScroll[GetItemTypeId(item)] and
       GetTriggerEventId() == EVENT_PLAYER_UNIT_PICKUP_ITEM and GetManipulatedItem() == item then
        local timer = CreateTimer()
        FE_Recipes.pickupCrafted[item] = timer
        TimerStart(timer, 0, false, function()
            if FE_Recipes.pickupCrafted[item] == timer then FE_Recipes.pickupCrafted[item] = nil end
            DestroyTimer(timer)
        end)
    end
    local charges = GetItemCharges(item)
    if charges > 1 then SetItemCharges(item, charges - 1) else RemoveItem(item) end
end

local function commit(unit, plan)
    local player = GetOwningPlayer(unit)
    if GetPlayerState(player, PLAYER_STATE_RESOURCE_GOLD) < plan.gold or
       GetPlayerState(player, PLAYER_STATE_RESOURCE_LUMBER) < plan.lumber then
        return false, 'Not enough gold or lumber for the missing components.'
    end
    -- Create before consuming anything, so an invalid object definition fails
    -- without charging the player or destroying their ingredients.
    local result = CreateItem(plan.result, GetUnitX(unit), GetUnitY(unit))
    if not result then return false, 'Could not create the finished item.' end
    FE_Recipes.busy[unit] = true
    for _, item in ipairs(plan.consumed) do consume(item) end
    if plan.scroll then consume(plan.scroll) end
    SetPlayerState(player, PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(player, PLAYER_STATE_RESOURCE_GOLD) - plan.gold)
    SetPlayerState(player, PLAYER_STATE_RESOURCE_LUMBER, GetPlayerState(player, PLAYER_STATE_RESOURCE_LUMBER) - plan.lumber)
    local added = UnitAddItem(unit, result)
    FE_Recipes.busy[unit] = nil
    -- The plan guarantees a slot unless another inventory restriction intervenes.
    -- Preserve the paid-for result on the ground in that case; never delete it.
    if not added then DisplayTextToPlayer(player, 0, 0, 'The crafted item is at your feet.') end
    if FE_Shops then FE_Shops.trace(player,'Craft result '..FE_Shops.raw(plan.result)..'; in inventory='..tostring(UnitHasItem(unit,result))) end
    return true
end

function FE_Recipes.canCombineOwned(unit, result)
    if FE_Recipes.busy[unit] or FE_Recipes.pending[unit] then return false end
    return FE_Recipes.plan(unit, FE_Recipes.byResult[result], false, nil) ~= nil
end

function FE_Recipes.combineOwned(unit, result)
    if FE_Recipes.busy[unit] or FE_Recipes.pending[unit] then return false end
    local plan = FE_Recipes.plan(unit, FE_Recipes.byResult[result], false, nil)
    if not plan then return false end
    return commit(unit, plan)
end

function FE_Recipes.combineAll(unit)
    if not unit or FE_Recipes.busy[unit] or FE_Recipes.pending[unit] then return end
    -- Bound chained crafting even with charged stacks. Stable recipe and slot
    -- order prevents hash-table iteration from choosing ingredients.
    for _ = 1, UnitInventorySize(unit) do
        local changed = false
        for _, recipe in ipairs(FE_RecipeData.recipes) do
            if FE_Recipes.combineOwned(unit, recipe.result) then changed = true; break end
        end
        if not changed then break end
    end
end

local function finishSale(unit, scroll, kind, player)
    -- Native inventory delivery must finish before we replace the sold item.
    -- A six-slot inventory may leave the purchased scroll on the ground: it is
    -- still paid for and can free a slot by consuming an owned component.
    local plan, message
    if GetUnitTypeId(unit) == 0 or GetOwningPlayer(unit) ~= player or GetWidgetLife(unit) <= 0.405 then
        message = 'Buyer is no longer available.'
    else
        plan, message = FE_Recipes.plan(unit, FE_Recipes.byScroll[kind], true, scroll)
    end
    local success = false
    if plan then success, message = commit(unit, plan) end
    if not success then
        FE_Recipes.diagnostics.refunded = FE_Recipes.diagnostics.refunded + 1
        FE_Recipes.diagnostics.last = message or 'Recipe could not be completed.'
        local price = FE_RecipeData.items[kind]
        FE_Recipes.busy[unit] = true
        consume(scroll)
        SetPlayerState(player, PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(player, PLAYER_STATE_RESOURCE_GOLD) + price.gold)
        SetPlayerState(player, PLAYER_STATE_RESOURCE_LUMBER, GetPlayerState(player, PLAYER_STATE_RESOURCE_LUMBER) + price.lumber)
        FE_Recipes.busy[unit] = nil
        DisplayTextToPlayer(player, 0, 0, (message or 'Recipe could not be completed.') .. ' Recipe purchase refunded.')
        if FE_Shops then FE_Shops.trace(player,FE_Recipes.diagnostics.last..' Scroll refunded.') end
        return
    end
    FE_Recipes.diagnostics.completed = FE_Recipes.diagnostics.completed + 1
    FE_Recipes.diagnostics.last = 'Completed.'
    FE_Recipes.combineAll(unit)
end

function FE_Recipes.onSale()
    local unit, scroll, shop = GetBuyingUnit(), GetSoldItem(), GetSellingUnit()
    FE_Shops.observeSale(shop,unit,scroll)
    if scroll and FE_Recipes.byScroll[GetItemTypeId(scroll)] then
        FE_Recipes.diagnostics.sales = FE_Recipes.diagnostics.sales + 1
        FE_Recipes.diagnostics.last = 'Recipe sale observed; checking buyer.'
    end
    if not shop or not FE_RecipeData.shops[GetUnitTypeId(shop)] then return end
    if not unit or not scroll or not FE_Roles.isAncient(GetOwningPlayer(unit)) then
        FE_Shops.trace(FE_Test and FE_Test.player,'Recipe/delivery handler stopped: '..
            (not unit and 'native sale has no buyer.' or not scroll and 'native sale has no item.' or 'buyer is not owned by the Ancient.'))
        return
    end
    if FE_Recipes.busy[unit] then return end
    if FE_Recipes.pickupCrafted[scroll] then FE_Recipes.pickupCrafted[scroll] = nil; return end
    local kind, player = GetItemTypeId(scroll), GetOwningPlayer(unit)
    if not FE_Recipes.byScroll[kind] then
        local timer = CreateTimer()
        TimerStart(timer,0,false,function()
            DestroyTimer(timer)
            if GetItemTypeId(scroll) == kind then FE_Shops.deliver(unit,scroll,player) end
        end)
        return
    end
    FE_Recipes.diagnostics.last = 'Waiting for native inventory delivery.'
    FE_Recipes.pending[unit] = (FE_Recipes.pending[unit] or 0) + 1
    local timer = CreateTimer()
    TimerStart(timer, 0, false, function()
        DestroyTimer(timer)
        local remaining = FE_Recipes.pending[unit] - 1
        FE_Recipes.pending[unit] = remaining > 0 and remaining or nil
        if GetItemTypeId(scroll) == kind then finishSale(unit, scroll, kind, player)
        else FE_Shops.trace(player,'Recipe scroll was consumed/replaced before deferred completion.') end
    end)
end

function FE_Recipes.init()
    if FE_Recipes.initialized then return end
    FE_Recipes.initialized = true
    local sale, pickup = CreateTrigger(), CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(sale, EVENT_PLAYER_UNIT_SELL_ITEM)
    TriggerAddAction(sale, FE_Recipes.onSale)
    TriggerRegisterAnyUnitEventBJ(pickup, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    TriggerAddAction(pickup, function() FE_Recipes.combineAll(GetTriggerUnit()) end)
end
