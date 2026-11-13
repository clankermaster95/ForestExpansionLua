-- races / forgotten / bloodmage
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

FE_Bloodmage = {}

function FE_Bloodmage.restoreResearch(unit)
    if GetUnitTypeId(unit) ~= FourCC("u009") then return end
    local level = 1 + GetPlayerTechCount(GetOwningPlayer(unit), FourCC("R043"), true)
    for _, raw in ipairs({"A065", "A063"}) do
        local ability = FourCC(raw)
        if GetUnitAbilityLevel(unit, ability) > 0 then SetUnitAbilityLevel(unit, ability, level) end
    end
end

-- BEGIN FOREST SECTION 90 Acidic_Blood
-- Shared bodies retain the original wrappers, resolving current Expander
-- positions through FE_Roles instead of excluding a historical Ancient slot.
local function BloodmageUpgradeUnits(index, abilityId)
    local units = GetUnitsOfPlayerAndTypeId(FE_Roles.expanderAt(index), FourCC("u009"))
    ForGroupBJ(units, function()
        IncUnitAbilityLevelSwapped(FourCC(abilityId), GetEnumUnit())
    end)
    DestroyGroup(units)
end

local function BloodmageResearchEvent(trigger, index, condition, action)
    FE_Roles.forEachPlayer(function(player)
        TriggerRegisterPlayerUnitEventSimple(trigger, player, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    end)
    TriggerAddCondition(trigger, Condition(function() return GetTriggerPlayer() == FE_Roles.expanderAt(index) end))
    TriggerAddCondition(trigger, Condition(condition))
    TriggerAddAction(trigger, action)
end

local bloodLifeCosts = {
    Acidic_Blood = 150.00, Binding_Shadows = 200.00, Cobalt_Blood = 200.00,
    Glowing_Blood = 50.00, Psychic_Slam = 300.00, Soul_Rend = 350.00, Dark_Blood = 400.00,
}

local function BloodmagePayLifeCost(spell)
    local cost = __jreal(bloodLifeCosts[spell])
    if GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) <= cost then
        IssueImmediateOrderBJ(GetSpellAbilityUnit(), "stop")
        return false
    end
    SetUnitLifeBJ(GetSpellAbilityUnit(), __jreal(GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) - cost))
    return true
end

-- The expiry branch historically leaves TicksRemaining untouched. Preserve
-- that distinction and the shared scratch globals until a separate state rewrite.
local function DrainRemoveInstance(caster, key, clearRemaining)
    udg_ncld_Tick[key] = 0
    if clearRemaining then udg_ncld_TicksRemaining[key] = 0 end
    GroupRemoveUnitSimple(caster, udg_ncld_Group)
    udg_ncld_Target[key] = nil
    DestroyLightningBJ(udg_ncld_Lightning[key])
    DestroyEffectBJ(udg_ncld_CasterSFX[key])
    DestroyEffectBJ(udg_ncld_TargetSFX[key])
end

function Trig_Acidic_Blood_Conditions()
    return GetSpellAbilityId() == FourCC("A05L")
end

function Trig_Acidic_Blood_Actions()
    BloodmagePayLifeCost("Acidic_Blood")
end

function InitTrig_Acidic_Blood()
    gg_trg_Acidic_Blood = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Acidic_Blood, EVENT_PLAYER_UNIT_SPELL_CAST)
    TriggerAddCondition(gg_trg_Acidic_Blood, Condition(Trig_Acidic_Blood_Conditions))
    TriggerAddAction(gg_trg_Acidic_Blood, Trig_Acidic_Blood_Actions)
end
-- END FOREST SECTION 90

-- BEGIN FOREST SECTION 91 Binding_Shadows
function Trig_Binding_Shadows_Conditions()
    return GetSpellAbilityId() == FourCC("A05M")
end

function Trig_Binding_Shadows_Actions()
    BloodmagePayLifeCost("Binding_Shadows")
end

function InitTrig_Binding_Shadows()
    gg_trg_Binding_Shadows = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Binding_Shadows, EVENT_PLAYER_UNIT_SPELL_CAST)
    TriggerAddCondition(gg_trg_Binding_Shadows, Condition(Trig_Binding_Shadows_Conditions))
    TriggerAddAction(gg_trg_Binding_Shadows, Trig_Binding_Shadows_Actions)
end
-- END FOREST SECTION 91

-- BEGIN FOREST SECTION 92 Cobalt_Blood
function Trig_Cobalt_Blood_Conditions()
    return GetSpellAbilityId() == FourCC("A068")
end

function Trig_Cobalt_Blood_Actions()
    BloodmagePayLifeCost("Cobalt_Blood")
end

function InitTrig_Cobalt_Blood()
    gg_trg_Cobalt_Blood = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Cobalt_Blood, EVENT_PLAYER_UNIT_SPELL_CAST)
    TriggerAddCondition(gg_trg_Cobalt_Blood, Condition(Trig_Cobalt_Blood_Conditions))
    TriggerAddAction(gg_trg_Cobalt_Blood, Trig_Cobalt_Blood_Actions)
end
-- END FOREST SECTION 92

-- BEGIN FOREST SECTION 93 Glowing_Blood
function Trig_Glowing_Blood_Conditions()
    return GetSpellAbilityId() == FourCC("A064")
end

function Trig_Glowing_Blood_Actions()
    BloodmagePayLifeCost("Glowing_Blood")
end

function InitTrig_Glowing_Blood()
    gg_trg_Glowing_Blood = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Glowing_Blood, EVENT_PLAYER_UNIT_SPELL_CAST)
    TriggerAddCondition(gg_trg_Glowing_Blood, Condition(Trig_Glowing_Blood_Conditions))
    TriggerAddAction(gg_trg_Glowing_Blood, Trig_Glowing_Blood_Actions)
end
-- END FOREST SECTION 93

-- BEGIN FOREST SECTION 94 Psychic_Slam
function Trig_Psychic_Slam_Conditions()
    return GetSpellAbilityId() == FourCC("A063")
end

function Trig_Psychic_Slam_Actions()
    BloodmagePayLifeCost("Psychic_Slam")
end

function InitTrig_Psychic_Slam()
    gg_trg_Psychic_Slam = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Psychic_Slam, EVENT_PLAYER_UNIT_SPELL_CAST)
    TriggerAddCondition(gg_trg_Psychic_Slam, Condition(Trig_Psychic_Slam_Conditions))
    TriggerAddAction(gg_trg_Psychic_Slam, Trig_Psychic_Slam_Actions)
end
-- END FOREST SECTION 94

-- BEGIN FOREST SECTION 95 Soul_Rend
function Trig_Soul_Rend_Conditions()
    return GetSpellAbilityId() == FourCC("A069")
end

function Trig_Soul_Rend_Actions()
    if BloodmagePayLifeCost("Soul_Rend") then
        SetUnitLifeBJ(GetSpellTargetUnit(), (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, GetSpellTargetUnit()) - __jreal(500.00))))
    end
end

function InitTrig_Soul_Rend()
    gg_trg_Soul_Rend = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Soul_Rend, EVENT_PLAYER_UNIT_SPELL_CAST)
    TriggerAddCondition(gg_trg_Soul_Rend, Condition(Trig_Soul_Rend_Conditions))
    TriggerAddAction(gg_trg_Soul_Rend, Trig_Soul_Rend_Actions)
end
-- END FOREST SECTION 95

-- BEGIN FOREST SECTION 96 Dark_Blood
function Trig_Dark_Blood_Conditions()
    return GetSpellAbilityId() == FourCC("A062")
end

function Trig_Dark_Blood_Actions()
    BloodmagePayLifeCost("Dark_Blood")
end

function InitTrig_Dark_Blood()
    gg_trg_Dark_Blood = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Dark_Blood, EVENT_PLAYER_UNIT_SPELL_CAST)
    TriggerAddCondition(gg_trg_Dark_Blood, Condition(Trig_Dark_Blood_Conditions))
    TriggerAddAction(gg_trg_Dark_Blood, Trig_Dark_Blood_Actions)
end
-- END FOREST SECTION 96

-- BEGIN FOREST SECTION 97 Shadowlings
function Trig_Shadowlings_Conditions()
    return GetUnitTypeId(GetSummonedUnit()) == FourCC("o01T")
end

function Trig_Shadowlings_Actions()
    local summoned = GetSummonedUnit()
    TriggerSleepAction(__jreal(20.00))
    if summoned and GetUnitTypeId(summoned) ~= 0 then KillUnit(summoned) end
end

function InitTrig_Shadowlings()
    gg_trg_Shadowlings = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Shadowlings, EVENT_PLAYER_UNIT_SUMMON)
    TriggerAddCondition(gg_trg_Shadowlings, Condition(Trig_Shadowlings_Conditions))
    TriggerAddAction(gg_trg_Shadowlings, Trig_Shadowlings_Actions)
end
-- END FOREST SECTION 97

-- BEGIN FOREST SECTION 98 Levelled_Drain
function Trig_Levelled_Drain_Conditions()
    return GetResearched() == FourCC("R043")
end

function Trig_Levelled_Drain_Actions()
    BloodmageUpgradeUnits(0, "A065")
end

function InitTrig_Levelled_Drain()
    gg_trg_Levelled_Drain = CreateTrigger()
    BloodmageResearchEvent(gg_trg_Levelled_Drain, 0, Trig_Levelled_Drain_Conditions, Trig_Levelled_Drain_Actions)
end
-- END FOREST SECTION 98

-- BEGIN FOREST SECTION 99 Levelled_Drain_Copy
function Trig_Levelled_Drain_Copy_Conditions()
    return GetResearched() == FourCC("R043")
end

function Trig_Levelled_Drain_Copy_Actions()
    BloodmageUpgradeUnits(1, "A065")
end

function InitTrig_Levelled_Drain_Copy()
    gg_trg_Levelled_Drain_Copy = CreateTrigger()
    BloodmageResearchEvent(gg_trg_Levelled_Drain_Copy, 1, Trig_Levelled_Drain_Copy_Conditions, Trig_Levelled_Drain_Copy_Actions)
end
-- END FOREST SECTION 99

-- BEGIN FOREST SECTION 100 Levelled_Drain_Copy_2
function Trig_Levelled_Drain_Copy_2_Conditions()
    return GetResearched() == FourCC("R043")
end

function Trig_Levelled_Drain_Copy_2_Actions()
    BloodmageUpgradeUnits(2, "A065")
end

function InitTrig_Levelled_Drain_Copy_2()
    gg_trg_Levelled_Drain_Copy_2 = CreateTrigger()
    BloodmageResearchEvent(gg_trg_Levelled_Drain_Copy_2, 2, Trig_Levelled_Drain_Copy_2_Conditions, Trig_Levelled_Drain_Copy_2_Actions)
end
-- END FOREST SECTION 100

-- BEGIN FOREST SECTION 101 Levelled_Drain_Copy_3
function Trig_Levelled_Drain_Copy_3_Conditions()
    return GetResearched() == FourCC("R043")
end

function Trig_Levelled_Drain_Copy_3_Actions()
    BloodmageUpgradeUnits(3, "A065")
end

function InitTrig_Levelled_Drain_Copy_3()
    gg_trg_Levelled_Drain_Copy_3 = CreateTrigger()
    BloodmageResearchEvent(gg_trg_Levelled_Drain_Copy_3, 3, Trig_Levelled_Drain_Copy_3_Conditions, Trig_Levelled_Drain_Copy_3_Actions)
end
-- END FOREST SECTION 101

-- BEGIN FOREST SECTION 102 Levelled_Drain_Copy_4
function Trig_Levelled_Drain_Copy_4_Conditions()
    return GetResearched() == FourCC("R043")
end

function Trig_Levelled_Drain_Copy_4_Actions()
    BloodmageUpgradeUnits(4, "A065")
end

function InitTrig_Levelled_Drain_Copy_4()
    gg_trg_Levelled_Drain_Copy_4 = CreateTrigger()
    BloodmageResearchEvent(gg_trg_Levelled_Drain_Copy_4, 4, Trig_Levelled_Drain_Copy_4_Conditions, Trig_Levelled_Drain_Copy_4_Actions)
end
-- END FOREST SECTION 102

-- BEGIN FOREST SECTION 103 Levelled_Drain_Copy_5
function Trig_Levelled_Drain_Copy_5_Conditions()
    return GetResearched() == FourCC("R043")
end

function Trig_Levelled_Drain_Copy_5_Actions()
    BloodmageUpgradeUnits(5, "A065")
end

function InitTrig_Levelled_Drain_Copy_5()
    gg_trg_Levelled_Drain_Copy_5 = CreateTrigger()
    BloodmageResearchEvent(gg_trg_Levelled_Drain_Copy_5, 5, Trig_Levelled_Drain_Copy_5_Conditions, Trig_Levelled_Drain_Copy_5_Actions)
end
-- END FOREST SECTION 103

-- BEGIN FOREST SECTION 104 Levelled_Drain_Copy_6
function Trig_Levelled_Drain_Copy_6_Conditions()
    return GetResearched() == FourCC("R043")
end

function Trig_Levelled_Drain_Copy_6_Actions()
    BloodmageUpgradeUnits(6, "A065")
end

function InitTrig_Levelled_Drain_Copy_6()
    gg_trg_Levelled_Drain_Copy_6 = CreateTrigger()
    BloodmageResearchEvent(gg_trg_Levelled_Drain_Copy_6, 6, Trig_Levelled_Drain_Copy_6_Conditions, Trig_Levelled_Drain_Copy_6_Actions)
end
-- END FOREST SECTION 104

-- BEGIN FOREST SECTION 105 Levelled_Drain_Copy_7
function Trig_Levelled_Drain_Copy_7_Conditions()
    return GetResearched() == FourCC("R043")
end

function Trig_Levelled_Drain_Copy_7_Actions()
    BloodmageUpgradeUnits(7, "A065")
end

function InitTrig_Levelled_Drain_Copy_7()
    gg_trg_Levelled_Drain_Copy_7 = CreateTrigger()
    BloodmageResearchEvent(gg_trg_Levelled_Drain_Copy_7, 7, Trig_Levelled_Drain_Copy_7_Conditions, Trig_Levelled_Drain_Copy_7_Actions)
end
-- END FOREST SECTION 105

-- BEGIN FOREST SECTION 106 Levelled_Drain_Copy_8
function Trig_Levelled_Drain_Copy_8_Conditions()
    return GetResearched() == FourCC("R043")
end

function Trig_Levelled_Drain_Copy_8_Actions()
    BloodmageUpgradeUnits(8, "A065")
end

function InitTrig_Levelled_Drain_Copy_8()
    gg_trg_Levelled_Drain_Copy_8 = CreateTrigger()
    BloodmageResearchEvent(gg_trg_Levelled_Drain_Copy_8, 8, Trig_Levelled_Drain_Copy_8_Conditions, Trig_Levelled_Drain_Copy_8_Actions)
end
-- END FOREST SECTION 106

-- BEGIN FOREST SECTION 107 Levelled_Drain_Copy_9
function Trig_Levelled_Drain_Copy_9_Conditions()
    return GetResearched() == FourCC("R043")
end

function Trig_Levelled_Drain_Copy_9_Actions()
    BloodmageUpgradeUnits(9, "A065")
end

function InitTrig_Levelled_Drain_Copy_9()
    gg_trg_Levelled_Drain_Copy_9 = CreateTrigger()
    BloodmageResearchEvent(gg_trg_Levelled_Drain_Copy_9, 9, Trig_Levelled_Drain_Copy_9_Conditions, Trig_Levelled_Drain_Copy_9_Actions)
end
-- END FOREST SECTION 107

-- BEGIN FOREST SECTION 108 Drain_Setup
function Trig_Drain_Setup_Actions()
    udg_ncld_Ability = FourCC("A065")
    udg_ncld_DrainHP = __jreal(20.00)
    udg_ncld_DrainHPUp = __jreal(5.00)
    udg_ncld_DrainMP = __jreal(0.00)
    udg_ncld_DrainMPUp = __jreal(0.00)
    udg_ncld_Duration = __jreal(5.00)
    udg_ncld_Duration_Up = __jreal(0.00)
    udg_ncld_Range = __jreal(950.00)
    udg_ncld_RangeUp = __jreal(0.00)
    udg_ncld_LightningArt = "DRAB"
    udg_ncld_TargetSFXArt = "Abilities\\Spells\\Other\\Drain\\DrainTarget.mdl"
    udg_ncld_CasterSFXArt = "Abilities\\Spells\\Other\\Drain\\DrainCaster.mdl"
    udg_ncld_FreqDrain = 1
    udg_ncld_FreqDistance = 20
    udg_ncld_EtherealBonus = __jreal(1.50)
    udg_ncld_buffId = (__jint(udg_ncld_buffId + 1))
    udg_ncld_BuffList[udg_ncld_buffId] = FourCC("BOwk")
    udg_ncld_CheckImmune = false
    udg_ncld_CheckResistant = false
    udg_ncld_CheckVisibile = false
    udg_tempReal = (__jreal(I2R(udg_ncld_FreqDrain) * __jreal(0.03)))
    udg_ncld_DrainHP = (__jreal(udg_ncld_DrainHP * udg_tempReal))
    udg_ncld_DrainHPUp = (__jreal(udg_ncld_DrainHPUp * udg_tempReal))
    udg_ncld_DrainMP = (__jreal(udg_ncld_DrainMP * udg_tempReal))
    udg_ncld_DrainMPUp = (__jreal(udg_ncld_DrainMPUp * udg_tempReal))
end

function InitTrig_Drain_Setup()
    gg_trg_Drain_Setup = CreateTrigger()
    TriggerAddAction(gg_trg_Drain_Setup, Trig_Drain_Setup_Actions)
end
-- END FOREST SECTION 108

-- BEGIN FOREST SECTION 109 Drain_Cast
function Trig_Drain_Cast_Conditions()
    return GetSpellAbilityId() == udg_ncld_Ability
end

function Trig_Drain_Cast_Func031C()
    return IsTriggerEnabled(gg_trg_Drain_Loop) == false
end

function Trig_Drain_Cast_Actions()
    udg_tempUnit = GetTriggerUnit()
    udg_Key = GetUnitUserData(udg_tempUnit)
    udg_ncld_Target[udg_Key] = GetSpellTargetUnit()
    GroupAddUnitSimple(udg_tempUnit, udg_ncld_Group)
    udg_ncld_Tick[udg_Key] = 0
    udg_ncld_TicksRemaining[udg_Key] = R2I((__jreal((__jreal(udg_ncld_Duration + (__jreal(udg_ncld_Duration_Up * I2R((__jint(GetUnitAbilityLevelSwapped(udg_ncld_Ability, udg_tempUnit) - 1))))))) * __jreal(33.00))))
    udg_ncld_Hp[udg_Key] = (__jreal(udg_ncld_DrainHP + (__jreal(udg_ncld_DrainHPUp * I2R((__jint(GetUnitAbilityLevelSwapped(udg_ncld_Ability, udg_tempUnit) - 1)))))))
    udg_ncld_Mp[udg_Key] = (__jreal(udg_ncld_DrainMP + (__jreal(udg_ncld_DrainMPUp * I2R((__jint(GetUnitAbilityLevelSwapped(udg_ncld_Ability, udg_tempUnit) - 1)))))))
    udg_ncld_Rng[udg_Key] = (__jreal(udg_ncld_Range + (__jreal(udg_ncld_RangeUp * I2R((__jint(GetUnitAbilityLevelSwapped(udg_ncld_Ability, udg_tempUnit) - 1)))))))
    udg_tempLoc1 = GetUnitLoc(udg_tempUnit)
    udg_tempX1 = GetLocationX(udg_tempLoc1)
    udg_tempY1 = GetLocationY(udg_tempLoc1)
    udg_tempZ1 = __jreal(__jreal(GetLocationZ(udg_tempLoc1) + GetUnitFlyHeight(udg_tempUnit)) + __jreal(60))
    RemoveLocation(udg_tempLoc1)
    udg_tempLoc1 = GetUnitLoc(udg_ncld_Target[udg_Key])
    udg_tempX2 = GetLocationX(udg_tempLoc1)
    udg_tempY2 = GetLocationY(udg_tempLoc1)
    udg_tempZ2 = __jreal(__jreal(GetLocationZ(udg_tempLoc1) + GetUnitFlyHeight(udg_ncld_Target[udg_Key])) + __jreal(60))
    RemoveLocation(udg_tempLoc1)
    udg_ncld_Lightning[udg_Key] = AddLightningEx(udg_ncld_LightningArt, true, udg_tempX1, udg_tempY1, udg_tempZ1, udg_tempX2, udg_tempY2, udg_tempZ2)
    AddSpecialEffectTargetUnitBJ("chest", udg_tempUnit, udg_ncld_CasterSFXArt)
    udg_ncld_CasterSFX[udg_Key] = GetLastCreatedEffectBJ()
    AddSpecialEffectTargetUnitBJ("chest", udg_ncld_Target[udg_Key], udg_ncld_TargetSFXArt)
    udg_ncld_TargetSFX[udg_Key] = GetLastCreatedEffectBJ()
    if (Trig_Drain_Cast_Func031C()) then
        EnableTrigger(gg_trg_Drain_Loop)
    end
end

function InitTrig_Drain_Cast()
    gg_trg_Drain_Cast = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Drain_Cast, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Drain_Cast, Condition(Trig_Drain_Cast_Conditions))
    TriggerAddAction(gg_trg_Drain_Cast, Trig_Drain_Cast_Actions)
end
-- END FOREST SECTION 109

-- BEGIN FOREST SECTION 110 Drain_Loop
function Trig_Drain_Loop_Func001Func005Func023Func001Func002C()
    return IsUnitType(udg_ncld_Target[udg_Key], UNIT_TYPE_ETHEREAL) == true
end

function Trig_Drain_Loop_Func001Func005Func023Func001C()
    return IsUnitType(udg_ncld_Target[udg_Key], UNIT_TYPE_MAGIC_IMMUNE) == false
end

function Trig_Drain_Loop_Func001Func005Func023C()
    return ModuloInteger(udg_ncld_Tick[udg_Key], udg_ncld_FreqDrain) == 0
end

function Trig_Drain_Loop_Func001Func005Func025Func002Func001C()
    return UnitHasBuffBJ(udg_ncld_Target[udg_Key], udg_ncld_BuffList[udg_LoopBuffs]) == true
end

function Trig_Drain_Loop_Func001Func005Func025Func003Func002C()
    return IsUnitType(udg_ncld_Target[udg_Key], UNIT_TYPE_MAGIC_IMMUNE) == true
end

function Trig_Drain_Loop_Func001Func005Func025Func003C()
    return udg_ncld_CheckImmune == true
end

function Trig_Drain_Loop_Func001Func005Func025Func004Func002C()
    return IsUnitType(udg_ncld_Target[udg_Key], UNIT_TYPE_RESISTANT) == true
end

function Trig_Drain_Loop_Func001Func005Func025Func004C()
    return udg_ncld_CheckResistant == true
end

function Trig_Drain_Loop_Func001Func005Func025Func005Func002C()
    return IsUnitVisible(udg_ncld_Target[udg_Key], GetOwningPlayer(udg_tempUnit)) == false
end

function Trig_Drain_Loop_Func001Func005Func025Func005C()
    return udg_ncld_CheckVisibile == true
end

function Trig_Drain_Loop_Func001Func005Func025Func006Func001C()
    if (udg_CheckBool == false) then
        return true
    end
    if (IsUnitDeadBJ(udg_ncld_Target[udg_Key]) == true) then
        return true
    end
    if (IsUnitHiddenBJ(udg_ncld_Target[udg_Key]) == true) then
        return true
    end
    return false
end

function Trig_Drain_Loop_Func001Func005Func025Func006C()
    return not not (Trig_Drain_Loop_Func001Func005Func025Func006Func001C())
end

function Trig_Drain_Loop_Func001Func005Func025Func008C()
    return udg_tempDistance > udg_ncld_Rng[udg_Key]
end

function Trig_Drain_Loop_Func001Func005Func025C()
    return ModuloInteger(udg_ncld_Tick[udg_Key], udg_ncld_FreqDistance) == 0
end

function Trig_Drain_Loop_Func001Func005C()
    return udg_ncld_TicksRemaining[udg_Key] >= 0
end

function Trig_Drain_Loop_Func001A()
    udg_tempUnit = GetEnumUnit()
    udg_Key = GetUnitUserData(udg_tempUnit)
    udg_ncld_TicksRemaining[udg_Key] = (__jint(udg_ncld_TicksRemaining[udg_Key] - 1))
    if (Trig_Drain_Loop_Func001Func005C()) then
        udg_ncld_Tick[udg_Key] = (__jint(udg_ncld_Tick[udg_Key] + 1))
        udg_tempLoc1 = GetUnitLoc(udg_tempUnit)
        udg_tempLoc2 = GetUnitLoc(udg_ncld_Target[udg_Key])
        udg_tempX1 = GetLocationX(udg_tempLoc1)
        udg_tempY1 = GetLocationY(udg_tempLoc1)
        udg_tempZ1 = __jreal(__jreal(GetLocationZ(udg_tempLoc1) + GetUnitFlyHeight(udg_tempUnit)) + __jreal(60))
        udg_tempX2 = GetLocationX(udg_tempLoc2)
        udg_tempY2 = GetLocationY(udg_tempLoc2)
        udg_tempZ2 = __jreal(__jreal(GetLocationZ(udg_tempLoc2) + GetUnitFlyHeight(udg_ncld_Target[udg_Key])) + __jreal(60))
        MoveLightningEx(udg_ncld_Lightning[udg_Key], true, udg_tempX1, udg_tempY1, udg_tempZ1, udg_tempX2, udg_tempY2, udg_tempZ2)
        if (Trig_Drain_Loop_Func001Func005Func023C()) then
            if (Trig_Drain_Loop_Func001Func005Func023Func001C()) then
                UnitDamageTargetBJ(udg_tempUnit, udg_ncld_Target[udg_Key], __jreal(0.00), ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL)
                if (Trig_Drain_Loop_Func001Func005Func023Func001Func002C()) then
                    SetUnitLifeBJ(udg_ncld_Target[udg_Key], (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, udg_ncld_Target[udg_Key]) - (__jreal(udg_ncld_Hp[udg_Key] * udg_ncld_EtherealBonus)))))
                    SetUnitManaBJ(udg_ncld_Target[udg_Key], (__jreal(GetUnitStateSwap(UNIT_STATE_MANA, udg_ncld_Target[udg_Key]) - (__jreal(udg_ncld_Mp[udg_Key] * udg_ncld_EtherealBonus)))))
                    SetUnitLifeBJ(udg_tempUnit, (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, udg_tempUnit) + (__jreal(udg_ncld_Hp[udg_Key] * udg_ncld_EtherealBonus)))))
                    SetUnitManaBJ(udg_tempUnit, (__jreal(GetUnitStateSwap(UNIT_STATE_MANA, udg_tempUnit) + (__jreal(udg_ncld_Mp[udg_Key] * udg_ncld_EtherealBonus)))))
                else
                    SetUnitLifeBJ(udg_ncld_Target[udg_Key], (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, udg_ncld_Target[udg_Key]) - udg_ncld_Hp[udg_Key])))
                    SetUnitManaBJ(udg_ncld_Target[udg_Key], (__jreal(GetUnitStateSwap(UNIT_STATE_MANA, udg_ncld_Target[udg_Key]) - udg_ncld_Mp[udg_Key])))
                    SetUnitLifeBJ(udg_tempUnit, (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, udg_tempUnit) + udg_ncld_Hp[udg_Key])))
                    SetUnitManaBJ(udg_tempUnit, (__jreal(GetUnitStateSwap(UNIT_STATE_MANA, udg_tempUnit) + udg_ncld_Mp[udg_Key])))
                end
            end
        end
        if (Trig_Drain_Loop_Func001Func005Func025C()) then
            udg_tempDistance = DistanceBetweenPoints(udg_tempLoc1, udg_tempLoc2)
            if (Trig_Drain_Loop_Func001Func005Func025Func008C()) then
                DrainRemoveInstance(udg_tempUnit, udg_Key, true)
            end
        else
            udg_CheckBool = true
            udg_LoopBuffs = 1
            while true do
                if (udg_LoopBuffs > udg_ncld_buffId) then break end
                if (Trig_Drain_Loop_Func001Func005Func025Func002Func001C()) then
                    udg_CheckBool = false
                end
                udg_LoopBuffs = __jint(udg_LoopBuffs + 1)
            end
            if (Trig_Drain_Loop_Func001Func005Func025Func003C()) then
                if (Trig_Drain_Loop_Func001Func005Func025Func003Func002C()) then
                    udg_CheckBool = false
                end
            end
            if (Trig_Drain_Loop_Func001Func005Func025Func004C()) then
                if (Trig_Drain_Loop_Func001Func005Func025Func004Func002C()) then
                    udg_CheckBool = false
                end
            end
            if (Trig_Drain_Loop_Func001Func005Func025Func005C()) then
                if (Trig_Drain_Loop_Func001Func005Func025Func005Func002C()) then
                    udg_CheckBool = false
                end
            end
            if (Trig_Drain_Loop_Func001Func005Func025Func006C()) then
                DrainRemoveInstance(udg_tempUnit, udg_Key, true)
            end
        end
        RemoveLocation(udg_tempLoc1)
        RemoveLocation(udg_tempLoc2)
    else
        DrainRemoveInstance(udg_tempUnit, udg_Key, false)
    end
end

function Trig_Drain_Loop_Func002C()
    return IsUnitGroupEmptyBJ(udg_ncld_Group) == true
end

function Trig_Drain_Loop_Actions()
    ForGroupBJ(udg_ncld_Group, Trig_Drain_Loop_Func001A)
    if (Trig_Drain_Loop_Func002C()) then
        DisableTrigger(GetTriggeringTrigger())
    end
end

function InitTrig_Drain_Loop()
    gg_trg_Drain_Loop = CreateTrigger()
    DisableTrigger(gg_trg_Drain_Loop)
    TriggerRegisterTimerEventPeriodic(gg_trg_Drain_Loop, __jreal(0.03))
    TriggerAddAction(gg_trg_Drain_Loop, Trig_Drain_Loop_Actions)
end
-- END FOREST SECTION 110

-- BEGIN FOREST SECTION 111 Levelled_Slam
function Trig_Levelled_Slam_Conditions()
    return GetResearched() == FourCC("R043")
end

function Trig_Levelled_Slam_Actions()
    BloodmageUpgradeUnits(0, "A063")
end

function InitTrig_Levelled_Slam()
    gg_trg_Levelled_Slam = CreateTrigger()
    BloodmageResearchEvent(gg_trg_Levelled_Slam, 0, Trig_Levelled_Slam_Conditions, Trig_Levelled_Slam_Actions)
end
-- END FOREST SECTION 111

-- BEGIN FOREST SECTION 112 Levelled_Slam_Copy
function Trig_Levelled_Slam_Copy_Conditions()
    return GetResearched() == FourCC("R043")
end

function Trig_Levelled_Slam_Copy_Actions()
    BloodmageUpgradeUnits(1, "A063")
end

function InitTrig_Levelled_Slam_Copy()
    gg_trg_Levelled_Slam_Copy = CreateTrigger()
    BloodmageResearchEvent(gg_trg_Levelled_Slam_Copy, 1, Trig_Levelled_Slam_Copy_Conditions, Trig_Levelled_Slam_Copy_Actions)
end
-- END FOREST SECTION 112

-- BEGIN FOREST SECTION 113 Levelled_Slam_Copy_2
function Trig_Levelled_Slam_Copy_2_Conditions()
    return GetResearched() == FourCC("R043")
end

function Trig_Levelled_Slam_Copy_2_Actions()
    BloodmageUpgradeUnits(2, "A063")
end

function InitTrig_Levelled_Slam_Copy_2()
    gg_trg_Levelled_Slam_Copy_2 = CreateTrigger()
    BloodmageResearchEvent(gg_trg_Levelled_Slam_Copy_2, 2, Trig_Levelled_Slam_Copy_2_Conditions, Trig_Levelled_Slam_Copy_2_Actions)
end
-- END FOREST SECTION 113

-- BEGIN FOREST SECTION 114 Levelled_Slam_Copy_3
function Trig_Levelled_Slam_Copy_3_Conditions()
    return GetResearched() == FourCC("R043")
end

function Trig_Levelled_Slam_Copy_3_Actions()
    BloodmageUpgradeUnits(3, "A063")
end

function InitTrig_Levelled_Slam_Copy_3()
    gg_trg_Levelled_Slam_Copy_3 = CreateTrigger()
    BloodmageResearchEvent(gg_trg_Levelled_Slam_Copy_3, 3, Trig_Levelled_Slam_Copy_3_Conditions, Trig_Levelled_Slam_Copy_3_Actions)
end
-- END FOREST SECTION 114

-- BEGIN FOREST SECTION 115 Levelled_Slam_Copy_4
function Trig_Levelled_Slam_Copy_4_Conditions()
    return GetResearched() == FourCC("R043")
end

function Trig_Levelled_Slam_Copy_4_Actions()
    BloodmageUpgradeUnits(4, "A063")
end

function InitTrig_Levelled_Slam_Copy_4()
    gg_trg_Levelled_Slam_Copy_4 = CreateTrigger()
    BloodmageResearchEvent(gg_trg_Levelled_Slam_Copy_4, 4, Trig_Levelled_Slam_Copy_4_Conditions, Trig_Levelled_Slam_Copy_4_Actions)
end
-- END FOREST SECTION 115

-- BEGIN FOREST SECTION 116 Levelled_Slam_Copy_5
function Trig_Levelled_Slam_Copy_5_Conditions()
    return GetResearched() == FourCC("R043")
end

function Trig_Levelled_Slam_Copy_5_Actions()
    BloodmageUpgradeUnits(5, "A063")
end

function InitTrig_Levelled_Slam_Copy_5()
    gg_trg_Levelled_Slam_Copy_5 = CreateTrigger()
    BloodmageResearchEvent(gg_trg_Levelled_Slam_Copy_5, 5, Trig_Levelled_Slam_Copy_5_Conditions, Trig_Levelled_Slam_Copy_5_Actions)
end
-- END FOREST SECTION 116

-- BEGIN FOREST SECTION 117 Levelled_Slam_Copy_6
function Trig_Levelled_Slam_Copy_6_Conditions()
    return GetResearched() == FourCC("R043")
end

function Trig_Levelled_Slam_Copy_6_Actions()
    BloodmageUpgradeUnits(6, "A063")
end

function InitTrig_Levelled_Slam_Copy_6()
    gg_trg_Levelled_Slam_Copy_6 = CreateTrigger()
    BloodmageResearchEvent(gg_trg_Levelled_Slam_Copy_6, 6, Trig_Levelled_Slam_Copy_6_Conditions, Trig_Levelled_Slam_Copy_6_Actions)
end
-- END FOREST SECTION 117

-- BEGIN FOREST SECTION 118 Levelled_Slam_Copy_7
function Trig_Levelled_Slam_Copy_7_Conditions()
    return GetResearched() == FourCC("R043")
end

function Trig_Levelled_Slam_Copy_7_Actions()
    BloodmageUpgradeUnits(7, "A063")
end

function InitTrig_Levelled_Slam_Copy_7()
    gg_trg_Levelled_Slam_Copy_7 = CreateTrigger()
    BloodmageResearchEvent(gg_trg_Levelled_Slam_Copy_7, 7, Trig_Levelled_Slam_Copy_7_Conditions, Trig_Levelled_Slam_Copy_7_Actions)
end
-- END FOREST SECTION 118

-- BEGIN FOREST SECTION 119 Levelled_Slam_Copy_8
function Trig_Levelled_Slam_Copy_8_Conditions()
    return GetResearched() == FourCC("R043")
end

function Trig_Levelled_Slam_Copy_8_Actions()
    BloodmageUpgradeUnits(8, "A063")
end

function InitTrig_Levelled_Slam_Copy_8()
    gg_trg_Levelled_Slam_Copy_8 = CreateTrigger()
    BloodmageResearchEvent(gg_trg_Levelled_Slam_Copy_8, 8, Trig_Levelled_Slam_Copy_8_Conditions, Trig_Levelled_Slam_Copy_8_Actions)
end
-- END FOREST SECTION 119

-- BEGIN FOREST SECTION 120 Levelled_Slam_Copy_9
function Trig_Levelled_Slam_Copy_9_Conditions()
    return GetResearched() == FourCC("R043")
end

function Trig_Levelled_Slam_Copy_9_Actions()
    BloodmageUpgradeUnits(9, "A063")
end

function InitTrig_Levelled_Slam_Copy_9()
    gg_trg_Levelled_Slam_Copy_9 = CreateTrigger()
    BloodmageResearchEvent(gg_trg_Levelled_Slam_Copy_9, 9, Trig_Levelled_Slam_Copy_9_Conditions, Trig_Levelled_Slam_Copy_9_Actions)
end
-- END FOREST SECTION 120
