-- game / startup
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 251 Initialization
function Trig_Initialization_Func002002()
    SetCameraBoundsToRectForPlayerBJ(GetEnumPlayer(), gg_rct_Camera_1)
end

function Trig_Initialization_Actions()
    SetCreepCampFilterState(false)
    ForForce(GetPlayersAll(), Trig_Initialization_Func002002)
end

function InitTrig_Initialization()
    gg_trg_Initialization = CreateTrigger()
    TriggerAddAction(gg_trg_Initialization, Trig_Initialization_Actions)
end
-- END FOREST SECTION 251

-- BEGIN FOREST SECTION 252 LimitedTraining
function Trig_LimitedTraining_Func002A()
    SetPlayerTechMaxAllowedSwap(FourCC("h03A"), 1, GetEnumPlayer())
    SetPlayerTechMaxAllowedSwap(FourCC("u00E"), 1, GetEnumPlayer())
    SetPlayerTechMaxAllowedSwap(FourCC("n006"), 1, GetEnumPlayer())
    SetPlayerTechMaxAllowedSwap(FourCC("n007"), 1, GetEnumPlayer())
    SetPlayerTechMaxAllowedSwap(FourCC("h05L"), 1, GetEnumPlayer())
    SetPlayerTechMaxAllowedSwap(FourCC("E00T"), 1, GetEnumPlayer())
    SetPlayerTechMaxAllowedSwap(FourCC("n00S"), 1, GetEnumPlayer())
    SetPlayerTechMaxAllowedSwap(FourCC("H064"), 1, GetEnumPlayer())
end

function Trig_LimitedTraining_Actions()
    MeleeStartingHeroLimit()
    ForForce(GetPlayersAll(), Trig_LimitedTraining_Func002A)
end

function InitTrig_LimitedTraining()
    gg_trg_LimitedTraining = CreateTrigger()
    TriggerAddAction(gg_trg_LimitedTraining, Trig_LimitedTraining_Actions)
end
-- END FOREST SECTION 252

-- BEGIN FOREST SECTION 253 TimeToExpanderSpawn
function Trig_TimeToExpanderSpawn_Actions()
    if FE_Test and FE_Test.skipped then return end
    TimerStart(udg_ExpanderSpawnTimer, __jreal(19.00), false, nil)
    CreateTimerDialogBJ(udg_ExpanderSpawnTimer, "TRIGSTR_7401")
    local dialog = GetLastCreatedTimerDialogBJ()
    if FE_Test and FE_Test.player then FE_Test.countdowns[#FE_Test.countdowns+1]={timer=udg_ExpanderSpawnTimer,dialog=dialog} end
    TriggerSleepAction(__jreal(19.00))
    if FE_Test then FE_Test.releaseCountdown(dialog) end
    DestroyTimerDialogBJ(dialog)
end

function InitTrig_TimeToExpanderSpawn()
    gg_trg_TimeToExpanderSpawn = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_TimeToExpanderSpawn, __jreal(1.00))
    TriggerAddAction(gg_trg_TimeToExpanderSpawn, Trig_TimeToExpanderSpawn_Actions)
end
-- END FOREST SECTION 253

-- BEGIN FOREST SECTION 254 TimeToAncientSpawn
function Trig_TimeToAncientSpawn_Actions()
    if FE_Test and FE_Test.skipped then return end
    TimerStart(udg_AncientSpawnTimer, __jreal(40.00), false, nil)
    CreateTimerDialogBJ(udg_AncientSpawnTimer, "TRIGSTR_7400")
    local dialog = GetLastCreatedTimerDialogBJ()
    if FE_Test and FE_Test.player then FE_Test.countdowns[#FE_Test.countdowns+1]={timer=udg_AncientSpawnTimer,dialog=dialog} end
    TriggerSleepAction(__jreal(40.00))
    if FE_Test then FE_Test.releaseCountdown(dialog) end
    DestroyTimerDialogBJ(dialog)
end

function InitTrig_TimeToAncientSpawn()
    gg_trg_TimeToAncientSpawn = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_TimeToAncientSpawn, __jreal(20.00))
    TriggerAddAction(gg_trg_TimeToAncientSpawn, Trig_TimeToAncientSpawn_Actions)
end
-- END FOREST SECTION 254

-- BEGIN FOREST SECTION 255 Unit_Indexer
function Trig_Unit_Indexer_Func017Func004C()
    return udg_UDexRecycle == 0
end

function Trig_Unit_Indexer_Func017C()
    return udg_UnitIndexerEnabled == true
end

function Trig_Unit_Indexer_Func030Func005C()
    return GetUnitUserData(udg_UDexUnits[udg_UDex]) == 0
end

function Trig_Unit_Indexer_Func030C()
    return udg_UDexWasted == 15
end

function Trig_Unit_Indexer_Func034C()
    return GetUnitUserData(GetFilterUnit()) == 0
end

function Trig_Unit_Indexer_Actions()
    ExecuteFunc("InitializeUnitIndexer")
end

function IndexUnit()
    local pdex = udg_UDex
    if (Trig_Unit_Indexer_Func017C()) then
        if (Trig_Unit_Indexer_Func017Func004C()) then
            udg_UDex = (__jint(udg_UDexGen + 1))
            udg_UDexGen = udg_UDex
        else
            udg_UDex = udg_UDexRecycle
            udg_UDexRecycle = udg_UDexNext[udg_UDex]
        end
        udg_UDexUnits[udg_UDex] = GetFilterUnit()
        SetUnitUserData(udg_UDexUnits[udg_UDex], udg_UDex)
        udg_UDexPrev[udg_UDexNext[0]] = udg_UDex
        udg_UDexNext[udg_UDex] = udg_UDexNext[0]
        udg_UDexNext[0] = udg_UDex
        udg_UnitIndexEvent = __jreal(0.00)
        udg_UnitIndexEvent = __jreal(1.00)
        udg_UnitIndexEvent = __jreal(0.00)
        udg_UDex = pdex
    end
    return false
end

function IndexNewUnit()
    local pdex = udg_UDex
    local ndex = 0
    udg_UDexWasted = (__jint(udg_UDexWasted + 1))
    if (Trig_Unit_Indexer_Func030C()) then
        udg_UDexWasted = 0
        udg_UDex = udg_UDexNext[0]
        while true do
            if (udg_UDex == 0) then break end
            if (Trig_Unit_Indexer_Func030Func005C()) then
                ndex = udg_UDexNext[udg_UDex]
                udg_UDexNext[udg_UDexPrev[udg_UDex]] = ndex
                udg_UDexPrev[ndex] = udg_UDexPrev[udg_UDex]
                udg_UDexPrev[udg_UDex] = 0
                udg_UnitIndexEvent = __jreal(2.00)
                udg_UnitIndexEvent = __jreal(0.00)
                udg_UDexUnits[udg_UDex] = nil
                udg_UDexNext[udg_UDex] = udg_UDexRecycle
                udg_UDexRecycle = udg_UDex
                udg_UDex = ndex
            else
                udg_UDex = udg_UDexNext[udg_UDex]
            end
        end
        udg_UDex = pdex
    end
    if (Trig_Unit_Indexer_Func034C()) then
        IndexUnit()
    end
    return false
end

function InitializeUnitIndexer()
    local i = 0
    local re = CreateRegion()
    local r = GetWorldBounds()
    udg_UnitIndexerEnabled = true
    RegionAddRect(re, r)
    TriggerRegisterEnterRegion(CreateTrigger(), re, Filter(IndexNewUnit))
    RemoveRect(r)
    re = nil
    r = nil
    while true do
        GroupEnumUnitsOfPlayer(bj_lastCreatedGroup, Player(i), Filter(IndexUnit))
        i = __jint(i + 1)
        if (i == 16) then break end
    end
    udg_UnitIndexEvent = __jreal(3.00)
    udg_UnitIndexEvent = __jreal(0.00)
end

function InitTrig_Unit_Indexer()
    gg_trg_Unit_Indexer = CreateTrigger()
    TriggerAddAction(gg_trg_Unit_Indexer, Trig_Unit_Indexer_Actions)
end
-- END FOREST SECTION 255
