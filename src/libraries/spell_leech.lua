-- Original JASS function: SpellLeech__ClockExpires (line 3153)
function SpellLeech__ClockExpires()
end

-- Original JASS function: SpellLeech__Now (line 3156)
function SpellLeech__Now()
    do return TimerGetElapsed(SpellLeech__SL_Clock) end
end

-- Original JASS function: SpellLeech__IsAlive (line 3160)
function SpellLeech__IsAlive(u)
    do return (((u ~= nil) and (GetWidgetLife(u) > __jreal(0.405))) and (not IsUnitType(u, UNIT_TYPE_DEAD))) end
end

-- Original JASS function: SpellLeech__GetDuration (line 3164)
function SpellLeech__GetDuration(level)
    do return __jreal(SpellLeech__SL_BASE_DURATION + __jreal(SpellLeech__SL_DURATION_PER_LEVEL * I2R(__jint(level - 1)))) end
end

-- Original JASS function: SpellLeech__ActivateLeech (line 3168)
function SpellLeech__ActivateLeech(caster, level)
    local expireTime = 0.0
    if ((caster == nil) or (level <= 0)) then
        do return end
    end
    expireTime = __jreal((TimerGetElapsed(SpellLeech__SL_Clock)) + (__jreal(SpellLeech__SL_BASE_DURATION + __jreal(SpellLeech__SL_DURATION_PER_LEVEL * I2R(__jint((level) - 1))))))
    SaveReal(SpellLeech__SL_Hash, GetHandleId(caster), 0, expireTime)
    DestroyEffect(AddSpecialEffectTarget(SpellLeech__SL_ACTIVATE_EFFECT, caster, "origin"))
end

-- Original JASS function: SpellLeech__IsLeechActive (line 3181)
function SpellLeech__IsLeechActive(caster)
    if (caster == nil) then
        do return false end
    end
    do return (LoadReal(SpellLeech__SL_Hash, GetHandleId(caster), 0) > (TimerGetElapsed(SpellLeech__SL_Clock))) end
end

-- Original JASS function: SpellLeech__IsValidLeechDamage (line 3189)
function SpellLeech__IsValidLeechDamage(source, target, damage)
    if (damage <= __jreal(0.00)) then
        do return false end
    end
    if (not SpellLeech__IsAlive(source)) then
        do return false end
    end
    if (target == nil) then
        do return false end
    end
    if (not SpellLeech__IsLeechActive(source)) then
        do return false end
    end
    if (SpellLeech__SL_ENEMY_ONLY and (not IsUnitEnemy(target, GetOwningPlayer(source)))) then
        do return false end
    end
    if (SpellLeech__SL_REQUIRE_NON_ATTACK and BlzGetEventIsAttack()) then
        do return false end
    end
    if (SpellLeech__SL_REQUIRE_DAMAGE_TYPE_MAGIC and (BlzGetEventDamageType() ~= DAMAGE_TYPE_MAGIC)) then
        do return false end
    end
    do return true end
end

-- Original JASS function: SpellLeech__HealUnit (line 3221)
function SpellLeech__HealUnit(u, amount)
    local life = 0.0
    local maxLife = 0.0
    if ((not SpellLeech__IsAlive(u)) or (amount <= __jreal(0.00))) then
        do return end
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

-- Original JASS function: SpellLeech__OnSpellEffect (line 3243)
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

-- Original JASS function: SpellLeech__OnDamage (line 3257)
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

-- Original JASS function: SpellLeech__Init (line 3272)
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
