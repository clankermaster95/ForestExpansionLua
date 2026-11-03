-- game / clock
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 7 Map_Ini_Testing
-- Original JASS function: Trig_Map_Ini_Testing_Actions (line 4813)
function Trig_Map_Ini_Testing_Actions()
    CreateMultiboardBJ(3, 11, "TRIGSTR_5709")
    MultiboardSetTitleText(GetLastCreatedMultiboard(), "TRIGSTR_5710")
end

-- Original JASS function: InitTrig_Map_Ini_Testing (line 4819)
function InitTrig_Map_Ini_Testing()
    gg_trg_Map_Ini_Testing = CreateTrigger()
    DisableTrigger(gg_trg_Map_Ini_Testing)
    TriggerRegisterTimerEventSingle(gg_trg_Map_Ini_Testing, __jreal(1.00))
    TriggerAddAction(gg_trg_Map_Ini_Testing, Trig_Map_Ini_Testing_Actions)
end
-- END FOREST SECTION 7

-- BEGIN FOREST SECTION 8 Counter_Testing
-- Original JASS function: Trig_Counter_Testing_Actions (line 4831)
function Trig_Counter_Testing_Actions()
    MultiboardSetItemWidthBJ(GetLastCreatedMultiboard(), 1, 1, __jreal(15.00))
    MultiboardSetItemWidthBJ(GetLastCreatedMultiboard(), 2, 1, __jreal(15.00))
    MultiboardSetItemStyleBJ(GetLastCreatedMultiboard(), 0, 1, true, false)
    MultiboardSetItemIconBJ(GetLastCreatedMultiboard(), 0, 2, "UI\\Feedback\\Resources\\ResourceGold.blp")
    MultiboardSetItemValueBJ(GetLastCreatedMultiboard(), 0, 1, "TRIGSTR_4490")
    MultiboardSetItemValueBJ(GetLastCreatedMultiboard(), 0, 2, "TRIGSTR_152")
    MultiboardSetItemValueBJ(GetLastCreatedMultiboard(), 1, 3, GetPlayerName(Player(0)))
    MultiboardSetItemValueBJ(GetLastCreatedMultiboard(), 1, 3, (__jconcat("|cffff0000", (__jconcat(GetPlayerName(Player(0)), "|r")))))
    MultiboardSetItemWidthBJ(GetLastCreatedMultiboard(), 0, 2, __jreal(13.00))
    MultiboardSetItemWidthBJ(GetLastCreatedMultiboard(), 1, 3, __jreal(15.00))
    MultiboardSetItemWidthBJ(GetLastCreatedMultiboard(), 2, 3, __jreal(6.00))
    MultiboardSetItemValueBJ(GetLastCreatedMultiboard(), 2, 3, I2S(GetPlayerState(Player(0), PLAYER_STATE_RESOURCE_GOLD)))
end

-- Original JASS function: InitTrig_Counter_Testing (line 4847)
function InitTrig_Counter_Testing()
    gg_trg_Counter_Testing = CreateTrigger()
    DisableTrigger(gg_trg_Counter_Testing)
    TriggerRegisterTimerEventPeriodic(gg_trg_Counter_Testing, __jreal(2.00))
    TriggerAddAction(gg_trg_Counter_Testing, Trig_Counter_Testing_Actions)
end
-- END FOREST SECTION 8

-- BEGIN FOREST SECTION 9 Start_Counter
-- Original JASS function: Trig_Start_Counter_Actions (line 4859)
function Trig_Start_Counter_Actions()
    DisableTrigger(gg_trg_Tradeoff_Detection)
    DisableTrigger(gg_trg_TreeChopper_Detection)
end

-- Original JASS function: InitTrig_Start_Counter (line 4865)
function InitTrig_Start_Counter()
    gg_trg_Start_Counter = CreateTrigger()
    DisableTrigger(gg_trg_Start_Counter)
    TriggerRegisterTimerEventSingle(gg_trg_Start_Counter, __jreal(60.00))
    TriggerAddAction(gg_trg_Start_Counter, Trig_Start_Counter_Actions)
end
-- END FOREST SECTION 9

-- BEGIN FOREST SECTION 10 Counter
-- Original JASS function: Trig_Counter_Func002Func003C (line 4875)
function Trig_Counter_Func002Func003C()
    if ((not ((udg_IntMinutes == 60)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Counter_Func002C (line 4882)
function Trig_Counter_Func002C()
    if ((not ((udg_IntSeconds == 60)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Counter_Func003C (line 4889)
function Trig_Counter_Func003C()
    if ((not ((udg_IntSeconds < 10)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Counter_Func004C (line 4896)
function Trig_Counter_Func004C()
    if ((not ((udg_IntMinutes < 10)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Counter_Actions (line 4903)
function Trig_Counter_Actions()
    udg_IntSeconds = (__jint(udg_IntSeconds + 1))
    if (Trig_Counter_Func002C()) then
        udg_IntSeconds = 0
        udg_IntMinutes = (__jint(udg_IntMinutes + 1))
        if (Trig_Counter_Func002Func003C()) then
            udg_IntMinutes = 0
            udg_IntHours = (__jint(udg_IntHours + 1))
        else
        end
    else
    end
    if (Trig_Counter_Func003C()) then
        udg_StringSeconds = "0"
    else
        udg_StringSeconds = ""
    end
    if (Trig_Counter_Func004C()) then
        udg_StringMinutes = "0"
    else
        udg_StringMinutes = ""
    end
    udg_Counterstring = (__jconcat((__jconcat((__jconcat("|cffe6cd00", (__jconcat(I2S(udg_IntHours), ":")))), (__jconcat((__jconcat(udg_StringMinutes, I2S(udg_IntMinutes))), ":")))), (__jconcat((__jconcat(udg_StringSeconds, I2S(udg_IntSeconds))), "|r"))))
    CreateMultiboardBJ(1, 1, (__jconcat((__jconcat("Information  -  ", (__jconcat("|cffcdcd00[|r ", (__jconcat((__jconcat(udg_TreeChopper, " ")), (__jconcat(udg_Tradeoff, "|cffcdcd00 ]  -  |r")))))))), udg_Counterstring)))
end

-- Original JASS function: InitTrig_Counter (line 4930)
function InitTrig_Counter()
    gg_trg_Counter = CreateTrigger()
    DisableTrigger(gg_trg_Counter)
    TriggerRegisterTimerEventPeriodic(gg_trg_Counter, __jreal(1.00))
    TriggerAddAction(gg_trg_Counter, Trig_Counter_Actions)
end
-- END FOREST SECTION 10
