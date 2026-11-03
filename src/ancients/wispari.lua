-- ancients / wispari
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 188 Refreshing_Breeze
-- This trigger has no standalone compiled functions. Library implementations are in src/libraries/.
-- END FOREST SECTION 188

-- BEGIN FOREST SECTION 189 Gale_Winds
-- This trigger has no standalone compiled functions. Library implementations are in src/libraries/.
-- END FOREST SECTION 189

-- BEGIN FOREST SECTION 190 WindWalkWispari
function WW_Stop(t, caster)
    if (caster ~= nil) then
        SaveBoolean(WW_Hash, GetHandleId(caster), 0, false)
    end
    FlushChildHashtable(WW_Hash, GetHandleId(t))
    PauseTimer(t)
    DestroyTimer(t)
end

function WW_CreateSpawn(caster)
    local spawned = CreateUnit(GetOwningPlayer(caster), WW_SPAWN_ID, GetUnitX(caster), GetUnitY(caster), GetUnitFacing(caster))
    UnitApplyTimedLife(spawned, FourCC("BTLF"), WW_SPAWN_LIFE)
    spawned = nil
end

function WW_Loop()
    local t = GetExpiredTimer()
    local caster = LoadUnitHandle(WW_Hash, GetHandleId(t), 0)
    if (caster == nil) then
        WW_Stop(t, caster)
        t = nil
        caster = nil
        return
    end
    if (GetWidgetLife(caster) <= __jreal(0.405)) then
        WW_Stop(t, caster)
        t = nil
        caster = nil
        return
    end
    if (GetUnitAbilityLevel(caster, WW_BUFF_ID) <= 0) then
        WW_Stop(t, caster)
        t = nil
        caster = nil
        return
    end
    WW_CreateSpawn(caster)
    caster = nil
    t = nil
end

function WW_Conditions()
    return (GetSpellAbilityId() == WW_ABILITY_ID)
end

function WW_Actions()
    local caster = GetTriggerUnit()
    local casterId = GetHandleId(caster)
    local t = nil
    if LoadBoolean(WW_Hash, casterId, 0) then
        caster = nil
        return
    end
    SaveBoolean(WW_Hash, casterId, 0, true)
    WW_CreateSpawn(caster)
    t = CreateTimer()
    SaveUnitHandle(WW_Hash, GetHandleId(t), 0, caster)
    TimerStart(t, WW_PERIOD, true, WW_Loop)
    t = nil
    caster = nil
end

function InitTrig_WindWalkWispari()
    local trg = CreateTrigger()
    local i = 0
    while true do
        if (i >= bj_MAX_PLAYER_SLOTS) then break end
        TriggerRegisterPlayerUnitEvent(trg, Player(i), EVENT_PLAYER_UNIT_SPELL_EFFECT, nil)
        i = __jint(i + 1)
    end
    TriggerAddCondition(trg, Condition(WW_Conditions))
    TriggerAddAction(trg, WW_Actions)
    trg = nil
end
-- END FOREST SECTION 190

-- BEGIN FOREST SECTION 191 TornadoMove
function Tornado_Clear_Caster(caster)
    if (caster ~= nil) then
        FlushChildHashtable(udg_TornadoHash, GetHandleId(caster))
    end
end

function Tornado_Begin_Death(t)
    local id = GetHandleId(t)
    local fx = LoadEffectHandle(udg_TornadoHash, id, TORNADO_KEY_EFFECT)
    local caster = LoadUnitHandle(udg_TornadoHash, id, TORNADO_KEY_CASTER)
    if LoadBoolean(udg_TornadoHash, id, TORNADO_KEY_DYING) then
        fx = nil
        caster = nil
        t = nil
        return
    end
    SaveBoolean(udg_TornadoHash, id, TORNADO_KEY_DYING, true)
    if (caster ~= nil) then
        Tornado_Clear_Caster(caster)
    end
    if (fx ~= nil) then
        DestroyEffect(fx)
    end
    FlushChildHashtable(udg_TornadoHash, id)
    PauseTimer(t)
    DestroyTimer(t)
    fx = nil
    caster = nil
    t = nil
end

function Tornado_Caster_Channel_Broken(caster, startX, startY)
    local dx = 0.0
    local dy = 0.0
    if (caster == nil) then
        return true
    end
    if (GetWidgetLife(caster) <= __jreal(0.405)) then
        return true
    end
    if IsUnitPaused(caster) then
        return true
    end
    if IsUnitType(caster, UNIT_TYPE_STUNNED) then
        return true
    end
    if IsUnitType(caster, UNIT_TYPE_POLYMORPHED) then
        return true
    end
    if IsUnitType(caster, UNIT_TYPE_SLEEPING) then
        return true
    end
    dx = __jreal(GetUnitX(caster) - startX)
    dy = __jreal(GetUnitY(caster) - startY)
    return (__jreal(__jreal(dx * dx) + __jreal(dy * dy)) > __jreal(TORNADO_MOVE_TOLERANCE * TORNADO_MOVE_TOLERANCE))
end

function Tornado_Line_Loop()
    local t = GetExpiredTimer()
    local id = GetHandleId(t)
    local fx = LoadEffectHandle(udg_TornadoHash, id, TORNADO_KEY_EFFECT)
    local caster = LoadUnitHandle(udg_TornadoHash, id, TORNADO_KEY_CASTER)
    local x = LoadReal(udg_TornadoHash, id, TORNADO_KEY_X)
    local y = LoadReal(udg_TornadoHash, id, TORNADO_KEY_Y)
    local angle = LoadReal(udg_TornadoHash, id, TORNADO_KEY_ANGLE)
    local traveled = LoadReal(udg_TornadoHash, id, TORNADO_KEY_TRAVELED)
    local maxDistance = LoadReal(udg_TornadoHash, id, TORNADO_KEY_MAX_DISTANCE)
    local speed = LoadReal(udg_TornadoHash, id, TORNADO_KEY_SPEED)
    local channelActive = LoadBoolean(udg_TornadoHash, id, TORNADO_KEY_CHANNEL_ACTIVE)
    local channelLeft = LoadReal(udg_TornadoHash, id, TORNADO_KEY_CHANNEL_LEFT)
    local startX = LoadReal(udg_TornadoHash, id, TORNADO_KEY_START_X)
    local startY = LoadReal(udg_TornadoHash, id, TORNADO_KEY_START_Y)
    local step = __jreal(speed * TORNADO_PERIOD)
    local nextX = 0.0
    local nextY = 0.0
    if (fx == nil) then
        FlushChildHashtable(udg_TornadoHash, id)
        PauseTimer(t)
        DestroyTimer(t)
        caster = nil
        t = nil
        return
    end
    if (channelActive and Tornado_Caster_Channel_Broken(caster, startX, startY)) then
        Tornado_Begin_Death(t)
        fx = nil
        caster = nil
        t = nil
        return
    end
    if (__jreal(traveled + step) > maxDistance) then
        step = __jreal(maxDistance - traveled)
    end
    nextX = __jreal(x + __jreal(step * Cos(angle)))
    nextY = __jreal(y + __jreal(step * Sin(angle)))
    x = nextX
    y = nextY
    traveled = __jreal(traveled + step)
    BlzSetSpecialEffectPosition(fx, x, y, __jreal(0.00))
    if channelActive then
        channelLeft = __jreal(channelLeft - TORNADO_PERIOD)
        if (channelLeft < __jreal(0.00)) then
            channelLeft = __jreal(0.00)
        end
        SaveReal(udg_TornadoHash, id, TORNADO_KEY_CHANNEL_LEFT, channelLeft)
    end
    if (traveled >= maxDistance) then
        Tornado_Begin_Death(t)
    else
        SaveReal(udg_TornadoHash, id, TORNADO_KEY_X, x)
        SaveReal(udg_TornadoHash, id, TORNADO_KEY_Y, y)
        SaveReal(udg_TornadoHash, id, TORNADO_KEY_TRAVELED, traveled)
    end
    fx = nil
    caster = nil
    t = nil
end

function Tornado_Line_Actions()
    local caster = GetTriggerUnit()
    local casterId = GetHandleId(caster)
    local level = GetUnitAbilityLevel(caster, TORNADO_ABILITY_ID)
    local casterX = GetUnitX(caster)
    local casterY = GetUnitY(caster)
    local x = casterX
    local y = casterY
    local targetX = GetSpellTargetX()
    local targetY = GetSpellTargetY()
    local dx = __jreal(targetX - casterX)
    local dy = __jreal(targetY - casterY)
    local angle = Atan2(dy, dx)
    local maxDistance = __jreal(__jreal(550.00) + __jreal(I2R(level) * __jreal(100.00)))
    local channelTime = __jreal(TORNADO_CHANNEL_BASE + __jreal(TORNADO_CHANNEL_PER_LEVEL * I2R(level)))
    local speed = 0.0
    local fx = nil
    local t = nil
    local old = LoadTimerHandle(udg_TornadoHash, casterId, TORNADO_CASTER_KEY_TIMER)
    local id = 0
    if (old ~= nil) then
        Tornado_Begin_Death(old)
    end
    if (channelTime <= __jreal(0.00)) then
        channelTime = TORNADO_PERIOD
    end
    speed = __jreal(maxDistance / channelTime)
    fx = AddSpecialEffect(TORNADO_MODEL_PATH, x, y)
    BlzSetSpecialEffectScale(fx, TORNADO_EFFECT_SCALE)
    BlzSetSpecialEffectOrientation(fx, angle, __jreal(0.00), __jreal(0.00))
    BlzSetSpecialEffectPosition(fx, x, y, __jreal(0.00))
    BlzPlaySpecialEffect(fx, ANIM_TYPE_STAND)
    t = CreateTimer()
    id = GetHandleId(t)
    SaveEffectHandle(udg_TornadoHash, id, TORNADO_KEY_EFFECT, fx)
    SaveReal(udg_TornadoHash, id, TORNADO_KEY_X, x)
    SaveReal(udg_TornadoHash, id, TORNADO_KEY_Y, y)
    SaveReal(udg_TornadoHash, id, TORNADO_KEY_ANGLE, angle)
    SaveReal(udg_TornadoHash, id, TORNADO_KEY_TRAVELED, __jreal(0.00))
    SaveReal(udg_TornadoHash, id, TORNADO_KEY_MAX_DISTANCE, maxDistance)
    SaveUnitHandle(udg_TornadoHash, id, TORNADO_KEY_CASTER, caster)
    SaveBoolean(udg_TornadoHash, id, TORNADO_KEY_CHANNEL_ACTIVE, true)
    SaveReal(udg_TornadoHash, id, TORNADO_KEY_CHANNEL_LEFT, channelTime)
    SaveReal(udg_TornadoHash, id, TORNADO_KEY_START_X, casterX)
    SaveReal(udg_TornadoHash, id, TORNADO_KEY_START_Y, casterY)
    SaveReal(udg_TornadoHash, id, TORNADO_KEY_SPEED, speed)
    SaveBoolean(udg_TornadoHash, id, TORNADO_KEY_DYING, false)
    SaveTimerHandle(udg_TornadoHash, casterId, TORNADO_CASTER_KEY_TIMER, t)
    TimerStart(t, TORNADO_PERIOD, true, Tornado_Line_Loop)
    caster = nil
    fx = nil
    t = nil
    old = nil
end

function Tornado_Line_Endcast_Actions()
    local caster = GetTriggerUnit()
    local casterId = GetHandleId(caster)
    local t = LoadTimerHandle(udg_TornadoHash, casterId, TORNADO_CASTER_KEY_TIMER)
    local id = 0
    local channelLeft = __jreal(0.00)
    if (t ~= nil) then
        id = GetHandleId(t)
        channelLeft = LoadReal(udg_TornadoHash, id, TORNADO_KEY_CHANNEL_LEFT)
        if (channelLeft > TORNADO_ENDCAST_TOLERANCE) then
            Tornado_Begin_Death(t)
        else
            Tornado_Clear_Caster(caster)
            SaveBoolean(udg_TornadoHash, id, TORNADO_KEY_CHANNEL_ACTIVE, false)
            RemoveSavedHandle(udg_TornadoHash, id, TORNADO_KEY_CASTER)
        end
    end
    caster = nil
    t = nil
end

function Tornado_Line_Conditions()
    return (GetSpellAbilityId() == TORNADO_ABILITY_ID)
end

function InitTrig_TornadoMove()
    local trg = CreateTrigger()
    local endTrg = CreateTrigger()
    if (udg_TornadoHash == nil) then
        udg_TornadoHash = InitHashtable()
    end
    TriggerRegisterAnyUnitEventBJ(trg, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(trg, Condition(Tornado_Line_Conditions))
    TriggerAddAction(trg, Tornado_Line_Actions)
    TriggerRegisterAnyUnitEventBJ(endTrg, EVENT_PLAYER_UNIT_SPELL_ENDCAST)
    TriggerAddCondition(endTrg, Condition(Tornado_Line_Conditions))
    TriggerAddAction(endTrg, Tornado_Line_Endcast_Actions)
    trg = nil
    endTrg = nil
end
-- END FOREST SECTION 191
