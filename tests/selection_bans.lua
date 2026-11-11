-- Exercise random purchase callbacks with bans applied after startup. This is
-- a deterministic native double, not validation of Warcraft's stock UI.
local checks, draw, calls, created, item, token = 0, 1, 0, nil, nil, nil
local player = {id=0}
local function check(value, message) assert(value, message); checks=checks+1 end
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
function GetUnitLoc() return {} end
function GetRectCenter() return {} end
function CreateNUnitsAtLocFacingLocBJ(n,raw,owner)
    check(n==1 and raw~=nil and owner==player,'one valid owned random unit')
    created={raw=raw,owner=owner}
end
function GetLastCreatedUnit() return created end
function RemoveLocation() end
function RemoveItem(i) i.removed=true end
function KillUnit(u) u.dead=true end
function GetPlayersAll() return {} end
function DisplayTextToForce() end
function GetPlayerName() return 'Player' end
function GetPlayerNameWithoutTag() return 'Player' end
function SetPlayerName() end
function GetUnitName(u) return u.raw end
function GetConvertedPlayerId() return 1 end
function GetUnitsInRectAll() return {} end
function ForGroupBJ() end
function CreateItemLoc() end
function GetPlayableMapRect() return {} end
function GetLastCreatedItem() return {} end
function UnitAddItemSwapped() end
function GetUnitTypeId(u) return u.raw end
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
end
print('Selection bans passed: '..checks..' assertions; every random draw, all bans, and full ban budget')
