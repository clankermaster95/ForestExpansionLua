-- items / effects
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 222 Staff_of_insight_pickup
function Trig_Staff_of_insight_pickup_Conditions()
    return GetItemTypeId(GetManipulatedItem()) == FourCC("I01C")
end

function Trig_Staff_of_insight_pickup_Actions()
    BlzItemAddAbilityBJ(GetManipulatedItem(), FourCC("AIms"))
end

function InitTrig_Staff_of_insight_pickup()
    gg_trg_Staff_of_insight_pickup = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Staff_of_insight_pickup, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    TriggerAddCondition(gg_trg_Staff_of_insight_pickup, Condition(Trig_Staff_of_insight_pickup_Conditions))
    TriggerAddAction(gg_trg_Staff_of_insight_pickup, Trig_Staff_of_insight_pickup_Actions)
end
-- END FOREST SECTION 222

-- BEGIN FOREST SECTION 223 Dusts_Slow
function DAS_RegisterInvisBuff(buffId)
    DAS_InvisBuff[DAS_InvisBuffCount] = buffId
    DAS_InvisBuffCount = __jint(DAS_InvisBuffCount + 1)
end

function DAS_InitInvisBuffs()
    DAS_InvisBuffCount = 0
    DAS_RegisterInvisBuff(FourCC("B03X"))
    DAS_RegisterInvisBuff(FourCC("B026"))
    DAS_RegisterInvisBuff(FourCC("BOwk"))
    DAS_RegisterInvisBuff(FourCC("Binv"))
    DAS_RegisterInvisBuff(FourCC("B001"))
end

function DAS_HasSlowAura(target)
    return (GetUnitAbilityLevel(target, DAS_SLOW_AURA_ID) > 0)
end

function DAS_TargetCountsAsInvisible(target, dustOwner)
    local engineInvisible = false
    local i = 0
    if (dustOwner ~= nil) then
        engineInvisible = IsUnitInvisible(target, dustOwner)
    end
    if engineInvisible then
        return true
    end
    if (GetUnitAbilityLevel(target, DAS_PERMANENT_INVIS_ABILITY) > 0) then
        return true
    end
    while true do
        if (i >= DAS_InvisBuffCount) then break end
        if (GetUnitAbilityLevel(target, DAS_InvisBuff[i]) > 0) then
            return true
        end
        i = __jint(i + 1)
    end
    return false
end

function DAS_AddSlowAura(target)
    if (target == nil) then
        return
    end
    if (not (GetUnitAbilityLevel((target), DAS_SLOW_AURA_ID) > 0)) then
        UnitAddAbility(target, DAS_SLOW_AURA_ID)
        BlzUnitHideAbility(target, DAS_SLOW_AURA_ID, true)
    end
end

function DAS_RemoveSlowAura(target)
    if (target == nil) then
        return
    end
    if (GetUnitAbilityLevel((target), DAS_SLOW_AURA_ID) > 0) then
        UnitRemoveAbility(target, DAS_SLOW_AURA_ID)
    end
end

function DAS_StopTracking(target)
    local t = nil
    if (target == nil) then
        return
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
        return
    end
    if (GetWidgetLife(target) <= __jreal(0.405)) then
        DAS_RemoveSlowAura(target)
        DAS_StopTracking(target)
        t = nil
        target = nil
        dustOwner = nil
        return
    end
    hasDust = (GetUnitAbilityLevel(target, DAS_DUST_BUFF_ID) > 0)
    isInvisible = DAS_TargetCountsAsInvisible(target, dustOwner)
    if (not hasDust) then
        if (GetUnitAbilityLevel((target), DAS_SLOW_AURA_ID) > 0) then
            DAS_RemoveSlowAura(target)
        end
        DAS_StopTracking(target)
    elseif isInvisible then
        if (not (GetUnitAbilityLevel((target), DAS_SLOW_AURA_ID) > 0)) then
            DAS_AddSlowAura(target)
        end
    else
        if ((GetUnitAbilityLevel((target), DAS_SLOW_AURA_ID) > 0) and (not isInvisible)) then
            DAS_RemoveSlowAura(target)
        end
    end
    t = nil
    target = nil
    dustOwner = nil
end

function DAS_StartTracking(target, dustOwner)
    local t = nil
    if (target == nil) then
        return
    end
    t = LoadTimerHandle(DAS_Hash, GetHandleId(target), DAS_KEY_TRACK_TIMER)
    if (t ~= nil) then
        SavePlayerHandle(DAS_Hash, GetHandleId(t), DAS_KEY_TIMER_OWNER, dustOwner)
        t = nil
        return
    end
    t = CreateTimer()
    SaveTimerHandle(DAS_Hash, GetHandleId(target), DAS_KEY_TRACK_TIMER, t)
    SaveUnitHandle(DAS_Hash, GetHandleId(t), DAS_KEY_TIMER_TARGET, target)
    SavePlayerHandle(DAS_Hash, GetHandleId(t), DAS_KEY_TIMER_OWNER, dustOwner)
    TimerStart(t, DAS_PERIOD, true, DAS_TrackLoop)
    t = nil
end

function DAS_EnumDustTargets()
    local target = GetEnumUnit()
    if ((((target ~= nil) and (GetWidgetLife(target) > __jreal(0.405))) and IsUnitEnemy(target, DAS_EnumOwner)) and (not IsUnitType(target, UNIT_TYPE_STRUCTURE))) then
        DAS_StartTracking(target, DAS_EnumOwner)
    end
    target = nil
end

function DAS_OnCast_Condition()
    return (GetSpellAbilityId() == DAS_DUST_CAST_ABILITY_ID)
end

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
function Trig_Firelords_Cape_usage_Conditions()
    return GetItemTypeId(GetManipulatedItem()) == FourCC("I01T")
end

function Trig_Firelords_Cape_usage_Actions()
    SetUnitLifePercentBJ(GetTriggerUnit(), (__jreal(GetUnitLifePercent(GetTriggerUnit()) + (__jreal(__jreal(0.20) * (__jreal(__jreal(100.00) - GetUnitLifePercent(GetTriggerUnit()))))))))
end

function InitTrig_Firelords_Cape_usage()
    gg_trg_Firelords_Cape_usage = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Firelords_Cape_usage, EVENT_PLAYER_UNIT_USE_ITEM)
    TriggerAddCondition(gg_trg_Firelords_Cape_usage, Condition(Trig_Firelords_Cape_usage_Conditions))
    TriggerAddAction(gg_trg_Firelords_Cape_usage, Trig_Firelords_Cape_usage_Actions)
end
-- END FOREST SECTION 224

-- BEGIN FOREST SECTION 225 Firelords_Cape_pickup
function Trig_Firelords_Cape_pickup_Conditions()
    return GetItemTypeId(GetManipulatedItem()) == FourCC("I01T")
end

function Trig_Firelords_Cape_pickup_Actions()
    BlzItemAddAbilityBJ(GetManipulatedItem(), FourCC("AIms"))
    BlzItemAddAbilityBJ(GetManipulatedItem(), FourCC("AId0"))
end

function InitTrig_Firelords_Cape_pickup()
    gg_trg_Firelords_Cape_pickup = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Firelords_Cape_pickup, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    TriggerAddCondition(gg_trg_Firelords_Cape_pickup, Condition(Trig_Firelords_Cape_pickup_Conditions))
    TriggerAddAction(gg_trg_Firelords_Cape_pickup, Trig_Firelords_Cape_pickup_Actions)
end
-- END FOREST SECTION 225

-- BEGIN FOREST SECTION 226 Bladed_Gauntlet_vs_Hero

function Trig_Bladed_Gauntlet_vs_Hero_Conditions()
    if (not GetBooleanOr((UnitHasItemOfTypeBJ(udg_DamageEventSource, FourCC("I00F")) == true), (UnitHasItemOfTypeBJ(udg_DamageEventSource, FourCC("I01L")) == true))) then
        return false
    end
    if (not (udg_IsDamageAttack == true)) then
        return false
    end
    if (not (IsUnitType(udg_DamageEventTarget, UNIT_TYPE_HERO) == true)) then
        return false
    end
    return true
end

function Trig_Bladed_Gauntlet_vs_Hero_Actions()
    UnitDamageTargetBJ(udg_DamageEventSource, udg_DamageEventTarget, __jreal(100.00), ATTACK_TYPE_HERO, DAMAGE_TYPE_NORMAL)
end

function InitTrig_Bladed_Gauntlet_vs_Hero()
    gg_trg_Bladed_Gauntlet_vs_Hero = CreateTrigger()
    h__TriggerRegisterVariableEvent(gg_trg_Bladed_Gauntlet_vs_Hero, "udg_DamageEvent", EQUAL, __jreal(1.00))
    TriggerAddCondition(gg_trg_Bladed_Gauntlet_vs_Hero, Condition(Trig_Bladed_Gauntlet_vs_Hero_Conditions))
    TriggerAddAction(gg_trg_Bladed_Gauntlet_vs_Hero, Trig_Bladed_Gauntlet_vs_Hero_Actions)
end
-- END FOREST SECTION 226

-- BEGIN FOREST SECTION 227 Cast_CL_on_Banish
function Trig_Cast_CL_on_Banish_Conditions()
    return GetSpellAbilityId() == FourCC("A094")
end

function Trig_Cast_CL_on_Banish_Actions()
    udg_Temp_Point = GetUnitLoc(GetSpellAbilityUnit())
    CreateNUnitsAtLocFacingLocBJ(1, FourCC("h04L"), GetOwningPlayer(GetSpellAbilityUnit()), udg_Temp_Point, udg_Temp_Point)
    UnitApplyTimedLifeBJ(__jreal(0.50), FourCC("BTLF"), GetLastCreatedUnit())
    IssueTargetOrderBJ(GetLastCreatedUnit(), "chainlightning", GetSpellTargetUnit())
    RemoveLocation(udg_Temp_Point)
end

function InitTrig_Cast_CL_on_Banish()
    gg_trg_Cast_CL_on_Banish = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Cast_CL_on_Banish, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Cast_CL_on_Banish, Condition(Trig_Cast_CL_on_Banish_Conditions))
    TriggerAddAction(gg_trg_Cast_CL_on_Banish, Trig_Cast_CL_on_Banish_Actions)
end
-- END FOREST SECTION 227

-- BEGIN FOREST SECTION 228 Ledgers_XP

function Trig_Ledgers_XP_Actions()
    FE_Ledgers.tick()
end

function InitTrig_Ledgers_XP()
    gg_trg_Ledgers_XP = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(gg_trg_Ledgers_XP, __jreal(1.00))
    TriggerAddAction(gg_trg_Ledgers_XP, Trig_Ledgers_XP_Actions)
end
-- END FOREST SECTION 228

-- BEGIN FOREST SECTION 229 Ledger_of_Clarity_pickup
function Trig_Ledger_of_Clarity_pickup_Conditions()
    return GetItemTypeId(GetManipulatedItem()) == FourCC("I01J")
end

function Trig_Ledger_of_Clarity_pickup_Actions()
    FE_Ledgers.watch(GetManipulatingUnit())
end

function InitTrig_Ledger_of_Clarity_pickup()
    gg_trg_Ledger_of_Clarity_pickup = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Ledger_of_Clarity_pickup, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    TriggerAddCondition(gg_trg_Ledger_of_Clarity_pickup, Condition(Trig_Ledger_of_Clarity_pickup_Conditions))
    TriggerAddAction(gg_trg_Ledger_of_Clarity_pickup, Trig_Ledger_of_Clarity_pickup_Actions)
end
-- END FOREST SECTION 229

-- BEGIN FOREST SECTION 230 Ledger_of_Clarity_lose
function Trig_Ledger_of_Clarity_lose_Conditions()
    return GetItemTypeId(GetManipulatedItem()) == FourCC("I01J")
end

function Trig_Ledger_of_Clarity_lose_Actions()
    FE_Ledgers.watch(GetManipulatingUnit())
end

function InitTrig_Ledger_of_Clarity_lose()
    gg_trg_Ledger_of_Clarity_lose = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Ledger_of_Clarity_lose, EVENT_PLAYER_UNIT_DROP_ITEM)
    TriggerAddCondition(gg_trg_Ledger_of_Clarity_lose, Condition(Trig_Ledger_of_Clarity_lose_Conditions))
    TriggerAddAction(gg_trg_Ledger_of_Clarity_lose, Trig_Ledger_of_Clarity_lose_Actions)
end
-- END FOREST SECTION 230

-- BEGIN FOREST SECTION 231 Ledger_of_Enlightment_pickup
function Trig_Ledger_of_Enlightment_pickup_Conditions()
    return GetItemTypeId(GetManipulatedItem()) == FourCC("I01N")
end

function Trig_Ledger_of_Enlightment_pickup_Actions()
    FE_Ledgers.watch(GetManipulatingUnit())
end

function InitTrig_Ledger_of_Enlightment_pickup()
    gg_trg_Ledger_of_Enlightment_pickup = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Ledger_of_Enlightment_pickup, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    TriggerAddCondition(gg_trg_Ledger_of_Enlightment_pickup, Condition(Trig_Ledger_of_Enlightment_pickup_Conditions))
    TriggerAddAction(gg_trg_Ledger_of_Enlightment_pickup, Trig_Ledger_of_Enlightment_pickup_Actions)
end
-- END FOREST SECTION 231

-- BEGIN FOREST SECTION 232 Ledger_of_Enlightment_lose
function Trig_Ledger_of_Enlightment_lose_Conditions()
    return GetItemTypeId(GetManipulatedItem()) == FourCC("I01N")
end

function Trig_Ledger_of_Enlightment_lose_Actions()
    FE_Ledgers.watch(GetManipulatingUnit())
end

function InitTrig_Ledger_of_Enlightment_lose()
    gg_trg_Ledger_of_Enlightment_lose = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Ledger_of_Enlightment_lose, EVENT_PLAYER_UNIT_DROP_ITEM)
    TriggerAddCondition(gg_trg_Ledger_of_Enlightment_lose, Condition(Trig_Ledger_of_Enlightment_lose_Conditions))
    TriggerAddAction(gg_trg_Ledger_of_Enlightment_lose, Trig_Ledger_of_Enlightment_lose_Actions)
end
-- END FOREST SECTION 232

-- BEGIN FOREST SECTION 233 Spellcasters_Cloak
function Trig_Spellcasters_Cloak_Conditions()
    return FE_Recipes.canCombineOwned(GetTriggerUnit(), FourCC('I01R'))
end

function Trig_Spellcasters_Cloak_Actions()
    FE_Recipes.combineOwned(GetTriggerUnit(), FourCC('I01R'))
end

function InitTrig_Spellcasters_Cloak()
    gg_trg_Spellcasters_Cloak = CreateTrigger()
    FE_Recipes.registerPickup(gg_trg_Spellcasters_Cloak, Trig_Spellcasters_Cloak_Conditions, Trig_Spellcasters_Cloak_Actions)
end
-- END FOREST SECTION 233

-- BEGIN FOREST SECTION 234 Ethereal_Scepter
function Trig_Ethereal_Scepter_Conditions()
    return FE_Recipes.canCombineOwned(GetTriggerUnit(), FourCC('I01P'))
end

function Trig_Ethereal_Scepter_Actions()
    FE_Recipes.combineOwned(GetTriggerUnit(), FourCC('I01P'))
end

function InitTrig_Ethereal_Scepter()
    gg_trg_Ethereal_Scepter = CreateTrigger()
    FE_Recipes.registerPickup(gg_trg_Ethereal_Scepter, Trig_Ethereal_Scepter_Conditions, Trig_Ethereal_Scepter_Actions)
end
-- END FOREST SECTION 234

-- BEGIN FOREST SECTION 235 Firelords_Cape
function Trig_Firelords_Cape_Conditions()
    return FE_Recipes.canCombineOwned(GetTriggerUnit(), FourCC('I01T'))
end

function Trig_Firelords_Cape_Actions()
    FE_Recipes.combineOwned(GetTriggerUnit(), FourCC('I01T'))
end

function InitTrig_Firelords_Cape()
    gg_trg_Firelords_Cape = CreateTrigger()
    FE_Recipes.registerPickup(gg_trg_Firelords_Cape, Trig_Firelords_Cape_Conditions, Trig_Firelords_Cape_Actions)
end
-- END FOREST SECTION 235

-- BEGIN FOREST SECTION 236 Ledget_of_Enlightment

function Trig_Ledget_of_Enlightment_Actions()
    FE_Recipes.combineOwned(GetTriggerUnit(), FourCC('I01N'))
end

function InitTrig_Ledget_of_Enlightment()
    gg_trg_Ledget_of_Enlightment = CreateTrigger()
    FE_Recipes.registerPickup(gg_trg_Ledget_of_Enlightment, nil, Trig_Ledget_of_Enlightment_Actions)
end
-- END FOREST SECTION 236

-- BEGIN FOREST SECTION 237 Hammer_of_might
function Trig_Hammer_of_might_Conditions()
    return FE_Recipes.canCombineOwned(GetTriggerUnit(), FourCC('I01L'))
end

function Trig_Hammer_of_might_Actions()
    FE_Recipes.combineOwned(GetTriggerUnit(), FourCC('I01L'))
end

function InitTrig_Hammer_of_might()
    gg_trg_Hammer_of_might = CreateTrigger()
    FE_Recipes.registerPickup(gg_trg_Hammer_of_might, Trig_Hammer_of_might_Conditions, Trig_Hammer_of_might_Actions)
end
-- END FOREST SECTION 237

-- BEGIN FOREST SECTION 238 Valorous_Helmet
function Trig_Valorous_Helmet_Conditions()
    return FE_Recipes.canCombineOwned(GetTriggerUnit(), FourCC('I00I'))
end

function Trig_Valorous_Helmet_Actions()
    FE_Recipes.combineOwned(GetTriggerUnit(), FourCC('I00I'))
end

function InitTrig_Valorous_Helmet()
    gg_trg_Valorous_Helmet = CreateTrigger()
    FE_Recipes.registerPickup(gg_trg_Valorous_Helmet, Trig_Valorous_Helmet_Conditions, Trig_Valorous_Helmet_Actions)
end
-- END FOREST SECTION 238

-- BEGIN FOREST SECTION 239 Bladed_Gauntlet
function Trig_Bladed_Gauntlet_Conditions()
    return FE_Recipes.canCombineOwned(GetTriggerUnit(), FourCC('I00F'))
end

function Trig_Bladed_Gauntlet_Actions()
    FE_Recipes.combineOwned(GetTriggerUnit(), FourCC('I00F'))
end

function InitTrig_Bladed_Gauntlet()
    gg_trg_Bladed_Gauntlet = CreateTrigger()
    FE_Recipes.registerPickup(gg_trg_Bladed_Gauntlet, Trig_Bladed_Gauntlet_Conditions, Trig_Bladed_Gauntlet_Actions)
end
-- END FOREST SECTION 239

-- BEGIN FOREST SECTION 240 Righteous_Armor
function Trig_Righteous_Armor_Conditions()
    return FE_Recipes.canCombineOwned(GetTriggerUnit(), FourCC('I012'))
end

function Trig_Righteous_Armor_Actions()
    FE_Recipes.combineOwned(GetTriggerUnit(), FourCC('I012'))
end

function InitTrig_Righteous_Armor()
    gg_trg_Righteous_Armor = CreateTrigger()
    FE_Recipes.registerPickup(gg_trg_Righteous_Armor, Trig_Righteous_Armor_Conditions, Trig_Righteous_Armor_Actions)
end
-- END FOREST SECTION 240

-- BEGIN FOREST SECTION 241 Arcanum_of_Hatred
function Trig_Arcanum_of_Hatred_Conditions()
    return FE_Recipes.canCombineOwned(GetTriggerUnit(), FourCC('I015'))
end

function Trig_Arcanum_of_Hatred_Actions()
    FE_Recipes.combineOwned(GetTriggerUnit(), FourCC('I015'))
end

function InitTrig_Arcanum_of_Hatred()
    gg_trg_Arcanum_of_Hatred = CreateTrigger()
    FE_Recipes.registerPickup(gg_trg_Arcanum_of_Hatred, Trig_Arcanum_of_Hatred_Conditions, Trig_Arcanum_of_Hatred_Actions)
end
-- END FOREST SECTION 241

-- BEGIN FOREST SECTION 242 Bleeding_Scythe
function Trig_Bleeding_Scythe_Conditions()
    return FE_Recipes.canCombineOwned(GetTriggerUnit(), FourCC('I017'))
end

function Trig_Bleeding_Scythe_Actions()
    FE_Recipes.combineOwned(GetTriggerUnit(), FourCC('I017'))
end

function InitTrig_Bleeding_Scythe()
    gg_trg_Bleeding_Scythe = CreateTrigger()
    FE_Recipes.registerPickup(gg_trg_Bleeding_Scythe, Trig_Bleeding_Scythe_Conditions, Trig_Bleeding_Scythe_Actions)
end
-- END FOREST SECTION 242

-- BEGIN FOREST SECTION 243 Staff_of_Insight
function Trig_Staff_of_Insight_Conditions()
    return FE_Recipes.canCombineOwned(GetTriggerUnit(), FourCC('I01C'))
end

function Trig_Staff_of_Insight_Actions()
    FE_Recipes.combineOwned(GetTriggerUnit(), FourCC('I01C'))
end

function InitTrig_Staff_of_Insight()
    gg_trg_Staff_of_Insight = CreateTrigger()
    FE_Recipes.registerPickup(gg_trg_Staff_of_Insight, Trig_Staff_of_Insight_Conditions, Trig_Staff_of_Insight_Actions)
end
-- END FOREST SECTION 243

-- BEGIN FOREST SECTION 244 Cosmic_Orb
function Trig_Cosmic_Orb_Conditions()
    return FE_Recipes.canCombineOwned(GetTriggerUnit(), FourCC('I019'))
end

function Trig_Cosmic_Orb_Actions()
    FE_Recipes.combineOwned(GetTriggerUnit(), FourCC('I019'))
end

function InitTrig_Cosmic_Orb()
    gg_trg_Cosmic_Orb = CreateTrigger()
    FE_Recipes.registerPickup(gg_trg_Cosmic_Orb, Trig_Cosmic_Orb_Conditions, Trig_Cosmic_Orb_Actions)
end
-- END FOREST SECTION 244

-- BEGIN FOREST SECTION 245 Level_up
function Trig_Level_up_Conditions()
    if (not (GetOwningPlayer(GetTriggerUnit()) == FE_Roles.ancient())) then
        return false
    end
    if (not (GetItemTypeId(GetManipulatedItem()) == FourCC("I00J"))) then
        return false
    end
    return true
end

function Trig_Level_up_Actions()
    RemoveItem(GetManipulatedItem())
    UnitAddItemByIdSwapped(FourCC("tkno"), GetTriggerUnit())
end

function InitTrig_Level_up()
    gg_trg_Level_up = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Level_up, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    TriggerAddCondition(gg_trg_Level_up, Condition(Trig_Level_up_Conditions))
    TriggerAddAction(gg_trg_Level_up, Trig_Level_up_Actions)
end
-- END FOREST SECTION 245
