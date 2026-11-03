-- Disabled in the original map.
function Trig_Seed_of_Rebirth_2_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A07V"))))) then
        do return false end
    end
    do return true end
end

function Trig_Seed_of_Rebirth_2_Actions()
    udg_Wisp = GetSpellAbilityUnit()
    UnitAddAbilityBJ(FourCC("A07W"), udg_Wisp)
    TriggerSleepAction(__jreal(0.10))
    DisplayTextToForce(GetPlayersAll(), (__jconcat(GetPlayerName(GetTriggerPlayer()), (__jconcat(" is reviving ", (__jconcat(GetPlayerName(udg_SeedP), "!")))))))
    UnitRemoveAbilityBJ(FourCC("A07V"), GetSpellAbilityUnit())
    PauseUnitBJ(true, udg_Wisp)
    TriggerSleepAction(__jreal(10.00))
    UnitRemoveAbilityBJ(FourCC("A07W"), udg_Wisp)
    PauseUnitBJ(false, udg_Wisp)
    DisplayTextToForce(GetPlayersAll(), (__jconcat(GetPlayerName(udg_SeedP), (__jconcat(" has been revived. ", (__jconcat(GetPlayerName(GetOwningPlayer(udg_Wisp)), " can no longer revive anyone else.")))))))
    CreateNUnitsAtLocFacingLocBJ(1, udg_Seed, udg_SeedP, udg_SeedR, GetUnitLoc(GetTriggerUnit()))
    PanCameraToTimedLocForPlayer(udg_SeedP, udg_SeedR, __jreal(1.25))
end

function InitTrig_Seed_of_Rebirth_2()
    gg_trg_Seed_of_Rebirth_2 = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Seed_of_Rebirth_2, EVENT_PLAYER_UNIT_SPELL_CAST)
    TriggerAddCondition(gg_trg_Seed_of_Rebirth_2, Condition(Trig_Seed_of_Rebirth_2_Conditions))
    TriggerAddAction(gg_trg_Seed_of_Rebirth_2, Trig_Seed_of_Rebirth_2_Actions)
end
