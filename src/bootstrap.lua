-- Runs after editor-generated sounds, regions, destructables, units and InitBlizzard.
function InitTrig_FE_Bootstrap()
    FE_InitNativeGlobals()
    ExecuteFunc("jasshelper__initstructs149790140")
    ExecuteFunc("PassiveMissiles__Init")
    ExecuteFunc("SpellLeech__Init")
    FE_InitGlobals()
    FE_InitCustomTriggers()
    FE_Recipes.init()
    FE_Shops.init()
    FE_Test.init()
    FE_RunInitializationTriggers()
end
