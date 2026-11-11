-- effects / timed
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 3 TSEConfig
-- Preserve the legacy callback globals: callbacks may change ActiveIndex or
-- RemainingDuration, and callers deliberately read those globals afterwards.
local function TSEPublishInstance(index)
    udg_TSE__ActiveIndex = index
    udg_TSE__RemainingDuration = udg_TSE_I_RemainingDuration[udg_TSE__ActiveIndex]
    udg_TSE__SourceUnit = udg_TSE_I_SourceUnit[udg_TSE__ActiveIndex]
    udg_TSE__TargetUnit = udg_TSE_I_TargetUnit[udg_TSE__ActiveIndex]
    udg_TSE__Point = udg_TSE_I_Point[udg_TSE__ActiveIndex]
    udg_TSE__SpecialEffect = udg_TSE_I_Effect[udg_TSE__ActiveIndex]
end

-- Keep the field-copy order, locked slots and same-cycle replacement processing.
local function TSEMoveInstance(index, replacement)
    udg_TSE_I_Point[index] = udg_TSE_I_Point[replacement]
    udg_TSE_I_RemainingDuration[index] = udg_TSE_I_RemainingDuration[replacement]
    udg_TSE_I_Effect[index] = udg_TSE_I_Effect[replacement]
    udg_TSE_I_ChanneledOrderID[index] = udg_TSE_I_ChanneledOrderID[replacement]
    udg_TSE_I_IsChanneling[index] = udg_TSE_I_IsChanneling[replacement]
    udg_TSE_I_SourceUnit[index] = udg_TSE_I_SourceUnit[replacement]
    udg_TSE_I_SourceUnitAliveCheck[index] = udg_TSE_I_SourceUnitAliveCheck[replacement]
    udg_TSE_I_TargetUnitAliveCheck[index] = udg_TSE_I_TargetUnitAliveCheck[replacement]
    udg_TSE_I_TargetUnit[index] = udg_TSE_I_TargetUnit[replacement]
    udg_TSE_I_OnLoopEvent[index] = udg_TSE_I_OnLoopEvent[replacement]
    udg_TSE_I_OnLoopTimer[index] = udg_TSE_I_OnLoopTimer[replacement]
    udg_TSE_I_LoopDuration[index] = udg_TSE_I_LoopDuration[replacement]
    udg_TSE_I_OnEndEvent[index] = udg_TSE_I_OnEndEvent[replacement]
    udg_TSE_I_LockInstance[index] = udg_TSE_I_LockInstance[replacement]
    udg_TSE_I_LockInstance[replacement] = false
    udg_TSE_I_ActiveInstance[index] = udg_TSE_I_ActiveInstance[replacement]
    udg_TSE_I_ActiveInstance[replacement] = false
end

function Trig_TSEConfig_Actions()
    udg_TSE_LoopTrigger = gg_trg_TSELoop
    udg_TSE_RegisterTrigger = gg_trg_TSERegister
    udg_TSE_EmptyEvent = gg_trg_TSEEmptyEvent
    udg_TSE_TIMEOUT = (__jreal(__jreal(1.00) / __jreal(32.00)))
    udg_TSE_MaxRecursion = 32767
    udg_TSEScale = __jreal(1.00)
end

function InitTrig_TSEConfig()
    gg_trg_TSEConfig = CreateTrigger()
    TriggerAddAction(gg_trg_TSEConfig, Trig_TSEConfig_Actions)
end
-- END FOREST SECTION 3

-- BEGIN FOREST SECTION 4 TSERegister
function Trig_TSERegister_Func002C()
    if (not (udg_TSEUnit ~= nil)) then
        return false
    end
    if (not (udg_TSETargetUnit == nil)) then
        return false
    end
    return true
end

function Trig_TSERegister_Func003Func001C()
    if (udg_TSETargetUnitAliveCheck == true) then
        return true
    end
    if (udg_TSEUnitAliveCheck == true) then
        return true
    end
    return false
end

function Trig_TSERegister_Func003C()
    return not not (Trig_TSERegister_Func003Func001C())
end

function Trig_TSERegister_Func007C()
    return udg_TSETargetUnit ~= nil
end

function Trig_TSERegister_Func008C()
    return udg_TSESourceUnit ~= nil
end

function Trig_TSERegister_Func011Func001C()
    return udg_TSESourceUnit ~= nil
end

function Trig_TSERegister_Func011C()
    return udg_TSEChanneledOrderID ~= ""
end

function Trig_TSERegister_Func012C()
    return udg_TSEOnLoopTimer < udg_TSE_TIMEOUT
end

function Trig_TSERegister_Func034C()
    return udg_TSE_MaxIndex == 1
end

function Trig_TSERegister_Actions()
    if (Trig_TSERegister_Func002C()) then
        udg_TSETargetUnit = udg_TSEUnit
    end
    if (Trig_TSERegister_Func003C()) then
        udg_TSETargetUnitAliveCheck = true
    end
    udg_TSE_MaxIndex = (__jint(udg_TSE_MaxIndex + 1))
    udg_TSE_I_RemainingDuration[udg_TSE_MaxIndex] = udg_TSEDuration
    if (Trig_TSERegister_Func007C()) then
        AddSpecialEffectTargetUnitBJ(udg_TSEAttachPoint, udg_TSETargetUnit, udg_TSEEffectName)
        udg_TSE_I_TargetUnitAliveCheck[udg_TSE_MaxIndex] = udg_TSETargetUnitAliveCheck
    else
        AddSpecialEffectLocBJ(udg_TSEPoint, udg_TSEEffectName)
        udg_TSE_I_TargetUnitAliveCheck[udg_TSE_MaxIndex] = false
    end
    if (Trig_TSERegister_Func008C()) then
        udg_TSE_I_SourceUnitAliveCheck[udg_TSE_MaxIndex] = udg_TSESourceUnitAliveCheck
    end
    udg_TSE_I_Effect[udg_TSE_MaxIndex] = GetLastCreatedEffectBJ()
    BlzSetSpecialEffectScale(udg_TSE_I_Effect[udg_TSE_MaxIndex], udg_TSEScale)
    if (Trig_TSERegister_Func011C()) then
        if (Trig_TSERegister_Func011Func001C()) then
            udg_TSE_I_IsChanneling[udg_TSE_MaxIndex] = true
        else
            DisplayTextToForce(GetPlayersAll(), "TRIGSTR_4185")
        end
    end
    if (Trig_TSERegister_Func012C()) then
        udg_TSEOnLoopTimer = udg_TSE_TIMEOUT
    end
    udg_TSE_I_SourceUnit[udg_TSE_MaxIndex] = udg_TSESourceUnit
    udg_TSE_I_TargetUnit[udg_TSE_MaxIndex] = udg_TSETargetUnit
    udg_TSE_I_ChanneledOrderID[udg_TSE_MaxIndex] = udg_TSEChanneledOrderID
    udg_TSE_I_OnLoopEvent[udg_TSE_MaxIndex] = udg_TSEOnLoopEvent
    udg_TSE_I_OnLoopTimer[udg_TSE_MaxIndex] = udg_TSEOnLoopTimer
    udg_TSE_I_LoopDuration[udg_TSE_MaxIndex] = udg_TSEOnLoopTimer
    udg_TSE_I_OnEndEvent[udg_TSE_MaxIndex] = udg_TSEOnEndEvent
    udg_TSE_I_LockInstance[udg_TSE_MaxIndex] = udg_TSELockInstance
    udg_TSE_I_ActiveInstance[udg_TSE_MaxIndex] = true
    udg_TSE_I_Point[udg_TSE_MaxIndex] = udg_TSEPoint
    TSEPublishInstance(udg_TSE_MaxIndex)
    ConditionalTriggerExecute(udg_TSEOnIndexEvent)
    udg_TSE_I_RemainingDuration[udg_TSE__ActiveIndex] = udg_TSE__RemainingDuration
    if (Trig_TSERegister_Func034C()) then
        TimerStart(udg_TSE_CTimer, udg_TSE_TIMEOUT, true, nil)
        EnableTrigger(udg_TSE_LoopTrigger)
    end
    udg_TSETargetUnit = nil
    udg_TSETargetUnitAliveCheck = false
    udg_TSEScale = __jreal(1.00)
    udg_TSEChanneledOrderID = ""
    udg_TSESourceUnit = nil
    udg_TSEOnIndexEvent = udg_TSE_EmptyEvent
    udg_TSEOnLoopEvent = udg_TSE_EmptyEvent
    udg_TSEOnLoopTimer = udg_TSE_TIMEOUT
    udg_TSEOnEndEvent = udg_TSE_EmptyEvent
    udg_TSELockInstance = false
    udg_TSEUnit = nil
    udg_TSEUnitAliveCheck = false
end

function InitTrig_TSERegister()
    gg_trg_TSERegister = CreateTrigger()
    TriggerAddAction(gg_trg_TSERegister, Trig_TSERegister_Actions)
end
-- END FOREST SECTION 4

-- BEGIN FOREST SECTION 5 TSELoop
function Trig_TSELoop_Func002Func001Func004C()
    return udg_TSE_I_LoopDuration[udg_TSE_Index] <= __jreal(0.00)
end

function Trig_TSELoop_Func002Func001Func006C()
    if (not (udg_TSE_I_TargetUnitAliveCheck[udg_TSE_Index] == true)) then
        return false
    end
    if (not (IsUnitAliveBJ(udg_TSE_I_TargetUnit[udg_TSE_Index]) == false)) then
        return false
    end
    return true
end

function Trig_TSELoop_Func002Func001Func007C()
    if (not (udg_TSE_I_SourceUnitAliveCheck[udg_TSE_Index] == true)) then
        return false
    end
    if (not (IsUnitAliveBJ(udg_TSE_I_SourceUnit[udg_TSE_Index]) == false)) then
        return false
    end
    if (not (udg_TSE_I_SourceUnit[udg_TSE_Index] ~= nil)) then
        return false
    end
    return true
end

function Trig_TSELoop_Func002Func001Func008C()
    if (not (udg_TSE_I_IsChanneling[udg_TSE_Index] == true)) then
        return false
    end
    if (not (GetUnitCurrentOrder(udg_TSE_I_SourceUnit[udg_TSE_Index]) ~= String2OrderIdBJ(udg_TSE_I_ChanneledOrderID[udg_TSE_Index]))) then
        return false
    end
    return true
end

function Trig_TSELoop_Func002Func001Func010Func017Func002Func002C()
    if (not (udg_TSE_I_LockInstance[udg_TSE_ReplacementIndex] == false)) then
        return false
    end
    if (not (udg_TSE_I_ActiveInstance[udg_TSE_ReplacementIndex] == true)) then
        return false
    end
    return true
end

function Trig_TSELoop_Func002Func001Func010Func017Func002C()
    if (udg_TSE_Recursion >= udg_TSE_MaxRecursion) then
        return true
    end
    if (Trig_TSELoop_Func002Func001Func010Func017Func002Func002C()) then
        return true
    end
    if (udg_TSE_ReplacementIndex == udg_TSE_Index) then
        return true
    end
    return false
end

function Trig_TSELoop_Func002Func001Func010Func017C()
    return not not (Trig_TSELoop_Func002Func001Func010Func017Func002C())
end

function Trig_TSELoop_Func002Func001Func010Func039Func002C()
    if (udg_TSE_ReplacementIndex == udg_TSE_MaxIndex) then
        return true
    end
    if (udg_TSE_I_ActiveInstance[udg_TSE_MaxIndex] == false) then
        return true
    end
    return false
end

function Trig_TSELoop_Func002Func001Func010Func039Func005Func002C()
    if (udg_TSE_I_ActiveInstance[udg_TSE_MaxIndex] == true) then
        return true
    end
    if (udg_TSE_MaxIndex <= 0) then
        return true
    end
    return false
end

function Trig_TSELoop_Func002Func001Func010Func039Func005C()
    return not not (Trig_TSELoop_Func002Func001Func010Func039Func005Func002C())
end

function Trig_TSELoop_Func002Func001Func010Func039C()
    return not not (Trig_TSELoop_Func002Func001Func010Func039Func002C())
end

function Trig_TSELoop_Func002Func001Func010Func041C()
    return udg_TSE_MaxIndex <= 0
end

function Trig_TSELoop_Func002Func001Func010C()
    return udg_TSE_I_RemainingDuration[udg_TSE_Index] <= __jreal(0.00)
end

function Trig_TSELoop_Func002Func001C()
    return udg_TSE_I_ActiveInstance[udg_TSE_Index] == true
end

function Trig_TSELoop_Actions()
    udg_TSE_Index = 1
    while true do
        if (udg_TSE_Index > udg_TSE_MaxIndex) then break end
        if (Trig_TSELoop_Func002Func001C()) then
            udg_TSE_I_RemainingDuration[udg_TSE_Index] = (__jreal(udg_TSE_I_RemainingDuration[udg_TSE_Index] - udg_TSE_TIMEOUT))
            udg_TSE_I_LoopDuration[udg_TSE_Index] = (__jreal(udg_TSE_I_LoopDuration[udg_TSE_Index] - udg_TSE_TIMEOUT))
            if (Trig_TSELoop_Func002Func001Func004C()) then
                TSEPublishInstance(udg_TSE_Index)
                ConditionalTriggerExecute(udg_TSE_I_OnLoopEvent[udg_TSE_Index])
                udg_TSE_I_RemainingDuration[udg_TSE__ActiveIndex] = udg_TSE__RemainingDuration
                udg_TSE_I_LoopDuration[udg_TSE_Index] = udg_TSE_I_OnLoopTimer[udg_TSE_Index]
            end
            if (Trig_TSELoop_Func002Func001Func006C()) then
                udg_TSE_I_RemainingDuration[udg_TSE_Index] = __jreal(0.00)
            end
            if (Trig_TSELoop_Func002Func001Func007C()) then
                udg_TSE_I_RemainingDuration[udg_TSE_Index] = __jreal(0.00)
            end
            if (Trig_TSELoop_Func002Func001Func008C()) then
                udg_TSE_I_RemainingDuration[udg_TSE_Index] = __jreal(0.00)
            end
            if (Trig_TSELoop_Func002Func001Func010C()) then
                TSEPublishInstance(udg_TSE_Index)
                ConditionalTriggerExecute(udg_TSE_I_OnEndEvent[udg_TSE_Index])
                DestroyEffectBJ(udg_TSE_I_Effect[udg_TSE_Index])
                udg_TSE_ReplacementIndexFound = false
                udg_TSE_ReplacementIndex = udg_TSE_MaxIndex
                udg_TSE_Recursion = 0
                while true do
                    udg_TSE_Recursion = (__jint(udg_TSE_Recursion + 1))
                    if (Trig_TSELoop_Func002Func001Func010Func017C()) then
                        udg_TSE_ReplacementIndexFound = true
                    else
                        udg_TSE_ReplacementIndex = (__jint(udg_TSE_ReplacementIndex - 1))
                    end
                    if (udg_TSE_ReplacementIndexFound == true) then break end
                end
                RemoveLocation(udg_TSE_I_Point[udg_TSE_Index])
                TSEMoveInstance(udg_TSE_Index, udg_TSE_ReplacementIndex)
                udg_TSE_Index = (__jint(udg_TSE_Index - 1))
                if (Trig_TSELoop_Func002Func001Func010Func039C()) then
                    udg_TSE_MaxCheckOver = false
                    while true do
                        udg_TSE_MaxIndex = (__jint(udg_TSE_MaxIndex - 1))
                        if (Trig_TSELoop_Func002Func001Func010Func039Func005C()) then
                            udg_TSE_MaxCheckOver = true
                        end
                        if (udg_TSE_MaxCheckOver == true) then break end
                    end
                end
                if (Trig_TSELoop_Func002Func001Func010Func041C()) then
                    PauseTimerBJ(true, udg_TSE_CTimer)
                    DisableTrigger(udg_TSE_LoopTrigger)
                end
            end
        end
        udg_TSE_Index = __jint(udg_TSE_Index + 1)
    end
end

function InitTrig_TSELoop()
    gg_trg_TSELoop = CreateTrigger()
    DisableTrigger(gg_trg_TSELoop)
    TriggerRegisterTimerExpireEventBJ(gg_trg_TSELoop, udg_TSE_CTimer)
    TriggerAddAction(gg_trg_TSELoop, Trig_TSELoop_Actions)
end
-- END FOREST SECTION 5

-- BEGIN FOREST SECTION 6 TSEEmptyEvent
function Trig_TSEEmptyEvent_Actions()
end

function InitTrig_TSEEmptyEvent()
    gg_trg_TSEEmptyEvent = CreateTrigger()
    TriggerAddAction(gg_trg_TSEEmptyEvent, Trig_TSEEmptyEvent_Actions)
end
-- END FOREST SECTION 6
