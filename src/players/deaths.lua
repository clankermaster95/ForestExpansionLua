-- players / deaths
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 323 Human_Dies
-- Original JASS function: Trig_Human_Dies_Conditions (line 18560)
function Trig_Human_Dies_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("h03D"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Human_Dies_Func001C (line 18567)
function Trig_Human_Dies_Func001C()
    if ((not ((IsUnitInGroup(udg_HumanFlag, GetUnitsInRectOfPlayer(GetPlayableMapRect(), GetOwningPlayer(GetDyingUnit()))) == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Human_Dies_Func003C (line 18574)
function Trig_Human_Dies_Func003C()
    do return true end
end

-- Original JASS function: Trig_Human_Dies_Actions (line 18578)
function Trig_Human_Dies_Actions()
    if (Trig_Human_Dies_Func001C()) then
    else
    end
    if ((true)) then
        PlaySoundBJ(gg_snd_PeasantDeath)
    else
    end
end

-- Original JASS function: InitTrig_Human_Dies (line 18589)
function InitTrig_Human_Dies()
    gg_trg_Human_Dies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Human_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Human_Dies, Condition(Trig_Human_Dies_Conditions))
    TriggerAddAction(gg_trg_Human_Dies, Trig_Human_Dies_Actions)
end
-- END FOREST SECTION 323

-- BEGIN FOREST SECTION 324 Wisp_Dies
-- Original JASS function: Trig_Wisp_Dies_Conditions (line 18599)
function Trig_Wisp_Dies_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("h02L"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Wisp_Dies_Func001C (line 18606)
function Trig_Wisp_Dies_Func001C()
    if ((not ((IsUnitInGroup(udg_WispFlag, GetUnitsInRectOfPlayer(GetPlayableMapRect(), GetOwningPlayer(GetDyingUnit()))) == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Wisp_Dies_Func003C (line 18613)
function Trig_Wisp_Dies_Func003C()
    do return true end
end

-- Original JASS function: Trig_Wisp_Dies_Actions (line 18617)
function Trig_Wisp_Dies_Actions()
    if (Trig_Wisp_Dies_Func001C()) then
    else
    end
    if ((true)) then
        PlaySoundBJ(gg_snd_WispPissed1)
    else
    end
end

-- Original JASS function: InitTrig_Wisp_Dies (line 18628)
function InitTrig_Wisp_Dies()
    gg_trg_Wisp_Dies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Wisp_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Wisp_Dies, Condition(Trig_Wisp_Dies_Conditions))
    TriggerAddAction(gg_trg_Wisp_Dies, Trig_Wisp_Dies_Actions)
end
-- END FOREST SECTION 324

-- BEGIN FOREST SECTION 325 Centaur_Dies
-- Original JASS function: Trig_Centaur_Dies_Conditions (line 18638)
function Trig_Centaur_Dies_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("h01X"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Centaur_Dies_Func001C (line 18645)
function Trig_Centaur_Dies_Func001C()
    if ((not ((IsUnitInGroup(udg_CentaurFlag, GetUnitsInRectOfPlayer(GetPlayableMapRect(), GetOwningPlayer(GetDyingUnit()))) == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Centaur_Dies_Func003C (line 18652)
function Trig_Centaur_Dies_Func003C()
    do return true end
end

-- Original JASS function: Trig_Centaur_Dies_Actions (line 18656)
function Trig_Centaur_Dies_Actions()
    if (Trig_Centaur_Dies_Func001C()) then
    else
    end
    if ((true)) then
        PlaySoundBJ(gg_snd_CentaurDeath)
    else
    end
end

-- Original JASS function: InitTrig_Centaur_Dies (line 18667)
function InitTrig_Centaur_Dies()
    gg_trg_Centaur_Dies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Centaur_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Centaur_Dies, Condition(Trig_Centaur_Dies_Conditions))
    TriggerAddAction(gg_trg_Centaur_Dies, Trig_Centaur_Dies_Actions)
end
-- END FOREST SECTION 325

-- BEGIN FOREST SECTION 326 Ogre_Dies
-- Original JASS function: Trig_Ogre_Dies_Conditions (line 18677)
function Trig_Ogre_Dies_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("h00F"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Ogre_Dies_Func001C (line 18684)
function Trig_Ogre_Dies_Func001C()
    if ((not ((IsUnitInGroup(udg_OgreFlag, GetUnitsInRectOfPlayer(GetPlayableMapRect(), GetOwningPlayer(GetDyingUnit()))) == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Ogre_Dies_Func003C (line 18691)
function Trig_Ogre_Dies_Func003C()
    do return true end
end

-- Original JASS function: Trig_Ogre_Dies_Actions (line 18695)
function Trig_Ogre_Dies_Actions()
    if (Trig_Ogre_Dies_Func001C()) then
    else
    end
    if ((true)) then
        PlaySoundBJ(gg_snd_OgreDeath1)
    else
    end
end

-- Original JASS function: InitTrig_Ogre_Dies (line 18706)
function InitTrig_Ogre_Dies()
    gg_trg_Ogre_Dies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Ogre_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Ogre_Dies, Condition(Trig_Ogre_Dies_Conditions))
    TriggerAddAction(gg_trg_Ogre_Dies, Trig_Ogre_Dies_Actions)
end
-- END FOREST SECTION 326

-- BEGIN FOREST SECTION 327 Worgen_Dies
-- Original JASS function: Trig_Worgen_Dies_Conditions (line 18716)
function Trig_Worgen_Dies_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("h00R"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Worgen_Dies_Func002C (line 18723)
function Trig_Worgen_Dies_Func002C()
    do return true end
end

-- Original JASS function: Trig_Worgen_Dies_Actions (line 18727)
function Trig_Worgen_Dies_Actions()
    if ((true)) then
        PlaySoundBJ(gg_snd_SatyrDeath1)
    else
    end
end

-- Original JASS function: InitTrig_Worgen_Dies (line 18735)
function InitTrig_Worgen_Dies()
    gg_trg_Worgen_Dies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Worgen_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Worgen_Dies, Condition(Trig_Worgen_Dies_Conditions))
    TriggerAddAction(gg_trg_Worgen_Dies, Trig_Worgen_Dies_Actions)
end
-- END FOREST SECTION 327

-- BEGIN FOREST SECTION 328 Night_Elf_Dies
-- Original JASS function: Trig_Night_Elf_Dies_Conditions (line 18745)
function Trig_Night_Elf_Dies_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("h05C"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Night_Elf_Dies_Func002C (line 18752)
function Trig_Night_Elf_Dies_Func002C()
    do return true end
end

-- Original JASS function: Trig_Night_Elf_Dies_Actions (line 18756)
function Trig_Night_Elf_Dies_Actions()
    if ((true)) then
        PlaySoundBJ(gg_snd_HeroDemonHunterDeath1)
    else
    end
end

-- Original JASS function: InitTrig_Night_Elf_Dies (line 18764)
function InitTrig_Night_Elf_Dies()
    gg_trg_Night_Elf_Dies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Night_Elf_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Night_Elf_Dies, Condition(Trig_Night_Elf_Dies_Conditions))
    TriggerAddAction(gg_trg_Night_Elf_Dies, Trig_Night_Elf_Dies_Actions)
end
-- END FOREST SECTION 328

-- BEGIN FOREST SECTION 329 Shadow_Dancer_Dies
-- Original JASS function: Trig_Shadow_Dancer_Dies_Conditions (line 18774)
function Trig_Shadow_Dancer_Dies_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("h05E"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Shadow_Dancer_Dies_Func002C (line 18781)
function Trig_Shadow_Dancer_Dies_Func002C()
    do return true end
end

-- Original JASS function: Trig_Shadow_Dancer_Dies_Actions (line 18785)
function Trig_Shadow_Dancer_Dies_Actions()
    if ((true)) then
        PlaySoundBJ(gg_snd_DemonHunterDeathAlternate1)
    else
    end
end

-- Original JASS function: InitTrig_Shadow_Dancer_Dies (line 18793)
function InitTrig_Shadow_Dancer_Dies()
    gg_trg_Shadow_Dancer_Dies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Shadow_Dancer_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Shadow_Dancer_Dies, Condition(Trig_Shadow_Dancer_Dies_Conditions))
    TriggerAddAction(gg_trg_Shadow_Dancer_Dies, Trig_Shadow_Dancer_Dies_Actions)
end
-- END FOREST SECTION 329

-- BEGIN FOREST SECTION 330 Archdruid_Dies
-- Original JASS function: Trig_Archdruid_Dies_Conditions (line 18803)
function Trig_Archdruid_Dies_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("h05D"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Archdruid_Dies_Func002C (line 18810)
function Trig_Archdruid_Dies_Func002C()
    do return true end
end

-- Original JASS function: Trig_Archdruid_Dies_Actions (line 18814)
function Trig_Archdruid_Dies_Actions()
    if ((true)) then
        PlaySoundBJ(gg_snd_DruidOfTheTalonDeath1)
    else
    end
end

-- Original JASS function: InitTrig_Archdruid_Dies (line 18822)
function InitTrig_Archdruid_Dies()
    gg_trg_Archdruid_Dies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Archdruid_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Archdruid_Dies, Condition(Trig_Archdruid_Dies_Conditions))
    TriggerAddAction(gg_trg_Archdruid_Dies, Trig_Archdruid_Dies_Actions)
end
-- END FOREST SECTION 330

-- BEGIN FOREST SECTION 331 Engineer_Highelf_Dies
-- Original JASS function: Trig_Engineer_Highelf_Dies_Conditions (line 18832)
function Trig_Engineer_Highelf_Dies_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("n00M"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Engineer_Highelf_Dies_Func002C (line 18839)
function Trig_Engineer_Highelf_Dies_Func002C()
    do return true end
end

-- Original JASS function: Trig_Engineer_Highelf_Dies_Actions (line 18843)
function Trig_Engineer_Highelf_Dies_Actions()
    if ((true)) then
        PlaySoundBJ(gg_snd_PeasantDeath)
    else
    end
end

-- Original JASS function: InitTrig_Engineer_Highelf_Dies (line 18851)
function InitTrig_Engineer_Highelf_Dies()
    gg_trg_Engineer_Highelf_Dies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Engineer_Highelf_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Engineer_Highelf_Dies, Condition(Trig_Engineer_Highelf_Dies_Conditions))
    TriggerAddAction(gg_trg_Engineer_Highelf_Dies, Trig_Engineer_Highelf_Dies_Actions)
end
-- END FOREST SECTION 331

-- BEGIN FOREST SECTION 332 Bounty_Hunter_Dies
-- Original JASS function: Trig_Bounty_Hunter_Dies_Conditions (line 18861)
function Trig_Bounty_Hunter_Dies_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("h05W"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Bounty_Hunter_Dies_Func002C (line 18868)
function Trig_Bounty_Hunter_Dies_Func002C()
    do return true end
end

-- Original JASS function: Trig_Bounty_Hunter_Dies_Actions (line 18872)
function Trig_Bounty_Hunter_Dies_Actions()
    if ((true)) then
        PlaySoundBJ(gg_snd_RiflemanDeath)
    else
    end
end

-- Original JASS function: InitTrig_Bounty_Hunter_Dies (line 18880)
function InitTrig_Bounty_Hunter_Dies()
    gg_trg_Bounty_Hunter_Dies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Bounty_Hunter_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Bounty_Hunter_Dies, Condition(Trig_Bounty_Hunter_Dies_Conditions))
    TriggerAddAction(gg_trg_Bounty_Hunter_Dies, Trig_Bounty_Hunter_Dies_Actions)
end
-- END FOREST SECTION 332

-- BEGIN FOREST SECTION 333 Ghoul_Dies
-- Original JASS function: Trig_Ghoul_Dies_Conditions (line 18890)
function Trig_Ghoul_Dies_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("o005"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Ghoul_Dies_Actions (line 18897)
function Trig_Ghoul_Dies_Actions()
    PlaySoundBJ(gg_snd_GhoulDeath)
end

-- Original JASS function: InitTrig_Ghoul_Dies (line 18902)
function InitTrig_Ghoul_Dies()
    gg_trg_Ghoul_Dies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Ghoul_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Ghoul_Dies, Condition(Trig_Ghoul_Dies_Conditions))
    TriggerAddAction(gg_trg_Ghoul_Dies, Trig_Ghoul_Dies_Actions)
end
-- END FOREST SECTION 333

-- BEGIN FOREST SECTION 334 Magmide_Dies
-- Original JASS function: Trig_Magmide_Dies_Conditions (line 18912)
function Trig_Magmide_Dies_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("o000"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Magmide_Dies_Func002C (line 18919)
function Trig_Magmide_Dies_Func002C()
    do return true end
end

-- Original JASS function: Trig_Magmide_Dies_Actions (line 18923)
function Trig_Magmide_Dies_Actions()
    if ((true)) then
        PlaySoundBJ(gg_snd_HeroFirelordDeath1)
    else
    end
end

-- Original JASS function: InitTrig_Magmide_Dies (line 18931)
function InitTrig_Magmide_Dies()
    gg_trg_Magmide_Dies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Magmide_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Magmide_Dies, Condition(Trig_Magmide_Dies_Conditions))
    TriggerAddAction(gg_trg_Magmide_Dies, Trig_Magmide_Dies_Actions)
end
-- END FOREST SECTION 334

-- BEGIN FOREST SECTION 335 Goblin_Dies
-- Original JASS function: Trig_Goblin_Dies_Conditions (line 18941)
function Trig_Goblin_Dies_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("h016"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Goblin_Dies_Func002C (line 18948)
function Trig_Goblin_Dies_Func002C()
    do return true end
end

-- Original JASS function: Trig_Goblin_Dies_Actions (line 18952)
function Trig_Goblin_Dies_Actions()
    if ((true)) then
        PlaySoundBJ(gg_snd_TinkerDeathAlt1)
    else
    end
end

-- Original JASS function: InitTrig_Goblin_Dies (line 18960)
function InitTrig_Goblin_Dies()
    gg_trg_Goblin_Dies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Goblin_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Goblin_Dies, Condition(Trig_Goblin_Dies_Conditions))
    TriggerAddAction(gg_trg_Goblin_Dies, Trig_Goblin_Dies_Actions)
end
-- END FOREST SECTION 335

-- BEGIN FOREST SECTION 336 Ratling_Dies
-- Original JASS function: Trig_Ratling_Dies_Conditions (line 18970)
function Trig_Ratling_Dies_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("o026"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Ratling_Dies_Func002C (line 18977)
function Trig_Ratling_Dies_Func002C()
    do return true end
end

-- Original JASS function: Trig_Ratling_Dies_Actions (line 18981)
function Trig_Ratling_Dies_Actions()
    if ((true)) then
        PlaySoundBJ(gg_snd_DuneWormDeath1)
    else
    end
end

-- Original JASS function: InitTrig_Ratling_Dies (line 18989)
function InitTrig_Ratling_Dies()
    gg_trg_Ratling_Dies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Ratling_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Ratling_Dies, Condition(Trig_Ratling_Dies_Conditions))
    TriggerAddAction(gg_trg_Ratling_Dies, Trig_Ratling_Dies_Actions)
end
-- END FOREST SECTION 336

-- BEGIN FOREST SECTION 337 Goblin_Ultima_Dies
-- Original JASS function: Trig_Goblin_Ultima_Dies_Conditions (line 18999)
function Trig_Goblin_Ultima_Dies_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("n008"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Goblin_Ultima_Dies_Func002C (line 19006)
function Trig_Goblin_Ultima_Dies_Func002C()
    do return true end
end

-- Original JASS function: Trig_Goblin_Ultima_Dies_Actions (line 19010)
function Trig_Goblin_Ultima_Dies_Actions()
    if ((true)) then
        PlaySoundBJ(gg_snd_TinkerDeathAlt1)
    else
    end
end

-- Original JASS function: InitTrig_Goblin_Ultima_Dies (line 19018)
function InitTrig_Goblin_Ultima_Dies()
    gg_trg_Goblin_Ultima_Dies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Goblin_Ultima_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Goblin_Ultima_Dies, Condition(Trig_Goblin_Ultima_Dies_Conditions))
    TriggerAddAction(gg_trg_Goblin_Ultima_Dies, Trig_Goblin_Ultima_Dies_Actions)
end
-- END FOREST SECTION 337

-- BEGIN FOREST SECTION 338 Furbolg_Shaman_Dies
-- Original JASS function: Trig_Furbolg_Shaman_Dies_Conditions (line 19028)
function Trig_Furbolg_Shaman_Dies_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("h02Y"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Furbolg_Shaman_Dies_Func002C (line 19035)
function Trig_Furbolg_Shaman_Dies_Func002C()
    do return true end
end

-- Original JASS function: Trig_Furbolg_Shaman_Dies_Actions (line 19039)
function Trig_Furbolg_Shaman_Dies_Actions()
    if ((true)) then
        PlaySoundBJ(gg_snd_FurbolgDeath1)
    else
    end
end

-- Original JASS function: InitTrig_Furbolg_Shaman_Dies (line 19047)
function InitTrig_Furbolg_Shaman_Dies()
    gg_trg_Furbolg_Shaman_Dies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Furbolg_Shaman_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Furbolg_Shaman_Dies, Condition(Trig_Furbolg_Shaman_Dies_Conditions))
    TriggerAddAction(gg_trg_Furbolg_Shaman_Dies, Trig_Furbolg_Shaman_Dies_Actions)
end
-- END FOREST SECTION 338

-- BEGIN FOREST SECTION 339 Furbolg_Warrior_Dies
-- Original JASS function: Trig_Furbolg_Warrior_Dies_Conditions (line 19057)
function Trig_Furbolg_Warrior_Dies_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("h02Z"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Furbolg_Warrior_Dies_Func002C (line 19064)
function Trig_Furbolg_Warrior_Dies_Func002C()
    do return true end
end

-- Original JASS function: Trig_Furbolg_Warrior_Dies_Actions (line 19068)
function Trig_Furbolg_Warrior_Dies_Actions()
    if ((true)) then
        PlaySoundBJ(gg_snd_FurbolgDeath1)
    else
    end
end

-- Original JASS function: InitTrig_Furbolg_Warrior_Dies (line 19076)
function InitTrig_Furbolg_Warrior_Dies()
    gg_trg_Furbolg_Warrior_Dies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Furbolg_Warrior_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Furbolg_Warrior_Dies, Condition(Trig_Furbolg_Warrior_Dies_Conditions))
    TriggerAddAction(gg_trg_Furbolg_Warrior_Dies, Trig_Furbolg_Warrior_Dies_Actions)
end
-- END FOREST SECTION 339

-- BEGIN FOREST SECTION 340 Furbolg_Dies
-- Original JASS function: Trig_Furbolg_Dies_Conditions (line 19086)
function Trig_Furbolg_Dies_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("h02U"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Furbolg_Dies_Func002C (line 19093)
function Trig_Furbolg_Dies_Func002C()
    do return true end
end

-- Original JASS function: Trig_Furbolg_Dies_Actions (line 19097)
function Trig_Furbolg_Dies_Actions()
    if ((true)) then
        PlaySoundBJ(gg_snd_FurbolgDeath1)
    else
    end
end

-- Original JASS function: InitTrig_Furbolg_Dies (line 19105)
function InitTrig_Furbolg_Dies()
    gg_trg_Furbolg_Dies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Furbolg_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Furbolg_Dies, Condition(Trig_Furbolg_Dies_Conditions))
    TriggerAddAction(gg_trg_Furbolg_Dies, Trig_Furbolg_Dies_Actions)
end
-- END FOREST SECTION 340

-- BEGIN FOREST SECTION 341 Nerubian_Dies
-- Original JASS function: Trig_Nerubian_Dies_Conditions (line 19115)
function Trig_Nerubian_Dies_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("h01K"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Nerubian_Dies_Func002C (line 19122)
function Trig_Nerubian_Dies_Func002C()
    do return true end
end

-- Original JASS function: Trig_Nerubian_Dies_Actions (line 19126)
function Trig_Nerubian_Dies_Actions()
    if ((true)) then
        PlaySoundBJ(gg_snd_PitFiendDeath1)
    else
    end
end

-- Original JASS function: InitTrig_Nerubian_Dies (line 19134)
function InitTrig_Nerubian_Dies()
    gg_trg_Nerubian_Dies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Nerubian_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Nerubian_Dies, Condition(Trig_Nerubian_Dies_Conditions))
    TriggerAddAction(gg_trg_Nerubian_Dies, Trig_Nerubian_Dies_Actions)
end
-- END FOREST SECTION 341

-- BEGIN FOREST SECTION 342 Kraken_Dies
-- Original JASS function: Trig_Kraken_Dies_Conditions (line 19144)
function Trig_Kraken_Dies_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("h000"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Kraken_Dies_Func001C (line 19151)
function Trig_Kraken_Dies_Func001C()
    if ((not ((IsUnitInGroup(udg_KrakenFlag, GetUnitsInRectOfPlayer(GetPlayableMapRect(), GetOwningPlayer(GetDyingUnit()))) == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Kraken_Dies_Func003C (line 19158)
function Trig_Kraken_Dies_Func003C()
    do return true end
end

-- Original JASS function: Trig_Kraken_Dies_Actions (line 19162)
function Trig_Kraken_Dies_Actions()
    if (Trig_Kraken_Dies_Func001C()) then
    else
    end
    if ((true)) then
        PlaySoundBJ(gg_snd_HydraDeath1)
    else
    end
end

-- Original JASS function: InitTrig_Kraken_Dies (line 19173)
function InitTrig_Kraken_Dies()
    gg_trg_Kraken_Dies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Kraken_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Kraken_Dies, Condition(Trig_Kraken_Dies_Conditions))
    TriggerAddAction(gg_trg_Kraken_Dies, Trig_Kraken_Dies_Actions)
end
-- END FOREST SECTION 342

-- BEGIN FOREST SECTION 343 Aethyr_Warp_Dies
-- Original JASS function: Trig_Aethyr_Warp_Dies_Conditions (line 19183)
function Trig_Aethyr_Warp_Dies_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("h03S"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Aethyr_Warp_Dies_Func001C (line 19190)
function Trig_Aethyr_Warp_Dies_Func001C()
    if ((not ((IsUnitInGroup(udg_AethyrFlag, GetUnitsInRectOfPlayer(GetPlayableMapRect(), GetOwningPlayer(GetDyingUnit()))) == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Aethyr_Warp_Dies_Func003C (line 19197)
function Trig_Aethyr_Warp_Dies_Func003C()
    do return true end
end

-- Original JASS function: Trig_Aethyr_Warp_Dies_Actions (line 19201)
function Trig_Aethyr_Warp_Dies_Actions()
    if (Trig_Aethyr_Warp_Dies_Func001C()) then
    else
    end
    if ((true)) then
        PlaySoundBJ(gg_snd_WarlockDeath1)
    else
    end
end

-- Original JASS function: InitTrig_Aethyr_Warp_Dies (line 19212)
function InitTrig_Aethyr_Warp_Dies()
    gg_trg_Aethyr_Warp_Dies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Aethyr_Warp_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Aethyr_Warp_Dies, Condition(Trig_Aethyr_Warp_Dies_Conditions))
    TriggerAddAction(gg_trg_Aethyr_Warp_Dies, Trig_Aethyr_Warp_Dies_Actions)
end
-- END FOREST SECTION 343

-- BEGIN FOREST SECTION 344 Kobold_Dies
-- Original JASS function: Trig_Kobold_Dies_Conditions (line 19222)
function Trig_Kobold_Dies_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("h03Q"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Kobold_Dies_Func002C (line 19229)
function Trig_Kobold_Dies_Func002C()
    do return true end
end

-- Original JASS function: Trig_Kobold_Dies_Actions (line 19233)
function Trig_Kobold_Dies_Actions()
    if ((true)) then
        PlaySoundBJ(gg_snd_KoboldDeath)
    else
    end
end

-- Original JASS function: InitTrig_Kobold_Dies (line 19241)
function InitTrig_Kobold_Dies()
    gg_trg_Kobold_Dies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Kobold_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Kobold_Dies, Condition(Trig_Kobold_Dies_Conditions))
    TriggerAddAction(gg_trg_Kobold_Dies, Trig_Kobold_Dies_Actions)
end
-- END FOREST SECTION 344

-- BEGIN FOREST SECTION 345 Razormane_Dies
-- Original JASS function: Trig_Razormane_Dies_Conditions (line 19251)
function Trig_Razormane_Dies_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("o01E"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Razormane_Dies_Func001C (line 19258)
function Trig_Razormane_Dies_Func001C()
    if ((not ((IsUnitInGroup(udg_RazormaneFlag, GetUnitsInRectOfPlayer(GetPlayableMapRect(), GetOwningPlayer(GetDyingUnit()))) == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Razormane_Dies_Func003C (line 19265)
function Trig_Razormane_Dies_Func003C()
    do return true end
end

-- Original JASS function: Trig_Razormane_Dies_Actions (line 19269)
function Trig_Razormane_Dies_Actions()
    if (Trig_Razormane_Dies_Func001C()) then
    else
    end
    if ((true)) then
        PlaySoundBJ(gg_snd_QuillboarDeath)
    else
    end
end

-- Original JASS function: InitTrig_Razormane_Dies (line 19280)
function InitTrig_Razormane_Dies()
    gg_trg_Razormane_Dies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Razormane_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Razormane_Dies, Condition(Trig_Razormane_Dies_Conditions))
    TriggerAddAction(gg_trg_Razormane_Dies, Trig_Razormane_Dies_Actions)
end
-- END FOREST SECTION 345

-- BEGIN FOREST SECTION 346 Wildkin_Dies
-- Original JASS function: Trig_Wildkin_Dies_Conditions (line 19290)
function Trig_Wildkin_Dies_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("h010"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Wildkin_Dies_Func002C (line 19297)
function Trig_Wildkin_Dies_Func002C()
    do return true end
end

-- Original JASS function: Trig_Wildkin_Dies_Actions (line 19301)
function Trig_Wildkin_Dies_Actions()
    if ((true)) then
        PlaySoundBJ(gg_snd_WendigoDeath)
    else
    end
end

-- Original JASS function: InitTrig_Wildkin_Dies (line 19309)
function InitTrig_Wildkin_Dies()
    gg_trg_Wildkin_Dies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Wildkin_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Wildkin_Dies, Condition(Trig_Wildkin_Dies_Conditions))
    TriggerAddAction(gg_trg_Wildkin_Dies, Trig_Wildkin_Dies_Actions)
end
-- END FOREST SECTION 346

-- BEGIN FOREST SECTION 347 Forgotten_One_Dies
-- Original JASS function: Trig_Forgotten_One_Dies_Conditions (line 19319)
function Trig_Forgotten_One_Dies_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("u007"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Forgotten_One_Dies_Func002C (line 19326)
function Trig_Forgotten_One_Dies_Func002C()
    do return true end
end

-- Original JASS function: Trig_Forgotten_One_Dies_Actions (line 19330)
function Trig_Forgotten_One_Dies_Actions()
    if ((true)) then
        PlaySoundBJ(gg_snd_FacelessDeath1)
    else
    end
end

-- Original JASS function: InitTrig_Forgotten_One_Dies (line 19338)
function InitTrig_Forgotten_One_Dies()
    gg_trg_Forgotten_One_Dies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Forgotten_One_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Forgotten_One_Dies, Condition(Trig_Forgotten_One_Dies_Conditions))
    TriggerAddAction(gg_trg_Forgotten_One_Dies, Trig_Forgotten_One_Dies_Actions)
end
-- END FOREST SECTION 347

-- BEGIN FOREST SECTION 348 Forgotten_Bloodmage_Dies
-- Original JASS function: Trig_Forgotten_Bloodmage_Dies_Conditions (line 19348)
function Trig_Forgotten_Bloodmage_Dies_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("u009"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Forgotten_Bloodmage_Dies_Func002C (line 19355)
function Trig_Forgotten_Bloodmage_Dies_Func002C()
    do return true end
end

-- Original JASS function: Trig_Forgotten_Bloodmage_Dies_Actions (line 19359)
function Trig_Forgotten_Bloodmage_Dies_Actions()
    if ((true)) then
        PlaySoundBJ(gg_snd_FacelessDeath1)
    else
    end
end

-- Original JASS function: InitTrig_Forgotten_Bloodmage_Dies (line 19367)
function InitTrig_Forgotten_Bloodmage_Dies()
    gg_trg_Forgotten_Bloodmage_Dies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Forgotten_Bloodmage_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Forgotten_Bloodmage_Dies, Condition(Trig_Forgotten_Bloodmage_Dies_Conditions))
    TriggerAddAction(gg_trg_Forgotten_Bloodmage_Dies, Trig_Forgotten_Bloodmage_Dies_Actions)
end
-- END FOREST SECTION 348

-- BEGIN FOREST SECTION 349 Forgotten_Executioner_Dies
-- Original JASS function: Trig_Forgotten_Executioner_Dies_Conditions (line 19377)
function Trig_Forgotten_Executioner_Dies_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("u00B"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Forgotten_Executioner_Dies_Func002C (line 19384)
function Trig_Forgotten_Executioner_Dies_Func002C()
    do return true end
end

-- Original JASS function: Trig_Forgotten_Executioner_Dies_Actions (line 19388)
function Trig_Forgotten_Executioner_Dies_Actions()
    if ((true)) then
        PlaySoundBJ(gg_snd_FacelessDeath1)
    else
    end
end

-- Original JASS function: InitTrig_Forgotten_Executioner_Dies (line 19396)
function InitTrig_Forgotten_Executioner_Dies()
    gg_trg_Forgotten_Executioner_Dies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Forgotten_Executioner_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Forgotten_Executioner_Dies, Condition(Trig_Forgotten_Executioner_Dies_Conditions))
    TriggerAddAction(gg_trg_Forgotten_Executioner_Dies, Trig_Forgotten_Executioner_Dies_Actions)
end
-- END FOREST SECTION 349

-- BEGIN FOREST SECTION 350 Forgotten_Soulreaper_Dies
-- Original JASS function: Trig_Forgotten_Soulreaper_Dies_Conditions (line 19406)
function Trig_Forgotten_Soulreaper_Dies_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("u00A"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Forgotten_Soulreaper_Dies_Func002C (line 19413)
function Trig_Forgotten_Soulreaper_Dies_Func002C()
    do return true end
end

-- Original JASS function: Trig_Forgotten_Soulreaper_Dies_Actions (line 19417)
function Trig_Forgotten_Soulreaper_Dies_Actions()
    if ((true)) then
        PlaySoundBJ(gg_snd_FacelessDeath1)
    else
    end
end

-- Original JASS function: InitTrig_Forgotten_Soulreaper_Dies (line 19425)
function InitTrig_Forgotten_Soulreaper_Dies()
    gg_trg_Forgotten_Soulreaper_Dies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Forgotten_Soulreaper_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Forgotten_Soulreaper_Dies, Condition(Trig_Forgotten_Soulreaper_Dies_Conditions))
    TriggerAddAction(gg_trg_Forgotten_Soulreaper_Dies, Trig_Forgotten_Soulreaper_Dies_Actions)
end
-- END FOREST SECTION 350
