-- Exercise the real bootstrap order, picking timers, selector and result
-- triggers together. Natives and unrelated systems remain an engine double.
local checks=0
local function check(value,message) assert(value,message);checks=checks+1 end
local players,triggers,queue,now,event,dialogs,announcements,results,banners,order,stockCalls
-- Prepared from the real unit objects by tests/picker_objects.py. Previous
-- tests ignored native stock timing and accepted Worgen's one-hour interval.
local stockData=dofile('build/picker-stock-test-input.lua')
local function schedule(delay,callback) queue[#queue+1]={at=now+delay,callback=callback} end
local function resume(co,context)
    event=context
    local ok,delay=coroutine.resume(co);assert(ok,delay)
    if coroutine.status(co)~='dead' then schedule(delay,function() resume(co,context) end) end
end
local function fire(trigger,context)
    if trigger.disabled then return end
    event=context or {};event.trigger=trigger
    for _,condition in ipairs(trigger.conditions) do if not condition() then return end end
    for _,action in ipairs(trigger.actions) do resume(coroutine.create(action),event) end
end
local function advance(untilTime)
    while true do
        local nextIndex
        for i,task in ipairs(queue) do
            if task.at<=untilTime and (not nextIndex or task.at<queue[nextIndex].at) then nextIndex=i end
        end
        if not nextIndex then break end
        local task=table.remove(queue,nextIndex);now=task.at;task.callback()
    end
    now=untilTime
end
local function emit(kind,player,unit,text,buyer,item)
    for _,trigger in ipairs(triggers) do
        for _,registration in ipairs(trigger.events) do
            local chatMatches=kind~='chat' or not registration.pattern or
                (registration.exact and text==registration.pattern) or
                (not registration.exact and text:find(registration.pattern,1,true)~=nil)
            if chatMatches and registration.kind==kind and (not registration.player or registration.player==player) then
                fire(trigger,{player=player,unit=unit,text=text,buyer=buyer,item=item});break
            end
        end
    end
end
function Player(i) if not players[i] then players[i]={id=i,controller='computer',state='empty',gold=0} end;return players[i] end
function GetPlayerId(p) return p.id end
function GetPlayerController(p) return p.controller end
function GetPlayerSlotState(p) return p.state end
function GetPlayerState(p,key) return p[key] end
function SetPlayerState(p,key,value) p[key]=value end
function GetTriggerPlayer() return event.player end
function GetTriggerUnit() return event.unit end
function GetLevelingUnit() return event.unit end
function GetBuyingUnit() return event.buyer end
function GetSellingUnit() return event.unit end
function GetSoldItem() return event.item end
function GetItemTypeId(item) return item and not item.removed and item.kind or 0 end
function GetTriggeringTrigger() return event.trigger end
function GetEventPlayerChatString() return event.text end
function GetUnitTypeId(u) return u and u.kind or 0 end
function GetUnitLevel(u) return u.level end
function GetOwningPlayer(u) return u.owner end
function FourCC(s) return s end
function __jreal(n) return n end
function __jint(n) return n end
function __jconcat(a,b) return tostring(a)..tostring(b) end
function I2S(n) return tostring(n) end
function DoNothing() end
function CreateTrigger() local t={conditions={},actions={},events={}};triggers[#triggers+1]=t;return t end
function Condition(f) return f end
function TriggerAddCondition(t,f) t.conditions[#t.conditions+1]=f end
function TriggerAddAction(t,f) t.actions[#t.actions+1]=f end
function DisableTrigger(t) if t then t.disabled=true end end
function EnableTrigger(t) t.disabled=false end
function TriggerRegisterTimerEventSingle(t,delay) schedule(delay,function() fire(t) end) end
function TriggerRegisterTimerEventPeriodic(t,period)
    local function tick() fire(t);schedule(period,tick) end
    schedule(period,tick)
end
function TriggerRegisterPlayerUnitEventSimple(t,p,kind) t.events[#t.events+1]={player=p,kind=kind} end
function TriggerRegisterPlayerEventLeave(t,p) TriggerRegisterPlayerUnitEventSimple(t,p,'leave') end
function TriggerRegisterPlayerChatEvent(t,p,pattern,exact)
    t.events[#t.events+1]={player=p,kind='chat',pattern=pattern,exact=exact}
end
function TriggerRegisterAnyUnitEventBJ(t,kind) t.events[#t.events+1]={kind=kind} end
function TriggerSleepAction(delay) coroutine.yield(delay) end
function CreateTimer() return {} end
function TimerStart(t,delay,periodic,callback)
    t.duration=delay;t.expires=now+delay
    if callback then schedule(delay,function() if not t.paused then callback() end end) end
end
function DestroyTimer(t) t.destroyed=true end
function PauseTimer(t) t.paused=true end
local lastDialog
function StartTimerBJ() error('GUI timer helper can release loading-time timer') end
function GetLastCreatedTimerBJ() error('timer ownership must be explicit') end
function CreateTimerDialogBJ(t,title) lastDialog={timer=t,title=title,visible=true};dialogs[#dialogs+1]=lastDialog end
function GetLastCreatedTimerDialogBJ() return lastDialog end
function TimerDialogDisplay(d,visible) d.visible=visible end
function DestroyTimerDialogBJ(d) d.destroyed=true;d.visible=false end
function RemoveUnitFromStock(shop,raw)
    shop.stock[raw]=nil;shop.maximum[raw]=nil;shop.stockState[raw]=nil
    stockCalls[#stockCalls+1]={'remove',raw}
end
function AddUnitToStock(shop,raw,count,maximum)
    local object=assert(stockData[raw],'missing native picker data: '..raw)
    shop.stock[raw]=count;shop.maximum=shop.maximum or {};shop.maximum[raw]=maximum
    shop.stockState=shop.stockState or {}
    shop.stockState[raw]={readyAt=now+object.start,interval=object.interval}
    stockCalls[#stockCalls+1]={'add',raw}
end
function SetPlayerTechResearched(player,raw,level)
    player.tech=player.tech or {};player.tech[raw]=level
end
function AddUnitToStockBJ(raw,shop,count,max) AddUnitToStock(shop,raw,count,max) end
function AddItemToStock(shop,raw,count,maximum)
    check(stockData[shop.kind] and stockData[shop.kind].sellsItems,'dynamic item stock needs native Sell Items ability')
    AddUnitToStock(shop,raw,count,maximum)
end
RemoveItemFromStock=RemoveUnitFromStock
function KillUnit(u) u.dead=true;emit('death',u.owner,u) end
function CreateQuest() return {} end
for _,name in ipairs({'QuestSetTitle','QuestSetDescription','QuestSetRequired','QuestSetDiscovered','QuestSetEnabled','QuestSetIconPath'}) do _G[name]=function() end end
function DisplayTextToPlayer(p,x,y,text) banners[#banners+1]=text end
function GetPlayersAll() return {} end
function DisplayTextToForce(force,text)
    if text=='Factions can no longer be banned.' then banners[#banners+1]=text
    else announcements[#announcements+1]=text end
end
function DisplayTimedTextToForce(force,seconds,text) announcements[#announcements+1]=text end
function PlayThematicMusicBJ() end
function CustomVictoryBJ(p) results[#results+1]={player=p,won=true} end
function CustomDefeatBJ(p) results[#results+1]={player=p,won=false} end
function GetLocalPlayer() error('Unsynchronized branch in gameplay test') end
bj_MAX_PLAYER_SLOTS=28;MAP_CONTROL_USER='user';PLAYER_SLOT_STATE_PLAYING='playing'
PLAYER_STATE_RESOURCE_GOLD='gold';PLAYER_STATE_RESOURCE_LUMBER='lumber'
EVENT_PLAYER_UNIT_DEATH='death';EVENT_PLAYER_HERO_LEVEL='level';EVENT_PLAYER_UNIT_SELECTED='selected';EVENT_PLAYER_UNIT_SELL='sell'
EVENT_PLAYER_UNIT_SELL_ITEM='sellItem'

local manifest=dofile('build/role-test-input.lua')
local initializers=manifest.soloInitializers
for _,path in ipairs({'src/game/startup.lua','src/game/selection.lua','src/game/victory.lua','src/players/leaving.lua'}) do dofile(path) end
dofile('src/players/roles.lua');dofile('src/bootstrap.lua')
function ExecuteFunc(name) order[#order+1]=name end
function FE_InitNativeGlobals() order[#order+1]='native-globals' end
function FE_InitGlobals()
    order[#order+1]='globals';udg_AncientPlayer=Player(FE_Roles.initialAncientSlot);udg_StillAlive=0;udg_Selectors='ewsp'
    udg_Bans=3
    udg_ExpanderSpawnTimer=CreateTimer();udg_AncientSpawnTimer=CreateTimer()
    for _,entry in ipairs(FE_TestData.pickers) do _G[entry.shop]={kind=entry.shop:sub(9,12),stock={}};_G[entry.ban]=0 end
end
function FE_InitCustomTriggers()
    order[#order+1]='triggers'
    for _,name in ipairs(initializers) do _G[name]() end
end
FE_Recipes={init=function() order[#order+1]='recipes' end}
FE_Shops={init=function() order[#order+1]='shops' end,initDebug=function() end}
function FE_RunInitializationTriggers()
    order[#order+1]='startup';check(FE_Test.initialized,'solo eligibility precedes startup actions')
end
local function reset(humans)
    players={};triggers={};queue={};now=0;event={};dialogs={};announcements={};results={};banners={};order={};stockCalls={}
    for _,slot in ipairs(humans) do local p=Player(slot);p.controller='user';p.state='playing' end
    dofile('src/commands/test_data.lua');dofile('src/commands/solo_test.lua')
    dofile('src/game/selection.lua')
    InitTrig_FE_Bootstrap()
    check(table.concat(order,',')=='native-globals,jasshelper__initstructs149790140,PassiveMissiles__Init,SpellLeech__Init,globals,triggers,recipes,shops,startup','real bootstrap order')
end

-- Model stock admission separately from research: ordinary mercenary hiring
-- may ignore the latter. Even aggressive replenishment cannot fill a zero cap.
local function tryPurchase(entry,player)
    local shop=_G[entry.shop]
    local state=shop.stockState and shop.stockState[entry.raw]
    if not state or now<state.readyAt or not shop.stock[entry.raw] or shop.stock[entry.raw]<=0 then return nil end
    shop.stock[entry.raw]=shop.stock[entry.raw]-1
    -- A removed/replaced stock entry cancels its previous replenishment.
    schedule(state.interval,function()
        if shop.stockState[entry.raw]==state then
            shop.stock[entry.raw]=math.min(shop.maximum[entry.raw],shop.stock[entry.raw]+1)
        end
    end)
    player.gold=player.gold-1
    if entry.raw:sub(1,1)=='I' then
        -- Blizzard's InitNeutralBuildings registers this removal before project
        -- triggers. Dynamic items would vanish for later players without repair.
        RemoveItemFromStock(shop,entry.raw)
        emit('sellItem',Player(27),shop,nil,nil,{kind=entry.raw})
    end
    return {kind=entry.raw,owner=player}
end
local function replenish(entry)
    local shop=_G[entry.shop]
    local state=shop.stockState and shop.stockState[entry.raw]
    if state and now>=state.readyAt and shop.stock[entry.raw]~=nil then
        shop.stock[entry.raw]=math.min(shop.maximum[entry.raw],shop.stock[entry.raw]+1)
    end
end

-- Both public command forms, all playable slots, and each phase boundary.
-- Test real purchases rather than just checking a Lua table says stock=1.
for slot=0,FE_Roles.playerSlotCount-1 do
    for _,command in ipairs({'-skip','-test skip'}) do
        for _,at in ipairs({0,0.5,5,19.999,20,25,59.999,60,200}) do
            reset({slot});advance(at);local p=Player(slot)
            emit('chat',p,nil,command)
            check(FE_Test.skipped,'skip command accepted in every playable solo slot')
            check(p.tech.RFPK==1 and p.tech.RFPA==1,'both phase prerequisites unlocked')
            for _,entry in ipairs(FE_TestData.pickers) do
                check(tryPurchase(entry,p)~=nil,'immediate skip purchase: '..entry.raw)
            end
            for _,entry in pairs(FE_Factions.randomStock) do
                check(tryPurchase(entry,p)~=nil,'immediate random purchase after skip: '..entry.raw)
            end
            local calls=#stockCalls
            emit('chat',p,nil,command)
            FE_Factions.showStock();FE_Factions.unlockPicking();FE_Factions.unlockAncients()
            check(#stockCalls==calls,'repeated skip/unlock makes no native stock calls')
            for _,entry in ipairs(FE_TestData.pickers) do
                check(tryPurchase(entry,p)==nil,'repeated skip does not refill consumed stock')
            end
            advance(at+0.999)
            check(tryPurchase(FE_Factions.byKey.Worgen,p)==nil,'Worgen respects ordinary refill interval')
            advance(at+1)
            for _,entry in ipairs(FE_TestData.pickers) do
                check(tryPurchase(entry,p)~=nil,'normal one-second refill: '..entry.raw)
            end
        end
    end
end

-- A first skip issued after a normal purchase must not reset an already open
-- phase. The old post-unlock loop refreshed the consumed choice immediately.
reset({0});advance(20)
check(tryPurchase(FE_Factions.byKey.Worgen,Player(0))~=nil,'normal timed Worgen purchase')
emit('chat',Player(0),nil,'-skip')
check(tryPurchase(FE_Factions.byKey.Worgen,Player(0))==nil,'late first skip preserves consumed expander stock')
advance(21);check(tryPurchase(FE_Factions.byKey.Worgen,Player(0))~=nil,'late skip preserves native refill timer')

-- Stock repair is scoped to a live placed selector's open Random entry. It may
-- never restore unrelated shop items, unlock previews or touch a removed shop.
reset({0})
emit('sellItem',Player(27),gg_unit_nmer_0000,nil,nil,{kind='I00W'})
emit('sellItem',Player(27),gg_unit_nmer_0000,nil,nil,{kind='I00W',removed=true})
check(#stockCalls==0,'stock repair cannot open an uninitialized phase')
advance(0);local calls=#stockCalls
emit('sellItem',Player(27),gg_unit_nmer_0000,nil,nil,{kind='I00W'})
emit('sellItem',Player(27),gg_unit_nmer_0000,nil,nil,{kind='I00W',removed=true})
check(#stockCalls==calls,'stock repair cannot open a preview')
advance(20);calls=#stockCalls
emit('sellItem',Player(27),gg_unit_nmer_0000,nil,nil,{kind='I000'})
emit('sellItem',Player(27),{kind='nmer'},nil,nil,{kind='I00W'})
emit('sellItem',Player(27),{kind='nmer'},nil,nil,{kind='I00W',removed=true})
emit('sellItem',Player(27),gg_unit_nmr2_0001,nil,nil,{kind='I00X'})
emit('sellItem',Player(27),gg_unit_nmr2_0001,nil,nil,{kind='I00X',removed=true})
check(#stockCalls==calls,'unrelated sales and locked Ancient phase untouched')
advance(60);calls=#stockCalls;gg_unit_nmr2_0001.kind=0
emit('sellItem',Player(27),gg_unit_nmr2_0001,nil,nil,{kind='I00X'})
emit('sellItem',Player(27),gg_unit_nmr2_0001,nil,nil,{kind='I00X',removed=true})
check(#stockCalls==calls,'removed Ancient selector is never restocked')

for _,slot in ipairs({FE_Roles.initialAncientSlot,0}) do
    for _,skipAt in ipairs({0,5,25}) do
        reset({slot});local p=Player(slot)
        check(FE_Test.player==p,'solo enabled in either role')
        advance(skipAt);emit('chat',p,nil,'-test skip')
        check(FE_Test.skipped,'registered skip callback reached')
        check(p.tech.RFPK==1 and p.tech.RFPA==1,'skip unlocks both native prerequisites')
        for _,entry in ipairs(FE_TestData.pickers) do check(_G[entry.shop].stock[entry.raw]==1,'all picks unlocked') end
        for _,dialog in ipairs(dialogs) do check(not dialog.visible,'active picking timers hidden') end
        -- Re-enabling the result trigger at 65 seconds must not restore victory.
        DisableTrigger(gg_trg_Extermination);advance(200)
        check(not gg_trg_Extermination.disabled,'real Ext_On fired')
        for _,entry in ipairs(FE_TestData.pickers) do check(_G[entry.shop].stock[entry.raw]==1,'later stock triggers cannot undo skip') end
        check(#FE_Test.countdowns==0,'suspended countdown callbacks release their handles')
        for _,entry in ipairs(FE_TestData.pickers) do
            if entry.raw:sub(1,1)=='O' then emit('death',Player(FE_Roles.initialAncientSlot),{kind=entry.raw,owner=Player(FE_Roles.initialAncientSlot)}) end
        end
        emit('level',Player(FE_Roles.initialAncientSlot),{kind='O004',owner=Player(FE_Roles.initialAncientSlot),level=20})
        emit('leave',Player(FE_Roles.initialAncientSlot))
        FE_Roles.finishMatch(false,'test');FE_Roles.otherPlayersWin()
        advance(400)
        check(#announcements==0 and #results==0,'no result announcements/countdowns/endgame during solo testing')
        local found=false
        for _,text in ipairs(banners) do if text:find(FE_TestData.releaseLabel..': SOLO TEST MODE ON',1,true) then found=true end end
        check(found,'opening banner identifies release and solo mode')
        emit('chat',p,nil,'-gold 10000');check(p.gold==10000,'commands still work after startup and result events')
    end
end

reset({0,FE_Roles.initialAncientSlot})
advance(0)
for _,at in ipairs({0,1,10,19,19.999}) do
    advance(at)
    for _,entry in pairs(FE_Factions.randomStock) do
        local shop=_G[entry.shop]
        check(shop.stock[entry.raw]==0 and shop.maximum[entry.raw]==0,'random preview is visible but empty')
        replenish(entry)
        check(tryPurchase(entry,Player(0))==nil,'random preview cannot bypass ban phase')
    end
    for _,entry in ipairs(FE_TestData.pickers) do
        local shop=_G[entry.shop]
        check((entry.raw=='h063' and shop.stock[entry.raw]==nil) or
              (entry.raw~='h063' and shop.stock[entry.raw]~=nil),'only eligible choices visible before unlock')
        replenish(entry)
        for _,slot in ipairs({0,FE_Roles.initialAncientSlot}) do
            local p=Player(slot);local before=p.gold
            check(tryPurchase(entry,p)==nil and p.gold==before,'early click cannot spawn a unit or spend gold')
        end
    end
end
check(not Player(0).tech or not Player(0).tech.RFPK,'ordinary picking locked before cutoff')
check(not dialogs[1].destroyed and dialogs[1].timer.expires==20,'countdown remains through 19.999 seconds')
advance(20)
check(Player(0).tech.RFPK==1 and not Player(FE_Roles.initialAncientSlot).tech.RFPA,'expander unlock preserves Ancient wait')
check(tryPurchase(FE_Factions.randomStock.expanders,Player(0))~=nil,'Random Expander opens at the same cutoff')
check(tryPurchase(FE_Factions.randomStock.expanders,Player(FE_Roles.initialAncientSlot))~=nil,'Random Expander remains available after native sale removal')
check(tryPurchase(FE_Factions.randomStock.ancients,Player(FE_Roles.initialAncientSlot))==nil,'Random Ancient still waits at expander cutoff')
for _,entry in ipairs(FE_Factions.expanders) do
    local bought=tryPurchase(entry,Player(0))
    check(entry.raw=='h063' and bought==nil or entry.raw~='h063' and bought~=nil,'only multiplayer races can be picked at cutoff')
end
check(dialogs[1].destroyed,'expander countdown removed at unlock')
advance(59.999)
check(tryPurchase(FE_Factions.randomStock.ancients,Player(FE_Roles.initialAncientSlot))==nil,'Random Ancient cannot bypass final wait')
for _,entry in ipairs(FE_Factions.ancients) do
    replenish(entry);check(tryPurchase(entry,Player(FE_Roles.initialAncientSlot))==nil,'Ancient cannot buy before 60 seconds')
end
advance(60)
check(Player(FE_Roles.initialAncientSlot).tech.RFPA==1,'Ancient unlock at original spawn deadline')
check(tryPurchase(FE_Factions.randomStock.ancients,Player(FE_Roles.initialAncientSlot))~=nil,'Random Ancient opens at the same cutoff')
for _,entry in ipairs(FE_Factions.ancients) do check(tryPurchase(entry,Player(FE_Roles.initialAncientSlot))~=nil,'Ancient can be picked at cutoff') end

-- Ban one choice on each selector, then use either normal timers or real solo
-- skip. Neither path may restore a banned choice, even if invoked repeatedly.
for _,skip in ipairs({false,true}) do
    reset({0});advance(5)
    for _,key in ipairs({'Worgen','Cultist','AncientFire'}) do FE_Factions.ban(key) end
    check(udg_Bans==0,'each valid ban consumes exactly one ban')
    FE_Factions.ban('Cultist');check(udg_Bans==0,'duplicate ban cannot consume another ban')
    if skip then emit('chat',Player(0),nil,'-test skip') else advance(60) end
    for _,key in ipairs({'Worgen','Cultist','AncientFire'}) do
        local entry=FE_Factions.byKey[key]
        check(_G[entry.shop].stock[entry.raw]==nil,'banned choice stays absent after unlock')
        check(tryPurchase(entry,Player(0))==nil,'banned choice cannot be bought')
    end
    for _,entry in ipairs(FE_TestData.pickers) do
        if _G[entry.ban]==0 then check(_G[entry.shop].stock[entry.raw]==1,'unbanned choice opens normally') end
    end
    local entry=FE_Factions.byKey.Human
    check(tryPurchase(entry,Player(0))~=nil,'consume an open choice')
    FE_Factions.showStock();FE_Factions.unlockPicking();FE_Factions.unlockAncients()
    check(_G[entry.shop].stock[entry.raw]==0,'repeated unlock cannot replenish a consumed choice')
    FE_Factions.ban('Human');check(udg_BannedHuman==0,'late ban cannot remove a valid choice')
end

-- Exhaustive catalog coverage: every ban, on every selector, survives both
-- scheduled unlocks and the sandbox shortcut without removing its neighbors.
for _,skip in ipairs({false,true}) do
    for _,key in ipairs(FE_Factions.banOrder) do
        reset({0});advance(5)
        FE_Factions.ban(key)
        if skip then emit('chat',Player(0),nil,'-test skip') else advance(60) end
        for _,entry in ipairs(FE_TestData.pickers) do
            local stock=_G[entry.shop].stock[entry.raw]
            local banned = entry.raw==FE_Factions.byKey[key].raw
            check(banned and stock==nil or not banned and stock==1,
                'ban/unlock preserves exact catalog membership: '..key..' / '..entry.raw)
        end
    end
end

-- Cultist is a solo test choice, including normal timed picks; it is never
-- unlocked by a multiplayer departure, a chat command or repeated stock calls.
reset({0});advance(0)
local cultist=FE_Factions.byKey.Cultist
check(_G[cultist.shop].stock.h063==0,'solo Cultist visible before cutoff')
advance(19.999);check(tryPurchase(cultist,Player(0))==nil,'solo Cultist still observes ban phase')
advance(20);check(tryPurchase(cultist,Player(0))~=nil,'solo Cultist opens on normal timer')
reset({0,FE_Roles.initialAncientSlot});advance(0)
FE_Factions.ban('Cultist')
check(udg_Bans==3 and udg_BannedCultist==0,'unavailable multiplayer Cultist does not consume a ban')
check(_G[cultist.shop].stock.h063==nil,'multiplayer Cultist has no preview stock')
emit('chat',Player(0),nil,'-test skip');advance(60)
check(not FE_Test.skipped and _G[cultist.shop].stock.h063==nil,'multiplayer skip cannot expose Cultist')
Player(0).state='left';emit('chat',Player(FE_Roles.initialAncientSlot),nil,'-test skip')
FE_Factions.showStock();FE_Factions.unlockPicking();FE_Factions.unlockAncients()
check(not FE_Test.player and _G[cultist.shop].stock.h063==nil,'departures cannot unlock solo-only race')
check(tryPurchase(cultist,Player(FE_Roles.initialAncientSlot))==nil,'remaining multiplayer human cannot buy Cultist')

reset({0,FE_Roles.initialAncientSlot})
check(not FE_Test.player,'two humans keep normal match behavior')
local ancient={kind='O004',owner=Player(FE_Roles.initialAncientSlot)}
emit('sell',Player(FE_Roles.initialAncientSlot),{kind='shop'},nil,ancient)
check(not ancient.dead and #announcements==0,'mercenary purchase does not kill Ancient or start victory')
local selector={kind='ewsp',owner=Player(FE_Roles.initialAncientSlot)}
emit('sell',Player(FE_Roles.initialAncientSlot),{kind='shop'},nil,selector)
check(selector.dead and #announcements==0,'selection purchase removes only the selector')
emit('death',Player(FE_Roles.initialAncientSlot),ancient)
check(#announcements==1,'normal multiplayer Ancient death still announces result')
-- Keep unrelated timers out of this case; directly resume only the death waits.
queue={};FE_Roles.finishMatch(false,'test')
check(#results==11,'normal match assigns results to every participant')
Player(0).state='left';emit('chat',Player(FE_Roles.initialAncientSlot),nil,'-gold 10000')
check(Player(FE_Roles.initialAncientSlot).gold==0 and not FE_Test.player,'leaving multiplayer never unlocks cheats')
print('Solo startup integration passed: '..checks..' assertions; real bootstrap/picking/result callbacks, simulated 400 seconds, both roles and multiplayer gate')
