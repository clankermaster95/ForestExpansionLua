-- races / aethyr
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 63 Vampiric_Wyrm
-- Original JASS function: Trig_Vampiric_Wyrm_Func001C (line 7995)
function Trig_Vampiric_Wyrm_Func001C()
    if (((GetUnitTypeId(GetConstructedStructure()) == FourCC("e005")))) then
        do return true end
    end
    if (((GetUnitTypeId(GetConstructedStructure()) == FourCC("e004")))) then
        do return true end
    end
    if (((GetUnitTypeId(GetConstructedStructure()) == FourCC("e006")))) then
        do return true end
    end
    do return false end
end

-- Original JASS function: Trig_Vampiric_Wyrm_Conditions (line 8008)
function Trig_Vampiric_Wyrm_Conditions()
    if ((not Trig_Vampiric_Wyrm_Func001C())) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Vampiric_Wyrm_Actions (line 8015)
function Trig_Vampiric_Wyrm_Actions()
    BlzSetUnitBooleanFieldBJ(GetConstructedStructure(), UNIT_BF_IS_A_BUILDING, false)
end

-- Original JASS function: InitTrig_Vampiric_Wyrm (line 8020)
function InitTrig_Vampiric_Wyrm()
    gg_trg_Vampiric_Wyrm = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Vampiric_Wyrm, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
    TriggerAddCondition(gg_trg_Vampiric_Wyrm, Condition(Trig_Vampiric_Wyrm_Conditions))
    TriggerAddAction(gg_trg_Vampiric_Wyrm, Trig_Vampiric_Wyrm_Actions)
end
-- END FOREST SECTION 63
