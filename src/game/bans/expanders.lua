-- game / bans / expanders
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 271 DisableExpanderBans
-- Original JASS function: Trig_DisableExpanderBans_Actions (line 16434)
function Trig_DisableExpanderBans_Actions()
    DisableTrigger(gg_trg_Worgen)
    DisableTrigger(gg_trg_Centaur)
    DisableTrigger(gg_trg_Wildkin)
    DisableTrigger(gg_trg_Nerubian)
    DisableTrigger(gg_trg_Human)
    DisableTrigger(gg_trg_Wisp)
    DisableTrigger(gg_trg_Kobold)
    DisableTrigger(gg_trg_Ghoul)
    DisableTrigger(gg_trg_Kraken)
    DisableTrigger(gg_trg_Aethyr)
    DisableTrigger(gg_trg_Forgotten)
    DisableTrigger(gg_trg_Goblin)
    DisableTrigger(gg_trg_Ogre)
    DisableTrigger(gg_trg_Magmide)
    DisableTrigger(gg_trg_Furbolg)
    DisableTrigger(gg_trg_Razormane)
    DisableTrigger(gg_trg_Elf)
    DisableTrigger(gg_trg_HighElf)
    DisplayTextToForce(GetPlayersAll(), "Factions can no longer be banned.")
end

-- Original JASS function: InitTrig_DisableExpanderBans (line 16458)
function InitTrig_DisableExpanderBans()
    gg_trg_DisableExpanderBans = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_DisableExpanderBans, __jreal(20.00))
    TriggerAddAction(gg_trg_DisableExpanderBans, Trig_DisableExpanderBans_Actions)
end
-- END FOREST SECTION 271

-- BEGIN FOREST SECTION 272 Worgen
-- Original JASS function: Trig_Worgen_Func001Func006001 (line 16468)
function Trig_Worgen_Func001Func006001()
    do return ((udg_Bans == 0)) end
end

-- Original JASS function: Trig_Worgen_Func001Func006002 (line 16472)
function Trig_Worgen_Func001Func006002()
    do return ((udg_BannedWorgen == __jreal(1.00))) end
end

-- Original JASS function: Trig_Worgen_Func001C (line 16476)
function Trig_Worgen_Func001C()
    if ((not GetBooleanOr(((udg_Bans == 0)), ((udg_BannedWorgen == __jreal(1.00)))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Worgen_Actions (line 16483)
function Trig_Worgen_Actions()
    if (Trig_Worgen_Func001C()) then
        DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        udg_Bans = (__jint(udg_Bans - 1))
        udg_BannedWorgen = __jreal(1.00)
        DisplayTextToForce(GetPlayersAll(), (__jconcat("Worgen banned. Bans remaining: ", I2S(udg_Bans))))
    end
end

-- Original JASS function: InitTrig_Worgen (line 16494)
function InitTrig_Worgen()
    gg_trg_Worgen = CreateTrigger()
    TriggerRegisterPlayerChatEvent(gg_trg_Worgen, Player(0), "-ban worgen", true)
    TriggerAddAction(gg_trg_Worgen, Trig_Worgen_Actions)
end
-- END FOREST SECTION 272

-- BEGIN FOREST SECTION 273 Centaur
-- Original JASS function: Trig_Centaur_Func001Func006001 (line 16504)
function Trig_Centaur_Func001Func006001()
    do return ((udg_Bans == 0)) end
end

-- Original JASS function: Trig_Centaur_Func001Func006002 (line 16508)
function Trig_Centaur_Func001Func006002()
    do return ((udg_BannedCentaur == __jreal(1.00))) end
end

-- Original JASS function: Trig_Centaur_Func001C (line 16512)
function Trig_Centaur_Func001C()
    if ((not GetBooleanOr(((udg_Bans == 0)), ((udg_BannedCentaur == __jreal(1.00)))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Centaur_Actions (line 16519)
function Trig_Centaur_Actions()
    if (Trig_Centaur_Func001C()) then
        DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        udg_Bans = (__jint(udg_Bans - 1))
        udg_BannedCentaur = __jreal(1.00)
        DisplayTextToForce(GetPlayersAll(), (__jconcat("Centaur banned. Bans remaining: ", I2S(udg_Bans))))
    end
end

-- Original JASS function: InitTrig_Centaur (line 16530)
function InitTrig_Centaur()
    gg_trg_Centaur = CreateTrigger()
    TriggerRegisterPlayerChatEvent(gg_trg_Centaur, Player(0), "-ban Centaur", true)
    TriggerAddAction(gg_trg_Centaur, Trig_Centaur_Actions)
end
-- END FOREST SECTION 273

-- BEGIN FOREST SECTION 274 Wildkin
-- Original JASS function: Trig_Wildkin_Func001Func006001 (line 16540)
function Trig_Wildkin_Func001Func006001()
    do return ((udg_Bans == 0)) end
end

-- Original JASS function: Trig_Wildkin_Func001Func006002 (line 16544)
function Trig_Wildkin_Func001Func006002()
    do return ((udg_BannedWildkin == __jreal(1.00))) end
end

-- Original JASS function: Trig_Wildkin_Func001C (line 16548)
function Trig_Wildkin_Func001C()
    if ((not GetBooleanOr(((udg_Bans == 0)), ((udg_BannedWildkin == __jreal(1.00)))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Wildkin_Actions (line 16555)
function Trig_Wildkin_Actions()
    if (Trig_Wildkin_Func001C()) then
        DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        udg_Bans = (__jint(udg_Bans - 1))
        udg_BannedWildkin = __jreal(1.00)
        DisplayTextToForce(GetPlayersAll(), (__jconcat("Wildkin banned. Bans remaining: ", I2S(udg_Bans))))
    end
end

-- Original JASS function: InitTrig_Wildkin (line 16566)
function InitTrig_Wildkin()
    gg_trg_Wildkin = CreateTrigger()
    TriggerRegisterPlayerChatEvent(gg_trg_Wildkin, Player(0), "-ban Wildkin", true)
    TriggerAddAction(gg_trg_Wildkin, Trig_Wildkin_Actions)
end
-- END FOREST SECTION 274

-- BEGIN FOREST SECTION 275 Nerubian
-- Original JASS function: Trig_Nerubian_Func001Func006001 (line 16576)
function Trig_Nerubian_Func001Func006001()
    do return ((udg_Bans == 0)) end
end

-- Original JASS function: Trig_Nerubian_Func001Func006002 (line 16580)
function Trig_Nerubian_Func001Func006002()
    do return ((udg_BannedNerubian == __jreal(1.00))) end
end

-- Original JASS function: Trig_Nerubian_Func001C (line 16584)
function Trig_Nerubian_Func001C()
    if ((not GetBooleanOr(((udg_Bans == 0)), ((udg_BannedNerubian == __jreal(1.00)))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Nerubian_Actions (line 16591)
function Trig_Nerubian_Actions()
    if (Trig_Nerubian_Func001C()) then
        DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        udg_Bans = (__jint(udg_Bans - 1))
        udg_BannedNerubian = __jreal(1.00)
        DisplayTextToForce(GetPlayersAll(), (__jconcat("Nerubian banned. Bans remaining: ", I2S(udg_Bans))))
    end
end

-- Original JASS function: InitTrig_Nerubian (line 16602)
function InitTrig_Nerubian()
    gg_trg_Nerubian = CreateTrigger()
    TriggerRegisterPlayerChatEvent(gg_trg_Nerubian, Player(0), "-ban Nerubian", true)
    TriggerAddAction(gg_trg_Nerubian, Trig_Nerubian_Actions)
end
-- END FOREST SECTION 275

-- BEGIN FOREST SECTION 276 Human
-- Original JASS function: Trig_Human_Func001Func006001 (line 16612)
function Trig_Human_Func001Func006001()
    do return ((udg_Bans == 0)) end
end

-- Original JASS function: Trig_Human_Func001Func006002 (line 16616)
function Trig_Human_Func001Func006002()
    do return ((udg_BannedHuman == __jreal(1.00))) end
end

-- Original JASS function: Trig_Human_Func001C (line 16620)
function Trig_Human_Func001C()
    if ((not GetBooleanOr(((udg_Bans == 0)), ((udg_BannedHuman == __jreal(1.00)))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Human_Actions (line 16627)
function Trig_Human_Actions()
    if (Trig_Human_Func001C()) then
        DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        udg_Bans = (__jint(udg_Bans - 1))
        udg_BannedHuman = __jreal(1.00)
        DisplayTextToForce(GetPlayersAll(), (__jconcat("Human banned. Bans remaining: ", I2S(udg_Bans))))
    end
end

-- Original JASS function: InitTrig_Human (line 16638)
function InitTrig_Human()
    gg_trg_Human = CreateTrigger()
    TriggerRegisterPlayerChatEvent(gg_trg_Human, Player(0), "-ban Human", true)
    TriggerAddAction(gg_trg_Human, Trig_Human_Actions)
end
-- END FOREST SECTION 276

-- BEGIN FOREST SECTION 277 Wisp
-- Original JASS function: Trig_Wisp_Func001Func006001 (line 16648)
function Trig_Wisp_Func001Func006001()
    do return ((udg_Bans == 0)) end
end

-- Original JASS function: Trig_Wisp_Func001Func006002 (line 16652)
function Trig_Wisp_Func001Func006002()
    do return ((udg_BannedWisp == __jreal(1.00))) end
end

-- Original JASS function: Trig_Wisp_Func001C (line 16656)
function Trig_Wisp_Func001C()
    if ((not GetBooleanOr(((udg_Bans == 0)), ((udg_BannedWisp == __jreal(1.00)))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Wisp_Actions (line 16663)
function Trig_Wisp_Actions()
    if (Trig_Wisp_Func001C()) then
        DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        udg_Bans = (__jint(udg_Bans - 1))
        udg_BannedWisp = __jreal(1.00)
        DisplayTextToForce(GetPlayersAll(), (__jconcat("Wisp banned. Bans remaining: ", I2S(udg_Bans))))
    end
end

-- Original JASS function: InitTrig_Wisp (line 16674)
function InitTrig_Wisp()
    gg_trg_Wisp = CreateTrigger()
    TriggerRegisterPlayerChatEvent(gg_trg_Wisp, Player(0), "-ban Wisp", true)
    TriggerAddAction(gg_trg_Wisp, Trig_Wisp_Actions)
end
-- END FOREST SECTION 277

-- BEGIN FOREST SECTION 278 Kobold
-- Original JASS function: Trig_Kobold_Func001Func006001 (line 16684)
function Trig_Kobold_Func001Func006001()
    do return ((udg_Bans == 0)) end
end

-- Original JASS function: Trig_Kobold_Func001Func006002 (line 16688)
function Trig_Kobold_Func001Func006002()
    do return ((udg_BannedKobold == __jreal(1.00))) end
end

-- Original JASS function: Trig_Kobold_Func001C (line 16692)
function Trig_Kobold_Func001C()
    if ((not GetBooleanOr(((udg_Bans == 0)), ((udg_BannedKobold == __jreal(1.00)))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Kobold_Actions (line 16699)
function Trig_Kobold_Actions()
    if (Trig_Kobold_Func001C()) then
        DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        udg_Bans = (__jint(udg_Bans - 1))
        udg_BannedKobold = __jreal(1.00)
        DisplayTextToForce(GetPlayersAll(), (__jconcat("Kobold banned. Bans remaining: ", I2S(udg_Bans))))
    end
end

-- Original JASS function: InitTrig_Kobold (line 16710)
function InitTrig_Kobold()
    gg_trg_Kobold = CreateTrigger()
    TriggerRegisterPlayerChatEvent(gg_trg_Kobold, Player(0), "-ban Kobold", true)
    TriggerAddAction(gg_trg_Kobold, Trig_Kobold_Actions)
end
-- END FOREST SECTION 278

-- BEGIN FOREST SECTION 279 Ghoul
-- Original JASS function: Trig_Ghoul_Func001Func006001 (line 16720)
function Trig_Ghoul_Func001Func006001()
    do return ((udg_Bans == 0)) end
end

-- Original JASS function: Trig_Ghoul_Func001Func006002 (line 16724)
function Trig_Ghoul_Func001Func006002()
    do return ((udg_BannedGhoul == __jreal(1.00))) end
end

-- Original JASS function: Trig_Ghoul_Func001C (line 16728)
function Trig_Ghoul_Func001C()
    if ((not GetBooleanOr(((udg_Bans == 0)), ((udg_BannedGhoul == __jreal(1.00)))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Ghoul_Actions (line 16735)
function Trig_Ghoul_Actions()
    if (Trig_Ghoul_Func001C()) then
        DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        udg_Bans = (__jint(udg_Bans - 1))
        udg_BannedGhoul = __jreal(1.00)
        DisplayTextToForce(GetPlayersAll(), (__jconcat("Ghoul banned. Bans remaining: ", I2S(udg_Bans))))
    end
end

-- Original JASS function: InitTrig_Ghoul (line 16746)
function InitTrig_Ghoul()
    gg_trg_Ghoul = CreateTrigger()
    TriggerRegisterPlayerChatEvent(gg_trg_Ghoul, Player(0), "-ban Ghoul", true)
    TriggerAddAction(gg_trg_Ghoul, Trig_Ghoul_Actions)
end
-- END FOREST SECTION 279

-- BEGIN FOREST SECTION 280 Kraken
-- Original JASS function: Trig_Kraken_Func001Func006001 (line 16756)
function Trig_Kraken_Func001Func006001()
    do return ((udg_Bans == 0)) end
end

-- Original JASS function: Trig_Kraken_Func001Func006002 (line 16760)
function Trig_Kraken_Func001Func006002()
    do return ((udg_BannedKraken == __jreal(1.00))) end
end

-- Original JASS function: Trig_Kraken_Func001C (line 16764)
function Trig_Kraken_Func001C()
    if ((not GetBooleanOr(((udg_Bans == 0)), ((udg_BannedKraken == __jreal(1.00)))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Kraken_Actions (line 16771)
function Trig_Kraken_Actions()
    if (Trig_Kraken_Func001C()) then
        DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        udg_Bans = (__jint(udg_Bans - 1))
        udg_BannedKraken = __jreal(1.00)
        DisplayTextToForce(GetPlayersAll(), (__jconcat("Kraken banned. Bans remaining: ", I2S(udg_Bans))))
    end
end

-- Original JASS function: InitTrig_Kraken (line 16782)
function InitTrig_Kraken()
    gg_trg_Kraken = CreateTrigger()
    TriggerRegisterPlayerChatEvent(gg_trg_Kraken, Player(0), "-ban Kraken", true)
    TriggerAddAction(gg_trg_Kraken, Trig_Kraken_Actions)
end
-- END FOREST SECTION 280

-- BEGIN FOREST SECTION 281 Aethyr
-- Original JASS function: Trig_Aethyr_Func001Func006001 (line 16792)
function Trig_Aethyr_Func001Func006001()
    do return ((udg_Bans == 0)) end
end

-- Original JASS function: Trig_Aethyr_Func001Func006002 (line 16796)
function Trig_Aethyr_Func001Func006002()
    do return ((udg_BannedAethyr == __jreal(1.00))) end
end

-- Original JASS function: Trig_Aethyr_Func001C (line 16800)
function Trig_Aethyr_Func001C()
    if ((not GetBooleanOr(((udg_Bans == 0)), ((udg_BannedAethyr == __jreal(1.00)))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Aethyr_Actions (line 16807)
function Trig_Aethyr_Actions()
    if (Trig_Aethyr_Func001C()) then
        DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        udg_Bans = (__jint(udg_Bans - 1))
        udg_BannedAethyr = __jreal(1.00)
        DisplayTextToForce(GetPlayersAll(), (__jconcat("Aethyr Warp banned. Bans remaining: ", I2S(udg_Bans))))
    end
end

-- Original JASS function: InitTrig_Aethyr (line 16818)
function InitTrig_Aethyr()
    gg_trg_Aethyr = CreateTrigger()
    TriggerRegisterPlayerChatEvent(gg_trg_Aethyr, Player(0), "-ban aethyr", true)
    TriggerAddAction(gg_trg_Aethyr, Trig_Aethyr_Actions)
end
-- END FOREST SECTION 281

-- BEGIN FOREST SECTION 282 Forgotten
-- Original JASS function: Trig_Forgotten_Func001Func006001 (line 16828)
function Trig_Forgotten_Func001Func006001()
    do return ((udg_Bans == 0)) end
end

-- Original JASS function: Trig_Forgotten_Func001Func006002 (line 16832)
function Trig_Forgotten_Func001Func006002()
    do return ((udg_BannedForgotten == __jreal(1.00))) end
end

-- Original JASS function: Trig_Forgotten_Func001C (line 16836)
function Trig_Forgotten_Func001C()
    if ((not GetBooleanOr(((udg_Bans == 0)), ((udg_BannedForgotten == __jreal(1.00)))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Forgotten_Actions (line 16843)
function Trig_Forgotten_Actions()
    if (Trig_Forgotten_Func001C()) then
        DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        udg_Bans = (__jint(udg_Bans - 1))
        udg_BannedForgotten = __jreal(1.00)
        DisplayTextToForce(GetPlayersAll(), (__jconcat("Forgotten One banned. Bans remaining: ", I2S(udg_Bans))))
    end
end

-- Original JASS function: InitTrig_Forgotten (line 16854)
function InitTrig_Forgotten()
    gg_trg_Forgotten = CreateTrigger()
    TriggerRegisterPlayerChatEvent(gg_trg_Forgotten, Player(0), "-ban Forgotten", true)
    TriggerAddAction(gg_trg_Forgotten, Trig_Forgotten_Actions)
end
-- END FOREST SECTION 282

-- BEGIN FOREST SECTION 283 Goblin
-- Original JASS function: Trig_Goblin_Func001Func006001 (line 16864)
function Trig_Goblin_Func001Func006001()
    do return ((udg_Bans == 0)) end
end

-- Original JASS function: Trig_Goblin_Func001Func006002 (line 16868)
function Trig_Goblin_Func001Func006002()
    do return ((udg_BannedGoblin == __jreal(1.00))) end
end

-- Original JASS function: Trig_Goblin_Func001C (line 16872)
function Trig_Goblin_Func001C()
    if ((not GetBooleanOr(((udg_Bans == 0)), ((udg_BannedGoblin == __jreal(1.00)))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Goblin_Actions (line 16879)
function Trig_Goblin_Actions()
    if (Trig_Goblin_Func001C()) then
        DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        udg_Bans = (__jint(udg_Bans - 1))
        udg_BannedGoblin = __jreal(1.00)
        DisplayTextToForce(GetPlayersAll(), (__jconcat("Goblin banned. Bans remaining: ", I2S(udg_Bans))))
    end
end

-- Original JASS function: InitTrig_Goblin (line 16890)
function InitTrig_Goblin()
    gg_trg_Goblin = CreateTrigger()
    TriggerRegisterPlayerChatEvent(gg_trg_Goblin, Player(0), "-ban Goblin", true)
    TriggerAddAction(gg_trg_Goblin, Trig_Goblin_Actions)
end
-- END FOREST SECTION 283

-- BEGIN FOREST SECTION 284 Ogre
-- Original JASS function: Trig_Ogre_Func001Func006001 (line 16900)
function Trig_Ogre_Func001Func006001()
    do return ((udg_Bans == 0)) end
end

-- Original JASS function: Trig_Ogre_Func001Func006002 (line 16904)
function Trig_Ogre_Func001Func006002()
    do return ((udg_BannedOgre == __jreal(1.00))) end
end

-- Original JASS function: Trig_Ogre_Func001C (line 16908)
function Trig_Ogre_Func001C()
    if ((not GetBooleanOr(((udg_Bans == 0)), ((udg_BannedOgre == __jreal(1.00)))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Ogre_Actions (line 16915)
function Trig_Ogre_Actions()
    if (Trig_Ogre_Func001C()) then
        DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        udg_Bans = (__jint(udg_Bans - 1))
        udg_BannedOgre = __jreal(1.00)
        DisplayTextToForce(GetPlayersAll(), (__jconcat("Ogre banned. Bans remaining: ", I2S(udg_Bans))))
    end
end

-- Original JASS function: InitTrig_Ogre (line 16926)
function InitTrig_Ogre()
    gg_trg_Ogre = CreateTrigger()
    TriggerRegisterPlayerChatEvent(gg_trg_Ogre, Player(0), "-ban Ogre", true)
    TriggerAddAction(gg_trg_Ogre, Trig_Ogre_Actions)
end
-- END FOREST SECTION 284

-- BEGIN FOREST SECTION 285 Magmide
-- Original JASS function: Trig_Magmide_Func001Func006001 (line 16936)
function Trig_Magmide_Func001Func006001()
    do return ((udg_Bans == 0)) end
end

-- Original JASS function: Trig_Magmide_Func001Func006002 (line 16940)
function Trig_Magmide_Func001Func006002()
    do return ((udg_BannedMagmide == __jreal(1.00))) end
end

-- Original JASS function: Trig_Magmide_Func001C (line 16944)
function Trig_Magmide_Func001C()
    if ((not GetBooleanOr(((udg_Bans == 0)), ((udg_BannedMagmide == __jreal(1.00)))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Magmide_Actions (line 16951)
function Trig_Magmide_Actions()
    if (Trig_Magmide_Func001C()) then
        DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        udg_Bans = (__jint(udg_Bans - 1))
        udg_BannedMagmide = __jreal(1.00)
        DisplayTextToForce(GetPlayersAll(), (__jconcat("Magmide banned. Bans remaining: ", I2S(udg_Bans))))
    end
end

-- Original JASS function: InitTrig_Magmide (line 16962)
function InitTrig_Magmide()
    gg_trg_Magmide = CreateTrigger()
    TriggerRegisterPlayerChatEvent(gg_trg_Magmide, Player(0), "-ban Magmide", true)
    TriggerAddAction(gg_trg_Magmide, Trig_Magmide_Actions)
end
-- END FOREST SECTION 285

-- BEGIN FOREST SECTION 286 Furbolg
-- Original JASS function: Trig_Furbolg_Func001Func006001 (line 16972)
function Trig_Furbolg_Func001Func006001()
    do return ((udg_Bans == 0)) end
end

-- Original JASS function: Trig_Furbolg_Func001Func006002 (line 16976)
function Trig_Furbolg_Func001Func006002()
    do return ((udg_BannedFurbolg == __jreal(1.00))) end
end

-- Original JASS function: Trig_Furbolg_Func001C (line 16980)
function Trig_Furbolg_Func001C()
    if ((not GetBooleanOr(((udg_Bans == 0)), ((udg_BannedFurbolg == __jreal(1.00)))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Furbolg_Actions (line 16987)
function Trig_Furbolg_Actions()
    if (Trig_Furbolg_Func001C()) then
        DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        udg_Bans = (__jint(udg_Bans - 1))
        udg_BannedFurbolg = __jreal(1.00)
        DisplayTextToForce(GetPlayersAll(), (__jconcat("Furbolg banned. Bans remaining: ", I2S(udg_Bans))))
    end
end

-- Original JASS function: InitTrig_Furbolg (line 16998)
function InitTrig_Furbolg()
    gg_trg_Furbolg = CreateTrigger()
    TriggerRegisterPlayerChatEvent(gg_trg_Furbolg, Player(0), "-ban Furbolg", true)
    TriggerAddAction(gg_trg_Furbolg, Trig_Furbolg_Actions)
end
-- END FOREST SECTION 286

-- BEGIN FOREST SECTION 287 Razormane
-- Original JASS function: Trig_Razormane_Func001Func006001 (line 17008)
function Trig_Razormane_Func001Func006001()
    do return ((udg_Bans == 0)) end
end

-- Original JASS function: Trig_Razormane_Func001Func006002 (line 17012)
function Trig_Razormane_Func001Func006002()
    do return ((udg_BannedRazormane == __jreal(1.00))) end
end

-- Original JASS function: Trig_Razormane_Func001C (line 17016)
function Trig_Razormane_Func001C()
    if ((not GetBooleanOr(((udg_Bans == 0)), ((udg_BannedRazormane == __jreal(1.00)))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Razormane_Actions (line 17023)
function Trig_Razormane_Actions()
    if (Trig_Razormane_Func001C()) then
        DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        udg_Bans = (__jint(udg_Bans - 1))
        udg_BannedRazormane = __jreal(1.00)
        DisplayTextToForce(GetPlayersAll(), (__jconcat("Razormane banned. Bans remaining: ", I2S(udg_Bans))))
    end
end

-- Original JASS function: InitTrig_Razormane (line 17034)
function InitTrig_Razormane()
    gg_trg_Razormane = CreateTrigger()
    TriggerRegisterPlayerChatEvent(gg_trg_Razormane, Player(0), "-ban Razormane", true)
    TriggerAddAction(gg_trg_Razormane, Trig_Razormane_Actions)
end
-- END FOREST SECTION 287

-- BEGIN FOREST SECTION 288 Elf
-- Original JASS function: Trig_Elf_Func001Func006001 (line 17044)
function Trig_Elf_Func001Func006001()
    do return ((udg_Bans == 0)) end
end

-- Original JASS function: Trig_Elf_Func001Func006002 (line 17048)
function Trig_Elf_Func001Func006002()
    do return ((udg_BannedElf == __jreal(1.00))) end
end

-- Original JASS function: Trig_Elf_Func001C (line 17052)
function Trig_Elf_Func001C()
    if ((not GetBooleanOr(((udg_Bans == 0)), ((udg_BannedElf == __jreal(1.00)))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Elf_Actions (line 17059)
function Trig_Elf_Actions()
    if (Trig_Elf_Func001C()) then
        DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        udg_Bans = (__jint(udg_Bans - 1))
        udg_BannedElf = __jreal(1.00)
        DisplayTextToForce(GetPlayersAll(), (__jconcat("Elf banned. Bans remaining: ", I2S(udg_Bans))))
    end
end

-- Original JASS function: InitTrig_Elf (line 17070)
function InitTrig_Elf()
    gg_trg_Elf = CreateTrigger()
    TriggerRegisterPlayerChatEvent(gg_trg_Elf, Player(0), "-ban NightElf", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Elf, Player(0), "-ban Elf", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Elf, Player(0), "-ban Night", true)
    TriggerAddAction(gg_trg_Elf, Trig_Elf_Actions)
end
-- END FOREST SECTION 288

-- BEGIN FOREST SECTION 289 HighElf
-- Original JASS function: Trig_HighElf_Func001Func006001 (line 17082)
function Trig_HighElf_Func001Func006001()
    do return ((udg_Bans == 0)) end
end

-- Original JASS function: Trig_HighElf_Func001Func006002 (line 17086)
function Trig_HighElf_Func001Func006002()
    do return ((udg_BannedHighElf == __jreal(1.00))) end
end

-- Original JASS function: Trig_HighElf_Func001C (line 17090)
function Trig_HighElf_Func001C()
    if ((not GetBooleanOr(((udg_Bans == 0)), ((udg_BannedHighElf == __jreal(1.00)))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_HighElf_Actions (line 17097)
function Trig_HighElf_Actions()
    if (Trig_HighElf_Func001C()) then
        DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        udg_Bans = (__jint(udg_Bans - 1))
        udg_BannedHighElf = __jreal(1.00)
        DisplayTextToForce(GetPlayersAll(), (__jconcat("Elf banned. Bans remaining: ", I2S(udg_Bans))))
    end
end

-- Original JASS function: InitTrig_HighElf (line 17108)
function InitTrig_HighElf()
    gg_trg_HighElf = CreateTrigger()
    TriggerRegisterPlayerChatEvent(gg_trg_HighElf, Player(0), "-ban HighElf", true)
    TriggerRegisterPlayerChatEvent(gg_trg_HighElf, Player(0), "-ban High Elf", true)
    TriggerRegisterPlayerChatEvent(gg_trg_HighElf, Player(0), "-ban High", true)
    TriggerAddAction(gg_trg_HighElf, Trig_HighElf_Actions)
end
-- END FOREST SECTION 289

-- BEGIN FOREST SECTION 290 Ratling
-- Original JASS function: Trig_Ratling_Func001Func006001 (line 17120)
function Trig_Ratling_Func001Func006001()
    do return ((udg_Bans == 0)) end
end

-- Original JASS function: Trig_Ratling_Func001Func006002 (line 17124)
function Trig_Ratling_Func001Func006002()
    do return ((udg_BannedRatling == __jreal(1.00))) end
end

-- Original JASS function: Trig_Ratling_Func001C (line 17128)
function Trig_Ratling_Func001C()
    if ((not GetBooleanOr(((udg_Bans == 0)), ((udg_BannedRatling == __jreal(1.00)))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Ratling_Actions (line 17135)
function Trig_Ratling_Actions()
    if (Trig_Ratling_Func001C()) then
        DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        udg_Bans = (__jint(udg_Bans - 1))
        udg_BannedRatling = __jreal(1.00)
        DisplayTextToForce(GetPlayersAll(), (__jconcat("Ratling Stalker banned. Bans remaining: ", I2S(udg_Bans))))
    end
end

-- Original JASS function: InitTrig_Ratling (line 17146)
function InitTrig_Ratling()
    gg_trg_Ratling = CreateTrigger()
    TriggerRegisterPlayerChatEvent(gg_trg_Ratling, Player(0), "-ban rat", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Ratling, Player(0), "-ban ratling", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Ratling, Player(0), "-ban stalker", true)
    TriggerAddAction(gg_trg_Ratling, Trig_Ratling_Actions)
end
-- END FOREST SECTION 290

-- BEGIN FOREST SECTION 291 Hunter
-- Original JASS function: Trig_Hunter_Func001Func006001 (line 17158)
function Trig_Hunter_Func001Func006001()
    do return ((udg_Bans == 0)) end
end

-- Original JASS function: Trig_Hunter_Func001Func006002 (line 17162)
function Trig_Hunter_Func001Func006002()
    do return ((udg_BannedHunter == __jreal(1.00))) end
end

-- Original JASS function: Trig_Hunter_Func001C (line 17166)
function Trig_Hunter_Func001C()
    if ((not GetBooleanOr(((udg_Bans == 0)), ((udg_BannedHunter == __jreal(1.00)))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Hunter_Actions (line 17173)
function Trig_Hunter_Actions()
    if (Trig_Hunter_Func001C()) then
        DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        udg_Bans = (__jint(udg_Bans - 1))
        udg_BannedHunter = __jreal(1.00)
        DisplayTextToForce(GetPlayersAll(), (__jconcat("Bounty Hunter banned. Bans remaining: ", I2S(udg_Bans))))
    end
end

-- Original JASS function: InitTrig_Hunter (line 17184)
function InitTrig_Hunter()
    gg_trg_Hunter = CreateTrigger()
    TriggerRegisterPlayerChatEvent(gg_trg_Hunter, Player(0), "-ban hunter", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Hunter, Player(0), "-ban bounty", true)
    TriggerAddAction(gg_trg_Hunter, Trig_Hunter_Actions)
end
-- END FOREST SECTION 291
