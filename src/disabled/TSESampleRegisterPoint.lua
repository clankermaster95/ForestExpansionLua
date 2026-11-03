-- Disabled in the original map.
function Trig_TSESampleRegisterPoint_Actions()
    udg_TSEDuration = __jreal(16.00)
    udg_TSEEffectName = "Abilities\\Spells\\Human\\CloudOfFog\\CloudOfFog.mdl"
    udg_TSEPoint = GetSpellTargetLoc()
    udg_TSEScale = __jreal(1.00)
    udg_TSESourceUnit = GetTriggerUnit()
    udg_TSESourceUnitAliveCheck = false
    udg_TSEChanneledOrderID = "blizzard"
    udg_TSEOnIndexEvent = udg_TSEOnIndexEvent
    udg_TSEOnLoopEvent = udg_TSEOnLoopEvent
    udg_TSEOnLoopTimer = __jreal(1.00)
    udg_TSEOnEndEvent = udg_TSEOnEndEvent
    udg_TSELockInstance = false
    ConditionalTriggerExecute(udg_TSE_RegisterTrigger)
end

function InitTrig_TSESampleRegisterPoint()
    gg_trg_TSESampleRegisterPoint = CreateTrigger()
    TriggerAddAction(gg_trg_TSESampleRegisterPoint, Trig_TSESampleRegisterPoint_Actions)
end
