function PassiveMissiles__IsAlive(u)
    return (((u ~= nil) and (GetWidgetLife(u) > __jreal(0.405))) and (not IsUnitType(u, UNIT_TYPE_DEAD)))
end

function PassiveMissiles__IsValidTargetForCaster(caster, target)
    local owner = nil
    local ok = false
    if ((caster == nil) or (target == nil)) then
        return false
    end
    owner = GetOwningPlayer(caster)
    ok = ((((PassiveMissiles__IsAlive(target) and IsUnitEnemy(target, owner)) and IsUnitVisible(target, owner)) and (not BlzIsUnitInvulnerable(target))) and (not IsUnitType(target, UNIT_TYPE_MAGIC_IMMUNE)))
    owner = nil
    return ok
end

function PassiveMissiles__TargetFilter()
    local u = GetFilterUnit()
    local ok = PassiveMissiles__IsValidTargetForCaster(PassiveMissiles__PM_Source, u)
    u = nil
    return ok
end

function PassiveMissiles__PickRandomTarget(caster)
    local u = nil
    local result = nil
    local count = 0
    PassiveMissiles__PM_Source = caster
    GroupEnumUnitsInRange(PassiveMissiles__PM_EnumGroup, GetUnitX(caster), GetUnitY(caster), PassiveMissiles__PM_RANGE, Condition(PassiveMissiles__TargetFilter))
    while true do
        u = FirstOfGroup(PassiveMissiles__PM_EnumGroup)
        if (u == nil) then break end
        GroupRemoveUnit(PassiveMissiles__PM_EnumGroup, u)
        count = __jint(count + 1)
        if (GetRandomInt(1, count) == 1) then
            result = u
        end
    end
    u = nil
    return result
end

function PassiveMissiles__GetProjectileCount(caster)
    local id = 0
    local owner = nil
    local level = 0
    if (caster == nil) then
        return 0
    end
    id = GetHandleId(caster)
    owner = LoadUnitHandle(PassiveMissiles__PM_Hash, id, PassiveMissiles__PM_KEY_TORNADO_OWNER)
    if (owner ~= nil) then
        level = GetUnitAbilityLevel(owner, PassiveMissiles__PM_ABILITY_ID)
        if (level <= 0) then
            level = LoadInteger(PassiveMissiles__PM_Hash, id, PassiveMissiles__PM_KEY_TORNADO_BASE_LEVEL)
        end
        owner = nil
        return level
    end
    return GetUnitAbilityLevel(caster, PassiveMissiles__PM_ABILITY_ID)
end

function PassiveMissiles__GetMissileDamageSource(caster)
    local owner = nil
    if (caster == nil) then
        return nil
    end
    owner = LoadUnitHandle(PassiveMissiles__PM_Hash, GetHandleId(caster), PassiveMissiles__PM_KEY_TORNADO_OWNER)
    if ((owner ~= nil) and PassiveMissiles__IsAlive(owner)) then
        return owner
    end
    return caster
end

function PassiveMissiles__DealMissileDamage(source, target)
    local damage = PassiveMissiles__PM_DAMAGE
    if (source == nil) then
        return
    end
    if IsUnitType(target, UNIT_TYPE_STRUCTURE) then
        damage = __jreal(PassiveMissiles__PM_DAMAGE * PassiveMissiles__PM_STRUCTURE_DAMAGE_MULTIPLIER)
    end
    UnitDamageTarget(source, target, damage, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, nil)
end

function PassiveMissiles__StartMissileSound(i)
    PassiveMissiles__PM_Sound[i] = CreateSound(PassiveMissiles__PM_LOOP_SOUND_FILE, true, true, true, PassiveMissiles__PM_SOUND_FADE_IN_RATE, PassiveMissiles__PM_SOUND_FADE_OUT_RATE, "SpellsEAX")
    SetSoundVolume(PassiveMissiles__PM_Sound[i], PassiveMissiles__PM_LOOP_SOUND_VOLUME)
    SetSoundDistances(PassiveMissiles__PM_Sound[i], PassiveMissiles__PM_SOUND_MIN_DIST, PassiveMissiles__PM_SOUND_MAX_DIST)
    SetSoundDistanceCutoff(PassiveMissiles__PM_Sound[i], PassiveMissiles__PM_SOUND_MAX_DIST)
    SetSoundPosition(PassiveMissiles__PM_Sound[i], PassiveMissiles__PM_X[i], PassiveMissiles__PM_Y[i], PassiveMissiles__PM_Z[i])
    StartSound(PassiveMissiles__PM_Sound[i])
end

function PassiveMissiles__StopMissileSound(i)
    if (PassiveMissiles__PM_Sound[i] ~= nil) then
        StopSound(PassiveMissiles__PM_Sound[i], true, true)
        PassiveMissiles__PM_Sound[i] = nil
    end
end

function PassiveMissiles__PlayDeathSoundAt(x, y, z)
    local s = CreateSound(PassiveMissiles__PM_DEATH_SOUND_FILE, false, true, true, PassiveMissiles__PM_SOUND_FADE_IN_RATE, PassiveMissiles__PM_SOUND_FADE_OUT_RATE, "SpellsEAX")
    SetSoundVolume(s, PassiveMissiles__PM_DEATH_SOUND_VOLUME)
    SetSoundDistances(s, PassiveMissiles__PM_SOUND_MIN_DIST, PassiveMissiles__PM_SOUND_MAX_DIST)
    SetSoundDistanceCutoff(s, PassiveMissiles__PM_SOUND_MAX_DIST)
    SetSoundPosition(s, x, y, z)
    StartSound(s)
    KillSoundWhenDone(s)
    s = nil
end

function PassiveMissiles__RemoveMissile(i)
    PassiveMissiles__StopMissileSound(i)
    DestroyEffect(PassiveMissiles__PM_Fx[i])
    PassiveMissiles__PM_Fx[i] = PassiveMissiles__PM_Fx[PassiveMissiles__PM_Count]
    PassiveMissiles__PM_Sound[i] = PassiveMissiles__PM_Sound[PassiveMissiles__PM_Count]
    PassiveMissiles__PM_Caster[i] = PassiveMissiles__PM_Caster[PassiveMissiles__PM_Count]
    PassiveMissiles__PM_DamageSource[i] = PassiveMissiles__PM_DamageSource[PassiveMissiles__PM_Count]
    PassiveMissiles__PM_Target[i] = PassiveMissiles__PM_Target[PassiveMissiles__PM_Count]
    PassiveMissiles__PM_X[i] = PassiveMissiles__PM_X[PassiveMissiles__PM_Count]
    PassiveMissiles__PM_Y[i] = PassiveMissiles__PM_Y[PassiveMissiles__PM_Count]
    PassiveMissiles__PM_Z[i] = PassiveMissiles__PM_Z[PassiveMissiles__PM_Count]
    PassiveMissiles__PM_Fx[PassiveMissiles__PM_Count] = nil
    PassiveMissiles__PM_Sound[PassiveMissiles__PM_Count] = nil
    PassiveMissiles__PM_Caster[PassiveMissiles__PM_Count] = nil
    PassiveMissiles__PM_DamageSource[PassiveMissiles__PM_Count] = nil
    PassiveMissiles__PM_Target[PassiveMissiles__PM_Count] = nil
    PassiveMissiles__PM_Count = __jint(PassiveMissiles__PM_Count - 1)
    if (PassiveMissiles__PM_Count == 0) then
        PauseTimer(PassiveMissiles__PM_MoveTimer)
    end
end

function PassiveMissiles__MoveMissiles()
    local i = 1
    local caster = nil
    local source = nil
    local target = nil
    local tx = 0.0
    local ty = 0.0
    local tz = 0.0
    local dx = 0.0
    local dy = 0.0
    local dz = 0.0
    local dist = 0.0
    local step = 0.0
    local yaw = 0.0
    while true do
        if (i > PassiveMissiles__PM_Count) then break end
        caster = PassiveMissiles__PM_Caster[i]
        source = PassiveMissiles__PM_DamageSource[i]
        target = PassiveMissiles__PM_Target[i]
        if (((caster == nil) or (target == nil)) or (not PassiveMissiles__IsValidTargetForCaster(caster, target))) then
            PassiveMissiles__RemoveMissile(i)
        else
            tx = GetUnitX(target)
            ty = GetUnitY(target)
            tz = __jreal(BlzGetUnitZ(target) + PassiveMissiles__PM_HEIGHT)
            dx = __jreal(tx - PassiveMissiles__PM_X[i])
            dy = __jreal(ty - PassiveMissiles__PM_Y[i])
            dz = __jreal(tz - PassiveMissiles__PM_Z[i])
            dist = SquareRoot(__jreal(__jreal(dx * dx) + __jreal(dy * dy)))
            step = __jreal(PassiveMissiles__PM_SPEED * PassiveMissiles__PM_TICK)
            if (dist <= step) then
                BlzSetSpecialEffectPosition(PassiveMissiles__PM_Fx[i], tx, ty, tz)
                if (PassiveMissiles__PM_Sound[i] ~= nil) then
                    SetSoundPosition(PassiveMissiles__PM_Sound[i], tx, ty, tz)
                    PassiveMissiles__PlayDeathSoundAt(tx, ty, tz)
                end
                if ((source == nil) or (not PassiveMissiles__IsAlive(source))) then
                    source = caster
                end
                PassiveMissiles__DealMissileDamage(source, target)
                PassiveMissiles__RemoveMissile(i)
            else
                yaw = Atan2(dy, dx)
                PassiveMissiles__PM_X[i] = __jreal(PassiveMissiles__PM_X[i] + __jreal(__jreal(dx / dist) * step))
                PassiveMissiles__PM_Y[i] = __jreal(PassiveMissiles__PM_Y[i] + __jreal(__jreal(dy / dist) * step))
                PassiveMissiles__PM_Z[i] = __jreal(PassiveMissiles__PM_Z[i] + __jreal(__jreal(dz / dist) * step))
                BlzSetSpecialEffectPosition(PassiveMissiles__PM_Fx[i], PassiveMissiles__PM_X[i], PassiveMissiles__PM_Y[i], PassiveMissiles__PM_Z[i])
                BlzSetSpecialEffectYaw(PassiveMissiles__PM_Fx[i], yaw)
                if (PassiveMissiles__PM_Sound[i] ~= nil) then
                    SetSoundPosition(PassiveMissiles__PM_Sound[i], PassiveMissiles__PM_X[i], PassiveMissiles__PM_Y[i], PassiveMissiles__PM_Z[i])
                end
                i = __jint(i + 1)
            end
        end
    end
    caster = nil
    source = nil
    target = nil
end

function PassiveMissiles__LaunchMissile(caster, target, playSound)
    PassiveMissiles__PM_Count = __jint(PassiveMissiles__PM_Count + 1)
    PassiveMissiles__PM_Caster[PassiveMissiles__PM_Count] = caster
    PassiveMissiles__PM_DamageSource[PassiveMissiles__PM_Count] = PassiveMissiles__GetMissileDamageSource(caster)
    PassiveMissiles__PM_Target[PassiveMissiles__PM_Count] = target
    PassiveMissiles__PM_X[PassiveMissiles__PM_Count] = GetUnitX(caster)
    PassiveMissiles__PM_Y[PassiveMissiles__PM_Count] = GetUnitY(caster)
    PassiveMissiles__PM_Z[PassiveMissiles__PM_Count] = __jreal(BlzGetUnitZ(caster) + PassiveMissiles__PM_HEIGHT)
    PassiveMissiles__PM_Fx[PassiveMissiles__PM_Count] = AddSpecialEffect(PassiveMissiles__PM_MODEL, PassiveMissiles__PM_X[PassiveMissiles__PM_Count], PassiveMissiles__PM_Y[PassiveMissiles__PM_Count])
    BlzSetSpecialEffectScale(PassiveMissiles__PM_Fx[PassiveMissiles__PM_Count], PassiveMissiles__PM_MODEL_SCALE)
    BlzSetSpecialEffectPosition(PassiveMissiles__PM_Fx[PassiveMissiles__PM_Count], PassiveMissiles__PM_X[PassiveMissiles__PM_Count], PassiveMissiles__PM_Y[PassiveMissiles__PM_Count], PassiveMissiles__PM_Z[PassiveMissiles__PM_Count])
    PassiveMissiles__PM_Sound[PassiveMissiles__PM_Count] = nil
    if playSound then
        PassiveMissiles__StartMissileSound(PassiveMissiles__PM_Count)
    end
    if (PassiveMissiles__PM_Count == 1) then
        TimerStart(PassiveMissiles__PM_MoveTimer, PassiveMissiles__PM_TICK, true, PassiveMissiles__MoveMissiles)
    end
end

function PassiveMissiles__LaunchOneFromVolley(caster, playSound)
    local target = nil
    if (((caster ~= nil) and PassiveMissiles__IsAlive(caster)) and (PassiveMissiles__GetProjectileCount(caster) > 0)) then
        target = PassiveMissiles__PickRandomTarget(caster)
        if (target ~= nil) then
            PassiveMissiles__LaunchMissile(caster, target, playSound)
            target = nil
            return true
        end
    end
    target = nil
    return false
end

function PassiveMissiles__ContinueVolley()
    local t = GetExpiredTimer()
    local id = GetHandleId(t)
    local caster = LoadUnitHandle(PassiveMissiles__PM_Hash, id, PassiveMissiles__PM_KEY_VOLLEY_CASTER)
    local remaining = LoadInteger(PassiveMissiles__PM_Hash, id, PassiveMissiles__PM_KEY_VOLLEY_REMAINING)
    PassiveMissiles__LaunchOneFromVolley(caster, false)
    remaining = __jint(remaining - 1)
    if ((((remaining > 0) and (caster ~= nil)) and PassiveMissiles__IsAlive(caster)) and (PassiveMissiles__GetProjectileCount(caster) > 0)) then
        SaveInteger(PassiveMissiles__PM_Hash, id, PassiveMissiles__PM_KEY_VOLLEY_REMAINING, remaining)
        TimerStart(t, PassiveMissiles__PM_LAUNCH_DELAY, false, PassiveMissiles__ContinueVolley)
    else
        FlushChildHashtable(PassiveMissiles__PM_Hash, id)
        DestroyTimer(t)
    end
    caster = nil
    t = nil
end

function PassiveMissiles__StartVolley(caster, count)
    local t = nil
    local id = 0
    if (count <= 0) then
        return
    end
    if (not PassiveMissiles__LaunchOneFromVolley(caster, true)) then
        return
    end
    if (count > 1) then
        t = CreateTimer()
        id = GetHandleId(t)
        SaveUnitHandle(PassiveMissiles__PM_Hash, id, PassiveMissiles__PM_KEY_VOLLEY_CASTER, caster)
        SaveInteger(PassiveMissiles__PM_Hash, id, PassiveMissiles__PM_KEY_VOLLEY_REMAINING, __jint(count - 1))
        TimerStart(t, PassiveMissiles__PM_LAUNCH_DELAY, false, PassiveMissiles__ContinueVolley)
    end
    t = nil
end

function PassiveMissiles__FireForCaster()
    local caster = GetEnumUnit()
    local count = PassiveMissiles__GetProjectileCount(caster)
    if ((not PassiveMissiles__IsAlive(caster)) or (count <= 0)) then
        GroupRemoveUnit(PassiveMissiles__PM_Casters, caster)
        FlushChildHashtable(PassiveMissiles__PM_Hash, GetHandleId(caster))
    else
        PassiveMissiles__StartVolley(caster, count)
    end
    caster = nil
end

function PassiveMissiles__PeriodicFire()
    ForGroup(PassiveMissiles__PM_Casters, PassiveMissiles__FireForCaster)
end

function PassiveMissiles__OnHeroSkill()
    if (GetLearnedSkill() == PassiveMissiles__PM_ABILITY_ID) then
        GroupAddUnit(PassiveMissiles__PM_Casters, GetTriggerUnit())
    end
    return false
end

function PassiveMissiles__OnSummon()
    local summoned = GetSummonedUnit()
    local summoner = GetSummoningUnit()
    local level = 0
    if (((summoned ~= nil) and (summoner ~= nil)) and (GetUnitTypeId(summoned) == PassiveMissiles__PM_TORNADO_UNIT_ID)) then
        level = GetUnitAbilityLevel(summoner, PassiveMissiles__PM_ABILITY_ID)
        if (level > 0) then
            SaveUnitHandle(PassiveMissiles__PM_Hash, GetHandleId(summoned), PassiveMissiles__PM_KEY_TORNADO_OWNER, summoner)
            SaveInteger(PassiveMissiles__PM_Hash, GetHandleId(summoned), PassiveMissiles__PM_KEY_TORNADO_BASE_LEVEL, level)
            GroupAddUnit(PassiveMissiles__PM_Casters, summoned)
        end
    end
    summoned = nil
    summoner = nil
    return false
end

function PassiveMissiles__RegisterExistingUnits()
    local g = CreateGroup()
    local u = nil
    GroupEnumUnitsInRect(g, bj_mapInitialPlayableArea, nil)
    while true do
        u = FirstOfGroup(g)
        if (u == nil) then break end
        GroupRemoveUnit(g, u)
        if (GetUnitAbilityLevel(u, PassiveMissiles__PM_ABILITY_ID) > 0) then
            GroupAddUnit(PassiveMissiles__PM_Casters, u)
        end
    end
    DestroyGroup(g)
    g = nil
    u = nil
end

function PassiveMissiles__Init()
    local skillTrigger = CreateTrigger()
    local summonTrigger = CreateTrigger()
    local i = 0
    while true do
        if (i >= bj_MAX_PLAYER_SLOTS) then break end
        TriggerRegisterPlayerUnitEvent(skillTrigger, Player(i), EVENT_PLAYER_HERO_SKILL, nil)
        TriggerRegisterPlayerUnitEvent(summonTrigger, Player(i), EVENT_PLAYER_UNIT_SUMMON, nil)
        i = __jint(i + 1)
    end
    TriggerAddCondition(skillTrigger, Condition(PassiveMissiles__OnHeroSkill))
    TriggerAddCondition(summonTrigger, Condition(PassiveMissiles__OnSummon))
    PassiveMissiles__RegisterExistingUnits()
    TimerStart(PassiveMissiles__PM_CastTimer, PassiveMissiles__PM_PERIOD, true, PassiveMissiles__PeriodicFire)
    skillTrigger = nil
    summonTrigger = nil
end
