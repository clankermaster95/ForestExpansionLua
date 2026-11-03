-- game / bans / expanders
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 271 DisableExpanderBans
function Trig_DisableExpanderBans_Actions()
    FE_Factions.closeBans()
end

function InitTrig_DisableExpanderBans()
    gg_trg_DisableExpanderBans = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_DisableExpanderBans, __jreal(20.00))
    TriggerAddAction(gg_trg_DisableExpanderBans, Trig_DisableExpanderBans_Actions)
end
-- END FOREST SECTION 271

-- BEGIN FOREST SECTION 272 Worgen
function Trig_Worgen_Actions()
    FE_Factions.ban("Worgen")
end

function InitTrig_Worgen()
    FE_Factions.registerBan("Worgen", Trig_Worgen_Actions)
end
-- END FOREST SECTION 272

-- BEGIN FOREST SECTION 273 Centaur
function Trig_Centaur_Actions()
    FE_Factions.ban("Centaur")
end

function InitTrig_Centaur()
    FE_Factions.registerBan("Centaur", Trig_Centaur_Actions)
end
-- END FOREST SECTION 273

-- BEGIN FOREST SECTION 274 Wildkin
function Trig_Wildkin_Actions()
    FE_Factions.ban("Wildkin")
end

function InitTrig_Wildkin()
    FE_Factions.registerBan("Wildkin", Trig_Wildkin_Actions)
end
-- END FOREST SECTION 274

-- BEGIN FOREST SECTION 275 Nerubian
function Trig_Nerubian_Actions()
    FE_Factions.ban("Nerubian")
end

function InitTrig_Nerubian()
    FE_Factions.registerBan("Nerubian", Trig_Nerubian_Actions)
end
-- END FOREST SECTION 275

-- BEGIN FOREST SECTION 276 Human
function Trig_Human_Actions()
    FE_Factions.ban("Human")
end

function InitTrig_Human()
    FE_Factions.registerBan("Human", Trig_Human_Actions)
end
-- END FOREST SECTION 276

-- BEGIN FOREST SECTION 277 Wisp
function Trig_Wisp_Actions()
    FE_Factions.ban("Wisp")
end

function InitTrig_Wisp()
    FE_Factions.registerBan("Wisp", Trig_Wisp_Actions)
end
-- END FOREST SECTION 277

-- BEGIN FOREST SECTION 278 Kobold
function Trig_Kobold_Actions()
    FE_Factions.ban("Kobold")
end

function InitTrig_Kobold()
    FE_Factions.registerBan("Kobold", Trig_Kobold_Actions)
end
-- END FOREST SECTION 278

-- BEGIN FOREST SECTION 279 Ghoul
function Trig_Ghoul_Actions()
    FE_Factions.ban("Ghoul")
end

function InitTrig_Ghoul()
    FE_Factions.registerBan("Ghoul", Trig_Ghoul_Actions)
end
-- END FOREST SECTION 279

-- BEGIN FOREST SECTION 280 Kraken
function Trig_Kraken_Actions()
    FE_Factions.ban("Kraken")
end

function InitTrig_Kraken()
    FE_Factions.registerBan("Kraken", Trig_Kraken_Actions)
end
-- END FOREST SECTION 280

-- BEGIN FOREST SECTION 281 Aethyr
function Trig_Aethyr_Actions()
    FE_Factions.ban("Aethyr")
end

function InitTrig_Aethyr()
    FE_Factions.registerBan("Aethyr", Trig_Aethyr_Actions)
end
-- END FOREST SECTION 281

-- BEGIN FOREST SECTION 282 Forgotten
function Trig_Forgotten_Actions()
    FE_Factions.ban("Forgotten")
end

function InitTrig_Forgotten()
    FE_Factions.registerBan("Forgotten", Trig_Forgotten_Actions)
end
-- END FOREST SECTION 282

-- BEGIN FOREST SECTION 283 Goblin
function Trig_Goblin_Actions()
    FE_Factions.ban("Goblin")
end

function InitTrig_Goblin()
    FE_Factions.registerBan("Goblin", Trig_Goblin_Actions)
end
-- END FOREST SECTION 283

-- BEGIN FOREST SECTION 284 Ogre
function Trig_Ogre_Actions()
    FE_Factions.ban("Ogre")
end

function InitTrig_Ogre()
    FE_Factions.registerBan("Ogre", Trig_Ogre_Actions)
end
-- END FOREST SECTION 284

-- BEGIN FOREST SECTION 285 Magmide
function Trig_Magmide_Actions()
    FE_Factions.ban("Magmide")
end

function InitTrig_Magmide()
    FE_Factions.registerBan("Magmide", Trig_Magmide_Actions)
end
-- END FOREST SECTION 285

-- BEGIN FOREST SECTION 286 Furbolg
function Trig_Furbolg_Actions()
    FE_Factions.ban("Furbolg")
end

function InitTrig_Furbolg()
    FE_Factions.registerBan("Furbolg", Trig_Furbolg_Actions)
end
-- END FOREST SECTION 286

-- BEGIN FOREST SECTION 287 Razormane
function Trig_Razormane_Actions()
    FE_Factions.ban("Razormane")
end

function InitTrig_Razormane()
    FE_Factions.registerBan("Razormane", Trig_Razormane_Actions)
end
-- END FOREST SECTION 287

-- BEGIN FOREST SECTION 288 Elf
function Trig_Elf_Actions()
    FE_Factions.ban("Elf")
end

function InitTrig_Elf()
    FE_Factions.registerBan("Elf", Trig_Elf_Actions)
end
-- END FOREST SECTION 288

-- BEGIN FOREST SECTION 289 HighElf
function Trig_HighElf_Actions()
    FE_Factions.ban("HighElf")
end

function InitTrig_HighElf()
    FE_Factions.registerBan("HighElf", Trig_HighElf_Actions)
end
-- END FOREST SECTION 289

-- BEGIN FOREST SECTION 290 Ratling
function Trig_Ratling_Actions()
    FE_Factions.ban("Ratling")
end

function InitTrig_Ratling()
    FE_Factions.registerBan("Ratling", Trig_Ratling_Actions)
end
-- END FOREST SECTION 290

-- BEGIN FOREST SECTION 291 Hunter
function Trig_Hunter_Actions()
    FE_Factions.ban("Hunter")
end

function InitTrig_Hunter()
    FE_Factions.registerBan("Hunter", Trig_Hunter_Actions)
end
-- END FOREST SECTION 291
