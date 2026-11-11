-- economy / income
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

FE_Income = { ancientMultiplier = 1 }

function FE_Income.bringItOn(player)
    -- Match the existing Red-only match settings. Warcraft exposes no
    -- authoritative lobby-host handle in the API used by this map.
    if player ~= Player(0) then return false end
    if FE_Income.ancientMultiplier == 2 then
        DisplayTextToPlayer(player, 0, 0, "Bring It On is already enabled.")
        return false
    end
    FE_Income.ancientMultiplier = 2
    DisplayTextToForce(GetPlayersAll(), "Bring It On enabled: the Ancient now gains 20 passive gold every 10 seconds. Kill rewards and starting gold are unchanged.")
    return true
end

-- BEGIN FOREST SECTION 246 Deliver_Gold
function Trig_Deliver_Gold_Actions()
    FE_Roles.forEachPlayer(function(player)
        local gold = FE_Roles.isAncient(player) and 1040 or 1
        AdjustPlayerStateBJ(gold, player, PLAYER_STATE_RESOURCE_GOLD)
    end)
end

function InitTrig_Deliver_Gold()
    gg_trg_Deliver_Gold = CreateTrigger()
    TriggerAddAction(gg_trg_Deliver_Gold, Trig_Deliver_Gold_Actions)
end
-- END FOREST SECTION 246

-- BEGIN FOREST SECTION 247 Worgens_gold
function Trig_Worgens_gold_Conditions()
    return GetUnitTypeId(udg_DamageEventTarget) == FourCC("h00Q")
end

function Trig_Worgens_gold_Func004C()
    return GetUnitTypeId(udg_DamageEventSource) == FourCC("h00R")
end

function Trig_Worgens_gold_Actions()
    AdjustPlayerStateBJ(1, GetOwningPlayer(GetEventDamageSource()), PLAYER_STATE_RESOURCE_GOLD)
    AddSpecialEffectLocBJ(GetUnitLoc(gg_unit_h00Q_0026), "UI\\Feedback\\GoldCredit\\GoldCredit.mdl")
    DestroyEffectBJ(GetLastCreatedEffectBJ())
    if (Trig_Worgens_gold_Func004C()) then
        AdjustPlayerStateBJ(1, GetOwningPlayer(GetEventDamageSource()), PLAYER_STATE_RESOURCE_GOLD)
    end
end

function InitTrig_Worgens_gold()
    gg_trg_Worgens_gold = CreateTrigger()
    h__TriggerRegisterVariableEvent(gg_trg_Worgens_gold, "udg_DamageEvent", EQUAL, __jreal(1.00))
    TriggerAddCondition(gg_trg_Worgens_gold, Condition(Trig_Worgens_gold_Conditions))
    TriggerAddAction(gg_trg_Worgens_gold, Trig_Worgens_gold_Actions)
end
-- END FOREST SECTION 247

-- BEGIN FOREST SECTION 248 Bounty
function Trig_Bounty_Func001A()
    SetPlayerFlagBJ(PLAYER_STATE_GIVES_BOUNTY, true, Player(0))
    SetPlayerFlagBJ(PLAYER_STATE_GIVES_BOUNTY, true, Player(1))
    SetPlayerFlagBJ(PLAYER_STATE_GIVES_BOUNTY, true, Player(2))
    SetPlayerFlagBJ(PLAYER_STATE_GIVES_BOUNTY, true, Player(3))
    SetPlayerFlagBJ(PLAYER_STATE_GIVES_BOUNTY, true, Player(4))
    SetPlayerFlagBJ(PLAYER_STATE_GIVES_BOUNTY, true, Player(5))
    SetPlayerFlagBJ(PLAYER_STATE_GIVES_BOUNTY, true, Player(6))
    SetPlayerFlagBJ(PLAYER_STATE_GIVES_BOUNTY, true, Player(7))
    SetPlayerFlagBJ(PLAYER_STATE_GIVES_BOUNTY, true, Player(8))
    SetPlayerFlagBJ(PLAYER_STATE_GIVES_BOUNTY, true, Player(9))
    SetPlayerFlagBJ(PLAYER_STATE_GIVES_BOUNTY, true, Player(10))
end

function Trig_Bounty_Actions()
    ForForce(GetPlayersAll(), Trig_Bounty_Func001A)
end

function InitTrig_Bounty()
    gg_trg_Bounty = CreateTrigger()
    TriggerAddAction(gg_trg_Bounty, Trig_Bounty_Actions)
end
-- END FOREST SECTION 248

-- BEGIN FOREST SECTION 249 Remove_Ancient_Lumber
function Trig_Remove_Ancient_Lumber_Conditions()
    return GetItemTypeId(GetManipulatedItem()) == FourCC("I01F")
end

function Trig_Remove_Ancient_Lumber_Actions()
    SetPlayerStateBJ(FE_Roles.ancient(), PLAYER_STATE_RESOURCE_LUMBER, (__jint(GetPlayerState(FE_Roles.ancient(), PLAYER_STATE_RESOURCE_LUMBER) - 500)))
end

function InitTrig_Remove_Ancient_Lumber()
    gg_trg_Remove_Ancient_Lumber = CreateTrigger()
    FE_Roles.registerAncientUnitEvent(gg_trg_Remove_Ancient_Lumber, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    TriggerAddCondition(gg_trg_Remove_Ancient_Lumber, Condition(Trig_Remove_Ancient_Lumber_Conditions))
    TriggerAddAction(gg_trg_Remove_Ancient_Lumber, Trig_Remove_Ancient_Lumber_Actions)
end
-- END FOREST SECTION 249

-- BEGIN FOREST SECTION 250 Ancient_Gold_income
function Trig_Ancient_Gold_income_Actions()
    AdjustPlayerStateBJ(10 * FE_Income.ancientMultiplier, FE_Roles.ancient(), PLAYER_STATE_RESOURCE_GOLD)
end

function InitTrig_Ancient_Gold_income()
    gg_trg_Ancient_Gold_income = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(gg_trg_Ancient_Gold_income, __jreal(10.00))
    TriggerAddAction(gg_trg_Ancient_Gold_income, Trig_Ancient_Gold_income_Actions)
    local command = CreateTrigger()
    TriggerRegisterPlayerChatEvent(command, Player(0), "-bringiton", true)
    TriggerAddAction(command, function() FE_Income.bringItOn(GetTriggerPlayer()) end)
end
-- END FOREST SECTION 250
