-- Inventory/event double. These checks do not substitute for native WC3 tests.
local checks, scenarios = 0, 0
local function check(value, message) assert(value, message); checks=checks+1 end
local players, triggers, event, timers, orders, trace, failCreate, rejectAdd, localSlot, rejectOwned, rejectNeutral
local function record(s) trace[#trace+1]=s end
function FourCC(s) return s end
function Player(i)
    if not players[i] then players[i]={id=i,gold=10000,lumber=1000,playing=true} end
    return players[i]
end
function GetPlayerId(p) return p.id end
function GetLocalPlayer() return Player(localSlot) end
function GetPlayerSlotState(p) return p.playing and 'playing' or 'empty' end
function GetPlayerState(p,s) return p[s] end
function SetPlayerState(p,s,v) p[s]=v; record(p.id..':'..s..'='..v) end
function GetUnitTypeId(u) return u and not u.removed and u.kind or 0 end
function GetUnitName(u) return u.kind end
function GetOwningPlayer(u) return u.owner end
function GetWidgetLife(u) return u.life end
function GetUnitX(u) return u.x end
function GetUnitY(u) return u.y end
function UnitInventorySize(u) return u.size end
function UnitItemInSlot(u,i) return u.slots[i] end
function GetItemTypeId(i) return i and not i.removed and i.kind or 0 end
function GetItemCharges(i) return i.charges or 0 end
function SetItemCharges(i,n) i.charges=n end
function CreateItem(kind,x,y)
    if failCreate then return nil end
    record('create:'..kind)
    return {kind=kind,x=x,y=y}
end
function CreateTrigger() local t={conditions={},actions={}}; triggers[#triggers+1]=t; return t end
function Condition(f) return f end
function TriggerAddCondition(t,f) t.conditions[#t.conditions+1]=f end
function TriggerAddAction(t,f) t.actions[#t.actions+1]=f end
function TriggerRegisterAnyUnitEventBJ(t,e) t.kind=e end
function TriggerRegisterPlayerUnitEventSimple(t,p,e) t.kind=e; t.players=t.players or {}; t.players[p]=true end
local function emit(kind,args)
    local previous=event; event=args; args.kind=kind
    for _,t in ipairs(triggers) do
        if t.kind==kind and (not t.players or t.players[args.player]) then
            local allowed=true
            for _,f in ipairs(t.conditions) do if not f() then allowed=false; break end end
            if allowed then for _,f in ipairs(t.actions) do f() end end
        end
    end
    event=previous
end
function GetTriggerUnit() return event.kind=='sale' and event.shop or event.unit end
function GetTriggerPlayer() return event.player end
function GetTriggerEventId() return event and event.kind end
function GetManipulatingUnit() return event.unit end
function GetManipulatedItem() return event.item end
function GetBuyingUnit() return event.unit end
function GetSellingUnit() return event.shop end
function GetSoldItem() return event.item end
function GetIssuedOrderId() return event.order end
function UnitHasItem(u,item) return item and not item.removed and item.unit==u end
function IsItemOwned(item) return item and not item.removed and item.unit~=nil end
function UnitAddItem(u,item)
    if rejectAdd then return false end
    for i=0,u.size-1 do
        if not u.slots[i] then
            u.slots[i]=item; item.unit=u
            emit('pickup',{unit=u,item=item,player=u.owner}); return true
        end
    end
    return false
end
function RemoveItem(item)
    check(not item.removed,'an ingredient/scroll cannot be consumed twice')
    local u=item.unit
    if u then
        for i=0,u.size-1 do if u.slots[i]==item then u.slots[i]=nil end end
        emit('drop',{unit=u,item=item,player=u.owner})
    end
    item.removed=true; item.unit=nil; record('remove:'..item.kind)
end
function UnitHasItemOfTypeBJ(u,kind)
    for i=0,u.size-1 do if GetItemTypeId(u.slots[i])==kind then return true end end
    return false
end
function AddHeroXP(u,xp) u.xp=(u.xp or 0)+xp end
function DisplayTextToPlayer(_,_,_,text) record('message:'..text) end
function CreateTimer() local t={}; timers[#timers+1]=t; return t end
function DestroyTimer(t) t.destroyed=true end
function TimerStart(t,d,periodic,f) t.callback=f; t.duration=d; t.periodic=periodic end
local function flushSales()
    for _,t in ipairs(timers) do
        if t.duration==0 and not t.periodic and not t.destroyed then t.callback() end
    end
end
function CreateGroup() return {} end
function GetWorldBounds() return {} end
function GroupEnumUnitsInRect(g) for _,u in ipairs(placed) do g[#g+1]=u end end
function FirstOfGroup(g) return g[1] end
function GroupRemoveUnit(g,u) for i,v in ipairs(g) do if v==u then table.remove(g,i); return end end end
function DestroyGroup(g) g.destroyed=true end
function RemoveRect(r) r.removed=true end
function BlzGetUnitAbility(u,id) return u.abilities and u.abilities[id] end
function BlzGetAbilityRealLevelField(a,field,level)
    check(field==ABILITY_RLF_ACTIVATION_RADIUS and level==0,'read the actual shop activation radius')
    return a.radius
end
function IsUnitInRange(a,b,r) return (a.x-b.x)^2+(a.y-b.y)^2<=r*r end
local function targetOrder(p,shop,order,buyer,route,rejected)
    check(order==852566,'shop selects buyer through the neutral interaction order ID')
    orders[#orders+1]={player=p,shop=shop,buyer=buyer,route=route}
    if rejected then return false end
    record('order:'..p.id..':'..shop.kind..':'..buyer.kind); return true
end
function IssueTargetOrderById(shop,order,buyer) return targetOrder(shop.owner,shop,order,buyer,'owned',rejectOwned) end
function IssueNeutralTargetOrderById(p,shop,order,buyer) return targetOrder(p,shop,order,buyer,'neutral',rejectNeutral) end
function SelectUnit() error('shop automation must not change UI selection') end
PLAYER_STATE_RESOURCE_GOLD='gold'; PLAYER_STATE_RESOURCE_LUMBER='lumber'
PLAYER_SLOT_STATE_PLAYING='playing'; ABILITY_RLF_ACTIVATION_RADIUS='Neu1'
EVENT_PLAYER_UNIT_PICKUP_ITEM='pickup'; EVENT_PLAYER_UNIT_DROP_ITEM='drop'
EVENT_PLAYER_UNIT_SELL_ITEM='sale'; EVENT_PLAYER_UNIT_SELECTED='selected'
EVENT_PLAYER_UNIT_ISSUED_ORDER='order'
dofile('src/runtime.lua')
local manifest=dofile('build/role-test-input.lua')
local function unit(owner,kind)
    return {owner=owner,kind=kind or 'O004',size=6,slots={},x=0,y=0,life=100}
end
local function put(u,kind,slot)
    local item={kind=kind,unit=u}
    if slot then u.slots[slot]=item; return item end
    for i=0,u.size-1 do if not u.slots[i] then u.slots[i]=item; return item end end
    error('test inventory is full')
end
local function count(u,kind)
    local n=0
    for i=0,u.size-1 do if GetItemTypeId(u.slots[i])==kind then n=n+1 end end
    return n
end
local function reset(slot)
    players={}; triggers={}; event=nil; timers={}; orders={}; trace={}; localSlot=slot or 6
    failCreate=false; rejectAdd=false; rejectOwned=false; rejectNeutral=false; FE_Roster=nil; FE_Test=nil
    dofile('src/players/roles.lua'); FE_Roles.setAncient(Player(6))
    dofile('src/items/recipe_data.lua'); dofile('src/items/recipes.lua')
    dofile('src/items/ledgers.lua'); dofile('src/items/shops.lua')
    -- Exercise the real legacy event adapters as well as the new handlers.
    dofile('src/items/effects.lua')
    for _,name in ipairs(manifest.shoppingInitializers) do _G[name]() end
    udg_AncientUnit=unit(Player(6)); local shop=unit(Player(6),'h02B')
    shop.abilities={Aall={radius=450}}; placed={shop}
    FE_Recipes.init(); FE_Shops.init()
    return udg_AncientUnit,shop
end
local function buy(u,shop,raw,saleFirst)
    scenarios=scenarios+1
    local price=FE_RecipeData.items[raw]
    u.owner.gold=u.owner.gold-price.gold; u.owner.lumber=u.owner.lumber-price.lumber
    local item={kind=raw}
    -- Native sale charges the scroll first. Test both plausible event orders.
    for i=0,u.size-1 do if not u.slots[i] then u.slots[i]=item; item.unit=u; break end end
    local args={unit=u,shop=shop,item=item,player=u.owner}
    if saleFirst then emit('sale',args); emit('pickup',args)
    else emit('pickup',args); emit('sale',args) end
    flushSales()
    return item
end

-- Explicit expected totals from the source map's component/scroll prices.
local totals={I00H=500,I00G=900,I01Q=950,I01O=700,I01S=1150,I01M=1550,
              I011=1500,I016=1050,I018=1200,I01D=950,I01A=600}
-- Each possible owned-component subset must reduce the total by exactly the
-- value already paid. Exercise real registered pickup/sale callbacks both ways.
reset()
local recipes=FE_RecipeData.recipes
local function leaves(raw)
    local recipe=FE_Recipes.byResult[raw]
    if not recipe then return {raw} end
    local list={}
    for _,part in ipairs(recipe.components) do for _,leaf in ipairs(leaves(part)) do list[#list+1]=leaf end end
    if recipe.scroll then list[#list+1]=recipe.scroll end
    return list
end
for _,recipe in ipairs(recipes) do
    if recipe.scroll then
        local flattened={}
        for _,part in ipairs(recipe.components) do for _,leaf in ipairs(leaves(part)) do flattened[#flattened+1]=leaf end end
        for _,parts in ipairs({recipe.components,flattened}) do
            for mask=0,2^#parts-1 do
                for _,saleFirst in ipairs({false,true}) do
                    local buyer,shop=reset(); local discount=0
                    for i,raw in ipairs(parts) do
                        if (mask & (1 << (i-1)))~=0 then
                            put(buyer,raw)
                            local nested=FE_Recipes.byResult[raw]
                            discount=discount+(nested and totals[nested.scroll] or FE_RecipeData.items[raw].gold)
                        end
                    end
                    local gold=buyer.owner.gold
                    buy(buyer,shop,recipe.scroll,saleFirst)
                    check(count(buyer,recipe.result)==1,'subset creates exactly one result: '..recipe.scroll..'/'..mask)
                    check(gold-buyer.owner.gold==totals[recipe.scroll]-discount,'owned subset is charged exactly once: '..recipe.scroll..'/'..mask)
                end
            end
        end
    end
end
for _,first in ipairs({false,true}) do
    for _,recipe in ipairs(dofile('src/items/recipe_data.lua') or FE_RecipeData.recipes) do
        if recipe.scroll then
            local u,s=reset(); local before=u.owner.gold
            buy(u,s,recipe.scroll,first)
            check(count(u,recipe.result)==1,'each sold recipe produces its result')
            check(before-u.owner.gold==totals[recipe.scroll],'exact full cost for '..recipe.scroll)
            check(count(u,recipe.scroll)==0,'consumed scroll does not remain')
        end
    end
end
for _,first in ipairs({false,true}) do
    local u,s=reset(); put(u,'I00F'); put(u,'I006'); local before=u.owner.gold
    buy(u,s,'I01M',first)
    check(before-u.owner.gold==300 and count(u,'I01L')==1,'owned crafted ingredients are never charged again')
    u,s=reset(); put(u,'I00G'); put(u,'I006'); put(u,'I006'); before=u.owner.gold
    buy(u,s,'I01M',first)
    check(before-u.owner.gold==800 and count(u,'I01L')==1,'nested owned scroll/components discount missing purchase')
    u,s=reset(); put(u,'I001'); put(u,'I004'); for i=1,3 do put(u,'junk') end
    before=u.owner.gold; buy(u,s,'I00H',first)
    check(count(u,'I00I')==1 and count(u,'junk')==3 and before-u.owner.gold==300,'full inventory crafts by freeing ingredients')
end
local u,s=reset(); local component=put(u,'I006'); u.owner.gold=1000
buy(u,s,'I01M',false)
check(u.owner.gold==1000 and not component.removed and count(u,'I01M')==0,'insufficient funds refund only scroll, preserve inventory')
u,s=reset(); for i=1,6 do put(u,'junk') end; local before=u.owner.gold
buy(u,s,'I00H',true)
check(u.owner.gold==before and count(u,'junk')==6,'no capacity refunds without deleting unrelated items')
u,s=reset(); failCreate=true; before=u.owner.gold; component=put(u,'I001')
buy(u,s,'I00H',true)
check(u.owner.gold==before and not component.removed,'creation failure is lossless')
u,s=reset(); rejectAdd=true; before=u.owner.gold; buy(u,s,'I00H',true)
check(before-u.owner.gold==500 and count(u,'I00I')==0,'failed inventory insertion preserves a paid ground result')
check(trace[#trace]=='message:The crafted item is at your feet.','ground result communicated')
u,s=reset(); local other=unit(Player(1)); before=other.owner.gold; buy(other,s,'I00H',true)
check(count(other,'I00H')==1 and before-other.owner.gold==300,'non-Ancient has manual recipes only')
u,s=reset(); local potions=put(u,'I01U'); potions.charges=3; before=u.owner.gold
buy(u,s,'I01Q',true)
check(count(u,'I01R')==1 and not potions.removed and potions.charges==2 and before-u.owner.gold==900,'craft consumes one potion charge and discounts only that charge')
u,s=reset(); put(u,'I001'); put(u,'I004'); local scroll=put(u,'I00H'); scroll.charges=3
before=u.owner.gold
local chargedEvent={unit=u,item=scroll,shop=s,player=u.owner}
emit('pickup',chargedEvent); emit('sale',chargedEvent)
check(count(u,'I00I')==1 and scroll.charges==2 and u.owner.gold==before,'pickup-first charged scroll cannot trigger a second paid craft')
u,s=reset(); for i=1,5 do put(u,'junk') end; scroll=put(u,'I00H'); scroll.charges=3
u.owner.gold=u.owner.gold-300; before=u.owner.gold
emit('sale',{unit=u,item=scroll,shop=s,player=u.owner})
flushSales()
check(scroll.charges==2 and u.owner.gold==before+300 and count(u,'junk')==5,'refund consumes only purchased scroll charge; a partial stack does not free a slot')
-- Regression for the native delivery ordering omitted from the original double.
-- SELL_ITEM can run while the sold item is still outside the inventory.
for _,full in ipairs({false,true}) do
    u,s=reset(); put(u,'I001'); for i=1,(full and 5 or 3) do put(u,'junk') end
    local purchased={kind='I00H'}; before=u.owner.gold; u.owner.gold=before-300
    emit('sale',{unit=u,item=purchased,shop=s,player=u.owner})
    check(not purchased.removed and count(u,'I00I')==0,'sale defers mutation until native delivery finishes')
    UnitAddItem(u,purchased) -- Fails for a full inventory: scroll stays on ground.
    flushSales()
    check(purchased.removed and count(u,'I00I')==1 and before-u.owner.gold==400,
        'late delivery/ground scroll completes using owned components at exact discounted cost')
end
u,s=reset(); udg_AncientUnit=nil; before=u.owner.gold; buy(u,s,'I00H',true)
check(count(u,'I00I')==1 and before-u.owner.gold==500,'actual Ancient buyer works without a cached hero handle')
u,s=reset(); for i=1,6 do put(u,'junk') end; before=u.owner.gold; buy(u,s,'I00H',true)
check(count(u,'junk')==6 and u.owner.gold==before,'ground scroll with no available result slot is refunded')
u,s=reset(); local replacement=unit(Player(1)); FE_Roles.setAncient(Player(1)); udg_AncientUnit=replacement
buy(replacement,s,'I00H',true); check(count(replacement,'I00I')==1,'auto buy follows takeover')
buy(u,s,'I00H',true); check(count(u,'I00H')==1,'old Ancient loses auto buy role')
u,s=reset(); put(u,'I01J'); put(u,'I01J'); put(u,'I01J')
emit('pickup',{unit=u,item=u.slots[0],player=u.owner})
check(count(u,'I01N')==1 and count(u,'I01J')==1,'three ledgers combine a distinct pair, leaving one')
other=unit(Player(1)); local ledger=put(other,'I01J'); emit('pickup',{unit=other,item=ledger,player=other.owner})
FE_Ledgers.tick(); check(u.xp==8 and other.xp==3,'all ledger carriers gain XP independently')
RemoveItem(ledger); FE_Ledgers.tick(); check(u.xp==16 and other.xp==3,'dropped ledger stops XP')
u.removed=true; FE_Ledgers.tick(); check(not FE_Ledgers.known[u],'removed carrier released')

-- Identical synchronized order/resource traces with different local clients.
local reference
for _,slot in ipairs({0,6,10}) do
    u,s=reset(slot); u.x=451; FE_Shops.tick(); check(#orders==0,'outside actual range')
    u.x=450; FE_Shops.tick(); check(#orders==1 and orders[1].player==Player(6) and orders[1].buyer==u,'range entry selects Ancient for its owner')
    FE_Shops.tick(); check(#orders==1,'no repeated order spam while buyer unchanged')
    emit('selected',{unit=s,player=Player(1)}); check(#orders==1,'other player shop selection is untouched')
    emit('selected',{unit=s,player=Player(6)}); check(#orders==2,'Ancient selecting shop reasserts buyer')
    flushSales(); check(#orders==3,'buyer reasserted after native selection settles')
    u.x=451; FE_Shops.tick(); u.x=450; FE_Shops.tick(); check(#orders==4,'returning to shop reacquires buyer')
    u.life=0; FE_Shops.tick(); check(#orders==4,'dead hero is not assigned')
    u.life=100; FE_Roles.setAncient(Player(1)); u.owner=Player(1); FE_Shops.tick()
    check(#orders==5 and orders[5].player==Player(1) and orders[5].route=='neutral','shared shop binding follows current owner on takeover')
    buy(u,s,'I01M',true)
    local output=table.concat(trace,'\n')
    if reference then check(reference==output,'gameplay trace independent of GetLocalPlayer') else reference=output end
end

-- The original double supplied a buyer and successful native delivery for
-- every click. Exercise rejected assignment and paid ground items explicitly.
u,s=reset(); FE_Shops.assign(s,true)
check(#orders==1 and orders[1].route=='owned','owned shops use Island Defense target-order path')
u,s=reset(); rejectOwned=true; FE_Shops.assign(s,true)
check(#orders==2 and orders[2].route=='neutral' and FE_Shops.lastBuyer[s]==u,'owned order failure retries explicit player order')
u,s=reset(); rejectOwned=true;rejectNeutral=true;FE_Shops.tick();FE_Shops.tick()
check(#orders==4 and FE_Shops.lastBuyer[s]==nil,'failed native orders never become cached success')
u,s=reset(); s.abilities.Aall.radius=0;FE_Shops.tick()
check(#orders==0 and FE_Shops.describe(s):find('radius=0',1,true),'unreadable range is exposed, never replaced with a guessed radius')
u,s=reset(); local item={kind='I001'};before=u.owner.gold;u.owner.gold=before-100
emit('sale',{unit=u,shop=s,item=item,player=s.owner});flushSales()
check(UnitHasItem(u,item) and before-u.owner.gold==100,'ordinary paid ground item delivered without duplicate item or charge')
check(FE_Shops.diagnostics.sales==1 and FE_Shops.diagnostics.delivered==1 and FE_Recipes.diagnostics.sales==0,'ordinary sales counted separately from recipes')
u,s=reset();item={kind='I001'};other=unit(Player(1));UnitAddItem(other,item)
emit('sale',{unit=u,shop=s,item=item,player=s.owner});flushSales()
check(UnitHasItem(other,item) and not UnitHasItem(u,item),'delivery never takes an item from another unit')
u,s=reset();for i=1,6 do put(u,'junk') end;item={kind='I001'}
emit('sale',{unit=u,shop=s,item=item,player=s.owner});flushSales()
check(not item.removed and not item.unit and FE_Shops.diagnostics.ground==1,'full inventory preserves purchased ground item')
u,s=reset();item={kind='I001'};emit('sale',{unit=u,shop=s,item=item,player=s.owner});u.life=0;flushSales()
check(not item.unit,'delivery cannot move an item into a dead buyer')
u,s=reset();item={kind='I00H'};emit('sale',{shop=s,item=item,player=s.owner});flushSales()
check(not item.removed and not item.unit and FE_Shops.diagnostics.sales==1,'buyerless sale is recorded without guessing who paid')
u,s=reset();FE_Shops.assign(s,true);emit('sale',{shop=s,item={kind='I001'},player=s.owner})
check(FE_Shops.lastBuyer[s]==nil,'observed absent native buyer invalidates cached assignment')
-- Solo tracing is informational. It must not leak into multiplayer or charge,
-- select, or mutate inventory when simply inspecting an order/pickup/drop.
u,s=reset();local debugPlayer=Player(6)
FE_Test={player=debugPlayer,allowed=function(p) return p==debugPlayer end}
FE_Shops.initDebug(debugPlayer);before=u.owner.gold
local quietCount=#trace
check(not FE_Shops.traceEnabled,'community build disables shop tracing by default')
emit('order',{unit=s,player=debugPlayer,order='I00H'})
FE_Shops.trace(debugPlayer,'hidden by default')
check(#trace==quietCount,'solo shop diagnostics remain silent until explicitly enabled')
FE_Shops.traceEnabled=true
emit('order',{unit=s,player=debugPlayer,order='I00H'})
check(trace[#trace]:find('Buy order',1,true) and u.owner.gold==before,'solo order debug works even without a sale event')
for _,timer in ipairs(timers) do if timer.duration==0.1 then timer.callback() end end
check(trace[#trace]:find('sale counter 0 -> 0',1,true),'debug identifies the missing sale event without inventing a refund')
FE_Shops.traceEnabled=false;local n=#trace;emit('order',{unit=s,player=debugPlayer,order='I00H'})
check(#trace==n,'shop off disables automatic diagnostic lines')
FE_Shops.traceEnabled=true;FE_Test.allowed=function() return false end
emit('order',{unit=s,player=debugPlayer,order='I00H'});FE_Shops.trace(debugPlayer,'hidden')
check(#trace==n,'multiplayer-ineligible state cannot emit solo diagnostics')
print('Shopping regression checks passed: '..checks..' assertions; '..scenarios..' purchases; 3 local-client traces')
