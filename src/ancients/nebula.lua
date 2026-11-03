-- ancients / nebula
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 160 RecallStart
-- Original JASS function: Trig_RecallStart_Conditions (line 11519)
function Trig_RecallStart_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A0AL"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_RecallStart_Actions (line 11526)
function Trig_RecallStart_Actions()
    udg_RecallTarget = GetSpellTargetUnit()
end

-- Original JASS function: InitTrig_RecallStart (line 11531)
function InitTrig_RecallStart()
    gg_trg_RecallStart = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_RecallStart, EVENT_PLAYER_UNIT_SPELL_CAST)
    TriggerAddCondition(gg_trg_RecallStart, Condition(Trig_RecallStart_Conditions))
    TriggerAddAction(gg_trg_RecallStart, Trig_RecallStart_Actions)
end
-- END FOREST SECTION 160

-- BEGIN FOREST SECTION 161 Recall
-- Original JASS function: Trig_Recall_Conditions (line 11541)
function Trig_Recall_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A0AL"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Recall_Actions (line 11548)
function Trig_Recall_Actions()
    SetUnitPositionLoc(udg_RecallTarget, GetRectCenter(gg_rct_Fountain))
end

-- Original JASS function: InitTrig_Recall (line 11553)
function InitTrig_Recall()
    gg_trg_Recall = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Recall, EVENT_PLAYER_UNIT_SPELL_FINISH)
    TriggerAddCondition(gg_trg_Recall, Condition(Trig_Recall_Conditions))
    TriggerAddAction(gg_trg_Recall, Trig_Recall_Actions)
end
-- END FOREST SECTION 161

-- BEGIN FOREST SECTION 162 Time_warp
-- Original JASS function: Trig_Time_warp_Conditions (line 11563)
function Trig_Time_warp_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A08S"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Time_warp_Func004Func001001 (line 11570)
function Trig_Time_warp_Func004Func001001()
    do return ((IsUnitEnemy(GetEnumUnit(), GetOwningPlayer(GetSpellAbilityUnit())) == true)) end
end

-- Original JASS function: Trig_Time_warp_Func004A (line 11574)
function Trig_Time_warp_Func004A()
    if (((IsUnitEnemy(GetEnumUnit(), GetOwningPlayer(GetSpellAbilityUnit())) == true))) then
        UnitDamageTargetBJ(GetSpellAbilityUnit(), GetEnumUnit(), __jreal(300.00), ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL)
    else
        DoNothing()
    end
end

-- Original JASS function: Trig_Time_warp_Actions (line 11582)
function Trig_Time_warp_Actions()
    udg_TimeWarpCaster = GetSpellAbilityUnit()
    udg_TimeWarp = GetSpellTargetLoc()
    UnitDamagePointLoc(udg_AncientUnit, __jreal(0), __jreal(500), GetUnitLoc(udg_TimeWarpCaster), __jreal(300.00), ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL)
    ForGroupBJ(GetUnitsInRangeOfLocAll(__jreal(512), OffsetLocation(udg_TimeWarp, __jreal(0), __jreal(0))), Trig_Time_warp_Func004A)
end

-- Original JASS function: InitTrig_Time_warp (line 11590)
function InitTrig_Time_warp()
    gg_trg_Time_warp = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Time_warp, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Time_warp, Condition(Trig_Time_warp_Conditions))
    TriggerAddAction(gg_trg_Time_warp, Trig_Time_warp_Actions)
end
-- END FOREST SECTION 162

-- BEGIN FOREST SECTION 163 Galactic_Fury
-- Original JASS function: Trig_Galactic_Fury_Conditions (line 11600)
function Trig_Galactic_Fury_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A0F1"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Galactic_Fury_Actions (line 11607)
function Trig_Galactic_Fury_Actions()
    udg_GalacticFuryCaster = GetSpellAbilityUnit()
end

-- Original JASS function: InitTrig_Galactic_Fury (line 11612)
function InitTrig_Galactic_Fury()
    gg_trg_Galactic_Fury = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Galactic_Fury, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Galactic_Fury, Condition(Trig_Galactic_Fury_Conditions))
    TriggerAddAction(gg_trg_Galactic_Fury, Trig_Galactic_Fury_Actions)
end
-- END FOREST SECTION 163

-- BEGIN FOREST SECTION 164 Galactic_Fury_2
-- Original JASS function: Trig_Galactic_Fury_2_Conditions (line 11622)
function Trig_Galactic_Fury_2_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A0F1"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Galactic_Fury_2_Actions (line 11629)
function Trig_Galactic_Fury_2_Actions()
    SetUnitLifePercentBJ(udg_GalacticFuryCaster, (__jreal(GetUnitLifePercent(udg_GalacticFuryCaster) + __jreal(25.00))))
end

-- Original JASS function: InitTrig_Galactic_Fury_2 (line 11634)
function InitTrig_Galactic_Fury_2()
    gg_trg_Galactic_Fury_2 = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Galactic_Fury_2, EVENT_PLAYER_UNIT_SPELL_FINISH)
    TriggerAddCondition(gg_trg_Galactic_Fury_2, Condition(Trig_Galactic_Fury_2_Conditions))
    TriggerAddAction(gg_trg_Galactic_Fury_2, Trig_Galactic_Fury_2_Actions)
end
-- END FOREST SECTION 164

-- BEGIN FOREST SECTION 165 Galactic_Fury_3
-- Original JASS function: SSZ_IsValidTarget (line 11645)
function SSZ_IsValidTarget(caster, target)
    do return (((((target ~= nil) and (target ~= caster)) and (GetWidgetLife(target) > __jreal(0.405))) and IsUnitEnemy(target, GetOwningPlayer(caster))) and (not IsUnitType(target, UNIT_TYPE_DEAD))) end
end

-- Original JASS function: SSZ_RemoveSlow (line 11649)
function SSZ_RemoveSlow()
    local t = GetExpiredTimer()
    local tid = GetHandleId(t)
    local target = LoadUnitHandle(SSZ_HASH, tid, 0)
    local uid = 0
    if (target ~= nil) then
        uid = GetHandleId(target)
        UnitRemoveAbility(target, SSZ_SLOW_ID)
        FlushChildHashtable(SSZ_HASH, uid)
    end
    FlushChildHashtable(SSZ_HASH, tid)
    PauseTimer(t)
    DestroyTimer(t)
    target = nil
    t = nil
end

-- Original JASS function: SSZ_ApplySlow (line 11669)
function SSZ_ApplySlow(target)
    local uid = GetHandleId(target)
    local t = LoadTimerHandle(SSZ_HASH, uid, 0)
    if (GetUnitAbilityLevel(target, SSZ_SLOW_ID) == 0) then
        UnitAddAbility(target, SSZ_SLOW_ID)
    end
    if (t == nil) then
        t = CreateTimer()
        SaveTimerHandle(SSZ_HASH, uid, 0, t)
        SaveUnitHandle(SSZ_HASH, GetHandleId(t), 0, target)
    end
    TimerStart(t, SSZ_SLOW_DURATION, false, SSZ_RemoveSlow)
    t = nil
end

-- Original JASS function: SSZ_OnCast (line 11688)
function SSZ_OnCast()
    local caster = GetTriggerUnit()
    local g = CreateGroup()
    local target = nil
    local x = GetUnitX(caster)
    local y = GetUnitY(caster)
    GroupEnumUnitsInRange(g, x, y, SSZ_AOE, nil)
    while true do
        target = FirstOfGroup(g)
        if (target == nil) then break end
        GroupRemoveUnit(g, target)
        if SSZ_IsValidTarget(caster, target) then
            if (not IsUnitType(target, UNIT_TYPE_STRUCTURE)) then
                UnitDamageTarget(caster, target, SSZ_DAMAGE, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
            end
            if (GetWidgetLife(target) > __jreal(0.405)) then
                SSZ_ApplySlow(target)
            end
        end
    end
    DestroyGroup(g)
    target = nil
    g = nil
    caster = nil
end

-- Original JASS function: SSZ_Condition (line 11720)
function SSZ_Condition()
    do return (GetSpellAbilityId() == SSZ_SPELL_ID) end
end

-- Original JASS function: InitTrig_Galactic_Fury_3 (line 11724)
function InitTrig_Galactic_Fury_3()
    local t = CreateTrigger()
    local i = 0
    if (SSZ_HASH == nil) then
        SSZ_HASH = InitHashtable()
    end
    while true do
        if (i >= bj_MAX_PLAYER_SLOTS) then break end
        TriggerRegisterPlayerUnitEvent(t, Player(i), EVENT_PLAYER_UNIT_SPELL_EFFECT, nil)
        i = __jint(i + 1)
    end
    TriggerAddCondition(t, Condition(SSZ_Condition))
    TriggerAddAction(t, SSZ_OnCast)
    t = nil
end
-- END FOREST SECTION 165

-- BEGIN FOREST SECTION 166 Cosmic_Strike
-- Original JASS function: Trig_Cosmic_Strike_Conditions (line 11746)
function Trig_Cosmic_Strike_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A08R"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Cosmic_Strike_Actions (line 11753)
function Trig_Cosmic_Strike_Actions()
    udg_CosmicStrikeCaster = GetSpellAbilityUnit()
    udg_CosmicStrikeCount = 1
end

-- Original JASS function: InitTrig_Cosmic_Strike (line 11759)
function InitTrig_Cosmic_Strike()
    gg_trg_Cosmic_Strike = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Cosmic_Strike, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Cosmic_Strike, Condition(Trig_Cosmic_Strike_Conditions))
    TriggerAddAction(gg_trg_Cosmic_Strike, Trig_Cosmic_Strike_Actions)
end
-- END FOREST SECTION 166

-- BEGIN FOREST SECTION 167 Cosmic_Strike_2
-- Original JASS function: Trig_Cosmic_Strike_2_Conditions (line 11769)
function Trig_Cosmic_Strike_2_Conditions()
    if ((not ((udg_DamageEventSource == udg_CosmicStrikeCaster)))) then
        do return false end
    end
    if ((not ((udg_IsDamageAttack == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Cosmic_Strike_2_Func005001 (line 11779)
function Trig_Cosmic_Strike_2_Func005001()
    do return ((udg_CosmicStrikeCount == 0)) end
end

-- Original JASS function: Trig_Cosmic_Strike_2_Actions (line 11783)
function Trig_Cosmic_Strike_2_Actions()
    SetUnitManaPercentBJ(udg_CosmicStrikeCaster, (__jreal(GetUnitManaPercent(GetEventDamageSource()) + __jreal(5.00))))
    udg_CosmicStrikeCount = (__jint(udg_CosmicStrikeCount - 1))
    if (((udg_CosmicStrikeCount == 0))) then
        UnitRemoveBuffBJ(FourCC("B038"), udg_CosmicStrikeCaster)
    else
        DoNothing()
    end
    udg_CosmicStrikeCaster = nil
end

-- Original JASS function: InitTrig_Cosmic_Strike_2 (line 11795)
function InitTrig_Cosmic_Strike_2()
    gg_trg_Cosmic_Strike_2 = CreateTrigger()
    h__TriggerRegisterVariableEvent(gg_trg_Cosmic_Strike_2, "udg_DamageEvent", EQUAL, __jreal(1.00))
    TriggerAddCondition(gg_trg_Cosmic_Strike_2, Condition(Trig_Cosmic_Strike_2_Conditions))
    TriggerAddAction(gg_trg_Cosmic_Strike_2, Trig_Cosmic_Strike_2_Actions)
end
-- END FOREST SECTION 167

-- BEGIN FOREST SECTION 168 Cosmic_Strike_3
-- Original JASS function: Trig_Cosmic_Strike_3_Conditions (line 11805)
function Trig_Cosmic_Strike_3_Conditions()
    if ((not ((UnitHasBuffBJ(udg_DamageEventSource, FourCC("B038")) == true)))) then
        do return false end
    end
    if ((not ((udg_IsDamageAttack == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Cosmic_Strike_3_Actions (line 11815)
function Trig_Cosmic_Strike_3_Actions()
    udg_DamageEventAttackT = udg_ATTACK_TYPE_CHAOS
end

-- Original JASS function: InitTrig_Cosmic_Strike_3 (line 11820)
function InitTrig_Cosmic_Strike_3()
    gg_trg_Cosmic_Strike_3 = CreateTrigger()
    h__TriggerRegisterVariableEvent(gg_trg_Cosmic_Strike_3, "udg_PreDamageEvent", LESS_THAN, __jreal(1.00))
    TriggerAddCondition(gg_trg_Cosmic_Strike_3, Condition(Trig_Cosmic_Strike_3_Conditions))
    TriggerAddAction(gg_trg_Cosmic_Strike_3, Trig_Cosmic_Strike_3_Actions)
end
-- END FOREST SECTION 168
