-- ancients / avalanche
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 176 Chill
-- Original JASS function: Trig_Chill_Conditions (line 12003)
function Trig_Chill_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A00A"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Chill_Actions (line 12010)
function Trig_Chill_Actions()
    local caster = GetSpellAbilityUnit()
    TriggerSleepAction(__jreal(0.80))
    SetUnitLifeBJ(caster, (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, caster) + (__jreal(__jreal(0.50) * GetUnitStateSwap(UNIT_STATE_MAX_MANA, caster))))))
end

-- Original JASS function: InitTrig_Chill (line 12016)
function InitTrig_Chill()
    gg_trg_Chill = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Chill, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Chill, Condition(Trig_Chill_Conditions))
    TriggerAddAction(gg_trg_Chill, Trig_Chill_Actions)
end
-- END FOREST SECTION 176

-- BEGIN FOREST SECTION 177 Freeze_Zone
-- Original JASS function: Trig_Freeze_Zone_Conditions (line 12026)
function Trig_Freeze_Zone_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A0EX"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Freeze_Zone_Actions (line 12033)
function Trig_Freeze_Zone_Actions()
    local timer = CreateTimer()
    TimerStart(timer, 60, false, nil)
    local dialog = CreateTimerDialog(timer)
    TimerDialogSetTitle(dialog, "TRIGSTR_7241")
    TimerDialogDisplay(dialog, true)
    TriggerSleepAction(__jreal(60))
    DestroyTimerDialog(dialog)
    DestroyTimer(timer)
end

-- Original JASS function: InitTrig_Freeze_Zone (line 12041)
function InitTrig_Freeze_Zone()
    gg_trg_Freeze_Zone = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Freeze_Zone, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Freeze_Zone, Condition(Trig_Freeze_Zone_Conditions))
    TriggerAddAction(gg_trg_Freeze_Zone, Trig_Freeze_Zone_Actions)
end
-- END FOREST SECTION 177

-- BEGIN FOREST SECTION 178 Freeze_Zone_V2
-- Original JASS function: TP_IsValidTarget (line 12054)
function TP_IsValidTarget(caster, target)
    do return (((((((target ~= nil) and (target ~= caster)) and (GetWidgetLife(target) > __jreal(0.405))) and IsUnitEnemy(target, GetOwningPlayer(caster))) and (not IsUnitType(target, UNIT_TYPE_DEAD))) and (not IsUnitType(target, UNIT_TYPE_STRUCTURE))) and (not IsUnitType(target, UNIT_TYPE_MAGIC_IMMUNE))) end
end

-- Original JASS function: TP_DummyCastDelayed (line 12058)
function TP_DummyCastDelayed()
    local t = GetExpiredTimer()
    local tid = GetHandleId(t)
    local dummy = LoadUnitHandle(TP_HASH, tid, 0)
    local target = LoadUnitHandle(TP_HASH, tid, 1)
    if (((dummy ~= nil) and (target ~= nil)) and (GetWidgetLife(target) > __jreal(0.405))) then
        IssueTargetOrder(dummy, TP_DEBUFF_ORDER, target)
        UnitApplyTimedLife(dummy, FourCC("BTLF"), TP_DUMMY_LIFETIME)
    elseif (dummy ~= nil) then
        UnitApplyTimedLife(dummy, FourCC("BTLF"), TP_DUMMY_LIFETIME)
    end
    FlushChildHashtable(TP_HASH, tid)
    DestroyTimer(t)
    target = nil
    dummy = nil
    t = nil
end

-- Original JASS function: TP_CastDebuff (line 12079)
function TP_CastDebuff(target, level)
    local t = CreateTimer()
    local tid = GetHandleId(t)
    local dummy = CreateUnit(TP_DUMMY_OWNER, TP_DUMMY_ID, __jreal(GetUnitX(target) + __jreal(150.00)), GetUnitY(target), __jreal(0.00))
    if (dummy == nil) then
        DestroyTimer(t)
        dummy = nil
        t = nil
        do return end
    end
    UnitAddAbility(dummy, TP_DEBUFF_ID)
    SetUnitAbilityLevel(dummy, TP_DEBUFF_ID, level)
    SetUnitState(dummy, UNIT_STATE_MANA, __jreal(9999.00))
    SaveUnitHandle(TP_HASH, tid, 0, dummy)
    SaveUnitHandle(TP_HASH, tid, 1, target)
    TimerStart(t, TP_DUMMY_CAST_DELAY, false, TP_DummyCastDelayed)
    dummy = nil
    t = nil
end

-- Original JASS function: TP_OnCast (line 12104)
function TP_OnCast()
    local caster = GetTriggerUnit()
    local g = CreateGroup()
    local target = nil
    local x = GetUnitX(caster)
    local y = GetUnitY(caster)
    local level = GetUnitAbilityLevel(caster, TP_SPELL_ID)
    local damage = __jreal(TP_DAMAGE_BASE + __jreal(TP_DAMAGE_PER_LEVEL * I2R(__jint(level - 1))))
    GroupEnumUnitsInRange(g, x, y, TP_AOE, nil)
    while true do
        target = FirstOfGroup(g)
        if (target == nil) then break end
        GroupRemoveUnit(g, target)
        if TP_IsValidTarget(caster, target) then
            UnitDamageTarget(caster, target, damage, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
            if (GetWidgetLife(target) > __jreal(0.405)) then
                TP_CastDebuff(target, level)
            end
        end
    end
    DestroyGroup(g)
    target = nil
    g = nil
    caster = nil
end

-- Original JASS function: TP_Condition (line 12136)
function TP_Condition()
    do return (GetSpellAbilityId() == TP_SPELL_ID) end
end

-- Original JASS function: InitTrig_Freeze_Zone_V2 (line 12140)
function InitTrig_Freeze_Zone_V2()
    local t = CreateTrigger()
    local i = 0
    if (TP_HASH == nil) then
        TP_HASH = InitHashtable()
    end
    while true do
        if (i >= bj_MAX_PLAYER_SLOTS) then break end
        TriggerRegisterPlayerUnitEvent(t, Player(i), EVENT_PLAYER_UNIT_SPELL_EFFECT, nil)
        i = __jint(i + 1)
    end
    TriggerAddCondition(t, Condition(TP_Condition))
    TriggerAddAction(t, TP_OnCast)
    t = nil
end
-- END FOREST SECTION 178
