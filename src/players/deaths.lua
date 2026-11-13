-- players / deaths
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 323 Human_Dies
-- Resolve sound handles when the event runs, after editor sounds exist.
local deathSounds = {
    ["h03D"] = "gg_snd_PeasantDeath",
    ["h02L"] = "gg_snd_WispPissed1",
    ["h01X"] = "gg_snd_CentaurDeath",
    ["h00F"] = "gg_snd_OgreDeath1",
    ["h00R"] = "gg_snd_SatyrDeath1",
    ["h05C"] = "gg_snd_HeroDemonHunterDeath1",
    ["h05E"] = "gg_snd_DemonHunterDeathAlternate1",
    ["h05D"] = "gg_snd_DruidOfTheTalonDeath1",
    ["n00M"] = "gg_snd_PeasantDeath",
    ["h05W"] = "gg_snd_RiflemanDeath",
    ["o005"] = "gg_snd_GhoulDeath",
    ["o000"] = "gg_snd_HeroFirelordDeath1",
    ["h016"] = "gg_snd_TinkerDeathAlt1",
    ["o026"] = "gg_snd_DuneWormDeath1",
    ["n008"] = "gg_snd_TinkerDeathAlt1",
    ["h02Y"] = "gg_snd_FurbolgDeath1",
    ["h02Z"] = "gg_snd_FurbolgDeath1",
    ["h02U"] = "gg_snd_FurbolgDeath1",
    ["h01K"] = "gg_snd_PitFiendDeath1",
    ["h000"] = "gg_snd_HydraDeath1",
    ["h03S"] = "gg_snd_WarlockDeath1",
    ["h03Q"] = "gg_snd_KoboldDeath",
    ["o01E"] = "gg_snd_QuillboarDeath",
    ["h010"] = "gg_snd_WendigoDeath",
    ["u007"] = "gg_snd_FacelessDeath1",
    ["u009"] = "gg_snd_FacelessDeath1",
    ["u00B"] = "gg_snd_FacelessDeath1",
    ["u00A"] = "gg_snd_FacelessDeath1",
}

local function PlayRaceDeathSound(rawcode)
    PlaySoundBJ(_G[deathSounds[rawcode]])
end

function Trig_Human_Dies_Conditions()
    return GetUnitTypeId(GetTriggerUnit()) == FourCC("h03D")
end

function Trig_Human_Dies_Func001C()
    local units = GetUnitsInRectOfPlayer(GetPlayableMapRect(), GetOwningPlayer(GetDyingUnit()))
    local present = IsUnitInGroup(udg_HumanFlag, units) == true
    DestroyGroup(units)
    return present
end

function Trig_Human_Dies_Actions()
    Trig_Human_Dies_Func001C()
    PlayRaceDeathSound("h03D")
end

function InitTrig_Human_Dies()
    gg_trg_Human_Dies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Human_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Human_Dies, Condition(Trig_Human_Dies_Conditions))
    TriggerAddAction(gg_trg_Human_Dies, Trig_Human_Dies_Actions)
end
-- END FOREST SECTION 323

-- BEGIN FOREST SECTION 324 Wisp_Dies
function Trig_Wisp_Dies_Conditions()
    return GetUnitTypeId(GetTriggerUnit()) == FourCC("h02L")
end

function Trig_Wisp_Dies_Func001C()
    local units = GetUnitsInRectOfPlayer(GetPlayableMapRect(), GetOwningPlayer(GetDyingUnit()))
    local present = IsUnitInGroup(udg_WispFlag, units) == true
    DestroyGroup(units)
    return present
end

function Trig_Wisp_Dies_Actions()
    Trig_Wisp_Dies_Func001C()
    PlayRaceDeathSound("h02L")
end

function InitTrig_Wisp_Dies()
    gg_trg_Wisp_Dies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Wisp_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Wisp_Dies, Condition(Trig_Wisp_Dies_Conditions))
    TriggerAddAction(gg_trg_Wisp_Dies, Trig_Wisp_Dies_Actions)
end
-- END FOREST SECTION 324

-- BEGIN FOREST SECTION 325 Centaur_Dies
function Trig_Centaur_Dies_Conditions()
    return GetUnitTypeId(GetTriggerUnit()) == FourCC("h01X")
end

function Trig_Centaur_Dies_Func001C()
    local units = GetUnitsInRectOfPlayer(GetPlayableMapRect(), GetOwningPlayer(GetDyingUnit()))
    local present = IsUnitInGroup(udg_CentaurFlag, units) == true
    DestroyGroup(units)
    return present
end

function Trig_Centaur_Dies_Actions()
    Trig_Centaur_Dies_Func001C()
    PlayRaceDeathSound("h01X")
end

function InitTrig_Centaur_Dies()
    gg_trg_Centaur_Dies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Centaur_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Centaur_Dies, Condition(Trig_Centaur_Dies_Conditions))
    TriggerAddAction(gg_trg_Centaur_Dies, Trig_Centaur_Dies_Actions)
end
-- END FOREST SECTION 325

-- BEGIN FOREST SECTION 326 Ogre_Dies
function Trig_Ogre_Dies_Conditions()
    return GetUnitTypeId(GetTriggerUnit()) == FourCC("h00F")
end

function Trig_Ogre_Dies_Func001C()
    local units = GetUnitsInRectOfPlayer(GetPlayableMapRect(), GetOwningPlayer(GetDyingUnit()))
    local present = IsUnitInGroup(udg_OgreFlag, units) == true
    DestroyGroup(units)
    return present
end

function Trig_Ogre_Dies_Actions()
    Trig_Ogre_Dies_Func001C()
    PlayRaceDeathSound("h00F")
end

function InitTrig_Ogre_Dies()
    gg_trg_Ogre_Dies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Ogre_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Ogre_Dies, Condition(Trig_Ogre_Dies_Conditions))
    TriggerAddAction(gg_trg_Ogre_Dies, Trig_Ogre_Dies_Actions)
end
-- END FOREST SECTION 326

-- BEGIN FOREST SECTION 327 Worgen_Dies
function Trig_Worgen_Dies_Conditions()
    return GetUnitTypeId(GetTriggerUnit()) == FourCC("h00R")
end

function Trig_Worgen_Dies_Actions()
    PlayRaceDeathSound("h00R")
end

function InitTrig_Worgen_Dies()
    gg_trg_Worgen_Dies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Worgen_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Worgen_Dies, Condition(Trig_Worgen_Dies_Conditions))
    TriggerAddAction(gg_trg_Worgen_Dies, Trig_Worgen_Dies_Actions)
end
-- END FOREST SECTION 327

-- BEGIN FOREST SECTION 328 Night_Elf_Dies
function Trig_Night_Elf_Dies_Conditions()
    return GetUnitTypeId(GetTriggerUnit()) == FourCC("h05C")
end

function Trig_Night_Elf_Dies_Actions()
    PlayRaceDeathSound("h05C")
end

function InitTrig_Night_Elf_Dies()
    gg_trg_Night_Elf_Dies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Night_Elf_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Night_Elf_Dies, Condition(Trig_Night_Elf_Dies_Conditions))
    TriggerAddAction(gg_trg_Night_Elf_Dies, Trig_Night_Elf_Dies_Actions)
end
-- END FOREST SECTION 328

-- BEGIN FOREST SECTION 329 Shadow_Dancer_Dies
function Trig_Shadow_Dancer_Dies_Conditions()
    return GetUnitTypeId(GetTriggerUnit()) == FourCC("h05E")
end

function Trig_Shadow_Dancer_Dies_Actions()
    PlayRaceDeathSound("h05E")
end

function InitTrig_Shadow_Dancer_Dies()
    gg_trg_Shadow_Dancer_Dies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Shadow_Dancer_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Shadow_Dancer_Dies, Condition(Trig_Shadow_Dancer_Dies_Conditions))
    TriggerAddAction(gg_trg_Shadow_Dancer_Dies, Trig_Shadow_Dancer_Dies_Actions)
end
-- END FOREST SECTION 329

-- BEGIN FOREST SECTION 330 Archdruid_Dies
function Trig_Archdruid_Dies_Conditions()
    return GetUnitTypeId(GetTriggerUnit()) == FourCC("h05D")
end

function Trig_Archdruid_Dies_Actions()
    PlayRaceDeathSound("h05D")
end

function InitTrig_Archdruid_Dies()
    gg_trg_Archdruid_Dies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Archdruid_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Archdruid_Dies, Condition(Trig_Archdruid_Dies_Conditions))
    TriggerAddAction(gg_trg_Archdruid_Dies, Trig_Archdruid_Dies_Actions)
end
-- END FOREST SECTION 330

-- BEGIN FOREST SECTION 331 Engineer_Highelf_Dies
function Trig_Engineer_Highelf_Dies_Conditions()
    return GetUnitTypeId(GetTriggerUnit()) == FourCC("n00M")
end

function Trig_Engineer_Highelf_Dies_Actions()
    PlayRaceDeathSound("n00M")
end

function InitTrig_Engineer_Highelf_Dies()
    gg_trg_Engineer_Highelf_Dies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Engineer_Highelf_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Engineer_Highelf_Dies, Condition(Trig_Engineer_Highelf_Dies_Conditions))
    TriggerAddAction(gg_trg_Engineer_Highelf_Dies, Trig_Engineer_Highelf_Dies_Actions)
end
-- END FOREST SECTION 331

-- BEGIN FOREST SECTION 332 Bounty_Hunter_Dies
function Trig_Bounty_Hunter_Dies_Conditions()
    return GetUnitTypeId(GetTriggerUnit()) == FourCC("h05W")
end

function Trig_Bounty_Hunter_Dies_Actions()
    PlayRaceDeathSound("h05W")
end

function InitTrig_Bounty_Hunter_Dies()
    gg_trg_Bounty_Hunter_Dies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Bounty_Hunter_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Bounty_Hunter_Dies, Condition(Trig_Bounty_Hunter_Dies_Conditions))
    TriggerAddAction(gg_trg_Bounty_Hunter_Dies, Trig_Bounty_Hunter_Dies_Actions)
end
-- END FOREST SECTION 332

-- BEGIN FOREST SECTION 333 Ghoul_Dies
function Trig_Ghoul_Dies_Conditions()
    return GetUnitTypeId(GetTriggerUnit()) == FourCC("o005")
end

function Trig_Ghoul_Dies_Actions()
    PlayRaceDeathSound("o005")
end

function InitTrig_Ghoul_Dies()
    gg_trg_Ghoul_Dies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Ghoul_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Ghoul_Dies, Condition(Trig_Ghoul_Dies_Conditions))
    TriggerAddAction(gg_trg_Ghoul_Dies, Trig_Ghoul_Dies_Actions)
end
-- END FOREST SECTION 333

-- BEGIN FOREST SECTION 334 Magmide_Dies
function Trig_Magmide_Dies_Conditions()
    return GetUnitTypeId(GetTriggerUnit()) == FourCC("o000")
end

function Trig_Magmide_Dies_Actions()
    PlayRaceDeathSound("o000")
end

function InitTrig_Magmide_Dies()
    gg_trg_Magmide_Dies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Magmide_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Magmide_Dies, Condition(Trig_Magmide_Dies_Conditions))
    TriggerAddAction(gg_trg_Magmide_Dies, Trig_Magmide_Dies_Actions)
end
-- END FOREST SECTION 334

-- BEGIN FOREST SECTION 335 Goblin_Dies
function Trig_Goblin_Dies_Conditions()
    return GetUnitTypeId(GetTriggerUnit()) == FourCC("h016")
end

function Trig_Goblin_Dies_Actions()
    PlayRaceDeathSound("h016")
end

function InitTrig_Goblin_Dies()
    gg_trg_Goblin_Dies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Goblin_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Goblin_Dies, Condition(Trig_Goblin_Dies_Conditions))
    TriggerAddAction(gg_trg_Goblin_Dies, Trig_Goblin_Dies_Actions)
end
-- END FOREST SECTION 335

-- BEGIN FOREST SECTION 336 Ratling_Dies
function Trig_Ratling_Dies_Conditions()
    return GetUnitTypeId(GetTriggerUnit()) == FourCC("o026")
end

function Trig_Ratling_Dies_Actions()
    PlayRaceDeathSound("o026")
end

function InitTrig_Ratling_Dies()
    gg_trg_Ratling_Dies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Ratling_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Ratling_Dies, Condition(Trig_Ratling_Dies_Conditions))
    TriggerAddAction(gg_trg_Ratling_Dies, Trig_Ratling_Dies_Actions)
end
-- END FOREST SECTION 336

-- BEGIN FOREST SECTION 337 Goblin_Ultima_Dies
function Trig_Goblin_Ultima_Dies_Conditions()
    return GetUnitTypeId(GetTriggerUnit()) == FourCC("n008")
end

function Trig_Goblin_Ultima_Dies_Actions()
    PlayRaceDeathSound("n008")
end

function InitTrig_Goblin_Ultima_Dies()
    gg_trg_Goblin_Ultima_Dies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Goblin_Ultima_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Goblin_Ultima_Dies, Condition(Trig_Goblin_Ultima_Dies_Conditions))
    TriggerAddAction(gg_trg_Goblin_Ultima_Dies, Trig_Goblin_Ultima_Dies_Actions)
end
-- END FOREST SECTION 337

-- BEGIN FOREST SECTION 338 Furbolg_Shaman_Dies
function Trig_Furbolg_Shaman_Dies_Conditions()
    return GetUnitTypeId(GetTriggerUnit()) == FourCC("h02Y")
end

function Trig_Furbolg_Shaman_Dies_Actions()
    PlayRaceDeathSound("h02Y")
end

function InitTrig_Furbolg_Shaman_Dies()
    gg_trg_Furbolg_Shaman_Dies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Furbolg_Shaman_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Furbolg_Shaman_Dies, Condition(Trig_Furbolg_Shaman_Dies_Conditions))
    TriggerAddAction(gg_trg_Furbolg_Shaman_Dies, Trig_Furbolg_Shaman_Dies_Actions)
end
-- END FOREST SECTION 338

-- BEGIN FOREST SECTION 339 Furbolg_Warrior_Dies
function Trig_Furbolg_Warrior_Dies_Conditions()
    return GetUnitTypeId(GetTriggerUnit()) == FourCC("h02Z")
end

function Trig_Furbolg_Warrior_Dies_Actions()
    PlayRaceDeathSound("h02Z")
end

function InitTrig_Furbolg_Warrior_Dies()
    gg_trg_Furbolg_Warrior_Dies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Furbolg_Warrior_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Furbolg_Warrior_Dies, Condition(Trig_Furbolg_Warrior_Dies_Conditions))
    TriggerAddAction(gg_trg_Furbolg_Warrior_Dies, Trig_Furbolg_Warrior_Dies_Actions)
end
-- END FOREST SECTION 339

-- BEGIN FOREST SECTION 340 Furbolg_Dies
function Trig_Furbolg_Dies_Conditions()
    return GetUnitTypeId(GetTriggerUnit()) == FourCC("h02U")
end

function Trig_Furbolg_Dies_Actions()
    PlayRaceDeathSound("h02U")
end

function InitTrig_Furbolg_Dies()
    gg_trg_Furbolg_Dies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Furbolg_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Furbolg_Dies, Condition(Trig_Furbolg_Dies_Conditions))
    TriggerAddAction(gg_trg_Furbolg_Dies, Trig_Furbolg_Dies_Actions)
end
-- END FOREST SECTION 340

-- BEGIN FOREST SECTION 341 Nerubian_Dies
function Trig_Nerubian_Dies_Conditions()
    return GetUnitTypeId(GetTriggerUnit()) == FourCC("h01K")
end

function Trig_Nerubian_Dies_Actions()
    PlayRaceDeathSound("h01K")
end

function InitTrig_Nerubian_Dies()
    gg_trg_Nerubian_Dies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Nerubian_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Nerubian_Dies, Condition(Trig_Nerubian_Dies_Conditions))
    TriggerAddAction(gg_trg_Nerubian_Dies, Trig_Nerubian_Dies_Actions)
end
-- END FOREST SECTION 341

-- BEGIN FOREST SECTION 342 Kraken_Dies
function Trig_Kraken_Dies_Conditions()
    return GetUnitTypeId(GetTriggerUnit()) == FourCC("h000")
end

function Trig_Kraken_Dies_Func001C()
    local units = GetUnitsInRectOfPlayer(GetPlayableMapRect(), GetOwningPlayer(GetDyingUnit()))
    local present = IsUnitInGroup(udg_KrakenFlag, units) == true
    DestroyGroup(units)
    return present
end

function Trig_Kraken_Dies_Actions()
    Trig_Kraken_Dies_Func001C()
    PlayRaceDeathSound("h000")
end

function InitTrig_Kraken_Dies()
    gg_trg_Kraken_Dies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Kraken_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Kraken_Dies, Condition(Trig_Kraken_Dies_Conditions))
    TriggerAddAction(gg_trg_Kraken_Dies, Trig_Kraken_Dies_Actions)
end
-- END FOREST SECTION 342

-- BEGIN FOREST SECTION 343 Aethyr_Warp_Dies
function Trig_Aethyr_Warp_Dies_Conditions()
    return GetUnitTypeId(GetTriggerUnit()) == FourCC("h03S")
end

function Trig_Aethyr_Warp_Dies_Func001C()
    local units = GetUnitsInRectOfPlayer(GetPlayableMapRect(), GetOwningPlayer(GetDyingUnit()))
    local present = IsUnitInGroup(udg_AethyrFlag, units) == true
    DestroyGroup(units)
    return present
end

function Trig_Aethyr_Warp_Dies_Actions()
    Trig_Aethyr_Warp_Dies_Func001C()
    PlayRaceDeathSound("h03S")
end

function InitTrig_Aethyr_Warp_Dies()
    gg_trg_Aethyr_Warp_Dies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Aethyr_Warp_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Aethyr_Warp_Dies, Condition(Trig_Aethyr_Warp_Dies_Conditions))
    TriggerAddAction(gg_trg_Aethyr_Warp_Dies, Trig_Aethyr_Warp_Dies_Actions)
end
-- END FOREST SECTION 343

-- BEGIN FOREST SECTION 344 Kobold_Dies
function Trig_Kobold_Dies_Conditions()
    return GetUnitTypeId(GetTriggerUnit()) == FourCC("h03Q")
end

function Trig_Kobold_Dies_Actions()
    PlayRaceDeathSound("h03Q")
end

function InitTrig_Kobold_Dies()
    gg_trg_Kobold_Dies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Kobold_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Kobold_Dies, Condition(Trig_Kobold_Dies_Conditions))
    TriggerAddAction(gg_trg_Kobold_Dies, Trig_Kobold_Dies_Actions)
end
-- END FOREST SECTION 344

-- BEGIN FOREST SECTION 345 Razormane_Dies
function Trig_Razormane_Dies_Conditions()
    return GetUnitTypeId(GetTriggerUnit()) == FourCC("o01E")
end

function Trig_Razormane_Dies_Func001C()
    local units = GetUnitsInRectOfPlayer(GetPlayableMapRect(), GetOwningPlayer(GetDyingUnit()))
    local present = IsUnitInGroup(udg_RazormaneFlag, units) == true
    DestroyGroup(units)
    return present
end

function Trig_Razormane_Dies_Actions()
    Trig_Razormane_Dies_Func001C()
    PlayRaceDeathSound("o01E")
end

function InitTrig_Razormane_Dies()
    gg_trg_Razormane_Dies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Razormane_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Razormane_Dies, Condition(Trig_Razormane_Dies_Conditions))
    TriggerAddAction(gg_trg_Razormane_Dies, Trig_Razormane_Dies_Actions)
end
-- END FOREST SECTION 345

-- BEGIN FOREST SECTION 346 Wildkin_Dies
function Trig_Wildkin_Dies_Conditions()
    return GetUnitTypeId(GetTriggerUnit()) == FourCC("h010")
end

function Trig_Wildkin_Dies_Actions()
    PlayRaceDeathSound("h010")
end

function InitTrig_Wildkin_Dies()
    gg_trg_Wildkin_Dies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Wildkin_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Wildkin_Dies, Condition(Trig_Wildkin_Dies_Conditions))
    TriggerAddAction(gg_trg_Wildkin_Dies, Trig_Wildkin_Dies_Actions)
end
-- END FOREST SECTION 346

-- BEGIN FOREST SECTION 347 Forgotten_One_Dies
function Trig_Forgotten_One_Dies_Conditions()
    return GetUnitTypeId(GetTriggerUnit()) == FourCC("u007")
end

function Trig_Forgotten_One_Dies_Actions()
    PlayRaceDeathSound("u007")
end

function InitTrig_Forgotten_One_Dies()
    gg_trg_Forgotten_One_Dies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Forgotten_One_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Forgotten_One_Dies, Condition(Trig_Forgotten_One_Dies_Conditions))
    TriggerAddAction(gg_trg_Forgotten_One_Dies, Trig_Forgotten_One_Dies_Actions)
end
-- END FOREST SECTION 347

-- BEGIN FOREST SECTION 348 Forgotten_Bloodmage_Dies
function Trig_Forgotten_Bloodmage_Dies_Conditions()
    return GetUnitTypeId(GetTriggerUnit()) == FourCC("u009")
end

function Trig_Forgotten_Bloodmage_Dies_Actions()
    PlayRaceDeathSound("u009")
end

function InitTrig_Forgotten_Bloodmage_Dies()
    gg_trg_Forgotten_Bloodmage_Dies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Forgotten_Bloodmage_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Forgotten_Bloodmage_Dies, Condition(Trig_Forgotten_Bloodmage_Dies_Conditions))
    TriggerAddAction(gg_trg_Forgotten_Bloodmage_Dies, Trig_Forgotten_Bloodmage_Dies_Actions)
end
-- END FOREST SECTION 348

-- BEGIN FOREST SECTION 349 Forgotten_Executioner_Dies
function Trig_Forgotten_Executioner_Dies_Conditions()
    return GetUnitTypeId(GetTriggerUnit()) == FourCC("u00B")
end

function Trig_Forgotten_Executioner_Dies_Actions()
    PlayRaceDeathSound("u00B")
end

function InitTrig_Forgotten_Executioner_Dies()
    gg_trg_Forgotten_Executioner_Dies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Forgotten_Executioner_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Forgotten_Executioner_Dies, Condition(Trig_Forgotten_Executioner_Dies_Conditions))
    TriggerAddAction(gg_trg_Forgotten_Executioner_Dies, Trig_Forgotten_Executioner_Dies_Actions)
end
-- END FOREST SECTION 349

-- BEGIN FOREST SECTION 350 Forgotten_Soulreaper_Dies
function Trig_Forgotten_Soulreaper_Dies_Conditions()
    return GetUnitTypeId(GetTriggerUnit()) == FourCC("u00A")
end

function Trig_Forgotten_Soulreaper_Dies_Actions()
    PlayRaceDeathSound("u00A")
end

function InitTrig_Forgotten_Soulreaper_Dies()
    gg_trg_Forgotten_Soulreaper_Dies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Forgotten_Soulreaper_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Forgotten_Soulreaper_Dies, Condition(Trig_Forgotten_Soulreaper_Dies_Conditions))
    TriggerAddAction(gg_trg_Forgotten_Soulreaper_Dies, Trig_Forgotten_Soulreaper_Dies_Actions)
end
-- END FOREST SECTION 350
