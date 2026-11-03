-- Original JASS function: InitGlobals (line 3314)
function FE_InitGlobals()
    local i = 0
    i = 0
    while true do
        if ((i > 1)) then break end
        udg_Units[i] = 0
        i = __jint(i + 1)
    end
    udg_Selectors = FourCC("ewsp")
    i = 0
    while true do
        if ((i > 1)) then break end
        udg_Ancients[i] = 0
        i = __jint(i + 1)
    end
    udg_Razormane = CreateForce()
    udg_UDex = 0
    udg_UDexRecycle = 0
    i = 0
    while true do
        if ((i > 1)) then break end
        udg_UDexNext[i] = 0
        i = __jint(i + 1)
    end
    udg_UDexGen = 0
    i = 0
    while true do
        if ((i > 1)) then break end
        udg_UDexPrev[i] = 0
        i = __jint(i + 1)
    end
    udg_UnitIndexEvent = __jreal(0)
    udg_UnitIndexerEnabled = false
    udg_UDexWasted = 0
    udg_ncld_DrainHP = __jreal(0)
    udg_ncld_DrainHPUp = __jreal(0)
    udg_ncld_DrainMP = __jreal(0)
    udg_ncld_DrainMPUp = __jreal(0)
    udg_ncld_Duration = __jreal(0)
    udg_ncld_Duration_Up = __jreal(0)
    udg_ncld_Range = __jreal(0)
    udg_ncld_RangeUp = __jreal(0)
    udg_ncld_TargetSFXArt = ""
    udg_ncld_CasterSFXArt = ""
    udg_ncld_FreqDrain = 0
    udg_ncld_FreqDistance = 0
    udg_ncld_EtherealBonus = __jreal(0)
    udg_ncld_buffId = 0
    udg_ncld_CheckImmune = false
    udg_ncld_CheckResistant = false
    udg_ncld_CheckVisibile = false
    udg_tempReal = __jreal(0)
    udg_Key = 0
    udg_ncld_Group = CreateGroup()
    i = 0
    while true do
        if ((i > 1)) then break end
        udg_ncld_Tick[i] = 0
        i = __jint(i + 1)
    end
    i = 0
    while true do
        if ((i > 1)) then break end
        udg_ncld_TicksRemaining[i] = 0
        i = __jint(i + 1)
    end
    i = 0
    while true do
        if ((i > 1)) then break end
        udg_ncld_Hp[i] = __jreal(0)
        i = __jint(i + 1)
    end
    i = 0
    while true do
        if ((i > 1)) then break end
        udg_ncld_Mp[i] = __jreal(0)
        i = __jint(i + 1)
    end
    i = 0
    while true do
        if ((i > 1)) then break end
        udg_ncld_Rng[i] = __jreal(0)
        i = __jint(i + 1)
    end
    udg_CheckBool = false
    udg_tempDistance = __jreal(0)
    udg_tempX1 = __jreal(0)
    udg_tempX2 = __jreal(0)
    udg_tempY1 = __jreal(0)
    udg_tempY2 = __jreal(0)
    udg_tempZ1 = __jreal(0)
    udg_tempZ2 = __jreal(0)
    udg_VanguardHeal = __jreal(0)
    udg_Omni = 0
    udg_RemSel = CreateGroup()
    udg_FZ = CreateTimer()
    udg_LS = CreateTimer()
    udg_AncientInCombat = __jreal(0)
    udg_Bans = 4
    udg_BannedWorgen = __jreal(0)
    udg_BannedForgotten = __jreal(0)
    udg_BannedAethyr = __jreal(0)
    udg_BannedGoblin = __jreal(0)
    udg_BannedOgre = __jreal(0)
    udg_BannedMagmide = __jreal(0)
    udg_BannedFurbolg = __jreal(0)
    udg_BannedRazormane = __jreal(0)
    udg_BannedNerubian = __jreal(0)
    udg_BannedWildkin = __jreal(0)
    udg_BannedHuman = __jreal(0)
    udg_BannedCentaur = __jreal(0)
    udg_BannedWisp = __jreal(0)
    udg_BannedKobold = __jreal(0)
    udg_BannedGhoul = __jreal(0)
    udg_BannedKraken = __jreal(0)
    udg_BannedAncientLight = __jreal(0)
    udg_BannedAncientLightning = __jreal(0)
    udg_BannedAncientDragon = __jreal(0)
    udg_BannedAncientEarth = __jreal(0)
    udg_BannedAncientDarkness = __jreal(0)
    udg_BannedAncientIce = __jreal(0)
    udg_BannedAncientFire = __jreal(0)
    udg_BannedAncientNature = __jreal(0)
    udg_ExpanderSpawnTimer = CreateTimer()
    udg_AncientSpawnTimer = CreateTimer()
    udg_BannedAncientSand = __jreal(0)
    udg_Cascade = 0
    udg_Resillence = __jreal(0)
    udg_CosmicStrikeCount = 0
    udg_PreDamageEvent = __jreal(0)
    udg_ArmorDamageEvent = __jreal(0)
    udg_ZeroDamageEvent = __jreal(0)
    udg_LethalDamageEvent = __jreal(0)
    udg_OnDamageEvent = __jreal(0)
    udg_AfterDamageEvent = __jreal(0)
    udg_SourceDamageEvent = __jreal(0)
    udg_AOEDamageEvent = __jreal(0)
    udg_DamageModifierEvent = __jreal(0)
    udg_DamageEvent = __jreal(0)
    udg_RemoveDamageEvent = false
    udg_DamageEventOverride = false
    udg_DamageEventPrevAmt = __jreal(0)
    udg_DamageEventLevel = 0
    udg_DamageEventAOE = 0
    udg_DamageEventAOEGroup = CreateGroup()
    udg_DamageScalingWC3 = __jreal(0)
    udg_DamageScalingUser = __jreal(0)
    udg_IsDamageAttack = false
    udg_IsDamageMelee = false
    udg_IsDamageRanged = false
    udg_IsDamageSpell = false
    udg_IsDamageCode = false
    udg_DamageEventAmount = __jreal(0)
    udg_DamageEventArmorPierced = __jreal(0)
    udg_LethalDamageHP = __jreal(0)
    udg_DamageEventAttackT = 0
    udg_DamageEventDamageT = 0
    udg_DamageEventArmorT = 0
    udg_DamageEventDefenseT = 0
    udg_DamageEventWeaponT = 0
    udg_DamageEventType = 0
    udg_NextDamageIsAttack = false
    udg_NextDamageIsRanged = false
    udg_NextDamageIsMelee = false
    udg_NextDamageType = 0
    udg_NextDamageWeaponT = 0
    udg_DamageFilterAttackT = 0
    udg_DamageFilterDamageT = 0
    udg_DamageFilterType = 0
    udg_DamageFilterMinAmount = __jreal(0)
    udg_DamageFilterRunChance = __jreal(0)
    udg_DamageFilterFailChance = __jreal(0)
    udg_DamageFilterSourceC = 0
    udg_DamageFilterTargetC = 0
    udg_UNIT_CLASS_MAGIC_IMMUNE = 0
    udg_UNIT_CLASS_ETHEREAL = 0
    udg_UNIT_CLASS_RESISTANT = 0
    udg_UNIT_CLASS_SLEEPING = 0
    udg_UNIT_CLASS_POLYMORPHED = 0
    udg_UNIT_CLASS_POISONED = 0
    udg_UNIT_CLASS_TAUREN = 0
    udg_UNIT_CLASS_ANCIENT = 0
    udg_UNIT_CLASS_TOWNHALL = 0
    udg_UNIT_CLASS_SAPPER = 0
    udg_UNIT_CLASS_PEON = 0
    udg_UNIT_CLASS_MECHANICAL = 0
    udg_UNIT_CLASS_UNDEAD = 0
    udg_UNIT_CLASS_SNARED = 0
    udg_UNIT_CLASS_PLAGUED = 0
    udg_UNIT_CLASS_STUNNED = 0
    udg_UNIT_CLASS_SUMMONED = 0
    udg_UNIT_CLASS_GIANT = 0
    udg_UNIT_CLASS_RANGED = 0
    udg_UNIT_CLASS_MELEE = 0
    udg_UNIT_CLASS_ATTACKS_GROUND = 0
    udg_UNIT_CLASS_ATTACKS_FLYING = 0
    udg_UNIT_CLASS_GROUND = 0
    udg_UNIT_CLASS_FLYING = 0
    udg_UNIT_CLASS_STRUCTURE = 0
    udg_UNIT_CLASS_DEAD = 0
    udg_UNIT_CLASS_HERO = 0
    udg_ARMOR_TYPE_NONE = 0
    udg_ARMOR_TYPE_FLESH = 0
    udg_ARMOR_TYPE_METAL = 0
    udg_ARMOR_TYPE_WOOD = 0
    udg_ARMOR_TYPE_ETHEREAL = 0
    udg_ARMOR_TYPE_STONE = 0
    i = 0
    while true do
        if ((i > 1)) then break end
        udg_ArmorTypeDebugStr[i] = ""
        i = __jint(i + 1)
    end
    udg_ATTACK_TYPE_SPELLS = 0
    udg_ATTACK_TYPE_NORMAL = 0
    udg_ATTACK_TYPE_PIERCE = 0
    udg_ATTACK_TYPE_SIEGE = 0
    udg_ATTACK_TYPE_MAGIC = 0
    udg_ATTACK_TYPE_CHAOS = 0
    udg_ATTACK_TYPE_HERO = 0
    i = 0
    while true do
        if ((i > 1)) then break end
        udg_AttackTypeDebugStr[i] = ""
        i = __jint(i + 1)
    end
    udg_DamageTypeBlocked = 0
    udg_DamageTypeCriticalStrike = 0
    udg_DamageTypeCode = 0
    udg_DamageTypeExplosive = 0
    udg_DamageTypeHeal = 0
    udg_DamageTypePure = 0
    udg_DamageTypePureExplosive = 0
    udg_DamageTypeReduced = 0
    udg_DAMAGE_TYPE_UNKNOWN = 0
    udg_DAMAGE_TYPE_NORMAL = 0
    udg_DAMAGE_TYPE_ENHANCED = 0
    udg_DAMAGE_TYPE_FIRE = 0
    udg_DAMAGE_TYPE_COLD = 0
    udg_DAMAGE_TYPE_LIGHTNING = 0
    udg_DAMAGE_TYPE_POISON = 0
    udg_DAMAGE_TYPE_DISEASE = 0
    udg_DAMAGE_TYPE_DIVINE = 0
    udg_DAMAGE_TYPE_MAGIC = 0
    udg_DAMAGE_TYPE_SONIC = 0
    udg_DAMAGE_TYPE_ACID = 0
    udg_DAMAGE_TYPE_FORCE = 0
    udg_DAMAGE_TYPE_DEATH = 0
    udg_DAMAGE_TYPE_MIND = 0
    udg_DAMAGE_TYPE_PLANT = 0
    udg_DAMAGE_TYPE_DEFENSIVE = 0
    udg_DAMAGE_TYPE_DEMOLITION = 0
    udg_DAMAGE_TYPE_SLOW_POISON = 0
    udg_DAMAGE_TYPE_SPIRIT_LINK = 0
    udg_DAMAGE_TYPE_SHADOW_STRIKE = 0
    udg_DAMAGE_TYPE_UNIVERSAL = 0
    i = 0
    while true do
        if ((i > 1)) then break end
        udg_DamageTypeDebugStr[i] = ""
        i = __jint(i + 1)
    end
    udg_DEFENSE_TYPE_LIGHT = 0
    udg_DEFENSE_TYPE_MEDIUM = 0
    udg_DEFENSE_TYPE_HEAVY = 0
    udg_DEFENSE_TYPE_FORTIFIED = 0
    udg_DEFENSE_TYPE_NORMAL = 0
    udg_DEFENSE_TYPE_HERO = 0
    udg_DEFENSE_TYPE_DIVINE = 0
    udg_DEFENSE_TYPE_UNARMORED = 0
    i = 0
    while true do
        if ((i > 1)) then break end
        udg_DefenseTypeDebugStr[i] = ""
        i = __jint(i + 1)
    end
    i = 0
    while true do
        if ((i > 1)) then break end
        udg_WeaponTypeDebugStr[i] = ""
        i = __jint(i + 1)
    end
    udg_WEAPON_TYPE_NONE = 0
    udg_WEAPON_TYPE_ML_CHOP = 0
    udg_WEAPON_TYPE_MM_CHOP = 0
    udg_WEAPON_TYPE_MH_CHOP = 0
    udg_WEAPON_TYPE_ML_SLICE = 0
    udg_WEAPON_TYPE_MM_SLICE = 0
    udg_WEAPON_TYPE_MH_SLICE = 0
    udg_WEAPON_TYPE_MM_BASH = 0
    udg_WEAPON_TYPE_MH_BASH = 0
    udg_WEAPON_TYPE_MM_STAB = 0
    udg_WEAPON_TYPE_MH_STAB = 0
    udg_WEAPON_TYPE_WL_SLICE = 0
    udg_WEAPON_TYPE_WM_SLICE = 0
    udg_WEAPON_TYPE_WH_SLICE = 0
    udg_WEAPON_TYPE_WL_BASH = 0
    udg_WEAPON_TYPE_WM_BASH = 0
    udg_WEAPON_TYPE_WH_BASH = 0
    udg_WEAPON_TYPE_WL_STAB = 0
    udg_WEAPON_TYPE_WM_STAB = 0
    udg_WEAPON_TYPE_CL_SLICE = 0
    udg_WEAPON_TYPE_CM_SLICE = 0
    udg_WEAPON_TYPE_CH_SLICE = 0
    udg_WEAPON_TYPE_AM_CHOP = 0
    udg_WEAPON_TYPE_RH_BASH = 0
    udg_XPperSecond = 0
    udg_BannedAncientSpace = __jreal(0)
    udg_Dutchmen = CreateGroup()
    i = 0
    while true do
        if ((i > 12)) then break end
        udg_PlayerColorHex[i] = ""
        i = __jint(i + 1)
    end
    udg_ThunderstruckLevel = 0
    FE_Roles.setAncient(Player(FE_Roles.initialAncientSlot))
    udg_StillAlive = 0
    udg_Ziggurats = CreateGroup()
    udg_AuraLevel = 0
    udg_Ziggurats_Count = 0
    udg_BannedElf = __jreal(0)
    udg_ShadowDancers = CreateGroup()
    udg_SeedPlayedNumber = 0
    i = 0
    while true do
        if ((i > 11)) then break end
        udg_DeepWater1[i] = false
        i = __jint(i + 1)
    end
    udg_BannedHighElf = __jreal(0)
    i = 0
    while true do
        if ((i > 11)) then break end
        udg_ExperienceRate[i] = __jreal(100.00)
        i = __jint(i + 1)
    end
    i = 0
    while true do
        if ((i > 11)) then break end
        udg_SilentStrider[i] = false
        i = __jint(i + 1)
    end
    udg_TSEUnitAliveCheck = false
    udg_TSE__RemainingDuration = __jreal(0)
    udg_TSE__ActiveIndex = 0
    udg_TSE_TIMEOUT = __jreal(0)
    i = 0
    while true do
        if ((i > 1)) then break end
        udg_TSE_I_RemainingDuration[i] = __jreal(0)
        i = __jint(i + 1)
    end
    i = 0
    while true do
        if ((i > 1)) then break end
        udg_TSE_I_ChanneledOrderID[i] = ""
        i = __jint(i + 1)
    end
    i = 0
    while true do
        if ((i > 1)) then break end
        udg_TSE_I_IsChanneling[i] = false
        i = __jint(i + 1)
    end
    i = 0
    while true do
        if ((i > 1)) then break end
        udg_TSE_I_TargetUnitAliveCheck[i] = false
        i = __jint(i + 1)
    end
    i = 0
    while true do
        if ((i > 1)) then break end
        udg_TSE_I_SourceUnitAliveCheck[i] = false
        i = __jint(i + 1)
    end
    i = 0
    while true do
        if ((i > 1)) then break end
        udg_TSE_I_OnLoopTimer[i] = __jreal(0)
        i = __jint(i + 1)
    end
    i = 0
    while true do
        if ((i > 1)) then break end
        udg_TSE_I_LoopDuration[i] = __jreal(0)
        i = __jint(i + 1)
    end
    i = 0
    while true do
        if ((i > 1)) then break end
        udg_TSE_I_ActiveInstance[i] = false
        i = __jint(i + 1)
    end
    i = 0
    while true do
        if ((i > 1)) then break end
        udg_TSE_I_LockInstance[i] = false
        i = __jint(i + 1)
    end
    udg_TSE_MaxIndex = 0
    udg_TSE_ReplacementIndex = 0
    udg_TSE_ReplacementIndexFound = false
    udg_TSE_MaxCheckOver = false
    udg_TSE_MaxRecursion = 0
    udg_TSE_Recursion = 0
    udg_TSE_Index = 0
    udg_TSE_CTimer = CreateTimer()
    udg_TSETargetUnitAliveCheck = false
    udg_TSESourceUnitAliveCheck = false
    udg_TSEEffectName = ""
    udg_TSEAttachPoint = ""
    udg_TSEDuration = __jreal(0)
    udg_TSEScale = __jreal(0)
    udg_TSEChanneledOrderID = ""
    udg_TSEOnLoopTimer = __jreal(0)
    udg_TSELockInstance = false
    udg_Acided = CreateGroup()
    udg_BannedRatling = __jreal(0)
    udg_TreeChopper = "|cff456d46-chopoff|r"
    udg_Tradeoff = "|cff456d46-tradeoff|r"
    udg_Counterstring = ""
    udg_IntSeconds = 0
    udg_IntMinutes = 0
    udg_IntHours = 0
    udg_StringSeconds = ""
    udg_StringMinutes = ""
    udg_BannedHunter = __jreal(0)
    i = 0
    while true do
        if ((i > 11)) then break end
        udg_Multiboard_Spot[i] = 0
        i = __jint(i + 1)
    end
    i = 0
    while true do
        if ((i > 1)) then break end
        udg_Flags[i] = false
        i = __jint(i + 1)
    end
    udg_BannedAncientWind = __jreal(0)
    udg_StartupDialog = DialogCreate()
end

-- Original JASS function: InitCustomTriggers (line 20434)
function FE_InitCustomTriggers()
    InitTrig_Damage_Engine_Config()
    InitTrig_TSEConfig()
    InitTrig_TSERegister()
    InitTrig_TSELoop()
    InitTrig_TSEEmptyEvent()
    InitTrig_Map_Ini_Testing()
    InitTrig_Counter_Testing()
    InitTrig_Start_Counter()
    InitTrig_Counter()
    InitTrig_Tradeoff_Detection()
    InitTrig_TreeChopper_Detection()
    InitTrig_Takeover()
    InitTrig_Enable_Overdrive()
    InitTrig_Disable_Overdrive()
    InitTrig_Death()
    InitTrig_Hardmode()
    InitTrig_Categorization()
    InitTrig_Fountain_Heal()
    InitTrig_Ancient_In_Combat()
    InitTrig_AutoFeedRate()
    InitTrig_TimeToAncientSpawn_Copy()
    InitTrig_FeedReduction()
    InitTrig_SetFeed()
    InitTrig_CheckFeedRates()
    InitTrig_Detonate()
    InitTrig_Expander_Hero_XP()
    InitTrig_Snipe_Shot()
    InitTrig_Dash()
    InitTrig_Rome()
    InitTrig_Basic_Bounty_Hit()
    InitTrig_Improved_Bounty_Hit()
    InitTrig_Harvest_Grapes()
    InitTrig_Bullets_Switch()
    InitTrig_Limb_Throw()
    InitTrig_Flesh_Stampede()
    InitTrig_Amalgamation()
    InitTrig_Merge()
    InitTrig_Husk_Detection()
    InitTrig_Death_Jump()
    InitTrig_Map_Start()
    InitTrig_Day()
    InitTrig_Night()
    InitTrig_Iron_Hoove()
    InitTrig_Lightning_Strike_TowerVers()
    InitTrig_Blizzard()
    InitTrig_ShovelStrikelevelup()
    InitTrig_Deepwater_1()
    InitTrig_Deepwater_2()
    InitTrig_Genesis()
    InitTrig_ConjureRefreshment()
    InitTrig_ShadowDancers()
    InitTrig_Mana_Burn()
    InitTrig_Mana_Steal_Dancer()
    InitTrig_Mana_Steal_Mages()
    InitTrig_ConjureMana()
    InitTrig_Blur()
    InitTrig_Ghoul_Units()
    InitTrig_Ghoul_lumber()
    InitTrig_Dutchmen_Trained()
    InitTrig_Dutchmen()
    InitTrig_Vampiric_Wyrm()
    InitTrig_Soul_Hammer()
    InitTrig_Coup_de_grace()
    InitTrig_Surge_of_Darkness()
    InitTrig_Focused_Anger_1()
    InitTrig_Focused_Anger_2()
    InitTrig_Focused_Anger_3()
    InitTrig_Focused_Anger_4()
    InitTrig_Focused_Anger_5()
    InitTrig_Focused_Anger_6()
    InitTrig_Focused_Anger_7()
    InitTrig_Focused_Anger_8()
    InitTrig_Focused_Anger_9()
    InitTrig_Focused_Anger_10()
    InitTrig_Focused_Anger_Trigger()
    InitTrig_Focused_Anger_Trigger_Copy()
    InitTrig_Focused_Anger_Trigger_Copy_2()
    InitTrig_Focused_Anger_Trigger_Copy_3()
    InitTrig_Focused_Anger_Trigger_Copy_4()
    InitTrig_Focused_Anger_Trigger_Copy_5()
    InitTrig_Focused_Anger_Trigger_Copy_6()
    InitTrig_Focused_Anger_Trigger_Copy_7()
    InitTrig_Focused_Anger_Trigger_Copy_8()
    InitTrig_Focused_Anger_Trigger_Copy_9()
    InitTrig_Feast_of_Souls()
    InitTrig_Soul_Strike()
    InitTrig_Avatar()
    InitTrig_Acidic_Blood()
    InitTrig_Binding_Shadows()
    InitTrig_Cobalt_Blood()
    InitTrig_Glowing_Blood()
    InitTrig_Psychic_Slam()
    InitTrig_Soul_Rend()
    InitTrig_Dark_Blood()
    InitTrig_Shadowlings()
    InitTrig_Levelled_Drain()
    InitTrig_Levelled_Drain_Copy()
    InitTrig_Levelled_Drain_Copy_2()
    InitTrig_Levelled_Drain_Copy_3()
    InitTrig_Levelled_Drain_Copy_4()
    InitTrig_Levelled_Drain_Copy_5()
    InitTrig_Levelled_Drain_Copy_6()
    InitTrig_Levelled_Drain_Copy_7()
    InitTrig_Levelled_Drain_Copy_8()
    InitTrig_Levelled_Drain_Copy_9()
    InitTrig_Drain_Setup()
    InitTrig_Drain_Cast()
    InitTrig_Drain_Loop()
    InitTrig_Levelled_Slam()
    InitTrig_Levelled_Slam_Copy()
    InitTrig_Levelled_Slam_Copy_2()
    InitTrig_Levelled_Slam_Copy_3()
    InitTrig_Levelled_Slam_Copy_4()
    InitTrig_Levelled_Slam_Copy_5()
    InitTrig_Levelled_Slam_Copy_6()
    InitTrig_Levelled_Slam_Copy_7()
    InitTrig_Levelled_Slam_Copy_8()
    InitTrig_Levelled_Slam_Copy_9()
    InitTrig_LevelUpAura()
    InitTrig_DowngradeAura()
    InitTrig_NerubianSpires()
    InitTrig_Frenzy()
    InitTrig_Chemical_Rage()
    InitTrig_ReduceMagicResist()
    InitTrig_ReduceMagicResist2()
    InitTrig_TargetAcquired()
    InitTrig_Poisoned_Bullets2()
    InitTrig_Poisoned_Bullets()
    InitTrig_Permanent_Invisibility()
    InitTrig_Permanent_Invisibility_2()
    InitTrig_Sticky_Glue()
    InitTrig_Wood_Income()
    InitTrig_Enter_Wood_Income()
    InitTrig_SeedOfRebirth()
    InitTrig_Ancient_Artifact()
    InitTrig_Moonstrike()
    InitTrig_Moonstrike_Leveled()
    InitTrig_Moonblast()
    InitTrig_Moonblast_Leveled()
    InitTrig_Lunar_Assault()
    InitTrig_Lunar_Assault_Leveled()
    InitTrig_Cascade_Leveled()
    InitTrig_Nourish()
    InitTrig_Nourish_Leveled()
    InitTrig_Solar_Blast()
    InitTrig_Natural_Vigil_Leveled()
    InitTrig_Lifebloom_Leveled()
    InitTrig_Suns_Fury()
    InitTrig_Return_lumber()
    InitTrig_Slash_Leveled()
    InitTrig_Bleed_Leveled()
    InitTrig_Focused_Strike()
    InitTrig_FanOfKnivesBasedSpells()
    InitTrig_Realm_of_darkness()
    InitTrig_Realm_of_darkness_2()
    InitTrig_Thunderstruck()
    InitTrig_Lightning_Strike()
    InitTrig_RecallStart()
    InitTrig_Recall()
    InitTrig_Time_warp()
    InitTrig_Galactic_Fury()
    InitTrig_Galactic_Fury_2()
    InitTrig_Galactic_Fury_3()
    InitTrig_Cosmic_Strike()
    InitTrig_Cosmic_Strike_2()
    InitTrig_Cosmic_Strike_3()
    InitTrig_Resillience()
    InitTrig_Resillience_2()
    InitTrig_Resillience_3()
    InitTrig_Sandstorm()
    InitTrig_Sandstorm_2()
    InitTrig_Ancient_Grasp()
    InitTrig_Deserts_Veil()
    InitTrig_Chill()
    InitTrig_Freeze_Zone()
    InitTrig_Freeze_Zone_V2()
    InitTrig_Sadism()
    InitTrig_Reckoning()
    InitTrig_Vanguard_Initial()
    InitTrig_Vanguard_Future_Levels()
    InitTrig_Vanguard()
    InitTrig_Omniscience_Initial()
    InitTrig_Omniscience_FL()
    InitTrig_Omniscience()
    InitTrig_Redemption()
    InitTrig_WindWalkWispari()
    InitTrig_TornadoMove()
    InitTrig_Sit_tight()
    InitTrig_ClearOnEsc()
    InitTrig_InitialText()
    InitTrig_Welcome()
    InitTrig_Info_Copy()
    InitTrig_Info()
    InitTrig_Ping_Hint()
    InitTrig_Hint2x2()
    InitTrig_HintInvisibility()
    InitTrig_HintFeed()
    InitTrig_Resource_Hint()
    InitTrig_Ping()
    InitTrig_PingForAncient()
    InitTrig_AncientSpells()
    InitTrig_Start()
    InitTrig_Hard_mode_on()
    InitTrig_Hard_Attack()
    InitTrig_Hard_Attack_Cont()
    InitTrig_Hard_attack_2()
    InitTrig_Select()
    InitTrig_Attack()
    InitTrig_Run_away()
    InitTrig_Slot1_Righteous_Armor()
    InitTrig_Slot2_Valor_Helmet()
    InitTrig_Slot3_Bladed_Gauntlet()
    InitTrig_Slot4_Bladed_Gauntlet()
    InitTrig_Slot5_Bladed_Gauntlet()
    InitTrig_Slot6_Bladed_Gauntlet()
    InitTrig_Level_Up_Tomes()
    InitTrig_Abilities()
    InitTrig_Staff_of_insight_pickup()
    InitTrig_Dusts_Slow()
    InitTrig_Firelords_Cape_usage()
    InitTrig_Firelords_Cape_pickup()
    InitTrig_Bladed_Gauntlet_vs_Hero()
    InitTrig_Cast_CL_on_Banish()
    InitTrig_Ledgers_XP()
    InitTrig_Ledger_of_Clarity_pickup()
    InitTrig_Ledger_of_Clarity_lose()
    InitTrig_Ledger_of_Enlightment_pickup()
    InitTrig_Ledger_of_Enlightment_lose()
    InitTrig_Spellcasters_Cloak()
    InitTrig_Ethereal_Scepter()
    InitTrig_Firelords_Cape()
    InitTrig_Ledget_of_Enlightment()
    InitTrig_Hammer_of_might()
    InitTrig_Valorous_Helmet()
    InitTrig_Bladed_Gauntlet()
    InitTrig_Righteous_Armor()
    InitTrig_Arcanum_of_Hatred()
    InitTrig_Bleeding_Scythe()
    InitTrig_Staff_of_Insight()
    InitTrig_Cosmic_Orb()
    InitTrig_Level_up()
    InitTrig_Deliver_Gold()
    InitTrig_Worgens_gold()
    InitTrig_Bounty()
    InitTrig_Remove_Ancient_Lumber()
    InitTrig_Ancient_Gold_income()
    InitTrig_Initialization()
    InitTrig_LimitedTraining()
    InitTrig_TimeToExpanderSpawn()
    InitTrig_TimeToAncientSpawn()
    InitTrig_Unit_Indexer()
    InitTrig_Spellbringers_spells()
    InitTrig_Give_orb()
    InitTrig_Colors()
    InitTrig_Name_Change()
    InitTrig_Name_Change_III()
    InitTrig_RandomExpander()
    InitTrig_RandomExpander2()
    InitTrig_Random_Ancient()
    InitTrig_Remove_Selection()
    InitTrig_Remove_Selector()
    InitTrig_Trade_disabled()
    InitTrig_Trade_enabled()
    InitTrig_Disable_trade_enabled()
    InitTrig_Spawn_Races()
    InitTrig_Spawn_Ancients()
    InitTrig_DisableExpanderBans()
    InitTrig_Worgen()
    InitTrig_Centaur()
    InitTrig_Wildkin()
    InitTrig_Nerubian()
    InitTrig_Human()
    InitTrig_Wisp()
    InitTrig_Kobold()
    InitTrig_Ghoul()
    InitTrig_Kraken()
    InitTrig_Aethyr()
    InitTrig_Forgotten()
    InitTrig_Goblin()
    InitTrig_Ogre()
    InitTrig_Magmide()
    InitTrig_Furbolg()
    InitTrig_Razormane()
    InitTrig_Elf()
    InitTrig_HighElf()
    InitTrig_Ratling()
    InitTrig_Hunter()
    InitTrig_AncientLight()
    InitTrig_AncientLightning()
    InitTrig_AncientDragon()
    InitTrig_AncientEarth()
    InitTrig_AncientDarkness()
    InitTrig_AncientIce()
    InitTrig_AncientFire()
    InitTrig_AncientNature()
    InitTrig_AncientSand()
    InitTrig_AncientSpace()
    InitTrig_AncientWind()
    InitTrig_Prevent_Attack()
    InitTrig_No_Attacking_Shops_Copy_3()
    InitTrig_No_Attacking_Shops_Copy_2()
    InitTrig_No_Attacking_Shops_Copy()
    InitTrig_No_Attacking_Shops()
    InitTrig_Ally_neutral()
    InitTrig_Vision()
    InitTrig_Death_anim()
    InitTrig_Quests()
    InitTrig_Warning_few_seconds()
    InitTrig_Camera_Copy()
    InitTrig_LatePickers()
    InitTrig_AncientSpawnTele()
    InitTrig_Player_group()
    InitTrig_Lackey_Respawn()
    InitTrig_Death_start()
    InitTrig_Spawn_Lackey()
    InitTrig_MiniMinis()
    InitTrig_Player_Leaves()
    InitTrig_Ancient_Leaves()
    InitTrig_Human_Dies()
    InitTrig_Wisp_Dies()
    InitTrig_Centaur_Dies()
    InitTrig_Ogre_Dies()
    InitTrig_Worgen_Dies()
    InitTrig_Night_Elf_Dies()
    InitTrig_Shadow_Dancer_Dies()
    InitTrig_Archdruid_Dies()
    InitTrig_Engineer_Highelf_Dies()
    InitTrig_Bounty_Hunter_Dies()
    InitTrig_Ghoul_Dies()
    InitTrig_Magmide_Dies()
    InitTrig_Goblin_Dies()
    InitTrig_Ratling_Dies()
    InitTrig_Goblin_Ultima_Dies()
    InitTrig_Furbolg_Shaman_Dies()
    InitTrig_Furbolg_Warrior_Dies()
    InitTrig_Furbolg_Dies()
    InitTrig_Nerubian_Dies()
    InitTrig_Kraken_Dies()
    InitTrig_Aethyr_Warp_Dies()
    InitTrig_Kobold_Dies()
    InitTrig_Razormane_Dies()
    InitTrig_Wildkin_Dies()
    InitTrig_Forgotten_One_Dies()
    InitTrig_Forgotten_Bloodmage_Dies()
    InitTrig_Forgotten_Executioner_Dies()
    InitTrig_Forgotten_Soulreaper_Dies()
    InitTrig_Ignite_Dies()
    InitTrig_Avalanche_Dies()
    InitTrig_Paranoia_Dies()
    InitTrig_Eternity_Dies()
    InitTrig_Dragos_Dies()
    InitTrig_Tremor_Dies()
    InitTrig_Zalxon_Dies()
    InitTrig_Divinity_Dies()
    InitTrig_Pharoah_Dies()
    InitTrig_Nebula_Dies()
    InitTrig_Wispari_Dies()
    InitTrig_Remove_Resources_new()
    InitTrig_DVIC_1()
    InitTrig_Ext_On()
    InitTrig_Extermination()
    InitTrig_Base_List_Init()
    InitTrig_Flagstack_Deny()
    InitTrig_Flag_no_base_Deny()
    InitTrig_NewFlag()
    InitTrig_NewFlag2()
    InitTrig_NewFlag3()
    InitTrig_NewFlag4()
    InitTrig_NewFlag5()
    InitTrig_Gobo_Mech_Blaster_pickup()
    InitTrig_Gobo_Mech_Blaster_attack_check()
end

-- Original JASS function: RunInitializationTriggers (line 20813)
function FE_RunInitializationTriggers()
    ConditionalTriggerExecute(gg_trg_Damage_Engine_Config)
    ConditionalTriggerExecute(gg_trg_TSEConfig)
    ConditionalTriggerExecute(gg_trg_Drain_Setup)
    ConditionalTriggerExecute(gg_trg_NerubianSpires)
    ConditionalTriggerExecute(gg_trg_InitialText)
    ConditionalTriggerExecute(gg_trg_Start)
    ConditionalTriggerExecute(gg_trg_Deliver_Gold)
    ConditionalTriggerExecute(gg_trg_Bounty)
    ConditionalTriggerExecute(gg_trg_Initialization)
    ConditionalTriggerExecute(gg_trg_LimitedTraining)
    ConditionalTriggerExecute(gg_trg_Unit_Indexer)
    ConditionalTriggerExecute(gg_trg_Colors)
    ConditionalTriggerExecute(gg_trg_RandomExpander)
    ConditionalTriggerExecute(gg_trg_Ally_neutral)
    ConditionalTriggerExecute(gg_trg_Vision)
    ConditionalTriggerExecute(gg_trg_Quests)
    ConditionalTriggerExecute(gg_trg_Player_group)
end
