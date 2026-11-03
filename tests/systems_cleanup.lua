-- Current systems compared with the frozen r7 source, in isolated environments.
-- Run after extracting tests/fixtures/refactor-r7.zip to build/refactor-r7.
-- These controlled native doubles do not validate Warcraft scheduling/save-load.
local baseline = arg[1] or 'build/refactor-r7'
local checks = 0
local function check(value, message)
    assert(value, message)
    checks = checks + 1
end
local function equal(label, before, after)
    check(before == after, label .. '\nbefore: ' .. tostring(before) .. '\nafter: ' .. tostring(after))
end
local function loadSource(env, path)
    return assert(loadfile(env.root .. '/' .. path, 't', env))()
end
local function environment(root)
    local env = setmetatable({root=root, trace={}, handles={}, players={}}, {__index=_G})
    env._G = env
    function env.record(...)
        local fields = {}
        for i=1,select('#',...) do
            local value = select(i,...)
            fields[i] = type(value)=='table' and assert(value.label) or tostring(value)
        end
        env.trace[#env.trace+1] = table.concat(fields, '|')
    end
    function env.handle(kind)
        local handle = {label=kind..'#'..(#env.handles+1), kind=kind}
        env.handles[#env.handles+1] = handle
        return handle
    end
    function env.Player(slot)
        if not env.players[slot] then env.players[slot]={label='player'..slot,id=slot,gold=10000,lumber=1000} end
        return env.players[slot]
    end
    loadSource(env, 'src/runtime.lua')
    function env.FourCC(raw) return env.__jint(string.unpack('>I4', raw)) end
    function env.StringLength(text) return #(text or '') end
    function env.StringCase(text, upper) return upper and (text or ''):upper() or (text or ''):lower() end
    function env.SubString(text, first, last) return (text or ''):sub(first+1,last) end
    function env.I2S(value) return tostring(value) end
    function env.S2I(text) return env.__jint(tonumber((text or ''):match('^%s*([+-]?%d+)')) or 0) end
    function env.GetLocalPlayer() return env.Player(env.localSlot or 6) end
    function env.ClearTextMessages() env.record('clear') end
    function env.DisplayTimedTextToPlayer(...) env.record('text',...) end
    function env.DisplayTextToPlayer(...) env.record('text',...) end
    function env.GetUnitTypeId(unit) return unit and not unit.removed and unit.raw or 0 end
    function env.GetUnitName(unit) return unit.name or tostring(unit.raw) end
    function env.GetOwningPlayer(unit) return unit.owner end
    function env.GetWidgetLife(unit) return unit.life end
    function env.GetUnitAbilityLevel(unit, ability) return unit.levels and unit.levels[ability] or 0 end
    function env.BlzGetAbilityResearchTooltip(ability, level)
        return '|cAB01F0a0Ability '..ability..' [%d]|r - : '
    end
    function env.BlzGetAbilityResearchExtendedTooltip(ability, level)
        return 'Level %d|n'..ability..'  [value '..level..'] /N|C00112233colored|R'
    end
    env.FE_Roles={ancient=function() return env.Player(env.ancientSlot or 6) end}
    env.FE_Roles.isAncient=function(player) return player == env.FE_Roles.ancient() end
    function env.GetTriggerPlayer() return env.event.player end
    function env.GetEventPlayerChatString() return env.event.text end
    function env.IsPlayerEnemy(player, ancient) return player ~= ancient and player.id ~= 11 end
    return env
end
local before, after = environment(baseline), environment('.')
loadSource(before, 'src/commands/player.lua')
loadSource(after, 'src/commands/player.lua')
local function compareCall(name, ...)
    local a, b = table.pack(before[name](...)), table.pack(after[name](...))
    equal(name..' return count',a.n,b.n)
    for i=1,a.n do equal(name..' return '..i,a[i],b[i]) end
end

-- Pure helpers: literal rather than pattern replacement, malformed tags,
-- unmatched/nested brackets, UTF-8 bytes, and exact literal-space behavior.
local texts = {'', ' ', '  a  b  ', '\t a\n b\r', 'a[b]c', 'a[b[c]d]e',
    'a[open', 'close]tail', '|c11223344x|r', '|Cabcdef12X|R', '|c123x',
    '||c12345678r', '|r|c12345678', '|cFF|r001122', 'alpha - :  ',
    '100% %d %d /n /N |n |N', 'caf\195\169 \240\159\140\178', string.char(0)..' -'}
local helperNames = {'Ancient_CollapseSpaces','Ancient_RemoveColorCodes',
    'Ancient_RemoveSquareBracketBlocks','Ancient_CleanTrailingSeparators'}
for _, name in ipairs(helperNames) do
    compareCall(name,nil)
    for _, text in ipairs(texts) do compareCall(name,text) end
end
for _, text in ipairs(texts) do
    for _, find in ipairs({'',' ','a','%d','|r','[','.*','aa'}) do
        for _, replacement in ipairs({'','%1','|c00112233','[replacement]'}) do
            compareCall('Ancient_ReplaceAll',text,find,replacement)
        end
        compareCall('Ancient_ReplaceAll',text,find,nil)
    end
    compareCall('Ancient_FormatTooltipText',text,3)
end
compareCall('Ancient_ReplaceAll',nil,'a','b')
compareCall('Ancient_ReplaceAll','source',nil,'b')
compareCall('Ancient_IsHexChar',nil)
compareCall('Ancient_IsHexChar',12)
compareCall('Ancient_IsHexChar','')
compareCall('Ancient_IsHexChar','aa')
for byte=0,255 do compareCall('Ancient_IsHexChar',string.char(byte)) end
local seed, tokens = 19, {'a',' ','\t','[',']','|c','|C','|r','|R','FF001122','%d',':','-','/n'}
for case=1,500 do
    local parts = {}
    for index=1,case%23+1 do
        seed=(seed*109+89)%65521
        parts[index]=tokens[seed%#tokens+1]
    end
    local text=table.concat(parts)
    for _,name in ipairs(helperNames) do compareCall(name,text) end
    compareCall('Ancient_FormatTooltipText',text,case%7)
end

-- Exhaust the declared metadata, including all old aliases and unknown keys.
local rawTypes={'O00A','O00S','O00L','O004','O008','O01V','O016','O00D','O01X','O01Z','O01D','xxxx'}
local aliases={'darkness','paranoia','dragon','dragons','dragos','drago','earth','tremor',
    'fire','ignite','ice','avalanche','avalanch','light','divinity','lightning','lighting','zalxon',
    'nature','eternity','sand','pharaoh','pharaon','space','nebula','wind','wispari','whispari',
    'whisperi','wisperi','','Darkness','unknown'}
for _,alias in ipairs(aliases) do compareCall('Ancient_GetUnitTypeIdByKeyword',alias) end
compareCall('Ancient_GetUnitTypeIdByKeyword',nil)
for _,raw in ipairs(rawTypes) do
    local id=before.FourCC(raw)
    compareCall('Ancient_GetUnitTypeDisplayName',id)
    compareCall('Ancient_GetAbilityCount',id)
    for index=-1,8 do compareCall('Ancient_GetAbilityIdByIndex',id,index) end
    compareCall('Ancient_GetAbilityIdByIndex',id,nil)
    compareCall('Ancient_GetAbilityIdByIndex',id,'2')
    compareCall('Ancient_GetAbilityIdByIndex',id,1.5)
end
compareCall('Ancient_GetUnitTypeDisplayName',nil)
compareCall('Ancient_GetAbilityCount',nil)
for _,text in ipairs({'','0','-1','2','+2','2tail','darkness','darkness 2','LIGHTNING 7','wind\t2'}) do
    compareCall('Ancient_ParsePageFromArgument',text)
end
local function commandTrace(env,slot,localSlot,text,raw,life)
    env.trace={};env.localSlot=localSlot
    env.event={player=env.Player(slot),text=text}
    env.udg_AncientUnit=raw and {raw=env.FourCC(raw),name='Ancient hero',life=life,levels={}} or nil
    if env.udg_AncientUnit then
        for index=1,6 do
            env.udg_AncientUnit.levels[env.Ancient_GetAbilityIdByIndex(env.udg_AncientUnit.raw,index)]=index%4
        end
    end
    env.Ancient_Command_Actions()
    return table.concat(env.trace,'\n')
end
for _,slot in ipairs({0,6,11}) do
    for _,localSlot in ipairs({0,6}) do
        for _,text in ipairs({'-ancient','-ancient 0','-ancient 2','-ancient 999','-ancient darkness 2',
            '-ANCIENT lighting 2','-ancient wind','-ancient nonsense','-ancient\t2','-ancientfoo','other'}) do
            for _,raw in ipairs(rawTypes) do
                equal('Ancient command native trace',commandTrace(before,slot,localSlot,text,raw,100),
                    commandTrace(after,slot,localSlot,text,raw,100))
            end
        end
    end
end
equal('Missing Ancient trace',commandTrace(before,0,0,'-ancient',nil,0),commandTrace(after,0,0,'-ancient',nil,0))
equal('Dead Ancient trace',commandTrace(before,0,0,'-ancient','O004',0),commandTrace(after,0,0,'-ancient','O004',0))

-- Item registration and nested inventory events: preserve legacy listener order,
-- callback identity, ingredient choice, resource mutation, and pending sale state.
local initializers={'Spellcasters_Cloak','Ethereal_Scepter','Firelords_Cape','Ledget_of_Enlightment',
    'Hammer_of_might','Valorous_Helmet','Bladed_Gauntlet','Righteous_Armor','Arcanum_of_Hatred',
    'Bleeding_Scythe','Staff_of_Insight','Cosmic_Orb'}
local function shoppingEnvironment(root)
    local env=environment(root)
    env.triggers={};env.timers={};env.items={}
    env.EVENT_PLAYER_UNIT_PICKUP_ITEM='pickup';env.EVENT_PLAYER_UNIT_DROP_ITEM='drop';env.EVENT_PLAYER_UNIT_SELL_ITEM='sale'
    env.PLAYER_STATE_RESOURCE_GOLD='gold';env.PLAYER_STATE_RESOURCE_LUMBER='lumber'
    env.FE_Shops={observeSale=function() end,trace=function() end,traceDefault=function() end,raw=tostring,deliver=function() error('unexpected ordinary sale') end}
    function env.CreateTrigger()
        local trigger=env.handle('trigger');trigger.conditions={};trigger.actions={}
        env.triggers[#env.triggers+1]=trigger;env.record('CreateTrigger',trigger);return trigger
    end
    function env.functionName(fn)
        for name,value in pairs(env) do if value==fn then return name end end
        return 'anonymous'
    end
    function env.Condition(fn) env.record('Condition',env.functionName(fn));return fn end
    function env.TriggerRegisterAnyUnitEventBJ(t,kind) t.event=kind;env.record('Register',t,kind) end
    function env.TriggerAddCondition(t,fn) t.conditions[#t.conditions+1]=fn;env.record('AddCondition',t,env.functionName(fn)) end
    function env.TriggerAddAction(t,fn) t.actions[#t.actions+1]=fn;env.record('AddAction',t,env.functionName(fn)) end
    function env.emit(kind,unit,item,shop)
        local previous=env.event
        env.event={kind=kind,unit=unit,item=item,shop=shop,player=unit.owner}
        for _,trigger in ipairs(env.triggers) do
            if trigger.event==kind then
                local accepted=true
                for _,condition in ipairs(trigger.conditions) do if not condition() then accepted=false;break end end
                if accepted then for _,action in ipairs(trigger.actions) do action() end end
            end
        end
        env.event=previous
    end
    function env.GetTriggerUnit() return env.event.kind=='sale' and env.event.shop or env.event.unit end
    function env.GetTriggerEventId() return env.event and env.event.kind end
    function env.GetManipulatedItem() return env.event.item end
    function env.GetBuyingUnit() return env.event.unit end
    function env.GetSoldItem() return env.event.item end
    function env.GetSellingUnit() return env.event.shop end
    function env.GetUnitX(unit) return unit.x end
    function env.GetUnitY(unit) return unit.y end
    function env.UnitInventorySize(unit) return unit.size end
    function env.UnitItemInSlot(unit,slot) return unit.slots[slot] end
    function env.GetItemTypeId(item) return item and not item.removed and item.raw or 0 end
    function env.GetItemCharges(item) return item.charges or 0 end
    function env.SetItemCharges(item,value) item.charges=value;env.record('Charges',item,value) end
    function env.GetPlayerState(player,state) return player[state] end
    function env.SetPlayerState(player,state,value) player[state]=value;env.record('Resource',player,state,value) end
    function env.UnitHasItem(unit,item) return item and not item.removed and item.unit==unit end
    function env.CreateItem(raw,x,y)
        env.record('CreateItem',raw,x,y)
        if env.failCreate then return nil end
        local item=env.handle('item');item.raw=raw;item.x=x;item.y=y
        env.items[#env.items+1]=item;return item
    end
    function env.UnitAddItem(unit,item)
        env.record('UnitAddItem',unit,item)
        if env.rejectAdd then return false end
        for slot=0,unit.size-1 do
            if not unit.slots[slot] then
                unit.slots[slot]=item;item.unit=unit;env.emit('pickup',unit,item);return true
            end
        end
        return false
    end
    function env.RemoveItem(item)
        check(not item.removed,'No duplicate item consumption')
        env.record('RemoveItem',item)
        local unit=item.unit
        if unit then
            for slot=0,unit.size-1 do if unit.slots[slot]==item then unit.slots[slot]=nil end end
            env.emit('drop',unit,item)
        end
        item.removed=true;item.unit=nil
    end
    function env.CreateTimer()
        local timer=env.handle('timer');env.timers[#env.timers+1]=timer;env.record('CreateTimer',timer);return timer
    end
    function env.TimerStart(timer,duration,periodic,callback)
        timer.callback=callback;timer.duration=duration;timer.periodic=periodic;env.record('TimerStart',timer,duration,periodic)
    end
    function env.DestroyTimer(timer) check(not timer.destroyed,'Timer destroyed once');timer.destroyed=true;env.record('DestroyTimer',timer) end
    function env.flush()
        for _,timer in ipairs(env.timers) do if not timer.destroyed and timer.duration==0 then timer.callback() end end
    end
    function env.unit(slot)
        local unit=env.handle('unit');unit.owner=env.Player(slot);unit.raw=env.FourCC('O004')
        unit.x=0;unit.y=0;unit.life=100;unit.size=6;unit.slots={};return unit
    end
    function env.put(unit,raw,charges)
        local item=env.CreateItem(env.FourCC(raw),0,0);item.charges=charges
        for slot=0,unit.size-1 do if not unit.slots[slot] then unit.slots[slot]=item;item.unit=unit;return item end end
        return item -- Native delivery can leave a purchased item on the ground.
    end
    loadSource(env,'src/items/recipe_data.lua');loadSource(env,'src/items/recipes.lua');loadSource(env,'src/items/effects.lua')
    for _,name in ipairs(initializers) do env['InitTrig_'..name]() end
    env.FE_Recipes.init()
    return env
end
local function shoppingCase(root,components,purchase,saleFirst,option)
    local env=shoppingEnvironment(root)
    local unit,shop=env.unit(6),env.unit(6);shop.raw=env.FourCC('h02B')
    for _,raw in ipairs(components) do env.put(unit,raw,option=='charges' and 3 or nil) end
    if option=='funds' then unit.owner.gold=350 end
    local item
    if purchase then
        item=env.put(unit,purchase)
        local price=env.FE_RecipeData.items[item.raw]
        unit.owner.gold=unit.owner.gold-price.gold;unit.owner.lumber=unit.owner.lumber-price.lumber
    else item=unit.slots[0] end
    env.failCreate=option=='create';env.rejectAdd=option=='add'
    if purchase and saleFirst then env.emit('sale',unit,item,shop) end
    env.emit('pickup',unit,item)
    if purchase and not saleFirst then env.emit('sale',unit,item,shop) end
    env.flush()
    env.record('FinalResources',unit.owner.gold,unit.owner.lumber)
    for slot=0,unit.size-1 do env.record('Slot',slot,unit.slots[slot]) end
    for _,owned in ipairs(env.items) do env.record('ItemState',owned,owned.raw,owned.charges,owned.unit,owned.removed) end
    local recipes=env.FE_Recipes
    env.record('RecipeState',recipes.busy[unit],recipes.pending[unit],recipes.diagnostics.sales,
        recipes.diagnostics.completed,recipes.diagnostics.refunded,recipes.diagnostics.last)
    return table.concat(env.trace,'\n')
end
local cases={
    {{'I00H','I001','I004','I01S','I00Z'}}, -- nested Cape competes with the Helmet listener
    {{'I01M','I00G','I002','I006','I006'}}, -- nested Hammer and Gauntlet
    {{'I01Q','I01O','I00Z','I01B','I01U','I00S'}}, -- Cloak/Scepter share mana orb
    {{'I01D','I011','I00I','I00Z','I004','I01B'}}, -- Staff/Armor share Helmet
    {{'I01J','I01J','I01J','I01J'}},
    {{'I001','I004'},'I00H'},
    {{},'I01M'},
    {{'I001','I004','I000','I000','I000','I000'},'I00H'},
    {{'I000','I000','I000','I000','I000','I000'},'I00H'},
    {{'I001'},'I00H','funds'},
    {{'I001'},'I00H','create'},
    {{'I001'},'I00H','add'},
    {{'I01U','I00Z','I01B'},'I01Q','charges'},
}
for _,case in ipairs(cases) do
    for _,saleFirst in ipairs({false,true}) do
        equal('Recipe native and inventory trace',shoppingCase(baseline,case[1],case[2],saleFirst,case[3]),
            shoppingCase('.',case[1],case[2],saleFirst,case[3]))
    end
end

local function saleDiagnosticTrace(root,enabled,hasSandbox)
    local env=environment(root)
    function env.GetPlayerId(player) return player.id end
    function env.GetItemTypeId(item) return item and item.raw or 0 end
    local shop={raw=env.FourCC('h02B'),owner=env.Player(6),name='Shop'}
    local item={raw=env.FourCC('I00H')}
    local buyer
    function env.GetBuyingUnit() return buyer end
    function env.GetSoldItem() return item end
    function env.GetSellingUnit() return shop end
    if hasSandbox then env.FE_Test={player=env.Player(6),allowed=function(player) return player==env.Player(6) end} end
    loadSource(env,'src/items/recipe_data.lua');loadSource(env,'src/items/recipes.lua');loadSource(env,'src/items/shops.lua')
    env.FE_Shops.traceEnabled=enabled
    env.FE_Recipes.onSale() -- No native buyer: use only the optional diagnostic recipient.
    buyer={raw=env.FourCC('h000'),owner=env.Player(0),name='Other buyer'}
    env.FE_Recipes.onSale() -- An ineligible buyer must not be converted into a payer.
    if hasSandbox then env.FE_Test.allowed=function() return false end end
    env.FE_Recipes.onSale() -- Eligibility is checked dynamically, not cached.
    env.record('Diagnostics',env.FE_Shops.diagnostics.sales,env.FE_Shops.diagnostics.last,
        env.FE_Recipes.diagnostics.sales,env.FE_Recipes.diagnostics.last)
    return table.concat(env.trace,'\n')
end
for _,enabled in ipairs({false,true}) do
    for _,hasSandbox in ipairs({false,true}) do
        equal('Sale diagnostics output boundary',saleDiagnosticTrace(baseline,enabled,hasSandbox),
            saleDiagnosticTrace('.',enabled,hasSandbox))
    end
end

-- The only deliberate behavioral difference in this suite: each ping releases
-- its newly allocated force and location. All other native calls remain ordered.
local function pingTrace(root,cleanupExpected)
    local env=environment(root);local forceCount,locationCount,freedForces,freedLocations=0,0,0,0
    env.event={player=env.Player(2)}
    for index=1,7 do env['gg_rct_Ping'..index]={label='region'..index} end
    function env.GetPlayersAllies(player)
        forceCount=forceCount+1
        local force=env.handle('force');force.owned=true;env.record('Allies',player,force);return force
    end
    function env.GetRectCenter(rect)
        locationCount=locationCount+1
        local location=env.handle('location');location.owned=true;env.record('Center',rect,location);return location
    end
    function env.PingMinimapLocForForce(force,location,duration) env.record('Ping',force,location,duration) end
    function env.DestroyForce(force)
        check(force.owned and force.kind=='force' and not force.freed,'Only newly owned forces are destroyed once')
        force.freed=true;freedForces=freedForces+1
    end
    function env.RemoveLocation(location)
        check(location.owned and location.kind=='location' and not location.freed,'Only newly owned locations are removed once')
        location.freed=true;freedLocations=freedLocations+1
    end
    loadSource(env,'src/ui/hints.lua')
    env.Trig_Ping_Actions();env.Trig_PingForAncient_Actions()
    equal('Ping force allocations',forceCount,14);equal('Ping location allocations',locationCount,14)
    equal('Ping force releases',freedForces,cleanupExpected and 14 or 0)
    equal('Ping location releases',freedLocations,cleanupExpected and 14 or 0)
    for _,handle in ipairs(env.handles) do equal('Ping ownership balance',not not handle.freed,cleanupExpected) end
    return table.concat(env.trace,'\n')
end
equal('Ping recipients/regions/native order unchanged',pingTrace(baseline,false),pingTrace('.',true))

local function soloTrace(root,text,mode,humans,direct)
    local env=environment(root);env.triggers={};env.timers={}
    env.bj_MAX_PLAYER_SLOTS=28;env.MAP_CONTROL_USER='user';env.PLAYER_SLOT_STATE_PLAYING='playing'
    env.PLAYER_STATE_RESOURCE_GOLD='gold';env.PLAYER_STATE_RESOURCE_LUMBER='lumber'
    env.EVENT_PLAYER_UNIT_SELECTED='selected';env.UNIT_TYPE_HERO='hero'
    env.UNIT_STATE_MAX_LIFE='maxlife';env.UNIT_STATE_MANA='mana';env.UNIT_STATE_MAX_MANA='maxmana'
    env.FOG_OF_WAR_VISIBLE='visible';env.bj_mapInitialPlayableArea={label='playable'}
    function env.GetPlayerController(p)
        return (p.id==6 or (humans==2 and p.id==0)) and 'user' or 'computer'
    end
    function env.GetPlayerSlotState(p) return env.GetPlayerController(p)=='user' and 'playing' or 'empty' end
    function env.GetPlayerState(p,k) return p[k] end
    function env.SetPlayerState(p,k,v) p[k]=v;env.record('PlayerState',p,k,v) end
    function env.GetUnitState(u,k) return u[k] end
    function env.SetUnitState(u,k,v) u[k]=v;env.record('UnitState',u,k,v) end
    function env.GetUnitX(u) return u.x end
    function env.GetUnitY(u) return u.y end
    function env.GetUnitFacing(u) return u.facing end
    function env.GetPlayerStartLocation(p) return p.id end
    function env.GetStartLocationX(id) return id*100 end
    function env.GetStartLocationY() return 200 end
    function env.GetItemTypeId(item) return item and item.raw or 0 end
    function env.UnitItemInSlot(u,slot) return u.slots[slot] end
    function env.CreateTrigger()
        local t=env.handle('trigger');t.conditions={};env.triggers[#env.triggers+1]=t;env.record('CreateTrigger',t);return t
    end
    function env.Condition(f) return f end
    function env.TriggerAddCondition(t,f) t.conditions[#t.conditions+1]=f;env.record('AddCondition',t) end
    function env.TriggerAddAction(t,f) t.action=f;env.record('AddAction',t) end
    function env.TriggerRegisterPlayerChatEvent(t,p,pattern,exact) t.event='chat';t.player=p;env.record('ChatEvent',t,p,pattern,exact) end
    function env.TriggerRegisterPlayerUnitEventSimple(t,p,event) t.event=event;t.player=p;env.record('UnitEvent',t,p,event) end
    function env.GetTriggerUnit() return env.event.unit end
    function env.CreateTimer() local t=env.handle('timer');env.timers[#env.timers+1]=t;env.record('CreateTimer',t);return t end
    function env.TimerStart(t,duration,periodic,callback) t.callback=callback;env.record('TimerStart',t,duration,periodic) end
    function env.DestroyTimer(t) t.destroyed=true;env.record('DestroyTimer',t) end
    function env.CreateUnit(p,raw,x,y,facing)
        local u=env.handle('unit');u.owner=p;u.raw=raw;u.x=x;u.y=y;u.facing=facing
        env.record('CreateUnit',u,p,raw,x,y,facing);return u
    end
    function env.CreateItem(raw,x,y) local item=env.handle('item');item.raw=raw;env.record('CreateItem',item,raw,x,y);return item end
    function env.IsUnitType(u) return u.hero end
    function env.GetHeroLevel(u) return u.level end
    function env.AddHeroXP(u,n,show) u.xp=(u.xp or 0)+n;env.record('XP',u,n,show) end
    function env.SetHeroLevel(u,n,show) u.level=math.max(u.level,n);env.record('Level',u,n,show) end
    function env.UnitStripHeroLevel(u,n) u.level=u.level-n;env.record('StripLevel',u,n) end
    function env.SetWidgetLife(u,n) u.life=n;env.record('Life',u,n) end
    function env.UnitResetCooldown(u) u.cooldown=0;env.record('Cooldown',u) end
    function env.SetUnitInvulnerable(u,v) u.invul=v;env.record('Invulnerable',u,v) end
    function env.KillUnit(u) u.life=0;env.record('Kill',u) end
    function env.RemoveUnit(u) u.removed=true;env.record('Remove',u) end
    function env.ReviveHero(u,x,y,show) u.life=100;env.record('Revive',u,x,y,show) end
    function env.SetUnitMoveSpeed(u,n) u.speed=n;env.record('Speed',u,n) end
    function env.SetTimeOfDay(n) env.record('Time',n) end
    function env.CreateFogModifierRect(...) local fog=env.handle('fog');env.record('Fog',fog,...);return fog end
    function env.FogModifierStart(f) f.active=true;env.record('FogStart',f) end
    function env.FogModifierStop(f) f.active=false;env.record('FogStop',f) end
    function env.DestroyFogModifier(f) f.destroyed=true;env.record('FogDestroy',f) end
    function env.DisableTrigger(t) t.disabled=true;env.record('Disable',t) end
    function env.PauseTimer(t) t.paused=true;env.record('Pause',t) end
    function env.TimerDialogDisplay(d,v) d.visible=v;env.record('Dialog',d,v) end
    function env.RemoveUnitFromStock(shop,raw) env.record('RemoveStock',shop,raw) end
    function env.AddUnitToStock(shop,raw,a,b) env.record('Stock',shop,raw,a,b) end
    env.FE_TestData={releaseLabel='fixture r7',catalog={},units={h000=true},items={I001=true},pickers={}}
    for index=1,15 do env.FE_TestData.catalog[index]={kind='units',raw=string.format('h%03d',index-1),name='Unit '..index} end
    env.FE_TestData.catalog[16]={kind='items',raw='I001',name='Helm of Devotion'}
    env.FE_Recipes={initialized=true,diagnostics={sales=3,completed=2,refunded=1,last='recipe status'}}
    env.FE_Shops={traceEnabled=false,diagnostics={sales=4,delivered=3,ground=1,last='shop status'},shops={}}
    function env.FE_Shops.initDebug(p) env.record('ShopDebug',p) end
    function env.FE_Shops.describe(shop) return shop.label end
    loadSource(env,'src/commands/solo_test.lua')
    for _,name in ipairs(env.FE_Test.resultTriggers) do env[name]=env.handle('result');env[name].conditions={} end
    for _,name in ipairs({'Spawn_Races','Spawn_Ancients','TimeToExpanderSpawn','TimeToAncientSpawn'}) do env['gg_trg_'..name]=env.handle('pick') end
    env.FE_Test.init()
    for _,timer in ipairs(env.timers) do timer.callback() end
    local player=env.Player(6)
    local unit=env.CreateUnit(player,env.FourCC('h000'),10,20,270)
    unit.life=50;unit.maxlife=100;unit.mana=20;unit.maxmana=100;unit.level=5;unit.hero=mode~='nonhero';unit.slots={}
    unit.slots[0]=env.CreateItem(env.FourCC('I001'),0,0)
    if mode~='none' then
        env.event={unit=unit,player=player}
        for _,trigger in ipairs(env.triggers) do if trigger.event=='selected' then trigger.action() end end
        env.udg_AncientUnit=unit
    end
    if mode=='foreign' then unit.owner=env.Player(0) end
    if mode=='dead' then unit.life=0 end
    if mode=='removed' then unit.removed=true end
    if mode=='vision' then env.FE_Test.vision=env.CreateFogModifierRect(player,'visible',env.bj_mapInitialPlayableArea,true,false) end
    if direct then env.FE_Test.run(player,text)
    else
        env.event={player=player,text=text}
        for _,trigger in ipairs(env.triggers) do if trigger.event=='chat' then trigger.action() end end
    end
    env.record('FinalPlayer',player.gold,player.lumber)
    env.record('FinalUnit',unit.life,unit.mana,unit.level,unit.xp,unit.invul,unit.speed,unit.cooldown,unit.removed)
    env.record('FinalSandbox',env.FE_Test.player,env.FE_Test.selected,env.FE_Test.vision,env.FE_Test.skipped,env.FE_Shops.traceEnabled)
    return table.concat(env.trace,'\n')
end
local commands={'-test','-test help','-cheats','-test skip','-skip','-gold 50','-test GOLD -1000000',
    '-lumber 1000000','-test gold 1000001','-gold +5','-test gold 1.5','-test find he','-test find a',
    '-test items','-test units 2','-test units 2 unit','-test units 99999','-test reveal','-mh','-nomh',
    '-test time 24','-test time 25','-test shop on','-test shop off','-test shop ON',
    '-spawn h000 3','-test spawn h000 21','-unit nope','-item I001 6','-test item I001 7',
    '-xp 30','-test xp -1','-lvl 3','-test level 20','-test level 21','-heal','-mana','-test cooldown',
    '-test cd','-cd','-invul','-vul','-test kill','-test destroy','-test revive','-test speed 522','-test speed -1',
    '-test copy 2','-test copy 0','-test unitid','-test itemid','-test loc','-test nonsense','-hardmode',
    '  -test gold 5','-TEST\tgold\t5',''}
for _,mode in ipairs({'own','none','foreign','dead','removed','nonhero','vision'}) do
    for _,text in ipairs(commands) do
        for _,direct in ipairs({false,true}) do
            equal('Solo command native/state trace '..mode..' '..text,
                soloTrace(baseline,text,mode,1,direct),soloTrace('.',text,mode,1,direct))
        end
    end
end
for _,text in ipairs({'-gold 1000','-test skip','-test reveal','-test destroy'}) do
    equal('Multiplayer solo gate',soloTrace(baseline,text,'own',2,true),soloTrace('.',text,'own',2,true))
end
print('Systems cleanup checks passed: '..checks..' assertions; frozen r7 text/metadata/command/recipe/ping/solo comparisons; 14 force + 14 location releases added across two ping actions')
