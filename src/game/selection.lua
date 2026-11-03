-- game / selection
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 18 Categorization
-- Original JASS function: Trig_Categorization_Conditions (line 5323)
function Trig_Categorization_Conditions()
    if ((not ((GetUnitTypeId(GetSellingUnit()) == FourCC("nmr2"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Categorization_Actions (line 5330)
function Trig_Categorization_Actions()
    udg_AncientUnit = GetSoldUnit()
    PlaySoundBJ(gg_snd_VarimathrasYes1)
end

-- Original JASS function: InitTrig_Categorization (line 5336)
function InitTrig_Categorization()
    gg_trg_Categorization = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Categorization, EVENT_PLAYER_UNIT_SELL)
    TriggerAddCondition(gg_trg_Categorization, Condition(Trig_Categorization_Conditions))
    TriggerAddAction(gg_trg_Categorization, Trig_Categorization_Actions)
end
-- END FOREST SECTION 18

-- BEGIN FOREST SECTION 256 Spellbringers_spells
-- Original JASS function: Trig_Spellbringers_spells_Func001C (line 15553)
function Trig_Spellbringers_spells_Func001C()
    if ((not ((GetUnitTypeId(GetSoldUnit()) == FourCC("O01D"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Spellbringers_spells_Func002C (line 15560)
function Trig_Spellbringers_spells_Func002C()
    if ((not ((GetUnitTypeId(GetSoldUnit()) == FourCC("O00A"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Spellbringers_spells_Func003C (line 15567)
function Trig_Spellbringers_spells_Func003C()
    if ((not ((GetUnitTypeId(GetSoldUnit()) == FourCC("O00S"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Spellbringers_spells_Func004C (line 15574)
function Trig_Spellbringers_spells_Func004C()
    if ((not ((GetUnitTypeId(GetSoldUnit()) == FourCC("O00L"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Spellbringers_spells_Func005C (line 15581)
function Trig_Spellbringers_spells_Func005C()
    if ((not ((GetUnitTypeId(GetSoldUnit()) == FourCC("O004"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Spellbringers_spells_Func006C (line 15588)
function Trig_Spellbringers_spells_Func006C()
    if ((not ((GetUnitTypeId(GetSoldUnit()) == FourCC("O008"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Spellbringers_spells_Func007C (line 15595)
function Trig_Spellbringers_spells_Func007C()
    if ((not ((GetUnitTypeId(GetSoldUnit()) == FourCC("O01V"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Spellbringers_spells_Func008C (line 15602)
function Trig_Spellbringers_spells_Func008C()
    if ((not ((GetUnitTypeId(GetSoldUnit()) == FourCC("O016"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Spellbringers_spells_Func009C (line 15609)
function Trig_Spellbringers_spells_Func009C()
    if ((not ((GetUnitTypeId(GetSoldUnit()) == FourCC("O00D"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Spellbringers_spells_Func010C (line 15616)
function Trig_Spellbringers_spells_Func010C()
    if ((not ((GetUnitTypeId(GetSoldUnit()) == FourCC("O01X"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Spellbringers_spells_Func011C (line 15623)
function Trig_Spellbringers_spells_Func011C()
    if ((not ((GetUnitTypeId(GetSoldUnit()) == FourCC("O01Z"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Spellbringers_spells_Actions (line 15630)
function Trig_Spellbringers_spells_Actions()
    if (Trig_Spellbringers_spells_Func001C()) then
        UnitAddAbilityBJ(FourCC("A0EM"), gg_unit_n00B_0266)
    else
    end
    if (Trig_Spellbringers_spells_Func002C()) then
        UnitAddAbilityBJ(FourCC("A0EN"), gg_unit_n00B_0266)
    else
    end
    if (Trig_Spellbringers_spells_Func003C()) then
        UnitAddAbilityBJ(FourCC("A0B4"), gg_unit_n00B_0266)
    else
    end
    if (Trig_Spellbringers_spells_Func004C()) then
        UnitAddAbilityBJ(FourCC("A0B5"), gg_unit_n00B_0266)
    else
    end
    if (Trig_Spellbringers_spells_Func005C()) then
        UnitAddAbilityBJ(FourCC("A0B3"), gg_unit_n00B_0266)
    else
    end
    if (Trig_Spellbringers_spells_Func006C()) then
        UnitAddAbilityBJ(FourCC("A0AZ"), gg_unit_n00B_0266)
    else
    end
    if (Trig_Spellbringers_spells_Func007C()) then
        UnitAddAbilityBJ(FourCC("A0FB"), gg_unit_n00B_0266)
    else
    end
    if (Trig_Spellbringers_spells_Func008C()) then
        UnitAddAbilityBJ(FourCC("A0B1"), gg_unit_n00B_0266)
    else
    end
    if (Trig_Spellbringers_spells_Func009C()) then
        UnitAddAbilityBJ(FourCC("A0AY"), gg_unit_n00B_0266)
    else
    end
    if (Trig_Spellbringers_spells_Func010C()) then
        UnitAddAbilityBJ(FourCC("A0B2"), gg_unit_n00B_0266)
    else
    end
    if (Trig_Spellbringers_spells_Func011C()) then
        UnitAddAbilityBJ(FourCC("A0AL"), gg_unit_n00B_0266)
    else
    end
end

-- Original JASS function: InitTrig_Spellbringers_spells (line 15678)
function InitTrig_Spellbringers_spells()
    gg_trg_Spellbringers_spells = CreateTrigger()
    TriggerRegisterUnitEvent(gg_trg_Spellbringers_spells, gg_unit_nmr2_0001, EVENT_UNIT_SELL)
    TriggerAddAction(gg_trg_Spellbringers_spells, Trig_Spellbringers_spells_Actions)
end
-- END FOREST SECTION 256

-- BEGIN FOREST SECTION 257 Give_orb
-- Original JASS function: Trig_Give_orb_Actions (line 15687)
function Trig_Give_orb_Actions()
    CreateItemLoc(FourCC("I000"), GetRectCenter(GetPlayableMapRect()))
    UnitAddItemSwapped(GetLastCreatedItem(), GetSoldUnit())
end

-- Original JASS function: InitTrig_Give_orb (line 15693)
function InitTrig_Give_orb()
    gg_trg_Give_orb = CreateTrigger()
    TriggerRegisterUnitEvent(gg_trg_Give_orb, gg_unit_nmr2_0001, EVENT_UNIT_SELL)
    TriggerAddAction(gg_trg_Give_orb, Trig_Give_orb_Actions)
end
-- END FOREST SECTION 257

-- BEGIN FOREST SECTION 261 RandomExpander
-- Original JASS function: Trig_RandomExpander_Actions (line 15782)
function Trig_RandomExpander_Actions()
    udg_Units[1] = FourCC("h03D")
    udg_Units[2] = FourCC("h016")
    udg_Units[3] = FourCC("h02L")
    udg_Units[4] = FourCC("h01X")
    udg_Units[5] = FourCC("h00F")
    udg_Units[6] = FourCC("h01K")
    udg_Units[7] = FourCC("h00R")
    udg_Units[8] = FourCC("h02U")
    udg_Units[9] = FourCC("o005")
    udg_Units[10] = FourCC("o000")
    udg_Units[11] = FourCC("h000")
    udg_Units[12] = FourCC("h03Q")
    udg_Units[13] = FourCC("o01E")
    udg_Units[14] = FourCC("u007")
    udg_Units[15] = FourCC("h010")
    udg_Units[16] = FourCC("h05C")
    udg_Units[17] = FourCC("n00M")
    udg_Units[18] = FourCC("o026")
end

-- Original JASS function: InitTrig_RandomExpander (line 15804)
function InitTrig_RandomExpander()
    gg_trg_RandomExpander = CreateTrigger()
    TriggerAddAction(gg_trg_RandomExpander, Trig_RandomExpander_Actions)
end
-- END FOREST SECTION 261

-- BEGIN FOREST SECTION 262 RandomExpander2
-- Original JASS function: Trig_RandomExpander2_Conditions (line 15812)
function Trig_RandomExpander2_Conditions()
    if ((not ((GetItemTypeId(GetManipulatedItem()) == FourCC("I00W"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_RandomExpander2_Actions (line 15819)
function Trig_RandomExpander2_Actions()
    udg_Point1 = GetUnitLoc(GetTriggerUnit())
    CreateNUnitsAtLocFacingLocBJ(1, udg_Units[GetRandomInt(1, 18)], GetOwningPlayer(GetTriggerUnit()), GetRectCenter(gg_rct_Tele_out_E), GetRectCenter(gg_rct_Tele_out_E))
    RemoveLocation(udg_Point1)
    RemoveItem(GetManipulatedItem())
    DisplayTextToForce(GetPlayersAll(), (__jconcat(GetPlayerName(GetTriggerPlayer()), " has randomed.")))
    SetPlayerName(GetOwningPlayer(GetTriggerUnit()), (__jconcat(GetUnitName(GetLastCreatedUnit()), (__jconcat(udg_PlayerColorHex[GetConvertedPlayerId(GetOwningPlayer(GetLastCreatedUnit()))], GetPlayerNameWithoutTag(GetOwningPlayer(GetLastCreatedUnit())))))))
    KillUnit(GetTriggerUnit())
end

-- Original JASS function: InitTrig_RandomExpander2 (line 15830)
function InitTrig_RandomExpander2()
    gg_trg_RandomExpander2 = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_RandomExpander2, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    TriggerAddCondition(gg_trg_RandomExpander2, Condition(Trig_RandomExpander2_Conditions))
    TriggerAddAction(gg_trg_RandomExpander2, Trig_RandomExpander2_Actions)
end
-- END FOREST SECTION 262

-- BEGIN FOREST SECTION 263 Random_Ancient
-- Original JASS function: Trig_Random_Ancient_Conditions (line 15841)
function Trig_Random_Ancient_Conditions()
    if ((not ((GetItemTypeId(GetManipulatedItem()) == FourCC("I00X"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Random_Ancient_Func041002 (line 15848)
function Trig_Random_Ancient_Func041002()
    RemoveUnit(GetEnumUnit())
end

-- Original JASS function: Trig_Random_Ancient_Func044C (line 15852)
function Trig_Random_Ancient_Func044C()
    if ((not ((GetUnitTypeId(GetLastCreatedUnit()) == FourCC("O01D"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Random_Ancient_Func045C (line 15859)
function Trig_Random_Ancient_Func045C()
    if ((not ((GetUnitTypeId(GetLastCreatedUnit()) == FourCC("O00A"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Random_Ancient_Func046C (line 15866)
function Trig_Random_Ancient_Func046C()
    if ((not ((GetUnitTypeId(GetLastCreatedUnit()) == FourCC("O00S"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Random_Ancient_Func047C (line 15873)
function Trig_Random_Ancient_Func047C()
    if ((not ((GetUnitTypeId(GetLastCreatedUnit()) == FourCC("O00L"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Random_Ancient_Func048C (line 15880)
function Trig_Random_Ancient_Func048C()
    if ((not ((GetUnitTypeId(GetLastCreatedUnit()) == FourCC("O004"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Random_Ancient_Func049C (line 15887)
function Trig_Random_Ancient_Func049C()
    if ((not ((GetUnitTypeId(GetLastCreatedUnit()) == FourCC("O008"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Random_Ancient_Func050C (line 15894)
function Trig_Random_Ancient_Func050C()
    if ((not ((GetUnitTypeId(GetLastCreatedUnit()) == FourCC("O01V"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Random_Ancient_Func051C (line 15901)
function Trig_Random_Ancient_Func051C()
    if ((not ((GetUnitTypeId(GetLastCreatedUnit()) == FourCC("O016"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Random_Ancient_Func052C (line 15908)
function Trig_Random_Ancient_Func052C()
    if ((not ((GetUnitTypeId(GetLastCreatedUnit()) == FourCC("O00D"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Random_Ancient_Func053C (line 15915)
function Trig_Random_Ancient_Func053C()
    if ((not ((GetUnitTypeId(GetLastCreatedUnit()) == FourCC("O01X"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Random_Ancient_Func054C (line 15922)
function Trig_Random_Ancient_Func054C()
    if ((not ((GetUnitTypeId(GetLastCreatedUnit()) == FourCC("O01Z"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Random_Ancient_Actions (line 15929)
function Trig_Random_Ancient_Actions()
    udg_Ancients[1] = FourCC("O004")
    udg_Ancients[2] = FourCC("O004")
    udg_Ancients[3] = FourCC("O004")
    udg_Ancients[4] = FourCC("O00A")
    udg_Ancients[5] = FourCC("O00A")
    udg_Ancients[6] = FourCC("O00A")
    udg_Ancients[7] = FourCC("O00S")
    udg_Ancients[8] = FourCC("O00S")
    udg_Ancients[9] = FourCC("O00S")
    udg_Ancients[10] = FourCC("O00L")
    udg_Ancients[11] = FourCC("O00L")
    udg_Ancients[12] = FourCC("O00L")
    udg_Ancients[13] = FourCC("O008")
    udg_Ancients[14] = FourCC("O008")
    udg_Ancients[15] = FourCC("O008")
    udg_Ancients[16] = FourCC("O00D")
    udg_Ancients[17] = FourCC("O00D")
    udg_Ancients[18] = FourCC("O00D")
    udg_Ancients[19] = FourCC("O016")
    udg_Ancients[20] = FourCC("O016")
    udg_Ancients[21] = FourCC("O016")
    udg_Ancients[22] = FourCC("O01D")
    udg_Ancients[23] = FourCC("O01D")
    udg_Ancients[24] = FourCC("O01D")
    udg_Ancients[25] = FourCC("O01V")
    udg_Ancients[26] = FourCC("O01V")
    udg_Ancients[27] = FourCC("O01V")
    udg_Ancients[28] = FourCC("O01Z")
    udg_Ancients[29] = FourCC("O01Z")
    udg_Ancients[30] = FourCC("O01Z")
    udg_Ancients[31] = FourCC("O01X")
    udg_Ancients[32] = FourCC("O01X")
    udg_Ancients[33] = FourCC("O01X")
    udg_Point1 = GetUnitLoc(GetTriggerUnit())
    CreateNUnitsAtLocFacingLocBJ(1, udg_Ancients[GetRandomInt(1, 33)], GetOwningPlayer(GetTriggerUnit()), GetRectCenter(gg_rct_Tele_out_D), GetRectCenter(gg_rct_Tele_out_E))
    udg_AncientUnit = GetLastCreatedUnit()
    RemoveLocation(udg_Point1)
    RemoveItem(GetManipulatedItem())
    DisplayTextToForce(GetPlayersAll(), (__jconcat(GetPlayerName(GetTriggerPlayer()), " has randomed.")))
    KillUnit(GetTriggerUnit())
    ForGroupBJ(GetUnitsInRectAll(gg_rct_SpawnDefender), Trig_Random_Ancient_Func041002)
    CreateItemLoc(FourCC("I000"), GetRectCenter(GetPlayableMapRect()))
    UnitAddItemSwapped(GetLastCreatedItem(), GetLastCreatedUnit())
    if (Trig_Random_Ancient_Func044C()) then
        UnitAddAbilityBJ(FourCC("A0EM"), gg_unit_n00B_0266)
    else
    end
    if (Trig_Random_Ancient_Func045C()) then
        UnitAddAbilityBJ(FourCC("A0EN"), gg_unit_n00B_0266)
    else
    end
    if (Trig_Random_Ancient_Func046C()) then
        UnitAddAbilityBJ(FourCC("A0B4"), gg_unit_n00B_0266)
    else
    end
    if (Trig_Random_Ancient_Func047C()) then
        UnitAddAbilityBJ(FourCC("A0B5"), gg_unit_n00B_0266)
    else
    end
    if (Trig_Random_Ancient_Func048C()) then
        UnitAddAbilityBJ(FourCC("A0B3"), gg_unit_n00B_0266)
    else
    end
    if (Trig_Random_Ancient_Func049C()) then
        UnitAddAbilityBJ(FourCC("A0AZ"), gg_unit_n00B_0266)
    else
    end
    if (Trig_Random_Ancient_Func050C()) then
        UnitAddAbilityBJ(FourCC("A0FB"), gg_unit_n00B_0266)
    else
    end
    if (Trig_Random_Ancient_Func051C()) then
        UnitAddAbilityBJ(FourCC("A0B1"), gg_unit_n00B_0266)
    else
    end
    if (Trig_Random_Ancient_Func052C()) then
        UnitAddAbilityBJ(FourCC("A0AY"), gg_unit_n00B_0266)
    else
    end
    if (Trig_Random_Ancient_Func053C()) then
        UnitAddAbilityBJ(FourCC("A0B2"), gg_unit_n00B_0266)
    else
    end
    if (Trig_Random_Ancient_Func054C()) then
        UnitAddAbilityBJ(FourCC("A0AL"), gg_unit_n00B_0266)
    else
    end
end

-- Original JASS function: InitTrig_Random_Ancient (line 16020)
function InitTrig_Random_Ancient()
    gg_trg_Random_Ancient = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Random_Ancient, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    TriggerAddCondition(gg_trg_Random_Ancient, Condition(Trig_Random_Ancient_Conditions))
    TriggerAddAction(gg_trg_Random_Ancient, Trig_Random_Ancient_Actions)
end
-- END FOREST SECTION 263

-- BEGIN FOREST SECTION 264 Remove_Selection
-- Original JASS function: Trig_Remove_Selection_Conditions (line 16030)
function Trig_Remove_Selection_Conditions()
    if ((not ((GetUnitTypeId(GetDyingUnit()) == FourCC("ewsp"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Remove_Selection_Actions (line 16037)
function Trig_Remove_Selection_Actions()
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_4611")
    RemoveUnit(gg_unit_nmr2_0001)
end

-- Original JASS function: InitTrig_Remove_Selection (line 16043)
function InitTrig_Remove_Selection()
    gg_trg_Remove_Selection = CreateTrigger()
    FE_Roles.registerAncientUnitEvent(gg_trg_Remove_Selection, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Remove_Selection, Condition(Trig_Remove_Selection_Conditions))
    TriggerAddAction(gg_trg_Remove_Selection, Trig_Remove_Selection_Actions)
end
-- END FOREST SECTION 264

-- BEGIN FOREST SECTION 265 Remove_Selector
-- Original JASS function: Trig_Remove_Selector_Conditions (line 16053)
function Trig_Remove_Selector_Conditions()
    local buyer = GetBuyingUnit()
    return buyer ~= nil and GetUnitTypeId(buyer) == udg_Selectors
end

-- Original JASS function: Trig_Remove_Selector_Actions (line 16060)
function Trig_Remove_Selector_Actions()
    KillUnit(GetBuyingUnit())
end

-- Original JASS function: InitTrig_Remove_Selector (line 16065)
function InitTrig_Remove_Selector()
    gg_trg_Remove_Selector = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Remove_Selector, EVENT_PLAYER_UNIT_SELL)
    TriggerAddCondition(gg_trg_Remove_Selector, Condition(Trig_Remove_Selector_Conditions))
    TriggerAddAction(gg_trg_Remove_Selector, Trig_Remove_Selector_Actions)
end
-- END FOREST SECTION 265

-- BEGIN FOREST SECTION 269 Spawn_Races
-- Original JASS function: Trig_Spawn_Races_Func001001 (line 16124)
function Trig_Spawn_Races_Func001001()
    do return ((udg_BannedWorgen == __jreal(0.00))) end
end

-- Original JASS function: Trig_Spawn_Races_Func002001 (line 16128)
function Trig_Spawn_Races_Func002001()
    do return ((udg_BannedForgotten == __jreal(0.00))) end
end

-- Original JASS function: Trig_Spawn_Races_Func003001 (line 16132)
function Trig_Spawn_Races_Func003001()
    do return ((udg_BannedAethyr == __jreal(0.00))) end
end

-- Original JASS function: Trig_Spawn_Races_Func004001 (line 16136)
function Trig_Spawn_Races_Func004001()
    do return ((udg_BannedGoblin == __jreal(0.00))) end
end

-- Original JASS function: Trig_Spawn_Races_Func005001 (line 16140)
function Trig_Spawn_Races_Func005001()
    do return ((udg_BannedOgre == __jreal(0.00))) end
end

-- Original JASS function: Trig_Spawn_Races_Func006001 (line 16144)
function Trig_Spawn_Races_Func006001()
    do return ((udg_BannedMagmide == __jreal(0.00))) end
end

-- Original JASS function: Trig_Spawn_Races_Func007001 (line 16148)
function Trig_Spawn_Races_Func007001()
    do return ((udg_BannedFurbolg == __jreal(0.00))) end
end

-- Original JASS function: Trig_Spawn_Races_Func008001 (line 16152)
function Trig_Spawn_Races_Func008001()
    do return ((udg_BannedRazormane == __jreal(0.00))) end
end

-- Original JASS function: Trig_Spawn_Races_Func009001 (line 16156)
function Trig_Spawn_Races_Func009001()
    do return ((udg_BannedCentaur == __jreal(0.00))) end
end

-- Original JASS function: Trig_Spawn_Races_Func010001 (line 16160)
function Trig_Spawn_Races_Func010001()
    do return ((udg_BannedWildkin == __jreal(0.00))) end
end

-- Original JASS function: Trig_Spawn_Races_Func011001 (line 16164)
function Trig_Spawn_Races_Func011001()
    do return ((udg_BannedNerubian == __jreal(0.00))) end
end

-- Original JASS function: Trig_Spawn_Races_Func012001 (line 16168)
function Trig_Spawn_Races_Func012001()
    do return ((udg_BannedHuman == __jreal(0.00))) end
end

-- Original JASS function: Trig_Spawn_Races_Func013001 (line 16172)
function Trig_Spawn_Races_Func013001()
    do return ((udg_BannedWisp == __jreal(0.00))) end
end

-- Original JASS function: Trig_Spawn_Races_Func014001 (line 16176)
function Trig_Spawn_Races_Func014001()
    do return ((udg_BannedKobold == __jreal(0.00))) end
end

-- Original JASS function: Trig_Spawn_Races_Func015001 (line 16180)
function Trig_Spawn_Races_Func015001()
    do return ((udg_BannedGhoul == __jreal(0.00))) end
end

-- Original JASS function: Trig_Spawn_Races_Func016001 (line 16184)
function Trig_Spawn_Races_Func016001()
    do return ((udg_BannedKraken == __jreal(0.00))) end
end

-- Original JASS function: Trig_Spawn_Races_Func017001 (line 16188)
function Trig_Spawn_Races_Func017001()
    do return ((udg_BannedElf == __jreal(0.00))) end
end

-- Original JASS function: Trig_Spawn_Races_Func018001 (line 16192)
function Trig_Spawn_Races_Func018001()
    do return ((udg_BannedHighElf == __jreal(0.00))) end
end

-- Original JASS function: Trig_Spawn_Races_Func019001 (line 16196)
function Trig_Spawn_Races_Func019001()
    do return ((udg_BannedRatling == __jreal(0.00))) end
end

-- Original JASS function: Trig_Spawn_Races_Func020001 (line 16200)
function Trig_Spawn_Races_Func020001()
    do return ((udg_BannedHunter == __jreal(0.00))) end
end

-- Original JASS function: Trig_Spawn_Races_Actions (line 16204)
function Trig_Spawn_Races_Actions()
    if (((udg_BannedWorgen == __jreal(0.00)))) then
        AddUnitToStockBJ(FourCC("h00R"), gg_unit_nmer_0000, 1, 1)
    else
        DoNothing()
    end
    if (((udg_BannedForgotten == __jreal(0.00)))) then
        AddUnitToStockBJ(FourCC("u007"), gg_unit_n00G_0035, 1, 1)
    else
        DoNothing()
    end
    if (((udg_BannedAethyr == __jreal(0.00)))) then
        AddUnitToStockBJ(FourCC("h03S"), gg_unit_n00G_0035, 1, 1)
    else
        DoNothing()
    end
    if (((udg_BannedGoblin == __jreal(0.00)))) then
        AddUnitToStockBJ(FourCC("h016"), gg_unit_n00G_0035, 1, 1)
    else
        DoNothing()
    end
    if (((udg_BannedOgre == __jreal(0.00)))) then
        AddUnitToStockBJ(FourCC("h00F"), gg_unit_n00G_0035, 1, 1)
    else
        DoNothing()
    end
    if (((udg_BannedMagmide == __jreal(0.00)))) then
        AddUnitToStockBJ(FourCC("o000"), gg_unit_n00G_0035, 1, 1)
    else
        DoNothing()
    end
    if (((udg_BannedFurbolg == __jreal(0.00)))) then
        AddUnitToStockBJ(FourCC("h02U"), gg_unit_n00G_0035, 1, 1)
    else
        DoNothing()
    end
    if (((udg_BannedRazormane == __jreal(0.00)))) then
        AddUnitToStockBJ(FourCC("o01E"), gg_unit_n00G_0035, 1, 1)
    else
        DoNothing()
    end
    if (((udg_BannedCentaur == __jreal(0.00)))) then
        AddUnitToStockBJ(FourCC("h01X"), gg_unit_nmer_0000, 1, 1)
    else
        DoNothing()
    end
    if (((udg_BannedWildkin == __jreal(0.00)))) then
        AddUnitToStockBJ(FourCC("h010"), gg_unit_nmer_0000, 1, 1)
    else
        DoNothing()
    end
    if (((udg_BannedNerubian == __jreal(0.00)))) then
        AddUnitToStockBJ(FourCC("h01K"), gg_unit_nmer_0000, 1, 1)
    else
        DoNothing()
    end
    if (((udg_BannedHuman == __jreal(0.00)))) then
        AddUnitToStockBJ(FourCC("h03D"), gg_unit_nmer_0000, 1, 1)
    else
        DoNothing()
    end
    if (((udg_BannedWisp == __jreal(0.00)))) then
        AddUnitToStockBJ(FourCC("h02L"), gg_unit_nmer_0000, 1, 1)
    else
        DoNothing()
    end
    if (((udg_BannedKobold == __jreal(0.00)))) then
        AddUnitToStockBJ(FourCC("h03Q"), gg_unit_nmer_0000, 1, 1)
    else
        DoNothing()
    end
    if (((udg_BannedGhoul == __jreal(0.00)))) then
        AddUnitToStockBJ(FourCC("o005"), gg_unit_nmer_0000, 1, 1)
    else
        DoNothing()
    end
    if (((udg_BannedKraken == __jreal(0.00)))) then
        AddUnitToStockBJ(FourCC("h000"), gg_unit_nmer_0000, 1, 1)
    else
        DoNothing()
    end
    if (((udg_BannedElf == __jreal(0.00)))) then
        AddUnitToStockBJ(FourCC("h05C"), gg_unit_n00G_0035, 1, 1)
    else
        DoNothing()
    end
    if (((udg_BannedHighElf == __jreal(0.00)))) then
        AddUnitToStockBJ(FourCC("n00M"), gg_unit_n00G_0035, 1, 1)
    else
        DoNothing()
    end
    if (((udg_BannedRatling == __jreal(0.00)))) then
        AddUnitToStockBJ(FourCC("o026"), gg_unit_nmer_0000, 1, 1)
    else
        DoNothing()
    end
    if (((udg_BannedHunter == __jreal(0.00)))) then
        AddUnitToStockBJ(FourCC("h05W"), gg_unit_n00G_0035, 1, 1)
    else
        DoNothing()
    end
end

-- Original JASS function: InitTrig_Spawn_Races (line 16308)
function InitTrig_Spawn_Races()
    gg_trg_Spawn_Races = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_Spawn_Races, __jreal(20.00))
    TriggerAddAction(gg_trg_Spawn_Races, Trig_Spawn_Races_Actions)
end
-- END FOREST SECTION 269

-- BEGIN FOREST SECTION 270 Spawn_Ancients
-- Original JASS function: Trig_Spawn_Ancients_Func001001 (line 16320)
function Trig_Spawn_Ancients_Func001001()
    do return ((udg_BannedAncientLight == __jreal(0.00))) end
end

-- Original JASS function: Trig_Spawn_Ancients_Func002001 (line 16324)
function Trig_Spawn_Ancients_Func002001()
    do return ((udg_BannedAncientLightning == __jreal(0.00))) end
end

-- Original JASS function: Trig_Spawn_Ancients_Func003001 (line 16328)
function Trig_Spawn_Ancients_Func003001()
    do return ((udg_BannedAncientDragon == __jreal(0.00))) end
end

-- Original JASS function: Trig_Spawn_Ancients_Func004001 (line 16332)
function Trig_Spawn_Ancients_Func004001()
    do return ((udg_BannedAncientEarth == __jreal(0.00))) end
end

-- Original JASS function: Trig_Spawn_Ancients_Func005001 (line 16336)
function Trig_Spawn_Ancients_Func005001()
    do return ((udg_BannedAncientDarkness == __jreal(0.00))) end
end

-- Original JASS function: Trig_Spawn_Ancients_Func006001 (line 16340)
function Trig_Spawn_Ancients_Func006001()
    do return ((udg_BannedAncientIce == __jreal(0.00))) end
end

-- Original JASS function: Trig_Spawn_Ancients_Func007001 (line 16344)
function Trig_Spawn_Ancients_Func007001()
    do return ((udg_BannedAncientFire == __jreal(0.00))) end
end

-- Original JASS function: Trig_Spawn_Ancients_Func008001 (line 16348)
function Trig_Spawn_Ancients_Func008001()
    do return ((udg_BannedAncientNature == __jreal(0.00))) end
end

-- Original JASS function: Trig_Spawn_Ancients_Func009001 (line 16352)
function Trig_Spawn_Ancients_Func009001()
    do return ((udg_BannedAncientSand == __jreal(0.00))) end
end

-- Original JASS function: Trig_Spawn_Ancients_Func010001 (line 16356)
function Trig_Spawn_Ancients_Func010001()
    do return ((udg_BannedAncientSpace == __jreal(0.00))) end
end

-- Original JASS function: Trig_Spawn_Ancients_Func011001 (line 16360)
function Trig_Spawn_Ancients_Func011001()
    do return ((udg_BannedAncientWind == __jreal(0.00))) end
end

-- Original JASS function: Trig_Spawn_Ancients_Actions (line 16365)
function Trig_Spawn_Ancients_Actions()
    if (((udg_BannedAncientLight == __jreal(0.00)))) then
        AddUnitToStockBJ(FourCC("O01V"), gg_unit_nmr2_0001, 0, 1)
    else
        DoNothing()
    end
    if (((udg_BannedAncientLightning == __jreal(0.00)))) then
        AddUnitToStockBJ(FourCC("O016"), gg_unit_nmr2_0001, 0, 1)
    else
        DoNothing()
    end
    if (((udg_BannedAncientDragon == __jreal(0.00)))) then
        AddUnitToStockBJ(FourCC("O00S"), gg_unit_nmr2_0001, 0, 1)
    else
        DoNothing()
    end
    if (((udg_BannedAncientEarth == __jreal(0.00)))) then
        AddUnitToStockBJ(FourCC("O00L"), gg_unit_nmr2_0001, 0, 1)
    else
        DoNothing()
    end
    if (((udg_BannedAncientDarkness == __jreal(0.00)))) then
        AddUnitToStockBJ(FourCC("O00A"), gg_unit_nmr2_0001, 0, 1)
    else
        DoNothing()
    end
    if (((udg_BannedAncientIce == __jreal(0.00)))) then
        AddUnitToStockBJ(FourCC("O008"), gg_unit_nmr2_0001, 0, 1)
    else
        DoNothing()
    end
    if (((udg_BannedAncientFire == __jreal(0.00)))) then
        AddUnitToStockBJ(FourCC("O004"), gg_unit_nmr2_0001, 0, 1)
    else
        DoNothing()
    end
    if (((udg_BannedAncientNature == __jreal(0.00)))) then
        AddUnitToStockBJ(FourCC("O00D"), gg_unit_nmr2_0001, 0, 1)
    else
        DoNothing()
    end
    if (((udg_BannedAncientSand == __jreal(0.00)))) then
        AddUnitToStockBJ(FourCC("O01X"), gg_unit_nmr2_0001, 0, 1)
    else
        DoNothing()
    end
    if (((udg_BannedAncientSpace == __jreal(0.00)))) then
        AddUnitToStockBJ(FourCC("O01Z"), gg_unit_nmr2_0001, 0, 1)
    else
        DoNothing()
    end
    if (((udg_BannedAncientWind == __jreal(0.00)))) then
        AddUnitToStockBJ(FourCC("O01D"), gg_unit_nmr2_0001, 0, 1)
    else
        DoNothing()
    end
end

-- Original JASS function: InitTrig_Spawn_Ancients (line 16424)
function InitTrig_Spawn_Ancients()
    gg_trg_Spawn_Ancients = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_Spawn_Ancients, __jreal(20.00))
    TriggerAddAction(gg_trg_Spawn_Ancients, Trig_Spawn_Ancients_Actions)
end
-- END FOREST SECTION 270

-- BEGIN FOREST SECTION 312 Warning_few_seconds
-- Original JASS function: Trig_Warning_few_seconds_Actions (line 17800)
function Trig_Warning_few_seconds_Actions()
    DisplayTextToForce(GetPlayersAllies(Player(0)), "TRIGSTR_3592")
end

-- Original JASS function: InitTrig_Warning_few_seconds (line 17805)
function InitTrig_Warning_few_seconds()
    gg_trg_Warning_few_seconds = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_Warning_few_seconds, __jreal(40.00))
    TriggerAddAction(gg_trg_Warning_few_seconds, Trig_Warning_few_seconds_Actions)
end
-- END FOREST SECTION 312

-- BEGIN FOREST SECTION 313 Camera_Copy
-- Original JASS function: Trig_Camera_Copy_Actions (line 17814)
function Trig_Camera_Copy_Actions()
    SetCameraBoundsToRectForPlayerBJ(GetOwningPlayer(GetTriggerUnit()), GetEntireMapRect())
    PanCameraToTimedLocForPlayer(GetOwningPlayer(GetTriggerUnit()), GetUnitLoc(GetTriggerUnit()), __jreal(0))
end

-- Original JASS function: InitTrig_Camera_Copy (line 17820)
function InitTrig_Camera_Copy()
    gg_trg_Camera_Copy = CreateTrigger()
    TriggerRegisterEnterRectSimple(gg_trg_Camera_Copy, gg_rct_Tele_out_D)
    TriggerRegisterEnterRectSimple(gg_trg_Camera_Copy, gg_rct_Tele_out_E)
    TriggerAddAction(gg_trg_Camera_Copy, Trig_Camera_Copy_Actions)
end
-- END FOREST SECTION 313

-- BEGIN FOREST SECTION 314 LatePickers
-- Original JASS function: IsUnitAncient (line 17836)
function IsUnitAncient(u)
    if IsUnitType(u, UNIT_TYPE_ANCIENT) then
        do return true end
    end
    do return false end
end

-- Original JASS function: GetRandomAlliedAncient (line 17844)
function GetRandomAlliedAncient(p)
    local g = CreateGroup()
    local ancientUnits = CreateGroup()
    local u = nil
    local result = nil
    local i = 0
    i = 0
    while true do
        if (i >= bj_MAX_PLAYER_SLOTS) then break end
        GroupEnumUnitsOfPlayer(g, Player(i), nil)
        if p ~= Player(i) and IsPlayerAlly(Player(i), p) then
            while true do
                u = FirstOfGroup(g)
                if (u == nil) then break end
                GroupRemoveUnit(g, u)
                if IsUnitAncient(u) and GetWidgetLife(u) > 0.405 and not IsUnitType(u, UNIT_TYPE_STRUCTURE) then
                    GroupAddUnit(ancientUnits, u)
                end
            end
        end
        i = __jint(i + 1)
    end
    if (CountUnitsInGroup(ancientUnits) > 0) then
        result = GroupPickRandomUnit(ancientUnits)
    end
    DestroyGroup(g)
    DestroyGroup(ancientUnits)
    g = nil
    ancientUnits = nil
    u = nil
    do return result end
end

-- Original JASS function: Trig_AncientTeleport_Actions (line 17889)
function Trig_AncientTeleport_Actions()
    local enteringUnit = GetTriggerUnit()
    local unitOwner = GetOwningPlayer(enteringUnit)
    local targetAncient = nil
    local oldX = __jreal(0.0)
    local oldY = __jreal(0.0)
    local newX = __jreal(0.0)
    local newY = __jreal(0.0)
    targetAncient = GetRandomAlliedAncient(unitOwner)
    if (targetAncient ~= nil) then
        oldX = GetUnitX(enteringUnit)
        oldY = GetUnitY(enteringUnit)
        newX = GetUnitX(targetAncient)
        newY = GetUnitY(targetAncient)
        SetUnitPosition(enteringUnit, newX, newY)
        DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Human\\MassTeleport\\MassTeleportTarget.mdl", oldX, oldY))
        DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Human\\MassTeleport\\MassTeleportTarget.mdl", newX, newY))
        DisplayTextToPlayer(unitOwner, __jreal(0), __jreal(0), "|cff00ff00Successfully teleported to allied expander!|r")
    end
    enteringUnit = nil
    unitOwner = nil
    targetAncient = nil
end

-- Original JASS function: EnableTeleportSystem (line 17926)
function EnableTeleportSystem()
    EnableTrigger(gg_trg_AncientTeleport)
    DestroyTimer(GetExpiredTimer())
    TeleportEnableTimer = nil
    DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS, __jreal(10.0), "|cff00ff00Late Pick Teleportation is now active!|r")
end

-- Original JASS function: InitTrig_LatePickers (line 17938)
function InitTrig_LatePickers()
    gg_trg_AncientTeleport = CreateTrigger()
    teleportRegion = CreateRegion()
    RegionAddRect(teleportRegion, gg_rct_Tele_out_E)
    TriggerRegisterEnterRegion(gg_trg_AncientTeleport, teleportRegion, nil)
    TriggerAddAction(gg_trg_AncientTeleport, Trig_AncientTeleport_Actions)
    DisableTrigger(gg_trg_AncientTeleport)
    TeleportEnableTimer = CreateTimer()
    TimerStart(TeleportEnableTimer, ENABLE_DELAY, false, EnableTeleportSystem)
    DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS, __jreal(10.0), "|cffffcc00Ancient will spawn in 60 seconds, don't take too much time to pick...|r")
end
-- END FOREST SECTION 314

-- BEGIN FOREST SECTION 315 AncientSpawnTele
-- Original JASS function: Trig_AncientSpawnTele_Actions (line 17965)
function Trig_AncientSpawnTele_Actions()
    SetUnitPositionLoc(GetTriggerUnit(), GetRectCenter(gg_rct_Spawn_all))
end

-- Original JASS function: InitTrig_AncientSpawnTele (line 17970)
function InitTrig_AncientSpawnTele()
    gg_trg_AncientSpawnTele = CreateTrigger()
    TriggerRegisterEnterRectSimple(gg_trg_AncientSpawnTele, gg_rct_Tele_out_D)
    TriggerRegisterEnterRectSimple(gg_trg_AncientSpawnTele, gg_rct_Tele_out_E)
    TriggerAddAction(gg_trg_AncientSpawnTele, Trig_AncientSpawnTele_Actions)
end
-- END FOREST SECTION 315
