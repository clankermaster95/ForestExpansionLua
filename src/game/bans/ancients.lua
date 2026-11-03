-- game / bans / ancients
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 292 AncientLight
-- Original JASS function: Trig_AncientLight_Func001Func006001 (line 17195)
function Trig_AncientLight_Func001Func006001()
    do return ((udg_Bans == 0)) end
end

-- Original JASS function: Trig_AncientLight_Func001Func006002 (line 17199)
function Trig_AncientLight_Func001Func006002()
    do return ((udg_BannedAncientLight == __jreal(1.00))) end
end

-- Original JASS function: Trig_AncientLight_Func001C (line 17203)
function Trig_AncientLight_Func001C()
    if ((not GetBooleanOr(((udg_Bans == 0)), ((udg_BannedAncientLight == __jreal(1.00)))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_AncientLight_Actions (line 17210)
function Trig_AncientLight_Actions()
    if (Trig_AncientLight_Func001C()) then
        DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        udg_Bans = (__jint(udg_Bans - 1))
        udg_BannedAncientLight = __jreal(1.00)
        DisplayTextToForce(GetPlayersAll(), (__jconcat("Ancient of Light banned. Bans remaining: ", I2S(udg_Bans))))
    end
end

-- Original JASS function: InitTrig_AncientLight (line 17221)
function InitTrig_AncientLight()
    gg_trg_AncientLight = CreateTrigger()
    TriggerRegisterPlayerChatEvent(gg_trg_AncientLight, Player(0), "-ban light", true)
    TriggerRegisterPlayerChatEvent(gg_trg_AncientLight, Player(0), "-ban divinity", true)
    TriggerAddAction(gg_trg_AncientLight, Trig_AncientLight_Actions)
end
-- END FOREST SECTION 292

-- BEGIN FOREST SECTION 293 AncientLightning
-- Original JASS function: Trig_AncientLightning_Func001Func006001 (line 17232)
function Trig_AncientLightning_Func001Func006001()
    do return ((udg_Bans == 0)) end
end

-- Original JASS function: Trig_AncientLightning_Func001Func006002 (line 17236)
function Trig_AncientLightning_Func001Func006002()
    do return ((udg_BannedAncientLightning == __jreal(1.00))) end
end

-- Original JASS function: Trig_AncientLightning_Func001C (line 17240)
function Trig_AncientLightning_Func001C()
    if ((not GetBooleanOr(((udg_Bans == 0)), ((udg_BannedAncientLightning == __jreal(1.00)))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_AncientLightning_Actions (line 17247)
function Trig_AncientLightning_Actions()
    if (Trig_AncientLightning_Func001C()) then
        DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        udg_Bans = (__jint(udg_Bans - 1))
        udg_BannedAncientLightning = __jreal(1.00)
        DisplayTextToForce(GetPlayersAll(), (__jconcat("Ancient of Lightning banned. Bans remaining: ", I2S(udg_Bans))))
    end
end

-- Original JASS function: InitTrig_AncientLightning (line 17258)
function InitTrig_AncientLightning()
    gg_trg_AncientLightning = CreateTrigger()
    TriggerRegisterPlayerChatEvent(gg_trg_AncientLightning, Player(0), "-ban Lightning", true)
    TriggerRegisterPlayerChatEvent(gg_trg_AncientLightning, Player(0), "-ban Zalxon", true)
    TriggerAddAction(gg_trg_AncientLightning, Trig_AncientLightning_Actions)
end
-- END FOREST SECTION 293

-- BEGIN FOREST SECTION 294 AncientDragon
-- Original JASS function: Trig_AncientDragon_Func001Func006001 (line 17269)
function Trig_AncientDragon_Func001Func006001()
    do return ((udg_Bans == 0)) end
end

-- Original JASS function: Trig_AncientDragon_Func001Func006002 (line 17273)
function Trig_AncientDragon_Func001Func006002()
    do return ((udg_BannedAncientDragon == __jreal(1.00))) end
end

-- Original JASS function: Trig_AncientDragon_Func001C (line 17277)
function Trig_AncientDragon_Func001C()
    if ((not GetBooleanOr(((udg_Bans == 0)), ((udg_BannedAncientDragon == __jreal(1.00)))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_AncientDragon_Actions (line 17284)
function Trig_AncientDragon_Actions()
    if (Trig_AncientDragon_Func001C()) then
        DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        udg_Bans = (__jint(udg_Bans - 1))
        udg_BannedAncientDragon = __jreal(1.00)
        DisplayTextToForce(GetPlayersAll(), (__jconcat("Ancient of Dragons banned. Bans remaining: ", I2S(udg_Bans))))
    end
end

-- Original JASS function: InitTrig_AncientDragon (line 17295)
function InitTrig_AncientDragon()
    gg_trg_AncientDragon = CreateTrigger()
    TriggerRegisterPlayerChatEvent(gg_trg_AncientDragon, Player(0), "-ban Dragon", true)
    TriggerRegisterPlayerChatEvent(gg_trg_AncientDragon, Player(0), "-ban Dragons", true)
    TriggerRegisterPlayerChatEvent(gg_trg_AncientDragon, Player(0), "-ban Dragos", true)
    TriggerAddAction(gg_trg_AncientDragon, Trig_AncientDragon_Actions)
end
-- END FOREST SECTION 294

-- BEGIN FOREST SECTION 295 AncientEarth
-- Original JASS function: Trig_AncientEarth_Func001Func006001 (line 17307)
function Trig_AncientEarth_Func001Func006001()
    do return ((udg_Bans == 0)) end
end

-- Original JASS function: Trig_AncientEarth_Func001Func006002 (line 17311)
function Trig_AncientEarth_Func001Func006002()
    do return ((udg_BannedAncientEarth == __jreal(1.00))) end
end

-- Original JASS function: Trig_AncientEarth_Func001C (line 17315)
function Trig_AncientEarth_Func001C()
    if ((not GetBooleanOr(((udg_Bans == 0)), ((udg_BannedAncientEarth == __jreal(1.00)))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_AncientEarth_Actions (line 17322)
function Trig_AncientEarth_Actions()
    if (Trig_AncientEarth_Func001C()) then
        DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        udg_Bans = (__jint(udg_Bans - 1))
        udg_BannedAncientEarth = __jreal(1.00)
        DisplayTextToForce(GetPlayersAll(), (__jconcat("Ancient of Earth banned. Bans remaining: ", I2S(udg_Bans))))
    end
end

-- Original JASS function: InitTrig_AncientEarth (line 17333)
function InitTrig_AncientEarth()
    gg_trg_AncientEarth = CreateTrigger()
    TriggerRegisterPlayerChatEvent(gg_trg_AncientEarth, Player(0), "-ban Earth", true)
    TriggerRegisterPlayerChatEvent(gg_trg_AncientEarth, Player(0), "-ban Tremor", true)
    TriggerAddAction(gg_trg_AncientEarth, Trig_AncientEarth_Actions)
end
-- END FOREST SECTION 295

-- BEGIN FOREST SECTION 296 AncientDarkness
-- Original JASS function: Trig_AncientDarkness_Func001Func006001 (line 17344)
function Trig_AncientDarkness_Func001Func006001()
    do return ((udg_Bans == 0)) end
end

-- Original JASS function: Trig_AncientDarkness_Func001Func006002 (line 17348)
function Trig_AncientDarkness_Func001Func006002()
    do return ((udg_BannedAncientDarkness == __jreal(1.00))) end
end

-- Original JASS function: Trig_AncientDarkness_Func001C (line 17352)
function Trig_AncientDarkness_Func001C()
    if ((not GetBooleanOr(((udg_Bans == 0)), ((udg_BannedAncientDarkness == __jreal(1.00)))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_AncientDarkness_Actions (line 17359)
function Trig_AncientDarkness_Actions()
    if (Trig_AncientDarkness_Func001C()) then
        DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        udg_Bans = (__jint(udg_Bans - 1))
        udg_BannedAncientDarkness = __jreal(1.00)
        DisplayTextToForce(GetPlayersAll(), (__jconcat("Ancient of Darkness banned. Bans remaining: ", I2S(udg_Bans))))
    end
end

-- Original JASS function: InitTrig_AncientDarkness (line 17370)
function InitTrig_AncientDarkness()
    gg_trg_AncientDarkness = CreateTrigger()
    TriggerRegisterPlayerChatEvent(gg_trg_AncientDarkness, Player(0), "-ban Darkness", true)
    TriggerRegisterPlayerChatEvent(gg_trg_AncientDarkness, Player(0), "-ban Paranoia", true)
    TriggerAddAction(gg_trg_AncientDarkness, Trig_AncientDarkness_Actions)
end
-- END FOREST SECTION 296

-- BEGIN FOREST SECTION 297 AncientIce
-- Original JASS function: Trig_AncientIce_Func001Func006001 (line 17381)
function Trig_AncientIce_Func001Func006001()
    do return ((udg_Bans == 0)) end
end

-- Original JASS function: Trig_AncientIce_Func001Func006002 (line 17385)
function Trig_AncientIce_Func001Func006002()
    do return ((udg_BannedAncientIce == __jreal(1.00))) end
end

-- Original JASS function: Trig_AncientIce_Func001C (line 17389)
function Trig_AncientIce_Func001C()
    if ((not GetBooleanOr(((udg_Bans == 0)), ((udg_BannedAncientIce == __jreal(1.00)))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_AncientIce_Actions (line 17396)
function Trig_AncientIce_Actions()
    if (Trig_AncientIce_Func001C()) then
        DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        udg_Bans = (__jint(udg_Bans - 1))
        udg_BannedAncientIce = __jreal(1.00)
        DisplayTextToForce(GetPlayersAll(), (__jconcat("Ancient of Ice banned. Bans remaining: ", I2S(udg_Bans))))
    end
end

-- Original JASS function: InitTrig_AncientIce (line 17407)
function InitTrig_AncientIce()
    gg_trg_AncientIce = CreateTrigger()
    TriggerRegisterPlayerChatEvent(gg_trg_AncientIce, Player(0), "-ban Ice", true)
    TriggerRegisterPlayerChatEvent(gg_trg_AncientIce, Player(0), "-ban Avalanche", true)
    TriggerAddAction(gg_trg_AncientIce, Trig_AncientIce_Actions)
end
-- END FOREST SECTION 297

-- BEGIN FOREST SECTION 298 AncientFire
-- Original JASS function: Trig_AncientFire_Func001Func006001 (line 17418)
function Trig_AncientFire_Func001Func006001()
    do return ((udg_Bans == 0)) end
end

-- Original JASS function: Trig_AncientFire_Func001Func006002 (line 17422)
function Trig_AncientFire_Func001Func006002()
    do return ((udg_BannedAncientFire == __jreal(1.00))) end
end

-- Original JASS function: Trig_AncientFire_Func001C (line 17426)
function Trig_AncientFire_Func001C()
    if ((not GetBooleanOr(((udg_Bans == 0)), ((udg_BannedAncientFire == __jreal(1.00)))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_AncientFire_Actions (line 17433)
function Trig_AncientFire_Actions()
    if (Trig_AncientFire_Func001C()) then
        DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        udg_Bans = (__jint(udg_Bans - 1))
        udg_BannedAncientFire = __jreal(1.00)
        DisplayTextToForce(GetPlayersAll(), (__jconcat("Ancient of Fire banned. Bans remaining: ", I2S(udg_Bans))))
    end
end

-- Original JASS function: InitTrig_AncientFire (line 17444)
function InitTrig_AncientFire()
    gg_trg_AncientFire = CreateTrigger()
    TriggerRegisterPlayerChatEvent(gg_trg_AncientFire, Player(0), "-ban Fire", true)
    TriggerRegisterPlayerChatEvent(gg_trg_AncientFire, Player(0), "-ban Ignite", true)
    TriggerAddAction(gg_trg_AncientFire, Trig_AncientFire_Actions)
end
-- END FOREST SECTION 298

-- BEGIN FOREST SECTION 299 AncientNature
-- Original JASS function: Trig_AncientNature_Func001Func006001 (line 17455)
function Trig_AncientNature_Func001Func006001()
    do return ((udg_Bans == 0)) end
end

-- Original JASS function: Trig_AncientNature_Func001Func006002 (line 17459)
function Trig_AncientNature_Func001Func006002()
    do return ((udg_BannedAncientNature == __jreal(1.00))) end
end

-- Original JASS function: Trig_AncientNature_Func001C (line 17463)
function Trig_AncientNature_Func001C()
    if ((not GetBooleanOr(((udg_Bans == 0)), ((udg_BannedAncientNature == __jreal(1.00)))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_AncientNature_Actions (line 17470)
function Trig_AncientNature_Actions()
    if (Trig_AncientNature_Func001C()) then
        DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        udg_Bans = (__jint(udg_Bans - 1))
        udg_BannedAncientNature = __jreal(1.00)
        DisplayTextToForce(GetPlayersAll(), (__jconcat("Ancient of Nature banned. Bans remaining: ", I2S(udg_Bans))))
    end
end

-- Original JASS function: InitTrig_AncientNature (line 17481)
function InitTrig_AncientNature()
    gg_trg_AncientNature = CreateTrigger()
    TriggerRegisterPlayerChatEvent(gg_trg_AncientNature, Player(0), "-ban Nature", true)
    TriggerRegisterPlayerChatEvent(gg_trg_AncientNature, Player(0), "-ban Eternity", true)
    TriggerAddAction(gg_trg_AncientNature, Trig_AncientNature_Actions)
end
-- END FOREST SECTION 299

-- BEGIN FOREST SECTION 300 AncientSand
-- Original JASS function: Trig_AncientSand_Func001Func006001 (line 17492)
function Trig_AncientSand_Func001Func006001()
    do return ((udg_Bans == 0)) end
end

-- Original JASS function: Trig_AncientSand_Func001Func006002 (line 17496)
function Trig_AncientSand_Func001Func006002()
    do return ((udg_BannedAncientSand == __jreal(1.00))) end
end

-- Original JASS function: Trig_AncientSand_Func001C (line 17500)
function Trig_AncientSand_Func001C()
    if ((not GetBooleanOr(((udg_Bans == 0)), ((udg_BannedAncientSand == __jreal(1.00)))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_AncientSand_Actions (line 17507)
function Trig_AncientSand_Actions()
    if (Trig_AncientSand_Func001C()) then
        DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        udg_Bans = (__jint(udg_Bans - 1))
        udg_BannedAncientSand = __jreal(1.00)
        DisplayTextToForce(GetPlayersAll(), (__jconcat("Ancient of Sand banned. Bans remaining: ", I2S(udg_Bans))))
    end
end

-- Original JASS function: InitTrig_AncientSand (line 17518)
function InitTrig_AncientSand()
    gg_trg_AncientSand = CreateTrigger()
    TriggerRegisterPlayerChatEvent(gg_trg_AncientSand, Player(0), "-ban Sand", true)
    TriggerRegisterPlayerChatEvent(gg_trg_AncientSand, Player(0), "-ban Pharaoh", true)
    TriggerAddAction(gg_trg_AncientSand, Trig_AncientSand_Actions)
end
-- END FOREST SECTION 300

-- BEGIN FOREST SECTION 301 AncientSpace
-- Original JASS function: Trig_AncientSpace_Func001Func010001 (line 17529)
function Trig_AncientSpace_Func001Func010001()
    do return ((udg_Bans == 0)) end
end

-- Original JASS function: Trig_AncientSpace_Func001Func010002 (line 17533)
function Trig_AncientSpace_Func001Func010002()
    do return ((udg_BannedAncientSpace == __jreal(1.00))) end
end

-- Original JASS function: Trig_AncientSpace_Func001C (line 17537)
function Trig_AncientSpace_Func001C()
    if ((not GetBooleanOr(((udg_Bans == 0)), ((udg_BannedAncientSpace == __jreal(1.00)))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_AncientSpace_Actions (line 17544)
function Trig_AncientSpace_Actions()
    if (Trig_AncientSpace_Func001C()) then
        DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        udg_Bans = (__jint(udg_Bans - 1))
        udg_BannedAncientSpace = __jreal(1.00)
        DisplayTextToForce(GetPlayersAll(), (__jconcat("Ancient of Space banned. Bans remaining: ", I2S(udg_Bans))))
    end
end

-- Original JASS function: InitTrig_AncientSpace (line 17555)
function InitTrig_AncientSpace()
    gg_trg_AncientSpace = CreateTrigger()
    TriggerRegisterPlayerChatEvent(gg_trg_AncientSpace, Player(0), "-ban Space", true)
    TriggerRegisterPlayerChatEvent(gg_trg_AncientSpace, Player(0), "-ban Nebula", true)
    TriggerAddAction(gg_trg_AncientSpace, Trig_AncientSpace_Actions)
end
-- END FOREST SECTION 301

-- BEGIN FOREST SECTION 302 AncientWind
-- Original JASS function: Trig_AncientWind_Func001Func011001 (line 17566)
function Trig_AncientWind_Func001Func011001()
    do return ((udg_Bans == 0)) end
end

-- Original JASS function: Trig_AncientWind_Func001Func011002 (line 17570)
function Trig_AncientWind_Func001Func011002()
    do return ((udg_BannedAncientWind == __jreal(1.00))) end
end

-- Original JASS function: Trig_AncientWind_Func001C (line 17574)
function Trig_AncientWind_Func001C()
    if ((not GetBooleanOr(((udg_Bans == 0)), ((udg_BannedAncientWind == __jreal(1.00)))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_AncientWind_Actions (line 17581)
function Trig_AncientWind_Actions()
    if (Trig_AncientWind_Func001C()) then
        DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        udg_Bans = (__jint(udg_Bans - 1))
        udg_BannedAncientWind = __jreal(1.00)
        DisplayTextToForce(GetPlayersAll(), (__jconcat("Ancient of Wind banned. Bans remaining: ", I2S(udg_Bans))))
    end
end

-- Original JASS function: InitTrig_AncientWind (line 17592)
function InitTrig_AncientWind()
    gg_trg_AncientWind = CreateTrigger()
    TriggerRegisterPlayerChatEvent(gg_trg_AncientWind, Player(0), "-ban Wind", true)
    TriggerRegisterPlayerChatEvent(gg_trg_AncientWind, Player(0), "-ban Wispari", true)
    TriggerRegisterPlayerChatEvent(gg_trg_AncientWind, Player(0), "-ban Wisperi", true)
    TriggerRegisterPlayerChatEvent(gg_trg_AncientWind, Player(0), "-ban Whispari", true)
    TriggerRegisterPlayerChatEvent(gg_trg_AncientWind, Player(0), "-ban Whisperi", true)
    TriggerAddAction(gg_trg_AncientWind, Trig_AncientWind_Actions)
end
-- END FOREST SECTION 302
