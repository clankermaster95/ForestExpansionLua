-- Original JASS function: sc___prototype2_execute (line 1307)
function sc___prototype2_execute(i, a1, a2, a3, a4)
    f__arg_trigger1 = a1
    f__arg_string1 = a2
    f__arg_limitop1 = a3
    f__arg_real1 = a4
    TriggerExecute(st___prototype2[i])
end

-- Original JASS function: sc___prototype2_evaluate (line 1315)
function sc___prototype2_evaluate(i, a1, a2, a3, a4)
    f__arg_trigger1 = a1
    f__arg_string1 = a2
    f__arg_limitop1 = a3
    f__arg_real1 = a4
    TriggerEvaluate(st___prototype2[i])
end

-- Original JASS function: h__TriggerRegisterVariableEvent (line 1324)
function h__TriggerRegisterVariableEvent(a0, a1, a2, a3)
    sc___prototype2_evaluate(1, a0, a1, a2, a3)
    do return TriggerRegisterVariableEvent(a0, a1, a2, a3) end
end

-- Original JASS function: s__DamageTrigger_checkItem (line 1338)
function s__DamageTrigger_checkItem(u, id)
    local i = 0
    if IsUnitType(u, UNIT_TYPE_HERO) then
        i = UnitInventorySize(u)
        while true do
            if (i <= 0) then break end
            i = __jint(i - 1)
            if (GetItemTypeId(UnitItemInSlot(u, i)) == id) then
                do return true end
            end
        end
    end
    do return false end
end

-- Original JASS function: s__DamageTrigger_checkConfig (line 1354)
function s__DamageTrigger_checkConfig(this)
    if ((s__DamageTrigger_sourceType[this] ~= 0) and (GetUnitTypeId(udg_DamageEventSource) ~= s__DamageTrigger_sourceType[this])) then
    elseif ((s__DamageTrigger_targetType[this] ~= 0) and (GetUnitTypeId(udg_DamageEventTarget) ~= s__DamageTrigger_targetType[this])) then
    elseif ((s__DamageTrigger_sourceBuff[this] ~= 0) and (GetUnitAbilityLevel(udg_DamageEventSource, s__DamageTrigger_sourceBuff[this]) == 0)) then
    elseif ((s__DamageTrigger_targetBuff[this] ~= 0) and (GetUnitAbilityLevel(udg_DamageEventTarget, s__DamageTrigger_targetBuff[this]) == 0)) then
    elseif ((s__DamageTrigger_failChance[this] > __jreal(0.00)) and (GetRandomReal(__jreal(0.00), __jreal(1.00)) <= s__DamageTrigger_failChance[this])) then
    elseif ((s__DamageTrigger_userType[this] ~= 0) and (udg_DamageEventType ~= s__DamageTrigger_userType[this])) then
    elseif ((s__DamageTrigger_source[this] ~= nil) and (s__DamageTrigger_source[this] ~= udg_DamageEventSource)) then
    elseif ((s__DamageTrigger_target[this] ~= nil) and (s__DamageTrigger_target[this] ~= udg_DamageEventTarget)) then
    elseif ((s__DamageTrigger_attackType[this] >= 0) and (s__DamageTrigger_attackType[this] ~= udg_DamageEventAttackT)) then
    elseif ((s__DamageTrigger_damageType[this] >= 0) and (s__DamageTrigger_damageType[this] ~= udg_DamageEventDamageT)) then
    elseif ((s__DamageTrigger_sourceItem[this] ~= 0) and (not s__DamageTrigger_checkItem(udg_DamageEventSource, s__DamageTrigger_sourceItem[this]))) then
    elseif ((s__DamageTrigger_targetItem[this] ~= 0) and (not s__DamageTrigger_checkItem(udg_DamageEventTarget, s__DamageTrigger_targetItem[this]))) then
    elseif ((s__DamageTrigger_sourceClass[this] >= 0) and (not IsUnitType(udg_DamageEventSource, ConvertUnitType(s__DamageTrigger_sourceClass[this])))) then
    elseif ((s__DamageTrigger_targetClass[this] >= 0) and (not IsUnitType(udg_DamageEventTarget, ConvertUnitType(s__DamageTrigger_targetClass[this])))) then
    elseif (udg_DamageEventAmount >= s__DamageTrigger_damageMin[this]) then
        do return true end
    end
    do return false end
end

-- Original JASS function: s__DamageTrigger__get_runChance (line 1392)
function s__DamageTrigger__get_runChance(this)
    do return __jreal(__jreal(1.00) - s__DamageTrigger_failChance[this]) end
end

-- Original JASS function: s__DamageTrigger__set_runChance (line 1397)
function s__DamageTrigger__set_runChance(this, chance)
    s__DamageTrigger_failChance[this] = __jreal(__jreal(1.00) - chance)
end

-- Original JASS function: s__DamageTrigger_configure (line 1401)
function s__DamageTrigger_configure(this)
    s__DamageTrigger_attackType[this] = udg_DamageFilterAttackT
    s__DamageTrigger_damageType[this] = udg_DamageFilterDamageT
    s__DamageTrigger_source[this] = udg_DamageFilterSource
    s__DamageTrigger_target[this] = udg_DamageFilterTarget
    s__DamageTrigger_sourceType[this] = udg_DamageFilterSourceT
    s__DamageTrigger_targetType[this] = udg_DamageFilterTargetT
    s__DamageTrigger_sourceItem[this] = udg_DamageFilterSourceI
    s__DamageTrigger_targetItem[this] = udg_DamageFilterTargetI
    s__DamageTrigger_sourceClass[this] = udg_DamageFilterSourceC
    s__DamageTrigger_targetClass[this] = udg_DamageFilterTargetC
    s__DamageTrigger_userType[this] = udg_DamageFilterType
    s__DamageTrigger_damageMin[this] = udg_DamageFilterMinAmount
    s__DamageTrigger_failChance[this] = __jreal(__jreal(1.00) - (__jreal(udg_DamageFilterRunChance - udg_DamageFilterFailChance)))
    if (udg_DamageFilterSourceA > 0) then
        s__DamageTrigger_sourceBuff[this] = udg_DamageFilterSourceA
        udg_DamageFilterSourceA = 0
    else
        s__DamageTrigger_sourceBuff[this] = udg_DamageFilterSourceB
    end
    if (udg_DamageFilterTargetA > 0) then
        s__DamageTrigger_targetBuff[this] = udg_DamageFilterTargetA
        udg_DamageFilterTargetA = 0
    else
        s__DamageTrigger_targetBuff[this] = udg_DamageFilterTargetB
    end
    udg_DamageFilterSource = nil
    udg_DamageFilterTarget = nil
    udg_DamageFilterAttackT = __jint(-(1))
    udg_DamageFilterDamageT = __jint(-(1))
    udg_DamageFilterSourceC = __jint(-(1))
    udg_DamageFilterTargetC = __jint(-(1))
    udg_DamageFilterSourceT = 0
    udg_DamageFilterTargetT = 0
    udg_DamageFilterType = 0
    udg_DamageFilterSourceB = 0
    udg_DamageFilterTargetB = 0
    udg_DamageFilterSourceI = 0
    udg_DamageFilterTargetI = 0
    udg_DamageFilterMinAmount = __jreal(0.00)
    udg_DamageFilterFailChance = __jreal(0.00)
    udg_DamageFilterRunChance = __jreal(1.00)
    s__DamageTrigger_configured[this] = true
end

-- Original JASS function: s__DamageTrigger_setGUIFromStruct (line 1454)
function s__DamageTrigger_setGUIFromStruct(full)
    udg_DamageEventAmount = s__Damage_damage[s__Damage_index]
    udg_DamageEventAttackT = GetHandleId(s__Damage_attackType[s__Damage_index])
    udg_DamageEventDamageT = GetHandleId(s__Damage_damageType[s__Damage_index])
    udg_DamageEventWeaponT = GetHandleId(s__Damage_weaponType[s__Damage_index])
    udg_DamageEventType = s__Damage_userType[s__Damage_index]
    udg_DamageEventArmorPierced = s__Damage_armorPierced[s__Damage_index]
    udg_DamageEventArmorT = s__Damage_armorType[s__Damage_index]
    udg_DamageEventDefenseT = s__Damage_defenseType[s__Damage_index]
    if full then
        udg_DamageEventSource = s__Damage_sourceUnit[s__Damage_index]
        udg_DamageEventTarget = s__Damage_targetUnit[s__Damage_index]
        udg_DamageEventPrevAmt = s__Damage_prevAmt[s__Damage_index]
        udg_IsDamageAttack = s__Damage_isAttack[s__Damage_index]
        udg_IsDamageCode = s__Damage_isCode[s__Damage_index]
        udg_IsDamageSpell = s__Damage_isSpell[s__Damage_index]
        udg_IsDamageMelee = s__Damage_isMelee[s__Damage_index]
        udg_IsDamageRanged = s__Damage_isRanged[s__Damage_index]
    end
end

-- Original JASS function: s__DamageTrigger_setStructFromGUI (line 1483)
function s__DamageTrigger_setStructFromGUI()
    s__Damage_damage[s__Damage_index] = udg_DamageEventAmount
    s__Damage_attackType[s__Damage_index] = ConvertAttackType(udg_DamageEventAttackT)
    s__Damage_damageType[s__Damage_index] = ConvertDamageType(udg_DamageEventDamageT)
    s__Damage_weaponType[s__Damage_index] = ConvertWeaponType(udg_DamageEventWeaponT)
    s__Damage_userType[s__Damage_index] = udg_DamageEventType
    s__Damage_armorPierced[s__Damage_index] = udg_DamageEventArmorPierced
    s__Damage_armorType[s__Damage_index] = udg_DamageEventArmorT
    s__Damage_defenseType[s__Damage_index] = udg_DamageEventDefenseT
end

-- Original JASS function: s__DamageTrigger_getVerboseStr (line 1497)
function s__DamageTrigger_getVerboseStr(eventName)
    if ((eventName == "Modifier") or (eventName == "Mod")) then
        do return "udg_DamageModifierEvent" end
    end
    do return __jconcat(__jconcat("udg_", eventName), "DamageEvent") end
end

-- Original JASS function: s__DamageTrigger_getStrIndex (line 1504)
function s__DamageTrigger_getStrIndex(var, lbs)
    local root = R2I(lbs)
    if ((((var == "udg_DamageModifierEvent") and (root < 4))) or (var == "udg_PreDamageEvent")) then
        root = s__DamageTrigger_MOD
    elseif ((var == "udg_DamageModifierEvent") or (var == "udg_ArmorDamageEvent")) then
        root = s__DamageTrigger_SHIELD
    elseif (((((var == "udg_DamageEvent") and (root == 2)) or (root == 0))) or (var == "udg_ZeroDamageEvent")) then
        root = s__DamageTrigger_ZERO
    elseif ((var == "udg_DamageEvent") or (var == "udg_OnDamageEvent")) then
        root = s__DamageTrigger_DAMAGE
    elseif (var == "udg_AfterDamageEvent") then
        root = s__DamageTrigger_AFTER
    elseif (var == "udg_LethalDamageEvent") then
        root = s__DamageTrigger_LETHAL
    elseif ((var == "udg_AOEDamageEvent") or (var == "udg_SourceDamageEvent")) then
        root = s__DamageTrigger_AOE
    else
        root = 0
    end
    do return root end
end

-- Original JASS function: s__DamageTrigger_toggleAllFilters (line 1533)
function s__DamageTrigger_toggleAllFilters(this, flag)
    s__DamageTrigger_filters[__jint(this + DamageEngine_FILTER_ATTACK)] = flag
    s__DamageTrigger_filters[__jint(this + DamageEngine_FILTER_MELEE)] = flag
    s__DamageTrigger_filters[__jint(this + DamageEngine_FILTER_OTHER)] = flag
    s__DamageTrigger_filters[__jint(this + DamageEngine_FILTER_RANGED)] = flag
    s__DamageTrigger_filters[__jint(this + DamageEngine_FILTER_SPELL)] = flag
    s__DamageTrigger_filters[__jint(this + DamageEngine_FILTER_CODE)] = flag
end

-- Original JASS function: s__DamageTrigger__set_filter (line 1542)
function s__DamageTrigger__set_filter(this, opId)
    this = __jint(this * DamageEngine_FILTER_MAX)
    if (opId == DamageEngine_FILTER_OTHER) then
        s__DamageTrigger_toggleAllFilters(this, true)
    else
        if (opId == DamageEngine_FILTER_ATTACK) then
            s__DamageTrigger_filters[__jint(this + DamageEngine_FILTER_ATTACK)] = true
            s__DamageTrigger_filters[__jint(this + DamageEngine_FILTER_MELEE)] = true
            s__DamageTrigger_filters[__jint(this + DamageEngine_FILTER_RANGED)] = true
        else
            s__DamageTrigger_filters[__jint(this + opId)] = true
        end
    end
end

-- Original JASS function: s__DamageTrigger_registerVerbose (line 1557)
function s__DamageTrigger_registerVerbose(whichTrig, var, lbs, GUI, filt)
    local index = s__DamageTrigger_getStrIndex(var, lbs)
    local i = 0
    local id = 0
    if (index == 0) then
        do return 0 end
    elseif ((s__DamageTrigger_rootTrig[s__DamageTrigger_lastRegistered] == whichTrig) and s__DamageTrigger_usingGUI[s__DamageTrigger_lastRegistered]) then
        s__DamageTrigger_filters[__jint(__jint(s__DamageTrigger_lastRegistered * DamageEngine_FILTER_MAX) + filt)] = true
        do return 0 end
    end
    DamageEngine___atLeastOneLethalDamageEventRegistered = (DamageEngine___atLeastOneLethalDamageEventRegistered or (index == s__DamageTrigger_LETHAL))
    if (s__DamageTrigger_trigIndexStack[0] == 0) then
        s__DamageTrigger_count = __jint(s__DamageTrigger_count + 1)
        id = s__DamageTrigger_count
    else
        id = s__DamageTrigger_trigIndexStack[0]
        s__DamageTrigger_trigIndexStack[0] = s__DamageTrigger_trigIndexStack[id]
    end
    s__DamageTrigger_lastRegistered = id
    s__DamageTrigger__set_filter(id, filt)
    s__DamageTrigger_rootTrig[id] = whichTrig
    s__DamageTrigger_usingGUI[id] = GUI
    s__DamageTrigger_weight[id] = lbs
    s__DamageTrigger_eventStr[id] = var
    s__DamageTrigger_attackType[id] = __jint(-(1))
    s__DamageTrigger_damageType[id] = __jint(-(1))
    s__DamageTrigger_sourceClass[id] = __jint(-(1))
    s__DamageTrigger_targetClass[id] = __jint(-(1))
    while true do
        i = s__DamageTrigger_next[index]
        if ((i == 0) or (lbs < s__DamageTrigger_weight[i])) then break end
        index = i
    end
    s__DamageTrigger_next[index] = id
    s__DamageTrigger_next[id] = i
    do return s__DamageTrigger_lastRegistered end
end

-- Original JASS function: s__DamageTrigger_registerTrigger (line 1607)
function s__DamageTrigger_registerTrigger(t, var, lbs)
    do return s__DamageTrigger_registerVerbose(t, s__DamageTrigger_getVerboseStr(var), lbs, false, DamageEngine_FILTER_OTHER) end
end

-- Original JASS function: s__DamageTrigger_getIndex (line 1611)
function s__DamageTrigger_getIndex(t, eventName, lbs)
    local index = s__DamageTrigger_getStrIndex(s__DamageTrigger_getVerboseStr(eventName), lbs)
    while true do
        s__DamageTrigger_prev = index
        index = s__DamageTrigger_next[index]
        if ((index == 0) or (s__DamageTrigger_rootTrig[index] == t)) then break end
    end
    do return index end
end

-- Original JASS function: s__DamageTrigger_unregisterByIndex (line 1621)
function s__DamageTrigger_unregisterByIndex(this, reset)
    if (this == 0) then
        do return false end
    end
    s__DamageTrigger_next[s__DamageTrigger_prev] = s__DamageTrigger_next[this]
    s__DamageTrigger_trigIndexStack[this] = s__DamageTrigger_trigIndexStack[0]
    s__DamageTrigger_trigIndexStack[0] = this
    if reset then
        s__DamageTrigger_configure(this)
        s__DamageTrigger_configured[this] = false
        s__DamageTrigger_toggleAllFilters((__jint(this * DamageEngine_FILTER_MAX)), false)
    end
    do return true end
end

-- Original JASS function: s__DamageTrigger_unregister (line 1638)
function s__DamageTrigger_unregister(t, eventName, lbs, reset)
    do return s__DamageTrigger_unregisterByIndex(s__DamageTrigger_getIndex(t, eventName, lbs), reset) end
end

-- Original JASS function: s__DamageTrigger_DamageEngine___run (line 1642)
function s__DamageTrigger_DamageEngine___run(this)
    local cat = this
    local d = s__Damage_index
    local structUnset = false
    local guiUnset = false
    local mod = (cat <= s__DamageTrigger_DAMAGE)
    if DamageEngine___callbacksInProgress then
        do return end
    end
    DamageEngine___callbacksInProgress = true
    DisableTrigger(DamageEngine___damagingTrigger)
    DisableTrigger(DamageEngine___damagedTrigger)
    EnableTrigger(DamageEngine___recursiveTrigger)
    while true do
        this = s__DamageTrigger_next[this]
        if (this == 0) then break end
        if ((cat == s__DamageTrigger_MOD) and ((udg_DamageEventOverride or (udg_DamageEventType == DamageEngine_TYPE_PURE)))) then break end
        if ((cat == s__DamageTrigger_SHIELD) and (udg_DamageEventAmount <= __jreal(0.00))) then break end
        if ((cat == s__DamageTrigger_LETHAL) and (udg_LethalDamageHP > DamageEngine___DEATH_VAL)) then break end
        s__DamageTrigger_eventIndex = this
        if ((((((not s__DamageTrigger_DamageEngine___trigFrozen[this])) and s__DamageTrigger_filters[__jint(__jint(this * DamageEngine_FILTER_MAX) + s__Damage_eFilter[d])]) and IsTriggerEnabled(s__DamageTrigger_rootTrig[this])) and ((((not s__DamageTrigger_configured[this])) or (s__DamageTrigger_checkConfig(this))))) and ((((cat ~= s__DamageTrigger_AOE) or (udg_DamageEventAOE > 1)) or (s__DamageTrigger_eventStr[this] == "udg_SourceDamageEvent")))) then
            if mod then
                if s__DamageTrigger_usingGUI[this] then
                    if guiUnset then
                        guiUnset = false
                        s__DamageTrigger_setGUIFromStruct(false)
                    end
                elseif structUnset then
                    structUnset = false
                    s__DamageTrigger_setStructFromGUI()
                end
            end
            if TriggerEvaluate(s__DamageTrigger_rootTrig[this]) then
                TriggerExecute(s__DamageTrigger_rootTrig[this])
            end
            if mod then
                if s__DamageTrigger_usingGUI[this] then
                    if (cat ~= s__DamageTrigger_MOD) then
                        s__Damage_damage[d] = udg_DamageEventAmount
                    else
                        structUnset = true
                    end
                elseif (cat ~= s__DamageTrigger_MOD) then
                    udg_DamageEventAmount = s__Damage_damage[d]
                else
                    guiUnset = true
                end
            end
            if udg_RemoveDamageEvent then
                udg_RemoveDamageEvent = false
                s__DamageTrigger_unregisterByIndex(this, true)
            end
        end
    end
    if structUnset then
        s__DamageTrigger_setStructFromGUI()
    end
    if guiUnset then
        s__DamageTrigger_setGUIFromStruct(false)
    end
    DisableTrigger(DamageEngine___recursiveTrigger)
    EnableTrigger(DamageEngine___damagingTrigger)
    EnableTrigger(DamageEngine___damagedTrigger)
    DamageEngine___callbacksInProgress = false
end

-- Original JASS function: s__DamageTrigger__staticgetindex (line 1746)
function s__DamageTrigger__staticgetindex(callback)
    local i = 0
    local b = Filter(callback)
    while true do
        if (i == s__DamageTrigger_autoN) then
            s__DamageTrigger_autoTriggers[i] = CreateTrigger()
            s__DamageTrigger_autoFuncs[i] = b
            TriggerAddCondition(s__DamageTrigger_autoTriggers[i], b)
            if true then break end
        end
        i = __jint(i + 1)
        if (b == s__DamageTrigger_autoFuncs[i]) then break end
    end
    do return s__DamageTrigger_autoTriggers[i] end
end

-- Original JASS function: s__Damage__get_source (line 1782)
function s__Damage__get_source()
    do return udg_DamageEventSource end
end

-- Original JASS function: s__Damage__get_target (line 1786)
function s__Damage__get_target()
    do return udg_DamageEventTarget end
end

-- Original JASS function: s__Damage__get_amount (line 1790)
function s__Damage__get_amount()
    do return s__Damage_damage[s__Damage_index] end
end

-- Original JASS function: s__Damage__set_amount (line 1794)
function s__Damage__set_amount(r)
    s__Damage_damage[s__Damage_index] = r
end

-- Original JASS function: s__Damage_setArmor (line 1799)
function s__Damage_setArmor(this, reset)
    local pierce = 0.0
    local at = 0
    local dt = 0
    if reset then
        pierce = udg_DamageEventArmorPierced
        at = s__Damage_prevArmorT[s__Damage_index]
        dt = s__Damage_prevDefenseT[s__Damage_index]
        udg_DamageEventArmorPierced = __jreal(0.00)
        s__Damage_armorPierced[this] = __jreal(0.00)
    else
        pierce = (-(udg_DamageEventArmorPierced))
        at = udg_DamageEventArmorT
        dt = udg_DamageEventDefenseT
    end
    if (not ((pierce == __jreal(0.00)))) then
        BlzSetUnitArmor(udg_DamageEventTarget, __jreal(BlzGetUnitArmor(udg_DamageEventTarget) + pierce))
    end
    if (s__Damage_prevArmorT[s__Damage_index] ~= udg_DamageEventArmorT) then
        BlzSetUnitIntegerField(udg_DamageEventTarget, UNIT_IF_ARMOR_TYPE, at)
    end
    if (s__Damage_prevDefenseT[s__Damage_index] ~= udg_DamageEventDefenseT) then
        BlzSetUnitIntegerField(udg_DamageEventTarget, UNIT_IF_DEFENSE_TYPE, dt)
    end
end

-- Original JASS function: s__Damage_onAOEEnd (line 1830)
function s__Damage_onAOEEnd()
    s__DamageTrigger_DamageEngine___run(s__DamageTrigger_AOE)
    udg_DamageEventAOE = 1
    udg_DamageEventLevel = 1
    udg_EnhancedDamageTarget = nil
    udg_AOEDamageSource = nil
    GroupClear(udg_DamageEventAOEGroup)
end

-- Original JASS function: s__Damage_afterDamage (line 1840)
function s__Damage_afterDamage()
    if ((udg_DamageEventDamageT ~= 0) and (not ((udg_DamageEventPrevAmt == __jreal(0.00))))) then
        s__DamageTrigger_DamageEngine___run(s__DamageTrigger_AFTER)
        udg_DamageEventDamageT = 0
        udg_DamageEventPrevAmt = __jreal(0.00)
    end
end

-- Original JASS function: s__Damage_runDamagingEvents (line 1848)
function s__Damage_runDamagingEvents(this, natural)
    s__Damage_armorType[this] = BlzGetUnitIntegerField(s__Damage_targetUnit[this], UNIT_IF_ARMOR_TYPE)
    s__Damage_defenseType[this] = BlzGetUnitIntegerField(s__Damage_targetUnit[this], UNIT_IF_DEFENSE_TYPE)
    s__Damage_prevArmorT[this] = s__Damage_armorType[this]
    s__Damage_prevDefenseT[this] = s__Damage_defenseType[this]
    s__Damage_armorPierced[this] = __jreal(0.00)
    s__Damage_index = this
    s__DamageTrigger_setGUIFromStruct(true)
    GroupAddUnit(DamageEngine___recursionSources, udg_DamageEventSource)
    GroupAddUnit(DamageEngine___recursionTargets, udg_DamageEventTarget)
    if (not ((udg_DamageEventAmount == __jreal(0.00)))) then
        udg_DamageEventOverride = (udg_DamageEventDamageT == 0)
        s__DamageTrigger_DamageEngine___run(s__DamageTrigger_MOD)
        if natural then
            BlzSetEventAttackType(s__Damage_attackType[this])
            BlzSetEventDamageType(s__Damage_damageType[this])
            BlzSetEventWeaponType(s__Damage_weaponType[this])
            BlzSetEventDamage(udg_DamageEventAmount)
        end
        s__Damage_setArmor(this, false)
        do return false end
    end
    do return true end
end

-- Original JASS function: s__Damage_unfreeze (line 1897)
function s__Damage_unfreeze()
    local i = s__Damage_damageStack
    while true do
        if (i == 0) then break end
        i = __jint(i - 1)
        s__DamageTrigger_DamageEngine___trigFrozen[s__Damage_recursiveTrig[s__Damage_stackRef[i]]] = false
        s__DamageTrigger_DamageEngine___ownRecursiveDepth[s__Damage_recursiveTrig[s__Damage_stackRef[i]]] = 0
    end
    EnableTrigger(DamageEngine___damagingTrigger)
    EnableTrigger(DamageEngine___damagedTrigger)
    DamageEngine___recursiveCallbaksInProgress = false
    s__Damage_damageStack = 0
    s__Damage_prepped = 0
    DamageEngine___callbacksInProgress = false
    DamageEngine___recursiveCallbackDepth = 0
    GroupClear(DamageEngine___recursionSources)
    GroupClear(DamageEngine___recursionTargets)
end

-- Original JASS function: s__Damage_runAfterDamageEvents (line 1921)
function s__Damage_runAfterDamageEvents()
    local i = 0
    local exit = 0
    if DamageEngine___nativeEventsCompleted then
        DamageEngine___nativeEventsCompleted = false
        s__Damage_afterDamage()
    end
    if (DamageEngine___isNotNativeRecursiveDamage and (not DamageEngine___recursiveCallbaksInProgress)) then
        if (s__Damage_damageStack ~= 0) then
            DamageEngine___recursiveCallbaksInProgress = true
            while true do
                DamageEngine___recursiveCallbackDepth = __jint(DamageEngine___recursiveCallbackDepth + 1)
                exit = s__Damage_damageStack
                while true do
                    s__Damage_prepped = s__Damage_stackRef[i]
                    if UnitAlive(s__Damage_targetUnit[s__Damage_prepped]) then
                        s__Damage_runDamagingEvents(s__Damage_prepped, false)
                        if (s__Damage_damage[s__Damage_prepped] > __jreal(0.00)) then
                            DisableTrigger(DamageEngine___damagingTrigger)
                            EnableTrigger(DamageEngine___damagedTrigger)
                            DamageEngine___waitingForDamageEventToRun = true
                            UnitDamageTarget(s__Damage_sourceUnit[s__Damage_prepped], s__Damage_targetUnit[s__Damage_prepped], s__Damage_damage[s__Damage_prepped], s__Damage_isAttack[s__Damage_prepped], s__Damage_isRanged[s__Damage_prepped], s__Damage_attackType[s__Damage_prepped], s__Damage_damageType[s__Damage_prepped], s__Damage_weaponType[s__Damage_prepped])
                        else
                            if (udg_DamageEventDamageT ~= 0) then
                                s__DamageTrigger_DamageEngine___run(s__DamageTrigger_DAMAGE)
                            end
                            if (s__Damage_damage[s__Damage_prepped] < __jreal(0.00)) then
                                SetWidgetLife(s__Damage_targetUnit[s__Damage_prepped], __jreal(GetWidgetLife(s__Damage_targetUnit[s__Damage_prepped]) - s__Damage_damage[s__Damage_prepped]))
                            end
                            s__Damage_setArmor(s__Damage_prepped, true)
                        end
                        s__Damage_afterDamage()
                    end
                    i = __jint(i + 1)
                    if (i == exit) then break end
                end
                if (i == s__Damage_damageStack) then break end
            end
        end
        s__Damage_unfreeze()
    end
end

-- Original JASS function: s__Damage_failsafeClear (line 1979)
function s__Damage_failsafeClear()
    s__Damage_setArmor(s__Damage_index, true)
    DamageEngine___isNotNativeRecursiveDamage = true
    DamageEngine___recursiveCallbaksInProgress = false
    DamageEngine___waitingForDamageEventToRun = false
    if (udg_DamageEventDamageT ~= 0) then
        s__DamageTrigger_DamageEngine___run(s__DamageTrigger_DAMAGE)
        DamageEngine___nativeEventsCompleted = true
    end
    s__Damage_runAfterDamageEvents()
end

-- Original JASS function: s__Damage__set_enabled (line 1996)
function s__Damage__set_enabled(b)
    if b then
        if DamageEngine___callbacksInProgress then
            EnableTrigger(DamageEngine___recursiveTrigger)
        else
            EnableTrigger(DamageEngine___damagingTrigger)
            EnableTrigger(DamageEngine___damagedTrigger)
        end
    else
        if DamageEngine___callbacksInProgress then
            DisableTrigger(DamageEngine___recursiveTrigger)
        else
            DisableTrigger(DamageEngine___damagingTrigger)
            DisableTrigger(DamageEngine___damagedTrigger)
        end
    end
end

-- Original JASS function: s__Damage__get_enabled (line 2014)
function s__Damage__get_enabled()
    do return IsTriggerEnabled(DamageEngine___damagingTrigger) end
end

-- Original JASS function: s__Damage_asyncCallbackSafeCallback (line 2019)
function s__Damage_asyncCallbackSafeCallback()
    if DamageEngine___waitingForDamageEventToRun then
        s__Damage_failsafeClear()
    else
        DamageEngine___isNotNativeRecursiveDamage = true
        DamageEngine___recursiveCallbaksInProgress = false
        s__Damage_runAfterDamageEvents()
    end
    s__Damage_onAOEEnd()
    s__Damage_threadCompleted = true
end

-- Original JASS function: s__Damage_asyncCallback (line 2036)
function s__Damage_asyncCallback()
    DamageEngine___callbacksInProgress = false
    s__Damage__set_enabled(true)
    ForForce(bj_FORCE_PLAYER[0], s__Damage_asyncCallbackSafeCallback)
    if (not s__Damage_threadCompleted) then
        s__Damage_unfreeze()
    else
        s__Damage_threadCompleted = false
    end
    s__Damage_count = 0
    s__Damage_index = 0
    DamageEngine___timerStarted = false
end

-- Original JASS function: s__Damage_addRecursive (line 2056)
function s__Damage_addRecursive(this)
    local currentIndex = 0
    if (not ((s__Damage_damage[this] == __jreal(0.00)))) then
        currentIndex = s__DamageTrigger_eventIndex
        s__Damage_recursiveTrig[this] = currentIndex
        if (not s__Damage_isCode[this]) then
            s__Damage_isCode[this] = true
            s__Damage_userType[this] = DamageEngine_TYPE_CODE
        end
        DamageEngine_inception = (DamageEngine_inception or s__DamageTrigger_DamageEngine___manualRecursionRequested[currentIndex])
        if ((DamageEngine___recursiveCallbaksInProgress and IsUnitInGroup(s__Damage_sourceUnit[this], DamageEngine___recursionSources)) and IsUnitInGroup(s__Damage_targetUnit[this], DamageEngine___recursionTargets)) then
            if (not DamageEngine_inception) then
                s__DamageTrigger_DamageEngine___trigFrozen[currentIndex] = true
            elseif (not s__DamageTrigger_DamageEngine___trigFrozen[currentIndex]) then
                s__DamageTrigger_DamageEngine___manualRecursionRequested[currentIndex] = true
                if (s__DamageTrigger_DamageEngine___ownRecursiveDepth[currentIndex] < DamageEngine___recursiveCallbackDepth) then
                    s__DamageTrigger_DamageEngine___ownRecursiveDepth[currentIndex] = __jint(s__DamageTrigger_DamageEngine___ownRecursiveDepth[currentIndex] + 1)
                    if (s__DamageTrigger_DamageEngine___ownRecursiveDepth[currentIndex] >= DamageEngine___MAX_RECURSIVE_TOLERANCE) then
                        s__DamageTrigger_DamageEngine___trigFrozen[currentIndex] = true
                    end
                end
            end
        end
        s__Damage_stackRef[s__Damage_damageStack] = this
        s__Damage_damageStack = __jint(s__Damage_damageStack + 1)
    end
    DamageEngine_inception = false
end

-- Original JASS function: s__Damage_clearNexts (line 2101)
function s__Damage_clearNexts()
    udg_NextDamageIsAttack = false
    udg_NextDamageType = 0
    udg_NextDamageWeaponT = 0
    udg_NextDamageIsMelee = false
    udg_NextDamageIsRanged = false
end

-- Original JASS function: s__Damage_create (line 2112)
function s__Damage_create(src, tgt, amt, isAttack, at, dt, wt)
    local d = __jint(s__Damage_count + 1)
    s__Damage_count = d
    s__Damage_sourceUnit[d] = src
    s__Damage_targetUnit[d] = tgt
    s__Damage_damage[d] = amt
    s__Damage_prevAmt[d] = amt
    s__Damage_damageType[d] = dt
    s__Damage_attackType[d] = at
    s__Damage_weaponType[d] = wt
    s__Damage_isAttack[d] = (udg_NextDamageIsAttack or isAttack)
    s__Damage_isSpell[d] = ((s__Damage_attackType[d] == nil) and (not s__Damage_isAttack[d]))
    do return d end
end

-- Original JASS function: s__Damage_createFromEvent (line 2130)
function s__Damage_createFromEvent()
    local d = s__Damage_create(GetEventDamageSource(), GetTriggerUnit(), GetEventDamage(), BlzGetEventIsAttack(), BlzGetEventAttackType(), BlzGetEventDamageType(), BlzGetEventWeaponType())
    s__Damage_isCode[d] = (((((((udg_NextDamageType ~= 0) or udg_NextDamageIsAttack) or udg_NextDamageIsRanged) or udg_NextDamageIsMelee) or (s__Damage_damageType[d] == DAMAGE_TYPE_MIND)) or (udg_NextDamageWeaponT ~= 0)) or (((s__Damage_damageType[d] == DAMAGE_TYPE_UNKNOWN) and (not ((s__Damage_damage[d] == __jreal(0.00)))))))
    if s__Damage_isCode[d] then
        if (udg_NextDamageType ~= 0) then
            s__Damage_userType[d] = udg_NextDamageType
        else
            s__Damage_userType[d] = DamageEngine_TYPE_CODE
        end
        s__Damage_isMelee[d] = udg_NextDamageIsMelee
        s__Damage_isRanged[d] = udg_NextDamageIsRanged
        s__Damage_eFilter[d] = DamageEngine_FILTER_CODE
        if (udg_NextDamageWeaponT ~= 0) then
            s__Damage_weaponType[d] = ConvertWeaponType(udg_NextDamageWeaponT)
            udg_NextDamageWeaponT = 0
        end
    else
        s__Damage_userType[d] = 0
        if ((s__Damage_damageType[d] == DAMAGE_TYPE_NORMAL) and s__Damage_isAttack[d]) then
            s__Damage_isMelee[d] = IsUnitType(s__Damage_sourceUnit[d], UNIT_TYPE_MELEE_ATTACKER)
            s__Damage_isRanged[d] = IsUnitType(s__Damage_sourceUnit[d], UNIT_TYPE_RANGED_ATTACKER)
            if (s__Damage_isMelee[d] and s__Damage_isRanged[d]) then
                s__Damage_isMelee[d] = (s__Damage_weaponType[d] ~= nil)
                s__Damage_isRanged[d] = (not s__Damage_isMelee[d])
            end
            if s__Damage_isMelee[d] then
                s__Damage_eFilter[d] = DamageEngine_FILTER_MELEE
            elseif s__Damage_isRanged[d] then
                s__Damage_eFilter[d] = DamageEngine_FILTER_RANGED
            else
                s__Damage_eFilter[d] = DamageEngine_FILTER_ATTACK
            end
        else
            if s__Damage_isSpell[d] then
                s__Damage_eFilter[d] = DamageEngine_FILTER_SPELL
            else
                s__Damage_eFilter[d] = DamageEngine_FILTER_OTHER
            end
            s__Damage_isMelee[d] = false
            s__Damage_isRanged[d] = false
        end
    end
    s__Damage_clearNexts()
    do return d end
end

-- Original JASS function: s__Damage_onRecursiveDamageCallback (line 2204)
function s__Damage_onRecursiveDamageCallback()
    local d = s__Damage_createFromEvent()
    s__Damage_addRecursive(d)
    BlzSetEventDamage(__jreal(0.00))
    do return false end
end

-- Original JASS function: s__Damage_onDamagingCallback (line 2211)
function s__Damage_onDamagingCallback()
    local d = s__Damage_createFromEvent()
    if DamageEngine___timerStarted then
        if DamageEngine___waitingForDamageEventToRun then
            if (((s__Damage_damageType[d] == DAMAGE_TYPE_SPIRIT_LINK) or (s__Damage_damageType[d] == DAMAGE_TYPE_DEFENSIVE)) or (s__Damage_damageType[d] == DAMAGE_TYPE_PLANT)) then
                DamageEngine___waitingForDamageEventToRun = false
                DamageEngine___lastInstance = s__Damage_index
                DamageEngine___isNotNativeRecursiveDamage = false
            else
                s__Damage_failsafeClear()
            end
        else
            s__Damage_runAfterDamageEvents()
        end
        if (s__Damage_sourceUnit[d] ~= udg_AOEDamageSource) then
            s__Damage_onAOEEnd()
            udg_AOEDamageSource = s__Damage_sourceUnit[d]
            udg_EnhancedDamageTarget = s__Damage_targetUnit[d]
        elseif (s__Damage_targetUnit[d] == udg_EnhancedDamageTarget) then
            udg_DamageEventLevel = __jint(udg_DamageEventLevel + 1)
        elseif (not IsUnitInGroup(s__Damage_targetUnit[d], udg_DamageEventAOEGroup)) then
            udg_DamageEventAOE = __jint(udg_DamageEventAOE + 1)
        end
    else
        TimerStart(DamageEngine___async, __jreal(0.00), false, s__Damage_asyncCallback)
        DamageEngine___timerStarted = true
        udg_AOEDamageSource = s__Damage_sourceUnit[d]
        udg_EnhancedDamageTarget = s__Damage_targetUnit[d]
    end
    GroupAddUnit(udg_DamageEventAOEGroup, s__Damage_targetUnit[d])
    if s__Damage_runDamagingEvents(d, true) then
        s__DamageTrigger_DamageEngine___run(s__DamageTrigger_ZERO)
        DamageEngine___isNotNativeRecursiveDamage = true
        s__Damage_runAfterDamageEvents()
    end
    DamageEngine___waitingForDamageEventToRun = ((((DamageEngine___lastInstance == 0) or DamageEngine___attacksImmune[udg_DamageEventAttackT]) or DamageEngine___damagesImmune[udg_DamageEventDamageT]) or (not IsUnitType(udg_DamageEventTarget, UNIT_TYPE_MAGIC_IMMUNE)))
    do return false end
end

-- Original JASS function: s__Damage_onDamagedCallback (line 2271)
function s__Damage_onDamagedCallback()
    local r = GetEventDamage()
    local d = s__Damage_index
    if (s__Damage_prepped > 0) then
        s__Damage_prepped = 0
    elseif (DamageEngine___callbacksInProgress or (s__Damage_prevAmt[d] == __jreal(0.00))) then
        do return false end
    elseif DamageEngine___waitingForDamageEventToRun then
        DamageEngine___waitingForDamageEventToRun = false
    else
        s__Damage_afterDamage()
        s__Damage_index = DamageEngine___lastInstance
        DamageEngine___lastInstance = 0
        d = s__Damage_index
        DamageEngine___isNotNativeRecursiveDamage = true
        s__DamageTrigger_setGUIFromStruct(true)
    end
    s__Damage_setArmor(d, true)
    if ((not ((udg_DamageEventAmount == __jreal(0.00)))) and (not ((r == __jreal(0.00))))) then
        udg_DamageScalingWC3 = __jreal(r / udg_DamageEventAmount)
    elseif (udg_DamageEventAmount > __jreal(0.00)) then
        udg_DamageScalingWC3 = __jreal(0.00)
    else
        udg_DamageScalingWC3 = __jreal(1.00)
        if (udg_DamageEventPrevAmt == __jreal(0.00)) then
            udg_DamageScalingUser = __jreal(0.00)
        else
            udg_DamageScalingUser = __jreal(udg_DamageEventAmount / udg_DamageEventPrevAmt)
        end
    end
    udg_DamageEventAmount = r
    s__Damage_damage[d] = r
    if (udg_DamageEventAmount > __jreal(0.00)) then
        s__DamageTrigger_DamageEngine___run(s__DamageTrigger_SHIELD)
        if (DamageEngine___atLeastOneLethalDamageEventRegistered or (udg_DamageEventType < 0)) then
            udg_LethalDamageHP = __jreal(GetWidgetLife(udg_DamageEventTarget) - udg_DamageEventAmount)
            if (udg_LethalDamageHP <= DamageEngine___DEATH_VAL) then
                if DamageEngine___atLeastOneLethalDamageEventRegistered then
                    s__DamageTrigger_DamageEngine___run(s__DamageTrigger_LETHAL)
                    udg_DamageEventAmount = __jreal(GetWidgetLife(udg_DamageEventTarget) - udg_LethalDamageHP)
                    s__Damage_damage[d] = udg_DamageEventAmount
                end
                if ((udg_DamageEventType < 0) and (udg_LethalDamageHP <= DamageEngine___DEATH_VAL)) then
                    SetUnitExploded(udg_DamageEventTarget, true)
                end
            end
        end
        if ((udg_DamageEventPrevAmt == __jreal(0.00)) or (udg_DamageScalingWC3 == __jreal(0.00))) then
            udg_DamageScalingUser = __jreal(0.00)
        else
            udg_DamageScalingUser = __jreal(__jreal(udg_DamageEventAmount / udg_DamageEventPrevAmt) / udg_DamageScalingWC3)
        end
    end
    if (udg_DamageEventDamageT ~= 0) then
        s__DamageTrigger_DamageEngine___run(s__DamageTrigger_DAMAGE)
    end
    BlzSetEventDamage(udg_DamageEventAmount)
    DamageEngine___nativeEventsCompleted = true
    if (udg_DamageEventAmount == __jreal(0.00)) then
        s__Damage_runAfterDamageEvents()
    end
    do return false end
end

-- Original JASS function: s__Damage_apply (line 2377)
function s__Damage_apply(src, tgt, amt, a, r, at, dt, wt)
    local d = 0
    if (udg_NextDamageType == 0) then
        udg_NextDamageType = DamageEngine_TYPE_CODE
    end
    if DamageEngine___callbacksInProgress then
        d = s__Damage_create(src, tgt, amt, a, at, dt, wt)
        s__Damage_isCode[d] = true
        s__Damage_eFilter[d] = DamageEngine_FILTER_CODE
        s__Damage_userType[d] = udg_NextDamageType
        if (not s__Damage_isSpell[d]) then
            s__Damage_isRanged[d] = (udg_NextDamageIsRanged or r)
            s__Damage_isMelee[d] = (not s__Damage_isRanged[d])
        end
        s__Damage_addRecursive(d)
    else
        UnitDamageTarget(src, tgt, amt, a, r, at, dt, wt)
        d = s__Damage_index
        s__Damage_runAfterDamageEvents()
    end
    s__Damage_clearNexts()
    do return d end
end

-- Original JASS function: s__Damage_applySpell (line 2412)
function s__Damage_applySpell(src, tgt, amt, dt)
    do return s__Damage_apply(src, tgt, amt, false, false, nil, dt, nil) end
end

-- Original JASS function: s__Damage_applyAttack (line 2416)
function s__Damage_applyAttack(src, tgt, amt, ranged, at, wt)
    do return s__Damage_apply(src, tgt, amt, true, ranged, at, DAMAGE_TYPE_NORMAL, wt) end
end

-- Original JASS function: s__Damage_onInit (line 2421)
function s__Damage_onInit()
    DamageEngine___async = CreateTimer()
    DamageEngine___recursionSources = CreateGroup()
    DamageEngine___recursionTargets = CreateGroup()
    DamageEngine___damagingTrigger = CreateTrigger()
    DamageEngine___damagedTrigger = CreateTrigger()
    DamageEngine___recursiveTrigger = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(DamageEngine___damagingTrigger, EVENT_PLAYER_UNIT_DAMAGING)
    TriggerAddCondition(DamageEngine___damagingTrigger, Filter(s__Damage_onDamagingCallback))
    TriggerRegisterAnyUnitEventBJ(DamageEngine___damagedTrigger, EVENT_PLAYER_UNIT_DAMAGED)
    TriggerAddCondition(DamageEngine___damagedTrigger, Filter(s__Damage_onDamagedCallback))
    TriggerRegisterAnyUnitEventBJ(DamageEngine___recursiveTrigger, EVENT_PLAYER_UNIT_DAMAGING)
    TriggerAddCondition(DamageEngine___recursiveTrigger, Filter(s__Damage_onRecursiveDamageCallback))
    DisableTrigger(DamageEngine___recursiveTrigger)
    DamageEngine___attacksImmune[0] = false
    DamageEngine___attacksImmune[1] = true
    DamageEngine___attacksImmune[2] = true
    DamageEngine___attacksImmune[3] = true
    DamageEngine___attacksImmune[4] = false
    DamageEngine___attacksImmune[5] = true
    DamageEngine___attacksImmune[6] = true
    DamageEngine___damagesImmune[0] = true
    DamageEngine___damagesImmune[4] = true
    DamageEngine___damagesImmune[5] = true
    DamageEngine___damagesImmune[8] = false
    DamageEngine___damagesImmune[9] = false
    DamageEngine___damagesImmune[10] = false
    DamageEngine___damagesImmune[11] = true
    DamageEngine___damagesImmune[12] = true
    DamageEngine___damagesImmune[13] = false
    DamageEngine___damagesImmune[14] = false
    DamageEngine___damagesImmune[15] = false
    DamageEngine___damagesImmune[16] = true
    DamageEngine___damagesImmune[17] = false
    DamageEngine___damagesImmune[18] = false
    DamageEngine___damagesImmune[19] = false
    DamageEngine___damagesImmune[20] = false
    DamageEngine___damagesImmune[21] = false
    DamageEngine___damagesImmune[22] = true
    DamageEngine___damagesImmune[23] = true
    DamageEngine___damagesImmune[24] = false
    DamageEngine___damagesImmune[25] = false
    DamageEngine___damagesImmune[26] = true
end

-- Original JASS function: DamageEngine_DebugStr (line 2484)
function DamageEngine_DebugStr()
    local i = 0
    while true do
        udg_CONVERTED_ATTACK_TYPE[i] = ConvertAttackType(i)
        if (i == 6) then break end
        i = __jint(i + 1)
    end
    i = 0
    while true do
        udg_CONVERTED_DAMAGE_TYPE[i] = ConvertDamageType(i)
        if (i == 26) then break end
        i = __jint(i + 1)
    end
    udg_AttackTypeDebugStr[0] = "SPELLS"
    udg_AttackTypeDebugStr[1] = "NORMAL"
    udg_AttackTypeDebugStr[2] = "PIERCE"
    udg_AttackTypeDebugStr[3] = "SIEGE"
    udg_AttackTypeDebugStr[4] = "MAGIC"
    udg_AttackTypeDebugStr[5] = "CHAOS"
    udg_AttackTypeDebugStr[6] = "HERO"
    udg_DamageTypeDebugStr[0] = "UNKNOWN"
    udg_DamageTypeDebugStr[4] = "NORMAL"
    udg_DamageTypeDebugStr[5] = "ENHANCED"
    udg_DamageTypeDebugStr[8] = "FIRE"
    udg_DamageTypeDebugStr[9] = "COLD"
    udg_DamageTypeDebugStr[10] = "LIGHTNING"
    udg_DamageTypeDebugStr[11] = "POISON"
    udg_DamageTypeDebugStr[12] = "DISEASE"
    udg_DamageTypeDebugStr[13] = "DIVINE"
    udg_DamageTypeDebugStr[14] = "MAGIC"
    udg_DamageTypeDebugStr[15] = "SONIC"
    udg_DamageTypeDebugStr[16] = "ACID"
    udg_DamageTypeDebugStr[17] = "FORCE"
    udg_DamageTypeDebugStr[18] = "DEATH"
    udg_DamageTypeDebugStr[19] = "MIND"
    udg_DamageTypeDebugStr[20] = "PLANT"
    udg_DamageTypeDebugStr[21] = "DEFENSIVE"
    udg_DamageTypeDebugStr[22] = "DEMOLITION"
    udg_DamageTypeDebugStr[23] = "SLOW_POISON"
    udg_DamageTypeDebugStr[24] = "SPIRIT_LINK"
    udg_DamageTypeDebugStr[25] = "SHADOW_STRIKE"
    udg_DamageTypeDebugStr[26] = "UNIVERSAL"
    udg_WeaponTypeDebugStr[0] = "NONE"
    udg_WeaponTypeDebugStr[1] = "METAL_LIGHT_CHOP"
    udg_WeaponTypeDebugStr[2] = "METAL_MEDIUM_CHOP"
    udg_WeaponTypeDebugStr[3] = "METAL_HEAVY_CHOP"
    udg_WeaponTypeDebugStr[4] = "METAL_LIGHT_SLICE"
    udg_WeaponTypeDebugStr[5] = "METAL_MEDIUM_SLICE"
    udg_WeaponTypeDebugStr[6] = "METAL_HEAVY_SLICE"
    udg_WeaponTypeDebugStr[7] = "METAL_MEDIUM_BASH"
    udg_WeaponTypeDebugStr[8] = "METAL_HEAVY_BASH"
    udg_WeaponTypeDebugStr[9] = "METAL_MEDIUM_STAB"
    udg_WeaponTypeDebugStr[10] = "METAL_HEAVY_STAB"
    udg_WeaponTypeDebugStr[11] = "WOOD_LIGHT_SLICE"
    udg_WeaponTypeDebugStr[12] = "WOOD_MEDIUM_SLICE"
    udg_WeaponTypeDebugStr[13] = "WOOD_HEAVY_SLICE"
    udg_WeaponTypeDebugStr[14] = "WOOD_LIGHT_BASH"
    udg_WeaponTypeDebugStr[15] = "WOOD_MEDIUM_BASH"
    udg_WeaponTypeDebugStr[16] = "WOOD_HEAVY_BASH"
    udg_WeaponTypeDebugStr[17] = "WOOD_LIGHT_STAB"
    udg_WeaponTypeDebugStr[18] = "WOOD_MEDIUM_STAB"
    udg_WeaponTypeDebugStr[19] = "CLAW_LIGHT_SLICE"
    udg_WeaponTypeDebugStr[20] = "CLAW_MEDIUM_SLICE"
    udg_WeaponTypeDebugStr[21] = "CLAW_HEAVY_SLICE"
    udg_WeaponTypeDebugStr[22] = "AXE_MEDIUM_CHOP"
    udg_WeaponTypeDebugStr[23] = "ROCK_HEAVY_BASH"
    udg_DefenseTypeDebugStr[0] = "LIGHT"
    udg_DefenseTypeDebugStr[1] = "MEDIUM"
    udg_DefenseTypeDebugStr[2] = "HEAVY"
    udg_DefenseTypeDebugStr[3] = "FORTIFIED"
    udg_DefenseTypeDebugStr[4] = "NORMAL"
    udg_DefenseTypeDebugStr[5] = "HERO"
    udg_DefenseTypeDebugStr[6] = "DIVINE"
    udg_DefenseTypeDebugStr[7] = "UNARMORED"
    udg_ArmorTypeDebugStr[0] = "NONE"
    udg_ArmorTypeDebugStr[1] = "FLESH"
    udg_ArmorTypeDebugStr[2] = "METAL"
    udg_ArmorTypeDebugStr[3] = "WOOD"
    udg_ArmorTypeDebugStr[4] = "ETHEREAL"
    udg_ArmorTypeDebugStr[5] = "STONE"
    udg_DamageEventAOE = 1
    udg_DamageEventLevel = 1
    udg_ATTACK_TYPE_SPELLS = 0
    udg_ATTACK_TYPE_NORMAL = 1
    udg_ATTACK_TYPE_PIERCE = 2
    udg_ATTACK_TYPE_SIEGE = 3
    udg_ATTACK_TYPE_MAGIC = 4
    udg_ATTACK_TYPE_CHAOS = 5
    udg_ATTACK_TYPE_HERO = 6
    udg_DAMAGE_TYPE_UNKNOWN = 0
    udg_DAMAGE_TYPE_NORMAL = 4
    udg_DAMAGE_TYPE_ENHANCED = 5
    udg_DAMAGE_TYPE_FIRE = 8
    udg_DAMAGE_TYPE_COLD = 9
    udg_DAMAGE_TYPE_LIGHTNING = 10
    udg_DAMAGE_TYPE_POISON = 11
    udg_DAMAGE_TYPE_DISEASE = 12
    udg_DAMAGE_TYPE_DIVINE = 13
    udg_DAMAGE_TYPE_MAGIC = 14
    udg_DAMAGE_TYPE_SONIC = 15
    udg_DAMAGE_TYPE_ACID = 16
    udg_DAMAGE_TYPE_FORCE = 17
    udg_DAMAGE_TYPE_DEATH = 18
    udg_DAMAGE_TYPE_MIND = 19
    udg_DAMAGE_TYPE_PLANT = 20
    udg_DAMAGE_TYPE_DEFENSIVE = 21
    udg_DAMAGE_TYPE_DEMOLITION = 22
    udg_DAMAGE_TYPE_SLOW_POISON = 23
    udg_DAMAGE_TYPE_SPIRIT_LINK = 24
    udg_DAMAGE_TYPE_SHADOW_STRIKE = 25
    udg_DAMAGE_TYPE_UNIVERSAL = 26
    udg_WEAPON_TYPE_NONE = 0
    udg_WEAPON_TYPE_ML_CHOP = 1
    udg_WEAPON_TYPE_MM_CHOP = 2
    udg_WEAPON_TYPE_MH_CHOP = 3
    udg_WEAPON_TYPE_ML_SLICE = 4
    udg_WEAPON_TYPE_MM_SLICE = 5
    udg_WEAPON_TYPE_MH_SLICE = 6
    udg_WEAPON_TYPE_MM_BASH = 7
    udg_WEAPON_TYPE_MH_BASH = 8
    udg_WEAPON_TYPE_MM_STAB = 9
    udg_WEAPON_TYPE_MH_STAB = 10
    udg_WEAPON_TYPE_WL_SLICE = 11
    udg_WEAPON_TYPE_WM_SLICE = 12
    udg_WEAPON_TYPE_WH_SLICE = 13
    udg_WEAPON_TYPE_WL_BASH = 14
    udg_WEAPON_TYPE_WM_BASH = 15
    udg_WEAPON_TYPE_WH_BASH = 16
    udg_WEAPON_TYPE_WL_STAB = 17
    udg_WEAPON_TYPE_WM_STAB = 18
    udg_WEAPON_TYPE_CL_SLICE = 19
    udg_WEAPON_TYPE_CM_SLICE = 20
    udg_WEAPON_TYPE_CH_SLICE = 21
    udg_WEAPON_TYPE_AM_CHOP = 22
    udg_WEAPON_TYPE_RH_BASH = 23
    udg_ARMOR_TYPE_NONE = 0
    udg_ARMOR_TYPE_FLESH = 1
    udg_ARMOR_TYPE_METAL = 2
    udg_ARMOR_TYPE_WOOD = 3
    udg_ARMOR_TYPE_ETHEREAL = 4
    udg_ARMOR_TYPE_STONE = 5
    udg_DEFENSE_TYPE_LIGHT = 0
    udg_DEFENSE_TYPE_MEDIUM = 1
    udg_DEFENSE_TYPE_HEAVY = 2
    udg_DEFENSE_TYPE_FORTIFIED = 3
    udg_DEFENSE_TYPE_NORMAL = 4
    udg_DEFENSE_TYPE_HERO = 5
    udg_DEFENSE_TYPE_DIVINE = 6
    udg_DEFENSE_TYPE_UNARMORED = 7
    udg_UNIT_CLASS_HERO = 0
    udg_UNIT_CLASS_DEAD = 1
    udg_UNIT_CLASS_STRUCTURE = 2
    udg_UNIT_CLASS_FLYING = 3
    udg_UNIT_CLASS_GROUND = 4
    udg_UNIT_CLASS_ATTACKS_FLYING = 5
    udg_UNIT_CLASS_ATTACKS_GROUND = 6
    udg_UNIT_CLASS_MELEE = 7
    udg_UNIT_CLASS_RANGED = 8
    udg_UNIT_CLASS_GIANT = 9
    udg_UNIT_CLASS_SUMMONED = 10
    udg_UNIT_CLASS_STUNNED = 11
    udg_UNIT_CLASS_PLAGUED = 12
    udg_UNIT_CLASS_SNARED = 13
    udg_UNIT_CLASS_UNDEAD = 14
    udg_UNIT_CLASS_MECHANICAL = 15
    udg_UNIT_CLASS_PEON = 16
    udg_UNIT_CLASS_SAPPER = 17
    udg_UNIT_CLASS_TOWNHALL = 18
    udg_UNIT_CLASS_ANCIENT = 19
    udg_UNIT_CLASS_TAUREN = 20
    udg_UNIT_CLASS_POISONED = 21
    udg_UNIT_CLASS_POLYMORPHED = 22
    udg_UNIT_CLASS_SLEEPING = 23
    udg_UNIT_CLASS_RESISTANT = 24
    udg_UNIT_CLASS_ETHEREAL = 25
    udg_UNIT_CLASS_MAGIC_IMMUNE = 26
    udg_DamageFilterAttackT = __jint(-(1))
    udg_DamageFilterDamageT = __jint(-(1))
    udg_DamageFilterSourceC = __jint(-(1))
    udg_DamageFilterTargetC = __jint(-(1))
    udg_DamageFilterRunChance = __jreal(1.00)
end

-- Original JASS function: DamageEngine_RegisterFromHook (line 2699)
function DamageEngine_RegisterFromHook(whichTrig, var, op, value)
    s__DamageTrigger_registerVerbose(whichTrig, var, value, true, GetHandleId(op))
end

-- Original JASS function: TriggerRegisterDamageEngineEx (line 2704)
function TriggerRegisterDamageEngineEx(whichTrig, eventName, value, opId)
    do return s__DamageTrigger_registerVerbose(whichTrig, s__DamageTrigger_getVerboseStr(eventName), value, false, opId) end
end

-- Original JASS function: TriggerRegisterDamageEngine (line 2708)
function TriggerRegisterDamageEngine(whichTrig, eventName, value)
    do return s__DamageTrigger_registerTrigger(whichTrig, eventName, value) end
end

-- Original JASS function: RegisterDamageEngineEx (line 2712)
function RegisterDamageEngineEx(callback, eventName, value, opId)
    do return TriggerRegisterDamageEngineEx(s__DamageTrigger__staticgetindex(callback), eventName, value, opId) end
end

-- Original JASS function: RegisterDamageEngine (line 2717)
function RegisterDamageEngine(callback, eventName, value)
    do return RegisterDamageEngineEx(callback, eventName, value, DamageEngine_FILTER_OTHER) end
end

-- Original JASS function: sa___prototype2_DamageEngine_RegisterFromHook (line 21323)
function sa___prototype2_DamageEngine_RegisterFromHook()
    DamageEngine_RegisterFromHook(f__arg_trigger1, f__arg_string1, f__arg_limitop1, f__arg_real1)
    do return true end
end

-- Original JASS function: jasshelper__initstructs149790140 (line 21328)
function jasshelper__initstructs149790140()
    st___prototype2[1] = CreateTrigger()
    TriggerAddAction(st___prototype2[1], sa___prototype2_DamageEngine_RegisterFromHook)
    TriggerAddCondition(st___prototype2[1], Condition(sa___prototype2_DamageEngine_RegisterFromHook))
    ExecuteFunc("s__Damage_onInit")
end
