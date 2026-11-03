-- Disabled in the original map.
function Trig_Invul_Actions()
    udg_DamageEventAmount = __jreal(0.00)
    udg_DamageEventOverride = true
    udg_DamageEventArmorT = udg_ARMOR_TYPE_NONE
    udg_DamageEventWeaponT = udg_WEAPON_TYPE_NONE
end

function InitTrig_Invul()
    gg_trg_Invul = CreateTrigger()
    TriggerRegisterVariableEvent(gg_trg_Invul, udg_PreDamageEvent, EQUAL, (-(__jreal(69.00))))
    TriggerAddAction(gg_trg_Invul, Trig_Invul_Actions)
end
