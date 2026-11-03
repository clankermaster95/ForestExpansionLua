-- effects / timed
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 3 TSEConfig
-- Original JASS function: Trig_TSEConfig_Actions (line 4366)
function Trig_TSEConfig_Actions()
    udg_TSE_LoopTrigger = gg_trg_TSELoop
    udg_TSE_RegisterTrigger = gg_trg_TSERegister
    udg_TSE_EmptyEvent = gg_trg_TSEEmptyEvent
    udg_TSE_TIMEOUT = (__jreal(__jreal(1.00) / __jreal(32.00)))
    udg_TSE_MaxRecursion = 32767
    udg_TSEScale = __jreal(1.00)
end

-- Original JASS function: InitTrig_TSEConfig (line 4392)
function InitTrig_TSEConfig()
    gg_trg_TSEConfig = CreateTrigger()
    TriggerAddAction(gg_trg_TSEConfig, Trig_TSEConfig_Actions)
end
-- END FOREST SECTION 3

-- BEGIN FOREST SECTION 4 TSERegister
-- Original JASS function: Trig_TSERegister_Func002C (line 4400)
function Trig_TSERegister_Func002C()
    if ((not ((udg_TSEUnit ~= nil)))) then
        do return false end
    end
    if ((not ((udg_TSETargetUnit == nil)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_TSERegister_Func003Func001C (line 4410)
function Trig_TSERegister_Func003Func001C()
    if (((udg_TSETargetUnitAliveCheck == true))) then
        do return true end
    end
    if (((udg_TSEUnitAliveCheck == true))) then
        do return true end
    end
    do return false end
end

-- Original JASS function: Trig_TSERegister_Func003C (line 4420)
function Trig_TSERegister_Func003C()
    if ((not Trig_TSERegister_Func003Func001C())) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_TSERegister_Func007C (line 4427)
function Trig_TSERegister_Func007C()
    if ((not ((udg_TSETargetUnit ~= nil)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_TSERegister_Func008C (line 4434)
function Trig_TSERegister_Func008C()
    if ((not ((udg_TSESourceUnit ~= nil)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_TSERegister_Func011Func001C (line 4441)
function Trig_TSERegister_Func011Func001C()
    if ((not ((udg_TSESourceUnit ~= nil)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_TSERegister_Func011C (line 4448)
function Trig_TSERegister_Func011C()
    if ((not ((udg_TSEChanneledOrderID ~= "")))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_TSERegister_Func012C (line 4455)
function Trig_TSERegister_Func012C()
    if ((not ((udg_TSEOnLoopTimer < udg_TSE_TIMEOUT)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_TSERegister_Func034C (line 4462)
function Trig_TSERegister_Func034C()
    if ((not ((udg_TSE_MaxIndex == 1)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_TSERegister_Actions (line 4469)
function Trig_TSERegister_Actions()
    if (Trig_TSERegister_Func002C()) then
        udg_TSETargetUnit = udg_TSEUnit
    else
    end
    if (Trig_TSERegister_Func003C()) then
        udg_TSETargetUnitAliveCheck = true
    else
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
    else
    end
    udg_TSE_I_Effect[udg_TSE_MaxIndex] = GetLastCreatedEffectBJ()
    BlzSetSpecialEffectScale(udg_TSE_I_Effect[udg_TSE_MaxIndex], udg_TSEScale)
    if (Trig_TSERegister_Func011C()) then
        if (Trig_TSERegister_Func011Func001C()) then
            udg_TSE_I_IsChanneling[udg_TSE_MaxIndex] = true
        else
            DisplayTextToForce(GetPlayersAll(), "TRIGSTR_4185")
        end
    else
    end
    if (Trig_TSERegister_Func012C()) then
        udg_TSEOnLoopTimer = udg_TSE_TIMEOUT
    else
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
    udg_TSE__ActiveIndex = udg_TSE_MaxIndex
    udg_TSE__RemainingDuration = udg_TSE_I_RemainingDuration[udg_TSE__ActiveIndex]
    udg_TSE__SourceUnit = udg_TSE_I_SourceUnit[udg_TSE__ActiveIndex]
    udg_TSE__TargetUnit = udg_TSE_I_TargetUnit[udg_TSE__ActiveIndex]
    udg_TSE__Point = udg_TSE_I_Point[udg_TSE__ActiveIndex]
    udg_TSE__SpecialEffect = udg_TSE_I_Effect[udg_TSE__ActiveIndex]
    ConditionalTriggerExecute(udg_TSEOnIndexEvent)
    udg_TSE_I_RemainingDuration[udg_TSE__ActiveIndex] = udg_TSE__RemainingDuration
    if (Trig_TSERegister_Func034C()) then
        StartTimerBJ(udg_TSE_CTimer, true, udg_TSE_TIMEOUT)
        EnableTrigger(udg_TSE_LoopTrigger)
    else
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

-- Original JASS function: InitTrig_TSERegister (line 4550)
function InitTrig_TSERegister()
    gg_trg_TSERegister = CreateTrigger()
    TriggerAddAction(gg_trg_TSERegister, Trig_TSERegister_Actions)
end
-- END FOREST SECTION 4

-- BEGIN FOREST SECTION 5 TSELoop
-- Original JASS function: Trig_TSELoop_Func002Func001Func004C (line 4558)
function Trig_TSELoop_Func002Func001Func004C()
    if ((not ((udg_TSE_I_LoopDuration[udg_TSE_Index] <= __jreal(0.00))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_TSELoop_Func002Func001Func006C (line 4565)
function Trig_TSELoop_Func002Func001Func006C()
    if ((not ((udg_TSE_I_TargetUnitAliveCheck[udg_TSE_Index] == true)))) then
        do return false end
    end
    if ((not ((IsUnitAliveBJ(udg_TSE_I_TargetUnit[udg_TSE_Index]) == false)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_TSELoop_Func002Func001Func007C (line 4575)
function Trig_TSELoop_Func002Func001Func007C()
    if ((not ((udg_TSE_I_SourceUnitAliveCheck[udg_TSE_Index] == true)))) then
        do return false end
    end
    if ((not ((IsUnitAliveBJ(udg_TSE_I_SourceUnit[udg_TSE_Index]) == false)))) then
        do return false end
    end
    if ((not ((udg_TSE_I_SourceUnit[udg_TSE_Index] ~= nil)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_TSELoop_Func002Func001Func008C (line 4588)
function Trig_TSELoop_Func002Func001Func008C()
    if ((not ((udg_TSE_I_IsChanneling[udg_TSE_Index] == true)))) then
        do return false end
    end
    if ((not ((GetUnitCurrentOrder(udg_TSE_I_SourceUnit[udg_TSE_Index]) ~= String2OrderIdBJ(udg_TSE_I_ChanneledOrderID[udg_TSE_Index]))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_TSELoop_Func002Func001Func010Func017Func002Func002C (line 4598)
function Trig_TSELoop_Func002Func001Func010Func017Func002Func002C()
    if ((not ((udg_TSE_I_LockInstance[udg_TSE_ReplacementIndex] == false)))) then
        do return false end
    end
    if ((not ((udg_TSE_I_ActiveInstance[udg_TSE_ReplacementIndex] == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_TSELoop_Func002Func001Func010Func017Func002C (line 4608)
function Trig_TSELoop_Func002Func001Func010Func017Func002C()
    if (((udg_TSE_Recursion >= udg_TSE_MaxRecursion))) then
        do return true end
    end
    if (Trig_TSELoop_Func002Func001Func010Func017Func002Func002C()) then
        do return true end
    end
    if (((udg_TSE_ReplacementIndex == udg_TSE_Index))) then
        do return true end
    end
    do return false end
end

-- Original JASS function: Trig_TSELoop_Func002Func001Func010Func017C (line 4621)
function Trig_TSELoop_Func002Func001Func010Func017C()
    if ((not Trig_TSELoop_Func002Func001Func010Func017Func002C())) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_TSELoop_Func002Func001Func010Func039Func002C (line 4628)
function Trig_TSELoop_Func002Func001Func010Func039Func002C()
    if (((udg_TSE_ReplacementIndex == udg_TSE_MaxIndex))) then
        do return true end
    end
    if (((udg_TSE_I_ActiveInstance[udg_TSE_MaxIndex] == false))) then
        do return true end
    end
    do return false end
end

-- Original JASS function: Trig_TSELoop_Func002Func001Func010Func039Func005Func002C (line 4638)
function Trig_TSELoop_Func002Func001Func010Func039Func005Func002C()
    if (((udg_TSE_I_ActiveInstance[udg_TSE_MaxIndex] == true))) then
        do return true end
    end
    if (((udg_TSE_MaxIndex <= 0))) then
        do return true end
    end
    do return false end
end

-- Original JASS function: Trig_TSELoop_Func002Func001Func010Func039Func005C (line 4648)
function Trig_TSELoop_Func002Func001Func010Func039Func005C()
    if ((not Trig_TSELoop_Func002Func001Func010Func039Func005Func002C())) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_TSELoop_Func002Func001Func010Func039C (line 4655)
function Trig_TSELoop_Func002Func001Func010Func039C()
    if ((not Trig_TSELoop_Func002Func001Func010Func039Func002C())) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_TSELoop_Func002Func001Func010Func041C (line 4662)
function Trig_TSELoop_Func002Func001Func010Func041C()
    if ((not ((udg_TSE_MaxIndex <= 0)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_TSELoop_Func002Func001Func010C (line 4669)
function Trig_TSELoop_Func002Func001Func010C()
    if ((not ((udg_TSE_I_RemainingDuration[udg_TSE_Index] <= __jreal(0.00))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_TSELoop_Func002Func001C (line 4676)
function Trig_TSELoop_Func002Func001C()
    if ((not ((udg_TSE_I_ActiveInstance[udg_TSE_Index] == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_TSELoop_Actions (line 4683)
function Trig_TSELoop_Actions()
    udg_TSE_Index = 1
    while true do
        if (udg_TSE_Index > udg_TSE_MaxIndex) then break end
        if (Trig_TSELoop_Func002Func001C()) then
            udg_TSE_I_RemainingDuration[udg_TSE_Index] = (__jreal(udg_TSE_I_RemainingDuration[udg_TSE_Index] - udg_TSE_TIMEOUT))
            udg_TSE_I_LoopDuration[udg_TSE_Index] = (__jreal(udg_TSE_I_LoopDuration[udg_TSE_Index] - udg_TSE_TIMEOUT))
            if (Trig_TSELoop_Func002Func001Func004C()) then
                udg_TSE__ActiveIndex = udg_TSE_Index
                udg_TSE__RemainingDuration = udg_TSE_I_RemainingDuration[udg_TSE__ActiveIndex]
                udg_TSE__SourceUnit = udg_TSE_I_SourceUnit[udg_TSE__ActiveIndex]
                udg_TSE__TargetUnit = udg_TSE_I_TargetUnit[udg_TSE__ActiveIndex]
                udg_TSE__Point = udg_TSE_I_Point[udg_TSE__ActiveIndex]
                udg_TSE__SpecialEffect = udg_TSE_I_Effect[udg_TSE__ActiveIndex]
                ConditionalTriggerExecute(udg_TSE_I_OnLoopEvent[udg_TSE_Index])
                udg_TSE_I_RemainingDuration[udg_TSE__ActiveIndex] = udg_TSE__RemainingDuration
                udg_TSE_I_LoopDuration[udg_TSE_Index] = udg_TSE_I_OnLoopTimer[udg_TSE_Index]
            else
            end
            if (Trig_TSELoop_Func002Func001Func006C()) then
                udg_TSE_I_RemainingDuration[udg_TSE_Index] = __jreal(0.00)
            else
            end
            if (Trig_TSELoop_Func002Func001Func007C()) then
                udg_TSE_I_RemainingDuration[udg_TSE_Index] = __jreal(0.00)
            else
            end
            if (Trig_TSELoop_Func002Func001Func008C()) then
                udg_TSE_I_RemainingDuration[udg_TSE_Index] = __jreal(0.00)
            else
            end
            if (Trig_TSELoop_Func002Func001Func010C()) then
                udg_TSE__ActiveIndex = udg_TSE_Index
                udg_TSE__RemainingDuration = udg_TSE_I_RemainingDuration[udg_TSE__ActiveIndex]
                udg_TSE__SourceUnit = udg_TSE_I_SourceUnit[udg_TSE__ActiveIndex]
                udg_TSE__TargetUnit = udg_TSE_I_TargetUnit[udg_TSE__ActiveIndex]
                udg_TSE__Point = udg_TSE_I_Point[udg_TSE__ActiveIndex]
                udg_TSE__SpecialEffect = udg_TSE_I_Effect[udg_TSE__ActiveIndex]
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
                udg_TSE_I_Point[udg_TSE_Index] = udg_TSE_I_Point[udg_TSE_ReplacementIndex]
                udg_TSE_I_RemainingDuration[udg_TSE_Index] = udg_TSE_I_RemainingDuration[udg_TSE_ReplacementIndex]
                udg_TSE_I_Effect[udg_TSE_Index] = udg_TSE_I_Effect[udg_TSE_ReplacementIndex]
                udg_TSE_I_ChanneledOrderID[udg_TSE_Index] = udg_TSE_I_ChanneledOrderID[udg_TSE_ReplacementIndex]
                udg_TSE_I_IsChanneling[udg_TSE_Index] = udg_TSE_I_IsChanneling[udg_TSE_ReplacementIndex]
                udg_TSE_I_SourceUnit[udg_TSE_Index] = udg_TSE_I_SourceUnit[udg_TSE_ReplacementIndex]
                udg_TSE_I_SourceUnitAliveCheck[udg_TSE_Index] = udg_TSE_I_SourceUnitAliveCheck[udg_TSE_ReplacementIndex]
                udg_TSE_I_TargetUnitAliveCheck[udg_TSE_Index] = udg_TSE_I_TargetUnitAliveCheck[udg_TSE_ReplacementIndex]
                udg_TSE_I_TargetUnit[udg_TSE_Index] = udg_TSE_I_TargetUnit[udg_TSE_ReplacementIndex]
                udg_TSE_I_OnLoopEvent[udg_TSE_Index] = udg_TSE_I_OnLoopEvent[udg_TSE_ReplacementIndex]
                udg_TSE_I_OnLoopTimer[udg_TSE_Index] = udg_TSE_I_OnLoopTimer[udg_TSE_ReplacementIndex]
                udg_TSE_I_LoopDuration[udg_TSE_Index] = udg_TSE_I_LoopDuration[udg_TSE_ReplacementIndex]
                udg_TSE_I_OnEndEvent[udg_TSE_Index] = udg_TSE_I_OnEndEvent[udg_TSE_ReplacementIndex]
                udg_TSE_I_LockInstance[udg_TSE_Index] = udg_TSE_I_LockInstance[udg_TSE_ReplacementIndex]
                udg_TSE_I_LockInstance[udg_TSE_ReplacementIndex] = false
                udg_TSE_I_ActiveInstance[udg_TSE_Index] = udg_TSE_I_ActiveInstance[udg_TSE_ReplacementIndex]
                udg_TSE_I_ActiveInstance[udg_TSE_ReplacementIndex] = false
                udg_TSE_Index = (__jint(udg_TSE_Index - 1))
                if (Trig_TSELoop_Func002Func001Func010Func039C()) then
                    udg_TSE_MaxCheckOver = false
                    while true do
                        udg_TSE_MaxIndex = (__jint(udg_TSE_MaxIndex - 1))
                        if (Trig_TSELoop_Func002Func001Func010Func039Func005C()) then
                            udg_TSE_MaxCheckOver = true
                        else
                        end
                        if (udg_TSE_MaxCheckOver == true) then break end
                    end
                else
                end
                if (Trig_TSELoop_Func002Func001Func010Func041C()) then
                    PauseTimerBJ(true, udg_TSE_CTimer)
                    DisableTrigger(udg_TSE_LoopTrigger)
                else
                end
            else
            end
        else
        end
        udg_TSE_Index = __jint(udg_TSE_Index + 1)
    end
end

-- Original JASS function: InitTrig_TSELoop (line 4789)
function InitTrig_TSELoop()
    gg_trg_TSELoop = CreateTrigger()
    DisableTrigger(gg_trg_TSELoop)
    TriggerRegisterTimerExpireEventBJ(gg_trg_TSELoop, udg_TSE_CTimer)
    TriggerAddAction(gg_trg_TSELoop, Trig_TSELoop_Actions)
end
-- END FOREST SECTION 5

-- BEGIN FOREST SECTION 6 TSEEmptyEvent
-- Original JASS function: Trig_TSEEmptyEvent_Actions (line 4799)
function Trig_TSEEmptyEvent_Actions()
end

-- Original JASS function: InitTrig_TSEEmptyEvent (line 4803)
function InitTrig_TSEEmptyEvent()
    gg_trg_TSEEmptyEvent = CreateTrigger()
    TriggerAddAction(gg_trg_TSEEmptyEvent, Trig_TSEEmptyEvent_Actions)
end
-- END FOREST SECTION 6
