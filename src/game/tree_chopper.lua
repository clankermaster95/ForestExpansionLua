-- game / tree_chopper
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 12 TreeChopper_Detection
-- Original JASS function: Trig_TreeChopper_Detection_Actions (line 4958)
function Trig_TreeChopper_Detection_Actions()
    CreateNUnitsAtLoc(1, FourCC("h060"), FE_Roles.ancient(), GetRectCenter(gg_rct_ChopChop), bj_UNIT_FACING)
    udg_TreeChopper = "|cffb79419-chopoff|r"
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_5530")
end

-- Original JASS function: InitTrig_TreeChopper_Detection (line 4965)
function InitTrig_TreeChopper_Detection()
    gg_trg_TreeChopper_Detection = CreateTrigger()
    TriggerRegisterPlayerChatEvent(gg_trg_TreeChopper_Detection, Player(0), "-chopchop", true)
    TriggerAddAction(gg_trg_TreeChopper_Detection, Trig_TreeChopper_Detection_Actions)
end
-- END FOREST SECTION 12
