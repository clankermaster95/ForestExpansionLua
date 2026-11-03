-- races / wisp
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 136 SeedOfRebirth
-- Original JASS function: Trig_SeedOfRebirth_Conditions (line 10485)
function Trig_SeedOfRebirth_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A0B9"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_SeedOfRebirth_IsSeedTargetType (line 10492)
function Trig_SeedOfRebirth_IsSeedTargetType(u)
    local id = GetUnitTypeId(u)
    do return (((((((((((id == FourCC("e00E")) or (id == FourCC("e00C"))) or (id == FourCC("e002"))) or (id == FourCC("e009"))) or (id == FourCC("e00A"))) or (id == FourCC("e00G"))) or (id == FourCC("e00J"))) or (id == FourCC("e00O"))) or (id == FourCC("e00H"))) or (id == FourCC("e00N"))) or (id == FourCC("e00S"))) end
end

-- Original JASS function: Trig_SeedOfRebirth_Func001Func006002 (line 10497)
function Trig_SeedOfRebirth_Func001Func006002()
    RemoveUnit(GetEnumUnit())
end

-- Original JASS function: Trig_SeedOfRebirth_Func001Func010Func001C (line 10501)
function Trig_SeedOfRebirth_Func001Func010Func001C()
    if ((not ((IsPlayerEnemy(ConvertedPlayer(udg_SeedPlayedNumber), GetEnumPlayer()) == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_SeedOfRebirth_Func001Func010A (line 10508)
function Trig_SeedOfRebirth_Func001Func010A()
    if (Trig_SeedOfRebirth_Func001Func010Func001C()) then
        SetPlayerAllianceStateBJ(udg_DeadPlayer, GetEnumPlayer(), bj_ALLIANCE_ALLIED_VISION)
        SetPlayerAllianceStateBJ(GetEnumPlayer(), udg_DeadPlayer, bj_ALLIANCE_ALLIED_VISION)
    else
    end
end

-- Original JASS function: Trig_SeedOfRebirth_Func001Func011A (line 10517)
function Trig_SeedOfRebirth_Func001Func011A()
    SetPlayerAllianceStateBJ(udg_DeadPlayer, GetEnumPlayer(), bj_ALLIANCE_UNALLIED)
    SetPlayerAllianceStateBJ(GetEnumPlayer(), udg_DeadPlayer, bj_ALLIANCE_UNALLIED)
end

-- Original JASS function: Trig_SeedOfRebirth_Func001C (line 10522)
function Trig_SeedOfRebirth_Func001C()
    do return Trig_SeedOfRebirth_IsSeedTargetType(GetSpellTargetUnit()) end
end

-- Original JASS function: Trig_SeedOfRebirth_Actions (line 10526)
function Trig_SeedOfRebirth_Actions()
    local caster, target = GetSpellAbilityUnit(), GetSpellTargetUnit()
    if not target or not Trig_SeedOfRebirth_IsSeedTargetType(target) then return end
    local player = GetOwningPlayer(target)
    local originalType = udg_SeedOfRebirth[GetConvertedPlayerId(player)]
    if originalType == 0 then return end
    TriggerSleepAction(__jreal(2.00))
    if GetUnitTypeId(target) == 0 or GetWidgetLife(target) <= 0.405 or GetOwningPlayer(target) ~= player or
       FE_Roles.isAncient(player) or FE_Roster.isAlive(player) or
       GetPlayerSlotState(player) ~= PLAYER_SLOT_STATE_PLAYING then return end
    local units = GetUnitsOfPlayerAll(player)
    local reborn = CreateUnit(player, originalType, GetUnitX(target), GetUnitY(target), bj_UNIT_FACING)
    if not reborn then DestroyGroup(units); return end
    ForGroupBJ(units, Trig_SeedOfRebirth_Func001Func006002)
    DestroyGroup(units)
    SetPlayerStateBJ(player, PLAYER_STATE_RESOURCE_GOLD, 0)
    SetPlayerStateBJ(player, PLAYER_STATE_RESOURCE_LUMBER, 0)
    FE_Roster.revive(player)
    FE_Roles.forEachPlayer(function(other)
        if other ~= player then
            local state = FE_Roster.isAlive(other) and bj_ALLIANCE_ALLIED_VISION or bj_ALLIANCE_UNALLIED
            SetPlayerAllianceStateBJ(player, other, state)
            SetPlayerAllianceStateBJ(other, player, state)
        end
    end)
    if GetUnitTypeId(caster) ~= 0 then IssueImmediateOrderBJ(caster, "stop") end
end

-- Original JASS function: InitTrig_SeedOfRebirth (line 10544)
function InitTrig_SeedOfRebirth()
    gg_trg_SeedOfRebirth = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_SeedOfRebirth, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_SeedOfRebirth, Condition(Trig_SeedOfRebirth_Conditions))
    TriggerAddAction(gg_trg_SeedOfRebirth, Trig_SeedOfRebirth_Actions)
end
-- END FOREST SECTION 136
