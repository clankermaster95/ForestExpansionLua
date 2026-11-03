-- Forest Expansion Lua port: generated map script. Edit src/, or save in World Editor.
-- BEGIN FOREST MODULE src/runtime.lua
-- Compatibility operations used by the typed JASS port. Lua 5.3+.
-- Keep engine natives and handle IDs supplied by Warcraft III.
local __forestInt32 = math.maxinteger == 2147483647
local __forestReal32 = (16777216.0 + 1.0) == 16777216.0

function __jint(value)
    -- Warcraft uses 32-bit Lua numbers; the standalone tools may use 64-bit.
    if __forestInt32 then return value | 0 end
    value = value & 0xffffffff
    if value >= 0x80000000 then return value - 0x100000000 end
    return value
end

function __jreal(value)
    -- Coerce integers to real even when the VM already uses binary32.
    -- The game path does not depend on string.pack/unpack or their save state.
    if __forestReal32 then return value + 0.0 end
    -- Standard standalone Lua uses wider floating-point numbers.
    return (string.unpack("f", string.pack("f", value)))
end

function __jdiv(a, b)
    -- Lua // rounds down, while JASS integer division truncates toward zero.
    if b == 0 then error("JASS integer division by zero", 2) end
    -- Avoid abs(INT_MIN), which cannot be represented by a signed 32-bit int.
    local quotient = a // b
    if a % b ~= 0 and (a < 0) ~= (b < 0) then quotient = quotient + 1 end
    return __jint(quotient)
end

function __jarray(default)
    return setmetatable({}, {__index = function() return default end})
end

function __jconcat(a, b)
    return (a or "") .. (b or "")
end
-- END FOREST MODULE src/runtime.lua

-- BEGIN FOREST MODULE src/globals.lua
-- Original global declarations, in their original order.
LIBRARY_DamageEngine = true
DamageEngine___USE_GUI = true
DamageEngine___USE_SCALING = DamageEngine___USE_GUI
DamageEngine___USE_EXTRA = true
DamageEngine___USE_ARMOR_MOD = true
DamageEngine___USE_MELEE_RANGE = true
DamageEngine___USE_LETHAL = true
DamageEngine___MAX_RECURSIVE_TOLERANCE = 16
DamageEngine_TYPE_CODE = 1
DamageEngine_TYPE_PURE = 2
DamageEngine___DEATH_VAL = __jreal(0.405)
DamageEngine___async = nil
DamageEngine___timerStarted = false
DamageEngine___lastInstance = 0
DamageEngine___isNotNativeRecursiveDamage = true
DamageEngine___waitingForDamageEventToRun = false
DamageEngine___attacksImmune = __jarray(false)
DamageEngine___damagesImmune = __jarray(false)
DamageEngine___damagingTrigger = nil
DamageEngine___damagedTrigger = nil
DamageEngine___recursiveTrigger = nil
DamageEngine_FILTER_ATTACK = 0
DamageEngine_FILTER_MELEE = 1
DamageEngine_FILTER_OTHER = 2
DamageEngine_FILTER_RANGED = 3
DamageEngine_FILTER_SPELL = 4
DamageEngine_FILTER_CODE = 5
DamageEngine_FILTER_MAX = 6
DamageEngine___eventFilter = DamageEngine_FILTER_OTHER
DamageEngine_inception = false
DamageEngine___callbacksInProgress = false
DamageEngine___recursiveCallbackDepth = 0
DamageEngine___recursionSources = nil
DamageEngine___recursionTargets = nil
DamageEngine___recursiveCallbaksInProgress = false
DamageEngine___nativeEventsCompleted = false
DamageEngine___atLeastOneLethalDamageEventRegistered = false
LIBRARY_PassiveMissiles = true
PassiveMissiles__PM_ABILITY_ID = FourCC("A0EP")
PassiveMissiles__PM_TORNADO_UNIT_ID = FourCC("ntor")
PassiveMissiles__PM_RANGE = __jreal(400.00)
PassiveMissiles__PM_DAMAGE = __jreal(60.00)
PassiveMissiles__PM_STRUCTURE_DAMAGE_MULTIPLIER = __jreal(0.50)
PassiveMissiles__PM_PERIOD = __jreal(1.00)
PassiveMissiles__PM_LAUNCH_DELAY = __jreal(0.12)
PassiveMissiles__PM_SPEED = __jreal(500.00)
PassiveMissiles__PM_TICK = __jreal(0.03125)
PassiveMissiles__PM_HEIGHT = __jreal(70.00)
PassiveMissiles__PM_MODEL_SCALE = __jreal(0.40)
PassiveMissiles__PM_MODEL = "war3mapImported\\SilentTornadoElemental.mdx"
PassiveMissiles__PM_LOOP_SOUND_FILE = "Abilities\\Spells\\NightElf\\Cyclone\\CycloneLoop1.flac"
PassiveMissiles__PM_DEATH_SOUND_FILE = "Abilities\\Spells\\NightElf\\Cyclone\\CycloneDeath1.flac"
PassiveMissiles__PM_LOOP_SOUND_VOLUME = 90
PassiveMissiles__PM_DEATH_SOUND_VOLUME = 55
PassiveMissiles__PM_SOUND_MIN_DIST = __jreal(600.00)
PassiveMissiles__PM_SOUND_MAX_DIST = __jreal(3000.00)
PassiveMissiles__PM_SOUND_FADE_IN_RATE = 1
PassiveMissiles__PM_SOUND_FADE_OUT_RATE = 1
PassiveMissiles__PM_KEY_VOLLEY_CASTER = 0
PassiveMissiles__PM_KEY_VOLLEY_REMAINING = 1
PassiveMissiles__PM_KEY_TORNADO_OWNER = 100
PassiveMissiles__PM_KEY_TORNADO_BASE_LEVEL = 101
PassiveMissiles__PM_Casters = CreateGroup()
PassiveMissiles__PM_EnumGroup = CreateGroup()
PassiveMissiles__PM_CastTimer = CreateTimer()
PassiveMissiles__PM_MoveTimer = CreateTimer()
PassiveMissiles__PM_Hash = InitHashtable()
PassiveMissiles__PM_Source = nil
PassiveMissiles__PM_Count = 0
PassiveMissiles__PM_Fx = __jarray(nil)
PassiveMissiles__PM_Sound = __jarray(nil)
PassiveMissiles__PM_Caster = __jarray(nil)
PassiveMissiles__PM_DamageSource = __jarray(nil)
PassiveMissiles__PM_Target = __jarray(nil)
PassiveMissiles__PM_X = __jarray(0.0)
PassiveMissiles__PM_Y = __jarray(0.0)
PassiveMissiles__PM_Z = __jarray(0.0)
LIBRARY_SpellLeech = true
SpellLeech__SL_ABILITY_ID = FourCC("A0ES")
SpellLeech__SL_BASE_DURATION = __jreal(3.00)
SpellLeech__SL_DURATION_PER_LEVEL = __jreal(3.00)
SpellLeech__SL_LEECH_FACTOR = __jreal(0.50)
SpellLeech__SL_ENEMY_ONLY = true
SpellLeech__SL_REQUIRE_NON_ATTACK = true
SpellLeech__SL_REQUIRE_DAMAGE_TYPE_MAGIC = false
SpellLeech__SL_ACTIVATE_EFFECT = "Abilities\\Spells\\Items\\AIre\\AIreTarget.mdl"
SpellLeech__SL_HEAL_EFFECT = "Abilities\\Spells\\Human\\Heal\\HealTarget.mdl"
SpellLeech__SL_SHOW_HEAL_EFFECT = false
SpellLeech__SL_Clock = CreateTimer()
SpellLeech__SL_Hash = InitHashtable()
udg_Units = __jarray(0)
udg_Point1 = nil
udg_Gold = 0
udg_Selectors = 0
udg_Ancients = __jarray(0)
udg_Moveto = __jarray(nil)
udg_Razormane = nil
udg_Aethyr = nil
udg_AncientKills = nil
udg_UDex = 0
udg_UDexRecycle = 0
udg_UDexNext = __jarray(0)
udg_UDexGen = 0
udg_UDexUnits = __jarray(nil)
udg_UDexPrev = __jarray(0)
udg_UnitIndexEvent = __jreal(0)
udg_UnitIndexerEnabled = false
udg_UDexWasted = 0
udg_ncld_Ability = 0
udg_ncld_DrainHP = __jreal(0)
udg_ncld_DrainHPUp = __jreal(0)
udg_ncld_DrainMP = __jreal(0)
udg_ncld_DrainMPUp = __jreal(0)
udg_ncld_Duration = __jreal(0)
udg_ncld_Duration_Up = __jreal(0)
udg_ncld_Range = __jreal(0)
udg_ncld_RangeUp = __jreal(0)
udg_ncld_LightningArt = nil
udg_ncld_TargetSFXArt = nil
udg_ncld_CasterSFXArt = nil
udg_ncld_FreqDrain = 0
udg_ncld_FreqDistance = 0
udg_ncld_EtherealBonus = __jreal(0)
udg_ncld_buffId = 0
udg_ncld_BuffList = __jarray(0)
udg_ncld_CheckImmune = false
udg_ncld_CheckResistant = false
udg_ncld_CheckVisibile = false
udg_tempReal = __jreal(0)
udg_tempUnit = nil
udg_Key = 0
udg_ncld_Target = __jarray(nil)
udg_ncld_Group = nil
udg_ncld_Tick = __jarray(0)
udg_ncld_TicksRemaining = __jarray(0)
udg_ncld_Hp = __jarray(0.0)
udg_ncld_Mp = __jarray(0.0)
udg_ncld_Rng = __jarray(0.0)
udg_tempLoc1 = nil
udg_ncld_CasterSFX = __jarray(nil)
udg_ncld_TargetSFX = __jarray(nil)
udg_ncld_Lightning = __jarray(nil)
udg_tempLoc2 = nil
udg_CheckBool = false
udg_LoopBuffs = 0
udg_tempDistance = __jreal(0)
udg_tempX1 = __jreal(0)
udg_tempX2 = __jreal(0)
udg_tempY1 = __jreal(0)
udg_tempY2 = __jreal(0)
udg_tempZ1 = __jreal(0)
udg_tempZ2 = __jreal(0)
udg_VanguardHeal = __jreal(0)
udg_Omni = 0
udg_Div = nil
udg_Hardunit = nil
udg_RemSel = nil
udg_FZ = nil
udg_LS = nil
udg_AncientUnit = nil
udg_AncientInCombat = __jreal(0)
udg_Bans = 0
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
udg_ExpanderSpawnTimer = nil
udg_AncientSpawnTimer = nil
udg_MoonTar = nil
udg_MoonCast = nil
udg_LunTar = nil
udg_LunCast = nil
udg_BlastTar = nil
udg_BlastCast = nil
udg_WispRez = 0
udg_WispRezU = nil
udg_Seed = 0
udg_SeedP = nil
udg_SeedO = nil
udg_SeedR = nil
udg_Wisp = nil
udg_Ledger = nil
udg_BannedAncientSand = __jreal(0)
udg_Flag = nil
udg_HumanFlag = nil
udg_KrakenFlag = nil
udg_OgreFlag = nil
udg_GhoulFlag = nil
udg_AethyrFlag = nil
udg_CentaurFlag = nil
udg_RazormaneFlag = nil
udg_WispFlag = nil
udg_Cascade = 0
udg_Resillence = __jreal(0)
udg_ResillienceLvler = nil
udg_CosmicStrikeCaster = nil
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
udg_DamageEventSource = nil
udg_DamageEventTarget = nil
udg_DamageEventPrevAmt = __jreal(0)
udg_AOEDamageSource = nil
udg_EnhancedDamageTarget = nil
udg_DamageEventLevel = 0
udg_DamageEventAOE = 0
udg_DamageEventAOEGroup = nil
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
udg_DamageFilterSource = nil
udg_DamageFilterTarget = nil
udg_DamageFilterAttackT = 0
udg_DamageFilterDamageT = 0
udg_DamageFilterSourceT = 0
udg_DamageFilterTargetT = 0
udg_DamageFilterSourceB = 0
udg_DamageFilterTargetB = 0
udg_DamageFilterType = 0
udg_DamageFilterMinAmount = __jreal(0)
udg_DamageFilterRunChance = __jreal(0)
udg_DamageFilterFailChance = __jreal(0)
udg_DamageFilterSourceA = 0
udg_DamageFilterTargetA = 0
udg_DamageFilterTargetI = 0
udg_DamageFilterSourceI = 0
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
udg_ArmorTypeDebugStr = __jarray(nil)
udg_CONVERTED_ATTACK_TYPE = __jarray(nil)
udg_ATTACK_TYPE_SPELLS = 0
udg_ATTACK_TYPE_NORMAL = 0
udg_ATTACK_TYPE_PIERCE = 0
udg_ATTACK_TYPE_SIEGE = 0
udg_ATTACK_TYPE_MAGIC = 0
udg_ATTACK_TYPE_CHAOS = 0
udg_ATTACK_TYPE_HERO = 0
udg_AttackTypeDebugStr = __jarray(nil)
udg_DamageTypeBlocked = 0
udg_DamageTypeCriticalStrike = 0
udg_DamageTypeCode = 0
udg_DamageTypeExplosive = 0
udg_DamageTypeHeal = 0
udg_DamageTypePure = 0
udg_DamageTypePureExplosive = 0
udg_DamageTypeReduced = 0
udg_CONVERTED_DAMAGE_TYPE = __jarray(nil)
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
udg_DamageTypeDebugStr = __jarray(nil)
udg_DEFENSE_TYPE_LIGHT = 0
udg_DEFENSE_TYPE_MEDIUM = 0
udg_DEFENSE_TYPE_HEAVY = 0
udg_DEFENSE_TYPE_FORTIFIED = 0
udg_DEFENSE_TYPE_NORMAL = 0
udg_DEFENSE_TYPE_HERO = 0
udg_DEFENSE_TYPE_DIVINE = 0
udg_DEFENSE_TYPE_UNARMORED = 0
udg_DefenseTypeDebugStr = __jarray(nil)
udg_WeaponTypeDebugStr = __jarray(nil)
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
udg_GalacticFuryCaster = nil
udg_TimeWarp = nil
udg_TimeWarpCaster = nil
udg_WorgenAttack = nil
udg_XPperSecond = 0
udg_BannedAncientSpace = __jreal(0)
udg_Dutchmen = nil
udg_Temp_Point = nil
udg_PlayerColorHex = __jarray(nil)
udg_DeadPlayer = nil
udg_LocationOfDeath = nil
udg_ThunderstruckTarget = nil
udg_ThunderstruckLevel = 0
udg_AncientPlayer = nil
udg_Lackey = 0
udg_StillAlive = 0
udg_Ziggurats = nil
udg_AuraLevel = 0
udg_Ziggurats_Count = 0
udg_BannedElf = __jreal(0)
udg_ShadowDancers = nil
udg_RecallTarget = nil
udg_SeedOfRebirth = __jarray(0)
udg_SeedUnitPosition = nil
udg_SeedPlayedNumber = 0
udg_DeepWater1 = __jarray(false)
udg_BannedHighElf = __jreal(0)
udg_ExperienceRate = __jarray(0.0)
udg_SilentStrider = __jarray(false)
udg_TSEUnit = nil
udg_TSEUnitAliveCheck = false
udg_TSE__RemainingDuration = __jreal(0)
udg_TSE__ActiveIndex = 0
udg_TSE__TargetUnit = nil
udg_TSE__SourceUnit = nil
udg_TSE__Point = nil
udg_TSE__SpecialEffect = nil
udg_TSE_LoopTrigger = nil
udg_TSE_RegisterTrigger = nil
udg_TSE_TIMEOUT = __jreal(0)
udg_TSE_I_RemainingDuration = __jarray(0.0)
udg_TSE_I_Effect = __jarray(nil)
udg_TSE_I_ChanneledOrderID = __jarray(nil)
udg_TSE_I_SourceUnit = __jarray(nil)
udg_TSE_I_IsChanneling = __jarray(false)
udg_TSE_I_TargetUnitAliveCheck = __jarray(false)
udg_TSE_I_SourceUnitAliveCheck = __jarray(false)
udg_TSE_I_TargetUnit = __jarray(nil)
udg_TSE_I_OnLoopEvent = __jarray(nil)
udg_TSE_I_OnLoopTimer = __jarray(0.0)
udg_TSE_I_LoopDuration = __jarray(0.0)
udg_TSE_I_OnEndEvent = __jarray(nil)
udg_TSE_I_ActiveInstance = __jarray(false)
udg_TSE_I_LockInstance = __jarray(false)
udg_TSE_I_Point = __jarray(nil)
udg_TSE_MaxIndex = 0
udg_TSE_ReplacementIndex = 0
udg_TSE_ReplacementIndexFound = false
udg_TSE_MaxCheckOver = false
udg_TSE_MaxRecursion = 0
udg_TSE_Recursion = 0
udg_TSE_Index = 0
udg_TSE_EmptyEvent = nil
udg_TSE_CTimer = nil
udg_TSETargetUnit = nil
udg_TSETargetUnitAliveCheck = false
udg_TSESourceUnit = nil
udg_TSESourceUnitAliveCheck = false
udg_TSEPoint = nil
udg_TSEEffectName = nil
udg_TSEAttachPoint = nil
udg_TSEDuration = __jreal(0)
udg_TSEScale = __jreal(0)
udg_TSEChanneledOrderID = nil
udg_TSEOnIndexEvent = nil
udg_TSEOnLoopEvent = nil
udg_TSEOnLoopTimer = __jreal(0)
udg_TSEOnEndEvent = nil
udg_TSELockInstance = false
udg_Acided = nil
udg_BannedRatling = __jreal(0)
udg_TreeChopper = nil
udg_Tradeoff = nil
udg_Counterstring = nil
udg_IntSeconds = 0
udg_IntMinutes = 0
udg_IntHours = 0
udg_StringSeconds = nil
udg_StringMinutes = nil
udg_ExpanderPlayers = __jarray(nil)
udg_BannedHunter = __jreal(0)
udg_Multiboard_Spot = __jarray(0)
udg_GARATHORbaseList = __jarray(nil)
udg_Flags = __jarray(false)
udg_BannedAncientWind = __jreal(0)
udg_StartupDialog = nil
gg_rct_SpawnDefender = nil
gg_rct_Tele_out_D = nil
gg_rct_Tele_out_E = nil
gg_rct_Spawn_all = nil
gg_rct_Alarm = nil
gg_rct_Spawner = nil
gg_rct_Camera_1 = nil
gg_rct_Respawn = nil
gg_rct_Ping1 = nil
gg_rct_Ping2 = nil
gg_rct_Ping3 = nil
gg_rct_Ping4 = nil
gg_rct_Ping5 = nil
gg_rct_Rest_of_Map = nil
gg_rct_Ping6 = nil
gg_rct_AI_Move_1 = nil
gg_rct_AI_Move_2 = nil
gg_rct_AI_Move_3 = nil
gg_rct_AI_Move_4 = nil
gg_rct_AI_Move_5 = nil
gg_rct_AI_Move_6 = nil
gg_rct_AI_Move_7 = nil
gg_rct_AI_Move_8 = nil
gg_rct_AI_Move_9 = nil
gg_rct_AI_Move_10 = nil
gg_rct_Suspicious_Bush_1 = nil
gg_rct_Suspicious_Bush_2 = nil
gg_rct_Remove_Selection = nil
gg_rct_Ping7 = nil
gg_rct_Fountain = nil
gg_rct_SeedofR = nil
gg_rct_Base_1 = nil
gg_rct_Base_2 = nil
gg_rct_Base_3 = nil
gg_rct_rawr = nil
gg_rct_Base_4 = nil
gg_rct_Base_5 = nil
gg_rct_Base_6 = nil
gg_rct_Base_7 = nil
gg_rct_Base_8 = nil
gg_rct_Base_9 = nil
gg_rct_Base_10 = nil
gg_rct_ChopChop = nil
gg_snd_VarimathrasYes1 = nil
gg_snd_PeasantDeath = nil
gg_snd_CentaurDeath = nil
gg_snd_WispPissed1 = nil
gg_snd_WarlockDeath1 = nil
gg_snd_OgreDeath1 = nil
gg_snd_HeroFirelordDeath1 = nil
gg_snd_SatyrDeath1 = nil
gg_snd_BansheeDeath = nil
gg_snd_TinkerDeathAlt1 = nil
gg_snd_FurbolgDeath1 = nil
gg_snd_PitFiendDeath1 = nil
gg_snd_HydraDeath1 = nil
gg_snd_KoboldDeath = nil
gg_snd_QuillboarDeath = nil
gg_snd_FacelessDeath1 = nil
gg_snd_WendigoDeath = nil
gg_snd_DemonHunterDeathAlternate1 = nil
gg_snd_DruidOfTheTalonDeath1 = nil
gg_snd_GhoulDeath = nil
gg_snd_HeroDemonHunterDeath1 = nil
gg_snd_RiflemanDeath = nil
gg_snd_DuneWormDeath1 = nil
gg_snd_CycloneLoop1 = nil
gg_snd_CycloneDeath1 = nil
gg_snd_KaelYesAttack3 = nil
gg_trg_Damage_Engine_Config = nil
gg_trg_Damage_Engine = nil
gg_trg_TSEConfig = nil
gg_trg_TSERegister = nil
gg_trg_TSELoop = nil
gg_trg_TSEEmptyEvent = nil
gg_trg_TSESampleRegisterUnit = nil
gg_trg_TSESampleRegisterPoint = nil
gg_trg_Untitled_Trigger_009 = nil
gg_trg_Untitled_Trigger_004 = nil
gg_trg_Map_Ini_Testing = nil
gg_trg_Counter_Testing = nil
gg_trg_Selection_Testing = nil
gg_trg_Start_Counter = nil
gg_trg_Counter = nil
gg_trg_Counter_for_Later = nil
gg_trg_Counter_Panel = nil
gg_trg_Tradeoff_Detection = nil
gg_trg_TreeChopper_Detection = nil
gg_trg_Takeover = nil
gg_trg_Enable_Overdrive = nil
gg_trg_Disable_Overdrive = nil
gg_trg_Death = nil
gg_trg_Hardmode = nil
gg_trg_Categorization = nil
gg_trg_Fountain_Heal = nil
gg_trg_Ancient_In_Combat = nil
gg_trg_AutoFeedRate = nil
gg_trg_TimeToAncientSpawn_Copy = nil
gg_trg_HandleSetRate = nil
gg_trg_FeedReduction = nil
gg_trg_SetFeed = nil
gg_trg_CheckFeedRates = nil
gg_trg_Detonate = nil
gg_trg_Expander_Hero_XP = nil
gg_trg_Snipe_Shot = nil
gg_trg_Dash = nil
gg_trg_Rome = nil
gg_trg_Basic_Bounty_Hit = nil
gg_trg_Improved_Bounty_Hit = nil
gg_trg_Harvest_Grapes = nil
gg_trg_Bullets_Switch = nil
gg_trg_Limb_Throw = nil
gg_trg_Flesh_Stampede = nil
gg_trg_Amalgamation = nil
gg_trg_Merge = nil
gg_trg_Husk_Detection = nil
gg_trg_Death_Jump = nil
gg_trg_Map_Start = nil
gg_trg_Day = nil
gg_trg_Night = nil
gg_trg_Iron_Hoove = nil
gg_trg_Lightning_Strike_TowerVers = nil
gg_trg_Blizzard = nil
gg_trg_ShovelStrikelevelup = nil
gg_trg_Deepwater_1 = nil
gg_trg_Deepwater_2 = nil
gg_trg_Genesis = nil
gg_trg_ConjureRefreshment = nil
gg_trg_ShadowDancers = nil
gg_trg_Mana_Burn_Manacost = nil
gg_trg_Mana_Burn = nil
gg_trg_Mana_Steal_Dancer = nil
gg_trg_Mana_Steal_Mages = nil
gg_trg_ConjureMana = nil
gg_trg_Blur = nil
gg_trg_Ghoul_Units = nil
gg_trg_Ghoul_lumber = nil
gg_trg_Dutchmen_Trained = nil
gg_trg_Dutchmen = nil
gg_trg_Vampiric_Wyrm = nil
gg_trg_Soul_Hammer = nil
gg_trg_Coup_de_grace = nil
gg_trg_Surge_of_Darkness = nil
gg_trg_Focused_Anger_1 = nil
gg_trg_Focused_Anger_2 = nil
gg_trg_Focused_Anger_3 = nil
gg_trg_Focused_Anger_4 = nil
gg_trg_Focused_Anger_5 = nil
gg_trg_Focused_Anger_6 = nil
gg_trg_Focused_Anger_7 = nil
gg_trg_Focused_Anger_8 = nil
gg_trg_Focused_Anger_9 = nil
gg_trg_Focused_Anger_10 = nil
gg_trg_Focused_Anger_Trigger = nil
gg_trg_Focused_Anger_Trigger_Copy = nil
gg_trg_Focused_Anger_Trigger_Copy_2 = nil
gg_trg_Focused_Anger_Trigger_Copy_3 = nil
gg_trg_Focused_Anger_Trigger_Copy_4 = nil
gg_trg_Focused_Anger_Trigger_Copy_5 = nil
gg_trg_Focused_Anger_Trigger_Copy_6 = nil
gg_trg_Focused_Anger_Trigger_Copy_7 = nil
gg_trg_Focused_Anger_Trigger_Copy_8 = nil
gg_trg_Focused_Anger_Trigger_Copy_9 = nil
gg_trg_Feast_of_Souls = nil
gg_trg_Soul_Strike = nil
gg_trg_Avatar = nil
gg_trg_Acidic_Blood = nil
gg_trg_Binding_Shadows = nil
gg_trg_Cobalt_Blood = nil
gg_trg_Glowing_Blood = nil
gg_trg_Psychic_Slam = nil
gg_trg_Soul_Rend = nil
gg_trg_Dark_Blood = nil
gg_trg_Shadowlings = nil
gg_trg_Levelled_Drain = nil
gg_trg_Levelled_Drain_Copy = nil
gg_trg_Levelled_Drain_Copy_2 = nil
gg_trg_Levelled_Drain_Copy_3 = nil
gg_trg_Levelled_Drain_Copy_4 = nil
gg_trg_Levelled_Drain_Copy_5 = nil
gg_trg_Levelled_Drain_Copy_6 = nil
gg_trg_Levelled_Drain_Copy_7 = nil
gg_trg_Levelled_Drain_Copy_8 = nil
gg_trg_Levelled_Drain_Copy_9 = nil
gg_trg_Drain_Setup = nil
gg_trg_Drain_Cast = nil
gg_trg_Drain_Loop = nil
gg_trg_Levelled_Slam = nil
gg_trg_Levelled_Slam_Copy = nil
gg_trg_Levelled_Slam_Copy_2 = nil
gg_trg_Levelled_Slam_Copy_3 = nil
gg_trg_Levelled_Slam_Copy_4 = nil
gg_trg_Levelled_Slam_Copy_5 = nil
gg_trg_Levelled_Slam_Copy_6 = nil
gg_trg_Levelled_Slam_Copy_7 = nil
gg_trg_Levelled_Slam_Copy_8 = nil
gg_trg_Levelled_Slam_Copy_9 = nil
gg_trg_LevelUpAura = nil
gg_trg_DowngradeAura = nil
gg_trg_NerubianSpires = nil
gg_trg_Frenzy = nil
gg_trg_Chemical_Rage = nil
gg_trg_ReduceMagicResist = nil
gg_trg_ReduceMagicResist2 = nil
gg_trg_TargetAcquired = nil
gg_trg_Poisoned_Bullets2 = nil
gg_trg_Poisoned_Bullets = nil
gg_trg_Permanent_Invisibility = nil
gg_trg_Permanent_Invisibility_2 = nil
gg_trg_Sticky_Glue = nil
gg_trg_Wood_Income = nil
gg_trg_Enter_Wood_Income = nil
gg_trg_SeedOfRebirth = nil
gg_trg_Seed_of_Rebirth = nil
gg_trg_Seed_of_Rebirth_2 = nil
gg_trg_Ancient_Artifact = nil
gg_trg_Moonstrike = nil
gg_trg_Moonstrike_Leveled = nil
gg_trg_Moonblast = nil
gg_trg_Moonblast_Leveled = nil
gg_trg_Lunar_Assault = nil
gg_trg_Lunar_Assault_Leveled = nil
gg_trg_Cascade_Leveled = nil
gg_trg_Nourish = nil
gg_trg_Nourish_Leveled = nil
gg_trg_Solar_Blast = nil
gg_trg_Natural_Vigil_Leveled = nil
gg_trg_Lifebloom_Leveled = nil
gg_trg_Lunar_Crystal = nil
gg_trg_Suns_Fury = nil
gg_trg_Return_lumber = nil
gg_trg_Gara_2hits1g = nil
gg_trg_Gara_2hits1g_2 = nil
gg_trg_Slash_Leveled = nil
gg_trg_Bleed_Leveled = nil
gg_trg_Focused_Strike = nil
gg_trg_FanOfKnivesBasedSpells = nil
gg_trg_Realm_of_darkness = nil
gg_trg_Realm_of_darkness_2 = nil
gg_trg_Thunderstruck = nil
gg_trg_Lightning_Strike = nil
gg_trg_Neutralize = nil
gg_trg_RecallStart = nil
gg_trg_Recall = nil
gg_trg_Time_warp = nil
gg_trg_Galactic_Fury = nil
gg_trg_Galactic_Fury_2 = nil
gg_trg_Galactic_Fury_3 = nil
gg_trg_Cosmic_Strike = nil
gg_trg_Cosmic_Strike_2 = nil
gg_trg_Cosmic_Strike_3 = nil
gg_trg_Empower = nil
gg_trg_Resillience = nil
gg_trg_Resillience_2 = nil
gg_trg_Resillience_3 = nil
gg_trg_Sandstorm = nil
gg_trg_Sandstorm_2 = nil
gg_trg_Ancient_Grasp = nil
gg_trg_Deserts_Veil = nil
gg_trg_Chill = nil
gg_trg_Freeze_Zone = nil
gg_trg_Freeze_Zone_V2 = nil
gg_trg_Sadism = nil
gg_trg_Reckoning = nil
gg_trg_Hammer_Hurl_macko = nil
gg_trg_Scepter_Copy = nil
gg_trg_Vanguard_Initial = nil
gg_trg_Vanguard_Future_Levels = nil
gg_trg_Vanguard = nil
gg_trg_Omniscience_Initial = nil
gg_trg_Omniscience_FL = nil
gg_trg_Omniscience = nil
gg_trg_Redemption = nil
gg_trg_Refreshing_Breeze = nil
gg_trg_Gale_Winds = nil
gg_trg_WindWalkWispari = nil
gg_trg_TornadoMove = nil
gg_trg_Sit_tight = nil
gg_trg_ClearOnEsc = nil
gg_trg_InitialText = nil
gg_trg_Welcome = nil
gg_trg_Info_Copy = nil
gg_trg_Info = nil
gg_trg_Ping_Hint = nil
gg_trg_Hint2x2 = nil
gg_trg_HintInvisibility = nil
gg_trg_HintFeed = nil
gg_trg_Resource_Hint = nil
gg_trg_Ping = nil
gg_trg_PingForAncient = nil
gg_trg_AncientSpells = nil
gg_trg_Start = nil
gg_trg_Hard_mode_on = nil
gg_trg_Hard_Attack = nil
gg_trg_Hard_Attack_Cont = nil
gg_trg_Hard_attack_2 = nil
gg_trg_Select = nil
gg_trg_Attack = nil
gg_trg_Run_away = nil
gg_trg_Slot1_Righteous_Armor = nil
gg_trg_Slot2_Valor_Helmet = nil
gg_trg_Slot3_Bladed_Gauntlet = nil
gg_trg_Slot4_Bladed_Gauntlet = nil
gg_trg_Slot5_Bladed_Gauntlet = nil
gg_trg_Slot6_Bladed_Gauntlet = nil
gg_trg_Level_Up_Tomes = nil
gg_trg_Abilities = nil
gg_trg_Staff_of_insight_pickup = nil
gg_trg_Debug_Control = nil
gg_trg_Dusts_Slow = nil
gg_trg_Hatred = nil
gg_trg_Firelords_Cape_usage = nil
gg_trg_Firelords_Cape_pickup = nil
gg_trg_Bladed_Gauntlet_vs_Hero = nil
gg_trg_Cast_CL_on_Banish = nil
gg_trg_Ledgers_XP = nil
gg_trg_Ledger_of_Clarity_pickup = nil
gg_trg_Ledger_of_Clarity_lose = nil
gg_trg_Ledger_of_Enlightment_pickup = nil
gg_trg_Ledger_of_Enlightment_lose = nil
gg_trg_Bonus_XP = nil
gg_trg_Spellcasters_Cloak = nil
gg_trg_Ethereal_Scepter = nil
gg_trg_Firelords_Cape = nil
gg_trg_Ledget_of_Enlightment = nil
gg_trg_Hammer_of_might = nil
gg_trg_Valorous_Helmet = nil
gg_trg_Bladed_Gauntlet = nil
gg_trg_Righteous_Armor = nil
gg_trg_Arcanum_of_Hatred = nil
gg_trg_Bleeding_Scythe = nil
gg_trg_Staff_of_Insight = nil
gg_trg_Cosmic_Orb = nil
gg_trg_Level_up = nil
gg_trg_Deliver_Gold = nil
gg_trg_Worgens_gold = nil
gg_trg_Invul = nil
gg_trg_Bounty = nil
gg_trg_Remove_Ancient_Lumber = nil
gg_trg_Ancient_Gold_income = nil
gg_trg_Initialization = nil
gg_trg_LimitedTraining = nil
gg_trg_TimeToExpanderSpawn = nil
gg_trg_TimeToAncientSpawn = nil
gg_trg_Unit_Indexer = nil
gg_trg_Spellbringers_spells = nil
gg_trg_Give_orb = nil
gg_trg_Colors = nil
gg_trg_Name_Change = nil
gg_trg_Name_Change_II = nil
gg_trg_Name_Change_III = nil
gg_trg_RandomExpander = nil
gg_trg_RandomExpander2 = nil
gg_trg_Random_Ancient = nil
gg_trg_Remove_Selection = nil
gg_trg_Remove_Selector = nil
gg_trg_Trade_disabled = nil
gg_trg_Trade_enabled = nil
gg_trg_Disable_trade_enabled = nil
gg_trg_Spawn_Races = nil
gg_trg_Spawn_Ancients = nil
gg_trg_DisableExpanderBans = nil
gg_trg_Worgen = nil
gg_trg_Centaur = nil
gg_trg_Wildkin = nil
gg_trg_Nerubian = nil
gg_trg_Human = nil
gg_trg_Wisp = nil
gg_trg_Kobold = nil
gg_trg_Ghoul = nil
gg_trg_Kraken = nil
gg_trg_Aethyr = nil
gg_trg_Forgotten = nil
gg_trg_Goblin = nil
gg_trg_Ogre = nil
gg_trg_Magmide = nil
gg_trg_Furbolg = nil
gg_trg_Razormane = nil
gg_trg_Elf = nil
gg_trg_HighElf = nil
gg_trg_Ratling = nil
gg_trg_Hunter = nil
gg_trg_AncientLight = nil
gg_trg_AncientLightning = nil
gg_trg_AncientDragon = nil
gg_trg_AncientEarth = nil
gg_trg_AncientDarkness = nil
gg_trg_AncientIce = nil
gg_trg_AncientFire = nil
gg_trg_AncientNature = nil
gg_trg_AncientSand = nil
gg_trg_AncientSpace = nil
gg_trg_AncientWind = nil
gg_trg_Prevent_Attack = nil
gg_trg_No_Attacking_Shops_Copy_3 = nil
gg_trg_No_Attacking_Shops_Copy_2 = nil
gg_trg_No_Attacking_Shops_Copy = nil
gg_trg_No_Attacking_Shops = nil
gg_trg_Ally_neutral = nil
gg_trg_Vision = nil
gg_trg_Death_anim = nil
gg_trg_Quests = nil
gg_trg_Warning_few_seconds = nil
gg_trg_Camera_Copy = nil
gg_trg_LatePickers = nil
gg_trg_AncientSpawnTele = nil
gg_trg_Player_group = nil
gg_trg_Lackey_Respawn = nil
gg_trg_Death_start = nil
gg_trg_Spawn_Lackey = nil
gg_trg_MiniMinis = nil
gg_trg_Player_Leaves = nil
gg_trg_Ancient_Leaves = nil
gg_trg_Human_Dies = nil
gg_trg_Wisp_Dies = nil
gg_trg_Centaur_Dies = nil
gg_trg_Ogre_Dies = nil
gg_trg_Worgen_Dies = nil
gg_trg_Night_Elf_Dies = nil
gg_trg_Shadow_Dancer_Dies = nil
gg_trg_Archdruid_Dies = nil
gg_trg_Engineer_Highelf_Dies = nil
gg_trg_Bounty_Hunter_Dies = nil
gg_trg_Ghoul_Dies = nil
gg_trg_Magmide_Dies = nil
gg_trg_Goblin_Dies = nil
gg_trg_Ratling_Dies = nil
gg_trg_Goblin_Ultima_Dies = nil
gg_trg_Furbolg_Shaman_Dies = nil
gg_trg_Furbolg_Warrior_Dies = nil
gg_trg_Furbolg_Dies = nil
gg_trg_Nerubian_Dies = nil
gg_trg_Kraken_Dies = nil
gg_trg_Aethyr_Warp_Dies = nil
gg_trg_Kobold_Dies = nil
gg_trg_Razormane_Dies = nil
gg_trg_Wildkin_Dies = nil
gg_trg_Forgotten_One_Dies = nil
gg_trg_Forgotten_Bloodmage_Dies = nil
gg_trg_Forgotten_Executioner_Dies = nil
gg_trg_Forgotten_Soulreaper_Dies = nil
gg_trg_Ignite_Dies = nil
gg_trg_Avalanche_Dies = nil
gg_trg_Paranoia_Dies = nil
gg_trg_Eternity_Dies = nil
gg_trg_Dragos_Dies = nil
gg_trg_Tremor_Dies = nil
gg_trg_Zalxon_Dies = nil
gg_trg_Divinity_Dies = nil
gg_trg_Pharoah_Dies = nil
gg_trg_Nebula_Dies = nil
gg_trg_Wispari_Dies = nil
gg_trg_Remove_Resources_new = nil
gg_trg_DVIC_1 = nil
gg_trg_Ext_On = nil
gg_trg_Extermination = nil
gg_trg_Base_List_Init = nil
gg_trg_Flagstack_Deny = nil
gg_trg_Flag_no_base_Deny = nil
gg_trg_Flag_Destroyed = nil
gg_trg_killcommand = nil
gg_trg_speedcommand = nil
gg_trg_NewFlag = nil
gg_trg_NewFlag2 = nil
gg_trg_NewFlag3 = nil
gg_trg_NewFlag4 = nil
gg_trg_NewFlag5 = nil
gg_trg_Gobo_Mech_Blaster_pickup = nil
gg_trg_Gobo_Mech_Blaster_attack_check = nil
gg_unit_h00Q_0026 = nil
gg_unit_nmer_0000 = nil
gg_unit_nmr2_0001 = nil
gg_unit_n00G_0035 = nil
gg_unit_n00B_0266 = nil
udg_HardmodeEnabled = false
udg_HardmodeCanBeEnabled = true
udg_HardmodePeriodicTimer = nil
udg_HardmodeSound = nil
HARDMODE_SOUND_PATH = "Units\\Human\\Kael\\KaelYesAttack3.flac"
FEEDRATE_FILE_PATH = "ForestExpansion\\ForestExpansion.pld"
FEEDRATE_SYNC_PREFIX = "FRAT"
FEEDRATE_NAME_SYNC_PREFIX = "FRNM"
FEEDRATE_MAX_PLAYERS = 11
FeedRate_ButtonYes = nil
FeedRate_ButtonOtherTag = nil
FeedRate_ButtonNo = nil
FeedRate_YesTrigger = nil
FeedRate_OtherTagTrigger = nil
FeedRate_NoTrigger = nil
FeedRate_SyncTrigger = nil
FeedRate_NameSyncTrigger = nil
FeedRate_Loaded = __jarray(false)
FeedRate_PendingRateReceived = __jarray(false)
FeedRate_PendingRate = __jarray(0)
FeedRate_PendingNameReceived = __jarray(false)
FeedRate_PendingName = __jarray(nil)
SNIPESHOT_Hash = InitHashtable()
SNIPESHOT_Group = CreateGroup()
SNIPESHOT_ABILITY_ID = FourCC("A0F7")
SNIPESHOT_DUMMY_ID = FourCC("h06G")
SNIPESHOT_STUN_ABILITY_ID = FourCC("A0F9")
SNIPESHOT_MISSILE_MODEL = "Abilities\\Weapons\\AncestralGuardianMissile\\AncestralGuardianMissile.mdl"
SNIPESHOT_STUN_ORDER = "thunderbolt"
SNIPESHOT_CHANNEL_TIME = __jreal(1.50)
SNIPESHOT_COOLDOWN = __jreal(60.00)
SNIPESHOT_PERIOD = __jreal(0.03125)
SNIPESHOT_MAX_RANGE = __jreal(3000.00)
SNIPESHOT_SPEED = __jreal(3000.00)
SNIPESHOT_COLLISION = __jreal(96.00)
SNIPESHOT_DAMAGE_PER_STEP = __jreal(100.00)
SNIPESHOT_DAMAGE_DISTANCE_STEP = __jreal(100.00)
SNIPESHOT_MISSILE_HEIGHT = __jreal(60.00)
DashHash = InitHashtable()
DASH_RANGE = __jreal(1000.00)
DASH_SPEED = __jreal(2000.00)
DASH_PERIOD = __jreal(0.03)
DASH_ATTACH_EFFECT = "Abilities\\Spells\\NightElf\\Blink\\BlinkTarget.mdl"
DASH_TRAIL_EFFECT = "Abilities\\Spells\\Human\\FlakCannons\\FlakTarget.mdl"
DASH_TRAIL_INTERVAL = __jreal(40.00)
FleshStampede_Group = nil
FleshStampede_Hash = nil
FLESH_STAMPEDE_ABILITY_ID = FourCC("A0EF")
FLESH_STAMPEDE_BUFF_ID = FourCC("B03T")
FLESH_STAMPEDE_MISS_KEY = 0
FLESH_STAMPEDE_MISS_LIMIT = 3
FLESH_STAMPEDE_PERIOD = __jreal(0.50)
FLESH_STAMPEDE_DAMAGE_FACTOR = __jreal(0.02)
UPG_ABILITY_ID = FourCC("A08P")
UPG_UPGRADE_ID = FourCC("R01J")
UPG_BASE_ABILITY_LEVEL = 1
UPG_MAX_ABILITY_LEVEL = 11
UPG_TempGroup = CreateGroup()
UPG_ResearchTrig = nil
UPG_EnterTrig = nil
UPG_WorldRegion = nil
udg_MoonblastHash = nil
MOONBLAST_ABILITY_ID = FourCC("A07H")
MOONBLAST_DAMAGE_FACTOR = __jreal(0.33)
MOONBLAST_TICK = __jreal(0.03125)
MOONBLAST_SPEED = __jreal(900.00)
MOONBLAST_COLLISION = __jreal(75.00)
MOONBLAST_MISSILE_MODEL = "war3mapImported\\StarfallMissle.mdx"
BURST_DRAGONIC_ABIL_ID = FourCC("A02B")
BURST_LICH_ABIL_ID = FourCC("A008")
BURST_PERIOD = __jreal(0.031250)
BURST_ENUM_GROUP = CreateGroup()
BURST_TIMER = CreateTimer()
BURST_COUNT = 0
BURST_CASTER = __jarray(nil)
BURST_TARGET = __jarray(nil)
BURST_MISSILE = __jarray(nil)
BURST_X = __jarray(0.0)
BURST_Y = __jarray(0.0)
BURST_DAMAGE = __jarray(0.0)
BURST_SPEED = __jarray(0.0)
BURST_HEIGHT = __jarray(0.0)
SSZ_SPELL_ID = FourCC("A0F1")
SSZ_SLOW_ID = FourCC("A0F0")
SSZ_AOE = __jreal(3000.00)
SSZ_DAMAGE = __jreal(100.00)
SSZ_SLOW_DURATION = __jreal(1.00)
SSZ_HASH = nil
TP_SPELL_ID = FourCC("A0EX")
TP_DEBUFF_ID = FourCC("A0EZ")
TP_DUMMY_ID = FourCC("h06G")
TP_DEBUFF_ORDER = "slow"
TP_AOE = __jreal(4000.00)
TP_DAMAGE_BASE = __jreal(100.00)
TP_DAMAGE_PER_LEVEL = __jreal(50.00)
TP_DUMMY_CAST_DELAY = __jreal(0.00)
TP_DUMMY_LIFETIME = __jreal(6.00)
TP_DUMMY_OWNER = Player(12)
TP_HASH = nil
WW_Hash = InitHashtable()
WW_ABILITY_ID = FourCC("A0EO")
WW_BUFF_ID = FourCC("B03X")
WW_SPAWN_ID = FourCC("u00M")
WW_PERIOD = __jreal(0.50)
WW_SPAWN_LIFE = __jreal(3.00)
TORNADO_ABILITY_ID = FourCC("A0EL")
TORNADO_MODEL_PATH = "Abilities\\Spells\\Other\\Tornado\\TornadoElemental.mdl"
TORNADO_EFFECT_SCALE = __jreal(1.00)
TORNADO_PERIOD = __jreal(0.031250)
TORNADO_CHANNEL_BASE = __jreal(0.60)
TORNADO_CHANNEL_PER_LEVEL = __jreal(0.10)
TORNADO_MOVE_TOLERANCE = __jreal(5.00)
TORNADO_ENDCAST_TOLERANCE = __jreal(0.05)
TORNADO_KEY_EFFECT = 0
TORNADO_KEY_X = 1
TORNADO_KEY_Y = 2
TORNADO_KEY_ANGLE = 3
TORNADO_KEY_TRAVELED = 4
TORNADO_KEY_MAX_DISTANCE = 5
TORNADO_KEY_CASTER = 6
TORNADO_KEY_CHANNEL_ACTIVE = 7
TORNADO_KEY_CHANNEL_LEFT = 8
TORNADO_KEY_START_X = 9
TORNADO_KEY_START_Y = 10
TORNADO_KEY_SPEED = 11
TORNADO_KEY_DYING = 12
TORNADO_CASTER_KEY_TIMER = 100
udg_TornadoHash = nil
DAS_Hash = InitHashtable()
DAS_EnumGroup = CreateGroup()
DAS_DUST_CAST_ABILITY_ID = FourCC("AItb")
DAS_DUST_BUFF_ID = FourCC("Bdet")
DAS_SLOW_AURA_ID = FourCC("A0FA")
DAS_PERMANENT_INVIS_ABILITY = FourCC("Apiv")
DAS_RADIUS = __jreal(1000.00)
DAS_PERIOD = __jreal(0.10)
DAS_KEY_TRACK_TIMER = 0
DAS_KEY_TIMER_TARGET = 1
DAS_KEY_TIMER_OWNER = 2
DAS_EnumOwner = nil
DAS_InvisBuff = __jarray(0)
DAS_InvisBuffCount = 0
gg_trg_AncientTeleport = nil
TeleportEnableTimer = nil
teleportRegion = nil
ENABLE_DELAY = __jreal(50.0)
LackeyRespawn_Hash = InitHashtable()
LACK_RESPAWN_DELAY = __jreal(60.00)
LACK_RESPAWN_KEY_TYPE = 0
LACK_RESPAWN_KEY_PLAYER = 1
LACK_RESPAWN_KEY_DIALOG = 2
SPAWN_LACKEY_DELAY_MARK = __jreal(360.00)
SpawnLackey_Hash = nil
SpawnLackey_GameTimer = nil
SpawnLackey_PlayerTimer = __jarray(nil)
SpawnLackey_PlayerDialog = __jarray(nil)
l__library_init = nil
si__DamageTrigger = 1
s__DamageTrigger_MOD = 1
s__DamageTrigger_SHIELD = 4
s__DamageTrigger_DAMAGE = 5
s__DamageTrigger_ZERO = 6
s__DamageTrigger_AFTER = 7
s__DamageTrigger_LETHAL = 8
s__DamageTrigger_AOE = 9
s__DamageTrigger_count = 9
s__DamageTrigger_lastRegistered = 0
s__DamageTrigger_trigIndexStack = __jarray(0)
s__DamageTrigger_eventIndex = 0
s__DamageTrigger_filters = __jarray(false)
s__DamageTrigger_eventStr = __jarray(nil)
s__DamageTrigger_weight = __jarray(0.0)
s__DamageTrigger_usingGUI = __jarray(false)
s__DamageTrigger_next = __jarray(0)
s__DamageTrigger_rootTrig = __jarray(nil)
s__DamageTrigger_DamageEngine___trigFrozen = __jarray(false)
s__DamageTrigger_DamageEngine___ownRecursiveDepth = __jarray(0)
s__DamageTrigger_DamageEngine___manualRecursionRequested = __jarray(false)
s__DamageTrigger_configured = __jarray(false)
s__DamageTrigger_source = __jarray(nil)
s__DamageTrigger_target = __jarray(nil)
s__DamageTrigger_sourceType = __jarray(0)
s__DamageTrigger_targetType = __jarray(0)
s__DamageTrigger_sourceBuff = __jarray(0)
s__DamageTrigger_targetBuff = __jarray(0)
s__DamageTrigger_sourceItem = __jarray(0)
s__DamageTrigger_targetItem = __jarray(0)
s__DamageTrigger_sourceClass = __jarray(0)
s__DamageTrigger_targetClass = __jarray(0)
s__DamageTrigger_damageMin = __jarray(0.0)
s__DamageTrigger_failChance = __jarray(0.0)
s__DamageTrigger_attackType = __jarray(0)
s__DamageTrigger_damageType = __jarray(0)
s__DamageTrigger_userType = __jarray(0)
s__DamageTrigger_prev = 0
s__DamageTrigger_autoTriggers = __jarray(nil)
s__DamageTrigger_autoFuncs = __jarray(nil)
s__DamageTrigger_autoN = 0
si__Damage = 2
s__Damage_sourceUnit = __jarray(nil)
s__Damage_targetUnit = __jarray(nil)
s__Damage_damage = __jarray(0.0)
s__Damage_prevAmt = __jarray(0.0)
s__Damage_attackType = __jarray(nil)
s__Damage_damageType = __jarray(nil)
s__Damage_weaponType = __jarray(nil)
s__Damage_userType = __jarray(0)
s__Damage_isAttack = __jarray(false)
s__Damage_isCode = __jarray(false)
s__Damage_isSpell = __jarray(false)
s__Damage_isMelee = __jarray(false)
s__Damage_isRanged = __jarray(false)
s__Damage_eFilter = __jarray(0)
s__Damage_armorPierced = __jarray(0.0)
s__Damage_armorType = __jarray(0)
s__Damage_defenseType = __jarray(0)
s__Damage_index = 0
s__Damage_damageStack = 0
s__Damage_prepped = 0
s__Damage_count = 0
s__Damage_stackRef = __jarray(0)
s__Damage_recursiveTrig = __jarray(0)
s__Damage_prevArmorT = __jarray(0)
s__Damage_prevDefenseT = __jarray(0)
s__Damage_threadCompleted = false
st___prototype2 = __jarray(nil)
f__arg_trigger1 = nil
f__arg_string1 = nil
f__arg_limitop1 = nil
f__arg_real1 = 0.0
-- END FOREST MODULE src/globals.lua

-- BEGIN FOREST MODULE src/players/roles.lua
-- Gameplay identity belongs to player handles, never colors or fixed slots.
-- This is the only default Ancient slot. Native lobby configuration still uses
-- the original eleven slots. Changing that lobby is a separate editor task.
FE_Roles = { initialAncientSlot = 6, playerSlotCount = 11 }

function FE_Roles.ancient()
    return udg_AncientPlayer
end

function FE_Roles.isAncient(player)
    return player ~= nil and player == udg_AncientPlayer
end

function FE_Roles.setAncient(player)
    assert(player ~= nil and GetPlayerId(player) >= 0 and
        GetPlayerId(player) < FE_Roles.playerSlotCount, "Ancient must be a participant")
    -- Retain the original global as the sole backing state for legacy triggers.
    local previous = udg_AncientPlayer
    udg_AncientPlayer = player
    if FE_Roster then FE_Roster.onAncientChanged(previous, player) end
end

function FE_Roles.forEachPlayer(action)
    for slot = 0, FE_Roles.playerSlotCount - 1 do action(Player(slot)) end
end

function FE_Roles.isAncientEvent()
    return FE_Roles.isAncient(GetTriggerPlayer())
end

-- Register all participants once. Evaluate ownership at event time, so a
-- takeover does not leave listeners attached to the previous Ancient.
function FE_Roles.registerAncientUnitEvent(trigger, event)
    FE_Roles.forEachPlayer(function(player)
        TriggerRegisterPlayerUnitEventSimple(trigger, player, event)
    end)
    TriggerAddCondition(trigger, Condition(FE_Roles.isAncientEvent))
end

function FE_Roles.registerAncientChatEvent(trigger, text, exact)
    FE_Roles.forEachPlayer(function(player)
        TriggerRegisterPlayerChatEvent(trigger, player, text, exact)
    end)
    TriggerAddCondition(trigger, Condition(FE_Roles.isAncientEvent))
end

function FE_Roles.registerAncientStateEvent(trigger, state, comparison, value)
    FE_Roles.forEachPlayer(function(player)
        TriggerRegisterPlayerStateEvent(trigger, player, state, comparison, value)
    end)
    TriggerAddCondition(trigger, Condition(FE_Roles.isAncientEvent))
end

function FE_Roles.finishMatch(ancientWon, defeatMessage)
    if FE_Test and not FE_Test.matchResultsEnabled() then return end
    local ancient = FE_Roles.ancient()
    assert(ancient ~= nil, "Cannot finish a match without an Ancient")
    FE_Roles.forEachPlayer(function(player)
        local won = (player == ancient) == ancientWon
        if won then CustomVictoryBJ(player, true, true)
        else CustomDefeatBJ(player, defeatMessage) end
    end)
end

function FE_Roles.otherPlayersWin()
    if FE_Test and not FE_Test.matchResultsEnabled() then return end
    FE_Roles.forEachPlayer(function(player)
        if not FE_Roles.isAncient(player) then CustomVictoryBJ(player, true, true) end
    end)
end
-- END FOREST MODULE src/players/roles.lua

-- BEGIN FOREST MODULE src/players/roster.lua
-- Match membership is independent of Blizzard's singleton player forces.
FE_Roster = { alive = {}, initialized = false, force = nil }

function FE_Roster.expanderForce()
    if not FE_Roster.force then FE_Roster.force = CreateForce() end
    ForceClear(FE_Roster.force)
    FE_Roles.forEachPlayer(function(player)
        if not FE_Roles.isAncient(player) and GetPlayerSlotState(player) == PLAYER_SLOT_STATE_PLAYING then
            ForceAddPlayer(FE_Roster.force, player)
        end
    end)
    return FE_Roster.force
end

function FE_Roster.initialize()
    if FE_Roster.initialized then return end
    FE_Roster.initialized = true
    udg_StillAlive = 0
    FE_Roles.forEachPlayer(function(player)
        local playing = GetPlayerSlotState(player) == PLAYER_SLOT_STATE_PLAYING and not FE_Roles.isAncient(player)
        FE_Roster.alive[GetPlayerId(player)] = playing
        if playing then udg_StillAlive = udg_StillAlive + 1 end
    end)
    FE_Roster.expanderForce()
end

function FE_Roster.isAlive(player)
    return player ~= nil and FE_Roster.alive[GetPlayerId(player)] == true
end

function FE_Roster.defeat(player)
    if not FE_Roster.isAlive(player) then return false end
    FE_Roster.alive[GetPlayerId(player)] = false
    udg_StillAlive = udg_StillAlive - 1
    return true
end

function FE_Roster.revive(player)
    if FE_Roles.isAncient(player) or FE_Roster.isAlive(player) or
       GetPlayerSlotState(player) ~= PLAYER_SLOT_STATE_PLAYING then return false end
    FE_Roster.alive[GetPlayerId(player)] = true
    udg_StillAlive = udg_StillAlive + 1
    return true
end

function FE_Roster.onAncientChanged(_, player)
    if not FE_Roster.initialized then return end
    FE_Roster.defeat(player)
    FE_Roster.expanderForce()
end
-- END FOREST MODULE src/players/roster.lua

-- BEGIN FOREST MODULE src/items/recipe_data.lua
-- Generated by tools/recipe_data.py from data/gameplay and object records.
-- Do not edit prices here. The regular build regenerates this module.
FE_RecipeData = {items = {}, recipes = {}, shops = {}, stock = {}}
FE_RecipeData.items[FourCC("I000")] = {gold=50, lumber=0, name="Orb of Revealing"}
FE_RecipeData.items[FourCC("I001")] = {gold=100, lumber=0, name="Helm of Devotion"}
FE_RecipeData.items[FourCC("I002")] = {gold=500, lumber=0, name="Iron Blade"}
FE_RecipeData.items[FourCC("I004")] = {gold=100, lumber=0, name="Valor Armor"}
FE_RecipeData.items[FourCC("I006")] = {gold=350, lumber=0, name="Gauntlet of Might"}
FE_RecipeData.items[FourCC("I00F")] = {gold=900, lumber=0, name="Bladed Gauntlet"}
FE_RecipeData.items[FourCC("I00G")] = {gold=50, lumber=0, name="[Recipe] Bladed Gauntlet (900)"}
FE_RecipeData.items[FourCC("I00H")] = {gold=300, lumber=0, name="[Recipe] Valorous Helmet (500)"}
FE_RecipeData.items[FourCC("I00I")] = {gold=500, lumber=0, name="Valorous Helmet"}
FE_RecipeData.items[FourCC("I00J")] = {gold=1250, lumber=0, name="Tome of Power"}
FE_RecipeData.items[FourCC("I00S")] = {gold=150, lumber=0, name="Amulet of Dominance"}
FE_RecipeData.items[FourCC("I00Y")] = {gold=100, lumber=0, name="Teleportation Wand"}
FE_RecipeData.items[FourCC("I00Z")] = {gold=350, lumber=0, name="Galiant Armor"}
FE_RecipeData.items[FourCC("I010")] = {gold=120, lumber=0, name="Protector Seed"}
FE_RecipeData.items[FourCC("I011")] = {gold=550, lumber=0, name="[Recipe] Righteous Armor (1500)"}
FE_RecipeData.items[FourCC("I012")] = {gold=1500, lumber=0, name="Righteous Armor"}
FE_RecipeData.items[FourCC("I014")] = {gold=600, lumber=0, name="Monocle of Truth"}
FE_RecipeData.items[FourCC("I015")] = {gold=1050, lumber=0, name="Arcanum of Hatred"}
FE_RecipeData.items[FourCC("I016")] = {gold=625, lumber=0, name="[Recipe] Arcanum of Hatred (1050)"}
FE_RecipeData.items[FourCC("I017")] = {gold=1200, lumber=0, name="Bleeding Scythe"}
FE_RecipeData.items[FourCC("I018")] = {gold=625, lumber=0, name="[Recipe] Bleeding Scythe (1200)"}
FE_RecipeData.items[FourCC("I019")] = {gold=600, lumber=0, name="Cosmic Orb"}
FE_RecipeData.items[FourCC("I01A")] = {gold=200, lumber=0, name="[Recipe] Cosmic Orb (600)"}
FE_RecipeData.items[FourCC("I01B")] = {gold=200, lumber=0, name="Orb of Mana"}
FE_RecipeData.items[FourCC("I01C")] = {gold=950, lumber=0, name="Staff of Insight"}
FE_RecipeData.items[FourCC("I01D")] = {gold=250, lumber=0, name="[Recipe] Staff of Insight (950)"}
FE_RecipeData.items[FourCC("I01J")] = {gold=700, lumber=0, name="Ledger of Clarity"}
FE_RecipeData.items[FourCC("I01L")] = {gold=1550, lumber=0, name="Hammer of Might"}
FE_RecipeData.items[FourCC("I01M")] = {gold=300, lumber=0, name="[Recipe] Hammer of Might (1550)"}
FE_RecipeData.items[FourCC("I01N")] = {gold=1400, lumber=0, name="Ledger of Enlightenment"}
FE_RecipeData.items[FourCC("I01O")] = {gold=350, lumber=0, name="[Recipe] Ethereal Scepter (700)"}
FE_RecipeData.items[FourCC("I01P")] = {gold=700, lumber=0, name="Ethereal Scepter"}
FE_RecipeData.items[FourCC("I01Q")] = {gold=350, lumber=0, name="[Recipe] Spellcaster's Cloak (950)"}
FE_RecipeData.items[FourCC("I01R")] = {gold=950, lumber=0, name="Spellcaster's Cloak"}
FE_RecipeData.items[FourCC("I01S")] = {gold=300, lumber=0, name="[Recipe] Firelord's Cape (1150)"}
FE_RecipeData.items[FourCC("I01T")] = {gold=1150, lumber=0, name="Firelord's Cape"}
FE_RecipeData.items[FourCC("I01U")] = {gold=50, lumber=0, name="Potion of Invisibility"}
FE_RecipeData.items[FourCC("I02E")] = {gold=600, lumber=0, name="I02E"}
FE_RecipeData.items[FourCC("I02F")] = {gold=75, lumber=0, name="Bracer of Agility"}
FE_RecipeData.recipes[#FE_RecipeData.recipes + 1] = {scroll=FourCC("I00H"), result=FourCC("I00I"), components={FourCC("I001"), FourCC("I004")}}
FE_RecipeData.recipes[#FE_RecipeData.recipes + 1] = {scroll=FourCC("I00G"), result=FourCC("I00F"), components={FourCC("I006"), FourCC("I002")}}
FE_RecipeData.recipes[#FE_RecipeData.recipes + 1] = {scroll=FourCC("I01Q"), result=FourCC("I01R"), components={FourCC("I00Z"), FourCC("I01B"), FourCC("I01U")}}
FE_RecipeData.recipes[#FE_RecipeData.recipes + 1] = {scroll=FourCC("I01O"), result=FourCC("I01P"), components={FourCC("I00S"), FourCC("I01B")}}
FE_RecipeData.recipes[#FE_RecipeData.recipes + 1] = {scroll=FourCC("I01S"), result=FourCC("I01T"), components={FourCC("I00Z"), FourCC("I00I")}}
FE_RecipeData.recipes[#FE_RecipeData.recipes + 1] = {scroll=FourCC("I01M"), result=FourCC("I01L"), components={FourCC("I00F"), FourCC("I006")}}
FE_RecipeData.recipes[#FE_RecipeData.recipes + 1] = {scroll=FourCC("I011"), result=FourCC("I012"), components={FourCC("I00I"), FourCC("I00Z"), FourCC("I004")}}
FE_RecipeData.recipes[#FE_RecipeData.recipes + 1] = {scroll=FourCC("I016"), result=FourCC("I015"), components={FourCC("I00Z"), FourCC("I02F")}}
FE_RecipeData.recipes[#FE_RecipeData.recipes + 1] = {scroll=FourCC("I018"), result=FourCC("I017"), components={FourCC("I002"), FourCC("I02F")}}
FE_RecipeData.recipes[#FE_RecipeData.recipes + 1] = {scroll=FourCC("I01D"), result=FourCC("I01C"), components={FourCC("I00I"), FourCC("I01B")}}
FE_RecipeData.recipes[#FE_RecipeData.recipes + 1] = {scroll=FourCC("I01A"), result=FourCC("I019"), components={FourCC("I000"), FourCC("I01B"), FourCC("I00S")}}
FE_RecipeData.recipes[#FE_RecipeData.recipes + 1] = {scroll=nil, result=FourCC("I01N"), components={FourCC("I01J"), FourCC("I01J")}}
FE_RecipeData.shops[FourCC("h02B")] = true
FE_RecipeData.stock[FourCC("h02B")] = {[FourCC("I01O")]=true, [FourCC("I01Q")]=true, [FourCC("I01S")]=true, [FourCC("I01M")]=true, [FourCC("I01A")]=true, [FourCC("I01D")]=true, [FourCC("I018")]=true, [FourCC("I016")]=true, [FourCC("I011")]=true, [FourCC("I00G")]=true, [FourCC("I00H")]=true}
FE_RecipeData.shops[FourCC("n000")] = true
FE_RecipeData.stock[FourCC("n000")] = {[FourCC("I02E")]=true, [FourCC("I01J")]=true, [FourCC("I014")]=true, [FourCC("I010")]=true, [FourCC("I00Z")]=true, [FourCC("I00Y")]=true, [FourCC("I02F")]=true, [FourCC("I00S")]=true}
FE_RecipeData.shops[FourCC("n00A")] = true
FE_RecipeData.stock[FourCC("n00A")] = {[FourCC("I01U")]=true, [FourCC("I00J")]=true, [FourCC("I01B")]=true, [FourCC("I006")]=true, [FourCC("I004")]=true, [FourCC("I002")]=true, [FourCC("I001")]=true, [FourCC("I000")]=true}
-- END FOREST MODULE src/items/recipe_data.lua

-- BEGIN FOREST MODULE src/items/recipes.lua
-- Deterministic inventory planning. All mutation runs in synchronized events.
FE_Recipes = { byScroll = {}, byResult = {}, busy = {}, pending = {}, pickupCrafted = {}, initialized = false }
FE_Recipes.diagnostics = {sales=0, completed=0, refunded=0, last='No recipe purchase observed.'}
for _, recipe in ipairs(FE_RecipeData.recipes) do
    FE_Recipes.byResult[recipe.result] = recipe
    if recipe.scroll then FE_Recipes.byScroll[recipe.scroll] = recipe end
end

local function inventory(unit)
    local entries = {}
    for slot = 0, UnitInventorySize(unit) - 1 do
        local item = UnitItemInSlot(unit, slot)
        if item then entries[#entries + 1] = {item=item, kind=GetItemTypeId(item), remaining=math.max(1,GetItemCharges(item))} end
    end
    return entries
end

function FE_Recipes.plan(unit, recipe, buyMissing, paidScroll)
    if not unit or not recipe then return nil, 'Unknown recipe.' end
    local plan = {entries=inventory(unit), consumed={}, gold=0, lumber=0, result=recipe.result, scroll=paidScroll}
    for _, entry in ipairs(plan.entries) do
        if entry.item == paidScroll then entry.remaining = entry.remaining - 1 end
    end
    local function reserve(kind)
        for _, entry in ipairs(plan.entries) do
            if entry.remaining > 0 and entry.item ~= paidScroll and entry.kind == kind then
                entry.remaining = entry.remaining - 1; plan.consumed[#plan.consumed + 1] = entry.item
                return true
            end
        end
        return false
    end
    local function purchase(kind)
        local price = FE_RecipeData.items[kind]
        if not buyMissing or not price then return false end
        plan.gold = plan.gold + price.gold; plan.lumber = plan.lumber + price.lumber
        return true
    end
    local ensure
    local function requirements(current, paid, visiting)
        if visiting[current.result] then return false end
        visiting[current.result] = true
        if current.scroll and not paid and not reserve(current.scroll) and not purchase(current.scroll) then return false end
        for _, component in ipairs(current.components) do
            if not ensure(component, visiting) then return false end
        end
        visiting[current.result] = nil
        return true
    end
    ensure = function(kind, visiting)
        if reserve(kind) then return true end
        local nested = FE_Recipes.byResult[kind]
        if nested then return requirements(nested, false, visiting) end
        return purchase(kind)
    end
    if not requirements(recipe, paidScroll ~= nil, {}) then return nil, 'Missing components.' end
    local free = UnitInventorySize(unit) - #plan.entries
    for _, entry in ipairs(plan.entries) do if entry.remaining == 0 then free = free + 1 end end
    if free < 1 then return nil, 'Inventory full.' end
    return plan
end

local function consume(item)
    -- A charged scroll can remain a valid handle after a pickup-first craft.
    -- Remember that this pickup already paid for a result until SELL_ITEM runs.
    if FE_Recipes.byScroll[GetItemTypeId(item)] and
       GetTriggerEventId() == EVENT_PLAYER_UNIT_PICKUP_ITEM and GetManipulatedItem() == item then
        local timer = CreateTimer()
        FE_Recipes.pickupCrafted[item] = timer
        TimerStart(timer, 0, false, function()
            if FE_Recipes.pickupCrafted[item] == timer then FE_Recipes.pickupCrafted[item] = nil end
            DestroyTimer(timer)
        end)
    end
    local charges = GetItemCharges(item)
    if charges > 1 then SetItemCharges(item, charges - 1) else RemoveItem(item) end
end

local function commit(unit, plan)
    local player = GetOwningPlayer(unit)
    if GetPlayerState(player, PLAYER_STATE_RESOURCE_GOLD) < plan.gold or
       GetPlayerState(player, PLAYER_STATE_RESOURCE_LUMBER) < plan.lumber then
        return false, 'Not enough gold or lumber for the missing components.'
    end
    -- Create before consuming anything, so an invalid object definition fails
    -- without charging the player or destroying their ingredients.
    local result = CreateItem(plan.result, GetUnitX(unit), GetUnitY(unit))
    if not result then return false, 'Could not create the finished item.' end
    FE_Recipes.busy[unit] = true
    for _, item in ipairs(plan.consumed) do consume(item) end
    if plan.scroll then consume(plan.scroll) end
    SetPlayerState(player, PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(player, PLAYER_STATE_RESOURCE_GOLD) - plan.gold)
    SetPlayerState(player, PLAYER_STATE_RESOURCE_LUMBER, GetPlayerState(player, PLAYER_STATE_RESOURCE_LUMBER) - plan.lumber)
    local added = UnitAddItem(unit, result)
    FE_Recipes.busy[unit] = nil
    -- The plan guarantees a slot unless another inventory restriction intervenes.
    -- Preserve the paid-for result on the ground in that case; never delete it.
    if not added then DisplayTextToPlayer(player, 0, 0, 'The crafted item is at your feet.') end
    if FE_Shops then FE_Shops.trace(player,'Craft result '..FE_Shops.raw(plan.result)..'; in inventory='..tostring(UnitHasItem(unit,result))) end
    return true
end

function FE_Recipes.canCombineOwned(unit, result)
    if FE_Recipes.busy[unit] or FE_Recipes.pending[unit] then return false end
    return FE_Recipes.plan(unit, FE_Recipes.byResult[result], false, nil) ~= nil
end

function FE_Recipes.combineOwned(unit, result)
    if FE_Recipes.busy[unit] or FE_Recipes.pending[unit] then return false end
    local plan = FE_Recipes.plan(unit, FE_Recipes.byResult[result], false, nil)
    if not plan then return false end
    return commit(unit, plan)
end

function FE_Recipes.combineAll(unit)
    if not unit or FE_Recipes.busy[unit] or FE_Recipes.pending[unit] then return end
    -- Bound chained crafting even with charged stacks. Stable recipe and slot
    -- order prevents hash-table iteration from choosing ingredients.
    for _ = 1, UnitInventorySize(unit) do
        local changed = false
        for _, recipe in ipairs(FE_RecipeData.recipes) do
            if FE_Recipes.combineOwned(unit, recipe.result) then changed = true; break end
        end
        if not changed then break end
    end
end

local function finishSale(unit, scroll, kind, player)
    -- Native inventory delivery must finish before we replace the sold item.
    -- A six-slot inventory may leave the purchased scroll on the ground: it is
    -- still paid for and can free a slot by consuming an owned component.
    local plan, message
    if GetUnitTypeId(unit) == 0 or GetOwningPlayer(unit) ~= player or GetWidgetLife(unit) <= 0.405 then
        message = 'Buyer is no longer available.'
    else
        plan, message = FE_Recipes.plan(unit, FE_Recipes.byScroll[kind], true, scroll)
    end
    local success = false
    if plan then success, message = commit(unit, plan) end
    if not success then
        FE_Recipes.diagnostics.refunded = FE_Recipes.diagnostics.refunded + 1
        FE_Recipes.diagnostics.last = message or 'Recipe could not be completed.'
        local price = FE_RecipeData.items[kind]
        FE_Recipes.busy[unit] = true
        consume(scroll)
        SetPlayerState(player, PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(player, PLAYER_STATE_RESOURCE_GOLD) + price.gold)
        SetPlayerState(player, PLAYER_STATE_RESOURCE_LUMBER, GetPlayerState(player, PLAYER_STATE_RESOURCE_LUMBER) + price.lumber)
        FE_Recipes.busy[unit] = nil
        DisplayTextToPlayer(player, 0, 0, (message or 'Recipe could not be completed.') .. ' Recipe purchase refunded.')
        if FE_Shops then FE_Shops.trace(player,FE_Recipes.diagnostics.last..' Scroll refunded.') end
        return
    end
    FE_Recipes.diagnostics.completed = FE_Recipes.diagnostics.completed + 1
    FE_Recipes.diagnostics.last = 'Completed.'
    FE_Recipes.combineAll(unit)
end

function FE_Recipes.onSale()
    local unit, scroll, shop = GetBuyingUnit(), GetSoldItem(), GetSellingUnit()
    FE_Shops.observeSale(shop,unit,scroll)
    if scroll and FE_Recipes.byScroll[GetItemTypeId(scroll)] then
        FE_Recipes.diagnostics.sales = FE_Recipes.diagnostics.sales + 1
        FE_Recipes.diagnostics.last = 'Recipe sale observed; checking buyer.'
    end
    if not shop or not FE_RecipeData.shops[GetUnitTypeId(shop)] then return end
    if not unit or not scroll or not FE_Roles.isAncient(GetOwningPlayer(unit)) then
        FE_Shops.trace(FE_Test and FE_Test.player,'Recipe/delivery handler stopped: '..
            (not unit and 'native sale has no buyer.' or not scroll and 'native sale has no item.' or 'buyer is not owned by the Ancient.'))
        return
    end
    if FE_Recipes.busy[unit] then return end
    if FE_Recipes.pickupCrafted[scroll] then FE_Recipes.pickupCrafted[scroll] = nil; return end
    local kind, player = GetItemTypeId(scroll), GetOwningPlayer(unit)
    if not FE_Recipes.byScroll[kind] then
        local timer = CreateTimer()
        TimerStart(timer,0,false,function()
            DestroyTimer(timer)
            if GetItemTypeId(scroll) == kind then FE_Shops.deliver(unit,scroll,player) end
        end)
        return
    end
    FE_Recipes.diagnostics.last = 'Waiting for native inventory delivery.'
    FE_Recipes.pending[unit] = (FE_Recipes.pending[unit] or 0) + 1
    local timer = CreateTimer()
    TimerStart(timer, 0, false, function()
        DestroyTimer(timer)
        local remaining = FE_Recipes.pending[unit] - 1
        FE_Recipes.pending[unit] = remaining > 0 and remaining or nil
        if GetItemTypeId(scroll) == kind then finishSale(unit, scroll, kind, player)
        else FE_Shops.trace(player,'Recipe scroll was consumed/replaced before deferred completion.') end
    end)
end

function FE_Recipes.init()
    if FE_Recipes.initialized then return end
    FE_Recipes.initialized = true
    local sale, pickup = CreateTrigger(), CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(sale, EVENT_PLAYER_UNIT_SELL_ITEM)
    TriggerAddAction(sale, FE_Recipes.onSale)
    TriggerRegisterAnyUnitEventBJ(pickup, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    TriggerAddAction(pickup, function() FE_Recipes.combineAll(GetTriggerUnit()) end)
end
-- END FOREST MODULE src/items/recipes.lua

-- BEGIN FOREST MODULE src/items/shops.lua
-- Assign a buyer to the Ancient's shops; never change the player's selection.
FE_Shops = { shops = {}, lastBuyer = {}, lastPlayer = {}, lastOrder = {}, initialized = false,
    traceEnabled = false, diagnostics = {sales=0, delivered=0, ground=0, last='No shop sale observed.'} }

function FE_Shops.raw(id)
    if not id or id == 0 then return 'none' end
    if type(id) == 'string' then return id end -- Offline engine double.
    return string.char((id >> 24) & 255, (id >> 16) & 255, (id >> 8) & 255, id & 255)
end

function FE_Shops.label(unit)
    if not unit or GetUnitTypeId(unit) == 0 then return 'none' end
    return GetUnitName(unit)..' ['..FE_Shops.raw(GetUnitTypeId(unit))..', player '..(GetPlayerId(GetOwningPlayer(unit))+1)..']'
end

function FE_Shops.trace(player, text)
    if FE_Shops.traceEnabled and FE_Test and FE_Test.allowed(player) then
        DisplayTextToPlayer(player, 0, 0, '|cff80d4ff[Shop debug]|r '..text)
    end
end

function FE_Shops.radius(shop)
    local ability = BlzGetUnitAbility(shop, FourCC('Aall')) or BlzGetUnitAbility(shop, FourCC('Aneu'))
    return ability and BlzGetAbilityRealLevelField(ability, ABILITY_RLF_ACTIVATION_RADIUS, 0) or 0
end

function FE_Shops.inRange(shop, ancient)
    if not shop or not ancient or GetUnitTypeId(shop) == 0 or GetUnitTypeId(ancient) == 0 or
       GetWidgetLife(shop) <= 0.405 or GetWidgetLife(ancient) <= 0.405 or
       not FE_Roles.isAncient(GetOwningPlayer(ancient)) then return false end
    if UnitInventorySize(ancient) < 1 then return false end
    local radius = FE_Shops.radius(shop)
    return radius > 0 and IsUnitInRange(ancient, shop, radius)
end

function FE_Shops.assign(shop, force)
    local ancient, player = udg_AncientUnit, FE_Roles.ancient()
    if not FE_Shops.inRange(shop, ancient) then
        FE_Shops.lastBuyer[shop] = nil; FE_Shops.lastPlayer[shop] = nil
        return false
    end
    if force or FE_Shops.lastBuyer[shop] ~= ancient or FE_Shops.lastPlayer[shop] ~= player then
        FE_Shops.lastOrder[shop] = nil
        -- These are player-owned shops. Island Defense uses the ordinary
        -- neutralinteract target order on its owned shop; use the explicit
        -- player form for shared/neutral shops or if the owned order fails.
        -- Both orders execute on every client, never in a local UI branch.
        local accepted = false
        if GetOwningPlayer(shop) == player then
            accepted = IssueTargetOrderById(shop, 852566, ancient)
            FE_Shops.lastOrder[shop] = 'owned target: '..tostring(accepted)
        end
        if not accepted then
            accepted = IssueNeutralTargetOrderById(player, shop, 852566, ancient)
            FE_Shops.lastOrder[shop] = (FE_Shops.lastOrder[shop] or '')..'; player target: '..tostring(accepted)
        end
        if not accepted then return false end
        FE_Shops.lastBuyer[shop] = ancient; FE_Shops.lastPlayer[shop] = player
    end
    return true
end

function FE_Shops.tick()
    for _, shop in ipairs(FE_Shops.shops) do FE_Shops.assign(shop, false) end
end

function FE_Shops.onSelected()
    local shop = GetTriggerUnit()
    if FE_Roles.isAncient(GetTriggerPlayer()) and FE_RecipeData.shops[GetUnitTypeId(shop)] then
        FE_Shops.assign(shop, true)
        -- Let native shop selection settle, then reassert the same buyer.
        local player, timer = GetTriggerPlayer(), CreateTimer()
        TimerStart(timer, 0, false, function()
            DestroyTimer(timer)
            if FE_Roles.isAncient(player) then
                FE_Shops.assign(shop, true)
                FE_Shops.trace(player, FE_Shops.describe(shop))
            end
        end)
    end
end

function FE_Shops.describe(shop)
    local ancient = udg_AncientUnit
    local distance = ancient and math.floor(math.sqrt((GetUnitX(ancient)-GetUnitX(shop))^2 + (GetUnitY(ancient)-GetUnitY(shop))^2)) or -1
    local slots, used = ancient and UnitInventorySize(ancient) or 0, 0
    for slot=0,slots-1 do if UnitItemInSlot(ancient,slot) then used=used+1 end end
    return FE_Shops.label(shop)..'; hero='..FE_Shops.label(ancient)..'; distance='..distance..
        '; radius='..FE_Shops.radius(shop)..'; in range='..tostring(FE_Shops.inRange(shop, ancient))..
        '; inventory='..used..'/'..slots..
        '; order='..(FE_Shops.lastOrder[shop] or 'not issued')
end

function FE_Shops.observeSale(shop, buyer, item)
    if not shop or not FE_RecipeData.shops[GetUnitTypeId(shop)] then return end
    local d = FE_Shops.diagnostics
    d.sales = d.sales + 1
    d.last = 'Sale #'..d.sales..': '..FE_Shops.raw(GetItemTypeId(item))..'; buyer='..FE_Shops.label(buyer)
    FE_Shops.trace(FE_Test and FE_Test.player, d.last)
    -- An accepted order is not proof of the native recipient. Discard a stale
    -- cache when the sale identifies a different buyer.
    if buyer ~= FE_Shops.lastBuyer[shop] then
        FE_Shops.lastBuyer[shop] = nil; FE_Shops.lastPlayer[shop] = nil
    end
end

function FE_Shops.deliver(buyer, item, player)
    -- Only a native sale's actual buyer/item may reach here. Never scan the
    -- ground, invent a payer, duplicate an item, or take another unit's item.
    if not item or GetItemTypeId(item) == 0 then return end
    local d = FE_Shops.diagnostics
    if not buyer or GetUnitTypeId(buyer) == 0 or GetOwningPlayer(buyer) ~= player or GetWidgetLife(buyer) <= 0.405 then
        d.last = 'Delivery stopped: buyer unavailable.'
    elseif UnitHasItem(buyer, item) then
        d.delivered = d.delivered + 1; d.last = 'Delivered to '..FE_Shops.label(buyer)..'.'
    elseif IsItemOwned(item) then
        d.last = 'Delivery stopped: item is held by another unit.'
    else
        local free = false
        for slot=0,UnitInventorySize(buyer)-1 do if not UnitItemInSlot(buyer,slot) then free=true;break end end
        if free then UnitAddItem(buyer, item) end
        if GetItemTypeId(item) == 0 or UnitHasItem(buyer,item) then
            d.delivered = d.delivered + 1; d.last = 'Delivered after native ground placement.'
        else
            d.ground = d.ground + 1
            d.last = free and 'Ground item: inventory insertion rejected.' or 'Ground item: inventory full.'
            DisplayTextToPlayer(player,0,0,d.last)
        end
    end
    FE_Shops.trace(player,d.last)
end

function FE_Shops.initDebug(player)
    if FE_Shops.debugInitialized then return end
    FE_Shops.debugInitialized = true
    local orders = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(orders, EVENT_PLAYER_UNIT_ISSUED_ORDER)
    TriggerAddAction(orders, function()
        local shop, id = GetTriggerUnit(), GetIssuedOrderId()
        local stock = FE_RecipeData.stock[GetUnitTypeId(shop)]
        if not FE_Test.allowed(player) or not FE_Shops.traceEnabled or not stock or not stock[id] then return end
        local before, gold, timer = FE_Shops.diagnostics.sales, GetPlayerState(player,PLAYER_STATE_RESOURCE_GOLD), CreateTimer()
        FE_Shops.trace(player,'Buy order '..FE_RecipeData.items[id].name..' ['..FE_Shops.raw(id)..']. '..FE_Shops.describe(shop))
        TimerStart(timer,0.1,false,function()
            DestroyTimer(timer)
            FE_Shops.trace(player,'After order: sale counter '..before..' -> '..FE_Shops.diagnostics.sales..
                '; gold '..gold..' -> '..GetPlayerState(player,PLAYER_STATE_RESOURCE_GOLD)..'. '..FE_Shops.diagnostics.last)
        end)
    end)
    for _,kind in ipairs({EVENT_PLAYER_UNIT_PICKUP_ITEM,EVENT_PLAYER_UNIT_DROP_ITEM}) do
        local trigger = CreateTrigger()
        TriggerRegisterAnyUnitEventBJ(trigger,kind)
        TriggerAddAction(trigger,function()
            if GetOwningPlayer(GetTriggerUnit()) == player then
                FE_Shops.trace(player,(kind == EVENT_PLAYER_UNIT_PICKUP_ITEM and 'Pickup ' or 'Drop ')..
                    FE_Shops.raw(GetItemTypeId(GetManipulatedItem()))..'; unit='..FE_Shops.label(GetTriggerUnit()))
            end
        end)
    end
end

function FE_Shops.init()
    if FE_Shops.initialized then return end
    FE_Shops.initialized = true
    local group, bounds = CreateGroup(), GetWorldBounds()
    GroupEnumUnitsInRect(group, bounds, nil)
    while true do
        local unit = FirstOfGroup(group)
        if not unit then break end
        GroupRemoveUnit(group, unit)
        if FE_RecipeData.shops[GetUnitTypeId(unit)] then FE_Shops.shops[#FE_Shops.shops + 1] = unit end
    end
    DestroyGroup(group); RemoveRect(bounds)
    local selected = CreateTrigger()
    FE_Roles.forEachPlayer(function(player)
        TriggerRegisterPlayerUnitEventSimple(selected, player, EVENT_PLAYER_UNIT_SELECTED)
    end)
    TriggerAddAction(selected, FE_Shops.onSelected)
    TimerStart(CreateTimer(), 0.25, true, FE_Shops.tick)
end
-- END FOREST MODULE src/items/shops.lua

-- BEGIN FOREST MODULE src/items/ledgers.lua
-- Each carrier earns its own XP. Read its inventory at each tick so nested
-- crafting/drop events cannot leave stale global counters behind.
FE_Ledgers = { units = {}, known = {} }

function FE_Ledgers.watch(unit)
    if unit and not FE_Ledgers.known[unit] then
        FE_Ledgers.known[unit] = true
        FE_Ledgers.units[#FE_Ledgers.units + 1] = unit
    end
end

function FE_Ledgers.tick()
    for index = #FE_Ledgers.units, 1, -1 do
        local unit = FE_Ledgers.units[index]
        local xp = 0
        if GetUnitTypeId(unit) ~= 0 then
            if UnitHasItemOfTypeBJ(unit, FourCC('I01N')) then xp = 8
            elseif UnitHasItemOfTypeBJ(unit, FourCC('I01J')) then xp = 3 end
        end
        if xp == 0 then
            FE_Ledgers.known[unit] = nil; table.remove(FE_Ledgers.units, index)
        elseif GetWidgetLife(unit) > 0.405 then
            AddHeroXP(unit, xp, true)
        end
    end
end
-- END FOREST MODULE src/items/ledgers.lua

-- BEGIN FOREST MODULE src/combat/focused_anger.lua
-- Unit custom data belongs to Unit Indexer. Never use it as a spell counter.
FE_FocusedAnger = { stacks = {} }

function FE_FocusedAnger.count(unit)
    return FE_FocusedAnger.stacks[unit] or 0
end

function FE_FocusedAnger.add(unit)
    if not unit or GetUnitTypeId(unit) == 0 or FE_FocusedAnger.count(unit) >= 15 then return end
    FE_FocusedAnger.stacks[unit] = FE_FocusedAnger.count(unit) + 1
    IncUnitAbilityLevel(unit, FourCC('A06K'))
    local timer = CreateTimer()
    TimerStart(timer, 6, false, function()
        local remaining = FE_FocusedAnger.count(unit) - 1
        FE_FocusedAnger.stacks[unit] = remaining > 0 and remaining or nil
        if GetUnitTypeId(unit) ~= 0 then DecUnitAbilityLevel(unit, FourCC('A06K')) end
        DestroyTimer(timer)
    end)
end
-- END FOREST MODULE src/combat/focused_anger.lua

-- BEGIN FOREST MODULE src/libraries/damage_engine.lua
-- Original JASS function: sc___prototype2_execute (line 1307)
function sc___prototype2_execute(i, a1, a2, a3, a4)
    f__arg_trigger1 = a1
    f__arg_string1 = a2
    f__arg_limitop1 = a3
    f__arg_real1 = a4
    TriggerExecute(st___prototype2[i])
end

-- Original JASS function: sc___prototype2_evaluate (line 1315)
function sc___prototype2_evaluate(i, a1, a2, a3, a4)
    f__arg_trigger1 = a1
    f__arg_string1 = a2
    f__arg_limitop1 = a3
    f__arg_real1 = a4
    TriggerEvaluate(st___prototype2[i])
end

-- Original JASS function: h__TriggerRegisterVariableEvent (line 1324)
function h__TriggerRegisterVariableEvent(a0, a1, a2, a3)
    sc___prototype2_evaluate(1, a0, a1, a2, a3)
    do return TriggerRegisterVariableEvent(a0, a1, a2, a3) end
end

-- Original JASS function: s__DamageTrigger_checkItem (line 1338)
function s__DamageTrigger_checkItem(u, id)
    local i = 0
    if IsUnitType(u, UNIT_TYPE_HERO) then
        i = UnitInventorySize(u)
        while true do
            if (i <= 0) then break end
            i = __jint(i - 1)
            if (GetItemTypeId(UnitItemInSlot(u, i)) == id) then
                do return true end
            end
        end
    end
    do return false end
end

-- Original JASS function: s__DamageTrigger_checkConfig (line 1354)
function s__DamageTrigger_checkConfig(this)
    if ((s__DamageTrigger_sourceType[this] ~= 0) and (GetUnitTypeId(udg_DamageEventSource) ~= s__DamageTrigger_sourceType[this])) then
    elseif ((s__DamageTrigger_targetType[this] ~= 0) and (GetUnitTypeId(udg_DamageEventTarget) ~= s__DamageTrigger_targetType[this])) then
    elseif ((s__DamageTrigger_sourceBuff[this] ~= 0) and (GetUnitAbilityLevel(udg_DamageEventSource, s__DamageTrigger_sourceBuff[this]) == 0)) then
    elseif ((s__DamageTrigger_targetBuff[this] ~= 0) and (GetUnitAbilityLevel(udg_DamageEventTarget, s__DamageTrigger_targetBuff[this]) == 0)) then
    elseif ((s__DamageTrigger_failChance[this] > __jreal(0.00)) and (GetRandomReal(__jreal(0.00), __jreal(1.00)) <= s__DamageTrigger_failChance[this])) then
    elseif ((s__DamageTrigger_userType[this] ~= 0) and (udg_DamageEventType ~= s__DamageTrigger_userType[this])) then
    elseif ((s__DamageTrigger_source[this] ~= nil) and (s__DamageTrigger_source[this] ~= udg_DamageEventSource)) then
    elseif ((s__DamageTrigger_target[this] ~= nil) and (s__DamageTrigger_target[this] ~= udg_DamageEventTarget)) then
    elseif ((s__DamageTrigger_attackType[this] >= 0) and (s__DamageTrigger_attackType[this] ~= udg_DamageEventAttackT)) then
    elseif ((s__DamageTrigger_damageType[this] >= 0) and (s__DamageTrigger_damageType[this] ~= udg_DamageEventDamageT)) then
    elseif ((s__DamageTrigger_sourceItem[this] ~= 0) and (not s__DamageTrigger_checkItem(udg_DamageEventSource, s__DamageTrigger_sourceItem[this]))) then
    elseif ((s__DamageTrigger_targetItem[this] ~= 0) and (not s__DamageTrigger_checkItem(udg_DamageEventTarget, s__DamageTrigger_targetItem[this]))) then
    elseif ((s__DamageTrigger_sourceClass[this] >= 0) and (not IsUnitType(udg_DamageEventSource, ConvertUnitType(s__DamageTrigger_sourceClass[this])))) then
    elseif ((s__DamageTrigger_targetClass[this] >= 0) and (not IsUnitType(udg_DamageEventTarget, ConvertUnitType(s__DamageTrigger_targetClass[this])))) then
    elseif (udg_DamageEventAmount >= s__DamageTrigger_damageMin[this]) then
        do return true end
    end
    do return false end
end

-- Original JASS function: s__DamageTrigger__get_runChance (line 1392)
function s__DamageTrigger__get_runChance(this)
    do return __jreal(__jreal(1.00) - s__DamageTrigger_failChance[this]) end
end

-- Original JASS function: s__DamageTrigger__set_runChance (line 1397)
function s__DamageTrigger__set_runChance(this, chance)
    s__DamageTrigger_failChance[this] = __jreal(__jreal(1.00) - chance)
end

-- Original JASS function: s__DamageTrigger_configure (line 1401)
function s__DamageTrigger_configure(this)
    s__DamageTrigger_attackType[this] = udg_DamageFilterAttackT
    s__DamageTrigger_damageType[this] = udg_DamageFilterDamageT
    s__DamageTrigger_source[this] = udg_DamageFilterSource
    s__DamageTrigger_target[this] = udg_DamageFilterTarget
    s__DamageTrigger_sourceType[this] = udg_DamageFilterSourceT
    s__DamageTrigger_targetType[this] = udg_DamageFilterTargetT
    s__DamageTrigger_sourceItem[this] = udg_DamageFilterSourceI
    s__DamageTrigger_targetItem[this] = udg_DamageFilterTargetI
    s__DamageTrigger_sourceClass[this] = udg_DamageFilterSourceC
    s__DamageTrigger_targetClass[this] = udg_DamageFilterTargetC
    s__DamageTrigger_userType[this] = udg_DamageFilterType
    s__DamageTrigger_damageMin[this] = udg_DamageFilterMinAmount
    s__DamageTrigger_failChance[this] = __jreal(__jreal(1.00) - (__jreal(udg_DamageFilterRunChance - udg_DamageFilterFailChance)))
    if (udg_DamageFilterSourceA > 0) then
        s__DamageTrigger_sourceBuff[this] = udg_DamageFilterSourceA
        udg_DamageFilterSourceA = 0
    else
        s__DamageTrigger_sourceBuff[this] = udg_DamageFilterSourceB
    end
    if (udg_DamageFilterTargetA > 0) then
        s__DamageTrigger_targetBuff[this] = udg_DamageFilterTargetA
        udg_DamageFilterTargetA = 0
    else
        s__DamageTrigger_targetBuff[this] = udg_DamageFilterTargetB
    end
    udg_DamageFilterSource = nil
    udg_DamageFilterTarget = nil
    udg_DamageFilterAttackT = __jint(-(1))
    udg_DamageFilterDamageT = __jint(-(1))
    udg_DamageFilterSourceC = __jint(-(1))
    udg_DamageFilterTargetC = __jint(-(1))
    udg_DamageFilterSourceT = 0
    udg_DamageFilterTargetT = 0
    udg_DamageFilterType = 0
    udg_DamageFilterSourceB = 0
    udg_DamageFilterTargetB = 0
    udg_DamageFilterSourceI = 0
    udg_DamageFilterTargetI = 0
    udg_DamageFilterMinAmount = __jreal(0.00)
    udg_DamageFilterFailChance = __jreal(0.00)
    udg_DamageFilterRunChance = __jreal(1.00)
    s__DamageTrigger_configured[this] = true
end

-- Original JASS function: s__DamageTrigger_setGUIFromStruct (line 1454)
function s__DamageTrigger_setGUIFromStruct(full)
    udg_DamageEventAmount = s__Damage_damage[s__Damage_index]
    udg_DamageEventAttackT = GetHandleId(s__Damage_attackType[s__Damage_index])
    udg_DamageEventDamageT = GetHandleId(s__Damage_damageType[s__Damage_index])
    udg_DamageEventWeaponT = GetHandleId(s__Damage_weaponType[s__Damage_index])
    udg_DamageEventType = s__Damage_userType[s__Damage_index]
    udg_DamageEventArmorPierced = s__Damage_armorPierced[s__Damage_index]
    udg_DamageEventArmorT = s__Damage_armorType[s__Damage_index]
    udg_DamageEventDefenseT = s__Damage_defenseType[s__Damage_index]
    if full then
        udg_DamageEventSource = s__Damage_sourceUnit[s__Damage_index]
        udg_DamageEventTarget = s__Damage_targetUnit[s__Damage_index]
        udg_DamageEventPrevAmt = s__Damage_prevAmt[s__Damage_index]
        udg_IsDamageAttack = s__Damage_isAttack[s__Damage_index]
        udg_IsDamageCode = s__Damage_isCode[s__Damage_index]
        udg_IsDamageSpell = s__Damage_isSpell[s__Damage_index]
        udg_IsDamageMelee = s__Damage_isMelee[s__Damage_index]
        udg_IsDamageRanged = s__Damage_isRanged[s__Damage_index]
    end
end

-- Original JASS function: s__DamageTrigger_setStructFromGUI (line 1483)
function s__DamageTrigger_setStructFromGUI()
    s__Damage_damage[s__Damage_index] = udg_DamageEventAmount
    s__Damage_attackType[s__Damage_index] = ConvertAttackType(udg_DamageEventAttackT)
    s__Damage_damageType[s__Damage_index] = ConvertDamageType(udg_DamageEventDamageT)
    s__Damage_weaponType[s__Damage_index] = ConvertWeaponType(udg_DamageEventWeaponT)
    s__Damage_userType[s__Damage_index] = udg_DamageEventType
    s__Damage_armorPierced[s__Damage_index] = udg_DamageEventArmorPierced
    s__Damage_armorType[s__Damage_index] = udg_DamageEventArmorT
    s__Damage_defenseType[s__Damage_index] = udg_DamageEventDefenseT
end

-- Original JASS function: s__DamageTrigger_getVerboseStr (line 1497)
function s__DamageTrigger_getVerboseStr(eventName)
    if ((eventName == "Modifier") or (eventName == "Mod")) then
        do return "udg_DamageModifierEvent" end
    end
    do return __jconcat(__jconcat("udg_", eventName), "DamageEvent") end
end

-- Original JASS function: s__DamageTrigger_getStrIndex (line 1504)
function s__DamageTrigger_getStrIndex(var, lbs)
    local root = R2I(lbs)
    if ((((var == "udg_DamageModifierEvent") and (root < 4))) or (var == "udg_PreDamageEvent")) then
        root = s__DamageTrigger_MOD
    elseif ((var == "udg_DamageModifierEvent") or (var == "udg_ArmorDamageEvent")) then
        root = s__DamageTrigger_SHIELD
    elseif (((((var == "udg_DamageEvent") and (root == 2)) or (root == 0))) or (var == "udg_ZeroDamageEvent")) then
        root = s__DamageTrigger_ZERO
    elseif ((var == "udg_DamageEvent") or (var == "udg_OnDamageEvent")) then
        root = s__DamageTrigger_DAMAGE
    elseif (var == "udg_AfterDamageEvent") then
        root = s__DamageTrigger_AFTER
    elseif (var == "udg_LethalDamageEvent") then
        root = s__DamageTrigger_LETHAL
    elseif ((var == "udg_AOEDamageEvent") or (var == "udg_SourceDamageEvent")) then
        root = s__DamageTrigger_AOE
    else
        root = 0
    end
    do return root end
end

-- Original JASS function: s__DamageTrigger_toggleAllFilters (line 1533)
function s__DamageTrigger_toggleAllFilters(this, flag)
    s__DamageTrigger_filters[__jint(this + DamageEngine_FILTER_ATTACK)] = flag
    s__DamageTrigger_filters[__jint(this + DamageEngine_FILTER_MELEE)] = flag
    s__DamageTrigger_filters[__jint(this + DamageEngine_FILTER_OTHER)] = flag
    s__DamageTrigger_filters[__jint(this + DamageEngine_FILTER_RANGED)] = flag
    s__DamageTrigger_filters[__jint(this + DamageEngine_FILTER_SPELL)] = flag
    s__DamageTrigger_filters[__jint(this + DamageEngine_FILTER_CODE)] = flag
end

-- Original JASS function: s__DamageTrigger__set_filter (line 1542)
function s__DamageTrigger__set_filter(this, opId)
    this = __jint(this * DamageEngine_FILTER_MAX)
    if (opId == DamageEngine_FILTER_OTHER) then
        s__DamageTrigger_toggleAllFilters(this, true)
    else
        if (opId == DamageEngine_FILTER_ATTACK) then
            s__DamageTrigger_filters[__jint(this + DamageEngine_FILTER_ATTACK)] = true
            s__DamageTrigger_filters[__jint(this + DamageEngine_FILTER_MELEE)] = true
            s__DamageTrigger_filters[__jint(this + DamageEngine_FILTER_RANGED)] = true
        else
            s__DamageTrigger_filters[__jint(this + opId)] = true
        end
    end
end

-- Original JASS function: s__DamageTrigger_registerVerbose (line 1557)
function s__DamageTrigger_registerVerbose(whichTrig, var, lbs, GUI, filt)
    local index = s__DamageTrigger_getStrIndex(var, lbs)
    local i = 0
    local id = 0
    if (index == 0) then
        do return 0 end
    elseif ((s__DamageTrigger_rootTrig[s__DamageTrigger_lastRegistered] == whichTrig) and s__DamageTrigger_usingGUI[s__DamageTrigger_lastRegistered]) then
        s__DamageTrigger_filters[__jint(__jint(s__DamageTrigger_lastRegistered * DamageEngine_FILTER_MAX) + filt)] = true
        do return 0 end
    end
    DamageEngine___atLeastOneLethalDamageEventRegistered = (DamageEngine___atLeastOneLethalDamageEventRegistered or (index == s__DamageTrigger_LETHAL))
    if (s__DamageTrigger_trigIndexStack[0] == 0) then
        s__DamageTrigger_count = __jint(s__DamageTrigger_count + 1)
        id = s__DamageTrigger_count
    else
        id = s__DamageTrigger_trigIndexStack[0]
        s__DamageTrigger_trigIndexStack[0] = s__DamageTrigger_trigIndexStack[id]
    end
    s__DamageTrigger_lastRegistered = id
    s__DamageTrigger__set_filter(id, filt)
    s__DamageTrigger_rootTrig[id] = whichTrig
    s__DamageTrigger_usingGUI[id] = GUI
    s__DamageTrigger_weight[id] = lbs
    s__DamageTrigger_eventStr[id] = var
    s__DamageTrigger_attackType[id] = __jint(-(1))
    s__DamageTrigger_damageType[id] = __jint(-(1))
    s__DamageTrigger_sourceClass[id] = __jint(-(1))
    s__DamageTrigger_targetClass[id] = __jint(-(1))
    while true do
        i = s__DamageTrigger_next[index]
        if ((i == 0) or (lbs < s__DamageTrigger_weight[i])) then break end
        index = i
    end
    s__DamageTrigger_next[index] = id
    s__DamageTrigger_next[id] = i
    do return s__DamageTrigger_lastRegistered end
end

-- Original JASS function: s__DamageTrigger_registerTrigger (line 1607)
function s__DamageTrigger_registerTrigger(t, var, lbs)
    do return s__DamageTrigger_registerVerbose(t, s__DamageTrigger_getVerboseStr(var), lbs, false, DamageEngine_FILTER_OTHER) end
end

-- Original JASS function: s__DamageTrigger_getIndex (line 1611)
function s__DamageTrigger_getIndex(t, eventName, lbs)
    local index = s__DamageTrigger_getStrIndex(s__DamageTrigger_getVerboseStr(eventName), lbs)
    while true do
        s__DamageTrigger_prev = index
        index = s__DamageTrigger_next[index]
        if ((index == 0) or (s__DamageTrigger_rootTrig[index] == t)) then break end
    end
    do return index end
end

-- Original JASS function: s__DamageTrigger_unregisterByIndex (line 1621)
function s__DamageTrigger_unregisterByIndex(this, reset)
    if (this == 0) then
        do return false end
    end
    s__DamageTrigger_next[s__DamageTrigger_prev] = s__DamageTrigger_next[this]
    s__DamageTrigger_trigIndexStack[this] = s__DamageTrigger_trigIndexStack[0]
    s__DamageTrigger_trigIndexStack[0] = this
    if reset then
        s__DamageTrigger_configure(this)
        s__DamageTrigger_configured[this] = false
        s__DamageTrigger_toggleAllFilters((__jint(this * DamageEngine_FILTER_MAX)), false)
    end
    do return true end
end

-- Original JASS function: s__DamageTrigger_unregister (line 1638)
function s__DamageTrigger_unregister(t, eventName, lbs, reset)
    do return s__DamageTrigger_unregisterByIndex(s__DamageTrigger_getIndex(t, eventName, lbs), reset) end
end

-- Original JASS function: s__DamageTrigger_DamageEngine___run (line 1642)
function s__DamageTrigger_DamageEngine___run(this)
    local cat = this
    local d = s__Damage_index
    local structUnset = false
    local guiUnset = false
    local mod = (cat <= s__DamageTrigger_DAMAGE)
    if DamageEngine___callbacksInProgress then
        do return end
    end
    DamageEngine___callbacksInProgress = true
    DisableTrigger(DamageEngine___damagingTrigger)
    DisableTrigger(DamageEngine___damagedTrigger)
    EnableTrigger(DamageEngine___recursiveTrigger)
    while true do
        this = s__DamageTrigger_next[this]
        if (this == 0) then break end
        if ((cat == s__DamageTrigger_MOD) and ((udg_DamageEventOverride or (udg_DamageEventType == DamageEngine_TYPE_PURE)))) then break end
        if ((cat == s__DamageTrigger_SHIELD) and (udg_DamageEventAmount <= __jreal(0.00))) then break end
        if ((cat == s__DamageTrigger_LETHAL) and (udg_LethalDamageHP > DamageEngine___DEATH_VAL)) then break end
        s__DamageTrigger_eventIndex = this
        if ((((((not s__DamageTrigger_DamageEngine___trigFrozen[this])) and s__DamageTrigger_filters[__jint(__jint(this * DamageEngine_FILTER_MAX) + s__Damage_eFilter[d])]) and IsTriggerEnabled(s__DamageTrigger_rootTrig[this])) and ((((not s__DamageTrigger_configured[this])) or (s__DamageTrigger_checkConfig(this))))) and ((((cat ~= s__DamageTrigger_AOE) or (udg_DamageEventAOE > 1)) or (s__DamageTrigger_eventStr[this] == "udg_SourceDamageEvent")))) then
            if mod then
                if s__DamageTrigger_usingGUI[this] then
                    if guiUnset then
                        guiUnset = false
                        s__DamageTrigger_setGUIFromStruct(false)
                    end
                elseif structUnset then
                    structUnset = false
                    s__DamageTrigger_setStructFromGUI()
                end
            end
            if TriggerEvaluate(s__DamageTrigger_rootTrig[this]) then
                TriggerExecute(s__DamageTrigger_rootTrig[this])
            end
            if mod then
                if s__DamageTrigger_usingGUI[this] then
                    if (cat ~= s__DamageTrigger_MOD) then
                        s__Damage_damage[d] = udg_DamageEventAmount
                    else
                        structUnset = true
                    end
                elseif (cat ~= s__DamageTrigger_MOD) then
                    udg_DamageEventAmount = s__Damage_damage[d]
                else
                    guiUnset = true
                end
            end
            if udg_RemoveDamageEvent then
                udg_RemoveDamageEvent = false
                s__DamageTrigger_unregisterByIndex(this, true)
            end
        end
    end
    if structUnset then
        s__DamageTrigger_setStructFromGUI()
    end
    if guiUnset then
        s__DamageTrigger_setGUIFromStruct(false)
    end
    DisableTrigger(DamageEngine___recursiveTrigger)
    EnableTrigger(DamageEngine___damagingTrigger)
    EnableTrigger(DamageEngine___damagedTrigger)
    DamageEngine___callbacksInProgress = false
end

-- Original JASS function: s__DamageTrigger__staticgetindex (line 1746)
function s__DamageTrigger__staticgetindex(callback)
    local i = 0
    local b = Filter(callback)
    while true do
        if (i == s__DamageTrigger_autoN) then
            s__DamageTrigger_autoTriggers[i] = CreateTrigger()
            s__DamageTrigger_autoFuncs[i] = b
            TriggerAddCondition(s__DamageTrigger_autoTriggers[i], b)
            if true then break end
        end
        i = __jint(i + 1)
        if (b == s__DamageTrigger_autoFuncs[i]) then break end
    end
    do return s__DamageTrigger_autoTriggers[i] end
end

-- Original JASS function: s__Damage__get_source (line 1782)
function s__Damage__get_source()
    do return udg_DamageEventSource end
end

-- Original JASS function: s__Damage__get_target (line 1786)
function s__Damage__get_target()
    do return udg_DamageEventTarget end
end

-- Original JASS function: s__Damage__get_amount (line 1790)
function s__Damage__get_amount()
    do return s__Damage_damage[s__Damage_index] end
end

-- Original JASS function: s__Damage__set_amount (line 1794)
function s__Damage__set_amount(r)
    s__Damage_damage[s__Damage_index] = r
end

-- Original JASS function: s__Damage_setArmor (line 1799)
function s__Damage_setArmor(this, reset)
    local pierce = 0.0
    local at = 0
    local dt = 0
    if reset then
        pierce = udg_DamageEventArmorPierced
        at = s__Damage_prevArmorT[s__Damage_index]
        dt = s__Damage_prevDefenseT[s__Damage_index]
        udg_DamageEventArmorPierced = __jreal(0.00)
        s__Damage_armorPierced[this] = __jreal(0.00)
    else
        pierce = (-(udg_DamageEventArmorPierced))
        at = udg_DamageEventArmorT
        dt = udg_DamageEventDefenseT
    end
    if (not ((pierce == __jreal(0.00)))) then
        BlzSetUnitArmor(udg_DamageEventTarget, __jreal(BlzGetUnitArmor(udg_DamageEventTarget) + pierce))
    end
    if (s__Damage_prevArmorT[s__Damage_index] ~= udg_DamageEventArmorT) then
        BlzSetUnitIntegerField(udg_DamageEventTarget, UNIT_IF_ARMOR_TYPE, at)
    end
    if (s__Damage_prevDefenseT[s__Damage_index] ~= udg_DamageEventDefenseT) then
        BlzSetUnitIntegerField(udg_DamageEventTarget, UNIT_IF_DEFENSE_TYPE, dt)
    end
end

-- Original JASS function: s__Damage_onAOEEnd (line 1830)
function s__Damage_onAOEEnd()
    s__DamageTrigger_DamageEngine___run(s__DamageTrigger_AOE)
    udg_DamageEventAOE = 1
    udg_DamageEventLevel = 1
    udg_EnhancedDamageTarget = nil
    udg_AOEDamageSource = nil
    GroupClear(udg_DamageEventAOEGroup)
end

-- Original JASS function: s__Damage_afterDamage (line 1840)
function s__Damage_afterDamage()
    if ((udg_DamageEventDamageT ~= 0) and (not ((udg_DamageEventPrevAmt == __jreal(0.00))))) then
        s__DamageTrigger_DamageEngine___run(s__DamageTrigger_AFTER)
        udg_DamageEventDamageT = 0
        udg_DamageEventPrevAmt = __jreal(0.00)
    end
end

-- Original JASS function: s__Damage_runDamagingEvents (line 1848)
function s__Damage_runDamagingEvents(this, natural)
    s__Damage_armorType[this] = BlzGetUnitIntegerField(s__Damage_targetUnit[this], UNIT_IF_ARMOR_TYPE)
    s__Damage_defenseType[this] = BlzGetUnitIntegerField(s__Damage_targetUnit[this], UNIT_IF_DEFENSE_TYPE)
    s__Damage_prevArmorT[this] = s__Damage_armorType[this]
    s__Damage_prevDefenseT[this] = s__Damage_defenseType[this]
    s__Damage_armorPierced[this] = __jreal(0.00)
    s__Damage_index = this
    s__DamageTrigger_setGUIFromStruct(true)
    GroupAddUnit(DamageEngine___recursionSources, udg_DamageEventSource)
    GroupAddUnit(DamageEngine___recursionTargets, udg_DamageEventTarget)
    if (not ((udg_DamageEventAmount == __jreal(0.00)))) then
        udg_DamageEventOverride = (udg_DamageEventDamageT == 0)
        s__DamageTrigger_DamageEngine___run(s__DamageTrigger_MOD)
        if natural then
            BlzSetEventAttackType(s__Damage_attackType[this])
            BlzSetEventDamageType(s__Damage_damageType[this])
            BlzSetEventWeaponType(s__Damage_weaponType[this])
            BlzSetEventDamage(udg_DamageEventAmount)
        end
        s__Damage_setArmor(this, false)
        do return false end
    end
    do return true end
end

-- Original JASS function: s__Damage_unfreeze (line 1897)
function s__Damage_unfreeze()
    local i = s__Damage_damageStack
    while true do
        if (i == 0) then break end
        i = __jint(i - 1)
        s__DamageTrigger_DamageEngine___trigFrozen[s__Damage_recursiveTrig[s__Damage_stackRef[i]]] = false
        s__DamageTrigger_DamageEngine___ownRecursiveDepth[s__Damage_recursiveTrig[s__Damage_stackRef[i]]] = 0
    end
    EnableTrigger(DamageEngine___damagingTrigger)
    EnableTrigger(DamageEngine___damagedTrigger)
    DamageEngine___recursiveCallbaksInProgress = false
    s__Damage_damageStack = 0
    s__Damage_prepped = 0
    DamageEngine___callbacksInProgress = false
    DamageEngine___recursiveCallbackDepth = 0
    GroupClear(DamageEngine___recursionSources)
    GroupClear(DamageEngine___recursionTargets)
end

-- Original JASS function: s__Damage_runAfterDamageEvents (line 1921)
function s__Damage_runAfterDamageEvents()
    local i = 0
    local exit = 0
    if DamageEngine___nativeEventsCompleted then
        DamageEngine___nativeEventsCompleted = false
        s__Damage_afterDamage()
    end
    if (DamageEngine___isNotNativeRecursiveDamage and (not DamageEngine___recursiveCallbaksInProgress)) then
        if (s__Damage_damageStack ~= 0) then
            DamageEngine___recursiveCallbaksInProgress = true
            while true do
                DamageEngine___recursiveCallbackDepth = __jint(DamageEngine___recursiveCallbackDepth + 1)
                exit = s__Damage_damageStack
                while true do
                    s__Damage_prepped = s__Damage_stackRef[i]
                    if UnitAlive(s__Damage_targetUnit[s__Damage_prepped]) then
                        s__Damage_runDamagingEvents(s__Damage_prepped, false)
                        if (s__Damage_damage[s__Damage_prepped] > __jreal(0.00)) then
                            DisableTrigger(DamageEngine___damagingTrigger)
                            EnableTrigger(DamageEngine___damagedTrigger)
                            DamageEngine___waitingForDamageEventToRun = true
                            UnitDamageTarget(s__Damage_sourceUnit[s__Damage_prepped], s__Damage_targetUnit[s__Damage_prepped], s__Damage_damage[s__Damage_prepped], s__Damage_isAttack[s__Damage_prepped], s__Damage_isRanged[s__Damage_prepped], s__Damage_attackType[s__Damage_prepped], s__Damage_damageType[s__Damage_prepped], s__Damage_weaponType[s__Damage_prepped])
                        else
                            if (udg_DamageEventDamageT ~= 0) then
                                s__DamageTrigger_DamageEngine___run(s__DamageTrigger_DAMAGE)
                            end
                            if (s__Damage_damage[s__Damage_prepped] < __jreal(0.00)) then
                                SetWidgetLife(s__Damage_targetUnit[s__Damage_prepped], __jreal(GetWidgetLife(s__Damage_targetUnit[s__Damage_prepped]) - s__Damage_damage[s__Damage_prepped]))
                            end
                            s__Damage_setArmor(s__Damage_prepped, true)
                        end
                        s__Damage_afterDamage()
                    end
                    i = __jint(i + 1)
                    if (i == exit) then break end
                end
                if (i == s__Damage_damageStack) then break end
            end
        end
        s__Damage_unfreeze()
    end
end

-- Original JASS function: s__Damage_failsafeClear (line 1979)
function s__Damage_failsafeClear()
    s__Damage_setArmor(s__Damage_index, true)
    DamageEngine___isNotNativeRecursiveDamage = true
    DamageEngine___recursiveCallbaksInProgress = false
    DamageEngine___waitingForDamageEventToRun = false
    if (udg_DamageEventDamageT ~= 0) then
        s__DamageTrigger_DamageEngine___run(s__DamageTrigger_DAMAGE)
        DamageEngine___nativeEventsCompleted = true
    end
    s__Damage_runAfterDamageEvents()
end

-- Original JASS function: s__Damage__set_enabled (line 1996)
function s__Damage__set_enabled(b)
    if b then
        if DamageEngine___callbacksInProgress then
            EnableTrigger(DamageEngine___recursiveTrigger)
        else
            EnableTrigger(DamageEngine___damagingTrigger)
            EnableTrigger(DamageEngine___damagedTrigger)
        end
    else
        if DamageEngine___callbacksInProgress then
            DisableTrigger(DamageEngine___recursiveTrigger)
        else
            DisableTrigger(DamageEngine___damagingTrigger)
            DisableTrigger(DamageEngine___damagedTrigger)
        end
    end
end

-- Original JASS function: s__Damage__get_enabled (line 2014)
function s__Damage__get_enabled()
    do return IsTriggerEnabled(DamageEngine___damagingTrigger) end
end

-- Original JASS function: s__Damage_asyncCallbackSafeCallback (line 2019)
function s__Damage_asyncCallbackSafeCallback()
    if DamageEngine___waitingForDamageEventToRun then
        s__Damage_failsafeClear()
    else
        DamageEngine___isNotNativeRecursiveDamage = true
        DamageEngine___recursiveCallbaksInProgress = false
        s__Damage_runAfterDamageEvents()
    end
    s__Damage_onAOEEnd()
    s__Damage_threadCompleted = true
end

-- Original JASS function: s__Damage_asyncCallback (line 2036)
function s__Damage_asyncCallback()
    DamageEngine___callbacksInProgress = false
    s__Damage__set_enabled(true)
    ForForce(bj_FORCE_PLAYER[0], s__Damage_asyncCallbackSafeCallback)
    if (not s__Damage_threadCompleted) then
        s__Damage_unfreeze()
    else
        s__Damage_threadCompleted = false
    end
    s__Damage_count = 0
    s__Damage_index = 0
    DamageEngine___timerStarted = false
end

-- Original JASS function: s__Damage_addRecursive (line 2056)
function s__Damage_addRecursive(this)
    local currentIndex = 0
    if (not ((s__Damage_damage[this] == __jreal(0.00)))) then
        currentIndex = s__DamageTrigger_eventIndex
        s__Damage_recursiveTrig[this] = currentIndex
        if (not s__Damage_isCode[this]) then
            s__Damage_isCode[this] = true
            s__Damage_userType[this] = DamageEngine_TYPE_CODE
        end
        DamageEngine_inception = (DamageEngine_inception or s__DamageTrigger_DamageEngine___manualRecursionRequested[currentIndex])
        if ((DamageEngine___recursiveCallbaksInProgress and IsUnitInGroup(s__Damage_sourceUnit[this], DamageEngine___recursionSources)) and IsUnitInGroup(s__Damage_targetUnit[this], DamageEngine___recursionTargets)) then
            if (not DamageEngine_inception) then
                s__DamageTrigger_DamageEngine___trigFrozen[currentIndex] = true
            elseif (not s__DamageTrigger_DamageEngine___trigFrozen[currentIndex]) then
                s__DamageTrigger_DamageEngine___manualRecursionRequested[currentIndex] = true
                if (s__DamageTrigger_DamageEngine___ownRecursiveDepth[currentIndex] < DamageEngine___recursiveCallbackDepth) then
                    s__DamageTrigger_DamageEngine___ownRecursiveDepth[currentIndex] = __jint(s__DamageTrigger_DamageEngine___ownRecursiveDepth[currentIndex] + 1)
                    if (s__DamageTrigger_DamageEngine___ownRecursiveDepth[currentIndex] >= DamageEngine___MAX_RECURSIVE_TOLERANCE) then
                        s__DamageTrigger_DamageEngine___trigFrozen[currentIndex] = true
                    end
                end
            end
        end
        s__Damage_stackRef[s__Damage_damageStack] = this
        s__Damage_damageStack = __jint(s__Damage_damageStack + 1)
    end
    DamageEngine_inception = false
end

-- Original JASS function: s__Damage_clearNexts (line 2101)
function s__Damage_clearNexts()
    udg_NextDamageIsAttack = false
    udg_NextDamageType = 0
    udg_NextDamageWeaponT = 0
    udg_NextDamageIsMelee = false
    udg_NextDamageIsRanged = false
end

-- Original JASS function: s__Damage_create (line 2112)
function s__Damage_create(src, tgt, amt, isAttack, at, dt, wt)
    local d = __jint(s__Damage_count + 1)
    s__Damage_count = d
    s__Damage_sourceUnit[d] = src
    s__Damage_targetUnit[d] = tgt
    s__Damage_damage[d] = amt
    s__Damage_prevAmt[d] = amt
    s__Damage_damageType[d] = dt
    s__Damage_attackType[d] = at
    s__Damage_weaponType[d] = wt
    s__Damage_isAttack[d] = (udg_NextDamageIsAttack or isAttack)
    s__Damage_isSpell[d] = ((s__Damage_attackType[d] == nil) and (not s__Damage_isAttack[d]))
    do return d end
end

-- Original JASS function: s__Damage_createFromEvent (line 2130)
function s__Damage_createFromEvent()
    local d = s__Damage_create(GetEventDamageSource(), GetTriggerUnit(), GetEventDamage(), BlzGetEventIsAttack(), BlzGetEventAttackType(), BlzGetEventDamageType(), BlzGetEventWeaponType())
    s__Damage_isCode[d] = (((((((udg_NextDamageType ~= 0) or udg_NextDamageIsAttack) or udg_NextDamageIsRanged) or udg_NextDamageIsMelee) or (s__Damage_damageType[d] == DAMAGE_TYPE_MIND)) or (udg_NextDamageWeaponT ~= 0)) or (((s__Damage_damageType[d] == DAMAGE_TYPE_UNKNOWN) and (not ((s__Damage_damage[d] == __jreal(0.00)))))))
    if s__Damage_isCode[d] then
        if (udg_NextDamageType ~= 0) then
            s__Damage_userType[d] = udg_NextDamageType
        else
            s__Damage_userType[d] = DamageEngine_TYPE_CODE
        end
        s__Damage_isMelee[d] = udg_NextDamageIsMelee
        s__Damage_isRanged[d] = udg_NextDamageIsRanged
        s__Damage_eFilter[d] = DamageEngine_FILTER_CODE
        if (udg_NextDamageWeaponT ~= 0) then
            s__Damage_weaponType[d] = ConvertWeaponType(udg_NextDamageWeaponT)
            udg_NextDamageWeaponT = 0
        end
    else
        s__Damage_userType[d] = 0
        if ((s__Damage_damageType[d] == DAMAGE_TYPE_NORMAL) and s__Damage_isAttack[d]) then
            s__Damage_isMelee[d] = IsUnitType(s__Damage_sourceUnit[d], UNIT_TYPE_MELEE_ATTACKER)
            s__Damage_isRanged[d] = IsUnitType(s__Damage_sourceUnit[d], UNIT_TYPE_RANGED_ATTACKER)
            if (s__Damage_isMelee[d] and s__Damage_isRanged[d]) then
                s__Damage_isMelee[d] = (s__Damage_weaponType[d] ~= nil)
                s__Damage_isRanged[d] = (not s__Damage_isMelee[d])
            end
            if s__Damage_isMelee[d] then
                s__Damage_eFilter[d] = DamageEngine_FILTER_MELEE
            elseif s__Damage_isRanged[d] then
                s__Damage_eFilter[d] = DamageEngine_FILTER_RANGED
            else
                s__Damage_eFilter[d] = DamageEngine_FILTER_ATTACK
            end
        else
            if s__Damage_isSpell[d] then
                s__Damage_eFilter[d] = DamageEngine_FILTER_SPELL
            else
                s__Damage_eFilter[d] = DamageEngine_FILTER_OTHER
            end
            s__Damage_isMelee[d] = false
            s__Damage_isRanged[d] = false
        end
    end
    s__Damage_clearNexts()
    do return d end
end

-- Original JASS function: s__Damage_onRecursiveDamageCallback (line 2204)
function s__Damage_onRecursiveDamageCallback()
    local d = s__Damage_createFromEvent()
    s__Damage_addRecursive(d)
    BlzSetEventDamage(__jreal(0.00))
    do return false end
end

-- Original JASS function: s__Damage_onDamagingCallback (line 2211)
function s__Damage_onDamagingCallback()
    local d = s__Damage_createFromEvent()
    if DamageEngine___timerStarted then
        if DamageEngine___waitingForDamageEventToRun then
            if (((s__Damage_damageType[d] == DAMAGE_TYPE_SPIRIT_LINK) or (s__Damage_damageType[d] == DAMAGE_TYPE_DEFENSIVE)) or (s__Damage_damageType[d] == DAMAGE_TYPE_PLANT)) then
                DamageEngine___waitingForDamageEventToRun = false
                DamageEngine___lastInstance = s__Damage_index
                DamageEngine___isNotNativeRecursiveDamage = false
            else
                s__Damage_failsafeClear()
            end
        else
            s__Damage_runAfterDamageEvents()
        end
        if (s__Damage_sourceUnit[d] ~= udg_AOEDamageSource) then
            s__Damage_onAOEEnd()
            udg_AOEDamageSource = s__Damage_sourceUnit[d]
            udg_EnhancedDamageTarget = s__Damage_targetUnit[d]
        elseif (s__Damage_targetUnit[d] == udg_EnhancedDamageTarget) then
            udg_DamageEventLevel = __jint(udg_DamageEventLevel + 1)
        elseif (not IsUnitInGroup(s__Damage_targetUnit[d], udg_DamageEventAOEGroup)) then
            udg_DamageEventAOE = __jint(udg_DamageEventAOE + 1)
        end
    else
        TimerStart(DamageEngine___async, __jreal(0.00), false, s__Damage_asyncCallback)
        DamageEngine___timerStarted = true
        udg_AOEDamageSource = s__Damage_sourceUnit[d]
        udg_EnhancedDamageTarget = s__Damage_targetUnit[d]
    end
    GroupAddUnit(udg_DamageEventAOEGroup, s__Damage_targetUnit[d])
    if s__Damage_runDamagingEvents(d, true) then
        s__DamageTrigger_DamageEngine___run(s__DamageTrigger_ZERO)
        DamageEngine___isNotNativeRecursiveDamage = true
        s__Damage_runAfterDamageEvents()
    end
    DamageEngine___waitingForDamageEventToRun = ((((DamageEngine___lastInstance == 0) or DamageEngine___attacksImmune[udg_DamageEventAttackT]) or DamageEngine___damagesImmune[udg_DamageEventDamageT]) or (not IsUnitType(udg_DamageEventTarget, UNIT_TYPE_MAGIC_IMMUNE)))
    do return false end
end

-- Original JASS function: s__Damage_onDamagedCallback (line 2271)
function s__Damage_onDamagedCallback()
    local r = GetEventDamage()
    local d = s__Damage_index
    if (s__Damage_prepped > 0) then
        s__Damage_prepped = 0
    elseif (DamageEngine___callbacksInProgress or (s__Damage_prevAmt[d] == __jreal(0.00))) then
        do return false end
    elseif DamageEngine___waitingForDamageEventToRun then
        DamageEngine___waitingForDamageEventToRun = false
    else
        s__Damage_afterDamage()
        s__Damage_index = DamageEngine___lastInstance
        DamageEngine___lastInstance = 0
        d = s__Damage_index
        DamageEngine___isNotNativeRecursiveDamage = true
        s__DamageTrigger_setGUIFromStruct(true)
    end
    s__Damage_setArmor(d, true)
    if ((not ((udg_DamageEventAmount == __jreal(0.00)))) and (not ((r == __jreal(0.00))))) then
        udg_DamageScalingWC3 = __jreal(r / udg_DamageEventAmount)
    elseif (udg_DamageEventAmount > __jreal(0.00)) then
        udg_DamageScalingWC3 = __jreal(0.00)
    else
        udg_DamageScalingWC3 = __jreal(1.00)
        if (udg_DamageEventPrevAmt == __jreal(0.00)) then
            udg_DamageScalingUser = __jreal(0.00)
        else
            udg_DamageScalingUser = __jreal(udg_DamageEventAmount / udg_DamageEventPrevAmt)
        end
    end
    udg_DamageEventAmount = r
    s__Damage_damage[d] = r
    if (udg_DamageEventAmount > __jreal(0.00)) then
        s__DamageTrigger_DamageEngine___run(s__DamageTrigger_SHIELD)
        if (DamageEngine___atLeastOneLethalDamageEventRegistered or (udg_DamageEventType < 0)) then
            udg_LethalDamageHP = __jreal(GetWidgetLife(udg_DamageEventTarget) - udg_DamageEventAmount)
            if (udg_LethalDamageHP <= DamageEngine___DEATH_VAL) then
                if DamageEngine___atLeastOneLethalDamageEventRegistered then
                    s__DamageTrigger_DamageEngine___run(s__DamageTrigger_LETHAL)
                    udg_DamageEventAmount = __jreal(GetWidgetLife(udg_DamageEventTarget) - udg_LethalDamageHP)
                    s__Damage_damage[d] = udg_DamageEventAmount
                end
                if ((udg_DamageEventType < 0) and (udg_LethalDamageHP <= DamageEngine___DEATH_VAL)) then
                    SetUnitExploded(udg_DamageEventTarget, true)
                end
            end
        end
        if ((udg_DamageEventPrevAmt == __jreal(0.00)) or (udg_DamageScalingWC3 == __jreal(0.00))) then
            udg_DamageScalingUser = __jreal(0.00)
        else
            udg_DamageScalingUser = __jreal(__jreal(udg_DamageEventAmount / udg_DamageEventPrevAmt) / udg_DamageScalingWC3)
        end
    end
    if (udg_DamageEventDamageT ~= 0) then
        s__DamageTrigger_DamageEngine___run(s__DamageTrigger_DAMAGE)
    end
    BlzSetEventDamage(udg_DamageEventAmount)
    DamageEngine___nativeEventsCompleted = true
    if (udg_DamageEventAmount == __jreal(0.00)) then
        s__Damage_runAfterDamageEvents()
    end
    do return false end
end

-- Original JASS function: s__Damage_apply (line 2377)
function s__Damage_apply(src, tgt, amt, a, r, at, dt, wt)
    local d = 0
    if (udg_NextDamageType == 0) then
        udg_NextDamageType = DamageEngine_TYPE_CODE
    end
    if DamageEngine___callbacksInProgress then
        d = s__Damage_create(src, tgt, amt, a, at, dt, wt)
        s__Damage_isCode[d] = true
        s__Damage_eFilter[d] = DamageEngine_FILTER_CODE
        s__Damage_userType[d] = udg_NextDamageType
        if (not s__Damage_isSpell[d]) then
            s__Damage_isRanged[d] = (udg_NextDamageIsRanged or r)
            s__Damage_isMelee[d] = (not s__Damage_isRanged[d])
        end
        s__Damage_addRecursive(d)
    else
        UnitDamageTarget(src, tgt, amt, a, r, at, dt, wt)
        d = s__Damage_index
        s__Damage_runAfterDamageEvents()
    end
    s__Damage_clearNexts()
    do return d end
end

-- Original JASS function: s__Damage_applySpell (line 2412)
function s__Damage_applySpell(src, tgt, amt, dt)
    do return s__Damage_apply(src, tgt, amt, false, false, nil, dt, nil) end
end

-- Original JASS function: s__Damage_applyAttack (line 2416)
function s__Damage_applyAttack(src, tgt, amt, ranged, at, wt)
    do return s__Damage_apply(src, tgt, amt, true, ranged, at, DAMAGE_TYPE_NORMAL, wt) end
end

-- Original JASS function: s__Damage_onInit (line 2421)
function s__Damage_onInit()
    DamageEngine___async = CreateTimer()
    DamageEngine___recursionSources = CreateGroup()
    DamageEngine___recursionTargets = CreateGroup()
    DamageEngine___damagingTrigger = CreateTrigger()
    DamageEngine___damagedTrigger = CreateTrigger()
    DamageEngine___recursiveTrigger = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(DamageEngine___damagingTrigger, EVENT_PLAYER_UNIT_DAMAGING)
    TriggerAddCondition(DamageEngine___damagingTrigger, Filter(s__Damage_onDamagingCallback))
    TriggerRegisterAnyUnitEventBJ(DamageEngine___damagedTrigger, EVENT_PLAYER_UNIT_DAMAGED)
    TriggerAddCondition(DamageEngine___damagedTrigger, Filter(s__Damage_onDamagedCallback))
    TriggerRegisterAnyUnitEventBJ(DamageEngine___recursiveTrigger, EVENT_PLAYER_UNIT_DAMAGING)
    TriggerAddCondition(DamageEngine___recursiveTrigger, Filter(s__Damage_onRecursiveDamageCallback))
    DisableTrigger(DamageEngine___recursiveTrigger)
    DamageEngine___attacksImmune[0] = false
    DamageEngine___attacksImmune[1] = true
    DamageEngine___attacksImmune[2] = true
    DamageEngine___attacksImmune[3] = true
    DamageEngine___attacksImmune[4] = false
    DamageEngine___attacksImmune[5] = true
    DamageEngine___attacksImmune[6] = true
    DamageEngine___damagesImmune[0] = true
    DamageEngine___damagesImmune[4] = true
    DamageEngine___damagesImmune[5] = true
    DamageEngine___damagesImmune[8] = false
    DamageEngine___damagesImmune[9] = false
    DamageEngine___damagesImmune[10] = false
    DamageEngine___damagesImmune[11] = true
    DamageEngine___damagesImmune[12] = true
    DamageEngine___damagesImmune[13] = false
    DamageEngine___damagesImmune[14] = false
    DamageEngine___damagesImmune[15] = false
    DamageEngine___damagesImmune[16] = true
    DamageEngine___damagesImmune[17] = false
    DamageEngine___damagesImmune[18] = false
    DamageEngine___damagesImmune[19] = false
    DamageEngine___damagesImmune[20] = false
    DamageEngine___damagesImmune[21] = false
    DamageEngine___damagesImmune[22] = true
    DamageEngine___damagesImmune[23] = true
    DamageEngine___damagesImmune[24] = false
    DamageEngine___damagesImmune[25] = false
    DamageEngine___damagesImmune[26] = true
end

-- Original JASS function: DamageEngine_DebugStr (line 2484)
function DamageEngine_DebugStr()
    local i = 0
    while true do
        udg_CONVERTED_ATTACK_TYPE[i] = ConvertAttackType(i)
        if (i == 6) then break end
        i = __jint(i + 1)
    end
    i = 0
    while true do
        udg_CONVERTED_DAMAGE_TYPE[i] = ConvertDamageType(i)
        if (i == 26) then break end
        i = __jint(i + 1)
    end
    udg_AttackTypeDebugStr[0] = "SPELLS"
    udg_AttackTypeDebugStr[1] = "NORMAL"
    udg_AttackTypeDebugStr[2] = "PIERCE"
    udg_AttackTypeDebugStr[3] = "SIEGE"
    udg_AttackTypeDebugStr[4] = "MAGIC"
    udg_AttackTypeDebugStr[5] = "CHAOS"
    udg_AttackTypeDebugStr[6] = "HERO"
    udg_DamageTypeDebugStr[0] = "UNKNOWN"
    udg_DamageTypeDebugStr[4] = "NORMAL"
    udg_DamageTypeDebugStr[5] = "ENHANCED"
    udg_DamageTypeDebugStr[8] = "FIRE"
    udg_DamageTypeDebugStr[9] = "COLD"
    udg_DamageTypeDebugStr[10] = "LIGHTNING"
    udg_DamageTypeDebugStr[11] = "POISON"
    udg_DamageTypeDebugStr[12] = "DISEASE"
    udg_DamageTypeDebugStr[13] = "DIVINE"
    udg_DamageTypeDebugStr[14] = "MAGIC"
    udg_DamageTypeDebugStr[15] = "SONIC"
    udg_DamageTypeDebugStr[16] = "ACID"
    udg_DamageTypeDebugStr[17] = "FORCE"
    udg_DamageTypeDebugStr[18] = "DEATH"
    udg_DamageTypeDebugStr[19] = "MIND"
    udg_DamageTypeDebugStr[20] = "PLANT"
    udg_DamageTypeDebugStr[21] = "DEFENSIVE"
    udg_DamageTypeDebugStr[22] = "DEMOLITION"
    udg_DamageTypeDebugStr[23] = "SLOW_POISON"
    udg_DamageTypeDebugStr[24] = "SPIRIT_LINK"
    udg_DamageTypeDebugStr[25] = "SHADOW_STRIKE"
    udg_DamageTypeDebugStr[26] = "UNIVERSAL"
    udg_WeaponTypeDebugStr[0] = "NONE"
    udg_WeaponTypeDebugStr[1] = "METAL_LIGHT_CHOP"
    udg_WeaponTypeDebugStr[2] = "METAL_MEDIUM_CHOP"
    udg_WeaponTypeDebugStr[3] = "METAL_HEAVY_CHOP"
    udg_WeaponTypeDebugStr[4] = "METAL_LIGHT_SLICE"
    udg_WeaponTypeDebugStr[5] = "METAL_MEDIUM_SLICE"
    udg_WeaponTypeDebugStr[6] = "METAL_HEAVY_SLICE"
    udg_WeaponTypeDebugStr[7] = "METAL_MEDIUM_BASH"
    udg_WeaponTypeDebugStr[8] = "METAL_HEAVY_BASH"
    udg_WeaponTypeDebugStr[9] = "METAL_MEDIUM_STAB"
    udg_WeaponTypeDebugStr[10] = "METAL_HEAVY_STAB"
    udg_WeaponTypeDebugStr[11] = "WOOD_LIGHT_SLICE"
    udg_WeaponTypeDebugStr[12] = "WOOD_MEDIUM_SLICE"
    udg_WeaponTypeDebugStr[13] = "WOOD_HEAVY_SLICE"
    udg_WeaponTypeDebugStr[14] = "WOOD_LIGHT_BASH"
    udg_WeaponTypeDebugStr[15] = "WOOD_MEDIUM_BASH"
    udg_WeaponTypeDebugStr[16] = "WOOD_HEAVY_BASH"
    udg_WeaponTypeDebugStr[17] = "WOOD_LIGHT_STAB"
    udg_WeaponTypeDebugStr[18] = "WOOD_MEDIUM_STAB"
    udg_WeaponTypeDebugStr[19] = "CLAW_LIGHT_SLICE"
    udg_WeaponTypeDebugStr[20] = "CLAW_MEDIUM_SLICE"
    udg_WeaponTypeDebugStr[21] = "CLAW_HEAVY_SLICE"
    udg_WeaponTypeDebugStr[22] = "AXE_MEDIUM_CHOP"
    udg_WeaponTypeDebugStr[23] = "ROCK_HEAVY_BASH"
    udg_DefenseTypeDebugStr[0] = "LIGHT"
    udg_DefenseTypeDebugStr[1] = "MEDIUM"
    udg_DefenseTypeDebugStr[2] = "HEAVY"
    udg_DefenseTypeDebugStr[3] = "FORTIFIED"
    udg_DefenseTypeDebugStr[4] = "NORMAL"
    udg_DefenseTypeDebugStr[5] = "HERO"
    udg_DefenseTypeDebugStr[6] = "DIVINE"
    udg_DefenseTypeDebugStr[7] = "UNARMORED"
    udg_ArmorTypeDebugStr[0] = "NONE"
    udg_ArmorTypeDebugStr[1] = "FLESH"
    udg_ArmorTypeDebugStr[2] = "METAL"
    udg_ArmorTypeDebugStr[3] = "WOOD"
    udg_ArmorTypeDebugStr[4] = "ETHEREAL"
    udg_ArmorTypeDebugStr[5] = "STONE"
    udg_DamageEventAOE = 1
    udg_DamageEventLevel = 1
    udg_ATTACK_TYPE_SPELLS = 0
    udg_ATTACK_TYPE_NORMAL = 1
    udg_ATTACK_TYPE_PIERCE = 2
    udg_ATTACK_TYPE_SIEGE = 3
    udg_ATTACK_TYPE_MAGIC = 4
    udg_ATTACK_TYPE_CHAOS = 5
    udg_ATTACK_TYPE_HERO = 6
    udg_DAMAGE_TYPE_UNKNOWN = 0
    udg_DAMAGE_TYPE_NORMAL = 4
    udg_DAMAGE_TYPE_ENHANCED = 5
    udg_DAMAGE_TYPE_FIRE = 8
    udg_DAMAGE_TYPE_COLD = 9
    udg_DAMAGE_TYPE_LIGHTNING = 10
    udg_DAMAGE_TYPE_POISON = 11
    udg_DAMAGE_TYPE_DISEASE = 12
    udg_DAMAGE_TYPE_DIVINE = 13
    udg_DAMAGE_TYPE_MAGIC = 14
    udg_DAMAGE_TYPE_SONIC = 15
    udg_DAMAGE_TYPE_ACID = 16
    udg_DAMAGE_TYPE_FORCE = 17
    udg_DAMAGE_TYPE_DEATH = 18
    udg_DAMAGE_TYPE_MIND = 19
    udg_DAMAGE_TYPE_PLANT = 20
    udg_DAMAGE_TYPE_DEFENSIVE = 21
    udg_DAMAGE_TYPE_DEMOLITION = 22
    udg_DAMAGE_TYPE_SLOW_POISON = 23
    udg_DAMAGE_TYPE_SPIRIT_LINK = 24
    udg_DAMAGE_TYPE_SHADOW_STRIKE = 25
    udg_DAMAGE_TYPE_UNIVERSAL = 26
    udg_WEAPON_TYPE_NONE = 0
    udg_WEAPON_TYPE_ML_CHOP = 1
    udg_WEAPON_TYPE_MM_CHOP = 2
    udg_WEAPON_TYPE_MH_CHOP = 3
    udg_WEAPON_TYPE_ML_SLICE = 4
    udg_WEAPON_TYPE_MM_SLICE = 5
    udg_WEAPON_TYPE_MH_SLICE = 6
    udg_WEAPON_TYPE_MM_BASH = 7
    udg_WEAPON_TYPE_MH_BASH = 8
    udg_WEAPON_TYPE_MM_STAB = 9
    udg_WEAPON_TYPE_MH_STAB = 10
    udg_WEAPON_TYPE_WL_SLICE = 11
    udg_WEAPON_TYPE_WM_SLICE = 12
    udg_WEAPON_TYPE_WH_SLICE = 13
    udg_WEAPON_TYPE_WL_BASH = 14
    udg_WEAPON_TYPE_WM_BASH = 15
    udg_WEAPON_TYPE_WH_BASH = 16
    udg_WEAPON_TYPE_WL_STAB = 17
    udg_WEAPON_TYPE_WM_STAB = 18
    udg_WEAPON_TYPE_CL_SLICE = 19
    udg_WEAPON_TYPE_CM_SLICE = 20
    udg_WEAPON_TYPE_CH_SLICE = 21
    udg_WEAPON_TYPE_AM_CHOP = 22
    udg_WEAPON_TYPE_RH_BASH = 23
    udg_ARMOR_TYPE_NONE = 0
    udg_ARMOR_TYPE_FLESH = 1
    udg_ARMOR_TYPE_METAL = 2
    udg_ARMOR_TYPE_WOOD = 3
    udg_ARMOR_TYPE_ETHEREAL = 4
    udg_ARMOR_TYPE_STONE = 5
    udg_DEFENSE_TYPE_LIGHT = 0
    udg_DEFENSE_TYPE_MEDIUM = 1
    udg_DEFENSE_TYPE_HEAVY = 2
    udg_DEFENSE_TYPE_FORTIFIED = 3
    udg_DEFENSE_TYPE_NORMAL = 4
    udg_DEFENSE_TYPE_HERO = 5
    udg_DEFENSE_TYPE_DIVINE = 6
    udg_DEFENSE_TYPE_UNARMORED = 7
    udg_UNIT_CLASS_HERO = 0
    udg_UNIT_CLASS_DEAD = 1
    udg_UNIT_CLASS_STRUCTURE = 2
    udg_UNIT_CLASS_FLYING = 3
    udg_UNIT_CLASS_GROUND = 4
    udg_UNIT_CLASS_ATTACKS_FLYING = 5
    udg_UNIT_CLASS_ATTACKS_GROUND = 6
    udg_UNIT_CLASS_MELEE = 7
    udg_UNIT_CLASS_RANGED = 8
    udg_UNIT_CLASS_GIANT = 9
    udg_UNIT_CLASS_SUMMONED = 10
    udg_UNIT_CLASS_STUNNED = 11
    udg_UNIT_CLASS_PLAGUED = 12
    udg_UNIT_CLASS_SNARED = 13
    udg_UNIT_CLASS_UNDEAD = 14
    udg_UNIT_CLASS_MECHANICAL = 15
    udg_UNIT_CLASS_PEON = 16
    udg_UNIT_CLASS_SAPPER = 17
    udg_UNIT_CLASS_TOWNHALL = 18
    udg_UNIT_CLASS_ANCIENT = 19
    udg_UNIT_CLASS_TAUREN = 20
    udg_UNIT_CLASS_POISONED = 21
    udg_UNIT_CLASS_POLYMORPHED = 22
    udg_UNIT_CLASS_SLEEPING = 23
    udg_UNIT_CLASS_RESISTANT = 24
    udg_UNIT_CLASS_ETHEREAL = 25
    udg_UNIT_CLASS_MAGIC_IMMUNE = 26
    udg_DamageFilterAttackT = __jint(-(1))
    udg_DamageFilterDamageT = __jint(-(1))
    udg_DamageFilterSourceC = __jint(-(1))
    udg_DamageFilterTargetC = __jint(-(1))
    udg_DamageFilterRunChance = __jreal(1.00)
end

-- Original JASS function: DamageEngine_RegisterFromHook (line 2699)
function DamageEngine_RegisterFromHook(whichTrig, var, op, value)
    s__DamageTrigger_registerVerbose(whichTrig, var, value, true, GetHandleId(op))
end

-- Original JASS function: TriggerRegisterDamageEngineEx (line 2704)
function TriggerRegisterDamageEngineEx(whichTrig, eventName, value, opId)
    do return s__DamageTrigger_registerVerbose(whichTrig, s__DamageTrigger_getVerboseStr(eventName), value, false, opId) end
end

-- Original JASS function: TriggerRegisterDamageEngine (line 2708)
function TriggerRegisterDamageEngine(whichTrig, eventName, value)
    do return s__DamageTrigger_registerTrigger(whichTrig, eventName, value) end
end

-- Original JASS function: RegisterDamageEngineEx (line 2712)
function RegisterDamageEngineEx(callback, eventName, value, opId)
    do return TriggerRegisterDamageEngineEx(s__DamageTrigger__staticgetindex(callback), eventName, value, opId) end
end

-- Original JASS function: RegisterDamageEngine (line 2717)
function RegisterDamageEngine(callback, eventName, value)
    do return RegisterDamageEngineEx(callback, eventName, value, DamageEngine_FILTER_OTHER) end
end

-- Original JASS function: sa___prototype2_DamageEngine_RegisterFromHook (line 21323)
function sa___prototype2_DamageEngine_RegisterFromHook()
    DamageEngine_RegisterFromHook(f__arg_trigger1, f__arg_string1, f__arg_limitop1, f__arg_real1)
    do return true end
end

-- Original JASS function: jasshelper__initstructs149790140 (line 21328)
function jasshelper__initstructs149790140()
    st___prototype2[1] = CreateTrigger()
    TriggerAddAction(st___prototype2[1], sa___prototype2_DamageEngine_RegisterFromHook)
    TriggerAddCondition(st___prototype2[1], Condition(sa___prototype2_DamageEngine_RegisterFromHook))
    ExecuteFunc("s__Damage_onInit")
end
-- END FOREST MODULE src/libraries/damage_engine.lua

-- BEGIN FOREST MODULE src/libraries/passive_missiles.lua
-- Original JASS function: PassiveMissiles__IsAlive (line 2730)
function PassiveMissiles__IsAlive(u)
    do return (((u ~= nil) and (GetWidgetLife(u) > __jreal(0.405))) and (not IsUnitType(u, UNIT_TYPE_DEAD))) end
end

-- Original JASS function: PassiveMissiles__IsValidTargetForCaster (line 2734)
function PassiveMissiles__IsValidTargetForCaster(caster, target)
    local owner = nil
    local ok = false
    if ((caster == nil) or (target == nil)) then
        do return false end
    end
    owner = GetOwningPlayer(caster)
    ok = ((((PassiveMissiles__IsAlive(target) and IsUnitEnemy(target, owner)) and IsUnitVisible(target, owner)) and (not BlzIsUnitInvulnerable(target))) and (not IsUnitType(target, UNIT_TYPE_MAGIC_IMMUNE)))
    owner = nil
    do return ok end
end

-- Original JASS function: PassiveMissiles__TargetFilter (line 2749)
function PassiveMissiles__TargetFilter()
    local u = GetFilterUnit()
    local ok = PassiveMissiles__IsValidTargetForCaster(PassiveMissiles__PM_Source, u)
    u = nil
    do return ok end
end

-- Original JASS function: PassiveMissiles__PickRandomTarget (line 2757)
function PassiveMissiles__PickRandomTarget(caster)
    local u = nil
    local result = nil
    local count = 0
    PassiveMissiles__PM_Source = caster
    GroupEnumUnitsInRange(PassiveMissiles__PM_EnumGroup, GetUnitX(caster), GetUnitY(caster), PassiveMissiles__PM_RANGE, Condition(PassiveMissiles__TargetFilter))
    while true do
        u = FirstOfGroup(PassiveMissiles__PM_EnumGroup)
        if (u == nil) then break end
        GroupRemoveUnit(PassiveMissiles__PM_EnumGroup, u)
        count = __jint(count + 1)
        if (GetRandomInt(1, count) == 1) then
            result = u
        end
    end
    u = nil
    do return result end
end

-- Original JASS function: PassiveMissiles__GetProjectileCount (line 2781)
function PassiveMissiles__GetProjectileCount(caster)
    local id = 0
    local owner = nil
    local level = 0
    if (caster == nil) then
        do return 0 end
    end
    id = GetHandleId(caster)
    owner = LoadUnitHandle(PassiveMissiles__PM_Hash, id, PassiveMissiles__PM_KEY_TORNADO_OWNER)
    if (owner ~= nil) then
        level = GetUnitAbilityLevel(owner, PassiveMissiles__PM_ABILITY_ID)
        if (level <= 0) then
            level = LoadInteger(PassiveMissiles__PM_Hash, id, PassiveMissiles__PM_KEY_TORNADO_BASE_LEVEL)
        end
        owner = nil
        do return level end
    end
    do return GetUnitAbilityLevel(caster, PassiveMissiles__PM_ABILITY_ID) end
end

-- Original JASS function: PassiveMissiles__GetMissileDamageSource (line 2807)
function PassiveMissiles__GetMissileDamageSource(caster)
    local owner = nil
    if (caster == nil) then
        do return nil end
    end
    owner = LoadUnitHandle(PassiveMissiles__PM_Hash, GetHandleId(caster), PassiveMissiles__PM_KEY_TORNADO_OWNER)
    if ((owner ~= nil) and PassiveMissiles__IsAlive(owner)) then
        do return owner end
    end
    do return caster end
end

-- Original JASS function: PassiveMissiles__DealMissileDamage (line 2823)
function PassiveMissiles__DealMissileDamage(source, target)
    local damage = PassiveMissiles__PM_DAMAGE
    if (source == nil) then
        do return end
    end
    if IsUnitType(target, UNIT_TYPE_STRUCTURE) then
        damage = __jreal(PassiveMissiles__PM_DAMAGE * PassiveMissiles__PM_STRUCTURE_DAMAGE_MULTIPLIER)
    end
    UnitDamageTarget(source, target, damage, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, nil)
end

-- Original JASS function: PassiveMissiles__StartMissileSound (line 2837)
function PassiveMissiles__StartMissileSound(i)
    PassiveMissiles__PM_Sound[i] = CreateSound(PassiveMissiles__PM_LOOP_SOUND_FILE, true, true, true, PassiveMissiles__PM_SOUND_FADE_IN_RATE, PassiveMissiles__PM_SOUND_FADE_OUT_RATE, "SpellsEAX")
    SetSoundVolume(PassiveMissiles__PM_Sound[i], PassiveMissiles__PM_LOOP_SOUND_VOLUME)
    SetSoundDistances(PassiveMissiles__PM_Sound[i], PassiveMissiles__PM_SOUND_MIN_DIST, PassiveMissiles__PM_SOUND_MAX_DIST)
    SetSoundDistanceCutoff(PassiveMissiles__PM_Sound[i], PassiveMissiles__PM_SOUND_MAX_DIST)
    SetSoundPosition(PassiveMissiles__PM_Sound[i], PassiveMissiles__PM_X[i], PassiveMissiles__PM_Y[i], PassiveMissiles__PM_Z[i])
    StartSound(PassiveMissiles__PM_Sound[i])
end

-- Original JASS function: PassiveMissiles__StopMissileSound (line 2847)
function PassiveMissiles__StopMissileSound(i)
    if (PassiveMissiles__PM_Sound[i] ~= nil) then
        StopSound(PassiveMissiles__PM_Sound[i], true, true)
        PassiveMissiles__PM_Sound[i] = nil
    end
end

-- Original JASS function: PassiveMissiles__PlayDeathSoundAt (line 2854)
function PassiveMissiles__PlayDeathSoundAt(x, y, z)
    local s = CreateSound(PassiveMissiles__PM_DEATH_SOUND_FILE, false, true, true, PassiveMissiles__PM_SOUND_FADE_IN_RATE, PassiveMissiles__PM_SOUND_FADE_OUT_RATE, "SpellsEAX")
    SetSoundVolume(s, PassiveMissiles__PM_DEATH_SOUND_VOLUME)
    SetSoundDistances(s, PassiveMissiles__PM_SOUND_MIN_DIST, PassiveMissiles__PM_SOUND_MAX_DIST)
    SetSoundDistanceCutoff(s, PassiveMissiles__PM_SOUND_MAX_DIST)
    SetSoundPosition(s, x, y, z)
    StartSound(s)
    KillSoundWhenDone(s)
    s = nil
end

-- Original JASS function: PassiveMissiles__RemoveMissile (line 2867)
function PassiveMissiles__RemoveMissile(i)
    PassiveMissiles__StopMissileSound(i)
    DestroyEffect(PassiveMissiles__PM_Fx[i])
    PassiveMissiles__PM_Fx[i] = PassiveMissiles__PM_Fx[PassiveMissiles__PM_Count]
    PassiveMissiles__PM_Sound[i] = PassiveMissiles__PM_Sound[PassiveMissiles__PM_Count]
    PassiveMissiles__PM_Caster[i] = PassiveMissiles__PM_Caster[PassiveMissiles__PM_Count]
    PassiveMissiles__PM_DamageSource[i] = PassiveMissiles__PM_DamageSource[PassiveMissiles__PM_Count]
    PassiveMissiles__PM_Target[i] = PassiveMissiles__PM_Target[PassiveMissiles__PM_Count]
    PassiveMissiles__PM_X[i] = PassiveMissiles__PM_X[PassiveMissiles__PM_Count]
    PassiveMissiles__PM_Y[i] = PassiveMissiles__PM_Y[PassiveMissiles__PM_Count]
    PassiveMissiles__PM_Z[i] = PassiveMissiles__PM_Z[PassiveMissiles__PM_Count]
    PassiveMissiles__PM_Fx[PassiveMissiles__PM_Count] = nil
    PassiveMissiles__PM_Sound[PassiveMissiles__PM_Count] = nil
    PassiveMissiles__PM_Caster[PassiveMissiles__PM_Count] = nil
    PassiveMissiles__PM_DamageSource[PassiveMissiles__PM_Count] = nil
    PassiveMissiles__PM_Target[PassiveMissiles__PM_Count] = nil
    PassiveMissiles__PM_Count = __jint(PassiveMissiles__PM_Count - 1)
    if (PassiveMissiles__PM_Count == 0) then
        PauseTimer(PassiveMissiles__PM_MoveTimer)
    end
end

-- Original JASS function: PassiveMissiles__MoveMissiles (line 2893)
function PassiveMissiles__MoveMissiles()
    local i = 1
    local caster = nil
    local source = nil
    local target = nil
    local tx = 0.0
    local ty = 0.0
    local tz = 0.0
    local dx = 0.0
    local dy = 0.0
    local dz = 0.0
    local dist = 0.0
    local step = 0.0
    local yaw = 0.0
    while true do
        if (i > PassiveMissiles__PM_Count) then break end
        caster = PassiveMissiles__PM_Caster[i]
        source = PassiveMissiles__PM_DamageSource[i]
        target = PassiveMissiles__PM_Target[i]
        if (((caster == nil) or (target == nil)) or (not PassiveMissiles__IsValidTargetForCaster(caster, target))) then
            PassiveMissiles__RemoveMissile(i)
        else
            tx = GetUnitX(target)
            ty = GetUnitY(target)
            tz = __jreal(BlzGetUnitZ(target) + PassiveMissiles__PM_HEIGHT)
            dx = __jreal(tx - PassiveMissiles__PM_X[i])
            dy = __jreal(ty - PassiveMissiles__PM_Y[i])
            dz = __jreal(tz - PassiveMissiles__PM_Z[i])
            dist = SquareRoot(__jreal(__jreal(dx * dx) + __jreal(dy * dy)))
            step = __jreal(PassiveMissiles__PM_SPEED * PassiveMissiles__PM_TICK)
            if (dist <= step) then
                BlzSetSpecialEffectPosition(PassiveMissiles__PM_Fx[i], tx, ty, tz)
                if (PassiveMissiles__PM_Sound[i] ~= nil) then
                    SetSoundPosition(PassiveMissiles__PM_Sound[i], tx, ty, tz)
                    PassiveMissiles__PlayDeathSoundAt(tx, ty, tz)
                end
                if ((source == nil) or (not PassiveMissiles__IsAlive(source))) then
                    source = caster
                end
                PassiveMissiles__DealMissileDamage(source, target)
                PassiveMissiles__RemoveMissile(i)
            else
                yaw = Atan2(dy, dx)
                PassiveMissiles__PM_X[i] = __jreal(PassiveMissiles__PM_X[i] + __jreal(__jreal(dx / dist) * step))
                PassiveMissiles__PM_Y[i] = __jreal(PassiveMissiles__PM_Y[i] + __jreal(__jreal(dy / dist) * step))
                PassiveMissiles__PM_Z[i] = __jreal(PassiveMissiles__PM_Z[i] + __jreal(__jreal(dz / dist) * step))
                BlzSetSpecialEffectPosition(PassiveMissiles__PM_Fx[i], PassiveMissiles__PM_X[i], PassiveMissiles__PM_Y[i], PassiveMissiles__PM_Z[i])
                BlzSetSpecialEffectYaw(PassiveMissiles__PM_Fx[i], yaw)
                if (PassiveMissiles__PM_Sound[i] ~= nil) then
                    SetSoundPosition(PassiveMissiles__PM_Sound[i], PassiveMissiles__PM_X[i], PassiveMissiles__PM_Y[i], PassiveMissiles__PM_Z[i])
                end
                i = __jint(i + 1)
            end
        end
    end
    caster = nil
    source = nil
    target = nil
end

-- Original JASS function: PassiveMissiles__LaunchMissile (line 2966)
function PassiveMissiles__LaunchMissile(caster, target, playSound)
    PassiveMissiles__PM_Count = __jint(PassiveMissiles__PM_Count + 1)
    PassiveMissiles__PM_Caster[PassiveMissiles__PM_Count] = caster
    PassiveMissiles__PM_DamageSource[PassiveMissiles__PM_Count] = PassiveMissiles__GetMissileDamageSource(caster)
    PassiveMissiles__PM_Target[PassiveMissiles__PM_Count] = target
    PassiveMissiles__PM_X[PassiveMissiles__PM_Count] = GetUnitX(caster)
    PassiveMissiles__PM_Y[PassiveMissiles__PM_Count] = GetUnitY(caster)
    PassiveMissiles__PM_Z[PassiveMissiles__PM_Count] = __jreal(BlzGetUnitZ(caster) + PassiveMissiles__PM_HEIGHT)
    PassiveMissiles__PM_Fx[PassiveMissiles__PM_Count] = AddSpecialEffect(PassiveMissiles__PM_MODEL, PassiveMissiles__PM_X[PassiveMissiles__PM_Count], PassiveMissiles__PM_Y[PassiveMissiles__PM_Count])
    BlzSetSpecialEffectScale(PassiveMissiles__PM_Fx[PassiveMissiles__PM_Count], PassiveMissiles__PM_MODEL_SCALE)
    BlzSetSpecialEffectPosition(PassiveMissiles__PM_Fx[PassiveMissiles__PM_Count], PassiveMissiles__PM_X[PassiveMissiles__PM_Count], PassiveMissiles__PM_Y[PassiveMissiles__PM_Count], PassiveMissiles__PM_Z[PassiveMissiles__PM_Count])
    PassiveMissiles__PM_Sound[PassiveMissiles__PM_Count] = nil
    if playSound then
        PassiveMissiles__StartMissileSound(PassiveMissiles__PM_Count)
    end
    if (PassiveMissiles__PM_Count == 1) then
        TimerStart(PassiveMissiles__PM_MoveTimer, PassiveMissiles__PM_TICK, true, PassiveMissiles__MoveMissiles)
    end
end

-- Original JASS function: PassiveMissiles__LaunchOneFromVolley (line 2992)
function PassiveMissiles__LaunchOneFromVolley(caster, playSound)
    local target = nil
    if (((caster ~= nil) and PassiveMissiles__IsAlive(caster)) and (PassiveMissiles__GetProjectileCount(caster) > 0)) then
        target = PassiveMissiles__PickRandomTarget(caster)
        if (target ~= nil) then
            PassiveMissiles__LaunchMissile(caster, target, playSound)
            target = nil
            do return true end
        end
    end
    target = nil
    do return false end
end

-- Original JASS function: PassiveMissiles__ContinueVolley (line 3009)
function PassiveMissiles__ContinueVolley()
    local t = GetExpiredTimer()
    local id = GetHandleId(t)
    local caster = LoadUnitHandle(PassiveMissiles__PM_Hash, id, PassiveMissiles__PM_KEY_VOLLEY_CASTER)
    local remaining = LoadInteger(PassiveMissiles__PM_Hash, id, PassiveMissiles__PM_KEY_VOLLEY_REMAINING)
    PassiveMissiles__LaunchOneFromVolley(caster, false)
    remaining = __jint(remaining - 1)
    if ((((remaining > 0) and (caster ~= nil)) and PassiveMissiles__IsAlive(caster)) and (PassiveMissiles__GetProjectileCount(caster) > 0)) then
        SaveInteger(PassiveMissiles__PM_Hash, id, PassiveMissiles__PM_KEY_VOLLEY_REMAINING, remaining)
        TimerStart(t, PassiveMissiles__PM_LAUNCH_DELAY, false, PassiveMissiles__ContinueVolley)
    else
        FlushChildHashtable(PassiveMissiles__PM_Hash, id)
        DestroyTimer(t)
    end
    caster = nil
    t = nil
end

-- Original JASS function: PassiveMissiles__StartVolley (line 3031)
function PassiveMissiles__StartVolley(caster, count)
    local t = nil
    local id = 0
    if (count <= 0) then
        do return end
    end
    if (not PassiveMissiles__LaunchOneFromVolley(caster, true)) then
        do return end
    end
    if (count > 1) then
        t = CreateTimer()
        id = GetHandleId(t)
        SaveUnitHandle(PassiveMissiles__PM_Hash, id, PassiveMissiles__PM_KEY_VOLLEY_CASTER, caster)
        SaveInteger(PassiveMissiles__PM_Hash, id, PassiveMissiles__PM_KEY_VOLLEY_REMAINING, __jint(count - 1))
        TimerStart(t, PassiveMissiles__PM_LAUNCH_DELAY, false, PassiveMissiles__ContinueVolley)
    end
    t = nil
end

-- Original JASS function: PassiveMissiles__FireForCaster (line 3056)
function PassiveMissiles__FireForCaster()
    local caster = GetEnumUnit()
    local count = PassiveMissiles__GetProjectileCount(caster)
    if ((not PassiveMissiles__IsAlive(caster)) or (count <= 0)) then
        GroupRemoveUnit(PassiveMissiles__PM_Casters, caster)
        FlushChildHashtable(PassiveMissiles__PM_Hash, GetHandleId(caster))
    else
        PassiveMissiles__StartVolley(caster, count)
    end
    caster = nil
end

-- Original JASS function: PassiveMissiles__PeriodicFire (line 3070)
function PassiveMissiles__PeriodicFire()
    ForGroup(PassiveMissiles__PM_Casters, PassiveMissiles__FireForCaster)
end

-- Original JASS function: PassiveMissiles__OnHeroSkill (line 3074)
function PassiveMissiles__OnHeroSkill()
    if (GetLearnedSkill() == PassiveMissiles__PM_ABILITY_ID) then
        GroupAddUnit(PassiveMissiles__PM_Casters, GetTriggerUnit())
    end
    do return false end
end

-- Original JASS function: PassiveMissiles__OnSummon (line 3082)
function PassiveMissiles__OnSummon()
    local summoned = GetSummonedUnit()
    local summoner = GetSummoningUnit()
    local level = 0
    if (((summoned ~= nil) and (summoner ~= nil)) and (GetUnitTypeId(summoned) == PassiveMissiles__PM_TORNADO_UNIT_ID)) then
        level = GetUnitAbilityLevel(summoner, PassiveMissiles__PM_ABILITY_ID)
        if (level > 0) then
            SaveUnitHandle(PassiveMissiles__PM_Hash, GetHandleId(summoned), PassiveMissiles__PM_KEY_TORNADO_OWNER, summoner)
            SaveInteger(PassiveMissiles__PM_Hash, GetHandleId(summoned), PassiveMissiles__PM_KEY_TORNADO_BASE_LEVEL, level)
            GroupAddUnit(PassiveMissiles__PM_Casters, summoned)
        end
    end
    summoned = nil
    summoner = nil
    do return false end
end

-- Original JASS function: PassiveMissiles__RegisterExistingUnits (line 3102)
function PassiveMissiles__RegisterExistingUnits()
    local g = CreateGroup()
    local u = nil
    GroupEnumUnitsInRect(g, bj_mapInitialPlayableArea, nil)
    while true do
        u = FirstOfGroup(g)
        if (u == nil) then break end
        GroupRemoveUnit(g, u)
        if (GetUnitAbilityLevel(u, PassiveMissiles__PM_ABILITY_ID) > 0) then
            GroupAddUnit(PassiveMissiles__PM_Casters, u)
        end
    end
    DestroyGroup(g)
    g = nil
    u = nil
end

-- Original JASS function: PassiveMissiles__Init (line 3124)
function PassiveMissiles__Init()
    local skillTrigger = CreateTrigger()
    local summonTrigger = CreateTrigger()
    local i = 0
    while true do
        if (i >= bj_MAX_PLAYER_SLOTS) then break end
        TriggerRegisterPlayerUnitEvent(skillTrigger, Player(i), EVENT_PLAYER_HERO_SKILL, nil)
        TriggerRegisterPlayerUnitEvent(summonTrigger, Player(i), EVENT_PLAYER_UNIT_SUMMON, nil)
        i = __jint(i + 1)
    end
    TriggerAddCondition(skillTrigger, Condition(PassiveMissiles__OnHeroSkill))
    TriggerAddCondition(summonTrigger, Condition(PassiveMissiles__OnSummon))
    PassiveMissiles__RegisterExistingUnits()
    TimerStart(PassiveMissiles__PM_CastTimer, PassiveMissiles__PM_PERIOD, true, PassiveMissiles__PeriodicFire)
    skillTrigger = nil
    summonTrigger = nil
end
-- END FOREST MODULE src/libraries/passive_missiles.lua

-- BEGIN FOREST MODULE src/libraries/prelude.lua
-- Original JASS function: Trig_Item_Crafting_Actions (line 3795)
function Trig_Item_Crafting_Actions()
    FE_Recipes.combineOwned(GetTriggerUnit(), FourCC('I01N'))
end

-- Original JASS function: InitTrig_Item_Crafting (line 3837)
function InitTrig_Item_Crafting()
    local t = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    TriggerAddAction(t, Trig_Item_Crafting_Actions)
end
-- END FOREST MODULE src/libraries/prelude.lua

-- BEGIN FOREST MODULE src/libraries/spell_leech.lua
-- Original JASS function: SpellLeech__ClockExpires (line 3153)
function SpellLeech__ClockExpires()
end

-- Original JASS function: SpellLeech__Now (line 3156)
function SpellLeech__Now()
    do return TimerGetElapsed(SpellLeech__SL_Clock) end
end

-- Original JASS function: SpellLeech__IsAlive (line 3160)
function SpellLeech__IsAlive(u)
    do return (((u ~= nil) and (GetWidgetLife(u) > __jreal(0.405))) and (not IsUnitType(u, UNIT_TYPE_DEAD))) end
end

-- Original JASS function: SpellLeech__GetDuration (line 3164)
function SpellLeech__GetDuration(level)
    do return __jreal(SpellLeech__SL_BASE_DURATION + __jreal(SpellLeech__SL_DURATION_PER_LEVEL * I2R(__jint(level - 1)))) end
end

-- Original JASS function: SpellLeech__ActivateLeech (line 3168)
function SpellLeech__ActivateLeech(caster, level)
    local expireTime = 0.0
    if ((caster == nil) or (level <= 0)) then
        do return end
    end
    expireTime = __jreal((TimerGetElapsed(SpellLeech__SL_Clock)) + (__jreal(SpellLeech__SL_BASE_DURATION + __jreal(SpellLeech__SL_DURATION_PER_LEVEL * I2R(__jint((level) - 1))))))
    SaveReal(SpellLeech__SL_Hash, GetHandleId(caster), 0, expireTime)
    DestroyEffect(AddSpecialEffectTarget(SpellLeech__SL_ACTIVATE_EFFECT, caster, "origin"))
end

-- Original JASS function: SpellLeech__IsLeechActive (line 3181)
function SpellLeech__IsLeechActive(caster)
    if (caster == nil) then
        do return false end
    end
    do return (LoadReal(SpellLeech__SL_Hash, GetHandleId(caster), 0) > (TimerGetElapsed(SpellLeech__SL_Clock))) end
end

-- Original JASS function: SpellLeech__IsValidLeechDamage (line 3189)
function SpellLeech__IsValidLeechDamage(source, target, damage)
    if (damage <= __jreal(0.00)) then
        do return false end
    end
    if (not SpellLeech__IsAlive(source)) then
        do return false end
    end
    if (target == nil) then
        do return false end
    end
    if (not SpellLeech__IsLeechActive(source)) then
        do return false end
    end
    if (SpellLeech__SL_ENEMY_ONLY and (not IsUnitEnemy(target, GetOwningPlayer(source)))) then
        do return false end
    end
    if (SpellLeech__SL_REQUIRE_NON_ATTACK and BlzGetEventIsAttack()) then
        do return false end
    end
    if (SpellLeech__SL_REQUIRE_DAMAGE_TYPE_MAGIC and (BlzGetEventDamageType() ~= DAMAGE_TYPE_MAGIC)) then
        do return false end
    end
    do return true end
end

-- Original JASS function: SpellLeech__HealUnit (line 3221)
function SpellLeech__HealUnit(u, amount)
    local life = 0.0
    local maxLife = 0.0
    if ((not SpellLeech__IsAlive(u)) or (amount <= __jreal(0.00))) then
        do return end
    end
    life = GetWidgetLife(u)
    maxLife = GetUnitState(u, UNIT_STATE_MAX_LIFE)
    if (__jreal(life + amount) > maxLife) then
        SetWidgetLife(u, maxLife)
    else
        SetWidgetLife(u, __jreal(life + amount))
    end
    if SpellLeech__SL_SHOW_HEAL_EFFECT then
        DestroyEffect(AddSpecialEffectTarget(SpellLeech__SL_HEAL_EFFECT, u, "origin"))
    end
end

-- Original JASS function: SpellLeech__OnSpellEffect (line 3243)
function SpellLeech__OnSpellEffect()
    local caster = nil
    local level = 0
    if (GetSpellAbilityId() == SpellLeech__SL_ABILITY_ID) then
        caster = GetTriggerUnit()
        level = GetUnitAbilityLevel(caster, SpellLeech__SL_ABILITY_ID)
        SpellLeech__ActivateLeech(caster, level)
        caster = nil
    end
end

-- Original JASS function: SpellLeech__OnDamage (line 3257)
function SpellLeech__OnDamage()
    local target = GetTriggerUnit()
    local source = GetEventDamageSource()
    local damage = GetEventDamage()
    local healAmount = 0.0
    if SpellLeech__IsValidLeechDamage(source, target, damage) then
        healAmount = __jreal(damage * SpellLeech__SL_LEECH_FACTOR)
        SpellLeech__HealUnit(source, healAmount)
    end
    target = nil
    source = nil
end

-- Original JASS function: SpellLeech__Init (line 3272)
function SpellLeech__Init()
    local spellTrigger = CreateTrigger()
    local damageTrigger = CreateTrigger()
    local i = 0
    TimerStart(SpellLeech__SL_Clock, __jreal(999999.00), false, SpellLeech__ClockExpires)
    while true do
        if (i >= bj_MAX_PLAYER_SLOTS) then break end
        TriggerRegisterPlayerUnitEvent(spellTrigger, Player(i), EVENT_PLAYER_UNIT_SPELL_EFFECT, nil)
        TriggerRegisterPlayerUnitEvent(damageTrigger, Player(i), EVENT_PLAYER_UNIT_DAMAGED, nil)
        i = __jint(i + 1)
    end
    TriggerAddAction(spellTrigger, SpellLeech__OnSpellEffect)
    TriggerAddAction(damageTrigger, SpellLeech__OnDamage)
    spellTrigger = nil
    damageTrigger = nil
end
-- END FOREST MODULE src/libraries/spell_leech.lua

-- BEGIN FOREST MODULE src/commands/test_data.lua
-- Generated by tools/test_data.py; edit object data/project.json, not this file.
FE_TestData = {units={}, items={}, catalog={}, pickers={}, releaseLabel="3.2.0 r7"}
FE_TestData.units["E000"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="E000", name="Centaur Warcaller"}
FE_TestData.units["E00T"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="E00T", name="E00T"}
FE_TestData.units["Edmm"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="Edmm", name="Edmm"}
FE_TestData.units["H01M"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="H01M", name="Magma Lord"}
FE_TestData.units["H01P"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="H01P", name="Ancient of Destruction"}
FE_TestData.units["H01R"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="H01R", name="Abomination"}
FE_TestData.units["H01V"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="H01V", name="Steam Wagon"}
FE_TestData.units["H03P"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="H03P", name="Haunted Ship"}
FE_TestData.units["H064"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="H064", name="Amalgamation"}
FE_TestData.units["O004"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="O004", name="Ancient of Fire"}
FE_TestData.units["O008"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="O008", name="Ancient of Ice"}
FE_TestData.units["O00A"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="O00A", name="Ancient of Darkness"}
FE_TestData.units["O00D"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="O00D", name="Ancient of Nature"}
FE_TestData.units["O00L"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="O00L", name="Ancient of Earth"}
FE_TestData.units["O00S"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="O00S", name="Ancient of Dragons"}
FE_TestData.units["O00W"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="O00W", name="Mecha-Wrecker"}
FE_TestData.units["O00Z"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="O00Z", name="Ogre Overlord"}
FE_TestData.units["O016"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="O016", name="Ancient of Lightning"}
FE_TestData.units["O01D"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="O01D", name="Ancient of Wind"}
FE_TestData.units["O01V"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="O01V", name="Ancient of Light"}
FE_TestData.units["O01X"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="O01X", name="Ancient of Sand"}
FE_TestData.units["O01Z"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="O01Z", name="Ancient of Space and Time"}
FE_TestData.units["O024"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="O024", name="Arcane Golem"}
FE_TestData.units["O029"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="O029", name="Ancient of Forest"}
FE_TestData.units["e001"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="e001", name="Tree of Life"}
FE_TestData.units["e002"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="e002", name="Dragon's Lackey"}
FE_TestData.units["e003"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="e003", name="Warpling"}
FE_TestData.units["e004"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="e004", name="Avenger"}
FE_TestData.units["e005"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="e005", name="Vampiric Wyrm"}
FE_TestData.units["e006"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="e006", name="Chaos Bringer"}
FE_TestData.units["e007"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="e007", name="Dragon Whelp"}
FE_TestData.units["e008"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="e008", name="Mud Golem"}
FE_TestData.units["e009"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="e009", name="Earth's Lackey"}
FE_TestData.units["e00A"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="e00A", name="Ignite's Lackey"}
FE_TestData.units["e00B"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="e00B", name="Ignite's Minion"}
FE_TestData.units["e00C"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="e00C", name="Darkness's Lackey"}
FE_TestData.units["e00D"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="e00D", name="Darkness Spawn"}
FE_TestData.units["e00E"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="e00E", name="Dark Templar"}
FE_TestData.units["e00F"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="e00F", name="Divine Golem"}
FE_TestData.units["e00G"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="e00G", name="Light Revenant"}
FE_TestData.units["e00H"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="e00H", name="Pharaoh's Servant"}
FE_TestData.units["e00I"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="e00I", name="Dune Worm"}
FE_TestData.units["e00J"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="e00J", name="Lightning Revenant"}
FE_TestData.units["e00K"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="e00K", name="Lightning Elemental"}
FE_TestData.units["e00L"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="e00L", name="Earth Rootling"}
FE_TestData.units["e00M"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="e00M", name="Nature's Spawn"}
FE_TestData.units["e00N"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="e00N", name="Ice's Lackey"}
FE_TestData.units["e00O"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="e00O", name="Nature's Lackey"}
FE_TestData.units["e00P"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="e00P", name="Ice Elemental"}
FE_TestData.units["e00Q"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="e00Q", name="Soul"}
FE_TestData.units["e00R"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="e00R", name="e00R"}
FE_TestData.units["e00S"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="e00S", name="Storm Spirit"}
FE_TestData.units["e00U"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="e00U", name="e00U"}
FE_TestData.units["e00V"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="e00V", name="e00V"}
FE_TestData.units["emtg"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="emtg", name="Dummy"}
FE_TestData.units["ewsp"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="ewsp", name="Selector"}
FE_TestData.units["h000"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h000", name="Kraken"}
FE_TestData.units["h001"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h001", name="Tent"}
FE_TestData.units["h002"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h002", name="Human Worker"}
FE_TestData.units["h003"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h003", name="Camp"}
FE_TestData.units["h004"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h004", name="Blacksmith"}
FE_TestData.units["h005"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h005", name="Arrow Tower"}
FE_TestData.units["h006"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h006", name="Cannon Tower"}
FE_TestData.units["h007"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h007", name="Missile Tower"}
FE_TestData.units["h008"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h008", name="Wall"}
FE_TestData.units["h009"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h009", name="Upgraded Wall"}
FE_TestData.units["h00A"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h00A", name="Shed"}
FE_TestData.units["h00B"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h00B", name="Flaming Wall"}
FE_TestData.units["h00C"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h00C", name="Grave"}
FE_TestData.units["h00D"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h00D", name="Ghoul Worker"}
FE_TestData.units["h00E"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h00E", name="Boney Wall"}
FE_TestData.units["h00F"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h00F", name="Ogre"}
FE_TestData.units["h00G"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h00G", name="Ogre Worker"}
FE_TestData.units["h00H"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h00H", name="Exoskeleton Wall"}
FE_TestData.units["h00I"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h00I", name="Meat Tosser"}
FE_TestData.units["h00J"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h00J", name="Tent"}
FE_TestData.units["h00K"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h00K", name="Technology Center"}
FE_TestData.units["h00L"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h00L", name="Rocky Wall"}
FE_TestData.units["h00M"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h00M", name="Earth Wall"}
FE_TestData.units["h00N"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h00N", name="Sand Tower"}
FE_TestData.units["h00O"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h00O", name="Rocky Tower"}
FE_TestData.units["h00P"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h00P", name="Boulder Tower"}
FE_TestData.units["h00Q"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h00Q", name="Gold"}
FE_TestData.units["h00R"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h00R", name="Worgen"}
FE_TestData.units["h00S"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h00S", name="Tunnel"}
FE_TestData.units["h00T"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h00T", name="Jippy"}
FE_TestData.units["h00U"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h00U", name="Barricade"}
FE_TestData.units["h00V"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h00V", name="Strong Barricade"}
FE_TestData.units["h00W"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h00W", name="Tree Spirit"}
FE_TestData.units["h00X"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h00X", name="Water Sprite"}
FE_TestData.units["h00Y"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h00Y", name="Light House"}
FE_TestData.units["h00Z"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h00Z", name="Squid Harvester"}
FE_TestData.units["h010"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h010", name="Wildkin"}
FE_TestData.units["h011"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h011", name="Waterfall of Defense"}
FE_TestData.units["h012"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h012", name="Light House"}
FE_TestData.units["h013"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h013", name="Light House"}
FE_TestData.units["h014"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h014", name="Light House"}
FE_TestData.units["h015"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h015", name="Light House"}
FE_TestData.units["h016"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h016", name="Goblin"}
FE_TestData.units["h017"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h017", name="Growth"}
FE_TestData.units["h018"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h018", name="Seedling"}
FE_TestData.units["h019"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h019", name="Roots"}
FE_TestData.units["h01A"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h01A", name="Spirit Tree: Defense"}
FE_TestData.units["h01B"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h01B", name="Nature Wall"}
FE_TestData.units["h01C"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h01C", name="Improved Nature Wall"}
FE_TestData.units["h01D"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h01D", name="Spirit Tree: Offense"}
FE_TestData.units["h01E"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h01E", name="Nature Tower"}
FE_TestData.units["h01F"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h01F", name="Improved Nature Tower"}
FE_TestData.units["h01G"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h01G", name="Corrupted Nature Tower"}
FE_TestData.units["h01H"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h01H", name="Laser Tower"}
FE_TestData.units["h01I"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h01I", name="Gate"}
FE_TestData.units["h01J"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h01J", name="Flak Cannon"}
FE_TestData.units["h01K"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h01K", name="Nerubian"}
FE_TestData.units["h01L"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h01L", name="Magma Rock"}
FE_TestData.units["h01N"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h01N", name="Spirit Tree: Speed"}
FE_TestData.units["h01O"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h01O", name="Speed Tower"}
FE_TestData.units["h01Q"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h01Q", name="Meat Wagon"}
FE_TestData.units["h01S"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h01S", name="Skeletal Warrior"}
FE_TestData.units["h01T"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h01T", name="Skeletal Archer"}
FE_TestData.units["h01U"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h01U", name="Factory"}
FE_TestData.units["h01W"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h01W", name="Mortar Team"}
FE_TestData.units["h01X"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h01X", name="Centaur"}
FE_TestData.units["h01Y"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h01Y", name="Tent"}
FE_TestData.units["h01Z"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h01Z", name="Centaur Wood Harvester"}
FE_TestData.units["h020"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h020", name="Centaur Wall"}
FE_TestData.units["h021"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h021", name="Defense Center"}
FE_TestData.units["h022"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h022", name="Upgraded Centaur Wall"}
FE_TestData.units["h023"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h023", name="Centaur Guard Tower"}
FE_TestData.units["h024"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h024", name="Centaur Watch Tower"}
FE_TestData.units["h025"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h025", name="Kobold Library"}
FE_TestData.units["h026"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h026", name="Kobold Warrior"}
FE_TestData.units["h027"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h027", name="Centaur War Tower"}
FE_TestData.units["h028"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h028", name="Centaur Magical Tower"}
FE_TestData.units["h029"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h029", name="Centaur Speed Tower"}
FE_TestData.units["h02A"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h02A", name="Mega Tower"}
FE_TestData.units["h02B"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h02B", name="Recipe Shop"}
FE_TestData.units["h02C"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h02C", name="Ancient of Corruption"}
FE_TestData.units["h02D"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h02D", name="Growth of Destruction"}
FE_TestData.units["h02E"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h02E", name="Ancient Wall"}
FE_TestData.units["h02F"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h02F", name="Military Camp"}
FE_TestData.units["h02G"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h02G", name="Centaur Barracks"}
FE_TestData.units["h02H"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h02H", name="Centaur Military HQ"}
FE_TestData.units["h02I"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h02I", name="Centaur Hide-out"}
FE_TestData.units["h02J"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h02J", name="Furbolg Base"}
FE_TestData.units["h02K"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h02K", name="Centaur Ultimate Tower"}
FE_TestData.units["h02L"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h02L", name="Wisp"}
FE_TestData.units["h02M"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h02M", name="Workshop"}
FE_TestData.units["h02N"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h02N", name="Scrap pile"}
FE_TestData.units["h02O"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h02O", name="Metalic Pile"}
FE_TestData.units["h02P"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h02P", name="Goblin Factory"}
FE_TestData.units["h02Q"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h02Q", name="Teleporter"}
FE_TestData.units["h02R"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h02R", name="Molten Wall"}
FE_TestData.units["h02S"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h02S", name="Centaur Destruction Tower"}
FE_TestData.units["h02T"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h02T", name="Centaur Haste Tower"}
FE_TestData.units["h02U"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h02U", name="Furbolg"}
FE_TestData.units["h02V"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h02V", name="Centaur Sorcerer Tower"}
FE_TestData.units["h02W"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h02W", name="Tent"}
FE_TestData.units["h02X"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h02X", name="Research Center"}
FE_TestData.units["h02Y"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h02Y", name="Furbolg Shaman"}
FE_TestData.units["h02Z"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h02Z", name="Furbolg Warrior"}
FE_TestData.units["h030"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h030", name="Warrior Encampent"}
FE_TestData.units["h031"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h031", name="Shaman Encampent"}
FE_TestData.units["h032"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h032", name="Centaur Base"}
FE_TestData.units["h033"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h033", name="Wall"}
FE_TestData.units["h034"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h034", name="Upgraded Wall"}
FE_TestData.units["h035"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h035", name="Outpost"}
FE_TestData.units["h036"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h036", name="Improved Nerubian Wall"}
FE_TestData.units["h037"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h037", name="Nerubian Wall"}
FE_TestData.units["h038"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h038", name="Plague House"}
FE_TestData.units["h039"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h039", name="Crypt Lord's Cove"}
FE_TestData.units["h03A"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h03A", name="Crypt Lord"}
FE_TestData.units["h03B"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h03B", name="Altar of Cryptlord"}
FE_TestData.units["h03C"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h03C", name="Nerubian Merchant"}
FE_TestData.units["h03D"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h03D", name="Human"}
FE_TestData.units["h03E"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h03E", name="Cove"}
FE_TestData.units["h03F"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h03F", name="Enhanced Sea Barrier Reef"}
FE_TestData.units["h03G"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h03G", name="Sea Barrier"}
FE_TestData.units["h03H"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h03H", name="Sea Barrier Reef"}
FE_TestData.units["h03I"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h03I", name="Temple of Tides"}
FE_TestData.units["h03J"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h03J", name="Guarded Tidal Tower"}
FE_TestData.units["h03K"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h03K", name="Guarded Tidal Tower of Destruction"}
FE_TestData.units["h03L"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h03L", name="Tidal Tower"}
FE_TestData.units["h03M"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h03M", name="Enhanced Tidal Tower"}
FE_TestData.units["h03N"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h03N", name="Depth's Shop"}
FE_TestData.units["h03O"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h03O", name="Davy Jones' Locker"}
FE_TestData.units["h03Q"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h03Q", name="Kobold"}
FE_TestData.units["h03R"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h03R", name="Suspicious Bush"}
FE_TestData.units["h03S"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h03S", name="Aethyr Warp"}
FE_TestData.units["h03T"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h03T", name="Nether Portal"}
FE_TestData.units["h03U"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h03U", name="Nether Obelisk"}
FE_TestData.units["h03V"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h03V", name="Ethereal Sustainer"}
FE_TestData.units["h03W"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h03W", name="Nether Rip"}
FE_TestData.units["h03X"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h03X", name="Black Hole"}
FE_TestData.units["h03Y"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h03Y", name="Supernova"}
FE_TestData.units["h03Z"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h03Z", name="Solar Flare"}
FE_TestData.units["h040"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h040", name="Nether Tower"}
FE_TestData.units["h041"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h041", name="Ethereal Tower"}
FE_TestData.units["h042"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h042", name="Solar Tower"}
FE_TestData.units["h043"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h043", name="Ancient Protector"}
FE_TestData.units["h044"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h044", name="Razor Den"}
FE_TestData.units["h045"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h045", name="Gamma Ray"}
FE_TestData.units["h046"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h046", name="Stalker"}
FE_TestData.units["h047"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h047", name="Dark Figure"}
FE_TestData.units["h048"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h048", name="Primordial Ooze"}
FE_TestData.units["h049"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h049", name="Blood Pool"}
FE_TestData.units["h04A"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h04A", name="Soul Beacon"}
FE_TestData.units["h04B"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h04B", name="Executioner's Domain"}
FE_TestData.units["h04C"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h04C", name="Mass Grave"}
FE_TestData.units["h04D"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h04D", name="Pit of Endless Ravening"}
FE_TestData.units["h04E"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h04E", name="Greater Blood Pool"}
FE_TestData.units["h04F"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h04F", name="Nightmare"}
FE_TestData.units["h04G"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h04G", name="Greater Nightmare"}
FE_TestData.units["h04H"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h04H", name="Fountain of Corruption"}
FE_TestData.units["h04I"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h04I", name="Wildkin's Den"}
FE_TestData.units["h04J"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h04J", name="Wildkin Worker"}
FE_TestData.units["h04K"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h04K", name="Totem"}
FE_TestData.units["h04L"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h04L", name="Avatar Dummy"}
FE_TestData.units["h04M"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h04M", name="Wildkin Hive"}
FE_TestData.units["h04N"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h04N", name="Blockade"}
FE_TestData.units["h04O"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h04O", name="Spirit Shrine"}
FE_TestData.units["h04P"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h04P", name="Improved Blockade"}
FE_TestData.units["h04Q"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h04Q", name="Great Temple"}
FE_TestData.units["h04R"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h04R", name="Test Dummy"}
FE_TestData.units["h04S"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h04S", name="War Center"}
FE_TestData.units["h04T"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h04T", name="Enraged Ent"}
FE_TestData.units["h04U"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h04U", name="Wildkin Shaman"}
FE_TestData.units["h04V"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h04V", name="Base Flag"}
FE_TestData.units["h04W"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h04W", name="Base Flag"}
FE_TestData.units["h04X"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h04X", name="Base Flag"}
FE_TestData.units["h04Y"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h04Y", name="Base Flag"}
FE_TestData.units["h04Z"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h04Z", name="Base Flag"}
FE_TestData.units["h050"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h050", name="Base Flag"}
FE_TestData.units["h051"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h051", name="Base Flag"}
FE_TestData.units["h052"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h052", name="Base Flag"}
FE_TestData.units["h053"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h053", name="Azjol'Nerub"}
FE_TestData.units["h054"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h054", name="Black Hole"}
FE_TestData.units["h055"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h055", name="Altar of Spider Queen"}
FE_TestData.units["h056"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h056", name="Nerubian Harvester"}
FE_TestData.units["h057"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h057", name="Attacker Dummy"}
FE_TestData.units["h058"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h058", name="Nerubian Ziggurat"}
FE_TestData.units["h059"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h059", name="Nerubian Spire"}
FE_TestData.units["h05A"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h05A", name="Nerubian Tower"}
FE_TestData.units["h05B"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h05B", name="Stash"}
FE_TestData.units["h05C"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h05C", name="Night Elf"}
FE_TestData.units["h05D"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h05D", name="Archdruid"}
FE_TestData.units["h05E"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h05E", name="Shadow Dancer"}
FE_TestData.units["h05F"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h05F", name="Spirit Totem"}
FE_TestData.units["h05G"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h05G", name="Elven Basement"}
FE_TestData.units["h05H"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h05H", name="Elven Merchant"}
FE_TestData.units["h05I"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h05I", name="Altar"}
FE_TestData.units["h05J"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h05J", name="Arcane Library"}
FE_TestData.units["h05K"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h05K", name="Arcane Academy"}
FE_TestData.units["h05L"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h05L", name="Cenarius Grove"}
FE_TestData.units["h05M"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h05M", name="Druids Den"}
FE_TestData.units["h05N"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h05N", name="Base Flag"}
FE_TestData.units["h05O"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h05O", name="Empowered Spirit Totem"}
FE_TestData.units["h05P"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h05P", name="Base Flag"}
FE_TestData.units["h05Q"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h05Q", name="Ceramic Wall"}
FE_TestData.units["h05R"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h05R", name="Improved Ceramic Wall"}
FE_TestData.units["h05S"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h05S", name="Sewers"}
FE_TestData.units["h05T"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h05T", name="Engineer's Worker"}
FE_TestData.units["h05U"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h05U", name="Cheese Wall"}
FE_TestData.units["h05V"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h05V", name="Even Cheesier Wall"}
FE_TestData.units["h05W"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h05W", name="Bounty Hunter"}
FE_TestData.units["h05X"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h05X", name="Tent"}
FE_TestData.units["h05Y"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h05Y", name="Silvester"}
FE_TestData.units["h05Z"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h05Z", name="Training Range"}
FE_TestData.units["h060"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h060", name="Old Workshop"}
FE_TestData.units["h061"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h061", name="Barricade"}
FE_TestData.units["h062"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h062", name="Fortified Barricade"}
FE_TestData.units["h063"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h063", name="Cultist"}
FE_TestData.units["h065"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h065", name="Outpost"}
FE_TestData.units["h066"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h066", name="Skull Pile"}
FE_TestData.units["h067"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h067", name="Greater Skull Pile"}
FE_TestData.units["h068"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h068", name="Towering Skull Pile"}
FE_TestData.units["h069"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h069", name="Tower of Death"}
FE_TestData.units["h06A"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h06A", name="Shrine"}
FE_TestData.units["h06B"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h06B", name="Follower"}
FE_TestData.units["h06C"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h06C", name="Combat Hunter"}
FE_TestData.units["h06D"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h06D", name="Altar of the Thing"}
FE_TestData.units["h06E"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h06E", name="Partial Shinigami Manifestation"}
FE_TestData.units["h06F"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h06F", name="Wind Burst Dummy"}
FE_TestData.units["h06G"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h06G", name="Freeze Zone Dummy"}
FE_TestData.units["h06H"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h06H", name="Elite Bounty Hunter"}
FE_TestData.units["h06I"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="h06I", name="Worgen Lumber Counter"}
FE_TestData.units["hfoo"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="hfoo", name="hfoo"}
FE_TestData.units["n000"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="n000", name="Awards II"}
FE_TestData.units["n001"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="n001", name="blocker"}
FE_TestData.units["n002"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="n002", name="Coral Research Center"}
FE_TestData.units["n003"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="n003", name="Goblin Worker Mech"}
FE_TestData.units["n004"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="n004", name="Goblin Battle Mech Beta"}
FE_TestData.units["n005"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="n005", name="Goblin Battle Mech Alpha"}
FE_TestData.units["n006"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="n006", name="Goblin Engineer"}
FE_TestData.units["n007"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="n007", name="Ogre-Rider"}
FE_TestData.units["n008"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="n008", name="Goblin Battle Mech Ultima"}
FE_TestData.units["n009"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="n009", name="Transport Zeppelin"}
FE_TestData.units["n00A"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="n00A", name="Awards"}
FE_TestData.units["n00B"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="n00B", name="Spellbringer"}
FE_TestData.units["n00C"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="n00C", name="Furbolg Worker"}
FE_TestData.units["n00D"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="n00D", name="Nikkone"}
FE_TestData.units["n00E"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="n00E", name="Druides"}
FE_TestData.units["n00F"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="n00F", name="Meerkatking"}
FE_TestData.units["n00G"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="n00G", name="Intermediate Races"}
FE_TestData.units["n00H"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="n00H", name="Razorvine"}
FE_TestData.units["n00I"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="n00I", name="Moosetackler"}
FE_TestData.units["n00J"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="n00J", name="Young Razorvine"}
FE_TestData.units["n00K"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="n00K", name="Thriving Razorvine"}
FE_TestData.units["n00L"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="n00L", name="Raging Growth"}
FE_TestData.units["n00M"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="n00M", name="Elf Engineer"}
FE_TestData.units["n00N"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="n00N", name="Research Center"}
FE_TestData.units["n00O"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="n00O", name="Power Generator"}
FE_TestData.units["n00P"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="n00P", name="Altar of Technologies"}
FE_TestData.units["n00Q"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="n00Q", name="Elven Lumbermill"}
FE_TestData.units["n00R"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="n00R", name="Engineer's Shop"}
FE_TestData.units["n00S"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="n00S", name="Observatory"}
FE_TestData.units["n00T"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="n00T", name="Flame Tower"}
FE_TestData.units["n00U"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="n00U", name="Frost Tower"}
FE_TestData.units["n00V"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="n00V", name="Lightning Tower"}
FE_TestData.units["n00W"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="n00W", name="Guard Tower"}
FE_TestData.units["n00X"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="n00X", name="n00X"}
FE_TestData.units["n00Y"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="n00Y", name="Repair Bot"}
FE_TestData.units["n00Z"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="n00Z", name="Rat"}
FE_TestData.units["n010"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="n010", name="Sticky Glue"}
FE_TestData.units["n011"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="n011", name="Tree Chopper"}
FE_TestData.units["n012"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="n012", name="Testing Station"}
FE_TestData.units["n013"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="n013", name="Flag Aura Dummy"}
FE_TestData.units["n014"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="n014", name="Eagle"}
FE_TestData.units["n015"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="n015", name="Elite Eagle"}
FE_TestData.units["nbnb"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="nbnb", name="Burrowed Nerubian Harvester"}
FE_TestData.units["nfoh"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="nfoh", name="nfoh"}
FE_TestData.units["ngbl"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="ngbl", name="ngbl"}
FE_TestData.units["nmer"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="nmer", name="Beginner Races"}
FE_TestData.units["nmoo"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="nmoo", name="nmoo"}
FE_TestData.units["nmr2"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="nmr2", name="Ancient Selection"}
FE_TestData.units["nmr3"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="nmr3", name="nmr3"}
FE_TestData.units["npgr"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="npgr", name="npgr"}
FE_TestData.units["ntor"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="ntor", name="Hurricane"}
FE_TestData.units["nwad"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="nwad", name="Watchful Eye"}
FE_TestData.units["o000"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o000", name="Magmide"}
FE_TestData.units["o001"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o001", name="Volcano"}
FE_TestData.units["o002"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o002", name="Fire Sprite"}
FE_TestData.units["o003"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o003", name="Flame Elemental"}
FE_TestData.units["o005"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o005", name="Ghoul"}
FE_TestData.units["o006"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o006", name="Mind Controller"}
FE_TestData.units["o007"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o007", name="Graveyard"}
FE_TestData.units["o009"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o009", name="Fire Pit"}
FE_TestData.units["o00B"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o00B", name="Dome"}
FE_TestData.units["o00C"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o00C", name="Advanced Tunnel"}
FE_TestData.units["o00E"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o00E", name="Labratory"}
FE_TestData.units["o00F"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o00F", name="Shaman Hub"}
FE_TestData.units["o00G"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o00G", name="o00G"}
FE_TestData.units["o00H"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o00H", name="o00H"}
FE_TestData.units["o00I"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o00I", name="o00I"}
FE_TestData.units["o00J"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o00J", name="Growth Ward"}
FE_TestData.units["o00K"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o00K", name="You may only train one hero"}
FE_TestData.units["o00M"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o00M", name="Centaur Burrow"}
FE_TestData.units["o00N"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o00N", name="Lava Shop"}
FE_TestData.units["o00O"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o00O", name="Lava Warrior"}
FE_TestData.units["o00P"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o00P", name="Hardened Root"}
FE_TestData.units["o00Q"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o00Q", name="Raging Thorn"}
FE_TestData.units["o00R"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o00R", name="Spark"}
FE_TestData.units["o00T"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o00T", name="Zeppelin Tower"}
FE_TestData.units["o00U"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o00U", name="Merchant"}
FE_TestData.units["o00V"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o00V", name="Laboratory"}
FE_TestData.units["o00X"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o00X", name="Goblin Observer"}
FE_TestData.units["o00Y"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o00Y", name="War Base"}
FE_TestData.units["o010"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o010", name="Ogre Head Smasher"}
FE_TestData.units["o011"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o011", name="Molten Core"}
FE_TestData.units["o012"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o012", name="Totem of Life"}
FE_TestData.units["o013"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o013", name="Totem of Destruction"}
FE_TestData.units["o014"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o014", name="Frost Tower"}
FE_TestData.units["o015"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o015", name="Seaweed Plant"}
FE_TestData.units["o017"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o017", name="Gilnean House"}
FE_TestData.units["o018"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o018", name="Gilnean Castle"}
FE_TestData.units["o019"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o019", name="Gilnean Shop"}
FE_TestData.units["o01A"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o01A", name="Gilnean Wall"}
FE_TestData.units["o01B"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o01B", name="Upgraded Gilnean Wall"}
FE_TestData.units["o01C"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o01C", name="Soft Razorvine"}
FE_TestData.units["o01E"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o01E", name="Razormane"}
FE_TestData.units["o01F"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o01F", name="Camp"}
FE_TestData.units["o01G"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o01G", name="Large Razorvine"}
FE_TestData.units["o01H"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o01H", name="Thick Razorvine"}
FE_TestData.units["o01I"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o01I", name="Strong Razorvine"}
FE_TestData.units["o01J"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o01J", name="Razormane Brute"}
FE_TestData.units["o01K"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o01K", name="Scout"}
FE_TestData.units["o01L"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o01L", name="Deathly Necromancer"}
FE_TestData.units["o01M"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o01M", name="Deathly Necromancer II"}
FE_TestData.units["o01N"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o01N", name="Deathly Necromancer III"}
FE_TestData.units["o01O"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o01O", name="Dark Tower II"}
FE_TestData.units["o01P"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o01P", name="Dark Tower III"}
FE_TestData.units["o01Q"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o01Q", name="Dark Tower I"}
FE_TestData.units["o01R"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o01R", name="Dark Tower V"}
FE_TestData.units["o01S"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o01S", name="Dark Tower IV"}
FE_TestData.units["o01T"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o01T", name="Shadowling"}
FE_TestData.units["o01U"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o01U", name="Forgotten Vault"}
FE_TestData.units["o01W"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o01W", name="Raging Ward"}
FE_TestData.units["o01Y"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o01Y", name="Quicksand Trap"}
FE_TestData.units["o020"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o020", name="Sun"}
FE_TestData.units["o021"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o021", name="Sun"}
FE_TestData.units["o022"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o022", name="Sun"}
FE_TestData.units["o023"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o023", name="Arcane Mage"}
FE_TestData.units["o025"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o025", name="Shady Vendor"}
FE_TestData.units["o026"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o026", name="Ratling Stalker"}
FE_TestData.units["o027"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o027", name="Cheesy Laboratory"}
FE_TestData.units["o028"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o028", name="Manor"}
FE_TestData.units["o02A"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o02A", name="Dmg Test Dummy"}
FE_TestData.units["o02B"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o02B", name="Stasis Trap (Bounty Hunter)"}
FE_TestData.units["o02C"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o02C", name="Tavern"}
FE_TestData.units["o02D"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o02D", name="Corpse"}
FE_TestData.units["o02E"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="o02E", name="Workshop"}
FE_TestData.units["otot"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="otot", name="otot"}
FE_TestData.units["u000"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="u000", name="Centaur Militia"}
FE_TestData.units["u001"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="u001", name="Centaur Champion"}
FE_TestData.units["u002"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="u002", name="Centaur Warrior"}
FE_TestData.units["u003"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="u003", name="Centaur Archer"}
FE_TestData.units["u004"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="u004", name="Centaur Protector"}
FE_TestData.units["u005"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="u005", name="Centaur Crossbowman"}
FE_TestData.units["u006"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="u006", name="Frigate Zeppelin"}
FE_TestData.units["u007"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="u007", name="Forgotten One"}
FE_TestData.units["u008"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="u008", name="Tentacle"}
FE_TestData.units["u009"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="u009", name="Forgotten Bloodmage"}
FE_TestData.units["u00A"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="u00A", name="Forgotten Soulreaper"}
FE_TestData.units["u00B"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="u00B", name="Forgotten Executioner"}
FE_TestData.units["u00C"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="u00C", name="Earth Elemental"}
FE_TestData.units["u00D"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="u00D", name="u00D"}
FE_TestData.units["u00E"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="u00E", name="Maexxna"}
FE_TestData.units["u00F"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="u00F", name="Nerubian Swarmer"}
FE_TestData.units["u00G"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="u00G", name="Golden Nerubian Harvester"}
FE_TestData.units["u00H"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="u00H", name="Advanced Nerubian Harvester"}
FE_TestData.units["u00I"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="u00I", name="Lesser Husk"}
FE_TestData.units["u00J"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="u00J", name="Greater Husk"}
FE_TestData.units["u00K"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="u00K", name="Supreme Husk"}
FE_TestData.units["u00L"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="u00L", name="Husk Sanctuary"}
FE_TestData.units["u00M"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="u00M", name="Wind Trail"}
FE_TestData.units["uloc"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="units", raw="uloc", name="uloc"}
FE_TestData.items["I000"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I000", name="Orb of Revealing"}
FE_TestData.items["I001"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I001", name="Helm of Devotion"}
FE_TestData.items["I002"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I002", name="Iron Blade"}
FE_TestData.items["I003"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I003", name="Training Lesson"}
FE_TestData.items["I004"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I004", name="Valor Armor"}
FE_TestData.items["I005"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I005", name="Magmide Blood"}
FE_TestData.items["I006"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I006", name="Gauntlet of Might"}
FE_TestData.items["I007"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I007", name="Experience Point"}
FE_TestData.items["I008"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I008", name="Intelligence Training"}
FE_TestData.items["I009"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I009", name="Agility training"}
FE_TestData.items["I00A"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I00A", name="Strength Training"}
FE_TestData.items["I00B"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I00B", name="Mystic Lava Rock"}
FE_TestData.items["I00C"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I00C", name="Heated Armor"}
FE_TestData.items["I00D"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I00D", name="Gem of Life"}
FE_TestData.items["I00E"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I00E", name="Flaming Staff"}
FE_TestData.items["I00F"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I00F", name="Bladed Gauntlet"}
FE_TestData.items["I00G"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I00G", name="[Recipe] Bladed Gauntlet (900)"}
FE_TestData.items["I00H"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I00H", name="[Recipe] Valorous Helmet (500)"}
FE_TestData.items["I00I"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I00I", name="Valorous Helmet"}
FE_TestData.items["I00J"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I00J", name="Tome of Power"}
FE_TestData.items["I00K"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I00K", name="Seed of Destruction"}
FE_TestData.items["I00L"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I00L", name="Nature's Leaf"}
FE_TestData.items["I00M"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I00M", name="Orb of God"}
FE_TestData.items["I00N"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I00N", name="Orb of God Recipe"}
FE_TestData.items["I00O"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I00O", name="Deadly Axe"}
FE_TestData.items["I00P"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I00P", name="Wand of Escape"}
FE_TestData.items["I00Q"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I00Q", name="IE-27 Mech Blaster"}
FE_TestData.items["I00R"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I00R", name="Horn of Speed"}
FE_TestData.items["I00S"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I00S", name="Amulet of Dominance"}
FE_TestData.items["I00T"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I00T", name="Lion Shield"}
FE_TestData.items["I00U"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I00U", name="Nerubian-Alchemy Gem"}
FE_TestData.items["I00V"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I00V", name="Majestic Sapphire"}
FE_TestData.items["I00W"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I00W", name="Random"}
FE_TestData.items["I00X"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I00X", name="Random (A)"}
FE_TestData.items["I00Y"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I00Y", name="Teleportation Wand"}
FE_TestData.items["I00Z"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I00Z", name="Galiant Armor"}
FE_TestData.items["I010"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I010", name="Protector Seed"}
FE_TestData.items["I011"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I011", name="[Recipe] Righteous Armor (1500)"}
FE_TestData.items["I012"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I012", name="Righteous Armor"}
FE_TestData.items["I013"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I013", name="Thriving Razorvine Seed"}
FE_TestData.items["I014"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I014", name="Monocle of Truth"}
FE_TestData.items["I015"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I015", name="Arcanum of Hatred"}
FE_TestData.items["I016"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I016", name="[Recipe] Arcanum of Hatred (1050)"}
FE_TestData.items["I017"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I017", name="Bleeding Scythe"}
FE_TestData.items["I018"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I018", name="[Recipe] Bleeding Scythe (1200)"}
FE_TestData.items["I019"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I019", name="Cosmic Orb"}
FE_TestData.items["I01A"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I01A", name="[Recipe] Cosmic Orb (600)"}
FE_TestData.items["I01B"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I01B", name="Orb of Mana"}
FE_TestData.items["I01C"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I01C", name="Staff of Insight"}
FE_TestData.items["I01D"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I01D", name="[Recipe] Staff of Insight (950)"}
FE_TestData.items["I01E"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I01E", name="Soul Hammer"}
FE_TestData.items["I01F"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I01F", name="Dark Transmutation"}
FE_TestData.items["I01G"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I01G", name="Hungering Blade"}
FE_TestData.items["I01H"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I01H", name="Ancient Artifact"}
FE_TestData.items["I01I"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I01I", name="Lunar Crystal"}
FE_TestData.items["I01J"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I01J", name="Ledger of Clarity"}
FE_TestData.items["I01K"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I01K", name="Rending Blade"}
FE_TestData.items["I01L"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I01L", name="Hammer of Might"}
FE_TestData.items["I01M"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I01M", name="[Recipe] Hammer of Might (1550)"}
FE_TestData.items["I01N"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I01N", name="Ledger of Enlightenment"}
FE_TestData.items["I01O"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I01O", name="[Recipe] Ethereal Scepter (700)"}
FE_TestData.items["I01P"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I01P", name="Ethereal Scepter"}
FE_TestData.items["I01Q"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I01Q", name="[Recipe] Spellcaster's Cloak (950)"}
FE_TestData.items["I01R"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I01R", name="Spellcaster's Cloak"}
FE_TestData.items["I01S"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I01S", name="[Recipe] Firelord's Cape (1150)"}
FE_TestData.items["I01T"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I01T", name="Firelord's Cape"}
FE_TestData.items["I01U"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I01U", name="Potion of Invisibility"}
FE_TestData.items["I01V"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I01V", name="I01V"}
FE_TestData.items["I01W"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I01W", name="Clarity Potion"}
FE_TestData.items["I01X"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I01X", name="I01X"}
FE_TestData.items["I01Y"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I01Y", name="Potion of Mana"}
FE_TestData.items["I01Z"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I01Z", name="Armor Plates"}
FE_TestData.items["I020"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I020", name="Repair Bot"}
FE_TestData.items["I021"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I021", name="Magical Biscuit"}
FE_TestData.items["I022"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I022", name="Cheese"}
FE_TestData.items["I023"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I023", name="I023"}
FE_TestData.items["I024"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I024", name="I024"}
FE_TestData.items["I025"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I025", name="Tree Chopper - Macko"}
FE_TestData.items["I026"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I026", name="Farseer Trinket"}
FE_TestData.items["I027"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I027", name="Grapes"}
FE_TestData.items["I028"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I028", name="Scout Eagle"}
FE_TestData.items["I029"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I029", name="I029"}
FE_TestData.items["I02A"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I02A", name="Rum"}
FE_TestData.items["I02B"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I02B", name="Barricade"}
FE_TestData.items["I02C"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I02C", name="Message Of The Day - 3.1.0"}
FE_TestData.items["I02D"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I02D", name="Gilnean Boots"}
FE_TestData.items["I02E"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I02E", name="I02E"}
FE_TestData.items["I02F"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I02F", name="Bracer of Agility"}
FE_TestData.items["I02G"] = true
FE_TestData.catalog[#FE_TestData.catalog+1] = {kind="items", raw="I02G", name="Potion of Greater Invisibility"}
FE_TestData.pickers[#FE_TestData.pickers+1] = {raw="h00R", shop="gg_unit_nmer_0000", ban="udg_BannedWorgen"}
FE_TestData.pickers[#FE_TestData.pickers+1] = {raw="u007", shop="gg_unit_n00G_0035", ban="udg_BannedForgotten"}
FE_TestData.pickers[#FE_TestData.pickers+1] = {raw="h03S", shop="gg_unit_n00G_0035", ban="udg_BannedAethyr"}
FE_TestData.pickers[#FE_TestData.pickers+1] = {raw="h016", shop="gg_unit_n00G_0035", ban="udg_BannedGoblin"}
FE_TestData.pickers[#FE_TestData.pickers+1] = {raw="h00F", shop="gg_unit_n00G_0035", ban="udg_BannedOgre"}
FE_TestData.pickers[#FE_TestData.pickers+1] = {raw="o000", shop="gg_unit_n00G_0035", ban="udg_BannedMagmide"}
FE_TestData.pickers[#FE_TestData.pickers+1] = {raw="h02U", shop="gg_unit_n00G_0035", ban="udg_BannedFurbolg"}
FE_TestData.pickers[#FE_TestData.pickers+1] = {raw="o01E", shop="gg_unit_n00G_0035", ban="udg_BannedRazormane"}
FE_TestData.pickers[#FE_TestData.pickers+1] = {raw="h01X", shop="gg_unit_nmer_0000", ban="udg_BannedCentaur"}
FE_TestData.pickers[#FE_TestData.pickers+1] = {raw="h010", shop="gg_unit_nmer_0000", ban="udg_BannedWildkin"}
FE_TestData.pickers[#FE_TestData.pickers+1] = {raw="h01K", shop="gg_unit_nmer_0000", ban="udg_BannedNerubian"}
FE_TestData.pickers[#FE_TestData.pickers+1] = {raw="h03D", shop="gg_unit_nmer_0000", ban="udg_BannedHuman"}
FE_TestData.pickers[#FE_TestData.pickers+1] = {raw="h02L", shop="gg_unit_nmer_0000", ban="udg_BannedWisp"}
FE_TestData.pickers[#FE_TestData.pickers+1] = {raw="h03Q", shop="gg_unit_nmer_0000", ban="udg_BannedKobold"}
FE_TestData.pickers[#FE_TestData.pickers+1] = {raw="o005", shop="gg_unit_nmer_0000", ban="udg_BannedGhoul"}
FE_TestData.pickers[#FE_TestData.pickers+1] = {raw="h000", shop="gg_unit_nmer_0000", ban="udg_BannedKraken"}
FE_TestData.pickers[#FE_TestData.pickers+1] = {raw="h05C", shop="gg_unit_n00G_0035", ban="udg_BannedElf"}
FE_TestData.pickers[#FE_TestData.pickers+1] = {raw="n00M", shop="gg_unit_n00G_0035", ban="udg_BannedHighElf"}
FE_TestData.pickers[#FE_TestData.pickers+1] = {raw="o026", shop="gg_unit_nmer_0000", ban="udg_BannedRatling"}
FE_TestData.pickers[#FE_TestData.pickers+1] = {raw="h05W", shop="gg_unit_n00G_0035", ban="udg_BannedHunter"}
FE_TestData.pickers[#FE_TestData.pickers+1] = {raw="O01V", shop="gg_unit_nmr2_0001", ban="udg_BannedAncientLight"}
FE_TestData.pickers[#FE_TestData.pickers+1] = {raw="O016", shop="gg_unit_nmr2_0001", ban="udg_BannedAncientLightning"}
FE_TestData.pickers[#FE_TestData.pickers+1] = {raw="O00S", shop="gg_unit_nmr2_0001", ban="udg_BannedAncientDragon"}
FE_TestData.pickers[#FE_TestData.pickers+1] = {raw="O00L", shop="gg_unit_nmr2_0001", ban="udg_BannedAncientEarth"}
FE_TestData.pickers[#FE_TestData.pickers+1] = {raw="O00A", shop="gg_unit_nmr2_0001", ban="udg_BannedAncientDarkness"}
FE_TestData.pickers[#FE_TestData.pickers+1] = {raw="O008", shop="gg_unit_nmr2_0001", ban="udg_BannedAncientIce"}
FE_TestData.pickers[#FE_TestData.pickers+1] = {raw="O004", shop="gg_unit_nmr2_0001", ban="udg_BannedAncientFire"}
FE_TestData.pickers[#FE_TestData.pickers+1] = {raw="O00D", shop="gg_unit_nmr2_0001", ban="udg_BannedAncientNature"}
FE_TestData.pickers[#FE_TestData.pickers+1] = {raw="O01X", shop="gg_unit_nmr2_0001", ban="udg_BannedAncientSand"}
FE_TestData.pickers[#FE_TestData.pickers+1] = {raw="O01Z", shop="gg_unit_nmr2_0001", ban="udg_BannedAncientSpace"}
FE_TestData.pickers[#FE_TestData.pickers+1] = {raw="O01D", shop="gg_unit_nmr2_0001", ban="udg_BannedAncientWind"}
-- END FOREST MODULE src/commands/test_data.lua

-- BEGIN FOREST MODULE src/commands/solo_test.lua
-- Solo sandbox. Eligibility is captured once, before match initialization.
-- Selection comes from synchronized selection events, never a local UI query.
FE_Test = {initialized=false, player=nil, selected=nil, vision=nil, skipped=false, countdowns={}}
FE_Test.resultTriggers = {
    'gg_trg_Ancient_Leaves', 'gg_trg_Ignite_Dies', 'gg_trg_Avalanche_Dies',
    'gg_trg_Paranoia_Dies', 'gg_trg_Eternity_Dies', 'gg_trg_Dragos_Dies',
    'gg_trg_Tremor_Dies', 'gg_trg_Zalxon_Dies', 'gg_trg_Divinity_Dies',
    'gg_trg_Pharoah_Dies', 'gg_trg_Nebula_Dies', 'gg_trg_Wispari_Dies',
    'gg_trg_DVIC_1', 'gg_trg_Extermination'
}

local function say(player, text)
    DisplayTextToPlayer(player, 0, 0, '|cff80d4ff[Test]|r '..text)
end

local function onlyHuman()
    local result
    for slot=0,bj_MAX_PLAYER_SLOTS-1 do
        local player=Player(slot)
        if GetPlayerController(player)==MAP_CONTROL_USER and GetPlayerSlotState(player)==PLAYER_SLOT_STATE_PLAYING then
            if result then return nil end
            result=player
        end
    end
    return result
end

function FE_Test.allowed(player)
    return player~=nil and player==FE_Test.player and onlyHuman()==player
end

function FE_Test.matchResultsEnabled()
    return FE_Test.player == nil
end

function FE_Test.suppressMatchResults()
    if not FE_Test.player then return end
    for _,name in ipairs(FE_Test.resultTriggers) do
        local trigger=assert(_G[name], 'Missing match-result trigger: '..name)
        -- A condition remains effective even if another startup trigger later
        -- enables the trigger. Block announcements as well as final results.
        TriggerAddCondition(trigger,Condition(FE_Test.matchResultsEnabled))
    end
end

local function target(player, dead)
    local unit=FE_Test.selected
    if not unit then unit=udg_AncientUnit end
    if unit and GetUnitTypeId(unit)~=0 and GetOwningPlayer(unit)==player and
       (dead or GetWidgetLife(unit)>0.405) then return unit end
    return nil
end

local function integer(text, low, high)
    if not text or not text:match('^%-?%d+$') then return nil end
    local value=tonumber(text)
    if value and value>=low and value<=high then return math.floor(value) end
end

local aliases={unit='spawn', lvl='level', mh='reveal', nomh='hide', cd='cooldown', cheats='help'}

function FE_Test.releaseCountdown(dialog)
    for i=#FE_Test.countdowns,1,-1 do
        if FE_Test.countdowns[i].dialog==dialog then table.remove(FE_Test.countdowns,i); return end
    end
end

function FE_Test.skipPicking(player)
    if not FE_Test.allowed(player) then return end
    if FE_Test.skipped then say(player,'Picking wait already skipped.'); return end
    FE_Test.skipped=true
    for _,trigger in ipairs({gg_trg_Spawn_Races,gg_trg_Spawn_Ancients,gg_trg_TimeToExpanderSpawn,gg_trg_TimeToAncientSpawn}) do
        DisableTrigger(trigger)
    end
    for _,countdown in ipairs(FE_Test.countdowns) do
        PauseTimer(countdown.timer); TimerDialogDisplay(countdown.dialog,false)
    end
    for _,entry in ipairs(FE_TestData.pickers) do
        local shop=_G[entry.shop]
        if shop and GetUnitTypeId(shop)~=0 and _G[entry.ban]==0 then
            RemoveUnitFromStock(shop,FourCC(entry.raw))
            AddUnitToStock(shop,FourCC(entry.raw),1,1)
        end
    end
    say(player,'Picking unlocked. Choose your hero or race normally. The match clock still runs normally.')
end

function FE_Test.run(player, text)
    if not FE_Test.allowed(player) then return end
    local args={}
    for word in text:gmatch('%S+') do args[#args+1]=word end
    local command=string.lower(args[1] or '')
    if command=='-test' then table.remove(args,1); command=string.lower(args[1] or 'help')
    else command=command:gsub('^%-','') end
    command=aliases[command] or command
    if command=='skip' then FE_Test.skipPicking(player); return end
    if command=='help' then
        say(player,'Solo test mode ('..FE_TestData.releaseLabel..'). Victory/defeat countdowns are disabled. Use -test <command>.')
        say(player,'skip: unlock hero/race picking immediately. Full command lists are in the separate DEBUG_REFERENCE.md document.')
        say(player,'gold/lumber <amount>: add resources; xp <amount>: add XP; level <1-20>: set level.')
        say(player,'find <name>, items [page] [name], units [page] [name] list IDs in chat.')
        say(player,'spawn <unit ID> [1-20]; item <item ID> [1-6]. Example: -item I001 creates Helm of Devotion.')
        say(player,'heal, mana, cooldown, invul, vul, revive, kill, destroy, copy [1-20], unitid, itemid, loc.')
        say(player,'reveal, hide, speed <0-522>, time <0-24>, shop. Unit commands affect your last selected owned unit.')
        return
    end
    if command=='gold' or command=='lumber' then
        local amount=integer(args[2],-1000000,1000000)
        if not amount then say(player,'Usage: -test '..command..' <amount, -1000000 to 1000000>'); return end
        local state=command=='gold' and PLAYER_STATE_RESOURCE_GOLD or PLAYER_STATE_RESOURCE_LUMBER
        local value=math.max(0,math.min(1000000,GetPlayerState(player,state)+amount))
        SetPlayerState(player,state,value); say(player,command..': '..value); return
    end
    if command=='find' or command=='items' or command=='units' then
        local page=integer(args[2],1,10000)
        local query=string.lower(table.concat(args,' ',page and 3 or 2)); local found=0
        page=page or 1
        if command=='find' and #query<2 then say(player,'Usage: -test find <at least 2 letters of a name or ID>'); return end
        for _,entry in ipairs(FE_TestData.catalog) do
            if (command=='find' or command==entry.kind) and string.find(string.lower(entry.name..' '..entry.raw),query,1,true) then
                found=found+1
                if found>(page-1)*12 and found<=page*12 then say(player,entry.raw..' ['..entry.kind..'] '..entry.name) end
            end
        end
        say(player,found..' matches; page '..page..'/'..math.max(1,math.ceil(found/12))..'. IDs are case-sensitive.')
        if found>page*12 then say(player,'Next: -test '..command..' '..(page+1)..' '..query) end
        return
    end
    if command=='reveal' or command=='hide' then
        if FE_Test.vision then
            FogModifierStop(FE_Test.vision); DestroyFogModifier(FE_Test.vision); FE_Test.vision=nil
        end
        if command=='reveal' then
            FE_Test.vision=CreateFogModifierRect(player,FOG_OF_WAR_VISIBLE,bj_mapInitialPlayableArea,true,false)
            FogModifierStart(FE_Test.vision)
        end
        say(player,command=='reveal' and 'Map revealed.' or 'Map reveal disabled.'); return
    end
    if command=='time' then
        local hour=integer(args[2],0,24)
        if hour then SetTimeOfDay(hour) else say(player,'Usage: -test time <0-24>') end
        return
    end
    if command=='shop' then
        if args[2]=='on' then FE_Shops.traceEnabled=true
        elseif args[2]=='off' then FE_Shops.traceEnabled=false end
        local d=FE_Recipes.diagnostics
        say(player,'Shop trace '..(FE_Shops.traceEnabled and 'ON' or 'OFF')..' (-test shop on/off). All shop sales: '..FE_Shops.diagnostics.sales..
            '; ordinary items delivered: '..FE_Shops.diagnostics.delivered..'; left on ground: '..FE_Shops.diagnostics.ground)
        say(player,FE_Shops.diagnostics.last)
        say(player,'Recipes initialized: '..tostring(FE_Recipes.initialized)..'; recipe sales: '..d.sales..
            '; completed: '..d.completed..'; refunded: '..d.refunded..'; last: '..d.last)
        say(player,'Ancient owner: '..tostring(FE_Roles.isAncient(player))..'; cached hero owned: '..
            tostring(udg_AncientUnit~=nil and GetOwningPlayer(udg_AncientUnit)==player))
        for _,shop in ipairs(FE_Shops.shops) do say(player,FE_Shops.describe(shop)) end
        return
    end
    local unit=target(player,command=='revive')
    if command=='spawn' or command=='item' then
        local raw=args[2]; local catalog=command=='spawn' and FE_TestData.units or FE_TestData.items
        local count=integer(args[3] or '1',1,command=='spawn' and 20 or 6)
        if not raw or not catalog[raw] or not count then
            say(player,'Usage: -test '..command..' <map object ID> [count]. Use -test find <name>.'); return
        end
        local start=GetPlayerStartLocation(player)
        local x=unit and GetUnitX(unit) or GetStartLocationX(start)
        local y=unit and GetUnitY(unit) or GetStartLocationY(start)
        for index=1,count do
            local offset=64*((index-1)%5+1)
            if command=='spawn' then CreateUnit(player,FourCC(raw),x+offset,y+64*((index-1)//5),270)
            else CreateItem(FourCC(raw),x+offset,y) end
        end
        say(player,'Created '..count..' '..raw..' nearby. Spawned heroes do not change match roles.'); return
    end
    if not unit then say(player,'Select one of your own units first.'); return end
    if command=='xp' or command=='level' then
        local amount=integer(args[2],command=='level' and 1 or 0,command=='level' and 20 or 1000000)
        if not amount or not IsUnitType(unit,UNIT_TYPE_HERO) then say(player,'Select an owned hero and supply a valid '..command..' amount.'); return end
        if command=='xp' then AddHeroXP(unit,amount,false)
        elseif amount<GetHeroLevel(unit) then UnitStripHeroLevel(unit,GetHeroLevel(unit)-amount)
        else SetHeroLevel(unit,amount,false) end
    elseif command=='heal' then
        SetWidgetLife(unit,GetUnitState(unit,UNIT_STATE_MAX_LIFE))
        SetUnitState(unit,UNIT_STATE_MANA,GetUnitState(unit,UNIT_STATE_MAX_MANA))
    elseif command=='mana' then SetUnitState(unit,UNIT_STATE_MANA,GetUnitState(unit,UNIT_STATE_MAX_MANA))
    elseif command=='cooldown' then UnitResetCooldown(unit)
    elseif command=='invul' or command=='vul' then SetUnitInvulnerable(unit,command=='invul')
    elseif command=='kill' then KillUnit(unit)
    elseif command=='destroy' then RemoveUnit(unit); FE_Test.selected=nil
    elseif command=='revive' then
        if IsUnitType(unit,UNIT_TYPE_HERO) then ReviveHero(unit,GetUnitX(unit),GetUnitY(unit),true) end
    elseif command=='speed' then
        local speed=integer(args[2],0,522)
        if not speed then say(player,'Usage: -test speed <0-522>'); return end
        SetUnitMoveSpeed(unit,speed)
    elseif command=='copy' then
        local count=integer(args[2] or '1',1,20)
        if not count then say(player,'Usage: -test copy <1-20>'); return end
        for index=1,count do CreateUnit(player,GetUnitTypeId(unit),GetUnitX(unit)+64*index,GetUnitY(unit),GetUnitFacing(unit)) end
    elseif command=='unitid' or command=='itemid' then
        local raw=GetUnitTypeId(unit)
        if command=='itemid' then raw=GetItemTypeId(UnitItemInSlot(unit,0)) end
        for _,entry in ipairs(FE_TestData.catalog) do
            if FourCC(entry.raw)==raw then say(player,entry.raw..' '..entry.name); return end
        end
        say(player,'No matching map object in that slot.'); return
    elseif command=='loc' then say(player,tostring(GetUnitX(unit))..', '..tostring(GetUnitY(unit))); return
    else say(player,'Unknown command. Use -test help.'); return end
    say(player,command..' applied.')
end

function FE_Test.init()
    if FE_Test.initialized then return end
    FE_Test.initialized=true; FE_Test.player=onlyHuman()
    if not FE_Test.player then return end
    local player=FE_Test.player
    FE_Shops.initDebug(player)
    FE_Test.suppressMatchResults()
    local chat,selected=CreateTrigger(),CreateTrigger()
    TriggerRegisterPlayerChatEvent(chat,player,'-',false)
    TriggerAddAction(chat,function()
        local text=GetEventPlayerChatString()
        local first=string.lower(text:match('^(%S+)') or '')
        -- Avoid interpreting the map's unrelated existing chat commands.
        local short={'gold','lumber','xp','lvl','unit','spawn','item','heal','mana','invul','vul','mh','nomh','cheats','skip'}
        local accept=first=='-test'
        for _,name in ipairs(short) do if first=='-'..name then accept=true end end
        if accept then FE_Test.run(GetTriggerPlayer(),text) end
    end)
    TriggerRegisterPlayerUnitEventSimple(selected,player,EVENT_PLAYER_UNIT_SELECTED)
    TriggerAddAction(selected,function()
        if not FE_Test.allowed(GetTriggerPlayer()) then return end
        local unit=GetTriggerUnit()
        if GetOwningPlayer(unit)==player then FE_Test.selected=unit end
    end)
    local timer=CreateTimer()
    TimerStart(timer,1,false,function()
        DestroyTimer(timer); say(player,'Forest Expansion '..FE_TestData.releaseLabel..': SOLO TEST MODE ON. Victory timers OFF. Type -test skip or -test help.')
    end)
end
-- END FOREST MODULE src/commands/solo_test.lua

-- BEGIN FOREST MODULE src/initialization.lua
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
-- END FOREST MODULE src/initialization.lua

-- BEGIN FOREST MODULE src/combat/damage.lua
-- combat / damage
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 1 Damage_Engine_Config
-- Original JASS function: Trig_Damage_Engine_Config_Actions (line 4321)
function Trig_Damage_Engine_Config_Actions()
    udg_DamageTypePureExplosive = __jint(-(2))
    udg_DamageTypeExplosive = __jint(-(1))
    udg_DamageTypeCode = 1
    udg_DamageTypePure = 2
    udg_DamageTypeHeal = 3
    udg_DamageTypeBlocked = 4
    udg_DamageTypeReduced = 5
    udg_DamageTypeCriticalStrike = 6
    DamageEngine_DebugStr()
end

-- Original JASS function: InitTrig_Damage_Engine_Config (line 4350)
function InitTrig_Damage_Engine_Config()
    gg_trg_Damage_Engine_Config = CreateTrigger()
    TriggerAddAction(gg_trg_Damage_Engine_Config, Trig_Damage_Engine_Config_Actions)
end
-- END FOREST SECTION 1

-- BEGIN FOREST SECTION 2 Damage_Engine
-- This trigger has no standalone compiled functions. Library implementations are in src/libraries/.
-- END FOREST SECTION 2
-- END FOREST MODULE src/combat/damage.lua

-- BEGIN FOREST MODULE src/effects/timed.lua
-- effects / timed
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 3 TSEConfig
-- Original JASS function: Trig_TSEConfig_Actions (line 4366)
function Trig_TSEConfig_Actions()
    udg_TSE_LoopTrigger = gg_trg_TSELoop
    udg_TSE_RegisterTrigger = gg_trg_TSERegister
    udg_TSE_EmptyEvent = gg_trg_TSEEmptyEvent
    udg_TSE_TIMEOUT = (__jreal(__jreal(1.00) / __jreal(32.00)))
    udg_TSE_MaxRecursion = 32767
    udg_TSEScale = __jreal(1.00)
end

-- Original JASS function: InitTrig_TSEConfig (line 4392)
function InitTrig_TSEConfig()
    gg_trg_TSEConfig = CreateTrigger()
    TriggerAddAction(gg_trg_TSEConfig, Trig_TSEConfig_Actions)
end
-- END FOREST SECTION 3

-- BEGIN FOREST SECTION 4 TSERegister
-- Original JASS function: Trig_TSERegister_Func002C (line 4400)
function Trig_TSERegister_Func002C()
    if ((not ((udg_TSEUnit ~= nil)))) then
        do return false end
    end
    if ((not ((udg_TSETargetUnit == nil)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_TSERegister_Func003Func001C (line 4410)
function Trig_TSERegister_Func003Func001C()
    if (((udg_TSETargetUnitAliveCheck == true))) then
        do return true end
    end
    if (((udg_TSEUnitAliveCheck == true))) then
        do return true end
    end
    do return false end
end

-- Original JASS function: Trig_TSERegister_Func003C (line 4420)
function Trig_TSERegister_Func003C()
    if ((not Trig_TSERegister_Func003Func001C())) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_TSERegister_Func007C (line 4427)
function Trig_TSERegister_Func007C()
    if ((not ((udg_TSETargetUnit ~= nil)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_TSERegister_Func008C (line 4434)
function Trig_TSERegister_Func008C()
    if ((not ((udg_TSESourceUnit ~= nil)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_TSERegister_Func011Func001C (line 4441)
function Trig_TSERegister_Func011Func001C()
    if ((not ((udg_TSESourceUnit ~= nil)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_TSERegister_Func011C (line 4448)
function Trig_TSERegister_Func011C()
    if ((not ((udg_TSEChanneledOrderID ~= "")))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_TSERegister_Func012C (line 4455)
function Trig_TSERegister_Func012C()
    if ((not ((udg_TSEOnLoopTimer < udg_TSE_TIMEOUT)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_TSERegister_Func034C (line 4462)
function Trig_TSERegister_Func034C()
    if ((not ((udg_TSE_MaxIndex == 1)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_TSERegister_Actions (line 4469)
function Trig_TSERegister_Actions()
    if (Trig_TSERegister_Func002C()) then
        udg_TSETargetUnit = udg_TSEUnit
    else
    end
    if (Trig_TSERegister_Func003C()) then
        udg_TSETargetUnitAliveCheck = true
    else
    end
    udg_TSE_MaxIndex = (__jint(udg_TSE_MaxIndex + 1))
    udg_TSE_I_RemainingDuration[udg_TSE_MaxIndex] = udg_TSEDuration
    if (Trig_TSERegister_Func007C()) then
        AddSpecialEffectTargetUnitBJ(udg_TSEAttachPoint, udg_TSETargetUnit, udg_TSEEffectName)
        udg_TSE_I_TargetUnitAliveCheck[udg_TSE_MaxIndex] = udg_TSETargetUnitAliveCheck
    else
        AddSpecialEffectLocBJ(udg_TSEPoint, udg_TSEEffectName)
        udg_TSE_I_TargetUnitAliveCheck[udg_TSE_MaxIndex] = false
    end
    if (Trig_TSERegister_Func008C()) then
        udg_TSE_I_SourceUnitAliveCheck[udg_TSE_MaxIndex] = udg_TSESourceUnitAliveCheck
    else
    end
    udg_TSE_I_Effect[udg_TSE_MaxIndex] = GetLastCreatedEffectBJ()
    BlzSetSpecialEffectScale(udg_TSE_I_Effect[udg_TSE_MaxIndex], udg_TSEScale)
    if (Trig_TSERegister_Func011C()) then
        if (Trig_TSERegister_Func011Func001C()) then
            udg_TSE_I_IsChanneling[udg_TSE_MaxIndex] = true
        else
            DisplayTextToForce(GetPlayersAll(), "TRIGSTR_4185")
        end
    else
    end
    if (Trig_TSERegister_Func012C()) then
        udg_TSEOnLoopTimer = udg_TSE_TIMEOUT
    else
    end
    udg_TSE_I_SourceUnit[udg_TSE_MaxIndex] = udg_TSESourceUnit
    udg_TSE_I_TargetUnit[udg_TSE_MaxIndex] = udg_TSETargetUnit
    udg_TSE_I_ChanneledOrderID[udg_TSE_MaxIndex] = udg_TSEChanneledOrderID
    udg_TSE_I_OnLoopEvent[udg_TSE_MaxIndex] = udg_TSEOnLoopEvent
    udg_TSE_I_OnLoopTimer[udg_TSE_MaxIndex] = udg_TSEOnLoopTimer
    udg_TSE_I_LoopDuration[udg_TSE_MaxIndex] = udg_TSEOnLoopTimer
    udg_TSE_I_OnEndEvent[udg_TSE_MaxIndex] = udg_TSEOnEndEvent
    udg_TSE_I_LockInstance[udg_TSE_MaxIndex] = udg_TSELockInstance
    udg_TSE_I_ActiveInstance[udg_TSE_MaxIndex] = true
    udg_TSE_I_Point[udg_TSE_MaxIndex] = udg_TSEPoint
    udg_TSE__ActiveIndex = udg_TSE_MaxIndex
    udg_TSE__RemainingDuration = udg_TSE_I_RemainingDuration[udg_TSE__ActiveIndex]
    udg_TSE__SourceUnit = udg_TSE_I_SourceUnit[udg_TSE__ActiveIndex]
    udg_TSE__TargetUnit = udg_TSE_I_TargetUnit[udg_TSE__ActiveIndex]
    udg_TSE__Point = udg_TSE_I_Point[udg_TSE__ActiveIndex]
    udg_TSE__SpecialEffect = udg_TSE_I_Effect[udg_TSE__ActiveIndex]
    ConditionalTriggerExecute(udg_TSEOnIndexEvent)
    udg_TSE_I_RemainingDuration[udg_TSE__ActiveIndex] = udg_TSE__RemainingDuration
    if (Trig_TSERegister_Func034C()) then
        StartTimerBJ(udg_TSE_CTimer, true, udg_TSE_TIMEOUT)
        EnableTrigger(udg_TSE_LoopTrigger)
    else
    end
    udg_TSETargetUnit = nil
    udg_TSETargetUnitAliveCheck = false
    udg_TSEScale = __jreal(1.00)
    udg_TSEChanneledOrderID = ""
    udg_TSESourceUnit = nil
    udg_TSEOnIndexEvent = udg_TSE_EmptyEvent
    udg_TSEOnLoopEvent = udg_TSE_EmptyEvent
    udg_TSEOnLoopTimer = udg_TSE_TIMEOUT
    udg_TSEOnEndEvent = udg_TSE_EmptyEvent
    udg_TSELockInstance = false
    udg_TSEUnit = nil
    udg_TSEUnitAliveCheck = false
end

-- Original JASS function: InitTrig_TSERegister (line 4550)
function InitTrig_TSERegister()
    gg_trg_TSERegister = CreateTrigger()
    TriggerAddAction(gg_trg_TSERegister, Trig_TSERegister_Actions)
end
-- END FOREST SECTION 4

-- BEGIN FOREST SECTION 5 TSELoop
-- Original JASS function: Trig_TSELoop_Func002Func001Func004C (line 4558)
function Trig_TSELoop_Func002Func001Func004C()
    if ((not ((udg_TSE_I_LoopDuration[udg_TSE_Index] <= __jreal(0.00))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_TSELoop_Func002Func001Func006C (line 4565)
function Trig_TSELoop_Func002Func001Func006C()
    if ((not ((udg_TSE_I_TargetUnitAliveCheck[udg_TSE_Index] == true)))) then
        do return false end
    end
    if ((not ((IsUnitAliveBJ(udg_TSE_I_TargetUnit[udg_TSE_Index]) == false)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_TSELoop_Func002Func001Func007C (line 4575)
function Trig_TSELoop_Func002Func001Func007C()
    if ((not ((udg_TSE_I_SourceUnitAliveCheck[udg_TSE_Index] == true)))) then
        do return false end
    end
    if ((not ((IsUnitAliveBJ(udg_TSE_I_SourceUnit[udg_TSE_Index]) == false)))) then
        do return false end
    end
    if ((not ((udg_TSE_I_SourceUnit[udg_TSE_Index] ~= nil)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_TSELoop_Func002Func001Func008C (line 4588)
function Trig_TSELoop_Func002Func001Func008C()
    if ((not ((udg_TSE_I_IsChanneling[udg_TSE_Index] == true)))) then
        do return false end
    end
    if ((not ((GetUnitCurrentOrder(udg_TSE_I_SourceUnit[udg_TSE_Index]) ~= String2OrderIdBJ(udg_TSE_I_ChanneledOrderID[udg_TSE_Index]))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_TSELoop_Func002Func001Func010Func017Func002Func002C (line 4598)
function Trig_TSELoop_Func002Func001Func010Func017Func002Func002C()
    if ((not ((udg_TSE_I_LockInstance[udg_TSE_ReplacementIndex] == false)))) then
        do return false end
    end
    if ((not ((udg_TSE_I_ActiveInstance[udg_TSE_ReplacementIndex] == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_TSELoop_Func002Func001Func010Func017Func002C (line 4608)
function Trig_TSELoop_Func002Func001Func010Func017Func002C()
    if (((udg_TSE_Recursion >= udg_TSE_MaxRecursion))) then
        do return true end
    end
    if (Trig_TSELoop_Func002Func001Func010Func017Func002Func002C()) then
        do return true end
    end
    if (((udg_TSE_ReplacementIndex == udg_TSE_Index))) then
        do return true end
    end
    do return false end
end

-- Original JASS function: Trig_TSELoop_Func002Func001Func010Func017C (line 4621)
function Trig_TSELoop_Func002Func001Func010Func017C()
    if ((not Trig_TSELoop_Func002Func001Func010Func017Func002C())) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_TSELoop_Func002Func001Func010Func039Func002C (line 4628)
function Trig_TSELoop_Func002Func001Func010Func039Func002C()
    if (((udg_TSE_ReplacementIndex == udg_TSE_MaxIndex))) then
        do return true end
    end
    if (((udg_TSE_I_ActiveInstance[udg_TSE_MaxIndex] == false))) then
        do return true end
    end
    do return false end
end

-- Original JASS function: Trig_TSELoop_Func002Func001Func010Func039Func005Func002C (line 4638)
function Trig_TSELoop_Func002Func001Func010Func039Func005Func002C()
    if (((udg_TSE_I_ActiveInstance[udg_TSE_MaxIndex] == true))) then
        do return true end
    end
    if (((udg_TSE_MaxIndex <= 0))) then
        do return true end
    end
    do return false end
end

-- Original JASS function: Trig_TSELoop_Func002Func001Func010Func039Func005C (line 4648)
function Trig_TSELoop_Func002Func001Func010Func039Func005C()
    if ((not Trig_TSELoop_Func002Func001Func010Func039Func005Func002C())) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_TSELoop_Func002Func001Func010Func039C (line 4655)
function Trig_TSELoop_Func002Func001Func010Func039C()
    if ((not Trig_TSELoop_Func002Func001Func010Func039Func002C())) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_TSELoop_Func002Func001Func010Func041C (line 4662)
function Trig_TSELoop_Func002Func001Func010Func041C()
    if ((not ((udg_TSE_MaxIndex <= 0)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_TSELoop_Func002Func001Func010C (line 4669)
function Trig_TSELoop_Func002Func001Func010C()
    if ((not ((udg_TSE_I_RemainingDuration[udg_TSE_Index] <= __jreal(0.00))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_TSELoop_Func002Func001C (line 4676)
function Trig_TSELoop_Func002Func001C()
    if ((not ((udg_TSE_I_ActiveInstance[udg_TSE_Index] == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_TSELoop_Actions (line 4683)
function Trig_TSELoop_Actions()
    udg_TSE_Index = 1
    while true do
        if (udg_TSE_Index > udg_TSE_MaxIndex) then break end
        if (Trig_TSELoop_Func002Func001C()) then
            udg_TSE_I_RemainingDuration[udg_TSE_Index] = (__jreal(udg_TSE_I_RemainingDuration[udg_TSE_Index] - udg_TSE_TIMEOUT))
            udg_TSE_I_LoopDuration[udg_TSE_Index] = (__jreal(udg_TSE_I_LoopDuration[udg_TSE_Index] - udg_TSE_TIMEOUT))
            if (Trig_TSELoop_Func002Func001Func004C()) then
                udg_TSE__ActiveIndex = udg_TSE_Index
                udg_TSE__RemainingDuration = udg_TSE_I_RemainingDuration[udg_TSE__ActiveIndex]
                udg_TSE__SourceUnit = udg_TSE_I_SourceUnit[udg_TSE__ActiveIndex]
                udg_TSE__TargetUnit = udg_TSE_I_TargetUnit[udg_TSE__ActiveIndex]
                udg_TSE__Point = udg_TSE_I_Point[udg_TSE__ActiveIndex]
                udg_TSE__SpecialEffect = udg_TSE_I_Effect[udg_TSE__ActiveIndex]
                ConditionalTriggerExecute(udg_TSE_I_OnLoopEvent[udg_TSE_Index])
                udg_TSE_I_RemainingDuration[udg_TSE__ActiveIndex] = udg_TSE__RemainingDuration
                udg_TSE_I_LoopDuration[udg_TSE_Index] = udg_TSE_I_OnLoopTimer[udg_TSE_Index]
            else
            end
            if (Trig_TSELoop_Func002Func001Func006C()) then
                udg_TSE_I_RemainingDuration[udg_TSE_Index] = __jreal(0.00)
            else
            end
            if (Trig_TSELoop_Func002Func001Func007C()) then
                udg_TSE_I_RemainingDuration[udg_TSE_Index] = __jreal(0.00)
            else
            end
            if (Trig_TSELoop_Func002Func001Func008C()) then
                udg_TSE_I_RemainingDuration[udg_TSE_Index] = __jreal(0.00)
            else
            end
            if (Trig_TSELoop_Func002Func001Func010C()) then
                udg_TSE__ActiveIndex = udg_TSE_Index
                udg_TSE__RemainingDuration = udg_TSE_I_RemainingDuration[udg_TSE__ActiveIndex]
                udg_TSE__SourceUnit = udg_TSE_I_SourceUnit[udg_TSE__ActiveIndex]
                udg_TSE__TargetUnit = udg_TSE_I_TargetUnit[udg_TSE__ActiveIndex]
                udg_TSE__Point = udg_TSE_I_Point[udg_TSE__ActiveIndex]
                udg_TSE__SpecialEffect = udg_TSE_I_Effect[udg_TSE__ActiveIndex]
                ConditionalTriggerExecute(udg_TSE_I_OnEndEvent[udg_TSE_Index])
                DestroyEffectBJ(udg_TSE_I_Effect[udg_TSE_Index])
                udg_TSE_ReplacementIndexFound = false
                udg_TSE_ReplacementIndex = udg_TSE_MaxIndex
                udg_TSE_Recursion = 0
                while true do
                    udg_TSE_Recursion = (__jint(udg_TSE_Recursion + 1))
                    if (Trig_TSELoop_Func002Func001Func010Func017C()) then
                        udg_TSE_ReplacementIndexFound = true
                    else
                        udg_TSE_ReplacementIndex = (__jint(udg_TSE_ReplacementIndex - 1))
                    end
                    if (udg_TSE_ReplacementIndexFound == true) then break end
                end
                RemoveLocation(udg_TSE_I_Point[udg_TSE_Index])
                udg_TSE_I_Point[udg_TSE_Index] = udg_TSE_I_Point[udg_TSE_ReplacementIndex]
                udg_TSE_I_RemainingDuration[udg_TSE_Index] = udg_TSE_I_RemainingDuration[udg_TSE_ReplacementIndex]
                udg_TSE_I_Effect[udg_TSE_Index] = udg_TSE_I_Effect[udg_TSE_ReplacementIndex]
                udg_TSE_I_ChanneledOrderID[udg_TSE_Index] = udg_TSE_I_ChanneledOrderID[udg_TSE_ReplacementIndex]
                udg_TSE_I_IsChanneling[udg_TSE_Index] = udg_TSE_I_IsChanneling[udg_TSE_ReplacementIndex]
                udg_TSE_I_SourceUnit[udg_TSE_Index] = udg_TSE_I_SourceUnit[udg_TSE_ReplacementIndex]
                udg_TSE_I_SourceUnitAliveCheck[udg_TSE_Index] = udg_TSE_I_SourceUnitAliveCheck[udg_TSE_ReplacementIndex]
                udg_TSE_I_TargetUnitAliveCheck[udg_TSE_Index] = udg_TSE_I_TargetUnitAliveCheck[udg_TSE_ReplacementIndex]
                udg_TSE_I_TargetUnit[udg_TSE_Index] = udg_TSE_I_TargetUnit[udg_TSE_ReplacementIndex]
                udg_TSE_I_OnLoopEvent[udg_TSE_Index] = udg_TSE_I_OnLoopEvent[udg_TSE_ReplacementIndex]
                udg_TSE_I_OnLoopTimer[udg_TSE_Index] = udg_TSE_I_OnLoopTimer[udg_TSE_ReplacementIndex]
                udg_TSE_I_LoopDuration[udg_TSE_Index] = udg_TSE_I_LoopDuration[udg_TSE_ReplacementIndex]
                udg_TSE_I_OnEndEvent[udg_TSE_Index] = udg_TSE_I_OnEndEvent[udg_TSE_ReplacementIndex]
                udg_TSE_I_LockInstance[udg_TSE_Index] = udg_TSE_I_LockInstance[udg_TSE_ReplacementIndex]
                udg_TSE_I_LockInstance[udg_TSE_ReplacementIndex] = false
                udg_TSE_I_ActiveInstance[udg_TSE_Index] = udg_TSE_I_ActiveInstance[udg_TSE_ReplacementIndex]
                udg_TSE_I_ActiveInstance[udg_TSE_ReplacementIndex] = false
                udg_TSE_Index = (__jint(udg_TSE_Index - 1))
                if (Trig_TSELoop_Func002Func001Func010Func039C()) then
                    udg_TSE_MaxCheckOver = false
                    while true do
                        udg_TSE_MaxIndex = (__jint(udg_TSE_MaxIndex - 1))
                        if (Trig_TSELoop_Func002Func001Func010Func039Func005C()) then
                            udg_TSE_MaxCheckOver = true
                        else
                        end
                        if (udg_TSE_MaxCheckOver == true) then break end
                    end
                else
                end
                if (Trig_TSELoop_Func002Func001Func010Func041C()) then
                    PauseTimerBJ(true, udg_TSE_CTimer)
                    DisableTrigger(udg_TSE_LoopTrigger)
                else
                end
            else
            end
        else
        end
        udg_TSE_Index = __jint(udg_TSE_Index + 1)
    end
end

-- Original JASS function: InitTrig_TSELoop (line 4789)
function InitTrig_TSELoop()
    gg_trg_TSELoop = CreateTrigger()
    DisableTrigger(gg_trg_TSELoop)
    TriggerRegisterTimerExpireEventBJ(gg_trg_TSELoop, udg_TSE_CTimer)
    TriggerAddAction(gg_trg_TSELoop, Trig_TSELoop_Actions)
end
-- END FOREST SECTION 5

-- BEGIN FOREST SECTION 6 TSEEmptyEvent
-- Original JASS function: Trig_TSEEmptyEvent_Actions (line 4799)
function Trig_TSEEmptyEvent_Actions()
end

-- Original JASS function: InitTrig_TSEEmptyEvent (line 4803)
function InitTrig_TSEEmptyEvent()
    gg_trg_TSEEmptyEvent = CreateTrigger()
    TriggerAddAction(gg_trg_TSEEmptyEvent, Trig_TSEEmptyEvent_Actions)
end
-- END FOREST SECTION 6
-- END FOREST MODULE src/effects/timed.lua

-- BEGIN FOREST MODULE src/game/clock.lua
-- game / clock
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 7 Map_Ini_Testing
-- Original JASS function: Trig_Map_Ini_Testing_Actions (line 4813)
function Trig_Map_Ini_Testing_Actions()
    CreateMultiboardBJ(3, 11, "TRIGSTR_5709")
    MultiboardSetTitleText(GetLastCreatedMultiboard(), "TRIGSTR_5710")
end

-- Original JASS function: InitTrig_Map_Ini_Testing (line 4819)
function InitTrig_Map_Ini_Testing()
    gg_trg_Map_Ini_Testing = CreateTrigger()
    DisableTrigger(gg_trg_Map_Ini_Testing)
    TriggerRegisterTimerEventSingle(gg_trg_Map_Ini_Testing, __jreal(1.00))
    TriggerAddAction(gg_trg_Map_Ini_Testing, Trig_Map_Ini_Testing_Actions)
end
-- END FOREST SECTION 7

-- BEGIN FOREST SECTION 8 Counter_Testing
-- Original JASS function: Trig_Counter_Testing_Actions (line 4831)
function Trig_Counter_Testing_Actions()
    MultiboardSetItemWidthBJ(GetLastCreatedMultiboard(), 1, 1, __jreal(15.00))
    MultiboardSetItemWidthBJ(GetLastCreatedMultiboard(), 2, 1, __jreal(15.00))
    MultiboardSetItemStyleBJ(GetLastCreatedMultiboard(), 0, 1, true, false)
    MultiboardSetItemIconBJ(GetLastCreatedMultiboard(), 0, 2, "UI\\Feedback\\Resources\\ResourceGold.blp")
    MultiboardSetItemValueBJ(GetLastCreatedMultiboard(), 0, 1, "TRIGSTR_4490")
    MultiboardSetItemValueBJ(GetLastCreatedMultiboard(), 0, 2, "TRIGSTR_152")
    MultiboardSetItemValueBJ(GetLastCreatedMultiboard(), 1, 3, GetPlayerName(Player(0)))
    MultiboardSetItemValueBJ(GetLastCreatedMultiboard(), 1, 3, (__jconcat("|cffff0000", (__jconcat(GetPlayerName(Player(0)), "|r")))))
    MultiboardSetItemWidthBJ(GetLastCreatedMultiboard(), 0, 2, __jreal(13.00))
    MultiboardSetItemWidthBJ(GetLastCreatedMultiboard(), 1, 3, __jreal(15.00))
    MultiboardSetItemWidthBJ(GetLastCreatedMultiboard(), 2, 3, __jreal(6.00))
    MultiboardSetItemValueBJ(GetLastCreatedMultiboard(), 2, 3, I2S(GetPlayerState(Player(0), PLAYER_STATE_RESOURCE_GOLD)))
end

-- Original JASS function: InitTrig_Counter_Testing (line 4847)
function InitTrig_Counter_Testing()
    gg_trg_Counter_Testing = CreateTrigger()
    DisableTrigger(gg_trg_Counter_Testing)
    TriggerRegisterTimerEventPeriodic(gg_trg_Counter_Testing, __jreal(2.00))
    TriggerAddAction(gg_trg_Counter_Testing, Trig_Counter_Testing_Actions)
end
-- END FOREST SECTION 8

-- BEGIN FOREST SECTION 9 Start_Counter
-- Original JASS function: Trig_Start_Counter_Actions (line 4859)
function Trig_Start_Counter_Actions()
    DisableTrigger(gg_trg_Tradeoff_Detection)
    DisableTrigger(gg_trg_TreeChopper_Detection)
end

-- Original JASS function: InitTrig_Start_Counter (line 4865)
function InitTrig_Start_Counter()
    gg_trg_Start_Counter = CreateTrigger()
    DisableTrigger(gg_trg_Start_Counter)
    TriggerRegisterTimerEventSingle(gg_trg_Start_Counter, __jreal(60.00))
    TriggerAddAction(gg_trg_Start_Counter, Trig_Start_Counter_Actions)
end
-- END FOREST SECTION 9

-- BEGIN FOREST SECTION 10 Counter
-- Original JASS function: Trig_Counter_Func002Func003C (line 4875)
function Trig_Counter_Func002Func003C()
    if ((not ((udg_IntMinutes == 60)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Counter_Func002C (line 4882)
function Trig_Counter_Func002C()
    if ((not ((udg_IntSeconds == 60)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Counter_Func003C (line 4889)
function Trig_Counter_Func003C()
    if ((not ((udg_IntSeconds < 10)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Counter_Func004C (line 4896)
function Trig_Counter_Func004C()
    if ((not ((udg_IntMinutes < 10)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Counter_Actions (line 4903)
function Trig_Counter_Actions()
    udg_IntSeconds = (__jint(udg_IntSeconds + 1))
    if (Trig_Counter_Func002C()) then
        udg_IntSeconds = 0
        udg_IntMinutes = (__jint(udg_IntMinutes + 1))
        if (Trig_Counter_Func002Func003C()) then
            udg_IntMinutes = 0
            udg_IntHours = (__jint(udg_IntHours + 1))
        else
        end
    else
    end
    if (Trig_Counter_Func003C()) then
        udg_StringSeconds = "0"
    else
        udg_StringSeconds = ""
    end
    if (Trig_Counter_Func004C()) then
        udg_StringMinutes = "0"
    else
        udg_StringMinutes = ""
    end
    udg_Counterstring = (__jconcat((__jconcat((__jconcat("|cffe6cd00", (__jconcat(I2S(udg_IntHours), ":")))), (__jconcat((__jconcat(udg_StringMinutes, I2S(udg_IntMinutes))), ":")))), (__jconcat((__jconcat(udg_StringSeconds, I2S(udg_IntSeconds))), "|r"))))
    CreateMultiboardBJ(1, 1, (__jconcat((__jconcat("Information  -  ", (__jconcat("|cffcdcd00[|r ", (__jconcat((__jconcat(udg_TreeChopper, " ")), (__jconcat(udg_Tradeoff, "|cffcdcd00 ]  -  |r")))))))), udg_Counterstring)))
end

-- Original JASS function: InitTrig_Counter (line 4930)
function InitTrig_Counter()
    gg_trg_Counter = CreateTrigger()
    DisableTrigger(gg_trg_Counter)
    TriggerRegisterTimerEventPeriodic(gg_trg_Counter, __jreal(1.00))
    TriggerAddAction(gg_trg_Counter, Trig_Counter_Actions)
end
-- END FOREST SECTION 10
-- END FOREST MODULE src/game/clock.lua

-- BEGIN FOREST MODULE src/commands/trade.lua
-- commands / trade
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 11 Tradeoff_Detection
-- Original JASS function: Trig_Tradeoff_Detection_Actions (line 4942)
function Trig_Tradeoff_Detection_Actions()
    udg_Tradeoff = "|cffb79419-tradeoff|r"
end

-- Original JASS function: InitTrig_Tradeoff_Detection (line 4947)
function InitTrig_Tradeoff_Detection()
    gg_trg_Tradeoff_Detection = CreateTrigger()
    FE_Roles.registerAncientChatEvent(gg_trg_Tradeoff_Detection, "-tradeoff", true)
    TriggerAddAction(gg_trg_Tradeoff_Detection, Trig_Tradeoff_Detection_Actions)
end
-- END FOREST SECTION 11

-- BEGIN FOREST SECTION 266 Trade_disabled
-- Original JASS function: Trig_Trade_disabled_Actions (line 16075)
function Trig_Trade_disabled_Actions()
    SetMapFlag(MAP_LOCK_RESOURCE_TRADING, true)
    DisableTrigger(gg_trg_Resource_Hint)
end

-- Original JASS function: InitTrig_Trade_disabled (line 16081)
function InitTrig_Trade_disabled()
    gg_trg_Trade_disabled = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_Trade_disabled, __jreal(0.10))
    TriggerAddAction(gg_trg_Trade_disabled, Trig_Trade_disabled_Actions)
end
-- END FOREST SECTION 266

-- BEGIN FOREST SECTION 267 Trade_enabled
-- Original JASS function: Trig_Trade_enabled_Actions (line 16090)
function Trig_Trade_enabled_Actions()
    SetMapFlag(MAP_LOCK_RESOURCE_TRADING, false)
    EnableTrigger(gg_trg_Resource_Hint)
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_3366")
end

-- Original JASS function: InitTrig_Trade_enabled (line 16097)
function InitTrig_Trade_enabled()
    gg_trg_Trade_enabled = CreateTrigger()
    FE_Roles.registerAncientChatEvent(gg_trg_Trade_enabled, "-tradeon", true)
    TriggerAddAction(gg_trg_Trade_enabled, Trig_Trade_enabled_Actions)
end
-- END FOREST SECTION 267

-- BEGIN FOREST SECTION 268 Disable_trade_enabled
-- Original JASS function: Trig_Disable_trade_enabled_Actions (line 16106)
function Trig_Disable_trade_enabled_Actions()
    DisableTrigger(gg_trg_Trade_disabled)
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_3665")
end

-- Original JASS function: InitTrig_Disable_trade_enabled (line 16112)
function InitTrig_Disable_trade_enabled()
    gg_trg_Disable_trade_enabled = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_Disable_trade_enabled, __jreal(80.00))
    TriggerAddAction(gg_trg_Disable_trade_enabled, Trig_Disable_trade_enabled_Actions)
end
-- END FOREST SECTION 268
-- END FOREST MODULE src/commands/trade.lua

-- BEGIN FOREST MODULE src/game/tree_chopper.lua
-- game / tree_chopper
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 12 TreeChopper_Detection
-- Original JASS function: Trig_TreeChopper_Detection_Actions (line 4958)
function Trig_TreeChopper_Detection_Actions()
    CreateNUnitsAtLoc(1, FourCC("h060"), FE_Roles.ancient(), GetRectCenter(gg_rct_ChopChop), bj_UNIT_FACING)
    udg_TreeChopper = "|cffb79419-chopoff|r"
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_5530")
end

-- Original JASS function: InitTrig_TreeChopper_Detection (line 4965)
function InitTrig_TreeChopper_Detection()
    gg_trg_TreeChopper_Detection = CreateTrigger()
    TriggerRegisterPlayerChatEvent(gg_trg_TreeChopper_Detection, Player(0), "-chopchop", true)
    TriggerAddAction(gg_trg_TreeChopper_Detection, Trig_TreeChopper_Detection_Actions)
end
-- END FOREST SECTION 12
-- END FOREST MODULE src/game/tree_chopper.lua

-- BEGIN FOREST MODULE src/players/participation.lua
-- players / participation
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 13 Takeover
-- Original JASS function: Trig_Takeover_MaxPlayerSlots (line 4974)
function Trig_Takeover_MaxPlayerSlots()
    do return 11 end
end

-- Original JASS function: Trig_Takeover_AncientHasController (line 4978)
function Trig_Takeover_AncientHasController(ancient)
    if (ancient == nil) then
        do return false end
    end
    if (GetPlayerSlotState(ancient) ~= PLAYER_SLOT_STATE_PLAYING) then
        do return false end
    end
    if (GetPlayerController(ancient) == MAP_CONTROL_USER) then
        do return true end
    end
    if (GetPlayerController(ancient) == MAP_CONTROL_COMPUTER) then
        do return true end
    end
    do return false end
end

-- Original JASS function: Trig_Takeover_RemoveAllUnitsOfPlayer (line 4998)
function Trig_Takeover_RemoveAllUnitsOfPlayer(whichPlayer)
    local g = CreateGroup()
    local u = nil
    GroupEnumUnitsOfPlayer(g, whichPlayer, nil)
    while true do
        u = FirstOfGroup(g)
        if (u == nil) then break end
        GroupRemoveUnit(g, u)
        RemoveUnit(u)
    end
    DestroyGroup(g)
    u = nil
    g = nil
end

-- Original JASS function: Trig_Takeover_TransferAllUnits (line 5016)
function Trig_Takeover_TransferAllUnits(oldOwner, newOwner)
    local g = CreateGroup()
    local u = nil
    GroupEnumUnitsOfPlayer(g, oldOwner, nil)
    while true do
        u = FirstOfGroup(g)
        if (u == nil) then break end
        GroupRemoveUnit(g, u)
        SetUnitOwner(u, newOwner, true)
    end
    DestroyGroup(g)
    u = nil
    g = nil
end

-- Original JASS function: Trig_Takeover_SetAllianceBothWays (line 5034)
function Trig_Takeover_SetAllianceBothWays(a, b, allied)
    SetPlayerAlliance(a, b, ALLIANCE_PASSIVE, allied)
    SetPlayerAlliance(b, a, ALLIANCE_PASSIVE, allied)
    SetPlayerAlliance(a, b, ALLIANCE_HELP_REQUEST, allied)
    SetPlayerAlliance(b, a, ALLIANCE_HELP_REQUEST, allied)
    SetPlayerAlliance(a, b, ALLIANCE_HELP_RESPONSE, allied)
    SetPlayerAlliance(b, a, ALLIANCE_HELP_RESPONSE, allied)
    SetPlayerAlliance(a, b, ALLIANCE_SHARED_XP, allied)
    SetPlayerAlliance(b, a, ALLIANCE_SHARED_XP, allied)
    SetPlayerAlliance(a, b, ALLIANCE_SHARED_SPELLS, allied)
    SetPlayerAlliance(b, a, ALLIANCE_SHARED_SPELLS, allied)
    SetPlayerAlliance(a, b, ALLIANCE_SHARED_VISION, allied)
    SetPlayerAlliance(b, a, ALLIANCE_SHARED_VISION, allied)
    SetPlayerAlliance(a, b, ALLIANCE_SHARED_CONTROL, false)
    SetPlayerAlliance(b, a, ALLIANCE_SHARED_CONTROL, false)
    SetPlayerAlliance(a, b, ALLIANCE_SHARED_ADVANCED_CONTROL, false)
    SetPlayerAlliance(b, a, ALLIANCE_SHARED_ADVANCED_CONTROL, false)
    SetPlayerAlliance(a, b, ALLIANCE_RESCUABLE, false)
    SetPlayerAlliance(b, a, ALLIANCE_RESCUABLE, false)
    SetPlayerAlliance(a, b, ALLIANCE_SHARED_VISION_FORCED, false)
    SetPlayerAlliance(b, a, ALLIANCE_SHARED_VISION_FORCED, false)
end

-- Original JASS function: Trig_Takeover_InvertTakerAlliances (line 5057)
function Trig_Takeover_InvertTakerAlliances(taker)
    local i = 0
    local p = nil
    local wasAlly = false
    while true do
        if (i >= (11)) then break end
        p = Player(i)
        if (p ~= taker) then
            wasAlly = GetPlayerAlliance(taker, p, ALLIANCE_PASSIVE)
            if wasAlly then
                Trig_Takeover_SetAllianceBothWays(taker, p, false)
            else
                Trig_Takeover_SetAllianceBothWays(taker, p, true)
            end
        end
        i = __jint(i + 1)
    end
    p = nil
end

-- Original JASS function: Trig_Takeover_ShouldInvertAlliances (line 5082)
function Trig_Takeover_ShouldInvertAlliances(oldAncient, taker)
    if GetPlayerAlliance(taker, oldAncient, ALLIANCE_PASSIVE) then
        do return false end
    end
    if GetPlayerAlliance(oldAncient, taker, ALLIANCE_PASSIVE) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Takeover_CopyAncientResources (line 5094)
function Trig_Takeover_CopyAncientResources(oldAncient, newAncient)
    SetPlayerState(newAncient, PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(oldAncient, PLAYER_STATE_RESOURCE_GOLD))
    SetPlayerState(newAncient, PLAYER_STATE_RESOURCE_LUMBER, GetPlayerState(oldAncient, PLAYER_STATE_RESOURCE_LUMBER))
end

-- Original JASS function: Trig_Takeover_Actions (line 5099)
function Trig_Takeover_Actions()
    local taker = GetTriggerPlayer()
    local oldAncient = FE_Roles.ancient()
    if (oldAncient == nil) then
        DisplayTextToPlayer(taker, __jreal(0.00), __jreal(0.00), "|cffff2020Takeover failed: AncientPlayer is not set.|r")
        taker = nil
        oldAncient = nil
        do return end
    end
    if Trig_Takeover_AncientHasController(oldAncient) then
        DisplayTextToPlayer(taker, __jreal(0.00), __jreal(0.00), "|cffff2020Takeover failed: Ancient still has an active player or AI controller.|r")
        taker = nil
        oldAncient = nil
        do return end
    end
    Trig_Takeover_RemoveAllUnitsOfPlayer(taker)
    Trig_Takeover_CopyAncientResources(oldAncient, taker)
    if Trig_Takeover_ShouldInvertAlliances(oldAncient, taker) then
        Trig_Takeover_InvertTakerAlliances(taker)
    end
    FE_Roles.setAncient(taker)
    Trig_Takeover_TransferAllUnits(oldAncient, taker)
    DisplayTimedTextToForce(GetPlayersAll(), __jreal(20.00), __jconcat(__jconcat("|cffffcc00", GetPlayerName(taker)), " has taken over Ancient because the previous Ancient has no active controller.|r"))
    taker = nil
    oldAncient = nil
end

-- Original JASS function: InitTrig_Takeover (line 5134)
function InitTrig_Takeover()
    local i = 0
    gg_trg_Takeover = CreateTrigger()
    while true do
        if (i >= (11)) then break end
        TriggerRegisterPlayerChatEvent(gg_trg_Takeover, Player(i), "-takeover", true)
        i = __jint(i + 1)
    end
    TriggerAddAction(gg_trg_Takeover, Trig_Takeover_Actions)
end
-- END FOREST SECTION 13

-- BEGIN FOREST SECTION 316 Player_group
-- Original JASS function: Trig_Player_group_Func001002 (line 17980)
function Trig_Player_group_Func001002()
    ForceAddPlayerSimple(GetEnumPlayer(), FE_Roster.expanderForce())
end

-- Original JASS function: Trig_Player_group_Func003002001001 (line 17984)
function Trig_Player_group_Func003002001001()
    do return ((GetPlayerSlotState(GetFilterPlayer()) == PLAYER_SLOT_STATE_PLAYING)) end
end

-- Original JASS function: Trig_Player_group_Func004C (line 17988)
function Trig_Player_group_Func004C()
    if ((not ((GetPlayerSlotState(FE_Roles.ancient()) == PLAYER_SLOT_STATE_PLAYING)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Player_group_Actions (line 17995)
function Trig_Player_group_Actions()
    FE_Roster.initialize()
    DisplayTextToForce(GetPlayersAll(), "Loaded " .. I2S(udg_StillAlive) .. " expanders")
end

-- Original JASS function: InitTrig_Player_group (line 18007)
function InitTrig_Player_group()
    gg_trg_Player_group = CreateTrigger()
    TriggerAddAction(gg_trg_Player_group, Trig_Player_group_Actions)
end
-- END FOREST SECTION 316
-- END FOREST MODULE src/players/participation.lua

-- BEGIN FOREST MODULE src/game/overdrive.lua
-- game / overdrive
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 14 Enable_Overdrive
-- Original JASS function: Trig_Enable_Overdrive_Func004C (line 5152)
function Trig_Enable_Overdrive_Func004C()
    if ((not ((GetUnitTypeId(GetSpellAbilityUnit()) == FourCC("n011"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Enable_Overdrive_Conditions (line 5159)
function Trig_Enable_Overdrive_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A0CY"))))) then
        do return false end
    end
    if ((not Trig_Enable_Overdrive_Func004C())) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Enable_Overdrive_Actions (line 5169)
function Trig_Enable_Overdrive_Actions()
    SetPlayerTechResearchedSwap(FourCC("R06X"), 1, GetOwningPlayer(GetSpellAbilityUnit()))
    AdjustPlayerStateBJ(10000, GetOwningPlayer(GetSpellAbilityUnit()), PLAYER_STATE_RESOURCE_LUMBER)
end

-- Original JASS function: InitTrig_Enable_Overdrive (line 5175)
function InitTrig_Enable_Overdrive()
    gg_trg_Enable_Overdrive = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Enable_Overdrive, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Enable_Overdrive, Condition(Trig_Enable_Overdrive_Conditions))
    TriggerAddAction(gg_trg_Enable_Overdrive, Trig_Enable_Overdrive_Actions)
end
-- END FOREST SECTION 14

-- BEGIN FOREST SECTION 15 Disable_Overdrive
-- Original JASS function: Trig_Disable_Overdrive_Func003C (line 5185)
function Trig_Disable_Overdrive_Func003C()
    if ((not ((GetUnitTypeId(GetSpellAbilityUnit()) == FourCC("n011"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Disable_Overdrive_Conditions (line 5192)
function Trig_Disable_Overdrive_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A0CZ"))))) then
        do return false end
    end
    if ((not Trig_Disable_Overdrive_Func003C())) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Disable_Overdrive_Actions (line 5202)
function Trig_Disable_Overdrive_Actions()
    SetPlayerTechResearchedSwap(FourCC("R06X"), 0, GetOwningPlayer(GetSpellAbilityUnit()))
end

-- Original JASS function: InitTrig_Disable_Overdrive (line 5207)
function InitTrig_Disable_Overdrive()
    gg_trg_Disable_Overdrive = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Disable_Overdrive, EVENT_PLAYER_UNIT_SPELL_CAST)
    TriggerAddCondition(gg_trg_Disable_Overdrive, Condition(Trig_Disable_Overdrive_Conditions))
    TriggerAddAction(gg_trg_Disable_Overdrive, Trig_Disable_Overdrive_Actions)
end
-- END FOREST SECTION 15

-- BEGIN FOREST SECTION 16 Death
-- Original JASS function: Trig_Death_Conditions (line 5217)
function Trig_Death_Conditions()
    if ((not ((GetUnitTypeId(GetDyingUnit()) == FourCC("n011"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Death_Actions (line 5224)
function Trig_Death_Actions()
    SetPlayerTechResearchedSwap(FourCC("R06X"), 0, GetOwningPlayer(GetDyingUnit()))
end

-- Original JASS function: InitTrig_Death (line 5229)
function InitTrig_Death()
    gg_trg_Death = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Death, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Death, Condition(Trig_Death_Conditions))
    TriggerAddAction(gg_trg_Death, Trig_Death_Actions)
end
-- END FOREST SECTION 16
-- END FOREST MODULE src/game/overdrive.lua

-- BEGIN FOREST MODULE src/commands/player.lua
-- commands / player
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 17 Hardmode
-- Original JASS function: Hardmode_GiveResources (line 5240)
function Hardmode_GiveResources()
    local i = 0
    local p = nil
    if (FE_Roles.ancient() == nil) then
        do return end
    end
    while true do
        if (i >= bj_MAX_PLAYERS) then break end
        p = Player(i)
        if ((GetPlayerSlotState(p) == PLAYER_SLOT_STATE_PLAYING) and IsPlayerEnemy(p, FE_Roles.ancient())) then
            SetPlayerState(p, PLAYER_STATE_RESOURCE_GOLD, __jint(GetPlayerState(p, PLAYER_STATE_RESOURCE_GOLD) + 1))
            SetPlayerState(p, PLAYER_STATE_RESOURCE_LUMBER, __jint(GetPlayerState(p, PLAYER_STATE_RESOURCE_LUMBER) + 50))
        end
        i = __jint(i + 1)
    end
    p = nil
end

-- Original JASS function: Hardmode_PlayActivationIndicator (line 5263)
function Hardmode_PlayActivationIndicator()
    DisplayTimedTextToPlayer(GetLocalPlayer(), __jreal(0.00), __jreal(0.00), __jreal(10.00), "|cffffcc00Ancient activated hardmode.|r Expanders will now receive extra |cff80ff8050 lumber|r and |cffffff001 gold|r every 6 seconds after ancient spawn.")
    if (udg_HardmodeSound ~= nil) then
        SetSoundVolume(udg_HardmodeSound, 127)
        StartSound(udg_HardmodeSound)
    end
end

-- Original JASS function: Hardmode_Start (line 5272)
function Hardmode_Start()
    local t = GetExpiredTimer()
    udg_HardmodeCanBeEnabled = false
    PauseTimer(t)
    DestroyTimer(t)
    if udg_HardmodeEnabled then
        Hardmode_GiveResources()
        udg_HardmodePeriodicTimer = CreateTimer()
        TimerStart(udg_HardmodePeriodicTimer, __jreal(6.00), true, Hardmode_GiveResources)
    end
    t = nil
end

-- Original JASS function: Hardmode_Chat (line 5290)
function Hardmode_Chat()
    if (udg_HardmodeCanBeEnabled and (GetTriggerPlayer() == FE_Roles.ancient())) then
        if (not udg_HardmodeEnabled) then
            udg_HardmodeEnabled = true
            Hardmode_PlayActivationIndicator()
        end
    end
end

-- Original JASS function: InitTrig_Hardmode (line 5299)
function InitTrig_Hardmode()
    local i = 0
    local t = CreateTrigger()
    local tm = CreateTimer()
    while true do
        if (i >= bj_MAX_PLAYERS) then break end
        TriggerRegisterPlayerChatEvent(t, Player(i), "-hardmode", true)
        i = __jint(i + 1)
    end
    TriggerAddAction(t, Hardmode_Chat)
    udg_HardmodeSound = CreateSound(HARDMODE_SOUND_PATH, false, false, false, 10, 10, "HeroAcksEAX")
    SetSoundVolume(udg_HardmodeSound, 127)
    TimerStart(tm, __jreal(60.00), false, Hardmode_Start)
    t = nil
    tm = nil
end
-- END FOREST SECTION 17

-- BEGIN FOREST SECTION 205 AncientSpells
-- Original JASS function: Ancient_ReplaceAll (line 12991)
function Ancient_ReplaceAll(source, findText, replaceText)
    local result = ""
    local sourceLength = 0
    local findLength = 0
    local i = 0
    if (source == nil) then
        do return "" end
    end
    sourceLength = StringLength(source)
    findLength = StringLength(findText)
    if (findLength <= 0) then
        do return source end
    end
    while true do
        if (i >= sourceLength) then break end
        if ((__jint(i + findLength) <= sourceLength) and (SubString(source, i, __jint(i + findLength)) == findText)) then
            result = __jconcat(result, replaceText)
            i = __jint(i + findLength)
        else
            result = __jconcat(result, SubString(source, i, __jint(i + 1)))
            i = __jint(i + 1)
        end
    end
    do return result end
end

-- Original JASS function: Ancient_CollapseSpaces (line 13023)
function Ancient_CollapseSpaces(source)
    local result = ""
    local length = 0
    local i = 0
    local c = nil
    local lastWasSpace = false
    if (source == nil) then
        do return "" end
    end
    length = StringLength(source)
    while true do
        if (i >= length) then break end
        c = SubString(source, i, __jint(i + 1))
        if (c == " ") then
            if (not lastWasSpace) then
                result = __jconcat(result, c)
            end
            lastWasSpace = true
        else
            result = __jconcat(result, c)
            lastWasSpace = false
        end
        i = __jint(i + 1)
    end
    do return result end
end

-- Original JASS function: Ancient_IsHexChar (line 13057)
function Ancient_IsHexChar(c)
    do return ((((((((((((((((((((((c == "0") or (c == "1")) or (c == "2")) or (c == "3")) or (c == "4")) or (c == "5")) or (c == "6")) or (c == "7")) or (c == "8")) or (c == "9")) or (c == "a")) or (c == "b")) or (c == "c")) or (c == "d")) or (c == "e")) or (c == "f")) or (c == "A")) or (c == "B")) or (c == "C")) or (c == "D")) or (c == "E")) or (c == "F")) end
end

-- Original JASS function: Ancient_RemoveColorCodes (line 13061)
function Ancient_RemoveColorCodes(source)
    local result = ""
    local length = 0
    local i = 0
    local c = nil
    if (source == nil) then
        do return "" end
    end
    length = StringLength(source)
    while true do
        if (i >= length) then break end
        c = SubString(source, i, __jint(i + 1))
        if (((((((((((__jint(i + 10) <= length) and (c == "|")) and (SubString(source, __jint(i + 1), __jint(i + 2)) == "c")) and Ancient_IsHexChar(SubString(source, __jint(i + 2), __jint(i + 3)))) and Ancient_IsHexChar(SubString(source, __jint(i + 3), __jint(i + 4)))) and Ancient_IsHexChar(SubString(source, __jint(i + 4), __jint(i + 5)))) and Ancient_IsHexChar(SubString(source, __jint(i + 5), __jint(i + 6)))) and Ancient_IsHexChar(SubString(source, __jint(i + 6), __jint(i + 7)))) and Ancient_IsHexChar(SubString(source, __jint(i + 7), __jint(i + 8)))) and Ancient_IsHexChar(SubString(source, __jint(i + 8), __jint(i + 9)))) and Ancient_IsHexChar(SubString(source, __jint(i + 9), __jint(i + 10)))) then
            i = __jint(i + 10)
        elseif (((((((((((__jint(i + 10) <= length) and (c == "|")) and (SubString(source, __jint(i + 1), __jint(i + 2)) == "C")) and Ancient_IsHexChar(SubString(source, __jint(i + 2), __jint(i + 3)))) and Ancient_IsHexChar(SubString(source, __jint(i + 3), __jint(i + 4)))) and Ancient_IsHexChar(SubString(source, __jint(i + 4), __jint(i + 5)))) and Ancient_IsHexChar(SubString(source, __jint(i + 5), __jint(i + 6)))) and Ancient_IsHexChar(SubString(source, __jint(i + 6), __jint(i + 7)))) and Ancient_IsHexChar(SubString(source, __jint(i + 7), __jint(i + 8)))) and Ancient_IsHexChar(SubString(source, __jint(i + 8), __jint(i + 9)))) and Ancient_IsHexChar(SubString(source, __jint(i + 9), __jint(i + 10)))) then
            i = __jint(i + 10)
        elseif (((__jint(i + 2) <= length) and (c == "|")) and (SubString(source, __jint(i + 1), __jint(i + 2)) == "r")) then
            i = __jint(i + 2)
        elseif (((__jint(i + 2) <= length) and (c == "|")) and (SubString(source, __jint(i + 1), __jint(i + 2)) == "R")) then
            i = __jint(i + 2)
        else
            result = __jconcat(result, c)
            i = __jint(i + 1)
        end
    end
    do return result end
end

-- Original JASS function: Ancient_RemoveSquareBracketBlocks (line 13095)
function Ancient_RemoveSquareBracketBlocks(source)
    local result = ""
    local length = 0
    local i = 0
    local c = nil
    local insideBracket = false
    if (source == nil) then
        do return "" end
    end
    length = StringLength(source)
    while true do
        if (i >= length) then break end
        c = SubString(source, i, __jint(i + 1))
        if (c == "[") then
            insideBracket = true
        elseif (c == "]") then
            insideBracket = false
        elseif (not insideBracket) then
            result = __jconcat(result, c)
        end
        i = __jint(i + 1)
    end
    do return Ancient_CollapseSpaces(result) end
end

-- Original JASS function: Ancient_CleanTrailingSeparators (line 13127)
function Ancient_CleanTrailingSeparators(source)
    local length = 0
    if (source == nil) then
        do return "" end
    end
    source = Ancient_CollapseSpaces(source)
    length = StringLength(source)
    while true do
        if (length <= 0) then break end
        if (SubString(source, __jint(length - 1), length) == " ") then
            source = SubString(source, 0, __jint(length - 1))
        elseif (SubString(source, __jint(length - 1), length) == "-") then
            source = SubString(source, 0, __jint(length - 1))
        elseif (SubString(source, __jint(length - 1), length) == ":") then
            source = SubString(source, 0, __jint(length - 1))
        else
            do return source end
        end
        source = Ancient_CollapseSpaces(source)
        length = StringLength(source)
    end
    do return source end
end

-- Original JASS function: Ancient_FormatTooltipText (line 13157)
function Ancient_FormatTooltipText(text, level)
    if (text == nil) then
        do return "" end
    end
    text = Ancient_ReplaceAll(text, "|n", " ")
    text = Ancient_ReplaceAll(text, "|N", " ")
    text = Ancient_ReplaceAll(text, "\n", " ")
    text = Ancient_ReplaceAll(text, "/n", " ")
    text = Ancient_ReplaceAll(text, "/N", " ")
    text = Ancient_ReplaceAll(text, "%d", I2S(level))
    text = Ancient_CollapseSpaces(text)
    do return text end
end

-- Original JASS function: Ancient_ClearMessagesForPlayer (line 13173)
function Ancient_ClearMessagesForPlayer(p)
    if (GetLocalPlayer() == p) then
        ClearTextMessages()
    end
end

-- Original JASS function: Ancient_IsCommand (line 13179)
function Ancient_IsCommand(chat)
    local s = StringCase(chat, false)
    local len = StringLength(s)
    if (len < 8) then
        do return false end
    end
    if (SubString(s, 0, 8) ~= "-ancient") then
        do return false end
    end
    if (len == 8) then
        do return true end
    end
    do return (SubString(s, 8, 9) == " ") end
end

-- Original JASS function: Ancient_GetArgumentText (line 13198)
function Ancient_GetArgumentText(chat)
    local len = StringLength(chat)
    local i = 8
    while true do
        if ((i >= len) or (SubString(chat, i, __jint(i + 1)) ~= " ")) then break end
        i = __jint(i + 1)
    end
    if (i >= len) then
        do return "" end
    end
    do return SubString(chat, i, len) end
end

-- Original JASS function: Ancient_GetFirstWord (line 13214)
function Ancient_GetFirstWord(text)
    local len = StringLength(text)
    local i = 0
    local start = 0
    while true do
        if ((i >= len) or (SubString(text, i, __jint(i + 1)) ~= " ")) then break end
        i = __jint(i + 1)
    end
    start = i
    while true do
        if ((i >= len) or (SubString(text, i, __jint(i + 1)) == " ")) then break end
        i = __jint(i + 1)
    end
    if (start >= len) then
        do return "" end
    end
    do return SubString(text, start, i) end
end

-- Original JASS function: Ancient_GetTextAfterFirstWord (line 13238)
function Ancient_GetTextAfterFirstWord(text)
    local len = StringLength(text)
    local i = 0
    while true do
        if ((i >= len) or (SubString(text, i, __jint(i + 1)) ~= " ")) then break end
        i = __jint(i + 1)
    end
    while true do
        if ((i >= len) or (SubString(text, i, __jint(i + 1)) == " ")) then break end
        i = __jint(i + 1)
    end
    while true do
        if ((i >= len) or (SubString(text, i, __jint(i + 1)) ~= " ")) then break end
        i = __jint(i + 1)
    end
    if (i >= len) then
        do return "" end
    end
    do return SubString(text, i, len) end
end

-- Original JASS function: Ancient_GetUnitTypeIdByKeyword (line 13264)
function Ancient_GetUnitTypeIdByKeyword(keyword)
    if ((keyword == "darkness") or (keyword == "paranoia")) then
        do return FourCC("O00A") end
    elseif ((((keyword == "dragon") or (keyword == "dragons")) or (keyword == "dragos")) or (keyword == "drago")) then
        do return FourCC("O00S") end
    elseif ((keyword == "earth") or (keyword == "tremor")) then
        do return FourCC("O00L") end
    elseif ((keyword == "fire") or (keyword == "ignite")) then
        do return FourCC("O004") end
    elseif (((keyword == "ice") or (keyword == "avalanche")) or (keyword == "avalanch")) then
        do return FourCC("O008") end
    elseif ((keyword == "light") or (keyword == "divinity")) then
        do return FourCC("O01V") end
    elseif (((keyword == "lightning") or (keyword == "lighting")) or (keyword == "zalxon")) then
        do return FourCC("O016") end
    elseif ((keyword == "nature") or (keyword == "eternity")) then
        do return FourCC("O00D") end
    elseif (((keyword == "sand") or (keyword == "pharaoh")) or (keyword == "pharaon")) then
        do return FourCC("O01X") end
    elseif ((keyword == "space") or (keyword == "nebula")) then
        do return FourCC("O01Z") end
    elseif (((((keyword == "wind") or (keyword == "wispari")) or (keyword == "whispari")) or (keyword == "whisperi")) or (keyword == "wisperi")) then
        do return FourCC("O01D") end
    end
    do return 0 end
end

-- Original JASS function: Ancient_GetUnitTypeDisplayName (line 13292)
function Ancient_GetUnitTypeDisplayName(unitTypeId)
    if (unitTypeId == FourCC("O00A")) then
        do return "Darkness / Paranoia" end
    elseif (unitTypeId == FourCC("O00S")) then
        do return "Dragon" end
    elseif (unitTypeId == FourCC("O00L")) then
        do return "Earth / Tremor" end
    elseif (unitTypeId == FourCC("O004")) then
        do return "Fire / Ignite" end
    elseif (unitTypeId == FourCC("O008")) then
        do return "Ice / Avalanche" end
    elseif (unitTypeId == FourCC("O01V")) then
        do return "Light / Divinity" end
    elseif (unitTypeId == FourCC("O016")) then
        do return "Lightning / Zalxon" end
    elseif (unitTypeId == FourCC("O00D")) then
        do return "Nature / Eternity" end
    elseif (unitTypeId == FourCC("O01X")) then
        do return "Sand / Pharaoh" end
    elseif (unitTypeId == FourCC("O01Z")) then
        do return "Space / Nebula" end
    elseif (unitTypeId == FourCC("O01D")) then
        do return "Wind / Wispari" end
    end
    do return "Unknown Ancient" end
end

-- Original JASS function: Ancient_ParsePageFromArgument (line 13320)
function Ancient_ParsePageFromArgument(argument)
    local lowerArgument = StringCase(argument, false)
    local firstWord = Ancient_GetFirstWord(lowerArgument)
    local rest = nil
    local page = 0
    if (Ancient_GetUnitTypeIdByKeyword(firstWord) ~= 0) then
        rest = Ancient_GetTextAfterFirstWord(lowerArgument)
        page = S2I(Ancient_GetFirstWord(rest))
    else
        page = S2I(firstWord)
    end
    if (page < 1) then
        page = 1
    end
    do return page end
end

-- Original JASS function: Ancient_ShowPreviewUsage (line 13340)
function Ancient_ShowPreviewUsage(p)
    Ancient_ClearMessagesForPlayer(p)
    DisplayTimedTextToPlayer(p, __jreal(0.00), __jreal(0.00), __jreal(20.00), "|cffffcc00Ancient preview:|r |cffffffffUse |r|cffffcc00-ancient darkness|r|cffffffff, |r|cffffcc00-ancient dragon|r|cffffffff, |r|cffffcc00-ancient earth|r|cffffffff, |r|cffffcc00-ancient fire|r|cffffffff, |r|cffffcc00-ancient ice|r|cffffffff, |r|cffffcc00-ancient light|r|cffffffff, |r|cffffcc00-ancient lightning|r|cffffffff, |r|cffffcc00-ancient nature|r|cffffffff, |r|cffffcc00-ancient sand|r|cffffffff, |r|cffffcc00-ancient space|r|cffffffff, or |r|cffffcc00-ancient wind|r|cffffffff. Add page number after the name if needed, for example |r|cffffcc00-ancient darkness 2|r|cffffffff.|r")
end

-- Original JASS function: Ancient_GetAbilityCount (line 13345)
function Ancient_GetAbilityCount(unitTypeId)
    if (unitTypeId == FourCC("O016")) then
        do return 6 end
    end
    if (unitTypeId == FourCC("O00A")) then
        do return 5 end
    elseif (unitTypeId == FourCC("O00S")) then
        do return 5 end
    elseif (unitTypeId == FourCC("O00L")) then
        do return 5 end
    elseif (unitTypeId == FourCC("O004")) then
        do return 5 end
    elseif (unitTypeId == FourCC("O008")) then
        do return 5 end
    elseif (unitTypeId == FourCC("O01V")) then
        do return 5 end
    elseif (unitTypeId == FourCC("O00D")) then
        do return 5 end
    elseif (unitTypeId == FourCC("O01X")) then
        do return 5 end
    elseif (unitTypeId == FourCC("O01Z")) then
        do return 5 end
    elseif (unitTypeId == FourCC("O01D")) then
        do return 5 end
    end
    do return 0 end
end

-- Original JASS function: Ancient_GetAbilityIdByIndex (line 13375)
function Ancient_GetAbilityIdByIndex(unitTypeId, index)
    if (unitTypeId == FourCC("O00A")) then
        if (index == 1) then
            do return FourCC("A0E9") end
        elseif (index == 2) then
            do return FourCC("A05F") end
        elseif (index == 3) then
            do return FourCC("A058") end
        elseif (index == 4) then
            do return FourCC("A05C") end
        elseif (index == 5) then
            do return FourCC("A05E") end
        end
    elseif (unitTypeId == FourCC("O00S")) then
        if (index == 1) then
            do return FourCC("A02B") end
        elseif (index == 2) then
            do return FourCC("A06P") end
        elseif (index == 3) then
            do return FourCC("A02A") end
        elseif (index == 4) then
            do return FourCC("A01J") end
        elseif (index == 5) then
            do return FourCC("A02D") end
        end
    elseif (unitTypeId == FourCC("O00L")) then
        if (index == 1) then
            do return FourCC("A06D") end
        elseif (index == 2) then
            do return FourCC("A088") end
        elseif (index == 3) then
            do return FourCC("A05Q") end
        elseif (index == 4) then
            do return FourCC("A01T") end
        elseif (index == 5) then
            do return FourCC("A06F") end
        end
    elseif (unitTypeId == FourCC("O004")) then
        if (index == 1) then
            do return FourCC("A002") end
        elseif (index == 2) then
            do return FourCC("A000") end
        elseif (index == 3) then
            do return FourCC("A07A") end
        elseif (index == 4) then
            do return FourCC("A003") end
        elseif (index == 5) then
            do return FourCC("A004") end
        end
    elseif (unitTypeId == FourCC("O008")) then
        if (index == 1) then
            do return FourCC("A008") end
        elseif (index == 2) then
            do return FourCC("A0EX") end
        elseif (index == 3) then
            do return FourCC("A074") end
        elseif (index == 4) then
            do return FourCC("A00A") end
        elseif (index == 5) then
            do return FourCC("A075") end
        end
    elseif (unitTypeId == FourCC("O01V")) then
        if (index == 1) then
            do return FourCC("A06X") end
        elseif (index == 2) then
            do return FourCC("A06W") end
        elseif (index == 3) then
            do return FourCC("A06V") end
        elseif (index == 4) then
            do return FourCC("A06U") end
        elseif (index == 5) then
            do return FourCC("A06Y") end
        end
    elseif (unitTypeId == FourCC("O016")) then
        if (index == 1) then
            do return FourCC("A03U") end
        elseif (index == 2) then
            do return FourCC("A09L") end
        elseif (index == 3) then
            do return FourCC("A03R") end
        elseif (index == 4) then
            do return FourCC("A07B") end
        elseif (index == 5) then
            do return FourCC("A03S") end
        elseif (index == 6) then
            do return FourCC("A03T") end
        end
    elseif (unitTypeId == FourCC("O00D")) then
        if (index == 1) then
            do return FourCC("A01M") end
        elseif (index == 2) then
            do return FourCC("A012") end
        elseif (index == 3) then
            do return FourCC("A070") end
        elseif (index == 4) then
            do return FourCC("A06Z") end
        elseif (index == 5) then
            do return FourCC("A013") end
        end
    elseif (unitTypeId == FourCC("O01X")) then
        if (index == 1) then
            do return FourCC("A07Y") end
        elseif (index == 2) then
            do return FourCC("A07X") end
        elseif (index == 3) then
            do return FourCC("A07Z") end
        elseif (index == 4) then
            do return FourCC("A080") end
        elseif (index == 5) then
            do return FourCC("A082") end
        end
    elseif (unitTypeId == FourCC("O01Z")) then
        if (index == 1) then
            do return FourCC("A08R") end
        elseif (index == 2) then
            do return FourCC("A08I") end
        elseif (index == 3) then
            do return FourCC("A08K") end
        elseif (index == 4) then
            do return FourCC("A0F1") end
        elseif (index == 5) then
            do return FourCC("A08S") end
        end
    elseif (unitTypeId == FourCC("O01D")) then
        if (index == 1) then
            do return FourCC("A0EL") end
        elseif (index == 2) then
            do return FourCC("A0EO") end
        elseif (index == 3) then
            do return FourCC("A0EP") end
        elseif (index == 4) then
            do return FourCC("A0ES") end
        elseif (index == 5) then
            do return FourCC("A048") end
        end
    end
    do return 0 end
end

-- Original JASS function: Ancient_GetSingleAbilityLine (line 13515)
function Ancient_GetSingleAbilityLine(ancient, abilityId)
    local abilityLevel = 1
    local tooltipIndex = 0
    local abilityName = nil
    local abilityDescription = nil
    if (ancient ~= nil) then
        abilityLevel = GetUnitAbilityLevel(ancient, abilityId)
    end
    if (abilityLevel <= 0) then
        abilityLevel = 1
    end
    tooltipIndex = __jint(abilityLevel - 1)
    abilityName = Ancient_FormatTooltipText(BlzGetAbilityResearchTooltip(abilityId, tooltipIndex), abilityLevel)
    abilityName = Ancient_RemoveColorCodes(abilityName)
    abilityName = Ancient_RemoveSquareBracketBlocks(abilityName)
    abilityName = Ancient_CleanTrailingSeparators(abilityName)
    abilityDescription = Ancient_FormatTooltipText(BlzGetAbilityResearchExtendedTooltip(abilityId, tooltipIndex), abilityLevel)
    abilityDescription = Ancient_RemoveColorCodes(abilityDescription)
    abilityDescription = Ancient_CollapseSpaces(abilityDescription)
    if (StringLength(abilityName) == 0) then
        abilityName = "Unknown ability"
    end
    if (StringLength(abilityDescription) == 0) then
        abilityDescription = "No learn tooltip text."
    end
    do return __jconcat(__jconcat(__jconcat(__jconcat("|cff00ccff", abilityName), "|r |cffffffff"), abilityDescription), "|r") end
end

-- Original JASS function: Ancient_ShowAbilityPageByType (line 13551)
function Ancient_ShowAbilityPageByType(p, ancient, unitTypeId, ancientName, page, isPreview)
    local abilityCount = Ancient_GetAbilityCount(unitTypeId)
    local abilitiesPerPage = 3
    local maxPage = 0
    local startIndex = 0
    local endIndex = 0
    local i = 0
    local abilityId = 0
    local pageText = nil
    if (abilityCount <= 0) then
        Ancient_ClearMessagesForPlayer(p)
        DisplayTimedTextToPlayer(p, __jreal(0.00), __jreal(0.00), __jreal(10.00), __jconcat("|cffffcc00Ancient:|r This Ancient unit type is not registered: ", I2S(unitTypeId)))
        do return end
    end
    maxPage = __jdiv((__jint(__jint(abilityCount + abilitiesPerPage) - 1)), abilitiesPerPage)
    if (page > maxPage) then
        page = maxPage
    end
    startIndex = __jint(__jint((__jint(page - 1)) * abilitiesPerPage) + 1)
    endIndex = __jint(page * abilitiesPerPage)
    if (endIndex > abilityCount) then
        endIndex = abilityCount
    end
    if isPreview then
        pageText = __jconcat(__jconcat(__jconcat(__jconcat(__jconcat(__jconcat("|cffffcc00Ancient preview:|r |cffffffff", ancientName), "|r |cffaaaaaaPage "), I2S(page)), "/"), I2S(maxPage)), "|r")
    else
        pageText = __jconcat(__jconcat(__jconcat(__jconcat(__jconcat(__jconcat("|cffffcc00Ancient spells:|r |cffffffff", ancientName), "|r |cffaaaaaaPage "), I2S(page)), "/"), I2S(maxPage)), "|r")
    end
    i = startIndex
    while true do
        if (i > endIndex) then break end
        abilityId = Ancient_GetAbilityIdByIndex(unitTypeId, i)
        if (abilityId ~= 0) then
            pageText = __jconcat(__jconcat(pageText, "\n"), Ancient_GetSingleAbilityLine(ancient, abilityId))
        end
        i = __jint(i + 1)
    end
    if (page < maxPage) then
        if isPreview then
            pageText = __jconcat(__jconcat(__jconcat(__jconcat(__jconcat(pageText, "\n|cffaaaaaaType |r|cffffcc00-ancient "), Ancient_GetFirstWord(Ancient_GetUnitTypeDisplayName(unitTypeId))), " "), I2S(__jint(page + 1))), "|r|cffaaaaaa to show the next page.|r")
        else
            pageText = __jconcat(__jconcat(__jconcat(pageText, "\n|cffaaaaaaType |r|cffffcc00-ancient "), I2S(__jint(page + 1))), "|r|cffaaaaaa to show the next page.|r")
        end
    end
    Ancient_ClearMessagesForPlayer(p)
    DisplayTimedTextToPlayer(p, __jreal(0.00), __jreal(0.00), __jreal(45.00), pageText)
end

-- Original JASS function: Ancient_ShowAbilityPage (line 13611)
function Ancient_ShowAbilityPage(p, ancient, page)
    Ancient_ShowAbilityPageByType(p, ancient, GetUnitTypeId(ancient), GetUnitName(ancient), page, false)
end

-- Original JASS function: Ancient_Command_Actions (line 13615)
function Ancient_Command_Actions()
    local p = GetTriggerPlayer()
    local chat = GetEventPlayerChatString()
    local argument = nil
    local firstWordOriginal = nil
    local firstWord = nil
    local page = 0
    local previewUnitTypeId = 0
    if (not Ancient_IsCommand(chat)) then
        p = nil
        do return end
    end
    argument = Ancient_GetArgumentText(chat)
    firstWordOriginal = Ancient_GetFirstWord(argument)
    firstWord = StringCase(firstWordOriginal, false)
    previewUnitTypeId = Ancient_GetUnitTypeIdByKeyword(firstWord)
    if (FE_Roles.ancient() == nil) then
        Ancient_ClearMessagesForPlayer(p)
        DisplayTimedTextToPlayer(p, __jreal(0.00), __jreal(0.00), __jreal(10.00), "|cffffcc00Ancient:|r Ancient player is not set.")
        p = nil
        do return end
    end
    if (p == FE_Roles.ancient()) then
        if (previewUnitTypeId ~= 0) then
            page = Ancient_ParsePageFromArgument(argument)
            Ancient_ShowAbilityPageByType(p, nil, previewUnitTypeId, Ancient_GetUnitTypeDisplayName(previewUnitTypeId), page, true)
            p = nil
            do return end
        end
        if (((StringLength(firstWordOriginal) > 0) and (S2I(firstWord) <= 0)) and (firstWord ~= "0")) then
            Ancient_ClearMessagesForPlayer(p)
            DisplayTimedTextToPlayer(p, __jreal(0.00), __jreal(0.00), __jreal(10.00), __jconcat(__jconcat("|cffffcc00Ancient preview:|r Cannot find Ancient called |cffff0000", firstWordOriginal), "|r|cffffffff.|r"))
            p = nil
            do return end
        end
        Ancient_ShowPreviewUsage(p)
        p = nil
        do return end
    end
    if (previewUnitTypeId ~= 0) then
        Ancient_ClearMessagesForPlayer(p)
        DisplayTimedTextToPlayer(p, __jreal(0.00), __jreal(0.00), __jreal(10.00), "|cffffcc00Ancient:|r Only the Ancient player can preview Ancient abilities by name.")
        p = nil
        do return end
    end
    if (((StringLength(firstWordOriginal) > 0) and (S2I(firstWord) <= 0)) and (firstWord ~= "0")) then
        Ancient_ClearMessagesForPlayer(p)
        DisplayTimedTextToPlayer(p, __jreal(0.00), __jreal(0.00), __jreal(10.00), "|cffffcc00Ancient:|r Invalid page. Use |cffffcc00-ancient|r|cffffffff or |r|cffffcc00-ancient 2|r|cffffffff.|r")
        p = nil
        do return end
    end
    page = Ancient_ParsePageFromArgument(argument)
    if (not IsPlayerEnemy(p, FE_Roles.ancient())) then
        Ancient_ClearMessagesForPlayer(p)
        DisplayTimedTextToPlayer(p, __jreal(0.00), __jreal(0.00), __jreal(10.00), "|cffffcc00Ancient:|r This command is only available to enemies of the Ancient.")
        p = nil
        do return end
    end
    if (udg_AncientUnit == nil) then
        Ancient_ClearMessagesForPlayer(p)
        DisplayTimedTextToPlayer(p, __jreal(0.00), __jreal(0.00), __jreal(10.00), "|cffffcc00Ancient:|r There is currently no living Ancient unit.")
        p = nil
        do return end
    end
    if ((GetUnitTypeId(udg_AncientUnit) == 0) or (GetWidgetLife(udg_AncientUnit) <= __jreal(0.405))) then
        Ancient_ClearMessagesForPlayer(p)
        DisplayTimedTextToPlayer(p, __jreal(0.00), __jreal(0.00), __jreal(10.00), "|cffffcc00Ancient:|r There is currently no living Ancient unit.")
        p = nil
        do return end
    end
    Ancient_ShowAbilityPage(p, udg_AncientUnit, page)
    p = nil
end

-- Original JASS function: InitTrig_AncientSpells (line 13703)
function InitTrig_AncientSpells()
    local t = CreateTrigger()
    local i = 0
    while true do
        if (i >= bj_MAX_PLAYERS) then break end
        TriggerRegisterPlayerChatEvent(t, Player(i), "-", false)
        i = __jint(i + 1)
    end
    TriggerAddAction(t, Ancient_Command_Actions)
    t = nil
end
-- END FOREST SECTION 205
-- END FOREST MODULE src/commands/player.lua

-- BEGIN FOREST MODULE src/game/selection.lua
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
-- END FOREST MODULE src/game/selection.lua

-- BEGIN FOREST MODULE src/game/fountain.lua
-- game / fountain
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 19 Fountain_Heal
-- Original JASS function: Trig_Fountain_Heal_Func001Func001Func001C (line 5346)
function Trig_Fountain_Heal_Func001Func001Func001C()
    if ((not ((IsUnitType(GetEnumUnit(), UNIT_TYPE_STRUCTURE) == false)))) then
        do return false end
    end
    if ((not ((IsUnitAlly(GetEnumUnit(), FE_Roles.ancient()) == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Fountain_Heal_Func001Func001A (line 5356)
function Trig_Fountain_Heal_Func001Func001A()
    if (Trig_Fountain_Heal_Func001Func001Func001C()) then
        SetUnitLifePercentBJ(GetEnumUnit(), (__jreal(GetUnitLifePercent(GetEnumUnit()) + (__jreal(GetUnitLifePercent(GetEnumUnit()) * __jreal(0.25))))))
        SetUnitManaPercentBJ(GetEnumUnit(), (__jreal(GetUnitManaPercent(GetEnumUnit()) + (__jreal(GetUnitManaPercent(GetEnumUnit()) * __jreal(0.25))))))
        udg_TSEAttachPoint = "overhead"
        udg_TSEEffectName = "Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl"
        udg_TSETargetUnit = GetEnumUnit()
        ConditionalTriggerExecute(udg_TSE_RegisterTrigger)
    else
    end
end

-- Original JASS function: Trig_Fountain_Heal_Func001C (line 5368)
function Trig_Fountain_Heal_Func001C()
    if ((not ((udg_AncientInCombat == __jreal(0.00))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Fountain_Heal_Actions (line 5375)
function Trig_Fountain_Heal_Actions()
    if (Trig_Fountain_Heal_Func001C()) then
        ForGroupBJ(GetUnitsInRectAll(gg_rct_Fountain), Trig_Fountain_Heal_Func001Func001A)
    else
        udg_AncientInCombat = __jreal(0.00)
    end
end

-- Original JASS function: InitTrig_Fountain_Heal (line 5384)
function InitTrig_Fountain_Heal()
    gg_trg_Fountain_Heal = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(gg_trg_Fountain_Heal, __jreal(4.00))
    TriggerAddAction(gg_trg_Fountain_Heal, Trig_Fountain_Heal_Actions)
end
-- END FOREST SECTION 19
-- END FOREST MODULE src/game/fountain.lua

-- BEGIN FOREST MODULE src/combat/common.lua
-- combat / common
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 20 Ancient_In_Combat
-- Original JASS function: Trig_Ancient_In_Combat_Conditions (line 5393)
function Trig_Ancient_In_Combat_Conditions()
    if ((not ((udg_DamageEventAmount >= __jreal(100.00))))) then
        do return false end
    end
    if ((not ((udg_DamageEventTarget == udg_AncientUnit)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Ancient_In_Combat_Actions (line 5403)
function Trig_Ancient_In_Combat_Actions()
    udg_AncientInCombat = __jreal(1.00)
end

-- Original JASS function: InitTrig_Ancient_In_Combat (line 5408)
function InitTrig_Ancient_In_Combat()
    gg_trg_Ancient_In_Combat = CreateTrigger()
    h__TriggerRegisterVariableEvent(gg_trg_Ancient_In_Combat, "udg_DamageModifierEvent", EQUAL, __jreal(1.00))
    TriggerAddCondition(gg_trg_Ancient_In_Combat, Condition(Trig_Ancient_In_Combat_Conditions))
    TriggerAddAction(gg_trg_Ancient_In_Combat, Trig_Ancient_In_Combat_Actions)
end
-- END FOREST SECTION 20

-- BEGIN FOREST SECTION 27 Detonate
-- Original JASS function: Trig_Detonate_Func001001 (line 6247)
function Trig_Detonate_Func001001()
    do return ((GetSpellAbilityId() == FourCC("A08G"))) end
end

-- Original JASS function: Trig_Detonate_Func001002 (line 6251)
function Trig_Detonate_Func001002()
    do return ((GetSpellAbilityId() == FourCC("A0F2"))) end
end

-- Original JASS function: Trig_Detonate_Conditions (line 6255)
function Trig_Detonate_Conditions()
    if ((not GetBooleanOr(((GetSpellAbilityId() == FourCC("A08G"))), ((GetSpellAbilityId() == FourCC("A0F2")))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Detonate_Actions (line 6262)
function Trig_Detonate_Actions()
    KillUnit(GetTriggerUnit())
end

-- Original JASS function: InitTrig_Detonate (line 6267)
function InitTrig_Detonate()
    gg_trg_Detonate = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Detonate, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Detonate, Condition(Trig_Detonate_Conditions))
    TriggerAddAction(gg_trg_Detonate, Trig_Detonate_Actions)
end
-- END FOREST SECTION 27

-- BEGIN FOREST SECTION 28 Expander_Hero_XP
-- Original JASS function: Trig_Expander_Hero_XP_Conditions (line 6277)
function Trig_Expander_Hero_XP_Conditions()
    if ((not ((IsUnitType(udg_DamageEventSource, UNIT_TYPE_HERO) == true)))) then
        do return false end
    end
    if ((not ((IsUnitType(udg_DamageEventTarget, UNIT_TYPE_HERO) == true)))) then
        do return false end
    end
    if ((not ((udg_IsDamageAttack == true)))) then
        do return false end
    end
    if ((not ((IsUnitAlly(udg_DamageEventTarget, FE_Roles.ancient()) == true)))) then
        do return false end
    end
    if ((not ((IsUnitEnemy(udg_DamageEventSource, FE_Roles.ancient()) == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Expander_Hero_XP_Actions (line 6296)
function Trig_Expander_Hero_XP_Actions()
    AddHeroXPSwapped(50, udg_DamageEventSource, true)
end

-- Original JASS function: InitTrig_Expander_Hero_XP (line 6301)
function InitTrig_Expander_Hero_XP()
    gg_trg_Expander_Hero_XP = CreateTrigger()
    h__TriggerRegisterVariableEvent(gg_trg_Expander_Hero_XP, "udg_DamageEvent", EQUAL, __jreal(1.00))
    TriggerAddCondition(gg_trg_Expander_Hero_XP, Condition(Trig_Expander_Hero_XP_Conditions))
    TriggerAddAction(gg_trg_Expander_Hero_XP, Trig_Expander_Hero_XP_Actions)
end
-- END FOREST SECTION 28
-- END FOREST MODULE src/combat/common.lua

-- BEGIN FOREST MODULE src/economy/feed.lua
-- economy / feed
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 21 AutoFeedRate
-- Capture lobby identity before race selection adds colors/titles to names.
FE_FeedNames = {}
function FeedRate_Identity(p)
    return FE_FeedNames[GetPlayerId(p)] or GetPlayerName(p)
end

-- Original JASS function: FeedRate_DebugError (line 5419)
function FeedRate_DebugError(msg)
    DisplayTimedTextToForce(GetPlayersAll(), __jreal(20.00), __jconcat("|cffff0000[FeedRate Debug]|r ", msg))
end

-- Original JASS function: FeedRate_Clamp (line 5423)
function FeedRate_Clamp(rate)
    if (rate < 50) then
        do return 50 end
    end
    if (rate > 100) then
        do return 100 end
    end
    do return rate end
end

-- Original JASS function: FeedRate_FindChar (line 5435)
function FeedRate_FindChar(data, wanted)
    local i = 0
    local len = StringLength(data)
    while true do
        if (i >= len) then break end
        if (SubString(data, i, __jint(i + 1)) == wanted) then
            do return i end
        end
        i = __jint(i + 1)
    end
    do return __jint(-(1)) end
end

-- Original JASS function: FeedRate_ParseRate (line 5452)
function FeedRate_ParseRate(data)
    local digits = data:match("^%d+$") or data:match("^%d+:(%d+)$")
    local rate = digits and tonumber(digits)
    if not rate or rate <= 0 or rate > 100 then return 0 end
    return FeedRate_Clamp(rate)
end

-- Original JASS function: FeedRate_IsValidUser (line 5470)
function FeedRate_IsValidUser(p)
    do return ((GetPlayerController(p) == MAP_CONTROL_USER) and (GetPlayerSlotState(p) == PLAYER_SLOT_STATE_PLAYING)) end
end

-- Original JASS function: FeedRate_CountActiveUsers (line 5474)
function FeedRate_CountActiveUsers()
    local i = 0
    local count = 0
    while true do
        if (i >= FEEDRATE_MAX_PLAYERS) then break end
        if FeedRate_IsValidUser(Player(i)) then
            count = __jint(count + 1)
        end
        i = __jint(i + 1)
    end
    do return count end
end

-- Original JASS function: FeedRate_PlayerNameHasBattleTag (line 5491)
function FeedRate_PlayerNameHasBattleTag(p)
    do return (FeedRate_FindChar(FeedRate_Identity(p), "#") >= 0) end
end

-- Original JASS function: FeedRate_FindMatchingPlayerByName (line 5495)
function FeedRate_FindMatchingPlayerByName(playerName)
    local i = 0
    local p = nil
    while true do
        if (i >= FEEDRATE_MAX_PLAYERS) then break end
        p = Player(i)
        if (FeedRate_IsValidUser(p) and (FeedRate_Identity(p) == playerName)) then
            do return p end
        end
        i = __jint(i + 1)
    end
    do return nil end
end

-- Original JASS function: FeedRate_Apply (line 5514)
function FeedRate_Apply(p, rate)
    local pid = GetPlayerId(p)
    rate = FeedRate_Clamp(rate)
    FeedRate_Loaded[pid] = true
    udg_ExperienceRate[pid] = I2R(rate)
end

-- Original JASS function: FeedRate_SaveForPlayer (line 5522)
function FeedRate_SaveForPlayer(p, rate)
    if GetLocalPlayer() == p and FeedRate_PlayerNameHasBattleTag(p) then
        -- Preloader files execute JASS even in a Lua map. Escape the JASS
        -- string literal before embedding a player-supplied name.
        local name = FeedRate_Identity(p):gsub('\\', '\\\\'):gsub('"', '\\"'):gsub('\r', '\\r'):gsub('\n', '\\n')
        PreloadGenClear()
        PreloadGenStart()
        Preload('\")\ncall BlzSendSyncData("' .. FEEDRATE_SYNC_PREFIX .. '","' .. tostring(FeedRate_Clamp(rate)) ..
            '")\ncall BlzSendSyncData("' .. FEEDRATE_NAME_SYNC_PREFIX .. '","' .. name .. '")\n//')
        PreloadGenEnd(FEEDRATE_FILE_PATH)
    end
end

-- Original JASS function: FeedRate_SelectRate (line 5533)
function FeedRate_SelectRate(p, rate)
    FeedRate_Apply(p, rate)
    FeedRate_SaveForPlayer(p, rate)
    p = nil
end

-- Original JASS function: FeedRate_ClickYes (line 5540)
function FeedRate_ClickYes()
    FeedRate_SelectRate(GetTriggerPlayer(), 100)
end

-- Original JASS function: FeedRate_ClickOtherTag (line 5544)
function FeedRate_ClickOtherTag()
    FeedRate_SelectRate(GetTriggerPlayer(), 75)
end

-- Original JASS function: FeedRate_ClickNo (line 5548)
function FeedRate_ClickNo()
    FeedRate_SelectRate(GetTriggerPlayer(), 50)
end

-- Original JASS function: FeedRate_OnRateSync (line 5552)
function FeedRate_OnRateSync()
    local p = GetTriggerPlayer()
    local pid = GetPlayerId(p)
    local rate = FeedRate_ParseRate(BlzGetTriggerSyncData())
    if (rate > 0) then
        FeedRate_PendingRateReceived[pid] = true
        FeedRate_PendingRate[pid] = rate
        FeedRate_ProcessPendingLoadForPlayer(p)
    end
    p = nil
end

-- Original JASS function: FeedRate_OnNameSync (line 5565)
function FeedRate_OnNameSync()
    local p = GetTriggerPlayer()
    local pid = GetPlayerId(p)
    FeedRate_PendingNameReceived[pid] = true
    FeedRate_PendingName[pid] = BlzGetTriggerSyncData()
    FeedRate_ProcessPendingLoadForPlayer(p)
    p = nil
end

-- Original JASS function: FeedRate_ProcessPendingLoadForPlayer (line 5575)
function FeedRate_ProcessPendingLoadForPlayer(p)
    local pid = GetPlayerId(p)
    if not FeedRate_IsValidUser(p) or FeedRate_Loaded[pid] or
       not FeedRate_PendingRateReceived[pid] or not FeedRate_PendingNameReceived[pid] then return end
    local rate = FeedRate_PendingRate[pid]
    local savedName = FeedRate_PendingName[pid]
    local offline = not FeedRate_PlayerNameHasBattleTag(p) and FeedRate_CountActiveUsers() <= 1
    -- A synchronized payload belongs only to its sender. Never let another
    -- player's local file choose the feed rate for someone else in the lobby.
    if savedName ~= FeedRate_Identity(p) and not offline then return end
    local finalRate = FeedRate_Clamp(rate + 5)
    FeedRate_Apply(p, finalRate)
    DialogDisplayBJ(false, udg_StartupDialog, p)
    if not offline and finalRate ~= rate then FeedRate_SaveForPlayer(p, finalRate) end
end

-- Original JASS function: FeedRate_ProcessPendingLoads (line 5621)
function FeedRate_ProcessPendingLoads()
    local t = GetExpiredTimer()
    local i = 0
    DestroyTimer(t)
    while true do
        if (i >= FEEDRATE_MAX_PLAYERS) then break end
        FeedRate_ProcessPendingLoadForPlayer(Player(i))
        i = __jint(i + 1)
    end
    t = nil
end

-- Original JASS function: FeedRate_TryLoadForPlayer (line 5638)
function FeedRate_TryLoadForPlayer(i)
    local p = Player(i)
    if FeedRate_IsValidUser(p) then
        if (GetLocalPlayer() == p) then
            Preloader(FEEDRATE_FILE_PATH)
        end
    end
    p = nil
end

-- Original JASS function: FeedRate_StartLoadAll (line 5650)
function FeedRate_StartLoadAll()
    local t = GetExpiredTimer()
    local i = 0
    DestroyTimer(t)
    while true do
        if (i >= FEEDRATE_MAX_PLAYERS) then break end
        FeedRate_Loaded[i] = false
        FeedRate_PendingRateReceived[i] = false
        FeedRate_PendingRate[i] = 0
        FeedRate_PendingNameReceived[i] = false
        FeedRate_PendingName[i] = ""
        FeedRate_TryLoadForPlayer(i)
        i = __jint(i + 1)
    end
    t = nil
end

-- Original JASS function: FeedRate_ShowDialogsForMissingLoads (line 5673)
function FeedRate_ShowDialogsForMissingLoads()
    local t = GetExpiredTimer()
    local i = 0
    DestroyTimer(t)
    while true do
        if (i >= FEEDRATE_MAX_PLAYERS) then break end
        if (FeedRate_IsValidUser(Player(i)) and (not FeedRate_Loaded[i])) then
            DialogDisplayBJ(true, udg_StartupDialog, Player(i))
        end
        i = __jint(i + 1)
    end
    t = nil
end

-- Original JASS function: FeedRate_SetupDialog (line 5692)
function FeedRate_SetupDialog()
    DialogClearBJ(udg_StartupDialog)
    DialogSetMessageBJ(udg_StartupDialog, "Did you play this map before?")
    FeedRate_ButtonYes = DialogAddButtonBJ(udg_StartupDialog, "Yes")
    FeedRate_ButtonOtherTag = DialogAddButtonBJ(udg_StartupDialog, "I played other tag maps")
    FeedRate_ButtonNo = DialogAddButtonBJ(udg_StartupDialog, "No / Not Sure")
    FeedRate_YesTrigger = CreateTrigger()
    FeedRate_OtherTagTrigger = CreateTrigger()
    FeedRate_NoTrigger = CreateTrigger()
    TriggerRegisterDialogButtonEvent(FeedRate_YesTrigger, FeedRate_ButtonYes)
    TriggerRegisterDialogButtonEvent(FeedRate_OtherTagTrigger, FeedRate_ButtonOtherTag)
    TriggerRegisterDialogButtonEvent(FeedRate_NoTrigger, FeedRate_ButtonNo)
    TriggerAddAction(FeedRate_YesTrigger, FeedRate_ClickYes)
    TriggerAddAction(FeedRate_OtherTagTrigger, FeedRate_ClickOtherTag)
    TriggerAddAction(FeedRate_NoTrigger, FeedRate_ClickNo)
end

-- Original JASS function: Trig_AutoFeedRate_Actions (line 5713)
function Trig_AutoFeedRate_Actions()
    local i = 0
    local loadTimer = CreateTimer()
    local processTimer = CreateTimer()
    local dialogTimer = CreateTimer()
    FeedRate_SetupDialog()
    FeedRate_SyncTrigger = CreateTrigger()
    FeedRate_NameSyncTrigger = CreateTrigger()
    TriggerAddAction(FeedRate_SyncTrigger, FeedRate_OnRateSync)
    TriggerAddAction(FeedRate_NameSyncTrigger, FeedRate_OnNameSync)
    while true do
        if (i >= FEEDRATE_MAX_PLAYERS) then break end
        BlzTriggerRegisterPlayerSyncEvent(FeedRate_SyncTrigger, Player(i), FEEDRATE_SYNC_PREFIX, false)
        BlzTriggerRegisterPlayerSyncEvent(FeedRate_NameSyncTrigger, Player(i), FEEDRATE_NAME_SYNC_PREFIX, false)
        i = __jint(i + 1)
    end
    TimerStart(loadTimer, __jreal(0.10), false, FeedRate_StartLoadAll)
    TimerStart(processTimer, __jreal(1.00), false, FeedRate_ProcessPendingLoads)
    TimerStart(dialogTimer, __jreal(1.50), false, FeedRate_ShowDialogsForMissingLoads)
    loadTimer = nil
    processTimer = nil
    dialogTimer = nil
end

-- Original JASS function: InitTrig_AutoFeedRate (line 5746)
function InitTrig_AutoFeedRate()
    for slot = 0, FEEDRATE_MAX_PLAYERS - 1 do
        FE_FeedNames[slot] = GetPlayerName(Player(slot))
    end
    gg_trg_AutoFeedRate = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_AutoFeedRate, __jreal(0.01))
    TriggerAddAction(gg_trg_AutoFeedRate, Trig_AutoFeedRate_Actions)
end
-- END FOREST SECTION 21

-- BEGIN FOREST SECTION 22 TimeToAncientSpawn_Copy
-- Original JASS function: Trig_TimeToAncientSpawn_Copy_Actions (line 5754)
function Trig_TimeToAncientSpawn_Copy_Actions()
    DisableTrigger(gg_trg_SetFeed)
end

-- Original JASS function: InitTrig_TimeToAncientSpawn_Copy (line 5759)
function InitTrig_TimeToAncientSpawn_Copy()
    gg_trg_TimeToAncientSpawn_Copy = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_TimeToAncientSpawn_Copy, __jreal(60.00))
    TriggerAddAction(gg_trg_TimeToAncientSpawn_Copy, Trig_TimeToAncientSpawn_Copy_Actions)
end
-- END FOREST SECTION 22

-- BEGIN FOREST SECTION 23 HandleSetRate
-- Original JASS function: SetFeedIsDigit (line 5768)
function SetFeedIsDigit(char)
    local digits = "0123456789"
    local i = 0
    while true do
        if (i >= 10) then break end
        if (char == SubString(digits, i, __jint(i + 1))) then
            do return true end
        end
        i = __jint(i + 1)
    end
    do return false end
end

-- Original JASS function: SetFeedClampRate (line 5783)
function SetFeedClampRate(rate)
    if (rate < __jreal(50.00)) then
        do return __jreal(50.00) end
    end
    if (rate > __jreal(200.00)) then
        do return __jreal(200.00) end
    end
    do return rate end
end

-- Original JASS function: SetFeedErrorRateOutOfRange (line 5793)
function SetFeedErrorRateOutOfRange(whichPlayer, value)
    DisplayTextToPlayer(whichPlayer, __jreal(0), __jreal(0), __jconcat(__jconcat("Error: Feedrate ", value), " is outside allowed range. Use 50 to 200."))
end

-- Original JASS function: SetFeedErrorCannotFindPlayer (line 5797)
function SetFeedErrorCannotFindPlayer(whichPlayer, playerName)
    DisplayTextToPlayer(whichPlayer, __jreal(0), __jreal(0), __jconcat("Error: Cannot find player called ", playerName))
end

-- Original JASS function: SetFeedTrimLeft (line 5801)
function SetFeedTrimLeft(s)
    local i = 0
    local len = StringLength(s)
    while true do
        if ((i >= len) or (SubString(s, i, __jint(i + 1)) ~= " ")) then break end
        i = __jint(i + 1)
    end
    do return SubString(s, i, len) end
end

-- Original JASS function: SetFeedFirstToken (line 5813)
function SetFeedFirstToken(s)
    local i = 0
    local len = StringLength(s)
    while true do
        if ((i >= len) or (SubString(s, i, __jint(i + 1)) == " ")) then break end
        i = __jint(i + 1)
    end
    do return SubString(s, 0, i) end
end

-- Original JASS function: SetFeedRestAfterFirstToken (line 5825)
function SetFeedRestAfterFirstToken(s)
    local i = 0
    local len = StringLength(s)
    while true do
        if ((i >= len) or (SubString(s, i, __jint(i + 1)) == " ")) then break end
        i = __jint(i + 1)
    end
    while true do
        if ((i >= len) or (SubString(s, i, __jint(i + 1)) ~= " ")) then break end
        i = __jint(i + 1)
    end
    do return SubString(s, i, len) end
end

-- Original JASS function: SetFeedIsUnsignedInteger (line 5842)
function SetFeedIsUnsignedInteger(s)
    local i = 0
    local len = StringLength(s)
    if (len <= 0) then
        do return false end
    end
    while true do
        if (i >= len) then break end
        if (not SetFeedIsDigit(SubString(s, i, __jint(i + 1)))) then
            do return false end
        end
        i = __jint(i + 1)
    end
    do return true end
end

-- Original JASS function: SetFeedIsUnsignedReal (line 5861)
function SetFeedIsUnsignedReal(s)
    local i = 0
    local len = StringLength(s)
    local dotCount = 0
    local digitCount = 0
    local c = nil
    if (len <= 0) then
        do return false end
    end
    while true do
        if (i >= len) then break end
        c = SubString(s, i, __jint(i + 1))
        if SetFeedIsDigit(c) then
            digitCount = __jint(digitCount + 1)
        elseif (c == ".") then
            dotCount = __jint(dotCount + 1)
            if (dotCount > 1) then
                do return false end
            end
        else
            do return false end
        end
        i = __jint(i + 1)
    end
    do return (digitCount > 0) end
end

-- Original JASS function: SetFeedPercentToMultiplierText (line 5893)
function SetFeedPercentToMultiplierText(percent)
    local whole = __jdiv(percent, 100)
    local frac = __jint(percent - __jint(whole * 100))
    if (frac == 0) then
        do return I2S(whole) end
    end
    if (ModuloInteger(frac, 10) == 0) then
        do return __jconcat(__jconcat(I2S(whole), "."), I2S(__jdiv(frac, 10))) end
    end
    if (frac < 10) then
        do return __jconcat(__jconcat(I2S(whole), ".0"), I2S(frac)) end
    end
    do return __jconcat(__jconcat(I2S(whole), "."), I2S(frac)) end
end

-- Original JASS function: SetFeedColorToPlayerNumber (line 5912)
function SetFeedColorToPlayerNumber(token)
    local c = StringCase(token, false)
    if (c == "red") then
        do return 1 end
    end
    if (c == "blue") then
        do return 2 end
    end
    if (c == "teal") then
        do return 3 end
    end
    if (c == "purple") then
        do return 4 end
    end
    if (c == "yellow") then
        do return 5 end
    end
    if (c == "orange") then
        do return 6 end
    end
    if (c == "green") then
        do return 7 end
    end
    if (c == "pink") then
        do return 8 end
    end
    if ((c == "gray") or (c == "grey")) then
        do return 9 end
    end
    if (((c == "lightblue") or (c == "light-blue")) or (c == "light_blue")) then
        do return 10 end
    end
    if (((c == "darkgreen") or (c == "dark-green")) or (c == "dark_green")) then
        do return 11 end
    end
    do return 0 end
end

-- Original JASS function: SetFeedTwoWordColorToPlayerNumber (line 5952)
function SetFeedTwoWordColorToPlayerNumber(token1, token2)
    local c1 = StringCase(token1, false)
    local c2 = StringCase(token2, false)
    if ((c1 == "light") and (c2 == "blue")) then
        do return 10 end
    end
    if ((c1 == "dark") and (c2 == "green")) then
        do return 11 end
    end
    do return 0 end
end

-- Original JASS function: SetFeedSetAll (line 5967)
function SetFeedSetAll(rate)
    local i = 0
    while true do
        if (i >= 11) then break end
        udg_ExperienceRate[i] = I2R(rate)
        i = __jint(i + 1)
    end
end

-- Original JASS function: HandleSetExp (line 5977)
function HandleSetExp(triggerPlayer, message)
    local trimmed = SetFeedTrimLeft(SubString(message, 8, StringLength(message)))
    local token1 = SetFeedFirstToken(trimmed)
    local rest = SetFeedRestAfterFirstToken(trimmed)
    local token2 = ""
    local extra = ""
    local multText = ""
    local playerNameForError = ""
    local playerNumber = 0
    local twoWordColorNumber = 0
    local y = 0
    local i = 0
    local suggestedPercent = 0
    local oldRate = __jreal(0.00)
    local multiplier = __jreal(0.00)
    local singleReal = __jreal(0.00)
    if (token1 == "") then
        DisplayTextToPlayer(triggerPlayer, __jreal(0), __jreal(0), "Failed to set feedrate")
        do return end
    end
    if (((rest == "") and (StringLength(token1) > 1)) and (SubString(token1, 0, 1) == "x")) then
        multText = SubString(token1, 1, StringLength(token1))
        if (not SetFeedIsUnsignedReal(multText)) then
            DisplayTextToPlayer(triggerPlayer, __jreal(0), __jreal(0), "Failed to set feedrate")
            do return end
        end
        multiplier = S2R(multText)
        if (multiplier <= __jreal(0.00)) then
            DisplayTextToPlayer(triggerPlayer, __jreal(0), __jreal(0), "Failed to set feedrate")
            do return end
        end
        if (((multiplier >= __jreal(50.00)) and (multiplier <= __jreal(200.00))) and (multiplier == I2R(R2I(multiplier)))) then
            suggestedPercent = R2I(multiplier)
            DisplayTextToPlayer(triggerPlayer, __jreal(0), __jreal(0), __jconcat(__jconcat(__jconcat(__jconcat(__jconcat(__jconcat(__jconcat(__jconcat("Error: Did you mean -setfeed x", SetFeedPercentToMultiplierText(suggestedPercent)), "? (multiplies every feedrate by "), SetFeedPercentToMultiplierText(suggestedPercent)), ") or did you mean to do -setfeed "), I2S(suggestedPercent)), " (sets everyone's feedrate to "), I2S(suggestedPercent)), "%)"))
            do return end
        end
        i = 0
        while true do
            if (i >= 11) then break end
            oldRate = udg_ExperienceRate[i]
            if ((oldRate < __jreal(50.00)) or (oldRate > __jreal(200.00))) then
                oldRate = __jreal(100.00)
            end
            udg_ExperienceRate[i] = SetFeedClampRate(I2R(R2I(__jreal(__jreal(oldRate * multiplier) + __jreal(0.50)))))
            i = __jint(i + 1)
        end
        DisplayTextToPlayer(triggerPlayer, __jreal(0), __jreal(0), __jconcat(__jconcat("Every feedrate was multiplied by ", multText), ". Final values are limited to 50%-200%."))
        do return end
    end
    if (rest == "") then
        if SetFeedIsUnsignedInteger(token1) then
            y = S2I(token1)
            if ((y < 50) or (y > 200)) then
                DisplayTextToPlayer((triggerPlayer), __jreal(0), __jreal(0), __jconcat(__jconcat("Error: Feedrate ", (token1)), " is outside allowed range. Use 50 to 200."))
                do return end
            end
            SetFeedSetAll(y)
            DisplayTextToPlayer(triggerPlayer, __jreal(0), __jreal(0), __jconcat(__jconcat("Feedrate of every player is set to ", I2S(y)), "%"))
            do return end
        end
        if SetFeedIsUnsignedReal(token1) then
            singleReal = S2R(token1)
            if ((singleReal >= __jreal(0.50)) and (singleReal <= __jreal(2.00))) then
                suggestedPercent = R2I(__jreal(__jreal(singleReal * __jreal(100.00)) + __jreal(0.50)))
                DisplayTextToPlayer(triggerPlayer, __jreal(0), __jreal(0), __jconcat(__jconcat(__jconcat(__jconcat(__jconcat(__jconcat(__jconcat(__jconcat("Error: Did you mean -setfeed x", token1), "? (multiplies every feedrate by "), token1), ") or did you mean to -setfeed "), I2S(suggestedPercent)), " (sets everyone's feedrate to "), I2S(suggestedPercent)), "%)."))
                do return end
            end
        end
        DisplayTextToPlayer(triggerPlayer, __jreal(0), __jreal(0), "Failed to set feedrate")
        do return end
    end
    token2 = SetFeedFirstToken(rest)
    extra = SetFeedRestAfterFirstToken(rest)
    playerNameForError = token1
    if SetFeedIsUnsignedInteger(token1) then
        playerNumber = S2I(token1)
    else
        playerNumber = SetFeedColorToPlayerNumber(token1)
        if (playerNumber == 0) then
            twoWordColorNumber = SetFeedTwoWordColorToPlayerNumber(token1, token2)
            if (twoWordColorNumber > 0) then
                playerNumber = twoWordColorNumber
                playerNameForError = __jconcat(__jconcat(token1, " "), token2)
                token2 = SetFeedFirstToken(extra)
                extra = SetFeedRestAfterFirstToken(extra)
            elseif (((extra ~= "") and SetFeedIsUnsignedInteger(extra)) and (not SetFeedIsUnsignedInteger(token2))) then
                playerNameForError = __jconcat(__jconcat(token1, " "), token2)
                token2 = extra
                extra = ""
            end
        end
    end
    if (token2 == "") then
        DisplayTextToPlayer(triggerPlayer, __jreal(0), __jreal(0), "Error: Missing feedrate value.")
        do return end
    end
    if (extra ~= "") then
        DisplayTextToPlayer(triggerPlayer, __jreal(0), __jreal(0), "Error: Too many arguments for -setfeed.")
        do return end
    end
    if (not SetFeedIsUnsignedInteger(token2)) then
        if ((playerNumber == 0) and (not SetFeedIsUnsignedInteger(token1))) then
            DisplayTextToPlayer((triggerPlayer), __jreal(0), __jreal(0), __jconcat("Error: Cannot find player called ", (playerNameForError)))
            do return end
        end
        DisplayTextToPlayer(triggerPlayer, __jreal(0), __jreal(0), "Error: Feedrate must be a whole number from 50 to 200.")
        do return end
    end
    y = S2I(token2)
    if ((playerNumber == 0) and (not SetFeedIsUnsignedInteger(token1))) then
        DisplayTextToPlayer((triggerPlayer), __jreal(0), __jreal(0), __jconcat("Error: Cannot find player called ", (playerNameForError)))
        do return end
    end
    if ((y < 50) or (y > 200)) then
        DisplayTextToPlayer((triggerPlayer), __jreal(0), __jreal(0), __jconcat(__jconcat("Error: Feedrate ", (token2)), " is outside allowed range. Use 50 to 200."))
        do return end
    end
    if ((playerNumber < 1) or (playerNumber > 11)) then
        DisplayTextToPlayer(triggerPlayer, __jreal(0), __jreal(0), "Error: Player number must be between 1 and 11.")
        do return end
    end
    udg_ExperienceRate[__jint(playerNumber - 1)] = I2R(y)
    DisplayTextToPlayer(triggerPlayer, __jreal(0), __jreal(0), __jconcat(__jconcat(__jconcat(__jconcat("Feedrate of player ", I2S(playerNumber)), " is set to "), I2S(y)), "%"))
end
-- END FOREST SECTION 23

-- BEGIN FOREST SECTION 24 FeedReduction
-- Original JASS function: FR_ScaledInt (line 6131)
function FR_ScaledInt(value, percent)
    if ((value <= 0) or (percent <= __jreal(0.00))) then
        do return 0 end
    end
    do return R2I(__jreal(__jreal(__jreal(I2R(value) * percent) * __jreal(0.01)) + __jreal(0.50))) end
end

-- Original JASS function: FR_ApplyGoldBountyRate (line 6138)
function FR_ApplyGoldBountyRate(target, percent)
    local base = BlzGetUnitIntegerField(target, UNIT_IF_GOLD_BOUNTY_AWARDED_BASE)
    local dice = BlzGetUnitIntegerField(target, UNIT_IF_GOLD_BOUNTY_AWARDED_NUMBER_OF_DICE)
    local sides = BlzGetUnitIntegerField(target, UNIT_IF_GOLD_BOUNTY_AWARDED_SIDES_PER_DIE)
    local newBase = FR_ScaledInt(base, percent)
    local newSides = FR_ScaledInt(sides, percent)
    if (percent <= __jreal(0.00)) then
        BlzSetUnitIntegerField(target, UNIT_IF_GOLD_BOUNTY_AWARDED_BASE, 0)
        BlzSetUnitIntegerField(target, UNIT_IF_GOLD_BOUNTY_AWARDED_NUMBER_OF_DICE, 0)
        BlzSetUnitIntegerField(target, UNIT_IF_GOLD_BOUNTY_AWARDED_SIDES_PER_DIE, 0)
    else
        BlzSetUnitIntegerField(target, UNIT_IF_GOLD_BOUNTY_AWARDED_BASE, newBase)
        BlzSetUnitIntegerField(target, UNIT_IF_GOLD_BOUNTY_AWARDED_NUMBER_OF_DICE, dice)
        BlzSetUnitIntegerField(target, UNIT_IF_GOLD_BOUNTY_AWARDED_SIDES_PER_DIE, newSides)
    end
end

-- Original JASS function: Trig_FeedReduction_Actions (line 6156)
function Trig_FeedReduction_Actions()
    local target = udg_DamageEventTarget
    local rate = udg_ExperienceRate[(__jint(GetConvertedPlayerId(GetOwningPlayer(target)) - 1))]
    SetPlayerHandicapXPBJ(FE_Roles.ancient(), rate)
    FR_ApplyGoldBountyRate(target, rate)
    target = nil
end

-- Original JASS function: InitTrig_FeedReduction (line 6167)
function InitTrig_FeedReduction()
    gg_trg_FeedReduction = CreateTrigger()
    h__TriggerRegisterVariableEvent(gg_trg_FeedReduction, "udg_LethalDamageEvent", EQUAL, __jreal(1.00))
    TriggerAddAction(gg_trg_FeedReduction, Trig_FeedReduction_Actions)
end
-- END FOREST SECTION 24

-- BEGIN FOREST SECTION 25 SetFeed
-- Original JASS function: Trig_SetFeed_Actions (line 6175)
function Trig_SetFeed_Actions()
    HandleSetExp(GetTriggerPlayer(), GetEventPlayerChatString())
end

-- Original JASS function: InitTrig_SetFeed (line 6180)
function InitTrig_SetFeed()
    gg_trg_SetFeed = CreateTrigger()
    TriggerRegisterPlayerChatEvent(gg_trg_SetFeed, Player(0), "-setfeed", false)
    TriggerAddAction(gg_trg_SetFeed, Trig_SetFeed_Actions)
end
-- END FOREST SECTION 25

-- BEGIN FOREST SECTION 26 CheckFeedRates
-- Original JASS function: Trig_CheckFeedRates_PlayerLabel (line 6189)
function Trig_CheckFeedRates_PlayerLabel(i)
    if (i == 0) then
        do return "|cffff0303Player 1|r" end
    elseif (i == 1) then
        do return "|cff0042ffPlayer 2|r" end
    elseif (i == 2) then
        do return "|cff1ce6b9Player 3|r" end
    elseif (i == 3) then
        do return "|cff540081Player 4|r" end
    elseif (i == 4) then
        do return "|cfffffc01Player 5|r" end
    elseif (i == 5) then
        do return "|cffff8a0ePlayer 6|r" end
    elseif (i == 6) then
        do return "|cff20c000Player 7|r" end
    elseif (i == 7) then
        do return "|cffe55bb0Player 8|r" end
    elseif (i == 8) then
        do return "|cff959697Player 9|r" end
    elseif (i == 9) then
        do return "|cff7ebff1Player 10|r" end
    elseif (i == 10) then
        do return "|cff106246Player 11|r" end
    end
    do return __jconcat("Player ", I2S(__jint(i + 1))) end
end

-- Original JASS function: Trig_CheckFeedRates_Actions (line 6217)
function Trig_CheckFeedRates_Actions()
    local i = 0
    local output = "|cffffcc00Current feed rates:|r"
    while true do
        if (i >= 11) then break end
        output = __jconcat(__jconcat(__jconcat(__jconcat(__jconcat(output, "\n"), Trig_CheckFeedRates_PlayerLabel(i)), ": |cffffffff"), I2S(R2I(__jreal(udg_ExperienceRate[i] + __jreal(0.50))))), "%|r")
        i = __jint(i + 1)
    end
    DisplayTextToPlayer(GetTriggerPlayer(), __jreal(0), __jreal(0), output)
end

-- Original JASS function: InitTrig_CheckFeedRates (line 6231)
function InitTrig_CheckFeedRates()
    local i = 0
    gg_trg_CheckFeedRates = CreateTrigger()
    while true do
        if (i >= 11) then break end
        TriggerRegisterPlayerChatEvent(gg_trg_CheckFeedRates, Player(i), "-feedrates", false)
        i = __jint(i + 1)
    end
    TriggerAddAction(gg_trg_CheckFeedRates, Trig_CheckFeedRates_Actions)
end
-- END FOREST SECTION 26
-- END FOREST MODULE src/economy/feed.lua

-- BEGIN FOREST MODULE src/races/bounty_hunter.lua
-- races / bounty_hunter
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 29 Snipe_Shot
-- Original JASS function: SnipeShot_IsAlive (line 6312)
function SnipeShot_IsAlive(u)
    do return (((u ~= nil) and (GetWidgetLife(u) > __jreal(0.405))) and (not IsUnitType(u, UNIT_TYPE_DEAD))) end
end

-- Original JASS function: SnipeShot_IsValidTarget (line 6316)
function SnipeShot_IsValidTarget(u, p)
    do return ((SnipeShot_IsAlive(u) and IsUnitEnemy(u, p)) and (not IsUnitType(u, UNIT_TYPE_FLYING))) end
end

-- Original JASS function: SnipeShot_StartCooldown (line 6320)
function SnipeShot_StartCooldown(caster)
    if (caster ~= nil) then
        BlzStartUnitAbilityCooldown(caster, SNIPESHOT_ABILITY_ID, SNIPESHOT_COOLDOWN)
    end
end

-- Original JASS function: SnipeShot_GetHitTarget (line 6326)
function SnipeShot_GetHitTarget(x, y, p)
    local u = nil
    local best = nil
    local dx = 0.0
    local dy = 0.0
    local d2 = 0.0
    local bestD2 = __jreal(999999999.00)
    GroupEnumUnitsInRange(SNIPESHOT_Group, x, y, SNIPESHOT_COLLISION, nil)
    while true do
        u = FirstOfGroup(SNIPESHOT_Group)
        if (u == nil) then break end
        GroupRemoveUnit(SNIPESHOT_Group, u)
        if SnipeShot_IsValidTarget(u, p) then
            dx = __jreal(GetUnitX(u) - x)
            dy = __jreal(GetUnitY(u) - y)
            d2 = __jreal(__jreal(dx * dx) + __jreal(dy * dy))
            if (d2 < bestD2) then
                bestD2 = d2
                best = u
            end
        end
    end
    u = nil
    do return best end
end

-- Original JASS function: SnipeShot_StunTarget (line 6357)
function SnipeShot_StunTarget(p, x, y, target)
    local dummy = CreateUnit(p, SNIPESHOT_DUMMY_ID, x, y, __jreal(0.00))
    UnitAddAbility(dummy, SNIPESHOT_STUN_ABILITY_ID)
    SetUnitAbilityLevel(dummy, SNIPESHOT_STUN_ABILITY_ID, 1)
    IssueTargetOrder(dummy, SNIPESHOT_STUN_ORDER, target)
    UnitApplyTimedLife(dummy, FourCC("BTLF"), __jreal(1.00))
    dummy = nil
end

-- Original JASS function: SnipeShot_EndMissile (line 6368)
function SnipeShot_EndMissile(t)
    local id = GetHandleId(t)
    local fx = LoadEffectHandle(SNIPESHOT_Hash, id, 2)
    if (fx ~= nil) then
        DestroyEffect(fx)
    end
    FlushChildHashtable(SNIPESHOT_Hash, id)
    PauseTimer(t)
    DestroyTimer(t)
    fx = nil
end

-- Original JASS function: SnipeShot_MissileLoop (line 6383)
function SnipeShot_MissileLoop()
    local t = GetExpiredTimer()
    local id = GetHandleId(t)
    local caster = LoadUnitHandle(SNIPESHOT_Hash, id, 0)
    local p = LoadPlayerHandle(SNIPESHOT_Hash, id, 1)
    local fx = LoadEffectHandle(SNIPESHOT_Hash, id, 2)
    local x = LoadReal(SNIPESHOT_Hash, id, 3)
    local y = LoadReal(SNIPESHOT_Hash, id, 4)
    local dx = LoadReal(SNIPESHOT_Hash, id, 5)
    local dy = LoadReal(SNIPESHOT_Hash, id, 6)
    local travelled = LoadReal(SNIPESHOT_Hash, id, 7)
    local maxDist = LoadReal(SNIPESHOT_Hash, id, 8)
    local step = __jreal(SNIPESHOT_SPEED * SNIPESHOT_PERIOD)
    local remaining = __jreal(maxDist - travelled)
    local hit = nil
    local damage = 0.0
    if (((caster == nil) or (not SnipeShot_IsAlive(caster))) or (remaining <= __jreal(0.00))) then
        SnipeShot_EndMissile(t)
    else
        if (step > remaining) then
            step = remaining
        end
        x = __jreal(x + __jreal(dx * step))
        y = __jreal(y + __jreal(dy * step))
        travelled = __jreal(travelled + step)
        BlzSetSpecialEffectPosition(fx, x, y, SNIPESHOT_MISSILE_HEIGHT)
        hit = SnipeShot_GetHitTarget(x, y, p)
        if (hit ~= nil) then
            damage = __jreal(__jreal(SNIPESHOT_DAMAGE_PER_STEP * travelled) / SNIPESHOT_DAMAGE_DISTANCE_STEP)
            UnitDamageTarget(caster, hit, damage, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
            SnipeShot_StunTarget(p, x, y, hit)
            SnipeShot_EndMissile(t)
        elseif (travelled >= maxDist) then
            SnipeShot_EndMissile(t)
        else
            SaveReal(SNIPESHOT_Hash, id, 3, x)
            SaveReal(SNIPESHOT_Hash, id, 4, y)
            SaveReal(SNIPESHOT_Hash, id, 7, travelled)
        end
    end
    hit = nil
    caster = nil
    p = nil
    fx = nil
    t = nil
end

-- Original JASS function: SnipeShot_StartMissile (line 6436)
function SnipeShot_StartMissile(caster, tx, ty)
    local t = CreateTimer()
    local id = GetHandleId(t)
    local p = GetOwningPlayer(caster)
    local x = GetUnitX(caster)
    local y = GetUnitY(caster)
    local dx = __jreal(tx - x)
    local dy = __jreal(ty - y)
    local dist = SquareRoot(__jreal(__jreal(dx * dx) + __jreal(dy * dy)))
    local angle = 0.0
    local fx = nil
    if (dist <= __jreal(1.00)) then
        angle = __jreal(GetUnitFacing(caster) * bj_DEGTORAD)
        dx = Cos(angle)
        dy = Sin(angle)
    else
        dx = __jreal(dx / dist)
        dy = __jreal(dy / dist)
    end
    fx = AddSpecialEffect(SNIPESHOT_MISSILE_MODEL, x, y)
    BlzSetSpecialEffectPosition(fx, x, y, SNIPESHOT_MISSILE_HEIGHT)
    BlzSetSpecialEffectYaw(fx, Atan2(dy, dx))
    SaveUnitHandle(SNIPESHOT_Hash, id, 0, caster)
    SavePlayerHandle(SNIPESHOT_Hash, id, 1, p)
    SaveEffectHandle(SNIPESHOT_Hash, id, 2, fx)
    SaveReal(SNIPESHOT_Hash, id, 3, x)
    SaveReal(SNIPESHOT_Hash, id, 4, y)
    SaveReal(SNIPESHOT_Hash, id, 5, dx)
    SaveReal(SNIPESHOT_Hash, id, 6, dy)
    SaveReal(SNIPESHOT_Hash, id, 7, __jreal(0.00))
    SaveReal(SNIPESHOT_Hash, id, 8, SNIPESHOT_MAX_RANGE)
    TimerStart(t, SNIPESHOT_PERIOD, true, SnipeShot_MissileLoop)
    fx = nil
    p = nil
    t = nil
end

-- Original JASS function: SnipeShot_OnChannel (line 6478)
function SnipeShot_OnChannel()
    local caster = GetTriggerUnit()
    local casterId = 0
    if (GetSpellAbilityId() == SNIPESHOT_ABILITY_ID) then
        casterId = GetHandleId(caster)
        SaveBoolean(SNIPESHOT_Hash, casterId, 100, true)
        SaveReal(SNIPESHOT_Hash, casterId, 101, GetSpellTargetX())
        SaveReal(SNIPESHOT_Hash, casterId, 102, GetSpellTargetY())
    end
    caster = nil
end

-- Original JASS function: SnipeShot_OnFinish (line 6493)
function SnipeShot_OnFinish()
    local caster = GetTriggerUnit()
    local casterId = 0
    local tx = 0.0
    local ty = 0.0
    if (GetSpellAbilityId() == SNIPESHOT_ABILITY_ID) then
        casterId = GetHandleId(caster)
        if (LoadBoolean(SNIPESHOT_Hash, casterId, 100) and SnipeShot_IsAlive(caster)) then
            tx = LoadReal(SNIPESHOT_Hash, casterId, 101)
            ty = LoadReal(SNIPESHOT_Hash, casterId, 102)
            FlushChildHashtable(SNIPESHOT_Hash, casterId)
            SnipeShot_StartCooldown(caster)
            SetUnitAnimation(caster, "attack")
            SnipeShot_StartMissile(caster, tx, ty)
        end
    end
    caster = nil
end

-- Original JASS function: InitTrig_Snipe_Shot (line 6516)
function InitTrig_Snipe_Shot()
    local channelTrig = CreateTrigger()
    local finishTrig = CreateTrigger()
    local i = 0
    while true do
        if (i >= bj_MAX_PLAYER_SLOTS) then break end
        TriggerRegisterPlayerUnitEvent(channelTrig, Player(i), EVENT_PLAYER_UNIT_SPELL_CHANNEL, nil)
        TriggerRegisterPlayerUnitEvent(finishTrig, Player(i), EVENT_PLAYER_UNIT_SPELL_FINISH, nil)
        i = __jint(i + 1)
    end
    TriggerAddAction(channelTrig, SnipeShot_OnChannel)
    TriggerAddAction(finishTrig, SnipeShot_OnFinish)
    channelTrig = nil
    finishTrig = nil
end
-- END FOREST SECTION 29

-- BEGIN FOREST SECTION 30 Dash
-- Original JASS function: Dash_CreateTrail (line 6538)
function Dash_CreateTrail(u)
    local e = AddSpecialEffect(DASH_TRAIL_EFFECT, GetUnitX(u), GetUnitY(u))
    DestroyEffect(e)
    e = nil
end

-- Original JASS function: Dash_Stop (line 6546)
function Dash_Stop(t)
    local id = GetHandleId(t)
    local u = LoadUnitHandle(DashHash, id, 0)
    local e = LoadEffectHandle(DashHash, id, 4)
    if (e ~= nil) then
        DestroyEffect(e)
    end
    if (u ~= nil) then
        ResetUnitAnimation(u)
    end
    FlushChildHashtable(DashHash, id)
    PauseTimer(t)
    DestroyTimer(t)
    e = nil
    u = nil
    t = nil
end

-- Original JASS function: Dash_TryMove (line 6568)
function Dash_TryMove(u, nx, ny)
    local ox = GetUnitX(u)
    local oy = GetUnitY(u)
    local ax = 0.0
    local ay = 0.0
    SetUnitPosition(u, nx, ny)
    ax = GetUnitX(u)
    ay = GetUnitY(u)
    if (__jreal(__jreal((__jreal(ax - nx)) * (__jreal(ax - nx))) + __jreal((__jreal(ay - ny)) * (__jreal(ay - ny)))) > __jreal(25.00)) then
        SetUnitPosition(u, ox, oy)
        do return false end
    end
    do return true end
end

-- Original JASS function: Dash_TrySlideStep (line 6588)
function Dash_TrySlideStep(u, angle, step)
    local x = GetUnitX(u)
    local y = GetUnitY(u)
    local nx = 0.0
    local ny = 0.0
    nx = __jreal(x + __jreal(step * Cos(angle)))
    ny = __jreal(y + __jreal(step * Sin(angle)))
    if Dash_TryMove(u, nx, ny) then
        do return step end
    end
    nx = __jreal(x + __jreal(step * Cos(__jreal(angle + __jreal(0.785398)))))
    ny = __jreal(y + __jreal(step * Sin(__jreal(angle + __jreal(0.785398)))))
    if Dash_TryMove(u, nx, ny) then
        do return step end
    end
    nx = __jreal(x + __jreal(step * Cos(__jreal(angle - __jreal(0.785398)))))
    ny = __jreal(y + __jreal(step * Sin(__jreal(angle - __jreal(0.785398)))))
    if Dash_TryMove(u, nx, ny) then
        do return step end
    end
    nx = __jreal(x + __jreal(step * Cos(__jreal(angle + __jreal(1.570796)))))
    ny = __jreal(y + __jreal(step * Sin(__jreal(angle + __jreal(1.570796)))))
    if Dash_TryMove(u, nx, ny) then
        do return step end
    end
    nx = __jreal(x + __jreal(step * Cos(__jreal(angle - __jreal(1.570796)))))
    ny = __jreal(y + __jreal(step * Sin(__jreal(angle - __jreal(1.570796)))))
    if Dash_TryMove(u, nx, ny) then
        do return step end
    end
    do return __jreal(0.00) end
end

-- Original JASS function: Dash_Loop (line 6638)
function Dash_Loop()
    local t = GetExpiredTimer()
    local id = GetHandleId(t)
    local u = LoadUnitHandle(DashHash, id, 0)
    local angle = LoadReal(DashHash, id, 1)
    local moved = LoadReal(DashHash, id, 2)
    local targetRange = LoadReal(DashHash, id, 3)
    local tickDistance = __jreal(DASH_SPEED * DASH_PERIOD)
    local subStep = __jreal(6.00)
    local moveNow = 0.0
    if ((u == nil) or (GetWidgetLife(u) <= __jreal(0.405))) then
        Dash_Stop(t)
        t = nil
        u = nil
        do return end
    end
    if (__jreal(moved + tickDistance) > targetRange) then
        tickDistance = __jreal(targetRange - moved)
    end
    while true do
        if (tickDistance <= __jreal(0.00)) then break end
        if (tickDistance < subStep) then
            moveNow = tickDistance
        else
            moveNow = subStep
        end
        moveNow = Dash_TrySlideStep(u, angle, moveNow)
        if (moveNow <= __jreal(0.00)) then
            Dash_Stop(t)
            t = nil
            u = nil
            do return end
        end
        moved = __jreal(moved + moveNow)
        SaveReal(DashHash, id, 5, __jreal(LoadReal(DashHash, id, 5) + moveNow))
        if (LoadReal(DashHash, id, 5) >= DASH_TRAIL_INTERVAL) then
            Dash_CreateTrail(u)
            SaveReal(DashHash, id, 5, __jreal(0.00))
        end
        tickDistance = __jreal(tickDistance - moveNow)
    end
    SaveReal(DashHash, id, 2, moved)
    if (moved >= targetRange) then
        Dash_Stop(t)
    end
    t = nil
    u = nil
end

-- Original JASS function: StartDash (line 6702)
function StartDash(u, tx, ty)
    local t = CreateTimer()
    local id = GetHandleId(t)
    local ux = GetUnitX(u)
    local uy = GetUnitY(u)
    local dx = __jreal(tx - ux)
    local dy = __jreal(ty - uy)
    local dist = SquareRoot(__jreal(__jreal(dx * dx) + __jreal(dy * dy)))
    local angle = 0.0
    local e = nil
    if (dist <= __jreal(10.00)) then
        DestroyTimer(t)
        t = nil
        do return end
    end
    if (dist > DASH_RANGE) then
        dist = DASH_RANGE
    end
    angle = Atan2(dy, dx)
    SetUnitAnimation(u, "walk")
    e = AddSpecialEffectTarget(DASH_ATTACH_EFFECT, u, "origin")
    SaveUnitHandle(DashHash, id, 0, u)
    SaveReal(DashHash, id, 1, angle)
    SaveReal(DashHash, id, 2, __jreal(0.00))
    SaveReal(DashHash, id, 3, dist)
    SaveEffectHandle(DashHash, id, 4, e)
    SaveReal(DashHash, id, 5, __jreal(0.00))
    TimerStart(t, DASH_PERIOD, true, Dash_Loop)
    e = nil
    t = nil
end

-- Original JASS function: Dash_Condition (line 6746)
function Dash_Condition()
    do return (GetSpellAbilityId() == FourCC("A0EW")) end
end

-- Original JASS function: Dash_Action (line 6750)
function Dash_Action()
    StartDash(GetTriggerUnit(), GetSpellTargetX(), GetSpellTargetY())
end

-- Original JASS function: InitTrig_Dash (line 6755)
function InitTrig_Dash()
    local trg = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(trg, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(trg, Condition(Dash_Condition))
    TriggerAddAction(trg, Dash_Action)
    trg = nil
end
-- END FOREST SECTION 30

-- BEGIN FOREST SECTION 31 Rome
-- Original JASS function: Trig_Rome_Conditions (line 6767)
function Trig_Rome_Conditions()
    if ((not ((UnitHasBuffBJ(udg_DamageEventTarget, FourCC("B03L")) == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Rome_Actions (line 6774)
function Trig_Rome_Actions()
    udg_DamageEventAmount = (__jreal(udg_DamageEventAmount * __jreal(0.60)))
end

-- Original JASS function: InitTrig_Rome (line 6779)
function InitTrig_Rome()
    gg_trg_Rome = CreateTrigger()
    h__TriggerRegisterVariableEvent(gg_trg_Rome, "udg_DamageEvent", EQUAL, __jreal(1.00))
    TriggerAddCondition(gg_trg_Rome, Condition(Trig_Rome_Conditions))
    TriggerAddAction(gg_trg_Rome, Trig_Rome_Actions)
end
-- END FOREST SECTION 31

-- BEGIN FOREST SECTION 32 Basic_Bounty_Hit
-- Original JASS function: Trig_Basic_Bounty_Hit_Func009Func002C (line 6789)
function Trig_Basic_Bounty_Hit_Func009Func002C()
    if (((GetUnitTypeId(udg_DamageEventSource) == FourCC("h05W")))) then
        do return true end
    end
    do return false end
end

-- Original JASS function: Trig_Basic_Bounty_Hit_Func009C (line 6796)
function Trig_Basic_Bounty_Hit_Func009C()
    if ((not ((IsUnitEnemy(udg_DamageEventSource, GetOwningPlayer(udg_DamageEventTarget)) == true)))) then
        do return false end
    end
    if ((not Trig_Basic_Bounty_Hit_Func009Func002C())) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Basic_Bounty_Hit_Conditions (line 6806)
function Trig_Basic_Bounty_Hit_Conditions()
    if ((not Trig_Basic_Bounty_Hit_Func009C())) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Basic_Bounty_Hit_Actions (line 6813)
function Trig_Basic_Bounty_Hit_Actions()
    AdjustPlayerStateBJ(35, GetOwningPlayer(udg_DamageEventSource), PLAYER_STATE_RESOURCE_LUMBER)
    AdjustPlayerStateBJ(1, GetOwningPlayer(udg_DamageEventSource), PLAYER_STATE_RESOURCE_GOLD)
    CreateTextTagUnitBJ("TRIGSTR_124", GetEventDamageSource(), __jreal(0), __jreal(9.00), __jreal(100), __jreal(100), __jreal(100), __jreal(0.35))
    SetTextTagPermanentBJ(GetLastCreatedTextTag(), false)
    SetTextTagLifespanBJ(GetLastCreatedTextTag(), __jreal(0.80))
    SetTextTagVelocityBJ(GetLastCreatedTextTag(), __jreal(42.00), __jreal(90))
    SetTextTagFadepointBJ(GetLastCreatedTextTag(), __jreal(0.30))
end

-- Original JASS function: InitTrig_Basic_Bounty_Hit (line 6824)
function InitTrig_Basic_Bounty_Hit()
    gg_trg_Basic_Bounty_Hit = CreateTrigger()
    h__TriggerRegisterVariableEvent(gg_trg_Basic_Bounty_Hit, "udg_DamageEvent", EQUAL, __jreal(1.00))
    TriggerAddCondition(gg_trg_Basic_Bounty_Hit, Condition(Trig_Basic_Bounty_Hit_Conditions))
    TriggerAddAction(gg_trg_Basic_Bounty_Hit, Trig_Basic_Bounty_Hit_Actions)
end
-- END FOREST SECTION 32

-- BEGIN FOREST SECTION 33 Improved_Bounty_Hit
-- Original JASS function: Trig_Improved_Bounty_Hit_Func009Func002C (line 6834)
function Trig_Improved_Bounty_Hit_Func009Func002C()
    if (((GetUnitTypeId(udg_DamageEventSource) == FourCC("h06H")))) then
        do return true end
    end
    if (((GetUnitTypeId(udg_DamageEventSource) == FourCC("h06C")))) then
        do return true end
    end
    do return false end
end

-- Original JASS function: Trig_Improved_Bounty_Hit_Func009C (line 6844)
function Trig_Improved_Bounty_Hit_Func009C()
    if ((not ((IsUnitEnemy(udg_DamageEventSource, GetOwningPlayer(udg_DamageEventTarget)) == true)))) then
        do return false end
    end
    if ((not Trig_Improved_Bounty_Hit_Func009Func002C())) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Improved_Bounty_Hit_Conditions (line 6854)
function Trig_Improved_Bounty_Hit_Conditions()
    if ((not Trig_Improved_Bounty_Hit_Func009C())) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Improved_Bounty_Hit_Actions (line 6861)
function Trig_Improved_Bounty_Hit_Actions()
    AdjustPlayerStateBJ(75, GetOwningPlayer(udg_DamageEventSource), PLAYER_STATE_RESOURCE_LUMBER)
    AdjustPlayerStateBJ(2, GetOwningPlayer(udg_DamageEventSource), PLAYER_STATE_RESOURCE_GOLD)
    CreateTextTagUnitBJ("TRIGSTR_1382", GetEventDamageSource(), __jreal(0), __jreal(9.00), __jreal(100), __jreal(100), __jreal(100), __jreal(0.35))
    SetTextTagPermanentBJ(GetLastCreatedTextTag(), false)
    SetTextTagLifespanBJ(GetLastCreatedTextTag(), __jreal(0.80))
    SetTextTagVelocityBJ(GetLastCreatedTextTag(), __jreal(42.00), __jreal(90))
    SetTextTagFadepointBJ(GetLastCreatedTextTag(), __jreal(0.30))
end

-- Original JASS function: InitTrig_Improved_Bounty_Hit (line 6872)
function InitTrig_Improved_Bounty_Hit()
    gg_trg_Improved_Bounty_Hit = CreateTrigger()
    h__TriggerRegisterVariableEvent(gg_trg_Improved_Bounty_Hit, "udg_DamageEvent", EQUAL, __jreal(1.00))
    TriggerAddCondition(gg_trg_Improved_Bounty_Hit, Condition(Trig_Improved_Bounty_Hit_Conditions))
    TriggerAddAction(gg_trg_Improved_Bounty_Hit, Trig_Improved_Bounty_Hit_Actions)
end
-- END FOREST SECTION 33

-- BEGIN FOREST SECTION 34 Harvest_Grapes
-- Original JASS function: Trig_Harvest_Grapes_Conditions (line 6882)
function Trig_Harvest_Grapes_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A0DB"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Harvest_Grapes_Actions (line 6889)
function Trig_Harvest_Grapes_Actions()
    CreateItemLoc(FourCC("I027"), GetUnitLoc(GetSpellAbilityUnit()))
    IssueTargetItemOrder(GetSpellAbilityUnit(), "smart", GetLastCreatedItem())
end

-- Original JASS function: InitTrig_Harvest_Grapes (line 6895)
function InitTrig_Harvest_Grapes()
    gg_trg_Harvest_Grapes = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Harvest_Grapes, EVENT_PLAYER_UNIT_SPELL_FINISH)
    TriggerAddCondition(gg_trg_Harvest_Grapes, Condition(Trig_Harvest_Grapes_Conditions))
    TriggerAddAction(gg_trg_Harvest_Grapes, Trig_Harvest_Grapes_Actions)
end
-- END FOREST SECTION 34

-- BEGIN FOREST SECTION 35 Bullets_Switch
-- Original JASS function: Trig_Bullets_Switch_Func002C (line 6905)
function Trig_Bullets_Switch_Func002C()
    if ((not ((GetSpellAbilityId() == FourCC("A0DE"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Bullets_Switch_Conditions (line 6912)
function Trig_Bullets_Switch_Conditions()
    if ((not Trig_Bullets_Switch_Func002C())) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Bullets_Switch_Func001C (line 6919)
function Trig_Bullets_Switch_Func001C()
    if ((not ((BlzGetUnitWeaponIntegerField(GetTriggerUnit(), UNIT_WEAPON_IF_ATTACK_ATTACK_TYPE, 0) == 5)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Bullets_Switch_Actions (line 6926)
function Trig_Bullets_Switch_Actions()
    if (Trig_Bullets_Switch_Func001C()) then
        BlzSetUnitWeaponIntegerFieldBJ(GetTriggerUnit(), UNIT_WEAPON_IF_ATTACK_ATTACK_TYPE, 0, 2)
    else
        BlzSetUnitWeaponIntegerFieldBJ(GetTriggerUnit(), UNIT_WEAPON_IF_ATTACK_ATTACK_TYPE, 0, 5)
    end
end

-- Original JASS function: InitTrig_Bullets_Switch (line 6935)
function InitTrig_Bullets_Switch()
    gg_trg_Bullets_Switch = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Bullets_Switch, EVENT_PLAYER_UNIT_SPELL_FINISH)
    TriggerAddCondition(gg_trg_Bullets_Switch, Condition(Trig_Bullets_Switch_Conditions))
    TriggerAddAction(gg_trg_Bullets_Switch, Trig_Bullets_Switch_Actions)
end
-- END FOREST SECTION 35
-- END FOREST MODULE src/races/bounty_hunter.lua

-- BEGIN FOREST MODULE src/races/cultist.lua
-- races / cultist
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 36 Limb_Throw
-- Original JASS function: Trig_Limb_Throw_Conditions (line 6945)
function Trig_Limb_Throw_Conditions()
    if ((not ((GetUnitTypeId(GetSpellAbilityUnit()) == FourCC("H064"))))) then
        do return false end
    end
    if ((not ((GetSpellAbilityId() == FourCC("A0EE"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Limb_Throw_Actions (line 6955)
function Trig_Limb_Throw_Actions()
    SetUnitLifeBJ(GetSpellAbilityUnit(), (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, GetSpellAbilityUnit()) - (__jreal(GetUnitStateSwap(UNIT_STATE_MAX_LIFE, GetSpellAbilityUnit()) * __jreal(0.15))))))
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_8758")
end

-- Original JASS function: InitTrig_Limb_Throw (line 6961)
function InitTrig_Limb_Throw()
    gg_trg_Limb_Throw = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Limb_Throw, EVENT_PLAYER_UNIT_SPELL_CAST)
    TriggerAddCondition(gg_trg_Limb_Throw, Condition(Trig_Limb_Throw_Conditions))
    TriggerAddAction(gg_trg_Limb_Throw, Trig_Limb_Throw_Actions)
end
-- END FOREST SECTION 36

-- BEGIN FOREST SECTION 37 Flesh_Stampede
-- Original JASS function: FleshStampede_Remove (line 6972)
function FleshStampede_Remove(u)
    local id = 0
    if (u == nil) then
        do return end
    end
    id = GetHandleId(u)
    GroupRemoveUnit(FleshStampede_Group, u)
    FlushChildHashtable(FleshStampede_Hash, id)
end

-- Original JASS function: FleshStampede_Add (line 6984)
function FleshStampede_Add(u)
    local id = 0
    if (u == nil) then
        do return end
    end
    if (GetUnitAbilityLevel(u, FLESH_STAMPEDE_ABILITY_ID) <= 0) then
        do return end
    end
    id = GetHandleId(u)
    GroupAddUnit(FleshStampede_Group, u)
    SaveInteger(FleshStampede_Hash, id, FLESH_STAMPEDE_MISS_KEY, 0)
    EnableTrigger(gg_trg_Flesh_Stampede)
end

-- Original JASS function: FleshStampede_LoopEnum (line 7001)
function FleshStampede_LoopEnum()
    local u = GetEnumUnit()
    local id = GetHandleId(u)
    local missCount = 0
    if (GetUnitState(u, UNIT_STATE_LIFE) <= __jreal(0.405)) then
        FleshStampede_Remove(u)
    elseif (GetUnitAbilityLevel(u, FLESH_STAMPEDE_ABILITY_ID) <= 0) then
        FleshStampede_Remove(u)
    elseif UnitHasBuffBJ(u, FLESH_STAMPEDE_BUFF_ID) then
        SaveInteger(FleshStampede_Hash, id, FLESH_STAMPEDE_MISS_KEY, 0)
        SetUnitLifeBJ(u, __jreal(GetUnitState(u, UNIT_STATE_LIFE) - (__jreal(GetUnitState(u, UNIT_STATE_MAX_LIFE) * FLESH_STAMPEDE_DAMAGE_FACTOR))))
    else
        missCount = __jint(LoadInteger(FleshStampede_Hash, id, FLESH_STAMPEDE_MISS_KEY) + 1)
        if (missCount >= FLESH_STAMPEDE_MISS_LIMIT) then
            FleshStampede_Remove(u)
        else
            SaveInteger(FleshStampede_Hash, id, FLESH_STAMPEDE_MISS_KEY, missCount)
        end
    end
    u = nil
end

-- Original JASS function: Trig_Flesh_Stampede_Actions (line 7026)
function Trig_Flesh_Stampede_Actions()
    ForGroup(FleshStampede_Group, FleshStampede_LoopEnum)
    if (FirstOfGroup(FleshStampede_Group) == nil) then
        DisableTrigger(gg_trg_Flesh_Stampede)
    end
end

-- Original JASS function: FleshStampede_Order_Conditions (line 7034)
function FleshStampede_Order_Conditions()
    do return (GetUnitAbilityLevel(GetTriggerUnit(), FLESH_STAMPEDE_ABILITY_ID) > 0) end
end

-- Original JASS function: FleshStampede_Order_Actions (line 7038)
function FleshStampede_Order_Actions()
    local u = GetTriggerUnit()
    local orderId = GetIssuedOrderId()
    if (orderId == OrderId("immolation")) then
        FleshStampede_Add(u)
    elseif (orderId == OrderId("unimmolation")) then
        FleshStampede_Remove(u)
    end
    u = nil
end

-- Original JASS function: FleshStampede_Death_Actions (line 7051)
function FleshStampede_Death_Actions()
    local u = GetTriggerUnit()
    if IsUnitInGroup(u, FleshStampede_Group) then
        FleshStampede_Remove(u)
    end
    u = nil
end

-- Original JASS function: InitTrig_Flesh_Stampede (line 7062)
function InitTrig_Flesh_Stampede()
    local orderTrig = CreateTrigger()
    local deathTrig = CreateTrigger()
    if (FleshStampede_Group == nil) then
        FleshStampede_Group = CreateGroup()
    end
    if (FleshStampede_Hash == nil) then
        FleshStampede_Hash = InitHashtable()
    end
    gg_trg_Flesh_Stampede = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(gg_trg_Flesh_Stampede, FLESH_STAMPEDE_PERIOD)
    TriggerAddAction(gg_trg_Flesh_Stampede, Trig_Flesh_Stampede_Actions)
    DisableTrigger(gg_trg_Flesh_Stampede)
    TriggerRegisterAnyUnitEventBJ(orderTrig, EVENT_PLAYER_UNIT_ISSUED_ORDER)
    TriggerAddCondition(orderTrig, Condition(FleshStampede_Order_Conditions))
    TriggerAddAction(orderTrig, FleshStampede_Order_Actions)
    TriggerRegisterAnyUnitEventBJ(deathTrig, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddAction(deathTrig, FleshStampede_Death_Actions)
    orderTrig = nil
    deathTrig = nil
end
-- END FOREST SECTION 37

-- BEGIN FOREST SECTION 38 Amalgamation
-- Original JASS function: Trig_Amalgamation_Conditions (line 7092)
function Trig_Amalgamation_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("H064"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Amalgamation_Func001Func002C (line 7099)
function Trig_Amalgamation_Func001Func002C()
    if ((not ((GetIssuedOrderIdBJ() == String2OrderIdBJ("unimmolation"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Amalgamation_Func001C (line 7106)
function Trig_Amalgamation_Func001C()
    if ((not ((GetIssuedOrderIdBJ() == String2OrderIdBJ("immolation"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Amalgamation_Actions (line 7113)
function Trig_Amalgamation_Actions()
    if (Trig_Amalgamation_Func001C()) then
        SetUnitMoveSpeed(GetTriggerUnit(), (__jreal(GetUnitDefaultMoveSpeed(GetTriggerUnit()) + __jreal(80.00))))
    else
        if (Trig_Amalgamation_Func001Func002C()) then
            SetUnitMoveSpeed(GetTriggerUnit(), GetUnitDefaultMoveSpeed(GetTriggerUnit()))
        else
        end
    end
end

-- Original JASS function: InitTrig_Amalgamation (line 7125)
function InitTrig_Amalgamation()
    gg_trg_Amalgamation = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Amalgamation, EVENT_PLAYER_UNIT_ISSUED_ORDER)
    TriggerAddCondition(gg_trg_Amalgamation, Condition(Trig_Amalgamation_Conditions))
    TriggerAddAction(gg_trg_Amalgamation, Trig_Amalgamation_Actions)
end
-- END FOREST SECTION 38

-- BEGIN FOREST SECTION 39 Merge
-- Original JASS function: Trig_Merge_Func001C (line 7135)
function Trig_Merge_Func001C()
    if ((not ((GetSpellAbilityId() == FourCC("A0DZ"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Merge_Conditions (line 7142)
function Trig_Merge_Conditions()
    if ((not Trig_Merge_Func001C())) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Merge_Actions (line 7149)
function Trig_Merge_Actions()
    KillUnit(GetSpellAbilityUnit())
end

-- Original JASS function: InitTrig_Merge (line 7154)
function InitTrig_Merge()
    gg_trg_Merge = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Merge, EVENT_PLAYER_UNIT_SPELL_ENDCAST)
    TriggerAddCondition(gg_trg_Merge, Condition(Trig_Merge_Conditions))
    TriggerAddAction(gg_trg_Merge, Trig_Merge_Actions)
end
-- END FOREST SECTION 39

-- BEGIN FOREST SECTION 40 Husk_Detection
-- Original JASS function: Trig_Husk_Detection_Conditions (line 7164)
function Trig_Husk_Detection_Conditions()
    if ((not ((GetUnitTypeId(GetSpellTargetUnit()) == FourCC("H064"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Husk_Detection_Func001C (line 7171)
function Trig_Husk_Detection_Func001C()
    if ((not ((GetSpellAbilityId() == FourCC("A0DZ"))))) then
        do return false end
    end
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("u00I"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Husk_Detection_Func002C (line 7181)
function Trig_Husk_Detection_Func002C()
    if ((not ((GetSpellAbilityId() == FourCC("A0DZ"))))) then
        do return false end
    end
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("u00J"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Husk_Detection_Func004C (line 7191)
function Trig_Husk_Detection_Func004C()
    if ((not ((GetSpellAbilityId() == FourCC("A0DZ"))))) then
        do return false end
    end
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("u00K"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Husk_Detection_Actions (line 7201)
function Trig_Husk_Detection_Actions()
    if (Trig_Husk_Detection_Func001C()) then
        ModifyHeroStat(bj_HEROSTAT_STR, GetSpellTargetUnit(), bj_MODIFYMETHOD_ADD, 1)
        BlzSetUnitBaseDamage(GetSpellTargetUnit(), (__jint(BlzGetUnitBaseDamage(GetSpellTargetUnit(), 0) + 4)), 0)
        BlzSetUnitMaxHP(GetSpellTargetUnit(), (__jint(BlzGetUnitMaxHP(GetSpellTargetUnit()) + 10)))
    else
    end
    if (Trig_Husk_Detection_Func002C()) then
        ModifyHeroStat(bj_HEROSTAT_STR, GetSpellTargetUnit(), bj_MODIFYMETHOD_ADD, 3)
        ModifyHeroStat(bj_HEROSTAT_AGI, GetSpellTargetUnit(), bj_MODIFYMETHOD_ADD, 2)
        BlzSetUnitBaseDamage(GetSpellTargetUnit(), (__jint(BlzGetUnitBaseDamage(GetSpellTargetUnit(), 0) + 7)), 0)
        BlzSetUnitMaxHP(GetSpellTargetUnit(), (__jint(BlzGetUnitMaxHP(GetSpellTargetUnit()) + 25)))
    else
    end
    if (Trig_Husk_Detection_Func004C()) then
        ModifyHeroStat(bj_HEROSTAT_STR, GetSpellTargetUnit(), bj_MODIFYMETHOD_ADD, 5)
        ModifyHeroStat(bj_HEROSTAT_AGI, GetSpellTargetUnit(), bj_MODIFYMETHOD_ADD, 5)
        BlzSetUnitBaseDamage(GetSpellTargetUnit(), (__jint(BlzGetUnitBaseDamage(GetSpellTargetUnit(), 0) + 10)), 0)
        BlzSetUnitMaxHP(GetSpellTargetUnit(), (__jint(BlzGetUnitMaxHP(GetSpellTargetUnit()) + 50)))
    else
    end
end

-- Original JASS function: InitTrig_Husk_Detection (line 7225)
function InitTrig_Husk_Detection()
    gg_trg_Husk_Detection = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Husk_Detection, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Husk_Detection, Condition(Trig_Husk_Detection_Conditions))
    TriggerAddAction(gg_trg_Husk_Detection, Trig_Husk_Detection_Actions)
end
-- END FOREST SECTION 40

-- BEGIN FOREST SECTION 41 Death_Jump
-- Original JASS function: Trig_Death_Jump_Conditions (line 7235)
function Trig_Death_Jump_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A0EG"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Death_Jump_Actions (line 7242)
function Trig_Death_Jump_Actions()
    SetUnitLifeBJ(GetSpellAbilityUnit(), (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, GetSpellAbilityUnit()) - (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, GetSpellAbilityUnit()) * __jreal(0.50))))))
end

-- Original JASS function: InitTrig_Death_Jump (line 7247)
function InitTrig_Death_Jump()
    gg_trg_Death_Jump = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Death_Jump, EVENT_PLAYER_UNIT_SPELL_CAST)
    TriggerAddCondition(gg_trg_Death_Jump, Condition(Trig_Death_Jump_Conditions))
    TriggerAddAction(gg_trg_Death_Jump, Trig_Death_Jump_Actions)
end
-- END FOREST SECTION 41

-- BEGIN FOREST SECTION 42 Map_Start
-- Original JASS function: Trig_Map_Start_Actions (line 7257)
function Trig_Map_Start_Actions()
    SetPlayerTechResearchedSwap(FourCC("R07L"), 1, Player(0))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 1, Player(1))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 1, Player(2))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 1, Player(3))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 1, Player(4))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 1, Player(5))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 1, Player(6))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 1, Player(7))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 1, Player(8))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 1, Player(9))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 1, Player(10))
    EnableTrigger(gg_trg_Day)
    EnableTrigger(gg_trg_Night)
end

-- Original JASS function: InitTrig_Map_Start (line 7274)
function InitTrig_Map_Start()
    gg_trg_Map_Start = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_Map_Start, __jreal(5.00))
    TriggerAddAction(gg_trg_Map_Start, Trig_Map_Start_Actions)
end
-- END FOREST SECTION 42

-- BEGIN FOREST SECTION 43 Day
-- Original JASS function: Trig_Day_Actions (line 7283)
function Trig_Day_Actions()
    SetPlayerTechResearchedSwap(FourCC("R07L"), 0, Player(0))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 0, Player(1))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 0, Player(2))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 0, Player(3))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 0, Player(4))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 0, Player(5))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 0, Player(6))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 0, Player(7))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 0, Player(8))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 0, Player(9))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 0, Player(10))
end

-- Original JASS function: InitTrig_Day (line 7298)
function InitTrig_Day()
    gg_trg_Day = CreateTrigger()
    DisableTrigger(gg_trg_Day)
    TriggerRegisterGameStateEventTimeOfDay(gg_trg_Day, EQUAL, __jreal(6.00))
    TriggerAddAction(gg_trg_Day, Trig_Day_Actions)
end
-- END FOREST SECTION 43

-- BEGIN FOREST SECTION 44 Night
-- Original JASS function: Trig_Night_Actions (line 7308)
function Trig_Night_Actions()
    SetPlayerTechResearchedSwap(FourCC("R07L"), 1, Player(0))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 1, Player(1))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 1, Player(2))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 1, Player(3))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 1, Player(4))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 1, Player(5))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 1, Player(6))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 1, Player(7))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 1, Player(8))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 1, Player(9))
    SetPlayerTechResearchedSwap(FourCC("R07L"), 1, Player(10))
end

-- Original JASS function: InitTrig_Night (line 7323)
function InitTrig_Night()
    gg_trg_Night = CreateTrigger()
    DisableTrigger(gg_trg_Night)
    TriggerRegisterGameStateEventTimeOfDay(gg_trg_Night, EQUAL, __jreal(18.00))
    TriggerAddAction(gg_trg_Night, Trig_Night_Actions)
end
-- END FOREST SECTION 44
-- END FOREST MODULE src/races/cultist.lua

-- BEGIN FOREST MODULE src/races/centaur.lua
-- races / centaur
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 45 Iron_Hoove
-- Original JASS function: UPG_MinInt (line 7334)
function UPG_MinInt(a, b)
    if (a < b) then
        do return a end
    end
    do return b end
end

-- Original JASS function: UPG_GetAbilityLevelForPlayer (line 7342)
function UPG_GetAbilityLevelForPlayer(p)
    do return UPG_MinInt(__jint(UPG_BASE_ABILITY_LEVEL + GetPlayerTechCount(p, UPG_UPGRADE_ID, true)), UPG_MAX_ABILITY_LEVEL) end
end

-- Original JASS function: UPG_ApplyToUnit (line 7346)
function UPG_ApplyToUnit(u)
    local wantedLevel = 0
    if (GetUnitAbilityLevel(u, UPG_ABILITY_ID) > 0) then
        wantedLevel = (UPG_MinInt(__jint(UPG_BASE_ABILITY_LEVEL + GetPlayerTechCount((GetOwningPlayer(u)), UPG_UPGRADE_ID, true)), UPG_MAX_ABILITY_LEVEL))
        if (wantedLevel > GetUnitAbilityLevel(u, UPG_ABILITY_ID)) then
            SetUnitAbilityLevel(u, UPG_ABILITY_ID, wantedLevel)
        end
    end
end

-- Original JASS function: UPG_ApplyToAllUnitsOfPlayer (line 7358)
function UPG_ApplyToAllUnitsOfPlayer(p)
    local u = nil
    GroupEnumUnitsOfPlayer(UPG_TempGroup, p, nil)
    while true do
        u = FirstOfGroup(UPG_TempGroup)
        if (u == nil) then break end
        GroupRemoveUnit(UPG_TempGroup, u)
        UPG_ApplyToUnit(u)
    end
    u = nil
end

-- Original JASS function: UPG_OnResearchFinish (line 7374)
function UPG_OnResearchFinish()
    local researchedId = GetResearched()
    local p = nil
    if (researchedId == UPG_UPGRADE_ID) then
        p = GetOwningPlayer(GetTriggerUnit())
        UPG_ApplyToAllUnitsOfPlayer(p)
        p = nil
    end
end

-- Original JASS function: UPG_OnUnitEnterMap (line 7385)
function UPG_OnUnitEnterMap()
    UPG_ApplyToUnit(GetTriggerUnit())
end

-- Original JASS function: InitTrig_Iron_Hoove (line 7389)
function InitTrig_Iron_Hoove()
    UPG_ResearchTrig = CreateTrigger()
    UPG_EnterTrig = CreateTrigger()
    UPG_WorldRegion = CreateRegion()
    TriggerRegisterAnyUnitEventBJ(UPG_ResearchTrig, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddAction(UPG_ResearchTrig, UPG_OnResearchFinish)
    RegionAddRect(UPG_WorldRegion, GetWorldBounds())
    TriggerRegisterEnterRegion(UPG_EnterTrig, UPG_WorldRegion, nil)
    TriggerAddAction(UPG_EnterTrig, UPG_OnUnitEnterMap)
end
-- END FOREST SECTION 45
-- END FOREST MODULE src/races/centaur.lua

-- BEGIN FOREST MODULE src/races/elf_engineer.lua
-- races / elf_engineer
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 46 Lightning_Strike_TowerVers
-- Original JASS function: Trig_Lightning_Strike_TowerVers_Conditions (line 7404)
function Trig_Lightning_Strike_TowerVers_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A0C2"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Lightning_Strike_TowerVers_Actions (line 7411)
function Trig_Lightning_Strike_TowerVers_Actions()
end

-- Original JASS function: InitTrig_Lightning_Strike_TowerVers (line 7415)
function InitTrig_Lightning_Strike_TowerVers()
    gg_trg_Lightning_Strike_TowerVers = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Lightning_Strike_TowerVers, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Lightning_Strike_TowerVers, Condition(Trig_Lightning_Strike_TowerVers_Conditions))
    TriggerAddAction(gg_trg_Lightning_Strike_TowerVers, Trig_Lightning_Strike_TowerVers_Actions)
end
-- END FOREST SECTION 46

-- BEGIN FOREST SECTION 47 Blizzard
-- Original JASS function: Trig_Blizzard_Conditions (line 7426)
function Trig_Blizzard_Conditions()
    if ((not ((IsUnitType(udg_DamageEventSource, UNIT_TYPE_HERO) == true)))) then
        do return false end
    end
    if ((not ((IsUnitType(udg_DamageEventTarget, UNIT_TYPE_HERO) == true)))) then
        do return false end
    end
    if ((not ((udg_IsDamageAttack == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Blizzard_Actions (line 7439)
function Trig_Blizzard_Actions()
end

-- Original JASS function: InitTrig_Blizzard (line 7443)
function InitTrig_Blizzard()
    gg_trg_Blizzard = CreateTrigger()
    h__TriggerRegisterVariableEvent(gg_trg_Blizzard, "udg_DamageEvent", EQUAL, __jreal(1.00))
    TriggerAddCondition(gg_trg_Blizzard, Condition(Trig_Blizzard_Conditions))
    TriggerAddAction(gg_trg_Blizzard, Trig_Blizzard_Actions)
end
-- END FOREST SECTION 47
-- END FOREST MODULE src/races/elf_engineer.lua

-- BEGIN FOREST MODULE src/races/kobold.lua
-- races / kobold
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 48 ShovelStrikelevelup
-- Original JASS function: Trig_ShovelStrikelevelup_Conditions (line 7453)
function Trig_ShovelStrikelevelup_Conditions()
    if ((not ((GetResearched() == FourCC("R004"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_ShovelStrikelevelup_Func003002 (line 7460)
function Trig_ShovelStrikelevelup_Func003002()
    IncUnitAbilityLevelSwapped(FourCC("A086"), GetEnumUnit())
end

-- Original JASS function: Trig_ShovelStrikelevelup_Actions (line 7464)
function Trig_ShovelStrikelevelup_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(GetOwningPlayer(GetResearchingUnit()), FourCC("h03Q")), Trig_ShovelStrikelevelup_Func003002)
end

-- Original JASS function: InitTrig_ShovelStrikelevelup (line 7469)
function InitTrig_ShovelStrikelevelup()
    gg_trg_ShovelStrikelevelup = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_ShovelStrikelevelup, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_ShovelStrikelevelup, Condition(Trig_ShovelStrikelevelup_Conditions))
    TriggerAddAction(gg_trg_ShovelStrikelevelup, Trig_ShovelStrikelevelup_Actions)
end
-- END FOREST SECTION 48
-- END FOREST MODULE src/races/kobold.lua

-- BEGIN FOREST MODULE src/races/night_elf.lua
-- races / night_elf
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 49 Deepwater_1
-- Original JASS function: Trig_Deepwater_1_Conditions (line 7479)
function Trig_Deepwater_1_Conditions()
    if ((not ((GetResearched() == FourCC("R066"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Deepwater_1_Func001A (line 7486)
function Trig_Deepwater_1_Func001A()
    UnitRemoveAbilityBJ(FourCC("A0A4"), GetEnumUnit())
    UnitAddAbilityBJ(FourCC("A0BB"), GetEnumUnit())
    udg_DeepWater1[GetConvertedPlayerId(GetOwningPlayer(GetResearchingUnit()))] = true
end

-- Original JASS function: Trig_Deepwater_1_Actions (line 7492)
function Trig_Deepwater_1_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(GetOwningPlayer(GetResearchingUnit()), FourCC("e00R")), Trig_Deepwater_1_Func001A)
end

-- Original JASS function: InitTrig_Deepwater_1 (line 7497)
function InitTrig_Deepwater_1()
    gg_trg_Deepwater_1 = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Deepwater_1, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Deepwater_1, Condition(Trig_Deepwater_1_Conditions))
    TriggerAddAction(gg_trg_Deepwater_1, Trig_Deepwater_1_Actions)
end
-- END FOREST SECTION 49

-- BEGIN FOREST SECTION 50 Deepwater_2
-- Original JASS function: Trig_Deepwater_2_Conditions (line 7507)
function Trig_Deepwater_2_Conditions()
    if ((not ((udg_DeepWater1[GetConvertedPlayerId(GetOwningPlayer(GetConstructedStructure()))] == true)))) then
        do return false end
    end
    if ((not ((GetUnitTypeId(GetConstructedStructure()) == FourCC("e00R"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Deepwater_2_Actions (line 7517)
function Trig_Deepwater_2_Actions()
    UnitRemoveAbilityBJ(FourCC("A0A4"), GetConstructedStructure())
    UnitAddAbilityBJ(FourCC("A0BB"), GetConstructedStructure())
end

-- Original JASS function: InitTrig_Deepwater_2 (line 7523)
function InitTrig_Deepwater_2()
    gg_trg_Deepwater_2 = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Deepwater_2, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
    TriggerAddCondition(gg_trg_Deepwater_2, Condition(Trig_Deepwater_2_Conditions))
    TriggerAddAction(gg_trg_Deepwater_2, Trig_Deepwater_2_Actions)
end
-- END FOREST SECTION 50
-- END FOREST MODULE src/races/night_elf.lua

-- BEGIN FOREST MODULE src/races/night_elf/arch_druid.lua
-- races / night_elf / arch_druid
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 51 Genesis
-- Original JASS function: Trig_Genesis_Conditions (line 7533)
function Trig_Genesis_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A0AO"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Genesis_Actions (line 7540)
function Trig_Genesis_Actions()
    local spellLoc = GetSpellTargetLoc()
    local caster = GetSpellAbilityUnit()
    local tree = nil
    local treeLoc = nil
    local treant = nil
    local dummy = nil
    CreateNUnitsAtLoc(1, FourCC("h04L"), GetOwningPlayer(caster), spellLoc, __jreal(0))
    dummy = GetLastCreatedUnit()
    UnitApplyTimedLifeBJ(__jreal(5.00), FourCC("BTLF"), GetLastCreatedUnit())
    CreateDestructableLoc(FourCC("LTlt"), spellLoc, GetRandomDirectionDeg(), __jreal(1), 0)
    tree = GetLastCreatedDestructable()
    SetDestructableAnimation(tree, "birth")
    SetDestructableAnimationSpeed(tree, __jreal(1.2))
    SetUnitAnimation(caster, "Spell Second")
    TriggerSleepAction(__jreal(3.0))
    if (((tree ~= nil)) and ((GetDestructableLife(tree) > __jreal(0)))) then
        treeLoc = GetDestructableLoc(tree)
        SetDestructableAnimationSpeed(tree, __jreal(1))
        KillDestructable(tree)
        CreateNUnitsAtLoc(1, FourCC("e00U"), GetOwningPlayer(caster), treeLoc, __jreal(0))
        treant = GetLastCreatedUnit()
        UnitApplyTimedLife(treant, FourCC("BTLF"), __jreal(60.0))
        SetUnitAnimation(treant, "birth")
        TriggerSleepAction(__jreal(1))
        RemoveDestructable(tree)
        RemoveLocation(treeLoc)
    end
    RemoveLocation(spellLoc)
    caster = nil
    tree = nil
    treant = nil
end

-- Original JASS function: InitTrig_Genesis (line 7594)
function InitTrig_Genesis()
    gg_trg_Genesis = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Genesis, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Genesis, Condition(Trig_Genesis_Conditions))
    TriggerAddAction(gg_trg_Genesis, Trig_Genesis_Actions)
end
-- END FOREST SECTION 51
-- END FOREST MODULE src/races/night_elf/arch_druid.lua

-- BEGIN FOREST MODULE src/races/night_elf/shadow_dancer.lua
-- races / night_elf / shadow_dancer
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 52 ConjureRefreshment
-- Original JASS function: Trig_ConjureRefreshment_Conditions (line 7605)
function Trig_ConjureRefreshment_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A0C8"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_ConjureRefreshment_Actions (line 7612)
function Trig_ConjureRefreshment_Actions()
    CreateItemLoc(FourCC("I021"), GetSpellTargetLoc())
end

-- Original JASS function: InitTrig_ConjureRefreshment (line 7617)
function InitTrig_ConjureRefreshment()
    gg_trg_ConjureRefreshment = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_ConjureRefreshment, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_ConjureRefreshment, Condition(Trig_ConjureRefreshment_Conditions))
    TriggerAddAction(gg_trg_ConjureRefreshment, Trig_ConjureRefreshment_Actions)
end
-- END FOREST SECTION 52

-- BEGIN FOREST SECTION 53 ShadowDancers
-- Original JASS function: Trig_ShadowDancers_Conditions (line 7627)
function Trig_ShadowDancers_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A0A5"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_ShadowDancers_Actions (line 7634)
function Trig_ShadowDancers_Actions()
    GroupAddUnitSimple(GetTriggerUnit(), udg_ShadowDancers)
end

-- Original JASS function: InitTrig_ShadowDancers (line 7639)
function InitTrig_ShadowDancers()
    gg_trg_ShadowDancers = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_ShadowDancers, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_ShadowDancers, Condition(Trig_ShadowDancers_Conditions))
    TriggerAddAction(gg_trg_ShadowDancers, Trig_ShadowDancers_Actions)
end
-- END FOREST SECTION 53

-- BEGIN FOREST SECTION 54 Mana_Burn
-- Original JASS function: Trig_Mana_Burn_Conditions (line 7649)
function Trig_Mana_Burn_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A0AR"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Mana_Burn_Func003C (line 7656)
function Trig_Mana_Burn_Func003C()
    if ((not ((GetUnitStateSwap(UNIT_STATE_MANA, GetSpellTargetUnit()) <= __jreal(10.00))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Mana_Burn_Actions (line 7663)
function Trig_Mana_Burn_Actions()
    BlzSetUnitRealFieldBJ(GetSpellTargetUnit(), UNIT_RF_MANA, (__jreal(BlzGetUnitRealField(GetSpellTargetUnit(), UNIT_RF_MANA) - (__jreal(GetUnitStateSwap(UNIT_STATE_MANA, GetSpellAbilityUnit()) * __jreal(0.40))))))
    BlzSetUnitRealFieldBJ(GetSpellAbilityUnit(), UNIT_RF_MANA, (__jreal(GetUnitStateSwap(UNIT_STATE_MANA, GetSpellAbilityUnit()) * __jreal(0.80))))
    if (Trig_Mana_Burn_Func003C()) then
        CreateNUnitsAtLoc(1, FourCC("h04L"), GetOwningPlayer(GetSpellAbilityUnit()), GetUnitLoc(GetSpellTargetUnit()), bj_UNIT_FACING)
        UnitAddAbilityBJ(FourCC("A0CW"), GetLastCreatedUnit())
        UnitApplyTimedLifeBJ(__jreal(2.00), FourCC("BTLF"), GetLastCreatedUnit())
        IssueTargetOrderBJ(GetLastCreatedUnit(), "thunderbolt", GetSpellTargetUnit())
    else
    end
end

-- Original JASS function: InitTrig_Mana_Burn (line 7676)
function InitTrig_Mana_Burn()
    gg_trg_Mana_Burn = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Mana_Burn, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Mana_Burn, Condition(Trig_Mana_Burn_Conditions))
    TriggerAddAction(gg_trg_Mana_Burn, Trig_Mana_Burn_Actions)
end
-- END FOREST SECTION 54

-- BEGIN FOREST SECTION 55 Mana_Steal_Dancer
-- Original JASS function: Trig_Mana_Steal_Dancer_Conditions (line 7686)
function Trig_Mana_Steal_Dancer_Conditions()
    if ((not ((GetUnitTypeId(udg_DamageEventSource) == FourCC("h05E"))))) then
        do return false end
    end
    if ((not ((IsPlayerAlly(GetOwningPlayer(udg_DamageEventTarget), GetOwningPlayer(udg_DamageEventSource)) == false)))) then
        do return false end
    end
    if ((not ((BlzGetUnitMaxMana(udg_DamageEventTarget) ~= 0)))) then
        do return false end
    end
    if ((not ((GetPlayerTechCountSimple(FourCC("R064"), GetOwningPlayer(udg_DamageEventSource)) == 1)))) then
        do return false end
    end
    if ((not ((udg_IsDamageAttack == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Mana_Steal_Dancer_Actions (line 7705)
function Trig_Mana_Steal_Dancer_Actions()
    local source, target = udg_DamageEventSource, udg_DamageEventTarget
    local steal = math.min(20, BlzGetUnitMaxMana(target))
    local actualSteal = math.min(steal, GetUnitState(target, UNIT_STATE_MANA))
    local sourceMana = GetUnitState(source, UNIT_STATE_MANA)
    local targetMana = GetUnitState(target, UNIT_STATE_MANA)
    BlzSetUnitMaxMana(source, BlzGetUnitMaxMana(source) + steal)
    BlzSetUnitMaxMana(target, BlzGetUnitMaxMana(target) - steal)
    SetUnitState(source, UNIT_STATE_MANA, sourceMana + actualSteal)
    SetUnitState(target, UNIT_STATE_MANA, targetMana - actualSteal)
    TriggerSleepAction(__jreal(180.00))
    -- Dead heroes can revive; restore their capacity too, but not removed units.
    if GetUnitTypeId(source) ~= 0 then
        BlzSetUnitMaxMana(source, math.max(0, BlzGetUnitMaxMana(source) - steal))
    end
    if GetUnitTypeId(target) ~= 0 then
        BlzSetUnitMaxMana(target, BlzGetUnitMaxMana(target) + steal)
    end
end

-- Original JASS function: InitTrig_Mana_Steal_Dancer (line 7749)
function InitTrig_Mana_Steal_Dancer()
    gg_trg_Mana_Steal_Dancer = CreateTrigger()
    h__TriggerRegisterVariableEvent(gg_trg_Mana_Steal_Dancer, "udg_DamageEvent", EQUAL, __jreal(1.00))
    TriggerAddCondition(gg_trg_Mana_Steal_Dancer, Condition(Trig_Mana_Steal_Dancer_Conditions))
    TriggerAddAction(gg_trg_Mana_Steal_Dancer, Trig_Mana_Steal_Dancer_Actions)
end
-- END FOREST SECTION 55

-- BEGIN FOREST SECTION 56 Mana_Steal_Mages
-- Original JASS function: Trig_Mana_Steal_Mages_Conditions (line 7758)
function Trig_Mana_Steal_Mages_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("o023"))))) then
        do return false end
    end
    if ((not ((IsPlayerAlly(GetOwningPlayer(udg_DamageEventTarget), GetOwningPlayer(udg_DamageEventSource)) == false)))) then
        do return false end
    end
    if ((not ((BlzGetUnitMaxMana(udg_DamageEventTarget) ~= 0)))) then
        do return false end
    end
    if ((not ((GetPlayerTechCountSimple(FourCC("R063"), GetOwningPlayer(udg_DamageEventSource)) == 1)))) then
        do return false end
    end
    if ((not ((udg_IsDamageAttack == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Mana_Steal_Mages_Actions (line 7777)
function Trig_Mana_Steal_Mages_Actions()
    SetUnitManaBJ(udg_DamageEventSource, (__jreal(GetUnitStateSwap(UNIT_STATE_MANA, udg_DamageEventSource) + __jreal(20.00))))
end

-- Original JASS function: InitTrig_Mana_Steal_Mages (line 7782)
function InitTrig_Mana_Steal_Mages()
    gg_trg_Mana_Steal_Mages = CreateTrigger()
    h__TriggerRegisterVariableEvent(gg_trg_Mana_Steal_Mages, "udg_DamageEvent", EQUAL, __jreal(1.00))
    TriggerAddCondition(gg_trg_Mana_Steal_Mages, Condition(Trig_Mana_Steal_Mages_Conditions))
    TriggerAddAction(gg_trg_Mana_Steal_Mages, Trig_Mana_Steal_Mages_Actions)
end
-- END FOREST SECTION 56

-- BEGIN FOREST SECTION 57 ConjureMana
-- Original JASS function: Trig_ConjureMana_Conditions (line 7792)
function Trig_ConjureMana_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A0AQ"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_ConjureMana_Actions (line 7799)
function Trig_ConjureMana_Actions()
    local caster = GetSpellAbilityUnit()
    BlzSetUnitBaseDamage(GetTriggerUnit(), (__jint(199 + R2I(GetUnitStateSwap(UNIT_STATE_MANA, GetTriggerUnit())))), 0)
    TriggerSleepAction(__jreal(1.00))
    SetUnitManaBJ(caster, (__jreal(GetUnitStateSwap(UNIT_STATE_MANA, caster) / __jreal(2.00))))
    TriggerSleepAction(__jreal(60.00))
    BlzSetUnitBaseDamage(GetTriggerUnit(), 199, 0)
end

-- Original JASS function: InitTrig_ConjureMana (line 7808)
function InitTrig_ConjureMana()
    gg_trg_ConjureMana = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_ConjureMana, EVENT_PLAYER_UNIT_SPELL_FINISH)
    TriggerAddCondition(gg_trg_ConjureMana, Condition(Trig_ConjureMana_Conditions))
    TriggerAddAction(gg_trg_ConjureMana, Trig_ConjureMana_Actions)
end
-- END FOREST SECTION 57

-- BEGIN FOREST SECTION 58 Blur
-- Original JASS function: Trig_Blur_Conditions (line 7818)
function Trig_Blur_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A0BG"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Blur_Actions (line 7825)
function Trig_Blur_Actions()
    UnitAddAbilityBJ(FourCC("A0AS"), GetSpellAbilityUnit())
    TriggerSleepAction(__jreal(GetUnitStateSwap(UNIT_STATE_MAX_MANA, GetTriggerUnit()) * __jreal(0.001)))
    UnitRemoveAbilityBJ(FourCC("A0AS"), GetTriggerUnit())
    UnitRemoveBuffBJ(FourCC("B03G"), GetTriggerUnit())
end

-- Original JASS function: InitTrig_Blur (line 7833)
function InitTrig_Blur()
    gg_trg_Blur = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Blur, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    TriggerAddCondition(gg_trg_Blur, Condition(Trig_Blur_Conditions))
    TriggerAddAction(gg_trg_Blur, Trig_Blur_Actions)
end
-- END FOREST SECTION 58
-- END FOREST MODULE src/races/night_elf/shadow_dancer.lua

-- BEGIN FOREST MODULE src/races/ghoul.lua
-- races / ghoul
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 59 Ghoul_Units
-- Original JASS function: Trig_Ghoul_Units_Func003001 (line 7848)
function Trig_Ghoul_Units_Func003001()
    do return ((GetUnitTypeId(GetConstructedStructure()) == FourCC("h01S"))) end
end

-- Original JASS function: Trig_Ghoul_Units_Func003002 (line 7852)
function Trig_Ghoul_Units_Func003002()
    do return ((GetUnitTypeId(GetConstructedStructure()) == FourCC("h01T"))) end
end

-- Original JASS function: Trig_Ghoul_Units_Conditions (line 7856)
function Trig_Ghoul_Units_Conditions()
    if ((not GetBooleanOr(((GetUnitTypeId(GetConstructedStructure()) == FourCC("h01S"))), ((GetUnitTypeId(GetConstructedStructure()) == FourCC("h01T")))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Ghoul_Units_Actions (line 7863)
function Trig_Ghoul_Units_Actions()
    BlzSetUnitBooleanFieldBJ(GetConstructedStructure(), UNIT_BF_IS_A_BUILDING, false)
end

-- Original JASS function: InitTrig_Ghoul_Units (line 7868)
function InitTrig_Ghoul_Units()
    gg_trg_Ghoul_Units = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Ghoul_Units, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
    TriggerAddCondition(gg_trg_Ghoul_Units, Condition(Trig_Ghoul_Units_Conditions))
    TriggerAddAction(gg_trg_Ghoul_Units, Trig_Ghoul_Units_Actions)
end
-- END FOREST SECTION 59

-- BEGIN FOREST SECTION 60 Ghoul_lumber
-- Original JASS function: Trig_Ghoul_lumber_Conditions (line 7878)
function Trig_Ghoul_lumber_Conditions()
    do return (GetResearched() == FourCC("R05K")) end
end

-- Original JASS function: Trig_Ghoul_lumber_ApplyToUnit (line 7882)
function Trig_Ghoul_lumber_ApplyToUnit(u)
    local p = nil
    local upgradeLevel = 0
    if (GetUnitTypeId(u) == FourCC("o005")) then
        p = GetOwningPlayer(u)
        upgradeLevel = GetPlayerTechCount(p, FourCC("R05K"), true)
        if (upgradeLevel >= 2) then
            UnitRemoveAbility(u, FourCC("A08Y"))
            UnitRemoveAbility(u, FourCC("A08Z"))
            UnitAddAbility(u, FourCC("A005"))
        elseif (upgradeLevel == 1) then
            UnitRemoveAbility(u, FourCC("A08Y"))
            UnitRemoveAbility(u, FourCC("A005"))
            UnitAddAbility(u, FourCC("A08Z"))
        end
        p = nil
    end
end

-- Original JASS function: Trig_Ghoul_lumber_Actions (line 7904)
function Trig_Ghoul_lumber_Actions()
    local p = GetOwningPlayer(GetResearchingUnit())
    local g = CreateGroup()
    local u = nil
    GroupEnumUnitsOfPlayer(g, p, nil)
    while true do
        u = FirstOfGroup(g)
        if (u == nil) then break end
        GroupRemoveUnit(g, u)
        Trig_Ghoul_lumber_ApplyToUnit(u)
    end
    DestroyGroup(g)
    u = nil
    g = nil
    p = nil
end

-- Original JASS function: Trig_Ghoul_lumber_Enter_Actions (line 7926)
function Trig_Ghoul_lumber_Enter_Actions()
    Trig_Ghoul_lumber_ApplyToUnit(GetTriggerUnit())
end

-- Original JASS function: InitTrig_Ghoul_lumber (line 7931)
function InitTrig_Ghoul_lumber()
    local enterTrig = CreateTrigger()
    local worldRegion = CreateRegion()
    gg_trg_Ghoul_lumber = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Ghoul_lumber, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Ghoul_lumber, Condition(Trig_Ghoul_lumber_Conditions))
    TriggerAddAction(gg_trg_Ghoul_lumber, Trig_Ghoul_lumber_Actions)
    RegionAddRect(worldRegion, GetWorldBounds())
    TriggerRegisterEnterRegion(enterTrig, worldRegion, nil)
    TriggerAddAction(enterTrig, Trig_Ghoul_lumber_Enter_Actions)
    enterTrig = nil
    worldRegion = nil
end
-- END FOREST SECTION 60
-- END FOREST MODULE src/races/ghoul.lua

-- BEGIN FOREST MODULE src/races/kraken.lua
-- races / kraken
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 61 Dutchmen_Trained
-- Original JASS function: Trig_Dutchmen_Trained_Conditions (line 7950)
function Trig_Dutchmen_Trained_Conditions()
    if ((not ((GetUnitTypeId(GetTrainedUnit()) == FourCC("H03P"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Dutchmen_Trained_Actions (line 7957)
function Trig_Dutchmen_Trained_Actions()
    GroupAddUnitSimple(GetTrainedUnit(), udg_Dutchmen)
end

-- Original JASS function: InitTrig_Dutchmen_Trained (line 7962)
function InitTrig_Dutchmen_Trained()
    gg_trg_Dutchmen_Trained = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Dutchmen_Trained, EVENT_PLAYER_UNIT_TRAIN_FINISH)
    TriggerAddCondition(gg_trg_Dutchmen_Trained, Condition(Trig_Dutchmen_Trained_Conditions))
    TriggerAddAction(gg_trg_Dutchmen_Trained, Trig_Dutchmen_Trained_Actions)
end
-- END FOREST SECTION 61

-- BEGIN FOREST SECTION 62 Dutchmen
-- Original JASS function: Trig_Dutchmen_Func001A (line 7972)
function Trig_Dutchmen_Func001A()
    BlzSetUnitBaseDamage(GetEnumUnit(), (__jint(GetPlayerState(GetOwningPlayer(GetEnumUnit()), PLAYER_STATE_RESOURCE_GOLD) + (__jint(49 + GetHeroStatBJ(bj_HEROSTAT_STR, GetEnumUnit(), true))))), 0)
end

-- Original JASS function: Trig_Dutchmen_Actions (line 7976)
function Trig_Dutchmen_Actions()
    ForGroupBJ(udg_Dutchmen, Trig_Dutchmen_Func001A)
end

-- Original JASS function: InitTrig_Dutchmen (line 7981)
function InitTrig_Dutchmen()
    gg_trg_Dutchmen = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(gg_trg_Dutchmen, __jreal(2))
    TriggerAddAction(gg_trg_Dutchmen, Trig_Dutchmen_Actions)
end
-- END FOREST SECTION 62
-- END FOREST MODULE src/races/kraken.lua

-- BEGIN FOREST MODULE src/races/aethyr.lua
-- races / aethyr
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 63 Vampiric_Wyrm
-- Original JASS function: Trig_Vampiric_Wyrm_Func001C (line 7995)
function Trig_Vampiric_Wyrm_Func001C()
    if (((GetUnitTypeId(GetConstructedStructure()) == FourCC("e005")))) then
        do return true end
    end
    if (((GetUnitTypeId(GetConstructedStructure()) == FourCC("e004")))) then
        do return true end
    end
    if (((GetUnitTypeId(GetConstructedStructure()) == FourCC("e006")))) then
        do return true end
    end
    do return false end
end

-- Original JASS function: Trig_Vampiric_Wyrm_Conditions (line 8008)
function Trig_Vampiric_Wyrm_Conditions()
    if ((not Trig_Vampiric_Wyrm_Func001C())) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Vampiric_Wyrm_Actions (line 8015)
function Trig_Vampiric_Wyrm_Actions()
    BlzSetUnitBooleanFieldBJ(GetConstructedStructure(), UNIT_BF_IS_A_BUILDING, false)
end

-- Original JASS function: InitTrig_Vampiric_Wyrm (line 8020)
function InitTrig_Vampiric_Wyrm()
    gg_trg_Vampiric_Wyrm = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Vampiric_Wyrm, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
    TriggerAddCondition(gg_trg_Vampiric_Wyrm, Condition(Trig_Vampiric_Wyrm_Conditions))
    TriggerAddAction(gg_trg_Vampiric_Wyrm, Trig_Vampiric_Wyrm_Actions)
end
-- END FOREST SECTION 63
-- END FOREST MODULE src/races/aethyr.lua

-- BEGIN FOREST MODULE src/races/forgotten.lua
-- races / forgotten
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 64 Soul_Hammer
-- Original JASS function: Trig_Soul_Hammer_Conditions (line 8030)
function Trig_Soul_Hammer_Conditions()
    if ((not ((GetItemTypeId(GetManipulatedItem()) == FourCC("I01E"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Soul_Hammer_Func002Func002Func001Func001C (line 8037)
function Trig_Soul_Hammer_Func002Func002Func001Func001C()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("u00B"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Soul_Hammer_Func002Func002Func001C (line 8044)
function Trig_Soul_Hammer_Func002Func002Func001C()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("u009"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Soul_Hammer_Func002Func002C (line 8051)
function Trig_Soul_Hammer_Func002Func002C()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("u007"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Soul_Hammer_Func002C (line 8058)
function Trig_Soul_Hammer_Func002C()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("u00A"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Soul_Hammer_Actions (line 8065)
function Trig_Soul_Hammer_Actions()
    if (Trig_Soul_Hammer_Func002C()) then
        DoNothing()
    else
        if (Trig_Soul_Hammer_Func002Func002C()) then
            DoNothing()
        else
            if (Trig_Soul_Hammer_Func002Func002Func001C()) then
                DoNothing()
            else
                if (Trig_Soul_Hammer_Func002Func002Func001Func001C()) then
                    DoNothing()
                else
                    UnitDropItemPointLoc(GetTriggerUnit(), GetManipulatedItem(), GetUnitLoc(GetTriggerUnit()))
                end
            end
        end
    end
end

-- Original JASS function: InitTrig_Soul_Hammer (line 8086)
function InitTrig_Soul_Hammer()
    gg_trg_Soul_Hammer = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Soul_Hammer, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    TriggerAddCondition(gg_trg_Soul_Hammer, Condition(Trig_Soul_Hammer_Conditions))
    TriggerAddAction(gg_trg_Soul_Hammer, Trig_Soul_Hammer_Actions)
end
-- END FOREST SECTION 64
-- END FOREST MODULE src/races/forgotten.lua

-- BEGIN FOREST MODULE src/races/forgotten/executioner.lua
-- races / forgotten / executioner
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 65 Coup_de_grace
-- Original JASS function: Trig_Coup_de_grace_Conditions (line 8096)
function Trig_Coup_de_grace_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A05X"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Coup_de_grace_Actions (line 8103)
function Trig_Coup_de_grace_Actions()
    SetUnitLifeBJ(GetSpellTargetUnit(), (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, GetSpellTargetUnit()) - (__jreal(GetUnitStateSwap(UNIT_STATE_MAX_LIFE, GetSpellTargetUnit()) * __jreal(0.10))))))
end

-- Original JASS function: InitTrig_Coup_de_grace (line 8108)
function InitTrig_Coup_de_grace()
    gg_trg_Coup_de_grace = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Coup_de_grace, EVENT_PLAYER_UNIT_SPELL_CAST)
    TriggerAddCondition(gg_trg_Coup_de_grace, Condition(Trig_Coup_de_grace_Conditions))
    TriggerAddAction(gg_trg_Coup_de_grace, Trig_Coup_de_grace_Actions)
end
-- END FOREST SECTION 65

-- BEGIN FOREST SECTION 66 Surge_of_Darkness
-- Original JASS function: Trig_Surge_of_Darkness_Conditions (line 8118)
function Trig_Surge_of_Darkness_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A060"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Surge_of_Darkness_Actions (line 8125)
function Trig_Surge_of_Darkness_Actions()
    UnitAddAbilityBJ(FourCC("A079"), GetTriggerUnit())
    TriggerSleepAction(__jreal(5.00))
    UnitRemoveAbilityBJ(FourCC("A079"), GetTriggerUnit())
end

-- Original JASS function: InitTrig_Surge_of_Darkness (line 8132)
function InitTrig_Surge_of_Darkness()
    gg_trg_Surge_of_Darkness = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Surge_of_Darkness, EVENT_PLAYER_UNIT_SPELL_CAST)
    TriggerAddCondition(gg_trg_Surge_of_Darkness, Condition(Trig_Surge_of_Darkness_Conditions))
    TriggerAddAction(gg_trg_Surge_of_Darkness, Trig_Surge_of_Darkness_Actions)
end
-- END FOREST SECTION 66

-- BEGIN FOREST SECTION 67 Focused_Anger_1
-- Original JASS function: Trig_Focused_Anger_1_Conditions (line 8142)
function Trig_Focused_Anger_1_Conditions()
    if ((not ((GetUnitTypeId(GetAttacker()) == FourCC("u00B"))))) then
        do return false end
    end
    if ((not ((GetOwningPlayer(GetAttacker()) == Player(0))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Focused_Anger_1_Func001C (line 8152)
function Trig_Focused_Anger_1_Func001C()
    return FE_FocusedAnger.count(GetAttacker()) >= 15
end

-- Original JASS function: Trig_Focused_Anger_1_Actions (line 8159)
function Trig_Focused_Anger_1_Actions()
    FE_FocusedAnger.add(GetAttacker())
end

-- Original JASS function: InitTrig_Focused_Anger_1 (line 8172)
function InitTrig_Focused_Anger_1()
    gg_trg_Focused_Anger_1 = CreateTrigger()
    DisableTrigger(gg_trg_Focused_Anger_1)
    FE_Roles.registerAncientUnitEvent(gg_trg_Focused_Anger_1, EVENT_PLAYER_UNIT_ATTACKED)
    TriggerAddCondition(gg_trg_Focused_Anger_1, Condition(Trig_Focused_Anger_1_Conditions))
    TriggerAddAction(gg_trg_Focused_Anger_1, Trig_Focused_Anger_1_Actions)
end
-- END FOREST SECTION 67

-- BEGIN FOREST SECTION 68 Focused_Anger_2
-- Original JASS function: Trig_Focused_Anger_2_Conditions (line 8183)
function Trig_Focused_Anger_2_Conditions()
    if ((not ((GetUnitTypeId(GetAttacker()) == FourCC("u00B"))))) then
        do return false end
    end
    if ((not ((GetOwningPlayer(GetAttacker()) == Player(1))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Focused_Anger_2_Func001C (line 8193)
function Trig_Focused_Anger_2_Func001C()
    return FE_FocusedAnger.count(GetAttacker()) >= 15
end

-- Original JASS function: Trig_Focused_Anger_2_Actions (line 8200)
function Trig_Focused_Anger_2_Actions()
    FE_FocusedAnger.add(GetAttacker())
end

-- Original JASS function: InitTrig_Focused_Anger_2 (line 8213)
function InitTrig_Focused_Anger_2()
    gg_trg_Focused_Anger_2 = CreateTrigger()
    DisableTrigger(gg_trg_Focused_Anger_2)
    FE_Roles.registerAncientUnitEvent(gg_trg_Focused_Anger_2, EVENT_PLAYER_UNIT_ATTACKED)
    TriggerAddCondition(gg_trg_Focused_Anger_2, Condition(Trig_Focused_Anger_2_Conditions))
    TriggerAddAction(gg_trg_Focused_Anger_2, Trig_Focused_Anger_2_Actions)
end
-- END FOREST SECTION 68

-- BEGIN FOREST SECTION 69 Focused_Anger_3
-- Original JASS function: Trig_Focused_Anger_3_Conditions (line 8224)
function Trig_Focused_Anger_3_Conditions()
    if ((not ((GetUnitTypeId(GetAttacker()) == FourCC("u00B"))))) then
        do return false end
    end
    if ((not ((GetOwningPlayer(GetAttacker()) == Player(2))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Focused_Anger_3_Func001C (line 8234)
function Trig_Focused_Anger_3_Func001C()
    return FE_FocusedAnger.count(GetAttacker()) >= 15
end

-- Original JASS function: Trig_Focused_Anger_3_Actions (line 8241)
function Trig_Focused_Anger_3_Actions()
    FE_FocusedAnger.add(GetAttacker())
end

-- Original JASS function: InitTrig_Focused_Anger_3 (line 8254)
function InitTrig_Focused_Anger_3()
    gg_trg_Focused_Anger_3 = CreateTrigger()
    DisableTrigger(gg_trg_Focused_Anger_3)
    FE_Roles.registerAncientUnitEvent(gg_trg_Focused_Anger_3, EVENT_PLAYER_UNIT_ATTACKED)
    TriggerAddCondition(gg_trg_Focused_Anger_3, Condition(Trig_Focused_Anger_3_Conditions))
    TriggerAddAction(gg_trg_Focused_Anger_3, Trig_Focused_Anger_3_Actions)
end
-- END FOREST SECTION 69

-- BEGIN FOREST SECTION 70 Focused_Anger_4
-- Original JASS function: Trig_Focused_Anger_4_Conditions (line 8265)
function Trig_Focused_Anger_4_Conditions()
    if ((not ((GetUnitTypeId(GetAttacker()) == FourCC("u00B"))))) then
        do return false end
    end
    if ((not ((GetOwningPlayer(GetAttacker()) == Player(3))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Focused_Anger_4_Func001C (line 8275)
function Trig_Focused_Anger_4_Func001C()
    return FE_FocusedAnger.count(GetAttacker()) >= 15
end

-- Original JASS function: Trig_Focused_Anger_4_Actions (line 8282)
function Trig_Focused_Anger_4_Actions()
    FE_FocusedAnger.add(GetAttacker())
end

-- Original JASS function: InitTrig_Focused_Anger_4 (line 8295)
function InitTrig_Focused_Anger_4()
    gg_trg_Focused_Anger_4 = CreateTrigger()
    DisableTrigger(gg_trg_Focused_Anger_4)
    FE_Roles.registerAncientUnitEvent(gg_trg_Focused_Anger_4, EVENT_PLAYER_UNIT_ATTACKED)
    TriggerAddCondition(gg_trg_Focused_Anger_4, Condition(Trig_Focused_Anger_4_Conditions))
    TriggerAddAction(gg_trg_Focused_Anger_4, Trig_Focused_Anger_4_Actions)
end
-- END FOREST SECTION 70

-- BEGIN FOREST SECTION 71 Focused_Anger_5
-- Original JASS function: Trig_Focused_Anger_5_Conditions (line 8306)
function Trig_Focused_Anger_5_Conditions()
    if ((not ((GetUnitTypeId(GetAttacker()) == FourCC("u00B"))))) then
        do return false end
    end
    if ((not ((GetOwningPlayer(GetAttacker()) == Player(4))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Focused_Anger_5_Func001C (line 8316)
function Trig_Focused_Anger_5_Func001C()
    return FE_FocusedAnger.count(GetAttacker()) >= 15
end

-- Original JASS function: Trig_Focused_Anger_5_Actions (line 8323)
function Trig_Focused_Anger_5_Actions()
    FE_FocusedAnger.add(GetAttacker())
end

-- Original JASS function: InitTrig_Focused_Anger_5 (line 8336)
function InitTrig_Focused_Anger_5()
    gg_trg_Focused_Anger_5 = CreateTrigger()
    DisableTrigger(gg_trg_Focused_Anger_5)
    FE_Roles.registerAncientUnitEvent(gg_trg_Focused_Anger_5, EVENT_PLAYER_UNIT_ATTACKED)
    TriggerAddCondition(gg_trg_Focused_Anger_5, Condition(Trig_Focused_Anger_5_Conditions))
    TriggerAddAction(gg_trg_Focused_Anger_5, Trig_Focused_Anger_5_Actions)
end
-- END FOREST SECTION 71

-- BEGIN FOREST SECTION 72 Focused_Anger_6
-- Original JASS function: Trig_Focused_Anger_6_Conditions (line 8347)
function Trig_Focused_Anger_6_Conditions()
    if ((not ((GetUnitTypeId(GetAttacker()) == FourCC("u00B"))))) then
        do return false end
    end
    if ((not ((GetOwningPlayer(GetAttacker()) == Player(5))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Focused_Anger_6_Func001C (line 8357)
function Trig_Focused_Anger_6_Func001C()
    return FE_FocusedAnger.count(GetAttacker()) >= 15
end

-- Original JASS function: Trig_Focused_Anger_6_Actions (line 8364)
function Trig_Focused_Anger_6_Actions()
    FE_FocusedAnger.add(GetAttacker())
end

-- Original JASS function: InitTrig_Focused_Anger_6 (line 8377)
function InitTrig_Focused_Anger_6()
    gg_trg_Focused_Anger_6 = CreateTrigger()
    DisableTrigger(gg_trg_Focused_Anger_6)
    FE_Roles.registerAncientUnitEvent(gg_trg_Focused_Anger_6, EVENT_PLAYER_UNIT_ATTACKED)
    TriggerAddCondition(gg_trg_Focused_Anger_6, Condition(Trig_Focused_Anger_6_Conditions))
    TriggerAddAction(gg_trg_Focused_Anger_6, Trig_Focused_Anger_6_Actions)
end
-- END FOREST SECTION 72

-- BEGIN FOREST SECTION 73 Focused_Anger_7
-- Original JASS function: Trig_Focused_Anger_7_Conditions (line 8388)
function Trig_Focused_Anger_7_Conditions()
    if ((not ((GetUnitTypeId(GetAttacker()) == FourCC("u00B"))))) then
        do return false end
    end
    if ((not ((GetOwningPlayer(GetAttacker()) == Player(7))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Focused_Anger_7_Func001C (line 8398)
function Trig_Focused_Anger_7_Func001C()
    return FE_FocusedAnger.count(GetAttacker()) >= 15
end

-- Original JASS function: Trig_Focused_Anger_7_Actions (line 8405)
function Trig_Focused_Anger_7_Actions()
    FE_FocusedAnger.add(GetAttacker())
end

-- Original JASS function: InitTrig_Focused_Anger_7 (line 8418)
function InitTrig_Focused_Anger_7()
    gg_trg_Focused_Anger_7 = CreateTrigger()
    DisableTrigger(gg_trg_Focused_Anger_7)
    FE_Roles.registerAncientUnitEvent(gg_trg_Focused_Anger_7, EVENT_PLAYER_UNIT_ATTACKED)
    TriggerAddCondition(gg_trg_Focused_Anger_7, Condition(Trig_Focused_Anger_7_Conditions))
    TriggerAddAction(gg_trg_Focused_Anger_7, Trig_Focused_Anger_7_Actions)
end
-- END FOREST SECTION 73

-- BEGIN FOREST SECTION 74 Focused_Anger_8
-- Original JASS function: Trig_Focused_Anger_8_Conditions (line 8429)
function Trig_Focused_Anger_8_Conditions()
    if ((not ((GetUnitTypeId(GetAttacker()) == FourCC("u00B"))))) then
        do return false end
    end
    if ((not ((GetOwningPlayer(GetAttacker()) == Player(8))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Focused_Anger_8_Func001C (line 8439)
function Trig_Focused_Anger_8_Func001C()
    return FE_FocusedAnger.count(GetAttacker()) >= 15
end

-- Original JASS function: Trig_Focused_Anger_8_Actions (line 8446)
function Trig_Focused_Anger_8_Actions()
    FE_FocusedAnger.add(GetAttacker())
end

-- Original JASS function: InitTrig_Focused_Anger_8 (line 8459)
function InitTrig_Focused_Anger_8()
    gg_trg_Focused_Anger_8 = CreateTrigger()
    DisableTrigger(gg_trg_Focused_Anger_8)
    FE_Roles.registerAncientUnitEvent(gg_trg_Focused_Anger_8, EVENT_PLAYER_UNIT_ATTACKED)
    TriggerAddCondition(gg_trg_Focused_Anger_8, Condition(Trig_Focused_Anger_8_Conditions))
    TriggerAddAction(gg_trg_Focused_Anger_8, Trig_Focused_Anger_8_Actions)
end
-- END FOREST SECTION 74

-- BEGIN FOREST SECTION 75 Focused_Anger_9
-- Original JASS function: Trig_Focused_Anger_9_Conditions (line 8470)
function Trig_Focused_Anger_9_Conditions()
    if ((not ((GetUnitTypeId(GetAttacker()) == FourCC("u00B"))))) then
        do return false end
    end
    if ((not ((GetOwningPlayer(GetAttacker()) == Player(9))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Focused_Anger_9_Func001C (line 8480)
function Trig_Focused_Anger_9_Func001C()
    return FE_FocusedAnger.count(GetAttacker()) >= 15
end

-- Original JASS function: Trig_Focused_Anger_9_Actions (line 8487)
function Trig_Focused_Anger_9_Actions()
    FE_FocusedAnger.add(GetAttacker())
end

-- Original JASS function: InitTrig_Focused_Anger_9 (line 8500)
function InitTrig_Focused_Anger_9()
    gg_trg_Focused_Anger_9 = CreateTrigger()
    DisableTrigger(gg_trg_Focused_Anger_9)
    FE_Roles.registerAncientUnitEvent(gg_trg_Focused_Anger_9, EVENT_PLAYER_UNIT_ATTACKED)
    TriggerAddCondition(gg_trg_Focused_Anger_9, Condition(Trig_Focused_Anger_9_Conditions))
    TriggerAddAction(gg_trg_Focused_Anger_9, Trig_Focused_Anger_9_Actions)
end
-- END FOREST SECTION 75

-- BEGIN FOREST SECTION 76 Focused_Anger_10
-- Original JASS function: Trig_Focused_Anger_10_Conditions (line 8511)
function Trig_Focused_Anger_10_Conditions()
    if ((not ((GetUnitTypeId(GetAttacker()) == FourCC("u00B"))))) then
        do return false end
    end
    if ((not ((GetOwningPlayer(GetAttacker()) == Player(10))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Focused_Anger_10_Func001C (line 8521)
function Trig_Focused_Anger_10_Func001C()
    return FE_FocusedAnger.count(GetAttacker()) >= 15
end

-- Original JASS function: Trig_Focused_Anger_10_Actions (line 8528)
function Trig_Focused_Anger_10_Actions()
    FE_FocusedAnger.add(GetAttacker())
end

-- Original JASS function: InitTrig_Focused_Anger_10 (line 8541)
function InitTrig_Focused_Anger_10()
    gg_trg_Focused_Anger_10 = CreateTrigger()
    DisableTrigger(gg_trg_Focused_Anger_10)
    FE_Roles.registerAncientUnitEvent(gg_trg_Focused_Anger_10, EVENT_PLAYER_UNIT_ATTACKED)
    TriggerAddCondition(gg_trg_Focused_Anger_10, Condition(Trig_Focused_Anger_10_Conditions))
    TriggerAddAction(gg_trg_Focused_Anger_10, Trig_Focused_Anger_10_Actions)
end
-- END FOREST SECTION 76

-- BEGIN FOREST SECTION 77 Focused_Anger_Trigger
-- Original JASS function: Trig_Focused_Anger_Trigger_Conditions (line 8552)
function Trig_Focused_Anger_Trigger_Conditions()
    if ((not ((GetResearched() == FourCC("R04T"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Focused_Anger_Trigger_Actions (line 8559)
function Trig_Focused_Anger_Trigger_Actions()
    EnableTrigger(gg_trg_Focused_Anger_1)
end

-- Original JASS function: InitTrig_Focused_Anger_Trigger (line 8564)
function InitTrig_Focused_Anger_Trigger()
    gg_trg_Focused_Anger_Trigger = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Focused_Anger_Trigger, Player(0), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Focused_Anger_Trigger, Condition(Trig_Focused_Anger_Trigger_Conditions))
    TriggerAddAction(gg_trg_Focused_Anger_Trigger, Trig_Focused_Anger_Trigger_Actions)
end
-- END FOREST SECTION 77

-- BEGIN FOREST SECTION 78 Focused_Anger_Trigger_Copy
-- Original JASS function: Trig_Focused_Anger_Trigger_Copy_Conditions (line 8574)
function Trig_Focused_Anger_Trigger_Copy_Conditions()
    if ((not ((GetResearched() == FourCC("R04T"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Focused_Anger_Trigger_Copy_Actions (line 8581)
function Trig_Focused_Anger_Trigger_Copy_Actions()
    EnableTrigger(gg_trg_Focused_Anger_2)
end

-- Original JASS function: InitTrig_Focused_Anger_Trigger_Copy (line 8586)
function InitTrig_Focused_Anger_Trigger_Copy()
    gg_trg_Focused_Anger_Trigger_Copy = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Focused_Anger_Trigger_Copy, Player(1), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Focused_Anger_Trigger_Copy, Condition(Trig_Focused_Anger_Trigger_Copy_Conditions))
    TriggerAddAction(gg_trg_Focused_Anger_Trigger_Copy, Trig_Focused_Anger_Trigger_Copy_Actions)
end
-- END FOREST SECTION 78

-- BEGIN FOREST SECTION 79 Focused_Anger_Trigger_Copy_2
-- Original JASS function: Trig_Focused_Anger_Trigger_Copy_2_Conditions (line 8596)
function Trig_Focused_Anger_Trigger_Copy_2_Conditions()
    if ((not ((GetResearched() == FourCC("R04T"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Focused_Anger_Trigger_Copy_2_Actions (line 8603)
function Trig_Focused_Anger_Trigger_Copy_2_Actions()
    EnableTrigger(gg_trg_Focused_Anger_3)
end

-- Original JASS function: InitTrig_Focused_Anger_Trigger_Copy_2 (line 8608)
function InitTrig_Focused_Anger_Trigger_Copy_2()
    gg_trg_Focused_Anger_Trigger_Copy_2 = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Focused_Anger_Trigger_Copy_2, Player(2), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Focused_Anger_Trigger_Copy_2, Condition(Trig_Focused_Anger_Trigger_Copy_2_Conditions))
    TriggerAddAction(gg_trg_Focused_Anger_Trigger_Copy_2, Trig_Focused_Anger_Trigger_Copy_2_Actions)
end
-- END FOREST SECTION 79

-- BEGIN FOREST SECTION 80 Focused_Anger_Trigger_Copy_3
-- Original JASS function: Trig_Focused_Anger_Trigger_Copy_3_Conditions (line 8618)
function Trig_Focused_Anger_Trigger_Copy_3_Conditions()
    if ((not ((GetResearched() == FourCC("R04T"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Focused_Anger_Trigger_Copy_3_Actions (line 8625)
function Trig_Focused_Anger_Trigger_Copy_3_Actions()
    EnableTrigger(gg_trg_Focused_Anger_4)
end

-- Original JASS function: InitTrig_Focused_Anger_Trigger_Copy_3 (line 8630)
function InitTrig_Focused_Anger_Trigger_Copy_3()
    gg_trg_Focused_Anger_Trigger_Copy_3 = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Focused_Anger_Trigger_Copy_3, Player(3), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Focused_Anger_Trigger_Copy_3, Condition(Trig_Focused_Anger_Trigger_Copy_3_Conditions))
    TriggerAddAction(gg_trg_Focused_Anger_Trigger_Copy_3, Trig_Focused_Anger_Trigger_Copy_3_Actions)
end
-- END FOREST SECTION 80

-- BEGIN FOREST SECTION 81 Focused_Anger_Trigger_Copy_4
-- Original JASS function: Trig_Focused_Anger_Trigger_Copy_4_Conditions (line 8640)
function Trig_Focused_Anger_Trigger_Copy_4_Conditions()
    if ((not ((GetResearched() == FourCC("R04T"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Focused_Anger_Trigger_Copy_4_Actions (line 8647)
function Trig_Focused_Anger_Trigger_Copy_4_Actions()
    EnableTrigger(gg_trg_Focused_Anger_5)
end

-- Original JASS function: InitTrig_Focused_Anger_Trigger_Copy_4 (line 8652)
function InitTrig_Focused_Anger_Trigger_Copy_4()
    gg_trg_Focused_Anger_Trigger_Copy_4 = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Focused_Anger_Trigger_Copy_4, Player(4), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Focused_Anger_Trigger_Copy_4, Condition(Trig_Focused_Anger_Trigger_Copy_4_Conditions))
    TriggerAddAction(gg_trg_Focused_Anger_Trigger_Copy_4, Trig_Focused_Anger_Trigger_Copy_4_Actions)
end
-- END FOREST SECTION 81

-- BEGIN FOREST SECTION 82 Focused_Anger_Trigger_Copy_5
-- Original JASS function: Trig_Focused_Anger_Trigger_Copy_5_Conditions (line 8662)
function Trig_Focused_Anger_Trigger_Copy_5_Conditions()
    if ((not ((GetResearched() == FourCC("R04T"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Focused_Anger_Trigger_Copy_5_Actions (line 8669)
function Trig_Focused_Anger_Trigger_Copy_5_Actions()
    EnableTrigger(gg_trg_Focused_Anger_6)
end

-- Original JASS function: InitTrig_Focused_Anger_Trigger_Copy_5 (line 8674)
function InitTrig_Focused_Anger_Trigger_Copy_5()
    gg_trg_Focused_Anger_Trigger_Copy_5 = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Focused_Anger_Trigger_Copy_5, Player(5), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Focused_Anger_Trigger_Copy_5, Condition(Trig_Focused_Anger_Trigger_Copy_5_Conditions))
    TriggerAddAction(gg_trg_Focused_Anger_Trigger_Copy_5, Trig_Focused_Anger_Trigger_Copy_5_Actions)
end
-- END FOREST SECTION 82

-- BEGIN FOREST SECTION 83 Focused_Anger_Trigger_Copy_6
-- Original JASS function: Trig_Focused_Anger_Trigger_Copy_6_Conditions (line 8684)
function Trig_Focused_Anger_Trigger_Copy_6_Conditions()
    if ((not ((GetResearched() == FourCC("R04T"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Focused_Anger_Trigger_Copy_6_Actions (line 8691)
function Trig_Focused_Anger_Trigger_Copy_6_Actions()
    EnableTrigger(gg_trg_Focused_Anger_7)
end

-- Original JASS function: InitTrig_Focused_Anger_Trigger_Copy_6 (line 8696)
function InitTrig_Focused_Anger_Trigger_Copy_6()
    gg_trg_Focused_Anger_Trigger_Copy_6 = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Focused_Anger_Trigger_Copy_6, Player(7), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Focused_Anger_Trigger_Copy_6, Condition(Trig_Focused_Anger_Trigger_Copy_6_Conditions))
    TriggerAddAction(gg_trg_Focused_Anger_Trigger_Copy_6, Trig_Focused_Anger_Trigger_Copy_6_Actions)
end
-- END FOREST SECTION 83

-- BEGIN FOREST SECTION 84 Focused_Anger_Trigger_Copy_7
-- Original JASS function: Trig_Focused_Anger_Trigger_Copy_7_Conditions (line 8706)
function Trig_Focused_Anger_Trigger_Copy_7_Conditions()
    if ((not ((GetResearched() == FourCC("R04T"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Focused_Anger_Trigger_Copy_7_Actions (line 8713)
function Trig_Focused_Anger_Trigger_Copy_7_Actions()
    EnableTrigger(gg_trg_Focused_Anger_8)
end

-- Original JASS function: InitTrig_Focused_Anger_Trigger_Copy_7 (line 8718)
function InitTrig_Focused_Anger_Trigger_Copy_7()
    gg_trg_Focused_Anger_Trigger_Copy_7 = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Focused_Anger_Trigger_Copy_7, Player(8), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Focused_Anger_Trigger_Copy_7, Condition(Trig_Focused_Anger_Trigger_Copy_7_Conditions))
    TriggerAddAction(gg_trg_Focused_Anger_Trigger_Copy_7, Trig_Focused_Anger_Trigger_Copy_7_Actions)
end
-- END FOREST SECTION 84

-- BEGIN FOREST SECTION 85 Focused_Anger_Trigger_Copy_8
-- Original JASS function: Trig_Focused_Anger_Trigger_Copy_8_Conditions (line 8728)
function Trig_Focused_Anger_Trigger_Copy_8_Conditions()
    if ((not ((GetResearched() == FourCC("R04T"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Focused_Anger_Trigger_Copy_8_Actions (line 8735)
function Trig_Focused_Anger_Trigger_Copy_8_Actions()
    EnableTrigger(gg_trg_Focused_Anger_9)
end

-- Original JASS function: InitTrig_Focused_Anger_Trigger_Copy_8 (line 8740)
function InitTrig_Focused_Anger_Trigger_Copy_8()
    gg_trg_Focused_Anger_Trigger_Copy_8 = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Focused_Anger_Trigger_Copy_8, Player(9), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Focused_Anger_Trigger_Copy_8, Condition(Trig_Focused_Anger_Trigger_Copy_8_Conditions))
    TriggerAddAction(gg_trg_Focused_Anger_Trigger_Copy_8, Trig_Focused_Anger_Trigger_Copy_8_Actions)
end
-- END FOREST SECTION 85

-- BEGIN FOREST SECTION 86 Focused_Anger_Trigger_Copy_9
-- Original JASS function: Trig_Focused_Anger_Trigger_Copy_9_Conditions (line 8750)
function Trig_Focused_Anger_Trigger_Copy_9_Conditions()
    if ((not ((GetResearched() == FourCC("R04T"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Focused_Anger_Trigger_Copy_9_Actions (line 8757)
function Trig_Focused_Anger_Trigger_Copy_9_Actions()
    EnableTrigger(gg_trg_Focused_Anger_10)
end

-- Original JASS function: InitTrig_Focused_Anger_Trigger_Copy_9 (line 8762)
function InitTrig_Focused_Anger_Trigger_Copy_9()
    gg_trg_Focused_Anger_Trigger_Copy_9 = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Focused_Anger_Trigger_Copy_9, Player(10), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Focused_Anger_Trigger_Copy_9, Condition(Trig_Focused_Anger_Trigger_Copy_9_Conditions))
    TriggerAddAction(gg_trg_Focused_Anger_Trigger_Copy_9, Trig_Focused_Anger_Trigger_Copy_9_Actions)
end
-- END FOREST SECTION 86
-- END FOREST MODULE src/races/forgotten/executioner.lua

-- BEGIN FOREST MODULE src/races/forgotten/soulreaper.lua
-- races / forgotten / soulreaper
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 87 Feast_of_Souls
-- Original JASS function: Trig_Feast_of_Souls_Conditions (line 8772)
function Trig_Feast_of_Souls_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A05Z"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Feast_of_Souls_Actions (line 8779)
function Trig_Feast_of_Souls_Actions()
    SetUnitLifeBJ(GetSpellAbilityUnit(), (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) + __jreal(700.00))))
end

-- Original JASS function: InitTrig_Feast_of_Souls (line 8784)
function InitTrig_Feast_of_Souls()
    gg_trg_Feast_of_Souls = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Feast_of_Souls, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Feast_of_Souls, Condition(Trig_Feast_of_Souls_Conditions))
    TriggerAddAction(gg_trg_Feast_of_Souls, Trig_Feast_of_Souls_Actions)
end
-- END FOREST SECTION 87

-- BEGIN FOREST SECTION 88 Soul_Strike
-- Original JASS function: Trig_Soul_Strike_Conditions (line 8794)
function Trig_Soul_Strike_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A05O"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Soul_Strike_Actions (line 8801)
function Trig_Soul_Strike_Actions()
    SetUnitLifeBJ(GetSpellAbilityUnit(), (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) + __jreal(200.00))))
end

-- Original JASS function: InitTrig_Soul_Strike (line 8806)
function InitTrig_Soul_Strike()
    gg_trg_Soul_Strike = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Soul_Strike, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Soul_Strike, Condition(Trig_Soul_Strike_Conditions))
    TriggerAddAction(gg_trg_Soul_Strike, Trig_Soul_Strike_Actions)
end
-- END FOREST SECTION 88

-- BEGIN FOREST SECTION 89 Avatar
-- Original JASS function: Trig_Avatar_Conditions (line 8816)
function Trig_Avatar_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A078"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Avatar_Actions (line 8823)
function Trig_Avatar_Actions()
    CreateNUnitsAtLoc(1, FourCC("h04L"), GetOwningPlayer(GetTriggerUnit()), GetUnitLoc(GetTriggerUnit()), bj_UNIT_FACING)
    IssueTargetOrderBJ(GetLastCreatedUnit(), "bloodlust", GetSpellAbilityUnit())
    UnitApplyTimedLifeBJ(__jreal(1.00), FourCC("BTLF"), GetLastCreatedUnit())
    SetUnitAbilityLevelSwapped(FourCC("A067"), GetTriggerUnit(), 2)
    TriggerSleepAction(__jreal(10.00))
    SetUnitAbilityLevelSwapped(FourCC("A067"), GetTriggerUnit(), 1)
end

-- Original JASS function: InitTrig_Avatar (line 8833)
function InitTrig_Avatar()
    gg_trg_Avatar = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Avatar, EVENT_PLAYER_UNIT_SPELL_CAST)
    TriggerAddCondition(gg_trg_Avatar, Condition(Trig_Avatar_Conditions))
    TriggerAddAction(gg_trg_Avatar, Trig_Avatar_Actions)
end
-- END FOREST SECTION 89
-- END FOREST MODULE src/races/forgotten/soulreaper.lua

-- BEGIN FOREST MODULE src/races/forgotten/bloodmage.lua
-- races / forgotten / bloodmage
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 90 Acidic_Blood
-- Original JASS function: Trig_Acidic_Blood_Conditions (line 8843)
function Trig_Acidic_Blood_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A05L"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Acidic_Blood_Func001C (line 8850)
function Trig_Acidic_Blood_Func001C()
    if ((not ((GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) <= __jreal(150.00))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Acidic_Blood_Actions (line 8857)
function Trig_Acidic_Blood_Actions()
    if (Trig_Acidic_Blood_Func001C()) then
        IssueImmediateOrderBJ(GetSpellAbilityUnit(), "stop")
    else
        SetUnitLifeBJ(GetSpellAbilityUnit(), (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) - __jreal(150.00))))
    end
end

-- Original JASS function: InitTrig_Acidic_Blood (line 8866)
function InitTrig_Acidic_Blood()
    gg_trg_Acidic_Blood = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Acidic_Blood, EVENT_PLAYER_UNIT_SPELL_CAST)
    TriggerAddCondition(gg_trg_Acidic_Blood, Condition(Trig_Acidic_Blood_Conditions))
    TriggerAddAction(gg_trg_Acidic_Blood, Trig_Acidic_Blood_Actions)
end
-- END FOREST SECTION 90

-- BEGIN FOREST SECTION 91 Binding_Shadows
-- Original JASS function: Trig_Binding_Shadows_Conditions (line 8876)
function Trig_Binding_Shadows_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A05M"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Binding_Shadows_Func001C (line 8883)
function Trig_Binding_Shadows_Func001C()
    if ((not ((GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) <= __jreal(200.00))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Binding_Shadows_Actions (line 8890)
function Trig_Binding_Shadows_Actions()
    if (Trig_Binding_Shadows_Func001C()) then
        IssueImmediateOrderBJ(GetSpellAbilityUnit(), "stop")
    else
        SetUnitLifeBJ(GetSpellAbilityUnit(), (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) - __jreal(200.00))))
    end
end

-- Original JASS function: InitTrig_Binding_Shadows (line 8899)
function InitTrig_Binding_Shadows()
    gg_trg_Binding_Shadows = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Binding_Shadows, EVENT_PLAYER_UNIT_SPELL_CAST)
    TriggerAddCondition(gg_trg_Binding_Shadows, Condition(Trig_Binding_Shadows_Conditions))
    TriggerAddAction(gg_trg_Binding_Shadows, Trig_Binding_Shadows_Actions)
end
-- END FOREST SECTION 91

-- BEGIN FOREST SECTION 92 Cobalt_Blood
-- Original JASS function: Trig_Cobalt_Blood_Conditions (line 8909)
function Trig_Cobalt_Blood_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A068"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Cobalt_Blood_Func001C (line 8916)
function Trig_Cobalt_Blood_Func001C()
    if ((not ((GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) <= __jreal(200.00))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Cobalt_Blood_Actions (line 8923)
function Trig_Cobalt_Blood_Actions()
    if (Trig_Cobalt_Blood_Func001C()) then
        IssueImmediateOrderBJ(GetSpellAbilityUnit(), "stop")
    else
        SetUnitLifeBJ(GetSpellAbilityUnit(), (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) - __jreal(200.00))))
    end
end

-- Original JASS function: InitTrig_Cobalt_Blood (line 8932)
function InitTrig_Cobalt_Blood()
    gg_trg_Cobalt_Blood = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Cobalt_Blood, EVENT_PLAYER_UNIT_SPELL_CAST)
    TriggerAddCondition(gg_trg_Cobalt_Blood, Condition(Trig_Cobalt_Blood_Conditions))
    TriggerAddAction(gg_trg_Cobalt_Blood, Trig_Cobalt_Blood_Actions)
end
-- END FOREST SECTION 92

-- BEGIN FOREST SECTION 93 Glowing_Blood
-- Original JASS function: Trig_Glowing_Blood_Conditions (line 8942)
function Trig_Glowing_Blood_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A064"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Glowing_Blood_Func001C (line 8949)
function Trig_Glowing_Blood_Func001C()
    if ((not ((GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) <= __jreal(50.00))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Glowing_Blood_Actions (line 8956)
function Trig_Glowing_Blood_Actions()
    if (Trig_Glowing_Blood_Func001C()) then
        IssueImmediateOrderBJ(GetSpellAbilityUnit(), "stop")
    else
        SetUnitLifeBJ(GetSpellAbilityUnit(), (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) - __jreal(50.00))))
    end
end

-- Original JASS function: InitTrig_Glowing_Blood (line 8965)
function InitTrig_Glowing_Blood()
    gg_trg_Glowing_Blood = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Glowing_Blood, EVENT_PLAYER_UNIT_SPELL_CAST)
    TriggerAddCondition(gg_trg_Glowing_Blood, Condition(Trig_Glowing_Blood_Conditions))
    TriggerAddAction(gg_trg_Glowing_Blood, Trig_Glowing_Blood_Actions)
end
-- END FOREST SECTION 93

-- BEGIN FOREST SECTION 94 Psychic_Slam
-- Original JASS function: Trig_Psychic_Slam_Conditions (line 8975)
function Trig_Psychic_Slam_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A063"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Psychic_Slam_Func001C (line 8982)
function Trig_Psychic_Slam_Func001C()
    if ((not ((GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) <= __jreal(300.00))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Psychic_Slam_Actions (line 8989)
function Trig_Psychic_Slam_Actions()
    if (Trig_Psychic_Slam_Func001C()) then
        IssueImmediateOrderBJ(GetSpellAbilityUnit(), "stop")
    else
        SetUnitLifeBJ(GetSpellAbilityUnit(), (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) - __jreal(300.00))))
    end
end

-- Original JASS function: InitTrig_Psychic_Slam (line 8998)
function InitTrig_Psychic_Slam()
    gg_trg_Psychic_Slam = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Psychic_Slam, EVENT_PLAYER_UNIT_SPELL_CAST)
    TriggerAddCondition(gg_trg_Psychic_Slam, Condition(Trig_Psychic_Slam_Conditions))
    TriggerAddAction(gg_trg_Psychic_Slam, Trig_Psychic_Slam_Actions)
end
-- END FOREST SECTION 94

-- BEGIN FOREST SECTION 95 Soul_Rend
-- Original JASS function: Trig_Soul_Rend_Conditions (line 9008)
function Trig_Soul_Rend_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A069"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Soul_Rend_Func001C (line 9015)
function Trig_Soul_Rend_Func001C()
    if ((not ((GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) <= __jreal(350.00))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Soul_Rend_Actions (line 9022)
function Trig_Soul_Rend_Actions()
    if (Trig_Soul_Rend_Func001C()) then
        IssueImmediateOrderBJ(GetSpellAbilityUnit(), "stop")
    else
        SetUnitLifeBJ(GetSpellAbilityUnit(), (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) - __jreal(350.00))))
        SetUnitLifeBJ(GetSpellTargetUnit(), (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, GetSpellTargetUnit()) - __jreal(500.00))))
    end
end

-- Original JASS function: InitTrig_Soul_Rend (line 9032)
function InitTrig_Soul_Rend()
    gg_trg_Soul_Rend = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Soul_Rend, EVENT_PLAYER_UNIT_SPELL_CAST)
    TriggerAddCondition(gg_trg_Soul_Rend, Condition(Trig_Soul_Rend_Conditions))
    TriggerAddAction(gg_trg_Soul_Rend, Trig_Soul_Rend_Actions)
end
-- END FOREST SECTION 95

-- BEGIN FOREST SECTION 96 Dark_Blood
-- Original JASS function: Trig_Dark_Blood_Conditions (line 9042)
function Trig_Dark_Blood_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A062"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Dark_Blood_Func001C (line 9049)
function Trig_Dark_Blood_Func001C()
    if ((not ((GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) <= __jreal(400.00))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Dark_Blood_Actions (line 9056)
function Trig_Dark_Blood_Actions()
    if (Trig_Dark_Blood_Func001C()) then
        IssueImmediateOrderBJ(GetSpellAbilityUnit(), "stop")
    else
        SetUnitLifeBJ(GetSpellAbilityUnit(), (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) - __jreal(400.00))))
    end
end

-- Original JASS function: InitTrig_Dark_Blood (line 9065)
function InitTrig_Dark_Blood()
    gg_trg_Dark_Blood = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Dark_Blood, EVENT_PLAYER_UNIT_SPELL_CAST)
    TriggerAddCondition(gg_trg_Dark_Blood, Condition(Trig_Dark_Blood_Conditions))
    TriggerAddAction(gg_trg_Dark_Blood, Trig_Dark_Blood_Actions)
end
-- END FOREST SECTION 96

-- BEGIN FOREST SECTION 97 Shadowlings
-- Original JASS function: Trig_Shadowlings_Conditions (line 9075)
function Trig_Shadowlings_Conditions()
    if ((not ((GetUnitTypeId(GetSummonedUnit()) == FourCC("o01T"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Shadowlings_Actions (line 9082)
function Trig_Shadowlings_Actions()
    local summoned = GetSummonedUnit()
    TriggerSleepAction(__jreal(20.00))
    if summoned and GetUnitTypeId(summoned) ~= 0 then KillUnit(summoned) end
end

-- Original JASS function: InitTrig_Shadowlings (line 9088)
function InitTrig_Shadowlings()
    gg_trg_Shadowlings = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Shadowlings, EVENT_PLAYER_UNIT_SUMMON)
    TriggerAddCondition(gg_trg_Shadowlings, Condition(Trig_Shadowlings_Conditions))
    TriggerAddAction(gg_trg_Shadowlings, Trig_Shadowlings_Actions)
end
-- END FOREST SECTION 97

-- BEGIN FOREST SECTION 98 Levelled_Drain
-- Original JASS function: Trig_Levelled_Drain_Conditions (line 9098)
function Trig_Levelled_Drain_Conditions()
    if ((not ((GetResearched() == FourCC("R043"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Levelled_Drain_Func001002 (line 9105)
function Trig_Levelled_Drain_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A065"), GetEnumUnit())
end

-- Original JASS function: Trig_Levelled_Drain_Actions (line 9109)
function Trig_Levelled_Drain_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(0), FourCC("u009")), Trig_Levelled_Drain_Func001002)
end

-- Original JASS function: InitTrig_Levelled_Drain (line 9114)
function InitTrig_Levelled_Drain()
    gg_trg_Levelled_Drain = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Drain, Player(0), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Levelled_Drain, Condition(Trig_Levelled_Drain_Conditions))
    TriggerAddAction(gg_trg_Levelled_Drain, Trig_Levelled_Drain_Actions)
end
-- END FOREST SECTION 98

-- BEGIN FOREST SECTION 99 Levelled_Drain_Copy
-- Original JASS function: Trig_Levelled_Drain_Copy_Conditions (line 9124)
function Trig_Levelled_Drain_Copy_Conditions()
    if ((not ((GetResearched() == FourCC("R043"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Levelled_Drain_Copy_Func001002 (line 9131)
function Trig_Levelled_Drain_Copy_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A065"), GetEnumUnit())
end

-- Original JASS function: Trig_Levelled_Drain_Copy_Actions (line 9135)
function Trig_Levelled_Drain_Copy_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(1), FourCC("u009")), Trig_Levelled_Drain_Copy_Func001002)
end

-- Original JASS function: InitTrig_Levelled_Drain_Copy (line 9140)
function InitTrig_Levelled_Drain_Copy()
    gg_trg_Levelled_Drain_Copy = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Drain_Copy, Player(1), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Levelled_Drain_Copy, Condition(Trig_Levelled_Drain_Copy_Conditions))
    TriggerAddAction(gg_trg_Levelled_Drain_Copy, Trig_Levelled_Drain_Copy_Actions)
end
-- END FOREST SECTION 99

-- BEGIN FOREST SECTION 100 Levelled_Drain_Copy_2
-- Original JASS function: Trig_Levelled_Drain_Copy_2_Conditions (line 9150)
function Trig_Levelled_Drain_Copy_2_Conditions()
    if ((not ((GetResearched() == FourCC("R043"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Levelled_Drain_Copy_2_Func001002 (line 9157)
function Trig_Levelled_Drain_Copy_2_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A065"), GetEnumUnit())
end

-- Original JASS function: Trig_Levelled_Drain_Copy_2_Actions (line 9161)
function Trig_Levelled_Drain_Copy_2_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(2), FourCC("u009")), Trig_Levelled_Drain_Copy_2_Func001002)
end

-- Original JASS function: InitTrig_Levelled_Drain_Copy_2 (line 9166)
function InitTrig_Levelled_Drain_Copy_2()
    gg_trg_Levelled_Drain_Copy_2 = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Drain_Copy_2, Player(2), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Levelled_Drain_Copy_2, Condition(Trig_Levelled_Drain_Copy_2_Conditions))
    TriggerAddAction(gg_trg_Levelled_Drain_Copy_2, Trig_Levelled_Drain_Copy_2_Actions)
end
-- END FOREST SECTION 100

-- BEGIN FOREST SECTION 101 Levelled_Drain_Copy_3
-- Original JASS function: Trig_Levelled_Drain_Copy_3_Conditions (line 9176)
function Trig_Levelled_Drain_Copy_3_Conditions()
    if ((not ((GetResearched() == FourCC("R043"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Levelled_Drain_Copy_3_Func001002 (line 9183)
function Trig_Levelled_Drain_Copy_3_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A065"), GetEnumUnit())
end

-- Original JASS function: Trig_Levelled_Drain_Copy_3_Actions (line 9187)
function Trig_Levelled_Drain_Copy_3_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(3), FourCC("u009")), Trig_Levelled_Drain_Copy_3_Func001002)
end

-- Original JASS function: InitTrig_Levelled_Drain_Copy_3 (line 9192)
function InitTrig_Levelled_Drain_Copy_3()
    gg_trg_Levelled_Drain_Copy_3 = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Drain_Copy_3, Player(3), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Levelled_Drain_Copy_3, Condition(Trig_Levelled_Drain_Copy_3_Conditions))
    TriggerAddAction(gg_trg_Levelled_Drain_Copy_3, Trig_Levelled_Drain_Copy_3_Actions)
end
-- END FOREST SECTION 101

-- BEGIN FOREST SECTION 102 Levelled_Drain_Copy_4
-- Original JASS function: Trig_Levelled_Drain_Copy_4_Conditions (line 9202)
function Trig_Levelled_Drain_Copy_4_Conditions()
    if ((not ((GetResearched() == FourCC("R043"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Levelled_Drain_Copy_4_Func001002 (line 9209)
function Trig_Levelled_Drain_Copy_4_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A065"), GetEnumUnit())
end

-- Original JASS function: Trig_Levelled_Drain_Copy_4_Actions (line 9213)
function Trig_Levelled_Drain_Copy_4_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(4), FourCC("u009")), Trig_Levelled_Drain_Copy_4_Func001002)
end

-- Original JASS function: InitTrig_Levelled_Drain_Copy_4 (line 9218)
function InitTrig_Levelled_Drain_Copy_4()
    gg_trg_Levelled_Drain_Copy_4 = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Drain_Copy_4, Player(4), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Levelled_Drain_Copy_4, Condition(Trig_Levelled_Drain_Copy_4_Conditions))
    TriggerAddAction(gg_trg_Levelled_Drain_Copy_4, Trig_Levelled_Drain_Copy_4_Actions)
end
-- END FOREST SECTION 102

-- BEGIN FOREST SECTION 103 Levelled_Drain_Copy_5
-- Original JASS function: Trig_Levelled_Drain_Copy_5_Conditions (line 9228)
function Trig_Levelled_Drain_Copy_5_Conditions()
    if ((not ((GetResearched() == FourCC("R043"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Levelled_Drain_Copy_5_Func001002 (line 9235)
function Trig_Levelled_Drain_Copy_5_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A065"), GetEnumUnit())
end

-- Original JASS function: Trig_Levelled_Drain_Copy_5_Actions (line 9239)
function Trig_Levelled_Drain_Copy_5_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(5), FourCC("u009")), Trig_Levelled_Drain_Copy_5_Func001002)
end

-- Original JASS function: InitTrig_Levelled_Drain_Copy_5 (line 9244)
function InitTrig_Levelled_Drain_Copy_5()
    gg_trg_Levelled_Drain_Copy_5 = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Drain_Copy_5, Player(5), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Levelled_Drain_Copy_5, Condition(Trig_Levelled_Drain_Copy_5_Conditions))
    TriggerAddAction(gg_trg_Levelled_Drain_Copy_5, Trig_Levelled_Drain_Copy_5_Actions)
end
-- END FOREST SECTION 103

-- BEGIN FOREST SECTION 104 Levelled_Drain_Copy_6
-- Original JASS function: Trig_Levelled_Drain_Copy_6_Conditions (line 9254)
function Trig_Levelled_Drain_Copy_6_Conditions()
    if ((not ((GetResearched() == FourCC("R043"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Levelled_Drain_Copy_6_Func001002 (line 9261)
function Trig_Levelled_Drain_Copy_6_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A065"), GetEnumUnit())
end

-- Original JASS function: Trig_Levelled_Drain_Copy_6_Actions (line 9265)
function Trig_Levelled_Drain_Copy_6_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(7), FourCC("u009")), Trig_Levelled_Drain_Copy_6_Func001002)
end

-- Original JASS function: InitTrig_Levelled_Drain_Copy_6 (line 9270)
function InitTrig_Levelled_Drain_Copy_6()
    gg_trg_Levelled_Drain_Copy_6 = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Drain_Copy_6, Player(7), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Levelled_Drain_Copy_6, Condition(Trig_Levelled_Drain_Copy_6_Conditions))
    TriggerAddAction(gg_trg_Levelled_Drain_Copy_6, Trig_Levelled_Drain_Copy_6_Actions)
end
-- END FOREST SECTION 104

-- BEGIN FOREST SECTION 105 Levelled_Drain_Copy_7
-- Original JASS function: Trig_Levelled_Drain_Copy_7_Conditions (line 9280)
function Trig_Levelled_Drain_Copy_7_Conditions()
    if ((not ((GetResearched() == FourCC("R043"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Levelled_Drain_Copy_7_Func001002 (line 9287)
function Trig_Levelled_Drain_Copy_7_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A065"), GetEnumUnit())
end

-- Original JASS function: Trig_Levelled_Drain_Copy_7_Actions (line 9291)
function Trig_Levelled_Drain_Copy_7_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(8), FourCC("u009")), Trig_Levelled_Drain_Copy_7_Func001002)
end

-- Original JASS function: InitTrig_Levelled_Drain_Copy_7 (line 9296)
function InitTrig_Levelled_Drain_Copy_7()
    gg_trg_Levelled_Drain_Copy_7 = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Drain_Copy_7, Player(8), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Levelled_Drain_Copy_7, Condition(Trig_Levelled_Drain_Copy_7_Conditions))
    TriggerAddAction(gg_trg_Levelled_Drain_Copy_7, Trig_Levelled_Drain_Copy_7_Actions)
end
-- END FOREST SECTION 105

-- BEGIN FOREST SECTION 106 Levelled_Drain_Copy_8
-- Original JASS function: Trig_Levelled_Drain_Copy_8_Conditions (line 9306)
function Trig_Levelled_Drain_Copy_8_Conditions()
    if ((not ((GetResearched() == FourCC("R043"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Levelled_Drain_Copy_8_Func001002 (line 9313)
function Trig_Levelled_Drain_Copy_8_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A065"), GetEnumUnit())
end

-- Original JASS function: Trig_Levelled_Drain_Copy_8_Actions (line 9317)
function Trig_Levelled_Drain_Copy_8_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(9), FourCC("u009")), Trig_Levelled_Drain_Copy_8_Func001002)
end

-- Original JASS function: InitTrig_Levelled_Drain_Copy_8 (line 9322)
function InitTrig_Levelled_Drain_Copy_8()
    gg_trg_Levelled_Drain_Copy_8 = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Drain_Copy_8, Player(9), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Levelled_Drain_Copy_8, Condition(Trig_Levelled_Drain_Copy_8_Conditions))
    TriggerAddAction(gg_trg_Levelled_Drain_Copy_8, Trig_Levelled_Drain_Copy_8_Actions)
end
-- END FOREST SECTION 106

-- BEGIN FOREST SECTION 107 Levelled_Drain_Copy_9
-- Original JASS function: Trig_Levelled_Drain_Copy_9_Conditions (line 9332)
function Trig_Levelled_Drain_Copy_9_Conditions()
    if ((not ((GetResearched() == FourCC("R043"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Levelled_Drain_Copy_9_Func001002 (line 9339)
function Trig_Levelled_Drain_Copy_9_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A065"), GetEnumUnit())
end

-- Original JASS function: Trig_Levelled_Drain_Copy_9_Actions (line 9343)
function Trig_Levelled_Drain_Copy_9_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(10), FourCC("u009")), Trig_Levelled_Drain_Copy_9_Func001002)
end

-- Original JASS function: InitTrig_Levelled_Drain_Copy_9 (line 9348)
function InitTrig_Levelled_Drain_Copy_9()
    gg_trg_Levelled_Drain_Copy_9 = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Drain_Copy_9, Player(10), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Levelled_Drain_Copy_9, Condition(Trig_Levelled_Drain_Copy_9_Conditions))
    TriggerAddAction(gg_trg_Levelled_Drain_Copy_9, Trig_Levelled_Drain_Copy_9_Actions)
end
-- END FOREST SECTION 107

-- BEGIN FOREST SECTION 108 Drain_Setup
-- Original JASS function: Trig_Drain_Setup_Actions (line 9369)
function Trig_Drain_Setup_Actions()
    udg_ncld_Ability = FourCC("A065")
    udg_ncld_DrainHP = __jreal(20.00)
    udg_ncld_DrainHPUp = __jreal(5.00)
    udg_ncld_DrainMP = __jreal(0.00)
    udg_ncld_DrainMPUp = __jreal(0.00)
    udg_ncld_Duration = __jreal(5.00)
    udg_ncld_Duration_Up = __jreal(0.00)
    udg_ncld_Range = __jreal(950.00)
    udg_ncld_RangeUp = __jreal(0.00)
    udg_ncld_LightningArt = "DRAB"
    udg_ncld_TargetSFXArt = "Abilities\\Spells\\Other\\Drain\\DrainTarget.mdl"
    udg_ncld_CasterSFXArt = "Abilities\\Spells\\Other\\Drain\\DrainCaster.mdl"
    udg_ncld_FreqDrain = 1
    udg_ncld_FreqDistance = 20
    udg_ncld_EtherealBonus = __jreal(1.50)
    udg_ncld_buffId = (__jint(udg_ncld_buffId + 1))
    udg_ncld_BuffList[udg_ncld_buffId] = FourCC("BOwk")
    udg_ncld_CheckImmune = false
    udg_ncld_CheckResistant = false
    udg_ncld_CheckVisibile = false
    udg_tempReal = (__jreal(I2R(udg_ncld_FreqDrain) * __jreal(0.03)))
    udg_ncld_DrainHP = (__jreal(udg_ncld_DrainHP * udg_tempReal))
    udg_ncld_DrainHPUp = (__jreal(udg_ncld_DrainHPUp * udg_tempReal))
    udg_ncld_DrainMP = (__jreal(udg_ncld_DrainMP * udg_tempReal))
    udg_ncld_DrainMPUp = (__jreal(udg_ncld_DrainMPUp * udg_tempReal))
end

-- Original JASS function: InitTrig_Drain_Setup (line 9403)
function InitTrig_Drain_Setup()
    gg_trg_Drain_Setup = CreateTrigger()
    TriggerAddAction(gg_trg_Drain_Setup, Trig_Drain_Setup_Actions)
end
-- END FOREST SECTION 108

-- BEGIN FOREST SECTION 109 Drain_Cast
-- Original JASS function: Trig_Drain_Cast_Conditions (line 9411)
function Trig_Drain_Cast_Conditions()
    if ((not ((GetSpellAbilityId() == udg_ncld_Ability)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Drain_Cast_Func031C (line 9418)
function Trig_Drain_Cast_Func031C()
    if ((not ((IsTriggerEnabled(gg_trg_Drain_Loop) == false)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Drain_Cast_Actions (line 9425)
function Trig_Drain_Cast_Actions()
    udg_tempUnit = GetTriggerUnit()
    udg_Key = GetUnitUserData(udg_tempUnit)
    udg_ncld_Target[udg_Key] = GetSpellTargetUnit()
    GroupAddUnitSimple(udg_tempUnit, udg_ncld_Group)
    udg_ncld_Tick[udg_Key] = 0
    udg_ncld_TicksRemaining[udg_Key] = R2I((__jreal((__jreal(udg_ncld_Duration + (__jreal(udg_ncld_Duration_Up * I2R((__jint(GetUnitAbilityLevelSwapped(udg_ncld_Ability, udg_tempUnit) - 1))))))) * __jreal(33.00))))
    udg_ncld_Hp[udg_Key] = (__jreal(udg_ncld_DrainHP + (__jreal(udg_ncld_DrainHPUp * I2R((__jint(GetUnitAbilityLevelSwapped(udg_ncld_Ability, udg_tempUnit) - 1)))))))
    udg_ncld_Mp[udg_Key] = (__jreal(udg_ncld_DrainMP + (__jreal(udg_ncld_DrainMPUp * I2R((__jint(GetUnitAbilityLevelSwapped(udg_ncld_Ability, udg_tempUnit) - 1)))))))
    udg_ncld_Rng[udg_Key] = (__jreal(udg_ncld_Range + (__jreal(udg_ncld_RangeUp * I2R((__jint(GetUnitAbilityLevelSwapped(udg_ncld_Ability, udg_tempUnit) - 1)))))))
    udg_tempLoc1 = GetUnitLoc(udg_tempUnit)
    udg_tempX1 = GetLocationX(udg_tempLoc1)
    udg_tempY1 = GetLocationY(udg_tempLoc1)
    udg_tempZ1 = __jreal(__jreal(GetLocationZ(udg_tempLoc1) + GetUnitFlyHeight(udg_tempUnit)) + __jreal(60))
    RemoveLocation(udg_tempLoc1)
    udg_tempLoc1 = GetUnitLoc(udg_ncld_Target[udg_Key])
    udg_tempX2 = GetLocationX(udg_tempLoc1)
    udg_tempY2 = GetLocationY(udg_tempLoc1)
    udg_tempZ2 = __jreal(__jreal(GetLocationZ(udg_tempLoc1) + GetUnitFlyHeight(udg_ncld_Target[udg_Key])) + __jreal(60))
    RemoveLocation(udg_tempLoc1)
    udg_ncld_Lightning[udg_Key] = AddLightningEx(udg_ncld_LightningArt, true, udg_tempX1, udg_tempY1, udg_tempZ1, udg_tempX2, udg_tempY2, udg_tempZ2)
    AddSpecialEffectTargetUnitBJ("chest", udg_tempUnit, udg_ncld_CasterSFXArt)
    udg_ncld_CasterSFX[udg_Key] = GetLastCreatedEffectBJ()
    AddSpecialEffectTargetUnitBJ("chest", udg_ncld_Target[udg_Key], udg_ncld_TargetSFXArt)
    udg_ncld_TargetSFX[udg_Key] = GetLastCreatedEffectBJ()
    if (Trig_Drain_Cast_Func031C()) then
        EnableTrigger(gg_trg_Drain_Loop)
    else
    end
end

-- Original JASS function: InitTrig_Drain_Cast (line 9463)
function InitTrig_Drain_Cast()
    gg_trg_Drain_Cast = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Drain_Cast, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Drain_Cast, Condition(Trig_Drain_Cast_Conditions))
    TriggerAddAction(gg_trg_Drain_Cast, Trig_Drain_Cast_Actions)
end
-- END FOREST SECTION 109

-- BEGIN FOREST SECTION 110 Drain_Loop
-- Original JASS function: Trig_Drain_Loop_Func001Func005Func023Func001Func002C (line 9473)
function Trig_Drain_Loop_Func001Func005Func023Func001Func002C()
    if ((not ((IsUnitType(udg_ncld_Target[udg_Key], UNIT_TYPE_ETHEREAL) == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Drain_Loop_Func001Func005Func023Func001C (line 9480)
function Trig_Drain_Loop_Func001Func005Func023Func001C()
    if ((not ((IsUnitType(udg_ncld_Target[udg_Key], UNIT_TYPE_MAGIC_IMMUNE) == false)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Drain_Loop_Func001Func005Func023C (line 9487)
function Trig_Drain_Loop_Func001Func005Func023C()
    if ((not ((ModuloInteger(udg_ncld_Tick[udg_Key], udg_ncld_FreqDrain) == 0)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Drain_Loop_Func001Func005Func025Func002Func001C (line 9494)
function Trig_Drain_Loop_Func001Func005Func025Func002Func001C()
    if ((not ((UnitHasBuffBJ(udg_ncld_Target[udg_Key], udg_ncld_BuffList[udg_LoopBuffs]) == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Drain_Loop_Func001Func005Func025Func003Func002C (line 9501)
function Trig_Drain_Loop_Func001Func005Func025Func003Func002C()
    if ((not ((IsUnitType(udg_ncld_Target[udg_Key], UNIT_TYPE_MAGIC_IMMUNE) == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Drain_Loop_Func001Func005Func025Func003C (line 9508)
function Trig_Drain_Loop_Func001Func005Func025Func003C()
    if ((not ((udg_ncld_CheckImmune == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Drain_Loop_Func001Func005Func025Func004Func002C (line 9515)
function Trig_Drain_Loop_Func001Func005Func025Func004Func002C()
    if ((not ((IsUnitType(udg_ncld_Target[udg_Key], UNIT_TYPE_RESISTANT) == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Drain_Loop_Func001Func005Func025Func004C (line 9522)
function Trig_Drain_Loop_Func001Func005Func025Func004C()
    if ((not ((udg_ncld_CheckResistant == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Drain_Loop_Func001Func005Func025Func005Func002C (line 9529)
function Trig_Drain_Loop_Func001Func005Func025Func005Func002C()
    if ((not ((IsUnitVisible(udg_ncld_Target[udg_Key], GetOwningPlayer(udg_tempUnit)) == false)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Drain_Loop_Func001Func005Func025Func005C (line 9536)
function Trig_Drain_Loop_Func001Func005Func025Func005C()
    if ((not ((udg_ncld_CheckVisibile == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Drain_Loop_Func001Func005Func025Func006Func001C (line 9543)
function Trig_Drain_Loop_Func001Func005Func025Func006Func001C()
    if (((udg_CheckBool == false))) then
        do return true end
    end
    if (((IsUnitDeadBJ(udg_ncld_Target[udg_Key]) == true))) then
        do return true end
    end
    if (((IsUnitHiddenBJ(udg_ncld_Target[udg_Key]) == true))) then
        do return true end
    end
    do return false end
end

-- Original JASS function: Trig_Drain_Loop_Func001Func005Func025Func006C (line 9556)
function Trig_Drain_Loop_Func001Func005Func025Func006C()
    if ((not Trig_Drain_Loop_Func001Func005Func025Func006Func001C())) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Drain_Loop_Func001Func005Func025Func008C (line 9563)
function Trig_Drain_Loop_Func001Func005Func025Func008C()
    if ((not ((udg_tempDistance > udg_ncld_Rng[udg_Key])))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Drain_Loop_Func001Func005Func025C (line 9570)
function Trig_Drain_Loop_Func001Func005Func025C()
    if ((not ((ModuloInteger(udg_ncld_Tick[udg_Key], udg_ncld_FreqDistance) == 0)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Drain_Loop_Func001Func005C (line 9577)
function Trig_Drain_Loop_Func001Func005C()
    if ((not ((udg_ncld_TicksRemaining[udg_Key] >= 0)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Drain_Loop_Func001A (line 9584)
function Trig_Drain_Loop_Func001A()
    udg_tempUnit = GetEnumUnit()
    udg_Key = GetUnitUserData(udg_tempUnit)
    udg_ncld_TicksRemaining[udg_Key] = (__jint(udg_ncld_TicksRemaining[udg_Key] - 1))
    if (Trig_Drain_Loop_Func001Func005C()) then
        udg_ncld_Tick[udg_Key] = (__jint(udg_ncld_Tick[udg_Key] + 1))
        udg_tempLoc1 = GetUnitLoc(udg_tempUnit)
        udg_tempLoc2 = GetUnitLoc(udg_ncld_Target[udg_Key])
        udg_tempX1 = GetLocationX(udg_tempLoc1)
        udg_tempY1 = GetLocationY(udg_tempLoc1)
        udg_tempZ1 = __jreal(__jreal(GetLocationZ(udg_tempLoc1) + GetUnitFlyHeight(udg_tempUnit)) + __jreal(60))
        udg_tempX2 = GetLocationX(udg_tempLoc2)
        udg_tempY2 = GetLocationY(udg_tempLoc2)
        udg_tempZ2 = __jreal(__jreal(GetLocationZ(udg_tempLoc2) + GetUnitFlyHeight(udg_ncld_Target[udg_Key])) + __jreal(60))
        MoveLightningEx(udg_ncld_Lightning[udg_Key], true, udg_tempX1, udg_tempY1, udg_tempZ1, udg_tempX2, udg_tempY2, udg_tempZ2)
        if (Trig_Drain_Loop_Func001Func005Func023C()) then
            if (Trig_Drain_Loop_Func001Func005Func023Func001C()) then
                UnitDamageTargetBJ(udg_tempUnit, udg_ncld_Target[udg_Key], __jreal(0.00), ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL)
                if (Trig_Drain_Loop_Func001Func005Func023Func001Func002C()) then
                    SetUnitLifeBJ(udg_ncld_Target[udg_Key], (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, udg_ncld_Target[udg_Key]) - (__jreal(udg_ncld_Hp[udg_Key] * udg_ncld_EtherealBonus)))))
                    SetUnitManaBJ(udg_ncld_Target[udg_Key], (__jreal(GetUnitStateSwap(UNIT_STATE_MANA, udg_ncld_Target[udg_Key]) - (__jreal(udg_ncld_Mp[udg_Key] * udg_ncld_EtherealBonus)))))
                    SetUnitLifeBJ(udg_tempUnit, (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, udg_tempUnit) + (__jreal(udg_ncld_Hp[udg_Key] * udg_ncld_EtherealBonus)))))
                    SetUnitManaBJ(udg_tempUnit, (__jreal(GetUnitStateSwap(UNIT_STATE_MANA, udg_tempUnit) + (__jreal(udg_ncld_Mp[udg_Key] * udg_ncld_EtherealBonus)))))
                else
                    SetUnitLifeBJ(udg_ncld_Target[udg_Key], (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, udg_ncld_Target[udg_Key]) - udg_ncld_Hp[udg_Key])))
                    SetUnitManaBJ(udg_ncld_Target[udg_Key], (__jreal(GetUnitStateSwap(UNIT_STATE_MANA, udg_ncld_Target[udg_Key]) - udg_ncld_Mp[udg_Key])))
                    SetUnitLifeBJ(udg_tempUnit, (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, udg_tempUnit) + udg_ncld_Hp[udg_Key])))
                    SetUnitManaBJ(udg_tempUnit, (__jreal(GetUnitStateSwap(UNIT_STATE_MANA, udg_tempUnit) + udg_ncld_Mp[udg_Key])))
                end
            else
            end
        else
        end
        if (Trig_Drain_Loop_Func001Func005Func025C()) then
            udg_tempDistance = DistanceBetweenPoints(udg_tempLoc1, udg_tempLoc2)
            if (Trig_Drain_Loop_Func001Func005Func025Func008C()) then
                udg_ncld_Tick[udg_Key] = 0
                udg_ncld_TicksRemaining[udg_Key] = 0
                GroupRemoveUnitSimple(udg_tempUnit, udg_ncld_Group)
                udg_ncld_Target[udg_Key] = nil
                DestroyLightningBJ(udg_ncld_Lightning[udg_Key])
                DestroyEffectBJ(udg_ncld_CasterSFX[udg_Key])
                DestroyEffectBJ(udg_ncld_TargetSFX[udg_Key])
            else
            end
        else
            udg_CheckBool = true
            udg_LoopBuffs = 1
            while true do
                if (udg_LoopBuffs > udg_ncld_buffId) then break end
                if (Trig_Drain_Loop_Func001Func005Func025Func002Func001C()) then
                    udg_CheckBool = false
                else
                end
                udg_LoopBuffs = __jint(udg_LoopBuffs + 1)
            end
            if (Trig_Drain_Loop_Func001Func005Func025Func003C()) then
                if (Trig_Drain_Loop_Func001Func005Func025Func003Func002C()) then
                    udg_CheckBool = false
                else
                end
            else
            end
            if (Trig_Drain_Loop_Func001Func005Func025Func004C()) then
                if (Trig_Drain_Loop_Func001Func005Func025Func004Func002C()) then
                    udg_CheckBool = false
                else
                end
            else
            end
            if (Trig_Drain_Loop_Func001Func005Func025Func005C()) then
                if (Trig_Drain_Loop_Func001Func005Func025Func005Func002C()) then
                    udg_CheckBool = false
                else
                end
            else
            end
            if (Trig_Drain_Loop_Func001Func005Func025Func006C()) then
                udg_ncld_Tick[udg_Key] = 0
                udg_ncld_TicksRemaining[udg_Key] = 0
                GroupRemoveUnitSimple(udg_tempUnit, udg_ncld_Group)
                udg_ncld_Target[udg_Key] = nil
                DestroyLightningBJ(udg_ncld_Lightning[udg_Key])
                DestroyEffectBJ(udg_ncld_CasterSFX[udg_Key])
                DestroyEffectBJ(udg_ncld_TargetSFX[udg_Key])
            else
            end
        end
        RemoveLocation(udg_tempLoc1)
        RemoveLocation(udg_tempLoc1)
    else
        udg_ncld_Tick[udg_Key] = 0
        GroupRemoveUnitSimple(udg_tempUnit, udg_ncld_Group)
        udg_ncld_Target[udg_Key] = nil
        DestroyLightningBJ(udg_ncld_Lightning[udg_Key])
        DestroyEffectBJ(udg_ncld_CasterSFX[udg_Key])
        DestroyEffectBJ(udg_ncld_TargetSFX[udg_Key])
    end
end

-- Original JASS function: Trig_Drain_Loop_Func002C (line 9694)
function Trig_Drain_Loop_Func002C()
    if ((not ((IsUnitGroupEmptyBJ(udg_ncld_Group) == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Drain_Loop_Actions (line 9701)
function Trig_Drain_Loop_Actions()
    ForGroupBJ(udg_ncld_Group, Trig_Drain_Loop_Func001A)
    if (Trig_Drain_Loop_Func002C()) then
        DisableTrigger(GetTriggeringTrigger())
    else
    end
end

-- Original JASS function: InitTrig_Drain_Loop (line 9710)
function InitTrig_Drain_Loop()
    gg_trg_Drain_Loop = CreateTrigger()
    DisableTrigger(gg_trg_Drain_Loop)
    TriggerRegisterTimerEventPeriodic(gg_trg_Drain_Loop, __jreal(0.03))
    TriggerAddAction(gg_trg_Drain_Loop, Trig_Drain_Loop_Actions)
end
-- END FOREST SECTION 110

-- BEGIN FOREST SECTION 111 Levelled_Slam
-- Original JASS function: Trig_Levelled_Slam_Conditions (line 9720)
function Trig_Levelled_Slam_Conditions()
    if ((not ((GetResearched() == FourCC("R043"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Levelled_Slam_Func001002 (line 9727)
function Trig_Levelled_Slam_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A063"), GetEnumUnit())
end

-- Original JASS function: Trig_Levelled_Slam_Actions (line 9731)
function Trig_Levelled_Slam_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(0), FourCC("u009")), Trig_Levelled_Slam_Func001002)
end

-- Original JASS function: InitTrig_Levelled_Slam (line 9736)
function InitTrig_Levelled_Slam()
    gg_trg_Levelled_Slam = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Slam, Player(0), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Levelled_Slam, Condition(Trig_Levelled_Slam_Conditions))
    TriggerAddAction(gg_trg_Levelled_Slam, Trig_Levelled_Slam_Actions)
end
-- END FOREST SECTION 111

-- BEGIN FOREST SECTION 112 Levelled_Slam_Copy
-- Original JASS function: Trig_Levelled_Slam_Copy_Conditions (line 9746)
function Trig_Levelled_Slam_Copy_Conditions()
    if ((not ((GetResearched() == FourCC("R043"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Levelled_Slam_Copy_Func001002 (line 9753)
function Trig_Levelled_Slam_Copy_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A063"), GetEnumUnit())
end

-- Original JASS function: Trig_Levelled_Slam_Copy_Actions (line 9757)
function Trig_Levelled_Slam_Copy_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(1), FourCC("u009")), Trig_Levelled_Slam_Copy_Func001002)
end

-- Original JASS function: InitTrig_Levelled_Slam_Copy (line 9762)
function InitTrig_Levelled_Slam_Copy()
    gg_trg_Levelled_Slam_Copy = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Slam_Copy, Player(1), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Levelled_Slam_Copy, Condition(Trig_Levelled_Slam_Copy_Conditions))
    TriggerAddAction(gg_trg_Levelled_Slam_Copy, Trig_Levelled_Slam_Copy_Actions)
end
-- END FOREST SECTION 112

-- BEGIN FOREST SECTION 113 Levelled_Slam_Copy_2
-- Original JASS function: Trig_Levelled_Slam_Copy_2_Conditions (line 9772)
function Trig_Levelled_Slam_Copy_2_Conditions()
    if ((not ((GetResearched() == FourCC("R043"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Levelled_Slam_Copy_2_Func001002 (line 9779)
function Trig_Levelled_Slam_Copy_2_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A063"), GetEnumUnit())
end

-- Original JASS function: Trig_Levelled_Slam_Copy_2_Actions (line 9783)
function Trig_Levelled_Slam_Copy_2_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(2), FourCC("u009")), Trig_Levelled_Slam_Copy_2_Func001002)
end

-- Original JASS function: InitTrig_Levelled_Slam_Copy_2 (line 9788)
function InitTrig_Levelled_Slam_Copy_2()
    gg_trg_Levelled_Slam_Copy_2 = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Slam_Copy_2, Player(2), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Levelled_Slam_Copy_2, Condition(Trig_Levelled_Slam_Copy_2_Conditions))
    TriggerAddAction(gg_trg_Levelled_Slam_Copy_2, Trig_Levelled_Slam_Copy_2_Actions)
end
-- END FOREST SECTION 113

-- BEGIN FOREST SECTION 114 Levelled_Slam_Copy_3
-- Original JASS function: Trig_Levelled_Slam_Copy_3_Conditions (line 9798)
function Trig_Levelled_Slam_Copy_3_Conditions()
    if ((not ((GetResearched() == FourCC("R043"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Levelled_Slam_Copy_3_Func001002 (line 9805)
function Trig_Levelled_Slam_Copy_3_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A063"), GetEnumUnit())
end

-- Original JASS function: Trig_Levelled_Slam_Copy_3_Actions (line 9809)
function Trig_Levelled_Slam_Copy_3_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(3), FourCC("u009")), Trig_Levelled_Slam_Copy_3_Func001002)
end

-- Original JASS function: InitTrig_Levelled_Slam_Copy_3 (line 9814)
function InitTrig_Levelled_Slam_Copy_3()
    gg_trg_Levelled_Slam_Copy_3 = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Slam_Copy_3, Player(3), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Levelled_Slam_Copy_3, Condition(Trig_Levelled_Slam_Copy_3_Conditions))
    TriggerAddAction(gg_trg_Levelled_Slam_Copy_3, Trig_Levelled_Slam_Copy_3_Actions)
end
-- END FOREST SECTION 114

-- BEGIN FOREST SECTION 115 Levelled_Slam_Copy_4
-- Original JASS function: Trig_Levelled_Slam_Copy_4_Conditions (line 9824)
function Trig_Levelled_Slam_Copy_4_Conditions()
    if ((not ((GetResearched() == FourCC("R043"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Levelled_Slam_Copy_4_Func001002 (line 9831)
function Trig_Levelled_Slam_Copy_4_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A063"), GetEnumUnit())
end

-- Original JASS function: Trig_Levelled_Slam_Copy_4_Actions (line 9835)
function Trig_Levelled_Slam_Copy_4_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(4), FourCC("u009")), Trig_Levelled_Slam_Copy_4_Func001002)
end

-- Original JASS function: InitTrig_Levelled_Slam_Copy_4 (line 9840)
function InitTrig_Levelled_Slam_Copy_4()
    gg_trg_Levelled_Slam_Copy_4 = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Slam_Copy_4, Player(4), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Levelled_Slam_Copy_4, Condition(Trig_Levelled_Slam_Copy_4_Conditions))
    TriggerAddAction(gg_trg_Levelled_Slam_Copy_4, Trig_Levelled_Slam_Copy_4_Actions)
end
-- END FOREST SECTION 115

-- BEGIN FOREST SECTION 116 Levelled_Slam_Copy_5
-- Original JASS function: Trig_Levelled_Slam_Copy_5_Conditions (line 9850)
function Trig_Levelled_Slam_Copy_5_Conditions()
    if ((not ((GetResearched() == FourCC("R043"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Levelled_Slam_Copy_5_Func001002 (line 9857)
function Trig_Levelled_Slam_Copy_5_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A063"), GetEnumUnit())
end

-- Original JASS function: Trig_Levelled_Slam_Copy_5_Actions (line 9861)
function Trig_Levelled_Slam_Copy_5_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(5), FourCC("u009")), Trig_Levelled_Slam_Copy_5_Func001002)
end

-- Original JASS function: InitTrig_Levelled_Slam_Copy_5 (line 9866)
function InitTrig_Levelled_Slam_Copy_5()
    gg_trg_Levelled_Slam_Copy_5 = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Slam_Copy_5, Player(5), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Levelled_Slam_Copy_5, Condition(Trig_Levelled_Slam_Copy_5_Conditions))
    TriggerAddAction(gg_trg_Levelled_Slam_Copy_5, Trig_Levelled_Slam_Copy_5_Actions)
end
-- END FOREST SECTION 116

-- BEGIN FOREST SECTION 117 Levelled_Slam_Copy_6
-- Original JASS function: Trig_Levelled_Slam_Copy_6_Conditions (line 9876)
function Trig_Levelled_Slam_Copy_6_Conditions()
    if ((not ((GetResearched() == FourCC("R043"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Levelled_Slam_Copy_6_Func001002 (line 9883)
function Trig_Levelled_Slam_Copy_6_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A063"), GetEnumUnit())
end

-- Original JASS function: Trig_Levelled_Slam_Copy_6_Actions (line 9887)
function Trig_Levelled_Slam_Copy_6_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(7), FourCC("u009")), Trig_Levelled_Slam_Copy_6_Func001002)
end

-- Original JASS function: InitTrig_Levelled_Slam_Copy_6 (line 9892)
function InitTrig_Levelled_Slam_Copy_6()
    gg_trg_Levelled_Slam_Copy_6 = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Slam_Copy_6, Player(7), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Levelled_Slam_Copy_6, Condition(Trig_Levelled_Slam_Copy_6_Conditions))
    TriggerAddAction(gg_trg_Levelled_Slam_Copy_6, Trig_Levelled_Slam_Copy_6_Actions)
end
-- END FOREST SECTION 117

-- BEGIN FOREST SECTION 118 Levelled_Slam_Copy_7
-- Original JASS function: Trig_Levelled_Slam_Copy_7_Conditions (line 9902)
function Trig_Levelled_Slam_Copy_7_Conditions()
    if ((not ((GetResearched() == FourCC("R043"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Levelled_Slam_Copy_7_Func001002 (line 9909)
function Trig_Levelled_Slam_Copy_7_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A063"), GetEnumUnit())
end

-- Original JASS function: Trig_Levelled_Slam_Copy_7_Actions (line 9913)
function Trig_Levelled_Slam_Copy_7_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(8), FourCC("u009")), Trig_Levelled_Slam_Copy_7_Func001002)
end

-- Original JASS function: InitTrig_Levelled_Slam_Copy_7 (line 9918)
function InitTrig_Levelled_Slam_Copy_7()
    gg_trg_Levelled_Slam_Copy_7 = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Slam_Copy_7, Player(8), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Levelled_Slam_Copy_7, Condition(Trig_Levelled_Slam_Copy_7_Conditions))
    TriggerAddAction(gg_trg_Levelled_Slam_Copy_7, Trig_Levelled_Slam_Copy_7_Actions)
end
-- END FOREST SECTION 118

-- BEGIN FOREST SECTION 119 Levelled_Slam_Copy_8
-- Original JASS function: Trig_Levelled_Slam_Copy_8_Conditions (line 9928)
function Trig_Levelled_Slam_Copy_8_Conditions()
    if ((not ((GetResearched() == FourCC("R043"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Levelled_Slam_Copy_8_Func001002 (line 9935)
function Trig_Levelled_Slam_Copy_8_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A063"), GetEnumUnit())
end

-- Original JASS function: Trig_Levelled_Slam_Copy_8_Actions (line 9939)
function Trig_Levelled_Slam_Copy_8_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(9), FourCC("u009")), Trig_Levelled_Slam_Copy_8_Func001002)
end

-- Original JASS function: InitTrig_Levelled_Slam_Copy_8 (line 9944)
function InitTrig_Levelled_Slam_Copy_8()
    gg_trg_Levelled_Slam_Copy_8 = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Slam_Copy_8, Player(9), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Levelled_Slam_Copy_8, Condition(Trig_Levelled_Slam_Copy_8_Conditions))
    TriggerAddAction(gg_trg_Levelled_Slam_Copy_8, Trig_Levelled_Slam_Copy_8_Actions)
end
-- END FOREST SECTION 119

-- BEGIN FOREST SECTION 120 Levelled_Slam_Copy_9
-- Original JASS function: Trig_Levelled_Slam_Copy_9_Conditions (line 9954)
function Trig_Levelled_Slam_Copy_9_Conditions()
    if ((not ((GetResearched() == FourCC("R043"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Levelled_Slam_Copy_9_Func001002 (line 9961)
function Trig_Levelled_Slam_Copy_9_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A063"), GetEnumUnit())
end

-- Original JASS function: Trig_Levelled_Slam_Copy_9_Actions (line 9965)
function Trig_Levelled_Slam_Copy_9_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(10), FourCC("u009")), Trig_Levelled_Slam_Copy_9_Func001002)
end

-- Original JASS function: InitTrig_Levelled_Slam_Copy_9 (line 9970)
function InitTrig_Levelled_Slam_Copy_9()
    gg_trg_Levelled_Slam_Copy_9 = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Slam_Copy_9, Player(10), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Levelled_Slam_Copy_9, Condition(Trig_Levelled_Slam_Copy_9_Conditions))
    TriggerAddAction(gg_trg_Levelled_Slam_Copy_9, Trig_Levelled_Slam_Copy_9_Actions)
end
-- END FOREST SECTION 120
-- END FOREST MODULE src/races/forgotten/bloodmage.lua

-- BEGIN FOREST MODULE src/races/nerubian.lua
-- races / nerubian
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 121 LevelUpAura
-- Original JASS function: Trig_LevelUpAura_Conditions (line 9980)
function Trig_LevelUpAura_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("h059"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_LevelUpAura_Func003A (line 9987)
function Trig_LevelUpAura_Func003A()
    SetUnitAbilityLevelSwapped(FourCC("A09S"), GetEnumUnit(), udg_Ziggurats_Count)
    SetUnitAbilityLevelSwapped(FourCC("A0A1"), GetEnumUnit(), udg_Ziggurats_Count)
end

-- Original JASS function: Trig_LevelUpAura_Actions (line 9992)
function Trig_LevelUpAura_Actions()
    GroupAddUnitSimple(GetTriggerUnit(), udg_Ziggurats)
    udg_Ziggurats_Count = (__jint(udg_Ziggurats_Count + 1))
    ForGroupBJ(udg_Ziggurats, Trig_LevelUpAura_Func003A)
end

-- Original JASS function: InitTrig_LevelUpAura (line 9999)
function InitTrig_LevelUpAura()
    gg_trg_LevelUpAura = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_LevelUpAura, EVENT_PLAYER_UNIT_UPGRADE_FINISH)
    TriggerAddCondition(gg_trg_LevelUpAura, Condition(Trig_LevelUpAura_Conditions))
    TriggerAddAction(gg_trg_LevelUpAura, Trig_LevelUpAura_Actions)
end
-- END FOREST SECTION 121

-- BEGIN FOREST SECTION 122 DowngradeAura
-- Original JASS function: Trig_DowngradeAura_Conditions (line 10009)
function Trig_DowngradeAura_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("h059"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_DowngradeAura_Func003A (line 10016)
function Trig_DowngradeAura_Func003A()
    SetUnitAbilityLevelSwapped(FourCC("A09S"), GetEnumUnit(), udg_Ziggurats_Count)
    SetUnitAbilityLevelSwapped(FourCC("A0A1"), GetEnumUnit(), udg_Ziggurats_Count)
end

-- Original JASS function: Trig_DowngradeAura_Actions (line 10021)
function Trig_DowngradeAura_Actions()
    GroupAddUnitSimple(GetTriggerUnit(), udg_Ziggurats)
    udg_Ziggurats_Count = (__jint(udg_Ziggurats_Count - 1))
    ForGroupBJ(udg_Ziggurats, Trig_DowngradeAura_Func003A)
end

-- Original JASS function: InitTrig_DowngradeAura (line 10028)
function InitTrig_DowngradeAura()
    gg_trg_DowngradeAura = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_DowngradeAura, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_DowngradeAura, Condition(Trig_DowngradeAura_Conditions))
    TriggerAddAction(gg_trg_DowngradeAura, Trig_DowngradeAura_Actions)
end
-- END FOREST SECTION 122

-- BEGIN FOREST SECTION 123 NerubianSpires
-- Original JASS function: IsBaseBuilding (line 10039)
function IsBaseBuilding(baseId, upgradedId)
    if (((baseId == FourCC("hkee")) and (upgradedId == FourCC("hcas")))) then
        do return true end
    elseif (((baseId == FourCC("hbar")) and (upgradedId == FourCC("hbax")))) then
        do return true end
    end
    do return false end
end

-- Original JASS function: CheckNearbyUpgrades (line 10050)
function CheckNearbyUpgrades(u)
    local g = CreateGroup()
    local b = nil
    local result = false
    local newBuildingId = GetUnitTypeId(u)
    GroupEnumUnitsInRange(g, GetUnitX(u), GetUnitY(u), __jreal(2000), nil)
    while true do
        b = FirstOfGroup(g)
        if (b == nil) then break end
        if ((GetUnitTypeId(b) == newBuildingId) and (not (((GetUnitX(u) == GetUnitX(b)) and (GetUnitY(u) == GetUnitY(b)))))) then
            result = true
            if true then break end
        end
        GroupRemoveUnit(g, b)
    end
    DestroyGroup(g)
    do return result end
end

-- Original JASS function: OnConstructionStart (line 10072)
function OnConstructionStart()
    local u = GetTriggerUnit()
    if (GetUnitTypeId(GetTriggerUnit()) == FourCC("h059")) then
        if CheckNearbyUpgrades(u) then
            DisplayTextToPlayer(GetOwningPlayer(u), __jreal(0), __jreal(0), "Upgrading too close to an existing building!")
            TriggerSleepAction(__jreal(0.1))
            IssueImmediateOrderById(u, 851976)
        end
    end
end

-- Original JASS function: InitTrig_NerubianSpires (line 10086)
function InitTrig_NerubianSpires()
    local t = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_UPGRADE_START)
    TriggerAddAction(t, OnConstructionStart)
end
-- END FOREST SECTION 123

-- BEGIN FOREST SECTION 124 Frenzy
-- Original JASS function: Trig_Frenzy_Conditions (line 10097)
function Trig_Frenzy_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A09X"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Frenzy_Actions (line 10104)
function Trig_Frenzy_Actions()
    CreateNUnitsAtLoc(1, FourCC("h04L"), GetOwningPlayer(GetTriggerUnit()), GetUnitLoc(GetTriggerUnit()), bj_UNIT_FACING)
    UnitAddAbilityBJ(FourCC("A09Y"), GetLastCreatedUnit())
    UnitApplyTimedLifeBJ(__jreal(2.00), FourCC("BTLF"), GetLastCreatedUnit())
    IssueTargetOrderBJ(GetLastCreatedUnit(), "unholyfrenzy", GetSpellAbilityUnit())
end

-- Original JASS function: InitTrig_Frenzy (line 10112)
function InitTrig_Frenzy()
    gg_trg_Frenzy = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Frenzy, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Frenzy, Condition(Trig_Frenzy_Conditions))
    TriggerAddAction(gg_trg_Frenzy, Trig_Frenzy_Actions)
end
-- END FOREST SECTION 124
-- END FOREST MODULE src/races/nerubian.lua

-- BEGIN FOREST MODULE src/races/ratling.lua
-- races / ratling
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 125 Chemical_Rage
-- Original JASS function: CHEMICAL_RAGE_ABILITY (line 10125)
function CHEMICAL_RAGE_ABILITY()
    do return FourCC("A0CU") end
end

-- Original JASS function: DUMMY_ABILITY (line 10129)
function DUMMY_ABILITY()
    do return FourCC("A0CV") end
end

-- Original JASS function: DUMMY_UNIT_ID (line 10133)
function DUMMY_UNIT_ID()
    do return FourCC("h04L") end
end

-- Original JASS function: ChemicalRageCondition (line 10140)
function ChemicalRageCondition()
    do return (GetSpellAbilityId() == (FourCC("A0CU"))) end
end

-- Original JASS function: ChemicalRageActions (line 10147)
function ChemicalRageActions()
    local caster = GetTriggerUnit()
    local p = GetOwningPlayer(caster)
    local dummy = nil
    local i = 0
    dummy = CreateUnit(p, (FourCC("h04L")), GetUnitX(caster), GetUnitY(caster), __jreal(0))
    UnitAddAbility(dummy, (FourCC("A0CV")))
    IssueTargetOrder(dummy, "bloodlust", caster)
    BlzSetUnitWeaponRealField(caster, UNIT_WEAPON_RF_ATTACK_BASE_COOLDOWN, 0, __jreal(1.25))
    TriggerSleepAction(__jreal(20.0))
    RemoveUnit(dummy)
    dummy = nil
    if ((caster == nil) or IsUnitType(caster, UNIT_TYPE_DEAD)) then
        caster = nil
        p = nil
        do return end
    end
    if ((caster ~= nil) and (not IsUnitType(caster, UNIT_TYPE_DEAD))) then
        BlzSetUnitWeaponRealField(caster, UNIT_WEAPON_RF_ATTACK_BASE_COOLDOWN, 0, __jreal(1.75))
    end
    caster = nil
    p = nil
end

-- Original JASS function: InitTrig_Chemical_Rage (line 10187)
function InitTrig_Chemical_Rage()
    local t = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_SPELL_FINISH)
    TriggerAddCondition(t, Condition(ChemicalRageCondition))
    TriggerAddAction(t, ChemicalRageActions)
end
-- END FOREST SECTION 125

-- BEGIN FOREST SECTION 126 ReduceMagicResist
-- Original JASS function: Trig_ReduceMagicResist_Conditions (line 10196)
function Trig_ReduceMagicResist_Conditions()
    if ((not ((UnitHasBuffBJ(udg_DamageEventTarget, FourCC("B03O")) == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_ReduceMagicResist_Actions (line 10203)
function Trig_ReduceMagicResist_Actions()
    UnitAddAbilityBJ(FourCC("A0CT"), udg_DamageEventTarget)
    GroupAddUnitSimple(udg_DamageEventTarget, udg_Acided)
end

-- Original JASS function: InitTrig_ReduceMagicResist (line 10209)
function InitTrig_ReduceMagicResist()
    gg_trg_ReduceMagicResist = CreateTrigger()
    h__TriggerRegisterVariableEvent(gg_trg_ReduceMagicResist, "udg_DamageEvent", EQUAL, __jreal(1.00))
    TriggerAddCondition(gg_trg_ReduceMagicResist, Condition(Trig_ReduceMagicResist_Conditions))
    TriggerAddAction(gg_trg_ReduceMagicResist, Trig_ReduceMagicResist_Actions)
end
-- END FOREST SECTION 126

-- BEGIN FOREST SECTION 127 ReduceMagicResist2
-- Original JASS function: Trig_ReduceMagicResist2_Func001Func001C (line 10219)
function Trig_ReduceMagicResist2_Func001Func001C()
    if ((not ((UnitHasBuffBJ(GetEnumUnit(), FourCC("B03O")) == false)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_ReduceMagicResist2_Func001A (line 10226)
function Trig_ReduceMagicResist2_Func001A()
    if (Trig_ReduceMagicResist2_Func001Func001C()) then
    else
        UnitRemoveAbilityBJ(FourCC("A0CT"), GetEnumUnit())
        GroupRemoveUnitSimple(GetEnumUnit(), udg_Acided)
    end
end

-- Original JASS function: Trig_ReduceMagicResist2_Actions (line 10234)
function Trig_ReduceMagicResist2_Actions()
    ForGroupBJ(udg_Acided, Trig_ReduceMagicResist2_Func001A)
end

-- Original JASS function: InitTrig_ReduceMagicResist2 (line 10239)
function InitTrig_ReduceMagicResist2()
    gg_trg_ReduceMagicResist2 = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(gg_trg_ReduceMagicResist2, __jreal(0.50))
    TriggerAddAction(gg_trg_ReduceMagicResist2, Trig_ReduceMagicResist2_Actions)
end
-- END FOREST SECTION 127

-- BEGIN FOREST SECTION 128 TargetAcquired
-- Original JASS function: Trig_TargetAcquired_Conditions (line 10248)
function Trig_TargetAcquired_Conditions()
    if ((not ((GetPlayerTechCountSimple(FourCC("R06S"), GetOwningPlayer(udg_DamageEventSource)) == 1)))) then
        do return false end
    end
    if ((not ((udg_IsDamageAttack == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_TargetAcquired_Func004C (line 10258)
function Trig_TargetAcquired_Func004C()
    if ((not ((GetRandomReal(__jreal(0.00), __jreal(100.00)) <= __jreal(30.00))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_TargetAcquired_Actions (line 10265)
function Trig_TargetAcquired_Actions()
    if (Trig_TargetAcquired_Func004C()) then
        if (not s__DamageTrigger_configured[s__DamageTrigger_eventIndex]) then
            udg_DamageFilterSourceT = FourCC("o026")
            s__DamageTrigger_configure(s__DamageTrigger_eventIndex)
        end
        if (not s__DamageTrigger_checkConfig(s__DamageTrigger_eventIndex)) then
            do return end
        end
        udg_DamageEventAttackT = udg_ATTACK_TYPE_CHAOS
        udg_DamageEventArmorPierced = __jreal(10.00)
        udg_TSEDuration = __jreal(1.00)
        udg_TSEScale = __jreal(0.75)
        udg_TSEAttachPoint = "overhead"
        udg_TSEEffectName = "war3mapImported\\SnipingTarget.mdx"
        udg_TSETargetUnit = udg_DamageEventTarget
        ConditionalTriggerExecute(udg_TSE_RegisterTrigger)
    else
    end
end

-- Original JASS function: InitTrig_TargetAcquired (line 10291)
function InitTrig_TargetAcquired()
    gg_trg_TargetAcquired = CreateTrigger()
    h__TriggerRegisterVariableEvent(gg_trg_TargetAcquired, "udg_PreDamageEvent", LESS_THAN, __jreal(1.00))
    TriggerAddCondition(gg_trg_TargetAcquired, Condition(Trig_TargetAcquired_Conditions))
    TriggerAddAction(gg_trg_TargetAcquired, Trig_TargetAcquired_Actions)
end
-- END FOREST SECTION 128

-- BEGIN FOREST SECTION 129 Poisoned_Bullets2
-- Original JASS function: Trig_Poisoned_Bullets2_Conditions (line 10301)
function Trig_Poisoned_Bullets2_Conditions()
    if ((not ((GetPlayerTechCountSimple(FourCC("R06R"), GetOwningPlayer(GetAttacker())) >= 1)))) then
        do return false end
    end
    if ((not ((GetUnitTypeId(GetAttacker()) == FourCC("o026"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Poisoned_Bullets2_Actions (line 10311)
function Trig_Poisoned_Bullets2_Actions()
    if ((GetUnitAbilityLevel(GetAttackedUnitBJ(), FourCC("Bspo")) == 0)) then
        SetUnitAbilityLevelSwapped(FourCC("A0CQ"), GetAttackedUnitBJ(), 1)
    end
    SetUnitAbilityLevelSwapped(FourCC("A0CO"), GetAttacker(), GetUnitAbilityLevel((GetAttackedUnitBJ()), FourCC("A0CQ")))
end

-- Original JASS function: InitTrig_Poisoned_Bullets2 (line 10319)
function InitTrig_Poisoned_Bullets2()
    gg_trg_Poisoned_Bullets2 = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Poisoned_Bullets2, EVENT_PLAYER_UNIT_ATTACKED)
    TriggerAddCondition(gg_trg_Poisoned_Bullets2, Condition(Trig_Poisoned_Bullets2_Conditions))
    TriggerAddAction(gg_trg_Poisoned_Bullets2, Trig_Poisoned_Bullets2_Actions)
end
-- END FOREST SECTION 129

-- BEGIN FOREST SECTION 130 Poisoned_Bullets
-- Original JASS function: Trig_Poisoned_Bullets_Conditions (line 10330)
function Trig_Poisoned_Bullets_Conditions()
    if ((not ((GetPlayerTechCountSimple(FourCC("R06R"), GetOwningPlayer(udg_DamageEventSource)) >= 1)))) then
        do return false end
    end
    if ((not ((GetUnitTypeId(udg_DamageEventSource) == FourCC("o026"))))) then
        do return false end
    end
    if ((not ((udg_IsDamageAttack == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Poisoned_Bullets_Actions (line 10343)
function Trig_Poisoned_Bullets_Actions()
    local var = 0
    if ((GetUnitAbilityLevel(udg_DamageEventTarget, FourCC("Bspo")) > 0)) then
        if ((GetUnitAbilityLevel(udg_DamageEventTarget, FourCC("A0CQ")) == 0)) then
            UnitAddAbility(udg_DamageEventTarget, FourCC("A0CQ"))
        end
        var = GetUnitAbilityLevel((udg_DamageEventTarget), FourCC("A0CQ"))
        IncUnitAbilityLevelSwapped(FourCC("A0CQ"), udg_DamageEventTarget)
    end
end

-- Original JASS function: InitTrig_Poisoned_Bullets (line 10355)
function InitTrig_Poisoned_Bullets()
    gg_trg_Poisoned_Bullets = CreateTrigger()
    h__TriggerRegisterVariableEvent(gg_trg_Poisoned_Bullets, "udg_PreDamageEvent", EQUAL, __jreal(1.00))
    TriggerAddCondition(gg_trg_Poisoned_Bullets, Condition(Trig_Poisoned_Bullets_Conditions))
    TriggerAddAction(gg_trg_Poisoned_Bullets, Trig_Poisoned_Bullets_Actions)
end
-- END FOREST SECTION 130

-- BEGIN FOREST SECTION 131 Permanent_Invisibility
-- Original JASS function: Trig_Permanent_Invisibility_Conditions (line 10366)
function Trig_Permanent_Invisibility_Conditions()
    if ((not ((GetResearched() == FourCC("R06K"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Permanent_Invisibility_Func001A (line 10373)
function Trig_Permanent_Invisibility_Func001A()
    UnitAddAbilityBJ(FourCC("A0CK"), GetEnumUnit())
    udg_SilentStrider[GetConvertedPlayerId(GetOwningPlayer(GetResearchingUnit()))] = true
end

-- Original JASS function: Trig_Permanent_Invisibility_Actions (line 10378)
function Trig_Permanent_Invisibility_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(GetOwningPlayer(GetResearchingUnit()), FourCC("o026")), Trig_Permanent_Invisibility_Func001A)
end

-- Original JASS function: InitTrig_Permanent_Invisibility (line 10383)
function InitTrig_Permanent_Invisibility()
    gg_trg_Permanent_Invisibility = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Permanent_Invisibility, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Permanent_Invisibility, Condition(Trig_Permanent_Invisibility_Conditions))
    TriggerAddAction(gg_trg_Permanent_Invisibility, Trig_Permanent_Invisibility_Actions)
end
-- END FOREST SECTION 131

-- BEGIN FOREST SECTION 132 Permanent_Invisibility_2
-- Original JASS function: Trig_Permanent_Invisibility_2_Conditions (line 10393)
function Trig_Permanent_Invisibility_2_Conditions()
    if ((not ((udg_SilentStrider[GetConvertedPlayerId(GetOwningPlayer(GetEnteringUnit()))] == true)))) then
        do return false end
    end
    if ((not ((GetUnitTypeId(GetEnteringUnit()) == FourCC("o026"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Permanent_Invisibility_2_Func002A (line 10403)
function Trig_Permanent_Invisibility_2_Func002A()
    UnitAddAbilityBJ(FourCC("A0CK"), GetEnumUnit())
end

-- Original JASS function: Trig_Permanent_Invisibility_2_Actions (line 10407)
function Trig_Permanent_Invisibility_2_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(GetOwningPlayer(GetResearchingUnit()), FourCC("o026")), Trig_Permanent_Invisibility_2_Func002A)
end

-- Original JASS function: InitTrig_Permanent_Invisibility_2 (line 10412)
function InitTrig_Permanent_Invisibility_2()
    gg_trg_Permanent_Invisibility_2 = CreateTrigger()
    TriggerRegisterEnterRectSimple(gg_trg_Permanent_Invisibility_2, GetPlayableMapRect())
    TriggerAddCondition(gg_trg_Permanent_Invisibility_2, Condition(Trig_Permanent_Invisibility_2_Conditions))
    TriggerAddAction(gg_trg_Permanent_Invisibility_2, Trig_Permanent_Invisibility_2_Actions)
end
-- END FOREST SECTION 132

-- BEGIN FOREST SECTION 133 Sticky_Glue
-- Original JASS function: Trig_Sticky_Glue_Conditions (line 10422)
function Trig_Sticky_Glue_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A0CL"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Sticky_Glue_Actions (line 10429)
function Trig_Sticky_Glue_Actions()
    CreateNUnitsAtLoc(1, FourCC("n010"), GetOwningPlayer(GetSpellAbilityUnit()), GetSpellTargetLoc(), bj_UNIT_FACING)
    UnitApplyTimedLifeBJ(__jreal(6.00), FourCC("BTLF"), GetLastCreatedUnit())
end

-- Original JASS function: InitTrig_Sticky_Glue (line 10435)
function InitTrig_Sticky_Glue()
    gg_trg_Sticky_Glue = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Sticky_Glue, EVENT_PLAYER_UNIT_SPELL_CAST)
    TriggerAddCondition(gg_trg_Sticky_Glue, Condition(Trig_Sticky_Glue_Conditions))
    TriggerAddAction(gg_trg_Sticky_Glue, Trig_Sticky_Glue_Actions)
end
-- END FOREST SECTION 133
-- END FOREST MODULE src/races/ratling.lua

-- BEGIN FOREST MODULE src/races/razormane.lua
-- races / razormane
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 134 Wood_Income
-- Original JASS function: Trig_Wood_Income_Func001002 (line 10445)
function Trig_Wood_Income_Func001002()
    AdjustPlayerStateBJ((__jdiv(GetPlayerState(GetEnumPlayer(), PLAYER_STATE_RESOURCE_FOOD_USED), 2)), GetEnumPlayer(), PLAYER_STATE_RESOURCE_LUMBER)
end

-- Original JASS function: Trig_Wood_Income_Actions (line 10449)
function Trig_Wood_Income_Actions()
    ForForce(udg_Razormane, Trig_Wood_Income_Func001002)
end

-- Original JASS function: InitTrig_Wood_Income (line 10454)
function InitTrig_Wood_Income()
    gg_trg_Wood_Income = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(gg_trg_Wood_Income, __jreal(10.00))
    TriggerAddAction(gg_trg_Wood_Income, Trig_Wood_Income_Actions)
end
-- END FOREST SECTION 134

-- BEGIN FOREST SECTION 135 Enter_Wood_Income
-- Original JASS function: Trig_Enter_Wood_Income_Conditions (line 10463)
function Trig_Enter_Wood_Income_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("o01E"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Enter_Wood_Income_Actions (line 10470)
function Trig_Enter_Wood_Income_Actions()
    ForceAddPlayerSimple(GetOwningPlayer(GetTriggerUnit()), udg_Razormane)
end

-- Original JASS function: InitTrig_Enter_Wood_Income (line 10475)
function InitTrig_Enter_Wood_Income()
    gg_trg_Enter_Wood_Income = CreateTrigger()
    TriggerRegisterEnterRectSimple(gg_trg_Enter_Wood_Income, gg_rct_Spawn_all)
    TriggerAddCondition(gg_trg_Enter_Wood_Income, Condition(Trig_Enter_Wood_Income_Conditions))
    TriggerAddAction(gg_trg_Enter_Wood_Income, Trig_Enter_Wood_Income_Actions)
end
-- END FOREST SECTION 135
-- END FOREST MODULE src/races/razormane.lua

-- BEGIN FOREST MODULE src/races/wisp.lua
-- races / wisp
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 136 SeedOfRebirth
-- Original JASS function: Trig_SeedOfRebirth_Conditions (line 10485)
function Trig_SeedOfRebirth_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A0B9"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_SeedOfRebirth_IsSeedTargetType (line 10492)
function Trig_SeedOfRebirth_IsSeedTargetType(u)
    local id = GetUnitTypeId(u)
    do return (((((((((((id == FourCC("e00E")) or (id == FourCC("e00C"))) or (id == FourCC("e002"))) or (id == FourCC("e009"))) or (id == FourCC("e00A"))) or (id == FourCC("e00G"))) or (id == FourCC("e00J"))) or (id == FourCC("e00O"))) or (id == FourCC("e00H"))) or (id == FourCC("e00N"))) or (id == FourCC("e00S"))) end
end

-- Original JASS function: Trig_SeedOfRebirth_Func001Func006002 (line 10497)
function Trig_SeedOfRebirth_Func001Func006002()
    RemoveUnit(GetEnumUnit())
end

-- Original JASS function: Trig_SeedOfRebirth_Func001Func010Func001C (line 10501)
function Trig_SeedOfRebirth_Func001Func010Func001C()
    if ((not ((IsPlayerEnemy(ConvertedPlayer(udg_SeedPlayedNumber), GetEnumPlayer()) == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_SeedOfRebirth_Func001Func010A (line 10508)
function Trig_SeedOfRebirth_Func001Func010A()
    if (Trig_SeedOfRebirth_Func001Func010Func001C()) then
        SetPlayerAllianceStateBJ(udg_DeadPlayer, GetEnumPlayer(), bj_ALLIANCE_ALLIED_VISION)
        SetPlayerAllianceStateBJ(GetEnumPlayer(), udg_DeadPlayer, bj_ALLIANCE_ALLIED_VISION)
    else
    end
end

-- Original JASS function: Trig_SeedOfRebirth_Func001Func011A (line 10517)
function Trig_SeedOfRebirth_Func001Func011A()
    SetPlayerAllianceStateBJ(udg_DeadPlayer, GetEnumPlayer(), bj_ALLIANCE_UNALLIED)
    SetPlayerAllianceStateBJ(GetEnumPlayer(), udg_DeadPlayer, bj_ALLIANCE_UNALLIED)
end

-- Original JASS function: Trig_SeedOfRebirth_Func001C (line 10522)
function Trig_SeedOfRebirth_Func001C()
    do return Trig_SeedOfRebirth_IsSeedTargetType(GetSpellTargetUnit()) end
end

-- Original JASS function: Trig_SeedOfRebirth_Actions (line 10526)
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

-- Original JASS function: InitTrig_SeedOfRebirth (line 10544)
function InitTrig_SeedOfRebirth()
    gg_trg_SeedOfRebirth = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_SeedOfRebirth, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_SeedOfRebirth, Condition(Trig_SeedOfRebirth_Conditions))
    TriggerAddAction(gg_trg_SeedOfRebirth, Trig_SeedOfRebirth_Actions)
end
-- END FOREST SECTION 136
-- END FOREST MODULE src/races/wisp.lua

-- BEGIN FOREST MODULE src/races/wildkin.lua
-- races / wildkin
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 137 Ancient_Artifact
-- Original JASS function: Trig_Ancient_Artifact_Conditions (line 10553)
function Trig_Ancient_Artifact_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A07D"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Ancient_Artifact_Actions (line 10560)
function Trig_Ancient_Artifact_Actions()
    SetUnitLifePercentBJ(GetSpellAbilityUnit(), (__jreal(GetUnitLifePercent(GetSpellAbilityUnit()) + __jreal(50.00))))
end

-- Original JASS function: InitTrig_Ancient_Artifact (line 10565)
function InitTrig_Ancient_Artifact()
    gg_trg_Ancient_Artifact = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Ancient_Artifact, EVENT_PLAYER_UNIT_SPELL_CAST)
    TriggerAddCondition(gg_trg_Ancient_Artifact, Condition(Trig_Ancient_Artifact_Conditions))
    TriggerAddAction(gg_trg_Ancient_Artifact, Trig_Ancient_Artifact_Actions)
end
-- END FOREST SECTION 137

-- BEGIN FOREST SECTION 138 Moonstrike
-- Original JASS function: Trig_Moonstrike_Conditions (line 10577)
function Trig_Moonstrike_Conditions()
    do return (GetSpellAbilityId() == FourCC("A07F")) end
end

-- Original JASS function: Trig_Moonstrike_Actions (line 10581)
function Trig_Moonstrike_Actions()
    local target = GetSpellTargetUnit()
    local caster = GetTriggerUnit()
    local damage = __jreal(GetUnitState(caster, UNIT_STATE_MAX_MANA) * __jreal(0.2))
    TriggerSleepAction(__jreal(0.25))
    if (((GetUnitTypeId(caster) ~= 0) and (GetUnitTypeId(target) ~= 0)) and (GetWidgetLife(target) > __jreal(0.405))) then
        UnitDamageTarget(caster, target, damage, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
    end
    target = nil
    caster = nil
end

-- Original JASS function: InitTrig_Moonstrike (line 10597)
function InitTrig_Moonstrike()
    gg_trg_Moonstrike = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Moonstrike, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Moonstrike, Condition(Trig_Moonstrike_Conditions))
    TriggerAddAction(gg_trg_Moonstrike, Trig_Moonstrike_Actions)
end
-- END FOREST SECTION 138

-- BEGIN FOREST SECTION 139 Moonstrike_Leveled
-- Original JASS function: Trig_Moonstrike_Leveled_Conditions (line 10606)
function Trig_Moonstrike_Leveled_Conditions()
    if ((not ((GetResearched() == FourCC("R051"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Moonstrike_Leveled_Func001002 (line 10613)
function Trig_Moonstrike_Leveled_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A07F"), GetEnumUnit())
end

-- Original JASS function: Trig_Moonstrike_Leveled_Actions (line 10617)
function Trig_Moonstrike_Leveled_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(GetTriggerPlayer(), FourCC("h010")), Trig_Moonstrike_Leveled_Func001002)
end

-- Original JASS function: InitTrig_Moonstrike_Leveled (line 10622)
function InitTrig_Moonstrike_Leveled()
    gg_trg_Moonstrike_Leveled = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Moonstrike_Leveled, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Moonstrike_Leveled, Condition(Trig_Moonstrike_Leveled_Conditions))
    TriggerAddAction(gg_trg_Moonstrike_Leveled, Trig_Moonstrike_Leveled_Actions)
end
-- END FOREST SECTION 139

-- BEGIN FOREST SECTION 140 Moonblast
-- Original JASS function: Trig_Moonblast_Conditions (line 10633)
function Trig_Moonblast_Conditions()
    do return (GetSpellAbilityId() == MOONBLAST_ABILITY_ID) end
end

-- Original JASS function: Trig_Moonblast_Cleanup (line 10637)
function Trig_Moonblast_Cleanup(t)
    local id = GetHandleId(t)
    local missile = LoadEffectHandle(udg_MoonblastHash, id, 2)
    DestroyEffect(missile)
    FlushChildHashtable(udg_MoonblastHash, id)
    PauseTimer(t)
    DestroyTimer(t)
    missile = nil
end

-- Original JASS function: Trig_Moonblast_Timer (line 10649)
function Trig_Moonblast_Timer()
    local t = GetExpiredTimer()
    local id = GetHandleId(t)
    local caster = LoadUnitHandle(udg_MoonblastHash, id, 0)
    local target = LoadUnitHandle(udg_MoonblastHash, id, 1)
    local missile = LoadEffectHandle(udg_MoonblastHash, id, 2)
    local damage = LoadReal(udg_MoonblastHash, id, 3)
    local x = LoadReal(udg_MoonblastHash, id, 4)
    local y = LoadReal(udg_MoonblastHash, id, 5)
    local tx = 0.0
    local ty = 0.0
    local dx = 0.0
    local dy = 0.0
    local dist = 0.0
    local step = __jreal(MOONBLAST_SPEED * MOONBLAST_TICK)
    if (((GetUnitTypeId(caster) == 0) or (GetUnitTypeId(target) == 0)) or (GetWidgetLife(target) <= __jreal(0.405))) then
        Trig_Moonblast_Cleanup(t)
    else
        tx = GetUnitX(target)
        ty = GetUnitY(target)
        dx = __jreal(tx - x)
        dy = __jreal(ty - y)
        dist = SquareRoot(__jreal(__jreal(dx * dx) + __jreal(dy * dy)))
        if ((dist <= MOONBLAST_COLLISION) or (dist <= step)) then
            BlzSetSpecialEffectX(missile, tx)
            BlzSetSpecialEffectY(missile, ty)
            UnitDamageTarget(caster, target, damage, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
            Trig_Moonblast_Cleanup(t)
        else
            x = __jreal(x + __jreal(__jreal(dx / dist) * step))
            y = __jreal(y + __jreal(__jreal(dy / dist) * step))
            SaveReal(udg_MoonblastHash, id, 4, x)
            SaveReal(udg_MoonblastHash, id, 5, y)
            BlzSetSpecialEffectX(missile, x)
            BlzSetSpecialEffectY(missile, y)
            BlzSetSpecialEffectYaw(missile, Atan2(dy, dx))
        end
    end
    caster = nil
    target = nil
    missile = nil
    t = nil
end

-- Original JASS function: Trig_Moonblast_Actions (line 10697)
function Trig_Moonblast_Actions()
    local target = GetSpellTargetUnit()
    local caster = GetTriggerUnit()
    local t = nil
    local id = 0
    local missile = nil
    local x = 0.0
    local y = 0.0
    local dx = 0.0
    local dy = 0.0
    if ((target == nil) or (caster == nil)) then
        target = nil
        caster = nil
        do return end
    end
    t = CreateTimer()
    id = GetHandleId(t)
    x = GetUnitX(caster)
    y = GetUnitY(caster)
    dx = __jreal(GetUnitX(target) - x)
    dy = __jreal(GetUnitY(target) - y)
    missile = AddSpecialEffect(MOONBLAST_MISSILE_MODEL, x, y)
    BlzSetSpecialEffectYaw(missile, Atan2(dy, dx))
    SaveUnitHandle(udg_MoonblastHash, id, 0, caster)
    SaveUnitHandle(udg_MoonblastHash, id, 1, target)
    SaveEffectHandle(udg_MoonblastHash, id, 2, missile)
    SaveReal(udg_MoonblastHash, id, 3, __jreal(GetUnitState(caster, UNIT_STATE_MAX_MANA) * MOONBLAST_DAMAGE_FACTOR))
    SaveReal(udg_MoonblastHash, id, 4, x)
    SaveReal(udg_MoonblastHash, id, 5, y)
    TimerStart(t, MOONBLAST_TICK, true, Trig_Moonblast_Timer)
    target = nil
    caster = nil
    missile = nil
    t = nil
end

-- Original JASS function: InitTrig_Moonblast (line 10740)
function InitTrig_Moonblast()
    gg_trg_Moonblast = CreateTrigger()
    if (udg_MoonblastHash == nil) then
        udg_MoonblastHash = InitHashtable()
    end
    TriggerRegisterAnyUnitEventBJ(gg_trg_Moonblast, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Moonblast, Condition(Trig_Moonblast_Conditions))
    TriggerAddAction(gg_trg_Moonblast, Trig_Moonblast_Actions)
end
-- END FOREST SECTION 140

-- BEGIN FOREST SECTION 141 Moonblast_Leveled
-- Original JASS function: Trig_Moonblast_Leveled_Conditions (line 10754)
function Trig_Moonblast_Leveled_Conditions()
    if ((not ((GetResearched() == FourCC("R051"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Moonblast_Leveled_Func001002 (line 10761)
function Trig_Moonblast_Leveled_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A07H"), GetEnumUnit())
end

-- Original JASS function: Trig_Moonblast_Leveled_Actions (line 10765)
function Trig_Moonblast_Leveled_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(GetTriggerPlayer(), FourCC("h010")), Trig_Moonblast_Leveled_Func001002)
end

-- Original JASS function: InitTrig_Moonblast_Leveled (line 10770)
function InitTrig_Moonblast_Leveled()
    gg_trg_Moonblast_Leveled = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Moonblast_Leveled, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Moonblast_Leveled, Condition(Trig_Moonblast_Leveled_Conditions))
    TriggerAddAction(gg_trg_Moonblast_Leveled, Trig_Moonblast_Leveled_Actions)
end
-- END FOREST SECTION 141

-- BEGIN FOREST SECTION 142 Lunar_Assault
-- Original JASS function: Trig_Lunar_Assault_Conditions (line 10782)
function Trig_Lunar_Assault_Conditions()
    do return (GetSpellAbilityId() == FourCC("A07I")) end
end

-- Original JASS function: Trig_Lunar_Assault_Actions (line 10786)
function Trig_Lunar_Assault_Actions()
    local target = GetSpellTargetUnit()
    local caster = GetTriggerUnit()
    local level = GetUnitAbilityLevel(caster, FourCC("A07I"))
    local factor = __jreal(__jreal(0.20) + __jreal(__jreal(0.10) * __jreal((__jint(level - 1)))))
    local damage = __jreal(GetUnitState(caster, UNIT_STATE_MAX_MANA) * factor)
    if (((GetUnitTypeId(caster) ~= 0) and (GetUnitTypeId(target) ~= 0)) and (GetWidgetLife(target) > __jreal(0.405))) then
        UnitDamageTarget(caster, target, damage, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
    end
    target = nil
    caster = nil
end

-- Original JASS function: InitTrig_Lunar_Assault (line 10802)
function InitTrig_Lunar_Assault()
    gg_trg_Lunar_Assault = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Lunar_Assault, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Lunar_Assault, Condition(Trig_Lunar_Assault_Conditions))
    TriggerAddAction(gg_trg_Lunar_Assault, Trig_Lunar_Assault_Actions)
end
-- END FOREST SECTION 142

-- BEGIN FOREST SECTION 143 Lunar_Assault_Leveled
-- Original JASS function: Trig_Lunar_Assault_Leveled_Conditions (line 10811)
function Trig_Lunar_Assault_Leveled_Conditions()
    if ((not ((GetResearched() == FourCC("R051"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Lunar_Assault_Leveled_Func001002 (line 10818)
function Trig_Lunar_Assault_Leveled_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A07I"), GetEnumUnit())
end

-- Original JASS function: Trig_Lunar_Assault_Leveled_Actions (line 10822)
function Trig_Lunar_Assault_Leveled_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(GetTriggerPlayer(), FourCC("h010")), Trig_Lunar_Assault_Leveled_Func001002)
end

-- Original JASS function: InitTrig_Lunar_Assault_Leveled (line 10827)
function InitTrig_Lunar_Assault_Leveled()
    gg_trg_Lunar_Assault_Leveled = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Lunar_Assault_Leveled, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Lunar_Assault_Leveled, Condition(Trig_Lunar_Assault_Leveled_Conditions))
    TriggerAddAction(gg_trg_Lunar_Assault_Leveled, Trig_Lunar_Assault_Leveled_Actions)
end
-- END FOREST SECTION 143

-- BEGIN FOREST SECTION 144 Cascade_Leveled
-- Original JASS function: Trig_Cascade_Leveled_Conditions (line 10837)
function Trig_Cascade_Leveled_Conditions()
    if ((not ((GetResearched() == FourCC("R051"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Cascade_Leveled_Func001002 (line 10844)
function Trig_Cascade_Leveled_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A07J"), GetEnumUnit())
end

-- Original JASS function: Trig_Cascade_Leveled_Actions (line 10848)
function Trig_Cascade_Leveled_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(GetTriggerPlayer(), FourCC("h010")), Trig_Cascade_Leveled_Func001002)
end

-- Original JASS function: InitTrig_Cascade_Leveled (line 10853)
function InitTrig_Cascade_Leveled()
    gg_trg_Cascade_Leveled = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Cascade_Leveled, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Cascade_Leveled, Condition(Trig_Cascade_Leveled_Conditions))
    TriggerAddAction(gg_trg_Cascade_Leveled, Trig_Cascade_Leveled_Actions)
end
-- END FOREST SECTION 144

-- BEGIN FOREST SECTION 145 Nourish
-- Original JASS function: Trig_Nourish_Conditions (line 10863)
function Trig_Nourish_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A07K"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Nourish_Actions (line 10870)
function Trig_Nourish_Actions()
    SetUnitLifeBJ(GetSpellTargetUnit(), (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, GetSpellTargetUnit()) + (__jreal(GetUnitStateSwap(UNIT_STATE_MAX_MANA, GetSpellAbilityUnit()) * __jreal(0.50))))))
end

-- Original JASS function: InitTrig_Nourish (line 10875)
function InitTrig_Nourish()
    gg_trg_Nourish = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Nourish, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Nourish, Condition(Trig_Nourish_Conditions))
    TriggerAddAction(gg_trg_Nourish, Trig_Nourish_Actions)
end
-- END FOREST SECTION 145

-- BEGIN FOREST SECTION 146 Nourish_Leveled
-- Original JASS function: Trig_Nourish_Leveled_Conditions (line 10885)
function Trig_Nourish_Leveled_Conditions()
    if ((not ((GetResearched() == FourCC("R051"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Nourish_Leveled_Func001002 (line 10892)
function Trig_Nourish_Leveled_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A07K"), GetEnumUnit())
end

-- Original JASS function: Trig_Nourish_Leveled_Actions (line 10896)
function Trig_Nourish_Leveled_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(GetTriggerPlayer(), FourCC("h010")), Trig_Nourish_Leveled_Func001002)
end

-- Original JASS function: InitTrig_Nourish_Leveled (line 10901)
function InitTrig_Nourish_Leveled()
    gg_trg_Nourish_Leveled = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Nourish_Leveled, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Nourish_Leveled, Condition(Trig_Nourish_Leveled_Conditions))
    TriggerAddAction(gg_trg_Nourish_Leveled, Trig_Nourish_Leveled_Actions)
end
-- END FOREST SECTION 146

-- BEGIN FOREST SECTION 147 Solar_Blast
-- Original JASS function: Trig_Solar_Blast_Conditions (line 10913)
function Trig_Solar_Blast_Conditions()
    do return (GetSpellAbilityId() == FourCC("A07L")) end
end

-- Original JASS function: Trig_Solar_Blast_Actions (line 10917)
function Trig_Solar_Blast_Actions()
    local target = GetSpellTargetUnit()
    local caster = GetTriggerUnit()
    local mana = GetUnitState(caster, UNIT_STATE_MANA)
    local damage = __jreal(mana * __jreal(1.33))
    if (((GetUnitTypeId(caster) ~= 0) and (GetUnitTypeId(target) ~= 0)) and (GetWidgetLife(target) > __jreal(0.405))) then
        UnitDamageTarget(caster, target, damage, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
    end
    if (GetUnitTypeId(caster) ~= 0) then
        SetUnitState(caster, UNIT_STATE_MANA, __jreal(0.00))
    end
    target = nil
    caster = nil
end

-- Original JASS function: InitTrig_Solar_Blast (line 10936)
function InitTrig_Solar_Blast()
    gg_trg_Solar_Blast = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Solar_Blast, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Solar_Blast, Condition(Trig_Solar_Blast_Conditions))
    TriggerAddAction(gg_trg_Solar_Blast, Trig_Solar_Blast_Actions)
end
-- END FOREST SECTION 147

-- BEGIN FOREST SECTION 148 Natural_Vigil_Leveled
-- Original JASS function: Trig_Natural_Vigil_Leveled_Conditions (line 10945)
function Trig_Natural_Vigil_Leveled_Conditions()
    if ((not ((GetResearched() == FourCC("R051"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Natural_Vigil_Leveled_Func001002 (line 10952)
function Trig_Natural_Vigil_Leveled_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A07M"), GetEnumUnit())
end

-- Original JASS function: Trig_Natural_Vigil_Leveled_Actions (line 10956)
function Trig_Natural_Vigil_Leveled_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(GetTriggerPlayer(), FourCC("h010")), Trig_Natural_Vigil_Leveled_Func001002)
end

-- Original JASS function: InitTrig_Natural_Vigil_Leveled (line 10961)
function InitTrig_Natural_Vigil_Leveled()
    gg_trg_Natural_Vigil_Leveled = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Natural_Vigil_Leveled, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Natural_Vigil_Leveled, Condition(Trig_Natural_Vigil_Leveled_Conditions))
    TriggerAddAction(gg_trg_Natural_Vigil_Leveled, Trig_Natural_Vigil_Leveled_Actions)
end
-- END FOREST SECTION 148

-- BEGIN FOREST SECTION 149 Lifebloom_Leveled
-- Original JASS function: Trig_Lifebloom_Leveled_Conditions (line 10971)
function Trig_Lifebloom_Leveled_Conditions()
    if ((not ((GetResearched() == FourCC("R051"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Lifebloom_Leveled_Func001002 (line 10978)
function Trig_Lifebloom_Leveled_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A07N"), GetEnumUnit())
end

-- Original JASS function: Trig_Lifebloom_Leveled_Actions (line 10982)
function Trig_Lifebloom_Leveled_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(GetTriggerPlayer(), FourCC("h010")), Trig_Lifebloom_Leveled_Func001002)
end

-- Original JASS function: InitTrig_Lifebloom_Leveled (line 10987)
function InitTrig_Lifebloom_Leveled()
    gg_trg_Lifebloom_Leveled = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Lifebloom_Leveled, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Lifebloom_Leveled, Condition(Trig_Lifebloom_Leveled_Conditions))
    TriggerAddAction(gg_trg_Lifebloom_Leveled, Trig_Lifebloom_Leveled_Actions)
end
-- END FOREST SECTION 149

-- BEGIN FOREST SECTION 150 Suns_Fury
-- Original JASS function: Trig_Suns_Fury_Conditions (line 10997)
function Trig_Suns_Fury_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A087"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Suns_Fury_Actions (line 11004)
function Trig_Suns_Fury_Actions()
    UnitResetCooldown(GetSpellAbilityUnit())
end

-- Original JASS function: InitTrig_Suns_Fury (line 11009)
function InitTrig_Suns_Fury()
    gg_trg_Suns_Fury = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Suns_Fury, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Suns_Fury, Condition(Trig_Suns_Fury_Conditions))
    TriggerAddAction(gg_trg_Suns_Fury, Trig_Suns_Fury_Actions)
end
-- END FOREST SECTION 150
-- END FOREST MODULE src/races/wildkin.lua

-- BEGIN FOREST MODULE src/races/worgen.lua
-- races / worgen
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 151 Return_lumber
-- Original JASS function: Trig_Return_lumber_Conditions (line 11019)
function Trig_Return_lumber_Conditions()
    if ((not ((GetIssuedOrderIdBJ() == String2OrderIdBJ("harvest"))))) then
        do return false end
    end
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("h00R"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Return_lumber_Actions (line 11029)
function Trig_Return_lumber_Actions()
    SetPlayerStateBJ(GetOwningPlayer(GetTriggerUnit()), PLAYER_STATE_RESOURCE_GOLD, (__jint(GetPlayerState(GetOwningPlayer(GetTriggerUnit()), PLAYER_STATE_RESOURCE_GOLD) + 1)))
end

-- Original JASS function: InitTrig_Return_lumber (line 11034)
function InitTrig_Return_lumber()
    gg_trg_Return_lumber = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Return_lumber, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER)
    TriggerAddCondition(gg_trg_Return_lumber, Condition(Trig_Return_lumber_Conditions))
    TriggerAddAction(gg_trg_Return_lumber, Trig_Return_lumber_Actions)
end
-- END FOREST SECTION 151

-- BEGIN FOREST SECTION 152 Slash_Leveled
-- Original JASS function: Trig_Slash_Leveled_Conditions (line 11044)
function Trig_Slash_Leveled_Conditions()
    if ((not ((GetResearched() == FourCC("R030"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Slash_Leveled_Func001002 (line 11051)
function Trig_Slash_Leveled_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A042"), GetEnumUnit())
end

-- Original JASS function: Trig_Slash_Leveled_Actions (line 11055)
function Trig_Slash_Leveled_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(GetTriggerPlayer(), FourCC("h00R")), Trig_Slash_Leveled_Func001002)
end

-- Original JASS function: InitTrig_Slash_Leveled (line 11060)
function InitTrig_Slash_Leveled()
    gg_trg_Slash_Leveled = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Slash_Leveled, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Slash_Leveled, Condition(Trig_Slash_Leveled_Conditions))
    TriggerAddAction(gg_trg_Slash_Leveled, Trig_Slash_Leveled_Actions)
end
-- END FOREST SECTION 152

-- BEGIN FOREST SECTION 153 Bleed_Leveled
-- Original JASS function: Trig_Bleed_Leveled_Conditions (line 11070)
function Trig_Bleed_Leveled_Conditions()
    if ((not ((GetResearched() == FourCC("R030"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Bleed_Leveled_Func001002 (line 11077)
function Trig_Bleed_Leveled_Func001002()
    IncUnitAbilityLevelSwapped(FourCC("A04C"), GetEnumUnit())
end

-- Original JASS function: Trig_Bleed_Leveled_Actions (line 11081)
function Trig_Bleed_Leveled_Actions()
    ForGroupBJ(GetUnitsOfPlayerAndTypeId(GetTriggerPlayer(), FourCC("h00R")), Trig_Bleed_Leveled_Func001002)
end

-- Original JASS function: InitTrig_Bleed_Leveled (line 11086)
function InitTrig_Bleed_Leveled()
    gg_trg_Bleed_Leveled = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Bleed_Leveled, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    TriggerAddCondition(gg_trg_Bleed_Leveled, Condition(Trig_Bleed_Leveled_Conditions))
    TriggerAddAction(gg_trg_Bleed_Leveled, Trig_Bleed_Leveled_Actions)
end
-- END FOREST SECTION 153

-- BEGIN FOREST SECTION 154 Focused_Strike
-- Original JASS function: Trig_Focused_Strike_Conditions (line 11096)
function Trig_Focused_Strike_Conditions()
    if ((not ((GetUnitTypeId(GetAttacker()) == FourCC("h00R"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Focused_Strike_Actions (line 11103)
function Trig_Focused_Strike_Actions()
    local attacker = GetAttacker()
    TriggerSleepAction(__jreal(0.50))
    if GetUnitTypeId(attacker) ~= 0 then UnitRemoveBuffBJ(FourCC("B02U"), attacker) end
end

-- Original JASS function: InitTrig_Focused_Strike (line 11111)
function InitTrig_Focused_Strike()
    gg_trg_Focused_Strike = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Focused_Strike, EVENT_PLAYER_UNIT_ATTACKED)
    TriggerAddCondition(gg_trg_Focused_Strike, Condition(Trig_Focused_Strike_Conditions))
    TriggerAddAction(gg_trg_Focused_Strike, Trig_Focused_Strike_Actions)
end
-- END FOREST SECTION 154
-- END FOREST MODULE src/races/worgen.lua

-- BEGIN FOREST MODULE src/combat/spells.lua
-- combat / spells
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 155 FanOfKnivesBasedSpells
-- Original JASS function: BURST_IsSupportedAbility (line 11122)
function BURST_IsSupportedAbility(abilId)
    do return ((abilId == BURST_DRAGONIC_ABIL_ID) or (abilId == BURST_LICH_ABIL_ID)) end
end

-- Original JASS function: BURST_GetMissileModel (line 11126)
function BURST_GetMissileModel(abilId)
    if (abilId == BURST_DRAGONIC_ABIL_ID) then
        do return "units\\creeps\\RedDragonWelp\\RedDragonWelp.mdl" end
    end
    if (abilId == BURST_LICH_ABIL_ID) then
        do return "Abilities\\Weapons\\LichMissile\\LichMissile.mdl" end
    end
    do return "" end
end

-- Original JASS function: BURST_GetMissileSpeed (line 11138)
function BURST_GetMissileSpeed(abilId, level)
    if (abilId == BURST_DRAGONIC_ABIL_ID) then
        do return __jreal(700.00) end
    end
    if (abilId == BURST_LICH_ABIL_ID) then
        do return __jreal(500.00) end
    end
    do return __jreal(0.00) end
end

-- Original JASS function: BURST_GetMissileHeight (line 11150)
function BURST_GetMissileHeight(abilId, level)
    if (abilId == BURST_DRAGONIC_ABIL_ID) then
        do return __jreal(200.00) end
    end
    if (abilId == BURST_LICH_ABIL_ID) then
        do return __jreal(70.00) end
    end
    do return __jreal(70.00) end
end

-- Original JASS function: BURST_GetMissileScale (line 11162)
function BURST_GetMissileScale(abilId, level)
    if (abilId == BURST_DRAGONIC_ABIL_ID) then
        do return __jreal(1.50) end
    end
    if (abilId == BURST_LICH_ABIL_ID) then
        do return __jreal(1.00) end
    end
    do return __jreal(1.00) end
end

-- Original JASS function: BURST_GetHitRange (line 11174)
function BURST_GetHitRange(abilId, level)
    if (abilId == BURST_DRAGONIC_ABIL_ID) then
        do return __jreal(30.00) end
    end
    if (abilId == BURST_LICH_ABIL_ID) then
        do return __jreal(35.00) end
    end
    do return __jreal(35.00) end
end

-- Original JASS function: BURST_GetDamage (line 11186)
function BURST_GetDamage(abilId, level)
    if (abilId == BURST_DRAGONIC_ABIL_ID) then
        do return __jreal(__jreal(100.00) + __jreal(__jreal(25.00) * I2R(__jint(level - 1)))) end
    end
    if (abilId == BURST_LICH_ABIL_ID) then
        do return __jreal(__jreal(100.00) + __jreal(__jreal(25.00) * I2R(__jint(level - 1)))) end
    end
    do return __jreal(0.00) end
end

-- Original JASS function: BURST_GetAoE (line 11200)
function BURST_GetAoE(abilId, level)
    if (abilId == BURST_DRAGONIC_ABIL_ID) then
        do return __jreal(__jreal(500.00) + __jreal(__jreal(50.00) * I2R(__jint(level - 1)))) end
    end
    if (abilId == BURST_LICH_ABIL_ID) then
        do return __jreal(800.00) end
    end
    do return __jreal(0.00) end
end

-- Original JASS function: BURST_UnitExists (line 11212)
function BURST_UnitExists(u)
    do return (GetUnitTypeId(u) ~= 0) end
end

-- Original JASS function: BURST_IsAlive (line 11216)
function BURST_IsAlive(u)
    do return ((GetUnitTypeId(u) ~= 0) and (GetWidgetLife(u) > __jreal(0.405))) end
end

-- Original JASS function: BURST_IsValidTarget (line 11220)
function BURST_IsValidTarget(caster, target)
    do return (((BURST_IsAlive(target) and IsUnitEnemy(target, GetOwningPlayer(caster))) and (not IsUnitType(target, UNIT_TYPE_STRUCTURE))) and (not IsUnitType(target, UNIT_TYPE_MAGIC_IMMUNE))) end
end

-- Original JASS function: BURST_RemoveMissile (line 11224)
function BURST_RemoveMissile(i)
    DestroyEffect(BURST_MISSILE[i])
    BURST_CASTER[i] = BURST_CASTER[BURST_COUNT]
    BURST_TARGET[i] = BURST_TARGET[BURST_COUNT]
    BURST_MISSILE[i] = BURST_MISSILE[BURST_COUNT]
    BURST_X[i] = BURST_X[BURST_COUNT]
    BURST_Y[i] = BURST_Y[BURST_COUNT]
    BURST_DAMAGE[i] = BURST_DAMAGE[BURST_COUNT]
    BURST_SPEED[i] = BURST_SPEED[BURST_COUNT]
    BURST_HEIGHT[i] = BURST_HEIGHT[BURST_COUNT]
    BURST_CASTER[BURST_COUNT] = nil
    BURST_TARGET[BURST_COUNT] = nil
    BURST_MISSILE[BURST_COUNT] = nil
    BURST_X[BURST_COUNT] = __jreal(0.00)
    BURST_Y[BURST_COUNT] = __jreal(0.00)
    BURST_DAMAGE[BURST_COUNT] = __jreal(0.00)
    BURST_SPEED[BURST_COUNT] = __jreal(0.00)
    BURST_HEIGHT[BURST_COUNT] = __jreal(0.00)
    BURST_COUNT = __jint(BURST_COUNT - 1)
end

-- Original JASS function: BURST_Periodic (line 11248)
function BURST_Periodic()
    local i = 1
    local tx = 0.0
    local ty = 0.0
    local dx = 0.0
    local dy = 0.0
    local dist = 0.0
    local angle = 0.0
    local step = 0.0
    while true do
        if (i > BURST_COUNT) then break end
        if ((not ((GetUnitTypeId((BURST_CASTER[i])) ~= 0))) or (not BURST_IsAlive(BURST_TARGET[i]))) then
            BURST_RemoveMissile(i)
        else
            tx = GetUnitX(BURST_TARGET[i])
            ty = GetUnitY(BURST_TARGET[i])
            dx = __jreal(tx - BURST_X[i])
            dy = __jreal(ty - BURST_Y[i])
            dist = SquareRoot(__jreal(__jreal(dx * dx) + __jreal(dy * dy)))
            step = __jreal(BURST_SPEED[i] * BURST_PERIOD)
            if (dist <= step) then
                if BURST_IsValidTarget(BURST_CASTER[i], BURST_TARGET[i]) then
                    UnitDamageTarget(BURST_CASTER[i], BURST_TARGET[i], BURST_DAMAGE[i], false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
                end
                BURST_RemoveMissile(i)
            else
                angle = Atan2(dy, dx)
                BURST_X[i] = __jreal(BURST_X[i] + __jreal(Cos(angle) * step))
                BURST_Y[i] = __jreal(BURST_Y[i] + __jreal(Sin(angle) * step))
                BlzSetSpecialEffectPosition(BURST_MISSILE[i], BURST_X[i], BURST_Y[i], BURST_HEIGHT[i])
                BlzSetSpecialEffectYaw(BURST_MISSILE[i], angle)
                i = __jint(i + 1)
            end
        end
    end
    if (BURST_COUNT == 0) then
        PauseTimer(BURST_TIMER)
    end
end

-- Original JASS function: BURST_StartMissile (line 11297)
function BURST_StartMissile(caster, target, abilId, level)
    local x = GetUnitX(caster)
    local y = GetUnitY(caster)
    local angle = Atan2(__jreal(GetUnitY(target) - y), __jreal(GetUnitX(target) - x))
    local height = BURST_GetMissileHeight(abilId, level)
    local e = AddSpecialEffect(BURST_GetMissileModel(abilId), x, y)
    BlzSetSpecialEffectScale(e, BURST_GetMissileScale(abilId, level))
    BlzSetSpecialEffectPosition(e, x, y, height)
    BlzSetSpecialEffectYaw(e, angle)
    BURST_COUNT = __jint(BURST_COUNT + 1)
    BURST_CASTER[BURST_COUNT] = caster
    BURST_TARGET[BURST_COUNT] = target
    BURST_MISSILE[BURST_COUNT] = e
    BURST_X[BURST_COUNT] = x
    BURST_Y[BURST_COUNT] = y
    BURST_DAMAGE[BURST_COUNT] = BURST_GetDamage(abilId, level)
    BURST_SPEED[BURST_COUNT] = BURST_GetMissileSpeed(abilId, level)
    BURST_HEIGHT[BURST_COUNT] = height
    if (BURST_COUNT == 1) then
        TimerStart(BURST_TIMER, BURST_PERIOD, true, BURST_Periodic)
    end
    e = nil
end

-- Original JASS function: BURST_OnCast (line 11326)
function BURST_OnCast()
    local caster = GetTriggerUnit()
    local abilId = GetSpellAbilityId()
    local level = 0
    local x = 0.0
    local y = 0.0
    local aoe = 0.0
    local target = nil
    if (not BURST_IsSupportedAbility(abilId)) then
        caster = nil
        do return end
    end
    level = GetUnitAbilityLevel(caster, abilId)
    x = GetUnitX(caster)
    y = GetUnitY(caster)
    aoe = BURST_GetAoE(abilId, level)
    GroupEnumUnitsInRange(BURST_ENUM_GROUP, x, y, aoe, nil)
    while true do
        target = FirstOfGroup(BURST_ENUM_GROUP)
        if (target == nil) then break end
        GroupRemoveUnit(BURST_ENUM_GROUP, target)
        if BURST_IsValidTarget(caster, target) then
            BURST_StartMissile(caster, target, abilId, level)
        end
    end
    caster = nil
    target = nil
end

-- Original JASS function: BURST_Conditions (line 11362)
function BURST_Conditions()
    do return BURST_IsSupportedAbility(GetSpellAbilityId()) end
end

-- Original JASS function: InitTrig_FanOfKnivesBasedSpells (line 11366)
function InitTrig_FanOfKnivesBasedSpells()
    local t = CreateTrigger()
    local i = 0
    while true do
        if (i >= bj_MAX_PLAYER_SLOTS) then break end
        TriggerRegisterPlayerUnitEvent(t, Player(i), EVENT_PLAYER_UNIT_SPELL_EFFECT, nil)
        i = __jint(i + 1)
    end
    TriggerAddCondition(t, Condition(BURST_Conditions))
    TriggerAddAction(t, BURST_OnCast)
    t = nil
end
-- END FOREST SECTION 155
-- END FOREST MODULE src/combat/spells.lua

-- BEGIN FOREST MODULE src/ancients/paranoia.lua
-- ancients / paranoia
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 156 Realm_of_darkness
-- Original JASS function: Trig_Realm_of_darkness_Conditions (line 11384)
function Trig_Realm_of_darkness_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A0B7"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Realm_of_darkness_Func002001002 (line 11391)
function Trig_Realm_of_darkness_Func002001002()
    do return ((IsUnitEnemy(GetFilterUnit(), FE_Roles.ancient()) == true)) end
end

-- Original JASS function: Trig_Realm_of_darkness_Func002A (line 11395)
function Trig_Realm_of_darkness_Func002A()
    UnitAddAbilityBJ(FourCC("A0B6"), GetEnumUnit())
end

-- Original JASS function: Trig_Realm_of_darkness_Func005001002 (line 11399)
function Trig_Realm_of_darkness_Func005001002()
    do return ((IsUnitEnemy(GetFilterUnit(), FE_Roles.ancient()) == true)) end
end

-- Original JASS function: Trig_Realm_of_darkness_Func005A (line 11403)
function Trig_Realm_of_darkness_Func005A()
    UnitRemoveAbilityBJ(FourCC("A0B6"), GetEnumUnit())
end

-- Original JASS function: Trig_Realm_of_darkness_Actions (line 11407)
function Trig_Realm_of_darkness_Actions()
    EnableTrigger(gg_trg_Realm_of_darkness_2)
    local group002 = GetUnitsInRectMatching(GetPlayableMapRect(), Condition(Trig_Realm_of_darkness_Func002001002))
    ForGroupBJ(group002, Trig_Realm_of_darkness_Func002A)
    DestroyGroup(group002)
    TriggerSleepAction(__jreal(60.00))
    DisableTrigger(gg_trg_Realm_of_darkness_2)
    local group005 = GetUnitsInRectMatching(GetPlayableMapRect(), Condition(Trig_Realm_of_darkness_Func005001002))
    ForGroupBJ(group005, Trig_Realm_of_darkness_Func005A)
    DestroyGroup(group005)
end

-- Original JASS function: InitTrig_Realm_of_darkness (line 11416)
function InitTrig_Realm_of_darkness()
    gg_trg_Realm_of_darkness = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Realm_of_darkness, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Realm_of_darkness, Condition(Trig_Realm_of_darkness_Conditions))
    TriggerAddAction(gg_trg_Realm_of_darkness, Trig_Realm_of_darkness_Actions)
end
-- END FOREST SECTION 156

-- BEGIN FOREST SECTION 157 Realm_of_darkness_2
-- Original JASS function: Trig_Realm_of_darkness_2_Conditions (line 11426)
function Trig_Realm_of_darkness_2_Conditions()
    if ((not ((IsUnitEnemy(GetTriggerUnit(), FE_Roles.ancient()) == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Realm_of_darkness_2_Actions (line 11433)
function Trig_Realm_of_darkness_2_Actions()
    UnitAddAbilityBJ(FourCC("A0B6"), GetTriggerUnit())
end

-- Original JASS function: InitTrig_Realm_of_darkness_2 (line 11438)
function InitTrig_Realm_of_darkness_2()
    gg_trg_Realm_of_darkness_2 = CreateTrigger()
    DisableTrigger(gg_trg_Realm_of_darkness_2)
    TriggerRegisterEnterRectSimple(gg_trg_Realm_of_darkness_2, GetPlayableMapRect())
    TriggerRegisterAnyUnitEventBJ(gg_trg_Realm_of_darkness_2, EVENT_PLAYER_UNIT_CONSTRUCT_START)
    TriggerAddCondition(gg_trg_Realm_of_darkness_2, Condition(Trig_Realm_of_darkness_2_Conditions))
    TriggerAddAction(gg_trg_Realm_of_darkness_2, Trig_Realm_of_darkness_2_Actions)
end
-- END FOREST SECTION 157
-- END FOREST MODULE src/ancients/paranoia.lua

-- BEGIN FOREST MODULE src/ancients/zalxon.lua
-- ancients / zalxon
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 158 Thunderstruck
-- Original JASS function: Trig_Thunderstruck_Conditions (line 11450)
function Trig_Thunderstruck_Conditions()
    if ((not ((GetUnitTypeId(udg_DamageEventTarget) == FourCC("O016"))))) then
        do return false end
    end
    if ((not ((udg_IsDamageAttack == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Thunderstruck_Func003C (line 11460)
function Trig_Thunderstruck_Func003C()
    if ((not ((GetRandomReal(__jreal(0.00), __jreal(100.00)) <= (__jreal((__jreal(__jreal(0.75) * I2R(GetUnitLevel(udg_DamageEventTarget)))) + __jreal(0.00))))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Thunderstruck_Actions (line 11467)
function Trig_Thunderstruck_Actions()
    udg_ThunderstruckLevel = GetUnitAbilityLevelSwapped(FourCC("A03S"), udg_DamageEventTarget)
    udg_ThunderstruckTarget = GetUnitLoc(udg_DamageEventSource)
    if (Trig_Thunderstruck_Func003C()) then
        CreateNUnitsAtLoc(1, FourCC("h04L"), GetOwningPlayer(BlzGetEventDamageTarget()), udg_ThunderstruckTarget, bj_UNIT_FACING)
        UnitAddAbilityBJ(FourCC("A03S"), GetLastCreatedUnit())
        SetUnitAbilityLevelSwapped(FourCC("A03S"), GetLastCreatedUnit(), udg_ThunderstruckLevel)
        UnitApplyTimedLifeBJ(__jreal(2.00), FourCC("BTLF"), GetLastCreatedUnit())
        IssuePointOrderLocBJ(GetLastCreatedUnit(), "flamestrike", udg_ThunderstruckTarget)
    else
    end
end

-- Original JASS function: InitTrig_Thunderstruck (line 11481)
function InitTrig_Thunderstruck()
    gg_trg_Thunderstruck = CreateTrigger()
    h__TriggerRegisterVariableEvent(gg_trg_Thunderstruck, "udg_DamageEvent", EQUAL, __jreal(1.00))
    TriggerAddCondition(gg_trg_Thunderstruck, Condition(Trig_Thunderstruck_Conditions))
    TriggerAddAction(gg_trg_Thunderstruck, Trig_Thunderstruck_Actions)
end
-- END FOREST SECTION 158

-- BEGIN FOREST SECTION 159 Lightning_Strike
-- Original JASS function: Trig_Lightning_Strike_Conditions (line 11491)
function Trig_Lightning_Strike_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A03S"))))) then
        do return false end
    end
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("O016"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Lightning_Strike_Actions (line 11501)
function Trig_Lightning_Strike_Actions()
    local timer = CreateTimer()
    TimerStart(timer, 25, false, nil)
    local dialog = CreateTimerDialog(timer)
    TimerDialogSetTitle(dialog, "TRIGSTR_7242")
    TimerDialogDisplay(dialog, true)
    TriggerSleepAction(__jreal(25))
    DestroyTimerDialog(dialog)
    DestroyTimer(timer)
end

-- Original JASS function: InitTrig_Lightning_Strike (line 11509)
function InitTrig_Lightning_Strike()
    gg_trg_Lightning_Strike = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Lightning_Strike, EVENT_PLAYER_UNIT_SPELL_FINISH)
    TriggerAddCondition(gg_trg_Lightning_Strike, Condition(Trig_Lightning_Strike_Conditions))
    TriggerAddAction(gg_trg_Lightning_Strike, Trig_Lightning_Strike_Actions)
end
-- END FOREST SECTION 159
-- END FOREST MODULE src/ancients/zalxon.lua

-- BEGIN FOREST MODULE src/ancients/nebula.lua
-- ancients / nebula
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 160 RecallStart
-- Original JASS function: Trig_RecallStart_Conditions (line 11519)
function Trig_RecallStart_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A0AL"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_RecallStart_Actions (line 11526)
function Trig_RecallStart_Actions()
    udg_RecallTarget = GetSpellTargetUnit()
end

-- Original JASS function: InitTrig_RecallStart (line 11531)
function InitTrig_RecallStart()
    gg_trg_RecallStart = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_RecallStart, EVENT_PLAYER_UNIT_SPELL_CAST)
    TriggerAddCondition(gg_trg_RecallStart, Condition(Trig_RecallStart_Conditions))
    TriggerAddAction(gg_trg_RecallStart, Trig_RecallStart_Actions)
end
-- END FOREST SECTION 160

-- BEGIN FOREST SECTION 161 Recall
-- Original JASS function: Trig_Recall_Conditions (line 11541)
function Trig_Recall_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A0AL"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Recall_Actions (line 11548)
function Trig_Recall_Actions()
    SetUnitPositionLoc(udg_RecallTarget, GetRectCenter(gg_rct_Fountain))
end

-- Original JASS function: InitTrig_Recall (line 11553)
function InitTrig_Recall()
    gg_trg_Recall = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Recall, EVENT_PLAYER_UNIT_SPELL_FINISH)
    TriggerAddCondition(gg_trg_Recall, Condition(Trig_Recall_Conditions))
    TriggerAddAction(gg_trg_Recall, Trig_Recall_Actions)
end
-- END FOREST SECTION 161

-- BEGIN FOREST SECTION 162 Time_warp
-- Original JASS function: Trig_Time_warp_Conditions (line 11563)
function Trig_Time_warp_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A08S"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Time_warp_Func004Func001001 (line 11570)
function Trig_Time_warp_Func004Func001001()
    do return ((IsUnitEnemy(GetEnumUnit(), GetOwningPlayer(GetSpellAbilityUnit())) == true)) end
end

-- Original JASS function: Trig_Time_warp_Func004A (line 11574)
function Trig_Time_warp_Func004A()
    if (((IsUnitEnemy(GetEnumUnit(), GetOwningPlayer(GetSpellAbilityUnit())) == true))) then
        UnitDamageTargetBJ(GetSpellAbilityUnit(), GetEnumUnit(), __jreal(300.00), ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL)
    else
        DoNothing()
    end
end

-- Original JASS function: Trig_Time_warp_Actions (line 11582)
function Trig_Time_warp_Actions()
    udg_TimeWarpCaster = GetSpellAbilityUnit()
    udg_TimeWarp = GetSpellTargetLoc()
    UnitDamagePointLoc(udg_AncientUnit, __jreal(0), __jreal(500), GetUnitLoc(udg_TimeWarpCaster), __jreal(300.00), ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL)
    ForGroupBJ(GetUnitsInRangeOfLocAll(__jreal(512), OffsetLocation(udg_TimeWarp, __jreal(0), __jreal(0))), Trig_Time_warp_Func004A)
end

-- Original JASS function: InitTrig_Time_warp (line 11590)
function InitTrig_Time_warp()
    gg_trg_Time_warp = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Time_warp, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Time_warp, Condition(Trig_Time_warp_Conditions))
    TriggerAddAction(gg_trg_Time_warp, Trig_Time_warp_Actions)
end
-- END FOREST SECTION 162

-- BEGIN FOREST SECTION 163 Galactic_Fury
-- Original JASS function: Trig_Galactic_Fury_Conditions (line 11600)
function Trig_Galactic_Fury_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A0F1"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Galactic_Fury_Actions (line 11607)
function Trig_Galactic_Fury_Actions()
    udg_GalacticFuryCaster = GetSpellAbilityUnit()
end

-- Original JASS function: InitTrig_Galactic_Fury (line 11612)
function InitTrig_Galactic_Fury()
    gg_trg_Galactic_Fury = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Galactic_Fury, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Galactic_Fury, Condition(Trig_Galactic_Fury_Conditions))
    TriggerAddAction(gg_trg_Galactic_Fury, Trig_Galactic_Fury_Actions)
end
-- END FOREST SECTION 163

-- BEGIN FOREST SECTION 164 Galactic_Fury_2
-- Original JASS function: Trig_Galactic_Fury_2_Conditions (line 11622)
function Trig_Galactic_Fury_2_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A0F1"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Galactic_Fury_2_Actions (line 11629)
function Trig_Galactic_Fury_2_Actions()
    SetUnitLifePercentBJ(udg_GalacticFuryCaster, (__jreal(GetUnitLifePercent(udg_GalacticFuryCaster) + __jreal(25.00))))
end

-- Original JASS function: InitTrig_Galactic_Fury_2 (line 11634)
function InitTrig_Galactic_Fury_2()
    gg_trg_Galactic_Fury_2 = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Galactic_Fury_2, EVENT_PLAYER_UNIT_SPELL_FINISH)
    TriggerAddCondition(gg_trg_Galactic_Fury_2, Condition(Trig_Galactic_Fury_2_Conditions))
    TriggerAddAction(gg_trg_Galactic_Fury_2, Trig_Galactic_Fury_2_Actions)
end
-- END FOREST SECTION 164

-- BEGIN FOREST SECTION 165 Galactic_Fury_3
-- Original JASS function: SSZ_IsValidTarget (line 11645)
function SSZ_IsValidTarget(caster, target)
    do return (((((target ~= nil) and (target ~= caster)) and (GetWidgetLife(target) > __jreal(0.405))) and IsUnitEnemy(target, GetOwningPlayer(caster))) and (not IsUnitType(target, UNIT_TYPE_DEAD))) end
end

-- Original JASS function: SSZ_RemoveSlow (line 11649)
function SSZ_RemoveSlow()
    local t = GetExpiredTimer()
    local tid = GetHandleId(t)
    local target = LoadUnitHandle(SSZ_HASH, tid, 0)
    local uid = 0
    if (target ~= nil) then
        uid = GetHandleId(target)
        UnitRemoveAbility(target, SSZ_SLOW_ID)
        FlushChildHashtable(SSZ_HASH, uid)
    end
    FlushChildHashtable(SSZ_HASH, tid)
    PauseTimer(t)
    DestroyTimer(t)
    target = nil
    t = nil
end

-- Original JASS function: SSZ_ApplySlow (line 11669)
function SSZ_ApplySlow(target)
    local uid = GetHandleId(target)
    local t = LoadTimerHandle(SSZ_HASH, uid, 0)
    if (GetUnitAbilityLevel(target, SSZ_SLOW_ID) == 0) then
        UnitAddAbility(target, SSZ_SLOW_ID)
    end
    if (t == nil) then
        t = CreateTimer()
        SaveTimerHandle(SSZ_HASH, uid, 0, t)
        SaveUnitHandle(SSZ_HASH, GetHandleId(t), 0, target)
    end
    TimerStart(t, SSZ_SLOW_DURATION, false, SSZ_RemoveSlow)
    t = nil
end

-- Original JASS function: SSZ_OnCast (line 11688)
function SSZ_OnCast()
    local caster = GetTriggerUnit()
    local g = CreateGroup()
    local target = nil
    local x = GetUnitX(caster)
    local y = GetUnitY(caster)
    GroupEnumUnitsInRange(g, x, y, SSZ_AOE, nil)
    while true do
        target = FirstOfGroup(g)
        if (target == nil) then break end
        GroupRemoveUnit(g, target)
        if SSZ_IsValidTarget(caster, target) then
            if (not IsUnitType(target, UNIT_TYPE_STRUCTURE)) then
                UnitDamageTarget(caster, target, SSZ_DAMAGE, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
            end
            if (GetWidgetLife(target) > __jreal(0.405)) then
                SSZ_ApplySlow(target)
            end
        end
    end
    DestroyGroup(g)
    target = nil
    g = nil
    caster = nil
end

-- Original JASS function: SSZ_Condition (line 11720)
function SSZ_Condition()
    do return (GetSpellAbilityId() == SSZ_SPELL_ID) end
end

-- Original JASS function: InitTrig_Galactic_Fury_3 (line 11724)
function InitTrig_Galactic_Fury_3()
    local t = CreateTrigger()
    local i = 0
    if (SSZ_HASH == nil) then
        SSZ_HASH = InitHashtable()
    end
    while true do
        if (i >= bj_MAX_PLAYER_SLOTS) then break end
        TriggerRegisterPlayerUnitEvent(t, Player(i), EVENT_PLAYER_UNIT_SPELL_EFFECT, nil)
        i = __jint(i + 1)
    end
    TriggerAddCondition(t, Condition(SSZ_Condition))
    TriggerAddAction(t, SSZ_OnCast)
    t = nil
end
-- END FOREST SECTION 165

-- BEGIN FOREST SECTION 166 Cosmic_Strike
-- Original JASS function: Trig_Cosmic_Strike_Conditions (line 11746)
function Trig_Cosmic_Strike_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A08R"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Cosmic_Strike_Actions (line 11753)
function Trig_Cosmic_Strike_Actions()
    udg_CosmicStrikeCaster = GetSpellAbilityUnit()
    udg_CosmicStrikeCount = 1
end

-- Original JASS function: InitTrig_Cosmic_Strike (line 11759)
function InitTrig_Cosmic_Strike()
    gg_trg_Cosmic_Strike = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Cosmic_Strike, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Cosmic_Strike, Condition(Trig_Cosmic_Strike_Conditions))
    TriggerAddAction(gg_trg_Cosmic_Strike, Trig_Cosmic_Strike_Actions)
end
-- END FOREST SECTION 166

-- BEGIN FOREST SECTION 167 Cosmic_Strike_2
-- Original JASS function: Trig_Cosmic_Strike_2_Conditions (line 11769)
function Trig_Cosmic_Strike_2_Conditions()
    if ((not ((udg_DamageEventSource == udg_CosmicStrikeCaster)))) then
        do return false end
    end
    if ((not ((udg_IsDamageAttack == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Cosmic_Strike_2_Func005001 (line 11779)
function Trig_Cosmic_Strike_2_Func005001()
    do return ((udg_CosmicStrikeCount == 0)) end
end

-- Original JASS function: Trig_Cosmic_Strike_2_Actions (line 11783)
function Trig_Cosmic_Strike_2_Actions()
    SetUnitManaPercentBJ(udg_CosmicStrikeCaster, (__jreal(GetUnitManaPercent(GetEventDamageSource()) + __jreal(5.00))))
    udg_CosmicStrikeCount = (__jint(udg_CosmicStrikeCount - 1))
    if (((udg_CosmicStrikeCount == 0))) then
        UnitRemoveBuffBJ(FourCC("B038"), udg_CosmicStrikeCaster)
    else
        DoNothing()
    end
    udg_CosmicStrikeCaster = nil
end

-- Original JASS function: InitTrig_Cosmic_Strike_2 (line 11795)
function InitTrig_Cosmic_Strike_2()
    gg_trg_Cosmic_Strike_2 = CreateTrigger()
    h__TriggerRegisterVariableEvent(gg_trg_Cosmic_Strike_2, "udg_DamageEvent", EQUAL, __jreal(1.00))
    TriggerAddCondition(gg_trg_Cosmic_Strike_2, Condition(Trig_Cosmic_Strike_2_Conditions))
    TriggerAddAction(gg_trg_Cosmic_Strike_2, Trig_Cosmic_Strike_2_Actions)
end
-- END FOREST SECTION 167

-- BEGIN FOREST SECTION 168 Cosmic_Strike_3
-- Original JASS function: Trig_Cosmic_Strike_3_Conditions (line 11805)
function Trig_Cosmic_Strike_3_Conditions()
    if ((not ((UnitHasBuffBJ(udg_DamageEventSource, FourCC("B038")) == true)))) then
        do return false end
    end
    if ((not ((udg_IsDamageAttack == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Cosmic_Strike_3_Actions (line 11815)
function Trig_Cosmic_Strike_3_Actions()
    udg_DamageEventAttackT = udg_ATTACK_TYPE_CHAOS
end

-- Original JASS function: InitTrig_Cosmic_Strike_3 (line 11820)
function InitTrig_Cosmic_Strike_3()
    gg_trg_Cosmic_Strike_3 = CreateTrigger()
    h__TriggerRegisterVariableEvent(gg_trg_Cosmic_Strike_3, "udg_PreDamageEvent", LESS_THAN, __jreal(1.00))
    TriggerAddCondition(gg_trg_Cosmic_Strike_3, Condition(Trig_Cosmic_Strike_3_Conditions))
    TriggerAddAction(gg_trg_Cosmic_Strike_3, Trig_Cosmic_Strike_3_Actions)
end
-- END FOREST SECTION 168
-- END FOREST MODULE src/ancients/nebula.lua

-- BEGIN FOREST MODULE src/ancients/tremor.lua
-- ancients / tremor
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 169 Resillience
-- Original JASS function: Trig_Resillience_Conditions (line 11830)
function Trig_Resillience_Conditions()
    if ((not ((GetLearnedSkillBJ() == FourCC("A088"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Resillience_Actions (line 11837)
function Trig_Resillience_Actions()
    udg_Resillence = __jreal(0.50)
    udg_ResillienceLvler = GetLearningUnit()
    EnableTrigger(gg_trg_Resillience_3)
    DisableTrigger(GetTriggeringTrigger())
end

-- Original JASS function: InitTrig_Resillience (line 11845)
function InitTrig_Resillience()
    gg_trg_Resillience = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Resillience, EVENT_PLAYER_HERO_SKILL)
    TriggerAddCondition(gg_trg_Resillience, Condition(Trig_Resillience_Conditions))
    TriggerAddAction(gg_trg_Resillience, Trig_Resillience_Actions)
end
-- END FOREST SECTION 169

-- BEGIN FOREST SECTION 170 Resillience_2
-- Original JASS function: Trig_Resillience_2_Actions (line 11855)
function Trig_Resillience_2_Actions()
    SetUnitManaPercentBJ(udg_ResillienceLvler, (__jreal(GetUnitManaPercent(udg_ResillienceLvler) + udg_Resillence)))
end

-- Original JASS function: InitTrig_Resillience_2 (line 11860)
function InitTrig_Resillience_2()
    gg_trg_Resillience_2 = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(gg_trg_Resillience_2, __jreal(1.00))
    TriggerAddAction(gg_trg_Resillience_2, Trig_Resillience_2_Actions)
end
-- END FOREST SECTION 170

-- BEGIN FOREST SECTION 171 Resillience_3
-- Original JASS function: Trig_Resillience_3_Conditions (line 11869)
function Trig_Resillience_3_Conditions()
    if ((not ((GetLearnedSkillBJ() == FourCC("A088"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Resillience_3_Actions (line 11876)
function Trig_Resillience_3_Actions()
    udg_Resillence = (__jreal(udg_Resillence + __jreal(0.50)))
end

-- Original JASS function: InitTrig_Resillience_3 (line 11881)
function InitTrig_Resillience_3()
    gg_trg_Resillience_3 = CreateTrigger()
    DisableTrigger(gg_trg_Resillience_3)
    TriggerRegisterAnyUnitEventBJ(gg_trg_Resillience_3, EVENT_PLAYER_HERO_SKILL)
    TriggerAddCondition(gg_trg_Resillience_3, Condition(Trig_Resillience_3_Conditions))
    TriggerAddAction(gg_trg_Resillience_3, Trig_Resillience_3_Actions)
end
-- END FOREST SECTION 171
-- END FOREST MODULE src/ancients/tremor.lua

-- BEGIN FOREST MODULE src/ancients/pharaoh.lua
-- ancients / pharaoh
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 172 Sandstorm
-- Original JASS function: Trig_Sandstorm_Conditions (line 11892)
function Trig_Sandstorm_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A07Y"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Sandstorm_Actions (line 11899)
function Trig_Sandstorm_Actions()
    SetUnitLifePercentBJ(GetSpellAbilityUnit(), (__jreal(GetUnitLifePercent(GetSpellAbilityUnit()) - __jreal(5.00))))
end

-- Original JASS function: InitTrig_Sandstorm (line 11904)
function InitTrig_Sandstorm()
    gg_trg_Sandstorm = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Sandstorm, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Sandstorm, Condition(Trig_Sandstorm_Conditions))
    TriggerAddAction(gg_trg_Sandstorm, Trig_Sandstorm_Actions)
end
-- END FOREST SECTION 172

-- BEGIN FOREST SECTION 173 Sandstorm_2
-- Original JASS function: Trig_Sandstorm_2_Conditions (line 11914)
function Trig_Sandstorm_2_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A07Y"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Sandstorm_2_Actions (line 11921)
function Trig_Sandstorm_2_Actions()
    local timer = CreateTimer()
    TimerStart(timer, 45, false, nil)
    local dialog = CreateTimerDialog(timer)
    TimerDialogSetTitle(dialog, "TRIGSTR_8327")
    TimerDialogDisplay(dialog, true)
    TriggerSleepAction(__jreal(45))
    DestroyTimerDialog(dialog)
    DestroyTimer(timer)
end

-- Original JASS function: InitTrig_Sandstorm_2 (line 11929)
function InitTrig_Sandstorm_2()
    gg_trg_Sandstorm_2 = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Sandstorm_2, EVENT_PLAYER_UNIT_SPELL_FINISH)
    TriggerAddCondition(gg_trg_Sandstorm_2, Condition(Trig_Sandstorm_2_Conditions))
    TriggerAddAction(gg_trg_Sandstorm_2, Trig_Sandstorm_2_Actions)
end
-- END FOREST SECTION 173

-- BEGIN FOREST SECTION 174 Ancient_Grasp
-- Original JASS function: Trig_Ancient_Grasp_Conditions (line 11939)
function Trig_Ancient_Grasp_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A07Z"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Ancient_Grasp_Actions (line 11946)
function Trig_Ancient_Grasp_Actions()
    local caster = GetSpellAbilityUnit()
    SetUnitLifePercentBJ(caster, (__jreal(GetUnitLifePercent(caster) - __jreal(10.00))))
    TriggerSleepAction(__jreal(1.00))
    SetUnitLifePercentBJ(caster, (__jreal(GetUnitLifePercent(caster) + __jreal(2.00))))
    TriggerSleepAction(__jreal(1.00))
    SetUnitLifePercentBJ(caster, (__jreal(GetUnitLifePercent(caster) + __jreal(2.00))))
    TriggerSleepAction(__jreal(1.00))
    SetUnitLifePercentBJ(caster, (__jreal(GetUnitLifePercent(caster) + __jreal(2.00))))
    TriggerSleepAction(__jreal(1.00))
    SetUnitLifePercentBJ(caster, (__jreal(GetUnitLifePercent(caster) + __jreal(2.00))))
    TriggerSleepAction(__jreal(1.00))
    SetUnitLifePercentBJ(caster, (__jreal(GetUnitLifePercent(caster) + __jreal(2.00))))
    TriggerSleepAction(__jreal(1.00))
    SetUnitLifePercentBJ(caster, (__jreal(GetUnitLifePercent(caster) + __jreal(2.00))))
    TriggerSleepAction(__jreal(1.00))
    SetUnitLifePercentBJ(caster, (__jreal(GetUnitLifePercent(caster) + __jreal(2.00))))
    TriggerSleepAction(__jreal(1.00))
    SetUnitLifePercentBJ(caster, (__jreal(GetUnitLifePercent(caster) + __jreal(2.00))))
    TriggerSleepAction(__jreal(1.00))
    SetUnitLifePercentBJ(caster, (__jreal(GetUnitLifePercent(caster) + __jreal(2.00))))
    TriggerSleepAction(__jreal(1.00))
    SetUnitLifePercentBJ(caster, (__jreal(GetUnitLifePercent(caster) + __jreal(2.00))))
end

-- Original JASS function: InitTrig_Ancient_Grasp (line 11971)
function InitTrig_Ancient_Grasp()
    gg_trg_Ancient_Grasp = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Ancient_Grasp, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Ancient_Grasp, Condition(Trig_Ancient_Grasp_Conditions))
    TriggerAddAction(gg_trg_Ancient_Grasp, Trig_Ancient_Grasp_Actions)
end
-- END FOREST SECTION 174

-- BEGIN FOREST SECTION 175 Deserts_Veil
-- Original JASS function: Trig_Deserts_Veil_Conditions (line 11981)
function Trig_Deserts_Veil_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A080"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Deserts_Veil_Actions (line 11988)
function Trig_Deserts_Veil_Actions()
    SetUnitLifePercentBJ(GetSpellAbilityUnit(), (__jreal(GetUnitLifePercent(GetSpellAbilityUnit()) + __jreal(30.00))))
end

-- Original JASS function: InitTrig_Deserts_Veil (line 11993)
function InitTrig_Deserts_Veil()
    gg_trg_Deserts_Veil = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Deserts_Veil, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Deserts_Veil, Condition(Trig_Deserts_Veil_Conditions))
    TriggerAddAction(gg_trg_Deserts_Veil, Trig_Deserts_Veil_Actions)
end
-- END FOREST SECTION 175
-- END FOREST MODULE src/ancients/pharaoh.lua

-- BEGIN FOREST MODULE src/ancients/avalanche.lua
-- ancients / avalanche
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 176 Chill
-- Original JASS function: Trig_Chill_Conditions (line 12003)
function Trig_Chill_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A00A"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Chill_Actions (line 12010)
function Trig_Chill_Actions()
    local caster = GetSpellAbilityUnit()
    TriggerSleepAction(__jreal(0.80))
    SetUnitLifeBJ(caster, (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, caster) + (__jreal(__jreal(0.50) * GetUnitStateSwap(UNIT_STATE_MAX_MANA, caster))))))
end

-- Original JASS function: InitTrig_Chill (line 12016)
function InitTrig_Chill()
    gg_trg_Chill = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Chill, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Chill, Condition(Trig_Chill_Conditions))
    TriggerAddAction(gg_trg_Chill, Trig_Chill_Actions)
end
-- END FOREST SECTION 176

-- BEGIN FOREST SECTION 177 Freeze_Zone
-- Original JASS function: Trig_Freeze_Zone_Conditions (line 12026)
function Trig_Freeze_Zone_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A0EX"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Freeze_Zone_Actions (line 12033)
function Trig_Freeze_Zone_Actions()
    local timer = CreateTimer()
    TimerStart(timer, 60, false, nil)
    local dialog = CreateTimerDialog(timer)
    TimerDialogSetTitle(dialog, "TRIGSTR_7241")
    TimerDialogDisplay(dialog, true)
    TriggerSleepAction(__jreal(60))
    DestroyTimerDialog(dialog)
    DestroyTimer(timer)
end

-- Original JASS function: InitTrig_Freeze_Zone (line 12041)
function InitTrig_Freeze_Zone()
    gg_trg_Freeze_Zone = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Freeze_Zone, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Freeze_Zone, Condition(Trig_Freeze_Zone_Conditions))
    TriggerAddAction(gg_trg_Freeze_Zone, Trig_Freeze_Zone_Actions)
end
-- END FOREST SECTION 177

-- BEGIN FOREST SECTION 178 Freeze_Zone_V2
-- Original JASS function: TP_IsValidTarget (line 12054)
function TP_IsValidTarget(caster, target)
    do return (((((((target ~= nil) and (target ~= caster)) and (GetWidgetLife(target) > __jreal(0.405))) and IsUnitEnemy(target, GetOwningPlayer(caster))) and (not IsUnitType(target, UNIT_TYPE_DEAD))) and (not IsUnitType(target, UNIT_TYPE_STRUCTURE))) and (not IsUnitType(target, UNIT_TYPE_MAGIC_IMMUNE))) end
end

-- Original JASS function: TP_DummyCastDelayed (line 12058)
function TP_DummyCastDelayed()
    local t = GetExpiredTimer()
    local tid = GetHandleId(t)
    local dummy = LoadUnitHandle(TP_HASH, tid, 0)
    local target = LoadUnitHandle(TP_HASH, tid, 1)
    if (((dummy ~= nil) and (target ~= nil)) and (GetWidgetLife(target) > __jreal(0.405))) then
        IssueTargetOrder(dummy, TP_DEBUFF_ORDER, target)
        UnitApplyTimedLife(dummy, FourCC("BTLF"), TP_DUMMY_LIFETIME)
    elseif (dummy ~= nil) then
        UnitApplyTimedLife(dummy, FourCC("BTLF"), TP_DUMMY_LIFETIME)
    end
    FlushChildHashtable(TP_HASH, tid)
    DestroyTimer(t)
    target = nil
    dummy = nil
    t = nil
end

-- Original JASS function: TP_CastDebuff (line 12079)
function TP_CastDebuff(target, level)
    local t = CreateTimer()
    local tid = GetHandleId(t)
    local dummy = CreateUnit(TP_DUMMY_OWNER, TP_DUMMY_ID, __jreal(GetUnitX(target) + __jreal(150.00)), GetUnitY(target), __jreal(0.00))
    if (dummy == nil) then
        DestroyTimer(t)
        dummy = nil
        t = nil
        do return end
    end
    UnitAddAbility(dummy, TP_DEBUFF_ID)
    SetUnitAbilityLevel(dummy, TP_DEBUFF_ID, level)
    SetUnitState(dummy, UNIT_STATE_MANA, __jreal(9999.00))
    SaveUnitHandle(TP_HASH, tid, 0, dummy)
    SaveUnitHandle(TP_HASH, tid, 1, target)
    TimerStart(t, TP_DUMMY_CAST_DELAY, false, TP_DummyCastDelayed)
    dummy = nil
    t = nil
end

-- Original JASS function: TP_OnCast (line 12104)
function TP_OnCast()
    local caster = GetTriggerUnit()
    local g = CreateGroup()
    local target = nil
    local x = GetUnitX(caster)
    local y = GetUnitY(caster)
    local level = GetUnitAbilityLevel(caster, TP_SPELL_ID)
    local damage = __jreal(TP_DAMAGE_BASE + __jreal(TP_DAMAGE_PER_LEVEL * I2R(__jint(level - 1))))
    GroupEnumUnitsInRange(g, x, y, TP_AOE, nil)
    while true do
        target = FirstOfGroup(g)
        if (target == nil) then break end
        GroupRemoveUnit(g, target)
        if TP_IsValidTarget(caster, target) then
            UnitDamageTarget(caster, target, damage, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
            if (GetWidgetLife(target) > __jreal(0.405)) then
                TP_CastDebuff(target, level)
            end
        end
    end
    DestroyGroup(g)
    target = nil
    g = nil
    caster = nil
end

-- Original JASS function: TP_Condition (line 12136)
function TP_Condition()
    do return (GetSpellAbilityId() == TP_SPELL_ID) end
end

-- Original JASS function: InitTrig_Freeze_Zone_V2 (line 12140)
function InitTrig_Freeze_Zone_V2()
    local t = CreateTrigger()
    local i = 0
    if (TP_HASH == nil) then
        TP_HASH = InitHashtable()
    end
    while true do
        if (i >= bj_MAX_PLAYER_SLOTS) then break end
        TriggerRegisterPlayerUnitEvent(t, Player(i), EVENT_PLAYER_UNIT_SPELL_EFFECT, nil)
        i = __jint(i + 1)
    end
    TriggerAddCondition(t, Condition(TP_Condition))
    TriggerAddAction(t, TP_OnCast)
    t = nil
end
-- END FOREST SECTION 178
-- END FOREST MODULE src/ancients/avalanche.lua

-- BEGIN FOREST MODULE src/ancients/divinity.lua
-- ancients / divinity
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 179 Sadism
-- Original JASS function: Trig_Sadism_Conditions (line 12162)
function Trig_Sadism_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A075"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Sadism_Actions (line 12169)
function Trig_Sadism_Actions()
    local caster = GetSpellAbilityUnit()
    local iterations = 10
    SetUnitLifeBJ(caster, (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) * __jreal(0.60))))
    TriggerSleepAction(__jreal(1.00))
    while true do
        SetUnitLifeBJ(caster, (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, caster) + __jreal(1000.00))))
        iterations = __jint(iterations - 1)
        TriggerSleepAction(__jreal(1.00))
        if (iterations == 0) then break end
    end
end

-- Original JASS function: InitTrig_Sadism (line 12182)
function InitTrig_Sadism()
    gg_trg_Sadism = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Sadism, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Sadism, Condition(Trig_Sadism_Conditions))
    TriggerAddAction(gg_trg_Sadism, Trig_Sadism_Actions)
end
-- END FOREST SECTION 179

-- BEGIN FOREST SECTION 180 Reckoning
-- Original JASS function: Trig_Reckoning_Conditions (line 12193)
function Trig_Reckoning_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A06W"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Reckoning_Actions (line 12200)
function Trig_Reckoning_Actions()
    udg_TSEDuration = __jreal(5.00)
    udg_TSEScale = __jreal(0.45)
    udg_TSEAttachPoint = "origin"
    udg_TSEEffectName = "war3mapImported\\HolyTornado.mdx"
    udg_TSETargetUnit = GetSpellAbilityUnit()
    ConditionalTriggerExecute(udg_TSE_RegisterTrigger)
end

-- Original JASS function: InitTrig_Reckoning (line 12210)
function InitTrig_Reckoning()
    gg_trg_Reckoning = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Reckoning, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Reckoning, Condition(Trig_Reckoning_Conditions))
    TriggerAddAction(gg_trg_Reckoning, Trig_Reckoning_Actions)
end
-- END FOREST SECTION 180

-- BEGIN FOREST SECTION 181 Vanguard_Initial
-- Original JASS function: Trig_Vanguard_Initial_Conditions (line 12221)
function Trig_Vanguard_Initial_Conditions()
    if ((not ((GetLearnedSkillBJ() == FourCC("A06U"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Vanguard_Initial_Actions (line 12228)
function Trig_Vanguard_Initial_Actions()
    udg_VanguardHeal = (__jreal(udg_VanguardHeal + __jreal(100.00)))
    TriggerSleepAction(__jreal(5.00))
    EnableTrigger(gg_trg_Vanguard_Future_Levels)
    DisableTrigger(GetTriggeringTrigger())
end

-- Original JASS function: InitTrig_Vanguard_Initial (line 12236)
function InitTrig_Vanguard_Initial()
    gg_trg_Vanguard_Initial = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Vanguard_Initial, EVENT_PLAYER_HERO_SKILL)
    TriggerAddCondition(gg_trg_Vanguard_Initial, Condition(Trig_Vanguard_Initial_Conditions))
    TriggerAddAction(gg_trg_Vanguard_Initial, Trig_Vanguard_Initial_Actions)
end
-- END FOREST SECTION 181

-- BEGIN FOREST SECTION 182 Vanguard_Future_Levels
-- Original JASS function: Trig_Vanguard_Future_Levels_Conditions (line 12246)
function Trig_Vanguard_Future_Levels_Conditions()
    if ((not ((GetLearnedSkillBJ() == FourCC("A06U"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Vanguard_Future_Levels_Actions (line 12253)
function Trig_Vanguard_Future_Levels_Actions()
    udg_VanguardHeal = (__jreal(udg_VanguardHeal + __jreal(50.00)))
end

-- Original JASS function: InitTrig_Vanguard_Future_Levels (line 12258)
function InitTrig_Vanguard_Future_Levels()
    gg_trg_Vanguard_Future_Levels = CreateTrigger()
    DisableTrigger(gg_trg_Vanguard_Future_Levels)
    TriggerRegisterAnyUnitEventBJ(gg_trg_Vanguard_Future_Levels, EVENT_PLAYER_HERO_SKILL)
    TriggerAddCondition(gg_trg_Vanguard_Future_Levels, Condition(Trig_Vanguard_Future_Levels_Conditions))
    TriggerAddAction(gg_trg_Vanguard_Future_Levels, Trig_Vanguard_Future_Levels_Actions)
end
-- END FOREST SECTION 182

-- BEGIN FOREST SECTION 183 Vanguard
-- Original JASS function: Trig_Vanguard_Conditions (line 12269)
function Trig_Vanguard_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A06U"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Vanguard_Actions (line 12276)
function Trig_Vanguard_Actions()
    local heal = udg_VanguardHeal
    SetUnitLifeBJ(GetTriggerUnit(), (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) + heal)))
    TriggerSleepAction(__jreal(1.00))
    SetUnitLifeBJ(GetTriggerUnit(), (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) + heal)))
    TriggerSleepAction(__jreal(1.00))
    SetUnitLifeBJ(GetTriggerUnit(), (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) + heal)))
    TriggerSleepAction(__jreal(1.00))
    SetUnitLifeBJ(GetTriggerUnit(), (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) + heal)))
    TriggerSleepAction(__jreal(1.00))
    SetUnitLifeBJ(GetTriggerUnit(), (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) + heal)))
    TriggerSleepAction(__jreal(1.00))
    SetUnitLifeBJ(GetTriggerUnit(), (__jreal(GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) + heal)))
end

-- Original JASS function: InitTrig_Vanguard (line 12291)
function InitTrig_Vanguard()
    gg_trg_Vanguard = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Vanguard, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Vanguard, Condition(Trig_Vanguard_Conditions))
    TriggerAddAction(gg_trg_Vanguard, Trig_Vanguard_Actions)
end
-- END FOREST SECTION 183

-- BEGIN FOREST SECTION 184 Omniscience_Initial
-- Original JASS function: Trig_Omniscience_Initial_Conditions (line 12301)
function Trig_Omniscience_Initial_Conditions()
    if ((not ((GetLearnedSkillBJ() == FourCC("A06X"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Omniscience_Initial_Actions (line 12308)
function Trig_Omniscience_Initial_Actions()
    udg_Div = GetLearningUnit()
    udg_Omni = 1
    EnableTrigger(gg_trg_Omniscience)
    EnableTrigger(gg_trg_Omniscience_FL)
    DisableTrigger(GetTriggeringTrigger())
end

-- Original JASS function: InitTrig_Omniscience_Initial (line 12317)
function InitTrig_Omniscience_Initial()
    gg_trg_Omniscience_Initial = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Omniscience_Initial, EVENT_PLAYER_HERO_SKILL)
    TriggerAddCondition(gg_trg_Omniscience_Initial, Condition(Trig_Omniscience_Initial_Conditions))
    TriggerAddAction(gg_trg_Omniscience_Initial, Trig_Omniscience_Initial_Actions)
end
-- END FOREST SECTION 184

-- BEGIN FOREST SECTION 185 Omniscience_FL
-- Original JASS function: Trig_Omniscience_FL_Conditions (line 12327)
function Trig_Omniscience_FL_Conditions()
    if ((not ((GetLearnedSkillBJ() == FourCC("A06X"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Omniscience_FL_Actions (line 12334)
function Trig_Omniscience_FL_Actions()
    udg_Omni = (__jint(udg_Omni + 1))
end

-- Original JASS function: InitTrig_Omniscience_FL (line 12339)
function InitTrig_Omniscience_FL()
    gg_trg_Omniscience_FL = CreateTrigger()
    DisableTrigger(gg_trg_Omniscience_FL)
    TriggerRegisterAnyUnitEventBJ(gg_trg_Omniscience_FL, EVENT_PLAYER_HERO_SKILL)
    TriggerAddCondition(gg_trg_Omniscience_FL, Condition(Trig_Omniscience_FL_Conditions))
    TriggerAddAction(gg_trg_Omniscience_FL, Trig_Omniscience_FL_Actions)
end
-- END FOREST SECTION 185

-- BEGIN FOREST SECTION 186 Omniscience
-- Original JASS function: Trig_Omniscience_Actions (line 12350)
function Trig_Omniscience_Actions()
    AddHeroXPSwapped(udg_Omni, udg_Div, true)
end

-- Original JASS function: InitTrig_Omniscience (line 12355)
function InitTrig_Omniscience()
    gg_trg_Omniscience = CreateTrigger()
    DisableTrigger(gg_trg_Omniscience)
    TriggerRegisterTimerEventPeriodic(gg_trg_Omniscience, __jreal(1.00))
    TriggerAddAction(gg_trg_Omniscience, Trig_Omniscience_Actions)
end
-- END FOREST SECTION 186

-- BEGIN FOREST SECTION 187 Redemption
-- Original JASS function: Trig_Redemption_Conditions (line 12365)
function Trig_Redemption_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A06Y"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Redemption_Actions (line 12372)
function Trig_Redemption_Actions()
    SetUnitLifePercentBJ(GetSpellAbilityUnit(), __jreal(100))
    SetUnitManaPercentBJ(GetSpellAbilityUnit(), __jreal(100))
end

-- Original JASS function: InitTrig_Redemption (line 12378)
function InitTrig_Redemption()
    gg_trg_Redemption = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Redemption, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Redemption, Condition(Trig_Redemption_Conditions))
    TriggerAddAction(gg_trg_Redemption, Trig_Redemption_Actions)
end
-- END FOREST SECTION 187
-- END FOREST MODULE src/ancients/divinity.lua

-- BEGIN FOREST MODULE src/ancients/wispari.lua
-- ancients / wispari
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 188 Refreshing_Breeze
-- This trigger has no standalone compiled functions. Library implementations are in src/libraries/.
-- END FOREST SECTION 188

-- BEGIN FOREST SECTION 189 Gale_Winds
-- This trigger has no standalone compiled functions. Library implementations are in src/libraries/.
-- END FOREST SECTION 189

-- BEGIN FOREST SECTION 190 WindWalkWispari
-- Original JASS function: WW_Stop (line 12395)
function WW_Stop(t, caster)
    if (caster ~= nil) then
        SaveBoolean(WW_Hash, GetHandleId(caster), 0, false)
    end
    FlushChildHashtable(WW_Hash, GetHandleId(t))
    PauseTimer(t)
    DestroyTimer(t)
end

-- Original JASS function: WW_CreateSpawn (line 12405)
function WW_CreateSpawn(caster)
    local spawned = CreateUnit(GetOwningPlayer(caster), WW_SPAWN_ID, GetUnitX(caster), GetUnitY(caster), GetUnitFacing(caster))
    UnitApplyTimedLife(spawned, FourCC("BTLF"), WW_SPAWN_LIFE)
    spawned = nil
end

-- Original JASS function: WW_Loop (line 12413)
function WW_Loop()
    local t = GetExpiredTimer()
    local caster = LoadUnitHandle(WW_Hash, GetHandleId(t), 0)
    if (caster == nil) then
        WW_Stop(t, caster)
        t = nil
        caster = nil
        do return end
    end
    if (GetWidgetLife(caster) <= __jreal(0.405)) then
        WW_Stop(t, caster)
        t = nil
        caster = nil
        do return end
    end
    if (GetUnitAbilityLevel(caster, WW_BUFF_ID) <= 0) then
        WW_Stop(t, caster)
        t = nil
        caster = nil
        do return end
    end
    WW_CreateSpawn(caster)
    caster = nil
    t = nil
end

-- Original JASS function: WW_Conditions (line 12444)
function WW_Conditions()
    do return (GetSpellAbilityId() == WW_ABILITY_ID) end
end

-- Original JASS function: WW_Actions (line 12448)
function WW_Actions()
    local caster = GetTriggerUnit()
    local casterId = GetHandleId(caster)
    local t = nil
    if LoadBoolean(WW_Hash, casterId, 0) then
        caster = nil
        do return end
    end
    SaveBoolean(WW_Hash, casterId, 0, true)
    WW_CreateSpawn(caster)
    t = CreateTimer()
    SaveUnitHandle(WW_Hash, GetHandleId(t), 0, caster)
    TimerStart(t, WW_PERIOD, true, WW_Loop)
    t = nil
    caster = nil
end

-- Original JASS function: InitTrig_WindWalkWispari (line 12471)
function InitTrig_WindWalkWispari()
    local trg = CreateTrigger()
    local i = 0
    while true do
        if (i >= bj_MAX_PLAYER_SLOTS) then break end
        TriggerRegisterPlayerUnitEvent(trg, Player(i), EVENT_PLAYER_UNIT_SPELL_EFFECT, nil)
        i = __jint(i + 1)
    end
    TriggerAddCondition(trg, Condition(WW_Conditions))
    TriggerAddAction(trg, WW_Actions)
    trg = nil
end
-- END FOREST SECTION 190

-- BEGIN FOREST SECTION 191 TornadoMove
-- Original JASS function: Tornado_Clear_Caster (line 12490)
function Tornado_Clear_Caster(caster)
    if (caster ~= nil) then
        FlushChildHashtable(udg_TornadoHash, GetHandleId(caster))
    end
end

-- Original JASS function: Tornado_Begin_Death (line 12496)
function Tornado_Begin_Death(t)
    local id = GetHandleId(t)
    local fx = LoadEffectHandle(udg_TornadoHash, id, TORNADO_KEY_EFFECT)
    local caster = LoadUnitHandle(udg_TornadoHash, id, TORNADO_KEY_CASTER)
    if LoadBoolean(udg_TornadoHash, id, TORNADO_KEY_DYING) then
        fx = nil
        caster = nil
        t = nil
        do return end
    end
    SaveBoolean(udg_TornadoHash, id, TORNADO_KEY_DYING, true)
    if (caster ~= nil) then
        Tornado_Clear_Caster(caster)
    end
    if (fx ~= nil) then
        DestroyEffect(fx)
    end
    FlushChildHashtable(udg_TornadoHash, id)
    PauseTimer(t)
    DestroyTimer(t)
    fx = nil
    caster = nil
    t = nil
end

-- Original JASS function: Tornado_Caster_Channel_Broken (line 12527)
function Tornado_Caster_Channel_Broken(caster, startX, startY)
    local dx = 0.0
    local dy = 0.0
    if (caster == nil) then
        do return true end
    end
    if (GetWidgetLife(caster) <= __jreal(0.405)) then
        do return true end
    end
    if IsUnitPaused(caster) then
        do return true end
    end
    if IsUnitType(caster, UNIT_TYPE_STUNNED) then
        do return true end
    end
    if IsUnitType(caster, UNIT_TYPE_POLYMORPHED) then
        do return true end
    end
    if IsUnitType(caster, UNIT_TYPE_SLEEPING) then
        do return true end
    end
    dx = __jreal(GetUnitX(caster) - startX)
    dy = __jreal(GetUnitY(caster) - startY)
    do return (__jreal(__jreal(dx * dx) + __jreal(dy * dy)) > __jreal(TORNADO_MOVE_TOLERANCE * TORNADO_MOVE_TOLERANCE)) end
end

-- Original JASS function: Tornado_Line_Loop (line 12561)
function Tornado_Line_Loop()
    local t = GetExpiredTimer()
    local id = GetHandleId(t)
    local fx = LoadEffectHandle(udg_TornadoHash, id, TORNADO_KEY_EFFECT)
    local caster = LoadUnitHandle(udg_TornadoHash, id, TORNADO_KEY_CASTER)
    local x = LoadReal(udg_TornadoHash, id, TORNADO_KEY_X)
    local y = LoadReal(udg_TornadoHash, id, TORNADO_KEY_Y)
    local angle = LoadReal(udg_TornadoHash, id, TORNADO_KEY_ANGLE)
    local traveled = LoadReal(udg_TornadoHash, id, TORNADO_KEY_TRAVELED)
    local maxDistance = LoadReal(udg_TornadoHash, id, TORNADO_KEY_MAX_DISTANCE)
    local speed = LoadReal(udg_TornadoHash, id, TORNADO_KEY_SPEED)
    local channelActive = LoadBoolean(udg_TornadoHash, id, TORNADO_KEY_CHANNEL_ACTIVE)
    local channelLeft = LoadReal(udg_TornadoHash, id, TORNADO_KEY_CHANNEL_LEFT)
    local startX = LoadReal(udg_TornadoHash, id, TORNADO_KEY_START_X)
    local startY = LoadReal(udg_TornadoHash, id, TORNADO_KEY_START_Y)
    local step = __jreal(speed * TORNADO_PERIOD)
    local nextX = 0.0
    local nextY = 0.0
    if (fx == nil) then
        FlushChildHashtable(udg_TornadoHash, id)
        PauseTimer(t)
        DestroyTimer(t)
        caster = nil
        t = nil
        do return end
    end
    if (channelActive and Tornado_Caster_Channel_Broken(caster, startX, startY)) then
        Tornado_Begin_Death(t)
        fx = nil
        caster = nil
        t = nil
        do return end
    end
    if (__jreal(traveled + step) > maxDistance) then
        step = __jreal(maxDistance - traveled)
    end
    nextX = __jreal(x + __jreal(step * Cos(angle)))
    nextY = __jreal(y + __jreal(step * Sin(angle)))
    x = nextX
    y = nextY
    traveled = __jreal(traveled + step)
    BlzSetSpecialEffectPosition(fx, x, y, __jreal(0.00))
    if channelActive then
        channelLeft = __jreal(channelLeft - TORNADO_PERIOD)
        if (channelLeft < __jreal(0.00)) then
            channelLeft = __jreal(0.00)
        end
        SaveReal(udg_TornadoHash, id, TORNADO_KEY_CHANNEL_LEFT, channelLeft)
    end
    if (traveled >= maxDistance) then
        Tornado_Begin_Death(t)
    else
        SaveReal(udg_TornadoHash, id, TORNADO_KEY_X, x)
        SaveReal(udg_TornadoHash, id, TORNADO_KEY_Y, y)
        SaveReal(udg_TornadoHash, id, TORNADO_KEY_TRAVELED, traveled)
    end
    fx = nil
    caster = nil
    t = nil
end

-- Original JASS function: Tornado_Line_Actions (line 12639)
function Tornado_Line_Actions()
    local caster = GetTriggerUnit()
    local casterId = GetHandleId(caster)
    local level = GetUnitAbilityLevel(caster, TORNADO_ABILITY_ID)
    local casterX = GetUnitX(caster)
    local casterY = GetUnitY(caster)
    local x = casterX
    local y = casterY
    local targetX = GetSpellTargetX()
    local targetY = GetSpellTargetY()
    local dx = __jreal(targetX - casterX)
    local dy = __jreal(targetY - casterY)
    local angle = Atan2(dy, dx)
    local maxDistance = __jreal(__jreal(550.00) + __jreal(I2R(level) * __jreal(100.00)))
    local channelTime = __jreal(TORNADO_CHANNEL_BASE + __jreal(TORNADO_CHANNEL_PER_LEVEL * I2R(level)))
    local speed = 0.0
    local fx = nil
    local t = nil
    local old = LoadTimerHandle(udg_TornadoHash, casterId, TORNADO_CASTER_KEY_TIMER)
    local id = 0
    if (old ~= nil) then
        Tornado_Begin_Death(old)
    end
    if (channelTime <= __jreal(0.00)) then
        channelTime = TORNADO_PERIOD
    end
    speed = __jreal(maxDistance / channelTime)
    fx = AddSpecialEffect(TORNADO_MODEL_PATH, x, y)
    BlzSetSpecialEffectScale(fx, TORNADO_EFFECT_SCALE)
    BlzSetSpecialEffectOrientation(fx, angle, __jreal(0.00), __jreal(0.00))
    BlzSetSpecialEffectPosition(fx, x, y, __jreal(0.00))
    BlzPlaySpecialEffect(fx, ANIM_TYPE_STAND)
    t = CreateTimer()
    id = GetHandleId(t)
    SaveEffectHandle(udg_TornadoHash, id, TORNADO_KEY_EFFECT, fx)
    SaveReal(udg_TornadoHash, id, TORNADO_KEY_X, x)
    SaveReal(udg_TornadoHash, id, TORNADO_KEY_Y, y)
    SaveReal(udg_TornadoHash, id, TORNADO_KEY_ANGLE, angle)
    SaveReal(udg_TornadoHash, id, TORNADO_KEY_TRAVELED, __jreal(0.00))
    SaveReal(udg_TornadoHash, id, TORNADO_KEY_MAX_DISTANCE, maxDistance)
    SaveUnitHandle(udg_TornadoHash, id, TORNADO_KEY_CASTER, caster)
    SaveBoolean(udg_TornadoHash, id, TORNADO_KEY_CHANNEL_ACTIVE, true)
    SaveReal(udg_TornadoHash, id, TORNADO_KEY_CHANNEL_LEFT, channelTime)
    SaveReal(udg_TornadoHash, id, TORNADO_KEY_START_X, casterX)
    SaveReal(udg_TornadoHash, id, TORNADO_KEY_START_Y, casterY)
    SaveReal(udg_TornadoHash, id, TORNADO_KEY_SPEED, speed)
    SaveBoolean(udg_TornadoHash, id, TORNADO_KEY_DYING, false)
    SaveTimerHandle(udg_TornadoHash, casterId, TORNADO_CASTER_KEY_TIMER, t)
    TimerStart(t, TORNADO_PERIOD, true, Tornado_Line_Loop)
    caster = nil
    fx = nil
    t = nil
    old = nil
end

-- Original JASS function: Tornado_Line_Endcast_Actions (line 12710)
function Tornado_Line_Endcast_Actions()
    local caster = GetTriggerUnit()
    local casterId = GetHandleId(caster)
    local t = LoadTimerHandle(udg_TornadoHash, casterId, TORNADO_CASTER_KEY_TIMER)
    local id = 0
    local channelLeft = __jreal(0.00)
    if (t ~= nil) then
        id = GetHandleId(t)
        channelLeft = LoadReal(udg_TornadoHash, id, TORNADO_KEY_CHANNEL_LEFT)
        if (channelLeft > TORNADO_ENDCAST_TOLERANCE) then
            Tornado_Begin_Death(t)
        else
            Tornado_Clear_Caster(caster)
            SaveBoolean(udg_TornadoHash, id, TORNADO_KEY_CHANNEL_ACTIVE, false)
            RemoveSavedHandle(udg_TornadoHash, id, TORNADO_KEY_CASTER)
        end
    end
    caster = nil
    t = nil
end

-- Original JASS function: Tornado_Line_Conditions (line 12734)
function Tornado_Line_Conditions()
    do return (GetSpellAbilityId() == TORNADO_ABILITY_ID) end
end

-- Original JASS function: InitTrig_TornadoMove (line 12738)
function InitTrig_TornadoMove()
    local trg = CreateTrigger()
    local endTrg = CreateTrigger()
    if (udg_TornadoHash == nil) then
        udg_TornadoHash = InitHashtable()
    end
    TriggerRegisterAnyUnitEventBJ(trg, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(trg, Condition(Tornado_Line_Conditions))
    TriggerAddAction(trg, Tornado_Line_Actions)
    TriggerRegisterAnyUnitEventBJ(endTrg, EVENT_PLAYER_UNIT_SPELL_ENDCAST)
    TriggerAddCondition(endTrg, Condition(Tornado_Line_Conditions))
    TriggerAddAction(endTrg, Tornado_Line_Endcast_Actions)
    trg = nil
    endTrg = nil
end
-- END FOREST SECTION 191
-- END FOREST MODULE src/ancients/wispari.lua

-- BEGIN FOREST MODULE src/ui/hints.lua
-- ui / hints
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 192 Sit_tight
-- Original JASS function: Trig_Sit_tight_Actions (line 12760)
function Trig_Sit_tight_Actions()
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_549")
end

-- Original JASS function: InitTrig_Sit_tight (line 12765)
function InitTrig_Sit_tight()
    gg_trg_Sit_tight = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_Sit_tight, __jreal(25.00))
    TriggerAddAction(gg_trg_Sit_tight, Trig_Sit_tight_Actions)
end
-- END FOREST SECTION 192

-- BEGIN FOREST SECTION 193 ClearOnEsc
-- Original JASS function: Trig_ClearMessagesOnEsc_Actions (line 12774)
function Trig_ClearMessagesOnEsc_Actions()
    if (GetLocalPlayer() == GetTriggerPlayer()) then
        ClearTextMessages()
    end
end

-- Original JASS function: InitTrig_ClearOnEsc (line 12780)
function InitTrig_ClearOnEsc()
    local t = CreateTrigger()
    local i = 0
    while true do
        if (i >= bj_MAX_PLAYER_SLOTS) then break end
        TriggerRegisterPlayerEvent(t, Player(i), EVENT_PLAYER_END_CINEMATIC)
        i = __jint(i + 1)
    end
    TriggerAddAction(t, Trig_ClearMessagesOnEsc_Actions)
    t = nil
end
-- END FOREST SECTION 193

-- BEGIN FOREST SECTION 194 InitialText
-- Original JASS function: Trig_InitialText_Actions (line 12797)
function Trig_InitialText_Actions()
    local redForce = CreateForce()
    ForceAddPlayer(redForce, Player(0))
    ForceEnumAllies(redForce, Player(0), nil)
    DisplayTimedTextToPlayer(FE_Roles.ancient(), __jreal(0.00), __jreal(0.00), __jreal(40.00), "The Ancient can enable trade by typing -tradeon during pick phase")
    DisplayTimedTextToPlayer(FE_Roles.ancient(), __jreal(0.00), __jreal(0.00), __jreal(40.00), "The Ancient can make enemies stronger by typing -hardmode during pick phase")
    DisplayTimedTextToForce(redForce, __jreal(40.00), "Player 1 (Red) can change feedrate% of all players to any value within 50 and 200, example: '-setfeed 120'")
    DisplayTimedTextToForce(redForce, __jreal(40.00), "Player 1 (Red) can multiply feedrate of all players by typing -setfeed x1.75")
    DisplayTimedTextToForce(redForce, __jreal(40.00), "Player 1 (Red) can also change feedrate of specific player, like: '-setfeed blue 150' or '-setfeed 2 150'")
    DisplayTimedTextToForce(redForce, __jreal(40.00), "Player 1 (Red) can write '-chopchop' to enable tree chopper for Ancient")
    DisplayTimedTextToForce(redForce, __jreal(40.00), "Player 1 (Red) can ban up to four ancients or expanders by typing '-ban name'")
    DisplayTimedTextToForce(redForce, __jreal(40.00), "For races with multiple words to their name, type the first word (e.g. -ban aethyr).")
    DisplayTimedTextToForce(redForce, __jreal(40.00), "Ban ancients by typing their element or given name. Ancient elements: Darkness, Dragon, Earth, Fire, Ice, Light, Lightning, Nature, Sand, Space, Wind")
    DisplayTimedTextToForce(redForce, __jreal(40.00), "Please note that banned races can still be randomed.")
    DisplayTimedTextToForce(redForce, __jreal(40.00), "For more info check F9")
    DestroyForce(redForce)
    redForce = nil
end

-- Original JASS function: InitTrig_InitialText (line 12821)
function InitTrig_InitialText()
    gg_trg_InitialText = CreateTrigger()
    TriggerAddAction(gg_trg_InitialText, Trig_InitialText_Actions)
end
-- END FOREST SECTION 194

-- BEGIN FOREST SECTION 195 Welcome
-- Original JASS function: Trig_Welcome_Actions (line 12830)
function Trig_Welcome_Actions()
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_336")
end

-- Original JASS function: InitTrig_Welcome (line 12835)
function InitTrig_Welcome()
    gg_trg_Welcome = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_Welcome, __jreal(20.00))
    TriggerAddAction(gg_trg_Welcome, Trig_Welcome_Actions)
end
-- END FOREST SECTION 195

-- BEGIN FOREST SECTION 196 Info_Copy
-- Original JASS function: Trig_Info_Copy_Actions (line 12844)
function Trig_Info_Copy_Actions()
    DisplayTimedTextToForce(bj_FORCE_PLAYER[6], __jreal(20.00), "TRIGSTR_469")
end

-- Original JASS function: InitTrig_Info_Copy (line 12849)
function InitTrig_Info_Copy()
    gg_trg_Info_Copy = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_Info_Copy, __jreal(40.00))
    TriggerAddAction(gg_trg_Info_Copy, Trig_Info_Copy_Actions)
end
-- END FOREST SECTION 196

-- BEGIN FOREST SECTION 197 Info
-- Original JASS function: Trig_Info_Actions (line 12858)
function Trig_Info_Actions()
    DisplayTimedTextToForce(bj_FORCE_PLAYER[6], __jreal(45.00), "TRIGSTR_7352")
end

-- Original JASS function: InitTrig_Info (line 12863)
function InitTrig_Info()
    gg_trg_Info = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_Info, __jreal(70.00))
    TriggerAddAction(gg_trg_Info, Trig_Info_Actions)
end
-- END FOREST SECTION 197

-- BEGIN FOREST SECTION 198 Ping_Hint
-- Original JASS function: Trig_Ping_Hint_Actions (line 12872)
function Trig_Ping_Hint_Actions()
    DisplayTextToForce(GetPlayersEnemies(FE_Roles.ancient()), "TRIGSTR_3139")
end

-- Original JASS function: InitTrig_Ping_Hint (line 12877)
function InitTrig_Ping_Hint()
    gg_trg_Ping_Hint = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_Ping_Hint, __jreal(70.00))
    TriggerAddAction(gg_trg_Ping_Hint, Trig_Ping_Hint_Actions)
end
-- END FOREST SECTION 198

-- BEGIN FOREST SECTION 199 Hint2x2
-- Original JASS function: Trig_Hint2x2_Actions (line 12886)
function Trig_Hint2x2_Actions()
    DisplayTextToForce(GetPlayersEnemies(FE_Roles.ancient()), "TRIGSTR_5110")
end

-- Original JASS function: InitTrig_Hint2x2 (line 12891)
function InitTrig_Hint2x2()
    gg_trg_Hint2x2 = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_Hint2x2, __jreal(90.00))
    TriggerAddAction(gg_trg_Hint2x2, Trig_Hint2x2_Actions)
end
-- END FOREST SECTION 199

-- BEGIN FOREST SECTION 200 HintInvisibility
-- Original JASS function: Trig_HintInvisibility_Actions (line 12900)
function Trig_HintInvisibility_Actions()
    DisplayTextToForce(GetPlayersEnemies(FE_Roles.ancient()), "TRIGSTR_5166")
end

-- Original JASS function: InitTrig_HintInvisibility (line 12905)
function InitTrig_HintInvisibility()
    gg_trg_HintInvisibility = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_HintInvisibility, __jreal(110.00))
    TriggerAddAction(gg_trg_HintInvisibility, Trig_HintInvisibility_Actions)
end
-- END FOREST SECTION 200

-- BEGIN FOREST SECTION 201 HintFeed
-- Original JASS function: Trig_HintFeed_Actions (line 12914)
function Trig_HintFeed_Actions()
    DisplayTextToForce(GetPlayersEnemies(FE_Roles.ancient()), "TRIGSTR_5775")
end

-- Original JASS function: InitTrig_HintFeed (line 12919)
function InitTrig_HintFeed()
    gg_trg_HintFeed = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_HintFeed, __jreal(260.00))
    TriggerAddAction(gg_trg_HintFeed, Trig_HintFeed_Actions)
end
-- END FOREST SECTION 201

-- BEGIN FOREST SECTION 202 Resource_Hint
-- Original JASS function: Trig_Resource_Hint_Actions (line 12928)
function Trig_Resource_Hint_Actions()
    DisplayTextToForce(FE_Roster.expanderForce(), "TRIGSTR_7317")
end

-- Original JASS function: InitTrig_Resource_Hint (line 12933)
function InitTrig_Resource_Hint()
    gg_trg_Resource_Hint = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(gg_trg_Resource_Hint, __jreal(300.00))
    TriggerAddAction(gg_trg_Resource_Hint, Trig_Resource_Hint_Actions)
end
-- END FOREST SECTION 202

-- BEGIN FOREST SECTION 203 Ping
-- Original JASS function: Trig_Ping_Actions (line 12942)
function Trig_Ping_Actions()
    PingMinimapLocForForce(GetPlayersAllies(GetTriggerPlayer()), GetRectCenter(gg_rct_Ping1), __jreal(3.00))
    PingMinimapLocForForce(GetPlayersAllies(GetTriggerPlayer()), GetRectCenter(gg_rct_Ping2), __jreal(3.00))
    PingMinimapLocForForce(GetPlayersAllies(GetTriggerPlayer()), GetRectCenter(gg_rct_Ping3), __jreal(3.00))
    PingMinimapLocForForce(GetPlayersAllies(GetTriggerPlayer()), GetRectCenter(gg_rct_Ping4), __jreal(3.00))
    PingMinimapLocForForce(GetPlayersAllies(GetTriggerPlayer()), GetRectCenter(gg_rct_Ping5), __jreal(3.00))
    PingMinimapLocForForce(GetPlayersAllies(GetTriggerPlayer()), GetRectCenter(gg_rct_Ping6), __jreal(3.00))
    PingMinimapLocForForce(GetPlayersAllies(GetTriggerPlayer()), GetRectCenter(gg_rct_Ping7), __jreal(3.00))
end

-- Original JASS function: InitTrig_Ping (line 12953)
function InitTrig_Ping()
    gg_trg_Ping = CreateTrigger()
    TriggerRegisterPlayerChatEvent(gg_trg_Ping, Player(0), "-gold", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Ping, Player(1), "-gold", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Ping, Player(2), "-gold", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Ping, Player(3), "-gold", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Ping, Player(4), "-gold", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Ping, Player(5), "-gold", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Ping, Player(7), "-gold", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Ping, Player(8), "-gold", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Ping, Player(9), "-gold", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Ping, Player(10), "-gold", true)
    TriggerAddAction(gg_trg_Ping, Trig_Ping_Actions)
end
-- END FOREST SECTION 203

-- BEGIN FOREST SECTION 204 PingForAncient
-- Original JASS function: Trig_PingForAncient_Actions (line 12971)
function Trig_PingForAncient_Actions()
    PingMinimapLocForForce(GetPlayersAllies(FE_Roles.ancient()), GetRectCenter(gg_rct_Ping1), __jreal(3.00))
    PingMinimapLocForForce(GetPlayersAllies(FE_Roles.ancient()), GetRectCenter(gg_rct_Ping2), __jreal(3.00))
    PingMinimapLocForForce(GetPlayersAllies(FE_Roles.ancient()), GetRectCenter(gg_rct_Ping3), __jreal(3.00))
    PingMinimapLocForForce(GetPlayersAllies(FE_Roles.ancient()), GetRectCenter(gg_rct_Ping4), __jreal(3.00))
    PingMinimapLocForForce(GetPlayersAllies(FE_Roles.ancient()), GetRectCenter(gg_rct_Ping5), __jreal(3.00))
    PingMinimapLocForForce(GetPlayersAllies(FE_Roles.ancient()), GetRectCenter(gg_rct_Ping6), __jreal(3.00))
    PingMinimapLocForForce(GetPlayersAllies(FE_Roles.ancient()), GetRectCenter(gg_rct_Ping7), __jreal(3.00))
end

-- Original JASS function: InitTrig_PingForAncient (line 12982)
function InitTrig_PingForAncient()
    gg_trg_PingForAncient = CreateTrigger()
    FE_Roles.registerAncientChatEvent(gg_trg_PingForAncient, "-gold", true)
    TriggerAddAction(gg_trg_PingForAncient, Trig_PingForAncient_Actions)
end
-- END FOREST SECTION 204
-- END FOREST MODULE src/ui/hints.lua

-- BEGIN FOREST MODULE src/ai/behavior.lua
-- ai / behavior
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 206 Start
-- Original JASS function: Trig_Start_Func001C (line 13720)
function Trig_Start_Func001C()
    if ((not ((GetPlayerController(FE_Roles.ancient()) ~= MAP_CONTROL_USER)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Start_Actions (line 13727)
function Trig_Start_Actions()
    if (Trig_Start_Func001C()) then
        EnableTrigger(gg_trg_Hard_mode_on)
        EnableTrigger(gg_trg_Select)
        EnableTrigger(gg_trg_Abilities)
        EnableTrigger(gg_trg_Attack)
        TriggerSleepAction(__jreal(2))
        DisplayTextToForce(FE_Roster.expanderForce(), "TRIGSTR_7143")
    else
        DoNothing()
    end
end

-- Original JASS function: InitTrig_Start (line 13741)
function InitTrig_Start()
    gg_trg_Start = CreateTrigger()
    TriggerAddAction(gg_trg_Start, Trig_Start_Actions)
end
-- END FOREST SECTION 206

-- BEGIN FOREST SECTION 207 Hard_mode_on
-- Original JASS function: Trig_Hard_mode_on_Actions (line 13749)
function Trig_Hard_mode_on_Actions()
    DisplayTextToForce(FE_Roster.expanderForce(), "TRIGSTR_7144")
    DisableTrigger(gg_trg_Attack)
    EnableTrigger(gg_trg_Hard_Attack)
end

-- Original JASS function: InitTrig_Hard_mode_on (line 13756)
function InitTrig_Hard_mode_on()
    gg_trg_Hard_mode_on = CreateTrigger()
    DisableTrigger(gg_trg_Hard_mode_on)
    TriggerRegisterPlayerChatEvent(gg_trg_Hard_mode_on, Player(0), "-hm", true)
    TriggerAddAction(gg_trg_Hard_mode_on, Trig_Hard_mode_on_Actions)
end
-- END FOREST SECTION 207

-- BEGIN FOREST SECTION 208 Hard_Attack
-- Original JASS function: Trig_Hard_Attack_Conditions (line 13766)
function Trig_Hard_Attack_Conditions()
    if ((not ((IsUnitEnemy(GetTriggerUnit(), FE_Roles.ancient()) == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Hard_Attack_Func002002001 (line 13773)
function Trig_Hard_Attack_Func002002001()
    do return ((GetOwningPlayer(GetEnumUnit()) ~= FE_Roles.ancient())) end
end

-- Original JASS function: Trig_Hard_Attack_Func002002002001 (line 13777)
function Trig_Hard_Attack_Func002002002001()
    do return ((GetOwningPlayer(GetEnumUnit()) ~= Player(PLAYER_NEUTRAL_PASSIVE))) end
end

-- Original JASS function: Trig_Hard_Attack_Func002002002002001 (line 13781)
function Trig_Hard_Attack_Func002002002002001()
    do return ((GetOwningPlayer(GetEnumUnit()) ~= Player(PLAYER_NEUTRAL_AGGRESSIVE))) end
end

-- Original JASS function: Trig_Hard_Attack_Func002002 (line 13785)
function Trig_Hard_Attack_Func002002()
    if (((GetOwningPlayer(GetEnumUnit()) ~= FE_Roles.ancient()))) then
        if (((GetOwningPlayer(GetEnumUnit()) ~= Player(PLAYER_NEUTRAL_PASSIVE)))) then
            if (((GetOwningPlayer(GetEnumUnit()) ~= Player(PLAYER_NEUTRAL_AGGRESSIVE)))) then
                udg_Hardunit = GetUnitLoc(GetEnumUnit())
            else
                TriggerExecute(gg_trg_Hard_attack_2)
            end
        else
            TriggerExecute(gg_trg_Hard_attack_2)
        end
    else
        TriggerExecute(gg_trg_Hard_attack_2)
    end
end

-- Original JASS function: Trig_Hard_Attack_Func003002 (line 13801)
function Trig_Hard_Attack_Func003002()
    IssuePointOrderLocBJ(GetEnumUnit(), "attack", udg_Hardunit)
end

-- Original JASS function: Trig_Hard_Attack_Actions (line 13805)
function Trig_Hard_Attack_Actions()
    ForGroupBJ(GetRandomSubGroup(1, GetUnitsInRectAll(GetPlayableMapRect())), Trig_Hard_Attack_Func002002)
    ForGroupBJ(GetUnitsOfPlayerAll(FE_Roles.ancient()), Trig_Hard_Attack_Func003002)
    EnableTrigger(gg_trg_Hard_Attack_Cont)
end

-- Original JASS function: InitTrig_Hard_Attack (line 13812)
function InitTrig_Hard_Attack()
    gg_trg_Hard_Attack = CreateTrigger()
    DisableTrigger(gg_trg_Hard_Attack)
    TriggerRegisterAnyUnitEventBJ(gg_trg_Hard_Attack, EVENT_PLAYER_UNIT_DEATH)
    TriggerRegisterTimerEventPeriodic(gg_trg_Hard_Attack, __jreal(35.00))
    TriggerAddCondition(gg_trg_Hard_Attack, Condition(Trig_Hard_Attack_Conditions))
    TriggerAddAction(gg_trg_Hard_Attack, Trig_Hard_Attack_Actions)
end
-- END FOREST SECTION 208

-- BEGIN FOREST SECTION 209 Hard_Attack_Cont
-- Original JASS function: Trig_Hard_Attack_Cont_Conditions (line 13824)
function Trig_Hard_Attack_Cont_Conditions()
    if ((not ((IsUnitEnemy(GetDyingUnit(), FE_Roles.ancient()) == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Hard_Attack_Cont_Func003002001 (line 13831)
function Trig_Hard_Attack_Cont_Func003002001()
    do return ((GetOwningPlayer(GetEnumUnit()) ~= FE_Roles.ancient())) end
end

-- Original JASS function: Trig_Hard_Attack_Cont_Func003002002001 (line 13835)
function Trig_Hard_Attack_Cont_Func003002002001()
    do return ((GetOwningPlayer(GetEnumUnit()) ~= Player(PLAYER_NEUTRAL_PASSIVE))) end
end

-- Original JASS function: Trig_Hard_Attack_Cont_Func003002002002001 (line 13839)
function Trig_Hard_Attack_Cont_Func003002002002001()
    do return ((GetOwningPlayer(GetEnumUnit()) ~= Player(PLAYER_NEUTRAL_AGGRESSIVE))) end
end

-- Original JASS function: Trig_Hard_Attack_Cont_Func003002 (line 13843)
function Trig_Hard_Attack_Cont_Func003002()
    if (((GetOwningPlayer(GetEnumUnit()) ~= FE_Roles.ancient()))) then
        if (((GetOwningPlayer(GetEnumUnit()) ~= Player(PLAYER_NEUTRAL_PASSIVE)))) then
            if (((GetOwningPlayer(GetEnumUnit()) ~= Player(PLAYER_NEUTRAL_AGGRESSIVE)))) then
                udg_Hardunit = GetUnitLoc(GetEnumUnit())
            else
                TriggerExecute(gg_trg_Hard_attack_2)
            end
        else
            TriggerExecute(gg_trg_Hard_attack_2)
        end
    else
        TriggerExecute(gg_trg_Hard_attack_2)
    end
end

-- Original JASS function: Trig_Hard_Attack_Cont_Func004002 (line 13859)
function Trig_Hard_Attack_Cont_Func004002()
    IssuePointOrderLocBJ(GetEnumUnit(), "attack", udg_Hardunit)
end

-- Original JASS function: Trig_Hard_Attack_Cont_Actions (line 13863)
function Trig_Hard_Attack_Cont_Actions()
    ForGroupBJ(GetRandomSubGroup(1, GetUnitsInRectAll(GetPlayableMapRect())), Trig_Hard_Attack_Cont_Func003002)
    ForGroupBJ(GetUnitsOfPlayerAll(FE_Roles.ancient()), Trig_Hard_Attack_Cont_Func004002)
end

-- Original JASS function: InitTrig_Hard_Attack_Cont (line 13869)
function InitTrig_Hard_Attack_Cont()
    gg_trg_Hard_Attack_Cont = CreateTrigger()
    DisableTrigger(gg_trg_Hard_Attack_Cont)
    TriggerRegisterAnyUnitEventBJ(gg_trg_Hard_Attack_Cont, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Hard_Attack_Cont, Condition(Trig_Hard_Attack_Cont_Conditions))
    TriggerAddAction(gg_trg_Hard_Attack_Cont, Trig_Hard_Attack_Cont_Actions)
end
-- END FOREST SECTION 209

-- BEGIN FOREST SECTION 210 Hard_attack_2
-- Original JASS function: Trig_Hard_attack_2_Func001002001 (line 13880)
function Trig_Hard_attack_2_Func001002001()
    do return ((GetOwningPlayer(GetEnumUnit()) ~= FE_Roles.ancient())) end
end

-- Original JASS function: Trig_Hard_attack_2_Func001002002001 (line 13884)
function Trig_Hard_attack_2_Func001002002001()
    do return ((GetOwningPlayer(GetEnumUnit()) ~= Player(PLAYER_NEUTRAL_PASSIVE))) end
end

-- Original JASS function: Trig_Hard_attack_2_Func001002002002001 (line 13888)
function Trig_Hard_attack_2_Func001002002002001()
    do return ((GetOwningPlayer(GetEnumUnit()) ~= Player(PLAYER_NEUTRAL_AGGRESSIVE))) end
end

-- Original JASS function: Trig_Hard_attack_2_Func001002 (line 13892)
function Trig_Hard_attack_2_Func001002()
    if (((GetOwningPlayer(GetEnumUnit()) ~= FE_Roles.ancient()))) then
        if (((GetOwningPlayer(GetEnumUnit()) ~= Player(PLAYER_NEUTRAL_PASSIVE)))) then
            if (((GetOwningPlayer(GetEnumUnit()) ~= Player(PLAYER_NEUTRAL_AGGRESSIVE)))) then
                udg_Hardunit = GetUnitLoc(GetEnumUnit())
            else
                TriggerExecute(gg_trg_Hard_attack_2)
            end
        else
            TriggerExecute(gg_trg_Hard_attack_2)
        end
    else
        TriggerExecute(gg_trg_Hard_attack_2)
    end
end

-- Original JASS function: Trig_Hard_attack_2_Func002002 (line 13908)
function Trig_Hard_attack_2_Func002002()
    IssuePointOrderLocBJ(GetEnumUnit(), "attack", GetUnitLoc(GetFilterUnit()))
end

-- Original JASS function: Trig_Hard_attack_2_Actions (line 13912)
function Trig_Hard_attack_2_Actions()
    ForGroupBJ(GetRandomSubGroup(1, GetUnitsInRectAll(GetPlayableMapRect())), Trig_Hard_attack_2_Func001002)
    ForGroupBJ(GetUnitsOfPlayerAll(FE_Roles.ancient()), Trig_Hard_attack_2_Func002002)
end

-- Original JASS function: InitTrig_Hard_attack_2 (line 13918)
function InitTrig_Hard_attack_2()
    gg_trg_Hard_attack_2 = CreateTrigger()
    DisableTrigger(gg_trg_Hard_attack_2)
    TriggerAddAction(gg_trg_Hard_attack_2, Trig_Hard_attack_2_Actions)
end
-- END FOREST SECTION 210

-- BEGIN FOREST SECTION 211 Select
-- Original JASS function: Trig_Select_Func026002 (line 13927)
function Trig_Select_Func026002()
    RemoveUnit(GetEnumUnit())
end

-- Original JASS function: Trig_Select_Actions (line 13931)
function Trig_Select_Actions()
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
    udg_Ancients[23] = FourCC("O01V")
    udg_Ancients[24] = FourCC("O01V")
    udg_Ancients[25] = FourCC("O01V")
    ForGroupBJ(GetUnitsInRectAll(gg_rct_SpawnDefender), Trig_Select_Func026002)
    AdjustPlayerStateBJ(__jint(-(1000)), FE_Roles.ancient(), PLAYER_STATE_RESOURCE_GOLD)
    CreateNUnitsAtLoc(1, udg_Ancients[GetRandomInt(1, 8)], FE_Roles.ancient(), GetRectCenter(gg_rct_Spawner), bj_UNIT_FACING)
    udg_AncientUnit = GetLastCreatedUnit()
    EnableTrigger(gg_trg_Slot1_Righteous_Armor)
end

-- Original JASS function: InitTrig_Select (line 13965)
function InitTrig_Select()
    gg_trg_Select = CreateTrigger()
    DisableTrigger(gg_trg_Select)
    TriggerRegisterTimerEventSingle(gg_trg_Select, __jreal(100.00))
    TriggerAddAction(gg_trg_Select, Trig_Select_Actions)
end
-- END FOREST SECTION 211

-- BEGIN FOREST SECTION 212 Attack
-- Original JASS function: Trig_Attack_Func017002 (line 13975)
function Trig_Attack_Func017002()
    IssuePointOrderLocBJ(GetEnumUnit(), "attack", GetRectCenter(udg_Moveto[GetRandomInt(1, 16)]))
end

-- Original JASS function: Trig_Attack_Actions (line 13979)
function Trig_Attack_Actions()
    udg_Moveto[1] = gg_rct_Ping1
    udg_Moveto[2] = gg_rct_Ping2
    udg_Moveto[3] = gg_rct_Ping3
    udg_Moveto[4] = gg_rct_Ping4
    udg_Moveto[5] = gg_rct_Ping5
    udg_Moveto[6] = gg_rct_Ping6
    udg_Moveto[7] = gg_rct_AI_Move_1
    udg_Moveto[8] = gg_rct_AI_Move_10
    udg_Moveto[9] = gg_rct_AI_Move_2
    udg_Moveto[10] = gg_rct_AI_Move_3
    udg_Moveto[11] = gg_rct_AI_Move_4
    udg_Moveto[12] = gg_rct_AI_Move_5
    udg_Moveto[13] = gg_rct_AI_Move_6
    udg_Moveto[14] = gg_rct_AI_Move_7
    udg_Moveto[15] = gg_rct_AI_Move_8
    udg_Moveto[16] = gg_rct_AI_Move_9
    ForGroupBJ(GetUnitsOfPlayerAll(FE_Roles.ancient()), Trig_Attack_Func017002)
end

-- Original JASS function: InitTrig_Attack (line 14000)
function InitTrig_Attack()
    gg_trg_Attack = CreateTrigger()
    DisableTrigger(gg_trg_Attack)
    TriggerRegisterTimerEventPeriodic(gg_trg_Attack, __jreal(65.00))
    TriggerAddAction(gg_trg_Attack, Trig_Attack_Actions)
end
-- END FOREST SECTION 212

-- BEGIN FOREST SECTION 213 Run_away
-- Original JASS function: Trig_Run_away_Actions (line 14012)
function Trig_Run_away_Actions()
end

-- Original JASS function: InitTrig_Run_away (line 14016)
function InitTrig_Run_away()
    gg_trg_Run_away = CreateTrigger()
    DisableTrigger(gg_trg_Run_away)
    TriggerAddAction(gg_trg_Run_away, Trig_Run_away_Actions)
end
-- END FOREST SECTION 213

-- BEGIN FOREST SECTION 214 Slot1_Righteous_Armor
-- Original JASS function: Trig_Slot1_Righteous_Armor_Actions (line 14025)
function Trig_Slot1_Righteous_Armor_Actions()
    UnitAddItemByIdSwapped(FourCC("I012"), udg_AncientUnit)
    AdjustPlayerStateBJ(-FE_RecipeData.items[FourCC("I012")].gold, FE_Roles.ancient(), PLAYER_STATE_RESOURCE_GOLD)
    DisableTrigger(GetTriggeringTrigger())
    EnableTrigger(gg_trg_Slot2_Valor_Helmet)
end

-- Original JASS function: InitTrig_Slot1_Righteous_Armor (line 14033)
function InitTrig_Slot1_Righteous_Armor()
    gg_trg_Slot1_Righteous_Armor = CreateTrigger()
    DisableTrigger(gg_trg_Slot1_Righteous_Armor)
    FE_Roles.registerAncientStateEvent(gg_trg_Slot1_Righteous_Armor, PLAYER_STATE_RESOURCE_GOLD, GREATER_THAN_OR_EQUAL, FE_RecipeData.items[FourCC("I012")].gold)
    TriggerAddAction(gg_trg_Slot1_Righteous_Armor, Trig_Slot1_Righteous_Armor_Actions)
end
-- END FOREST SECTION 214

-- BEGIN FOREST SECTION 215 Slot2_Valor_Helmet
-- Original JASS function: Trig_Slot2_Valor_Helmet_Actions (line 14043)
function Trig_Slot2_Valor_Helmet_Actions()
    UnitAddItemByIdSwapped(FourCC("I015"), udg_AncientUnit)
    AdjustPlayerStateBJ(-FE_RecipeData.items[FourCC("I015")].gold, FE_Roles.ancient(), PLAYER_STATE_RESOURCE_GOLD)
    DisableTrigger(GetTriggeringTrigger())
    EnableTrigger(gg_trg_Slot3_Bladed_Gauntlet)
end

-- Original JASS function: InitTrig_Slot2_Valor_Helmet (line 14051)
function InitTrig_Slot2_Valor_Helmet()
    gg_trg_Slot2_Valor_Helmet = CreateTrigger()
    DisableTrigger(gg_trg_Slot2_Valor_Helmet)
    FE_Roles.registerAncientStateEvent(gg_trg_Slot2_Valor_Helmet, PLAYER_STATE_RESOURCE_GOLD, GREATER_THAN_OR_EQUAL, FE_RecipeData.items[FourCC("I015")].gold)
    TriggerAddAction(gg_trg_Slot2_Valor_Helmet, Trig_Slot2_Valor_Helmet_Actions)
end
-- END FOREST SECTION 215

-- BEGIN FOREST SECTION 216 Slot3_Bladed_Gauntlet
-- Original JASS function: Trig_Slot3_Bladed_Gauntlet_Actions (line 14061)
function Trig_Slot3_Bladed_Gauntlet_Actions()
    AdjustPlayerStateBJ(-FE_RecipeData.items[FourCC("I012")].gold, FE_Roles.ancient(), PLAYER_STATE_RESOURCE_GOLD)
    UnitAddItemByIdSwapped(FourCC("I012"), udg_AncientUnit)
    DisableTrigger(GetTriggeringTrigger())
    EnableTrigger(gg_trg_Slot4_Bladed_Gauntlet)
end

-- Original JASS function: InitTrig_Slot3_Bladed_Gauntlet (line 14069)
function InitTrig_Slot3_Bladed_Gauntlet()
    gg_trg_Slot3_Bladed_Gauntlet = CreateTrigger()
    DisableTrigger(gg_trg_Slot3_Bladed_Gauntlet)
    FE_Roles.registerAncientStateEvent(gg_trg_Slot3_Bladed_Gauntlet, PLAYER_STATE_RESOURCE_GOLD, GREATER_THAN_OR_EQUAL, FE_RecipeData.items[FourCC("I012")].gold)
    TriggerAddAction(gg_trg_Slot3_Bladed_Gauntlet, Trig_Slot3_Bladed_Gauntlet_Actions)
end
-- END FOREST SECTION 216

-- BEGIN FOREST SECTION 217 Slot4_Bladed_Gauntlet
-- Original JASS function: Trig_Slot4_Bladed_Gauntlet_Actions (line 14079)
function Trig_Slot4_Bladed_Gauntlet_Actions()
    AdjustPlayerStateBJ(-FE_RecipeData.items[FourCC("I012")].gold, FE_Roles.ancient(), PLAYER_STATE_RESOURCE_GOLD)
    UnitAddItemByIdSwapped(FourCC("I012"), udg_AncientUnit)
    DisableTrigger(GetTriggeringTrigger())
    EnableTrigger(gg_trg_Slot5_Bladed_Gauntlet)
end

-- Original JASS function: InitTrig_Slot4_Bladed_Gauntlet (line 14087)
function InitTrig_Slot4_Bladed_Gauntlet()
    gg_trg_Slot4_Bladed_Gauntlet = CreateTrigger()
    DisableTrigger(gg_trg_Slot4_Bladed_Gauntlet)
    FE_Roles.registerAncientStateEvent(gg_trg_Slot4_Bladed_Gauntlet, PLAYER_STATE_RESOURCE_GOLD, GREATER_THAN_OR_EQUAL, FE_RecipeData.items[FourCC("I012")].gold)
    TriggerAddAction(gg_trg_Slot4_Bladed_Gauntlet, Trig_Slot4_Bladed_Gauntlet_Actions)
end
-- END FOREST SECTION 217

-- BEGIN FOREST SECTION 218 Slot5_Bladed_Gauntlet
-- Original JASS function: Trig_Slot5_Bladed_Gauntlet_Actions (line 14097)
function Trig_Slot5_Bladed_Gauntlet_Actions()
    AdjustPlayerStateBJ(-FE_RecipeData.items[FourCC("I012")].gold, FE_Roles.ancient(), PLAYER_STATE_RESOURCE_GOLD)
    UnitAddItemByIdSwapped(FourCC("I012"), udg_AncientUnit)
    DisableTrigger(GetTriggeringTrigger())
    EnableTrigger(gg_trg_Slot6_Bladed_Gauntlet)
end

-- Original JASS function: InitTrig_Slot5_Bladed_Gauntlet (line 14105)
function InitTrig_Slot5_Bladed_Gauntlet()
    gg_trg_Slot5_Bladed_Gauntlet = CreateTrigger()
    DisableTrigger(gg_trg_Slot5_Bladed_Gauntlet)
    FE_Roles.registerAncientStateEvent(gg_trg_Slot5_Bladed_Gauntlet, PLAYER_STATE_RESOURCE_GOLD, GREATER_THAN_OR_EQUAL, FE_RecipeData.items[FourCC("I012")].gold)
    TriggerAddAction(gg_trg_Slot5_Bladed_Gauntlet, Trig_Slot5_Bladed_Gauntlet_Actions)
end
-- END FOREST SECTION 218

-- BEGIN FOREST SECTION 219 Slot6_Bladed_Gauntlet
-- Original JASS function: Trig_Slot6_Bladed_Gauntlet_Actions (line 14115)
function Trig_Slot6_Bladed_Gauntlet_Actions()
    AdjustPlayerStateBJ(-FE_RecipeData.items[FourCC("I012")].gold, FE_Roles.ancient(), PLAYER_STATE_RESOURCE_GOLD)
    UnitAddItemByIdSwapped(FourCC("I012"), udg_AncientUnit)
    DisableTrigger(GetTriggeringTrigger())
    EnableTrigger(gg_trg_Level_Up_Tomes)
end

-- Original JASS function: InitTrig_Slot6_Bladed_Gauntlet (line 14123)
function InitTrig_Slot6_Bladed_Gauntlet()
    gg_trg_Slot6_Bladed_Gauntlet = CreateTrigger()
    DisableTrigger(gg_trg_Slot6_Bladed_Gauntlet)
    FE_Roles.registerAncientStateEvent(gg_trg_Slot6_Bladed_Gauntlet, PLAYER_STATE_RESOURCE_GOLD, GREATER_THAN_OR_EQUAL, FE_RecipeData.items[FourCC("I012")].gold)
    TriggerAddAction(gg_trg_Slot6_Bladed_Gauntlet, Trig_Slot6_Bladed_Gauntlet_Actions)
end
-- END FOREST SECTION 219

-- BEGIN FOREST SECTION 220 Level_Up_Tomes
-- AI uses a powerup tome with a full inventory, at the player shop tome price.
-- Original JASS function: Trig_Level_Up_Tomes_Actions (line 14133)
function Trig_Level_Up_Tomes_Actions()
    UnitAddItemByIdSwapped(FourCC("I003"), udg_AncientUnit)
    AdjustPlayerStateBJ(-FE_RecipeData.items[FourCC("I00J")].gold, FE_Roles.ancient(), PLAYER_STATE_RESOURCE_GOLD)
end

-- Original JASS function: InitTrig_Level_Up_Tomes (line 14139)
function InitTrig_Level_Up_Tomes()
    gg_trg_Level_Up_Tomes = CreateTrigger()
    DisableTrigger(gg_trg_Level_Up_Tomes)
    FE_Roles.registerAncientStateEvent(gg_trg_Level_Up_Tomes, PLAYER_STATE_RESOURCE_GOLD, GREATER_THAN_OR_EQUAL, FE_RecipeData.items[FourCC("I00J")].gold)
    TriggerAddAction(gg_trg_Level_Up_Tomes, Trig_Level_Up_Tomes_Actions)
end
-- END FOREST SECTION 220

-- BEGIN FOREST SECTION 221 Abilities
-- Original JASS function: Trig_Abilities_Func001Func007Func007Func007Func006Func007Func007Func001Func001C (line 14149)
function Trig_Abilities_Func001Func007Func007Func007Func006Func007Func007Func001Func001C()
    if ((not ((GetUnitTypeId(udg_AncientUnit) == FourCC("O01V"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Abilities_Func001Func007Func007Func007Func006Func007Func007Func001C (line 14156)
function Trig_Abilities_Func001Func007Func007Func007Func006Func007Func007Func001C()
    if ((not ((GetUnitTypeId(udg_AncientUnit) == FourCC("O01D"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Abilities_Func001Func007Func007Func007Func006Func007Func007C (line 14163)
function Trig_Abilities_Func001Func007Func007Func007Func006Func007Func007C()
    if ((not ((GetUnitTypeId(udg_AncientUnit) == FourCC("O016"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Abilities_Func001Func007Func007Func007Func006Func007C (line 14170)
function Trig_Abilities_Func001Func007Func007Func007Func006Func007C()
    if ((not ((GetUnitTypeId(udg_AncientUnit) == FourCC("O00D"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Abilities_Func001Func007Func007Func007Func006C (line 14177)
function Trig_Abilities_Func001Func007Func007Func007Func006C()
    if ((not ((GetUnitTypeId(udg_AncientUnit) == FourCC("O008"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Abilities_Func001Func007Func007Func007C (line 14184)
function Trig_Abilities_Func001Func007Func007Func007C()
    if ((not ((GetUnitTypeId(udg_AncientUnit) == FourCC("O004"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Abilities_Func001Func007Func007C (line 14191)
function Trig_Abilities_Func001Func007Func007C()
    if ((not ((GetUnitTypeId(udg_AncientUnit) == FourCC("O00L"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Abilities_Func001Func007C (line 14198)
function Trig_Abilities_Func001Func007C()
    if ((not ((GetUnitTypeId(udg_AncientUnit) == FourCC("O00S"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Abilities_Func001C (line 14205)
function Trig_Abilities_Func001C()
    if ((not ((GetUnitTypeId(udg_AncientUnit) == FourCC("O00A"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Abilities_Actions (line 14212)
function Trig_Abilities_Actions()
    if (Trig_Abilities_Func001C()) then
        SelectHeroSkill(udg_AncientUnit, FourCC("A05E"))
        SelectHeroSkill(udg_AncientUnit, FourCC("A05C"))
        SelectHeroSkill(udg_AncientUnit, FourCC("A0E9"))
        SelectHeroSkill(udg_AncientUnit, FourCC("A058"))
        SelectHeroSkill(udg_AncientUnit, FourCC("A05F"))
    else
        if (Trig_Abilities_Func001Func007C()) then
            SelectHeroSkill(udg_AncientUnit, FourCC("A02D"))
            SelectHeroSkill(udg_AncientUnit, FourCC("A06P"))
            SelectHeroSkill(udg_AncientUnit, FourCC("A01J"))
            SelectHeroSkill(udg_AncientUnit, FourCC("A02A"))
            SelectHeroSkill(udg_AncientUnit, FourCC("A02B"))
        else
            if (Trig_Abilities_Func001Func007Func007C()) then
                SelectHeroSkill(udg_AncientUnit, FourCC("A06F"))
                SelectHeroSkill(udg_AncientUnit, FourCC("A088"))
                SelectHeroSkill(udg_AncientUnit, FourCC("A05Q"))
                SelectHeroSkill(udg_AncientUnit, FourCC("A01T"))
                SelectHeroSkill(udg_AncientUnit, FourCC("A06D"))
            else
                if (Trig_Abilities_Func001Func007Func007Func007C()) then
                    SelectHeroSkill(udg_AncientUnit, FourCC("A004"))
                    SelectHeroSkill(udg_AncientUnit, FourCC("A000"))
                    SelectHeroSkill(udg_AncientUnit, FourCC("A003"))
                    SelectHeroSkill(udg_AncientUnit, FourCC("A002"))
                else
                    if (Trig_Abilities_Func001Func007Func007Func007Func006C()) then
                        SelectHeroSkill(udg_AncientUnit, FourCC("A075"))
                        SelectHeroSkill(udg_AncientUnit, FourCC("A073"))
                        SelectHeroSkill(udg_AncientUnit, FourCC("A074"))
                        SelectHeroSkill(udg_AncientUnit, FourCC("A00A"))
                        SelectHeroSkill(udg_AncientUnit, FourCC("A008"))
                    else
                        if (Trig_Abilities_Func001Func007Func007Func007Func006Func007C()) then
                            SelectHeroSkill(udg_AncientUnit, FourCC("A013"))
                            SelectHeroSkill(udg_AncientUnit, FourCC("A070"))
                            SelectHeroSkill(udg_AncientUnit, FourCC("A01M"))
                            SelectHeroSkill(udg_AncientUnit, FourCC("A012"))
                            SelectHeroSkill(udg_AncientUnit, FourCC("A06Z"))
                        else
                            if (Trig_Abilities_Func001Func007Func007Func007Func006Func007Func007C()) then
                                SelectHeroSkill(udg_AncientUnit, FourCC("A03R"))
                                SelectHeroSkill(udg_AncientUnit, FourCC("A03S"))
                                SelectHeroSkill(udg_AncientUnit, FourCC("A03U"))
                                SelectHeroSkill(udg_AncientUnit, FourCC("A03T"))
                            else
                                if (Trig_Abilities_Func001Func007Func007Func007Func006Func007Func007Func001C()) then
                                    SelectHeroSkill(udg_AncientUnit, FourCC("A048"))
                                    SelectHeroSkill(udg_AncientUnit, FourCC("A046"))
                                    SelectHeroSkill(udg_AncientUnit, FourCC("A045"))
                                    SelectHeroSkill(udg_AncientUnit, FourCC("A047"))
                                else
                                    if (Trig_Abilities_Func001Func007Func007Func007Func006Func007Func007Func001Func001C()) then
                                        SelectHeroSkill(udg_AncientUnit, FourCC("A06Y"))
                                        SelectHeroSkill(udg_AncientUnit, FourCC("A06X"))
                                        SelectHeroSkill(udg_AncientUnit, FourCC("A06U"))
                                        SelectHeroSkill(udg_AncientUnit, FourCC("A06W"))
                                        SelectHeroSkill(udg_AncientUnit, FourCC("A06V"))
                                    else
                                        DoNothing()
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

-- Original JASS function: InitTrig_Abilities (line 14286)
function InitTrig_Abilities()
    gg_trg_Abilities = CreateTrigger()
    DisableTrigger(gg_trg_Abilities)
    TriggerRegisterTimerEventPeriodic(gg_trg_Abilities, __jreal(30.00))
    TriggerAddAction(gg_trg_Abilities, Trig_Abilities_Actions)
end
-- END FOREST SECTION 221
-- END FOREST MODULE src/ai/behavior.lua

-- BEGIN FOREST MODULE src/items/effects.lua
-- items / effects
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 222 Staff_of_insight_pickup
-- Original JASS function: Trig_Staff_of_insight_pickup_Conditions (line 14296)
function Trig_Staff_of_insight_pickup_Conditions()
    if ((not ((GetItemTypeId(GetManipulatedItem()) == FourCC("I01C"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Staff_of_insight_pickup_Actions (line 14303)
function Trig_Staff_of_insight_pickup_Actions()
    BlzItemAddAbilityBJ(GetManipulatedItem(), FourCC("AIms"))
end

-- Original JASS function: InitTrig_Staff_of_insight_pickup (line 14308)
function InitTrig_Staff_of_insight_pickup()
    gg_trg_Staff_of_insight_pickup = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Staff_of_insight_pickup, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    TriggerAddCondition(gg_trg_Staff_of_insight_pickup, Condition(Trig_Staff_of_insight_pickup_Conditions))
    TriggerAddAction(gg_trg_Staff_of_insight_pickup, Trig_Staff_of_insight_pickup_Actions)
end
-- END FOREST SECTION 222

-- BEGIN FOREST SECTION 223 Dusts_Slow
-- Original JASS function: DAS_RegisterInvisBuff (line 14319)
function DAS_RegisterInvisBuff(buffId)
    DAS_InvisBuff[DAS_InvisBuffCount] = buffId
    DAS_InvisBuffCount = __jint(DAS_InvisBuffCount + 1)
end

-- Original JASS function: DAS_InitInvisBuffs (line 14324)
function DAS_InitInvisBuffs()
    DAS_InvisBuffCount = 0
    DAS_RegisterInvisBuff(FourCC("B03X"))
    DAS_RegisterInvisBuff(FourCC("B026"))
    DAS_RegisterInvisBuff(FourCC("BOwk"))
    DAS_RegisterInvisBuff(FourCC("Binv"))
    DAS_RegisterInvisBuff(FourCC("B001"))
end

-- Original JASS function: DAS_HasSlowAura (line 14334)
function DAS_HasSlowAura(target)
    do return (GetUnitAbilityLevel(target, DAS_SLOW_AURA_ID) > 0) end
end

-- Original JASS function: DAS_TargetCountsAsInvisible (line 14338)
function DAS_TargetCountsAsInvisible(target, dustOwner)
    local engineInvisible = false
    local i = 0
    if (dustOwner ~= nil) then
        engineInvisible = IsUnitInvisible(target, dustOwner)
    end
    if engineInvisible then
        do return true end
    end
    if (GetUnitAbilityLevel(target, DAS_PERMANENT_INVIS_ABILITY) > 0) then
        do return true end
    end
    while true do
        if (i >= DAS_InvisBuffCount) then break end
        if (GetUnitAbilityLevel(target, DAS_InvisBuff[i]) > 0) then
            do return true end
        end
        i = __jint(i + 1)
    end
    do return false end
end

-- Original JASS function: DAS_AddSlowAura (line 14367)
function DAS_AddSlowAura(target)
    if (target == nil) then
        do return end
    end
    if (not ((GetUnitAbilityLevel((target), DAS_SLOW_AURA_ID) > 0))) then
        UnitAddAbility(target, DAS_SLOW_AURA_ID)
        BlzUnitHideAbility(target, DAS_SLOW_AURA_ID, true)
    end
end

-- Original JASS function: DAS_RemoveSlowAura (line 14378)
function DAS_RemoveSlowAura(target)
    if (target == nil) then
        do return end
    end
    if ((GetUnitAbilityLevel((target), DAS_SLOW_AURA_ID) > 0)) then
        UnitRemoveAbility(target, DAS_SLOW_AURA_ID)
    end
end

-- Original JASS function: DAS_StopTracking (line 14388)
function DAS_StopTracking(target)
    local t = nil
    if (target == nil) then
        do return end
    end
    t = LoadTimerHandle(DAS_Hash, GetHandleId(target), DAS_KEY_TRACK_TIMER)
    if (t ~= nil) then
        PauseTimer(t)
        FlushChildHashtable(DAS_Hash, GetHandleId(t))
        DestroyTimer(t)
        RemoveSavedHandle(DAS_Hash, GetHandleId(target), DAS_KEY_TRACK_TIMER)
    end
    t = nil
end

-- Original JASS function: DAS_TrackLoop (line 14407)
function DAS_TrackLoop()
    local t = GetExpiredTimer()
    local target = LoadUnitHandle(DAS_Hash, GetHandleId(t), DAS_KEY_TIMER_TARGET)
    local dustOwner = LoadPlayerHandle(DAS_Hash, GetHandleId(t), DAS_KEY_TIMER_OWNER)
    local hasDust = false
    local isInvisible = false
    if (target == nil) then
        PauseTimer(t)
        FlushChildHashtable(DAS_Hash, GetHandleId(t))
        DestroyTimer(t)
        t = nil
        dustOwner = nil
        do return end
    end
    if (GetWidgetLife(target) <= __jreal(0.405)) then
        DAS_RemoveSlowAura(target)
        DAS_StopTracking(target)
        t = nil
        target = nil
        dustOwner = nil
        do return end
    end
    hasDust = (GetUnitAbilityLevel(target, DAS_DUST_BUFF_ID) > 0)
    isInvisible = DAS_TargetCountsAsInvisible(target, dustOwner)
    if (not hasDust) then
        if ((GetUnitAbilityLevel((target), DAS_SLOW_AURA_ID) > 0)) then
            DAS_RemoveSlowAura(target)
        end
        DAS_StopTracking(target)
    elseif isInvisible then
        if (not ((GetUnitAbilityLevel((target), DAS_SLOW_AURA_ID) > 0))) then
            DAS_AddSlowAura(target)
        end
    else
        if (((GetUnitAbilityLevel((target), DAS_SLOW_AURA_ID) > 0)) and (not isInvisible)) then
            DAS_RemoveSlowAura(target)
        end
    end
    t = nil
    target = nil
    dustOwner = nil
end

-- Original JASS function: DAS_StartTracking (line 14456)
function DAS_StartTracking(target, dustOwner)
    local t = nil
    if (target == nil) then
        do return end
    end
    t = LoadTimerHandle(DAS_Hash, GetHandleId(target), DAS_KEY_TRACK_TIMER)
    if (t ~= nil) then
        SavePlayerHandle(DAS_Hash, GetHandleId(t), DAS_KEY_TIMER_OWNER, dustOwner)
        t = nil
        do return end
    end
    t = CreateTimer()
    SaveTimerHandle(DAS_Hash, GetHandleId(target), DAS_KEY_TRACK_TIMER, t)
    SaveUnitHandle(DAS_Hash, GetHandleId(t), DAS_KEY_TIMER_TARGET, target)
    SavePlayerHandle(DAS_Hash, GetHandleId(t), DAS_KEY_TIMER_OWNER, dustOwner)
    TimerStart(t, DAS_PERIOD, true, DAS_TrackLoop)
    t = nil
end

-- Original JASS function: DAS_EnumDustTargets (line 14480)
function DAS_EnumDustTargets()
    local target = GetEnumUnit()
    if ((((target ~= nil) and (GetWidgetLife(target) > __jreal(0.405))) and IsUnitEnemy(target, DAS_EnumOwner)) and (not IsUnitType(target, UNIT_TYPE_STRUCTURE))) then
        DAS_StartTracking(target, DAS_EnumOwner)
    end
    target = nil
end

-- Original JASS function: DAS_OnCast_Condition (line 14490)
function DAS_OnCast_Condition()
    do return (GetSpellAbilityId() == DAS_DUST_CAST_ABILITY_ID) end
end

-- Original JASS function: DAS_OnCast_Action (line 14494)
function DAS_OnCast_Action()
    local caster = GetTriggerUnit()
    local x = GetUnitX(caster)
    local y = GetUnitY(caster)
    DAS_EnumOwner = GetOwningPlayer(caster)
    GroupEnumUnitsInRange(DAS_EnumGroup, x, y, DAS_RADIUS, nil)
    ForGroup(DAS_EnumGroup, DAS_EnumDustTargets)
    GroupClear(DAS_EnumGroup)
    DAS_EnumOwner = nil
    caster = nil
end

-- Original JASS function: InitTrig_Dusts_Slow (line 14509)
function InitTrig_Dusts_Slow()
    local t = CreateTrigger()
    local i = 0
    DAS_InitInvisBuffs()
    while true do
        if (i >= bj_MAX_PLAYER_SLOTS) then break end
        TriggerRegisterPlayerUnitEvent(t, Player(i), EVENT_PLAYER_UNIT_SPELL_EFFECT, nil)
        i = __jint(i + 1)
    end
    TriggerAddCondition(t, Condition(DAS_OnCast_Condition))
    TriggerAddAction(t, DAS_OnCast_Action)
    t = nil
end
-- END FOREST SECTION 223

-- BEGIN FOREST SECTION 224 Firelords_Cape_usage
-- Original JASS function: Trig_Firelords_Cape_usage_Conditions (line 14529)
function Trig_Firelords_Cape_usage_Conditions()
    if ((not ((GetItemTypeId(GetManipulatedItem()) == FourCC("I01T"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Firelords_Cape_usage_Actions (line 14536)
function Trig_Firelords_Cape_usage_Actions()
    SetUnitLifePercentBJ(GetTriggerUnit(), (__jreal(GetUnitLifePercent(GetTriggerUnit()) + (__jreal(__jreal(0.20) * (__jreal(__jreal(100.00) - GetUnitLifePercent(GetTriggerUnit()))))))))
end

-- Original JASS function: InitTrig_Firelords_Cape_usage (line 14541)
function InitTrig_Firelords_Cape_usage()
    gg_trg_Firelords_Cape_usage = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Firelords_Cape_usage, EVENT_PLAYER_UNIT_USE_ITEM)
    TriggerAddCondition(gg_trg_Firelords_Cape_usage, Condition(Trig_Firelords_Cape_usage_Conditions))
    TriggerAddAction(gg_trg_Firelords_Cape_usage, Trig_Firelords_Cape_usage_Actions)
end
-- END FOREST SECTION 224

-- BEGIN FOREST SECTION 225 Firelords_Cape_pickup
-- Original JASS function: Trig_Firelords_Cape_pickup_Conditions (line 14551)
function Trig_Firelords_Cape_pickup_Conditions()
    if ((not ((GetItemTypeId(GetManipulatedItem()) == FourCC("I01T"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Firelords_Cape_pickup_Actions (line 14558)
function Trig_Firelords_Cape_pickup_Actions()
    BlzItemAddAbilityBJ(GetManipulatedItem(), FourCC("AIms"))
    BlzItemAddAbilityBJ(GetManipulatedItem(), FourCC("AId0"))
end

-- Original JASS function: InitTrig_Firelords_Cape_pickup (line 14564)
function InitTrig_Firelords_Cape_pickup()
    gg_trg_Firelords_Cape_pickup = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Firelords_Cape_pickup, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    TriggerAddCondition(gg_trg_Firelords_Cape_pickup, Condition(Trig_Firelords_Cape_pickup_Conditions))
    TriggerAddAction(gg_trg_Firelords_Cape_pickup, Trig_Firelords_Cape_pickup_Actions)
end
-- END FOREST SECTION 225

-- BEGIN FOREST SECTION 226 Bladed_Gauntlet_vs_Hero
-- Original JASS function: Trig_Bladed_Gauntlet_vs_Hero_Func002001 (line 14574)
function Trig_Bladed_Gauntlet_vs_Hero_Func002001()
    do return ((UnitHasItemOfTypeBJ(udg_DamageEventSource, FourCC("I00F")) == true)) end
end

-- Original JASS function: Trig_Bladed_Gauntlet_vs_Hero_Func002002 (line 14578)
function Trig_Bladed_Gauntlet_vs_Hero_Func002002()
    do return ((UnitHasItemOfTypeBJ(udg_DamageEventSource, FourCC("I01L")) == true)) end
end

-- Original JASS function: Trig_Bladed_Gauntlet_vs_Hero_Conditions (line 14582)
function Trig_Bladed_Gauntlet_vs_Hero_Conditions()
    if ((not GetBooleanOr(((UnitHasItemOfTypeBJ(udg_DamageEventSource, FourCC("I00F")) == true)), ((UnitHasItemOfTypeBJ(udg_DamageEventSource, FourCC("I01L")) == true))))) then
        do return false end
    end
    if ((not ((udg_IsDamageAttack == true)))) then
        do return false end
    end
    if ((not ((IsUnitType(udg_DamageEventTarget, UNIT_TYPE_HERO) == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Bladed_Gauntlet_vs_Hero_Actions (line 14595)
function Trig_Bladed_Gauntlet_vs_Hero_Actions()
    UnitDamageTargetBJ(udg_DamageEventSource, udg_DamageEventTarget, __jreal(100.00), ATTACK_TYPE_HERO, DAMAGE_TYPE_NORMAL)
end

-- Original JASS function: InitTrig_Bladed_Gauntlet_vs_Hero (line 14600)
function InitTrig_Bladed_Gauntlet_vs_Hero()
    gg_trg_Bladed_Gauntlet_vs_Hero = CreateTrigger()
    h__TriggerRegisterVariableEvent(gg_trg_Bladed_Gauntlet_vs_Hero, "udg_DamageEvent", EQUAL, __jreal(1.00))
    TriggerAddCondition(gg_trg_Bladed_Gauntlet_vs_Hero, Condition(Trig_Bladed_Gauntlet_vs_Hero_Conditions))
    TriggerAddAction(gg_trg_Bladed_Gauntlet_vs_Hero, Trig_Bladed_Gauntlet_vs_Hero_Actions)
end
-- END FOREST SECTION 226

-- BEGIN FOREST SECTION 227 Cast_CL_on_Banish
-- Original JASS function: Trig_Cast_CL_on_Banish_Conditions (line 14610)
function Trig_Cast_CL_on_Banish_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A094"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Cast_CL_on_Banish_Actions (line 14617)
function Trig_Cast_CL_on_Banish_Actions()
    udg_Temp_Point = GetUnitLoc(GetSpellAbilityUnit())
    CreateNUnitsAtLocFacingLocBJ(1, FourCC("h04L"), GetOwningPlayer(GetSpellAbilityUnit()), udg_Temp_Point, udg_Temp_Point)
    UnitApplyTimedLifeBJ(__jreal(0.50), FourCC("BTLF"), GetLastCreatedUnit())
    IssueTargetOrderBJ(GetLastCreatedUnit(), "chainlightning", GetSpellTargetUnit())
    RemoveLocation(udg_Temp_Point)
end

-- Original JASS function: InitTrig_Cast_CL_on_Banish (line 14626)
function InitTrig_Cast_CL_on_Banish()
    gg_trg_Cast_CL_on_Banish = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Cast_CL_on_Banish, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Cast_CL_on_Banish, Condition(Trig_Cast_CL_on_Banish_Conditions))
    TriggerAddAction(gg_trg_Cast_CL_on_Banish, Trig_Cast_CL_on_Banish_Actions)
end
-- END FOREST SECTION 227

-- BEGIN FOREST SECTION 228 Ledgers_XP
-- Original JASS function: Trig_Ledgers_XP_Func001Func001C (line 14636)
function Trig_Ledgers_XP_Func001Func001C()
    if ((not ((UnitHasItemOfTypeBJ(udg_Ledger, FourCC("I01J")) == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Ledgers_XP_Func001C (line 14643)
function Trig_Ledgers_XP_Func001C()
    if ((not ((UnitHasItemOfTypeBJ(udg_Ledger, FourCC("I01N")) == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Ledgers_XP_Actions (line 14650)
function Trig_Ledgers_XP_Actions()
    FE_Ledgers.tick()
end

-- Original JASS function: InitTrig_Ledgers_XP (line 14662)
function InitTrig_Ledgers_XP()
    gg_trg_Ledgers_XP = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(gg_trg_Ledgers_XP, __jreal(1.00))
    TriggerAddAction(gg_trg_Ledgers_XP, Trig_Ledgers_XP_Actions)
end
-- END FOREST SECTION 228

-- BEGIN FOREST SECTION 229 Ledger_of_Clarity_pickup
-- Original JASS function: Trig_Ledger_of_Clarity_pickup_Conditions (line 14671)
function Trig_Ledger_of_Clarity_pickup_Conditions()
    if ((not ((GetItemTypeId(GetManipulatedItem()) == FourCC("I01J"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Ledger_of_Clarity_pickup_Actions (line 14678)
function Trig_Ledger_of_Clarity_pickup_Actions()
    FE_Ledgers.watch(GetManipulatingUnit())
end

-- Original JASS function: InitTrig_Ledger_of_Clarity_pickup (line 14684)
function InitTrig_Ledger_of_Clarity_pickup()
    gg_trg_Ledger_of_Clarity_pickup = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Ledger_of_Clarity_pickup, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    TriggerAddCondition(gg_trg_Ledger_of_Clarity_pickup, Condition(Trig_Ledger_of_Clarity_pickup_Conditions))
    TriggerAddAction(gg_trg_Ledger_of_Clarity_pickup, Trig_Ledger_of_Clarity_pickup_Actions)
end
-- END FOREST SECTION 229

-- BEGIN FOREST SECTION 230 Ledger_of_Clarity_lose
-- Original JASS function: Trig_Ledger_of_Clarity_lose_Conditions (line 14694)
function Trig_Ledger_of_Clarity_lose_Conditions()
    if ((not ((GetItemTypeId(GetManipulatedItem()) == FourCC("I01J"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Ledger_of_Clarity_lose_Actions (line 14701)
function Trig_Ledger_of_Clarity_lose_Actions()
    FE_Ledgers.watch(GetManipulatingUnit())
end

-- Original JASS function: InitTrig_Ledger_of_Clarity_lose (line 14706)
function InitTrig_Ledger_of_Clarity_lose()
    gg_trg_Ledger_of_Clarity_lose = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Ledger_of_Clarity_lose, EVENT_PLAYER_UNIT_DROP_ITEM)
    TriggerAddCondition(gg_trg_Ledger_of_Clarity_lose, Condition(Trig_Ledger_of_Clarity_lose_Conditions))
    TriggerAddAction(gg_trg_Ledger_of_Clarity_lose, Trig_Ledger_of_Clarity_lose_Actions)
end
-- END FOREST SECTION 230

-- BEGIN FOREST SECTION 231 Ledger_of_Enlightment_pickup
-- Original JASS function: Trig_Ledger_of_Enlightment_pickup_Conditions (line 14716)
function Trig_Ledger_of_Enlightment_pickup_Conditions()
    if ((not ((GetItemTypeId(GetManipulatedItem()) == FourCC("I01N"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Ledger_of_Enlightment_pickup_Actions (line 14723)
function Trig_Ledger_of_Enlightment_pickup_Actions()
    FE_Ledgers.watch(GetManipulatingUnit())
end

-- Original JASS function: InitTrig_Ledger_of_Enlightment_pickup (line 14729)
function InitTrig_Ledger_of_Enlightment_pickup()
    gg_trg_Ledger_of_Enlightment_pickup = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Ledger_of_Enlightment_pickup, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    TriggerAddCondition(gg_trg_Ledger_of_Enlightment_pickup, Condition(Trig_Ledger_of_Enlightment_pickup_Conditions))
    TriggerAddAction(gg_trg_Ledger_of_Enlightment_pickup, Trig_Ledger_of_Enlightment_pickup_Actions)
end
-- END FOREST SECTION 231

-- BEGIN FOREST SECTION 232 Ledger_of_Enlightment_lose
-- Original JASS function: Trig_Ledger_of_Enlightment_lose_Conditions (line 14739)
function Trig_Ledger_of_Enlightment_lose_Conditions()
    if ((not ((GetItemTypeId(GetManipulatedItem()) == FourCC("I01N"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Ledger_of_Enlightment_lose_Actions (line 14746)
function Trig_Ledger_of_Enlightment_lose_Actions()
    FE_Ledgers.watch(GetManipulatingUnit())
end

-- Original JASS function: InitTrig_Ledger_of_Enlightment_lose (line 14751)
function InitTrig_Ledger_of_Enlightment_lose()
    gg_trg_Ledger_of_Enlightment_lose = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Ledger_of_Enlightment_lose, EVENT_PLAYER_UNIT_DROP_ITEM)
    TriggerAddCondition(gg_trg_Ledger_of_Enlightment_lose, Condition(Trig_Ledger_of_Enlightment_lose_Conditions))
    TriggerAddAction(gg_trg_Ledger_of_Enlightment_lose, Trig_Ledger_of_Enlightment_lose_Actions)
end
-- END FOREST SECTION 232

-- BEGIN FOREST SECTION 233 Spellcasters_Cloak
-- Original JASS function: Trig_Spellcasters_Cloak_Conditions (line 14761)
function Trig_Spellcasters_Cloak_Conditions()
    return FE_Recipes.canCombineOwned(GetTriggerUnit(), FourCC('I01R'))
end

-- Original JASS function: Trig_Spellcasters_Cloak_Actions (line 14777)
function Trig_Spellcasters_Cloak_Actions()
    FE_Recipes.combineOwned(GetTriggerUnit(), FourCC('I01R'))
end

-- Original JASS function: InitTrig_Spellcasters_Cloak (line 14786)
function InitTrig_Spellcasters_Cloak()
    gg_trg_Spellcasters_Cloak = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Spellcasters_Cloak, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    TriggerAddCondition(gg_trg_Spellcasters_Cloak, Condition(Trig_Spellcasters_Cloak_Conditions))
    TriggerAddAction(gg_trg_Spellcasters_Cloak, Trig_Spellcasters_Cloak_Actions)
end
-- END FOREST SECTION 233

-- BEGIN FOREST SECTION 234 Ethereal_Scepter
-- Original JASS function: Trig_Ethereal_Scepter_Conditions (line 14796)
function Trig_Ethereal_Scepter_Conditions()
    return FE_Recipes.canCombineOwned(GetTriggerUnit(), FourCC('I01P'))
end

-- Original JASS function: Trig_Ethereal_Scepter_Actions (line 14809)
function Trig_Ethereal_Scepter_Actions()
    FE_Recipes.combineOwned(GetTriggerUnit(), FourCC('I01P'))
end

-- Original JASS function: InitTrig_Ethereal_Scepter (line 14817)
function InitTrig_Ethereal_Scepter()
    gg_trg_Ethereal_Scepter = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Ethereal_Scepter, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    TriggerAddCondition(gg_trg_Ethereal_Scepter, Condition(Trig_Ethereal_Scepter_Conditions))
    TriggerAddAction(gg_trg_Ethereal_Scepter, Trig_Ethereal_Scepter_Actions)
end
-- END FOREST SECTION 234

-- BEGIN FOREST SECTION 235 Firelords_Cape
-- Original JASS function: Trig_Firelords_Cape_Conditions (line 14827)
function Trig_Firelords_Cape_Conditions()
    return FE_Recipes.canCombineOwned(GetTriggerUnit(), FourCC('I01T'))
end

-- Original JASS function: Trig_Firelords_Cape_Actions (line 14840)
function Trig_Firelords_Cape_Actions()
    FE_Recipes.combineOwned(GetTriggerUnit(), FourCC('I01T'))
end

-- Original JASS function: InitTrig_Firelords_Cape (line 14848)
function InitTrig_Firelords_Cape()
    gg_trg_Firelords_Cape = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Firelords_Cape, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    TriggerAddCondition(gg_trg_Firelords_Cape, Condition(Trig_Firelords_Cape_Conditions))
    TriggerAddAction(gg_trg_Firelords_Cape, Trig_Firelords_Cape_Actions)
end
-- END FOREST SECTION 235

-- BEGIN FOREST SECTION 236 Ledget_of_Enlightment
-- Original JASS function: Trig_Ledget_of_Enlightment_Func002Func001C (line 14858)
function Trig_Ledget_of_Enlightment_Func002Func001C()
    if ((not ((GetItemTypeId(UnitItemInSlotBJ(GetTriggerUnit(), GetForLoopIndexA())) == FourCC("I01J"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Ledget_of_Enlightment_Actions (line 14865)
function Trig_Ledget_of_Enlightment_Actions()
    FE_Recipes.combineOwned(GetTriggerUnit(), FourCC('I01N'))
end

-- Original JASS function: InitTrig_Ledget_of_Enlightment (line 14890)
function InitTrig_Ledget_of_Enlightment()
    gg_trg_Ledget_of_Enlightment = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Ledget_of_Enlightment, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    TriggerAddAction(gg_trg_Ledget_of_Enlightment, Trig_Ledget_of_Enlightment_Actions)
end
-- END FOREST SECTION 236

-- BEGIN FOREST SECTION 237 Hammer_of_might
-- Original JASS function: Trig_Hammer_of_might_Conditions (line 14899)
function Trig_Hammer_of_might_Conditions()
    return FE_Recipes.canCombineOwned(GetTriggerUnit(), FourCC('I01L'))
end

-- Original JASS function: Trig_Hammer_of_might_Actions (line 14912)
function Trig_Hammer_of_might_Actions()
    FE_Recipes.combineOwned(GetTriggerUnit(), FourCC('I01L'))
end

-- Original JASS function: InitTrig_Hammer_of_might (line 14920)
function InitTrig_Hammer_of_might()
    gg_trg_Hammer_of_might = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Hammer_of_might, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    TriggerAddCondition(gg_trg_Hammer_of_might, Condition(Trig_Hammer_of_might_Conditions))
    TriggerAddAction(gg_trg_Hammer_of_might, Trig_Hammer_of_might_Actions)
end
-- END FOREST SECTION 237

-- BEGIN FOREST SECTION 238 Valorous_Helmet
-- Original JASS function: Trig_Valorous_Helmet_Conditions (line 14930)
function Trig_Valorous_Helmet_Conditions()
    return FE_Recipes.canCombineOwned(GetTriggerUnit(), FourCC('I00I'))
end

-- Original JASS function: Trig_Valorous_Helmet_Actions (line 14943)
function Trig_Valorous_Helmet_Actions()
    FE_Recipes.combineOwned(GetTriggerUnit(), FourCC('I00I'))
end

-- Original JASS function: InitTrig_Valorous_Helmet (line 14951)
function InitTrig_Valorous_Helmet()
    gg_trg_Valorous_Helmet = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Valorous_Helmet, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    TriggerAddCondition(gg_trg_Valorous_Helmet, Condition(Trig_Valorous_Helmet_Conditions))
    TriggerAddAction(gg_trg_Valorous_Helmet, Trig_Valorous_Helmet_Actions)
end
-- END FOREST SECTION 238

-- BEGIN FOREST SECTION 239 Bladed_Gauntlet
-- Original JASS function: Trig_Bladed_Gauntlet_Conditions (line 14961)
function Trig_Bladed_Gauntlet_Conditions()
    return FE_Recipes.canCombineOwned(GetTriggerUnit(), FourCC('I00F'))
end

-- Original JASS function: Trig_Bladed_Gauntlet_Actions (line 14974)
function Trig_Bladed_Gauntlet_Actions()
    FE_Recipes.combineOwned(GetTriggerUnit(), FourCC('I00F'))
end

-- Original JASS function: InitTrig_Bladed_Gauntlet (line 14982)
function InitTrig_Bladed_Gauntlet()
    gg_trg_Bladed_Gauntlet = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Bladed_Gauntlet, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    TriggerAddCondition(gg_trg_Bladed_Gauntlet, Condition(Trig_Bladed_Gauntlet_Conditions))
    TriggerAddAction(gg_trg_Bladed_Gauntlet, Trig_Bladed_Gauntlet_Actions)
end
-- END FOREST SECTION 239

-- BEGIN FOREST SECTION 240 Righteous_Armor
-- Original JASS function: Trig_Righteous_Armor_Conditions (line 14992)
function Trig_Righteous_Armor_Conditions()
    return FE_Recipes.canCombineOwned(GetTriggerUnit(), FourCC('I012'))
end

-- Original JASS function: Trig_Righteous_Armor_Actions (line 15008)
function Trig_Righteous_Armor_Actions()
    FE_Recipes.combineOwned(GetTriggerUnit(), FourCC('I012'))
end

-- Original JASS function: InitTrig_Righteous_Armor (line 15017)
function InitTrig_Righteous_Armor()
    gg_trg_Righteous_Armor = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Righteous_Armor, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    TriggerAddCondition(gg_trg_Righteous_Armor, Condition(Trig_Righteous_Armor_Conditions))
    TriggerAddAction(gg_trg_Righteous_Armor, Trig_Righteous_Armor_Actions)
end
-- END FOREST SECTION 240

-- BEGIN FOREST SECTION 241 Arcanum_of_Hatred
-- Original JASS function: Trig_Arcanum_of_Hatred_Conditions (line 15027)
function Trig_Arcanum_of_Hatred_Conditions()
    return FE_Recipes.canCombineOwned(GetTriggerUnit(), FourCC('I015'))
end

-- Original JASS function: Trig_Arcanum_of_Hatred_Actions (line 15040)
function Trig_Arcanum_of_Hatred_Actions()
    FE_Recipes.combineOwned(GetTriggerUnit(), FourCC('I015'))
end

-- Original JASS function: InitTrig_Arcanum_of_Hatred (line 15048)
function InitTrig_Arcanum_of_Hatred()
    gg_trg_Arcanum_of_Hatred = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Arcanum_of_Hatred, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    TriggerAddCondition(gg_trg_Arcanum_of_Hatred, Condition(Trig_Arcanum_of_Hatred_Conditions))
    TriggerAddAction(gg_trg_Arcanum_of_Hatred, Trig_Arcanum_of_Hatred_Actions)
end
-- END FOREST SECTION 241

-- BEGIN FOREST SECTION 242 Bleeding_Scythe
-- Original JASS function: Trig_Bleeding_Scythe_Conditions (line 15058)
function Trig_Bleeding_Scythe_Conditions()
    return FE_Recipes.canCombineOwned(GetTriggerUnit(), FourCC('I017'))
end

-- Original JASS function: Trig_Bleeding_Scythe_Actions (line 15071)
function Trig_Bleeding_Scythe_Actions()
    FE_Recipes.combineOwned(GetTriggerUnit(), FourCC('I017'))
end

-- Original JASS function: InitTrig_Bleeding_Scythe (line 15079)
function InitTrig_Bleeding_Scythe()
    gg_trg_Bleeding_Scythe = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Bleeding_Scythe, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    TriggerAddCondition(gg_trg_Bleeding_Scythe, Condition(Trig_Bleeding_Scythe_Conditions))
    TriggerAddAction(gg_trg_Bleeding_Scythe, Trig_Bleeding_Scythe_Actions)
end
-- END FOREST SECTION 242

-- BEGIN FOREST SECTION 243 Staff_of_Insight
-- Original JASS function: Trig_Staff_of_Insight_Conditions (line 15089)
function Trig_Staff_of_Insight_Conditions()
    return FE_Recipes.canCombineOwned(GetTriggerUnit(), FourCC('I01C'))
end

-- Original JASS function: Trig_Staff_of_Insight_Actions (line 15102)
function Trig_Staff_of_Insight_Actions()
    FE_Recipes.combineOwned(GetTriggerUnit(), FourCC('I01C'))
end

-- Original JASS function: InitTrig_Staff_of_Insight (line 15110)
function InitTrig_Staff_of_Insight()
    gg_trg_Staff_of_Insight = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Staff_of_Insight, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    TriggerAddCondition(gg_trg_Staff_of_Insight, Condition(Trig_Staff_of_Insight_Conditions))
    TriggerAddAction(gg_trg_Staff_of_Insight, Trig_Staff_of_Insight_Actions)
end
-- END FOREST SECTION 243

-- BEGIN FOREST SECTION 244 Cosmic_Orb
-- Original JASS function: Trig_Cosmic_Orb_Conditions (line 15120)
function Trig_Cosmic_Orb_Conditions()
    return FE_Recipes.canCombineOwned(GetTriggerUnit(), FourCC('I019'))
end

-- Original JASS function: Trig_Cosmic_Orb_Actions (line 15136)
function Trig_Cosmic_Orb_Actions()
    FE_Recipes.combineOwned(GetTriggerUnit(), FourCC('I019'))
end

-- Original JASS function: InitTrig_Cosmic_Orb (line 15145)
function InitTrig_Cosmic_Orb()
    gg_trg_Cosmic_Orb = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Cosmic_Orb, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    TriggerAddCondition(gg_trg_Cosmic_Orb, Condition(Trig_Cosmic_Orb_Conditions))
    TriggerAddAction(gg_trg_Cosmic_Orb, Trig_Cosmic_Orb_Actions)
end
-- END FOREST SECTION 244

-- BEGIN FOREST SECTION 245 Level_up
-- Original JASS function: Trig_Level_up_Conditions (line 15155)
function Trig_Level_up_Conditions()
    if ((not ((GetOwningPlayer(GetTriggerUnit()) == FE_Roles.ancient())))) then
        do return false end
    end
    if ((not ((GetItemTypeId(GetManipulatedItem()) == FourCC("I00J"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Level_up_Actions (line 15165)
function Trig_Level_up_Actions()
    RemoveItem(GetManipulatedItem())
    UnitAddItemByIdSwapped(FourCC("tkno"), GetTriggerUnit())
end

-- Original JASS function: InitTrig_Level_up (line 15171)
function InitTrig_Level_up()
    gg_trg_Level_up = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Level_up, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    TriggerAddCondition(gg_trg_Level_up, Condition(Trig_Level_up_Conditions))
    TriggerAddAction(gg_trg_Level_up, Trig_Level_up_Actions)
end
-- END FOREST SECTION 245
-- END FOREST MODULE src/items/effects.lua

-- BEGIN FOREST MODULE src/economy/income.lua
-- economy / income
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 246 Deliver_Gold
-- Original JASS function: Trig_Deliver_Gold_Actions (line 15181)
function Trig_Deliver_Gold_Actions()
    FE_Roles.forEachPlayer(function(player)
        local gold = FE_Roles.isAncient(player) and 1040 or 1
        AdjustPlayerStateBJ(gold, player, PLAYER_STATE_RESOURCE_GOLD)
    end)
end

-- Original JASS function: InitTrig_Deliver_Gold (line 15196)
function InitTrig_Deliver_Gold()
    gg_trg_Deliver_Gold = CreateTrigger()
    TriggerAddAction(gg_trg_Deliver_Gold, Trig_Deliver_Gold_Actions)
end
-- END FOREST SECTION 246

-- BEGIN FOREST SECTION 247 Worgens_gold
-- Original JASS function: Trig_Worgens_gold_Conditions (line 15204)
function Trig_Worgens_gold_Conditions()
    if ((not ((GetUnitTypeId(udg_DamageEventTarget) == FourCC("h00Q"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Worgens_gold_Func004C (line 15211)
function Trig_Worgens_gold_Func004C()
    if ((not ((GetUnitTypeId(udg_DamageEventSource) == FourCC("h00R"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Worgens_gold_Actions (line 15218)
function Trig_Worgens_gold_Actions()
    AdjustPlayerStateBJ(1, GetOwningPlayer(GetEventDamageSource()), PLAYER_STATE_RESOURCE_GOLD)
    AddSpecialEffectLocBJ(GetUnitLoc(gg_unit_h00Q_0026), "UI\\Feedback\\GoldCredit\\GoldCredit.mdl")
    DestroyEffectBJ(GetLastCreatedEffectBJ())
    if (Trig_Worgens_gold_Func004C()) then
        AdjustPlayerStateBJ(1, GetOwningPlayer(GetEventDamageSource()), PLAYER_STATE_RESOURCE_GOLD)
    else
    end
end

-- Original JASS function: InitTrig_Worgens_gold (line 15229)
function InitTrig_Worgens_gold()
    gg_trg_Worgens_gold = CreateTrigger()
    h__TriggerRegisterVariableEvent(gg_trg_Worgens_gold, "udg_DamageEvent", EQUAL, __jreal(1.00))
    TriggerAddCondition(gg_trg_Worgens_gold, Condition(Trig_Worgens_gold_Conditions))
    TriggerAddAction(gg_trg_Worgens_gold, Trig_Worgens_gold_Actions)
end
-- END FOREST SECTION 247

-- BEGIN FOREST SECTION 248 Bounty
-- Original JASS function: Trig_Bounty_Func001A (line 15239)
function Trig_Bounty_Func001A()
    SetPlayerFlagBJ(PLAYER_STATE_GIVES_BOUNTY, true, Player(0))
    SetPlayerFlagBJ(PLAYER_STATE_GIVES_BOUNTY, true, Player(1))
    SetPlayerFlagBJ(PLAYER_STATE_GIVES_BOUNTY, true, Player(2))
    SetPlayerFlagBJ(PLAYER_STATE_GIVES_BOUNTY, true, Player(3))
    SetPlayerFlagBJ(PLAYER_STATE_GIVES_BOUNTY, true, Player(4))
    SetPlayerFlagBJ(PLAYER_STATE_GIVES_BOUNTY, true, Player(5))
    SetPlayerFlagBJ(PLAYER_STATE_GIVES_BOUNTY, true, Player(6))
    SetPlayerFlagBJ(PLAYER_STATE_GIVES_BOUNTY, true, Player(7))
    SetPlayerFlagBJ(PLAYER_STATE_GIVES_BOUNTY, true, Player(8))
    SetPlayerFlagBJ(PLAYER_STATE_GIVES_BOUNTY, true, Player(9))
    SetPlayerFlagBJ(PLAYER_STATE_GIVES_BOUNTY, true, Player(10))
end

-- Original JASS function: Trig_Bounty_Actions (line 15253)
function Trig_Bounty_Actions()
    ForForce(GetPlayersAll(), Trig_Bounty_Func001A)
end

-- Original JASS function: InitTrig_Bounty (line 15258)
function InitTrig_Bounty()
    gg_trg_Bounty = CreateTrigger()
    TriggerAddAction(gg_trg_Bounty, Trig_Bounty_Actions)
end
-- END FOREST SECTION 248

-- BEGIN FOREST SECTION 249 Remove_Ancient_Lumber
-- Original JASS function: Trig_Remove_Ancient_Lumber_Conditions (line 15266)
function Trig_Remove_Ancient_Lumber_Conditions()
    if ((not ((GetItemTypeId(GetManipulatedItem()) == FourCC("I01F"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Remove_Ancient_Lumber_Actions (line 15273)
function Trig_Remove_Ancient_Lumber_Actions()
    SetPlayerStateBJ(FE_Roles.ancient(), PLAYER_STATE_RESOURCE_LUMBER, (__jint(GetPlayerState(FE_Roles.ancient(), PLAYER_STATE_RESOURCE_LUMBER) - 500)))
end

-- Original JASS function: InitTrig_Remove_Ancient_Lumber (line 15278)
function InitTrig_Remove_Ancient_Lumber()
    gg_trg_Remove_Ancient_Lumber = CreateTrigger()
    FE_Roles.registerAncientUnitEvent(gg_trg_Remove_Ancient_Lumber, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    TriggerAddCondition(gg_trg_Remove_Ancient_Lumber, Condition(Trig_Remove_Ancient_Lumber_Conditions))
    TriggerAddAction(gg_trg_Remove_Ancient_Lumber, Trig_Remove_Ancient_Lumber_Actions)
end
-- END FOREST SECTION 249

-- BEGIN FOREST SECTION 250 Ancient_Gold_income
-- Original JASS function: Trig_Ancient_Gold_income_Actions (line 15288)
function Trig_Ancient_Gold_income_Actions()
    AdjustPlayerStateBJ(10, FE_Roles.ancient(), PLAYER_STATE_RESOURCE_GOLD)
end

-- Original JASS function: InitTrig_Ancient_Gold_income (line 15293)
function InitTrig_Ancient_Gold_income()
    gg_trg_Ancient_Gold_income = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(gg_trg_Ancient_Gold_income, __jreal(10.00))
    TriggerAddAction(gg_trg_Ancient_Gold_income, Trig_Ancient_Gold_income_Actions)
end
-- END FOREST SECTION 250
-- END FOREST MODULE src/economy/income.lua

-- BEGIN FOREST MODULE src/game/startup.lua
-- game / startup
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 251 Initialization
-- Original JASS function: Trig_Initialization_Func002002 (line 15302)
function Trig_Initialization_Func002002()
    SetCameraBoundsToRectForPlayerBJ(GetEnumPlayer(), gg_rct_Camera_1)
end

-- Original JASS function: Trig_Initialization_Actions (line 15306)
function Trig_Initialization_Actions()
    SetCreepCampFilterState(false)
    ForForce(GetPlayersAll(), Trig_Initialization_Func002002)
end

-- Original JASS function: InitTrig_Initialization (line 15312)
function InitTrig_Initialization()
    gg_trg_Initialization = CreateTrigger()
    TriggerAddAction(gg_trg_Initialization, Trig_Initialization_Actions)
end
-- END FOREST SECTION 251

-- BEGIN FOREST SECTION 252 LimitedTraining
-- Original JASS function: Trig_LimitedTraining_Func002A (line 15320)
function Trig_LimitedTraining_Func002A()
    SetPlayerTechMaxAllowedSwap(FourCC("h03A"), 1, GetEnumPlayer())
    SetPlayerTechMaxAllowedSwap(FourCC("u00E"), 1, GetEnumPlayer())
    SetPlayerTechMaxAllowedSwap(FourCC("n006"), 1, GetEnumPlayer())
    SetPlayerTechMaxAllowedSwap(FourCC("n007"), 1, GetEnumPlayer())
    SetPlayerTechMaxAllowedSwap(FourCC("h05L"), 1, GetEnumPlayer())
    SetPlayerTechMaxAllowedSwap(FourCC("E00T"), 1, GetEnumPlayer())
    SetPlayerTechMaxAllowedSwap(FourCC("n00S"), 1, GetEnumPlayer())
end

-- Original JASS function: Trig_LimitedTraining_Actions (line 15330)
function Trig_LimitedTraining_Actions()
    MeleeStartingHeroLimit()
    ForForce(GetPlayersAll(), Trig_LimitedTraining_Func002A)
end

-- Original JASS function: InitTrig_LimitedTraining (line 15336)
function InitTrig_LimitedTraining()
    gg_trg_LimitedTraining = CreateTrigger()
    TriggerAddAction(gg_trg_LimitedTraining, Trig_LimitedTraining_Actions)
end
-- END FOREST SECTION 252

-- BEGIN FOREST SECTION 253 TimeToExpanderSpawn
-- Original JASS function: Trig_TimeToExpanderSpawn_Actions (line 15344)
function Trig_TimeToExpanderSpawn_Actions()
    if FE_Test and FE_Test.skipped then return end
    StartTimerBJ(udg_ExpanderSpawnTimer, false, __jreal(19.00))
    CreateTimerDialogBJ(GetLastCreatedTimerBJ(), "TRIGSTR_7401")
    local dialog = GetLastCreatedTimerDialogBJ()
    if FE_Test and FE_Test.player then FE_Test.countdowns[#FE_Test.countdowns+1]={timer=udg_ExpanderSpawnTimer,dialog=dialog} end
    TriggerSleepAction(__jreal(18.00))
    if FE_Test then FE_Test.releaseCountdown(dialog) end
    DestroyTimerDialogBJ(dialog)
end

-- Original JASS function: InitTrig_TimeToExpanderSpawn (line 15352)
function InitTrig_TimeToExpanderSpawn()
    gg_trg_TimeToExpanderSpawn = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_TimeToExpanderSpawn, __jreal(1.00))
    TriggerAddAction(gg_trg_TimeToExpanderSpawn, Trig_TimeToExpanderSpawn_Actions)
end
-- END FOREST SECTION 253

-- BEGIN FOREST SECTION 254 TimeToAncientSpawn
-- Original JASS function: Trig_TimeToAncientSpawn_Actions (line 15361)
function Trig_TimeToAncientSpawn_Actions()
    if FE_Test and FE_Test.skipped then return end
    StartTimerBJ(udg_AncientSpawnTimer, false, __jreal(40.00))
    CreateTimerDialogBJ(GetLastCreatedTimerBJ(), "TRIGSTR_7400")
    local dialog = GetLastCreatedTimerDialogBJ()
    if FE_Test and FE_Test.player then FE_Test.countdowns[#FE_Test.countdowns+1]={timer=udg_AncientSpawnTimer,dialog=dialog} end
    TriggerSleepAction(__jreal(40.00))
    if FE_Test then FE_Test.releaseCountdown(dialog) end
    DestroyTimerDialogBJ(dialog)
end

-- Original JASS function: InitTrig_TimeToAncientSpawn (line 15369)
function InitTrig_TimeToAncientSpawn()
    gg_trg_TimeToAncientSpawn = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_TimeToAncientSpawn, __jreal(20.00))
    TriggerAddAction(gg_trg_TimeToAncientSpawn, Trig_TimeToAncientSpawn_Actions)
end
-- END FOREST SECTION 254

-- BEGIN FOREST SECTION 255 Unit_Indexer
-- Original JASS function: Trig_Unit_Indexer_Func017Func004C (line 15383)
function Trig_Unit_Indexer_Func017Func004C()
    if ((not ((udg_UDexRecycle == 0)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Unit_Indexer_Func017C (line 15390)
function Trig_Unit_Indexer_Func017C()
    if ((not ((udg_UnitIndexerEnabled == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Unit_Indexer_Func030Func005C (line 15397)
function Trig_Unit_Indexer_Func030Func005C()
    if ((not ((GetUnitUserData(udg_UDexUnits[udg_UDex]) == 0)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Unit_Indexer_Func030C (line 15404)
function Trig_Unit_Indexer_Func030C()
    if ((not ((udg_UDexWasted == 15)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Unit_Indexer_Func034C (line 15411)
function Trig_Unit_Indexer_Func034C()
    if ((not ((GetUnitUserData(GetFilterUnit()) == 0)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Unit_Indexer_Actions (line 15418)
function Trig_Unit_Indexer_Actions()
    ExecuteFunc("InitializeUnitIndexer")
end

-- Original JASS function: IndexUnit (line 15424)
function IndexUnit()
    local pdex = udg_UDex
    if (Trig_Unit_Indexer_Func017C()) then
        if (Trig_Unit_Indexer_Func017Func004C()) then
            udg_UDex = (__jint(udg_UDexGen + 1))
            udg_UDexGen = udg_UDex
        else
            udg_UDex = udg_UDexRecycle
            udg_UDexRecycle = udg_UDexNext[udg_UDex]
        end
        udg_UDexUnits[udg_UDex] = GetFilterUnit()
        SetUnitUserData(udg_UDexUnits[udg_UDex], udg_UDex)
        udg_UDexPrev[udg_UDexNext[0]] = udg_UDex
        udg_UDexNext[udg_UDex] = udg_UDexNext[0]
        udg_UDexNext[0] = udg_UDex
        udg_UnitIndexEvent = __jreal(0.00)
        udg_UnitIndexEvent = __jreal(1.00)
        udg_UnitIndexEvent = __jreal(0.00)
        udg_UDex = pdex
    else
    end
    do return false end
end

-- Original JASS function: IndexNewUnit (line 15471)
function IndexNewUnit()
    local pdex = udg_UDex
    local ndex = 0
    udg_UDexWasted = (__jint(udg_UDexWasted + 1))
    if (Trig_Unit_Indexer_Func030C()) then
        udg_UDexWasted = 0
        udg_UDex = udg_UDexNext[0]
        while true do
            if (udg_UDex == 0) then break end
            if (Trig_Unit_Indexer_Func030Func005C()) then
                ndex = udg_UDexNext[udg_UDex]
                udg_UDexNext[udg_UDexPrev[udg_UDex]] = ndex
                udg_UDexPrev[ndex] = udg_UDexPrev[udg_UDex]
                udg_UDexPrev[udg_UDex] = 0
                udg_UnitIndexEvent = __jreal(2.00)
                udg_UnitIndexEvent = __jreal(0.00)
                udg_UDexUnits[udg_UDex] = nil
                udg_UDexNext[udg_UDex] = udg_UDexRecycle
                udg_UDexRecycle = udg_UDex
                udg_UDex = ndex
            else
                udg_UDex = udg_UDexNext[udg_UDex]
            end
        end
        udg_UDex = pdex
    else
    end
    if (Trig_Unit_Indexer_Func034C()) then
        IndexUnit()
    else
    end
    do return false end
end

-- Original JASS function: InitializeUnitIndexer (line 15522)
function InitializeUnitIndexer()
    local i = 0
    local re = CreateRegion()
    local r = GetWorldBounds()
    udg_UnitIndexerEnabled = true
    RegionAddRect(re, r)
    TriggerRegisterEnterRegion(CreateTrigger(), re, Filter(IndexNewUnit))
    RemoveRect(r)
    re = nil
    r = nil
    while true do
        GroupEnumUnitsOfPlayer(bj_lastCreatedGroup, Player(i), Filter(IndexUnit))
        i = __jint(i + 1)
        if (i == 16) then break end
    end
    udg_UnitIndexEvent = __jreal(3.00)
    udg_UnitIndexEvent = __jreal(0.00)
end

-- Original JASS function: InitTrig_Unit_Indexer (line 15545)
function InitTrig_Unit_Indexer()
    gg_trg_Unit_Indexer = CreateTrigger()
    TriggerAddAction(gg_trg_Unit_Indexer, Trig_Unit_Indexer_Actions)
end
-- END FOREST SECTION 255
-- END FOREST MODULE src/game/startup.lua

-- BEGIN FOREST MODULE src/ui/names.lua
-- ui / names
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 258 Colors
-- Original JASS function: Trig_Colors_Actions (line 15702)
function Trig_Colors_Actions()
    udg_PlayerColorHex[1] = " - |cffff0303"
    udg_PlayerColorHex[2] = " - |cff0042ff"
    udg_PlayerColorHex[3] = " - |cff1ce6b9"
    udg_PlayerColorHex[4] = " - |cff540081"
    udg_PlayerColorHex[5] = " - |cfffffc01"
    udg_PlayerColorHex[6] = " - |cfffe8a0e"
    udg_PlayerColorHex[7] = " - |cff20c000"
    udg_PlayerColorHex[8] = " - |cffe55bb0"
    udg_PlayerColorHex[9] = " - |cff959697"
    udg_PlayerColorHex[10] = " - |cff7ebff1"
    udg_PlayerColorHex[11] = " - |cff106246"
    udg_PlayerColorHex[12] = " - |cff4e2a04"
end

-- Original JASS function: InitTrig_Colors (line 15718)
function InitTrig_Colors()
    gg_trg_Colors = CreateTrigger()
    TriggerAddAction(gg_trg_Colors, Trig_Colors_Actions)
end
-- END FOREST SECTION 258

-- BEGIN FOREST SECTION 259 Name_Change
-- Original JASS function: Trig_Name_Change_Conditions (line 15726)
function Trig_Name_Change_Conditions()
    if ((not (((GetUnitTypeId(GetTriggerUnit()) == FourCC("nmer")) or (GetUnitTypeId(GetTriggerUnit()) == FourCC("n00G")))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: GetPlayerNameWithoutTag (line 15733)
function GetPlayerNameWithoutTag(p)
    local fullName = GetPlayerName(p)
    local result = ""
    local i = 0
    local length = StringLength(fullName)
    while true do
        if (i >= length) then break end
        if ((SubString(fullName, i, __jint(i + 1)) == "#")) then
            do return result end
        end
        result = __jconcat(result, SubString(fullName, i, __jint(i + 1)))
        i = __jint(i + 1)
    end
    do return result end
end

-- Original JASS function: Trig_Name_Change_Actions (line 15751)
function Trig_Name_Change_Actions()
    DisplayTextToForce(GetPlayersAll(), (__jconcat(GetPlayerName(GetOwningPlayer(GetSoldUnit())), (__jconcat(" has selected ", GetUnitName(GetSoldUnit()))))))
    SetPlayerName(GetOwningPlayer(GetSoldUnit()), (__jconcat(GetUnitName(GetSoldUnit()), (__jconcat(udg_PlayerColorHex[GetConvertedPlayerId(GetOwningPlayer(GetSoldUnit()))], GetPlayerNameWithoutTag(GetOwningPlayer(GetSoldUnit())))))))
end

-- Original JASS function: InitTrig_Name_Change (line 15757)
function InitTrig_Name_Change()
    gg_trg_Name_Change = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Name_Change, EVENT_PLAYER_UNIT_SELL)
    TriggerAddCondition(gg_trg_Name_Change, Condition(Trig_Name_Change_Conditions))
    TriggerAddAction(gg_trg_Name_Change, Trig_Name_Change_Actions)
end
-- END FOREST SECTION 259

-- BEGIN FOREST SECTION 260 Name_Change_III
-- Original JASS function: Trig_Name_Change_III_Actions (line 15768)
function Trig_Name_Change_III_Actions()
    SetPlayerName(FE_Roles.ancient(), (__jconcat("Ancient ", (__jconcat(udg_PlayerColorHex[GetPlayerId(FE_Roles.ancient()) + 1], GetPlayerName(FE_Roles.ancient()))))))
end

-- Original JASS function: InitTrig_Name_Change_III (line 15773)
function InitTrig_Name_Change_III()
    gg_trg_Name_Change_III = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_Name_Change_III, __jreal(10.00))
    TriggerAddAction(gg_trg_Name_Change_III, Trig_Name_Change_III_Actions)
end
-- END FOREST SECTION 260
-- END FOREST MODULE src/ui/names.lua

-- BEGIN FOREST MODULE src/game/bans/expanders.lua
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
-- END FOREST MODULE src/game/bans/expanders.lua

-- BEGIN FOREST MODULE src/game/bans/ancients.lua
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
-- END FOREST MODULE src/game/bans/ancients.lua

-- BEGIN FOREST MODULE src/combat/shop_protection.lua
-- combat / shop_protection
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 303 Prevent_Attack
-- Original JASS function: Trig_Prevent_Attack_Func002C (line 17606)
function Trig_Prevent_Attack_Func002C()
    if (((GetUnitTypeId(GetAttackedUnitBJ()) == FourCC("h05B")))) then
        do return true end
    end
    if (((GetUnitTypeId(GetAttackedUnitBJ()) == FourCC("h02B")))) then
        do return true end
    end
    if (((GetUnitTypeId(GetAttackedUnitBJ()) == FourCC("n000")))) then
        do return true end
    end
    if (((GetUnitTypeId(GetAttackedUnitBJ()) == FourCC("n00A")))) then
        do return true end
    end
    if (((GetUnitTypeId(GetAttackedUnitBJ()) == FourCC("h060")))) then
        do return true end
    end
    do return false end
end

-- Original JASS function: Trig_Prevent_Attack_Conditions (line 17625)
function Trig_Prevent_Attack_Conditions()
    if ((not Trig_Prevent_Attack_Func002C())) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Prevent_Attack_Actions (line 17632)
function Trig_Prevent_Attack_Actions()
    IssueImmediateOrderBJ(GetAttacker(), "stop")
end

-- Original JASS function: InitTrig_Prevent_Attack (line 17637)
function InitTrig_Prevent_Attack()
    gg_trg_Prevent_Attack = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Prevent_Attack, EVENT_PLAYER_UNIT_ATTACKED)
    TriggerAddCondition(gg_trg_Prevent_Attack, Condition(Trig_Prevent_Attack_Conditions))
    TriggerAddAction(gg_trg_Prevent_Attack, Trig_Prevent_Attack_Actions)
end
-- END FOREST SECTION 303

-- BEGIN FOREST SECTION 304 No_Attacking_Shops_Copy_3
-- Original JASS function: Trig_No_Attacking_Shops_Copy_3_Conditions (line 17647)
function Trig_No_Attacking_Shops_Copy_3_Conditions()
    if ((not ((GetUnitTypeId(GetAttackedUnitBJ()) == FourCC("h05B"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_No_Attacking_Shops_Copy_3_Actions (line 17654)
function Trig_No_Attacking_Shops_Copy_3_Actions()
    IssueImmediateOrderBJ(GetAttacker(), "stop")
end

-- Original JASS function: InitTrig_No_Attacking_Shops_Copy_3 (line 17659)
function InitTrig_No_Attacking_Shops_Copy_3()
    gg_trg_No_Attacking_Shops_Copy_3 = CreateTrigger()
    DisableTrigger(gg_trg_No_Attacking_Shops_Copy_3)
    TriggerRegisterAnyUnitEventBJ(gg_trg_No_Attacking_Shops_Copy_3, EVENT_PLAYER_UNIT_ATTACKED)
    TriggerAddCondition(gg_trg_No_Attacking_Shops_Copy_3, Condition(Trig_No_Attacking_Shops_Copy_3_Conditions))
    TriggerAddAction(gg_trg_No_Attacking_Shops_Copy_3, Trig_No_Attacking_Shops_Copy_3_Actions)
end
-- END FOREST SECTION 304

-- BEGIN FOREST SECTION 305 No_Attacking_Shops_Copy_2
-- Original JASS function: Trig_No_Attacking_Shops_Copy_2_Conditions (line 17670)
function Trig_No_Attacking_Shops_Copy_2_Conditions()
    if ((not ((GetUnitTypeId(GetAttackedUnitBJ()) == FourCC("h02B"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_No_Attacking_Shops_Copy_2_Actions (line 17677)
function Trig_No_Attacking_Shops_Copy_2_Actions()
    IssueImmediateOrderBJ(GetAttacker(), "stop")
end

-- Original JASS function: InitTrig_No_Attacking_Shops_Copy_2 (line 17682)
function InitTrig_No_Attacking_Shops_Copy_2()
    gg_trg_No_Attacking_Shops_Copy_2 = CreateTrigger()
    DisableTrigger(gg_trg_No_Attacking_Shops_Copy_2)
    TriggerRegisterAnyUnitEventBJ(gg_trg_No_Attacking_Shops_Copy_2, EVENT_PLAYER_UNIT_ATTACKED)
    TriggerAddCondition(gg_trg_No_Attacking_Shops_Copy_2, Condition(Trig_No_Attacking_Shops_Copy_2_Conditions))
    TriggerAddAction(gg_trg_No_Attacking_Shops_Copy_2, Trig_No_Attacking_Shops_Copy_2_Actions)
end
-- END FOREST SECTION 305

-- BEGIN FOREST SECTION 306 No_Attacking_Shops_Copy
-- Original JASS function: Trig_No_Attacking_Shops_Copy_Conditions (line 17693)
function Trig_No_Attacking_Shops_Copy_Conditions()
    if ((not ((GetUnitTypeId(GetAttackedUnitBJ()) == FourCC("n000"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_No_Attacking_Shops_Copy_Actions (line 17700)
function Trig_No_Attacking_Shops_Copy_Actions()
    IssueImmediateOrderBJ(GetAttacker(), "stop")
end

-- Original JASS function: InitTrig_No_Attacking_Shops_Copy (line 17705)
function InitTrig_No_Attacking_Shops_Copy()
    gg_trg_No_Attacking_Shops_Copy = CreateTrigger()
    DisableTrigger(gg_trg_No_Attacking_Shops_Copy)
    TriggerRegisterAnyUnitEventBJ(gg_trg_No_Attacking_Shops_Copy, EVENT_PLAYER_UNIT_ATTACKED)
    TriggerAddCondition(gg_trg_No_Attacking_Shops_Copy, Condition(Trig_No_Attacking_Shops_Copy_Conditions))
    TriggerAddAction(gg_trg_No_Attacking_Shops_Copy, Trig_No_Attacking_Shops_Copy_Actions)
end
-- END FOREST SECTION 306

-- BEGIN FOREST SECTION 307 No_Attacking_Shops
-- Original JASS function: Trig_No_Attacking_Shops_Conditions (line 17716)
function Trig_No_Attacking_Shops_Conditions()
    if ((not ((GetUnitTypeId(GetAttackedUnitBJ()) == FourCC("n00A"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_No_Attacking_Shops_Actions (line 17723)
function Trig_No_Attacking_Shops_Actions()
    IssueImmediateOrderBJ(GetAttacker(), "stop")
end

-- Original JASS function: InitTrig_No_Attacking_Shops (line 17728)
function InitTrig_No_Attacking_Shops()
    gg_trg_No_Attacking_Shops = CreateTrigger()
    DisableTrigger(gg_trg_No_Attacking_Shops)
    TriggerRegisterAnyUnitEventBJ(gg_trg_No_Attacking_Shops, EVENT_PLAYER_UNIT_ATTACKED)
    TriggerAddCondition(gg_trg_No_Attacking_Shops, Condition(Trig_No_Attacking_Shops_Conditions))
    TriggerAddAction(gg_trg_No_Attacking_Shops, Trig_No_Attacking_Shops_Actions)
end
-- END FOREST SECTION 307
-- END FOREST MODULE src/combat/shop_protection.lua

-- BEGIN FOREST MODULE src/players/alliances.lua
-- players / alliances
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 308 Ally_neutral
-- Original JASS function: Trig_Ally_neutral_Actions (line 17739)
function Trig_Ally_neutral_Actions()
    SetPlayerAllianceStateBJ(FE_Roles.ancient(), Player(PLAYER_NEUTRAL_AGGRESSIVE), bj_ALLIANCE_ALLIED)
end

-- Original JASS function: InitTrig_Ally_neutral (line 17744)
function InitTrig_Ally_neutral()
    gg_trg_Ally_neutral = CreateTrigger()
    TriggerAddAction(gg_trg_Ally_neutral, Trig_Ally_neutral_Actions)
end
-- END FOREST SECTION 308

-- BEGIN FOREST SECTION 309 Vision
-- Original JASS function: Trig_Vision_Actions (line 17752)
function Trig_Vision_Actions()
    FogMaskEnableOff()
end

-- Original JASS function: InitTrig_Vision (line 17757)
function InitTrig_Vision()
    gg_trg_Vision = CreateTrigger()
    TriggerAddAction(gg_trg_Vision, Trig_Vision_Actions)
end
-- END FOREST SECTION 309
-- END FOREST MODULE src/players/alliances.lua

-- BEGIN FOREST MODULE src/ui/animations.lua
-- ui / animations
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 310 Death_anim
-- Original JASS function: Trig_Death_anim_Actions (line 17765)
function Trig_Death_anim_Actions()
    RemoveUnit(GetDecayingUnit())
end

-- Original JASS function: InitTrig_Death_anim (line 17770)
function InitTrig_Death_anim()
    gg_trg_Death_anim = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(gg_trg_Death_anim, __jreal(1.00))
    TriggerAddAction(gg_trg_Death_anim, Trig_Death_anim_Actions)
end
-- END FOREST SECTION 310
-- END FOREST MODULE src/ui/animations.lua

-- BEGIN FOREST MODULE src/ui/quests.lua
-- ui / quests
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 311 Quests
-- Original JASS function: Trig_Quests_Actions (line 17779)
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

-- Original JASS function: InitTrig_Quests (line 17792)
function InitTrig_Quests()
    gg_trg_Quests = CreateTrigger()
    TriggerAddAction(gg_trg_Quests, Trig_Quests_Actions)
end
-- END FOREST SECTION 311
-- END FOREST MODULE src/ui/quests.lua

-- BEGIN FOREST MODULE src/players/lackeys.lua
-- players / lackeys
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 317 Lackey_Respawn
-- Original JASS function: LackeyRespawn_IsValidType (line 18016)
function LackeyRespawn_IsValidType(unitType)
    do return (((((((((((unitType == FourCC("e00E")) or (unitType == FourCC("e00C"))) or (unitType == FourCC("e002"))) or (unitType == FourCC("e009"))) or (unitType == FourCC("e00A"))) or (unitType == FourCC("e00G"))) or (unitType == FourCC("e00J"))) or (unitType == FourCC("e00O"))) or (unitType == FourCC("e00H"))) or (unitType == FourCC("e00N"))) or (unitType == FourCC("e00S"))) end
end

-- Original JASS function: LackeyRespawn_IsPlayerPresent (line 18020)
function LackeyRespawn_IsPlayerPresent(playerId)
    do return (GetPlayerSlotState(Player(playerId)) == PLAYER_SLOT_STATE_PLAYING) end
end

-- Original JASS function: LackeyRespawn_OnTimer (line 18024)
function LackeyRespawn_OnTimer()
    local t = GetExpiredTimer()
    local id = GetHandleId(t)
    local unitType = LoadInteger(LackeyRespawn_Hash, id, LACK_RESPAWN_KEY_TYPE)
    local playerId = LoadInteger(LackeyRespawn_Hash, id, LACK_RESPAWN_KEY_PLAYER)
    local td = LoadTimerDialogHandle(LackeyRespawn_Hash, id, LACK_RESPAWN_KEY_DIALOG)
    local x = GetRectCenterX(gg_rct_Alarm)
    local y = GetRectCenterY(gg_rct_Alarm)
    if GetPlayerSlotState(Player(playerId)) == PLAYER_SLOT_STATE_PLAYING and
       not FE_Roles.isAncient(Player(playerId)) and not FE_Roster.isAlive(Player(playerId)) then
        CreateUnit(Player(playerId), unitType, x, y, bj_UNIT_FACING)
    end
    TimerDialogDisplay(td, false)
    DestroyTimerDialog(td)
    FlushChildHashtable(LackeyRespawn_Hash, id)
    PauseTimer(t)
    DestroyTimer(t)
    td = nil
    t = nil
end

-- Original JASS function: Trig_Lackey_Respawn_Conditions (line 18048)
function Trig_Lackey_Respawn_Conditions()
    do return LackeyRespawn_IsValidType(GetUnitTypeId(GetTriggerUnit())) end
end

-- Original JASS function: Trig_Lackey_Respawn_Actions (line 18052)
function Trig_Lackey_Respawn_Actions()
    local dying = GetTriggerUnit()
    local owner = GetOwningPlayer(dying)
    local unitType = GetUnitTypeId(dying)
    local playerId = GetPlayerId(owner)
    local t = nil
    local td = nil
    local id = 0
    if (not ((GetPlayerSlotState(Player((playerId))) == PLAYER_SLOT_STATE_PLAYING))) then
        dying = nil
        owner = nil
        do return end
    end
    t = CreateTimer()
    td = CreateTimerDialog(t)
    id = GetHandleId(t)
    SaveInteger(LackeyRespawn_Hash, id, LACK_RESPAWN_KEY_TYPE, unitType)
    SaveInteger(LackeyRespawn_Hash, id, LACK_RESPAWN_KEY_PLAYER, playerId)
    SaveTimerDialogHandle(LackeyRespawn_Hash, id, LACK_RESPAWN_KEY_DIALOG, td)
    TimerDialogSetTitle(td, "Lackey respawn")
    if (GetLocalPlayer() == owner) then
        TimerDialogDisplay(td, true)
    end
    TimerStart(t, LACK_RESPAWN_DELAY, false, LackeyRespawn_OnTimer)
    dying = nil
    owner = nil
    td = nil
    t = nil
end

-- Original JASS function: InitTrig_Lackey_Respawn (line 18090)
function InitTrig_Lackey_Respawn()
    gg_trg_Lackey_Respawn = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Lackey_Respawn, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Lackey_Respawn, Condition(Trig_Lackey_Respawn_Conditions))
    TriggerAddAction(gg_trg_Lackey_Respawn, Trig_Lackey_Respawn_Actions)
end
-- END FOREST SECTION 317

-- BEGIN FOREST SECTION 318 Death_start
-- Original JASS function: Trig_Death_start_Conditions (line 18099)
function Trig_Death_start_Conditions()
    if ((not ((IsUnitType(GetTriggerUnit(), UNIT_TYPE_STRUCTURE) == false)))) then
        do return false end
    end
    if ((not ((IsUnitType(GetTriggerUnit(), UNIT_TYPE_ANCIENT) == true)))) then
        do return false end
    end
    if ((not ((IsUnitEnemy(GetDyingUnit(), FE_Roles.ancient()) == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Death_start_Func002002 (line 18112)
function Trig_Death_start_Func002002()
    RemoveUnit(GetEnumUnit())
end

-- Original JASS function: Trig_Death_start_Func010Func001C (line 18116)
function Trig_Death_start_Func010Func001C()
    if ((not ((IsPlayerAlly(udg_DeadPlayer, GetEnumPlayer()) == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Death_start_Func010A (line 18123)
function Trig_Death_start_Func010A()
    if (Trig_Death_start_Func010Func001C()) then
        SetPlayerAllianceStateBJ(udg_DeadPlayer, GetEnumPlayer(), bj_ALLIANCE_UNALLIED)
        SetPlayerAllianceStateBJ(GetEnumPlayer(), udg_DeadPlayer, bj_ALLIANCE_UNALLIED)
    else
    end
end

-- Original JASS function: Trig_Death_start_Func011Func001C (line 18131)
function Trig_Death_start_Func011Func001C()
    do return true end
end

-- Original JASS function: Trig_Death_start_Func011A (line 18135)
function Trig_Death_start_Func011A()
    if ((true)) then
        SetPlayerAllianceStateBJ(udg_DeadPlayer, GetEnumPlayer(), bj_ALLIANCE_ALLIED_VISION)
        SetPlayerAllianceStateBJ(GetEnumPlayer(), udg_DeadPlayer, bj_ALLIANCE_ALLIED_VISION)
    else
    end
end

-- Original JASS function: Trig_Death_start_Actions (line 18143)
function Trig_Death_start_Actions()
    local dying = GetTriggerUnit()
    local player = GetOwningPlayer(dying)
    if not FE_Roster.defeat(player) then return end
    local killer = GetKillingUnitBJ()
    local location = GetUnitLoc(killer or dying)
    udg_Flags[GetConvertedPlayerId(player)] = false
    udg_DeadPlayer = player
    udg_SeedOfRebirth[GetConvertedPlayerId(player)] = GetUnitTypeId(dying)
    udg_LocationOfDeath = location
    DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl", GetUnitX(dying), GetUnitY(dying)))
    local units = GetUnitsOfPlayerAll(player)
    ForGroupBJ(units, Trig_Death_start_Func002002)
    DestroyGroup(units)
    ConditionalTriggerExecute(gg_trg_Spawn_Lackey)
    RemoveLocation(location)
    udg_LocationOfDeath = nil
    ForForce(GetPlayersAll(), Trig_Death_start_Func010A)
    local allies = GetPlayersAllies(FE_Roles.ancient())
    ForForce(allies, Trig_Death_start_Func011A)
    DestroyForce(allies)
    SetPlayerAllianceStateBJ(player, FE_Roles.ancient(), bj_ALLIANCE_ALLIED_VISION)
    SetPlayerAllianceStateBJ(FE_Roles.ancient(), player, bj_ALLIANCE_ALLIED_VISION)
end

-- Original JASS function: InitTrig_Death_start (line 18161)
function InitTrig_Death_start()
    gg_trg_Death_start = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Death_start, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Death_start, Condition(Trig_Death_start_Conditions))
    TriggerAddAction(gg_trg_Death_start, Trig_Death_start_Actions)
end
-- END FOREST SECTION 318

-- BEGIN FOREST SECTION 319 Spawn_Lackey
-- Original JASS function: SpawnLackey_EnsureSetup (line 18171)
function SpawnLackey_EnsureSetup()
    if (SpawnLackey_Hash == nil) then
        SpawnLackey_Hash = InitHashtable()
    end
    if (SpawnLackey_GameTimer == nil) then
        SpawnLackey_GameTimer = CreateTimer()
        TimerStart(SpawnLackey_GameTimer, __jreal(999999.00), false, nil)
    end
end

-- Original JASS function: SpawnLackey_GetFountainCenterX (line 18182)
function SpawnLackey_GetFountainCenterX()
    do return __jreal((__jreal(GetRectMinX(gg_rct_Fountain) + GetRectMaxX(gg_rct_Fountain))) * __jreal(0.50)) end
end

-- Original JASS function: SpawnLackey_GetFountainCenterY (line 18186)
function SpawnLackey_GetFountainCenterY()
    do return __jreal((__jreal(GetRectMinY(gg_rct_Fountain) + GetRectMaxY(gg_rct_Fountain))) * __jreal(0.50)) end
end

-- Original JASS function: SpawnLackey_PanCameraToFountainForPlayer (line 18190)
function SpawnLackey_PanCameraToFountainForPlayer(whichPlayer)
    local x = (__jreal((__jreal(GetRectMinX(gg_rct_Fountain) + GetRectMaxX(gg_rct_Fountain))) * __jreal(0.50)))
    local y = (__jreal((__jreal(GetRectMinY(gg_rct_Fountain) + GetRectMaxY(gg_rct_Fountain))) * __jreal(0.50)))
    if (GetLocalPlayer() == whichPlayer) then
        PanCameraToTimed(x, y, __jreal(0.00))
    end
end

-- Original JASS function: SpawnLackey_GetLackeyType (line 18199)
function SpawnLackey_GetLackeyType()
    local ancientUnitType = GetUnitTypeId(udg_AncientUnit)
    if (ancientUnitType == FourCC("O00A")) then
        do return FourCC("e00C") end
    end
    if (ancientUnitType == FourCC("O00S")) then
        do return FourCC("e002") end
    end
    if (ancientUnitType == FourCC("O00L")) then
        do return FourCC("e009") end
    end
    if (ancientUnitType == FourCC("O004")) then
        do return FourCC("e00A") end
    end
    if (ancientUnitType == FourCC("O008")) then
        do return FourCC("e00N") end
    end
    if (ancientUnitType == FourCC("O01V")) then
        do return FourCC("e00G") end
    end
    if (ancientUnitType == FourCC("O016")) then
        do return FourCC("e00J") end
    end
    if (ancientUnitType == FourCC("O00D")) then
        do return FourCC("e00O") end
    end
    if (ancientUnitType == FourCC("O01X")) then
        do return FourCC("e00H") end
    end
    if (ancientUnitType == FourCC("O01Z")) then
        do return FourCC("e00E") end
    end
    if (ancientUnitType == FourCC("O01D")) then
        do return FourCC("e00S") end
    end
    do return 0 end
end

-- Original JASS function: SpawnLackey_CreateAtXY (line 18239)
function SpawnLackey_CreateAtXY(deadPlayer, lackeyType, x, y)
    local lackey = nil
    if (lackeyType == 0) then
        do return end
    end
    lackey = CreateUnit(deadPlayer, lackeyType, x, y, bj_UNIT_FACING)
    if (lackey ~= nil) then
        DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl", GetUnitX(lackey), GetUnitY(lackey)))
    end
    lackey = nil
end

-- Original JASS function: SpawnLackey_CreateAtLoc (line 18255)
function SpawnLackey_CreateAtLoc(deadPlayer, lackeyType, spawnLoc)
    SpawnLackey_CreateAtXY(deadPlayer, lackeyType, GetLocationX(spawnLoc), GetLocationY(spawnLoc))
end

-- Original JASS function: SpawnLackey_DelayedTimerExpires (line 18259)
function SpawnLackey_DelayedTimerExpires()
    local t = GetExpiredTimer()
    local timerId = GetHandleId(t)
    local playerIndex = LoadInteger(SpawnLackey_Hash, timerId, 0)
    local lackeyType = LoadInteger(SpawnLackey_Hash, timerId, 1)
    local deadPlayer = Player(playerIndex)
    local x = (__jreal((__jreal(GetRectMinX(gg_rct_Fountain) + GetRectMaxX(gg_rct_Fountain))) * __jreal(0.50)))
    local y = (__jreal((__jreal(GetRectMinY(gg_rct_Fountain) + GetRectMaxY(gg_rct_Fountain))) * __jreal(0.50)))
    if GetPlayerSlotState(deadPlayer) == PLAYER_SLOT_STATE_PLAYING and
       not FE_Roles.isAncient(deadPlayer) and not FE_Roster.isAlive(deadPlayer) then
        SpawnLackey_CreateAtXY(deadPlayer, lackeyType, x, y)
        SpawnLackey_PanCameraToFountainForPlayer(deadPlayer)
    end
    if (SpawnLackey_PlayerDialog[playerIndex] ~= nil) then
        TimerDialogDisplay(SpawnLackey_PlayerDialog[playerIndex], false)
        DestroyTimerDialog(SpawnLackey_PlayerDialog[playerIndex])
        SpawnLackey_PlayerDialog[playerIndex] = nil
    end
    SpawnLackey_PlayerTimer[playerIndex] = nil
    FlushChildHashtable(SpawnLackey_Hash, timerId)
    DestroyTimer(t)
    t = nil
    deadPlayer = nil
end

-- Original JASS function: SpawnLackey_StartDelayedTimer (line 18286)
function SpawnLackey_StartDelayedTimer(deadPlayer, lackeyType, remaining)
    local playerIndex = GetPlayerId(deadPlayer)
    local t = CreateTimer()
    SpawnLackey_EnsureSetup()
    if (remaining < __jreal(0.00)) then
        remaining = __jreal(0.00)
    end
    if (SpawnLackey_PlayerTimer[playerIndex] ~= nil) then
        PauseTimer(SpawnLackey_PlayerTimer[playerIndex])
        FlushChildHashtable(SpawnLackey_Hash, GetHandleId(SpawnLackey_PlayerTimer[playerIndex]))
        DestroyTimer(SpawnLackey_PlayerTimer[playerIndex])
        SpawnLackey_PlayerTimer[playerIndex] = nil
    end
    if (SpawnLackey_PlayerDialog[playerIndex] ~= nil) then
        TimerDialogDisplay(SpawnLackey_PlayerDialog[playerIndex], false)
        DestroyTimerDialog(SpawnLackey_PlayerDialog[playerIndex])
        SpawnLackey_PlayerDialog[playerIndex] = nil
    end
    SpawnLackey_PlayerTimer[playerIndex] = t
    SpawnLackey_PlayerDialog[playerIndex] = CreateTimerDialog(t)
    TimerDialogSetTitle(SpawnLackey_PlayerDialog[playerIndex], "Time till lackey spawn")
    if (GetLocalPlayer() == deadPlayer) then
        TimerDialogDisplay(SpawnLackey_PlayerDialog[playerIndex], true)
    end
    SaveInteger(SpawnLackey_Hash, GetHandleId(t), 0, playerIndex)
    SaveInteger(SpawnLackey_Hash, GetHandleId(t), 1, lackeyType)
    TimerStart(t, remaining, false, SpawnLackey_DelayedTimerExpires)
    t = nil
end

-- Original JASS function: Trig_Spawn_Lackey_Actions (line 18326)
function Trig_Spawn_Lackey_Actions()
    local deadPlayer = udg_DeadPlayer
    local x, y = GetLocationX(udg_LocationOfDeath), GetLocationY(udg_LocationOfDeath)
    SpawnLackey_EnsureSetup()
    local lackeyType = SpawnLackey_GetLackeyType()
    local killer = GetKillingUnitBJ()
    local killerName = killer and GetPlayerName(GetOwningPlayer(killer)) or "the environment"
    DisplayTextToForce(GetPlayersAll(), GetPlayerName(deadPlayer) .. " was killed by " .. killerName)
    SetPlayerStateBJ(deadPlayer, PLAYER_STATE_RESOURCE_GOLD, 0)
    SetPlayerStateBJ(deadPlayer, PLAYER_STATE_RESOURCE_LUMBER, 0)
    TriggerSleepAction(__jreal(0.50))
    if lackeyType == 0 or GetPlayerSlotState(deadPlayer) ~= PLAYER_SLOT_STATE_PLAYING or
       FE_Roles.isAncient(deadPlayer) or FE_Roster.isAlive(deadPlayer) then return end
    local remaining = SPAWN_LACKEY_DELAY_MARK - TimerGetElapsed(SpawnLackey_GameTimer)
    if remaining > 0 then SpawnLackey_StartDelayedTimer(deadPlayer, lackeyType, remaining)
    else SpawnLackey_CreateAtXY(deadPlayer, lackeyType, x, y) end
end

-- Original JASS function: InitTrig_Spawn_Lackey (line 18356)
function InitTrig_Spawn_Lackey()
    SpawnLackey_EnsureSetup()
    gg_trg_Spawn_Lackey = CreateTrigger()
    TriggerAddAction(gg_trg_Spawn_Lackey, Trig_Spawn_Lackey_Actions)
end
-- END FOREST SECTION 319

-- BEGIN FOREST SECTION 320 MiniMinis
-- Original JASS function: Trig_MiniMinis_Conditions (line 18365)
function Trig_MiniMinis_Conditions()
    if ((not ((IsUnitEnemy(GetDyingUnit(), FE_Roles.ancient()) == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_MiniMinis_Func003C (line 18372)
function Trig_MiniMinis_Func003C()
    if ((not ((GetUnitTypeId(GetKillingUnitBJ()) == FourCC("e00C"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_MiniMinis_Func005C (line 18379)
function Trig_MiniMinis_Func005C()
    if ((not ((GetUnitTypeId(GetKillingUnitBJ()) == FourCC("e00G"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_MiniMinis_Func007C (line 18386)
function Trig_MiniMinis_Func007C()
    if ((not ((GetUnitTypeId(GetKillingUnitBJ()) == FourCC("e00A"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_MiniMinis_Func009C (line 18393)
function Trig_MiniMinis_Func009C()
    if ((not ((GetUnitTypeId(GetKillingUnitBJ()) == FourCC("e00N"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_MiniMinis_Func011C (line 18400)
function Trig_MiniMinis_Func011C()
    if ((not ((GetUnitTypeId(GetKillingUnitBJ()) == FourCC("e009"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_MiniMinis_Func013C (line 18407)
function Trig_MiniMinis_Func013C()
    if ((not ((GetUnitTypeId(GetKillingUnitBJ()) == FourCC("e00J"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_MiniMinis_Func015C (line 18414)
function Trig_MiniMinis_Func015C()
    if ((not ((GetUnitTypeId(GetKillingUnitBJ()) == FourCC("e00O"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_MiniMinis_Func017C (line 18421)
function Trig_MiniMinis_Func017C()
    if ((not ((GetUnitTypeId(GetKillingUnitBJ()) == FourCC("e00H"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_MiniMinis_Actions (line 18428)
function Trig_MiniMinis_Actions()
    if (Trig_MiniMinis_Func003C()) then
        AddSpecialEffectLocBJ(GetUnitLoc(GetDyingUnit()), "Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl")
        CreateNUnitsAtLoc(1, FourCC("e00D"), GetOwningPlayer(GetKillingUnitBJ()), GetUnitLoc(GetDyingUnit()), bj_UNIT_FACING)
    else
    end
    if (Trig_MiniMinis_Func005C()) then
        CreateNUnitsAtLoc(1, FourCC("e00F"), GetOwningPlayer(GetKillingUnitBJ()), GetUnitLoc(GetDyingUnit()), bj_UNIT_FACING)
    else
    end
    if (Trig_MiniMinis_Func007C()) then
        CreateNUnitsAtLoc(1, FourCC("e00B"), GetOwningPlayer(GetKillingUnitBJ()), GetUnitLoc(GetDyingUnit()), bj_UNIT_FACING)
    else
    end
    if (Trig_MiniMinis_Func009C()) then
        CreateNUnitsAtLoc(1, FourCC("e00P"), GetOwningPlayer(GetKillingUnitBJ()), GetUnitLoc(GetDyingUnit()), bj_UNIT_FACING)
    else
    end
    if (Trig_MiniMinis_Func011C()) then
        CreateNUnitsAtLoc(1, FourCC("e008"), GetOwningPlayer(GetKillingUnitBJ()), GetUnitLoc(GetDyingUnit()), bj_UNIT_FACING)
    else
    end
    if (Trig_MiniMinis_Func013C()) then
        CreateNUnitsAtLoc(1, FourCC("e00K"), GetOwningPlayer(GetKillingUnitBJ()), GetUnitLoc(GetDyingUnit()), bj_UNIT_FACING)
    else
    end
    if (Trig_MiniMinis_Func015C()) then
        CreateNUnitsAtLoc(1, FourCC("e00M"), GetOwningPlayer(GetKillingUnitBJ()), GetUnitLoc(GetDyingUnit()), bj_UNIT_FACING)
    else
    end
    if (Trig_MiniMinis_Func017C()) then
        CreateNUnitsAtLoc(1, FourCC("e00I"), GetOwningPlayer(GetKillingUnitBJ()), GetUnitLoc(GetDyingUnit()), bj_UNIT_FACING)
    else
    end
end

-- Original JASS function: InitTrig_MiniMinis (line 18472)
function InitTrig_MiniMinis()
    gg_trg_MiniMinis = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_MiniMinis, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_MiniMinis, Condition(Trig_MiniMinis_Conditions))
    TriggerAddAction(gg_trg_MiniMinis, Trig_MiniMinis_Actions)
end
-- END FOREST SECTION 320
-- END FOREST MODULE src/players/lackeys.lua

-- BEGIN FOREST MODULE src/players/leaving.lua
-- players / leaving
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 321 Player_Leaves
-- Original JASS function: Trig_Player_Leaves_Func003002 (line 18482)
function Trig_Player_Leaves_Func003002()
    RemoveUnit(GetEnumUnit())
end

-- Original JASS function: Trig_Player_Leaves_Actions (line 18486)
function Trig_Player_Leaves_Actions()
    if FE_Roles.isAncient(GetTriggerPlayer()) then return end
    FE_Roster.defeat(GetTriggerPlayer())
    udg_Flags[GetConvertedPlayerId(GetTriggerPlayer())] = false
    DisplayTextToForce(GetPlayersAll(), (__jconcat(GetPlayerName(GetTriggerPlayer()), " has left the game.")))
    local units = GetUnitsOfPlayerAll(GetTriggerPlayer())
    ForGroupBJ(units, Trig_Player_Leaves_Func003002)
    DestroyGroup(units)
end

-- Original JASS function: InitTrig_Player_Leaves (line 18493)
function InitTrig_Player_Leaves()
    gg_trg_Player_Leaves = CreateTrigger()
    FE_Roles.forEachPlayer(function(player)
        TriggerRegisterPlayerEventLeave(gg_trg_Player_Leaves, player)
    end)
    TriggerAddAction(gg_trg_Player_Leaves, Trig_Player_Leaves_Actions)
end
-- END FOREST SECTION 321

-- BEGIN FOREST SECTION 322 Ancient_Leaves
-- Original JASS function: Trig_Ancient_Leaves_Actions (line 18511)
function Trig_Ancient_Leaves_Actions()
    local leavingAncient = GetTriggerPlayer()
    if (leavingAncient ~= FE_Roles.ancient()) then
        leavingAncient = nil
        do return end
    end
    PlayThematicMusicBJ("Tension")
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_436")
    TriggerSleepAction(__jreal(3.00))
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_5283")
    TriggerSleepAction(__jreal(120.00))
    if (FE_Roles.ancient() == leavingAncient) then
        FE_Roles.otherPlayersWin()
    else
        DisplayTextToForce(GetPlayersAll(), "|cff80ff80Ancient was taken over. The game will continue.|r")
    end
    leavingAncient = nil
end

-- Original JASS function: InitTrig_Ancient_Leaves (line 18544)
function InitTrig_Ancient_Leaves()
    local i = 0
    gg_trg_Ancient_Leaves = CreateTrigger()
    while true do
        if (i >= 11) then break end
        TriggerRegisterPlayerEventLeave(gg_trg_Ancient_Leaves, Player(i))
        i = __jint(i + 1)
    end
    TriggerAddAction(gg_trg_Ancient_Leaves, Trig_Ancient_Leaves_Actions)
end
-- END FOREST SECTION 322
-- END FOREST MODULE src/players/leaving.lua

-- BEGIN FOREST MODULE src/players/deaths.lua
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
-- END FOREST MODULE src/players/deaths.lua

-- BEGIN FOREST MODULE src/game/victory.lua
-- game / victory
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 351 Ignite_Dies
-- Original JASS function: Trig_Ignite_Dies_Conditions (line 19435)
function Trig_Ignite_Dies_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("O004"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Ignite_Dies_Actions (line 19442)
function Trig_Ignite_Dies_Actions()
    DisableTrigger(gg_trg_Ancient_Leaves)
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_302")
    PlayThematicMusicBJ("HeroicVictory")
    TriggerSleepAction(__jreal(3.00))
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_5283")
    DisplayTimedTextToForce(GetPlayersAll(), __jreal(120.00), "TRIGSTR_9243")
    TriggerSleepAction(__jreal(120.00))
    FE_Roles.finishMatch(false, "TRIGSTR_4301")
end

-- Original JASS function: InitTrig_Ignite_Dies (line 19463)
function InitTrig_Ignite_Dies()
    gg_trg_Ignite_Dies = CreateTrigger()
    FE_Roles.registerAncientUnitEvent(gg_trg_Ignite_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Ignite_Dies, Condition(Trig_Ignite_Dies_Conditions))
    TriggerAddAction(gg_trg_Ignite_Dies, Trig_Ignite_Dies_Actions)
end
-- END FOREST SECTION 351

-- BEGIN FOREST SECTION 352 Avalanche_Dies
-- Original JASS function: Trig_Avalanche_Dies_Conditions (line 19473)
function Trig_Avalanche_Dies_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("O008"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Avalanche_Dies_Actions (line 19480)
function Trig_Avalanche_Dies_Actions()
    DisableTrigger(gg_trg_Ancient_Leaves)
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_446")
    PlayThematicMusicBJ("HeroicVictory")
    TriggerSleepAction(__jreal(3.00))
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_5283")
    DisplayTimedTextToForce(GetPlayersAll(), __jreal(120.00), "TRIGSTR_9243")
    TriggerSleepAction(__jreal(120.00))
    FE_Roles.finishMatch(false, "TRIGSTR_4301")
end

-- Original JASS function: InitTrig_Avalanche_Dies (line 19501)
function InitTrig_Avalanche_Dies()
    gg_trg_Avalanche_Dies = CreateTrigger()
    FE_Roles.registerAncientUnitEvent(gg_trg_Avalanche_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Avalanche_Dies, Condition(Trig_Avalanche_Dies_Conditions))
    TriggerAddAction(gg_trg_Avalanche_Dies, Trig_Avalanche_Dies_Actions)
end
-- END FOREST SECTION 352

-- BEGIN FOREST SECTION 353 Paranoia_Dies
-- Original JASS function: Trig_Paranoia_Dies_Conditions (line 19511)
function Trig_Paranoia_Dies_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("O00A"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Paranoia_Dies_Actions (line 19518)
function Trig_Paranoia_Dies_Actions()
    DisableTrigger(gg_trg_Ancient_Leaves)
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_418")
    PlayThematicMusicBJ("HeroicVictory")
    TriggerSleepAction(__jreal(3.00))
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_5283")
    DisplayTimedTextToForce(GetPlayersAll(), __jreal(120.00), "TRIGSTR_9243")
    TriggerSleepAction(__jreal(120.00))
    FE_Roles.finishMatch(false, "TRIGSTR_4301")
end

-- Original JASS function: InitTrig_Paranoia_Dies (line 19539)
function InitTrig_Paranoia_Dies()
    gg_trg_Paranoia_Dies = CreateTrigger()
    FE_Roles.registerAncientUnitEvent(gg_trg_Paranoia_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Paranoia_Dies, Condition(Trig_Paranoia_Dies_Conditions))
    TriggerAddAction(gg_trg_Paranoia_Dies, Trig_Paranoia_Dies_Actions)
end
-- END FOREST SECTION 353

-- BEGIN FOREST SECTION 354 Eternity_Dies
-- Original JASS function: Trig_Eternity_Dies_Conditions (line 19549)
function Trig_Eternity_Dies_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("O00D"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Eternity_Dies_Actions (line 19556)
function Trig_Eternity_Dies_Actions()
    DisableTrigger(gg_trg_Ancient_Leaves)
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_680")
    PlayThematicMusicBJ("HeroicVictory")
    TriggerSleepAction(__jreal(3.00))
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_5283")
    DisplayTimedTextToForce(GetPlayersAll(), __jreal(120.00), "TRIGSTR_9243")
    TriggerSleepAction(__jreal(120.00))
    FE_Roles.finishMatch(false, "TRIGSTR_4301")
end

-- Original JASS function: InitTrig_Eternity_Dies (line 19577)
function InitTrig_Eternity_Dies()
    gg_trg_Eternity_Dies = CreateTrigger()
    FE_Roles.registerAncientUnitEvent(gg_trg_Eternity_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Eternity_Dies, Condition(Trig_Eternity_Dies_Conditions))
    TriggerAddAction(gg_trg_Eternity_Dies, Trig_Eternity_Dies_Actions)
end
-- END FOREST SECTION 354

-- BEGIN FOREST SECTION 355 Dragos_Dies
-- Original JASS function: Trig_Dragos_Dies_Conditions (line 19587)
function Trig_Dragos_Dies_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("O00S"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Dragos_Dies_Actions (line 19594)
function Trig_Dragos_Dies_Actions()
    DisableTrigger(gg_trg_Ancient_Leaves)
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_2030")
    PlayThematicMusicBJ("HeroicVictory")
    TriggerSleepAction(__jreal(3.00))
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_5283")
    DisplayTimedTextToForce(GetPlayersAll(), __jreal(120.00), "TRIGSTR_9243")
    TriggerSleepAction(__jreal(120.00))
    FE_Roles.finishMatch(false, "TRIGSTR_4301")
end

-- Original JASS function: InitTrig_Dragos_Dies (line 19616)
function InitTrig_Dragos_Dies()
    gg_trg_Dragos_Dies = CreateTrigger()
    FE_Roles.registerAncientUnitEvent(gg_trg_Dragos_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Dragos_Dies, Condition(Trig_Dragos_Dies_Conditions))
    TriggerAddAction(gg_trg_Dragos_Dies, Trig_Dragos_Dies_Actions)
end
-- END FOREST SECTION 355

-- BEGIN FOREST SECTION 356 Tremor_Dies
-- Original JASS function: Trig_Tremor_Dies_Conditions (line 19626)
function Trig_Tremor_Dies_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("O00L"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Tremor_Dies_Actions (line 19633)
function Trig_Tremor_Dies_Actions()
    DisableTrigger(gg_trg_Ancient_Leaves)
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_1475")
    PlayThematicMusicBJ("HeroicVictory")
    TriggerSleepAction(__jreal(3.00))
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_5283")
    DisplayTimedTextToForce(GetPlayersAll(), __jreal(120.00), "TRIGSTR_9243")
    TriggerSleepAction(__jreal(120.00))
    FE_Roles.finishMatch(false, "TRIGSTR_4301")
end

-- Original JASS function: InitTrig_Tremor_Dies (line 19655)
function InitTrig_Tremor_Dies()
    gg_trg_Tremor_Dies = CreateTrigger()
    FE_Roles.registerAncientUnitEvent(gg_trg_Tremor_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Tremor_Dies, Condition(Trig_Tremor_Dies_Conditions))
    TriggerAddAction(gg_trg_Tremor_Dies, Trig_Tremor_Dies_Actions)
end
-- END FOREST SECTION 356

-- BEGIN FOREST SECTION 357 Zalxon_Dies
-- Original JASS function: Trig_Zalxon_Dies_Conditions (line 19665)
function Trig_Zalxon_Dies_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("O016"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Zalxon_Dies_Actions (line 19672)
function Trig_Zalxon_Dies_Actions()
    DisableTrigger(gg_trg_Ancient_Leaves)
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_3657")
    PlayThematicMusicBJ("HeroicVictory")
    TriggerSleepAction(__jreal(3.00))
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_5283")
    DisplayTimedTextToForce(GetPlayersAll(), __jreal(120.00), "TRIGSTR_9243")
    TriggerSleepAction(__jreal(120.00))
    FE_Roles.finishMatch(false, "TRIGSTR_4301")
end

-- Original JASS function: InitTrig_Zalxon_Dies (line 19694)
function InitTrig_Zalxon_Dies()
    gg_trg_Zalxon_Dies = CreateTrigger()
    FE_Roles.registerAncientUnitEvent(gg_trg_Zalxon_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Zalxon_Dies, Condition(Trig_Zalxon_Dies_Conditions))
    TriggerAddAction(gg_trg_Zalxon_Dies, Trig_Zalxon_Dies_Actions)
end
-- END FOREST SECTION 357

-- BEGIN FOREST SECTION 358 Divinity_Dies
-- Original JASS function: Trig_Divinity_Dies_Conditions (line 19704)
function Trig_Divinity_Dies_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("O01V"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Divinity_Dies_Actions (line 19711)
function Trig_Divinity_Dies_Actions()
    DisableTrigger(gg_trg_Ancient_Leaves)
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_7140")
    PlayThematicMusicBJ("HeroicVictory")
    TriggerSleepAction(__jreal(3.00))
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_5283")
    DisplayTimedTextToForce(GetPlayersAll(), __jreal(120.00), "TRIGSTR_9243")
    TriggerSleepAction(__jreal(120.00))
    FE_Roles.finishMatch(false, "TRIGSTR_4301")
end

-- Original JASS function: InitTrig_Divinity_Dies (line 19733)
function InitTrig_Divinity_Dies()
    gg_trg_Divinity_Dies = CreateTrigger()
    FE_Roles.registerAncientUnitEvent(gg_trg_Divinity_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Divinity_Dies, Condition(Trig_Divinity_Dies_Conditions))
    TriggerAddAction(gg_trg_Divinity_Dies, Trig_Divinity_Dies_Actions)
end
-- END FOREST SECTION 358

-- BEGIN FOREST SECTION 359 Pharoah_Dies
-- Original JASS function: Trig_Pharoah_Dies_Conditions (line 19743)
function Trig_Pharoah_Dies_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("O01X"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Pharoah_Dies_Actions (line 19750)
function Trig_Pharoah_Dies_Actions()
    DisableTrigger(gg_trg_Ancient_Leaves)
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_8363")
    PlayThematicMusicBJ("HeroicVictory")
    TriggerSleepAction(__jreal(3.00))
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_5283")
    DisplayTimedTextToForce(GetPlayersAll(), __jreal(120.00), "TRIGSTR_9243")
    TriggerSleepAction(__jreal(120.00))
    FE_Roles.finishMatch(false, "TRIGSTR_4301")
end

-- Original JASS function: InitTrig_Pharoah_Dies (line 19772)
function InitTrig_Pharoah_Dies()
    gg_trg_Pharoah_Dies = CreateTrigger()
    FE_Roles.registerAncientUnitEvent(gg_trg_Pharoah_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Pharoah_Dies, Condition(Trig_Pharoah_Dies_Conditions))
    TriggerAddAction(gg_trg_Pharoah_Dies, Trig_Pharoah_Dies_Actions)
end
-- END FOREST SECTION 359

-- BEGIN FOREST SECTION 360 Nebula_Dies
-- Original JASS function: Trig_Nebula_Dies_Conditions (line 19782)
function Trig_Nebula_Dies_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("O01Z"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Nebula_Dies_Actions (line 19789)
function Trig_Nebula_Dies_Actions()
    DisableTrigger(gg_trg_Ancient_Leaves)
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_9096")
    PlayThematicMusicBJ("HeroicVictory")
    TriggerSleepAction(__jreal(3.00))
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_5283")
    DisplayTimedTextToForce(GetPlayersAll(), __jreal(120.00), "TRIGSTR_9243")
    TriggerSleepAction(__jreal(120.00))
    FE_Roles.finishMatch(false, "TRIGSTR_4301")
end

-- Original JASS function: InitTrig_Nebula_Dies (line 19811)
function InitTrig_Nebula_Dies()
    gg_trg_Nebula_Dies = CreateTrigger()
    FE_Roles.registerAncientUnitEvent(gg_trg_Nebula_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Nebula_Dies, Condition(Trig_Nebula_Dies_Conditions))
    TriggerAddAction(gg_trg_Nebula_Dies, Trig_Nebula_Dies_Actions)
end
-- END FOREST SECTION 360

-- BEGIN FOREST SECTION 361 Wispari_Dies
-- Original JASS function: Trig_Wispari_Dies_Conditions (line 19821)
function Trig_Wispari_Dies_Conditions()
    if ((not ((GetUnitTypeId(GetTriggerUnit()) == FourCC("O01D"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Wispari_Dies_Actions (line 19828)
function Trig_Wispari_Dies_Actions()
    DisableTrigger(gg_trg_Ancient_Leaves)
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_4300")
    PlayThematicMusicBJ("HeroicVictory")
    TriggerSleepAction(__jreal(3.00))
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_5283")
    DisplayTimedTextToForce(GetPlayersAll(), __jreal(120.00), "TRIGSTR_9243")
    TriggerSleepAction(__jreal(120.00))
    FE_Roles.finishMatch(false, "TRIGSTR_4301")
end

-- Original JASS function: InitTrig_Wispari_Dies (line 19850)
function InitTrig_Wispari_Dies()
    gg_trg_Wispari_Dies = CreateTrigger()
    FE_Roles.registerAncientUnitEvent(gg_trg_Wispari_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Wispari_Dies, Condition(Trig_Wispari_Dies_Conditions))
    TriggerAddAction(gg_trg_Wispari_Dies, Trig_Wispari_Dies_Actions)
end
-- END FOREST SECTION 361

-- BEGIN FOREST SECTION 362 Remove_Resources_new
-- Original JASS function: Trig_Remove_Resources_new_Func001Func001C (line 19862)
function Trig_Remove_Resources_new_Func001Func001C()
    if ((not ((GetEnumPlayer() ~= FE_Roles.ancient())))) then
        do return false end
    end
    if ((not ((IsPlayerAlly(GetEnumPlayer(), FE_Roles.ancient()) == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Remove_Resources_new_Func001A (line 19872)
function Trig_Remove_Resources_new_Func001A()
    if (Trig_Remove_Resources_new_Func001Func001C()) then
        SetPlayerStateBJ(GetEnumPlayer(), PLAYER_STATE_RESOURCE_GOLD, 0)
        SetPlayerStateBJ(GetEnumPlayer(), PLAYER_STATE_RESOURCE_LUMBER, 0)
    else
        DoNothing()
    end
end

-- Original JASS function: Trig_Remove_Resources_new_Actions (line 19881)
function Trig_Remove_Resources_new_Actions()
    ForForce(GetPlayersAll(), Trig_Remove_Resources_new_Func001A)
end

-- Original JASS function: InitTrig_Remove_Resources_new (line 19886)
function InitTrig_Remove_Resources_new()
    gg_trg_Remove_Resources_new = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(gg_trg_Remove_Resources_new, __jreal(0.50))
    TriggerAddAction(gg_trg_Remove_Resources_new, Trig_Remove_Resources_new_Actions)
end
-- END FOREST SECTION 362

-- BEGIN FOREST SECTION 363 DVIC_1
-- Original JASS function: Trig_DVIC_1_Conditions (line 19895)
function Trig_DVIC_1_Conditions()
    if ((not ((GetUnitLevel(GetLevelingUnit()) == 20)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_DVIC_1_Actions (line 19902)
function Trig_DVIC_1_Actions()
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_7267")
    PlayThematicMusicBJ("UndeadVictory")
    TriggerSleepAction(__jreal(3.00))
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_7268")
    DisplayTimedTextToForce(GetPlayersAll(), __jreal(120.00), "TRIGSTR_9243")
    TriggerSleepAction(__jreal(120.00))
    FE_Roles.finishMatch(true, "TRIGSTR_7269")
end

-- Original JASS function: InitTrig_DVIC_1 (line 19923)
function InitTrig_DVIC_1()
    gg_trg_DVIC_1 = CreateTrigger()
    FE_Roles.registerAncientUnitEvent(gg_trg_DVIC_1, EVENT_PLAYER_HERO_LEVEL)
    TriggerAddCondition(gg_trg_DVIC_1, Condition(Trig_DVIC_1_Conditions))
    TriggerAddAction(gg_trg_DVIC_1, Trig_DVIC_1_Actions)
end
-- END FOREST SECTION 363

-- BEGIN FOREST SECTION 364 Ext_On
-- Original JASS function: Trig_Ext_On_Actions (line 19933)
function Trig_Ext_On_Actions()
    EnableTrigger(gg_trg_Extermination)
end

-- Original JASS function: InitTrig_Ext_On (line 19938)
function InitTrig_Ext_On()
    gg_trg_Ext_On = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_Ext_On, __jreal(65.00))
    TriggerAddAction(gg_trg_Ext_On, Trig_Ext_On_Actions)
end
-- END FOREST SECTION 364

-- BEGIN FOREST SECTION 365 Extermination
-- Original JASS function: Trig_Extermination_Conditions (line 19947)
function Trig_Extermination_Conditions()
    if ((not ((udg_StillAlive == 0)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Extermination_Actions (line 19954)
function Trig_Extermination_Actions()
    PlayThematicMusicBJ("UndeadVictory")
    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_7280")
    DisplayTimedTextToForce(GetPlayersAll(), __jreal(120.00), "TRIGSTR_9243")
    DisableTrigger(GetTriggeringTrigger())
    TriggerSleepAction(__jreal(120.00))
    FE_Roles.finishMatch(true, "TRIGSTR_7269")
end

-- Original JASS function: InitTrig_Extermination (line 19974)
function InitTrig_Extermination()
    gg_trg_Extermination = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(gg_trg_Extermination, __jreal(10.00))
    TriggerAddCondition(gg_trg_Extermination, Condition(Trig_Extermination_Conditions))
    TriggerAddAction(gg_trg_Extermination, Trig_Extermination_Actions)
end
-- END FOREST SECTION 365
-- END FOREST MODULE src/game/victory.lua

-- BEGIN FOREST MODULE src/economy/base_flags.lua
-- economy / base_flags
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 366 Base_List_Init
-- Original JASS function: Trig_Base_List_Init_Actions (line 19984)
function Trig_Base_List_Init_Actions()
    udg_GARATHORbaseList[1] = gg_rct_Base_1
    udg_GARATHORbaseList[2] = gg_rct_Base_2
    udg_GARATHORbaseList[3] = gg_rct_Base_3
    udg_GARATHORbaseList[4] = gg_rct_Base_4
    udg_GARATHORbaseList[5] = gg_rct_Base_5
    udg_GARATHORbaseList[6] = gg_rct_Base_6
    udg_GARATHORbaseList[7] = gg_rct_Base_7
    udg_GARATHORbaseList[8] = gg_rct_Base_8
    udg_GARATHORbaseList[9] = gg_rct_Base_9
    udg_GARATHORbaseList[10] = gg_rct_Base_10
end

-- Original JASS function: InitTrig_Base_List_Init (line 19998)
function InitTrig_Base_List_Init()
    gg_trg_Base_List_Init = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_Base_List_Init, __jreal(5))
    TriggerAddAction(gg_trg_Base_List_Init, Trig_Base_List_Init_Actions)
end
-- END FOREST SECTION 366

-- BEGIN FOREST SECTION 367 Flagstack_Deny
-- Original JASS function: Trig_Flagstack_Deny_IsFlag (line 20007)
function Trig_Flagstack_Deny_IsFlag(u)
    local id = GetUnitTypeId(u)
    if (id == FourCC("h04Z")) then
        do return true end
    end
    if (id == FourCC("h050")) then
        do return true end
    end
    if (id == FourCC("h05P")) then
        do return true end
    end
    if (id == FourCC("h04Y")) then
        do return true end
    end
    if (id == FourCC("h04V")) then
        do return true end
    end
    if (id == FourCC("h04W")) then
        do return true end
    end
    if (id == FourCC("h05N")) then
        do return true end
    end
    if (id == FourCC("h04X")) then
        do return true end
    end
    if (id == FourCC("h051")) then
        do return true end
    end
    if (id == FourCC("h052")) then
        do return true end
    end
    do return false end
end

-- Original JASS function: Trig_Flagstack_Deny_Conditions (line 20044)
function Trig_Flagstack_Deny_Conditions()
    do return Trig_Flagstack_Deny_IsFlag(GetTriggerUnit()) end
end

-- Original JASS function: Trig_Flagstack_Deny_BaseHasOtherFlag (line 20048)
function Trig_Flagstack_Deny_BaseHasOtherFlag(r, newFlag)
    local g = CreateGroup()
    local u = nil
    local result = false
    GroupEnumUnitsInRect(g, r, nil)
    while true do
        u = FirstOfGroup(g)
        if ((u == nil) or result) then break end
        GroupRemoveUnit(g, u)
        if ((((u ~= newFlag) and (GetWidgetLife(u) > __jreal(0.405))) and (not IsUnitType(u, UNIT_TYPE_DEAD))) and Trig_Flagstack_Deny_IsFlag(u)) then
            result = true
        end
    end
    DestroyGroup(g)
    g = nil
    u = nil
    newFlag = nil
    do return result end
end

-- Original JASS function: Trig_Flagstack_Deny_Actions (line 20075)
function Trig_Flagstack_Deny_Actions()
    local newFlag = GetTriggerUnit()
    local i = 1
    local e = nil
    while true do
        if (i > 10) then break end
        if RectContainsUnit(udg_GARATHORbaseList[i], newFlag) then
            if Trig_Flagstack_Deny_BaseHasOtherFlag(udg_GARATHORbaseList[i], newFlag) then
                e = AddSpecialEffect("Abilities\\Spells\\Human\\ThunderClap\\ThunderClapCaster.mdl", GetUnitX(newFlag), GetUnitY(newFlag))
                DestroyEffect(e)
                KillUnit(newFlag)
                AdjustPlayerStateBJ(2000, GetOwningPlayer(newFlag), PLAYER_STATE_RESOURCE_LUMBER)
                DisplayTimedTextToForce(GetForceOfPlayer(GetOwningPlayer(newFlag)), __jreal(2.00), "TRIGSTR_6274")
            end
            e = nil
            newFlag = nil
            do return end
        end
        i = __jint(i + 1)
    end
    e = nil
    newFlag = nil
end

-- Original JASS function: InitTrig_Flagstack_Deny (line 20105)
function InitTrig_Flagstack_Deny()
    gg_trg_Flagstack_Deny = CreateTrigger()
    TriggerRegisterEnterRectSimple(gg_trg_Flagstack_Deny, GetPlayableMapRect())
    TriggerAddCondition(gg_trg_Flagstack_Deny, Condition(Trig_Flagstack_Deny_Conditions))
    TriggerAddAction(gg_trg_Flagstack_Deny, Trig_Flagstack_Deny_Actions)
end
-- END FOREST SECTION 367

-- BEGIN FOREST SECTION 368 Flag_no_base_Deny
-- Original JASS function: Trig_Flag_no_base_Deny_Func001C (line 20115)
function Trig_Flag_no_base_Deny_Func001C()
    if (((GetUnitTypeId(GetConstructingStructure()) == FourCC("h04Z")))) then
        do return true end
    end
    if (((GetUnitTypeId(GetConstructingStructure()) == FourCC("h050")))) then
        do return true end
    end
    if (((GetUnitTypeId(GetConstructingStructure()) == FourCC("h05P")))) then
        do return true end
    end
    if (((GetUnitTypeId(GetConstructingStructure()) == FourCC("h04Y")))) then
        do return true end
    end
    if (((GetUnitTypeId(GetConstructingStructure()) == FourCC("h04V")))) then
        do return true end
    end
    if (((GetUnitTypeId(GetConstructingStructure()) == FourCC("h04W")))) then
        do return true end
    end
    if (((GetUnitTypeId(GetConstructingStructure()) == FourCC("h05N")))) then
        do return true end
    end
    if (((GetUnitTypeId(GetConstructingStructure()) == FourCC("h04X")))) then
        do return true end
    end
    if (((GetUnitTypeId(GetConstructingStructure()) == FourCC("h051")))) then
        do return true end
    end
    if (((GetUnitTypeId(GetConstructingStructure()) == FourCC("h052")))) then
        do return true end
    end
    do return false end
end

-- Original JASS function: Trig_Flag_no_base_Deny_Conditions (line 20149)
function Trig_Flag_no_base_Deny_Conditions()
    if ((not Trig_Flag_no_base_Deny_Func001C())) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Flag_no_base_Deny_Func002C (line 20156)
function Trig_Flag_no_base_Deny_Func002C()
    if ((not ((RectContainsUnit(udg_GARATHORbaseList[1], GetConstructingStructure()) == false)))) then
        do return false end
    end
    if ((not ((RectContainsUnit(udg_GARATHORbaseList[2], GetConstructingStructure()) == false)))) then
        do return false end
    end
    if ((not ((RectContainsUnit(udg_GARATHORbaseList[3], GetConstructingStructure()) == false)))) then
        do return false end
    end
    if ((not ((RectContainsUnit(udg_GARATHORbaseList[4], GetConstructingStructure()) == false)))) then
        do return false end
    end
    if ((not ((RectContainsUnit(udg_GARATHORbaseList[5], GetConstructingStructure()) == false)))) then
        do return false end
    end
    if ((not ((RectContainsUnit(udg_GARATHORbaseList[6], GetConstructingStructure()) == false)))) then
        do return false end
    end
    if ((not ((RectContainsUnit(udg_GARATHORbaseList[7], GetConstructingStructure()) == false)))) then
        do return false end
    end
    if ((not ((RectContainsUnit(udg_GARATHORbaseList[8], GetConstructingStructure()) == false)))) then
        do return false end
    end
    if ((not ((RectContainsUnit(udg_GARATHORbaseList[9], GetConstructingStructure()) == false)))) then
        do return false end
    end
    if ((not ((RectContainsUnit(udg_GARATHORbaseList[10], GetConstructingStructure()) == false)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Flag_no_base_Deny_Actions (line 20190)
function Trig_Flag_no_base_Deny_Actions()
    if (Trig_Flag_no_base_Deny_Func002C()) then
        AddSpecialEffectLocBJ(GetUnitLoc(GetConstructingStructure()), "Abilities\\Spells\\Human\\ThunderClap\\ThunderClapCaster.mdl")
        SetPlayerStateBJ(GetOwningPlayer(GetTriggerUnit()), PLAYER_STATE_RESOURCE_LUMBER, (__jint(GetPlayerState(Player(0), PLAYER_STATE_RESOURCE_LUMBER) + 2000)))
        DisplayTextToForce(GetForceOfPlayer(GetOwningPlayer(GetTriggerUnit())), "TRIGSTR_6233")
        RemoveUnit(GetConstructingStructure())
    else
    end
end

-- Original JASS function: InitTrig_Flag_no_base_Deny (line 20201)
function InitTrig_Flag_no_base_Deny()
    gg_trg_Flag_no_base_Deny = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Flag_no_base_Deny, EVENT_PLAYER_UNIT_CONSTRUCT_START)
    TriggerAddCondition(gg_trg_Flag_no_base_Deny, Condition(Trig_Flag_no_base_Deny_Conditions))
    TriggerAddAction(gg_trg_Flag_no_base_Deny, Trig_Flag_no_base_Deny_Actions)
end
-- END FOREST SECTION 368

-- BEGIN FOREST SECTION 369 NewFlag
-- Original JASS function: Trig_NewFlag_Conditions (line 20211)
function Trig_NewFlag_Conditions()
    local unitId = GetUnitTypeId(GetConstructedStructure())
    if ((not (((((((((((unitId == FourCC("h04Z")) or (unitId == FourCC("h050"))) or (unitId == FourCC("h04Y"))) or (unitId == FourCC("h04V"))) or (unitId == FourCC("h04W"))) or (unitId == FourCC("h05N"))) or (unitId == FourCC("h04X"))) or (unitId == FourCC("h051"))) or (unitId == FourCC("h052"))) or (unitId == FourCC("h05P")))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_NewFlag_Actions (line 20219)
function Trig_NewFlag_Actions()
    PingMinimapLocForForce(GetPlayersAll(), GetUnitLoc(GetConstructedStructure()), __jreal(5.00))
    DisplayTextToForce(GetPlayersEnemies(FE_Roles.ancient()), "A base flag has been constructed! You will receive 1 gold and 50 lumber every 6 seconds. However, should the base fall, the Ancient will receive 1000 gold!")
    DisplayTextToForce(GetPlayersAllies(FE_Roles.ancient()), "A base flag has been constructed! The enemy expanders will recieve 1 gold and 50 lumber every 6 seconds. However, should you destroy this base, you will recieve 1000 gold! Destroy the base before the expanders get too strong.")
    udg_Flags[GetConvertedPlayerId(GetTriggerPlayer())] = true
end

-- Original JASS function: InitTrig_NewFlag (line 20227)
function InitTrig_NewFlag()
    gg_trg_NewFlag = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_NewFlag, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
    TriggerAddCondition(gg_trg_NewFlag, Condition(Trig_NewFlag_Conditions))
    TriggerAddAction(gg_trg_NewFlag, Trig_NewFlag_Actions)
end
-- END FOREST SECTION 369

-- BEGIN FOREST SECTION 370 NewFlag2
-- Original JASS function: Trig_NewFlag2_Func001Func001Func001A (line 20238)
function Trig_NewFlag2_Func001Func001Func001A()
    AdjustPlayerStateBJ(1, GetEnumPlayer(), PLAYER_STATE_RESOURCE_GOLD)
    AdjustPlayerStateBJ(50, GetEnumPlayer(), PLAYER_STATE_RESOURCE_LUMBER)
end

-- Original JASS function: Trig_NewFlag2_Func001Func001C (line 20243)
function Trig_NewFlag2_Func001Func001C()
    if ((not ((udg_Flags[GetConvertedPlayerId(GetEnumPlayer())] == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_NewFlag2_Func001A (line 20250)
function Trig_NewFlag2_Func001A()
    if (Trig_NewFlag2_Func001Func001C()) then
        ForForce(GetPlayersAllies(GetEnumPlayer()), Trig_NewFlag2_Func001Func001Func001A)
    else
    end
end

-- Original JASS function: Trig_NewFlag2_Actions (line 20257)
function Trig_NewFlag2_Actions()
    ForForce(GetPlayersAll(), Trig_NewFlag2_Func001A)
end

-- Original JASS function: InitTrig_NewFlag2 (line 20262)
function InitTrig_NewFlag2()
    gg_trg_NewFlag2 = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(gg_trg_NewFlag2, __jreal(6.00))
    TriggerAddAction(gg_trg_NewFlag2, Trig_NewFlag2_Actions)
end
-- END FOREST SECTION 370

-- BEGIN FOREST SECTION 371 NewFlag3
-- Original JASS function: Trig_NewFlag3_Conditions (line 20271)
function Trig_NewFlag3_Conditions()
    local unitId = GetUnitTypeId(GetDyingUnit())
    if ((not (((((((((((unitId == FourCC("h04Z")) or (unitId == FourCC("h050"))) or (unitId == FourCC("h04Y"))) or (unitId == FourCC("h04V"))) or (unitId == FourCC("h04W"))) or (unitId == FourCC("h05N"))) or (unitId == FourCC("h04X"))) or (unitId == FourCC("h051"))) or (unitId == FourCC("h052"))) or (unitId == FourCC("h05P")))))) then
        do return false end
    end
    if ((not ((GetUnitTypeId(GetKillingUnitBJ()) ~= 0)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_NewFlag3_Actions (line 20282)
function Trig_NewFlag3_Actions()
    PingMinimapLocForForce(GetPlayersAll(), GetUnitLoc(GetDyingUnit()), __jreal(5.00))
    DisplayTextToForce(GetPlayersEnemies(FE_Roles.ancient()), "TRIGSTR_1774")
    DisplayTextToForce(GetPlayersAllies(FE_Roles.ancient()), "TRIGSTR_1824")
    udg_Flags[GetConvertedPlayerId(GetOwningPlayer(GetDyingUnit()))] = false
end

-- Original JASS function: InitTrig_NewFlag3 (line 20290)
function InitTrig_NewFlag3()
    gg_trg_NewFlag3 = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_NewFlag3, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_NewFlag3, Condition(Trig_NewFlag3_Conditions))
    TriggerAddAction(gg_trg_NewFlag3, Trig_NewFlag3_Actions)
end
-- END FOREST SECTION 371

-- BEGIN FOREST SECTION 372 NewFlag4
-- Original JASS function: Trig_NewFlag4_Conditions (line 20301)
function Trig_NewFlag4_Conditions()
    local unitId = GetUnitTypeId(GetConstructingStructure())
    if ((not ((udg_Flags[GetConvertedPlayerId(GetOwningPlayer(GetConstructingStructure()))] == true)))) then
        do return false end
    end
    if ((not (((((((((((unitId == FourCC("h04Z")) or (unitId == FourCC("h050"))) or (unitId == FourCC("h04Y"))) or (unitId == FourCC("h04V"))) or (unitId == FourCC("h04W"))) or (unitId == FourCC("h05N"))) or (unitId == FourCC("h04X"))) or (unitId == FourCC("h051"))) or (unitId == FourCC("h052"))) or (unitId == FourCC("h05P")))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_NewFlag4_Actions (line 20313)
function Trig_NewFlag4_Actions()
    udg_Flag = GetOwningPlayer(GetTriggerUnit())
    IssueImmediateOrderBJ(GetTriggerUnit(), "stop")
    KillUnit(GetConstructingStructure())
    SetPlayerStateBJ(udg_Flag, PLAYER_STATE_RESOURCE_LUMBER, (__jint(GetPlayerState(udg_Flag, PLAYER_STATE_RESOURCE_LUMBER) + 2000)))
    DisplayTextToForce(GetForceOfPlayer(udg_Flag), "You have already constructed a base flag!")
end

-- Original JASS function: InitTrig_NewFlag4 (line 20322)
function InitTrig_NewFlag4()
    gg_trg_NewFlag4 = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_NewFlag4, EVENT_PLAYER_UNIT_CONSTRUCT_START)
    TriggerAddCondition(gg_trg_NewFlag4, Condition(Trig_NewFlag4_Conditions))
    TriggerAddAction(gg_trg_NewFlag4, Trig_NewFlag4_Actions)
end
-- END FOREST SECTION 372

-- BEGIN FOREST SECTION 373 NewFlag5
-- Original JASS function: Trig_NewFlag5_Conditions (line 20333)
function Trig_NewFlag5_Conditions()
    local unitId = GetUnitTypeId(GetAttackedUnitBJ())
    if ((not (((((((((((unitId == FourCC("h04Z")) or (unitId == FourCC("h050"))) or (unitId == FourCC("h04Y"))) or (unitId == FourCC("h04V"))) or (unitId == FourCC("h04W"))) or (unitId == FourCC("h05N"))) or (unitId == FourCC("h04X"))) or (unitId == FourCC("h051"))) or (unitId == FourCC("h052"))) or (unitId == FourCC("h05P")))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_NewFlag5_Func001C (line 20341)
function Trig_NewFlag5_Func001C()
    if ((not ((GetOwningPlayer(GetAttacker()) == FE_Roles.ancient())))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_NewFlag5_Actions (line 20348)
function Trig_NewFlag5_Actions()
    if (Trig_NewFlag5_Func001C()) then
        DoNothing()
    else
        IssueImmediateOrderBJ(GetAttacker(), "stop")
    end
end

-- Original JASS function: InitTrig_NewFlag5 (line 20357)
function InitTrig_NewFlag5()
    gg_trg_NewFlag5 = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_NewFlag5, EVENT_PLAYER_UNIT_ATTACKED)
    TriggerAddCondition(gg_trg_NewFlag5, Condition(Trig_NewFlag5_Conditions))
    TriggerAddAction(gg_trg_NewFlag5, Trig_NewFlag5_Actions)
end
-- END FOREST SECTION 373
-- END FOREST MODULE src/economy/base_flags.lua

-- BEGIN FOREST MODULE src/items/mech_blaster.lua
-- items / mech_blaster
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 374 Gobo_Mech_Blaster_pickup
-- Original JASS function: Trig_Gobo_Mech_Blaster_pickup_Conditions (line 20368)
function Trig_Gobo_Mech_Blaster_pickup_Conditions()
    if ((not ((GetItemTypeId(GetManipulatedItem()) == FourCC("I00Q"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Gobo_Mech_Blaster_pickup_Func001C (line 20375)
function Trig_Gobo_Mech_Blaster_pickup_Func001C()
    if ((not ((IsUnitType(GetTriggerUnit(), UNIT_TYPE_MELEE_ATTACKER) == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Gobo_Mech_Blaster_pickup_Actions (line 20382)
function Trig_Gobo_Mech_Blaster_pickup_Actions()
    if (Trig_Gobo_Mech_Blaster_pickup_Func001C()) then
        SetUnitAbilityLevelSwapped(FourCC("A0DP"), GetTriggerUnit(), 2)
    else
        SetUnitAbilityLevelSwapped(FourCC("A0DP"), GetTriggerUnit(), 1)
    end
end

-- Original JASS function: InitTrig_Gobo_Mech_Blaster_pickup (line 20391)
function InitTrig_Gobo_Mech_Blaster_pickup()
    gg_trg_Gobo_Mech_Blaster_pickup = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Gobo_Mech_Blaster_pickup, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    TriggerAddCondition(gg_trg_Gobo_Mech_Blaster_pickup, Condition(Trig_Gobo_Mech_Blaster_pickup_Conditions))
    TriggerAddAction(gg_trg_Gobo_Mech_Blaster_pickup, Trig_Gobo_Mech_Blaster_pickup_Actions)
end
-- END FOREST SECTION 374

-- BEGIN FOREST SECTION 375 Gobo_Mech_Blaster_attack_check
-- Original JASS function: Trig_Gobo_Mech_Blaster_attack_check_Conditions (line 20403)
function Trig_Gobo_Mech_Blaster_attack_check_Conditions()
    if ((not ((UnitHasItemOfTypeBJ(udg_DamageEventSource, FourCC("I00Q")) == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Gobo_Mech_Blaster_attack_check_Func001C (line 20410)
function Trig_Gobo_Mech_Blaster_attack_check_Func001C()
    if ((not ((IsUnitType(udg_DamageFilterSource, UNIT_TYPE_MELEE_ATTACKER) == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Gobo_Mech_Blaster_attack_check_Actions (line 20417)
function Trig_Gobo_Mech_Blaster_attack_check_Actions()
    if (Trig_Gobo_Mech_Blaster_attack_check_Func001C()) then
        SetUnitAbilityLevelSwapped(FourCC("A0DP"), udg_DamageEventSource, 2)
    else
        SetUnitAbilityLevelSwapped(FourCC("A0DP"), udg_DamageEventSource, 1)
    end
end

-- Original JASS function: InitTrig_Gobo_Mech_Blaster_attack_check (line 20426)
function InitTrig_Gobo_Mech_Blaster_attack_check()
    gg_trg_Gobo_Mech_Blaster_attack_check = CreateTrigger()
    h__TriggerRegisterVariableEvent(gg_trg_Gobo_Mech_Blaster_attack_check, "udg_DamageModifierEvent", EQUAL, __jreal(1.00))
    TriggerAddCondition(gg_trg_Gobo_Mech_Blaster_attack_check, Condition(Trig_Gobo_Mech_Blaster_attack_check_Conditions))
    TriggerAddAction(gg_trg_Gobo_Mech_Blaster_attack_check, Trig_Gobo_Mech_Blaster_attack_check_Actions)
end
-- END FOREST SECTION 375
-- END FOREST MODULE src/items/mech_blaster.lua























































































































































































































































































































































































-- BEGIN FOREST MODULE src/bootstrap.lua
-- Runs after editor-generated sounds, regions, destructables, units and InitBlizzard.
function InitTrig_FE_Bootstrap()
    ExecuteFunc("jasshelper__initstructs149790140")
    ExecuteFunc("PassiveMissiles__Init")
    ExecuteFunc("SpellLeech__Init")
    FE_InitGlobals()
    FE_InitCustomTriggers()
    FE_Recipes.init()
    FE_Shops.init()
    FE_Test.init()
    FE_RunInitializationTriggers()
end
-- END FOREST MODULE src/bootstrap.lua

-- BEGIN WORLD EDITOR GENERATED FUNCTIONS
function Doodad001056_DropItems()
    local trigWidget = nil
    local trigUnit = nil
    local itemID = 0
    local canDrop = true
    trigWidget = bj_lastDyingWidget
    if ((trigWidget == nil)) then
        trigUnit = GetTriggerUnit()
    end
    if ((trigUnit ~= nil)) then
        canDrop = (not IsUnitHidden(trigUnit))
        if ((canDrop and (GetChangingUnit() ~= nil))) then
            canDrop = ((GetChangingUnitPrevOwner() == Player(PLAYER_NEUTRAL_AGGRESSIVE)))
        end
    end
    if (canDrop) then
        RandomDistReset()
        RandomDistAddItem(FourCC("I02C"), 100)
        itemID = RandomDistChoose()
        if ((trigUnit ~= nil)) then
            UnitDropItem(trigUnit, itemID)
        else
            WidgetDropItem(trigWidget, itemID)
        end
    end
    bj_lastDyingWidget = nil
    DestroyTrigger(GetTriggeringTrigger())
end

function InitSounds()
    gg_snd_VarimathrasYes1 = CreateSound("Units\\Undead\\Varimathras\\VarimathrasYes1.wav", false, false, false, 10, 10, "DefaultEAXON")
    SetSoundDuration(gg_snd_VarimathrasYes1, 1352)
    SetSoundChannel(gg_snd_VarimathrasYes1, 0)
    SetSoundVolume(gg_snd_VarimathrasYes1, __jint(-(1)))
    SetSoundPitch(gg_snd_VarimathrasYes1, __jreal(1.0))
    gg_snd_PeasantDeath = CreateSound("Units\\Human\\Peasant\\PeasantDeath.wav", false, false, false, 10, 10, "DefaultEAXON")
    SetSoundDuration(gg_snd_PeasantDeath, 3645)
    SetSoundChannel(gg_snd_PeasantDeath, 0)
    SetSoundVolume(gg_snd_PeasantDeath, __jint(-(1)))
    SetSoundPitch(gg_snd_PeasantDeath, __jreal(1.0))
    gg_snd_CentaurDeath = CreateSound("Units\\Creeps\\Centaur\\CentaurDeath.wav", false, false, false, 10, 10, "DefaultEAXON")
    SetSoundDuration(gg_snd_CentaurDeath, 2005)
    SetSoundChannel(gg_snd_CentaurDeath, 0)
    SetSoundVolume(gg_snd_CentaurDeath, __jint(-(1)))
    SetSoundPitch(gg_snd_CentaurDeath, __jreal(1.0))
    gg_snd_WispPissed1 = CreateSound("Units\\NightElf\\Wisp\\WispPissed1.wav", false, false, false, 10, 10, "DefaultEAXON")
    SetSoundDuration(gg_snd_WispPissed1, 2797)
    SetSoundChannel(gg_snd_WispPissed1, 0)
    SetSoundVolume(gg_snd_WispPissed1, __jint(-(1)))
    SetSoundPitch(gg_snd_WispPissed1, __jreal(1.0))
    gg_snd_WarlockDeath1 = CreateSound("Units\\Demon\\Warlock\\WarlockDeath1.wav", false, false, false, 10, 10, "DefaultEAXON")
    SetSoundDuration(gg_snd_WarlockDeath1, 3430)
    SetSoundChannel(gg_snd_WarlockDeath1, 0)
    SetSoundVolume(gg_snd_WarlockDeath1, __jint(-(1)))
    SetSoundPitch(gg_snd_WarlockDeath1, __jreal(0.5))
    gg_snd_OgreDeath1 = CreateSound("Units\\Creeps\\Ogre\\OgreDeath1.wav", false, false, false, 10, 10, "DefaultEAXON")
    SetSoundDuration(gg_snd_OgreDeath1, 2059)
    SetSoundChannel(gg_snd_OgreDeath1, 0)
    SetSoundVolume(gg_snd_OgreDeath1, __jint(-(1)))
    SetSoundPitch(gg_snd_OgreDeath1, __jreal(1.0))
    gg_snd_HeroFirelordDeath1 = CreateSound("Units\\Creeps\\HeroFlameLord\\HeroFirelordDeath1.wav", false, false, false, 10, 10, "DefaultEAXON")
    SetSoundDuration(gg_snd_HeroFirelordDeath1, 2345)
    SetSoundChannel(gg_snd_HeroFirelordDeath1, 0)
    SetSoundVolume(gg_snd_HeroFirelordDeath1, __jint(-(1)))
    SetSoundPitch(gg_snd_HeroFirelordDeath1, __jreal(1.0))
    gg_snd_SatyrDeath1 = CreateSound("Units\\Creeps\\Satyr\\SatyrDeath1.wav", false, false, false, 10, 10, "DefaultEAXON")
    SetSoundDuration(gg_snd_SatyrDeath1, 3565)
    SetSoundChannel(gg_snd_SatyrDeath1, 0)
    SetSoundVolume(gg_snd_SatyrDeath1, __jint(-(1)))
    SetSoundPitch(gg_snd_SatyrDeath1, __jreal(1.0))
    gg_snd_BansheeDeath = CreateSound("Units\\Undead\\Banshee\\BansheeDeath.wav", false, false, false, 10, 10, "DefaultEAXON")
    SetSoundDuration(gg_snd_BansheeDeath, 2379)
    SetSoundChannel(gg_snd_BansheeDeath, 0)
    SetSoundVolume(gg_snd_BansheeDeath, __jint(-(1)))
    SetSoundPitch(gg_snd_BansheeDeath, __jreal(1.0))
    gg_snd_TinkerDeathAlt1 = CreateSound("Units\\Creeps\\HeroTinker\\TinkerDeathAlt1.wav", false, false, false, 10, 10, "DefaultEAXON")
    SetSoundDuration(gg_snd_TinkerDeathAlt1, 3088)
    SetSoundChannel(gg_snd_TinkerDeathAlt1, 0)
    SetSoundVolume(gg_snd_TinkerDeathAlt1, __jint(-(1)))
    SetSoundPitch(gg_snd_TinkerDeathAlt1, __jreal(1.0))
    gg_snd_FurbolgDeath1 = CreateSound("Units\\Creeps\\Furbolg\\FurbolgDeath1.wav", false, false, false, 10, 10, "DefaultEAXON")
    SetSoundDuration(gg_snd_FurbolgDeath1, 2798)
    SetSoundChannel(gg_snd_FurbolgDeath1, 0)
    SetSoundVolume(gg_snd_FurbolgDeath1, __jint(-(1)))
    SetSoundPitch(gg_snd_FurbolgDeath1, __jreal(1.0))
    gg_snd_PitFiendDeath1 = CreateSound("Units\\Undead\\CryptFiend\\PitFiendDeath1.wav", false, false, false, 10, 10, "DefaultEAXON")
    SetSoundDuration(gg_snd_PitFiendDeath1, 2792)
    SetSoundChannel(gg_snd_PitFiendDeath1, 0)
    SetSoundVolume(gg_snd_PitFiendDeath1, __jint(-(1)))
    SetSoundPitch(gg_snd_PitFiendDeath1, __jreal(1.0))
    gg_snd_HydraDeath1 = CreateSound("Units\\Creeps\\Hydra\\HydraDeath1.wav", false, false, false, 10, 10, "DefaultEAXON")
    SetSoundDuration(gg_snd_HydraDeath1, 3002)
    SetSoundChannel(gg_snd_HydraDeath1, 0)
    SetSoundVolume(gg_snd_HydraDeath1, __jint(-(1)))
    SetSoundPitch(gg_snd_HydraDeath1, __jreal(1.0))
    gg_snd_KoboldDeath = CreateSound("Units\\Creeps\\Kobold\\KoboldDeath.wav", false, false, false, 10, 10, "DefaultEAXON")
    SetSoundDuration(gg_snd_KoboldDeath, 2075)
    SetSoundChannel(gg_snd_KoboldDeath, 0)
    SetSoundVolume(gg_snd_KoboldDeath, __jint(-(1)))
    SetSoundPitch(gg_snd_KoboldDeath, __jreal(1.0))
    gg_snd_QuillboarDeath = CreateSound("Units\\Creeps\\QuillBeast\\QuillboarDeath.wav", false, false, false, 10, 10, "DefaultEAXON")
    SetSoundDuration(gg_snd_QuillboarDeath, 1529)
    SetSoundChannel(gg_snd_QuillboarDeath, 0)
    SetSoundVolume(gg_snd_QuillboarDeath, __jint(-(1)))
    SetSoundPitch(gg_snd_QuillboarDeath, __jreal(1.0))
    gg_snd_FacelessDeath1 = CreateSound("Units\\Creeps\\FacelessOne\\FacelessDeath1.wav", false, false, false, 10, 10, "DefaultEAXON")
    SetSoundDuration(gg_snd_FacelessDeath1, 1979)
    SetSoundChannel(gg_snd_FacelessDeath1, 0)
    SetSoundVolume(gg_snd_FacelessDeath1, __jint(-(1)))
    SetSoundPitch(gg_snd_FacelessDeath1, __jreal(0.8))
    gg_snd_WendigoDeath = CreateSound("Units\\Creeps\\Wendigo\\WendigoDeath.wav", false, false, false, 10, 10, "DefaultEAXON")
    SetSoundDuration(gg_snd_WendigoDeath, 2147)
    SetSoundChannel(gg_snd_WendigoDeath, 0)
    SetSoundVolume(gg_snd_WendigoDeath, __jint(-(1)))
    SetSoundPitch(gg_snd_WendigoDeath, __jreal(1.0))
    gg_snd_DemonHunterDeathAlternate1 = CreateSound("Units/NightElf/HeroDemonHunter/DemonHunterDeathAlternate1.flac", false, true, true, 0, 0, "HeroAcksEAX")
    SetSoundParamsFromLabel(gg_snd_DemonHunterDeathAlternate1, "HeroDemonHunterDeathAlternate")
    SetSoundDuration(gg_snd_DemonHunterDeathAlternate1, 2002)
    SetSoundVolume(gg_snd_DemonHunterDeathAlternate1, 127)
    gg_snd_DruidOfTheTalonDeath1 = CreateSound("Units/NightElf/DruidOfTheTalon/DruidOfTheTalonDeath1.flac", false, true, true, 0, 0, "DefaultEAXON")
    SetSoundParamsFromLabel(gg_snd_DruidOfTheTalonDeath1, "DruidOfTheTalonDeath")
    SetSoundDuration(gg_snd_DruidOfTheTalonDeath1, 4597)
    SetSoundVolume(gg_snd_DruidOfTheTalonDeath1, 127)
    gg_snd_GhoulDeath = CreateSound("Units/Undead/Ghoul/GhoulDeath.flac", false, true, true, 0, 0, "DefaultEAXON")
    SetSoundParamsFromLabel(gg_snd_GhoulDeath, "GhoulDeath")
    SetSoundDuration(gg_snd_GhoulDeath, 1570)
    SetSoundVolume(gg_snd_GhoulDeath, 127)
    gg_snd_HeroDemonHunterDeath1 = CreateSound("Units/NightElf/HeroDemonHunter/HeroDemonHunterDeath1.flac", false, true, true, 1, 1, "HeroAcksEAX")
    SetSoundParamsFromLabel(gg_snd_HeroDemonHunterDeath1, "HeroDemonHunterDeath")
    SetSoundDuration(gg_snd_HeroDemonHunterDeath1, 4133)
    SetSoundVolume(gg_snd_HeroDemonHunterDeath1, 127)
    gg_snd_RiflemanDeath = CreateSound("Units/Human/Rifleman/RiflemanDeath.flac", false, true, true, 0, 0, "DefaultEAXON")
    SetSoundParamsFromLabel(gg_snd_RiflemanDeath, "RiflemanDeath")
    SetSoundDuration(gg_snd_RiflemanDeath, 1770)
    SetSoundVolume(gg_snd_RiflemanDeath, 127)
    gg_snd_DuneWormDeath1 = CreateSound("Units/Critters/DuneWorm/DuneWormDeath1.flac", false, true, true, 0, 0, "DefaultEAXON")
    SetSoundParamsFromLabel(gg_snd_DuneWormDeath1, "DuneWormDeath")
    SetSoundDuration(gg_snd_DuneWormDeath1, 2885)
    SetSoundVolume(gg_snd_DuneWormDeath1, 127)
    gg_snd_CycloneLoop1 = CreateSound("Abilities/Spells/NightElf/Cyclone/CycloneLoop1.flac", false, true, true, 1, 1, "SpellsEAX")
    SetSoundParamsFromLabel(gg_snd_CycloneLoop1, "CycloneLoop")
    SetSoundDuration(gg_snd_CycloneLoop1, 4003)
    SetSoundVolume(gg_snd_CycloneLoop1, 127)
    gg_snd_CycloneDeath1 = CreateSound("Abilities/Spells/NightElf/Cyclone/CycloneDeath1.flac", false, true, true, 1, 1, "SpellsEAX")
    SetSoundParamsFromLabel(gg_snd_CycloneDeath1, "CycloneDeath")
    SetSoundDuration(gg_snd_CycloneDeath1, 2136)
    SetSoundVolume(gg_snd_CycloneDeath1, 60)
    gg_snd_KaelYesAttack3 = CreateSound("Units/Human/Kael/KaelYesAttack3.flac", false, true, true, 0, 0, "HeroAcksEAX")
    SetSoundParamsFromLabel(gg_snd_KaelYesAttack3, "KaelYesAttack")
    SetSoundDuration(gg_snd_KaelYesAttack3, 1634)
    SetSoundVolume(gg_snd_KaelYesAttack3, 127)
end

function CreateAllDestructables()
    local d = nil
    local t = nil
    local life = 0.0
    d = BlzCreateDestructableZWithSkin(FourCC("LTbr"), __jreal(6560.0), __jreal(6816.0), __jreal(132.0), __jreal(178.000), __jreal(1.110), 0, FourCC("LTbr"))
    t = CreateTrigger()
    TriggerRegisterDeathEvent(t, d)
    TriggerAddAction(t, SaveDyingWidget)
    TriggerAddAction(t, Doodad001056_DropItems)
end

function CreateUnitsForPlayer0()
    local p = Player(0)
    local u = nil
    local unitID = 0
    local t = nil
    local life = 0.0
    u = BlzCreateUnitWithSkin(p, FourCC("ewsp"), __jreal(6785.4), __jreal(7161.1), __jreal(311.219), FourCC("ewsp"))
end

function CreateUnitsForPlayer1()
    local p = Player(1)
    local u = nil
    local unitID = 0
    local t = nil
    local life = 0.0
    u = BlzCreateUnitWithSkin(p, FourCC("ewsp"), __jreal(6814.8), __jreal(7191.4), __jreal(72.545), FourCC("ewsp"))
end

function CreateUnitsForPlayer2()
    local p = Player(2)
    local u = nil
    local unitID = 0
    local t = nil
    local life = 0.0
    u = BlzCreateUnitWithSkin(p, FourCC("ewsp"), __jreal(6783.5), __jreal(7170.7), __jreal(223.688), FourCC("ewsp"))
end

function CreateUnitsForPlayer3()
    local p = Player(3)
    local u = nil
    local unitID = 0
    local t = nil
    local life = 0.0
    u = BlzCreateUnitWithSkin(p, FourCC("ewsp"), __jreal(6832.2), __jreal(7179.2), __jreal(125.742), FourCC("ewsp"))
end

function CreateUnitsForPlayer4()
    local p = Player(4)
    local u = nil
    local unitID = 0
    local t = nil
    local life = 0.0
    u = BlzCreateUnitWithSkin(p, FourCC("ewsp"), __jreal(6804.7), __jreal(7159.1), __jreal(90.816), FourCC("ewsp"))
end

function CreateUnitsForPlayer5()
    local p = Player(5)
    local u = nil
    local unitID = 0
    local t = nil
    local life = 0.0
    u = BlzCreateUnitWithSkin(p, FourCC("ewsp"), __jreal(6827.8), __jreal(7152.9), __jreal(329.336), FourCC("ewsp"))
end

function CreateBuildingsForPlayer6()
    local p = Player(6)
    local u = nil
    local unitID = 0
    local t = nil
    local life = 0.0
    u = BlzCreateUnitWithSkin(p, FourCC("h02B"), (-(__jreal(1216.0))), (-(__jreal(192.0))), __jreal(270.000), FourCC("h02B"))
    u = BlzCreateUnitWithSkin(p, FourCC("n000"), __jreal(0.0), __jreal(832.0), __jreal(270.000), FourCC("n000"))
    u = BlzCreateUnitWithSkin(p, FourCC("n00A"), (-(__jreal(384.0))), __jreal(256.0), __jreal(270.000), FourCC("n00A"))
    u = BlzCreateUnitWithSkin(p, FourCC("h05B"), (-(__jreal(768.0))), __jreal(128.0), __jreal(270.000), FourCC("h05B"))
    gg_unit_n00B_0266 = BlzCreateUnitWithSkin(p, FourCC("n00B"), (-(__jreal(1216.0))), __jreal(512.0), __jreal(270.000), FourCC("n00B"))
end

function CreateUnitsForPlayer6()
    local p = Player(6)
    local u = nil
    local unitID = 0
    local t = nil
    local life = 0.0
    u = BlzCreateUnitWithSkin(p, FourCC("ewsp"), __jreal(7652.9), __jreal(7309.1), __jreal(170.810), FourCC("ewsp"))
end

function CreateUnitsForPlayer7()
    local p = Player(7)
    local u = nil
    local unitID = 0
    local t = nil
    local life = 0.0
    u = BlzCreateUnitWithSkin(p, FourCC("ewsp"), __jreal(6788.3), __jreal(7144.7), __jreal(65.349), FourCC("ewsp"))
end

function CreateUnitsForPlayer8()
    local p = Player(8)
    local u = nil
    local unitID = 0
    local t = nil
    local life = 0.0
    u = BlzCreateUnitWithSkin(p, FourCC("ewsp"), __jreal(6831.1), __jreal(7153.0), __jreal(168.931), FourCC("ewsp"))
end

function CreateUnitsForPlayer9()
    local p = Player(9)
    local u = nil
    local unitID = 0
    local t = nil
    local life = 0.0
    u = BlzCreateUnitWithSkin(p, FourCC("ewsp"), __jreal(6794.9), __jreal(7144.5), __jreal(165.646), FourCC("ewsp"))
end

function CreateUnitsForPlayer10()
    local p = Player(10)
    local u = nil
    local unitID = 0
    local t = nil
    local life = 0.0
    u = BlzCreateUnitWithSkin(p, FourCC("ewsp"), __jreal(6815.7), __jreal(7143.3), __jreal(346.574), FourCC("ewsp"))
end

function CreateNeutralHostileBuildings()
    local p = Player(PLAYER_NEUTRAL_AGGRESSIVE)
    local u = nil
    local unitID = 0
    local t = nil
    local life = 0.0
    u = BlzCreateUnitWithSkin(p, FourCC("h00Q"), (-(__jreal(4096.0))), __jreal(6016.0), __jreal(270.000), FourCC("h00Q"))
    u = BlzCreateUnitWithSkin(p, FourCC("h00Q"), __jreal(832.0), __jreal(6272.0), __jreal(270.000), FourCC("h00Q"))
    gg_unit_h00Q_0026 = BlzCreateUnitWithSkin(p, FourCC("h00Q"), (-(__jreal(4480.0))), __jreal(2816.0), __jreal(270.000), FourCC("h00Q"))
    u = BlzCreateUnitWithSkin(p, FourCC("h00Q"), __jreal(7616.0), (-(__jreal(7872.0))), __jreal(270.000), FourCC("h00Q"))
    u = BlzCreateUnitWithSkin(p, FourCC("h00Q"), __jreal(6976.0), __jreal(4416.0), __jreal(270.000), FourCC("h00Q"))
    u = BlzCreateUnitWithSkin(p, FourCC("h00Q"), (-(__jreal(3584.0))), (-(__jreal(4160.0))), __jreal(270.000), FourCC("h00Q"))
    u = BlzCreateUnitWithSkin(p, FourCC("h00Q"), __jreal(4864.0), (-(__jreal(960.0))), __jreal(270.000), FourCC("h00Q"))
end

function CreateNeutralPassiveBuildings()
    local p = Player(PLAYER_NEUTRAL_PASSIVE)
    local u = nil
    local unitID = 0
    local t = nil
    local life = 0.0
    gg_unit_nmer_0000 = BlzCreateUnitWithSkin(p, FourCC("nmer"), __jreal(6976.0), __jreal(7168.0), __jreal(270.000), FourCC("nmer"))
    SetUnitColor(gg_unit_nmer_0000, ConvertPlayerColor(0))
    gg_unit_nmr2_0001 = BlzCreateUnitWithSkin(p, FourCC("nmr2"), __jreal(7680.0), __jreal(7168.0), __jreal(270.000), FourCC("nmr2"))
    SetUnitColor(gg_unit_nmr2_0001, ConvertPlayerColor(12))
    gg_unit_n00G_0035 = BlzCreateUnitWithSkin(p, FourCC("n00G"), __jreal(6656.0), __jreal(7168.0), __jreal(270.000), FourCC("n00G"))
    SetUnitColor(gg_unit_n00G_0035, ConvertPlayerColor(0))
    u = BlzCreateUnitWithSkin(p, FourCC("h03R"), (-(__jreal(4800.0))), __jreal(960.0), __jreal(270.000), FourCC("h03R"))
    WaygateSetDestination(u, GetRectCenterX(gg_rct_Suspicious_Bush_1), GetRectCenterY(gg_rct_Suspicious_Bush_1))
    WaygateActivate(u, true)
    u = BlzCreateUnitWithSkin(p, FourCC("h03R"), (-(__jreal(3264.0))), (-(__jreal(320.0))), __jreal(270.000), FourCC("h03R"))
    WaygateSetDestination(u, GetRectCenterX(gg_rct_Suspicious_Bush_2), GetRectCenterY(gg_rct_Suspicious_Bush_2))
    WaygateActivate(u, true)
end

function CreateNeutralPassive()
    local p = Player(PLAYER_NEUTRAL_PASSIVE)
    local u = nil
    local unitID = 0
    local t = nil
    local life = 0.0
    u = BlzCreateUnitWithSkin(p, FourCC("n00D"), __jreal(646.0), (-(__jreal(5477.8))), __jreal(179.588), FourCC("n00D"))
    u = BlzCreateUnitWithSkin(p, FourCC("n00F"), __jreal(3218.3), __jreal(5330.8), __jreal(80.389), FourCC("n00F"))
    u = BlzCreateUnitWithSkin(p, FourCC("n00I"), (-(__jreal(4433.9))), __jreal(5244.2), __jreal(120.667), FourCC("n00I"))
    u = BlzCreateUnitWithSkin(p, FourCC("n001"), (-(__jreal(1143.1))), (-(__jreal(337.6))), __jreal(257.571), FourCC("n001"))
    u = BlzCreateUnitWithSkin(p, FourCC("n001"), (-(__jreal(1380.1))), (-(__jreal(190.4))), __jreal(328.062), FourCC("n001"))
    u = BlzCreateUnitWithSkin(p, FourCC("n00E"), __jreal(5236.3), (-(__jreal(5638.1))), __jreal(334.247), FourCC("n00E"))
end

function CreatePlayerBuildings()
    CreateBuildingsForPlayer6()
end

function CreatePlayerUnits()
    CreateUnitsForPlayer0()
    CreateUnitsForPlayer1()
    CreateUnitsForPlayer2()
    CreateUnitsForPlayer3()
    CreateUnitsForPlayer4()
    CreateUnitsForPlayer5()
    CreateUnitsForPlayer6()
    CreateUnitsForPlayer7()
    CreateUnitsForPlayer8()
    CreateUnitsForPlayer9()
    CreateUnitsForPlayer10()
end

function CreateAllUnits()
    CreateNeutralHostileBuildings()
    CreateNeutralPassiveBuildings()
    CreateBuildingsForPlayer6()
    CreateNeutralPassive()
    CreatePlayerUnits()
end

function CreateRegions()
    local we = nil
    gg_rct_SpawnDefender = Rect(__jreal(7744.0), __jreal(7136.0), __jreal(7872.0), __jreal(7264.0))
    gg_rct_Tele_out_D = Rect(__jreal(7360.0), __jreal(6752.0), __jreal(7936.0), __jreal(7552.0))
    gg_rct_Tele_out_E = Rect(__jreal(6240.0), __jreal(6784.0), __jreal(7296.0), __jreal(7552.0))
    gg_rct_Spawn_all = Rect((-(__jreal(704.0))), (-(__jreal(64.0))), (-(__jreal(96.0))), __jreal(480.0))
    gg_rct_Alarm = Rect((-(__jreal(640.0))), (-(__jreal(96.0))), (-(__jreal(160.0))), __jreal(480.0))
    gg_rct_Spawner = Rect((-(__jreal(512.0))), __jreal(64.0), (-(__jreal(288.0))), __jreal(320.0))
    gg_rct_Camera_1 = Rect(__jreal(6528.0), __jreal(6944.0), __jreal(7936.0), __jreal(7424.0))
    gg_rct_Respawn = Rect(__jreal(6720.0), __jreal(7200.0), __jreal(8032.0), __jreal(7392.0))
    gg_rct_Ping1 = Rect((-(__jreal(4640.0))), __jreal(2688.0), (-(__jreal(4320.0))), __jreal(2976.0))
    gg_rct_Ping2 = Rect((-(__jreal(4224.0))), __jreal(5888.0), (-(__jreal(4000.0))), __jreal(6112.0))
    gg_rct_Ping3 = Rect(__jreal(672.0), __jreal(6144.0), __jreal(960.0), __jreal(6368.0))
    gg_rct_Ping4 = Rect(__jreal(6592.0), __jreal(4256.0), __jreal(6912.0), __jreal(4416.0))
    gg_rct_Ping5 = Rect(__jreal(7488.0), (-(__jreal(7968.0))), __jreal(7712.0), (-(__jreal(7776.0))))
    gg_rct_Rest_of_Map = Rect((-(__jreal(8192.0))), (-(__jreal(8704.0))), __jreal(8160.0), __jreal(7680.0))
    gg_rct_Ping6 = Rect((-(__jreal(3744.0))), (-(__jreal(4256.0))), (-(__jreal(3456.0))), (-(__jreal(4064.0))))
    gg_rct_AI_Move_1 = Rect((-(__jreal(6784.0))), __jreal(6176.0), (-(__jreal(6560.0))), __jreal(6368.0))
    gg_rct_AI_Move_2 = Rect((-(__jreal(4800.0))), __jreal(4384.0), (-(__jreal(4704.0))), __jreal(4512.0))
    gg_rct_AI_Move_3 = Rect((-(__jreal(4384.0))), __jreal(1248.0), (-(__jreal(4288.0))), __jreal(1344.0))
    gg_rct_AI_Move_4 = Rect((-(__jreal(7008.0))), (-(__jreal(5856.0))), (-(__jreal(6912.0))), (-(__jreal(5760.0))))
    gg_rct_AI_Move_5 = Rect((-(__jreal(4224.0))), (-(__jreal(6080.0))), (-(__jreal(3872.0))), (-(__jreal(5920.0))))
    gg_rct_AI_Move_6 = Rect(__jreal(3936.0), (-(__jreal(4896.0))), __jreal(4128.0), (-(__jreal(4736.0))))
    gg_rct_AI_Move_7 = Rect(__jreal(6048.0), (-(__jreal(7072.0))), __jreal(6272.0), (-(__jreal(6912.0))))
    gg_rct_AI_Move_8 = Rect(__jreal(6464.0), (-(__jreal(224.0))), __jreal(6656.0), (-(__jreal(64.0))))
    gg_rct_AI_Move_9 = Rect(__jreal(3392.0), (-(__jreal(288.0))), __jreal(3552.0), (-(__jreal(128.0))))
    gg_rct_AI_Move_10 = Rect(__jreal(4992.0), __jreal(3136.0), __jreal(5152.0), __jreal(3328.0))
    gg_rct_Suspicious_Bush_1 = Rect((-(__jreal(3360.0))), (-(__jreal(480.0))), (-(__jreal(3200.0))), (-(__jreal(352.0))))
    gg_rct_Suspicious_Bush_2 = Rect((-(__jreal(4768.0))), __jreal(896.0), (-(__jreal(4608.0))), __jreal(1024.0))
    gg_rct_Remove_Selection = Rect(__jreal(6240.0), __jreal(6784.0), __jreal(7936.0), __jreal(7552.0))
    gg_rct_Ping7 = Rect(__jreal(4768.0), (-(__jreal(1056.0))), __jreal(4960.0), (-(__jreal(832.0))))
    gg_rct_Fountain = Rect((-(__jreal(1440.0))), (-(__jreal(544.0))), __jreal(320.0), __jreal(1088.0))
    gg_rct_SeedofR = Rect((-(__jreal(8192.0))), (-(__jreal(8704.0))), (-(__jreal(8000.0))), (-(__jreal(8512.0))))
    gg_rct_Base_1 = Rect((-(__jreal(7872.0))), __jreal(5344.0), (-(__jreal(5216.0))), __jreal(7136.0))
    gg_rct_Base_2 = Rect((-(__jreal(5408.0))), __jreal(3552.0), (-(__jreal(3648.0))), __jreal(4960.0))
    gg_rct_Base_3 = Rect((-(__jreal(4896.0))), __jreal(416.0), (-(__jreal(3424.0))), __jreal(1920.0))
    gg_rct_rawr = Rect((-(__jreal(3680.0))), (-(__jreal(928.0))), (-(__jreal(2656.0))), __jreal(288.0))
    gg_rct_Base_4 = Rect((-(__jreal(7584.0))), (-(__jreal(6176.0))), (-(__jreal(6240.0))), (-(__jreal(3520.0))))
    gg_rct_Base_5 = Rect((-(__jreal(4992.0))), (-(__jreal(7776.0))), (-(__jreal(3200.0))), (-(__jreal(5568.0))))
    gg_rct_Base_6 = Rect(__jreal(3936.0), __jreal(2784.0), __jreal(5920.0), __jreal(5408.0))
    gg_rct_Base_7 = Rect(__jreal(2336.0), (-(__jreal(1120.0))), __jreal(4160.0), __jreal(896.0))
    gg_rct_Base_8 = Rect(__jreal(5856.0), (-(__jreal(1440.0))), __jreal(7360.0), __jreal(512.0))
    gg_rct_Base_9 = Rect(__jreal(3136.0), (-(__jreal(5696.0))), __jreal(4896.0), (-(__jreal(3136.0))))
    gg_rct_Base_10 = Rect(__jreal(4736.0), (-(__jreal(7552.0))), __jreal(7104.0), (-(__jreal(5888.0))))
    gg_rct_ChopChop = Rect((-(__jreal(160.0))), __jreal(2080.0), __jreal(128.0), __jreal(2400.0))
end

function InitCustomPlayerSlots()
    SetPlayerStartLocation(Player(0), 0)
    ForcePlayerStartLocation(Player(0), 0)
    SetPlayerColor(Player(0), ConvertPlayerColor(0))
    SetPlayerRacePreference(Player(0), RACE_PREF_HUMAN)
    SetPlayerRaceSelectable(Player(0), false)
    SetPlayerController(Player(0), MAP_CONTROL_USER)
    SetPlayerStartLocation(Player(1), 1)
    ForcePlayerStartLocation(Player(1), 1)
    SetPlayerColor(Player(1), ConvertPlayerColor(1))
    SetPlayerRacePreference(Player(1), RACE_PREF_HUMAN)
    SetPlayerRaceSelectable(Player(1), false)
    SetPlayerController(Player(1), MAP_CONTROL_USER)
    SetPlayerStartLocation(Player(2), 2)
    ForcePlayerStartLocation(Player(2), 2)
    SetPlayerColor(Player(2), ConvertPlayerColor(2))
    SetPlayerRacePreference(Player(2), RACE_PREF_HUMAN)
    SetPlayerRaceSelectable(Player(2), false)
    SetPlayerController(Player(2), MAP_CONTROL_USER)
    SetPlayerStartLocation(Player(3), 3)
    ForcePlayerStartLocation(Player(3), 3)
    SetPlayerColor(Player(3), ConvertPlayerColor(3))
    SetPlayerRacePreference(Player(3), RACE_PREF_HUMAN)
    SetPlayerRaceSelectable(Player(3), false)
    SetPlayerController(Player(3), MAP_CONTROL_USER)
    SetPlayerStartLocation(Player(4), 4)
    ForcePlayerStartLocation(Player(4), 4)
    SetPlayerColor(Player(4), ConvertPlayerColor(4))
    SetPlayerRacePreference(Player(4), RACE_PREF_HUMAN)
    SetPlayerRaceSelectable(Player(4), false)
    SetPlayerController(Player(4), MAP_CONTROL_USER)
    SetPlayerStartLocation(Player(5), 5)
    ForcePlayerStartLocation(Player(5), 5)
    SetPlayerColor(Player(5), ConvertPlayerColor(5))
    SetPlayerRacePreference(Player(5), RACE_PREF_HUMAN)
    SetPlayerRaceSelectable(Player(5), false)
    SetPlayerController(Player(5), MAP_CONTROL_USER)
    SetPlayerStartLocation(Player(6), 6)
    ForcePlayerStartLocation(Player(6), 6)
    SetPlayerColor(Player(6), ConvertPlayerColor(6))
    SetPlayerRacePreference(Player(6), RACE_PREF_NIGHTELF)
    SetPlayerRaceSelectable(Player(6), false)
    SetPlayerController(Player(6), MAP_CONTROL_USER)
    SetPlayerStartLocation(Player(7), 7)
    ForcePlayerStartLocation(Player(7), 7)
    SetPlayerColor(Player(7), ConvertPlayerColor(7))
    SetPlayerRacePreference(Player(7), RACE_PREF_HUMAN)
    SetPlayerRaceSelectable(Player(7), false)
    SetPlayerController(Player(7), MAP_CONTROL_USER)
    SetPlayerStartLocation(Player(8), 8)
    ForcePlayerStartLocation(Player(8), 8)
    SetPlayerColor(Player(8), ConvertPlayerColor(8))
    SetPlayerRacePreference(Player(8), RACE_PREF_HUMAN)
    SetPlayerRaceSelectable(Player(8), false)
    SetPlayerController(Player(8), MAP_CONTROL_USER)
    SetPlayerStartLocation(Player(9), 9)
    ForcePlayerStartLocation(Player(9), 9)
    SetPlayerColor(Player(9), ConvertPlayerColor(9))
    SetPlayerRacePreference(Player(9), RACE_PREF_HUMAN)
    SetPlayerRaceSelectable(Player(9), false)
    SetPlayerController(Player(9), MAP_CONTROL_USER)
    SetPlayerStartLocation(Player(10), 10)
    ForcePlayerStartLocation(Player(10), 10)
    SetPlayerColor(Player(10), ConvertPlayerColor(10))
    SetPlayerRacePreference(Player(10), RACE_PREF_HUMAN)
    SetPlayerRaceSelectable(Player(10), false)
    SetPlayerController(Player(10), MAP_CONTROL_USER)
end

function InitCustomTeams()
    SetPlayerTeam(Player(0), 0)
    SetPlayerTeam(Player(1), 0)
    SetPlayerTeam(Player(2), 0)
    SetPlayerTeam(Player(3), 0)
    SetPlayerTeam(Player(4), 0)
    SetPlayerTeam(Player(5), 0)
    SetPlayerTeam(Player(7), 0)
    SetPlayerTeam(Player(8), 0)
    SetPlayerTeam(Player(9), 0)
    SetPlayerTeam(Player(10), 0)
    SetPlayerAllianceStateAllyBJ(Player(0), Player(1), true)
    SetPlayerAllianceStateAllyBJ(Player(0), Player(2), true)
    SetPlayerAllianceStateAllyBJ(Player(0), Player(3), true)
    SetPlayerAllianceStateAllyBJ(Player(0), Player(4), true)
    SetPlayerAllianceStateAllyBJ(Player(0), Player(5), true)
    SetPlayerAllianceStateAllyBJ(Player(0), Player(7), true)
    SetPlayerAllianceStateAllyBJ(Player(0), Player(8), true)
    SetPlayerAllianceStateAllyBJ(Player(0), Player(9), true)
    SetPlayerAllianceStateAllyBJ(Player(0), Player(10), true)
    SetPlayerAllianceStateAllyBJ(Player(1), Player(0), true)
    SetPlayerAllianceStateAllyBJ(Player(1), Player(2), true)
    SetPlayerAllianceStateAllyBJ(Player(1), Player(3), true)
    SetPlayerAllianceStateAllyBJ(Player(1), Player(4), true)
    SetPlayerAllianceStateAllyBJ(Player(1), Player(5), true)
    SetPlayerAllianceStateAllyBJ(Player(1), Player(7), true)
    SetPlayerAllianceStateAllyBJ(Player(1), Player(8), true)
    SetPlayerAllianceStateAllyBJ(Player(1), Player(9), true)
    SetPlayerAllianceStateAllyBJ(Player(1), Player(10), true)
    SetPlayerAllianceStateAllyBJ(Player(2), Player(0), true)
    SetPlayerAllianceStateAllyBJ(Player(2), Player(1), true)
    SetPlayerAllianceStateAllyBJ(Player(2), Player(3), true)
    SetPlayerAllianceStateAllyBJ(Player(2), Player(4), true)
    SetPlayerAllianceStateAllyBJ(Player(2), Player(5), true)
    SetPlayerAllianceStateAllyBJ(Player(2), Player(7), true)
    SetPlayerAllianceStateAllyBJ(Player(2), Player(8), true)
    SetPlayerAllianceStateAllyBJ(Player(2), Player(9), true)
    SetPlayerAllianceStateAllyBJ(Player(2), Player(10), true)
    SetPlayerAllianceStateAllyBJ(Player(3), Player(0), true)
    SetPlayerAllianceStateAllyBJ(Player(3), Player(1), true)
    SetPlayerAllianceStateAllyBJ(Player(3), Player(2), true)
    SetPlayerAllianceStateAllyBJ(Player(3), Player(4), true)
    SetPlayerAllianceStateAllyBJ(Player(3), Player(5), true)
    SetPlayerAllianceStateAllyBJ(Player(3), Player(7), true)
    SetPlayerAllianceStateAllyBJ(Player(3), Player(8), true)
    SetPlayerAllianceStateAllyBJ(Player(3), Player(9), true)
    SetPlayerAllianceStateAllyBJ(Player(3), Player(10), true)
    SetPlayerAllianceStateAllyBJ(Player(4), Player(0), true)
    SetPlayerAllianceStateAllyBJ(Player(4), Player(1), true)
    SetPlayerAllianceStateAllyBJ(Player(4), Player(2), true)
    SetPlayerAllianceStateAllyBJ(Player(4), Player(3), true)
    SetPlayerAllianceStateAllyBJ(Player(4), Player(5), true)
    SetPlayerAllianceStateAllyBJ(Player(4), Player(7), true)
    SetPlayerAllianceStateAllyBJ(Player(4), Player(8), true)
    SetPlayerAllianceStateAllyBJ(Player(4), Player(9), true)
    SetPlayerAllianceStateAllyBJ(Player(4), Player(10), true)
    SetPlayerAllianceStateAllyBJ(Player(5), Player(0), true)
    SetPlayerAllianceStateAllyBJ(Player(5), Player(1), true)
    SetPlayerAllianceStateAllyBJ(Player(5), Player(2), true)
    SetPlayerAllianceStateAllyBJ(Player(5), Player(3), true)
    SetPlayerAllianceStateAllyBJ(Player(5), Player(4), true)
    SetPlayerAllianceStateAllyBJ(Player(5), Player(7), true)
    SetPlayerAllianceStateAllyBJ(Player(5), Player(8), true)
    SetPlayerAllianceStateAllyBJ(Player(5), Player(9), true)
    SetPlayerAllianceStateAllyBJ(Player(5), Player(10), true)
    SetPlayerAllianceStateAllyBJ(Player(7), Player(0), true)
    SetPlayerAllianceStateAllyBJ(Player(7), Player(1), true)
    SetPlayerAllianceStateAllyBJ(Player(7), Player(2), true)
    SetPlayerAllianceStateAllyBJ(Player(7), Player(3), true)
    SetPlayerAllianceStateAllyBJ(Player(7), Player(4), true)
    SetPlayerAllianceStateAllyBJ(Player(7), Player(5), true)
    SetPlayerAllianceStateAllyBJ(Player(7), Player(8), true)
    SetPlayerAllianceStateAllyBJ(Player(7), Player(9), true)
    SetPlayerAllianceStateAllyBJ(Player(7), Player(10), true)
    SetPlayerAllianceStateAllyBJ(Player(8), Player(0), true)
    SetPlayerAllianceStateAllyBJ(Player(8), Player(1), true)
    SetPlayerAllianceStateAllyBJ(Player(8), Player(2), true)
    SetPlayerAllianceStateAllyBJ(Player(8), Player(3), true)
    SetPlayerAllianceStateAllyBJ(Player(8), Player(4), true)
    SetPlayerAllianceStateAllyBJ(Player(8), Player(5), true)
    SetPlayerAllianceStateAllyBJ(Player(8), Player(7), true)
    SetPlayerAllianceStateAllyBJ(Player(8), Player(9), true)
    SetPlayerAllianceStateAllyBJ(Player(8), Player(10), true)
    SetPlayerAllianceStateAllyBJ(Player(9), Player(0), true)
    SetPlayerAllianceStateAllyBJ(Player(9), Player(1), true)
    SetPlayerAllianceStateAllyBJ(Player(9), Player(2), true)
    SetPlayerAllianceStateAllyBJ(Player(9), Player(3), true)
    SetPlayerAllianceStateAllyBJ(Player(9), Player(4), true)
    SetPlayerAllianceStateAllyBJ(Player(9), Player(5), true)
    SetPlayerAllianceStateAllyBJ(Player(9), Player(7), true)
    SetPlayerAllianceStateAllyBJ(Player(9), Player(8), true)
    SetPlayerAllianceStateAllyBJ(Player(9), Player(10), true)
    SetPlayerAllianceStateAllyBJ(Player(10), Player(0), true)
    SetPlayerAllianceStateAllyBJ(Player(10), Player(1), true)
    SetPlayerAllianceStateAllyBJ(Player(10), Player(2), true)
    SetPlayerAllianceStateAllyBJ(Player(10), Player(3), true)
    SetPlayerAllianceStateAllyBJ(Player(10), Player(4), true)
    SetPlayerAllianceStateAllyBJ(Player(10), Player(5), true)
    SetPlayerAllianceStateAllyBJ(Player(10), Player(7), true)
    SetPlayerAllianceStateAllyBJ(Player(10), Player(8), true)
    SetPlayerAllianceStateAllyBJ(Player(10), Player(9), true)
    SetPlayerAllianceStateVisionBJ(Player(0), Player(1), true)
    SetPlayerAllianceStateVisionBJ(Player(0), Player(2), true)
    SetPlayerAllianceStateVisionBJ(Player(0), Player(3), true)
    SetPlayerAllianceStateVisionBJ(Player(0), Player(4), true)
    SetPlayerAllianceStateVisionBJ(Player(0), Player(5), true)
    SetPlayerAllianceStateVisionBJ(Player(0), Player(7), true)
    SetPlayerAllianceStateVisionBJ(Player(0), Player(8), true)
    SetPlayerAllianceStateVisionBJ(Player(0), Player(9), true)
    SetPlayerAllianceStateVisionBJ(Player(0), Player(10), true)
    SetPlayerAllianceStateVisionBJ(Player(1), Player(0), true)
    SetPlayerAllianceStateVisionBJ(Player(1), Player(2), true)
    SetPlayerAllianceStateVisionBJ(Player(1), Player(3), true)
    SetPlayerAllianceStateVisionBJ(Player(1), Player(4), true)
    SetPlayerAllianceStateVisionBJ(Player(1), Player(5), true)
    SetPlayerAllianceStateVisionBJ(Player(1), Player(7), true)
    SetPlayerAllianceStateVisionBJ(Player(1), Player(8), true)
    SetPlayerAllianceStateVisionBJ(Player(1), Player(9), true)
    SetPlayerAllianceStateVisionBJ(Player(1), Player(10), true)
    SetPlayerAllianceStateVisionBJ(Player(2), Player(0), true)
    SetPlayerAllianceStateVisionBJ(Player(2), Player(1), true)
    SetPlayerAllianceStateVisionBJ(Player(2), Player(3), true)
    SetPlayerAllianceStateVisionBJ(Player(2), Player(4), true)
    SetPlayerAllianceStateVisionBJ(Player(2), Player(5), true)
    SetPlayerAllianceStateVisionBJ(Player(2), Player(7), true)
    SetPlayerAllianceStateVisionBJ(Player(2), Player(8), true)
    SetPlayerAllianceStateVisionBJ(Player(2), Player(9), true)
    SetPlayerAllianceStateVisionBJ(Player(2), Player(10), true)
    SetPlayerAllianceStateVisionBJ(Player(3), Player(0), true)
    SetPlayerAllianceStateVisionBJ(Player(3), Player(1), true)
    SetPlayerAllianceStateVisionBJ(Player(3), Player(2), true)
    SetPlayerAllianceStateVisionBJ(Player(3), Player(4), true)
    SetPlayerAllianceStateVisionBJ(Player(3), Player(5), true)
    SetPlayerAllianceStateVisionBJ(Player(3), Player(7), true)
    SetPlayerAllianceStateVisionBJ(Player(3), Player(8), true)
    SetPlayerAllianceStateVisionBJ(Player(3), Player(9), true)
    SetPlayerAllianceStateVisionBJ(Player(3), Player(10), true)
    SetPlayerAllianceStateVisionBJ(Player(4), Player(0), true)
    SetPlayerAllianceStateVisionBJ(Player(4), Player(1), true)
    SetPlayerAllianceStateVisionBJ(Player(4), Player(2), true)
    SetPlayerAllianceStateVisionBJ(Player(4), Player(3), true)
    SetPlayerAllianceStateVisionBJ(Player(4), Player(5), true)
    SetPlayerAllianceStateVisionBJ(Player(4), Player(7), true)
    SetPlayerAllianceStateVisionBJ(Player(4), Player(8), true)
    SetPlayerAllianceStateVisionBJ(Player(4), Player(9), true)
    SetPlayerAllianceStateVisionBJ(Player(4), Player(10), true)
    SetPlayerAllianceStateVisionBJ(Player(5), Player(0), true)
    SetPlayerAllianceStateVisionBJ(Player(5), Player(1), true)
    SetPlayerAllianceStateVisionBJ(Player(5), Player(2), true)
    SetPlayerAllianceStateVisionBJ(Player(5), Player(3), true)
    SetPlayerAllianceStateVisionBJ(Player(5), Player(4), true)
    SetPlayerAllianceStateVisionBJ(Player(5), Player(7), true)
    SetPlayerAllianceStateVisionBJ(Player(5), Player(8), true)
    SetPlayerAllianceStateVisionBJ(Player(5), Player(9), true)
    SetPlayerAllianceStateVisionBJ(Player(5), Player(10), true)
    SetPlayerAllianceStateVisionBJ(Player(7), Player(0), true)
    SetPlayerAllianceStateVisionBJ(Player(7), Player(1), true)
    SetPlayerAllianceStateVisionBJ(Player(7), Player(2), true)
    SetPlayerAllianceStateVisionBJ(Player(7), Player(3), true)
    SetPlayerAllianceStateVisionBJ(Player(7), Player(4), true)
    SetPlayerAllianceStateVisionBJ(Player(7), Player(5), true)
    SetPlayerAllianceStateVisionBJ(Player(7), Player(8), true)
    SetPlayerAllianceStateVisionBJ(Player(7), Player(9), true)
    SetPlayerAllianceStateVisionBJ(Player(7), Player(10), true)
    SetPlayerAllianceStateVisionBJ(Player(8), Player(0), true)
    SetPlayerAllianceStateVisionBJ(Player(8), Player(1), true)
    SetPlayerAllianceStateVisionBJ(Player(8), Player(2), true)
    SetPlayerAllianceStateVisionBJ(Player(8), Player(3), true)
    SetPlayerAllianceStateVisionBJ(Player(8), Player(4), true)
    SetPlayerAllianceStateVisionBJ(Player(8), Player(5), true)
    SetPlayerAllianceStateVisionBJ(Player(8), Player(7), true)
    SetPlayerAllianceStateVisionBJ(Player(8), Player(9), true)
    SetPlayerAllianceStateVisionBJ(Player(8), Player(10), true)
    SetPlayerAllianceStateVisionBJ(Player(9), Player(0), true)
    SetPlayerAllianceStateVisionBJ(Player(9), Player(1), true)
    SetPlayerAllianceStateVisionBJ(Player(9), Player(2), true)
    SetPlayerAllianceStateVisionBJ(Player(9), Player(3), true)
    SetPlayerAllianceStateVisionBJ(Player(9), Player(4), true)
    SetPlayerAllianceStateVisionBJ(Player(9), Player(5), true)
    SetPlayerAllianceStateVisionBJ(Player(9), Player(7), true)
    SetPlayerAllianceStateVisionBJ(Player(9), Player(8), true)
    SetPlayerAllianceStateVisionBJ(Player(9), Player(10), true)
    SetPlayerAllianceStateVisionBJ(Player(10), Player(0), true)
    SetPlayerAllianceStateVisionBJ(Player(10), Player(1), true)
    SetPlayerAllianceStateVisionBJ(Player(10), Player(2), true)
    SetPlayerAllianceStateVisionBJ(Player(10), Player(3), true)
    SetPlayerAllianceStateVisionBJ(Player(10), Player(4), true)
    SetPlayerAllianceStateVisionBJ(Player(10), Player(5), true)
    SetPlayerAllianceStateVisionBJ(Player(10), Player(7), true)
    SetPlayerAllianceStateVisionBJ(Player(10), Player(8), true)
    SetPlayerAllianceStateVisionBJ(Player(10), Player(9), true)
    SetPlayerTeam(Player(6), 1)
end

function InitAllyPriorities()
    SetStartLocPrioCount(0, 9)
    SetStartLocPrio(0, 0, 1, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(0, 1, 2, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(0, 2, 3, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(0, 3, 4, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(0, 4, 5, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(0, 5, 7, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(0, 6, 8, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(0, 7, 9, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(0, 8, 10, MAP_LOC_PRIO_HIGH)
    SetStartLocPrioCount(1, 9)
    SetStartLocPrio(1, 0, 0, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(1, 1, 2, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(1, 2, 3, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(1, 3, 4, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(1, 4, 5, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(1, 5, 7, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(1, 6, 8, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(1, 7, 9, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(1, 8, 10, MAP_LOC_PRIO_HIGH)
    SetStartLocPrioCount(2, 9)
    SetStartLocPrio(2, 0, 0, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(2, 1, 1, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(2, 2, 3, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(2, 3, 4, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(2, 4, 5, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(2, 5, 7, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(2, 6, 8, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(2, 7, 9, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(2, 8, 10, MAP_LOC_PRIO_HIGH)
    SetStartLocPrioCount(3, 9)
    SetStartLocPrio(3, 0, 0, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(3, 1, 1, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(3, 2, 2, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(3, 3, 4, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(3, 4, 5, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(3, 5, 7, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(3, 6, 8, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(3, 7, 9, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(3, 8, 10, MAP_LOC_PRIO_HIGH)
    SetStartLocPrioCount(4, 9)
    SetStartLocPrio(4, 0, 0, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(4, 1, 1, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(4, 2, 2, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(4, 3, 3, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(4, 4, 5, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(4, 5, 7, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(4, 6, 8, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(4, 7, 9, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(4, 8, 10, MAP_LOC_PRIO_HIGH)
    SetStartLocPrioCount(5, 9)
    SetStartLocPrio(5, 0, 0, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(5, 1, 1, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(5, 2, 2, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(5, 3, 3, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(5, 4, 4, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(5, 5, 7, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(5, 6, 8, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(5, 7, 9, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(5, 8, 10, MAP_LOC_PRIO_HIGH)
    SetStartLocPrioCount(6, 10)
    SetStartLocPrio(6, 0, 0, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(6, 1, 1, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(6, 2, 2, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(6, 3, 3, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(6, 4, 4, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(6, 5, 5, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(6, 6, 7, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(6, 7, 8, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(6, 8, 9, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(6, 9, 10, MAP_LOC_PRIO_HIGH)
    SetStartLocPrioCount(7, 9)
    SetStartLocPrio(7, 0, 0, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(7, 1, 1, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(7, 2, 2, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(7, 3, 3, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(7, 4, 4, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(7, 5, 5, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(7, 6, 8, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(7, 7, 9, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(7, 8, 10, MAP_LOC_PRIO_HIGH)
    SetStartLocPrioCount(8, 9)
    SetStartLocPrio(8, 0, 0, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(8, 1, 1, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(8, 2, 2, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(8, 3, 3, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(8, 4, 4, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(8, 5, 5, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(8, 6, 7, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(8, 7, 9, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(8, 8, 10, MAP_LOC_PRIO_HIGH)
    SetStartLocPrioCount(9, 9)
    SetStartLocPrio(9, 0, 0, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(9, 1, 1, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(9, 2, 2, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(9, 3, 3, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(9, 4, 4, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(9, 5, 5, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(9, 6, 7, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(9, 7, 8, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(9, 8, 10, MAP_LOC_PRIO_HIGH)
    SetStartLocPrioCount(10, 9)
    SetStartLocPrio(10, 0, 0, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(10, 1, 1, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(10, 2, 2, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(10, 3, 3, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(10, 4, 4, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(10, 5, 5, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(10, 6, 7, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(10, 7, 8, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(10, 8, 9, MAP_LOC_PRIO_HIGH)
end

function config()
    SetMapName("TRIGSTR_116")
    SetMapDescription("TRIGSTR_118")
    SetPlayers(11)
    SetTeams(11)
    SetGamePlacement(MAP_PLACEMENT_TEAMS_TOGETHER)
    DefineStartLocation(0, __jreal(7040.0), __jreal(7232.0))
    DefineStartLocation(1, __jreal(7040.0), __jreal(7232.0))
    DefineStartLocation(2, __jreal(7040.0), __jreal(7232.0))
    DefineStartLocation(3, __jreal(7040.0), __jreal(7232.0))
    DefineStartLocation(4, __jreal(7040.0), __jreal(7232.0))
    DefineStartLocation(5, __jreal(7040.0), __jreal(7232.0))
    DefineStartLocation(6, __jreal(7680.0), __jreal(7232.0))
    DefineStartLocation(7, __jreal(7040.0), __jreal(7232.0))
    DefineStartLocation(8, __jreal(7040.0), __jreal(7232.0))
    DefineStartLocation(9, __jreal(7040.0), __jreal(7232.0))
    DefineStartLocation(10, __jreal(7040.0), __jreal(7232.0))
    InitCustomPlayerSlots()
    InitCustomTeams()
    InitAllyPriorities()
end

function main()
    SetCameraBounds(__jreal((-(__jreal(8192.0))) + GetCameraMargin(CAMERA_MARGIN_LEFT)), __jreal((-(__jreal(8704.0))) + GetCameraMargin(CAMERA_MARGIN_BOTTOM)), __jreal(__jreal(8192.0) - GetCameraMargin(CAMERA_MARGIN_RIGHT)), __jreal(__jreal(7680.0) - GetCameraMargin(CAMERA_MARGIN_TOP)), __jreal((-(__jreal(8192.0))) + GetCameraMargin(CAMERA_MARGIN_LEFT)), __jreal(__jreal(7680.0) - GetCameraMargin(CAMERA_MARGIN_TOP)), __jreal(__jreal(8192.0) - GetCameraMargin(CAMERA_MARGIN_RIGHT)), __jreal((-(__jreal(8704.0))) + GetCameraMargin(CAMERA_MARGIN_BOTTOM)))
    SetDayNightModels("Environment\\DNC\\DNCLordaeron\\DNCLordaeronTerrain\\DNCLordaeronTerrain.mdl", "Environment\\DNC\\DNCLordaeron\\DNCLordaeronUnit\\DNCLordaeronUnit.mdl")
    NewSoundEnvironment("Default")
    SetAmbientDaySound("SunkenRuinsDay")
    SetAmbientNightSound("SunkenRuinsNight")
    SetMapMusic("Music", true, 0)
    InitSounds()
    CreateRegions()
    CreateAllDestructables()
    CreateAllUnits()
    InitBlizzard()
    InitTrig_FE_Bootstrap()
end
