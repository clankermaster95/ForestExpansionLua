-- combat / damage
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 1 Damage_Engine_Config
-- Original JASS function: Trig_Damage_Engine_Config_Actions (line 4321)
function Trig_Damage_Engine_Config_Actions()
    udg_DamageTypePureExplosive = __jint(-(2))
    udg_DamageTypeExplosive = __jint(-(1))
    udg_DamageTypeCode = 1
    udg_DamageTypePure = 2
    udg_DamageTypeHeal = 3
    udg_DamageTypeBlocked = 4
    udg_DamageTypeReduced = 5
    udg_DamageTypeCriticalStrike = 6
    DamageEngine_DebugStr()
end

-- Original JASS function: InitTrig_Damage_Engine_Config (line 4350)
function InitTrig_Damage_Engine_Config()
    gg_trg_Damage_Engine_Config = CreateTrigger()
    TriggerAddAction(gg_trg_Damage_Engine_Config, Trig_Damage_Engine_Config_Actions)
end
-- END FOREST SECTION 1

-- BEGIN FOREST SECTION 2 Damage_Engine
-- This trigger has no standalone compiled functions. Library implementations are in src/libraries/.
-- END FOREST SECTION 2
