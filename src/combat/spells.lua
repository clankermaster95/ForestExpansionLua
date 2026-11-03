-- combat / spells
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 155 FanOfKnivesBasedSpells
function BURST_IsSupportedAbility(abilId)
    return ((abilId == BURST_DRAGONIC_ABIL_ID) or (abilId == BURST_LICH_ABIL_ID))
end

function BURST_GetMissileModel(abilId)
    if (abilId == BURST_DRAGONIC_ABIL_ID) then
        return "units\\creeps\\RedDragonWelp\\RedDragonWelp.mdl"
    end
    if (abilId == BURST_LICH_ABIL_ID) then
        return "Abilities\\Weapons\\LichMissile\\LichMissile.mdl"
    end
    return ""
end

function BURST_GetMissileSpeed(abilId, level)
    if (abilId == BURST_DRAGONIC_ABIL_ID) then
        return __jreal(700.00)
    end
    if (abilId == BURST_LICH_ABIL_ID) then
        return __jreal(500.00)
    end
    return __jreal(0.00)
end

function BURST_GetMissileHeight(abilId, level)
    if (abilId == BURST_DRAGONIC_ABIL_ID) then
        return __jreal(200.00)
    end
    if (abilId == BURST_LICH_ABIL_ID) then
        return __jreal(70.00)
    end
    return __jreal(70.00)
end

function BURST_GetMissileScale(abilId, level)
    if (abilId == BURST_DRAGONIC_ABIL_ID) then
        return __jreal(1.50)
    end
    if (abilId == BURST_LICH_ABIL_ID) then
        return __jreal(1.00)
    end
    return __jreal(1.00)
end

function BURST_GetHitRange(abilId, level)
    if (abilId == BURST_DRAGONIC_ABIL_ID) then
        return __jreal(30.00)
    end
    if (abilId == BURST_LICH_ABIL_ID) then
        return __jreal(35.00)
    end
    return __jreal(35.00)
end

function BURST_GetDamage(abilId, level)
    if (abilId == BURST_DRAGONIC_ABIL_ID) then
        return __jreal(__jreal(100.00) + __jreal(__jreal(25.00) * I2R(__jint(level - 1))))
    end
    if (abilId == BURST_LICH_ABIL_ID) then
        return __jreal(__jreal(100.00) + __jreal(__jreal(25.00) * I2R(__jint(level - 1))))
    end
    return __jreal(0.00)
end

function BURST_GetAoE(abilId, level)
    if (abilId == BURST_DRAGONIC_ABIL_ID) then
        return __jreal(__jreal(500.00) + __jreal(__jreal(50.00) * I2R(__jint(level - 1))))
    end
    if (abilId == BURST_LICH_ABIL_ID) then
        return __jreal(800.00)
    end
    return __jreal(0.00)
end

function BURST_UnitExists(u)
    return (GetUnitTypeId(u) ~= 0)
end

function BURST_IsAlive(u)
    return ((GetUnitTypeId(u) ~= 0) and (GetWidgetLife(u) > __jreal(0.405)))
end

function BURST_IsValidTarget(caster, target)
    return (((BURST_IsAlive(target) and IsUnitEnemy(target, GetOwningPlayer(caster))) and (not IsUnitType(target, UNIT_TYPE_STRUCTURE))) and (not IsUnitType(target, UNIT_TYPE_MAGIC_IMMUNE)))
end

function BURST_RemoveMissile(i)
    DestroyEffect(BURST_MISSILE[i])
    BURST_CASTER[i] = BURST_CASTER[BURST_COUNT]
    BURST_TARGET[i] = BURST_TARGET[BURST_COUNT]
    BURST_MISSILE[i] = BURST_MISSILE[BURST_COUNT]
    BURST_X[i] = BURST_X[BURST_COUNT]
    BURST_Y[i] = BURST_Y[BURST_COUNT]
    BURST_DAMAGE[i] = BURST_DAMAGE[BURST_COUNT]
    BURST_SPEED[i] = BURST_SPEED[BURST_COUNT]
    BURST_HEIGHT[i] = BURST_HEIGHT[BURST_COUNT]
    BURST_CASTER[BURST_COUNT] = nil
    BURST_TARGET[BURST_COUNT] = nil
    BURST_MISSILE[BURST_COUNT] = nil
    BURST_X[BURST_COUNT] = __jreal(0.00)
    BURST_Y[BURST_COUNT] = __jreal(0.00)
    BURST_DAMAGE[BURST_COUNT] = __jreal(0.00)
    BURST_SPEED[BURST_COUNT] = __jreal(0.00)
    BURST_HEIGHT[BURST_COUNT] = __jreal(0.00)
    BURST_COUNT = __jint(BURST_COUNT - 1)
end

function BURST_Periodic()
    local i = 1
    local tx = 0.0
    local ty = 0.0
    local dx = 0.0
    local dy = 0.0
    local dist = 0.0
    local angle = 0.0
    local step = 0.0
    while true do
        if (i > BURST_COUNT) then break end
        if ((not (GetUnitTypeId((BURST_CASTER[i])) ~= 0)) or (not BURST_IsAlive(BURST_TARGET[i]))) then
            BURST_RemoveMissile(i)
        else
            tx = GetUnitX(BURST_TARGET[i])
            ty = GetUnitY(BURST_TARGET[i])
            dx = __jreal(tx - BURST_X[i])
            dy = __jreal(ty - BURST_Y[i])
            dist = SquareRoot(__jreal(__jreal(dx * dx) + __jreal(dy * dy)))
            step = __jreal(BURST_SPEED[i] * BURST_PERIOD)
            if (dist <= step) then
                if BURST_IsValidTarget(BURST_CASTER[i], BURST_TARGET[i]) then
                    UnitDamageTarget(BURST_CASTER[i], BURST_TARGET[i], BURST_DAMAGE[i], false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
                end
                BURST_RemoveMissile(i)
            else
                angle = Atan2(dy, dx)
                BURST_X[i] = __jreal(BURST_X[i] + __jreal(Cos(angle) * step))
                BURST_Y[i] = __jreal(BURST_Y[i] + __jreal(Sin(angle) * step))
                BlzSetSpecialEffectPosition(BURST_MISSILE[i], BURST_X[i], BURST_Y[i], BURST_HEIGHT[i])
                BlzSetSpecialEffectYaw(BURST_MISSILE[i], angle)
                i = __jint(i + 1)
            end
        end
    end
    if (BURST_COUNT == 0) then
        PauseTimer(BURST_TIMER)
    end
end

function BURST_StartMissile(caster, target, abilId, level)
    local x = GetUnitX(caster)
    local y = GetUnitY(caster)
    local angle = Atan2(__jreal(GetUnitY(target) - y), __jreal(GetUnitX(target) - x))
    local height = BURST_GetMissileHeight(abilId, level)
    local e = AddSpecialEffect(BURST_GetMissileModel(abilId), x, y)
    BlzSetSpecialEffectScale(e, BURST_GetMissileScale(abilId, level))
    BlzSetSpecialEffectPosition(e, x, y, height)
    BlzSetSpecialEffectYaw(e, angle)
    BURST_COUNT = __jint(BURST_COUNT + 1)
    BURST_CASTER[BURST_COUNT] = caster
    BURST_TARGET[BURST_COUNT] = target
    BURST_MISSILE[BURST_COUNT] = e
    BURST_X[BURST_COUNT] = x
    BURST_Y[BURST_COUNT] = y
    BURST_DAMAGE[BURST_COUNT] = BURST_GetDamage(abilId, level)
    BURST_SPEED[BURST_COUNT] = BURST_GetMissileSpeed(abilId, level)
    BURST_HEIGHT[BURST_COUNT] = height
    if (BURST_COUNT == 1) then
        TimerStart(BURST_TIMER, BURST_PERIOD, true, BURST_Periodic)
    end
    e = nil
end

function BURST_OnCast()
    local caster = GetTriggerUnit()
    local abilId = GetSpellAbilityId()
    local level = 0
    local x = 0.0
    local y = 0.0
    local aoe = 0.0
    local target = nil
    if (not BURST_IsSupportedAbility(abilId)) then
        caster = nil
        return
    end
    level = GetUnitAbilityLevel(caster, abilId)
    x = GetUnitX(caster)
    y = GetUnitY(caster)
    aoe = BURST_GetAoE(abilId, level)
    GroupEnumUnitsInRange(BURST_ENUM_GROUP, x, y, aoe, nil)
    while true do
        target = FirstOfGroup(BURST_ENUM_GROUP)
        if (target == nil) then break end
        GroupRemoveUnit(BURST_ENUM_GROUP, target)
        if BURST_IsValidTarget(caster, target) then
            BURST_StartMissile(caster, target, abilId, level)
        end
    end
    caster = nil
    target = nil
end

function BURST_Conditions()
    return BURST_IsSupportedAbility(GetSpellAbilityId())
end

function InitTrig_FanOfKnivesBasedSpells()
    local t = CreateTrigger()
    local i = 0
    while true do
        if (i >= bj_MAX_PLAYER_SLOTS) then break end
        TriggerRegisterPlayerUnitEvent(t, Player(i), EVENT_PLAYER_UNIT_SPELL_EFFECT, nil)
        i = __jint(i + 1)
    end
    TriggerAddCondition(t, Condition(BURST_Conditions))
    TriggerAddAction(t, BURST_OnCast)
    t = nil
end
-- END FOREST SECTION 155
