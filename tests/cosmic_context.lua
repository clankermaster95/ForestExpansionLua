-- A Damage Engine callback may run with stale or absent native event context.
-- This is an ordinary gameplay regression test, not a multiplayer reproduction.
local checks, writes, nativeReads = 0, 0, 0
local function check(value,message) assert(value,message);checks=checks+1 end
function FourCC(raw) return raw end
function GetUnitManaPercent(unit) return unit.mana end
function SetUnitManaPercentBJ(unit,value) unit.mana=math.min(100,value);writes=writes+1 end
function UnitRemoveBuffBJ(raw,unit)
    check(raw=='B038','only Cosmic Strike buff is consumed')
    unit.buff=false
end
dofile('src/runtime.lua')
dofile('src/ancients/nebula.lua')
local function dispatch()
    if Trig_Cosmic_Strike_2_Conditions() then Trig_Cosmic_Strike_2_Actions() end
end
for _,mode in ipairs({'stale','unavailable'}) do
    local caster,other={mana=30,buff=true},{mana=70,buff=true}
    GetEventDamageSource=function()
        nativeReads=nativeReads+1
        if mode=='unavailable' then error('no native damage context during deferred callback') end
        return other
    end
    for _,remaining in ipairs({1,2}) do
        caster.mana=30;caster.buff=true
        udg_CosmicStrikeCaster=caster;udg_CosmicStrikeCount=remaining
        udg_DamageEventSource=caster;udg_IsDamageAttack=true
        local before=writes
        dispatch()
        check(caster.mana==35 and other.mana==70,'restore five points from the matched caster mana')
        check(writes==before+1,'one mana write for one matching attack')
        check(udg_CosmicStrikeCount==remaining-1,'consume exactly one count')
        check(caster.buff==(remaining>1),'only final count removes the buff')
        check(udg_CosmicStrikeCaster==nil,'preserve existing caster reset')
        check(nativeReads==0,'never consult stale or unavailable native response')
    end
    for _,mismatch in ipairs({'other source','not an attack'}) do
        caster.mana=30;caster.buff=true
        udg_CosmicStrikeCaster=caster;udg_CosmicStrikeCount=1
        udg_DamageEventSource=mismatch=='other source' and other or caster
        udg_IsDamageAttack=mismatch~='not an attack'
        local before=writes
        dispatch()
        check(caster.mana==30 and other.mana==70 and writes==before,'unmatched callback leaves mana unchanged')
        check(udg_CosmicStrikeCaster==caster and udg_CosmicStrikeCount==1 and caster.buff,'unmatched callback preserves charge and buff')
        check(nativeReads==0,'unmatched callback does not access native context')
    end
end
print('Cosmic Strike context passed: '..checks..' assertions; stale/absent native context and unchanged charge handling')
