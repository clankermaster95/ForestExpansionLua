-- Solo sandbox. Eligibility is captured once, before match initialization.
-- Selection comes from synchronized selection events, never a local UI query.
FE_Test = {initialized=false, player=nil, selected=nil, vision=nil, skipped=false, countdowns={}}
FE_Test.resultTriggers = {
    'gg_trg_Ancient_Leaves', 'gg_trg_Ignite_Dies', 'gg_trg_Avalanche_Dies',
    'gg_trg_Paranoia_Dies', 'gg_trg_Eternity_Dies', 'gg_trg_Dragos_Dies',
    'gg_trg_Tremor_Dies', 'gg_trg_Zalxon_Dies', 'gg_trg_Divinity_Dies',
    'gg_trg_Pharoah_Dies', 'gg_trg_Nebula_Dies', 'gg_trg_Wispari_Dies',
    'gg_trg_DVIC_1', 'gg_trg_Extermination'
}

local function say(player, text)
    DisplayTextToPlayer(player, 0, 0, '|cff80d4ff[Test]|r '..text)
end

local function onlyHuman()
    local result
    for slot=0,bj_MAX_PLAYER_SLOTS-1 do
        local player=Player(slot)
        if GetPlayerController(player)==MAP_CONTROL_USER and GetPlayerSlotState(player)==PLAYER_SLOT_STATE_PLAYING then
            if result then return nil end
            result=player
        end
    end
    return result
end

function FE_Test.allowed(player)
    return player~=nil and player==FE_Test.player and onlyHuman()==player
end

function FE_Test.matchResultsEnabled()
    return FE_Test.player == nil
end

function FE_Test.suppressMatchResults()
    if not FE_Test.player then return end
    for _,name in ipairs(FE_Test.resultTriggers) do
        local trigger=assert(_G[name], 'Missing match-result trigger: '..name)
        -- A condition remains effective even if another startup trigger later
        -- enables the trigger. Block announcements as well as final results.
        TriggerAddCondition(trigger,Condition(FE_Test.matchResultsEnabled))
    end
end

local function target(player, dead)
    local unit=FE_Test.selected
    if not unit then unit=udg_AncientUnit end
    if unit and GetUnitTypeId(unit)~=0 and GetOwningPlayer(unit)==player and
       (dead or GetWidgetLife(unit)>0.405) then return unit end
    return nil
end

local function integer(text, low, high)
    if not text or not text:match('^\x25-?\x25d+$') then return nil end
    local value=tonumber(text)
    if value and value>=low and value<=high then return math.floor(value) end
end

local aliases={unit='spawn', lvl='level', mh='reveal', nomh='hide', cd='cooldown', cheats='help'}

function FE_Test.releaseCountdown(dialog)
    for i=#FE_Test.countdowns,1,-1 do
        if FE_Test.countdowns[i].dialog==dialog then table.remove(FE_Test.countdowns,i); return end
    end
end

function FE_Test.skipPicking(player)
    if not FE_Test.allowed(player) then return end
    if FE_Test.skipped then say(player,'Picking wait already skipped.'); return end
    FE_Test.skipped=true
    FE_Factions.showStock()
    FE_Factions.unlockPicking()
    FE_Factions.unlockAncients()
    for _,trigger in ipairs({gg_trg_Spawn_Races,gg_trg_Spawn_Ancients,gg_trg_TimeToExpanderSpawn,gg_trg_TimeToAncientSpawn}) do
        DisableTrigger(trigger)
    end
    for _,countdown in ipairs(FE_Test.countdowns) do
        PauseTimer(countdown.timer); TimerDialogDisplay(countdown.dialog,false)
    end
    for _,entry in ipairs(FE_TestData.pickers) do
        local shop=_G[entry.shop]
        if shop and GetUnitTypeId(shop)~=0 and _G[entry.ban]==0 and FE_Factions.available(entry) then
            RemoveUnitFromStock(shop,FourCC(entry.raw))
            AddUnitToStock(shop,FourCC(entry.raw),1,1)
        end
    end
    say(player,'Picking unlocked. Choose your hero or race normally. The match clock still runs normally.')
end

local function showHelp(player, args, command)
    say(player,'Solo test mode ('..FE_TestData.releaseLabel..'). Victory/defeat countdowns are disabled. Use -test <command>.')
    say(player,'skip: unlock hero/race picking immediately. Full command lists are in the separate DEBUG_REFERENCE.md document.')
    say(player,'gold/lumber <amount>: add resources; xp <amount>: add XP; level <1-20>: set level.')
    say(player,'find <name>, items [page] [name], units [page] [name] list IDs in chat.')
    say(player,'spawn <unit ID> [1-20]; item <item ID> [1-6]. Example: -item I001 creates Helm of Devotion.')
    say(player,'heal, mana, cooldown, invul, vul, revive, kill, destroy, copy [1-20], unitid, itemid, loc.')
    say(player,'reveal, hide, speed <0-522>, time <0-24>, shop. Unit commands affect your last selected owned unit.')
    return
end

local function changeResources(player, args, command)
    local amount=integer(args[2],-1000000,1000000)
    if not amount then say(player,'Usage: -test '..command..' <amount, -1000000 to 1000000>'); return end
    local state=command=='gold' and PLAYER_STATE_RESOURCE_GOLD or PLAYER_STATE_RESOURCE_LUMBER
    local value=math.max(0,math.min(1000000,GetPlayerState(player,state)+amount))
    SetPlayerState(player,state,value); say(player,command..': '..value); return
end

local function listCatalog(player, args, command)
    local page=integer(args[2],1,10000)
    local query=string.lower(table.concat(args,' ',page and 3 or 2)); local found=0
    page=page or 1
    if command=='find' and #query<2 then say(player,'Usage: -test find <at least 2 letters of a name or ID>'); return end
    for _,entry in ipairs(FE_TestData.catalog) do
        if (command=='find' or command==entry.kind) and string.find(string.lower(entry.name..' '..entry.raw),query,1,true) then
            found=found+1
            if found>(page-1)*12 and found<=page*12 then say(player,entry.raw..' ['..entry.kind..'] '..entry.name) end
        end
    end
    say(player,found..' matches; page '..page..'/'..math.max(1,math.ceil(found/12))..'. IDs are case-sensitive.')
    if found>page*12 then say(player,'Next: -test '..command..' '..(page+1)..' '..query) end
    return
end

local function setVision(player, args, command)
    if FE_Test.vision then
        FogModifierStop(FE_Test.vision); DestroyFogModifier(FE_Test.vision); FE_Test.vision=nil
    end
    if command=='reveal' then
        FE_Test.vision=CreateFogModifierRect(player,FOG_OF_WAR_VISIBLE,bj_mapInitialPlayableArea,true,false)
        FogModifierStart(FE_Test.vision)
    end
    say(player,command=='reveal' and 'Map revealed.' or 'Map reveal disabled.'); return
end

local function setTime(player, args, command)
    local hour=integer(args[2],0,24)
    if hour then SetTimeOfDay(hour) else say(player,'Usage: -test time <0-24>') end
    return
end

local function showShopStatus(player, args, command)
    if args[2]=='on' then FE_Shops.traceEnabled=true
    elseif args[2]=='off' then FE_Shops.traceEnabled=false end
    local d=FE_Recipes.diagnostics
    say(player,'Shop trace '..(FE_Shops.traceEnabled and 'ON' or 'OFF')..' (-test shop on/off). All shop sales: '..FE_Shops.diagnostics.sales..
        '; ordinary items delivered: '..FE_Shops.diagnostics.delivered..'; left on ground: '..FE_Shops.diagnostics.ground)
    say(player,FE_Shops.diagnostics.last)
    say(player,'Recipes initialized: '..tostring(FE_Recipes.initialized)..'; recipe sales: '..d.sales..
        '; completed: '..d.completed..'; refunded: '..d.refunded..'; last: '..d.last)
    say(player,'Ancient owner: '..tostring(FE_Roles.isAncient(player))..'; cached hero owned: '..
        tostring(udg_AncientUnit~=nil and GetOwningPlayer(udg_AncientUnit)==player))
    for _,shop in ipairs(FE_Shops.shops) do say(player,FE_Shops.describe(shop)) end
    return
end

local function createObjects(player, args, command, unit)
    local raw=args[2]; local catalog=command=='spawn' and FE_TestData.units or FE_TestData.items
    local count=integer(args[3] or '1',1,command=='spawn' and 20 or 6)
    if not raw or not catalog[raw] or not count then
        say(player,'Usage: -test '..command..' <map object ID> [count]. Use -test find <name>.'); return
    end
    local start=GetPlayerStartLocation(player)
    local x=unit and GetUnitX(unit) or GetStartLocationX(start)
    local y=unit and GetUnitY(unit) or GetStartLocationY(start)
    for index=1,count do
        local offset=64*(math.fmod(index-1,5)+1)
        if command=='spawn' then CreateUnit(player,FourCC(raw),x+offset,y+64*((index-1)//5),270)
        else CreateItem(FourCC(raw),x+offset,y) end
    end
    say(player,'Created '..count..' '..raw..' nearby. Spawned heroes do not change match roles.'); return
end

-- Unit handlers return true only when the common applied message is needed.
local function changeHeroProgress(player, args, command, unit)
    local amount=integer(args[2],command=='level' and 1 or 0,command=='level' and 20 or 1000000)
    if not amount or not IsUnitType(unit,UNIT_TYPE_HERO) then say(player,'Select an owned hero and supply a valid '..command..' amount.'); return false end
    if command=='xp' then AddHeroXP(unit,amount,false)
    elseif amount<GetHeroLevel(unit) then UnitStripHeroLevel(unit,GetHeroLevel(unit)-amount)
    else SetHeroLevel(unit,amount,false) end
    return true
end

local function restoreUnit(player, args, command, unit)
    if command=='heal' then SetWidgetLife(unit,GetUnitState(unit,UNIT_STATE_MAX_LIFE)) end
    SetUnitState(unit,UNIT_STATE_MANA,GetUnitState(unit,UNIT_STATE_MAX_MANA))
    return true
end

local function resetCooldown(player, args, command, unit)
    UnitResetCooldown(unit)
    return true
end

local function setProtection(player, args, command, unit)
    SetUnitInvulnerable(unit,command=='invul')
    return true
end

local function killUnit(player, args, command, unit)
    KillUnit(unit)
    return true
end

local function removeUnit(player, args, command, unit)
    RemoveUnit(unit); FE_Test.selected=nil
    return true
end

local function reviveUnit(player, args, command, unit)
    if IsUnitType(unit,UNIT_TYPE_HERO) then ReviveHero(unit,GetUnitX(unit),GetUnitY(unit),true) end
    return true
end

local function setSpeed(player, args, command, unit)
    local speed=integer(args[2],0,522)
    if not speed then say(player,'Usage: -test speed <0-522>'); return false end
    SetUnitMoveSpeed(unit,speed)
    return true
end

local function copyUnit(player, args, command, unit)
    local count=integer(args[2] or '1',1,20)
    if not count then say(player,'Usage: -test copy <1-20>'); return false end
    for index=1,count do CreateUnit(player,GetUnitTypeId(unit),GetUnitX(unit)+64*index,GetUnitY(unit),GetUnitFacing(unit)) end
    return true
end

local function showObjectId(player, args, command, unit)
    local raw=GetUnitTypeId(unit)
    if command=='itemid' then raw=GetItemTypeId(UnitItemInSlot(unit,0)) end
    for _,entry in ipairs(FE_TestData.catalog) do
        if FourCC(entry.raw)==raw then say(player,entry.raw..' '..entry.name); return end
    end
    say(player,'No matching map object in that slot.')
end

local function showLocation(player, args, command, unit)
    say(player,tostring(GetUnitX(unit))..', '..tostring(GetUnitY(unit)))
end

local playerCommands = {
    skip=function(player) FE_Test.skipPicking(player) end,
    help=showHelp, gold=changeResources, lumber=changeResources,
    find=listCatalog, items=listCatalog, units=listCatalog, reveal=setVision, hide=setVision,
    time=setTime, shop=showShopStatus,
}
local unitCommands = {
    xp=changeHeroProgress, level=changeHeroProgress, heal=restoreUnit, mana=restoreUnit,
    cooldown=resetCooldown, invul=setProtection, vul=setProtection, kill=killUnit,
    destroy=removeUnit, revive=reviveUnit, speed=setSpeed, copy=copyUnit,
    unitid=showObjectId, itemid=showObjectId, loc=showLocation,
}

function FE_Test.run(player, text)
    if not FE_Test.allowed(player) then return end
    local args={}
    for word in text:gmatch('\x25S+') do args[#args+1]=word end
    local command=string.lower(args[1] or '')
    if command=='-test' then table.remove(args,1); command=string.lower(args[1] or 'help')
    else command=command:gsub('^\x25-','') end
    command=aliases[command] or command
    local handler=playerCommands[command]
    if handler then handler(player,args,command); return end
    -- Preserve the original target check even for unknown commands and spawns.
    local unit=target(player,command=='revive')
    if command=='spawn' or command=='item' then createObjects(player,args,command,unit); return end
    if not unit then say(player,'Select one of your own units first.'); return end
    handler=unitCommands[command]
    if not handler then say(player,'Unknown command. Use -test help.'); return end
    if handler(player,args,command,unit) then say(player,command..' applied.') end
end

function FE_Test.init()
    if FE_Test.initialized then return end
    FE_Test.initialized=true; FE_Test.player=onlyHuman()
    if not FE_Test.player then return end
    local player=FE_Test.player
    FE_Shops.initDebug(player)
    FE_Test.suppressMatchResults()
    local chat,selected=CreateTrigger(),CreateTrigger()
    TriggerRegisterPlayerChatEvent(chat,player,'-',false)
    TriggerAddAction(chat,function()
        local text=GetEventPlayerChatString()
        local first=string.lower(text:match('^(\x25S+)') or '')
        -- Avoid interpreting the map's unrelated existing chat commands.
        local short={'gold','lumber','xp','lvl','unit','spawn','item','heal','mana','invul','vul','mh','nomh','cheats','skip'}
        local accept=first=='-test'
        for _,name in ipairs(short) do if first=='-'..name then accept=true end end
        if accept then FE_Test.run(GetTriggerPlayer(),text) end
    end)
    TriggerRegisterPlayerUnitEventSimple(selected,player,EVENT_PLAYER_UNIT_SELECTED)
    TriggerAddAction(selected,function()
        if not FE_Test.allowed(GetTriggerPlayer()) then return end
        local unit=GetTriggerUnit()
        if GetOwningPlayer(unit)==player then FE_Test.selected=unit end
    end)
    local timer=CreateTimer()
    TimerStart(timer,1,false,function()
        DestroyTimer(timer); say(player,'Forest Expansion '..FE_TestData.releaseLabel..': SOLO TEST MODE ON. Victory timers OFF. Type -test skip or -test help.')
    end)
end
