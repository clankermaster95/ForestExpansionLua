-- Disabled in the original map.
function Trig_TSESampleRegisterUnit_Actions()
    udg_TSEDuration = __jreal(10.00)
    udg_TSETargetUnit = GetTriggerUnit()
    udg_TSEAttachPoint = "left hand"
    udg_TSEEffectName = "war3mapImported/Soul Bow Enchantment Necro.mdx"
    udg_TSETargetUnitAliveCheck = false
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

function InitTrig_TSESampleRegisterUnit()
    gg_trg_TSESampleRegisterUnit = CreateTrigger()
    TriggerAddAction(gg_trg_TSESampleRegisterUnit, Trig_TSESampleRegisterUnit_Actions)
end
