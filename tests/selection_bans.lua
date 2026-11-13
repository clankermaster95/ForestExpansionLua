-- Exercise random purchase callbacks with bans applied after startup. This is
-- a deterministic native double, not validation of Warcraft's stock UI.
local checks, draw, calls, created, item, token = 0, 1, 0, nil, nil, nil
local player = {id=0}
local function check(value, message) assert(value, message); checks=checks+1 end
local locations,groups={},{}
gg_rct_Tele_out_E={x=100,y=200};gg_rct_Tele_out_D={x=300,y=400}
gg_rct_Spawn_all={x=500,y=600};gg_rct_SpawnDefender={x=700,y=800}
local map={x=50,y=60}
local function location(x,y)
    local point={x=x,y=y};locations[point]=true;return point
end
local function noLeaks()
    check(next(locations)==nil,'every temporary location released')
    check(next(groups)==nil,'every temporary group released')
end
function FourCC(s) return s end
function GetRandomInt(lo,hi)
    calls=calls+1
    check(lo==1 and draw<=hi and draw>=lo,'random bounds include the requested draw')
    return draw
end
function GetTriggerUnit() return token end
function GetTriggerPlayer() return player end
function GetOwningPlayer(u) return u.owner end
function GetManipulatedItem() return item end
function GetUnitLoc(u) return location(u.x,u.y) end
function GetRectCenter(rect) return location(rect.x,rect.y) end
function CreateNUnitsAtLocFacingLocBJ(n,raw,owner,point,facing)
    check(n==1 and raw~=nil and owner==player,'one valid owned random unit')
    check(locations[point] and locations[facing],'live spawn/facing locations')
    local expected=raw:sub(1,1)=='O' and gg_rct_Tele_out_D or gg_rct_Tele_out_E
    check(point.x==expected.x and point.y==expected.y,'original random spawn position')
    check(facing.x==gg_rct_Tele_out_E.x and facing.y==gg_rct_Tele_out_E.y,'original random facing point')
    created={raw=raw,owner=owner}
end
function GetLastCreatedUnit() return created end
function RemoveLocation(point) check(locations[point],'location released exactly once');locations[point]=nil end
function RemoveItem(i) i.removed=true end
function KillUnit(u) u.dead=true end
function GetPlayersAll() return {} end
function DisplayTextToForce() end
function GetPlayerName() return 'Player' end
function GetPlayerNameWithoutTag() return 'Player' end
function SetPlayerName() end
function GetUnitName(u) return u.raw end
function GetConvertedPlayerId() return 1 end
local enum,orb
function GetUnitsInRectAll(rect)
    check(rect==gg_rct_SpawnDefender,'original selector removal region')
    local group={{},{}};groups[group]=true;return group
end
function ForGroup(group,callback)
    check(groups[group],'selector group remains live during enumeration')
    for _,unit in ipairs(group) do enum=unit;callback() end
    enum=nil
end
function GetEnumUnit() return enum end
function RemoveUnit(unit) unit.removed=true end
function DestroyGroup(group)
    check(groups[group],'group released exactly once')
    for _,unit in ipairs(group) do check(unit.removed,'all selector removals precede group cleanup') end
    groups[group]=nil
end
function CreateItemLoc(raw,point)
    check(raw=='I000' and locations[point] and point.x==map.x and point.y==map.y,'orb created at original map center')
    orb={raw=raw}
end
function GetPlayableMapRect() return map end
function GetLastCreatedItem() return orb end
function UnitAddItemSwapped(given,unit) check(given==orb and unit==created,'orb delivered to selected Ancient') end
function GetUnitTypeId(u) return u and not u.removed and u.raw or 0 end
function GetItemTypeId(i) return i and not i.removed and i.raw or 0 end
function UnitAddAbilityBJ() end
function RemoveUnitFromStock() end
function I2S(n) return tostring(n) end
dofile('src/runtime.lua')
dofile('src/game/selection.lua')
udg_Units={};udg_Ancients={};udg_PlayerColorHex={''}
local function reset()
    for _,key in ipairs(FE_Factions.banOrder) do _G[FE_Factions.byKey[key].ban]=0 end
    FE_Factions.bansClosed=false;udg_Bans=3;created=nil;calls=0
    -- Deliberately populate before bans to catch stale startup arrays.
    Trig_RandomExpander_Actions()
    FE_Factions.fillRandomPool(udg_Ancients,'randomAncients')
end
local function exercise(kind, action)
    local expected={}
    for _,key in ipairs(FE_Factions[kind]) do
        local e=FE_Factions.byKey[key]
        if _G[e.ban]==0 then expected[#expected+1]=e.raw end
    end
    for index,raw in ipairs(expected) do
        draw=index;token={owner=player};item={}
        local before=calls
        action()
        check(created.raw==raw,'each surviving draw preserves order and relative weight')
        check(calls==before+1,'exactly one synchronized draw per purchase')
        check(token.dead and item.removed,'successful purchase consumes selector and random item')
        if kind=='randomAncients' then check(udg_AncientUnit==created,'Ancient role receives random unit') end
        noLeaks()
    end
    local pool=kind=='randomAncients' and udg_Ancients or udg_Units
    for index=#expected+1,#FE_Factions[kind] do check(pool[index]==nil,'stale banned entries cleared') end
end
for _,case in ipairs({{'randomExpanders',Trig_RandomExpander2_Actions},
                      {'randomAncients',Trig_Random_Ancient_Actions}}) do
    local kind,action=case[1],case[2]
    reset();exercise(kind,action)
    -- Every individual faction ban, including factions outside a legacy pool.
    for _,key in ipairs(FE_Factions.banOrder) do
        reset();FE_Factions.ban(key);exercise(kind,action)
    end
    reset()
    local keys=kind=='randomAncients' and {'AncientFire','AncientLight','AncientSand'} or {'Human','Worgen','Wildkin'}
    for _,key in ipairs(keys) do FE_Factions.ban(key) end
    check(udg_Bans==0,'all three bans applied');exercise(kind,action)
    -- Defensive empty-pool path: no invalid random bound or selector loss.
    for _,key in ipairs(FE_Factions[kind]) do _G[FE_Factions.byKey[key].ban]=1 end
    token={owner=player};item={};created=nil
    local before=calls;action()
    check(calls==before and not created and not item.removed and not token.dead,'empty pool leaves buyer intact')
    noLeaks()
end
-- Direct Ancient purchases and both enter-region callbacks own their temporary
-- points too. Check arguments remain usable until the native consumes them.
created={owner=player};function GetSoldUnit() return created end
Trig_Give_orb_Actions();noLeaks()
token={owner=player,x=123,y=-456}
function GetEntireMapRect() return map end
function SetCameraBoundsToRectForPlayerBJ(owner,rect) check(owner==player and rect==map,'camera bounds retained') end
function PanCameraToTimedLocForPlayer(owner,point,duration)
    check(owner==player and locations[point] and point.x==token.x and point.y==token.y and duration==0,'camera pans to entering unit')
end
Trig_Camera_Copy_Actions();noLeaks()
function SetUnitPositionLoc(unit,point)
    check(unit==token and locations[point] and point.x==gg_rct_Spawn_all.x and point.y==gg_rct_Spawn_all.y,'Ancient teleport destination retained')
end
Trig_AncientSpawnTele_Actions();noLeaks()

-- Pickup may consume the Random item before the later sale notification. Run
-- the real pickup action, then the sale callback against that removed handle;
-- the surviving Expander shop must still serve the next player.
local shop={raw='nmer',stock=0}
gg_unit_nmer_0000=shop
function GetSellingUnit() return shop end
function GetSoldItem() return item end
function AddItemToStock(s,raw,count,maximum)
    check(s==shop and raw=='I00W' and count==10 and maximum==10,'restock identifies Random by its surviving selector')
    s.stock=count
end
reset();FE_Factions.stocked={expanders='open',ancients='preview'}
for _,shopRaw in ipairs({'nmer','n00G'}) do
shop.raw=shopRaw
gg_unit_nmer_0000=shopRaw=='nmer' and shop or {raw='nmer'}
gg_unit_n00G_0035=shopRaw=='n00G' and shop or {raw='n00G'}
for index=1,2 do
    draw=index;token={owner=player};item={raw='I00W'};shop.stock=0
    Trig_RandomExpander2_Actions()
    check(item.removed and GetItemTypeId(item)==0 and GetUnitTypeId(shop)==shopRaw,'pickup removes item but leaves Expander shop')
    FE_Factions.restoreRandomStock()
    check(shop.stock==10,'removed Random item does not prevent the next purchase')
    noLeaks()
end
end
print('Selection bans passed: '..checks..' assertions; every random draw, all bans, and full ban budget')
