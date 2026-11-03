-- Disabled in the original map.
function Trig_Gara_2hits1g_Func021Func001C()
    if ((not ((GetPlayerState(GetTriggerPlayer(), PLAYER_STATE_RESOURCE_LUMBER) == (__jint(BlzGetUnitMaxMana(GetEnumUnit()) + 150)))))) then
        do return false end
    end
    do return true end
end

function Trig_Gara_2hits1g_Func021A()
    if (Trig_Gara_2hits1g_Func021Func001C()) then
        BlzSetUnitMaxMana(GetEnumUnit(), GetPlayerState(Player(0), PLAYER_STATE_RESOURCE_LUMBER))
        SetPlayerStateBJ(GetTriggerPlayer(), PLAYER_STATE_RESOURCE_GOLD, (__jint(GetPlayerState(GetTriggerPlayer(), PLAYER_STATE_RESOURCE_GOLD) + 1)))
    else
    end
    BlzSetUnitMaxMana(GetEnumUnit(), GetPlayerState(Player(0), PLAYER_STATE_RESOURCE_LUMBER))
end

function Trig_Gara_2hits1g_Func021001002()
    do return ((GetUnitTypeId(GetFilterUnit()) == FourCC("h06I"))) end
end

function Trig_Gara_2hits1g_Actions()
    ForGroupBJ(GetUnitsOfPlayerMatching(GetTriggerPlayer(), Condition(Trig_Gara_2hits1g_Func021001002)), Trig_Gara_2hits1g_Func021A)
end

function InitTrig_Gara_2hits1g()
    gg_trg_Gara_2hits1g = CreateTrigger()
    TriggerRegisterPlayerStateEvent(gg_trg_Gara_2hits1g, Player(0), PLAYER_STATE_RESOURCE_LUMBER, GREATER_THAN, GetUnitStateSwap(UNIT_STATE_MAX_MANA, gg_unit_h06I_0044))
    TriggerRegisterPlayerStateEvent(gg_trg_Gara_2hits1g, Player(0), PLAYER_STATE_RESOURCE_LUMBER, GREATER_THAN, GetUnitStateSwap(UNIT_STATE_MAX_MANA, gg_unit_h06I_0044))
    TriggerRegisterPlayerStateEvent(gg_trg_Gara_2hits1g, Player(1), PLAYER_STATE_RESOURCE_LUMBER, LESS_THAN, GetUnitStateSwap(UNIT_STATE_MAX_MANA, gg_unit_h06I_0046))
    TriggerRegisterPlayerStateEvent(gg_trg_Gara_2hits1g, Player(1), PLAYER_STATE_RESOURCE_LUMBER, GREATER_THAN, GetUnitStateSwap(UNIT_STATE_MAX_MANA, gg_unit_h06I_0046))
    TriggerRegisterPlayerStateEvent(gg_trg_Gara_2hits1g, Player(2), PLAYER_STATE_RESOURCE_LUMBER, LESS_THAN, GetUnitStateSwap(UNIT_STATE_MAX_MANA, gg_unit_h06I_0047))
    TriggerRegisterPlayerStateEvent(gg_trg_Gara_2hits1g, Player(2), PLAYER_STATE_RESOURCE_LUMBER, LESS_THAN, GetUnitStateSwap(UNIT_STATE_MAX_MANA, gg_unit_h06I_0047))
    TriggerRegisterPlayerStateEvent(gg_trg_Gara_2hits1g, Player(3), PLAYER_STATE_RESOURCE_LUMBER, LESS_THAN, GetUnitStateSwap(UNIT_STATE_MAX_MANA, gg_unit_h06I_0048))
    TriggerRegisterPlayerStateEvent(gg_trg_Gara_2hits1g, Player(3), PLAYER_STATE_RESOURCE_LUMBER, LESS_THAN, GetUnitStateSwap(UNIT_STATE_MAX_MANA, gg_unit_h06I_0048))
    TriggerRegisterPlayerStateEvent(gg_trg_Gara_2hits1g, Player(4), PLAYER_STATE_RESOURCE_LUMBER, LESS_THAN, GetUnitStateSwap(UNIT_STATE_MAX_MANA, gg_unit_h06I_0049))
    TriggerRegisterPlayerStateEvent(gg_trg_Gara_2hits1g, Player(4), PLAYER_STATE_RESOURCE_LUMBER, LESS_THAN, GetUnitStateSwap(UNIT_STATE_MAX_MANA, gg_unit_h06I_0049))
    TriggerRegisterPlayerStateEvent(gg_trg_Gara_2hits1g, Player(5), PLAYER_STATE_RESOURCE_LUMBER, LESS_THAN, GetUnitStateSwap(UNIT_STATE_MAX_MANA, gg_unit_h06I_0050))
    TriggerRegisterPlayerStateEvent(gg_trg_Gara_2hits1g, Player(5), PLAYER_STATE_RESOURCE_LUMBER, LESS_THAN, GetUnitStateSwap(UNIT_STATE_MAX_MANA, gg_unit_h06I_0050))
    TriggerRegisterPlayerStateEvent(gg_trg_Gara_2hits1g, Player(7), PLAYER_STATE_RESOURCE_LUMBER, LESS_THAN, GetUnitStateSwap(UNIT_STATE_MAX_MANA, gg_unit_h06I_0051))
    TriggerRegisterPlayerStateEvent(gg_trg_Gara_2hits1g, Player(7), PLAYER_STATE_RESOURCE_LUMBER, LESS_THAN, GetUnitStateSwap(UNIT_STATE_MAX_MANA, gg_unit_h06I_0051))
    TriggerRegisterPlayerStateEvent(gg_trg_Gara_2hits1g, Player(8), PLAYER_STATE_RESOURCE_LUMBER, LESS_THAN, GetUnitStateSwap(UNIT_STATE_MAX_MANA, gg_unit_h06I_0052))
    TriggerRegisterPlayerStateEvent(gg_trg_Gara_2hits1g, Player(8), PLAYER_STATE_RESOURCE_LUMBER, LESS_THAN, GetUnitStateSwap(UNIT_STATE_MAX_MANA, gg_unit_h06I_0052))
    TriggerRegisterPlayerStateEvent(gg_trg_Gara_2hits1g, Player(9), PLAYER_STATE_RESOURCE_LUMBER, LESS_THAN, GetUnitStateSwap(UNIT_STATE_MAX_MANA, gg_unit_h06I_0053))
    TriggerRegisterPlayerStateEvent(gg_trg_Gara_2hits1g, Player(9), PLAYER_STATE_RESOURCE_LUMBER, LESS_THAN, GetUnitStateSwap(UNIT_STATE_MAX_MANA, gg_unit_h06I_0053))
    TriggerRegisterPlayerStateEvent(gg_trg_Gara_2hits1g, Player(10), PLAYER_STATE_RESOURCE_LUMBER, LESS_THAN, GetUnitStateSwap(UNIT_STATE_MAX_MANA, gg_unit_h06I_0054))
    TriggerRegisterPlayerStateEvent(gg_trg_Gara_2hits1g, Player(10), PLAYER_STATE_RESOURCE_LUMBER, LESS_THAN, GetUnitStateSwap(UNIT_STATE_MAX_MANA, gg_unit_h06I_0054))
    TriggerAddAction(gg_trg_Gara_2hits1g, Trig_Gara_2hits1g_Actions)
end
