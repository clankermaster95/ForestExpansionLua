function SpellLeech__ClockExpires()
end

function SpellLeech__Now()
    return TimerGetElapsed(SpellLeech__SL_Clock)
end

function SpellLeech__IsAlive(u)
    return (((u ~= nil) and (GetWidgetLife(u) > __jreal(0.405))) and (not IsUnitType(u, UNIT_TYPE_DEAD)))
end

function SpellLeech__GetDuration(level)
    return __jreal(SpellLeech__SL_BASE_DURATION + __jreal(SpellLeech__SL_DURATION_PER_LEVEL * I2R(__jint(level - 1))))
end

function SpellLeech__ActivateLeech(caster, level)
    local expireTime = 0.0
    if ((caster == nil) or (level <= 0)) then
        return
    end
    expireTime = __jreal((TimerGetElapsed(SpellLeech__SL_Clock)) + (__jreal(SpellLeech__SL_BASE_DURATION + __jreal(SpellLeech__SL_DURATION_PER_LEVEL * I2R(__jint((level) - 1))))))
    SaveReal(SpellLeech__SL_Hash, GetHandleId(caster), 0, expireTime)
    DestroyEffect(AddSpecialEffectTarget(SpellLeech__SL_ACTIVATE_EFFECT, caster, "origin"))
end

function SpellLeech__IsLeechActive(caster)
    if (caster == nil) then
        return false
    end
    return (LoadReal(SpellLeech__SL_Hash, GetHandleId(caster), 0) > (TimerGetElapsed(SpellLeech__SL_Clock)))
end

function SpellLeech__IsValidLeechDamage(source, target, damage)
    if (damage <= __jreal(0.00)) then
        return false
    end
    if (not SpellLeech__IsAlive(source)) then
        return false
    end
    if (target == nil) then
        return false
    end
    if (not SpellLeech__IsLeechActive(source)) then
        return false
    end
    if (SpellLeech__SL_ENEMY_ONLY and (not IsUnitEnemy(target, GetOwningPlayer(source)))) then
        return false
    end
    if (SpellLeech__SL_REQUIRE_NON_ATTACK and BlzGetEventIsAttack()) then
        return false
    end
    if (SpellLeech__SL_REQUIRE_DAMAGE_TYPE_MAGIC and (BlzGetEventDamageType() ~= DAMAGE_TYPE_MAGIC)) then
        return false
    end
    return true
end

function SpellLeech__HealUnit(u, amount)
    local life = 0.0
    local maxLife = 0.0
    if ((not SpellLeech__IsAlive(u)) or (amount <= __jreal(0.00))) then
        return
    end
    life = GetWidgetLife(u)
    maxLife = GetUnitState(u, UNIT_STATE_MAX_LIFE)
    if (__jreal(life + amount) > maxLife) then
        SetWidgetLife(u, maxLife)
    else
        SetWidgetLife(u, __jreal(life + amount))
    end
    if SpellLeech__SL_SHOW_HEAL_EFFECT then
        DestroyEffect(AddSpecialEffectTarget(SpellLeech__SL_HEAL_EFFECT, u, "origin"))
    end
end

function SpellLeech__OnSpellEffect()
    local caster = nil
    local level = 0
    if (GetSpellAbilityId() == SpellLeech__SL_ABILITY_ID) then
        caster = GetTriggerUnit()
        level = GetUnitAbilityLevel(caster, SpellLeech__SL_ABILITY_ID)
        SpellLeech__ActivateLeech(caster, level)
        caster = nil
    end
end

function SpellLeech__OnDamage()
    local target = GetTriggerUnit()
    local source = GetEventDamageSource()
    local damage = GetEventDamage()
    local healAmount = 0.0
    if SpellLeech__IsValidLeechDamage(source, target, damage) then
        healAmount = __jreal(damage * SpellLeech__SL_LEECH_FACTOR)
        SpellLeech__HealUnit(source, healAmount)
    end
    target = nil
    source = nil
end

function SpellLeech__Init()
    local spellTrigger = CreateTrigger()
    local damageTrigger = CreateTrigger()
    local i = 0
    TimerStart(SpellLeech__SL_Clock, __jreal(999999.00), false, SpellLeech__ClockExpires)
    while true do
        if (i >= bj_MAX_PLAYER_SLOTS) then break end
        TriggerRegisterPlayerUnitEvent(spellTrigger, Player(i), EVENT_PLAYER_UNIT_SPELL_EFFECT, nil)
        TriggerRegisterPlayerUnitEvent(damageTrigger, Player(i), EVENT_PLAYER_UNIT_DAMAGED, nil)
        i = __jint(i + 1)
    end
    TriggerAddAction(spellTrigger, SpellLeech__OnSpellEffect)
    TriggerAddAction(damageTrigger, SpellLeech__OnDamage)
    spellTrigger = nil
    damageTrigger = nil
end
