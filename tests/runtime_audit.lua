-- Exercise real event registration, event-specific native contexts and native
-- handle ownership. Run against another source root to verify regression proof.
local root = arg[1] or "."
local checks, failures = 0, {}
local world, triggers, event, enumUnit, counts
local function check(value, message) assert(value, message); checks = checks + 1 end
function FourCC(value) return value end
function __jreal(value) return value end
function __jint(value) return value end
function Condition(callback) return callback end
function GetConvertedPlayerId(player) return player.id + 1 end
function GetOwningPlayer(unit) assert(unit, "missing unit in event context"); return unit.owner end
function GetUnitTypeId(unit) return unit and not unit.removed and unit.kind or 0 end
function RemoveUnit(unit)
    counts.removals = (counts.removals or 0) + 1
    unit.removed=true
    return "removed"
end
function GetUnitX(unit) return unit.x end
function GetUnitY(unit) return unit.y end
function GetWidgetLife(unit) return unit.life end
function IsUnitType(unit, kind)
    if not unit then return false end
    if kind == UNIT_TYPE_DEAD then return unit.dead end
    if kind == UNIT_TYPE_MELEE_ATTACKER then return unit.melee == true end
    return false
end
function UnitHasItemOfTypeBJ(unit, raw) return unit.items and unit.items[raw] == true end
function IsUnitEnemy(unit, owner) return unit.owner ~= owner end
function IsPlayerAlly(player, other) return player == other end
function GetPlayerTechCountSimple(raw, player) return player.research and player.research[raw] or 0 end
function BlzGetUnitMaxMana(unit) return unit.maxMana or 0 end
function GetUnitStateSwap(state, unit) return unit[state] or 0 end
function SetUnitManaBJ(unit, amount) unit.mana=math.min(amount, unit.maxMana or 0) end
function GetTriggerUnit() return event.unit end
function GetTriggerPlayer() return event.unit.owner end
function GetAttacker() return event.attacker end
function GetResearchingUnit() assert(event.kind == "research", "research context used outside research event"); return event.unit end
function GetEnteringUnit() assert(event.kind == "enter", "enter context used outside enter event"); return event.unit end
function GetConstructedStructure() assert(event.kind == "construct", "construction context used outside construction event"); return event.unit end
function GetResearched() assert(event.kind == "research"); return event.research end
function GetSpellAbilityUnit() assert(event.kind == "spell_finish"); return event.unit end
function GetSpellAbilityId() return event.research end
function GetIssuedOrderIdBJ() assert(event.kind == "target_order"); return event.research end
function String2OrderIdBJ(value) return value end
function GetPlayerState(player, resource) return player[resource] or 0 end
function SetPlayerStateBJ(player, resource, amount) player[resource]=amount end
function GetEventDamageSource() error("native damage context used by a Damage Engine variable callback") end
function GetEnumUnit() return enumUnit end
function GetPlayableMapRect() return {} end
function CreateTrigger() local trigger = {events={}, conditions={}, actions={}}; triggers[#triggers+1] = trigger; return trigger end
function TriggerAddCondition(trigger, callback) trigger.conditions[#trigger.conditions+1] = callback end
function TriggerAddAction(trigger, callback) trigger.actions[#trigger.actions+1] = callback end
function TriggerRegisterAnyUnitEventBJ(trigger, kind) trigger.events[#trigger.events+1] = kind end
function TriggerRegisterPlayerUnitEventSimple(trigger, player, kind) trigger.events[#trigger.events+1] = {kind=kind,player=player} end
function TriggerRegisterPlayerChatEvent(trigger, player) TriggerRegisterPlayerUnitEventSimple(trigger,player,"chat") end
function DisableTrigger(trigger) trigger.disabled=true end
function EnableTrigger(trigger) trigger.disabled=false end
function TriggerRegisterEnterRectSimple(trigger) TriggerRegisterAnyUnitEventBJ(trigger, "enter") end
function TriggerRegisterTimerEventPeriodic(trigger) TriggerRegisterAnyUnitEventBJ(trigger, "tick") end
function h__TriggerRegisterVariableEvent(trigger, name) TriggerRegisterAnyUnitEventBJ(trigger, name) end
local function emit(kind, unit, research, attacker)
    event = {kind=kind, unit=unit, research=research, attacker=attacker}
    for _, trigger in ipairs(triggers) do
        for _, registered in ipairs(trigger.events) do
            local matches = registered == kind or (type(registered) == "table" and registered.kind == kind and registered.player == unit.owner)
            if matches and not trigger.disabled then
                local passed = true
                for _, condition in ipairs(trigger.conditions) do if not condition() then passed = false; break end end
                if passed then for _, action in ipairs(trigger.actions) do action() end end
            end
        end
    end
end
function CreateGroup() counts.groups = counts.groups + 1; return {} end
function DestroyGroup(group) assert(not group.destroyed, "group destroyed twice"); group.destroyed=true; counts.groups=counts.groups-1 end
function IsUnitInGroup(unit, group) for _, member in ipairs(group) do if member == unit then return true end end; return false end
function GroupAddUnitSimple(unit, group) if not IsUnitInGroup(unit, group) then group[#group+1] = unit end end
function GroupRemoveUnit(group, unit) for i, member in ipairs(group) do if member == unit then table.remove(group, i); return end end end
function GroupRemoveUnitSimple(unit, group) GroupRemoveUnit(group, unit) end
function FirstOfGroup(group) return group[1] end
function ForGroupBJ(group, callback)
    local snapshot = {}; for _, unit in ipairs(group) do snapshot[#snapshot+1] = unit end
    for _, unit in ipairs(snapshot) do enumUnit = unit; callback() end
    enumUnit = nil
end
function GetUnitsOfPlayerAndTypeId(player, kind)
    local group = CreateGroup()
    for _, unit in ipairs(world) do if unit.owner == player and unit.kind == kind and not unit.removed then group[#group+1] = unit end end
    return group
end
function GroupEnumUnitsInRange(group, x, y, radius)
    for _, unit in ipairs(world) do
        if not unit.removed and (unit.x-x)^2+(unit.y-y)^2 <= radius^2 then GroupAddUnitSimple(unit, group) end
    end
end
function UnitAddAbilityBJ(raw, unit) unit.abilities[raw] = unit.abilities[raw] or 1 end
function UnitRemoveAbilityBJ(raw, unit) unit.abilities[raw] = nil end
function SetUnitAbilityLevelSwapped(raw, unit, level) unit.abilities[raw] = level end
function IncUnitAbilityLevelSwapped(raw, unit) if unit.abilities[raw] then unit.abilities[raw]=unit.abilities[raw]+1 end end
function GetUnitAbilityLevel(unit, raw) return unit.abilities[raw] or 0 end
function SetUnitAbilityLevel(unit, raw, level) unit.abilities[raw]=level end
function UnitHasBuffBJ(unit, raw) return unit.buffs[raw] == true end
function AdjustPlayerStateBJ(amount, player, resource) player[resource] = (player[resource] or 0) + amount end
function AddSpecialEffect(path, x, y) counts.effects=counts.effects+1; return {path=path,x=x,y=y} end
function DestroyEffect(effect) assert(not effect.destroyed); effect.destroyed=true; counts.effects=counts.effects-1 end
function GetUnitLoc() error("tree-hit callback allocates an unreleased location") end
local lastTag
function CreateTextTagUnitBJ(text, unit) assert(unit); lastTag={text=text,unit=unit} end
function GetLastCreatedTextTag() return lastTag end
function SetTextTagPermanentBJ(tag, permanent) tag.permanent=permanent end
function SetTextTagLifespanBJ(tag, duration) tag.duration=duration end
function SetTextTagVelocityBJ() end
function SetTextTagFadepointBJ() end
function CreateItem(raw, x, y) return {kind=raw,x=x,y=y} end
function IssueTargetItemOrder(unit, order, item) unit.lastOrder={order=order,item=item} end
EVENT_PLAYER_UNIT_RESEARCH_FINISH = "research"
EVENT_PLAYER_UNIT_CONSTRUCT_FINISH = "construct"
EVENT_PLAYER_UNIT_UPGRADE_FINISH = "upgrade"
EVENT_PLAYER_UNIT_DEATH = "death"
EVENT_PLAYER_UNIT_SPELL_FINISH = "spell_finish"
EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER = "target_order"
EVENT_PLAYER_UNIT_ATTACKED = "attacked"
UNIT_TYPE_DEAD = "dead"
UNIT_TYPE_MELEE_ATTACKER = "melee"
UNIT_STATE_MANA = "mana"
PLAYER_STATE_RESOURCE_GOLD = "gold"
PLAYER_STATE_RESOURCE_LUMBER = "lumber"
EQUAL = "equal"
local function unit(kind, owner, x, y)
    local value = {kind=kind, owner=owner, x=x or 0, y=y or 0, life=100, dead=false, abilities={}, buffs={}}
    world[#world+1] = value; return value
end
local function reset()
    world, triggers, counts = {}, {}, {groups=0, effects=0}
    udg_SilentStrider, udg_DeepWater1 = {}, {}
    udg_Ziggurats, udg_Ziggurats_Count, udg_Acided = {}, 0, {}
    return {id=0,gold=0}, {id=1,gold=0}
end
local function test(name, callback)
    local ok, message = pcall(callback)
    if not ok then failures[#failures+1] = name .. ": " .. tostring(message) end
end
dofile(root .. "/src/races/ratling.lua")
dofile(root .. "/src/races/night_elf.lua")
dofile(root .. "/src/races/nerubian.lua")
dofile(root .. "/src/economy/income.lua")
dofile(root .. "/src/items/mech_blaster.lua")
dofile(root .. "/src/races/bounty_hunter.lua")
dofile(root .. "/src/races/worgen.lua")
dofile(root .. "/src/races/night_elf/shadow_dancer.lua")

test("corrosion lifetime", function()
    local player = reset(); InitTrig_ReduceMagicResist(); InitTrig_ReduceMagicResist2()
    local target = unit("target", player); target.buffs.B03O = true
    udg_DamageEventTarget=target; emit("udg_DamageEvent")
    check(target.abilities.A0CT == 1 and #udg_Acided == 1, "corrosion must apply on damage")
    for _=1,20 do emit("tick") end
    check(target.abilities.A0CT == 1 and #udg_Acided == 1, "corrosion must last while its buff exists")
    target.buffs.B03O=nil; emit("tick")
    check(target.abilities.A0CT == nil and #udg_Acided == 0, "expired corrosion must remove ability and tracking")
    for _=1,1000 do
        target.buffs.B03O=true; emit("udg_DamageEvent"); target.buffs.B03O=nil; emit("tick")
    end
    check(#udg_Acided == 0, "repeated corrosion must leave no tracked expired units")
end)

test("Ratling research and replacement", function()
    local owner, other = reset(); InitTrig_Permanent_Invisibility(); InitTrig_Permanent_Invisibility_2()
    emit("research", unit("laboratory",owner), "R06K")
    check(udg_SilentStrider[1] == true, "research must persist without a living Ratling")
    check(counts.groups == 0, "research must release its temporary group")
    local replacement = unit("o026",owner); emit("enter",replacement)
    check(replacement.abilities.A0CK == 1, "replacement Ratling must regain researched invisibility")
    local enemy = unit("o026",other); emit("enter",enemy)
    check(enemy.abilities.A0CK == nil, "unresearched owner must not receive invisibility")
    local unrelated = unit("other",owner); emit("enter",unrelated)
    check(unrelated.abilities.A0CK == nil, "research must not affect other unit types")
    emit("research", unit("laboratory",other), "R06K")
    check(enemy.abilities.A0CK == 1 and counts.groups == 0, "research must affect existing Ratlings and release groups")
end)

test("Deepwater research before construction", function()
    local owner, other = reset(); InitTrig_Deepwater_1(); InitTrig_Deepwater_2()
    emit("research", unit("laboratory",owner), "R066")
    check(udg_DeepWater1[1] == true, "research must persist without an existing well")
    local well = unit("e00R",owner); well.abilities.A0A4=1; emit("construct",well)
    check(well.abilities.A0A4 == nil and well.abilities.A0BB == 1, "later well must receive the researched ability")
    local otherWell = unit("e00R",other); otherWell.abilities.A0A4=1; emit("construct",otherWell)
    check(otherWell.abilities.A0A4 == 1 and not otherWell.abilities.A0BB, "well research must remain owner-specific")
    emit("research",unit("laboratory",other),"R066")
    check(otherWell.abilities.A0A4 == nil and otherWell.abilities.A0BB == 1, "research must update an existing well")
    check(counts.groups == 0, "research enumeration must not leak groups")
end)

test("Nerubian spire lifetime", function()
    local player = reset(); InitTrig_LevelUpAura(); InitTrig_DowngradeAura()
    local first, second = unit("h059",player), unit("h059",player,3000)
    emit("upgrade",first); emit("upgrade",second); emit("upgrade",second)
    check(udg_Ziggurats_Count == 2 and #udg_Ziggurats == 2, "each completed spire must count once")
    check(first.abilities.A09S == 2 and second.abilities.A0A1 == 2, "live spires must share the correct aura level")
    first.life=0; first.dead=true; emit("death",first)
    check(udg_Ziggurats_Count == 1 and #udg_Ziggurats == 1 and udg_Ziggurats[1] == second, "dead spire must leave persistent tracking")
    check(second.abilities.A09S == 1, "surviving spire must lose one aura level")
    emit("death",first); emit("death",unit("h059",player))
    check(udg_Ziggurats_Count == 1, "duplicate or untracked deaths must not decrement the aura")
    second.life=0; second.dead=true; emit("death",second)
    check(udg_Ziggurats_Count == 0 and #udg_Ziggurats == 0, "last spire death must leave empty state")
end)

test("Nerubian proximity uses living unit identity", function()
    local player = reset(); local candidate = unit("h059",player)
    check(not CheckNearbyUpgrades(candidate), "spire must not block its own upgrade")
    local corpse = unit("h059",player,100); corpse.dead=true; corpse.life=0
    check(not CheckNearbyUpgrades(candidate), "dead spire corpse must not block replacement")
    corpse.dead=false; corpse.life=100
    check(CheckNearbyUpgrades(candidate), "live nearby spire must block upgrade")
    corpse.x=0
    check(CheckNearbyUpgrades(candidate), "distinct overlapping live spire must still block upgrade")
    corpse.x=2001
    check(not CheckNearbyUpgrades(candidate), "outside-radius spire must not block upgrade")
    check(counts.groups == 0, "all proximity paths must release the search group")
end)

test("Nerubian bulk removal updates surviving aura levels", function()
    local owner, other=reset(); InitTrig_LevelUpAura(); InitTrig_DowngradeAura()
    local first, second, survivor=unit("h059",owner),unit("h059",owner,3000),unit("h059",other,6000)
    emit("upgrade",first); emit("upgrade",second); emit("upgrade",survivor)
    -- Defeat/unclaimed takeover cleanup calls RemoveUnit, without a death event.
    local departing=GetUnitsOfPlayerAndTypeId(owner,"h059")
    ForGroupBJ(departing,function() RemoveUnit(GetEnumUnit()) end); DestroyGroup(departing)
    check(first.removed and second.removed and counts.removals == 2, "bulk cleanup must call native removal once per unit")
    check(udg_Ziggurats_Count == 1 and #udg_Ziggurats == 1 and udg_Ziggurats[1] == survivor,
        "removed spires must leave the global count and persistent group immediately")
    check(survivor.abilities.A09S == 1 and survivor.abilities.A0A1 == 1, "surviving spire auras must drop with removed spires")
    emit("death",survivor); RemoveUnit(survivor)
    check(udg_Ziggurats_Count == 0 and #udg_Ziggurats == 0, "death followed by removal must not decrement twice")
    check(RemoveUnit(unit("other",owner)) == "removed" and udg_Ziggurats_Count == 0, "untracked removal must retain native return behavior")
    local wrapper=RemoveUnit; InitTrig_LevelUpAura()
    check(RemoveUnit == wrapper, "reinitializing the trigger must not wrap the native again")
    check(counts.groups == 0, "bulk removal must leave no temporary group")
end)

test("tree payout uses Damage Engine event source", function()
    local owner, other = reset(); InitTrig_Worgens_gold()
    gg_unit_h00Q_0026=unit("h00Q",other)
    udg_DamageEventTarget=gg_unit_h00Q_0026
    udg_DamageEventSource=unit("ordinary",owner); emit("udg_DamageEvent")
    check(owner.gold == 1 and other.gold == 0, "ordinary tree hit must pay its Damage Engine source owner one gold")
    udg_DamageEventSource=unit("h00R",owner); emit("udg_DamageEvent")
    check(owner.gold == 3, "Worgen tree hit must pay two gold")
    for _=1,10000 do emit("udg_DamageEvent") end
    check(owner.gold == 20003 and counts.effects == 0, "repeated tree attacks must preserve payouts without leaked effect handles")
    udg_DamageEventTarget=unit("unrelated",other); emit("udg_DamageEvent")
    check(owner.gold == 20003, "unrelated damage must not produce tree income")
end)

test("Mech Blaster damage checks the attacking holder", function()
    local owner = reset(); InitTrig_Gobo_Mech_Blaster_attack_check()
    local holder = unit("holder",owner); holder.items={I00Q=true}; holder.melee=true
    udg_DamageEventSource=holder; udg_DamageFilterSource=nil
    emit("udg_DamageModifierEvent")
    check(holder.abilities.A0DP == 2, "melee holder must keep melee Mech Blaster level when filter source is unset")
    holder.melee=false; udg_DamageFilterSource={melee=true}
    emit("udg_DamageModifierEvent")
    check(holder.abilities.A0DP == 1, "ranged holder must ignore unrelated filter configuration")
    holder.items.I00Q=nil; holder.abilities.A0DP=nil; emit("udg_DamageModifierEvent")
    check(holder.abilities.A0DP == nil, "non-holder must not receive item ability levels")
end)

test("Bounty Hunter text follows the Damage Engine source", function()
    local owner, enemy = reset(); InitTrig_Basic_Bounty_Hit(); InitTrig_Improved_Bounty_Hit()
    udg_DamageEventTarget=unit("enemy",enemy)
    for _, kind in ipairs({"h05W","h06H","h06C"}) do
        udg_DamageEventSource=unit(kind,owner); emit("udg_DamageEvent")
        check(lastTag.unit == udg_DamageEventSource and lastTag.permanent == false and lastTag.duration == 0.8,
            "bounty feedback must follow the source and expire")
    end
    check(owner.gold == 5 and owner.lumber == 185, "source correction must preserve all bounty amounts")
end)

test("Harvest Grapes creates and orders the same item without a location", function()
    local owner = reset(); InitTrig_Harvest_Grapes()
    local caster = unit("h05W",owner,37,-19)
    emit("spell_finish",caster,"A0DB")
    check(caster.lastOrder.order == "smart" and caster.lastOrder.item.kind == "I027", "grape must be targeted for pickup")
    check(caster.lastOrder.item.x == 37 and caster.lastOrder.item.y == -19, "grape must appear at the caster")
end)

test("harvest-order spam cannot mint gold", function()
    local owner, other = reset(); InitTrig_Return_lumber(); InitTrig_Worgens_gold()
    local worgen = unit("h00R",owner)
    for _=1,10000 do emit("target_order",worgen,"harvest") end
    check(owner.gold == 0, "issuing harvest orders must not grant income")
    gg_unit_h00Q_0026=unit("h00Q",other)
    udg_DamageEventSource=worgen; udg_DamageEventTarget=gg_unit_h00Q_0026
    emit("udg_DamageEvent")
    check(owner.gold == 2, "real Worgen world-tree damage must still pay two gold")
end)

test("mage mana restoration belongs to the attacking mage", function()
    local owner, enemy = reset(); InitTrig_Mana_Steal_Mages()
    owner.research={R063=1}
    local mage=unit("o023",owner); mage.maxMana=200; mage.mana=50
    local target=unit("ordinary",enemy); target.maxMana=200
    udg_DamageEventSource=mage; udg_DamageEventTarget=target; udg_IsDamageAttack=true
    emit("udg_DamageEvent",target)
    check(mage.mana == 70, "researched mage's attack must restore20mana even when native trigger unit is its victim")
    local otherAttacker=unit("ordinary",owner); otherAttacker.maxMana=200; otherAttacker.mana=50
    local enemyMage=unit("o023",enemy); enemyMage.maxMana=200
    udg_DamageEventSource=otherAttacker; udg_DamageEventTarget=enemyMage
    emit("udg_DamageEvent",enemyMage)
    check(otherAttacker.mana == 50, "hitting a mage must not give a non-mage the mage bonus")
    udg_DamageEventSource=mage; udg_DamageEventTarget=target; udg_IsDamageAttack=false
    emit("udg_DamageEvent",target)
    check(mage.mana == 70, "spell damage must not restore attack-only mana")
    udg_IsDamageAttack=true; udg_DamageEventTarget=unit("ally",owner); udg_DamageEventTarget.maxMana=200
    emit("udg_DamageEvent",udg_DamageEventTarget)
    check(mage.mana == 70, "allied attacks must not restore mage mana")
end)

test("Focused Anger covers every Expander role and copied research", function()
    reset()
    local players = {}
    function Player(id) if not players[id] then players[id]={id=id,research={}} end; return players[id] end
    function GetPlayerId(player) return player.id end
    function GetPlayerTechCount(player, raw) return player.research[raw] or 0 end
    dofile(root .. "/src/players/roles.lua")
    dofile(root .. "/src/races/forgotten/executioner.lua")
    FE_FocusedAnger={add=function(attacker) attacker.stacks=(attacker.stacks or 0)+1 end}
    udg_AncientPlayer=Player(10)
    for i=1,10 do _G["InitTrig_Focused_Anger_"..i]() end
    InitTrig_Focused_Anger_Trigger(); InitTrig_Focused_Anger_Trigger_Copy()
    for i=2,9 do _G["InitTrig_Focused_Anger_Trigger_Copy_"..i]() end
    local ancient = unit("ancient",Player(10))
    local executioners = {}
    for slot=0,9 do
        local owner=Player(slot)
        local attacker=unit("u00B",owner); executioners[slot]=attacker
        emit("attacked",ancient,nil,attacker)
        check(not attacker.stacks, "unresearched Expander must not stack Focused Anger")
        owner.research.R04T=1; emit("research",unit("altar",owner),"R04T")
        emit("attacked",ancient,nil,attacker)
        check(attacker.stacks == 1, "every Expander, including slot7, must receive exactly one stack")
    end
    local ancientOwned=unit("u00B",Player(10)); Player(10).research.R04T=1
    emit("attacked",ancient,nil,ancientOwned)
    check(not ancientOwned.stacks, "Ancient must not be treated as an Expander")
    emit("attacked",executioners[0],nil,executioners[6])
    check(executioners[6].stacks == 1, "original Ancient-target restriction must remain intact")
    -- A takeover changes the Ancient handle and copies technology directly,
    -- without generating a research-finish event for the receiving owner.
    udg_AncientPlayer=Player(5); local newAncient=unit("ancient",Player(5))
    local receivingOwner=Player(10); receivingOwner.research.R04T=1
    local inherited=unit("u00B",receivingOwner)
    emit("attacked",newAncient,nil,inherited)
    check(inherited.stacks == 1, "copied research must work with dynamic role ownership")
    emit("attacked",newAncient,nil,executioners[5])
    check(executioners[5].stacks == 1, "new Ancient owner must stop receiving Expander stacks")
end)

test("Bloodmage research covers all Expander owners without group leaks", function()
    reset(); udg_AncientPlayer=Player(10)
    dofile(root .. "/src/races/forgotten/bloodmage.lua")
    for _, family in ipairs({"Drain","Slam"}) do
        _G["InitTrig_Levelled_"..family]()
        _G["InitTrig_Levelled_"..family.."_Copy"]()
        for i=2,9 do _G["InitTrig_Levelled_"..family.."_Copy_"..i]() end
    end
    local mages={}
    for slot=0,10 do
        mages[slot]=unit("u009",Player(slot)); mages[slot].abilities={A065=1,A063=1}
    end
    for slot=0,9 do
        emit("research",unit("altar",Player(slot)),"R043")
        check(mages[slot].abilities.A065 == 2 and mages[slot].abilities.A063 == 2,
            "each Expander's Drain and Slam must increase exactly once")
        for other=slot+1,10 do check(mages[other].abilities.A065 == 1 and mages[other].abilities.A063 == 1,
            "research must not level another owner's Bloodmage") end
    end
    emit("research",unit("altar",Player(10)),"R043")
    check(mages[10].abilities.A065 == 1, "Ancient research must not use an Expander wrapper")
    udg_AncientPlayer=Player(6)
    emit("research",unit("altar",Player(10)),"R043")
    check(mages[10].abilities.A065 == 2 and mages[10].abilities.A063 == 2,
        "research subscriptions must follow current role after takeover")
    emit("research",unit("altar",Player(6)),"R043")
    check(mages[6].abilities.A065 == 2, "new Ancient must be excluded after takeover")
    check(counts.groups == 0, "all Bloodmage research enumeration groups must be released")
end)

test("Ancient hints and gold pings follow the role", function()
    reset(); udg_AncientPlayer=Player(10)
    dofile(root .. "/src/ui/hints.lua")
    local messages, pings, ownedForces, ownedLocations = {}, {}, 0, 0
    function DisplayTimedTextToPlayer(player, x, y, duration, text) messages[#messages+1]={player=player,text=text,duration=duration} end
    function GetPlayersAllies(player) ownedForces=ownedForces+1; return {owner=player} end
    function DestroyForce() ownedForces=ownedForces-1 end
    function GetRectCenter(rect) ownedLocations=ownedLocations+1; return {rect=rect} end
    function RemoveLocation() ownedLocations=ownedLocations-1 end
    function PingMinimapLocForForce(force) pings[force.owner]=(pings[force.owner] or 0)+1 end
    InitTrig_Ping(); InitTrig_PingForAncient()
    for slot=0,10 do
        emit("chat",{owner=Player(slot)},"-gold")
        check(pings[Player(slot)] == 7, "every player must receive one set of seven gold pings, not zero or two")
    end
    Trig_Info_Copy_Actions(); Trig_Info_Actions()
    check(messages[1].player == Player(10) and messages[2].player == Player(10), "Ancient hints must reach lobby slot11")
    udg_AncientPlayer=Player(6); pings={}
    emit("chat",{owner=Player(6)},"-gold"); emit("chat",{owner=Player(10)},"-gold")
    check(pings[Player(6)] == 7 and pings[Player(10)] == 7, "pings must remain single after role transfer")
    Trig_Info_Actions()
    check(messages[3].player == Player(6), "Ancient hint must follow a transferred role")
    check(ownedForces == 0 and ownedLocations == 0, "ping helper must release temporary forces and locations")
end)

test("hard AI selection is bounded and timer/event contexts are valid", function()
    reset(); udg_AncientPlayer=Player(10); udg_Hardunit=nil
    PLAYER_NEUTRAL_PASSIVE=15; PLAYER_NEUTRAL_AGGRESSIVE=12
    dofile(root .. "/src/ai/behavior.lua")
    local orders, locations, pickIndex, draws = {}, 0, 1, 0
    function GetUnitsInRectAll()
        local group=CreateGroup(); for _, u in ipairs(world) do if not u.removed then group[#group+1]=u end end; return group
    end
    function GetUnitsOfPlayerAll(player)
        local group=CreateGroup(); for _, u in ipairs(world) do if u.owner == player and not u.removed then group[#group+1]=u end end; return group
    end
    function GetRandomSubGroup(amount, group)
        assert(amount == 1 and #group > 0, "AI must not draw from an empty pool")
        draws=draws+1; local chosen=CreateGroup(); chosen[1]=group[pickIndex]; return chosen
    end
    function GetUnitLoc(u) assert(u); locations=locations+1; return {x=u.x,y=u.y} end
    function RemoveLocation() locations=locations-1 end
    function GetFilterUnit() error("AI order callback has no filter unit context") end
    function TriggerExecute() error("AI must not recursively retry selection") end
    function IssuePointOrderLocBJ(u, order, location)
        assert(location); orders[#orders+1]={unit=u,order=order,x=location.x,y=location.y}
    end
    local ancient=unit("ancient",Player(10)); local ally=unit("army",Player(10))
    unit("neutral",Player(15)); unit("neutral",Player(12))
    InitTrig_Hard_Attack(); InitTrig_Hard_Attack_Cont(); InitTrig_Hard_attack_2()
    EnableTrigger(gg_trg_Hard_Attack)
    emit("tick")
    check(#orders == 0 and draws == 0 and counts.groups == 0, "no eligible target must stop without recursion, draws, orders or leaks")
    local first=unit("expander",Player(0),50,70)
    local second=unit("expander",Player(6),90,110)
    emit("tick")
    check(#orders == 2 and orders[1].x == 50 and orders[2].x == 50, "periodic hard AI must order its army toward an eligible target")
    orders={}; pickIndex=2
    Trig_Hard_attack_2_Actions()
    check(#orders == 2 and orders[1].x == 90, "retry compatibility callback must order the selected second target")
    orders={}; pickIndex=1; event={unit=first}
    check(Trig_Hard_Attack_Conditions(), "enemy death must retain the hard-AI trigger")
    event={unit=ancient}
    check(not Trig_Hard_Attack_Conditions(), "Ancient-owned death must remain excluded")
    for _=1,1000 do Trig_Hard_attack_2_Actions() end
    check(counts.groups == 0 and locations == 0 and udg_Hardunit == nil,
        "repeated AI attacks must release search, chosen, army and location handles")
end)

test("Seed of Rebirth restores Worgen, Bloodmage and Kobold research by owner", function()
    reset(); udg_AncientPlayer=Player(10)
    dofile(root .. "/src/races/wisp.lua")
    dofile(root .. "/src/races/kobold.lua")
    local target, created, alive = nil, nil, {}
    function GetSpellAbilityUnit() return event.unit end
    function GetSpellTargetUnit() return target end
    function TriggerSleepAction() end
    function GetPlayerSlotState() return PLAYER_SLOT_STATE_PLAYING end
    function CreateUnit(player, kind, x, y)
        created=unit(kind,player,x,y)
        if kind == "h00R" then created.abilities={A042=1,A04C=1,unrelated=7}
        elseif kind == "u009" then created.abilities={A065=1,A063=1,unrelated=7}
        elseif kind == "h03Q" then created.abilities={A086=1,unrelated=7} end
        return created
    end
    function IssueImmediateOrderBJ() end
    function SetPlayerAllianceStateBJ() end
    FE_Roster={isAlive=function(player) return alive[player] == true end,revive=function(player) alive[player]=true end}
    FE_Wildkin=nil
    PLAYER_SLOT_STATE_PLAYING="playing"; bj_UNIT_FACING=270
    udg_SeedOfRebirth={}
    local caster=unit("h02L",Player(2))
    for _, scenario in ipairs({{owner=0,kind="h00R",research="R030",upgrades=20,first="A042",second="A04C"},
        {owner=1,kind="h00R",research="R030",upgrades=0,first="A042",second="A04C"},
        {owner=3,kind="u009",research="R043",upgrades=10,first="A065",second="A063"},
        {owner=4,kind="u009",research="R043",upgrades=0,first="A065",second="A063"},
        {owner=5,kind="h03Q",research="R004",upgrades=10,first="A086",second="A086"},
        {owner=6,kind="h03Q",research="R004",upgrades=0,first="A086",second="A086"}}) do
        local owner=Player(scenario.owner); owner.research[scenario.research]=scenario.upgrades
        udg_SeedOfRebirth[scenario.owner+1]=scenario.kind
        target=unit("e00E",owner,12,34); event={unit=caster}
        Trig_SeedOfRebirth_Actions()
        check(created and created.kind == scenario.kind and created.owner == owner and not created.removed,
            "rebirth must retain the newly created owner's builder")
        check(created.abilities[scenario.first] == 1+scenario.upgrades and created.abilities[scenario.second] == 1+scenario.upgrades,
            "rebirth must restore each owner's complete manual research levels")
        check(created.abilities.unrelated == 7, "restoration must not modify unrelated abilities")
        check(alive[owner] and target.removed, "rebirth must preserve its roster and old-unit cleanup")
    end
    local wrong=unit("unrelated",Player(0)); wrong.abilities={A042=4,A065=6}
    FE_Worgen.restoreResearch(wrong); FE_Bloodmage.restoreResearch(wrong)
    check(wrong.abilities.A042 == 4 and wrong.abilities.A065 == 6, "restoration must ignore other races")
    local missing=unit("h00R",Player(0)); FE_Worgen.restoreResearch(missing)
    check(not missing.abilities.A042 and not missing.abilities.A04C, "restoration must not grant absent abilities")
    local absent=unit("h03Q",Player(5)); FE_Kobold.restoreResearch(absent)
    check(not absent.abilities.A086, "Kobold restoration must not grant an absent spellbook ability")
    check(counts.groups == 0, "rebirth must release its temporary old-unit group")
end)

test("feed bounty scaling restores original values across lethal/revival turns", function()
    reset(); udg_AncientPlayer=Player(10)
    local timers, expired, liveTimers = {}, nil, 0
    UNIT_IF_GOLD_BOUNTY_AWARDED_BASE="base"
    UNIT_IF_GOLD_BOUNTY_AWARDED_NUMBER_OF_DICE="dice"
    UNIT_IF_GOLD_BOUNTY_AWARDED_SIDES_PER_DIE="sides"
    function I2R(value) return value end
    function R2I(value) return math.modf(value) end
    function BlzGetUnitIntegerField(target, field) assert(not target.removed); return target.bounty[field] end
    function BlzSetUnitIntegerField(target, field, value) assert(not target.removed); target.bounty[field]=value; return true end
    function SetPlayerHandicapXPBJ(player, rate) player.xpRate=rate end
    function TimerStart(timer, delay, periodic, callback)
        assert(delay == 0 and not periodic); timer.callback=callback; timers[#timers+1]=timer
    end
    function GetExpiredTimer() return expired end
    FE_Timers={create=function() liveTimers=liveTimers+1; return {} end,
        destroy=function(timer) assert(not timer.destroyed); timer.destroyed=true; liveTimers=liveTimers-1 end}
    local function flush()
        local pending=timers; timers={}
        for _, timer in ipairs(pending) do expired=timer; timer.callback() end
        expired=nil
    end
    local function bountyUnit(kind, owner)
        local target=unit(kind,owner); target.bounty={base=100,dice=2,sides=20}; return target
    end
    dofile(root .. "/src/economy/feed.lua"); InitTrig_FeedReduction()
    local owner=Player(0); local target=bountyUnit("hero",owner)
    udg_ExperienceRate={[0]=50}; udg_DamageEventTarget=target
    emit("udg_LethalDamageEvent")
    check(target.bounty.base == 50 and target.bounty.dice == 2 and target.bounty.sides == 10,
        "lethal event must scale base/sides and preserve dice count")
    check(Player(10).xpRate == 50, "lethal callback must retain the existing XP policy")
    emit("udg_LethalDamageEvent")
    check(target.bounty.base == 50 and target.bounty.sides == 10 and liveTimers == 1,
        "overlapping lethal events must not compound or duplicate timers")
    udg_ExperienceRate[0]=200; emit("udg_LethalDamageEvent")
    check(target.bounty.base == 200 and target.bounty.sides == 40, "changed feed must derive from captured native baseline")
    -- Model another callback preventing death: the unit remains alive.
    flush()
    check(target.bounty.base == 100 and target.bounty.dice == 2 and target.bounty.sides == 20 and liveTimers == 0,
        "cancelled lethal damage must leave native base fields restored and no timer")
    udg_ExperienceRate[0]=50; emit("udg_LethalDamageEvent"); target.dead=true; target.life=0
    local nativePayout=target.bounty.base + target.bounty.dice*target.bounty.sides
    flush(); target.dead=false; target.life=100
    udg_ExperienceRate[0]=150; emit("udg_LethalDamageEvent")
    check(nativePayout == 70 and target.bounty.base == 150 and target.bounty.sides == 30,
        "revival and a different feed rate must use original bounty, not the previous death's scaling")
    flush()
    FR_ApplyGoldBountyRate(target,0)
    check(target.bounty.base == 0 and target.bounty.dice == 0 and target.bounty.sides == 0, "zero feed must suppress every bounty field")
    FR_ApplyGoldBountyRate(target,100)
    check(target.bounty.base == 100 and target.bounty.dice == 2 and target.bounty.sides == 20, "zero then normal feed in one turn must recover all original values")
    flush()
    target.bounty={base=240,dice=3,sides=40}; FR_ApplyGoldBountyRate(target,50)
    check(target.bounty.base == 120 and target.bounty.dice == 3 and target.bounty.sides == 20,
        "later native bounty/research edits must become the next baseline")
    target.bounty.base=300; FR_ApplyGoldBountyRate(target,50)
    check(target.bounty.base == 150 and target.bounty.sides == 20, "intervening field edit must be adopted without compounding unchanged fields")
    target.bounty.dice=5; flush()
    check(target.bounty.base == 300 and target.bounty.dice == 5 and target.bounty.sides == 40,
        "restoration must preserve another system's intervening field edit")
    FR_ApplyGoldBountyRate(target,50); target.kind="upgraded"; target.bounty={base=700,dice=4,sides=60}; flush()
    check(target.bounty.base == 700 and target.bounty.sides == 60, "pending restoration must not overwrite a native type upgrade")
    FR_ApplyGoldBountyRate(target,50); target.kind="morphed"; target.bounty={base=800,dice=6,sides=80}
    FR_ApplyGoldBountyRate(target,200)
    check(target.bounty.base == 1600 and target.bounty.dice == 6 and target.bounty.sides == 160,
        "another lethal event after morph must capture the new type's native values")
    flush(); check(target.bounty.base == 800 and target.bounty.sides == 80, "morphed type must restore its own values")
    local removed=bountyUnit("removed",owner); FR_ApplyGoldBountyRate(removed,50); RemoveUnit(removed); flush()
    check(liveTimers == 0, "removed target must release pending state without calling invalid field natives")
    local second=bountyUnit("other",Player(1)); FR_ApplyGoldBountyRate(target,50); FR_ApplyGoldBountyRate(second,200)
    check(target.bounty.base == 400 and second.bounty.base == 200 and liveTimers == 2, "simultaneous targets require independent captured baselines")
    flush()
    for _=1,1000 do FR_ApplyGoldBountyRate(target,50); FR_ApplyGoldBountyRate(target,200); flush() end
    check(target.bounty.base == 800 and target.bounty.sides == 80 and liveTimers == 0,
        "repeated lethal/revival turns must neither drift native values nor retain timers")
end)

if #failures > 0 then error(table.concat(failures,"\n")) end
print("runtime audit: " .. checks .. " behavioral assertions passed")
