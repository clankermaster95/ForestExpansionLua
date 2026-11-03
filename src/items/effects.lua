-- items / effects
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 222 Staff_of_insight_pickup
-- Original JASS function: Trig_Staff_of_insight_pickup_Conditions (line 14296)
function Trig_Staff_of_insight_pickup_Conditions()
    if ((not ((GetItemTypeId(GetManipulatedItem()) == FourCC("I01C"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Staff_of_insight_pickup_Actions (line 14303)
function Trig_Staff_of_insight_pickup_Actions()
    BlzItemAddAbilityBJ(GetManipulatedItem(), FourCC("AIms"))
end

-- Original JASS function: InitTrig_Staff_of_insight_pickup (line 14308)
function InitTrig_Staff_of_insight_pickup()
    gg_trg_Staff_of_insight_pickup = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Staff_of_insight_pickup, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    TriggerAddCondition(gg_trg_Staff_of_insight_pickup, Condition(Trig_Staff_of_insight_pickup_Conditions))
    TriggerAddAction(gg_trg_Staff_of_insight_pickup, Trig_Staff_of_insight_pickup_Actions)
end
-- END FOREST SECTION 222

-- BEGIN FOREST SECTION 223 Dusts_Slow
-- Original JASS function: DAS_RegisterInvisBuff (line 14319)
function DAS_RegisterInvisBuff(buffId)
    DAS_InvisBuff[DAS_InvisBuffCount] = buffId
    DAS_InvisBuffCount = __jint(DAS_InvisBuffCount + 1)
end

-- Original JASS function: DAS_InitInvisBuffs (line 14324)
function DAS_InitInvisBuffs()
    DAS_InvisBuffCount = 0
    DAS_RegisterInvisBuff(FourCC("B03X"))
    DAS_RegisterInvisBuff(FourCC("B026"))
    DAS_RegisterInvisBuff(FourCC("BOwk"))
    DAS_RegisterInvisBuff(FourCC("Binv"))
    DAS_RegisterInvisBuff(FourCC("B001"))
end

-- Original JASS function: DAS_HasSlowAura (line 14334)
function DAS_HasSlowAura(target)
    do return (GetUnitAbilityLevel(target, DAS_SLOW_AURA_ID) > 0) end
end

-- Original JASS function: DAS_TargetCountsAsInvisible (line 14338)
function DAS_TargetCountsAsInvisible(target, dustOwner)
    local engineInvisible = false
    local i = 0
    if (dustOwner ~= nil) then
        engineInvisible = IsUnitInvisible(target, dustOwner)
    end
    if engineInvisible then
        do return true end
    end
    if (GetUnitAbilityLevel(target, DAS_PERMANENT_INVIS_ABILITY) > 0) then
        do return true end
    end
    while true do
        if (i >= DAS_InvisBuffCount) then break end
        if (GetUnitAbilityLevel(target, DAS_InvisBuff[i]) > 0) then
            do return true end
        end
        i = __jint(i + 1)
    end
    do return false end
end

-- Original JASS function: DAS_AddSlowAura (line 14367)
function DAS_AddSlowAura(target)
    if (target == nil) then
        do return end
    end
    if (not ((GetUnitAbilityLevel((target), DAS_SLOW_AURA_ID) > 0))) then
        UnitAddAbility(target, DAS_SLOW_AURA_ID)
        BlzUnitHideAbility(target, DAS_SLOW_AURA_ID, true)
    end
end

-- Original JASS function: DAS_RemoveSlowAura (line 14378)
function DAS_RemoveSlowAura(target)
    if (target == nil) then
        do return end
    end
    if ((GetUnitAbilityLevel((target), DAS_SLOW_AURA_ID) > 0)) then
        UnitRemoveAbility(target, DAS_SLOW_AURA_ID)
    end
end

-- Original JASS function: DAS_StopTracking (line 14388)
function DAS_StopTracking(target)
    local t = nil
    if (target == nil) then
        do return end
    end
    t = LoadTimerHandle(DAS_Hash, GetHandleId(target), DAS_KEY_TRACK_TIMER)
    if (t ~= nil) then
        PauseTimer(t)
        FlushChildHashtable(DAS_Hash, GetHandleId(t))
        DestroyTimer(t)
        RemoveSavedHandle(DAS_Hash, GetHandleId(target), DAS_KEY_TRACK_TIMER)
    end
    t = nil
end

-- Original JASS function: DAS_TrackLoop (line 14407)
function DAS_TrackLoop()
    local t = GetExpiredTimer()
    local target = LoadUnitHandle(DAS_Hash, GetHandleId(t), DAS_KEY_TIMER_TARGET)
    local dustOwner = LoadPlayerHandle(DAS_Hash, GetHandleId(t), DAS_KEY_TIMER_OWNER)
    local hasDust = false
    local isInvisible = false
    if (target == nil) then
        PauseTimer(t)
        FlushChildHashtable(DAS_Hash, GetHandleId(t))
        DestroyTimer(t)
        t = nil
        dustOwner = nil
        do return end
    end
    if (GetWidgetLife(target) <= __jreal(0.405)) then
        DAS_RemoveSlowAura(target)
        DAS_StopTracking(target)
        t = nil
        target = nil
        dustOwner = nil
        do return end
    end
    hasDust = (GetUnitAbilityLevel(target, DAS_DUST_BUFF_ID) > 0)
    isInvisible = DAS_TargetCountsAsInvisible(target, dustOwner)
    if (not hasDust) then
        if ((GetUnitAbilityLevel((target), DAS_SLOW_AURA_ID) > 0)) then
            DAS_RemoveSlowAura(target)
        end
        DAS_StopTracking(target)
    elseif isInvisible then
        if (not ((GetUnitAbilityLevel((target), DAS_SLOW_AURA_ID) > 0))) then
            DAS_AddSlowAura(target)
        end
    else
        if (((GetUnitAbilityLevel((target), DAS_SLOW_AURA_ID) > 0)) and (not isInvisible)) then
            DAS_RemoveSlowAura(target)
        end
    end
    t = nil
    target = nil
    dustOwner = nil
end

-- Original JASS function: DAS_StartTracking (line 14456)
function DAS_StartTracking(target, dustOwner)
    local t = nil
    if (target == nil) then
        do return end
    end
    t = LoadTimerHandle(DAS_Hash, GetHandleId(target), DAS_KEY_TRACK_TIMER)
    if (t ~= nil) then
        SavePlayerHandle(DAS_Hash, GetHandleId(t), DAS_KEY_TIMER_OWNER, dustOwner)
        t = nil
        do return end
    end
    t = CreateTimer()
    SaveTimerHandle(DAS_Hash, GetHandleId(target), DAS_KEY_TRACK_TIMER, t)
    SaveUnitHandle(DAS_Hash, GetHandleId(t), DAS_KEY_TIMER_TARGET, target)
    SavePlayerHandle(DAS_Hash, GetHandleId(t), DAS_KEY_TIMER_OWNER, dustOwner)
    TimerStart(t, DAS_PERIOD, true, DAS_TrackLoop)
    t = nil
end

-- Original JASS function: DAS_EnumDustTargets (line 14480)
function DAS_EnumDustTargets()
    local target = GetEnumUnit()
    if ((((target ~= nil) and (GetWidgetLife(target) > __jreal(0.405))) and IsUnitEnemy(target, DAS_EnumOwner)) and (not IsUnitType(target, UNIT_TYPE_STRUCTURE))) then
        DAS_StartTracking(target, DAS_EnumOwner)
    end
    target = nil
end

-- Original JASS function: DAS_OnCast_Condition (line 14490)
function DAS_OnCast_Condition()
    do return (GetSpellAbilityId() == DAS_DUST_CAST_ABILITY_ID) end
end

-- Original JASS function: DAS_OnCast_Action (line 14494)
function DAS_OnCast_Action()
    local caster = GetTriggerUnit()
    local x = GetUnitX(caster)
    local y = GetUnitY(caster)
    DAS_EnumOwner = GetOwningPlayer(caster)
    GroupEnumUnitsInRange(DAS_EnumGroup, x, y, DAS_RADIUS, nil)
    ForGroup(DAS_EnumGroup, DAS_EnumDustTargets)
    GroupClear(DAS_EnumGroup)
    DAS_EnumOwner = nil
    caster = nil
end

-- Original JASS function: InitTrig_Dusts_Slow (line 14509)
function InitTrig_Dusts_Slow()
    local t = CreateTrigger()
    local i = 0
    DAS_InitInvisBuffs()
    while true do
        if (i >= bj_MAX_PLAYER_SLOTS) then break end
        TriggerRegisterPlayerUnitEvent(t, Player(i), EVENT_PLAYER_UNIT_SPELL_EFFECT, nil)
        i = __jint(i + 1)
    end
    TriggerAddCondition(t, Condition(DAS_OnCast_Condition))
    TriggerAddAction(t, DAS_OnCast_Action)
    t = nil
end
-- END FOREST SECTION 223

-- BEGIN FOREST SECTION 224 Firelords_Cape_usage
-- Original JASS function: Trig_Firelords_Cape_usage_Conditions (line 14529)
function Trig_Firelords_Cape_usage_Conditions()
    if ((not ((GetItemTypeId(GetManipulatedItem()) == FourCC("I01T"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Firelords_Cape_usage_Actions (line 14536)
function Trig_Firelords_Cape_usage_Actions()
    SetUnitLifePercentBJ(GetTriggerUnit(), (__jreal(GetUnitLifePercent(GetTriggerUnit()) + (__jreal(__jreal(0.20) * (__jreal(__jreal(100.00) - GetUnitLifePercent(GetTriggerUnit()))))))))
end

-- Original JASS function: InitTrig_Firelords_Cape_usage (line 14541)
function InitTrig_Firelords_Cape_usage()
    gg_trg_Firelords_Cape_usage = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Firelords_Cape_usage, EVENT_PLAYER_UNIT_USE_ITEM)
    TriggerAddCondition(gg_trg_Firelords_Cape_usage, Condition(Trig_Firelords_Cape_usage_Conditions))
    TriggerAddAction(gg_trg_Firelords_Cape_usage, Trig_Firelords_Cape_usage_Actions)
end
-- END FOREST SECTION 224

-- BEGIN FOREST SECTION 225 Firelords_Cape_pickup
-- Original JASS function: Trig_Firelords_Cape_pickup_Conditions (line 14551)
function Trig_Firelords_Cape_pickup_Conditions()
    if ((not ((GetItemTypeId(GetManipulatedItem()) == FourCC("I01T"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Firelords_Cape_pickup_Actions (line 14558)
function Trig_Firelords_Cape_pickup_Actions()
    BlzItemAddAbilityBJ(GetManipulatedItem(), FourCC("AIms"))
    BlzItemAddAbilityBJ(GetManipulatedItem(), FourCC("AId0"))
end

-- Original JASS function: InitTrig_Firelords_Cape_pickup (line 14564)
function InitTrig_Firelords_Cape_pickup()
    gg_trg_Firelords_Cape_pickup = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Firelords_Cape_pickup, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    TriggerAddCondition(gg_trg_Firelords_Cape_pickup, Condition(Trig_Firelords_Cape_pickup_Conditions))
    TriggerAddAction(gg_trg_Firelords_Cape_pickup, Trig_Firelords_Cape_pickup_Actions)
end
-- END FOREST SECTION 225

-- BEGIN FOREST SECTION 226 Bladed_Gauntlet_vs_Hero
-- Original JASS function: Trig_Bladed_Gauntlet_vs_Hero_Func002001 (line 14574)
function Trig_Bladed_Gauntlet_vs_Hero_Func002001()
    do return ((UnitHasItemOfTypeBJ(udg_DamageEventSource, FourCC("I00F")) == true)) end
end

-- Original JASS function: Trig_Bladed_Gauntlet_vs_Hero_Func002002 (line 14578)
function Trig_Bladed_Gauntlet_vs_Hero_Func002002()
    do return ((UnitHasItemOfTypeBJ(udg_DamageEventSource, FourCC("I01L")) == true)) end
end

-- Original JASS function: Trig_Bladed_Gauntlet_vs_Hero_Conditions (line 14582)
function Trig_Bladed_Gauntlet_vs_Hero_Conditions()
    if ((not GetBooleanOr(((UnitHasItemOfTypeBJ(udg_DamageEventSource, FourCC("I00F")) == true)), ((UnitHasItemOfTypeBJ(udg_DamageEventSource, FourCC("I01L")) == true))))) then
        do return false end
    end
    if ((not ((udg_IsDamageAttack == true)))) then
        do return false end
    end
    if ((not ((IsUnitType(udg_DamageEventTarget, UNIT_TYPE_HERO) == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Bladed_Gauntlet_vs_Hero_Actions (line 14595)
function Trig_Bladed_Gauntlet_vs_Hero_Actions()
    UnitDamageTargetBJ(udg_DamageEventSource, udg_DamageEventTarget, __jreal(100.00), ATTACK_TYPE_HERO, DAMAGE_TYPE_NORMAL)
end

-- Original JASS function: InitTrig_Bladed_Gauntlet_vs_Hero (line 14600)
function InitTrig_Bladed_Gauntlet_vs_Hero()
    gg_trg_Bladed_Gauntlet_vs_Hero = CreateTrigger()
    h__TriggerRegisterVariableEvent(gg_trg_Bladed_Gauntlet_vs_Hero, "udg_DamageEvent", EQUAL, __jreal(1.00))
    TriggerAddCondition(gg_trg_Bladed_Gauntlet_vs_Hero, Condition(Trig_Bladed_Gauntlet_vs_Hero_Conditions))
    TriggerAddAction(gg_trg_Bladed_Gauntlet_vs_Hero, Trig_Bladed_Gauntlet_vs_Hero_Actions)
end
-- END FOREST SECTION 226

-- BEGIN FOREST SECTION 227 Cast_CL_on_Banish
-- Original JASS function: Trig_Cast_CL_on_Banish_Conditions (line 14610)
function Trig_Cast_CL_on_Banish_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A094"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Cast_CL_on_Banish_Actions (line 14617)
function Trig_Cast_CL_on_Banish_Actions()
    udg_Temp_Point = GetUnitLoc(GetSpellAbilityUnit())
    CreateNUnitsAtLocFacingLocBJ(1, FourCC("h04L"), GetOwningPlayer(GetSpellAbilityUnit()), udg_Temp_Point, udg_Temp_Point)
    UnitApplyTimedLifeBJ(__jreal(0.50), FourCC("BTLF"), GetLastCreatedUnit())
    IssueTargetOrderBJ(GetLastCreatedUnit(), "chainlightning", GetSpellTargetUnit())
    RemoveLocation(udg_Temp_Point)
end

-- Original JASS function: InitTrig_Cast_CL_on_Banish (line 14626)
function InitTrig_Cast_CL_on_Banish()
    gg_trg_Cast_CL_on_Banish = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Cast_CL_on_Banish, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Cast_CL_on_Banish, Condition(Trig_Cast_CL_on_Banish_Conditions))
    TriggerAddAction(gg_trg_Cast_CL_on_Banish, Trig_Cast_CL_on_Banish_Actions)
end
-- END FOREST SECTION 227

-- BEGIN FOREST SECTION 228 Ledgers_XP
-- Original JASS function: Trig_Ledgers_XP_Func001Func001C (line 14636)
function Trig_Ledgers_XP_Func001Func001C()
    if ((not ((UnitHasItemOfTypeBJ(udg_Ledger, FourCC("I01J")) == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Ledgers_XP_Func001C (line 14643)
function Trig_Ledgers_XP_Func001C()
    if ((not ((UnitHasItemOfTypeBJ(udg_Ledger, FourCC("I01N")) == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Ledgers_XP_Actions (line 14650)
function Trig_Ledgers_XP_Actions()
    FE_Ledgers.tick()
end

-- Original JASS function: InitTrig_Ledgers_XP (line 14662)
function InitTrig_Ledgers_XP()
    gg_trg_Ledgers_XP = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(gg_trg_Ledgers_XP, __jreal(1.00))
    TriggerAddAction(gg_trg_Ledgers_XP, Trig_Ledgers_XP_Actions)
end
-- END FOREST SECTION 228

-- BEGIN FOREST SECTION 229 Ledger_of_Clarity_pickup
-- Original JASS function: Trig_Ledger_of_Clarity_pickup_Conditions (line 14671)
function Trig_Ledger_of_Clarity_pickup_Conditions()
    if ((not ((GetItemTypeId(GetManipulatedItem()) == FourCC("I01J"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Ledger_of_Clarity_pickup_Actions (line 14678)
function Trig_Ledger_of_Clarity_pickup_Actions()
    FE_Ledgers.watch(GetManipulatingUnit())
end

-- Original JASS function: InitTrig_Ledger_of_Clarity_pickup (line 14684)
function InitTrig_Ledger_of_Clarity_pickup()
    gg_trg_Ledger_of_Clarity_pickup = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Ledger_of_Clarity_pickup, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    TriggerAddCondition(gg_trg_Ledger_of_Clarity_pickup, Condition(Trig_Ledger_of_Clarity_pickup_Conditions))
    TriggerAddAction(gg_trg_Ledger_of_Clarity_pickup, Trig_Ledger_of_Clarity_pickup_Actions)
end
-- END FOREST SECTION 229

-- BEGIN FOREST SECTION 230 Ledger_of_Clarity_lose
-- Original JASS function: Trig_Ledger_of_Clarity_lose_Conditions (line 14694)
function Trig_Ledger_of_Clarity_lose_Conditions()
    if ((not ((GetItemTypeId(GetManipulatedItem()) == FourCC("I01J"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Ledger_of_Clarity_lose_Actions (line 14701)
function Trig_Ledger_of_Clarity_lose_Actions()
    FE_Ledgers.watch(GetManipulatingUnit())
end

-- Original JASS function: InitTrig_Ledger_of_Clarity_lose (line 14706)
function InitTrig_Ledger_of_Clarity_lose()
    gg_trg_Ledger_of_Clarity_lose = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Ledger_of_Clarity_lose, EVENT_PLAYER_UNIT_DROP_ITEM)
    TriggerAddCondition(gg_trg_Ledger_of_Clarity_lose, Condition(Trig_Ledger_of_Clarity_lose_Conditions))
    TriggerAddAction(gg_trg_Ledger_of_Clarity_lose, Trig_Ledger_of_Clarity_lose_Actions)
end
-- END FOREST SECTION 230

-- BEGIN FOREST SECTION 231 Ledger_of_Enlightment_pickup
-- Original JASS function: Trig_Ledger_of_Enlightment_pickup_Conditions (line 14716)
function Trig_Ledger_of_Enlightment_pickup_Conditions()
    if ((not ((GetItemTypeId(GetManipulatedItem()) == FourCC("I01N"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Ledger_of_Enlightment_pickup_Actions (line 14723)
function Trig_Ledger_of_Enlightment_pickup_Actions()
    FE_Ledgers.watch(GetManipulatingUnit())
end

-- Original JASS function: InitTrig_Ledger_of_Enlightment_pickup (line 14729)
function InitTrig_Ledger_of_Enlightment_pickup()
    gg_trg_Ledger_of_Enlightment_pickup = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Ledger_of_Enlightment_pickup, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    TriggerAddCondition(gg_trg_Ledger_of_Enlightment_pickup, Condition(Trig_Ledger_of_Enlightment_pickup_Conditions))
    TriggerAddAction(gg_trg_Ledger_of_Enlightment_pickup, Trig_Ledger_of_Enlightment_pickup_Actions)
end
-- END FOREST SECTION 231

-- BEGIN FOREST SECTION 232 Ledger_of_Enlightment_lose
-- Original JASS function: Trig_Ledger_of_Enlightment_lose_Conditions (line 14739)
function Trig_Ledger_of_Enlightment_lose_Conditions()
    if ((not ((GetItemTypeId(GetManipulatedItem()) == FourCC("I01N"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Ledger_of_Enlightment_lose_Actions (line 14746)
function Trig_Ledger_of_Enlightment_lose_Actions()
    FE_Ledgers.watch(GetManipulatingUnit())
end

-- Original JASS function: InitTrig_Ledger_of_Enlightment_lose (line 14751)
function InitTrig_Ledger_of_Enlightment_lose()
    gg_trg_Ledger_of_Enlightment_lose = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Ledger_of_Enlightment_lose, EVENT_PLAYER_UNIT_DROP_ITEM)
    TriggerAddCondition(gg_trg_Ledger_of_Enlightment_lose, Condition(Trig_Ledger_of_Enlightment_lose_Conditions))
    TriggerAddAction(gg_trg_Ledger_of_Enlightment_lose, Trig_Ledger_of_Enlightment_lose_Actions)
end
-- END FOREST SECTION 232

-- BEGIN FOREST SECTION 233 Spellcasters_Cloak
-- Original JASS function: Trig_Spellcasters_Cloak_Conditions (line 14761)
function Trig_Spellcasters_Cloak_Conditions()
    return FE_Recipes.canCombineOwned(GetTriggerUnit(), FourCC('I01R'))
end

-- Original JASS function: Trig_Spellcasters_Cloak_Actions (line 14777)
function Trig_Spellcasters_Cloak_Actions()
    FE_Recipes.combineOwned(GetTriggerUnit(), FourCC('I01R'))
end

-- Original JASS function: InitTrig_Spellcasters_Cloak (line 14786)
function InitTrig_Spellcasters_Cloak()
    gg_trg_Spellcasters_Cloak = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Spellcasters_Cloak, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    TriggerAddCondition(gg_trg_Spellcasters_Cloak, Condition(Trig_Spellcasters_Cloak_Conditions))
    TriggerAddAction(gg_trg_Spellcasters_Cloak, Trig_Spellcasters_Cloak_Actions)
end
-- END FOREST SECTION 233

-- BEGIN FOREST SECTION 234 Ethereal_Scepter
-- Original JASS function: Trig_Ethereal_Scepter_Conditions (line 14796)
function Trig_Ethereal_Scepter_Conditions()
    return FE_Recipes.canCombineOwned(GetTriggerUnit(), FourCC('I01P'))
end

-- Original JASS function: Trig_Ethereal_Scepter_Actions (line 14809)
function Trig_Ethereal_Scepter_Actions()
    FE_Recipes.combineOwned(GetTriggerUnit(), FourCC('I01P'))
end

-- Original JASS function: InitTrig_Ethereal_Scepter (line 14817)
function InitTrig_Ethereal_Scepter()
    gg_trg_Ethereal_Scepter = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Ethereal_Scepter, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    TriggerAddCondition(gg_trg_Ethereal_Scepter, Condition(Trig_Ethereal_Scepter_Conditions))
    TriggerAddAction(gg_trg_Ethereal_Scepter, Trig_Ethereal_Scepter_Actions)
end
-- END FOREST SECTION 234

-- BEGIN FOREST SECTION 235 Firelords_Cape
-- Original JASS function: Trig_Firelords_Cape_Conditions (line 14827)
function Trig_Firelords_Cape_Conditions()
    return FE_Recipes.canCombineOwned(GetTriggerUnit(), FourCC('I01T'))
end

-- Original JASS function: Trig_Firelords_Cape_Actions (line 14840)
function Trig_Firelords_Cape_Actions()
    FE_Recipes.combineOwned(GetTriggerUnit(), FourCC('I01T'))
end

-- Original JASS function: InitTrig_Firelords_Cape (line 14848)
function InitTrig_Firelords_Cape()
    gg_trg_Firelords_Cape = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Firelords_Cape, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    TriggerAddCondition(gg_trg_Firelords_Cape, Condition(Trig_Firelords_Cape_Conditions))
    TriggerAddAction(gg_trg_Firelords_Cape, Trig_Firelords_Cape_Actions)
end
-- END FOREST SECTION 235

-- BEGIN FOREST SECTION 236 Ledget_of_Enlightment
-- Original JASS function: Trig_Ledget_of_Enlightment_Func002Func001C (line 14858)
function Trig_Ledget_of_Enlightment_Func002Func001C()
    if ((not ((GetItemTypeId(UnitItemInSlotBJ(GetTriggerUnit(), GetForLoopIndexA())) == FourCC("I01J"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Ledget_of_Enlightment_Actions (line 14865)
function Trig_Ledget_of_Enlightment_Actions()
    FE_Recipes.combineOwned(GetTriggerUnit(), FourCC('I01N'))
end

-- Original JASS function: InitTrig_Ledget_of_Enlightment (line 14890)
function InitTrig_Ledget_of_Enlightment()
    gg_trg_Ledget_of_Enlightment = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Ledget_of_Enlightment, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    TriggerAddAction(gg_trg_Ledget_of_Enlightment, Trig_Ledget_of_Enlightment_Actions)
end
-- END FOREST SECTION 236

-- BEGIN FOREST SECTION 237 Hammer_of_might
-- Original JASS function: Trig_Hammer_of_might_Conditions (line 14899)
function Trig_Hammer_of_might_Conditions()
    return FE_Recipes.canCombineOwned(GetTriggerUnit(), FourCC('I01L'))
end

-- Original JASS function: Trig_Hammer_of_might_Actions (line 14912)
function Trig_Hammer_of_might_Actions()
    FE_Recipes.combineOwned(GetTriggerUnit(), FourCC('I01L'))
end

-- Original JASS function: InitTrig_Hammer_of_might (line 14920)
function InitTrig_Hammer_of_might()
    gg_trg_Hammer_of_might = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Hammer_of_might, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    TriggerAddCondition(gg_trg_Hammer_of_might, Condition(Trig_Hammer_of_might_Conditions))
    TriggerAddAction(gg_trg_Hammer_of_might, Trig_Hammer_of_might_Actions)
end
-- END FOREST SECTION 237

-- BEGIN FOREST SECTION 238 Valorous_Helmet
-- Original JASS function: Trig_Valorous_Helmet_Conditions (line 14930)
function Trig_Valorous_Helmet_Conditions()
    return FE_Recipes.canCombineOwned(GetTriggerUnit(), FourCC('I00I'))
end

-- Original JASS function: Trig_Valorous_Helmet_Actions (line 14943)
function Trig_Valorous_Helmet_Actions()
    FE_Recipes.combineOwned(GetTriggerUnit(), FourCC('I00I'))
end

-- Original JASS function: InitTrig_Valorous_Helmet (line 14951)
function InitTrig_Valorous_Helmet()
    gg_trg_Valorous_Helmet = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Valorous_Helmet, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    TriggerAddCondition(gg_trg_Valorous_Helmet, Condition(Trig_Valorous_Helmet_Conditions))
    TriggerAddAction(gg_trg_Valorous_Helmet, Trig_Valorous_Helmet_Actions)
end
-- END FOREST SECTION 238

-- BEGIN FOREST SECTION 239 Bladed_Gauntlet
-- Original JASS function: Trig_Bladed_Gauntlet_Conditions (line 14961)
function Trig_Bladed_Gauntlet_Conditions()
    return FE_Recipes.canCombineOwned(GetTriggerUnit(), FourCC('I00F'))
end

-- Original JASS function: Trig_Bladed_Gauntlet_Actions (line 14974)
function Trig_Bladed_Gauntlet_Actions()
    FE_Recipes.combineOwned(GetTriggerUnit(), FourCC('I00F'))
end

-- Original JASS function: InitTrig_Bladed_Gauntlet (line 14982)
function InitTrig_Bladed_Gauntlet()
    gg_trg_Bladed_Gauntlet = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Bladed_Gauntlet, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    TriggerAddCondition(gg_trg_Bladed_Gauntlet, Condition(Trig_Bladed_Gauntlet_Conditions))
    TriggerAddAction(gg_trg_Bladed_Gauntlet, Trig_Bladed_Gauntlet_Actions)
end
-- END FOREST SECTION 239

-- BEGIN FOREST SECTION 240 Righteous_Armor
-- Original JASS function: Trig_Righteous_Armor_Conditions (line 14992)
function Trig_Righteous_Armor_Conditions()
    return FE_Recipes.canCombineOwned(GetTriggerUnit(), FourCC('I012'))
end

-- Original JASS function: Trig_Righteous_Armor_Actions (line 15008)
function Trig_Righteous_Armor_Actions()
    FE_Recipes.combineOwned(GetTriggerUnit(), FourCC('I012'))
end

-- Original JASS function: InitTrig_Righteous_Armor (line 15017)
function InitTrig_Righteous_Armor()
    gg_trg_Righteous_Armor = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Righteous_Armor, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    TriggerAddCondition(gg_trg_Righteous_Armor, Condition(Trig_Righteous_Armor_Conditions))
    TriggerAddAction(gg_trg_Righteous_Armor, Trig_Righteous_Armor_Actions)
end
-- END FOREST SECTION 240

-- BEGIN FOREST SECTION 241 Arcanum_of_Hatred
-- Original JASS function: Trig_Arcanum_of_Hatred_Conditions (line 15027)
function Trig_Arcanum_of_Hatred_Conditions()
    return FE_Recipes.canCombineOwned(GetTriggerUnit(), FourCC('I015'))
end

-- Original JASS function: Trig_Arcanum_of_Hatred_Actions (line 15040)
function Trig_Arcanum_of_Hatred_Actions()
    FE_Recipes.combineOwned(GetTriggerUnit(), FourCC('I015'))
end

-- Original JASS function: InitTrig_Arcanum_of_Hatred (line 15048)
function InitTrig_Arcanum_of_Hatred()
    gg_trg_Arcanum_of_Hatred = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Arcanum_of_Hatred, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    TriggerAddCondition(gg_trg_Arcanum_of_Hatred, Condition(Trig_Arcanum_of_Hatred_Conditions))
    TriggerAddAction(gg_trg_Arcanum_of_Hatred, Trig_Arcanum_of_Hatred_Actions)
end
-- END FOREST SECTION 241

-- BEGIN FOREST SECTION 242 Bleeding_Scythe
-- Original JASS function: Trig_Bleeding_Scythe_Conditions (line 15058)
function Trig_Bleeding_Scythe_Conditions()
    return FE_Recipes.canCombineOwned(GetTriggerUnit(), FourCC('I017'))
end

-- Original JASS function: Trig_Bleeding_Scythe_Actions (line 15071)
function Trig_Bleeding_Scythe_Actions()
    FE_Recipes.combineOwned(GetTriggerUnit(), FourCC('I017'))
end

-- Original JASS function: InitTrig_Bleeding_Scythe (line 15079)
function InitTrig_Bleeding_Scythe()
    gg_trg_Bleeding_Scythe = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Bleeding_Scythe, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    TriggerAddCondition(gg_trg_Bleeding_Scythe, Condition(Trig_Bleeding_Scythe_Conditions))
    TriggerAddAction(gg_trg_Bleeding_Scythe, Trig_Bleeding_Scythe_Actions)
end
-- END FOREST SECTION 242

-- BEGIN FOREST SECTION 243 Staff_of_Insight
-- Original JASS function: Trig_Staff_of_Insight_Conditions (line 15089)
function Trig_Staff_of_Insight_Conditions()
    return FE_Recipes.canCombineOwned(GetTriggerUnit(), FourCC('I01C'))
end

-- Original JASS function: Trig_Staff_of_Insight_Actions (line 15102)
function Trig_Staff_of_Insight_Actions()
    FE_Recipes.combineOwned(GetTriggerUnit(), FourCC('I01C'))
end

-- Original JASS function: InitTrig_Staff_of_Insight (line 15110)
function InitTrig_Staff_of_Insight()
    gg_trg_Staff_of_Insight = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Staff_of_Insight, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    TriggerAddCondition(gg_trg_Staff_of_Insight, Condition(Trig_Staff_of_Insight_Conditions))
    TriggerAddAction(gg_trg_Staff_of_Insight, Trig_Staff_of_Insight_Actions)
end
-- END FOREST SECTION 243

-- BEGIN FOREST SECTION 244 Cosmic_Orb
-- Original JASS function: Trig_Cosmic_Orb_Conditions (line 15120)
function Trig_Cosmic_Orb_Conditions()
    return FE_Recipes.canCombineOwned(GetTriggerUnit(), FourCC('I019'))
end

-- Original JASS function: Trig_Cosmic_Orb_Actions (line 15136)
function Trig_Cosmic_Orb_Actions()
    FE_Recipes.combineOwned(GetTriggerUnit(), FourCC('I019'))
end

-- Original JASS function: InitTrig_Cosmic_Orb (line 15145)
function InitTrig_Cosmic_Orb()
    gg_trg_Cosmic_Orb = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Cosmic_Orb, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    TriggerAddCondition(gg_trg_Cosmic_Orb, Condition(Trig_Cosmic_Orb_Conditions))
    TriggerAddAction(gg_trg_Cosmic_Orb, Trig_Cosmic_Orb_Actions)
end
-- END FOREST SECTION 244

-- BEGIN FOREST SECTION 245 Level_up
-- Original JASS function: Trig_Level_up_Conditions (line 15155)
function Trig_Level_up_Conditions()
    if ((not ((GetOwningPlayer(GetTriggerUnit()) == FE_Roles.ancient())))) then
        do return false end
    end
    if ((not ((GetItemTypeId(GetManipulatedItem()) == FourCC("I00J"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Level_up_Actions (line 15165)
function Trig_Level_up_Actions()
    RemoveItem(GetManipulatedItem())
    UnitAddItemByIdSwapped(FourCC("tkno"), GetTriggerUnit())
end

-- Original JASS function: InitTrig_Level_up (line 15171)
function InitTrig_Level_up()
    gg_trg_Level_up = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Level_up, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    TriggerAddCondition(gg_trg_Level_up, Condition(Trig_Level_up_Conditions))
    TriggerAddAction(gg_trg_Level_up, Trig_Level_up_Actions)
end
-- END FOREST SECTION 245
