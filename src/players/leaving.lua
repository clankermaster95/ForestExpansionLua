-- players / leaving
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 321 Player_Leaves
function Trig_Player_Leaves_Func003002()
    RemoveUnit(GetEnumUnit())
end

function Trig_Player_Leaves_Actions()
    if FE_Roles.isAncient(GetTriggerPlayer()) then return end
    FE_Takeover.begin(GetTriggerPlayer())
end

function InitTrig_Player_Leaves()
    gg_trg_Player_Leaves = CreateTrigger()
    FE_Roles.forEachPlayer(function(player)
        TriggerRegisterPlayerEventLeave(gg_trg_Player_Leaves, player)
    end)
    TriggerAddAction(gg_trg_Player_Leaves, Trig_Player_Leaves_Actions)
end
-- END FOREST SECTION 321

-- BEGIN FOREST SECTION 322 Ancient_Leaves
function Trig_Ancient_Leaves_Actions()
    if FE_Roles.isAncient(GetTriggerPlayer()) then
        PlayThematicMusicBJ("Tension")
        FE_Takeover.begin(GetTriggerPlayer())
    end
end

function InitTrig_Ancient_Leaves()
    local i = 0
    gg_trg_Ancient_Leaves = CreateTrigger()
    while true do
        if (i >= 11) then break end
        TriggerRegisterPlayerEventLeave(gg_trg_Ancient_Leaves, Player(i))
        i = __jint(i + 1)
    end
    TriggerAddAction(gg_trg_Ancient_Leaves, Trig_Ancient_Leaves_Actions)
end
-- END FOREST SECTION 322
