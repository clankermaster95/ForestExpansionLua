-- races / aethyr
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 63 Vampiric_Wyrm
function Trig_Vampiric_Wyrm_Func001C()
    if (GetUnitTypeId(GetConstructedStructure()) == FourCC("e005")) then
        return true
    end
    if (GetUnitTypeId(GetConstructedStructure()) == FourCC("e004")) then
        return true
    end
    if (GetUnitTypeId(GetConstructedStructure()) == FourCC("e006")) then
        return true
    end
    return false
end

function Trig_Vampiric_Wyrm_Conditions()
    return not not (Trig_Vampiric_Wyrm_Func001C())
end

function Trig_Vampiric_Wyrm_Actions()
    BlzSetUnitBooleanFieldBJ(GetConstructedStructure(), UNIT_BF_IS_A_BUILDING, false)
end

function InitTrig_Vampiric_Wyrm()
    gg_trg_Vampiric_Wyrm = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Vampiric_Wyrm, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
    TriggerAddCondition(gg_trg_Vampiric_Wyrm, Condition(Trig_Vampiric_Wyrm_Conditions))
    TriggerAddAction(gg_trg_Vampiric_Wyrm, Trig_Vampiric_Wyrm_Actions)
end
-- END FOREST SECTION 63
