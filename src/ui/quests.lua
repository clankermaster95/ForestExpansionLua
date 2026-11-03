-- ui / quests
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 311 Quests
function Trig_Quests_Actions()
    CreateQuestBJ(bj_QUESTTYPE_REQ_DISCOVERED, "TRIGSTR_973", "TRIGSTR_974", "ReplaceableTextures\\CommandButtons\\BTNSpellBookBLS.blp")
    CreateQuestBJ(bj_QUESTTYPE_REQ_DISCOVERED, "TRIGSTR_584", "TRIGSTR_653", "ReplaceableTextures\\CommandButtons\\BTNGarithos.blp")
    CreateQuestBJ(bj_QUESTTYPE_REQ_DISCOVERED, "TRIGSTR_5854", "TRIGSTR_5855", "ReplaceableTextures\\CommandButtons\\BTNSpellBookBLS.blp")
    CreateQuestBJ(bj_QUESTTYPE_REQ_DISCOVERED, "TRIGSTR_6309", "TRIGSTR_6310", "ReplaceableTextures\\CommandButtons\\BTNTomeBrown.blp")
    CreateQuestBJ(bj_QUESTTYPE_OPT_DISCOVERED, "TRIGSTR_812", "TRIGSTR_813", "ReplaceableTextures\\CommandButtons\\BTNFlakCannons.blp")
    CreateQuestBJ(bj_QUESTTYPE_OPT_DISCOVERED, "TRIGSTR_3707", "TRIGSTR_4488", "ReplaceableTextures\\CommandButtons\\BTNTemp.blp")
    CreateQuestBJ(bj_QUESTTYPE_OPT_DISCOVERED, "TRIGSTR_2160", "TRIGSTR_2162", "ReplaceableTextures\\CommandButtons\\BTNWispSplode.blp")
    CreateQuestBJ(bj_QUESTTYPE_OPT_DISCOVERED, "TRIGSTR_2142", "TRIGSTR_2143", "ReplaceableTextures\\CommandButtons\\BTNEngineeringUpgrade.blp")
    CreateQuestBJ(bj_QUESTTYPE_OPT_DISCOVERED, "TRIGSTR_5649", "TRIGSTR_6783", "ReplaceableTextures\\CommandButtons\\BTNChestOfGold.blp")
end

function InitTrig_Quests()
    gg_trg_Quests = CreateTrigger()
    TriggerAddAction(gg_trg_Quests, Trig_Quests_Actions)
end
-- END FOREST SECTION 311
