-- races / wisp
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 136 SeedOfRebirth
function Trig_SeedOfRebirth_Conditions()
    return GetSpellAbilityId() == FourCC("A0B9")
end

function Trig_SeedOfRebirth_IsSeedTargetType(u)
    local id = GetUnitTypeId(u)
    return (((((((((((id == FourCC("e00E")) or (id == FourCC("e00C"))) or (id == FourCC("e002"))) or (id == FourCC("e009"))) or (id == FourCC("e00A"))) or (id == FourCC("e00G"))) or (id == FourCC("e00J"))) or (id == FourCC("e00O"))) or (id == FourCC("e00H"))) or (id == FourCC("e00N"))) or (id == FourCC("e00S")))
end

function Trig_SeedOfRebirth_Func001Func006002()
    RemoveUnit(GetEnumUnit())
end

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
    if FE_Wildkin then FE_Wildkin.restoreResearch(reborn) end
    if FE_Worgen then FE_Worgen.restoreResearch(reborn) end
    if FE_Bloodmage then FE_Bloodmage.restoreResearch(reborn) end
    if FE_Kobold then FE_Kobold.restoreResearch(reborn) end
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

function InitTrig_SeedOfRebirth()
    gg_trg_SeedOfRebirth = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_SeedOfRebirth, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_SeedOfRebirth, Condition(Trig_SeedOfRebirth_Conditions))
    TriggerAddAction(gg_trg_SeedOfRebirth, Trig_SeedOfRebirth_Actions)
end
-- END FOREST SECTION 136
