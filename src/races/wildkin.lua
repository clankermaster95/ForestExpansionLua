-- races / wildkin
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 137 Ancient_Artifact
-- Original JASS function: Trig_Ancient_Artifact_Conditions (line 10553)
function Trig_Ancient_Artifact_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A07D"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Ancient_Artifact_Actions (line 10560)
function Trig_Ancient_Artifact_Actions()
    SetUnitLifePercentBJ(GetSpellAbilityUnit(), (__jreal(GetUnitLifePercent(GetSpellAbilityUnit()) + __jreal(50.00))))
end

-- Original JASS function: InitTrig_Ancient_Artifact (line 10565)
function InitTrig_Ancient_Artifact()
    gg_trg_Ancient_Artifact = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Ancient_Artifact, EVENT_PLAYER_UNIT_SPELL_CAST)
    TriggerAddCondition(gg_trg_Ancient_Artifact, Condition(Trig_Ancient_Artifact_Conditions))
    TriggerAddAction(gg_trg_Ancient_Artifact, Trig_Ancient_Artifact_Actions)
end
-- END FOREST SECTION 137

-- BEGIN FOREST SECTION 138 Moonstrike
-- Original JASS function: Trig_Moonstrike_Conditions (line 10577)
function Trig_Moonstrike_Conditions()
    do return (GetSpellAbilityId() == FourCC("A07F")) end
end

-- Original JASS function: Trig_Moonstrike_Actions (line 10581)
function Trig_Moonstrike_Actions()
    local target = GetSpellTargetUnit()
    local caster = GetTriggerUnit()
    local damage = __jreal(GetUnitState(caster, UNIT_STATE_MAX_MANA) * __jreal(0.2))
    TriggerSleepAction(__jreal(0.25))
    if (((GetUnitTypeId(caster) ~= 0) and (GetUnitTypeId(target) ~= 0)) and (GetWidgetLife(target) > __jreal(0.405))) then
        UnitDamageTarget(caster, target, damage, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
    end
    target = nil
    caster = nil
end

-- Original JASS function: InitTrig_Moonstrike (line 10597)
function InitTrig_Moonstrike()
    gg_trg_Moonstrike = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Moonstrike, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Moonstrike, Condition(Trig_Moonstrike_Conditions))
    TriggerAddAction(gg_trg_Moonstrike, Trig_Moonstrike_Actions)
end
-- END FOREST SECTION 138

-- BEGIN FOREST SECTION 139 Moonstrike_Leveled
-- Original JASS function: Trig_Moonstrike_Leveled_Conditions (line 10606)
function Trig_Moonstrike_Leveled_Conditions()
    if ((not ((GetResearched() == FourCC("R051"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Moonstrike_Leveled_Func001002 (line 10613)
function Trig_Moonstrike_Leveled_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A07F"), GetEnumUnit())
end

-- Original JASS function: Trig_Moonstrike_Leveled_Actions (line 10617)
function Trig_Moonstrike_Leveled_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(GetTriggerPlayer(), FourCC("h010")), Trig_Moonstrike_Leveled_Func001002)
end

-- Original JASS function: InitTrig_Moonstrike_Leveled (line 10622)
function InitTrig_Moonstrike_Leveled()
    gg_trg_Moonstrike_Leveled = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Moonstrike_Leveled, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Moonstrike_Leveled, Condition(Trig_Moonstrike_Leveled_Conditions))
    TriggerAddAction(gg_trg_Moonstrike_Leveled, Trig_Moonstrike_Leveled_Actions)
end
-- END FOREST SECTION 139

-- BEGIN FOREST SECTION 140 Moonblast
-- Original JASS function: Trig_Moonblast_Conditions (line 10633)
function Trig_Moonblast_Conditions()
    do return (GetSpellAbilityId() == MOONBLAST_ABILITY_ID) end
end

-- Original JASS function: Trig_Moonblast_Cleanup (line 10637)
function Trig_Moonblast_Cleanup(t)
    local id = GetHandleId(t)
    local missile = LoadEffectHandle(udg_MoonblastHash, id, 2)
    DestroyEffect(missile)
    FlushChildHashtable(udg_MoonblastHash, id)
    PauseTimer(t)
    DestroyTimer(t)
    missile = nil
end

-- Original JASS function: Trig_Moonblast_Timer (line 10649)
function Trig_Moonblast_Timer()
    local t = GetExpiredTimer()
    local id = GetHandleId(t)
    local caster = LoadUnitHandle(udg_MoonblastHash, id, 0)
    local target = LoadUnitHandle(udg_MoonblastHash, id, 1)
    local missile = LoadEffectHandle(udg_MoonblastHash, id, 2)
    local damage = LoadReal(udg_MoonblastHash, id, 3)
    local x = LoadReal(udg_MoonblastHash, id, 4)
    local y = LoadReal(udg_MoonblastHash, id, 5)
    local tx = 0.0
    local ty = 0.0
    local dx = 0.0
    local dy = 0.0
    local dist = 0.0
    local step = __jreal(MOONBLAST_SPEED * MOONBLAST_TICK)
    if (((GetUnitTypeId(caster) == 0) or (GetUnitTypeId(target) == 0)) or (GetWidgetLife(target) <= __jreal(0.405))) then
        Trig_Moonblast_Cleanup(t)
    else
        tx = GetUnitX(target)
        ty = GetUnitY(target)
        dx = __jreal(tx - x)
        dy = __jreal(ty - y)
        dist = SquareRoot(__jreal(__jreal(dx * dx) + __jreal(dy * dy)))
        if ((dist <= MOONBLAST_COLLISION) or (dist <= step)) then
            BlzSetSpecialEffectX(missile, tx)
            BlzSetSpecialEffectY(missile, ty)
            UnitDamageTarget(caster, target, damage, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
            Trig_Moonblast_Cleanup(t)
        else
            x = __jreal(x + __jreal(__jreal(dx / dist) * step))
            y = __jreal(y + __jreal(__jreal(dy / dist) * step))
            SaveReal(udg_MoonblastHash, id, 4, x)
            SaveReal(udg_MoonblastHash, id, 5, y)
            BlzSetSpecialEffectX(missile, x)
            BlzSetSpecialEffectY(missile, y)
            BlzSetSpecialEffectYaw(missile, Atan2(dy, dx))
        end
    end
    caster = nil
    target = nil
    missile = nil
    t = nil
end

-- Original JASS function: Trig_Moonblast_Actions (line 10697)
function Trig_Moonblast_Actions()
    local target = GetSpellTargetUnit()
    local caster = GetTriggerUnit()
    local t = nil
    local id = 0
    local missile = nil
    local x = 0.0
    local y = 0.0
    local dx = 0.0
    local dy = 0.0
    if ((target == nil) or (caster == nil)) then
        target = nil
        caster = nil
        do return end
    end
    t = CreateTimer()
    id = GetHandleId(t)
    x = GetUnitX(caster)
    y = GetUnitY(caster)
    dx = __jreal(GetUnitX(target) - x)
    dy = __jreal(GetUnitY(target) - y)
    missile = AddSpecialEffect(MOONBLAST_MISSILE_MODEL, x, y)
    BlzSetSpecialEffectYaw(missile, Atan2(dy, dx))
    SaveUnitHandle(udg_MoonblastHash, id, 0, caster)
    SaveUnitHandle(udg_MoonblastHash, id, 1, target)
    SaveEffectHandle(udg_MoonblastHash, id, 2, missile)
    SaveReal(udg_MoonblastHash, id, 3, __jreal(GetUnitState(caster, UNIT_STATE_MAX_MANA) * MOONBLAST_DAMAGE_FACTOR))
    SaveReal(udg_MoonblastHash, id, 4, x)
    SaveReal(udg_MoonblastHash, id, 5, y)
    TimerStart(t, MOONBLAST_TICK, true, Trig_Moonblast_Timer)
    target = nil
    caster = nil
    missile = nil
    t = nil
end

-- Original JASS function: InitTrig_Moonblast (line 10740)
function InitTrig_Moonblast()
    gg_trg_Moonblast = CreateTrigger()
    if (udg_MoonblastHash == nil) then
        udg_MoonblastHash = InitHashtable()
    end
    TriggerRegisterAnyUnitEventBJ(gg_trg_Moonblast, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Moonblast, Condition(Trig_Moonblast_Conditions))
    TriggerAddAction(gg_trg_Moonblast, Trig_Moonblast_Actions)
end
-- END FOREST SECTION 140

-- BEGIN FOREST SECTION 141 Moonblast_Leveled
-- Original JASS function: Trig_Moonblast_Leveled_Conditions (line 10754)
function Trig_Moonblast_Leveled_Conditions()
    if ((not ((GetResearched() == FourCC("R051"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Moonblast_Leveled_Func001002 (line 10761)
function Trig_Moonblast_Leveled_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A07H"), GetEnumUnit())
end

-- Original JASS function: Trig_Moonblast_Leveled_Actions (line 10765)
function Trig_Moonblast_Leveled_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(GetTriggerPlayer(), FourCC("h010")), Trig_Moonblast_Leveled_Func001002)
end

-- Original JASS function: InitTrig_Moonblast_Leveled (line 10770)
function InitTrig_Moonblast_Leveled()
    gg_trg_Moonblast_Leveled = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Moonblast_Leveled, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Moonblast_Leveled, Condition(Trig_Moonblast_Leveled_Conditions))
    TriggerAddAction(gg_trg_Moonblast_Leveled, Trig_Moonblast_Leveled_Actions)
end
-- END FOREST SECTION 141

-- BEGIN FOREST SECTION 142 Lunar_Assault
-- Original JASS function: Trig_Lunar_Assault_Conditions (line 10782)
function Trig_Lunar_Assault_Conditions()
    do return (GetSpellAbilityId() == FourCC("A07I")) end
end

-- Original JASS function: Trig_Lunar_Assault_Actions (line 10786)
function Trig_Lunar_Assault_Actions()
    local target = GetSpellTargetUnit()
    local caster = GetTriggerUnit()
    local level = GetUnitAbilityLevel(caster, FourCC("A07I"))
    local factor = __jreal(__jreal(0.20) + __jreal(__jreal(0.10) * __jreal((__jint(level - 1)))))
    local damage = __jreal(GetUnitState(caster, UNIT_STATE_MAX_MANA) * factor)
    if (((GetUnitTypeId(caster) ~= 0) and (GetUnitTypeId(target) ~= 0)) and (GetWidgetLife(target) > __jreal(0.405))) then
        UnitDamageTarget(caster, target, damage, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
    end
    target = nil
    caster = nil
end

-- Original JASS function: InitTrig_Lunar_Assault (line 10802)
function InitTrig_Lunar_Assault()
    gg_trg_Lunar_Assault = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Lunar_Assault, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Lunar_Assault, Condition(Trig_Lunar_Assault_Conditions))
    TriggerAddAction(gg_trg_Lunar_Assault, Trig_Lunar_Assault_Actions)
end
-- END FOREST SECTION 142

-- BEGIN FOREST SECTION 143 Lunar_Assault_Leveled
-- Original JASS function: Trig_Lunar_Assault_Leveled_Conditions (line 10811)
function Trig_Lunar_Assault_Leveled_Conditions()
    if ((not ((GetResearched() == FourCC("R051"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Lunar_Assault_Leveled_Func001002 (line 10818)
function Trig_Lunar_Assault_Leveled_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A07I"), GetEnumUnit())
end

-- Original JASS function: Trig_Lunar_Assault_Leveled_Actions (line 10822)
function Trig_Lunar_Assault_Leveled_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(GetTriggerPlayer(), FourCC("h010")), Trig_Lunar_Assault_Leveled_Func001002)
end

-- Original JASS function: InitTrig_Lunar_Assault_Leveled (line 10827)
function InitTrig_Lunar_Assault_Leveled()
    gg_trg_Lunar_Assault_Leveled = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Lunar_Assault_Leveled, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Lunar_Assault_Leveled, Condition(Trig_Lunar_Assault_Leveled_Conditions))
    TriggerAddAction(gg_trg_Lunar_Assault_Leveled, Trig_Lunar_Assault_Leveled_Actions)
end
-- END FOREST SECTION 143

-- BEGIN FOREST SECTION 144 Cascade_Leveled
-- Original JASS function: Trig_Cascade_Leveled_Conditions (line 10837)
function Trig_Cascade_Leveled_Conditions()
    if ((not ((GetResearched() == FourCC("R051"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Cascade_Leveled_Func001002 (line 10844)
function Trig_Cascade_Leveled_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A07J"), GetEnumUnit())
end

-- Original JASS function: Trig_Cascade_Leveled_Actions (line 10848)
function Trig_Cascade_Leveled_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(GetTriggerPlayer(), FourCC("h010")), Trig_Cascade_Leveled_Func001002)
end

-- Original JASS function: InitTrig_Cascade_Leveled (line 10853)
function InitTrig_Cascade_Leveled()
    gg_trg_Cascade_Leveled = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Cascade_Leveled, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Cascade_Leveled, Condition(Trig_Cascade_Leveled_Conditions))
    TriggerAddAction(gg_trg_Cascade_Leveled, Trig_Cascade_Leveled_Actions)
end
-- END FOREST SECTION 144

-- BEGIN FOREST SECTION 145 Nourish
-- Original JASS function: Trig_Nourish_Conditions (line 10863)
function Trig_Nourish_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A07K"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Nourish_Actions (line 10870)
function Trig_Nourish_Actions()
    SetUnitLifeBJ(GetSpellTargetUnit(), (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, GetSpellTargetUnit()) + (__jreal(GetUnitStateSwap(UNIT_STATE_MAX_MANA, GetSpellAbilityUnit()) * __jreal(0.50))))))
end

-- Original JASS function: InitTrig_Nourish (line 10875)
function InitTrig_Nourish()
    gg_trg_Nourish = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Nourish, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Nourish, Condition(Trig_Nourish_Conditions))
    TriggerAddAction(gg_trg_Nourish, Trig_Nourish_Actions)
end
-- END FOREST SECTION 145

-- BEGIN FOREST SECTION 146 Nourish_Leveled
-- Original JASS function: Trig_Nourish_Leveled_Conditions (line 10885)
function Trig_Nourish_Leveled_Conditions()
    if ((not ((GetResearched() == FourCC("R051"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Nourish_Leveled_Func001002 (line 10892)
function Trig_Nourish_Leveled_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A07K"), GetEnumUnit())
end

-- Original JASS function: Trig_Nourish_Leveled_Actions (line 10896)
function Trig_Nourish_Leveled_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(GetTriggerPlayer(), FourCC("h010")), Trig_Nourish_Leveled_Func001002)
end

-- Original JASS function: InitTrig_Nourish_Leveled (line 10901)
function InitTrig_Nourish_Leveled()
    gg_trg_Nourish_Leveled = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Nourish_Leveled, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Nourish_Leveled, Condition(Trig_Nourish_Leveled_Conditions))
    TriggerAddAction(gg_trg_Nourish_Leveled, Trig_Nourish_Leveled_Actions)
end
-- END FOREST SECTION 146

-- BEGIN FOREST SECTION 147 Solar_Blast
-- Original JASS function: Trig_Solar_Blast_Conditions (line 10913)
function Trig_Solar_Blast_Conditions()
    do return (GetSpellAbilityId() == FourCC("A07L")) end
end

-- Original JASS function: Trig_Solar_Blast_Actions (line 10917)
function Trig_Solar_Blast_Actions()
    local target = GetSpellTargetUnit()
    local caster = GetTriggerUnit()
    local mana = GetUnitState(caster, UNIT_STATE_MANA)
    local damage = __jreal(mana * __jreal(1.33))
    if (((GetUnitTypeId(caster) ~= 0) and (GetUnitTypeId(target) ~= 0)) and (GetWidgetLife(target) > __jreal(0.405))) then
        UnitDamageTarget(caster, target, damage, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
    end
    if (GetUnitTypeId(caster) ~= 0) then
        SetUnitState(caster, UNIT_STATE_MANA, __jreal(0.00))
    end
    target = nil
    caster = nil
end

-- Original JASS function: InitTrig_Solar_Blast (line 10936)
function InitTrig_Solar_Blast()
    gg_trg_Solar_Blast = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Solar_Blast, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Solar_Blast, Condition(Trig_Solar_Blast_Conditions))
    TriggerAddAction(gg_trg_Solar_Blast, Trig_Solar_Blast_Actions)
end
-- END FOREST SECTION 147

-- BEGIN FOREST SECTION 148 Natural_Vigil_Leveled
-- Original JASS function: Trig_Natural_Vigil_Leveled_Conditions (line 10945)
function Trig_Natural_Vigil_Leveled_Conditions()
    if ((not ((GetResearched() == FourCC("R051"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Natural_Vigil_Leveled_Func001002 (line 10952)
function Trig_Natural_Vigil_Leveled_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A07M"), GetEnumUnit())
end

-- Original JASS function: Trig_Natural_Vigil_Leveled_Actions (line 10956)
function Trig_Natural_Vigil_Leveled_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(GetTriggerPlayer(), FourCC("h010")), Trig_Natural_Vigil_Leveled_Func001002)
end

-- Original JASS function: InitTrig_Natural_Vigil_Leveled (line 10961)
function InitTrig_Natural_Vigil_Leveled()
    gg_trg_Natural_Vigil_Leveled = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Natural_Vigil_Leveled, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Natural_Vigil_Leveled, Condition(Trig_Natural_Vigil_Leveled_Conditions))
    TriggerAddAction(gg_trg_Natural_Vigil_Leveled, Trig_Natural_Vigil_Leveled_Actions)
end
-- END FOREST SECTION 148

-- BEGIN FOREST SECTION 149 Lifebloom_Leveled
-- Original JASS function: Trig_Lifebloom_Leveled_Conditions (line 10971)
function Trig_Lifebloom_Leveled_Conditions()
    if ((not ((GetResearched() == FourCC("R051"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Lifebloom_Leveled_Func001002 (line 10978)
function Trig_Lifebloom_Leveled_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A07N"), GetEnumUnit())
end

-- Original JASS function: Trig_Lifebloom_Leveled_Actions (line 10982)
function Trig_Lifebloom_Leveled_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(GetTriggerPlayer(), FourCC("h010")), Trig_Lifebloom_Leveled_Func001002)
end

-- Original JASS function: InitTrig_Lifebloom_Leveled (line 10987)
function InitTrig_Lifebloom_Leveled()
    gg_trg_Lifebloom_Leveled = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Lifebloom_Leveled, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Lifebloom_Leveled, Condition(Trig_Lifebloom_Leveled_Conditions))
    TriggerAddAction(gg_trg_Lifebloom_Leveled, Trig_Lifebloom_Leveled_Actions)
end
-- END FOREST SECTION 149

-- BEGIN FOREST SECTION 150 Suns_Fury
-- Original JASS function: Trig_Suns_Fury_Conditions (line 10997)
function Trig_Suns_Fury_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A087"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Suns_Fury_Actions (line 11004)
function Trig_Suns_Fury_Actions()
    UnitResetCooldown(GetSpellAbilityUnit())
end

-- Original JASS function: InitTrig_Suns_Fury (line 11009)
function InitTrig_Suns_Fury()
    gg_trg_Suns_Fury = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Suns_Fury, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Suns_Fury, Condition(Trig_Suns_Fury_Conditions))
    TriggerAddAction(gg_trg_Suns_Fury, Trig_Suns_Fury_Actions)
end
-- END FOREST SECTION 150
