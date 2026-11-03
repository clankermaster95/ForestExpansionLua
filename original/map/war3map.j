globals
//globals from DamageEngine:
constant boolean LIBRARY_DamageEngine=true
constant boolean DamageEngine___USE_GUI= true

constant boolean DamageEngine___USE_SCALING= DamageEngine___USE_GUI
constant boolean DamageEngine___USE_EXTRA= true
constant boolean DamageEngine___USE_ARMOR_MOD= true
constant boolean DamageEngine___USE_MELEE_RANGE= true
constant boolean DamageEngine___USE_LETHAL= true


constant integer DamageEngine___MAX_RECURSIVE_TOLERANCE= 16

constant integer DamageEngine_TYPE_CODE= 1
constant integer DamageEngine_TYPE_PURE= 2
constant real DamageEngine___DEATH_VAL= 0.405

timer DamageEngine___async= null
boolean DamageEngine___timerStarted= false

    //Values to track the original pre-spirit Link/defensive damage values
integer DamageEngine___lastInstance= 0

boolean DamageEngine___isNotNativeRecursiveDamage= true
boolean DamageEngine___waitingForDamageEventToRun= false

boolean array DamageEngine___attacksImmune
boolean array DamageEngine___damagesImmune

    //Primary triggers used to handle all damage events.
trigger DamageEngine___damagingTrigger= null
trigger DamageEngine___damagedTrigger= null
trigger DamageEngine___recursiveTrigger= null


constant integer DamageEngine_FILTER_ATTACK= 0
constant integer DamageEngine_FILTER_MELEE= 1
constant integer DamageEngine_FILTER_OTHER= 2
constant integer DamageEngine_FILTER_RANGED= 3
constant integer DamageEngine_FILTER_SPELL= 4
constant integer DamageEngine_FILTER_CODE= 5
constant integer DamageEngine_FILTER_MAX= 6
integer DamageEngine___eventFilter= DamageEngine_FILTER_OTHER


boolean DamageEngine_inception= false

boolean DamageEngine___callbacksInProgress= false
integer DamageEngine___recursiveCallbackDepth= 0
group DamageEngine___recursionSources= null
group DamageEngine___recursionTargets= null
boolean DamageEngine___recursiveCallbaksInProgress= false
boolean DamageEngine___nativeEventsCompleted= false
boolean DamageEngine___atLeastOneLethalDamageEventRegistered= false

    // Struct members made private to this library.
//endglobals from DamageEngine
//globals from PassiveMissiles:
constant boolean LIBRARY_PassiveMissiles=true
constant integer PassiveMissiles__PM_ABILITY_ID= 'A0EP'

    // Replace this with the rawcode of the summoned Tornado unit.
constant integer PassiveMissiles__PM_TORNADO_UNIT_ID= 'ntor'

constant real PassiveMissiles__PM_RANGE= 400.00
constant real PassiveMissiles__PM_DAMAGE= 60.00
constant real PassiveMissiles__PM_STRUCTURE_DAMAGE_MULTIPLIER= 0.50
constant real PassiveMissiles__PM_PERIOD= 1.00
constant real PassiveMissiles__PM_LAUNCH_DELAY= 0.12

constant real PassiveMissiles__PM_SPEED= 500.00
constant real PassiveMissiles__PM_TICK= 0.03125
constant real PassiveMissiles__PM_HEIGHT= 70.00
constant real PassiveMissiles__PM_MODEL_SCALE= 0.40

constant string PassiveMissiles__PM_MODEL= "war3mapImported\\SilentTornadoElemental.mdx"

constant string PassiveMissiles__PM_LOOP_SOUND_FILE= "Abilities\\Spells\\NightElf\\Cyclone\\CycloneLoop1.flac"
constant string PassiveMissiles__PM_DEATH_SOUND_FILE= "Abilities\\Spells\\NightElf\\Cyclone\\CycloneDeath1.flac"

constant integer PassiveMissiles__PM_LOOP_SOUND_VOLUME= 90
constant integer PassiveMissiles__PM_DEATH_SOUND_VOLUME= 55

constant real PassiveMissiles__PM_SOUND_MIN_DIST= 600.00
constant real PassiveMissiles__PM_SOUND_MAX_DIST= 3000.00

constant integer PassiveMissiles__PM_SOUND_FADE_IN_RATE= 1
constant integer PassiveMissiles__PM_SOUND_FADE_OUT_RATE= 1

constant integer PassiveMissiles__PM_KEY_VOLLEY_CASTER= 0
constant integer PassiveMissiles__PM_KEY_VOLLEY_REMAINING= 1
constant integer PassiveMissiles__PM_KEY_TORNADO_OWNER= 100
constant integer PassiveMissiles__PM_KEY_TORNADO_BASE_LEVEL= 101

group PassiveMissiles__PM_Casters= CreateGroup()
group PassiveMissiles__PM_EnumGroup= CreateGroup()

timer PassiveMissiles__PM_CastTimer= CreateTimer()
timer PassiveMissiles__PM_MoveTimer= CreateTimer()

hashtable PassiveMissiles__PM_Hash= InitHashtable()

unit PassiveMissiles__PM_Source= null

integer PassiveMissiles__PM_Count= 0
effect array PassiveMissiles__PM_Fx
sound array PassiveMissiles__PM_Sound
unit array PassiveMissiles__PM_Caster
unit array PassiveMissiles__PM_DamageSource
unit array PassiveMissiles__PM_Target
real array PassiveMissiles__PM_X
real array PassiveMissiles__PM_Y
real array PassiveMissiles__PM_Z
//endglobals from PassiveMissiles
//globals from SpellLeech:
constant boolean LIBRARY_SpellLeech=true
    // Replace this with your active ability rawcode.
constant integer SpellLeech__SL_ABILITY_ID= 'A0ES'

    // Duration formula:
    // Level 1 = 3 seconds
    // Level 2 = 6 seconds
    // Level 3 = 9 seconds
constant real SpellLeech__SL_BASE_DURATION= 3.00
constant real SpellLeech__SL_DURATION_PER_LEVEL= 3.00

    // 1.00 = heal for 100% of spell damage dealt.
    // 0.50 = heal for 50% of spell damage dealt.
constant real SpellLeech__SL_LEECH_FACTOR= 0.50

    // true = only heal from damage dealt to enemies.
    // false = heal from any spell damage caused by the unit.
constant boolean SpellLeech__SL_ENEMY_ONLY= true

    // true = only non-attack damage can heal.
    // This is recommended because normal Warcraft III spells and your tornado missiles are non-attack damage.
constant boolean SpellLeech__SL_REQUIRE_NON_ATTACK= true

    // false = accepts all non-attack damage as spell damage.
    // true = only accepts DAMAGE_TYPE_MAGIC.
    //
    // Leave this false if you want it to work with most normal Object Editor spells.
constant boolean SpellLeech__SL_REQUIRE_DAMAGE_TYPE_MAGIC= false

constant string SpellLeech__SL_ACTIVATE_EFFECT= "Abilities\\Spells\\Items\\AIre\\AIreTarget.mdl"
constant string SpellLeech__SL_HEAL_EFFECT= "Abilities\\Spells\\Human\\Heal\\HealTarget.mdl"

    // Turn this on only if you want a heal flash on every damage event.
    // For damage-over-time spells this can become visually noisy.
constant boolean SpellLeech__SL_SHOW_HEAL_EFFECT= false

timer SpellLeech__SL_Clock= CreateTimer()
hashtable SpellLeech__SL_Hash= InitHashtable()
//endglobals from SpellLeech
    // User-defined
integer array udg_Units
location udg_Point1= null
integer udg_Gold= 0
integer udg_Selectors= 0
integer array udg_Ancients
rect array udg_Moveto
force udg_Razormane= null
location udg_Aethyr= null
sound udg_AncientKills= null
integer udg_UDex= 0
integer udg_UDexRecycle= 0
integer array udg_UDexNext
integer udg_UDexGen= 0
unit array udg_UDexUnits
integer array udg_UDexPrev
real udg_UnitIndexEvent= 0
boolean udg_UnitIndexerEnabled= false
integer udg_UDexWasted= 0
integer udg_ncld_Ability= 0
real udg_ncld_DrainHP= 0
real udg_ncld_DrainHPUp= 0
real udg_ncld_DrainMP= 0
real udg_ncld_DrainMPUp= 0
real udg_ncld_Duration= 0
real udg_ncld_Duration_Up= 0
real udg_ncld_Range= 0
real udg_ncld_RangeUp= 0
string udg_ncld_LightningArt
string udg_ncld_TargetSFXArt
string udg_ncld_CasterSFXArt
integer udg_ncld_FreqDrain= 0
integer udg_ncld_FreqDistance= 0
real udg_ncld_EtherealBonus= 0
integer udg_ncld_buffId= 0
integer array udg_ncld_BuffList
boolean udg_ncld_CheckImmune= false
boolean udg_ncld_CheckResistant= false
boolean udg_ncld_CheckVisibile= false
real udg_tempReal= 0
unit udg_tempUnit= null
integer udg_Key= 0
unit array udg_ncld_Target
group udg_ncld_Group= null
integer array udg_ncld_Tick
integer array udg_ncld_TicksRemaining
real array udg_ncld_Hp
real array udg_ncld_Mp
real array udg_ncld_Rng
location udg_tempLoc1= null
effect array udg_ncld_CasterSFX
effect array udg_ncld_TargetSFX
lightning array udg_ncld_Lightning
location udg_tempLoc2= null
boolean udg_CheckBool= false
integer udg_LoopBuffs= 0
real udg_tempDistance= 0
real udg_tempX1= 0
real udg_tempX2= 0
real udg_tempY1= 0
real udg_tempY2= 0
real udg_tempZ1= 0
real udg_tempZ2= 0
real udg_VanguardHeal= 0
integer udg_Omni= 0
unit udg_Div= null
location udg_Hardunit= null
group udg_RemSel= null
timer udg_FZ= null
timer udg_LS= null
unit udg_AncientUnit= null
real udg_AncientInCombat= 0
integer udg_Bans= 0
real udg_BannedWorgen= 0
real udg_BannedForgotten= 0
real udg_BannedAethyr= 0
real udg_BannedGoblin= 0
real udg_BannedOgre= 0
real udg_BannedMagmide= 0
real udg_BannedFurbolg= 0
real udg_BannedRazormane= 0
real udg_BannedNerubian= 0
real udg_BannedWildkin= 0
real udg_BannedHuman= 0
real udg_BannedCentaur= 0
real udg_BannedWisp= 0
real udg_BannedKobold= 0
real udg_BannedGhoul= 0
real udg_BannedKraken= 0
real udg_BannedAncientLight= 0
real udg_BannedAncientLightning= 0
real udg_BannedAncientDragon= 0
real udg_BannedAncientEarth= 0
real udg_BannedAncientDarkness= 0
real udg_BannedAncientIce= 0
real udg_BannedAncientFire= 0
real udg_BannedAncientNature= 0
timer udg_ExpanderSpawnTimer= null
timer udg_AncientSpawnTimer= null
unit udg_MoonTar= null
unit udg_MoonCast= null
unit udg_LunTar= null
unit udg_LunCast= null
unit udg_BlastTar= null
unit udg_BlastCast= null
integer udg_WispRez= 0
unit udg_WispRezU= null
integer udg_Seed= 0
player udg_SeedP= null
unit udg_SeedO= null
location udg_SeedR= null
unit udg_Wisp= null
unit udg_Ledger= null
real udg_BannedAncientSand= 0
player udg_Flag= null
unit udg_HumanFlag= null
unit udg_KrakenFlag= null
unit udg_OgreFlag= null
unit udg_GhoulFlag= null
unit udg_AethyrFlag= null
unit udg_CentaurFlag= null
unit udg_RazormaneFlag= null
unit udg_WispFlag= null
integer udg_Cascade= 0
real udg_Resillence= 0
unit udg_ResillienceLvler= null
unit udg_CosmicStrikeCaster= null
integer udg_CosmicStrikeCount= 0
real udg_PreDamageEvent= 0
real udg_ArmorDamageEvent= 0
real udg_ZeroDamageEvent= 0
real udg_LethalDamageEvent= 0
real udg_OnDamageEvent= 0
real udg_AfterDamageEvent= 0
real udg_SourceDamageEvent= 0
real udg_AOEDamageEvent= 0
real udg_DamageModifierEvent= 0
real udg_DamageEvent= 0
boolean udg_RemoveDamageEvent= false
boolean udg_DamageEventOverride= false
unit udg_DamageEventSource= null
unit udg_DamageEventTarget= null
real udg_DamageEventPrevAmt= 0
unit udg_AOEDamageSource= null
unit udg_EnhancedDamageTarget= null
integer udg_DamageEventLevel= 0
integer udg_DamageEventAOE= 0
group udg_DamageEventAOEGroup= null
real udg_DamageScalingWC3= 0
real udg_DamageScalingUser= 0
boolean udg_IsDamageAttack= false
boolean udg_IsDamageMelee= false
boolean udg_IsDamageRanged= false
boolean udg_IsDamageSpell= false
boolean udg_IsDamageCode= false
real udg_DamageEventAmount= 0
real udg_DamageEventArmorPierced= 0
real udg_LethalDamageHP= 0
integer udg_DamageEventAttackT= 0
integer udg_DamageEventDamageT= 0
integer udg_DamageEventArmorT= 0
integer udg_DamageEventDefenseT= 0
integer udg_DamageEventWeaponT= 0
integer udg_DamageEventType= 0
boolean udg_NextDamageIsAttack= false
boolean udg_NextDamageIsRanged= false
boolean udg_NextDamageIsMelee= false
integer udg_NextDamageType= 0
integer udg_NextDamageWeaponT= 0
unit udg_DamageFilterSource= null
unit udg_DamageFilterTarget= null
integer udg_DamageFilterAttackT= 0
integer udg_DamageFilterDamageT= 0
integer udg_DamageFilterSourceT= 0
integer udg_DamageFilterTargetT= 0
integer udg_DamageFilterSourceB= 0
integer udg_DamageFilterTargetB= 0
integer udg_DamageFilterType= 0
real udg_DamageFilterMinAmount= 0
real udg_DamageFilterRunChance= 0
real udg_DamageFilterFailChance= 0
integer udg_DamageFilterSourceA= 0
integer udg_DamageFilterTargetA= 0
integer udg_DamageFilterTargetI= 0
integer udg_DamageFilterSourceI= 0
integer udg_DamageFilterSourceC= 0
integer udg_DamageFilterTargetC= 0
integer udg_UNIT_CLASS_MAGIC_IMMUNE= 0
integer udg_UNIT_CLASS_ETHEREAL= 0
integer udg_UNIT_CLASS_RESISTANT= 0
integer udg_UNIT_CLASS_SLEEPING= 0
integer udg_UNIT_CLASS_POLYMORPHED= 0
integer udg_UNIT_CLASS_POISONED= 0
integer udg_UNIT_CLASS_TAUREN= 0
integer udg_UNIT_CLASS_ANCIENT= 0
integer udg_UNIT_CLASS_TOWNHALL= 0
integer udg_UNIT_CLASS_SAPPER= 0
integer udg_UNIT_CLASS_PEON= 0
integer udg_UNIT_CLASS_MECHANICAL= 0
integer udg_UNIT_CLASS_UNDEAD= 0
integer udg_UNIT_CLASS_SNARED= 0
integer udg_UNIT_CLASS_PLAGUED= 0
integer udg_UNIT_CLASS_STUNNED= 0
integer udg_UNIT_CLASS_SUMMONED= 0
integer udg_UNIT_CLASS_GIANT= 0
integer udg_UNIT_CLASS_RANGED= 0
integer udg_UNIT_CLASS_MELEE= 0
integer udg_UNIT_CLASS_ATTACKS_GROUND= 0
integer udg_UNIT_CLASS_ATTACKS_FLYING= 0
integer udg_UNIT_CLASS_GROUND= 0
integer udg_UNIT_CLASS_FLYING= 0
integer udg_UNIT_CLASS_STRUCTURE= 0
integer udg_UNIT_CLASS_DEAD= 0
integer udg_UNIT_CLASS_HERO= 0
integer udg_ARMOR_TYPE_NONE= 0
integer udg_ARMOR_TYPE_FLESH= 0
integer udg_ARMOR_TYPE_METAL= 0
integer udg_ARMOR_TYPE_WOOD= 0
integer udg_ARMOR_TYPE_ETHEREAL= 0
integer udg_ARMOR_TYPE_STONE= 0
string array udg_ArmorTypeDebugStr
attacktype array udg_CONVERTED_ATTACK_TYPE
integer udg_ATTACK_TYPE_SPELLS= 0
integer udg_ATTACK_TYPE_NORMAL= 0
integer udg_ATTACK_TYPE_PIERCE= 0
integer udg_ATTACK_TYPE_SIEGE= 0
integer udg_ATTACK_TYPE_MAGIC= 0
integer udg_ATTACK_TYPE_CHAOS= 0
integer udg_ATTACK_TYPE_HERO= 0
string array udg_AttackTypeDebugStr
integer udg_DamageTypeBlocked= 0
integer udg_DamageTypeCriticalStrike= 0
integer udg_DamageTypeCode= 0
integer udg_DamageTypeExplosive= 0
integer udg_DamageTypeHeal= 0
integer udg_DamageTypePure= 0
integer udg_DamageTypePureExplosive= 0
integer udg_DamageTypeReduced= 0
damagetype array udg_CONVERTED_DAMAGE_TYPE
integer udg_DAMAGE_TYPE_UNKNOWN= 0
integer udg_DAMAGE_TYPE_NORMAL= 0
integer udg_DAMAGE_TYPE_ENHANCED= 0
integer udg_DAMAGE_TYPE_FIRE= 0
integer udg_DAMAGE_TYPE_COLD= 0
integer udg_DAMAGE_TYPE_LIGHTNING= 0
integer udg_DAMAGE_TYPE_POISON= 0
integer udg_DAMAGE_TYPE_DISEASE= 0
integer udg_DAMAGE_TYPE_DIVINE= 0
integer udg_DAMAGE_TYPE_MAGIC= 0
integer udg_DAMAGE_TYPE_SONIC= 0
integer udg_DAMAGE_TYPE_ACID= 0
integer udg_DAMAGE_TYPE_FORCE= 0
integer udg_DAMAGE_TYPE_DEATH= 0
integer udg_DAMAGE_TYPE_MIND= 0
integer udg_DAMAGE_TYPE_PLANT= 0
integer udg_DAMAGE_TYPE_DEFENSIVE= 0
integer udg_DAMAGE_TYPE_DEMOLITION= 0
integer udg_DAMAGE_TYPE_SLOW_POISON= 0
integer udg_DAMAGE_TYPE_SPIRIT_LINK= 0
integer udg_DAMAGE_TYPE_SHADOW_STRIKE= 0
integer udg_DAMAGE_TYPE_UNIVERSAL= 0
string array udg_DamageTypeDebugStr
integer udg_DEFENSE_TYPE_LIGHT= 0
integer udg_DEFENSE_TYPE_MEDIUM= 0
integer udg_DEFENSE_TYPE_HEAVY= 0
integer udg_DEFENSE_TYPE_FORTIFIED= 0
integer udg_DEFENSE_TYPE_NORMAL= 0
integer udg_DEFENSE_TYPE_HERO= 0
integer udg_DEFENSE_TYPE_DIVINE= 0
integer udg_DEFENSE_TYPE_UNARMORED= 0
string array udg_DefenseTypeDebugStr
string array udg_WeaponTypeDebugStr
integer udg_WEAPON_TYPE_NONE= 0
integer udg_WEAPON_TYPE_ML_CHOP= 0
integer udg_WEAPON_TYPE_MM_CHOP= 0
integer udg_WEAPON_TYPE_MH_CHOP= 0
integer udg_WEAPON_TYPE_ML_SLICE= 0
integer udg_WEAPON_TYPE_MM_SLICE= 0
integer udg_WEAPON_TYPE_MH_SLICE= 0
integer udg_WEAPON_TYPE_MM_BASH= 0
integer udg_WEAPON_TYPE_MH_BASH= 0
integer udg_WEAPON_TYPE_MM_STAB= 0
integer udg_WEAPON_TYPE_MH_STAB= 0
integer udg_WEAPON_TYPE_WL_SLICE= 0
integer udg_WEAPON_TYPE_WM_SLICE= 0
integer udg_WEAPON_TYPE_WH_SLICE= 0
integer udg_WEAPON_TYPE_WL_BASH= 0
integer udg_WEAPON_TYPE_WM_BASH= 0
integer udg_WEAPON_TYPE_WH_BASH= 0
integer udg_WEAPON_TYPE_WL_STAB= 0
integer udg_WEAPON_TYPE_WM_STAB= 0
integer udg_WEAPON_TYPE_CL_SLICE= 0
integer udg_WEAPON_TYPE_CM_SLICE= 0
integer udg_WEAPON_TYPE_CH_SLICE= 0
integer udg_WEAPON_TYPE_AM_CHOP= 0
integer udg_WEAPON_TYPE_RH_BASH= 0
unit udg_GalacticFuryCaster= null
location udg_TimeWarp= null
unit udg_TimeWarpCaster= null
unit udg_WorgenAttack= null
integer udg_XPperSecond= 0
real udg_BannedAncientSpace= 0
group udg_Dutchmen= null
location udg_Temp_Point= null
string array udg_PlayerColorHex
player udg_DeadPlayer= null
location udg_LocationOfDeath= null
location udg_ThunderstruckTarget= null
integer udg_ThunderstruckLevel= 0
player udg_AncientPlayer= null
integer udg_Lackey= 0
integer udg_StillAlive= 0
group udg_Ziggurats= null
integer udg_AuraLevel= 0
integer udg_Ziggurats_Count= 0
real udg_BannedElf= 0
group udg_ShadowDancers= null
unit udg_RecallTarget= null
integer array udg_SeedOfRebirth
location udg_SeedUnitPosition= null
integer udg_SeedPlayedNumber= 0
boolean array udg_DeepWater1
real udg_BannedHighElf= 0
real array udg_ExperienceRate
boolean array udg_SilentStrider
unit udg_TSEUnit= null
boolean udg_TSEUnitAliveCheck= false
real udg_TSE__RemainingDuration= 0
integer udg_TSE__ActiveIndex= 0
unit udg_TSE__TargetUnit= null
unit udg_TSE__SourceUnit= null
location udg_TSE__Point= null
effect udg_TSE__SpecialEffect= null
trigger udg_TSE_LoopTrigger= null
trigger udg_TSE_RegisterTrigger= null
real udg_TSE_TIMEOUT= 0
real array udg_TSE_I_RemainingDuration
effect array udg_TSE_I_Effect
string array udg_TSE_I_ChanneledOrderID
unit array udg_TSE_I_SourceUnit
boolean array udg_TSE_I_IsChanneling
boolean array udg_TSE_I_TargetUnitAliveCheck
boolean array udg_TSE_I_SourceUnitAliveCheck
unit array udg_TSE_I_TargetUnit
trigger array udg_TSE_I_OnLoopEvent
real array udg_TSE_I_OnLoopTimer
real array udg_TSE_I_LoopDuration
trigger array udg_TSE_I_OnEndEvent
boolean array udg_TSE_I_ActiveInstance
boolean array udg_TSE_I_LockInstance
location array udg_TSE_I_Point
integer udg_TSE_MaxIndex= 0
integer udg_TSE_ReplacementIndex= 0
boolean udg_TSE_ReplacementIndexFound= false
boolean udg_TSE_MaxCheckOver= false
integer udg_TSE_MaxRecursion= 0
integer udg_TSE_Recursion= 0
integer udg_TSE_Index= 0
trigger udg_TSE_EmptyEvent= null
timer udg_TSE_CTimer= null
unit udg_TSETargetUnit= null
boolean udg_TSETargetUnitAliveCheck= false
unit udg_TSESourceUnit= null
boolean udg_TSESourceUnitAliveCheck= false
location udg_TSEPoint= null
string udg_TSEEffectName
string udg_TSEAttachPoint
real udg_TSEDuration= 0
real udg_TSEScale= 0
string udg_TSEChanneledOrderID
trigger udg_TSEOnIndexEvent= null
trigger udg_TSEOnLoopEvent= null
real udg_TSEOnLoopTimer= 0
trigger udg_TSEOnEndEvent= null
boolean udg_TSELockInstance= false
group udg_Acided= null
real udg_BannedRatling= 0
string udg_TreeChopper
string udg_Tradeoff
string udg_Counterstring
integer udg_IntSeconds= 0
integer udg_IntMinutes= 0
integer udg_IntHours= 0
string udg_StringSeconds
string udg_StringMinutes
player array udg_ExpanderPlayers
real udg_BannedHunter= 0
integer array udg_Multiboard_Spot
rect array udg_GARATHORbaseList
boolean array udg_Flags
real udg_BannedAncientWind= 0
dialog udg_StartupDialog= null

    // Generated
rect gg_rct_SpawnDefender= null
rect gg_rct_Tele_out_D= null
rect gg_rct_Tele_out_E= null
rect gg_rct_Spawn_all= null
rect gg_rct_Alarm= null
rect gg_rct_Spawner= null
rect gg_rct_Camera_1= null
rect gg_rct_Respawn= null
rect gg_rct_Ping1= null
rect gg_rct_Ping2= null
rect gg_rct_Ping3= null
rect gg_rct_Ping4= null
rect gg_rct_Ping5= null
rect gg_rct_Rest_of_Map= null
rect gg_rct_Ping6= null
rect gg_rct_AI_Move_1= null
rect gg_rct_AI_Move_2= null
rect gg_rct_AI_Move_3= null
rect gg_rct_AI_Move_4= null
rect gg_rct_AI_Move_5= null
rect gg_rct_AI_Move_6= null
rect gg_rct_AI_Move_7= null
rect gg_rct_AI_Move_8= null
rect gg_rct_AI_Move_9= null
rect gg_rct_AI_Move_10= null
rect gg_rct_Suspicious_Bush_1= null
rect gg_rct_Suspicious_Bush_2= null
rect gg_rct_Remove_Selection= null
rect gg_rct_Ping7= null
rect gg_rct_Fountain= null
rect gg_rct_SeedofR= null
rect gg_rct_Base_1= null
rect gg_rct_Base_2= null
rect gg_rct_Base_3= null
rect gg_rct_rawr= null
rect gg_rct_Base_4= null
rect gg_rct_Base_5= null
rect gg_rct_Base_6= null
rect gg_rct_Base_7= null
rect gg_rct_Base_8= null
rect gg_rct_Base_9= null
rect gg_rct_Base_10= null
rect gg_rct_ChopChop= null
sound gg_snd_VarimathrasYes1= null
sound gg_snd_PeasantDeath= null
sound gg_snd_CentaurDeath= null
sound gg_snd_WispPissed1= null
sound gg_snd_WarlockDeath1= null
sound gg_snd_OgreDeath1= null
sound gg_snd_HeroFirelordDeath1= null
sound gg_snd_SatyrDeath1= null
sound gg_snd_BansheeDeath= null
sound gg_snd_TinkerDeathAlt1= null
sound gg_snd_FurbolgDeath1= null
sound gg_snd_PitFiendDeath1= null
sound gg_snd_HydraDeath1= null
sound gg_snd_KoboldDeath= null
sound gg_snd_QuillboarDeath= null
sound gg_snd_FacelessDeath1= null
sound gg_snd_WendigoDeath= null
sound gg_snd_DemonHunterDeathAlternate1= null
sound gg_snd_DruidOfTheTalonDeath1= null
sound gg_snd_GhoulDeath= null
sound gg_snd_HeroDemonHunterDeath1= null
sound gg_snd_RiflemanDeath= null
sound gg_snd_DuneWormDeath1= null
sound gg_snd_CycloneLoop1= null
sound gg_snd_CycloneDeath1= null
sound gg_snd_KaelYesAttack3= null
trigger gg_trg_Damage_Engine_Config= null
trigger gg_trg_Damage_Engine= null
trigger gg_trg_TSEConfig= null
trigger gg_trg_TSERegister= null
trigger gg_trg_TSELoop= null
trigger gg_trg_TSEEmptyEvent= null
trigger gg_trg_TSESampleRegisterUnit= null
trigger gg_trg_TSESampleRegisterPoint= null
trigger gg_trg_Untitled_Trigger_009= null
trigger gg_trg_Untitled_Trigger_004= null
trigger gg_trg_Map_Ini_Testing= null
trigger gg_trg_Counter_Testing= null
trigger gg_trg_Selection_Testing= null
trigger gg_trg_Start_Counter= null
trigger gg_trg_Counter= null
trigger gg_trg_Counter_for_Later= null
trigger gg_trg_Counter_Panel= null
trigger gg_trg_Tradeoff_Detection= null
trigger gg_trg_TreeChopper_Detection= null
trigger gg_trg_Takeover= null
trigger gg_trg_Enable_Overdrive= null
trigger gg_trg_Disable_Overdrive= null
trigger gg_trg_Death= null
trigger gg_trg_Hardmode= null
trigger gg_trg_Categorization= null
trigger gg_trg_Fountain_Heal= null
trigger gg_trg_Ancient_In_Combat= null
trigger gg_trg_AutoFeedRate= null
trigger gg_trg_TimeToAncientSpawn_Copy= null
trigger gg_trg_HandleSetRate= null
trigger gg_trg_FeedReduction= null
trigger gg_trg_SetFeed= null
trigger gg_trg_CheckFeedRates= null
trigger gg_trg_Detonate= null
trigger gg_trg_Expander_Hero_XP= null
trigger gg_trg_Snipe_Shot= null
trigger gg_trg_Dash= null
trigger gg_trg_Rome= null
trigger gg_trg_Basic_Bounty_Hit= null
trigger gg_trg_Improved_Bounty_Hit= null
trigger gg_trg_Harvest_Grapes= null
trigger gg_trg_Bullets_Switch= null
trigger gg_trg_Limb_Throw= null
trigger gg_trg_Flesh_Stampede= null
trigger gg_trg_Amalgamation= null
trigger gg_trg_Merge= null
trigger gg_trg_Husk_Detection= null
trigger gg_trg_Death_Jump= null
trigger gg_trg_Map_Start= null
trigger gg_trg_Day= null
trigger gg_trg_Night= null
trigger gg_trg_Iron_Hoove= null
trigger gg_trg_Lightning_Strike_TowerVers= null
trigger gg_trg_Blizzard= null
trigger gg_trg_ShovelStrikelevelup= null
trigger gg_trg_Deepwater_1= null
trigger gg_trg_Deepwater_2= null
trigger gg_trg_Genesis= null
trigger gg_trg_ConjureRefreshment= null
trigger gg_trg_ShadowDancers= null
trigger gg_trg_Mana_Burn_Manacost= null
trigger gg_trg_Mana_Burn= null
trigger gg_trg_Mana_Steal_Dancer= null
trigger gg_trg_Mana_Steal_Mages= null
trigger gg_trg_ConjureMana= null
trigger gg_trg_Blur= null
trigger gg_trg_Ghoul_Units= null
trigger gg_trg_Ghoul_lumber= null
trigger gg_trg_Dutchmen_Trained= null
trigger gg_trg_Dutchmen= null
trigger gg_trg_Vampiric_Wyrm= null
trigger gg_trg_Soul_Hammer= null
trigger gg_trg_Coup_de_grace= null
trigger gg_trg_Surge_of_Darkness= null
trigger gg_trg_Focused_Anger_1= null
trigger gg_trg_Focused_Anger_2= null
trigger gg_trg_Focused_Anger_3= null
trigger gg_trg_Focused_Anger_4= null
trigger gg_trg_Focused_Anger_5= null
trigger gg_trg_Focused_Anger_6= null
trigger gg_trg_Focused_Anger_7= null
trigger gg_trg_Focused_Anger_8= null
trigger gg_trg_Focused_Anger_9= null
trigger gg_trg_Focused_Anger_10= null
trigger gg_trg_Focused_Anger_Trigger= null
trigger gg_trg_Focused_Anger_Trigger_Copy= null
trigger gg_trg_Focused_Anger_Trigger_Copy_2= null
trigger gg_trg_Focused_Anger_Trigger_Copy_3= null
trigger gg_trg_Focused_Anger_Trigger_Copy_4= null
trigger gg_trg_Focused_Anger_Trigger_Copy_5= null
trigger gg_trg_Focused_Anger_Trigger_Copy_6= null
trigger gg_trg_Focused_Anger_Trigger_Copy_7= null
trigger gg_trg_Focused_Anger_Trigger_Copy_8= null
trigger gg_trg_Focused_Anger_Trigger_Copy_9= null
trigger gg_trg_Feast_of_Souls= null
trigger gg_trg_Soul_Strike= null
trigger gg_trg_Avatar= null
trigger gg_trg_Acidic_Blood= null
trigger gg_trg_Binding_Shadows= null
trigger gg_trg_Cobalt_Blood= null
trigger gg_trg_Glowing_Blood= null
trigger gg_trg_Psychic_Slam= null
trigger gg_trg_Soul_Rend= null
trigger gg_trg_Dark_Blood= null
trigger gg_trg_Shadowlings= null
trigger gg_trg_Levelled_Drain= null
trigger gg_trg_Levelled_Drain_Copy= null
trigger gg_trg_Levelled_Drain_Copy_2= null
trigger gg_trg_Levelled_Drain_Copy_3= null
trigger gg_trg_Levelled_Drain_Copy_4= null
trigger gg_trg_Levelled_Drain_Copy_5= null
trigger gg_trg_Levelled_Drain_Copy_6= null
trigger gg_trg_Levelled_Drain_Copy_7= null
trigger gg_trg_Levelled_Drain_Copy_8= null
trigger gg_trg_Levelled_Drain_Copy_9= null
trigger gg_trg_Drain_Setup= null
trigger gg_trg_Drain_Cast= null
trigger gg_trg_Drain_Loop= null
trigger gg_trg_Levelled_Slam= null
trigger gg_trg_Levelled_Slam_Copy= null
trigger gg_trg_Levelled_Slam_Copy_2= null
trigger gg_trg_Levelled_Slam_Copy_3= null
trigger gg_trg_Levelled_Slam_Copy_4= null
trigger gg_trg_Levelled_Slam_Copy_5= null
trigger gg_trg_Levelled_Slam_Copy_6= null
trigger gg_trg_Levelled_Slam_Copy_7= null
trigger gg_trg_Levelled_Slam_Copy_8= null
trigger gg_trg_Levelled_Slam_Copy_9= null
trigger gg_trg_LevelUpAura= null
trigger gg_trg_DowngradeAura= null
trigger gg_trg_NerubianSpires= null
trigger gg_trg_Frenzy= null
trigger gg_trg_Chemical_Rage= null
trigger gg_trg_ReduceMagicResist= null
trigger gg_trg_ReduceMagicResist2= null
trigger gg_trg_TargetAcquired= null
trigger gg_trg_Poisoned_Bullets2= null
trigger gg_trg_Poisoned_Bullets= null
trigger gg_trg_Permanent_Invisibility= null
trigger gg_trg_Permanent_Invisibility_2= null
trigger gg_trg_Sticky_Glue= null
trigger gg_trg_Wood_Income= null
trigger gg_trg_Enter_Wood_Income= null
trigger gg_trg_SeedOfRebirth= null
trigger gg_trg_Seed_of_Rebirth= null
trigger gg_trg_Seed_of_Rebirth_2= null
trigger gg_trg_Ancient_Artifact= null
trigger gg_trg_Moonstrike= null
trigger gg_trg_Moonstrike_Leveled= null
trigger gg_trg_Moonblast= null
trigger gg_trg_Moonblast_Leveled= null
trigger gg_trg_Lunar_Assault= null
trigger gg_trg_Lunar_Assault_Leveled= null
trigger gg_trg_Cascade_Leveled= null
trigger gg_trg_Nourish= null
trigger gg_trg_Nourish_Leveled= null
trigger gg_trg_Solar_Blast= null
trigger gg_trg_Natural_Vigil_Leveled= null
trigger gg_trg_Lifebloom_Leveled= null
trigger gg_trg_Lunar_Crystal= null
trigger gg_trg_Suns_Fury= null
trigger gg_trg_Return_lumber= null
trigger gg_trg_Gara_2hits1g= null
trigger gg_trg_Gara_2hits1g_2= null
trigger gg_trg_Slash_Leveled= null
trigger gg_trg_Bleed_Leveled= null
trigger gg_trg_Focused_Strike= null
trigger gg_trg_FanOfKnivesBasedSpells= null
trigger gg_trg_Realm_of_darkness= null
trigger gg_trg_Realm_of_darkness_2= null
trigger gg_trg_Thunderstruck= null
trigger gg_trg_Lightning_Strike= null
trigger gg_trg_Neutralize= null
trigger gg_trg_RecallStart= null
trigger gg_trg_Recall= null
trigger gg_trg_Time_warp= null
trigger gg_trg_Galactic_Fury= null
trigger gg_trg_Galactic_Fury_2= null
trigger gg_trg_Galactic_Fury_3= null
trigger gg_trg_Cosmic_Strike= null
trigger gg_trg_Cosmic_Strike_2= null
trigger gg_trg_Cosmic_Strike_3= null
trigger gg_trg_Empower= null
trigger gg_trg_Resillience= null
trigger gg_trg_Resillience_2= null
trigger gg_trg_Resillience_3= null
trigger gg_trg_Sandstorm= null
trigger gg_trg_Sandstorm_2= null
trigger gg_trg_Ancient_Grasp= null
trigger gg_trg_Deserts_Veil= null
trigger gg_trg_Chill= null
trigger gg_trg_Freeze_Zone= null
trigger gg_trg_Freeze_Zone_V2= null
trigger gg_trg_Sadism= null
trigger gg_trg_Reckoning= null
trigger gg_trg_Hammer_Hurl_macko= null
trigger gg_trg_Scepter_Copy= null
trigger gg_trg_Vanguard_Initial= null
trigger gg_trg_Vanguard_Future_Levels= null
trigger gg_trg_Vanguard= null
trigger gg_trg_Omniscience_Initial= null
trigger gg_trg_Omniscience_FL= null
trigger gg_trg_Omniscience= null
trigger gg_trg_Redemption= null
trigger gg_trg_Refreshing_Breeze= null
trigger gg_trg_Gale_Winds= null
trigger gg_trg_WindWalkWispari= null
trigger gg_trg_TornadoMove= null
trigger gg_trg_Sit_tight= null
trigger gg_trg_ClearOnEsc= null
trigger gg_trg_InitialText= null
trigger gg_trg_Welcome= null
trigger gg_trg_Info_Copy= null
trigger gg_trg_Info= null
trigger gg_trg_Ping_Hint= null
trigger gg_trg_Hint2x2= null
trigger gg_trg_HintInvisibility= null
trigger gg_trg_HintFeed= null
trigger gg_trg_Resource_Hint= null
trigger gg_trg_Ping= null
trigger gg_trg_PingForAncient= null
trigger gg_trg_AncientSpells= null
trigger gg_trg_Start= null
trigger gg_trg_Hard_mode_on= null
trigger gg_trg_Hard_Attack= null
trigger gg_trg_Hard_Attack_Cont= null
trigger gg_trg_Hard_attack_2= null
trigger gg_trg_Select= null
trigger gg_trg_Attack= null
trigger gg_trg_Run_away= null
trigger gg_trg_Slot1_Righteous_Armor= null
trigger gg_trg_Slot2_Valor_Helmet= null
trigger gg_trg_Slot3_Bladed_Gauntlet= null
trigger gg_trg_Slot4_Bladed_Gauntlet= null
trigger gg_trg_Slot5_Bladed_Gauntlet= null
trigger gg_trg_Slot6_Bladed_Gauntlet= null
trigger gg_trg_Level_Up_Tomes= null
trigger gg_trg_Abilities= null
trigger gg_trg_Staff_of_insight_pickup= null
trigger gg_trg_Debug_Control= null
trigger gg_trg_Dusts_Slow= null
trigger gg_trg_Hatred= null
trigger gg_trg_Firelords_Cape_usage= null
trigger gg_trg_Firelords_Cape_pickup= null
trigger gg_trg_Bladed_Gauntlet_vs_Hero= null
trigger gg_trg_Cast_CL_on_Banish= null
trigger gg_trg_Ledgers_XP= null
trigger gg_trg_Ledger_of_Clarity_pickup= null
trigger gg_trg_Ledger_of_Clarity_lose= null
trigger gg_trg_Ledger_of_Enlightment_pickup= null
trigger gg_trg_Ledger_of_Enlightment_lose= null
trigger gg_trg_Bonus_XP= null
trigger gg_trg_Spellcasters_Cloak= null
trigger gg_trg_Ethereal_Scepter= null
trigger gg_trg_Firelords_Cape= null
trigger gg_trg_Ledget_of_Enlightment= null
trigger gg_trg_Hammer_of_might= null
trigger gg_trg_Valorous_Helmet= null
trigger gg_trg_Bladed_Gauntlet= null
trigger gg_trg_Righteous_Armor= null
trigger gg_trg_Arcanum_of_Hatred= null
trigger gg_trg_Bleeding_Scythe= null
trigger gg_trg_Staff_of_Insight= null
trigger gg_trg_Cosmic_Orb= null
trigger gg_trg_Level_up= null
trigger gg_trg_Deliver_Gold= null
trigger gg_trg_Worgens_gold= null
trigger gg_trg_Invul= null
trigger gg_trg_Bounty= null
trigger gg_trg_Remove_Ancient_Lumber= null
trigger gg_trg_Ancient_Gold_income= null
trigger gg_trg_Initialization= null
trigger gg_trg_LimitedTraining= null
trigger gg_trg_TimeToExpanderSpawn= null
trigger gg_trg_TimeToAncientSpawn= null
trigger gg_trg_Unit_Indexer= null
trigger gg_trg_Spellbringers_spells= null
trigger gg_trg_Give_orb= null
trigger gg_trg_Colors= null
trigger gg_trg_Name_Change= null
trigger gg_trg_Name_Change_II= null
trigger gg_trg_Name_Change_III= null
trigger gg_trg_RandomExpander= null
trigger gg_trg_RandomExpander2= null
trigger gg_trg_Random_Ancient= null
trigger gg_trg_Remove_Selection= null
trigger gg_trg_Remove_Selector= null
trigger gg_trg_Trade_disabled= null
trigger gg_trg_Trade_enabled= null
trigger gg_trg_Disable_trade_enabled= null
trigger gg_trg_Spawn_Races= null
trigger gg_trg_Spawn_Ancients= null
trigger gg_trg_DisableExpanderBans= null
trigger gg_trg_Worgen= null
trigger gg_trg_Centaur= null
trigger gg_trg_Wildkin= null
trigger gg_trg_Nerubian= null
trigger gg_trg_Human= null
trigger gg_trg_Wisp= null
trigger gg_trg_Kobold= null
trigger gg_trg_Ghoul= null
trigger gg_trg_Kraken= null
trigger gg_trg_Aethyr= null
trigger gg_trg_Forgotten= null
trigger gg_trg_Goblin= null
trigger gg_trg_Ogre= null
trigger gg_trg_Magmide= null
trigger gg_trg_Furbolg= null
trigger gg_trg_Razormane= null
trigger gg_trg_Elf= null
trigger gg_trg_HighElf= null
trigger gg_trg_Ratling= null
trigger gg_trg_Hunter= null
trigger gg_trg_AncientLight= null
trigger gg_trg_AncientLightning= null
trigger gg_trg_AncientDragon= null
trigger gg_trg_AncientEarth= null
trigger gg_trg_AncientDarkness= null
trigger gg_trg_AncientIce= null
trigger gg_trg_AncientFire= null
trigger gg_trg_AncientNature= null
trigger gg_trg_AncientSand= null
trigger gg_trg_AncientSpace= null
trigger gg_trg_AncientWind= null
trigger gg_trg_Prevent_Attack= null
trigger gg_trg_No_Attacking_Shops_Copy_3= null
trigger gg_trg_No_Attacking_Shops_Copy_2= null
trigger gg_trg_No_Attacking_Shops_Copy= null
trigger gg_trg_No_Attacking_Shops= null
trigger gg_trg_Ally_neutral= null
trigger gg_trg_Vision= null
trigger gg_trg_Death_anim= null
trigger gg_trg_Quests= null
trigger gg_trg_Warning_few_seconds= null
trigger gg_trg_Camera_Copy= null
trigger gg_trg_LatePickers= null
trigger gg_trg_AncientSpawnTele= null
trigger gg_trg_Player_group= null
trigger gg_trg_Lackey_Respawn= null
trigger gg_trg_Death_start= null
trigger gg_trg_Spawn_Lackey= null
trigger gg_trg_MiniMinis= null
trigger gg_trg_Player_Leaves= null
trigger gg_trg_Ancient_Leaves= null
trigger gg_trg_Human_Dies= null
trigger gg_trg_Wisp_Dies= null
trigger gg_trg_Centaur_Dies= null
trigger gg_trg_Ogre_Dies= null
trigger gg_trg_Worgen_Dies= null
trigger gg_trg_Night_Elf_Dies= null
trigger gg_trg_Shadow_Dancer_Dies= null
trigger gg_trg_Archdruid_Dies= null
trigger gg_trg_Engineer_Highelf_Dies= null
trigger gg_trg_Bounty_Hunter_Dies= null
trigger gg_trg_Ghoul_Dies= null
trigger gg_trg_Magmide_Dies= null
trigger gg_trg_Goblin_Dies= null
trigger gg_trg_Ratling_Dies= null
trigger gg_trg_Goblin_Ultima_Dies= null
trigger gg_trg_Furbolg_Shaman_Dies= null
trigger gg_trg_Furbolg_Warrior_Dies= null
trigger gg_trg_Furbolg_Dies= null
trigger gg_trg_Nerubian_Dies= null
trigger gg_trg_Kraken_Dies= null
trigger gg_trg_Aethyr_Warp_Dies= null
trigger gg_trg_Kobold_Dies= null
trigger gg_trg_Razormane_Dies= null
trigger gg_trg_Wildkin_Dies= null
trigger gg_trg_Forgotten_One_Dies= null
trigger gg_trg_Forgotten_Bloodmage_Dies= null
trigger gg_trg_Forgotten_Executioner_Dies= null
trigger gg_trg_Forgotten_Soulreaper_Dies= null
trigger gg_trg_Ignite_Dies= null
trigger gg_trg_Avalanche_Dies= null
trigger gg_trg_Paranoia_Dies= null
trigger gg_trg_Eternity_Dies= null
trigger gg_trg_Dragos_Dies= null
trigger gg_trg_Tremor_Dies= null
trigger gg_trg_Zalxon_Dies= null
trigger gg_trg_Divinity_Dies= null
trigger gg_trg_Pharoah_Dies= null
trigger gg_trg_Nebula_Dies= null
trigger gg_trg_Wispari_Dies= null
trigger gg_trg_Remove_Resources_new= null
trigger gg_trg_DVIC_1= null
trigger gg_trg_Ext_On= null
trigger gg_trg_Extermination= null
trigger gg_trg_Base_List_Init= null
trigger gg_trg_Flagstack_Deny= null
trigger gg_trg_Flag_no_base_Deny= null
trigger gg_trg_Flag_Destroyed= null
trigger gg_trg_killcommand= null
trigger gg_trg_speedcommand= null
trigger gg_trg_NewFlag= null
trigger gg_trg_NewFlag2= null
trigger gg_trg_NewFlag3= null
trigger gg_trg_NewFlag4= null
trigger gg_trg_NewFlag5= null
trigger gg_trg_Gobo_Mech_Blaster_pickup= null
trigger gg_trg_Gobo_Mech_Blaster_attack_check= null
unit gg_unit_h00Q_0026= null
unit gg_unit_nmer_0000= null
unit gg_unit_nmr2_0001= null
unit gg_unit_n00G_0035= null
unit gg_unit_n00B_0266= null
boolean udg_HardmodeEnabled= false
boolean udg_HardmodeCanBeEnabled= true
timer udg_HardmodePeriodicTimer= null
sound udg_HardmodeSound= null
constant string HARDMODE_SOUND_PATH= "Units\\Human\\Kael\\KaelYesAttack3.flac"
constant string FEEDRATE_FILE_PATH= "ForestExpansion\\ForestExpansion.pld"
constant string FEEDRATE_SYNC_PREFIX= "FRAT"
constant string FEEDRATE_NAME_SYNC_PREFIX= "FRNM"
constant integer FEEDRATE_MAX_PLAYERS= 11

button FeedRate_ButtonYes= null
button FeedRate_ButtonOtherTag= null
button FeedRate_ButtonNo= null

trigger FeedRate_YesTrigger= null
trigger FeedRate_OtherTagTrigger= null
trigger FeedRate_NoTrigger= null
trigger FeedRate_SyncTrigger= null
trigger FeedRate_NameSyncTrigger= null

boolean array FeedRate_Loaded

boolean array FeedRate_PendingRateReceived
integer array FeedRate_PendingRate
boolean array FeedRate_PendingNameReceived
string array FeedRate_PendingName
hashtable SNIPESHOT_Hash= InitHashtable()
group SNIPESHOT_Group= CreateGroup()

constant integer SNIPESHOT_ABILITY_ID= 'A0F7'
constant integer SNIPESHOT_DUMMY_ID= 'h06G'
constant integer SNIPESHOT_STUN_ABILITY_ID= 'A0F9'

constant string SNIPESHOT_MISSILE_MODEL= "Abilities\\Weapons\\AncestralGuardianMissile\\AncestralGuardianMissile.mdl"
constant string SNIPESHOT_STUN_ORDER= "thunderbolt"

constant real SNIPESHOT_CHANNEL_TIME= 1.50
constant real SNIPESHOT_COOLDOWN= 60.00
constant real SNIPESHOT_PERIOD= 0.03125
constant real SNIPESHOT_MAX_RANGE= 3000.00
constant real SNIPESHOT_SPEED= 3000.00
constant real SNIPESHOT_COLLISION= 96.00
constant real SNIPESHOT_DAMAGE_PER_STEP= 100.00
constant real SNIPESHOT_DAMAGE_DISTANCE_STEP= 100.00
constant real SNIPESHOT_MISSILE_HEIGHT= 60.00
hashtable DashHash= InitHashtable()

constant real DASH_RANGE= 1000.00
constant real DASH_SPEED= 2000.00
constant real DASH_PERIOD= 0.03

constant string DASH_ATTACH_EFFECT= "Abilities\\Spells\\NightElf\\Blink\\BlinkTarget.mdl"
constant string DASH_TRAIL_EFFECT= "Abilities\\Spells\\Human\\FlakCannons\\FlakTarget.mdl"

constant real DASH_TRAIL_INTERVAL= 40.00
group FleshStampede_Group= null
hashtable FleshStampede_Hash= null

constant integer FLESH_STAMPEDE_ABILITY_ID= 'A0EF'
constant integer FLESH_STAMPEDE_BUFF_ID= 'B03T'
constant integer FLESH_STAMPEDE_MISS_KEY= 0
constant integer FLESH_STAMPEDE_MISS_LIMIT= 3

constant real FLESH_STAMPEDE_PERIOD= 0.50
constant real FLESH_STAMPEDE_DAMAGE_FACTOR= 0.02
constant integer UPG_ABILITY_ID= 'A08P'
constant integer UPG_UPGRADE_ID= 'R01J'

constant integer UPG_BASE_ABILITY_LEVEL= 1
constant integer UPG_MAX_ABILITY_LEVEL= 11

group UPG_TempGroup= CreateGroup()
trigger UPG_ResearchTrig= null
trigger UPG_EnterTrig= null
region UPG_WorldRegion= null
hashtable udg_MoonblastHash= null

constant integer MOONBLAST_ABILITY_ID= 'A07H'
constant real MOONBLAST_DAMAGE_FACTOR= 0.33

constant real MOONBLAST_TICK= 0.03125
constant real MOONBLAST_SPEED= 900.00
constant real MOONBLAST_COLLISION= 75.00

constant string MOONBLAST_MISSILE_MODEL= "war3mapImported\\StarfallMissle.mdx"
    // Existing spell.
constant integer BURST_DRAGONIC_ABIL_ID= 'A02B'

    // New spell. Change this rawcode.
constant integer BURST_LICH_ABIL_ID= 'A008'

constant real BURST_PERIOD= 0.031250

group BURST_ENUM_GROUP= CreateGroup()
timer BURST_TIMER= CreateTimer()

integer BURST_COUNT= 0

unit array BURST_CASTER
unit array BURST_TARGET
effect array BURST_MISSILE

real array BURST_X
real array BURST_Y
real array BURST_DAMAGE
real array BURST_SPEED
real array BURST_HEIGHT
constant integer SSZ_SPELL_ID= 'A0F1'
constant integer SSZ_SLOW_ID= 'A0F0'

constant real SSZ_AOE= 3000.00
constant real SSZ_DAMAGE= 100.00
constant real SSZ_SLOW_DURATION= 1.00

hashtable SSZ_HASH= null
constant integer TP_SPELL_ID= 'A0EX'
constant integer TP_DEBUFF_ID= 'A0EZ'
constant integer TP_DUMMY_ID= 'h06G'

constant string TP_DEBUFF_ORDER= "slow"

constant real TP_AOE= 4000.00
constant real TP_DAMAGE_BASE= 100.00
constant real TP_DAMAGE_PER_LEVEL= 50.00
constant real TP_DUMMY_CAST_DELAY= 0.00
constant real TP_DUMMY_LIFETIME= 6.00

constant player TP_DUMMY_OWNER= Player(12)

hashtable TP_HASH= null
hashtable WW_Hash= InitHashtable()

constant integer WW_ABILITY_ID= 'A0EO'
constant integer WW_BUFF_ID= 'B03X'
constant integer WW_SPAWN_ID= 'u00M'

constant real WW_PERIOD= 0.50
constant real WW_SPAWN_LIFE= 3.00
constant integer TORNADO_ABILITY_ID= 'A0EL'

constant string TORNADO_MODEL_PATH= "Abilities\\Spells\\Other\\Tornado\\TornadoElemental.mdl"
constant real TORNADO_EFFECT_SCALE= 1.00

constant real TORNADO_PERIOD= 0.031250
constant real TORNADO_CHANNEL_BASE= 0.60
constant real TORNADO_CHANNEL_PER_LEVEL= 0.10
constant real TORNADO_MOVE_TOLERANCE= 5.00
constant real TORNADO_ENDCAST_TOLERANCE= 0.05

constant integer TORNADO_KEY_EFFECT= 0
constant integer TORNADO_KEY_X= 1
constant integer TORNADO_KEY_Y= 2
constant integer TORNADO_KEY_ANGLE= 3
constant integer TORNADO_KEY_TRAVELED= 4
constant integer TORNADO_KEY_MAX_DISTANCE= 5
constant integer TORNADO_KEY_CASTER= 6
constant integer TORNADO_KEY_CHANNEL_ACTIVE= 7
constant integer TORNADO_KEY_CHANNEL_LEFT= 8
constant integer TORNADO_KEY_START_X= 9
constant integer TORNADO_KEY_START_Y= 10
constant integer TORNADO_KEY_SPEED= 11
constant integer TORNADO_KEY_DYING= 12

constant integer TORNADO_CASTER_KEY_TIMER= 100

hashtable udg_TornadoHash= null
hashtable DAS_Hash= InitHashtable()
group DAS_EnumGroup= CreateGroup()

constant integer DAS_DUST_CAST_ABILITY_ID= 'AItb'
constant integer DAS_DUST_BUFF_ID= 'Bdet'
constant integer DAS_SLOW_AURA_ID= 'A0FA'

constant integer DAS_PERMANENT_INVIS_ABILITY= 'Apiv'

constant real DAS_RADIUS= 1000.00
constant real DAS_PERIOD= 0.10

constant integer DAS_KEY_TRACK_TIMER= 0
constant integer DAS_KEY_TIMER_TARGET= 1
constant integer DAS_KEY_TIMER_OWNER= 2

player DAS_EnumOwner= null

integer array DAS_InvisBuff
integer DAS_InvisBuffCount= 0
trigger gg_trg_AncientTeleport= null
timer TeleportEnableTimer= null
region teleportRegion= null
constant real ENABLE_DELAY= 50.0
hashtable LackeyRespawn_Hash= InitHashtable()

constant real LACK_RESPAWN_DELAY= 60.00

constant integer LACK_RESPAWN_KEY_TYPE= 0
constant integer LACK_RESPAWN_KEY_PLAYER= 1
constant integer LACK_RESPAWN_KEY_DIALOG= 2
constant real SPAWN_LACKEY_DELAY_MARK= 360.00
hashtable SpawnLackey_Hash= null
timer SpawnLackey_GameTimer= null
timer array SpawnLackey_PlayerTimer
timerdialog array SpawnLackey_PlayerDialog

trigger l__library_init

//JASSHelper struct globals:
constant integer si__DamageTrigger=1
integer s__DamageTrigger_MOD= 1
integer s__DamageTrigger_SHIELD= 4
integer s__DamageTrigger_DAMAGE= 5
integer s__DamageTrigger_ZERO= 6
integer s__DamageTrigger_AFTER= 7
integer s__DamageTrigger_LETHAL= 8
integer s__DamageTrigger_AOE= 9
integer s__DamageTrigger_count= 9
integer s__DamageTrigger_lastRegistered= 0
integer array s__DamageTrigger_trigIndexStack
integer s__DamageTrigger_eventIndex= 0
boolean array s__DamageTrigger_filters
string array s__DamageTrigger_eventStr
real array s__DamageTrigger_weight
boolean array s__DamageTrigger_usingGUI
integer array s__DamageTrigger_next
trigger array s__DamageTrigger_rootTrig
boolean array s__DamageTrigger_DamageEngine___trigFrozen
integer array s__DamageTrigger_DamageEngine___ownRecursiveDepth
boolean array s__DamageTrigger_DamageEngine___manualRecursionRequested
boolean array s__DamageTrigger_configured
unit array s__DamageTrigger_source
unit array s__DamageTrigger_target
integer array s__DamageTrigger_sourceType
integer array s__DamageTrigger_targetType
integer array s__DamageTrigger_sourceBuff
integer array s__DamageTrigger_targetBuff
integer array s__DamageTrigger_sourceItem
integer array s__DamageTrigger_targetItem
integer array s__DamageTrigger_sourceClass
integer array s__DamageTrigger_targetClass
real array s__DamageTrigger_damageMin
real array s__DamageTrigger_failChance
integer array s__DamageTrigger_attackType
integer array s__DamageTrigger_damageType
integer array s__DamageTrigger_userType
integer s__DamageTrigger_prev= 0
trigger array s__DamageTrigger_autoTriggers
boolexpr array s__DamageTrigger_autoFuncs
integer s__DamageTrigger_autoN= 0
constant integer si__Damage=2
unit array s__Damage_sourceUnit
unit array s__Damage_targetUnit
real array s__Damage_damage
real array s__Damage_prevAmt
attacktype array s__Damage_attackType
damagetype array s__Damage_damageType
weapontype array s__Damage_weaponType
integer array s__Damage_userType
boolean array s__Damage_isAttack
boolean array s__Damage_isCode
boolean array s__Damage_isSpell
boolean array s__Damage_isMelee
boolean array s__Damage_isRanged
integer array s__Damage_eFilter
real array s__Damage_armorPierced
integer array s__Damage_armorType
integer array s__Damage_defenseType
integer s__Damage_index= 0
integer s__Damage_damageStack= 0
integer s__Damage_prepped= 0
integer s__Damage_count= 0
integer array s__Damage_stackRef
integer array s__Damage_recursiveTrig
integer array s__Damage_prevArmorT
integer array s__Damage_prevDefenseT
boolean s__Damage_threadCompleted= false
trigger array st___prototype2
trigger f__arg_trigger1
string f__arg_string1
limitop f__arg_limitop1
real f__arg_real1

endglobals
native UnitAlive takes unit u returns boolean

function sc___prototype2_execute takes integer i,trigger a1,string a2,limitop a3,real a4 returns nothing
    set f__arg_trigger1=a1
    set f__arg_string1=a2
    set f__arg_limitop1=a3
    set f__arg_real1=a4

    call TriggerExecute(st___prototype2[i])
endfunction
function sc___prototype2_evaluate takes integer i,trigger a1,string a2,limitop a3,real a4 returns nothing
    set f__arg_trigger1=a1
    set f__arg_string1=a2
    set f__arg_limitop1=a3
    set f__arg_real1=a4

    call TriggerEvaluate(st___prototype2[i])

endfunction
function h__TriggerRegisterVariableEvent takes trigger a0, string a1, limitop a2, real a3 returns event
    //hook: DamageEngine_RegisterFromHook
    call sc___prototype2_evaluate(1,a0,a1,a2,a3)
return TriggerRegisterVariableEvent(a0,a1,a2,a3)
endfunction

//library DamageEngine:



//GUI Vars:



    function s__DamageTrigger_checkItem takes unit u,integer id returns boolean
        local integer i
        if IsUnitType(u, UNIT_TYPE_HERO) then
            set i=UnitInventorySize(u)
            loop
                exitwhen i <= 0
                set i=i - 1
                if GetItemTypeId(UnitItemInSlot(u, i)) == id then
                    return true
                endif
            endloop
        endif
        return false
    endfunction


    function s__DamageTrigger_checkConfig takes integer this returns boolean

        //call BJDebugMsg("Checking configuration")

        if s__DamageTrigger_sourceType[this] != 0 and GetUnitTypeId(udg_DamageEventSource) != s__DamageTrigger_sourceType[this] then
        elseif s__DamageTrigger_targetType[this] != 0 and GetUnitTypeId(udg_DamageEventTarget) != s__DamageTrigger_targetType[this] then
        elseif s__DamageTrigger_sourceBuff[this] != 0 and GetUnitAbilityLevel(udg_DamageEventSource, s__DamageTrigger_sourceBuff[this]) == 0 then
        elseif s__DamageTrigger_targetBuff[this] != 0 and GetUnitAbilityLevel(udg_DamageEventTarget, s__DamageTrigger_targetBuff[this]) == 0 then
        elseif s__DamageTrigger_failChance[this] > 0.00 and GetRandomReal(0.00, 1.00) <= s__DamageTrigger_failChance[this] then
        elseif s__DamageTrigger_userType[this] != 0 and udg_DamageEventType != s__DamageTrigger_userType[this] then
        elseif s__DamageTrigger_source[this] != null and s__DamageTrigger_source[this] != udg_DamageEventSource then
        elseif s__DamageTrigger_target[this] != null and s__DamageTrigger_target[this] != udg_DamageEventTarget then
        elseif s__DamageTrigger_attackType[this] >= 0 and s__DamageTrigger_attackType[this] != udg_DamageEventAttackT then
        elseif s__DamageTrigger_damageType[this] >= 0 and s__DamageTrigger_damageType[this] != udg_DamageEventDamageT then
        elseif s__DamageTrigger_sourceItem[this] != 0 and not s__DamageTrigger_checkItem(udg_DamageEventSource , s__DamageTrigger_sourceItem[this]) then
        elseif s__DamageTrigger_targetItem[this] != 0 and not s__DamageTrigger_checkItem(udg_DamageEventTarget , s__DamageTrigger_targetItem[this]) then
        elseif s__DamageTrigger_sourceClass[this] >= 0 and not IsUnitType(udg_DamageEventSource, ConvertUnitType(s__DamageTrigger_sourceClass[this])) then
        elseif s__DamageTrigger_targetClass[this] >= 0 and not IsUnitType(udg_DamageEventTarget, ConvertUnitType(s__DamageTrigger_targetClass[this])) then
        elseif udg_DamageEventAmount >= s__DamageTrigger_damageMin[this] then
            //call BJDebugMsg("Configuration passed")
            return true
        endif
        //call BJDebugMsg("Checking failed")
        return false
    endfunction

    //The below variables are to be treated as constant






    //The below variables are to be treated as private

    //configuration variables:

    // getter:
    function s__DamageTrigger__get_runChance takes integer this returns real
        return 1.00 - s__DamageTrigger_failChance[this]
    endfunction

    // setter:
    function s__DamageTrigger__set_runChance takes integer this,real chance returns nothing
        set s__DamageTrigger_failChance[this]=1.00 - chance
    endfunction

    function s__DamageTrigger_configure takes integer this returns nothing
        set s__DamageTrigger_attackType[this]=udg_DamageFilterAttackT
        set s__DamageTrigger_damageType[this]=udg_DamageFilterDamageT
        set s__DamageTrigger_source[this]=udg_DamageFilterSource
        set s__DamageTrigger_target[this]=udg_DamageFilterTarget
        set s__DamageTrigger_sourceType[this]=udg_DamageFilterSourceT
        set s__DamageTrigger_targetType[this]=udg_DamageFilterTargetT
        set s__DamageTrigger_sourceItem[this]=udg_DamageFilterSourceI
        set s__DamageTrigger_targetItem[this]=udg_DamageFilterTargetI
        set s__DamageTrigger_sourceClass[this]=udg_DamageFilterSourceC
        set s__DamageTrigger_targetClass[this]=udg_DamageFilterTargetC
        set s__DamageTrigger_userType[this]=udg_DamageFilterType
        set s__DamageTrigger_damageMin[this]=udg_DamageFilterMinAmount
        set s__DamageTrigger_failChance[this]=1.00 - ( udg_DamageFilterRunChance - udg_DamageFilterFailChance )

        if udg_DamageFilterSourceA > 0 then
            set s__DamageTrigger_sourceBuff[this]=udg_DamageFilterSourceA
            set udg_DamageFilterSourceA=0
        else
            set s__DamageTrigger_sourceBuff[this]=udg_DamageFilterSourceB
        endif

        if udg_DamageFilterTargetA > 0 then
            set s__DamageTrigger_targetBuff[this]=udg_DamageFilterTargetA
            set udg_DamageFilterTargetA=0
        else
            set s__DamageTrigger_targetBuff[this]=udg_DamageFilterTargetB
        endif

        set udg_DamageFilterSource=null
        set udg_DamageFilterTarget=null

        //These handles can have a valid value of 0, so we need to distinguish them.
        set udg_DamageFilterAttackT=- 1
        set udg_DamageFilterDamageT=- 1
        set udg_DamageFilterSourceC=- 1
        set udg_DamageFilterTargetC=- 1

        set udg_DamageFilterSourceT=0
        set udg_DamageFilterTargetT=0
        set udg_DamageFilterType=0
        set udg_DamageFilterSourceB=0
        set udg_DamageFilterTargetB=0
        set udg_DamageFilterSourceI=0
        set udg_DamageFilterTargetI=0
        
        set udg_DamageFilterMinAmount=0.00
        set udg_DamageFilterFailChance=0.00
        set udg_DamageFilterRunChance=1.00

        set s__DamageTrigger_configured[this]=true
    endfunction

    function s__DamageTrigger_setGUIFromStruct takes boolean full returns nothing
        set udg_DamageEventAmount=s__Damage_damage[s__Damage_index]
        set udg_DamageEventAttackT=GetHandleId(s__Damage_attackType[s__Damage_index])
        set udg_DamageEventDamageT=GetHandleId(s__Damage_damageType[s__Damage_index])
        set udg_DamageEventWeaponT=GetHandleId(s__Damage_weaponType[s__Damage_index])
        set udg_DamageEventType=s__Damage_userType[s__Damage_index]
        

            set udg_DamageEventArmorPierced=s__Damage_armorPierced[s__Damage_index]
            set udg_DamageEventArmorT=s__Damage_armorType[s__Damage_index]
            set udg_DamageEventDefenseT=s__Damage_defenseType[s__Damage_index]

        if full then
            set udg_DamageEventSource=s__Damage_sourceUnit[s__Damage_index]
            set udg_DamageEventTarget=s__Damage_targetUnit[s__Damage_index]
            set udg_DamageEventPrevAmt=s__Damage_prevAmt[s__Damage_index]
            set udg_IsDamageAttack=s__Damage_isAttack[s__Damage_index]
            set udg_IsDamageCode=s__Damage_isCode[s__Damage_index]
            set udg_IsDamageSpell=s__Damage_isSpell[s__Damage_index]
            
//ignored textmacro command: ATTACK_INDEXER_GUI_VARS()


                set udg_IsDamageMelee=s__Damage_isMelee[s__Damage_index]
                set udg_IsDamageRanged=s__Damage_isRanged[s__Damage_index]

        endif
    endfunction

    function s__DamageTrigger_setStructFromGUI takes nothing returns nothing
        set s__Damage_damage[s__Damage_index]=udg_DamageEventAmount
        set s__Damage_attackType[s__Damage_index]=ConvertAttackType(udg_DamageEventAttackT)
        set s__Damage_damageType[s__Damage_index]=ConvertDamageType(udg_DamageEventDamageT)
        set s__Damage_weaponType[s__Damage_index]=ConvertWeaponType(udg_DamageEventWeaponT)
        set s__Damage_userType[s__Damage_index]=udg_DamageEventType
        

            set s__Damage_armorPierced[s__Damage_index]=udg_DamageEventArmorPierced
            set s__Damage_armorType[s__Damage_index]=udg_DamageEventArmorT
            set s__Damage_defenseType[s__Damage_index]=udg_DamageEventDefenseT

    endfunction

    function s__DamageTrigger_getVerboseStr takes string eventName returns string
        if eventName == "Modifier" or eventName == "Mod" then
            return "udg_DamageModifierEvent"
        endif
        return "udg_" + eventName + "DamageEvent"
    endfunction

    function s__DamageTrigger_getStrIndex takes string var,real lbs returns integer
        local integer root= R2I(lbs)
        if ( var == "udg_DamageModifierEvent" and root < 4 ) or var == "udg_PreDamageEvent" then
            set root=s__DamageTrigger_MOD
        elseif var == "udg_DamageModifierEvent" or var == "udg_ArmorDamageEvent" then
            set root=s__DamageTrigger_SHIELD
        elseif ( var == "udg_DamageEvent" and root == 2 or root == 0 ) or var == "udg_ZeroDamageEvent" then
            set root=s__DamageTrigger_ZERO
        elseif var == "udg_DamageEvent" or var == "udg_OnDamageEvent" then
            set root=s__DamageTrigger_DAMAGE
        elseif var == "udg_AfterDamageEvent" then
            set root=s__DamageTrigger_AFTER
        elseif var == "udg_LethalDamageEvent" then
            set root=s__DamageTrigger_LETHAL
        elseif var == "udg_AOEDamageEvent" or var == "udg_SourceDamageEvent" then
            set root=s__DamageTrigger_AOE
        else
            set root=0
//ignored textmacro command: DAMAGE_EVENT_REG_PLUGIN_GDD()
//ignored textmacro command: DAMAGE_EVENT_REG_PLUGIN_PDD()
//ignored textmacro command: DAMAGE_EVENT_REG_PLUGIN_01()
//ignored textmacro command: DAMAGE_EVENT_REG_PLUGIN_02()
//ignored textmacro command: DAMAGE_EVENT_REG_PLUGIN_03()
//ignored textmacro command: DAMAGE_EVENT_REG_PLUGIN_04()
//ignored textmacro command: DAMAGE_EVENT_REG_PLUGIN_05()
        endif
        return root
    endfunction

    function s__DamageTrigger_toggleAllFilters takes integer this,boolean flag returns nothing
        set s__DamageTrigger_filters[this + DamageEngine_FILTER_ATTACK]=flag
        set s__DamageTrigger_filters[this + DamageEngine_FILTER_MELEE]=flag
        set s__DamageTrigger_filters[this + DamageEngine_FILTER_OTHER]=flag
        set s__DamageTrigger_filters[this + DamageEngine_FILTER_RANGED]=flag
        set s__DamageTrigger_filters[this + DamageEngine_FILTER_SPELL]=flag
        set s__DamageTrigger_filters[this + DamageEngine_FILTER_CODE]=flag
    endfunction

    function s__DamageTrigger__set_filter takes integer this,integer opId returns nothing
        set this=this * DamageEngine_FILTER_MAX
        if opId == DamageEngine_FILTER_OTHER then
            call s__DamageTrigger_toggleAllFilters(this,true)
        else
            if opId == DamageEngine_FILTER_ATTACK then
                set s__DamageTrigger_filters[this + DamageEngine_FILTER_ATTACK]=true
                set s__DamageTrigger_filters[this + DamageEngine_FILTER_MELEE]=true
                set s__DamageTrigger_filters[this + DamageEngine_FILTER_RANGED]=true
            else
                set s__DamageTrigger_filters[this + opId]=true
            endif
        endif
    endfunction

    function s__DamageTrigger_registerVerbose takes trigger whichTrig,string var,real lbs,boolean GUI,integer filt returns integer
        local integer index= s__DamageTrigger_getStrIndex(var , lbs)
        local integer i= 0
        local integer id= 0

        if index == 0 then
            return 0
        elseif s__DamageTrigger_rootTrig[s__DamageTrigger_lastRegistered] == whichTrig and s__DamageTrigger_usingGUI[s__DamageTrigger_lastRegistered] then
            //allows GUI to register multiple different types of Damage filters to the same trigger
            set s__DamageTrigger_filters[s__DamageTrigger_lastRegistered * DamageEngine_FILTER_MAX + filt]=true
            return 0
        endif

        set DamageEngine___atLeastOneLethalDamageEventRegistered=DamageEngine___atLeastOneLethalDamageEventRegistered or index == s__DamageTrigger_LETHAL

        if s__DamageTrigger_trigIndexStack[0] == 0 then
            set s__DamageTrigger_count=s__DamageTrigger_count + 1 //List runs from index 10 and up
            set id=s__DamageTrigger_count
        else
            set id=s__DamageTrigger_trigIndexStack[0]
            set s__DamageTrigger_trigIndexStack[0]=s__DamageTrigger_trigIndexStack[id]
        endif
        set s__DamageTrigger_lastRegistered=id
        call s__DamageTrigger__set_filter(id,filt)
        set s__DamageTrigger_rootTrig[id]=whichTrig
        set s__DamageTrigger_usingGUI[id]=GUI
        set s__DamageTrigger_weight[id]=lbs
        set s__DamageTrigger_eventStr[id]=var

        //Next 2 lines added to fix a bug when using manual vJass configuration,
        //discovered and solved by lolreported
        set s__DamageTrigger_attackType[id]=- 1
        set s__DamageTrigger_damageType[id]=- 1

        //they will probably bug out with class types as well, so I should add them, just in case:
        set s__DamageTrigger_sourceClass[id]=- 1
        set s__DamageTrigger_targetClass[id]=- 1

        loop
            set i=s__DamageTrigger_next[index]
            exitwhen i == 0 or lbs < s__DamageTrigger_weight[i]
            set index=i
        endloop
        set s__DamageTrigger_next[index]=id
        set s__DamageTrigger_next[id]=i

        //call BJDebugMsg("Registered " + I2S(id) + " to " + I2S(index) + " and before " + I2S(i))
        return s__DamageTrigger_lastRegistered
    endfunction

    function s__DamageTrigger_registerTrigger takes trigger t,string var,real lbs returns integer
        return s__DamageTrigger_registerVerbose(t , s__DamageTrigger_getVerboseStr(var) , lbs , false , DamageEngine_FILTER_OTHER)
    endfunction

    function s__DamageTrigger_getIndex takes trigger t,string eventName,real lbs returns integer
        local integer index= s__DamageTrigger_getStrIndex(s__DamageTrigger_getVerboseStr(eventName) , lbs)
        loop
            set s__DamageTrigger_prev=index
            set index=s__DamageTrigger_next[index]
            exitwhen index == 0 or s__DamageTrigger_rootTrig[index] == t
        endloop
        return index
    endfunction

    function s__DamageTrigger_unregisterByIndex takes integer this,boolean reset returns boolean
        if this == 0 then
            return false
        endif
        set s__DamageTrigger_next[s__DamageTrigger_prev]=s__DamageTrigger_next[this]

        set s__DamageTrigger_trigIndexStack[this]=s__DamageTrigger_trigIndexStack[0]
        set s__DamageTrigger_trigIndexStack[0]=this

        if reset then
            call s__DamageTrigger_configure(this)
            set s__DamageTrigger_configured[this]=false
            call s__DamageTrigger_toggleAllFilters((this * DamageEngine_FILTER_MAX),false)
        endif
        return true
    endfunction

    function s__DamageTrigger_unregister takes trigger t,string eventName,real lbs,boolean reset returns boolean
        return s__DamageTrigger_unregisterByIndex(s__DamageTrigger_getIndex(t , eventName , lbs),reset)
    endfunction

    function s__DamageTrigger_DamageEngine___run takes integer this returns nothing
        local integer cat= this
        local integer d= s__Damage_index


            local boolean structUnset= false
            local boolean guiUnset= false
            local boolean mod= cat <= s__DamageTrigger_DAMAGE


        if DamageEngine___callbacksInProgress then
            return
        endif
        set DamageEngine___callbacksInProgress=true
        call DisableTrigger(DamageEngine___damagingTrigger)
        call DisableTrigger(DamageEngine___damagedTrigger)
        call EnableTrigger(DamageEngine___recursiveTrigger)
        //call BJDebugMsg("Start of event running")
        loop
            set this=s__DamageTrigger_next[this]
            exitwhen this == 0
            exitwhen cat == s__DamageTrigger_MOD and ( udg_DamageEventOverride or udg_DamageEventType == DamageEngine_TYPE_PURE )
            exitwhen cat == s__DamageTrigger_SHIELD and udg_DamageEventAmount <= 0.00


                exitwhen cat == s__DamageTrigger_LETHAL and udg_LethalDamageHP > DamageEngine___DEATH_VAL


            set s__DamageTrigger_eventIndex=this
            if ( not s__DamageTrigger_DamageEngine___trigFrozen[this] ) and s__DamageTrigger_filters[this * DamageEngine_FILTER_MAX + s__Damage_eFilter[d]] and IsTriggerEnabled(s__DamageTrigger_rootTrig[this]) and ( ( not s__DamageTrigger_configured[this] ) or ( s__DamageTrigger_checkConfig(this) ) ) and ( cat != s__DamageTrigger_AOE or udg_DamageEventAOE > 1 or s__DamageTrigger_eventStr[this] == "udg_SourceDamageEvent" ) then

                    if mod then
                        if s__DamageTrigger_usingGUI[this] then
                            if guiUnset then
                                set guiUnset=false
                                call s__DamageTrigger_setGUIFromStruct(false)
                            endif
//ignored textmacro command: DAMAGE_EVENT_FILTER_PLUGIN_PDD()
                        elseif structUnset then
                            set structUnset=false
                            call s__DamageTrigger_setStructFromGUI()
                        endif
                    endif

//ignored textmacro command: DAMAGE_EVENT_FILTER_PLUGIN_01()
//ignored textmacro command: DAMAGE_EVENT_FILTER_PLUGIN_02()
//ignored textmacro command: DAMAGE_EVENT_FILTER_PLUGIN_03()
//ignored textmacro command: DAMAGE_EVENT_FILTER_PLUGIN_04()
//ignored textmacro command: DAMAGE_EVENT_FILTER_PLUGIN_05()

                //JASS users who do not use actions can modify the below block to just evaluate.
                //It should not make any perceptable difference in terms of performance.
                if TriggerEvaluate(s__DamageTrigger_rootTrig[this]) then
                    call TriggerExecute(s__DamageTrigger_rootTrig[this])
                endif
//ignored textmacro command: DAMAGE_EVENT_MOD_PLUGIN_01()
//ignored textmacro command: DAMAGE_EVENT_MOD_PLUGIN_02()
//ignored textmacro command: DAMAGE_EVENT_MOD_PLUGIN_03()
//ignored textmacro command: DAMAGE_EVENT_MOD_PLUGIN_04()
//ignored textmacro command: DAMAGE_EVENT_MOD_PLUGIN_05()

                    if mod then
                        if s__DamageTrigger_usingGUI[this] then
//ignored textmacro command: DAMAGE_EVENT_MOD_PLUGIN_PDD()
                            if cat != s__DamageTrigger_MOD then
                                set s__Damage_damage[d]=udg_DamageEventAmount
                            else
                                set structUnset=true
                            endif
                        elseif cat != s__DamageTrigger_MOD then
                            set udg_DamageEventAmount=s__Damage_damage[d]
                        else
                            set guiUnset=true
                        endif
                    endif
                    if udg_RemoveDamageEvent then
                        set udg_RemoveDamageEvent=false
                        call s__DamageTrigger_unregisterByIndex(this,true)
                    endif

            endif
        endloop


            if structUnset then
                call s__DamageTrigger_setStructFromGUI()
            endif
            if guiUnset then
                call s__DamageTrigger_setGUIFromStruct(false)
            endif




        //call BJDebugMsg("End of event running")

        call DisableTrigger(DamageEngine___recursiveTrigger)
        call EnableTrigger(DamageEngine___damagingTrigger)
        call EnableTrigger(DamageEngine___damagedTrigger)
        set DamageEngine___callbacksInProgress=false
    endfunction



    function s__DamageTrigger__staticgetindex takes code callback returns trigger
        local integer i= 0
        local boolexpr b= Filter(callback)
        loop
            if i == s__DamageTrigger_autoN then
                set s__DamageTrigger_autoTriggers[i]=CreateTrigger()
                set s__DamageTrigger_autoFuncs[i]=b
                call TriggerAddCondition(s__DamageTrigger_autoTriggers[i], b)
                exitwhen true
            endif
            set i=i + 1
            exitwhen b == s__DamageTrigger_autoFuncs[i]
        endloop
        return s__DamageTrigger_autoTriggers[i]
    endfunction

//ignored textmacro command: DAMAGE_EVENT_USER_STRUCT_PLUGIN_01()
//ignored textmacro command: DAMAGE_EVENT_USER_STRUCT_PLUGIN_02()
//ignored textmacro command: DAMAGE_EVENT_USER_STRUCT_PLUGIN_03()
//ignored textmacro command: DAMAGE_EVENT_USER_STRUCT_PLUGIN_04()
//ignored textmacro command: DAMAGE_EVENT_USER_STRUCT_PLUGIN_05()















    function s__Damage__get_source takes nothing returns unit
        return udg_DamageEventSource
    endfunction

    function s__Damage__get_target takes nothing returns unit
        return udg_DamageEventTarget
    endfunction

    function s__Damage__get_amount takes nothing returns real
        return s__Damage_damage[s__Damage_index]
    endfunction

    function s__Damage__set_amount takes real r returns nothing
        set s__Damage_damage[s__Damage_index]=r
    endfunction


        function s__Damage_setArmor takes integer this,boolean reset returns nothing
            local real pierce
            local integer at
            local integer dt

            if reset then
                set pierce=udg_DamageEventArmorPierced
                set at=s__Damage_prevArmorT[s__Damage_index]
                set dt=s__Damage_prevDefenseT[s__Damage_index]
                set udg_DamageEventArmorPierced=0.00
                set s__Damage_armorPierced[this]=0.00
            else
                set pierce=- udg_DamageEventArmorPierced
                set at=udg_DamageEventArmorT
                set dt=udg_DamageEventDefenseT
            endif

            if not ( pierce == 0.00 ) then //Changed from != to not == due to bug reported by BLOKKADE
                call BlzSetUnitArmor(udg_DamageEventTarget, BlzGetUnitArmor(udg_DamageEventTarget) + pierce)
            endif

            if s__Damage_prevArmorT[s__Damage_index] != udg_DamageEventArmorT then
                call BlzSetUnitIntegerField(udg_DamageEventTarget, UNIT_IF_ARMOR_TYPE, at)
            endif
            if s__Damage_prevDefenseT[s__Damage_index] != udg_DamageEventDefenseT then
                call BlzSetUnitIntegerField(udg_DamageEventTarget, UNIT_IF_DEFENSE_TYPE, dt)
            endif
        endfunction



        function s__Damage_onAOEEnd takes nothing returns nothing
            call s__DamageTrigger_DamageEngine___run(s__DamageTrigger_AOE)
            set udg_DamageEventAOE=1
            set udg_DamageEventLevel=1
            set udg_EnhancedDamageTarget=null
            set udg_AOEDamageSource=null
            call GroupClear(udg_DamageEventAOEGroup)
        endfunction


    function s__Damage_afterDamage takes nothing returns nothing
        if udg_DamageEventDamageT != 0 and not ( udg_DamageEventPrevAmt == 0.00 ) then
            call s__DamageTrigger_DamageEngine___run(s__DamageTrigger_AFTER)
            set udg_DamageEventDamageT=0
            set udg_DamageEventPrevAmt=0.00
        endif
    endfunction

    function s__Damage_runDamagingEvents takes integer this,boolean natural returns boolean


            set s__Damage_armorType[this]=BlzGetUnitIntegerField(s__Damage_targetUnit[this], UNIT_IF_ARMOR_TYPE)
            set s__Damage_defenseType[this]=BlzGetUnitIntegerField(s__Damage_targetUnit[this], UNIT_IF_DEFENSE_TYPE)
            set s__Damage_prevArmorT[this]=s__Damage_armorType[this]
            set s__Damage_prevDefenseT[this]=s__Damage_defenseType[this]
            set s__Damage_armorPierced[this]=0.00


        set s__Damage_index=this
        call s__DamageTrigger_setGUIFromStruct(true)

        call GroupAddUnit(DamageEngine___recursionSources, udg_DamageEventSource)
        call GroupAddUnit(DamageEngine___recursionTargets, udg_DamageEventTarget)

//ignored textmacro command: DAMAGE_EVENT_PRE_VARS_PLUGIN_01()
//ignored textmacro command: DAMAGE_EVENT_PRE_VARS_PLUGIN_02()
//ignored textmacro command: DAMAGE_EVENT_PRE_VARS_PLUGIN_03()
//ignored textmacro command: DAMAGE_EVENT_PRE_VARS_PLUGIN_04()
//ignored textmacro command: DAMAGE_EVENT_PRE_VARS_PLUGIN_05()

        // Using not == instead of !=; the idea is to eliminate floating point bugs when two numbers are very close to 0,
        // because JASS uses a less-strict comparison for checking if a number is equal than when it is unequal.
        if not ( udg_DamageEventAmount == 0.00 ) then
            set udg_DamageEventOverride=udg_DamageEventDamageT == 0

            call s__DamageTrigger_DamageEngine___run(s__DamageTrigger_MOD)





            if natural then
                call BlzSetEventAttackType(s__Damage_attackType[this])
                call BlzSetEventDamageType(s__Damage_damageType[this])
                call BlzSetEventWeaponType(s__Damage_weaponType[this])
                call BlzSetEventDamage(udg_DamageEventAmount)
            endif


                call s__Damage_setArmor(this,false)


            return false
        endif
        return true //return value is based on whether the event is a 0 damage event (true) or not (false).
    endfunction

    function s__Damage_unfreeze takes nothing returns nothing
        local integer i= s__Damage_damageStack

        loop
            exitwhen i == 0
            set i=i - 1
            set s__DamageTrigger_DamageEngine___trigFrozen[s__Damage_recursiveTrig[s__Damage_stackRef[i]]]=false
            set s__DamageTrigger_DamageEngine___ownRecursiveDepth[s__Damage_recursiveTrig[s__Damage_stackRef[i]]]=0
        endloop

        call EnableTrigger(DamageEngine___damagingTrigger)
        call EnableTrigger(DamageEngine___damagedTrigger)

        set DamageEngine___recursiveCallbaksInProgress=false
        set s__Damage_damageStack=0
        set s__Damage_prepped=0
        set DamageEngine___callbacksInProgress=false
        set DamageEngine___recursiveCallbackDepth=0
        call GroupClear(DamageEngine___recursionSources)
        call GroupClear(DamageEngine___recursionTargets)

        //call BJDebugMsg("Cleared up the groups")
    endfunction

    function s__Damage_runAfterDamageEvents takes nothing returns nothing
        local integer i= 0
        local integer exit

        if DamageEngine___nativeEventsCompleted then
            set DamageEngine___nativeEventsCompleted=false
            call s__Damage_afterDamage()
        endif

        if DamageEngine___isNotNativeRecursiveDamage and not DamageEngine___recursiveCallbaksInProgress then
            if s__Damage_damageStack != 0 then
                set DamageEngine___recursiveCallbaksInProgress=true
                loop
                
                    set DamageEngine___recursiveCallbackDepth=DamageEngine___recursiveCallbackDepth + 1
                    set exit=s__Damage_damageStack
                    loop
                        set s__Damage_prepped=s__Damage_stackRef[i]

                        if UnitAlive(s__Damage_targetUnit[s__Damage_prepped]) then

                            // We don't need to trigger `damagingTrigger` itself, so just call its handler directly.
                            call s__Damage_runDamagingEvents(s__Damage_prepped,false)

                            if s__Damage_damage[s__Damage_prepped] > 0.00 then
                                call DisableTrigger(DamageEngine___damagingTrigger) // Disallow `damagingTrigger` because we only want `damageTrigger` to run.
                                call EnableTrigger(DamageEngine___damagedTrigger) // Re-enable `damagedTrigger` in case the user forgot to do so.

                                set DamageEngine___waitingForDamageEventToRun=true

                                call UnitDamageTarget(s__Damage_sourceUnit[s__Damage_prepped], s__Damage_targetUnit[s__Damage_prepped], s__Damage_damage[s__Damage_prepped], s__Damage_isAttack[s__Damage_prepped], s__Damage_isRanged[s__Damage_prepped], s__Damage_attackType[s__Damage_prepped], s__Damage_damageType[s__Damage_prepped], s__Damage_weaponType[s__Damage_prepped])
                            else
                                if udg_DamageEventDamageT != 0 then
                                    //No native events run at all in this case
                                    call s__DamageTrigger_DamageEngine___run(s__DamageTrigger_DAMAGE)
                                endif

                                if s__Damage_damage[s__Damage_prepped] < 0.00 then
                                
                                    call SetWidgetLife(s__Damage_targetUnit[s__Damage_prepped], GetWidgetLife(s__Damage_targetUnit[s__Damage_prepped]) - s__Damage_damage[s__Damage_prepped])
                                endif


                                    call s__Damage_setArmor(s__Damage_prepped,true)

                            endif
                            call s__Damage_afterDamage()
                        endif
                        set i=i + 1
                        exitwhen i == exit
                    endloop
                    exitwhen i == s__Damage_damageStack
                endloop
            endif
            call s__Damage_unfreeze()
        endif
    endfunction

    function s__Damage_failsafeClear takes nothing returns nothing

            call s__Damage_setArmor(s__Damage_index,true)

        set DamageEngine___isNotNativeRecursiveDamage=true
        set DamageEngine___recursiveCallbaksInProgress=false

        set DamageEngine___waitingForDamageEventToRun=false

        if udg_DamageEventDamageT != 0 then
            call s__DamageTrigger_DamageEngine___run(s__DamageTrigger_DAMAGE)
            set DamageEngine___nativeEventsCompleted=true
        endif

        call s__Damage_runAfterDamageEvents()
    endfunction

    function s__Damage__set_enabled takes boolean b returns nothing
        if b then
            if DamageEngine___callbacksInProgress then
                call EnableTrigger(DamageEngine___recursiveTrigger)
            else
                call EnableTrigger(DamageEngine___damagingTrigger)
                call EnableTrigger(DamageEngine___damagedTrigger)
            endif
        else
            if DamageEngine___callbacksInProgress then
                call DisableTrigger(DamageEngine___recursiveTrigger)
            else
                call DisableTrigger(DamageEngine___damagingTrigger)
                call DisableTrigger(DamageEngine___damagedTrigger)
            endif
        endif
    endfunction

    function s__Damage__get_enabled takes nothing returns boolean
        return IsTriggerEnabled(DamageEngine___damagingTrigger)
    endfunction


    function s__Damage_asyncCallbackSafeCallback takes nothing returns nothing
        if DamageEngine___waitingForDamageEventToRun then
        
            call s__Damage_failsafeClear()
        else
            set DamageEngine___isNotNativeRecursiveDamage=true
            set DamageEngine___recursiveCallbaksInProgress=false
            call s__Damage_runAfterDamageEvents()
        endif


            call s__Damage_onAOEEnd()


        set s__Damage_threadCompleted=true
    endfunction

    function s__Damage_asyncCallback takes nothing returns nothing
        set DamageEngine___callbacksInProgress=false
        call s__Damage__set_enabled(true)
    
        call ForForce(bj_FORCE_PLAYER[0], function s__Damage_asyncCallbackSafeCallback)

        if not s__Damage_threadCompleted then
            //call BJDebugMsg("DamageEngine issue: thread crashed!")
            call s__Damage_unfreeze()
        else
            set s__Damage_threadCompleted=false
        endif

        set s__Damage_count=0
        set s__Damage_index=0
        set DamageEngine___timerStarted=false

        //call BJDebugMsg("Timer wrapped up")
    endfunction

    function s__Damage_addRecursive takes integer this returns nothing
        local integer currentIndex

        if not ( s__Damage_damage[this] == 0.00 ) then

            set currentIndex=s__DamageTrigger_eventIndex

            set s__Damage_recursiveTrig[this]=currentIndex

            if not s__Damage_isCode[this] then
            
                set s__Damage_isCode[this]=true
                set s__Damage_userType[this]=DamageEngine_TYPE_CODE
            endif

            set DamageEngine_inception=DamageEngine_inception or s__DamageTrigger_DamageEngine___manualRecursionRequested[currentIndex]

            if DamageEngine___recursiveCallbaksInProgress and IsUnitInGroup(s__Damage_sourceUnit[this], DamageEngine___recursionSources) and IsUnitInGroup(s__Damage_targetUnit[this], DamageEngine___recursionTargets) then
                if not DamageEngine_inception then
                    set s__DamageTrigger_DamageEngine___trigFrozen[currentIndex]=true

                elseif not s__DamageTrigger_DamageEngine___trigFrozen[currentIndex] then
                    
                    set s__DamageTrigger_DamageEngine___manualRecursionRequested[currentIndex]=true

                    if s__DamageTrigger_DamageEngine___ownRecursiveDepth[currentIndex] < DamageEngine___recursiveCallbackDepth then

                        set s__DamageTrigger_DamageEngine___ownRecursiveDepth[currentIndex]=s__DamageTrigger_DamageEngine___ownRecursiveDepth[currentIndex] + 1

                        if s__DamageTrigger_DamageEngine___ownRecursiveDepth[currentIndex] >= DamageEngine___MAX_RECURSIVE_TOLERANCE then
                            set s__DamageTrigger_DamageEngine___trigFrozen[currentIndex]=true
                        endif
                    endif
                endif
            endif

            // push the reference to the top of the damage stack.
            set s__Damage_stackRef[s__Damage_damageStack]=this
            set s__Damage_damageStack=s__Damage_damageStack + 1

            //call BJDebugMsg("damageStack: " + I2S(damageStack) + " ownRecursiveDepth: " + I2S(currentIndex.ownRecursiveDepth) + " recursiveCallbackDepth: " + I2S(recursiveCallbackDepth))
        endif
        set DamageEngine_inception=false
    endfunction

    function s__Damage_clearNexts takes nothing returns nothing
        set udg_NextDamageIsAttack=false
        set udg_NextDamageType=0
        set udg_NextDamageWeaponT=0


            set udg_NextDamageIsMelee=false
            set udg_NextDamageIsRanged=false

    endfunction

    function s__Damage_create takes unit src,unit tgt,real amt,boolean isAttack,attacktype at,damagetype dt,weapontype wt returns integer
        local integer d= s__Damage_count + 1
        set s__Damage_count=d
        
        set s__Damage_sourceUnit[d]=src
        set s__Damage_targetUnit[d]=tgt
        set s__Damage_damage[d]=amt
        set s__Damage_prevAmt[d]=amt

        set s__Damage_damageType[d]=dt
        set s__Damage_attackType[d]=at
        set s__Damage_weaponType[d]=wt

        set s__Damage_isAttack[d]=udg_NextDamageIsAttack or isAttack
        set s__Damage_isSpell[d]=s__Damage_attackType[d] == null and not s__Damage_isAttack[d]
        return d
    endfunction

    function s__Damage_createFromEvent takes nothing returns integer
        local integer d= s__Damage_create(GetEventDamageSource() , GetTriggerUnit() , GetEventDamage() , BlzGetEventIsAttack() , BlzGetEventAttackType() , BlzGetEventDamageType() , BlzGetEventWeaponType())

        set s__Damage_isCode[d]=udg_NextDamageType != 0 or udg_NextDamageIsAttack or udg_NextDamageIsRanged or udg_NextDamageIsMelee or s__Damage_damageType[d] == DAMAGE_TYPE_MIND or udg_NextDamageWeaponT != 0 or ( s__Damage_damageType[d] == DAMAGE_TYPE_UNKNOWN and not ( s__Damage_damage[d] == 0.00 ) )

        if s__Damage_isCode[d] then
            if udg_NextDamageType != 0 then
                set s__Damage_userType[d]=udg_NextDamageType
            else
                set s__Damage_userType[d]=DamageEngine_TYPE_CODE
            endif


                set s__Damage_isMelee[d]=udg_NextDamageIsMelee
                set s__Damage_isRanged[d]=udg_NextDamageIsRanged


            set s__Damage_eFilter[d]=DamageEngine_FILTER_CODE

            if udg_NextDamageWeaponT != 0 then
                set s__Damage_weaponType[d]=ConvertWeaponType(udg_NextDamageWeaponT)
                set udg_NextDamageWeaponT=0
            endif
        else
            set s__Damage_userType[d]=0

            if s__Damage_damageType[d] == DAMAGE_TYPE_NORMAL and s__Damage_isAttack[d] then

                // Added in version 5.A in order to allow an optional external 
                // Attack Indexer system to reset the event weapon type to normal.
//ignored textmacro command: ATTACK_INDEXER_ADJUSTMENTS()


                    set s__Damage_isMelee[d]=IsUnitType(s__Damage_sourceUnit[d], UNIT_TYPE_MELEE_ATTACKER)
                    set s__Damage_isRanged[d]=IsUnitType(s__Damage_sourceUnit[d], UNIT_TYPE_RANGED_ATTACKER)

                    if s__Damage_isMelee[d] and s__Damage_isRanged[d] then
                        // Melee units always play a sound when damaging in WC3, 
                        // so this is an easy check.
                        set s__Damage_isMelee[d]=s__Damage_weaponType[d] != null

                        // In the case where a unit is both ranged and melee,
                        // the ranged attack plays no sound.
                        set s__Damage_isRanged[d]=not s__Damage_isMelee[d]
                    endif

                    if s__Damage_isMelee[d] then
                        set s__Damage_eFilter[d]=DamageEngine_FILTER_MELEE
                    elseif s__Damage_isRanged[d] then
                        set s__Damage_eFilter[d]=DamageEngine_FILTER_RANGED
                    else
                        set s__Damage_eFilter[d]=DamageEngine_FILTER_ATTACK
                    endif



            else
                if s__Damage_isSpell[d] then
                    set s__Damage_eFilter[d]=DamageEngine_FILTER_SPELL
                else
                    set s__Damage_eFilter[d]=DamageEngine_FILTER_OTHER
                endif


                    // Spells are neither melee nor ranged.
                    set s__Damage_isMelee[d]=false
                    set s__Damage_isRanged[d]=false

            endif
        endif
        call s__Damage_clearNexts()
        return d
    endfunction

    function s__Damage_onRecursiveDamageCallback takes nothing returns boolean
        local integer d= s__Damage_createFromEvent()
        call s__Damage_addRecursive(d)
        call BlzSetEventDamage(0.00)
        return false
    endfunction

    function s__Damage_onDamagingCallback takes nothing returns boolean
        local integer d= s__Damage_createFromEvent()

        //call BJDebugMsg("Pre-damage event running for " + GetUnitName(GetTriggerUnit()))

        if DamageEngine___timerStarted then
            if DamageEngine___waitingForDamageEventToRun then
                //WarCraft 3 didn't run the DAMAGED event despite running the DAMAGING event.

                if s__Damage_damageType[d] == DAMAGE_TYPE_SPIRIT_LINK or s__Damage_damageType[d] == DAMAGE_TYPE_DEFENSIVE or s__Damage_damageType[d] == DAMAGE_TYPE_PLANT then
                    set DamageEngine___waitingForDamageEventToRun=false
                    set DamageEngine___lastInstance=s__Damage_index
                    set DamageEngine___isNotNativeRecursiveDamage=false
                else
                    call s__Damage_failsafeClear() //Not an overlapping event - just wrap it up
                endif
            else
                call s__Damage_runAfterDamageEvents() //wrap up any previous damage index
            endif


                if s__Damage_sourceUnit[d] != udg_AOEDamageSource then

                    call s__Damage_onAOEEnd()
                    set udg_AOEDamageSource=s__Damage_sourceUnit[d]
                    set udg_EnhancedDamageTarget=s__Damage_targetUnit[d]

                elseif s__Damage_targetUnit[d] == udg_EnhancedDamageTarget then

                    set udg_DamageEventLevel=udg_DamageEventLevel + 1

                elseif not IsUnitInGroup(s__Damage_targetUnit[d], udg_DamageEventAOEGroup) then
                    set udg_DamageEventAOE=udg_DamageEventAOE + 1
                endif

        else
            call TimerStart(DamageEngine___async, 0.00, false, function s__Damage_asyncCallback)
            set DamageEngine___timerStarted=true


                set udg_AOEDamageSource=s__Damage_sourceUnit[d]
                set udg_EnhancedDamageTarget=s__Damage_targetUnit[d]

        endif


            call GroupAddUnit(udg_DamageEventAOEGroup, s__Damage_targetUnit[d])


        if s__Damage_runDamagingEvents(d,true) then
            call s__DamageTrigger_DamageEngine___run(s__DamageTrigger_ZERO)
            set DamageEngine___isNotNativeRecursiveDamage=true
            call s__Damage_runAfterDamageEvents()
        endif

        set DamageEngine___waitingForDamageEventToRun=DamageEngine___lastInstance == 0 or DamageEngine___attacksImmune[udg_DamageEventAttackT] or DamageEngine___damagesImmune[udg_DamageEventDamageT] or not IsUnitType(udg_DamageEventTarget, UNIT_TYPE_MAGIC_IMMUNE)

        return false
    endfunction

    function s__Damage_onDamagedCallback takes nothing returns boolean
        local real r= GetEventDamage()
        local integer d= s__Damage_index

        //call BJDebugMsg("Second damage event running for " + GetUnitName(GetTriggerUnit()))

        if s__Damage_prepped > 0 then
            set s__Damage_prepped=0
        elseif DamageEngine___callbacksInProgress or s__Damage_prevAmt[d] == 0.00 then
            return false
        elseif DamageEngine___waitingForDamageEventToRun then
            set DamageEngine___waitingForDamageEventToRun=false
        else
            
            call s__Damage_afterDamage()
            set s__Damage_index=DamageEngine___lastInstance
            set DamageEngine___lastInstance=0
            set d=s__Damage_index

        
            set DamageEngine___isNotNativeRecursiveDamage=true

            call s__DamageTrigger_setGUIFromStruct(true)
        endif


            call s__Damage_setArmor(d,true)



            if not ( udg_DamageEventAmount == 0.00 ) and not ( r == 0.00 ) then
                set udg_DamageScalingWC3=r / udg_DamageEventAmount
            elseif udg_DamageEventAmount > 0.00 then
                set udg_DamageScalingWC3=0.00
            else
                set udg_DamageScalingWC3=1.00
                if udg_DamageEventPrevAmt == 0.00 then
                    set udg_DamageScalingUser=0.00
                else
                    set udg_DamageScalingUser=udg_DamageEventAmount / udg_DamageEventPrevAmt
                endif
            endif

        set udg_DamageEventAmount=r
        set s__Damage_damage[d]=r

//ignored textmacro command: DAMAGE_EVENT_VARS_PLUGIN_GDD()
//ignored textmacro command: DAMAGE_EVENT_VARS_PLUGIN_PDD()
//ignored textmacro command: DAMAGE_EVENT_VARS_PLUGIN_01()
//ignored textmacro command: DAMAGE_EVENT_VARS_PLUGIN_02()
//ignored textmacro command: DAMAGE_EVENT_VARS_PLUGIN_03()
//ignored textmacro command: DAMAGE_EVENT_VARS_PLUGIN_04()
//ignored textmacro command: DAMAGE_EVENT_VARS_PLUGIN_05()

        if udg_DamageEventAmount > 0.00 then

            call s__DamageTrigger_DamageEngine___run(s__DamageTrigger_SHIELD)






                if DamageEngine___atLeastOneLethalDamageEventRegistered or udg_DamageEventType < 0 then
                    set udg_LethalDamageHP=GetWidgetLife(udg_DamageEventTarget) - udg_DamageEventAmount

                    if udg_LethalDamageHP <= DamageEngine___DEATH_VAL then
                        if DamageEngine___atLeastOneLethalDamageEventRegistered then
                            call s__DamageTrigger_DamageEngine___run(s__DamageTrigger_LETHAL)

                            set udg_DamageEventAmount=GetWidgetLife(udg_DamageEventTarget) - udg_LethalDamageHP
                            set s__Damage_damage[d]=udg_DamageEventAmount
                        endif
                        if udg_DamageEventType < 0 and udg_LethalDamageHP <= DamageEngine___DEATH_VAL then
                            call SetUnitExploded(udg_DamageEventTarget, true)
                        endif
                    endif
                endif



                if udg_DamageEventPrevAmt == 0.00 or udg_DamageScalingWC3 == 0.00 then
                    set udg_DamageScalingUser=0.00
                else
                    set udg_DamageScalingUser=udg_DamageEventAmount / udg_DamageEventPrevAmt / udg_DamageScalingWC3
                endif

        endif

        if udg_DamageEventDamageT != 0 then
            call s__DamageTrigger_DamageEngine___run(s__DamageTrigger_DAMAGE)
        endif

        call BlzSetEventDamage(udg_DamageEventAmount)

        set DamageEngine___nativeEventsCompleted=true

        if udg_DamageEventAmount == 0.00 then
            call s__Damage_runAfterDamageEvents()
        endif

        // This return statement was needed years ago to avoid potential crashes on Mac.
        // I am not sure if that's still a thing.
        return false
    endfunction

    function s__Damage_apply takes unit src,unit tgt,real amt,boolean a,boolean r,attacktype at,damagetype dt,weapontype wt returns integer
        local integer d

        if udg_NextDamageType == 0 then
           set udg_NextDamageType=DamageEngine_TYPE_CODE
        endif

        if DamageEngine___callbacksInProgress then
            set d=s__Damage_create(src , tgt , amt , a , at , dt , wt)
            set s__Damage_isCode[d]=true
            set s__Damage_eFilter[d]=DamageEngine_FILTER_CODE

            set s__Damage_userType[d]=udg_NextDamageType


                if not s__Damage_isSpell[d] then
                    set s__Damage_isRanged[d]=udg_NextDamageIsRanged or r
                    set s__Damage_isMelee[d]=not s__Damage_isRanged[d]
                endif


            call s__Damage_addRecursive(d)
        else
            call UnitDamageTarget(src, tgt, amt, a, r, at, dt, wt)

            set d=s__Damage_index

            call s__Damage_runAfterDamageEvents()
        endif

        call s__Damage_clearNexts()

        return d
    endfunction

    function s__Damage_applySpell takes unit src,unit tgt,real amt,damagetype dt returns integer
        return s__Damage_apply(src , tgt , amt , false , false , null , dt , null)
    endfunction

    function s__Damage_applyAttack takes unit src,unit tgt,real amt,boolean ranged,attacktype at,weapontype wt returns integer
        return s__Damage_apply(src , tgt , amt , true , ranged , at , DAMAGE_TYPE_NORMAL , wt)
    endfunction


    function s__Damage_onInit takes nothing returns nothing
        set DamageEngine___async=CreateTimer()

        set DamageEngine___recursionSources=CreateGroup()
        set DamageEngine___recursionTargets=CreateGroup()

        set DamageEngine___damagingTrigger=CreateTrigger()
        set DamageEngine___damagedTrigger=CreateTrigger()
        set DamageEngine___recursiveTrigger=CreateTrigger() //Moved from globals block as per request of user Ricola3D

        call TriggerRegisterAnyUnitEventBJ(DamageEngine___damagingTrigger, EVENT_PLAYER_UNIT_DAMAGING)
        call TriggerAddCondition(DamageEngine___damagingTrigger, Filter(function s__Damage_onDamagingCallback))

        call TriggerRegisterAnyUnitEventBJ(DamageEngine___damagedTrigger, EVENT_PLAYER_UNIT_DAMAGED)
        call TriggerAddCondition(DamageEngine___damagedTrigger, Filter(function s__Damage_onDamagedCallback))

        //For recursion
        call TriggerRegisterAnyUnitEventBJ(DamageEngine___recursiveTrigger, EVENT_PLAYER_UNIT_DAMAGING)
        call TriggerAddCondition(DamageEngine___recursiveTrigger, Filter(function s__Damage_onRecursiveDamageCallback))
        call DisableTrigger(DamageEngine___recursiveTrigger) //starts disabled. Will be enabled during recursive event handling.

            
        set DamageEngine___attacksImmune[0]=false //ATTACK_TYPE_NORMAL
        set DamageEngine___attacksImmune[1]=true //ATTACK_TYPE_MELEE
        set DamageEngine___attacksImmune[2]=true //ATTACK_TYPE_PIERCE
        set DamageEngine___attacksImmune[3]=true //ATTACK_TYPE_SIEGE
        set DamageEngine___attacksImmune[4]=false //ATTACK_TYPE_MAGIC
        set DamageEngine___attacksImmune[5]=true //ATTACK_TYPE_CHAOS
        set DamageEngine___attacksImmune[6]=true //ATTACK_TYPE_HERO

        set DamageEngine___damagesImmune[0]=true //DAMAGE_TYPE_UNKNOWN
        set DamageEngine___damagesImmune[4]=true //DAMAGE_TYPE_NORMAL
        set DamageEngine___damagesImmune[5]=true //DAMAGE_TYPE_ENHANCED
        set DamageEngine___damagesImmune[8]=false //DAMAGE_TYPE_FIRE
        set DamageEngine___damagesImmune[9]=false //DAMAGE_TYPE_COLD
        set DamageEngine___damagesImmune[10]=false //DAMAGE_TYPE_LIGHTNING
        set DamageEngine___damagesImmune[11]=true //DAMAGE_TYPE_POISON
        set DamageEngine___damagesImmune[12]=true //DAMAGE_TYPE_DISEASE
        set DamageEngine___damagesImmune[13]=false //DAMAGE_TYPE_DIVINE
        set DamageEngine___damagesImmune[14]=false //DAMAGE_TYPE_MAGIC
        set DamageEngine___damagesImmune[15]=false //DAMAGE_TYPE_SONIC
        set DamageEngine___damagesImmune[16]=true //DAMAGE_TYPE_ACID
        set DamageEngine___damagesImmune[17]=false //DAMAGE_TYPE_FORCE
        set DamageEngine___damagesImmune[18]=false //DAMAGE_TYPE_DEATH
        set DamageEngine___damagesImmune[19]=false //DAMAGE_TYPE_MIND
        set DamageEngine___damagesImmune[20]=false //DAMAGE_TYPE_PLANT
        set DamageEngine___damagesImmune[21]=false //DAMAGE_TYPE_DEFENSIVE
        set DamageEngine___damagesImmune[22]=true //DAMAGE_TYPE_DEMOLITION
        set DamageEngine___damagesImmune[23]=true //DAMAGE_TYPE_SLOW_POISON
        set DamageEngine___damagesImmune[24]=false //DAMAGE_TYPE_SPIRIT_LINK
        set DamageEngine___damagesImmune[25]=false //DAMAGE_TYPE_SHADOW_STRIKE
        set DamageEngine___damagesImmune[26]=true //DAMAGE_TYPE_UNIVERSAL
    endfunction

//ignored textmacro command: DAMAGE_EVENT_STRUCT_PLUGIN_DMGPKG()
//ignored textmacro command: DAMAGE_EVENT_STRUCT_PLUGIN_01()
//ignored textmacro command: DAMAGE_EVENT_STRUCT_PLUGIN_02()
//ignored textmacro command: DAMAGE_EVENT_STRUCT_PLUGIN_03()
//ignored textmacro command: DAMAGE_EVENT_STRUCT_PLUGIN_04()
//ignored textmacro command: DAMAGE_EVENT_STRUCT_PLUGIN_05()


// Called from the GUI configuration trigger once the assignments are in place.
function DamageEngine_DebugStr takes nothing returns nothing
    local integer i= 0
    loop
        set udg_CONVERTED_ATTACK_TYPE[i]=ConvertAttackType(i)
        exitwhen i == 6
        set i=i + 1
    endloop

    set i=0
    loop
        set udg_CONVERTED_DAMAGE_TYPE[i]=ConvertDamageType(i)
        exitwhen i == 26
        set i=i + 1
    endloop

    set udg_AttackTypeDebugStr[0]="SPELLS" //ATTACK_TYPE_NORMAL in JASS
    set udg_AttackTypeDebugStr[1]="NORMAL" //ATTACK_TYPE_MELEE in JASS
    set udg_AttackTypeDebugStr[2]="PIERCE"
    set udg_AttackTypeDebugStr[3]="SIEGE"
    set udg_AttackTypeDebugStr[4]="MAGIC"
    set udg_AttackTypeDebugStr[5]="CHAOS"
    set udg_AttackTypeDebugStr[6]="HERO"
    set udg_DamageTypeDebugStr[0]="UNKNOWN"
    set udg_DamageTypeDebugStr[4]="NORMAL"
    set udg_DamageTypeDebugStr[5]="ENHANCED"
    set udg_DamageTypeDebugStr[8]="FIRE"
    set udg_DamageTypeDebugStr[9]="COLD"
    set udg_DamageTypeDebugStr[10]="LIGHTNING"
    set udg_DamageTypeDebugStr[11]="POISON"
    set udg_DamageTypeDebugStr[12]="DISEASE"
    set udg_DamageTypeDebugStr[13]="DIVINE"
    set udg_DamageTypeDebugStr[14]="MAGIC"
    set udg_DamageTypeDebugStr[15]="SONIC"
    set udg_DamageTypeDebugStr[16]="ACID"
    set udg_DamageTypeDebugStr[17]="FORCE"
    set udg_DamageTypeDebugStr[18]="DEATH"
    set udg_DamageTypeDebugStr[19]="MIND"
    set udg_DamageTypeDebugStr[20]="PLANT"
    set udg_DamageTypeDebugStr[21]="DEFENSIVE"
    set udg_DamageTypeDebugStr[22]="DEMOLITION"
    set udg_DamageTypeDebugStr[23]="SLOW_POISON"
    set udg_DamageTypeDebugStr[24]="SPIRIT_LINK"
    set udg_DamageTypeDebugStr[25]="SHADOW_STRIKE"
    set udg_DamageTypeDebugStr[26]="UNIVERSAL"
    set udg_WeaponTypeDebugStr[0]="NONE" //WEAPON_TYPE_WHOKNOWS in JASS
    set udg_WeaponTypeDebugStr[1]="METAL_LIGHT_CHOP"
    set udg_WeaponTypeDebugStr[2]="METAL_MEDIUM_CHOP"
    set udg_WeaponTypeDebugStr[3]="METAL_HEAVY_CHOP"
    set udg_WeaponTypeDebugStr[4]="METAL_LIGHT_SLICE"
    set udg_WeaponTypeDebugStr[5]="METAL_MEDIUM_SLICE"
    set udg_WeaponTypeDebugStr[6]="METAL_HEAVY_SLICE"
    set udg_WeaponTypeDebugStr[7]="METAL_MEDIUM_BASH"
    set udg_WeaponTypeDebugStr[8]="METAL_HEAVY_BASH"
    set udg_WeaponTypeDebugStr[9]="METAL_MEDIUM_STAB"
    set udg_WeaponTypeDebugStr[10]="METAL_HEAVY_STAB"
    set udg_WeaponTypeDebugStr[11]="WOOD_LIGHT_SLICE"
    set udg_WeaponTypeDebugStr[12]="WOOD_MEDIUM_SLICE"
    set udg_WeaponTypeDebugStr[13]="WOOD_HEAVY_SLICE"
    set udg_WeaponTypeDebugStr[14]="WOOD_LIGHT_BASH"
    set udg_WeaponTypeDebugStr[15]="WOOD_MEDIUM_BASH"
    set udg_WeaponTypeDebugStr[16]="WOOD_HEAVY_BASH"
    set udg_WeaponTypeDebugStr[17]="WOOD_LIGHT_STAB"
    set udg_WeaponTypeDebugStr[18]="WOOD_MEDIUM_STAB"
    set udg_WeaponTypeDebugStr[19]="CLAW_LIGHT_SLICE"
    set udg_WeaponTypeDebugStr[20]="CLAW_MEDIUM_SLICE"
    set udg_WeaponTypeDebugStr[21]="CLAW_HEAVY_SLICE"
    set udg_WeaponTypeDebugStr[22]="AXE_MEDIUM_CHOP"
    set udg_WeaponTypeDebugStr[23]="ROCK_HEAVY_BASH"
    set udg_DefenseTypeDebugStr[0]="LIGHT"
    set udg_DefenseTypeDebugStr[1]="MEDIUM"
    set udg_DefenseTypeDebugStr[2]="HEAVY"
    set udg_DefenseTypeDebugStr[3]="FORTIFIED"
    set udg_DefenseTypeDebugStr[4]="NORMAL" //Typically deals flat damage to all armor types
    set udg_DefenseTypeDebugStr[5]="HERO"
    set udg_DefenseTypeDebugStr[6]="DIVINE"
    set udg_DefenseTypeDebugStr[7]="UNARMORED"
    set udg_ArmorTypeDebugStr[0]="NONE" //ARMOR_TYPE_WHOKNOWS in JASS, added in 1.31
    set udg_ArmorTypeDebugStr[1]="FLESH"
    set udg_ArmorTypeDebugStr[2]="METAL"
    set udg_ArmorTypeDebugStr[3]="WOOD"
    set udg_ArmorTypeDebugStr[4]="ETHEREAL"
    set udg_ArmorTypeDebugStr[5]="STONE"
    
    // Added 25 July 2017 to allow detection of things like Bash or Pulverize or AOE spread
    set udg_DamageEventAOE=1
    set udg_DamageEventLevel=1

    set udg_ATTACK_TYPE_SPELLS=0
    set udg_ATTACK_TYPE_NORMAL=1
    set udg_ATTACK_TYPE_PIERCE=2
    set udg_ATTACK_TYPE_SIEGE=3
    set udg_ATTACK_TYPE_MAGIC=4
    set udg_ATTACK_TYPE_CHAOS=5
    set udg_ATTACK_TYPE_HERO=6
    // -
    set udg_DAMAGE_TYPE_UNKNOWN=0
    set udg_DAMAGE_TYPE_NORMAL=4
    set udg_DAMAGE_TYPE_ENHANCED=5
    set udg_DAMAGE_TYPE_FIRE=8
    set udg_DAMAGE_TYPE_COLD=9
    set udg_DAMAGE_TYPE_LIGHTNING=10
    set udg_DAMAGE_TYPE_POISON=11
    set udg_DAMAGE_TYPE_DISEASE=12
    set udg_DAMAGE_TYPE_DIVINE=13
    set udg_DAMAGE_TYPE_MAGIC=14
    set udg_DAMAGE_TYPE_SONIC=15
    set udg_DAMAGE_TYPE_ACID=16
    set udg_DAMAGE_TYPE_FORCE=17
    set udg_DAMAGE_TYPE_DEATH=18
    set udg_DAMAGE_TYPE_MIND=19
    set udg_DAMAGE_TYPE_PLANT=20
    set udg_DAMAGE_TYPE_DEFENSIVE=21
    set udg_DAMAGE_TYPE_DEMOLITION=22
    set udg_DAMAGE_TYPE_SLOW_POISON=23
    set udg_DAMAGE_TYPE_SPIRIT_LINK=24
    set udg_DAMAGE_TYPE_SHADOW_STRIKE=25
    set udg_DAMAGE_TYPE_UNIVERSAL=26
    
    
    
    set udg_WEAPON_TYPE_NONE=0

    // Metal Light/Medium/Heavy
    set udg_WEAPON_TYPE_ML_CHOP=1
    set udg_WEAPON_TYPE_MM_CHOP=2
    set udg_WEAPON_TYPE_MH_CHOP=3
    set udg_WEAPON_TYPE_ML_SLICE=4
    set udg_WEAPON_TYPE_MM_SLICE=5
    set udg_WEAPON_TYPE_MH_SLICE=6
    set udg_WEAPON_TYPE_MM_BASH=7
    set udg_WEAPON_TYPE_MH_BASH=8
    set udg_WEAPON_TYPE_MM_STAB=9
    set udg_WEAPON_TYPE_MH_STAB=10

    // Wood Light/Medium/Heavy
    set udg_WEAPON_TYPE_WL_SLICE=11
    set udg_WEAPON_TYPE_WM_SLICE=12
    set udg_WEAPON_TYPE_WH_SLICE=13
    set udg_WEAPON_TYPE_WL_BASH=14
    set udg_WEAPON_TYPE_WM_BASH=15
    set udg_WEAPON_TYPE_WH_BASH=16
    set udg_WEAPON_TYPE_WL_STAB=17
    set udg_WEAPON_TYPE_WM_STAB=18

    // Claw Light/Medium/Heavy
    set udg_WEAPON_TYPE_CL_SLICE=19
    set udg_WEAPON_TYPE_CM_SLICE=20
    set udg_WEAPON_TYPE_CH_SLICE=21

    // Axe Medium
    set udg_WEAPON_TYPE_AM_CHOP=22

    // Rock Heavy
    set udg_WEAPON_TYPE_RH_BASH=23


    set udg_ARMOR_TYPE_NONE=0
    set udg_ARMOR_TYPE_FLESH=1
    set udg_ARMOR_TYPE_METAL=2
    set udg_ARMOR_TYPE_WOOD=3
    set udg_ARMOR_TYPE_ETHEREAL=4
    set udg_ARMOR_TYPE_STONE=5

    set udg_DEFENSE_TYPE_LIGHT=0
    set udg_DEFENSE_TYPE_MEDIUM=1
    set udg_DEFENSE_TYPE_HEAVY=2
    set udg_DEFENSE_TYPE_FORTIFIED=3
    set udg_DEFENSE_TYPE_NORMAL=4
    set udg_DEFENSE_TYPE_HERO=5
    set udg_DEFENSE_TYPE_DIVINE=6
    set udg_DEFENSE_TYPE_UNARMORED=7



    set udg_UNIT_CLASS_HERO=0
    set udg_UNIT_CLASS_DEAD=1
    set udg_UNIT_CLASS_STRUCTURE=2

    set udg_UNIT_CLASS_FLYING=3
    set udg_UNIT_CLASS_GROUND=4

    set udg_UNIT_CLASS_ATTACKS_FLYING=5
    set udg_UNIT_CLASS_ATTACKS_GROUND=6

    set udg_UNIT_CLASS_MELEE=7
    set udg_UNIT_CLASS_RANGED=8

    set udg_UNIT_CLASS_GIANT=9
    set udg_UNIT_CLASS_SUMMONED=10
    set udg_UNIT_CLASS_STUNNED=11
    set udg_UNIT_CLASS_PLAGUED=12
    set udg_UNIT_CLASS_SNARED=13

    set udg_UNIT_CLASS_UNDEAD=14
    set udg_UNIT_CLASS_MECHANICAL=15
    set udg_UNIT_CLASS_PEON=16
    set udg_UNIT_CLASS_SAPPER=17
    set udg_UNIT_CLASS_TOWNHALL=18
    set udg_UNIT_CLASS_ANCIENT=19

    set udg_UNIT_CLASS_TAUREN=20
    set udg_UNIT_CLASS_POISONED=21
    set udg_UNIT_CLASS_POLYMORPHED=22
    set udg_UNIT_CLASS_SLEEPING=23
    set udg_UNIT_CLASS_RESISTANT=24
    set udg_UNIT_CLASS_ETHEREAL=25
    set udg_UNIT_CLASS_MAGIC_IMMUNE=26

    set udg_DamageFilterAttackT=- 1
    set udg_DamageFilterDamageT=- 1
    set udg_DamageFilterSourceC=- 1
    set udg_DamageFilterTargetC=- 1
    set udg_DamageFilterRunChance=1.00
endfunction

function DamageEngine_RegisterFromHook takes trigger whichTrig,string var,limitop op,real value returns nothing
    call s__DamageTrigger_registerVerbose(whichTrig , var , value , true , GetHandleId(op))
endfunction
//processed hook: hook TriggerRegisterVariableEvent DamageEngine_RegisterFromHook

function TriggerRegisterDamageEngineEx takes trigger whichTrig,string eventName,real value,integer opId returns integer
    return s__DamageTrigger_registerVerbose(whichTrig , s__DamageTrigger_getVerboseStr(eventName) , value , false , opId)
endfunction

function TriggerRegisterDamageEngine takes trigger whichTrig,string eventName,real value returns integer
    return s__DamageTrigger_registerTrigger(whichTrig , eventName , value)
endfunction

function RegisterDamageEngineEx takes code callback,string eventName,real value,integer opId returns integer
    return TriggerRegisterDamageEngineEx(s__DamageTrigger__staticgetindex(callback) , eventName , value , opId)
endfunction

//Similar to TriggerRegisterDamageEvent, but takes code instead of trigger as the first argument.
function RegisterDamageEngine takes code callback,string eventName,real value returns integer
    return RegisterDamageEngineEx(callback , eventName , value , DamageEngine_FILTER_OTHER)
endfunction






//library DamageEngine ends
//library PassiveMissiles:


function PassiveMissiles__IsAlive takes unit u returns boolean
    return u != null and GetWidgetLife(u) > 0.405 and not IsUnitType(u, UNIT_TYPE_DEAD)
endfunction

function PassiveMissiles__IsValidTargetForCaster takes unit caster,unit target returns boolean
    local player owner
    local boolean ok

    if caster == null or target == null then
        return false
    endif

    set owner=GetOwningPlayer(caster)
    set ok=PassiveMissiles__IsAlive(target) and IsUnitEnemy(target, owner) and IsUnitVisible(target, owner) and not BlzIsUnitInvulnerable(target) and not IsUnitType(target, UNIT_TYPE_MAGIC_IMMUNE)

    set owner=null
    return ok
endfunction

function PassiveMissiles__TargetFilter takes nothing returns boolean
    local unit u= GetFilterUnit()
    local boolean ok= PassiveMissiles__IsValidTargetForCaster(PassiveMissiles__PM_Source , u)

    set u=null
    return ok
endfunction

function PassiveMissiles__PickRandomTarget takes unit caster returns unit
    local unit u
    local unit result= null
    local integer count= 0

    set PassiveMissiles__PM_Source=caster
    call GroupEnumUnitsInRange(PassiveMissiles__PM_EnumGroup, GetUnitX(caster), GetUnitY(caster), PassiveMissiles__PM_RANGE, Condition(function PassiveMissiles__TargetFilter))

    loop
        set u=FirstOfGroup(PassiveMissiles__PM_EnumGroup)
        exitwhen u == null

        call GroupRemoveUnit(PassiveMissiles__PM_EnumGroup, u)

        set count=count + 1
        if GetRandomInt(1, count) == 1 then
            set result=u
        endif
    endloop

    set u=null
    return result
endfunction

function PassiveMissiles__GetProjectileCount takes unit caster returns integer
    local integer id
    local unit owner
    local integer level

    if caster == null then
        return 0
    endif

    set id=GetHandleId(caster)
    set owner=LoadUnitHandle(PassiveMissiles__PM_Hash, id, PassiveMissiles__PM_KEY_TORNADO_OWNER)

    if owner != null then
        set level=GetUnitAbilityLevel(owner, PassiveMissiles__PM_ABILITY_ID)

        if level <= 0 then
            set level=LoadInteger(PassiveMissiles__PM_Hash, id, PassiveMissiles__PM_KEY_TORNADO_BASE_LEVEL)
        endif

        set owner=null
        return level
    endif

    return GetUnitAbilityLevel(caster, PassiveMissiles__PM_ABILITY_ID)
endfunction

function PassiveMissiles__GetMissileDamageSource takes unit caster returns unit
    local unit owner

    if caster == null then
        return null
    endif

    set owner=LoadUnitHandle(PassiveMissiles__PM_Hash, GetHandleId(caster), PassiveMissiles__PM_KEY_TORNADO_OWNER)

    if owner != null and PassiveMissiles__IsAlive(owner) then
        return owner
    endif

    return caster
endfunction

function PassiveMissiles__DealMissileDamage takes unit source,unit target returns nothing
    local real damage= PassiveMissiles__PM_DAMAGE

    if source == null then
        return
    endif

    if IsUnitType(target, UNIT_TYPE_STRUCTURE) then
        set damage=PassiveMissiles__PM_DAMAGE * PassiveMissiles__PM_STRUCTURE_DAMAGE_MULTIPLIER
    endif

    call UnitDamageTarget(source, target, damage, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, null)
endfunction

function PassiveMissiles__StartMissileSound takes integer i returns nothing
    set PassiveMissiles__PM_Sound[i]=CreateSound(PassiveMissiles__PM_LOOP_SOUND_FILE, true, true, true, PassiveMissiles__PM_SOUND_FADE_IN_RATE, PassiveMissiles__PM_SOUND_FADE_OUT_RATE, "SpellsEAX")

    call SetSoundVolume(PassiveMissiles__PM_Sound[i], PassiveMissiles__PM_LOOP_SOUND_VOLUME)
    call SetSoundDistances(PassiveMissiles__PM_Sound[i], PassiveMissiles__PM_SOUND_MIN_DIST, PassiveMissiles__PM_SOUND_MAX_DIST)
    call SetSoundDistanceCutoff(PassiveMissiles__PM_Sound[i], PassiveMissiles__PM_SOUND_MAX_DIST)
    call SetSoundPosition(PassiveMissiles__PM_Sound[i], PassiveMissiles__PM_X[i], PassiveMissiles__PM_Y[i], PassiveMissiles__PM_Z[i])
    call StartSound(PassiveMissiles__PM_Sound[i])
endfunction

function PassiveMissiles__StopMissileSound takes integer i returns nothing
    if PassiveMissiles__PM_Sound[i] != null then
        call StopSound(PassiveMissiles__PM_Sound[i], true, true)
        set PassiveMissiles__PM_Sound[i]=null
    endif
endfunction

function PassiveMissiles__PlayDeathSoundAt takes real x,real y,real z returns nothing
    local sound s= CreateSound(PassiveMissiles__PM_DEATH_SOUND_FILE, false, true, true, PassiveMissiles__PM_SOUND_FADE_IN_RATE, PassiveMissiles__PM_SOUND_FADE_OUT_RATE, "SpellsEAX")

    call SetSoundVolume(s, PassiveMissiles__PM_DEATH_SOUND_VOLUME)
    call SetSoundDistances(s, PassiveMissiles__PM_SOUND_MIN_DIST, PassiveMissiles__PM_SOUND_MAX_DIST)
    call SetSoundDistanceCutoff(s, PassiveMissiles__PM_SOUND_MAX_DIST)
    call SetSoundPosition(s, x, y, z)
    call StartSound(s)
    call KillSoundWhenDone(s)

    set s=null
endfunction

function PassiveMissiles__RemoveMissile takes integer i returns nothing
    call PassiveMissiles__StopMissileSound(i)
    call DestroyEffect(PassiveMissiles__PM_Fx[i])

    set PassiveMissiles__PM_Fx[i]=PassiveMissiles__PM_Fx[PassiveMissiles__PM_Count]
    set PassiveMissiles__PM_Sound[i]=PassiveMissiles__PM_Sound[PassiveMissiles__PM_Count]
    set PassiveMissiles__PM_Caster[i]=PassiveMissiles__PM_Caster[PassiveMissiles__PM_Count]
    set PassiveMissiles__PM_DamageSource[i]=PassiveMissiles__PM_DamageSource[PassiveMissiles__PM_Count]
    set PassiveMissiles__PM_Target[i]=PassiveMissiles__PM_Target[PassiveMissiles__PM_Count]
    set PassiveMissiles__PM_X[i]=PassiveMissiles__PM_X[PassiveMissiles__PM_Count]
    set PassiveMissiles__PM_Y[i]=PassiveMissiles__PM_Y[PassiveMissiles__PM_Count]
    set PassiveMissiles__PM_Z[i]=PassiveMissiles__PM_Z[PassiveMissiles__PM_Count]

    set PassiveMissiles__PM_Fx[PassiveMissiles__PM_Count]=null
    set PassiveMissiles__PM_Sound[PassiveMissiles__PM_Count]=null
    set PassiveMissiles__PM_Caster[PassiveMissiles__PM_Count]=null
    set PassiveMissiles__PM_DamageSource[PassiveMissiles__PM_Count]=null
    set PassiveMissiles__PM_Target[PassiveMissiles__PM_Count]=null

    set PassiveMissiles__PM_Count=PassiveMissiles__PM_Count - 1

    if PassiveMissiles__PM_Count == 0 then
        call PauseTimer(PassiveMissiles__PM_MoveTimer)
    endif
endfunction

function PassiveMissiles__MoveMissiles takes nothing returns nothing
    local integer i= 1
    local unit caster
    local unit source
    local unit target
    local real tx
    local real ty
    local real tz
    local real dx
    local real dy
    local real dz
    local real dist
    local real step
    local real yaw

    loop
        exitwhen i > PassiveMissiles__PM_Count

        set caster=PassiveMissiles__PM_Caster[i]
        set source=PassiveMissiles__PM_DamageSource[i]
        set target=PassiveMissiles__PM_Target[i]

        if caster == null or target == null or not PassiveMissiles__IsValidTargetForCaster(caster , target) then
            call PassiveMissiles__RemoveMissile(i)
        else
            set tx=GetUnitX(target)
            set ty=GetUnitY(target)
            set tz=BlzGetUnitZ(target) + PassiveMissiles__PM_HEIGHT

            set dx=tx - PassiveMissiles__PM_X[i]
            set dy=ty - PassiveMissiles__PM_Y[i]
            set dz=tz - PassiveMissiles__PM_Z[i]
            set dist=SquareRoot(dx * dx + dy * dy)
            set step=PassiveMissiles__PM_SPEED * PassiveMissiles__PM_TICK

            if dist <= step then
                call BlzSetSpecialEffectPosition(PassiveMissiles__PM_Fx[i], tx, ty, tz)

                if PassiveMissiles__PM_Sound[i] != null then
                    call SetSoundPosition(PassiveMissiles__PM_Sound[i], tx, ty, tz)
                    call PassiveMissiles__PlayDeathSoundAt(tx , ty , tz)
                endif

                if source == null or not PassiveMissiles__IsAlive(source) then
                    set source=caster
                endif

                call PassiveMissiles__DealMissileDamage(source , target)
                call PassiveMissiles__RemoveMissile(i)
            else
                set yaw=Atan2(dy, dx)

                set PassiveMissiles__PM_X[i]=PassiveMissiles__PM_X[i] + dx / dist * step
                set PassiveMissiles__PM_Y[i]=PassiveMissiles__PM_Y[i] + dy / dist * step
                set PassiveMissiles__PM_Z[i]=PassiveMissiles__PM_Z[i] + dz / dist * step

                call BlzSetSpecialEffectPosition(PassiveMissiles__PM_Fx[i], PassiveMissiles__PM_X[i], PassiveMissiles__PM_Y[i], PassiveMissiles__PM_Z[i])
                call BlzSetSpecialEffectYaw(PassiveMissiles__PM_Fx[i], yaw)

                if PassiveMissiles__PM_Sound[i] != null then
                    call SetSoundPosition(PassiveMissiles__PM_Sound[i], PassiveMissiles__PM_X[i], PassiveMissiles__PM_Y[i], PassiveMissiles__PM_Z[i])
                endif

                set i=i + 1
            endif
        endif
    endloop

    set caster=null
    set source=null
    set target=null
endfunction

function PassiveMissiles__LaunchMissile takes unit caster,unit target,boolean playSound returns nothing
    set PassiveMissiles__PM_Count=PassiveMissiles__PM_Count + 1

    set PassiveMissiles__PM_Caster[PassiveMissiles__PM_Count]=caster
    set PassiveMissiles__PM_DamageSource[PassiveMissiles__PM_Count]=PassiveMissiles__GetMissileDamageSource(caster)
    set PassiveMissiles__PM_Target[PassiveMissiles__PM_Count]=target

    set PassiveMissiles__PM_X[PassiveMissiles__PM_Count]=GetUnitX(caster)
    set PassiveMissiles__PM_Y[PassiveMissiles__PM_Count]=GetUnitY(caster)
    set PassiveMissiles__PM_Z[PassiveMissiles__PM_Count]=BlzGetUnitZ(caster) + PassiveMissiles__PM_HEIGHT

    set PassiveMissiles__PM_Fx[PassiveMissiles__PM_Count]=AddSpecialEffect(PassiveMissiles__PM_MODEL, PassiveMissiles__PM_X[PassiveMissiles__PM_Count], PassiveMissiles__PM_Y[PassiveMissiles__PM_Count])
    call BlzSetSpecialEffectScale(PassiveMissiles__PM_Fx[PassiveMissiles__PM_Count], PassiveMissiles__PM_MODEL_SCALE)
    call BlzSetSpecialEffectPosition(PassiveMissiles__PM_Fx[PassiveMissiles__PM_Count], PassiveMissiles__PM_X[PassiveMissiles__PM_Count], PassiveMissiles__PM_Y[PassiveMissiles__PM_Count], PassiveMissiles__PM_Z[PassiveMissiles__PM_Count])

    set PassiveMissiles__PM_Sound[PassiveMissiles__PM_Count]=null

    if playSound then
        call PassiveMissiles__StartMissileSound(PassiveMissiles__PM_Count)
    endif

    if PassiveMissiles__PM_Count == 1 then
        call TimerStart(PassiveMissiles__PM_MoveTimer, PassiveMissiles__PM_TICK, true, function PassiveMissiles__MoveMissiles)
    endif
endfunction

function PassiveMissiles__LaunchOneFromVolley takes unit caster,boolean playSound returns boolean
    local unit target

    if caster != null and PassiveMissiles__IsAlive(caster) and PassiveMissiles__GetProjectileCount(caster) > 0 then
        set target=PassiveMissiles__PickRandomTarget(caster)

        if target != null then
            call PassiveMissiles__LaunchMissile(caster , target , playSound)
            set target=null
            return true
        endif
    endif

    set target=null
    return false
endfunction

function PassiveMissiles__ContinueVolley takes nothing returns nothing
    local timer t= GetExpiredTimer()
    local integer id= GetHandleId(t)
    local unit caster= LoadUnitHandle(PassiveMissiles__PM_Hash, id, PassiveMissiles__PM_KEY_VOLLEY_CASTER)
    local integer remaining= LoadInteger(PassiveMissiles__PM_Hash, id, PassiveMissiles__PM_KEY_VOLLEY_REMAINING)

    call PassiveMissiles__LaunchOneFromVolley(caster , false)

    set remaining=remaining - 1

    if remaining > 0 and caster != null and PassiveMissiles__IsAlive(caster) and PassiveMissiles__GetProjectileCount(caster) > 0 then
        call SaveInteger(PassiveMissiles__PM_Hash, id, PassiveMissiles__PM_KEY_VOLLEY_REMAINING, remaining)
        call TimerStart(t, PassiveMissiles__PM_LAUNCH_DELAY, false, function PassiveMissiles__ContinueVolley)
    else
        call FlushChildHashtable(PassiveMissiles__PM_Hash, id)
        call DestroyTimer(t)
    endif

    set caster=null
    set t=null
endfunction

function PassiveMissiles__StartVolley takes unit caster,integer count returns nothing
    local timer t
    local integer id

    if count <= 0 then
        return
    endif

    if not PassiveMissiles__LaunchOneFromVolley(caster , true) then
        return
    endif

    if count > 1 then
        set t=CreateTimer()
        set id=GetHandleId(t)

        call SaveUnitHandle(PassiveMissiles__PM_Hash, id, PassiveMissiles__PM_KEY_VOLLEY_CASTER, caster)
        call SaveInteger(PassiveMissiles__PM_Hash, id, PassiveMissiles__PM_KEY_VOLLEY_REMAINING, count - 1)

        call TimerStart(t, PassiveMissiles__PM_LAUNCH_DELAY, false, function PassiveMissiles__ContinueVolley)
    endif

    set t=null
endfunction

function PassiveMissiles__FireForCaster takes nothing returns nothing
    local unit caster= GetEnumUnit()
    local integer count= PassiveMissiles__GetProjectileCount(caster)

    if not PassiveMissiles__IsAlive(caster) or count <= 0 then
        call GroupRemoveUnit(PassiveMissiles__PM_Casters, caster)
        call FlushChildHashtable(PassiveMissiles__PM_Hash, GetHandleId(caster))
    else
        call PassiveMissiles__StartVolley(caster , count)
    endif

    set caster=null
endfunction

function PassiveMissiles__PeriodicFire takes nothing returns nothing
    call ForGroup(PassiveMissiles__PM_Casters, function PassiveMissiles__FireForCaster)
endfunction

function PassiveMissiles__OnHeroSkill takes nothing returns boolean
    if GetLearnedSkill() == PassiveMissiles__PM_ABILITY_ID then
        call GroupAddUnit(PassiveMissiles__PM_Casters, GetTriggerUnit())
    endif

    return false
endfunction

function PassiveMissiles__OnSummon takes nothing returns boolean
    local unit summoned= GetSummonedUnit()
    local unit summoner= GetSummoningUnit()
    local integer level

    if summoned != null and summoner != null and GetUnitTypeId(summoned) == PassiveMissiles__PM_TORNADO_UNIT_ID then
        set level=GetUnitAbilityLevel(summoner, PassiveMissiles__PM_ABILITY_ID)

        if level > 0 then
            call SaveUnitHandle(PassiveMissiles__PM_Hash, GetHandleId(summoned), PassiveMissiles__PM_KEY_TORNADO_OWNER, summoner)
            call SaveInteger(PassiveMissiles__PM_Hash, GetHandleId(summoned), PassiveMissiles__PM_KEY_TORNADO_BASE_LEVEL, level)
            call GroupAddUnit(PassiveMissiles__PM_Casters, summoned)
        endif
    endif

    set summoned=null
    set summoner=null
    return false
endfunction

function PassiveMissiles__RegisterExistingUnits takes nothing returns nothing
    local group g= CreateGroup()
    local unit u

    call GroupEnumUnitsInRect(g, bj_mapInitialPlayableArea, null)

    loop
        set u=FirstOfGroup(g)
        exitwhen u == null

        call GroupRemoveUnit(g, u)

        if GetUnitAbilityLevel(u, PassiveMissiles__PM_ABILITY_ID) > 0 then
            call GroupAddUnit(PassiveMissiles__PM_Casters, u)
        endif
    endloop

    call DestroyGroup(g)
    set g=null
    set u=null
endfunction

function PassiveMissiles__Init takes nothing returns nothing
    local trigger skillTrigger= CreateTrigger()
    local trigger summonTrigger= CreateTrigger()
    local integer i= 0

    loop
        exitwhen i >= bj_MAX_PLAYER_SLOTS

        call TriggerRegisterPlayerUnitEvent(skillTrigger, Player(i), EVENT_PLAYER_HERO_SKILL, null)
        call TriggerRegisterPlayerUnitEvent(summonTrigger, Player(i), EVENT_PLAYER_UNIT_SUMMON, null)

        set i=i + 1
    endloop

    call TriggerAddCondition(skillTrigger, Condition(function PassiveMissiles__OnHeroSkill))
    call TriggerAddCondition(summonTrigger, Condition(function PassiveMissiles__OnSummon))

    call PassiveMissiles__RegisterExistingUnits()
    call TimerStart(PassiveMissiles__PM_CastTimer, PassiveMissiles__PM_PERIOD, true, function PassiveMissiles__PeriodicFire)

    set skillTrigger=null
    set summonTrigger=null
endfunction


//library PassiveMissiles ends
//library SpellLeech:


function SpellLeech__ClockExpires takes nothing returns nothing
endfunction

function SpellLeech__Now takes nothing returns real
    return TimerGetElapsed(SpellLeech__SL_Clock)
endfunction

function SpellLeech__IsAlive takes unit u returns boolean
    return u != null and GetWidgetLife(u) > 0.405 and not IsUnitType(u, UNIT_TYPE_DEAD)
endfunction

function SpellLeech__GetDuration takes integer level returns real
    return SpellLeech__SL_BASE_DURATION + SpellLeech__SL_DURATION_PER_LEVEL * I2R(level - 1)
endfunction

function SpellLeech__ActivateLeech takes unit caster,integer level returns nothing
    local real expireTime

    if caster == null or level <= 0 then
        return
    endif

    set expireTime=(TimerGetElapsed(SpellLeech__SL_Clock)) + (SpellLeech__SL_BASE_DURATION + SpellLeech__SL_DURATION_PER_LEVEL * I2R((level) - 1)) // INLINED!!

    call SaveReal(SpellLeech__SL_Hash, GetHandleId(caster), 0, expireTime)
    call DestroyEffect(AddSpecialEffectTarget(SpellLeech__SL_ACTIVATE_EFFECT, caster, "origin"))
endfunction

function SpellLeech__IsLeechActive takes unit caster returns boolean
    if caster == null then
        return false
    endif

    return LoadReal(SpellLeech__SL_Hash, GetHandleId(caster), 0) > (TimerGetElapsed(SpellLeech__SL_Clock)) // INLINED!!
endfunction

function SpellLeech__IsValidLeechDamage takes unit source,unit target,real damage returns boolean
    if damage <= 0.00 then
        return false
    endif

    if not SpellLeech__IsAlive(source) then
        return false
    endif

    if target == null then
        return false
    endif

    if not SpellLeech__IsLeechActive(source) then
        return false
    endif

    if SpellLeech__SL_ENEMY_ONLY and not IsUnitEnemy(target, GetOwningPlayer(source)) then
        return false
    endif

    if SpellLeech__SL_REQUIRE_NON_ATTACK and BlzGetEventIsAttack() then
        return false
    endif

    if SpellLeech__SL_REQUIRE_DAMAGE_TYPE_MAGIC and BlzGetEventDamageType() != DAMAGE_TYPE_MAGIC then
        return false
    endif

    return true
endfunction

function SpellLeech__HealUnit takes unit u,real amount returns nothing
    local real life
    local real maxLife

    if not SpellLeech__IsAlive(u) or amount <= 0.00 then
        return
    endif

    set life=GetWidgetLife(u)
    set maxLife=GetUnitState(u, UNIT_STATE_MAX_LIFE)

    if life + amount > maxLife then
        call SetWidgetLife(u, maxLife)
    else
        call SetWidgetLife(u, life + amount)
    endif

    if SpellLeech__SL_SHOW_HEAL_EFFECT then
        call DestroyEffect(AddSpecialEffectTarget(SpellLeech__SL_HEAL_EFFECT, u, "origin"))
    endif
endfunction

function SpellLeech__OnSpellEffect takes nothing returns nothing
    local unit caster
    local integer level

    if GetSpellAbilityId() == SpellLeech__SL_ABILITY_ID then
        set caster=GetTriggerUnit()
        set level=GetUnitAbilityLevel(caster, SpellLeech__SL_ABILITY_ID)

        call SpellLeech__ActivateLeech(caster , level)

        set caster=null
    endif
endfunction

function SpellLeech__OnDamage takes nothing returns nothing
    local unit target= GetTriggerUnit()
    local unit source= GetEventDamageSource()
    local real damage= GetEventDamage()
    local real healAmount

    if SpellLeech__IsValidLeechDamage(source , target , damage) then
        set healAmount=damage * SpellLeech__SL_LEECH_FACTOR
        call SpellLeech__HealUnit(source , healAmount)
    endif

    set target=null
    set source=null
endfunction

function SpellLeech__Init takes nothing returns nothing
    local trigger spellTrigger= CreateTrigger()
    local trigger damageTrigger= CreateTrigger()
    local integer i= 0

    call TimerStart(SpellLeech__SL_Clock, 999999.00, false, function SpellLeech__ClockExpires)

    loop
        exitwhen i >= bj_MAX_PLAYER_SLOTS

        call TriggerRegisterPlayerUnitEvent(spellTrigger, Player(i), EVENT_PLAYER_UNIT_SPELL_EFFECT, null)
        call TriggerRegisterPlayerUnitEvent(damageTrigger, Player(i), EVENT_PLAYER_UNIT_DAMAGED, null)

        set i=i + 1
    endloop

    call TriggerAddAction(spellTrigger, function SpellLeech__OnSpellEffect)
    call TriggerAddAction(damageTrigger, function SpellLeech__OnDamage)

    set spellTrigger=null
    set damageTrigger=null
endfunction


//library SpellLeech ends
//===========================================================================
// 
// |cff08BD5AForest Expansion|r 3.1.2a
// 
//   Warcraft III map script
//   Generated by the Warcraft III World Editor
//   Map Author: Nikkone
// 
//===========================================================================

//***************************************************************************
//*
//*  Global Variables
//*
//***************************************************************************


function InitGlobals takes nothing returns nothing
    local integer i= 0
    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_Units[i]=0
        set i=i + 1
    endloop

    set udg_Selectors='ewsp'
    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_Ancients[i]=0
        set i=i + 1
    endloop

    set udg_Razormane=CreateForce()
    set udg_UDex=0
    set udg_UDexRecycle=0
    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_UDexNext[i]=0
        set i=i + 1
    endloop

    set udg_UDexGen=0
    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_UDexPrev[i]=0
        set i=i + 1
    endloop

    set udg_UnitIndexEvent=0
    set udg_UnitIndexerEnabled=false
    set udg_UDexWasted=0
    set udg_ncld_DrainHP=0
    set udg_ncld_DrainHPUp=0
    set udg_ncld_DrainMP=0
    set udg_ncld_DrainMPUp=0
    set udg_ncld_Duration=0
    set udg_ncld_Duration_Up=0
    set udg_ncld_Range=0
    set udg_ncld_RangeUp=0
    set udg_ncld_TargetSFXArt=""
    set udg_ncld_CasterSFXArt=""
    set udg_ncld_FreqDrain=0
    set udg_ncld_FreqDistance=0
    set udg_ncld_EtherealBonus=0
    set udg_ncld_buffId=0
    set udg_ncld_CheckImmune=false
    set udg_ncld_CheckResistant=false
    set udg_ncld_CheckVisibile=false
    set udg_tempReal=0
    set udg_Key=0
    set udg_ncld_Group=CreateGroup()
    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_ncld_Tick[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_ncld_TicksRemaining[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_ncld_Hp[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_ncld_Mp[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_ncld_Rng[i]=0
        set i=i + 1
    endloop

    set udg_CheckBool=false
    set udg_tempDistance=0
    set udg_tempX1=0
    set udg_tempX2=0
    set udg_tempY1=0
    set udg_tempY2=0
    set udg_tempZ1=0
    set udg_tempZ2=0
    set udg_VanguardHeal=0
    set udg_Omni=0
    set udg_RemSel=CreateGroup()
    set udg_FZ=CreateTimer()
    set udg_LS=CreateTimer()
    set udg_AncientInCombat=0
    set udg_Bans=4
    set udg_BannedWorgen=0
    set udg_BannedForgotten=0
    set udg_BannedAethyr=0
    set udg_BannedGoblin=0
    set udg_BannedOgre=0
    set udg_BannedMagmide=0
    set udg_BannedFurbolg=0
    set udg_BannedRazormane=0
    set udg_BannedNerubian=0
    set udg_BannedWildkin=0
    set udg_BannedHuman=0
    set udg_BannedCentaur=0
    set udg_BannedWisp=0
    set udg_BannedKobold=0
    set udg_BannedGhoul=0
    set udg_BannedKraken=0
    set udg_BannedAncientLight=0
    set udg_BannedAncientLightning=0
    set udg_BannedAncientDragon=0
    set udg_BannedAncientEarth=0
    set udg_BannedAncientDarkness=0
    set udg_BannedAncientIce=0
    set udg_BannedAncientFire=0
    set udg_BannedAncientNature=0
    set udg_ExpanderSpawnTimer=CreateTimer()
    set udg_AncientSpawnTimer=CreateTimer()
    set udg_BannedAncientSand=0
    set udg_Cascade=0
    set udg_Resillence=0
    set udg_CosmicStrikeCount=0
    set udg_PreDamageEvent=0
    set udg_ArmorDamageEvent=0
    set udg_ZeroDamageEvent=0
    set udg_LethalDamageEvent=0
    set udg_OnDamageEvent=0
    set udg_AfterDamageEvent=0
    set udg_SourceDamageEvent=0
    set udg_AOEDamageEvent=0
    set udg_DamageModifierEvent=0
    set udg_DamageEvent=0
    set udg_RemoveDamageEvent=false
    set udg_DamageEventOverride=false
    set udg_DamageEventPrevAmt=0
    set udg_DamageEventLevel=0
    set udg_DamageEventAOE=0
    set udg_DamageEventAOEGroup=CreateGroup()
    set udg_DamageScalingWC3=0
    set udg_DamageScalingUser=0
    set udg_IsDamageAttack=false
    set udg_IsDamageMelee=false
    set udg_IsDamageRanged=false
    set udg_IsDamageSpell=false
    set udg_IsDamageCode=false
    set udg_DamageEventAmount=0
    set udg_DamageEventArmorPierced=0
    set udg_LethalDamageHP=0
    set udg_DamageEventAttackT=0
    set udg_DamageEventDamageT=0
    set udg_DamageEventArmorT=0
    set udg_DamageEventDefenseT=0
    set udg_DamageEventWeaponT=0
    set udg_DamageEventType=0
    set udg_NextDamageIsAttack=false
    set udg_NextDamageIsRanged=false
    set udg_NextDamageIsMelee=false
    set udg_NextDamageType=0
    set udg_NextDamageWeaponT=0
    set udg_DamageFilterAttackT=0
    set udg_DamageFilterDamageT=0
    set udg_DamageFilterType=0
    set udg_DamageFilterMinAmount=0
    set udg_DamageFilterRunChance=0
    set udg_DamageFilterFailChance=0
    set udg_DamageFilterSourceC=0
    set udg_DamageFilterTargetC=0
    set udg_UNIT_CLASS_MAGIC_IMMUNE=0
    set udg_UNIT_CLASS_ETHEREAL=0
    set udg_UNIT_CLASS_RESISTANT=0
    set udg_UNIT_CLASS_SLEEPING=0
    set udg_UNIT_CLASS_POLYMORPHED=0
    set udg_UNIT_CLASS_POISONED=0
    set udg_UNIT_CLASS_TAUREN=0
    set udg_UNIT_CLASS_ANCIENT=0
    set udg_UNIT_CLASS_TOWNHALL=0
    set udg_UNIT_CLASS_SAPPER=0
    set udg_UNIT_CLASS_PEON=0
    set udg_UNIT_CLASS_MECHANICAL=0
    set udg_UNIT_CLASS_UNDEAD=0
    set udg_UNIT_CLASS_SNARED=0
    set udg_UNIT_CLASS_PLAGUED=0
    set udg_UNIT_CLASS_STUNNED=0
    set udg_UNIT_CLASS_SUMMONED=0
    set udg_UNIT_CLASS_GIANT=0
    set udg_UNIT_CLASS_RANGED=0
    set udg_UNIT_CLASS_MELEE=0
    set udg_UNIT_CLASS_ATTACKS_GROUND=0
    set udg_UNIT_CLASS_ATTACKS_FLYING=0
    set udg_UNIT_CLASS_GROUND=0
    set udg_UNIT_CLASS_FLYING=0
    set udg_UNIT_CLASS_STRUCTURE=0
    set udg_UNIT_CLASS_DEAD=0
    set udg_UNIT_CLASS_HERO=0
    set udg_ARMOR_TYPE_NONE=0
    set udg_ARMOR_TYPE_FLESH=0
    set udg_ARMOR_TYPE_METAL=0
    set udg_ARMOR_TYPE_WOOD=0
    set udg_ARMOR_TYPE_ETHEREAL=0
    set udg_ARMOR_TYPE_STONE=0
    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_ArmorTypeDebugStr[i]=""
        set i=i + 1
    endloop

    set udg_ATTACK_TYPE_SPELLS=0
    set udg_ATTACK_TYPE_NORMAL=0
    set udg_ATTACK_TYPE_PIERCE=0
    set udg_ATTACK_TYPE_SIEGE=0
    set udg_ATTACK_TYPE_MAGIC=0
    set udg_ATTACK_TYPE_CHAOS=0
    set udg_ATTACK_TYPE_HERO=0
    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_AttackTypeDebugStr[i]=""
        set i=i + 1
    endloop

    set udg_DamageTypeBlocked=0
    set udg_DamageTypeCriticalStrike=0
    set udg_DamageTypeCode=0
    set udg_DamageTypeExplosive=0
    set udg_DamageTypeHeal=0
    set udg_DamageTypePure=0
    set udg_DamageTypePureExplosive=0
    set udg_DamageTypeReduced=0
    set udg_DAMAGE_TYPE_UNKNOWN=0
    set udg_DAMAGE_TYPE_NORMAL=0
    set udg_DAMAGE_TYPE_ENHANCED=0
    set udg_DAMAGE_TYPE_FIRE=0
    set udg_DAMAGE_TYPE_COLD=0
    set udg_DAMAGE_TYPE_LIGHTNING=0
    set udg_DAMAGE_TYPE_POISON=0
    set udg_DAMAGE_TYPE_DISEASE=0
    set udg_DAMAGE_TYPE_DIVINE=0
    set udg_DAMAGE_TYPE_MAGIC=0
    set udg_DAMAGE_TYPE_SONIC=0
    set udg_DAMAGE_TYPE_ACID=0
    set udg_DAMAGE_TYPE_FORCE=0
    set udg_DAMAGE_TYPE_DEATH=0
    set udg_DAMAGE_TYPE_MIND=0
    set udg_DAMAGE_TYPE_PLANT=0
    set udg_DAMAGE_TYPE_DEFENSIVE=0
    set udg_DAMAGE_TYPE_DEMOLITION=0
    set udg_DAMAGE_TYPE_SLOW_POISON=0
    set udg_DAMAGE_TYPE_SPIRIT_LINK=0
    set udg_DAMAGE_TYPE_SHADOW_STRIKE=0
    set udg_DAMAGE_TYPE_UNIVERSAL=0
    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_DamageTypeDebugStr[i]=""
        set i=i + 1
    endloop

    set udg_DEFENSE_TYPE_LIGHT=0
    set udg_DEFENSE_TYPE_MEDIUM=0
    set udg_DEFENSE_TYPE_HEAVY=0
    set udg_DEFENSE_TYPE_FORTIFIED=0
    set udg_DEFENSE_TYPE_NORMAL=0
    set udg_DEFENSE_TYPE_HERO=0
    set udg_DEFENSE_TYPE_DIVINE=0
    set udg_DEFENSE_TYPE_UNARMORED=0
    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_DefenseTypeDebugStr[i]=""
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_WeaponTypeDebugStr[i]=""
        set i=i + 1
    endloop

    set udg_WEAPON_TYPE_NONE=0
    set udg_WEAPON_TYPE_ML_CHOP=0
    set udg_WEAPON_TYPE_MM_CHOP=0
    set udg_WEAPON_TYPE_MH_CHOP=0
    set udg_WEAPON_TYPE_ML_SLICE=0
    set udg_WEAPON_TYPE_MM_SLICE=0
    set udg_WEAPON_TYPE_MH_SLICE=0
    set udg_WEAPON_TYPE_MM_BASH=0
    set udg_WEAPON_TYPE_MH_BASH=0
    set udg_WEAPON_TYPE_MM_STAB=0
    set udg_WEAPON_TYPE_MH_STAB=0
    set udg_WEAPON_TYPE_WL_SLICE=0
    set udg_WEAPON_TYPE_WM_SLICE=0
    set udg_WEAPON_TYPE_WH_SLICE=0
    set udg_WEAPON_TYPE_WL_BASH=0
    set udg_WEAPON_TYPE_WM_BASH=0
    set udg_WEAPON_TYPE_WH_BASH=0
    set udg_WEAPON_TYPE_WL_STAB=0
    set udg_WEAPON_TYPE_WM_STAB=0
    set udg_WEAPON_TYPE_CL_SLICE=0
    set udg_WEAPON_TYPE_CM_SLICE=0
    set udg_WEAPON_TYPE_CH_SLICE=0
    set udg_WEAPON_TYPE_AM_CHOP=0
    set udg_WEAPON_TYPE_RH_BASH=0
    set udg_XPperSecond=0
    set udg_BannedAncientSpace=0
    set udg_Dutchmen=CreateGroup()
    set i=0
    loop
        exitwhen ( i > 12 )
        set udg_PlayerColorHex[i]=""
        set i=i + 1
    endloop

    set udg_ThunderstruckLevel=0
    set udg_AncientPlayer=Player(6)
    set udg_StillAlive=0
    set udg_Ziggurats=CreateGroup()
    set udg_AuraLevel=0
    set udg_Ziggurats_Count=0
    set udg_BannedElf=0
    set udg_ShadowDancers=CreateGroup()
    set udg_SeedPlayedNumber=0
    set i=0
    loop
        exitwhen ( i > 11 )
        set udg_DeepWater1[i]=false
        set i=i + 1
    endloop

    set udg_BannedHighElf=0
    set i=0
    loop
        exitwhen ( i > 11 )
        set udg_ExperienceRate[i]=100.00
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 11 )
        set udg_SilentStrider[i]=false
        set i=i + 1
    endloop

    set udg_TSEUnitAliveCheck=false
    set udg_TSE__RemainingDuration=0
    set udg_TSE__ActiveIndex=0
    set udg_TSE_TIMEOUT=0
    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_TSE_I_RemainingDuration[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_TSE_I_ChanneledOrderID[i]=""
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_TSE_I_IsChanneling[i]=false
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_TSE_I_TargetUnitAliveCheck[i]=false
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_TSE_I_SourceUnitAliveCheck[i]=false
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_TSE_I_OnLoopTimer[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_TSE_I_LoopDuration[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_TSE_I_ActiveInstance[i]=false
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_TSE_I_LockInstance[i]=false
        set i=i + 1
    endloop

    set udg_TSE_MaxIndex=0
    set udg_TSE_ReplacementIndex=0
    set udg_TSE_ReplacementIndexFound=false
    set udg_TSE_MaxCheckOver=false
    set udg_TSE_MaxRecursion=0
    set udg_TSE_Recursion=0
    set udg_TSE_Index=0
    set udg_TSE_CTimer=CreateTimer()
    set udg_TSETargetUnitAliveCheck=false
    set udg_TSESourceUnitAliveCheck=false
    set udg_TSEEffectName=""
    set udg_TSEAttachPoint=""
    set udg_TSEDuration=0
    set udg_TSEScale=0
    set udg_TSEChanneledOrderID=""
    set udg_TSEOnLoopTimer=0
    set udg_TSELockInstance=false
    set udg_Acided=CreateGroup()
    set udg_BannedRatling=0
    set udg_TreeChopper="|cff456d46-chopoff|r"
    set udg_Tradeoff="|cff456d46-tradeoff|r"
    set udg_Counterstring=""
    set udg_IntSeconds=0
    set udg_IntMinutes=0
    set udg_IntHours=0
    set udg_StringSeconds=""
    set udg_StringMinutes=""
    set udg_BannedHunter=0
    set i=0
    loop
        exitwhen ( i > 11 )
        set udg_Multiboard_Spot[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 1 )
        set udg_Flags[i]=false
        set i=i + 1
    endloop

    set udg_BannedAncientWind=0
    set udg_StartupDialog=DialogCreate()
endfunction

//***************************************************************************
//*
//*  Custom Script Code
//*
//***************************************************************************
//***************************************************************************
//*  Untitled Script 001
function Trig_Item_Crafting_Actions takes nothing returns nothing
    local unit u= GetTriggerUnit()
    local integer count= 0
    local integer i

    call DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "Trigger fired!")

    // Count instances of the required item in the inventory
    loop
        set i=0
        exitwhen i >= 6
        if GetItemTypeId(UnitItemInSlot(u, i)) == 'I01J' then
            set count=count + 1
        endif
        set i=i + 1
    endloop

    // Check if the unit has at least two of the required item
    if count >= 2 then
        set count=2 // Only remove exactly two items
        set i=0

        loop
            exitwhen count == 0 or i >= 6
            if GetItemTypeId(UnitItemInSlot(u, i)) == 'I01J' then
                call UnitRemoveItemFromSlot(u, i)
                set count=count - 1
            endif
            set i=i + 1
        endloop

        // Create the new crafted item
        call UnitAddItemById(u, 'I01N')
        call DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "Claw of Attack +12 crafted!")
    endif

    // Clean up local variables
    set u=null
endfunction

// Trigger Initialization

function InitTrig_Item_Crafting takes nothing returns nothing
    local trigger t= CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddAction(t, function Trig_Item_Crafting_Actions)
endfunction

//***************************************************************************
//*
//*  Destructible Item Tables
//*
//***************************************************************************

function Doodad001056_DropItems takes nothing returns nothing
    local widget trigWidget= null
    local unit trigUnit= null
    local integer itemID= 0
    local boolean canDrop= true

    set trigWidget=bj_lastDyingWidget
    if ( trigWidget == null ) then
        set trigUnit=GetTriggerUnit()
    endif

    if ( trigUnit != null ) then
        set canDrop=not IsUnitHidden(trigUnit)
        if ( canDrop and GetChangingUnit() != null ) then
            set canDrop=( GetChangingUnitPrevOwner() == Player(PLAYER_NEUTRAL_AGGRESSIVE) )
        endif
    endif

    if ( canDrop ) then
        // Item set 0
        call RandomDistReset()
        call RandomDistAddItem('I02C', 100)
        set itemID=RandomDistChoose()
        if ( trigUnit != null ) then
            call UnitDropItem(trigUnit, itemID)
        else
            call WidgetDropItem(trigWidget, itemID)
        endif

    endif

    set bj_lastDyingWidget=null
    call DestroyTrigger(GetTriggeringTrigger())
endfunction


//***************************************************************************
//*
//*  Sound Assets
//*
//***************************************************************************

function InitSounds takes nothing returns nothing
    set gg_snd_VarimathrasYes1=CreateSound("Units\\Undead\\Varimathras\\VarimathrasYes1.wav", false, false, false, 10, 10, "DefaultEAXON")
    call SetSoundDuration(gg_snd_VarimathrasYes1, 1352)
    call SetSoundChannel(gg_snd_VarimathrasYes1, 0)
    call SetSoundVolume(gg_snd_VarimathrasYes1, - 1)
    call SetSoundPitch(gg_snd_VarimathrasYes1, 1.0)
    set gg_snd_PeasantDeath=CreateSound("Units\\Human\\Peasant\\PeasantDeath.wav", false, false, false, 10, 10, "DefaultEAXON")
    call SetSoundDuration(gg_snd_PeasantDeath, 3645)
    call SetSoundChannel(gg_snd_PeasantDeath, 0)
    call SetSoundVolume(gg_snd_PeasantDeath, - 1)
    call SetSoundPitch(gg_snd_PeasantDeath, 1.0)
    set gg_snd_CentaurDeath=CreateSound("Units\\Creeps\\Centaur\\CentaurDeath.wav", false, false, false, 10, 10, "DefaultEAXON")
    call SetSoundDuration(gg_snd_CentaurDeath, 2005)
    call SetSoundChannel(gg_snd_CentaurDeath, 0)
    call SetSoundVolume(gg_snd_CentaurDeath, - 1)
    call SetSoundPitch(gg_snd_CentaurDeath, 1.0)
    set gg_snd_WispPissed1=CreateSound("Units\\NightElf\\Wisp\\WispPissed1.wav", false, false, false, 10, 10, "DefaultEAXON")
    call SetSoundDuration(gg_snd_WispPissed1, 2797)
    call SetSoundChannel(gg_snd_WispPissed1, 0)
    call SetSoundVolume(gg_snd_WispPissed1, - 1)
    call SetSoundPitch(gg_snd_WispPissed1, 1.0)
    set gg_snd_WarlockDeath1=CreateSound("Units\\Demon\\Warlock\\WarlockDeath1.wav", false, false, false, 10, 10, "DefaultEAXON")
    call SetSoundDuration(gg_snd_WarlockDeath1, 3430)
    call SetSoundChannel(gg_snd_WarlockDeath1, 0)
    call SetSoundVolume(gg_snd_WarlockDeath1, - 1)
    call SetSoundPitch(gg_snd_WarlockDeath1, 0.5)
    set gg_snd_OgreDeath1=CreateSound("Units\\Creeps\\Ogre\\OgreDeath1.wav", false, false, false, 10, 10, "DefaultEAXON")
    call SetSoundDuration(gg_snd_OgreDeath1, 2059)
    call SetSoundChannel(gg_snd_OgreDeath1, 0)
    call SetSoundVolume(gg_snd_OgreDeath1, - 1)
    call SetSoundPitch(gg_snd_OgreDeath1, 1.0)
    set gg_snd_HeroFirelordDeath1=CreateSound("Units\\Creeps\\HeroFlameLord\\HeroFirelordDeath1.wav", false, false, false, 10, 10, "DefaultEAXON")
    call SetSoundDuration(gg_snd_HeroFirelordDeath1, 2345)
    call SetSoundChannel(gg_snd_HeroFirelordDeath1, 0)
    call SetSoundVolume(gg_snd_HeroFirelordDeath1, - 1)
    call SetSoundPitch(gg_snd_HeroFirelordDeath1, 1.0)
    set gg_snd_SatyrDeath1=CreateSound("Units\\Creeps\\Satyr\\SatyrDeath1.wav", false, false, false, 10, 10, "DefaultEAXON")
    call SetSoundDuration(gg_snd_SatyrDeath1, 3565)
    call SetSoundChannel(gg_snd_SatyrDeath1, 0)
    call SetSoundVolume(gg_snd_SatyrDeath1, - 1)
    call SetSoundPitch(gg_snd_SatyrDeath1, 1.0)
    set gg_snd_BansheeDeath=CreateSound("Units\\Undead\\Banshee\\BansheeDeath.wav", false, false, false, 10, 10, "DefaultEAXON")
    call SetSoundDuration(gg_snd_BansheeDeath, 2379)
    call SetSoundChannel(gg_snd_BansheeDeath, 0)
    call SetSoundVolume(gg_snd_BansheeDeath, - 1)
    call SetSoundPitch(gg_snd_BansheeDeath, 1.0)
    set gg_snd_TinkerDeathAlt1=CreateSound("Units\\Creeps\\HeroTinker\\TinkerDeathAlt1.wav", false, false, false, 10, 10, "DefaultEAXON")
    call SetSoundDuration(gg_snd_TinkerDeathAlt1, 3088)
    call SetSoundChannel(gg_snd_TinkerDeathAlt1, 0)
    call SetSoundVolume(gg_snd_TinkerDeathAlt1, - 1)
    call SetSoundPitch(gg_snd_TinkerDeathAlt1, 1.0)
    set gg_snd_FurbolgDeath1=CreateSound("Units\\Creeps\\Furbolg\\FurbolgDeath1.wav", false, false, false, 10, 10, "DefaultEAXON")
    call SetSoundDuration(gg_snd_FurbolgDeath1, 2798)
    call SetSoundChannel(gg_snd_FurbolgDeath1, 0)
    call SetSoundVolume(gg_snd_FurbolgDeath1, - 1)
    call SetSoundPitch(gg_snd_FurbolgDeath1, 1.0)
    set gg_snd_PitFiendDeath1=CreateSound("Units\\Undead\\CryptFiend\\PitFiendDeath1.wav", false, false, false, 10, 10, "DefaultEAXON")
    call SetSoundDuration(gg_snd_PitFiendDeath1, 2792)
    call SetSoundChannel(gg_snd_PitFiendDeath1, 0)
    call SetSoundVolume(gg_snd_PitFiendDeath1, - 1)
    call SetSoundPitch(gg_snd_PitFiendDeath1, 1.0)
    set gg_snd_HydraDeath1=CreateSound("Units\\Creeps\\Hydra\\HydraDeath1.wav", false, false, false, 10, 10, "DefaultEAXON")
    call SetSoundDuration(gg_snd_HydraDeath1, 3002)
    call SetSoundChannel(gg_snd_HydraDeath1, 0)
    call SetSoundVolume(gg_snd_HydraDeath1, - 1)
    call SetSoundPitch(gg_snd_HydraDeath1, 1.0)
    set gg_snd_KoboldDeath=CreateSound("Units\\Creeps\\Kobold\\KoboldDeath.wav", false, false, false, 10, 10, "DefaultEAXON")
    call SetSoundDuration(gg_snd_KoboldDeath, 2075)
    call SetSoundChannel(gg_snd_KoboldDeath, 0)
    call SetSoundVolume(gg_snd_KoboldDeath, - 1)
    call SetSoundPitch(gg_snd_KoboldDeath, 1.0)
    set gg_snd_QuillboarDeath=CreateSound("Units\\Creeps\\QuillBeast\\QuillboarDeath.wav", false, false, false, 10, 10, "DefaultEAXON")
    call SetSoundDuration(gg_snd_QuillboarDeath, 1529)
    call SetSoundChannel(gg_snd_QuillboarDeath, 0)
    call SetSoundVolume(gg_snd_QuillboarDeath, - 1)
    call SetSoundPitch(gg_snd_QuillboarDeath, 1.0)
    set gg_snd_FacelessDeath1=CreateSound("Units\\Creeps\\FacelessOne\\FacelessDeath1.wav", false, false, false, 10, 10, "DefaultEAXON")
    call SetSoundDuration(gg_snd_FacelessDeath1, 1979)
    call SetSoundChannel(gg_snd_FacelessDeath1, 0)
    call SetSoundVolume(gg_snd_FacelessDeath1, - 1)
    call SetSoundPitch(gg_snd_FacelessDeath1, 0.8)
    set gg_snd_WendigoDeath=CreateSound("Units\\Creeps\\Wendigo\\WendigoDeath.wav", false, false, false, 10, 10, "DefaultEAXON")
    call SetSoundDuration(gg_snd_WendigoDeath, 2147)
    call SetSoundChannel(gg_snd_WendigoDeath, 0)
    call SetSoundVolume(gg_snd_WendigoDeath, - 1)
    call SetSoundPitch(gg_snd_WendigoDeath, 1.0)
    set gg_snd_DemonHunterDeathAlternate1=CreateSound("Units/NightElf/HeroDemonHunter/DemonHunterDeathAlternate1.flac", false, true, true, 0, 0, "HeroAcksEAX")
    call SetSoundParamsFromLabel(gg_snd_DemonHunterDeathAlternate1, "HeroDemonHunterDeathAlternate")
    call SetSoundDuration(gg_snd_DemonHunterDeathAlternate1, 2002)
    call SetSoundVolume(gg_snd_DemonHunterDeathAlternate1, 127)
    set gg_snd_DruidOfTheTalonDeath1=CreateSound("Units/NightElf/DruidOfTheTalon/DruidOfTheTalonDeath1.flac", false, true, true, 0, 0, "DefaultEAXON")
    call SetSoundParamsFromLabel(gg_snd_DruidOfTheTalonDeath1, "DruidOfTheTalonDeath")
    call SetSoundDuration(gg_snd_DruidOfTheTalonDeath1, 4597)
    call SetSoundVolume(gg_snd_DruidOfTheTalonDeath1, 127)
    set gg_snd_GhoulDeath=CreateSound("Units/Undead/Ghoul/GhoulDeath.flac", false, true, true, 0, 0, "DefaultEAXON")
    call SetSoundParamsFromLabel(gg_snd_GhoulDeath, "GhoulDeath")
    call SetSoundDuration(gg_snd_GhoulDeath, 1570)
    call SetSoundVolume(gg_snd_GhoulDeath, 127)
    set gg_snd_HeroDemonHunterDeath1=CreateSound("Units/NightElf/HeroDemonHunter/HeroDemonHunterDeath1.flac", false, true, true, 1, 1, "HeroAcksEAX")
    call SetSoundParamsFromLabel(gg_snd_HeroDemonHunterDeath1, "HeroDemonHunterDeath")
    call SetSoundDuration(gg_snd_HeroDemonHunterDeath1, 4133)
    call SetSoundVolume(gg_snd_HeroDemonHunterDeath1, 127)
    set gg_snd_RiflemanDeath=CreateSound("Units/Human/Rifleman/RiflemanDeath.flac", false, true, true, 0, 0, "DefaultEAXON")
    call SetSoundParamsFromLabel(gg_snd_RiflemanDeath, "RiflemanDeath")
    call SetSoundDuration(gg_snd_RiflemanDeath, 1770)
    call SetSoundVolume(gg_snd_RiflemanDeath, 127)
    set gg_snd_DuneWormDeath1=CreateSound("Units/Critters/DuneWorm/DuneWormDeath1.flac", false, true, true, 0, 0, "DefaultEAXON")
    call SetSoundParamsFromLabel(gg_snd_DuneWormDeath1, "DuneWormDeath")
    call SetSoundDuration(gg_snd_DuneWormDeath1, 2885)
    call SetSoundVolume(gg_snd_DuneWormDeath1, 127)
    set gg_snd_CycloneLoop1=CreateSound("Abilities/Spells/NightElf/Cyclone/CycloneLoop1.flac", false, true, true, 1, 1, "SpellsEAX")
    call SetSoundParamsFromLabel(gg_snd_CycloneLoop1, "CycloneLoop")
    call SetSoundDuration(gg_snd_CycloneLoop1, 4003)
    call SetSoundVolume(gg_snd_CycloneLoop1, 127)
    set gg_snd_CycloneDeath1=CreateSound("Abilities/Spells/NightElf/Cyclone/CycloneDeath1.flac", false, true, true, 1, 1, "SpellsEAX")
    call SetSoundParamsFromLabel(gg_snd_CycloneDeath1, "CycloneDeath")
    call SetSoundDuration(gg_snd_CycloneDeath1, 2136)
    call SetSoundVolume(gg_snd_CycloneDeath1, 60)
    set gg_snd_KaelYesAttack3=CreateSound("Units/Human/Kael/KaelYesAttack3.flac", false, true, true, 0, 0, "HeroAcksEAX")
    call SetSoundParamsFromLabel(gg_snd_KaelYesAttack3, "KaelYesAttack")
    call SetSoundDuration(gg_snd_KaelYesAttack3, 1634)
    call SetSoundVolume(gg_snd_KaelYesAttack3, 127)
endfunction

//***************************************************************************
//*
//*  Destructable Objects
//*
//***************************************************************************

function CreateAllDestructables takes nothing returns nothing
    local destructable d
    local trigger t
    local real life
    set d=BlzCreateDestructableZWithSkin('LTbr', 6560.0, 6816.0, 132.0, 178.000, 1.110, 0, 'LTbr')
    set t=CreateTrigger()
    call TriggerRegisterDeathEvent(t, d)
    call TriggerAddAction(t, function SaveDyingWidget)
    call TriggerAddAction(t, function Doodad001056_DropItems)
endfunction

//***************************************************************************
//*
//*  Unit Creation
//*
//***************************************************************************

//===========================================================================
function CreateUnitsForPlayer0 takes nothing returns nothing
    local player p= Player(0)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set u=BlzCreateUnitWithSkin(p, 'ewsp', 6785.4, 7161.1, 311.219, 'ewsp')
endfunction

//===========================================================================
function CreateUnitsForPlayer1 takes nothing returns nothing
    local player p= Player(1)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set u=BlzCreateUnitWithSkin(p, 'ewsp', 6814.8, 7191.4, 72.545, 'ewsp')
endfunction

//===========================================================================
function CreateUnitsForPlayer2 takes nothing returns nothing
    local player p= Player(2)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set u=BlzCreateUnitWithSkin(p, 'ewsp', 6783.5, 7170.7, 223.688, 'ewsp')
endfunction

//===========================================================================
function CreateUnitsForPlayer3 takes nothing returns nothing
    local player p= Player(3)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set u=BlzCreateUnitWithSkin(p, 'ewsp', 6832.2, 7179.2, 125.742, 'ewsp')
endfunction

//===========================================================================
function CreateUnitsForPlayer4 takes nothing returns nothing
    local player p= Player(4)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set u=BlzCreateUnitWithSkin(p, 'ewsp', 6804.7, 7159.1, 90.816, 'ewsp')
endfunction

//===========================================================================
function CreateUnitsForPlayer5 takes nothing returns nothing
    local player p= Player(5)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set u=BlzCreateUnitWithSkin(p, 'ewsp', 6827.8, 7152.9, 329.336, 'ewsp')
endfunction

//===========================================================================
function CreateBuildingsForPlayer6 takes nothing returns nothing
    local player p= Player(6)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set u=BlzCreateUnitWithSkin(p, 'h02B', - 1216.0, - 192.0, 270.000, 'h02B')
    set u=BlzCreateUnitWithSkin(p, 'n000', 0.0, 832.0, 270.000, 'n000')
    set u=BlzCreateUnitWithSkin(p, 'n00A', - 384.0, 256.0, 270.000, 'n00A')
    set u=BlzCreateUnitWithSkin(p, 'h05B', - 768.0, 128.0, 270.000, 'h05B')
    set gg_unit_n00B_0266=BlzCreateUnitWithSkin(p, 'n00B', - 1216.0, 512.0, 270.000, 'n00B')
endfunction

//===========================================================================
function CreateUnitsForPlayer6 takes nothing returns nothing
    local player p= Player(6)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set u=BlzCreateUnitWithSkin(p, 'ewsp', 7652.9, 7309.1, 170.810, 'ewsp')
endfunction

//===========================================================================
function CreateUnitsForPlayer7 takes nothing returns nothing
    local player p= Player(7)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set u=BlzCreateUnitWithSkin(p, 'ewsp', 6788.3, 7144.7, 65.349, 'ewsp')
endfunction

//===========================================================================
function CreateUnitsForPlayer8 takes nothing returns nothing
    local player p= Player(8)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set u=BlzCreateUnitWithSkin(p, 'ewsp', 6831.1, 7153.0, 168.931, 'ewsp')
endfunction

//===========================================================================
function CreateUnitsForPlayer9 takes nothing returns nothing
    local player p= Player(9)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set u=BlzCreateUnitWithSkin(p, 'ewsp', 6794.9, 7144.5, 165.646, 'ewsp')
endfunction

//===========================================================================
function CreateUnitsForPlayer10 takes nothing returns nothing
    local player p= Player(10)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set u=BlzCreateUnitWithSkin(p, 'ewsp', 6815.7, 7143.3, 346.574, 'ewsp')
endfunction

//===========================================================================
function CreateNeutralHostileBuildings takes nothing returns nothing
    local player p= Player(PLAYER_NEUTRAL_AGGRESSIVE)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set u=BlzCreateUnitWithSkin(p, 'h00Q', - 4096.0, 6016.0, 270.000, 'h00Q')
    set u=BlzCreateUnitWithSkin(p, 'h00Q', 832.0, 6272.0, 270.000, 'h00Q')
    set gg_unit_h00Q_0026=BlzCreateUnitWithSkin(p, 'h00Q', - 4480.0, 2816.0, 270.000, 'h00Q')
    set u=BlzCreateUnitWithSkin(p, 'h00Q', 7616.0, - 7872.0, 270.000, 'h00Q')
    set u=BlzCreateUnitWithSkin(p, 'h00Q', 6976.0, 4416.0, 270.000, 'h00Q')
    set u=BlzCreateUnitWithSkin(p, 'h00Q', - 3584.0, - 4160.0, 270.000, 'h00Q')
    set u=BlzCreateUnitWithSkin(p, 'h00Q', 4864.0, - 960.0, 270.000, 'h00Q')
endfunction

//===========================================================================
function CreateNeutralPassiveBuildings takes nothing returns nothing
    local player p= Player(PLAYER_NEUTRAL_PASSIVE)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set gg_unit_nmer_0000=BlzCreateUnitWithSkin(p, 'nmer', 6976.0, 7168.0, 270.000, 'nmer')
    call SetUnitColor(gg_unit_nmer_0000, ConvertPlayerColor(0))
    set gg_unit_nmr2_0001=BlzCreateUnitWithSkin(p, 'nmr2', 7680.0, 7168.0, 270.000, 'nmr2')
    call SetUnitColor(gg_unit_nmr2_0001, ConvertPlayerColor(12))
    set gg_unit_n00G_0035=BlzCreateUnitWithSkin(p, 'n00G', 6656.0, 7168.0, 270.000, 'n00G')
    call SetUnitColor(gg_unit_n00G_0035, ConvertPlayerColor(0))
    set u=BlzCreateUnitWithSkin(p, 'h03R', - 4800.0, 960.0, 270.000, 'h03R')
    call WaygateSetDestination(u, GetRectCenterX(gg_rct_Suspicious_Bush_1), GetRectCenterY(gg_rct_Suspicious_Bush_1))
    call WaygateActivate(u, true)
    set u=BlzCreateUnitWithSkin(p, 'h03R', - 3264.0, - 320.0, 270.000, 'h03R')
    call WaygateSetDestination(u, GetRectCenterX(gg_rct_Suspicious_Bush_2), GetRectCenterY(gg_rct_Suspicious_Bush_2))
    call WaygateActivate(u, true)
endfunction

//===========================================================================
function CreateNeutralPassive takes nothing returns nothing
    local player p= Player(PLAYER_NEUTRAL_PASSIVE)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set u=BlzCreateUnitWithSkin(p, 'n00D', 646.0, - 5477.8, 179.588, 'n00D')
    set u=BlzCreateUnitWithSkin(p, 'n00F', 3218.3, 5330.8, 80.389, 'n00F')
    set u=BlzCreateUnitWithSkin(p, 'n00I', - 4433.9, 5244.2, 120.667, 'n00I')
    set u=BlzCreateUnitWithSkin(p, 'n001', - 1143.1, - 337.6, 257.571, 'n001')
    set u=BlzCreateUnitWithSkin(p, 'n001', - 1380.1, - 190.4, 328.062, 'n001')
    set u=BlzCreateUnitWithSkin(p, 'n00E', 5236.3, - 5638.1, 334.247, 'n00E')
endfunction

//===========================================================================
function CreatePlayerBuildings takes nothing returns nothing
    call CreateBuildingsForPlayer6()
endfunction

//===========================================================================
function CreatePlayerUnits takes nothing returns nothing
    call CreateUnitsForPlayer0()
    call CreateUnitsForPlayer1()
    call CreateUnitsForPlayer2()
    call CreateUnitsForPlayer3()
    call CreateUnitsForPlayer4()
    call CreateUnitsForPlayer5()
    call CreateUnitsForPlayer6()
    call CreateUnitsForPlayer7()
    call CreateUnitsForPlayer8()
    call CreateUnitsForPlayer9()
    call CreateUnitsForPlayer10()
endfunction

//===========================================================================
function CreateAllUnits takes nothing returns nothing
    call CreateNeutralHostileBuildings()
    call CreateNeutralPassiveBuildings()
    call CreateBuildingsForPlayer6() // INLINED!!
    call CreateNeutralPassive()
    call CreatePlayerUnits()
endfunction

//***************************************************************************
//*
//*  Regions
//*
//***************************************************************************

function CreateRegions takes nothing returns nothing
    local weathereffect we

    set gg_rct_SpawnDefender=Rect(7744.0, 7136.0, 7872.0, 7264.0)
    set gg_rct_Tele_out_D=Rect(7360.0, 6752.0, 7936.0, 7552.0)
    set gg_rct_Tele_out_E=Rect(6240.0, 6784.0, 7296.0, 7552.0)
    set gg_rct_Spawn_all=Rect(- 704.0, - 64.0, - 96.0, 480.0)
    set gg_rct_Alarm=Rect(- 640.0, - 96.0, - 160.0, 480.0)
    set gg_rct_Spawner=Rect(- 512.0, 64.0, - 288.0, 320.0)
    set gg_rct_Camera_1=Rect(6528.0, 6944.0, 7936.0, 7424.0)
    set gg_rct_Respawn=Rect(6720.0, 7200.0, 8032.0, 7392.0)
    set gg_rct_Ping1=Rect(- 4640.0, 2688.0, - 4320.0, 2976.0)
    set gg_rct_Ping2=Rect(- 4224.0, 5888.0, - 4000.0, 6112.0)
    set gg_rct_Ping3=Rect(672.0, 6144.0, 960.0, 6368.0)
    set gg_rct_Ping4=Rect(6592.0, 4256.0, 6912.0, 4416.0)
    set gg_rct_Ping5=Rect(7488.0, - 7968.0, 7712.0, - 7776.0)
    set gg_rct_Rest_of_Map=Rect(- 8192.0, - 8704.0, 8160.0, 7680.0)
    set gg_rct_Ping6=Rect(- 3744.0, - 4256.0, - 3456.0, - 4064.0)
    set gg_rct_AI_Move_1=Rect(- 6784.0, 6176.0, - 6560.0, 6368.0)
    set gg_rct_AI_Move_2=Rect(- 4800.0, 4384.0, - 4704.0, 4512.0)
    set gg_rct_AI_Move_3=Rect(- 4384.0, 1248.0, - 4288.0, 1344.0)
    set gg_rct_AI_Move_4=Rect(- 7008.0, - 5856.0, - 6912.0, - 5760.0)
    set gg_rct_AI_Move_5=Rect(- 4224.0, - 6080.0, - 3872.0, - 5920.0)
    set gg_rct_AI_Move_6=Rect(3936.0, - 4896.0, 4128.0, - 4736.0)
    set gg_rct_AI_Move_7=Rect(6048.0, - 7072.0, 6272.0, - 6912.0)
    set gg_rct_AI_Move_8=Rect(6464.0, - 224.0, 6656.0, - 64.0)
    set gg_rct_AI_Move_9=Rect(3392.0, - 288.0, 3552.0, - 128.0)
    set gg_rct_AI_Move_10=Rect(4992.0, 3136.0, 5152.0, 3328.0)
    set gg_rct_Suspicious_Bush_1=Rect(- 3360.0, - 480.0, - 3200.0, - 352.0)
    set gg_rct_Suspicious_Bush_2=Rect(- 4768.0, 896.0, - 4608.0, 1024.0)
    set gg_rct_Remove_Selection=Rect(6240.0, 6784.0, 7936.0, 7552.0)
    set gg_rct_Ping7=Rect(4768.0, - 1056.0, 4960.0, - 832.0)
    set gg_rct_Fountain=Rect(- 1440.0, - 544.0, 320.0, 1088.0)
    set gg_rct_SeedofR=Rect(- 8192.0, - 8704.0, - 8000.0, - 8512.0)
    set gg_rct_Base_1=Rect(- 7872.0, 5344.0, - 5216.0, 7136.0)
    set gg_rct_Base_2=Rect(- 5408.0, 3552.0, - 3648.0, 4960.0)
    set gg_rct_Base_3=Rect(- 4896.0, 416.0, - 3424.0, 1920.0)
    set gg_rct_rawr=Rect(- 3680.0, - 928.0, - 2656.0, 288.0)
    set gg_rct_Base_4=Rect(- 7584.0, - 6176.0, - 6240.0, - 3520.0)
    set gg_rct_Base_5=Rect(- 4992.0, - 7776.0, - 3200.0, - 5568.0)
    set gg_rct_Base_6=Rect(3936.0, 2784.0, 5920.0, 5408.0)
    set gg_rct_Base_7=Rect(2336.0, - 1120.0, 4160.0, 896.0)
    set gg_rct_Base_8=Rect(5856.0, - 1440.0, 7360.0, 512.0)
    set gg_rct_Base_9=Rect(3136.0, - 5696.0, 4896.0, - 3136.0)
    set gg_rct_Base_10=Rect(4736.0, - 7552.0, 7104.0, - 5888.0)
    set gg_rct_ChopChop=Rect(- 160.0, 2080.0, 128.0, 2400.0)
endfunction

//***************************************************************************
//*
//*  Triggers
//*
//***************************************************************************

//===========================================================================
// Trigger: Damage Engine Config
//===========================================================================
function Trig_Damage_Engine_Config_Actions takes nothing returns nothing
    // You can add extra classifications here if you want to differentiate between your triggered damage
    // Use DamageTypeExplosive (or any negative value damage type) if you want a unit killed by that damage to explode
    // -
    // The pre-defined type Code might be set by Damage Engine if Unit - Damage Target is detected and the user didn't define a type of their own.
    // "Pure" is especially important because it overrides both the Damage Engine as well as WarCraft 3 damage modification.
    // I therefore gave the user "Explosive Pure" in case one wants to combine the functionality of the two.
    // -
    set udg_DamageTypePureExplosive=- 2
    set udg_DamageTypeExplosive=- 1
    set udg_DamageTypeCode=1
    set udg_DamageTypePure=2
    // -
    // The following types are custom for the user only and do not have any significance to Damage Engine
    // other than telling it that the damage source is 'code' if setting NextDamageType to one of them
    // -
    set udg_DamageTypeHeal=3
    set udg_DamageTypeBlocked=4
    set udg_DamageTypeReduced=5
    set udg_DamageTypeCriticalStrike=6
    // -
    // Inform the DamageEngine source code to initialize the debug strings.
    // This cannot be done during library/struct initialization because InitGlobals had not been called yet.
    // Due to weird GUI-vJass conflicts, I created Total Initialization for Lua.
    // -
    call DamageEngine_DebugStr()
endfunction

//===========================================================================
function InitTrig_Damage_Engine_Config takes nothing returns nothing
    set gg_trg_Damage_Engine_Config=CreateTrigger()
    call TriggerAddAction(gg_trg_Damage_Engine_Config, function Trig_Damage_Engine_Config_Actions)
endfunction

//===========================================================================
// Trigger: Damage Engine
//===========================================================================



//===========================================================================

//===========================================================================
// Trigger: TSEConfig
//===========================================================================
function Trig_TSEConfig_Actions takes nothing returns nothing
    // CORE
    // Set to TSELoop trigger
    set udg_TSE_LoopTrigger=gg_trg_TSELoop
    // Set to TSERegister trigger
    set udg_TSE_RegisterTrigger=gg_trg_TSERegister
    // Set to TSEEmptyEvent trigger
    set udg_TSE_EmptyEvent=gg_trg_TSEEmptyEvent
    // DO NOT CHANGE
    // UNLESS YOU KNOW WHAT YOU ARE DOING
    // Default timeout for effect check
    // Recommended value: 0.03-0.10
    // Default: 0.03125 (1/32)
    // Low End Performance: 0.1, 0.05
    // Extreme Precision: 1/64, 1/128
    set udg_TSE_TIMEOUT=( 1.00 / 32.00 )
    // Recursion for Lock Instance tolerance
    // A safety feature if infinite loops happened when Lock Instance is utilized, although theorically it should not be triggered at all
    // It is recommended to keep this at numbers ideally higher than generally possible instances until TSE is suspected of freezing the map due to loops
    set udg_TSE_MaxRecursion=32767
    // END CONFIG
    // Default values for some variables
    set udg_TSEScale=1.00
endfunction

//===========================================================================
function InitTrig_TSEConfig takes nothing returns nothing
    set gg_trg_TSEConfig=CreateTrigger()
    call TriggerAddAction(gg_trg_TSEConfig, function Trig_TSEConfig_Actions)
endfunction

//===========================================================================
// Trigger: TSERegister
//===========================================================================
function Trig_TSERegister_Func002C takes nothing returns boolean
    if ( not ( udg_TSEUnit != null ) ) then
        return false
    endif
    if ( not ( udg_TSETargetUnit == null ) ) then
        return false
    endif
    return true
endfunction

function Trig_TSERegister_Func003Func001C takes nothing returns boolean
    if ( ( udg_TSETargetUnitAliveCheck == true ) ) then
        return true
    endif
    if ( ( udg_TSEUnitAliveCheck == true ) ) then
        return true
    endif
    return false
endfunction

function Trig_TSERegister_Func003C takes nothing returns boolean
    if ( not Trig_TSERegister_Func003Func001C() ) then
        return false
    endif
    return true
endfunction

function Trig_TSERegister_Func007C takes nothing returns boolean
    if ( not ( udg_TSETargetUnit != null ) ) then
        return false
    endif
    return true
endfunction

function Trig_TSERegister_Func008C takes nothing returns boolean
    if ( not ( udg_TSESourceUnit != null ) ) then
        return false
    endif
    return true
endfunction

function Trig_TSERegister_Func011Func001C takes nothing returns boolean
    if ( not ( udg_TSESourceUnit != null ) ) then
        return false
    endif
    return true
endfunction

function Trig_TSERegister_Func011C takes nothing returns boolean
    if ( not ( udg_TSEChanneledOrderID != "" ) ) then
        return false
    endif
    return true
endfunction

function Trig_TSERegister_Func012C takes nothing returns boolean
    if ( not ( udg_TSEOnLoopTimer < udg_TSE_TIMEOUT ) ) then
        return false
    endif
    return true
endfunction

function Trig_TSERegister_Func034C takes nothing returns boolean
    if ( not ( udg_TSE_MaxIndex == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_TSERegister_Actions takes nothing returns nothing
    // Backward compatibility
    if ( Trig_TSERegister_Func002C() ) then
        set udg_TSETargetUnit=udg_TSEUnit
    else
    endif
    if ( Trig_TSERegister_Func003C() ) then
        set udg_TSETargetUnitAliveCheck=true
    else
    endif
    // Register effect instance
    set udg_TSE_MaxIndex=( udg_TSE_MaxIndex + 1 )
    set udg_TSE_I_RemainingDuration[udg_TSE_MaxIndex]=udg_TSEDuration
    if ( Trig_TSERegister_Func007C() ) then
        call AddSpecialEffectTargetUnitBJ(udg_TSEAttachPoint, udg_TSETargetUnit, udg_TSEEffectName)
        set udg_TSE_I_TargetUnitAliveCheck[udg_TSE_MaxIndex]=udg_TSETargetUnitAliveCheck
    else
        call AddSpecialEffectLocBJ(udg_TSEPoint, udg_TSEEffectName)
        set udg_TSE_I_TargetUnitAliveCheck[udg_TSE_MaxIndex]=false
    endif
    if ( Trig_TSERegister_Func008C() ) then
        set udg_TSE_I_SourceUnitAliveCheck[udg_TSE_MaxIndex]=udg_TSESourceUnitAliveCheck
    else
    endif
    set udg_TSE_I_Effect[udg_TSE_MaxIndex]=GetLastCreatedEffectBJ()
    call BlzSetSpecialEffectScale(udg_TSE_I_Effect[udg_TSE_MaxIndex], udg_TSEScale)
    if ( Trig_TSERegister_Func011C() ) then
        if ( Trig_TSERegister_Func011Func001C() ) then
            set udg_TSE_I_IsChanneling[udg_TSE_MaxIndex]=true
        else
            call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_4185")
        endif
    else
    endif
    if ( Trig_TSERegister_Func012C() ) then
        set udg_TSEOnLoopTimer=udg_TSE_TIMEOUT
    else
    endif
    set udg_TSE_I_SourceUnit[udg_TSE_MaxIndex]=udg_TSESourceUnit
    set udg_TSE_I_TargetUnit[udg_TSE_MaxIndex]=udg_TSETargetUnit
    set udg_TSE_I_ChanneledOrderID[udg_TSE_MaxIndex]=udg_TSEChanneledOrderID
    set udg_TSE_I_OnLoopEvent[udg_TSE_MaxIndex]=udg_TSEOnLoopEvent
    set udg_TSE_I_OnLoopTimer[udg_TSE_MaxIndex]=udg_TSEOnLoopTimer
    set udg_TSE_I_LoopDuration[udg_TSE_MaxIndex]=udg_TSEOnLoopTimer
    set udg_TSE_I_OnEndEvent[udg_TSE_MaxIndex]=udg_TSEOnEndEvent
    set udg_TSE_I_LockInstance[udg_TSE_MaxIndex]=udg_TSELockInstance
    set udg_TSE_I_ActiveInstance[udg_TSE_MaxIndex]=true
    set udg_TSE_I_Point[udg_TSE_MaxIndex]=udg_TSEPoint
    // OnEvent Variables
    set udg_TSE__ActiveIndex=udg_TSE_MaxIndex
    set udg_TSE__RemainingDuration=udg_TSE_I_RemainingDuration[udg_TSE__ActiveIndex]
    set udg_TSE__SourceUnit=udg_TSE_I_SourceUnit[udg_TSE__ActiveIndex]
    set udg_TSE__TargetUnit=udg_TSE_I_TargetUnit[udg_TSE__ActiveIndex]
    set udg_TSE__Point=udg_TSE_I_Point[udg_TSE__ActiveIndex]
    set udg_TSE__SpecialEffect=udg_TSE_I_Effect[udg_TSE__ActiveIndex]
    // Run OnIndexEvent
    call ConditionalTriggerExecute(udg_TSEOnIndexEvent)
    set udg_TSE_I_RemainingDuration[udg_TSE__ActiveIndex]=udg_TSE__RemainingDuration
    // Loop Check
    if ( Trig_TSERegister_Func034C() ) then
        call StartTimerBJ(udg_TSE_CTimer, true, udg_TSE_TIMEOUT)
        call EnableTrigger(udg_TSE_LoopTrigger)
    else
    endif
    // Clean information for next registration
    set udg_TSETargetUnit=null
    set udg_TSETargetUnitAliveCheck=false
    set udg_TSEScale=1.00
    set udg_TSEChanneledOrderID=""
    set udg_TSESourceUnit=null
    set udg_TSEOnIndexEvent=udg_TSE_EmptyEvent
    set udg_TSEOnLoopEvent=udg_TSE_EmptyEvent
    set udg_TSEOnLoopTimer=udg_TSE_TIMEOUT
    set udg_TSEOnEndEvent=udg_TSE_EmptyEvent
    set udg_TSELockInstance=false
    // DEPRECATED
    set udg_TSEUnit=null
    set udg_TSEUnitAliveCheck=false
endfunction

//===========================================================================
function InitTrig_TSERegister takes nothing returns nothing
    set gg_trg_TSERegister=CreateTrigger()
    call TriggerAddAction(gg_trg_TSERegister, function Trig_TSERegister_Actions)
endfunction

//===========================================================================
// Trigger: TSELoop
//===========================================================================
function Trig_TSELoop_Func002Func001Func004C takes nothing returns boolean
    if ( not ( udg_TSE_I_LoopDuration[udg_TSE_Index] <= 0.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_TSELoop_Func002Func001Func006C takes nothing returns boolean
    if ( not ( udg_TSE_I_TargetUnitAliveCheck[udg_TSE_Index] == true ) ) then
        return false
    endif
    if ( not ( IsUnitAliveBJ(udg_TSE_I_TargetUnit[udg_TSE_Index]) == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_TSELoop_Func002Func001Func007C takes nothing returns boolean
    if ( not ( udg_TSE_I_SourceUnitAliveCheck[udg_TSE_Index] == true ) ) then
        return false
    endif
    if ( not ( IsUnitAliveBJ(udg_TSE_I_SourceUnit[udg_TSE_Index]) == false ) ) then
        return false
    endif
    if ( not ( udg_TSE_I_SourceUnit[udg_TSE_Index] != null ) ) then
        return false
    endif
    return true
endfunction

function Trig_TSELoop_Func002Func001Func008C takes nothing returns boolean
    if ( not ( udg_TSE_I_IsChanneling[udg_TSE_Index] == true ) ) then
        return false
    endif
    if ( not ( GetUnitCurrentOrder(udg_TSE_I_SourceUnit[udg_TSE_Index]) != String2OrderIdBJ(udg_TSE_I_ChanneledOrderID[udg_TSE_Index]) ) ) then
        return false
    endif
    return true
endfunction

function Trig_TSELoop_Func002Func001Func010Func017Func002Func002C takes nothing returns boolean
    if ( not ( udg_TSE_I_LockInstance[udg_TSE_ReplacementIndex] == false ) ) then
        return false
    endif
    if ( not ( udg_TSE_I_ActiveInstance[udg_TSE_ReplacementIndex] == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_TSELoop_Func002Func001Func010Func017Func002C takes nothing returns boolean
    if ( ( udg_TSE_Recursion >= udg_TSE_MaxRecursion ) ) then
        return true
    endif
    if ( Trig_TSELoop_Func002Func001Func010Func017Func002Func002C() ) then
        return true
    endif
    if ( ( udg_TSE_ReplacementIndex == udg_TSE_Index ) ) then
        return true
    endif
    return false
endfunction

function Trig_TSELoop_Func002Func001Func010Func017C takes nothing returns boolean
    if ( not Trig_TSELoop_Func002Func001Func010Func017Func002C() ) then
        return false
    endif
    return true
endfunction

function Trig_TSELoop_Func002Func001Func010Func039Func002C takes nothing returns boolean
    if ( ( udg_TSE_ReplacementIndex == udg_TSE_MaxIndex ) ) then
        return true
    endif
    if ( ( udg_TSE_I_ActiveInstance[udg_TSE_MaxIndex] == false ) ) then
        return true
    endif
    return false
endfunction

function Trig_TSELoop_Func002Func001Func010Func039Func005Func002C takes nothing returns boolean
    if ( ( udg_TSE_I_ActiveInstance[udg_TSE_MaxIndex] == true ) ) then
        return true
    endif
    if ( ( udg_TSE_MaxIndex <= 0 ) ) then
        return true
    endif
    return false
endfunction

function Trig_TSELoop_Func002Func001Func010Func039Func005C takes nothing returns boolean
    if ( not Trig_TSELoop_Func002Func001Func010Func039Func005Func002C() ) then
        return false
    endif
    return true
endfunction

function Trig_TSELoop_Func002Func001Func010Func039C takes nothing returns boolean
    if ( not Trig_TSELoop_Func002Func001Func010Func039Func002C() ) then
        return false
    endif
    return true
endfunction

function Trig_TSELoop_Func002Func001Func010Func041C takes nothing returns boolean
    if ( not ( udg_TSE_MaxIndex <= 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_TSELoop_Func002Func001Func010C takes nothing returns boolean
    if ( not ( udg_TSE_I_RemainingDuration[udg_TSE_Index] <= 0.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_TSELoop_Func002Func001C takes nothing returns boolean
    if ( not ( udg_TSE_I_ActiveInstance[udg_TSE_Index] == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_TSELoop_Actions takes nothing returns nothing
    set udg_TSE_Index=1
    loop
        exitwhen udg_TSE_Index > udg_TSE_MaxIndex
        if ( Trig_TSELoop_Func002Func001C() ) then
            set udg_TSE_I_RemainingDuration[udg_TSE_Index]=( udg_TSE_I_RemainingDuration[udg_TSE_Index] - udg_TSE_TIMEOUT )
            set udg_TSE_I_LoopDuration[udg_TSE_Index]=( udg_TSE_I_LoopDuration[udg_TSE_Index] - udg_TSE_TIMEOUT )
            // Check if this is time for loop event
            if ( Trig_TSELoop_Func002Func001Func004C() ) then
                // OnEvent Variables
                set udg_TSE__ActiveIndex=udg_TSE_Index
                set udg_TSE__RemainingDuration=udg_TSE_I_RemainingDuration[udg_TSE__ActiveIndex]
                set udg_TSE__SourceUnit=udg_TSE_I_SourceUnit[udg_TSE__ActiveIndex]
                set udg_TSE__TargetUnit=udg_TSE_I_TargetUnit[udg_TSE__ActiveIndex]
                set udg_TSE__Point=udg_TSE_I_Point[udg_TSE__ActiveIndex]
                set udg_TSE__SpecialEffect=udg_TSE_I_Effect[udg_TSE__ActiveIndex]
                // OnLoopEvent
                call ConditionalTriggerExecute(udg_TSE_I_OnLoopEvent[udg_TSE_Index])
                set udg_TSE_I_RemainingDuration[udg_TSE__ActiveIndex]=udg_TSE__RemainingDuration
                // Reset Loop Timer
                set udg_TSE_I_LoopDuration[udg_TSE_Index]=udg_TSE_I_OnLoopTimer[udg_TSE_Index]
            else
            endif
            // Loop conditional check
            if ( Trig_TSELoop_Func002Func001Func006C() ) then
                set udg_TSE_I_RemainingDuration[udg_TSE_Index]=0.00
            else
            endif
            if ( Trig_TSELoop_Func002Func001Func007C() ) then
                set udg_TSE_I_RemainingDuration[udg_TSE_Index]=0.00
            else
            endif
            if ( Trig_TSELoop_Func002Func001Func008C() ) then
                set udg_TSE_I_RemainingDuration[udg_TSE_Index]=0.00
            else
            endif
            // End phase check
            if ( Trig_TSELoop_Func002Func001Func010C() ) then
                // OnEvent Variables
                set udg_TSE__ActiveIndex=udg_TSE_Index
                set udg_TSE__RemainingDuration=udg_TSE_I_RemainingDuration[udg_TSE__ActiveIndex]
                set udg_TSE__SourceUnit=udg_TSE_I_SourceUnit[udg_TSE__ActiveIndex]
                set udg_TSE__TargetUnit=udg_TSE_I_TargetUnit[udg_TSE__ActiveIndex]
                set udg_TSE__Point=udg_TSE_I_Point[udg_TSE__ActiveIndex]
                set udg_TSE__SpecialEffect=udg_TSE_I_Effect[udg_TSE__ActiveIndex]
                // OnEndEvent
                call ConditionalTriggerExecute(udg_TSE_I_OnEndEvent[udg_TSE_Index])
                // De-indexing Phase
                call DestroyEffectBJ(udg_TSE_I_Effect[udg_TSE_Index])
                set udg_TSE_ReplacementIndexFound=false
                set udg_TSE_ReplacementIndex=udg_TSE_MaxIndex
                set udg_TSE_Recursion=0
                loop
                set udg_TSE_Recursion=( udg_TSE_Recursion + 1 )
                if ( Trig_TSELoop_Func002Func001Func010Func017C() ) then
                    set udg_TSE_ReplacementIndexFound=true
                else
                    set udg_TSE_ReplacementIndex=( udg_TSE_ReplacementIndex - 1 )
                endif
                exitwhen udg_TSE_ReplacementIndexFound == true
                endloop
                call RemoveLocation(udg_TSE_I_Point[udg_TSE_Index])
                set udg_TSE_I_Point[udg_TSE_Index]=udg_TSE_I_Point[udg_TSE_ReplacementIndex]
                set udg_TSE_I_RemainingDuration[udg_TSE_Index]=udg_TSE_I_RemainingDuration[udg_TSE_ReplacementIndex]
                set udg_TSE_I_Effect[udg_TSE_Index]=udg_TSE_I_Effect[udg_TSE_ReplacementIndex]
                set udg_TSE_I_ChanneledOrderID[udg_TSE_Index]=udg_TSE_I_ChanneledOrderID[udg_TSE_ReplacementIndex]
                set udg_TSE_I_IsChanneling[udg_TSE_Index]=udg_TSE_I_IsChanneling[udg_TSE_ReplacementIndex]
                set udg_TSE_I_SourceUnit[udg_TSE_Index]=udg_TSE_I_SourceUnit[udg_TSE_ReplacementIndex]
                set udg_TSE_I_SourceUnitAliveCheck[udg_TSE_Index]=udg_TSE_I_SourceUnitAliveCheck[udg_TSE_ReplacementIndex]
                set udg_TSE_I_TargetUnitAliveCheck[udg_TSE_Index]=udg_TSE_I_TargetUnitAliveCheck[udg_TSE_ReplacementIndex]
                set udg_TSE_I_TargetUnit[udg_TSE_Index]=udg_TSE_I_TargetUnit[udg_TSE_ReplacementIndex]
                set udg_TSE_I_OnLoopEvent[udg_TSE_Index]=udg_TSE_I_OnLoopEvent[udg_TSE_ReplacementIndex]
                set udg_TSE_I_OnLoopTimer[udg_TSE_Index]=udg_TSE_I_OnLoopTimer[udg_TSE_ReplacementIndex]
                set udg_TSE_I_LoopDuration[udg_TSE_Index]=udg_TSE_I_LoopDuration[udg_TSE_ReplacementIndex]
                set udg_TSE_I_OnEndEvent[udg_TSE_Index]=udg_TSE_I_OnEndEvent[udg_TSE_ReplacementIndex]
                set udg_TSE_I_LockInstance[udg_TSE_Index]=udg_TSE_I_LockInstance[udg_TSE_ReplacementIndex]
                set udg_TSE_I_LockInstance[udg_TSE_ReplacementIndex]=false
                set udg_TSE_I_ActiveInstance[udg_TSE_Index]=udg_TSE_I_ActiveInstance[udg_TSE_ReplacementIndex]
                set udg_TSE_I_ActiveInstance[udg_TSE_ReplacementIndex]=false
                set udg_TSE_Index=( udg_TSE_Index - 1 )
                if ( Trig_TSELoop_Func002Func001Func010Func039C() ) then
                    set udg_TSE_MaxCheckOver=false
                    loop
                    set udg_TSE_MaxIndex=( udg_TSE_MaxIndex - 1 )
                    if ( Trig_TSELoop_Func002Func001Func010Func039Func005C() ) then
                        set udg_TSE_MaxCheckOver=true
                    else
                    endif
                    exitwhen udg_TSE_MaxCheckOver == true
                    endloop
                else
                endif
                if ( Trig_TSELoop_Func002Func001Func010Func041C() ) then
                    call PauseTimerBJ(true, udg_TSE_CTimer)
                    call DisableTrigger(udg_TSE_LoopTrigger)
                else
                endif
            else
            endif
        else
        endif
        set udg_TSE_Index=udg_TSE_Index + 1
    endloop
endfunction

//===========================================================================
function InitTrig_TSELoop takes nothing returns nothing
    set gg_trg_TSELoop=CreateTrigger()
    call DisableTrigger(gg_trg_TSELoop)
    call TriggerRegisterTimerExpireEventBJ(gg_trg_TSELoop, udg_TSE_CTimer)
    call TriggerAddAction(gg_trg_TSELoop, function Trig_TSELoop_Actions)
endfunction

//===========================================================================
// Trigger: TSEEmptyEvent
//===========================================================================
function Trig_TSEEmptyEvent_Actions takes nothing returns nothing
endfunction

//===========================================================================
function InitTrig_TSEEmptyEvent takes nothing returns nothing
    set gg_trg_TSEEmptyEvent=CreateTrigger()
    call TriggerAddAction(gg_trg_TSEEmptyEvent, function Trig_TSEEmptyEvent_Actions)
endfunction

//===========================================================================
// Trigger: Map Ini Testing
//
// May 4th
//===========================================================================
function Trig_Map_Ini_Testing_Actions takes nothing returns nothing
    call CreateMultiboardBJ(3, 11, "TRIGSTR_5709")
    call MultiboardSetTitleText(GetLastCreatedMultiboard(), "TRIGSTR_5710")
endfunction

//===========================================================================
function InitTrig_Map_Ini_Testing takes nothing returns nothing
    set gg_trg_Map_Ini_Testing=CreateTrigger()
    call DisableTrigger(gg_trg_Map_Ini_Testing)
    call TriggerRegisterTimerEventSingle(gg_trg_Map_Ini_Testing, 1.00)
    call TriggerAddAction(gg_trg_Map_Ini_Testing, function Trig_Map_Ini_Testing_Actions)
endfunction

//===========================================================================
// Trigger: Counter Testing
//
// May 4th
//===========================================================================
function Trig_Counter_Testing_Actions takes nothing returns nothing
    call MultiboardSetItemWidthBJ(GetLastCreatedMultiboard(), 1, 1, 15.00)
    call MultiboardSetItemWidthBJ(GetLastCreatedMultiboard(), 2, 1, 15.00)
    call MultiboardSetItemStyleBJ(GetLastCreatedMultiboard(), 0, 1, true, false)
    call MultiboardSetItemIconBJ(GetLastCreatedMultiboard(), 0, 2, "UI\\Feedback\\Resources\\ResourceGold.blp")
    call MultiboardSetItemValueBJ(GetLastCreatedMultiboard(), 0, 1, "TRIGSTR_4490")
    call MultiboardSetItemValueBJ(GetLastCreatedMultiboard(), 0, 2, "TRIGSTR_152")
    call MultiboardSetItemValueBJ(GetLastCreatedMultiboard(), 1, 3, GetPlayerName(Player(0)))
    call MultiboardSetItemValueBJ(GetLastCreatedMultiboard(), 1, 3, ( "|cffff0000" + ( GetPlayerName(Player(0)) + "|r" ) ))
    call MultiboardSetItemWidthBJ(GetLastCreatedMultiboard(), 0, 2, 13.00)
    call MultiboardSetItemWidthBJ(GetLastCreatedMultiboard(), 1, 3, 15.00)
    call MultiboardSetItemWidthBJ(GetLastCreatedMultiboard(), 2, 3, 6.00)
    call MultiboardSetItemValueBJ(GetLastCreatedMultiboard(), 2, 3, I2S(GetPlayerState(Player(0), PLAYER_STATE_RESOURCE_GOLD)))
endfunction

//===========================================================================
function InitTrig_Counter_Testing takes nothing returns nothing
    set gg_trg_Counter_Testing=CreateTrigger()
    call DisableTrigger(gg_trg_Counter_Testing)
    call TriggerRegisterTimerEventPeriodic(gg_trg_Counter_Testing, 2.00)
    call TriggerAddAction(gg_trg_Counter_Testing, function Trig_Counter_Testing_Actions)
endfunction

//===========================================================================
// Trigger: Start Counter
//
// Temporary rushed trigger for quick hotfix patch april 29th.
//===========================================================================
function Trig_Start_Counter_Actions takes nothing returns nothing
    call DisableTrigger(gg_trg_Tradeoff_Detection)
    call DisableTrigger(gg_trg_TreeChopper_Detection)
endfunction

//===========================================================================
function InitTrig_Start_Counter takes nothing returns nothing
    set gg_trg_Start_Counter=CreateTrigger()
    call DisableTrigger(gg_trg_Start_Counter)
    call TriggerRegisterTimerEventSingle(gg_trg_Start_Counter, 60.00)
    call TriggerAddAction(gg_trg_Start_Counter, function Trig_Start_Counter_Actions)
endfunction

//===========================================================================
// Trigger: Counter
//===========================================================================
function Trig_Counter_Func002Func003C takes nothing returns boolean
    if ( not ( udg_IntMinutes == 60 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Counter_Func002C takes nothing returns boolean
    if ( not ( udg_IntSeconds == 60 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Counter_Func003C takes nothing returns boolean
    if ( not ( udg_IntSeconds < 10 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Counter_Func004C takes nothing returns boolean
    if ( not ( udg_IntMinutes < 10 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Counter_Actions takes nothing returns nothing
    set udg_IntSeconds=( udg_IntSeconds + 1 )
    if ( Trig_Counter_Func002C() ) then
        set udg_IntSeconds=0
        set udg_IntMinutes=( udg_IntMinutes + 1 )
        if ( Trig_Counter_Func002Func003C() ) then
            set udg_IntMinutes=0
            set udg_IntHours=( udg_IntHours + 1 )
        else
        endif
    else
    endif
    if ( Trig_Counter_Func003C() ) then
        set udg_StringSeconds="0"
    else
        set udg_StringSeconds=""
    endif
    if ( Trig_Counter_Func004C() ) then
        set udg_StringMinutes="0"
    else
        set udg_StringMinutes=""
    endif
    set udg_Counterstring=( ( ( "|cffe6cd00" + ( I2S(udg_IntHours) + ":" ) ) + ( ( udg_StringMinutes + I2S(udg_IntMinutes) ) + ":" ) ) + ( ( udg_StringSeconds + I2S(udg_IntSeconds) ) + "|r" ) )
    call CreateMultiboardBJ(1, 1, ( ( "Information  -  " + ( "|cffcdcd00[|r " + ( ( udg_TreeChopper + " " ) + ( udg_Tradeoff + "|cffcdcd00 ]  -  |r" ) ) ) ) + udg_Counterstring ))
endfunction

//===========================================================================
function InitTrig_Counter takes nothing returns nothing
    set gg_trg_Counter=CreateTrigger()
    call DisableTrigger(gg_trg_Counter)
    call TriggerRegisterTimerEventPeriodic(gg_trg_Counter, 1.00)
    call TriggerAddAction(gg_trg_Counter, function Trig_Counter_Actions)
endfunction

//===========================================================================
// Trigger: Tradeoff Detection
//
// Can always be put inside of the original trigger file, it is inside of here for clarity.
//===========================================================================
function Trig_Tradeoff_Detection_Actions takes nothing returns nothing
    set udg_Tradeoff="|cffb79419-tradeoff|r"
endfunction

//===========================================================================
function InitTrig_Tradeoff_Detection takes nothing returns nothing
    set gg_trg_Tradeoff_Detection=CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_Tradeoff_Detection, Player(6), "-tradeoff", true)
    call TriggerAddAction(gg_trg_Tradeoff_Detection, function Trig_Tradeoff_Detection_Actions)
endfunction

//===========================================================================
// Trigger: TreeChopper Detection
//
// Yet to be used.  TRIAL TEST FOR NOW - 29th april
//===========================================================================
function Trig_TreeChopper_Detection_Actions takes nothing returns nothing
    call CreateNUnitsAtLoc(1, 'h060', Player(6), GetRectCenter(gg_rct_ChopChop), bj_UNIT_FACING)
    set udg_TreeChopper="|cffb79419-chopoff|r"
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_5530")
endfunction

//===========================================================================
function InitTrig_TreeChopper_Detection takes nothing returns nothing
    set gg_trg_TreeChopper_Detection=CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_TreeChopper_Detection, Player(0), "-chopchop", true)
    call TriggerAddAction(gg_trg_TreeChopper_Detection, function Trig_TreeChopper_Detection_Actions)
endfunction

//===========================================================================
// Trigger: Takeover
//===========================================================================
function Trig_Takeover_MaxPlayerSlots takes nothing returns integer
    return 11
endfunction

function Trig_Takeover_AncientHasController takes player ancient returns boolean
    if ancient == null then
        return false
    endif

    if GetPlayerSlotState(ancient) != PLAYER_SLOT_STATE_PLAYING then
        return false
    endif

    if GetPlayerController(ancient) == MAP_CONTROL_USER then
        return true
    endif

    if GetPlayerController(ancient) == MAP_CONTROL_COMPUTER then
        return true
    endif

    return false
endfunction

function Trig_Takeover_RemoveAllUnitsOfPlayer takes player whichPlayer returns nothing
    local group g= CreateGroup()
    local unit u

    call GroupEnumUnitsOfPlayer(g, whichPlayer, null)

    loop
        set u=FirstOfGroup(g)
        exitwhen u == null
        call GroupRemoveUnit(g, u)
        call RemoveUnit(u)
    endloop

    call DestroyGroup(g)
    set u=null
    set g=null
endfunction

function Trig_Takeover_TransferAllUnits takes player oldOwner,player newOwner returns nothing
    local group g= CreateGroup()
    local unit u

    call GroupEnumUnitsOfPlayer(g, oldOwner, null)

    loop
        set u=FirstOfGroup(g)
        exitwhen u == null
        call GroupRemoveUnit(g, u)
        call SetUnitOwner(u, newOwner, true)
    endloop

    call DestroyGroup(g)
    set u=null
    set g=null
endfunction

function Trig_Takeover_SetAllianceBothWays takes player a,player b,boolean allied returns nothing
    call SetPlayerAlliance(a, b, ALLIANCE_PASSIVE, allied)
    call SetPlayerAlliance(b, a, ALLIANCE_PASSIVE, allied)
    call SetPlayerAlliance(a, b, ALLIANCE_HELP_REQUEST, allied)
    call SetPlayerAlliance(b, a, ALLIANCE_HELP_REQUEST, allied)
    call SetPlayerAlliance(a, b, ALLIANCE_HELP_RESPONSE, allied)
    call SetPlayerAlliance(b, a, ALLIANCE_HELP_RESPONSE, allied)
    call SetPlayerAlliance(a, b, ALLIANCE_SHARED_XP, allied)
    call SetPlayerAlliance(b, a, ALLIANCE_SHARED_XP, allied)
    call SetPlayerAlliance(a, b, ALLIANCE_SHARED_SPELLS, allied)
    call SetPlayerAlliance(b, a, ALLIANCE_SHARED_SPELLS, allied)
    call SetPlayerAlliance(a, b, ALLIANCE_SHARED_VISION, allied)
    call SetPlayerAlliance(b, a, ALLIANCE_SHARED_VISION, allied)
    call SetPlayerAlliance(a, b, ALLIANCE_SHARED_CONTROL, false)
    call SetPlayerAlliance(b, a, ALLIANCE_SHARED_CONTROL, false)
    call SetPlayerAlliance(a, b, ALLIANCE_SHARED_ADVANCED_CONTROL, false)
    call SetPlayerAlliance(b, a, ALLIANCE_SHARED_ADVANCED_CONTROL, false)
    call SetPlayerAlliance(a, b, ALLIANCE_RESCUABLE, false)
    call SetPlayerAlliance(b, a, ALLIANCE_RESCUABLE, false)
    call SetPlayerAlliance(a, b, ALLIANCE_SHARED_VISION_FORCED, false)
    call SetPlayerAlliance(b, a, ALLIANCE_SHARED_VISION_FORCED, false)
endfunction

function Trig_Takeover_InvertTakerAlliances takes player taker returns nothing
    local integer i= 0
    local player p
    local boolean wasAlly

    loop
        exitwhen i >= (11) // INLINED!!
        set p=Player(i)

        if p != taker then
            set wasAlly=GetPlayerAlliance(taker, p, ALLIANCE_PASSIVE)

            if wasAlly then
                call Trig_Takeover_SetAllianceBothWays(taker , p , false)
            else
                call Trig_Takeover_SetAllianceBothWays(taker , p , true)
            endif
        endif

        set i=i + 1
    endloop

    set p=null
endfunction

function Trig_Takeover_ShouldInvertAlliances takes player oldAncient,player taker returns boolean
    if GetPlayerAlliance(taker, oldAncient, ALLIANCE_PASSIVE) then
        return false
    endif

    if GetPlayerAlliance(oldAncient, taker, ALLIANCE_PASSIVE) then
        return false
    endif

    return true
endfunction

function Trig_Takeover_CopyAncientResources takes player oldAncient,player newAncient returns nothing
    call SetPlayerState(newAncient, PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(oldAncient, PLAYER_STATE_RESOURCE_GOLD))
    call SetPlayerState(newAncient, PLAYER_STATE_RESOURCE_LUMBER, GetPlayerState(oldAncient, PLAYER_STATE_RESOURCE_LUMBER))
endfunction

function Trig_Takeover_Actions takes nothing returns nothing
    local player taker= GetTriggerPlayer()
    local player oldAncient= udg_AncientPlayer

    if oldAncient == null then
        call DisplayTextToPlayer(taker, 0.00, 0.00, "|cffff2020Takeover failed: AncientPlayer is not set.|r")
        set taker=null
        set oldAncient=null
        return
    endif

    if Trig_Takeover_AncientHasController(oldAncient) then
        call DisplayTextToPlayer(taker, 0.00, 0.00, "|cffff2020Takeover failed: Ancient still has an active player or AI controller.|r")
        set taker=null
        set oldAncient=null
        return
    endif

    call Trig_Takeover_RemoveAllUnitsOfPlayer(taker)
    call Trig_Takeover_CopyAncientResources(oldAncient , taker)

    if Trig_Takeover_ShouldInvertAlliances(oldAncient , taker) then
        call Trig_Takeover_InvertTakerAlliances(taker)
    endif

    set udg_AncientPlayer=taker

    call Trig_Takeover_TransferAllUnits(oldAncient , taker)
    call DisplayTimedTextToForce(GetPlayersAll(), 20.00, "|cffffcc00" + GetPlayerName(taker) + " has taken over Ancient because the previous Ancient has no active controller.|r")

    set taker=null
    set oldAncient=null
endfunction

//===========================================================================
function InitTrig_Takeover takes nothing returns nothing
    local integer i= 0

    set gg_trg_Takeover=CreateTrigger()

    loop
        exitwhen i >= (11) // INLINED!!
        call TriggerRegisterPlayerChatEvent(gg_trg_Takeover, Player(i), "-takeover", true)
        set i=i + 1
    endloop

    call TriggerAddAction(gg_trg_Takeover, function Trig_Takeover_Actions)
endfunction
//===========================================================================
// Trigger: Enable Overdrive
//
// Additionally, Ancient receives +1 lumber to use for an upgrade.
//===========================================================================
function Trig_Enable_Overdrive_Func004C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetSpellAbilityUnit()) == 'n011' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Enable_Overdrive_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A0CY' ) ) then
        return false
    endif
    if ( not Trig_Enable_Overdrive_Func004C() ) then
        return false
    endif
    return true
endfunction

function Trig_Enable_Overdrive_Actions takes nothing returns nothing
    call SetPlayerTechResearchedSwap('R06X', 1, GetOwningPlayer(GetSpellAbilityUnit()))
    call AdjustPlayerStateBJ(10000, GetOwningPlayer(GetSpellAbilityUnit()), PLAYER_STATE_RESOURCE_LUMBER)
endfunction

//===========================================================================
function InitTrig_Enable_Overdrive takes nothing returns nothing
    set gg_trg_Enable_Overdrive=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Enable_Overdrive, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Enable_Overdrive, Condition(function Trig_Enable_Overdrive_Conditions))
    call TriggerAddAction(gg_trg_Enable_Overdrive, function Trig_Enable_Overdrive_Actions)
endfunction

//===========================================================================
// Trigger: Disable Overdrive
//===========================================================================
function Trig_Disable_Overdrive_Func003C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetSpellAbilityUnit()) == 'n011' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Disable_Overdrive_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A0CZ' ) ) then
        return false
    endif
    if ( not Trig_Disable_Overdrive_Func003C() ) then
        return false
    endif
    return true
endfunction

function Trig_Disable_Overdrive_Actions takes nothing returns nothing
    call SetPlayerTechResearchedSwap('R06X', 0, GetOwningPlayer(GetSpellAbilityUnit()))
endfunction

//===========================================================================
function InitTrig_Disable_Overdrive takes nothing returns nothing
    set gg_trg_Disable_Overdrive=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Disable_Overdrive, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(gg_trg_Disable_Overdrive, Condition(function Trig_Disable_Overdrive_Conditions))
    call TriggerAddAction(gg_trg_Disable_Overdrive, function Trig_Disable_Overdrive_Actions)
endfunction

//===========================================================================
// Trigger: Death
//===========================================================================
function Trig_Death_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetDyingUnit()) == 'n011' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Death_Actions takes nothing returns nothing
    call SetPlayerTechResearchedSwap('R06X', 0, GetOwningPlayer(GetDyingUnit()))
endfunction

//===========================================================================
function InitTrig_Death takes nothing returns nothing
    set gg_trg_Death=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Death, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Death, Condition(function Trig_Death_Conditions))
    call TriggerAddAction(gg_trg_Death, function Trig_Death_Actions)
endfunction

//===========================================================================
// Trigger: Hardmode
//===========================================================================

function Hardmode_GiveResources takes nothing returns nothing
    local integer i= 0
    local player p

    if udg_AncientPlayer == null then
        return
    endif

    loop
        exitwhen i >= bj_MAX_PLAYERS
        set p=Player(i)

        if GetPlayerSlotState(p) == PLAYER_SLOT_STATE_PLAYING and IsPlayerEnemy(p, udg_AncientPlayer) then
            call SetPlayerState(p, PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(p, PLAYER_STATE_RESOURCE_GOLD) + 1)
            call SetPlayerState(p, PLAYER_STATE_RESOURCE_LUMBER, GetPlayerState(p, PLAYER_STATE_RESOURCE_LUMBER) + 50)
        endif

        set i=i + 1
    endloop

    set p=null
endfunction

function Hardmode_PlayActivationIndicator takes nothing returns nothing
    call DisplayTimedTextToPlayer(GetLocalPlayer(), 0.00, 0.00, 10.00, "|cffffcc00Ancient activated hardmode.|r Expanders will now receive extra |cff80ff8050 lumber|r and |cffffff001 gold|r every 6 seconds after ancient spawn.")

    if udg_HardmodeSound != null then
        call SetSoundVolume(udg_HardmodeSound, 127)
        call StartSound(udg_HardmodeSound)
    endif
endfunction

function Hardmode_Start takes nothing returns nothing
    local timer t= GetExpiredTimer()

    set udg_HardmodeCanBeEnabled=false

    call PauseTimer(t)
    call DestroyTimer(t)

    if udg_HardmodeEnabled then
        call Hardmode_GiveResources()

        set udg_HardmodePeriodicTimer=CreateTimer()
        call TimerStart(udg_HardmodePeriodicTimer, 6.00, true, function Hardmode_GiveResources)
    endif

    set t=null
endfunction

function Hardmode_Chat takes nothing returns nothing
    if udg_HardmodeCanBeEnabled and GetTriggerPlayer() == udg_AncientPlayer then
        if not udg_HardmodeEnabled then
            set udg_HardmodeEnabled=true
            call Hardmode_PlayActivationIndicator()
        endif
    endif
endfunction

function InitTrig_Hardmode takes nothing returns nothing
    local integer i= 0
    local trigger t= CreateTrigger()
    local timer tm= CreateTimer()

    loop
        exitwhen i >= bj_MAX_PLAYERS
        call TriggerRegisterPlayerChatEvent(t, Player(i), "-hardmode", true)
        set i=i + 1
    endloop

    call TriggerAddAction(t, function Hardmode_Chat)

    set udg_HardmodeSound=CreateSound(HARDMODE_SOUND_PATH, false, false, false, 10, 10, "HeroAcksEAX")
    call SetSoundVolume(udg_HardmodeSound, 127)

    call TimerStart(tm, 60.00, false, function Hardmode_Start)

    set t=null
    set tm=null
endfunction
//===========================================================================
// Trigger: Categorization
//===========================================================================
function Trig_Categorization_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetSellingUnit()) == 'nmr2' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Categorization_Actions takes nothing returns nothing
    set udg_AncientUnit=GetSoldUnit()
    call PlaySoundBJ(gg_snd_VarimathrasYes1)
endfunction

//===========================================================================
function InitTrig_Categorization takes nothing returns nothing
    set gg_trg_Categorization=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Categorization, EVENT_PLAYER_UNIT_SELL)
    call TriggerAddCondition(gg_trg_Categorization, Condition(function Trig_Categorization_Conditions))
    call TriggerAddAction(gg_trg_Categorization, function Trig_Categorization_Actions)
endfunction

//===========================================================================
// Trigger: Fountain Heal
//===========================================================================
function Trig_Fountain_Heal_Func001Func001Func001C takes nothing returns boolean
    if ( not ( IsUnitType(GetEnumUnit(), UNIT_TYPE_STRUCTURE) == false ) ) then
        return false
    endif
    if ( not ( IsUnitAlly(GetEnumUnit(), udg_AncientPlayer) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Fountain_Heal_Func001Func001A takes nothing returns nothing
    if ( Trig_Fountain_Heal_Func001Func001Func001C() ) then
        call SetUnitLifePercentBJ(GetEnumUnit(), ( GetUnitLifePercent(GetEnumUnit()) + ( GetUnitLifePercent(GetEnumUnit()) * 0.25 ) ))
        call SetUnitManaPercentBJ(GetEnumUnit(), ( GetUnitManaPercent(GetEnumUnit()) + ( GetUnitManaPercent(GetEnumUnit()) * 0.25 ) ))
        set udg_TSEAttachPoint="overhead"
        set udg_TSEEffectName="Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl"
        set udg_TSETargetUnit=GetEnumUnit()
        call ConditionalTriggerExecute(udg_TSE_RegisterTrigger)
    else
    endif
endfunction

function Trig_Fountain_Heal_Func001C takes nothing returns boolean
    if ( not ( udg_AncientInCombat == 0.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Fountain_Heal_Actions takes nothing returns nothing
    if ( Trig_Fountain_Heal_Func001C() ) then
        call ForGroupBJ(GetUnitsInRectAll(gg_rct_Fountain), function Trig_Fountain_Heal_Func001Func001A)
    else
        set udg_AncientInCombat=0.00
    endif
endfunction

//===========================================================================
function InitTrig_Fountain_Heal takes nothing returns nothing
    set gg_trg_Fountain_Heal=CreateTrigger()
    call TriggerRegisterTimerEventPeriodic(gg_trg_Fountain_Heal, 4.00)
    call TriggerAddAction(gg_trg_Fountain_Heal, function Trig_Fountain_Heal_Actions)
endfunction

//===========================================================================
// Trigger: Ancient In Combat
//===========================================================================
function Trig_Ancient_In_Combat_Conditions takes nothing returns boolean
    if ( not ( udg_DamageEventAmount >= 100.00 ) ) then
        return false
    endif
    if ( not ( udg_DamageEventTarget == udg_AncientUnit ) ) then
        return false
    endif
    return true
endfunction

function Trig_Ancient_In_Combat_Actions takes nothing returns nothing
    set udg_AncientInCombat=1.00
endfunction

//===========================================================================
function InitTrig_Ancient_In_Combat takes nothing returns nothing
    set gg_trg_Ancient_In_Combat=CreateTrigger()
    call h__TriggerRegisterVariableEvent(gg_trg_Ancient_In_Combat, "udg_DamageModifierEvent", EQUAL, 1.00)
    call TriggerAddCondition(gg_trg_Ancient_In_Combat, Condition(function Trig_Ancient_In_Combat_Conditions))
    call TriggerAddAction(gg_trg_Ancient_In_Combat, function Trig_Ancient_In_Combat_Actions)
endfunction

//===========================================================================
// Trigger: AutoFeedRate
//===========================================================================

function FeedRate_DebugError takes string msg returns nothing
    call DisplayTimedTextToForce(GetPlayersAll(), 20.00, "|cffff0000[FeedRate Debug]|r " + msg)
endfunction

function FeedRate_Clamp takes integer rate returns integer
    if rate < 50 then
        return 50
    endif

    if rate > 100 then
        return 100
    endif

    return rate
endfunction

function FeedRate_FindChar takes string data,string wanted returns integer
    local integer i= 0
    local integer len= StringLength(data)

    loop
        exitwhen i >= len

        if SubString(data, i, i + 1) == wanted then
            return i
        endif

        set i=i + 1
    endloop

    return - 1
endfunction

function FeedRate_ParseRate takes string data returns integer
    local integer len= StringLength(data)
    local integer colonSep= FeedRate_FindChar(data , ":")
    local integer rate= 0

    if colonSep >= 0 then
        set rate=S2I(SubString(data, colonSep + 1, len))
    else
        set rate=S2I(data)
    endif

    if rate <= 0 then
        return 0
    endif

    return FeedRate_Clamp(rate)
endfunction

function FeedRate_IsValidUser takes player p returns boolean
    return GetPlayerController(p) == MAP_CONTROL_USER and GetPlayerSlotState(p) == PLAYER_SLOT_STATE_PLAYING
endfunction

function FeedRate_CountActiveUsers takes nothing returns integer
    local integer i= 0
    local integer count= 0

    loop
        exitwhen i >= FEEDRATE_MAX_PLAYERS

        if FeedRate_IsValidUser(Player(i)) then
            set count=count + 1
        endif

        set i=i + 1
    endloop

    return count
endfunction

function FeedRate_PlayerNameHasBattleTag takes player p returns boolean
    return FeedRate_FindChar(GetPlayerName(p) , "#") >= 0
endfunction

function FeedRate_FindMatchingPlayerByName takes string playerName returns player
    local integer i= 0
    local player p= null

    loop
        exitwhen i >= FEEDRATE_MAX_PLAYERS

        set p=Player(i)

        if FeedRate_IsValidUser(p) and GetPlayerName(p) == playerName then
            return p
        endif

        set i=i + 1
    endloop

    return null
endfunction

function FeedRate_Apply takes player p,integer rate returns nothing
    local integer pid= GetPlayerId(p)

    set rate=FeedRate_Clamp(rate)
    set FeedRate_Loaded[pid]=true
    set udg_ExperienceRate[pid]=I2R(rate)
endfunction

function FeedRate_SaveForPlayer takes player p,integer rate returns nothing
    if GetLocalPlayer() == p then
        if (FeedRate_FindChar(GetPlayerName((p)) , "#") >= 0) then // INLINED!!
            call PreloadGenClear()
            call PreloadGenStart()
            call Preload("\")\ncall BlzSendSyncData(\"" + FEEDRATE_SYNC_PREFIX + "\",\"" + I2S(FeedRate_Clamp(rate)) + "\")\ncall BlzSendSyncData(\"" + FEEDRATE_NAME_SYNC_PREFIX + "\",\"" + GetPlayerName(p) + "\")\n//")
            call PreloadGenEnd(FEEDRATE_FILE_PATH)
        endif
    endif
endfunction

function FeedRate_SelectRate takes player p,integer rate returns nothing
    call FeedRate_Apply(p , rate)
    call FeedRate_SaveForPlayer(p , rate)

    set p=null
endfunction

function FeedRate_ClickYes takes nothing returns nothing
    call FeedRate_SelectRate(GetTriggerPlayer() , 100)
endfunction

function FeedRate_ClickOtherTag takes nothing returns nothing
    call FeedRate_SelectRate(GetTriggerPlayer() , 75)
endfunction

function FeedRate_ClickNo takes nothing returns nothing
    call FeedRate_SelectRate(GetTriggerPlayer() , 50)
endfunction

function FeedRate_OnRateSync takes nothing returns nothing
    local player p= GetTriggerPlayer()
    local integer pid= GetPlayerId(p)
    local integer rate= FeedRate_ParseRate(BlzGetTriggerSyncData())

    if rate > 0 then
        set FeedRate_PendingRateReceived[pid]=true
        set FeedRate_PendingRate[pid]=rate
    endif

    set p=null
endfunction

function FeedRate_OnNameSync takes nothing returns nothing
    local player p= GetTriggerPlayer()
    local integer pid= GetPlayerId(p)

    set FeedRate_PendingNameReceived[pid]=true
    set FeedRate_PendingName[pid]=BlzGetTriggerSyncData()

    set p=null
endfunction

function FeedRate_ProcessPendingLoadForPlayer takes player p returns nothing
    local integer pid= GetPlayerId(p)
    local integer rate= FeedRate_PendingRate[pid]
    local integer finalRate= FeedRate_Clamp(rate + 5)
    local string savedName= FeedRate_PendingName[pid]
    local string currentName= GetPlayerName(p)
    local player target= null
    local integer targetPid= 0

    if not FeedRate_IsValidUser(p) or not FeedRate_PendingRateReceived[pid] or FeedRate_Loaded[pid] then
        set p=null
        return
    endif

    if not FeedRate_PendingNameReceived[pid] then
        call FeedRate_Apply(p , finalRate)
        call FeedRate_SaveForPlayer(p , finalRate)
    elseif savedName == currentName then
        call FeedRate_Apply(p , finalRate)

        if finalRate != rate then
            call FeedRate_SaveForPlayer(p , finalRate)
        endif
    elseif not (FeedRate_FindChar(GetPlayerName((p)) , "#") >= 0) and FeedRate_CountActiveUsers() <= 1 then // INLINED!!
        call FeedRate_DebugError("Player name has no #, treating saved name '" + savedName + "' as singleplayer/offline load. Save rewrite skipped.")
        call FeedRate_Apply(p , finalRate)
    else
        call FeedRate_DebugError("Player names mismatched. Sync sender Player(" + I2S(pid) + ") is '" + currentName + "', but file belongs to '" + savedName + "'. Searching lobby.")

        set target=FeedRate_FindMatchingPlayerByName(savedName)

        if target != null then
            set targetPid=GetPlayerId(target)

            if not FeedRate_Loaded[targetPid] and not FeedRate_PendingRateReceived[targetPid] then
                call FeedRate_Apply(target , finalRate)
            endif
        else
            call FeedRate_DebugError("No active player found with saved file name '" + savedName + "'. Ignoring loaded feedrate.")
        endif
    endif

    set target=null
    set p=null
endfunction

function FeedRate_ProcessPendingLoads takes nothing returns nothing
    local timer t= GetExpiredTimer()
    local integer i= 0

    call DestroyTimer(t)

    loop
        exitwhen i >= FEEDRATE_MAX_PLAYERS

        call FeedRate_ProcessPendingLoadForPlayer(Player(i))

        set i=i + 1
    endloop

    set t=null
endfunction

function FeedRate_TryLoadForPlayer takes integer i returns nothing
    local player p= Player(i)

    if FeedRate_IsValidUser(p) then
        if GetLocalPlayer() == p then
            call Preloader(FEEDRATE_FILE_PATH)
        endif
    endif

    set p=null
endfunction

function FeedRate_StartLoadAll takes nothing returns nothing
    local timer t= GetExpiredTimer()
    local integer i= 0

    call DestroyTimer(t)

    loop
        exitwhen i >= FEEDRATE_MAX_PLAYERS

        set FeedRate_Loaded[i]=false
        set FeedRate_PendingRateReceived[i]=false
        set FeedRate_PendingRate[i]=0
        set FeedRate_PendingNameReceived[i]=false
        set FeedRate_PendingName[i]=""

        call FeedRate_TryLoadForPlayer(i)

        set i=i + 1
    endloop

    set t=null
endfunction

function FeedRate_ShowDialogsForMissingLoads takes nothing returns nothing
    local timer t= GetExpiredTimer()
    local integer i= 0

    call DestroyTimer(t)

    loop
        exitwhen i >= FEEDRATE_MAX_PLAYERS

        if FeedRate_IsValidUser(Player(i)) and not FeedRate_Loaded[i] then
            call DialogDisplayBJ(true, udg_StartupDialog, Player(i))
        endif

        set i=i + 1
    endloop

    set t=null
endfunction

function FeedRate_SetupDialog takes nothing returns nothing
    call DialogClearBJ(udg_StartupDialog)
    call DialogSetMessageBJ(udg_StartupDialog, "Did you play this map before?")

    set FeedRate_ButtonYes=DialogAddButtonBJ(udg_StartupDialog, "Yes")
    set FeedRate_ButtonOtherTag=DialogAddButtonBJ(udg_StartupDialog, "I played other tag maps")
    set FeedRate_ButtonNo=DialogAddButtonBJ(udg_StartupDialog, "No / Not Sure")

    set FeedRate_YesTrigger=CreateTrigger()
    set FeedRate_OtherTagTrigger=CreateTrigger()
    set FeedRate_NoTrigger=CreateTrigger()

    call TriggerRegisterDialogButtonEvent(FeedRate_YesTrigger, FeedRate_ButtonYes)
    call TriggerRegisterDialogButtonEvent(FeedRate_OtherTagTrigger, FeedRate_ButtonOtherTag)
    call TriggerRegisterDialogButtonEvent(FeedRate_NoTrigger, FeedRate_ButtonNo)

    call TriggerAddAction(FeedRate_YesTrigger, function FeedRate_ClickYes)
    call TriggerAddAction(FeedRate_OtherTagTrigger, function FeedRate_ClickOtherTag)
    call TriggerAddAction(FeedRate_NoTrigger, function FeedRate_ClickNo)
endfunction

function Trig_AutoFeedRate_Actions takes nothing returns nothing
    local integer i= 0
    local timer loadTimer= CreateTimer()
    local timer processTimer= CreateTimer()
    local timer dialogTimer= CreateTimer()

    call FeedRate_SetupDialog()

    set FeedRate_SyncTrigger=CreateTrigger()
    set FeedRate_NameSyncTrigger=CreateTrigger()

    call TriggerAddAction(FeedRate_SyncTrigger, function FeedRate_OnRateSync)
    call TriggerAddAction(FeedRate_NameSyncTrigger, function FeedRate_OnNameSync)

    loop
        exitwhen i >= FEEDRATE_MAX_PLAYERS

        call BlzTriggerRegisterPlayerSyncEvent(FeedRate_SyncTrigger, Player(i), FEEDRATE_SYNC_PREFIX, false)
        call BlzTriggerRegisterPlayerSyncEvent(FeedRate_NameSyncTrigger, Player(i), FEEDRATE_NAME_SYNC_PREFIX, false)

        set i=i + 1
    endloop

    call TimerStart(loadTimer, 0.10, false, function FeedRate_StartLoadAll)
    call TimerStart(processTimer, 1.00, false, function FeedRate_ProcessPendingLoads)
    call TimerStart(dialogTimer, 1.50, false, function FeedRate_ShowDialogsForMissingLoads)

    set loadTimer=null
    set processTimer=null
    set dialogTimer=null
endfunction

//===========================================================================
function InitTrig_AutoFeedRate takes nothing returns nothing
    set gg_trg_AutoFeedRate=CreateTrigger()
    call TriggerRegisterTimerEventSingle(gg_trg_AutoFeedRate, 0.01)
    call TriggerAddAction(gg_trg_AutoFeedRate, function Trig_AutoFeedRate_Actions)
endfunction
//===========================================================================
// Trigger: TimeToAncientSpawn Copy
//===========================================================================
function Trig_TimeToAncientSpawn_Copy_Actions takes nothing returns nothing
    call DisableTrigger(gg_trg_SetFeed)
endfunction

//===========================================================================
function InitTrig_TimeToAncientSpawn_Copy takes nothing returns nothing
    set gg_trg_TimeToAncientSpawn_Copy=CreateTrigger()
    call TriggerRegisterTimerEventSingle(gg_trg_TimeToAncientSpawn_Copy, 60.00)
    call TriggerAddAction(gg_trg_TimeToAncientSpawn_Copy, function Trig_TimeToAncientSpawn_Copy_Actions)
endfunction

//===========================================================================
// Trigger: HandleSetRate
//===========================================================================
function SetFeedIsDigit takes string char returns boolean
    local string digits= "0123456789"
    local integer i= 0

    loop
        exitwhen i >= 10
        if char == SubString(digits, i, i + 1) then
            return true
        endif
        set i=i + 1
    endloop

    return false
endfunction

function SetFeedClampRate takes real rate returns real
    if rate < 50.00 then
        return 50.00
    endif
    if rate > 200.00 then
        return 200.00
    endif
    return rate
endfunction

function SetFeedErrorRateOutOfRange takes player whichPlayer,string value returns nothing
    call DisplayTextToPlayer(whichPlayer, 0, 0, "Error: Feedrate " + value + " is outside allowed range. Use 50 to 200.")
endfunction

function SetFeedErrorCannotFindPlayer takes player whichPlayer,string playerName returns nothing
    call DisplayTextToPlayer(whichPlayer, 0, 0, "Error: Cannot find player called " + playerName)
endfunction

function SetFeedTrimLeft takes string s returns string
    local integer i= 0
    local integer len= StringLength(s)

    loop
        exitwhen i >= len or SubString(s, i, i + 1) != " "
        set i=i + 1
    endloop

    return SubString(s, i, len)
endfunction

function SetFeedFirstToken takes string s returns string
    local integer i= 0
    local integer len= StringLength(s)

    loop
        exitwhen i >= len or SubString(s, i, i + 1) == " "
        set i=i + 1
    endloop

    return SubString(s, 0, i)
endfunction

function SetFeedRestAfterFirstToken takes string s returns string
    local integer i= 0
    local integer len= StringLength(s)

    loop
        exitwhen i >= len or SubString(s, i, i + 1) == " "
        set i=i + 1
    endloop

    loop
        exitwhen i >= len or SubString(s, i, i + 1) != " "
        set i=i + 1
    endloop

    return SubString(s, i, len)
endfunction

function SetFeedIsUnsignedInteger takes string s returns boolean
    local integer i= 0
    local integer len= StringLength(s)

    if len <= 0 then
        return false
    endif

    loop
        exitwhen i >= len
        if not SetFeedIsDigit(SubString(s, i, i + 1)) then
            return false
        endif
        set i=i + 1
    endloop

    return true
endfunction

function SetFeedIsUnsignedReal takes string s returns boolean
    local integer i= 0
    local integer len= StringLength(s)
    local integer dotCount= 0
    local integer digitCount= 0
    local string c

    if len <= 0 then
        return false
    endif

    loop
        exitwhen i >= len
        set c=SubString(s, i, i + 1)

        if SetFeedIsDigit(c) then
            set digitCount=digitCount + 1
        elseif c == "." then
            set dotCount=dotCount + 1
            if dotCount > 1 then
                return false
            endif
        else
            return false
        endif

        set i=i + 1
    endloop

    return digitCount > 0
endfunction

function SetFeedPercentToMultiplierText takes integer percent returns string
    local integer whole= percent / 100
    local integer frac= percent - whole * 100

    if frac == 0 then
        return I2S(whole)
    endif

    if ModuloInteger(frac, 10) == 0 then
        return I2S(whole) + "." + I2S(frac / 10)
    endif

    if frac < 10 then
        return I2S(whole) + ".0" + I2S(frac)
    endif

    return I2S(whole) + "." + I2S(frac)
endfunction

function SetFeedColorToPlayerNumber takes string token returns integer
    local string c= StringCase(token, false)

    if c == "red" then
        return 1
    endif
    if c == "blue" then
        return 2
    endif
    if c == "teal" then
        return 3
    endif
    if c == "purple" then
        return 4
    endif
    if c == "yellow" then
        return 5
    endif
    if c == "orange" then
        return 6
    endif
    if c == "green" then
        return 7
    endif
    if c == "pink" then
        return 8
    endif
    if c == "gray" or c == "grey" then
        return 9
    endif
    if c == "lightblue" or c == "light-blue" or c == "light_blue" then
        return 10
    endif
    if c == "darkgreen" or c == "dark-green" or c == "dark_green" then
        return 11
    endif

    return 0
endfunction

function SetFeedTwoWordColorToPlayerNumber takes string token1,string token2 returns integer
    local string c1= StringCase(token1, false)
    local string c2= StringCase(token2, false)

    if c1 == "light" and c2 == "blue" then
        return 10
    endif

    if c1 == "dark" and c2 == "green" then
        return 11
    endif

    return 0
endfunction

function SetFeedSetAll takes integer rate returns nothing
    local integer i= 0

    loop
        exitwhen i >= 11
        set udg_ExperienceRate[i]=I2R(rate)
        set i=i + 1
    endloop
endfunction

function HandleSetExp takes player triggerPlayer,string message returns nothing
    local string trimmed= SetFeedTrimLeft(SubString(message, 8, StringLength(message)))
    local string token1= SetFeedFirstToken(trimmed)
    local string rest= SetFeedRestAfterFirstToken(trimmed)
    local string token2= ""
    local string extra= ""
    local string multText= ""
    local string playerNameForError= ""
    local integer playerNumber= 0
    local integer twoWordColorNumber= 0
    local integer y= 0
    local integer i= 0
    local integer suggestedPercent= 0
    local real oldRate= 0.00
    local real multiplier= 0.00
    local real singleReal= 0.00

    if token1 == "" then
        call DisplayTextToPlayer(triggerPlayer, 0, 0, "Failed to set feedrate")
        return
    endif

    if rest == "" and StringLength(token1) > 1 and SubString(token1, 0, 1) == "x" then
        set multText=SubString(token1, 1, StringLength(token1))

        if not SetFeedIsUnsignedReal(multText) then
            call DisplayTextToPlayer(triggerPlayer, 0, 0, "Failed to set feedrate")
            return
        endif

        set multiplier=S2R(multText)

        if multiplier <= 0.00 then
            call DisplayTextToPlayer(triggerPlayer, 0, 0, "Failed to set feedrate")
            return
        endif

        if multiplier >= 50.00 and multiplier <= 200.00 and multiplier == I2R(R2I(multiplier)) then
            set suggestedPercent=R2I(multiplier)
            call DisplayTextToPlayer(triggerPlayer, 0, 0, "Error: Did you mean -setfeed x" + SetFeedPercentToMultiplierText(suggestedPercent) + "? (multiplies every feedrate by " + SetFeedPercentToMultiplierText(suggestedPercent) + ") or did you mean to do -setfeed " + I2S(suggestedPercent) + " (sets everyone's feedrate to " + I2S(suggestedPercent) + "%)")
            return
        endif

        set i=0
        loop
            exitwhen i >= 11
            set oldRate=udg_ExperienceRate[i]
            if oldRate < 50.00 or oldRate > 200.00 then
                set oldRate=100.00
            endif
            set udg_ExperienceRate[i]=SetFeedClampRate(I2R(R2I(oldRate * multiplier + 0.50)))
            set i=i + 1
        endloop

        call DisplayTextToPlayer(triggerPlayer, 0, 0, "Every feedrate was multiplied by " + multText + ". Final values are limited to 50%-200%.")
        return
    endif

    if rest == "" then
        if SetFeedIsUnsignedInteger(token1) then
            set y=S2I(token1)

            if y < 50 or y > 200 then
                call DisplayTextToPlayer((triggerPlayer ), 0, 0, "Error: Feedrate " + ( token1) + " is outside allowed range. Use 50 to 200.") // INLINED!!
                return
            endif

            call SetFeedSetAll(y)
            call DisplayTextToPlayer(triggerPlayer, 0, 0, "Feedrate of every player is set to " + I2S(y) + "%")
            return
        endif

        if SetFeedIsUnsignedReal(token1) then
            set singleReal=S2R(token1)

            if singleReal >= 0.50 and singleReal <= 2.00 then
                set suggestedPercent=R2I(singleReal * 100.00 + 0.50)
                call DisplayTextToPlayer(triggerPlayer, 0, 0, "Error: Did you mean -setfeed x" + token1 + "? (multiplies every feedrate by " + token1 + ") or did you mean to -setfeed " + I2S(suggestedPercent) + " (sets everyone's feedrate to " + I2S(suggestedPercent) + "%).")
                return
            endif
        endif

        call DisplayTextToPlayer(triggerPlayer, 0, 0, "Failed to set feedrate")
        return
    endif

    set token2=SetFeedFirstToken(rest)
    set extra=SetFeedRestAfterFirstToken(rest)
    set playerNameForError=token1

    if SetFeedIsUnsignedInteger(token1) then
        set playerNumber=S2I(token1)
    else
        set playerNumber=SetFeedColorToPlayerNumber(token1)

        if playerNumber == 0 then
            set twoWordColorNumber=SetFeedTwoWordColorToPlayerNumber(token1 , token2)

            if twoWordColorNumber > 0 then
                set playerNumber=twoWordColorNumber
                set playerNameForError=token1 + " " + token2
                set token2=SetFeedFirstToken(extra)
                set extra=SetFeedRestAfterFirstToken(extra)
            elseif extra != "" and SetFeedIsUnsignedInteger(extra) and not SetFeedIsUnsignedInteger(token2) then
                set playerNameForError=token1 + " " + token2
                set token2=extra
                set extra=""
            endif
        endif
    endif

    if token2 == "" then
        call DisplayTextToPlayer(triggerPlayer, 0, 0, "Error: Missing feedrate value.")
        return
    endif

    if extra != "" then
        call DisplayTextToPlayer(triggerPlayer, 0, 0, "Error: Too many arguments for -setfeed.")
        return
    endif

    if not SetFeedIsUnsignedInteger(token2) then
        if playerNumber == 0 and not SetFeedIsUnsignedInteger(token1) then
            call DisplayTextToPlayer((triggerPlayer ), 0, 0, "Error: Cannot find player called " + ( playerNameForError)) // INLINED!!
            return
        endif

        call DisplayTextToPlayer(triggerPlayer, 0, 0, "Error: Feedrate must be a whole number from 50 to 200.")
        return
    endif

    set y=S2I(token2)

    if playerNumber == 0 and not SetFeedIsUnsignedInteger(token1) then
        call DisplayTextToPlayer((triggerPlayer ), 0, 0, "Error: Cannot find player called " + ( playerNameForError)) // INLINED!!
        return
    endif

    if y < 50 or y > 200 then
        call DisplayTextToPlayer((triggerPlayer ), 0, 0, "Error: Feedrate " + ( token2) + " is outside allowed range. Use 50 to 200.") // INLINED!!
        return
    endif

    if playerNumber < 1 or playerNumber > 11 then
        call DisplayTextToPlayer(triggerPlayer, 0, 0, "Error: Player number must be between 1 and 11.")
        return
    endif

    set udg_ExperienceRate[playerNumber - 1]=I2R(y)
    call DisplayTextToPlayer(triggerPlayer, 0, 0, "Feedrate of player " + I2S(playerNumber) + " is set to " + I2S(y) + "%")
endfunction
//===========================================================================
// Trigger: FeedReduction
//===========================================================================
function FR_ScaledInt takes integer value,real percent returns integer
    if value <= 0 or percent <= 0.00 then
        return 0
    endif
    return R2I(I2R(value) * percent * 0.01 + 0.50)
endfunction

function FR_ApplyGoldBountyRate takes unit target,real percent returns nothing
    local integer base= BlzGetUnitIntegerField(target, UNIT_IF_GOLD_BOUNTY_AWARDED_BASE)
    local integer dice= BlzGetUnitIntegerField(target, UNIT_IF_GOLD_BOUNTY_AWARDED_NUMBER_OF_DICE)
    local integer sides= BlzGetUnitIntegerField(target, UNIT_IF_GOLD_BOUNTY_AWARDED_SIDES_PER_DIE)
    local integer newBase= FR_ScaledInt(base , percent)
    local integer newSides= FR_ScaledInt(sides , percent)

    if percent <= 0.00 then
        call BlzSetUnitIntegerField(target, UNIT_IF_GOLD_BOUNTY_AWARDED_BASE, 0)
        call BlzSetUnitIntegerField(target, UNIT_IF_GOLD_BOUNTY_AWARDED_NUMBER_OF_DICE, 0)
        call BlzSetUnitIntegerField(target, UNIT_IF_GOLD_BOUNTY_AWARDED_SIDES_PER_DIE, 0)
    else
        call BlzSetUnitIntegerField(target, UNIT_IF_GOLD_BOUNTY_AWARDED_BASE, newBase)
        call BlzSetUnitIntegerField(target, UNIT_IF_GOLD_BOUNTY_AWARDED_NUMBER_OF_DICE, dice)
        call BlzSetUnitIntegerField(target, UNIT_IF_GOLD_BOUNTY_AWARDED_SIDES_PER_DIE, newSides)
    endif
endfunction

function Trig_FeedReduction_Actions takes nothing returns nothing
    local unit target= udg_DamageEventTarget
    local real rate= udg_ExperienceRate[( GetConvertedPlayerId(GetOwningPlayer(target)) - 1 )]

    call SetPlayerHandicapXPBJ(udg_AncientPlayer, rate)
    call FR_ApplyGoldBountyRate(target , rate)

    set target=null
endfunction

//===========================================================================
function InitTrig_FeedReduction takes nothing returns nothing
    set gg_trg_FeedReduction=CreateTrigger()
    call h__TriggerRegisterVariableEvent(gg_trg_FeedReduction, "udg_LethalDamageEvent", EQUAL, 1.00)
    call TriggerAddAction(gg_trg_FeedReduction, function Trig_FeedReduction_Actions)
endfunction
//===========================================================================
// Trigger: SetFeed
//===========================================================================
function Trig_SetFeed_Actions takes nothing returns nothing
    call HandleSetExp(GetTriggerPlayer() , GetEventPlayerChatString())
endfunction

//===========================================================================
function InitTrig_SetFeed takes nothing returns nothing
    set gg_trg_SetFeed=CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_SetFeed, Player(0), "-setfeed", false)
    call TriggerAddAction(gg_trg_SetFeed, function Trig_SetFeed_Actions)
endfunction

//===========================================================================
// Trigger: CheckFeedRates
//===========================================================================
function Trig_CheckFeedRates_PlayerLabel takes integer i returns string
    if i == 0 then
        return "|cffff0303Player 1|r"
    elseif i == 1 then
        return "|cff0042ffPlayer 2|r"
    elseif i == 2 then
        return "|cff1ce6b9Player 3|r"
    elseif i == 3 then
        return "|cff540081Player 4|r"
    elseif i == 4 then
        return "|cfffffc01Player 5|r"
    elseif i == 5 then
        return "|cffff8a0ePlayer 6|r"
    elseif i == 6 then
        return "|cff20c000Player 7|r"
    elseif i == 7 then
        return "|cffe55bb0Player 8|r"
    elseif i == 8 then
        return "|cff959697Player 9|r"
    elseif i == 9 then
        return "|cff7ebff1Player 10|r"
    elseif i == 10 then
        return "|cff106246Player 11|r"
    endif

    return "Player " + I2S(i + 1)
endfunction

function Trig_CheckFeedRates_Actions takes nothing returns nothing
    local integer i= 0
    local string output= "|cffffcc00Current feed rates:|r"

    loop
        exitwhen i >= 11
        set output=output + "\n" + Trig_CheckFeedRates_PlayerLabel(i) + ": |cffffffff" + I2S(R2I(udg_ExperienceRate[i] + 0.50)) + "%|r"
        set i=i + 1
    endloop

    call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, output)
endfunction

//===========================================================================
function InitTrig_CheckFeedRates takes nothing returns nothing
    local integer i= 0

    set gg_trg_CheckFeedRates=CreateTrigger()

    loop
        exitwhen i >= 11
        call TriggerRegisterPlayerChatEvent(gg_trg_CheckFeedRates, Player(i), "-feedrates", false)
        set i=i + 1
    endloop

    call TriggerAddAction(gg_trg_CheckFeedRates, function Trig_CheckFeedRates_Actions)
endfunction
//===========================================================================
// Trigger: Detonate
//===========================================================================
function Trig_Detonate_Func001001 takes nothing returns boolean
    return ( GetSpellAbilityId() == 'A08G' )
endfunction

function Trig_Detonate_Func001002 takes nothing returns boolean
    return ( GetSpellAbilityId() == 'A0F2' )
endfunction

function Trig_Detonate_Conditions takes nothing returns boolean
    if ( not GetBooleanOr((GetSpellAbilityId() == 'A08G'), (GetSpellAbilityId() == 'A0F2')) ) then // INLINED!!
        return false
    endif
    return true
endfunction

function Trig_Detonate_Actions takes nothing returns nothing
    call KillUnit(GetTriggerUnit())
endfunction

//===========================================================================
function InitTrig_Detonate takes nothing returns nothing
    set gg_trg_Detonate=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Detonate, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Detonate, Condition(function Trig_Detonate_Conditions))
    call TriggerAddAction(gg_trg_Detonate, function Trig_Detonate_Actions)
endfunction

//===========================================================================
// Trigger: Expander Hero XP
//===========================================================================
function Trig_Expander_Hero_XP_Conditions takes nothing returns boolean
    if ( not ( IsUnitType(udg_DamageEventSource, UNIT_TYPE_HERO) == true ) ) then
        return false
    endif
    if ( not ( IsUnitType(udg_DamageEventTarget, UNIT_TYPE_HERO) == true ) ) then
        return false
    endif
    if ( not ( udg_IsDamageAttack == true ) ) then
        return false
    endif
    if ( not ( IsUnitAlly(udg_DamageEventTarget, Player(6)) == true ) ) then
        return false
    endif
    if ( not ( IsUnitEnemy(udg_DamageEventSource, Player(6)) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Expander_Hero_XP_Actions takes nothing returns nothing
    call AddHeroXPSwapped(50, udg_DamageEventSource, true)
endfunction

//===========================================================================
function InitTrig_Expander_Hero_XP takes nothing returns nothing
    set gg_trg_Expander_Hero_XP=CreateTrigger()
    call h__TriggerRegisterVariableEvent(gg_trg_Expander_Hero_XP, "udg_DamageEvent", EQUAL, 1.00)
    call TriggerAddCondition(gg_trg_Expander_Hero_XP, Condition(function Trig_Expander_Hero_XP_Conditions))
    call TriggerAddAction(gg_trg_Expander_Hero_XP, function Trig_Expander_Hero_XP_Actions)
endfunction

//===========================================================================
// Trigger: Snipe Shot
//===========================================================================

function SnipeShot_IsAlive takes unit u returns boolean
    return u != null and GetWidgetLife(u) > 0.405 and not IsUnitType(u, UNIT_TYPE_DEAD)
endfunction

function SnipeShot_IsValidTarget takes unit u,player p returns boolean
    return SnipeShot_IsAlive(u) and IsUnitEnemy(u, p) and not IsUnitType(u, UNIT_TYPE_FLYING)
endfunction

function SnipeShot_StartCooldown takes unit caster returns nothing
    if caster != null then
        call BlzStartUnitAbilityCooldown(caster, SNIPESHOT_ABILITY_ID, SNIPESHOT_COOLDOWN)
    endif
endfunction

function SnipeShot_GetHitTarget takes real x,real y,player p returns unit
    local unit u
    local unit best= null
    local real dx
    local real dy
    local real d2
    local real bestD2= 999999999.00

    call GroupEnumUnitsInRange(SNIPESHOT_Group, x, y, SNIPESHOT_COLLISION, null)

    loop
        set u=FirstOfGroup(SNIPESHOT_Group)
        exitwhen u == null
        call GroupRemoveUnit(SNIPESHOT_Group, u)

        if SnipeShot_IsValidTarget(u , p) then
            set dx=GetUnitX(u) - x
            set dy=GetUnitY(u) - y
            set d2=dx * dx + dy * dy

            if d2 < bestD2 then
                set bestD2=d2
                set best=u
            endif
        endif
    endloop

    set u=null
    return best
endfunction

function SnipeShot_StunTarget takes player p,real x,real y,unit target returns nothing
    local unit dummy= CreateUnit(p, SNIPESHOT_DUMMY_ID, x, y, 0.00)

    call UnitAddAbility(dummy, SNIPESHOT_STUN_ABILITY_ID)
    call SetUnitAbilityLevel(dummy, SNIPESHOT_STUN_ABILITY_ID, 1)
    call IssueTargetOrder(dummy, SNIPESHOT_STUN_ORDER, target)
    call UnitApplyTimedLife(dummy, 'BTLF', 1.00)

    set dummy=null
endfunction

function SnipeShot_EndMissile takes timer t returns nothing
    local integer id= GetHandleId(t)
    local effect fx= LoadEffectHandle(SNIPESHOT_Hash, id, 2)

    if fx != null then
        call DestroyEffect(fx)
    endif

    call FlushChildHashtable(SNIPESHOT_Hash, id)
    call PauseTimer(t)
    call DestroyTimer(t)

    set fx=null
endfunction

function SnipeShot_MissileLoop takes nothing returns nothing
    local timer t= GetExpiredTimer()
    local integer id= GetHandleId(t)
    local unit caster= LoadUnitHandle(SNIPESHOT_Hash, id, 0)
    local player p= LoadPlayerHandle(SNIPESHOT_Hash, id, 1)
    local effect fx= LoadEffectHandle(SNIPESHOT_Hash, id, 2)
    local real x= LoadReal(SNIPESHOT_Hash, id, 3)
    local real y= LoadReal(SNIPESHOT_Hash, id, 4)
    local real dx= LoadReal(SNIPESHOT_Hash, id, 5)
    local real dy= LoadReal(SNIPESHOT_Hash, id, 6)
    local real travelled= LoadReal(SNIPESHOT_Hash, id, 7)
    local real maxDist= LoadReal(SNIPESHOT_Hash, id, 8)
    local real step= SNIPESHOT_SPEED * SNIPESHOT_PERIOD
    local real remaining= maxDist - travelled
    local unit hit
    local real damage

    if caster == null or not SnipeShot_IsAlive(caster) or remaining <= 0.00 then
        call SnipeShot_EndMissile(t)
    else
        if step > remaining then
            set step=remaining
        endif

        set x=x + dx * step
        set y=y + dy * step
        set travelled=travelled + step

        call BlzSetSpecialEffectPosition(fx, x, y, SNIPESHOT_MISSILE_HEIGHT)

        set hit=SnipeShot_GetHitTarget(x , y , p)

        if hit != null then
            set damage=SNIPESHOT_DAMAGE_PER_STEP * travelled / SNIPESHOT_DAMAGE_DISTANCE_STEP
            call UnitDamageTarget(caster, hit, damage, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
            call SnipeShot_StunTarget(p , x , y , hit)
            call SnipeShot_EndMissile(t)
        elseif travelled >= maxDist then
            call SnipeShot_EndMissile(t)
        else
            call SaveReal(SNIPESHOT_Hash, id, 3, x)
            call SaveReal(SNIPESHOT_Hash, id, 4, y)
            call SaveReal(SNIPESHOT_Hash, id, 7, travelled)
        endif
    endif

    set hit=null
    set caster=null
    set p=null
    set fx=null
    set t=null
endfunction

function SnipeShot_StartMissile takes unit caster,real tx,real ty returns nothing
    local timer t= CreateTimer()
    local integer id= GetHandleId(t)
    local player p= GetOwningPlayer(caster)
    local real x= GetUnitX(caster)
    local real y= GetUnitY(caster)
    local real dx= tx - x
    local real dy= ty - y
    local real dist= SquareRoot(dx * dx + dy * dy)
    local real angle
    local effect fx

    if dist <= 1.00 then
        set angle=GetUnitFacing(caster) * bj_DEGTORAD
        set dx=Cos(angle)
        set dy=Sin(angle)
    else
        set dx=dx / dist
        set dy=dy / dist
    endif

    set fx=AddSpecialEffect(SNIPESHOT_MISSILE_MODEL, x, y)
    call BlzSetSpecialEffectPosition(fx, x, y, SNIPESHOT_MISSILE_HEIGHT)
    call BlzSetSpecialEffectYaw(fx, Atan2(dy, dx))

    call SaveUnitHandle(SNIPESHOT_Hash, id, 0, caster)
    call SavePlayerHandle(SNIPESHOT_Hash, id, 1, p)
    call SaveEffectHandle(SNIPESHOT_Hash, id, 2, fx)
    call SaveReal(SNIPESHOT_Hash, id, 3, x)
    call SaveReal(SNIPESHOT_Hash, id, 4, y)
    call SaveReal(SNIPESHOT_Hash, id, 5, dx)
    call SaveReal(SNIPESHOT_Hash, id, 6, dy)
    call SaveReal(SNIPESHOT_Hash, id, 7, 0.00)
    call SaveReal(SNIPESHOT_Hash, id, 8, SNIPESHOT_MAX_RANGE)

    call TimerStart(t, SNIPESHOT_PERIOD, true, function SnipeShot_MissileLoop)

    set fx=null
    set p=null
    set t=null
endfunction

function SnipeShot_OnChannel takes nothing returns nothing
    local unit caster= GetTriggerUnit()
    local integer casterId

    if GetSpellAbilityId() == SNIPESHOT_ABILITY_ID then
        set casterId=GetHandleId(caster)

        call SaveBoolean(SNIPESHOT_Hash, casterId, 100, true)
        call SaveReal(SNIPESHOT_Hash, casterId, 101, GetSpellTargetX())
        call SaveReal(SNIPESHOT_Hash, casterId, 102, GetSpellTargetY())
    endif

    set caster=null
endfunction

function SnipeShot_OnFinish takes nothing returns nothing
    local unit caster= GetTriggerUnit()
    local integer casterId
    local real tx
    local real ty

    if GetSpellAbilityId() == SNIPESHOT_ABILITY_ID then
        set casterId=GetHandleId(caster)

        if LoadBoolean(SNIPESHOT_Hash, casterId, 100) and SnipeShot_IsAlive(caster) then
            set tx=LoadReal(SNIPESHOT_Hash, casterId, 101)
            set ty=LoadReal(SNIPESHOT_Hash, casterId, 102)

            call FlushChildHashtable(SNIPESHOT_Hash, casterId)
            call SnipeShot_StartCooldown(caster)
            call SetUnitAnimation(caster, "attack")
            call SnipeShot_StartMissile(caster , tx , ty)
        endif
    endif

    set caster=null
endfunction

function InitTrig_Snipe_Shot takes nothing returns nothing
    local trigger channelTrig= CreateTrigger()
    local trigger finishTrig= CreateTrigger()
    local integer i= 0

    loop
        exitwhen i >= bj_MAX_PLAYER_SLOTS
        call TriggerRegisterPlayerUnitEvent(channelTrig, Player(i), EVENT_PLAYER_UNIT_SPELL_CHANNEL, null)
        call TriggerRegisterPlayerUnitEvent(finishTrig, Player(i), EVENT_PLAYER_UNIT_SPELL_FINISH, null)
        set i=i + 1
    endloop

    call TriggerAddAction(channelTrig, function SnipeShot_OnChannel)
    call TriggerAddAction(finishTrig, function SnipeShot_OnFinish)

    set channelTrig=null
    set finishTrig=null
endfunction
//===========================================================================
// Trigger: Dash
//===========================================================================

function Dash_CreateTrail takes unit u returns nothing
    local effect e= AddSpecialEffect(DASH_TRAIL_EFFECT, GetUnitX(u), GetUnitY(u))

    call DestroyEffect(e)

    set e=null
endfunction

function Dash_Stop takes timer t returns nothing
    local integer id= GetHandleId(t)
    local unit u= LoadUnitHandle(DashHash, id, 0)
    local effect e= LoadEffectHandle(DashHash, id, 4)

    if e != null then
        call DestroyEffect(e)
    endif

    if u != null then
        call ResetUnitAnimation(u)
    endif

    call FlushChildHashtable(DashHash, id)
    call PauseTimer(t)
    call DestroyTimer(t)

    set e=null
    set u=null
    set t=null
endfunction

function Dash_TryMove takes unit u,real nx,real ny returns boolean
    local real ox= GetUnitX(u)
    local real oy= GetUnitY(u)
    local real ax
    local real ay

    call SetUnitPosition(u, nx, ny)

    set ax=GetUnitX(u)
    set ay=GetUnitY(u)

    // 25.00 = 5 distance squared tolerance.
    if ( ax - nx ) * ( ax - nx ) + ( ay - ny ) * ( ay - ny ) > 25.00 then
        call SetUnitPosition(u, ox, oy)
        return false
    endif

    return true
endfunction

function Dash_TrySlideStep takes unit u,real angle,real step returns real
    local real x= GetUnitX(u)
    local real y= GetUnitY(u)
    local real nx
    local real ny

    // 1. Try normal forward movement.
    set nx=x + step * Cos(angle)
    set ny=y + step * Sin(angle)

    if Dash_TryMove(u , nx , ny) then
        return step
    endif

    // 2. Try sliding forward-left.
    set nx=x + step * Cos(angle + 0.785398)
    set ny=y + step * Sin(angle + 0.785398)

    if Dash_TryMove(u , nx , ny) then
        return step
    endif

    // 3. Try sliding forward-right.
    set nx=x + step * Cos(angle - 0.785398)
    set ny=y + step * Sin(angle - 0.785398)

    if Dash_TryMove(u , nx , ny) then
        return step
    endif

    // 4. Try pure side-left.
    set nx=x + step * Cos(angle + 1.570796)
    set ny=y + step * Sin(angle + 1.570796)

    if Dash_TryMove(u , nx , ny) then
        return step
    endif

    // 5. Try pure side-right.
    set nx=x + step * Cos(angle - 1.570796)
    set ny=y + step * Sin(angle - 1.570796)

    if Dash_TryMove(u , nx , ny) then
        return step
    endif

    // Fully boxed in.
    return 0.00
endfunction

function Dash_Loop takes nothing returns nothing
    local timer t= GetExpiredTimer()
    local integer id= GetHandleId(t)

    local unit u= LoadUnitHandle(DashHash, id, 0)
    local real angle= LoadReal(DashHash, id, 1)
    local real moved= LoadReal(DashHash, id, 2)
    local real targetRange= LoadReal(DashHash, id, 3)

    local real tickDistance= DASH_SPEED * DASH_PERIOD
    local real subStep= 6.00
    local real moveNow

    if u == null or GetWidgetLife(u) <= 0.405 then
        call Dash_Stop(t)
        set t=null
        set u=null
        return
    endif

    if moved + tickDistance > targetRange then
        set tickDistance=targetRange - moved
    endif

    loop
        exitwhen tickDistance <= 0.00

        if tickDistance < subStep then
            set moveNow=tickDistance
        else
            set moveNow=subStep
        endif

        set moveNow=Dash_TrySlideStep(u , angle , moveNow)

        if moveNow <= 0.00 then
            call Dash_Stop(t)
            set t=null
            set u=null
            return
        endif

        set moved=moved + moveNow

	call SaveReal(DashHash, id, 5, LoadReal(DashHash, id, 5) + moveNow)

    if LoadReal(DashHash, id, 5) >= DASH_TRAIL_INTERVAL then
        call Dash_CreateTrail(u)
        call SaveReal(DashHash, id, 5, 0.00)
    endif

        set tickDistance=tickDistance - moveNow
    endloop

    call SaveReal(DashHash, id, 2, moved)

    if moved >= targetRange then
        call Dash_Stop(t)
    endif

    set t=null
    set u=null
endfunction

function StartDash takes unit u,real tx,real ty returns nothing
    local timer t= CreateTimer()
    local integer id= GetHandleId(t)

    local real ux= GetUnitX(u)
    local real uy= GetUnitY(u)

    local real dx= tx - ux
    local real dy= ty - uy
    local real dist= SquareRoot(dx * dx + dy * dy)
    local real angle
    local effect e

    if dist <= 10.00 then
        call DestroyTimer(t)
        set t=null
        return
    endif

    if dist > DASH_RANGE then
        set dist=DASH_RANGE
    endif

    set angle=Atan2(dy, dx)

    // Unit animation during dash.
    call SetUnitAnimation(u, "walk")

    // Attached visual effect during dash.
    set e=AddSpecialEffectTarget(DASH_ATTACH_EFFECT, u, "origin")

    call SaveUnitHandle(DashHash, id, 0, u)
    call SaveReal(DashHash, id, 1, angle)
    call SaveReal(DashHash, id, 2, 0.00) // distance moved
    call SaveReal(DashHash, id, 3, dist) // target dash distance
    call SaveEffectHandle(DashHash, id, 4, e)
    call SaveReal(DashHash, id, 5, 0.00) // trail distance counter

    call TimerStart(t, DASH_PERIOD, true, function Dash_Loop)

    set e=null
    set t=null
endfunction

function Dash_Condition takes nothing returns boolean
    return GetSpellAbilityId() == 'A0EW' // Replace with your ability rawcode
endfunction

function Dash_Action takes nothing returns nothing
    call StartDash(GetTriggerUnit() , GetSpellTargetX() , GetSpellTargetY())

endfunction

function InitTrig_Dash takes nothing returns nothing
    local trigger trg= CreateTrigger()

    call TriggerRegisterAnyUnitEventBJ(trg, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(trg, Condition(function Dash_Condition))
    call TriggerAddAction(trg, function Dash_Action)

    set trg=null
endfunction
//===========================================================================
// Trigger: Rome
//===========================================================================
function Trig_Rome_Conditions takes nothing returns boolean
    if ( not ( UnitHasBuffBJ(udg_DamageEventTarget, 'B03L') == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Rome_Actions takes nothing returns nothing
    set udg_DamageEventAmount=( udg_DamageEventAmount * 0.60 )
endfunction

//===========================================================================
function InitTrig_Rome takes nothing returns nothing
    set gg_trg_Rome=CreateTrigger()
    call h__TriggerRegisterVariableEvent(gg_trg_Rome, "udg_DamageEvent", EQUAL, 1.00)
    call TriggerAddCondition(gg_trg_Rome, Condition(function Trig_Rome_Conditions))
    call TriggerAddAction(gg_trg_Rome, function Trig_Rome_Actions)
endfunction

//===========================================================================
// Trigger: Basic Bounty Hit
//===========================================================================
function Trig_Basic_Bounty_Hit_Func009Func002C takes nothing returns boolean
    if ( ( GetUnitTypeId(udg_DamageEventSource) == 'h05W' ) ) then
        return true
    endif
    return false
endfunction

function Trig_Basic_Bounty_Hit_Func009C takes nothing returns boolean
    if ( not ( IsUnitEnemy(udg_DamageEventSource, GetOwningPlayer(udg_DamageEventTarget)) == true ) ) then
        return false
    endif
    if ( not Trig_Basic_Bounty_Hit_Func009Func002C() ) then
        return false
    endif
    return true
endfunction

function Trig_Basic_Bounty_Hit_Conditions takes nothing returns boolean
    if ( not Trig_Basic_Bounty_Hit_Func009C() ) then
        return false
    endif
    return true
endfunction

function Trig_Basic_Bounty_Hit_Actions takes nothing returns nothing
    call AdjustPlayerStateBJ(35, GetOwningPlayer(udg_DamageEventSource), PLAYER_STATE_RESOURCE_LUMBER)
    call AdjustPlayerStateBJ(1, GetOwningPlayer(udg_DamageEventSource), PLAYER_STATE_RESOURCE_GOLD)
    call CreateTextTagUnitBJ("TRIGSTR_124", GetEventDamageSource(), 0, 9.00, 100, 100, 100, 0.35)
    call SetTextTagPermanentBJ(GetLastCreatedTextTag(), false)
    call SetTextTagLifespanBJ(GetLastCreatedTextTag(), 0.80)
    call SetTextTagVelocityBJ(GetLastCreatedTextTag(), 42.00, 90)
    call SetTextTagFadepointBJ(GetLastCreatedTextTag(), 0.30)
endfunction

//===========================================================================
function InitTrig_Basic_Bounty_Hit takes nothing returns nothing
    set gg_trg_Basic_Bounty_Hit=CreateTrigger()
    call h__TriggerRegisterVariableEvent(gg_trg_Basic_Bounty_Hit, "udg_DamageEvent", EQUAL, 1.00)
    call TriggerAddCondition(gg_trg_Basic_Bounty_Hit, Condition(function Trig_Basic_Bounty_Hit_Conditions))
    call TriggerAddAction(gg_trg_Basic_Bounty_Hit, function Trig_Basic_Bounty_Hit_Actions)
endfunction

//===========================================================================
// Trigger: Improved Bounty Hit
//===========================================================================
function Trig_Improved_Bounty_Hit_Func009Func002C takes nothing returns boolean
    if ( ( GetUnitTypeId(udg_DamageEventSource) == 'h06H' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(udg_DamageEventSource) == 'h06C' ) ) then
        return true
    endif
    return false
endfunction

function Trig_Improved_Bounty_Hit_Func009C takes nothing returns boolean
    if ( not ( IsUnitEnemy(udg_DamageEventSource, GetOwningPlayer(udg_DamageEventTarget)) == true ) ) then
        return false
    endif
    if ( not Trig_Improved_Bounty_Hit_Func009Func002C() ) then
        return false
    endif
    return true
endfunction

function Trig_Improved_Bounty_Hit_Conditions takes nothing returns boolean
    if ( not Trig_Improved_Bounty_Hit_Func009C() ) then
        return false
    endif
    return true
endfunction

function Trig_Improved_Bounty_Hit_Actions takes nothing returns nothing
    call AdjustPlayerStateBJ(75, GetOwningPlayer(udg_DamageEventSource), PLAYER_STATE_RESOURCE_LUMBER)
    call AdjustPlayerStateBJ(2, GetOwningPlayer(udg_DamageEventSource), PLAYER_STATE_RESOURCE_GOLD)
    call CreateTextTagUnitBJ("TRIGSTR_1382", GetEventDamageSource(), 0, 9.00, 100, 100, 100, 0.35)
    call SetTextTagPermanentBJ(GetLastCreatedTextTag(), false)
    call SetTextTagLifespanBJ(GetLastCreatedTextTag(), 0.80)
    call SetTextTagVelocityBJ(GetLastCreatedTextTag(), 42.00, 90)
    call SetTextTagFadepointBJ(GetLastCreatedTextTag(), 0.30)
endfunction

//===========================================================================
function InitTrig_Improved_Bounty_Hit takes nothing returns nothing
    set gg_trg_Improved_Bounty_Hit=CreateTrigger()
    call h__TriggerRegisterVariableEvent(gg_trg_Improved_Bounty_Hit, "udg_DamageEvent", EQUAL, 1.00)
    call TriggerAddCondition(gg_trg_Improved_Bounty_Hit, Condition(function Trig_Improved_Bounty_Hit_Conditions))
    call TriggerAddAction(gg_trg_Improved_Bounty_Hit, function Trig_Improved_Bounty_Hit_Actions)
endfunction

//===========================================================================
// Trigger: Harvest Grapes
//===========================================================================
function Trig_Harvest_Grapes_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A0DB' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Harvest_Grapes_Actions takes nothing returns nothing
    call CreateItemLoc('I027', GetUnitLoc(GetSpellAbilityUnit()))
    call IssueTargetItemOrder(GetSpellAbilityUnit(), "smart", GetLastCreatedItem())
endfunction

//===========================================================================
function InitTrig_Harvest_Grapes takes nothing returns nothing
    set gg_trg_Harvest_Grapes=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Harvest_Grapes, EVENT_PLAYER_UNIT_SPELL_FINISH)
    call TriggerAddCondition(gg_trg_Harvest_Grapes, Condition(function Trig_Harvest_Grapes_Conditions))
    call TriggerAddAction(gg_trg_Harvest_Grapes, function Trig_Harvest_Grapes_Actions)
endfunction

//===========================================================================
// Trigger: Bullets Switch
//===========================================================================
function Trig_Bullets_Switch_Func002C takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A0DE' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Bullets_Switch_Conditions takes nothing returns boolean
    if ( not Trig_Bullets_Switch_Func002C() ) then
        return false
    endif
    return true
endfunction

function Trig_Bullets_Switch_Func001C takes nothing returns boolean
    if ( not ( BlzGetUnitWeaponIntegerField(GetTriggerUnit(), UNIT_WEAPON_IF_ATTACK_ATTACK_TYPE, 0) == 5 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Bullets_Switch_Actions takes nothing returns nothing
    if ( Trig_Bullets_Switch_Func001C() ) then
        call BlzSetUnitWeaponIntegerFieldBJ(GetTriggerUnit(), UNIT_WEAPON_IF_ATTACK_ATTACK_TYPE, 0, 2)
    else
        call BlzSetUnitWeaponIntegerFieldBJ(GetTriggerUnit(), UNIT_WEAPON_IF_ATTACK_ATTACK_TYPE, 0, 5)
    endif
endfunction

//===========================================================================
function InitTrig_Bullets_Switch takes nothing returns nothing
    set gg_trg_Bullets_Switch=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Bullets_Switch, EVENT_PLAYER_UNIT_SPELL_FINISH)
    call TriggerAddCondition(gg_trg_Bullets_Switch, Condition(function Trig_Bullets_Switch_Conditions))
    call TriggerAddAction(gg_trg_Bullets_Switch, function Trig_Bullets_Switch_Actions)
endfunction

//===========================================================================
// Trigger: Limb Throw
//===========================================================================
function Trig_Limb_Throw_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetSpellAbilityUnit()) == 'H064' ) ) then
        return false
    endif
    if ( not ( GetSpellAbilityId() == 'A0EE' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Limb_Throw_Actions takes nothing returns nothing
    call SetUnitLifeBJ(GetSpellAbilityUnit(), ( GetUnitStateSwap(UNIT_STATE_LIFE, GetSpellAbilityUnit()) - ( GetUnitStateSwap(UNIT_STATE_MAX_LIFE, GetSpellAbilityUnit()) * 0.15 ) ))
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_8758")
endfunction

//===========================================================================
function InitTrig_Limb_Throw takes nothing returns nothing
    set gg_trg_Limb_Throw=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Limb_Throw, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(gg_trg_Limb_Throw, Condition(function Trig_Limb_Throw_Conditions))
    call TriggerAddAction(gg_trg_Limb_Throw, function Trig_Limb_Throw_Actions)
endfunction

//===========================================================================
// Trigger: Flesh Stampede
//===========================================================================

function FleshStampede_Remove takes unit u returns nothing
    local integer id= 0

    if u == null then
        return
    endif

    set id=GetHandleId(u)
    call GroupRemoveUnit(FleshStampede_Group, u)
    call FlushChildHashtable(FleshStampede_Hash, id)
endfunction

function FleshStampede_Add takes unit u returns nothing
    local integer id= 0

    if u == null then
        return
    endif

    if GetUnitAbilityLevel(u, FLESH_STAMPEDE_ABILITY_ID) <= 0 then
        return
    endif

    set id=GetHandleId(u)
    call GroupAddUnit(FleshStampede_Group, u)
    call SaveInteger(FleshStampede_Hash, id, FLESH_STAMPEDE_MISS_KEY, 0)
    call EnableTrigger(gg_trg_Flesh_Stampede)
endfunction

function FleshStampede_LoopEnum takes nothing returns nothing
    local unit u= GetEnumUnit()
    local integer id= GetHandleId(u)
    local integer missCount= 0

    if GetUnitState(u, UNIT_STATE_LIFE) <= 0.405 then
        call FleshStampede_Remove(u)
    elseif GetUnitAbilityLevel(u, FLESH_STAMPEDE_ABILITY_ID) <= 0 then
        call FleshStampede_Remove(u)
    elseif UnitHasBuffBJ(u, FLESH_STAMPEDE_BUFF_ID) then
        call SaveInteger(FleshStampede_Hash, id, FLESH_STAMPEDE_MISS_KEY, 0)
        call SetUnitLifeBJ(u, GetUnitState(u, UNIT_STATE_LIFE) - ( GetUnitState(u, UNIT_STATE_MAX_LIFE) * FLESH_STAMPEDE_DAMAGE_FACTOR ))
    else
        set missCount=LoadInteger(FleshStampede_Hash, id, FLESH_STAMPEDE_MISS_KEY) + 1

        if missCount >= FLESH_STAMPEDE_MISS_LIMIT then
            call FleshStampede_Remove(u)
        else
            call SaveInteger(FleshStampede_Hash, id, FLESH_STAMPEDE_MISS_KEY, missCount)
        endif
    endif

    set u=null
endfunction

function Trig_Flesh_Stampede_Actions takes nothing returns nothing
    call ForGroup(FleshStampede_Group, function FleshStampede_LoopEnum)

    if FirstOfGroup(FleshStampede_Group) == null then
        call DisableTrigger(gg_trg_Flesh_Stampede)
    endif
endfunction

function FleshStampede_Order_Conditions takes nothing returns boolean
    return GetUnitAbilityLevel(GetTriggerUnit(), FLESH_STAMPEDE_ABILITY_ID) > 0
endfunction

function FleshStampede_Order_Actions takes nothing returns nothing
    local unit u= GetTriggerUnit()
    local integer orderId= GetIssuedOrderId()

    if orderId == OrderId("immolation") then
        call FleshStampede_Add(u)
    elseif orderId == OrderId("unimmolation") then
        call FleshStampede_Remove(u)
    endif

    set u=null
endfunction

function FleshStampede_Death_Actions takes nothing returns nothing
    local unit u= GetTriggerUnit()

    if IsUnitInGroup(u, FleshStampede_Group) then
        call FleshStampede_Remove(u)
    endif

    set u=null
endfunction

//===========================================================================
function InitTrig_Flesh_Stampede takes nothing returns nothing
    local trigger orderTrig= CreateTrigger()
    local trigger deathTrig= CreateTrigger()

    if FleshStampede_Group == null then
        set FleshStampede_Group=CreateGroup()
    endif

    if FleshStampede_Hash == null then
        set FleshStampede_Hash=InitHashtable()
    endif

    set gg_trg_Flesh_Stampede=CreateTrigger()
    call TriggerRegisterTimerEventPeriodic(gg_trg_Flesh_Stampede, FLESH_STAMPEDE_PERIOD)
    call TriggerAddAction(gg_trg_Flesh_Stampede, function Trig_Flesh_Stampede_Actions)
    call DisableTrigger(gg_trg_Flesh_Stampede)

    call TriggerRegisterAnyUnitEventBJ(orderTrig, EVENT_PLAYER_UNIT_ISSUED_ORDER)
    call TriggerAddCondition(orderTrig, Condition(function FleshStampede_Order_Conditions))
    call TriggerAddAction(orderTrig, function FleshStampede_Order_Actions)

    call TriggerRegisterAnyUnitEventBJ(deathTrig, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddAction(deathTrig, function FleshStampede_Death_Actions)

    set orderTrig=null
    set deathTrig=null
endfunction
//===========================================================================
// Trigger: Amalgamation
//===========================================================================
function Trig_Amalgamation_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'H064' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Amalgamation_Func001Func002C takes nothing returns boolean
    if ( not ( GetIssuedOrderIdBJ() == String2OrderIdBJ("unimmolation") ) ) then
        return false
    endif
    return true
endfunction

function Trig_Amalgamation_Func001C takes nothing returns boolean
    if ( not ( GetIssuedOrderIdBJ() == String2OrderIdBJ("immolation") ) ) then
        return false
    endif
    return true
endfunction

function Trig_Amalgamation_Actions takes nothing returns nothing
    if ( Trig_Amalgamation_Func001C() ) then
        call SetUnitMoveSpeed(GetTriggerUnit(), ( GetUnitDefaultMoveSpeed(GetTriggerUnit()) + 80.00 ))
    else
        if ( Trig_Amalgamation_Func001Func002C() ) then
            call SetUnitMoveSpeed(GetTriggerUnit(), GetUnitDefaultMoveSpeed(GetTriggerUnit()))
        else
        endif
    endif
endfunction

//===========================================================================
function InitTrig_Amalgamation takes nothing returns nothing
    set gg_trg_Amalgamation=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Amalgamation, EVENT_PLAYER_UNIT_ISSUED_ORDER)
    call TriggerAddCondition(gg_trg_Amalgamation, Condition(function Trig_Amalgamation_Conditions))
    call TriggerAddAction(gg_trg_Amalgamation, function Trig_Amalgamation_Actions)
endfunction

//===========================================================================
// Trigger: Merge
//===========================================================================
function Trig_Merge_Func001C takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A0DZ' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Merge_Conditions takes nothing returns boolean
    if ( not Trig_Merge_Func001C() ) then
        return false
    endif
    return true
endfunction

function Trig_Merge_Actions takes nothing returns nothing
    call KillUnit(GetSpellAbilityUnit())
endfunction

//===========================================================================
function InitTrig_Merge takes nothing returns nothing
    set gg_trg_Merge=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Merge, EVENT_PLAYER_UNIT_SPELL_ENDCAST)
    call TriggerAddCondition(gg_trg_Merge, Condition(function Trig_Merge_Conditions))
    call TriggerAddAction(gg_trg_Merge, function Trig_Merge_Actions)
endfunction

//===========================================================================
// Trigger: Husk Detection
//===========================================================================
function Trig_Husk_Detection_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetSpellTargetUnit()) == 'H064' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Husk_Detection_Func001C takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A0DZ' ) ) then
        return false
    endif
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'u00I' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Husk_Detection_Func002C takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A0DZ' ) ) then
        return false
    endif
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'u00J' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Husk_Detection_Func004C takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A0DZ' ) ) then
        return false
    endif
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'u00K' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Husk_Detection_Actions takes nothing returns nothing
    if ( Trig_Husk_Detection_Func001C() ) then
        call ModifyHeroStat(bj_HEROSTAT_STR, GetSpellTargetUnit(), bj_MODIFYMETHOD_ADD, 1)
        call BlzSetUnitBaseDamage(GetSpellTargetUnit(), ( BlzGetUnitBaseDamage(GetSpellTargetUnit(), 0) + 4 ), 0)
        call BlzSetUnitMaxHP(GetSpellTargetUnit(), ( BlzGetUnitMaxHP(GetSpellTargetUnit()) + 10 ))
    else
    endif
    if ( Trig_Husk_Detection_Func002C() ) then
        call ModifyHeroStat(bj_HEROSTAT_STR, GetSpellTargetUnit(), bj_MODIFYMETHOD_ADD, 3)
        call ModifyHeroStat(bj_HEROSTAT_AGI, GetSpellTargetUnit(), bj_MODIFYMETHOD_ADD, 2)
        call BlzSetUnitBaseDamage(GetSpellTargetUnit(), ( BlzGetUnitBaseDamage(GetSpellTargetUnit(), 0) + 7 ), 0)
        call BlzSetUnitMaxHP(GetSpellTargetUnit(), ( BlzGetUnitMaxHP(GetSpellTargetUnit()) + 25 ))
    else
    endif
    if ( Trig_Husk_Detection_Func004C() ) then
        call ModifyHeroStat(bj_HEROSTAT_STR, GetSpellTargetUnit(), bj_MODIFYMETHOD_ADD, 5)
        call ModifyHeroStat(bj_HEROSTAT_AGI, GetSpellTargetUnit(), bj_MODIFYMETHOD_ADD, 5)
        call BlzSetUnitBaseDamage(GetSpellTargetUnit(), ( BlzGetUnitBaseDamage(GetSpellTargetUnit(), 0) + 10 ), 0)
        call BlzSetUnitMaxHP(GetSpellTargetUnit(), ( BlzGetUnitMaxHP(GetSpellTargetUnit()) + 50 ))
    else
    endif
endfunction

//===========================================================================
function InitTrig_Husk_Detection takes nothing returns nothing
    set gg_trg_Husk_Detection=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Husk_Detection, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Husk_Detection, Condition(function Trig_Husk_Detection_Conditions))
    call TriggerAddAction(gg_trg_Husk_Detection, function Trig_Husk_Detection_Actions)
endfunction

//===========================================================================
// Trigger: Death Jump
//===========================================================================
function Trig_Death_Jump_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A0EG' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Death_Jump_Actions takes nothing returns nothing
    call SetUnitLifeBJ(GetSpellAbilityUnit(), ( GetUnitStateSwap(UNIT_STATE_LIFE, GetSpellAbilityUnit()) - ( GetUnitStateSwap(UNIT_STATE_LIFE, GetSpellAbilityUnit()) * 0.50 ) ))
endfunction

//===========================================================================
function InitTrig_Death_Jump takes nothing returns nothing
    set gg_trg_Death_Jump=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Death_Jump, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(gg_trg_Death_Jump, Condition(function Trig_Death_Jump_Conditions))
    call TriggerAddAction(gg_trg_Death_Jump, function Trig_Death_Jump_Actions)
endfunction

//===========================================================================
// Trigger: Map Start
//===========================================================================
function Trig_Map_Start_Actions takes nothing returns nothing
    call SetPlayerTechResearchedSwap('R07L', 1, Player(0))
    call SetPlayerTechResearchedSwap('R07L', 1, Player(1))
    call SetPlayerTechResearchedSwap('R07L', 1, Player(2))
    call SetPlayerTechResearchedSwap('R07L', 1, Player(3))
    call SetPlayerTechResearchedSwap('R07L', 1, Player(4))
    call SetPlayerTechResearchedSwap('R07L', 1, Player(5))
    call SetPlayerTechResearchedSwap('R07L', 1, Player(6))
    call SetPlayerTechResearchedSwap('R07L', 1, Player(7))
    call SetPlayerTechResearchedSwap('R07L', 1, Player(8))
    call SetPlayerTechResearchedSwap('R07L', 1, Player(9))
    call SetPlayerTechResearchedSwap('R07L', 1, Player(10))
    call EnableTrigger(gg_trg_Day)
    call EnableTrigger(gg_trg_Night)
endfunction

//===========================================================================
function InitTrig_Map_Start takes nothing returns nothing
    set gg_trg_Map_Start=CreateTrigger()
    call TriggerRegisterTimerEventSingle(gg_trg_Map_Start, 5.00)
    call TriggerAddAction(gg_trg_Map_Start, function Trig_Map_Start_Actions)
endfunction

//===========================================================================
// Trigger: Day
//===========================================================================
function Trig_Day_Actions takes nothing returns nothing
    call SetPlayerTechResearchedSwap('R07L', 0, Player(0))
    call SetPlayerTechResearchedSwap('R07L', 0, Player(1))
    call SetPlayerTechResearchedSwap('R07L', 0, Player(2))
    call SetPlayerTechResearchedSwap('R07L', 0, Player(3))
    call SetPlayerTechResearchedSwap('R07L', 0, Player(4))
    call SetPlayerTechResearchedSwap('R07L', 0, Player(5))
    call SetPlayerTechResearchedSwap('R07L', 0, Player(6))
    call SetPlayerTechResearchedSwap('R07L', 0, Player(7))
    call SetPlayerTechResearchedSwap('R07L', 0, Player(8))
    call SetPlayerTechResearchedSwap('R07L', 0, Player(9))
    call SetPlayerTechResearchedSwap('R07L', 0, Player(10))
endfunction

//===========================================================================
function InitTrig_Day takes nothing returns nothing
    set gg_trg_Day=CreateTrigger()
    call DisableTrigger(gg_trg_Day)
    call TriggerRegisterGameStateEventTimeOfDay(gg_trg_Day, EQUAL, 6.00)
    call TriggerAddAction(gg_trg_Day, function Trig_Day_Actions)
endfunction

//===========================================================================
// Trigger: Night
//===========================================================================
function Trig_Night_Actions takes nothing returns nothing
    call SetPlayerTechResearchedSwap('R07L', 1, Player(0))
    call SetPlayerTechResearchedSwap('R07L', 1, Player(1))
    call SetPlayerTechResearchedSwap('R07L', 1, Player(2))
    call SetPlayerTechResearchedSwap('R07L', 1, Player(3))
    call SetPlayerTechResearchedSwap('R07L', 1, Player(4))
    call SetPlayerTechResearchedSwap('R07L', 1, Player(5))
    call SetPlayerTechResearchedSwap('R07L', 1, Player(6))
    call SetPlayerTechResearchedSwap('R07L', 1, Player(7))
    call SetPlayerTechResearchedSwap('R07L', 1, Player(8))
    call SetPlayerTechResearchedSwap('R07L', 1, Player(9))
    call SetPlayerTechResearchedSwap('R07L', 1, Player(10))
endfunction

//===========================================================================
function InitTrig_Night takes nothing returns nothing
    set gg_trg_Night=CreateTrigger()
    call DisableTrigger(gg_trg_Night)
    call TriggerRegisterGameStateEventTimeOfDay(gg_trg_Night, EQUAL, 18.00)
    call TriggerAddAction(gg_trg_Night, function Trig_Night_Actions)
endfunction

//===========================================================================
// Trigger: Iron Hoove
//===========================================================================

function UPG_MinInt takes integer a,integer b returns integer
    if a < b then
        return a
    endif

    return b
endfunction

function UPG_GetAbilityLevelForPlayer takes player p returns integer
    return UPG_MinInt(UPG_BASE_ABILITY_LEVEL + GetPlayerTechCount(p, UPG_UPGRADE_ID, true) , UPG_MAX_ABILITY_LEVEL)
endfunction

function UPG_ApplyToUnit takes unit u returns nothing
    local integer wantedLevel

    if GetUnitAbilityLevel(u, UPG_ABILITY_ID) > 0 then
        set wantedLevel=(UPG_MinInt(UPG_BASE_ABILITY_LEVEL + GetPlayerTechCount((GetOwningPlayer(u)), UPG_UPGRADE_ID, true) , UPG_MAX_ABILITY_LEVEL)) // INLINED!!

        if wantedLevel > GetUnitAbilityLevel(u, UPG_ABILITY_ID) then
            call SetUnitAbilityLevel(u, UPG_ABILITY_ID, wantedLevel)
        endif
    endif
endfunction

function UPG_ApplyToAllUnitsOfPlayer takes player p returns nothing
    local unit u

    call GroupEnumUnitsOfPlayer(UPG_TempGroup, p, null)

    loop
        set u=FirstOfGroup(UPG_TempGroup)
        exitwhen u == null

        call GroupRemoveUnit(UPG_TempGroup, u)
        call UPG_ApplyToUnit(u)
    endloop

    set u=null
endfunction

function UPG_OnResearchFinish takes nothing returns nothing
    local integer researchedId= GetResearched()
    local player p

    if researchedId == UPG_UPGRADE_ID then
        set p=GetOwningPlayer(GetTriggerUnit())
        call UPG_ApplyToAllUnitsOfPlayer(p)
        set p=null
    endif
endfunction

function UPG_OnUnitEnterMap takes nothing returns nothing
    call UPG_ApplyToUnit(GetTriggerUnit())
endfunction

function InitTrig_Iron_Hoove takes nothing returns nothing
    set UPG_ResearchTrig=CreateTrigger()
    set UPG_EnterTrig=CreateTrigger()
    set UPG_WorldRegion=CreateRegion()

    call TriggerRegisterAnyUnitEventBJ(UPG_ResearchTrig, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    call TriggerAddAction(UPG_ResearchTrig, function UPG_OnResearchFinish)

    call RegionAddRect(UPG_WorldRegion, GetWorldBounds())
    call TriggerRegisterEnterRegion(UPG_EnterTrig, UPG_WorldRegion, null)
    call TriggerAddAction(UPG_EnterTrig, function UPG_OnUnitEnterMap)
endfunction
//===========================================================================
// Trigger: Lightning Strike TowerVers
//===========================================================================
function Trig_Lightning_Strike_TowerVers_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A0C2' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Lightning_Strike_TowerVers_Actions takes nothing returns nothing
endfunction

//===========================================================================
function InitTrig_Lightning_Strike_TowerVers takes nothing returns nothing
    set gg_trg_Lightning_Strike_TowerVers=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Lightning_Strike_TowerVers, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Lightning_Strike_TowerVers, Condition(function Trig_Lightning_Strike_TowerVers_Conditions))
    call TriggerAddAction(gg_trg_Lightning_Strike_TowerVers, function Trig_Lightning_Strike_TowerVers_Actions)
endfunction


//===========================================================================
// Trigger: Blizzard
//===========================================================================
function Trig_Blizzard_Conditions takes nothing returns boolean
    if ( not ( IsUnitType(udg_DamageEventSource, UNIT_TYPE_HERO) == true ) ) then
        return false
    endif
    if ( not ( IsUnitType(udg_DamageEventTarget, UNIT_TYPE_HERO) == true ) ) then
        return false
    endif
    if ( not ( udg_IsDamageAttack == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Blizzard_Actions takes nothing returns nothing
endfunction

//===========================================================================
function InitTrig_Blizzard takes nothing returns nothing
    set gg_trg_Blizzard=CreateTrigger()
    call h__TriggerRegisterVariableEvent(gg_trg_Blizzard, "udg_DamageEvent", EQUAL, 1.00)
    call TriggerAddCondition(gg_trg_Blizzard, Condition(function Trig_Blizzard_Conditions))
    call TriggerAddAction(gg_trg_Blizzard, function Trig_Blizzard_Actions)
endfunction

//===========================================================================
// Trigger: ShovelStrikelevelup
//===========================================================================
function Trig_ShovelStrikelevelup_Conditions takes nothing returns boolean
    if ( not ( GetResearched() == 'R004' ) ) then
        return false
    endif
    return true
endfunction

function Trig_ShovelStrikelevelup_Func003002 takes nothing returns nothing
    call IncUnitAbilityLevelSwapped('A086', GetEnumUnit())
endfunction

function Trig_ShovelStrikelevelup_Actions takes nothing returns nothing
    call ForGroupBJ(GetUnitsOfPlayerAndTypeId(GetOwningPlayer(GetResearchingUnit()), 'h03Q'), function Trig_ShovelStrikelevelup_Func003002)
endfunction

//===========================================================================
function InitTrig_ShovelStrikelevelup takes nothing returns nothing
    set gg_trg_ShovelStrikelevelup=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_ShovelStrikelevelup, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    call TriggerAddCondition(gg_trg_ShovelStrikelevelup, Condition(function Trig_ShovelStrikelevelup_Conditions))
    call TriggerAddAction(gg_trg_ShovelStrikelevelup, function Trig_ShovelStrikelevelup_Actions)
endfunction

//===========================================================================
// Trigger: Deepwater 1
//===========================================================================
function Trig_Deepwater_1_Conditions takes nothing returns boolean
    if ( not ( GetResearched() == 'R066' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Deepwater_1_Func001A takes nothing returns nothing
    call UnitRemoveAbilityBJ('A0A4', GetEnumUnit())
    call UnitAddAbilityBJ('A0BB', GetEnumUnit())
    set udg_DeepWater1[GetConvertedPlayerId(GetOwningPlayer(GetResearchingUnit()))]=true
endfunction

function Trig_Deepwater_1_Actions takes nothing returns nothing
    call ForGroupBJ(GetUnitsOfPlayerAndTypeId(GetOwningPlayer(GetResearchingUnit()), 'e00R'), function Trig_Deepwater_1_Func001A)
endfunction

//===========================================================================
function InitTrig_Deepwater_1 takes nothing returns nothing
    set gg_trg_Deepwater_1=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Deepwater_1, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    call TriggerAddCondition(gg_trg_Deepwater_1, Condition(function Trig_Deepwater_1_Conditions))
    call TriggerAddAction(gg_trg_Deepwater_1, function Trig_Deepwater_1_Actions)
endfunction

//===========================================================================
// Trigger: Deepwater 2
//===========================================================================
function Trig_Deepwater_2_Conditions takes nothing returns boolean
    if ( not ( udg_DeepWater1[GetConvertedPlayerId(GetOwningPlayer(GetConstructedStructure()))] == true ) ) then
        return false
    endif
    if ( not ( GetUnitTypeId(GetConstructedStructure()) == 'e00R' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Deepwater_2_Actions takes nothing returns nothing
    call UnitRemoveAbilityBJ('A0A4', GetConstructedStructure())
    call UnitAddAbilityBJ('A0BB', GetConstructedStructure())
endfunction

//===========================================================================
function InitTrig_Deepwater_2 takes nothing returns nothing
    set gg_trg_Deepwater_2=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Deepwater_2, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
    call TriggerAddCondition(gg_trg_Deepwater_2, Condition(function Trig_Deepwater_2_Conditions))
    call TriggerAddAction(gg_trg_Deepwater_2, function Trig_Deepwater_2_Actions)
endfunction

//===========================================================================
// Trigger: Genesis
//===========================================================================
function Trig_Genesis_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A0AO' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Genesis_Actions takes nothing returns nothing
    local location spellLoc= GetSpellTargetLoc()
    local unit caster= GetSpellAbilityUnit()
    local destructable tree= null
    local location treeLoc= null
    local unit treant= null
    local unit dummy= null

    call CreateNUnitsAtLoc(1, 'h04L', GetOwningPlayer(GetSpellAbilityUnit()), GetSpellTargetLoc(), 0)
    set dummy=GetLastCreatedUnit()
    call UnitApplyTimedLifeBJ(5.00, 'BTLF', GetLastCreatedUnit())

    // --- 1. CREATE THE TREE ---
    call CreateDestructableLoc('LTlt', spellLoc, GetRandomDirectionDeg(), 1, 0)
    set tree=GetLastCreatedDestructable()
    call SetDestructableAnimation(tree, "birth")
    call SetDestructableAnimationSpeed(tree, 1.2) // Slow birth = visible growth (1.2 = 120% of original, adjust as needed)

    // Caster animation
    call SetUnitAnimation(caster, "Spell Second")

    // --- 2. WAIT 3 SECONDS ---
    call TriggerSleepAction(3.0)

    // --- 3. TRANSFORM TREE INTO TREANT ---
    if ( tree != null ) and ( GetDestructableLife(tree) > 0 ) then
        set treeLoc=GetDestructableLoc(tree)

        // SLOW the tree's animation drastically so the death animation becomes visible
        call SetDestructableAnimationSpeed(tree, 1) // 30% speed → death lasts ~3.3x longer

        // Kill the tree, this triggers the death animation at 30% speed
        call KillDestructable(tree)

        // Immediately create the treant on top of the dying tree
        call CreateNUnitsAtLoc(1, 'e00U', GetOwningPlayer(caster), treeLoc, 0)
        set treant=GetLastCreatedUnit()
        call UnitApplyTimedLife(treant, 'BTLF', 60.0)
        call SetUnitAnimation(treant, "birth") // Treant birth is already working

        // Wait for the slowed death animation to finish
        call TriggerSleepAction(1) // Adjust: 1 sec original death * 3.3 ≈ 3.3 sec wait
        call RemoveDestructable(tree) // Clean up the corpse

        call RemoveLocation(treeLoc)
    endif

    call RemoveLocation(spellLoc)
    set caster=null
    set tree=null
    set treant=null
endfunction

//===========================================================================
function InitTrig_Genesis takes nothing returns nothing
    set gg_trg_Genesis=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Genesis, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Genesis, Condition(function Trig_Genesis_Conditions))
    call TriggerAddAction(gg_trg_Genesis, function Trig_Genesis_Actions)
endfunction


//===========================================================================
// Trigger: ConjureRefreshment
//===========================================================================
function Trig_ConjureRefreshment_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A0C8' ) ) then
        return false
    endif
    return true
endfunction

function Trig_ConjureRefreshment_Actions takes nothing returns nothing
    call CreateItemLoc('I021', GetSpellTargetLoc())
endfunction

//===========================================================================
function InitTrig_ConjureRefreshment takes nothing returns nothing
    set gg_trg_ConjureRefreshment=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_ConjureRefreshment, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_ConjureRefreshment, Condition(function Trig_ConjureRefreshment_Conditions))
    call TriggerAddAction(gg_trg_ConjureRefreshment, function Trig_ConjureRefreshment_Actions)
endfunction

//===========================================================================
// Trigger: ShadowDancers
//===========================================================================
function Trig_ShadowDancers_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A0A5' ) ) then
        return false
    endif
    return true
endfunction

function Trig_ShadowDancers_Actions takes nothing returns nothing
    call GroupAddUnitSimple(GetTriggerUnit(), udg_ShadowDancers)
endfunction

//===========================================================================
function InitTrig_ShadowDancers takes nothing returns nothing
    set gg_trg_ShadowDancers=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_ShadowDancers, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_ShadowDancers, Condition(function Trig_ShadowDancers_Conditions))
    call TriggerAddAction(gg_trg_ShadowDancers, function Trig_ShadowDancers_Actions)
endfunction

//===========================================================================
// Trigger: Mana Burn
//===========================================================================
function Trig_Mana_Burn_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A0AR' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Mana_Burn_Func003C takes nothing returns boolean
    if ( not ( GetUnitStateSwap(UNIT_STATE_MANA, GetSpellTargetUnit()) <= 10.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Mana_Burn_Actions takes nothing returns nothing
    call BlzSetUnitRealFieldBJ(GetSpellTargetUnit(), UNIT_RF_MANA, ( BlzGetUnitRealField(GetSpellTargetUnit(), UNIT_RF_MANA) - ( GetUnitStateSwap(UNIT_STATE_MANA, GetSpellAbilityUnit()) * 0.40 ) ))
    call BlzSetUnitRealFieldBJ(GetSpellAbilityUnit(), UNIT_RF_MANA, ( GetUnitStateSwap(UNIT_STATE_MANA, GetSpellAbilityUnit()) * 0.80 ))
    if ( Trig_Mana_Burn_Func003C() ) then
        call CreateNUnitsAtLoc(1, 'h04L', GetOwningPlayer(GetSpellAbilityUnit()), GetUnitLoc(GetSpellTargetUnit()), bj_UNIT_FACING)
        call UnitAddAbilityBJ('A0CW', GetLastCreatedUnit())
        call UnitApplyTimedLifeBJ(2.00, 'BTLF', GetLastCreatedUnit())
        call IssueTargetOrderBJ(GetLastCreatedUnit(), "thunderbolt", GetSpellTargetUnit())
    else
    endif
endfunction

//===========================================================================
function InitTrig_Mana_Burn takes nothing returns nothing
    set gg_trg_Mana_Burn=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Mana_Burn, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Mana_Burn, Condition(function Trig_Mana_Burn_Conditions))
    call TriggerAddAction(gg_trg_Mana_Burn, function Trig_Mana_Burn_Actions)
endfunction

//===========================================================================
// Trigger: Mana Steal Dancer
//===========================================================================
function Trig_Mana_Steal_Dancer_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_DamageEventSource) == 'h05E' ) ) then
        return false
    endif
    if ( not ( IsPlayerAlly(GetOwningPlayer(udg_DamageEventTarget), GetOwningPlayer(udg_DamageEventSource)) == false ) ) then
	return false
    endif
    if ( not ( BlzGetUnitMaxMana(udg_DamageEventTarget) != 0 ) ) then
	return false
    endif
    if ( not ( GetPlayerTechCountSimple('R064', GetOwningPlayer(udg_DamageEventSource)) == 1 ) ) then
        return false
    endif
    if ( not ( udg_IsDamageAttack == true ) ) then
	return false
    endif
    return true
endfunction

function Trig_Mana_Steal_Dancer_Actions takes nothing returns nothing
    local unit source= udg_DamageEventSource
    local unit target= udg_DamageEventTarget
    local integer steal= 20
    local real targetMana= GetUnitState(target, UNIT_STATE_MANA)
    local real sourceMana= GetUnitState(source, UNIT_STATE_MANA)
    local real actualSteal= RMinBJ(steal, targetMana)
    local integer newMax
    // ----- Current mana steal (original behaviour, fixed to also subtract from target) -----
    call SetUnitManaBJ(udg_DamageEventSource, ( GetUnitStateSwap(UNIT_STATE_MANA, udg_DamageEventSource) + actualSteal ))


    // ----- Max mana steal (temporary) -----
    // Attacker gains +20 max mana
    set newMax=BlzGetUnitMaxMana(source) + steal
    call BlzSetUnitMaxMana(source, newMax)
    // Target loses 20 max mana (but never below 0)
    set newMax=BlzGetUnitMaxMana(target) - steal
    if newMax < 0 then
        set newMax=0
    endif
    call BlzSetUnitMaxMana(target, newMax)

    // Wait 180 seconds (game time)
    call TriggerSleepAction(180.00)

    // ----- Revert max mana if units still exist -----
    if source != null and GetUnitState(source, UNIT_STATE_LIFE) > 0 then
        set newMax=BlzGetUnitMaxMana(source) - steal
        if newMax < 0 then
            set newMax=0
        endif
        call BlzSetUnitMaxMana(source, newMax)
    endif
    if target != null and GetUnitState(target, UNIT_STATE_LIFE) > 0 then
        set newMax=BlzGetUnitMaxMana(target) + steal
        call BlzSetUnitMaxMana(target, newMax)
    endif

    set source=null
    set target=null
endfunction

//===========================================================================
function InitTrig_Mana_Steal_Dancer takes nothing returns nothing
    set gg_trg_Mana_Steal_Dancer=CreateTrigger()
    call h__TriggerRegisterVariableEvent(gg_trg_Mana_Steal_Dancer, "udg_DamageEvent", EQUAL, 1.00)
    call TriggerAddCondition(gg_trg_Mana_Steal_Dancer, Condition(function Trig_Mana_Steal_Dancer_Conditions))
    call TriggerAddAction(gg_trg_Mana_Steal_Dancer, function Trig_Mana_Steal_Dancer_Actions)
endfunction
//===========================================================================
// Trigger: Mana Steal Mages
//===========================================================================
function Trig_Mana_Steal_Mages_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'o023' ) ) then
        return false
    endif
    if ( not ( IsPlayerAlly(GetOwningPlayer(udg_DamageEventTarget), GetOwningPlayer(udg_DamageEventSource)) == false ) ) then
        return false
    endif
    if ( not ( BlzGetUnitMaxMana(udg_DamageEventTarget) != 0 ) ) then
        return false
    endif
    if ( not ( GetPlayerTechCountSimple('R063', GetOwningPlayer(udg_DamageEventSource)) == 1 ) ) then
        return false
    endif
    if ( not ( udg_IsDamageAttack == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Mana_Steal_Mages_Actions takes nothing returns nothing
    call SetUnitManaBJ(udg_DamageEventSource, ( GetUnitStateSwap(UNIT_STATE_MANA, udg_DamageEventSource) + 20.00 ))
endfunction

//===========================================================================
function InitTrig_Mana_Steal_Mages takes nothing returns nothing
    set gg_trg_Mana_Steal_Mages=CreateTrigger()
    call h__TriggerRegisterVariableEvent(gg_trg_Mana_Steal_Mages, "udg_DamageEvent", EQUAL, 1.00)
    call TriggerAddCondition(gg_trg_Mana_Steal_Mages, Condition(function Trig_Mana_Steal_Mages_Conditions))
    call TriggerAddAction(gg_trg_Mana_Steal_Mages, function Trig_Mana_Steal_Mages_Actions)
endfunction

//===========================================================================
// Trigger: ConjureMana
//===========================================================================
function Trig_ConjureMana_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A0AQ' ) ) then
        return false
    endif
    return true
endfunction

function Trig_ConjureMana_Actions takes nothing returns nothing
    call BlzSetUnitBaseDamage(GetTriggerUnit(), ( 199 + R2I(GetUnitStateSwap(UNIT_STATE_MANA, GetTriggerUnit())) ), 0)
    call TriggerSleepAction(1.00)
    call SetUnitManaBJ(GetSpellAbilityUnit(), ( GetUnitStateSwap(UNIT_STATE_MANA, GetSpellAbilityUnit()) / 2.00 ))
    call TriggerSleepAction(60.00)
    call BlzSetUnitBaseDamage(GetTriggerUnit(), 199, 0)
endfunction

//===========================================================================
function InitTrig_ConjureMana takes nothing returns nothing
    set gg_trg_ConjureMana=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_ConjureMana, EVENT_PLAYER_UNIT_SPELL_FINISH)
    call TriggerAddCondition(gg_trg_ConjureMana, Condition(function Trig_ConjureMana_Conditions))
    call TriggerAddAction(gg_trg_ConjureMana, function Trig_ConjureMana_Actions)
endfunction

//===========================================================================
// Trigger: Blur
//===========================================================================
function Trig_Blur_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A0BG' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Blur_Actions takes nothing returns nothing
    call UnitAddAbilityBJ('A0AS', GetSpellAbilityUnit())
    call TriggerSleepAction(GetUnitStateSwap(UNIT_STATE_MAX_MANA, GetTriggerUnit()) * 0.001)
    call UnitRemoveAbilityBJ('A0AS', GetTriggerUnit())
    call UnitRemoveBuffBJ('B03G', GetTriggerUnit())
endfunction

//===========================================================================
function InitTrig_Blur takes nothing returns nothing
    set gg_trg_Blur=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Blur, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    call TriggerAddCondition(gg_trg_Blur, Condition(function Trig_Blur_Conditions))
    call TriggerAddAction(gg_trg_Blur, function Trig_Blur_Actions)
endfunction


//===========================================================================
// Trigger: Ghoul Units
//
// In this map file these units have been given *Stats - Is a Building - TRUE* status which guarantees that they return back 100% of their value upon cancellation, including 5 food. Upon construction, these units are revoked their status as "a building".
// - Issue reported by fadebolt (688822315534123016) on FE discord.
// - Trigger created: 17th of April 2026
//===========================================================================
function Trig_Ghoul_Units_Func003001 takes nothing returns boolean
    return ( GetUnitTypeId(GetConstructedStructure()) == 'h01S' )
endfunction

function Trig_Ghoul_Units_Func003002 takes nothing returns boolean
    return ( GetUnitTypeId(GetConstructedStructure()) == 'h01T' )
endfunction

function Trig_Ghoul_Units_Conditions takes nothing returns boolean
    if ( not GetBooleanOr((GetUnitTypeId(GetConstructedStructure()) == 'h01S'), (GetUnitTypeId(GetConstructedStructure()) == 'h01T')) ) then // INLINED!!
        return false
    endif
    return true
endfunction

function Trig_Ghoul_Units_Actions takes nothing returns nothing
    call BlzSetUnitBooleanFieldBJ(GetConstructedStructure(), UNIT_BF_IS_A_BUILDING, false)
endfunction

//===========================================================================
function InitTrig_Ghoul_Units takes nothing returns nothing
    set gg_trg_Ghoul_Units=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Ghoul_Units, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
    call TriggerAddCondition(gg_trg_Ghoul_Units, Condition(function Trig_Ghoul_Units_Conditions))
    call TriggerAddAction(gg_trg_Ghoul_Units, function Trig_Ghoul_Units_Actions)
endfunction

//===========================================================================
// Trigger: Ghoul lumber
//===========================================================================
function Trig_Ghoul_lumber_Conditions takes nothing returns boolean
    return GetResearched() == 'R05K'
endfunction

function Trig_Ghoul_lumber_ApplyToUnit takes unit u returns nothing
    local player p
    local integer upgradeLevel

    if GetUnitTypeId(u) == 'o005' then
        set p=GetOwningPlayer(u)
        set upgradeLevel=GetPlayerTechCount(p, 'R05K', true)

        if upgradeLevel >= 2 then
            call UnitRemoveAbility(u, 'A08Y')
            call UnitRemoveAbility(u, 'A08Z')
            call UnitAddAbility(u, 'A005')
        elseif upgradeLevel == 1 then
            call UnitRemoveAbility(u, 'A08Y')
            call UnitRemoveAbility(u, 'A005')
            call UnitAddAbility(u, 'A08Z')
        endif

        set p=null
    endif
endfunction

function Trig_Ghoul_lumber_Actions takes nothing returns nothing
    local player p= GetOwningPlayer(GetResearchingUnit())
    local group g= CreateGroup()
    local unit u

    call GroupEnumUnitsOfPlayer(g, p, null)

    loop
        set u=FirstOfGroup(g)
        exitwhen u == null

        call GroupRemoveUnit(g, u)
        call Trig_Ghoul_lumber_ApplyToUnit(u)
    endloop

    call DestroyGroup(g)

    set u=null
    set g=null
    set p=null
endfunction

function Trig_Ghoul_lumber_Enter_Actions takes nothing returns nothing
    call Trig_Ghoul_lumber_ApplyToUnit(GetTriggerUnit())
endfunction

//===========================================================================
function InitTrig_Ghoul_lumber takes nothing returns nothing
    local trigger enterTrig= CreateTrigger()
    local region worldRegion= CreateRegion()

    set gg_trg_Ghoul_lumber=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Ghoul_lumber, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    call TriggerAddCondition(gg_trg_Ghoul_lumber, Condition(function Trig_Ghoul_lumber_Conditions))
    call TriggerAddAction(gg_trg_Ghoul_lumber, function Trig_Ghoul_lumber_Actions)

    call RegionAddRect(worldRegion, GetWorldBounds())
    call TriggerRegisterEnterRegion(enterTrig, worldRegion, null)
    call TriggerAddAction(enterTrig, function Trig_Ghoul_lumber_Enter_Actions)

    set enterTrig=null
    set worldRegion=null
endfunction
//===========================================================================
// Trigger: Dutchmen Trained
//===========================================================================
function Trig_Dutchmen_Trained_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTrainedUnit()) == 'H03P' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Dutchmen_Trained_Actions takes nothing returns nothing
    call GroupAddUnitSimple(GetTrainedUnit(), udg_Dutchmen)
endfunction

//===========================================================================
function InitTrig_Dutchmen_Trained takes nothing returns nothing
    set gg_trg_Dutchmen_Trained=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Dutchmen_Trained, EVENT_PLAYER_UNIT_TRAIN_FINISH)
    call TriggerAddCondition(gg_trg_Dutchmen_Trained, Condition(function Trig_Dutchmen_Trained_Conditions))
    call TriggerAddAction(gg_trg_Dutchmen_Trained, function Trig_Dutchmen_Trained_Actions)
endfunction

//===========================================================================
// Trigger: Dutchmen
//===========================================================================
function Trig_Dutchmen_Func001A takes nothing returns nothing
    call BlzSetUnitBaseDamage(GetEnumUnit(), ( GetPlayerState(GetOwningPlayer(GetEnumUnit()), PLAYER_STATE_RESOURCE_GOLD) + ( 49 + GetHeroStatBJ(bj_HEROSTAT_STR, GetEnumUnit(), true) ) ), 0)
endfunction

function Trig_Dutchmen_Actions takes nothing returns nothing
    call ForGroupBJ(udg_Dutchmen, function Trig_Dutchmen_Func001A)
endfunction

//===========================================================================
function InitTrig_Dutchmen takes nothing returns nothing
    set gg_trg_Dutchmen=CreateTrigger()
    call TriggerRegisterTimerEventPeriodic(gg_trg_Dutchmen, 2)
    call TriggerAddAction(gg_trg_Dutchmen, function Trig_Dutchmen_Actions)
endfunction

//===========================================================================
// Trigger: Vampiric Wyrm
//
// In this map file the unit has been given *Stats - Is a Building - TRUE* status which guarantees that it returns back 100% of it's value upon cancellation, including 10 food. Upon construction, this unit is revoked it's status as "a building".
// *Additionally, the other two constructable units by Aethyr also require that fix, thus they are included in this trigger.
// - Issue reported by Scalarius (79600512139264000) on FE discord.
// - Trigger created: 5th of May 2026
//===========================================================================
function Trig_Vampiric_Wyrm_Func001C takes nothing returns boolean
    if ( ( GetUnitTypeId(GetConstructedStructure()) == 'e005' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetConstructedStructure()) == 'e004' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetConstructedStructure()) == 'e006' ) ) then
        return true
    endif
    return false
endfunction

function Trig_Vampiric_Wyrm_Conditions takes nothing returns boolean
    if ( not Trig_Vampiric_Wyrm_Func001C() ) then
        return false
    endif
    return true
endfunction

function Trig_Vampiric_Wyrm_Actions takes nothing returns nothing
    call BlzSetUnitBooleanFieldBJ(GetConstructedStructure(), UNIT_BF_IS_A_BUILDING, false)
endfunction

//===========================================================================
function InitTrig_Vampiric_Wyrm takes nothing returns nothing
    set gg_trg_Vampiric_Wyrm=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Vampiric_Wyrm, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
    call TriggerAddCondition(gg_trg_Vampiric_Wyrm, Condition(function Trig_Vampiric_Wyrm_Conditions))
    call TriggerAddAction(gg_trg_Vampiric_Wyrm, function Trig_Vampiric_Wyrm_Actions)
endfunction

//===========================================================================
// Trigger: Soul Hammer
//===========================================================================
function Trig_Soul_Hammer_Conditions takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I01E' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Soul_Hammer_Func002Func002Func001Func001C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'u00B' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Soul_Hammer_Func002Func002Func001C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'u009' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Soul_Hammer_Func002Func002C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'u007' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Soul_Hammer_Func002C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'u00A' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Soul_Hammer_Actions takes nothing returns nothing
    if ( Trig_Soul_Hammer_Func002C() ) then
        call DoNothing()
    else
        if ( Trig_Soul_Hammer_Func002Func002C() ) then
            call DoNothing()
        else
            if ( Trig_Soul_Hammer_Func002Func002Func001C() ) then
                call DoNothing()
            else
                if ( Trig_Soul_Hammer_Func002Func002Func001Func001C() ) then
                    call DoNothing()
                else
                    call UnitDropItemPointLoc(GetTriggerUnit(), GetManipulatedItem(), GetUnitLoc(GetTriggerUnit()))
                endif
            endif
        endif
    endif
endfunction

//===========================================================================
function InitTrig_Soul_Hammer takes nothing returns nothing
    set gg_trg_Soul_Hammer=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Soul_Hammer, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddCondition(gg_trg_Soul_Hammer, Condition(function Trig_Soul_Hammer_Conditions))
    call TriggerAddAction(gg_trg_Soul_Hammer, function Trig_Soul_Hammer_Actions)
endfunction

//===========================================================================
// Trigger: Coup de grace
//===========================================================================
function Trig_Coup_de_grace_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A05X' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Coup_de_grace_Actions takes nothing returns nothing
    call SetUnitLifeBJ(GetSpellTargetUnit(), ( GetUnitStateSwap(UNIT_STATE_LIFE, GetSpellTargetUnit()) - ( GetUnitStateSwap(UNIT_STATE_MAX_LIFE, GetSpellTargetUnit()) * 0.10 ) ))
endfunction

//===========================================================================
function InitTrig_Coup_de_grace takes nothing returns nothing
    set gg_trg_Coup_de_grace=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Coup_de_grace, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(gg_trg_Coup_de_grace, Condition(function Trig_Coup_de_grace_Conditions))
    call TriggerAddAction(gg_trg_Coup_de_grace, function Trig_Coup_de_grace_Actions)
endfunction

//===========================================================================
// Trigger: Surge of Darkness
//===========================================================================
function Trig_Surge_of_Darkness_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A060' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Surge_of_Darkness_Actions takes nothing returns nothing
    call UnitAddAbilityBJ('A079', GetTriggerUnit())
    call TriggerSleepAction(5.00)
    call UnitRemoveAbilityBJ('A079', GetTriggerUnit())
endfunction

//===========================================================================
function InitTrig_Surge_of_Darkness takes nothing returns nothing
    set gg_trg_Surge_of_Darkness=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Surge_of_Darkness, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(gg_trg_Surge_of_Darkness, Condition(function Trig_Surge_of_Darkness_Conditions))
    call TriggerAddAction(gg_trg_Surge_of_Darkness, function Trig_Surge_of_Darkness_Actions)
endfunction

//===========================================================================
// Trigger: Focused Anger 1
//===========================================================================
function Trig_Focused_Anger_1_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetAttacker()) == 'u00B' ) ) then
        return false
    endif
    if ( not ( GetOwningPlayer(GetAttacker()) == Player(0) ) ) then
        return false
    endif
    return true
endfunction

function Trig_Focused_Anger_1_Func001C takes nothing returns boolean
    if ( not ( GetUnitUserData(GetTriggerUnit()) == 15 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Focused_Anger_1_Actions takes nothing returns nothing
    if ( Trig_Focused_Anger_1_Func001C() ) then
        call DoNothing()
    else
        call IncUnitAbilityLevelSwapped('A06K', GetAttacker())
        call SetUnitUserData(GetTriggerUnit(), ( GetUnitUserData(GetTriggerUnit()) + 1 ))
        call TriggerSleepAction(6.00)
        call DecUnitAbilityLevelSwapped('A06K', GetAttacker())
        call SetUnitUserData(GetTriggerUnit(), ( GetUnitUserData(GetTriggerUnit()) - 1 ))
    endif
endfunction

//===========================================================================
function InitTrig_Focused_Anger_1 takes nothing returns nothing
    set gg_trg_Focused_Anger_1=CreateTrigger()
    call DisableTrigger(gg_trg_Focused_Anger_1)
    call TriggerRegisterPlayerUnitEventSimple(gg_trg_Focused_Anger_1, Player(6), EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddCondition(gg_trg_Focused_Anger_1, Condition(function Trig_Focused_Anger_1_Conditions))
    call TriggerAddAction(gg_trg_Focused_Anger_1, function Trig_Focused_Anger_1_Actions)
endfunction

//===========================================================================
// Trigger: Focused Anger 2
//===========================================================================
function Trig_Focused_Anger_2_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetAttacker()) == 'u00B' ) ) then
        return false
    endif
    if ( not ( GetOwningPlayer(GetAttacker()) == Player(1) ) ) then
        return false
    endif
    return true
endfunction

function Trig_Focused_Anger_2_Func001C takes nothing returns boolean
    if ( not ( GetUnitUserData(GetTriggerUnit()) == 15 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Focused_Anger_2_Actions takes nothing returns nothing
    if ( Trig_Focused_Anger_2_Func001C() ) then
        call DoNothing()
    else
        call IncUnitAbilityLevelSwapped('A06K', GetAttacker())
        call SetUnitUserData(GetTriggerUnit(), ( GetUnitUserData(GetTriggerUnit()) + 1 ))
        call TriggerSleepAction(6.00)
        call DecUnitAbilityLevelSwapped('A06K', GetAttacker())
        call SetUnitUserData(GetTriggerUnit(), ( GetUnitUserData(GetTriggerUnit()) - 1 ))
    endif
endfunction

//===========================================================================
function InitTrig_Focused_Anger_2 takes nothing returns nothing
    set gg_trg_Focused_Anger_2=CreateTrigger()
    call DisableTrigger(gg_trg_Focused_Anger_2)
    call TriggerRegisterPlayerUnitEventSimple(gg_trg_Focused_Anger_2, Player(6), EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddCondition(gg_trg_Focused_Anger_2, Condition(function Trig_Focused_Anger_2_Conditions))
    call TriggerAddAction(gg_trg_Focused_Anger_2, function Trig_Focused_Anger_2_Actions)
endfunction

//===========================================================================
// Trigger: Focused Anger 3
//===========================================================================
function Trig_Focused_Anger_3_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetAttacker()) == 'u00B' ) ) then
        return false
    endif
    if ( not ( GetOwningPlayer(GetAttacker()) == Player(2) ) ) then
        return false
    endif
    return true
endfunction

function Trig_Focused_Anger_3_Func001C takes nothing returns boolean
    if ( not ( GetUnitUserData(GetTriggerUnit()) == 15 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Focused_Anger_3_Actions takes nothing returns nothing
    if ( Trig_Focused_Anger_3_Func001C() ) then
        call DoNothing()
    else
        call IncUnitAbilityLevelSwapped('A06K', GetAttacker())
        call SetUnitUserData(GetTriggerUnit(), ( GetUnitUserData(GetTriggerUnit()) + 1 ))
        call TriggerSleepAction(6.00)
        call DecUnitAbilityLevelSwapped('A06K', GetAttacker())
        call SetUnitUserData(GetTriggerUnit(), ( GetUnitUserData(GetTriggerUnit()) - 1 ))
    endif
endfunction

//===========================================================================
function InitTrig_Focused_Anger_3 takes nothing returns nothing
    set gg_trg_Focused_Anger_3=CreateTrigger()
    call DisableTrigger(gg_trg_Focused_Anger_3)
    call TriggerRegisterPlayerUnitEventSimple(gg_trg_Focused_Anger_3, Player(6), EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddCondition(gg_trg_Focused_Anger_3, Condition(function Trig_Focused_Anger_3_Conditions))
    call TriggerAddAction(gg_trg_Focused_Anger_3, function Trig_Focused_Anger_3_Actions)
endfunction

//===========================================================================
// Trigger: Focused Anger 4
//===========================================================================
function Trig_Focused_Anger_4_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetAttacker()) == 'u00B' ) ) then
        return false
    endif
    if ( not ( GetOwningPlayer(GetAttacker()) == Player(3) ) ) then
        return false
    endif
    return true
endfunction

function Trig_Focused_Anger_4_Func001C takes nothing returns boolean
    if ( not ( GetUnitUserData(GetTriggerUnit()) == 15 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Focused_Anger_4_Actions takes nothing returns nothing
    if ( Trig_Focused_Anger_4_Func001C() ) then
        call DoNothing()
    else
        call IncUnitAbilityLevelSwapped('A06K', GetAttacker())
        call SetUnitUserData(GetTriggerUnit(), ( GetUnitUserData(GetTriggerUnit()) + 1 ))
        call TriggerSleepAction(6.00)
        call DecUnitAbilityLevelSwapped('A06K', GetAttacker())
        call SetUnitUserData(GetTriggerUnit(), ( GetUnitUserData(GetTriggerUnit()) - 1 ))
    endif
endfunction

//===========================================================================
function InitTrig_Focused_Anger_4 takes nothing returns nothing
    set gg_trg_Focused_Anger_4=CreateTrigger()
    call DisableTrigger(gg_trg_Focused_Anger_4)
    call TriggerRegisterPlayerUnitEventSimple(gg_trg_Focused_Anger_4, Player(6), EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddCondition(gg_trg_Focused_Anger_4, Condition(function Trig_Focused_Anger_4_Conditions))
    call TriggerAddAction(gg_trg_Focused_Anger_4, function Trig_Focused_Anger_4_Actions)
endfunction

//===========================================================================
// Trigger: Focused Anger 5
//===========================================================================
function Trig_Focused_Anger_5_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetAttacker()) == 'u00B' ) ) then
        return false
    endif
    if ( not ( GetOwningPlayer(GetAttacker()) == Player(4) ) ) then
        return false
    endif
    return true
endfunction

function Trig_Focused_Anger_5_Func001C takes nothing returns boolean
    if ( not ( GetUnitUserData(GetTriggerUnit()) == 15 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Focused_Anger_5_Actions takes nothing returns nothing
    if ( Trig_Focused_Anger_5_Func001C() ) then
        call DoNothing()
    else
        call IncUnitAbilityLevelSwapped('A06K', GetAttacker())
        call SetUnitUserData(GetTriggerUnit(), ( GetUnitUserData(GetTriggerUnit()) + 1 ))
        call TriggerSleepAction(6.00)
        call DecUnitAbilityLevelSwapped('A06K', GetAttacker())
        call SetUnitUserData(GetTriggerUnit(), ( GetUnitUserData(GetTriggerUnit()) - 1 ))
    endif
endfunction

//===========================================================================
function InitTrig_Focused_Anger_5 takes nothing returns nothing
    set gg_trg_Focused_Anger_5=CreateTrigger()
    call DisableTrigger(gg_trg_Focused_Anger_5)
    call TriggerRegisterPlayerUnitEventSimple(gg_trg_Focused_Anger_5, Player(6), EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddCondition(gg_trg_Focused_Anger_5, Condition(function Trig_Focused_Anger_5_Conditions))
    call TriggerAddAction(gg_trg_Focused_Anger_5, function Trig_Focused_Anger_5_Actions)
endfunction

//===========================================================================
// Trigger: Focused Anger 6
//===========================================================================
function Trig_Focused_Anger_6_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetAttacker()) == 'u00B' ) ) then
        return false
    endif
    if ( not ( GetOwningPlayer(GetAttacker()) == Player(5) ) ) then
        return false
    endif
    return true
endfunction

function Trig_Focused_Anger_6_Func001C takes nothing returns boolean
    if ( not ( GetUnitUserData(GetTriggerUnit()) == 15 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Focused_Anger_6_Actions takes nothing returns nothing
    if ( Trig_Focused_Anger_6_Func001C() ) then
        call DoNothing()
    else
        call IncUnitAbilityLevelSwapped('A06K', GetAttacker())
        call SetUnitUserData(GetTriggerUnit(), ( GetUnitUserData(GetTriggerUnit()) + 1 ))
        call TriggerSleepAction(6.00)
        call DecUnitAbilityLevelSwapped('A06K', GetAttacker())
        call SetUnitUserData(GetTriggerUnit(), ( GetUnitUserData(GetTriggerUnit()) - 1 ))
    endif
endfunction

//===========================================================================
function InitTrig_Focused_Anger_6 takes nothing returns nothing
    set gg_trg_Focused_Anger_6=CreateTrigger()
    call DisableTrigger(gg_trg_Focused_Anger_6)
    call TriggerRegisterPlayerUnitEventSimple(gg_trg_Focused_Anger_6, Player(6), EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddCondition(gg_trg_Focused_Anger_6, Condition(function Trig_Focused_Anger_6_Conditions))
    call TriggerAddAction(gg_trg_Focused_Anger_6, function Trig_Focused_Anger_6_Actions)
endfunction

//===========================================================================
// Trigger: Focused Anger 7
//===========================================================================
function Trig_Focused_Anger_7_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetAttacker()) == 'u00B' ) ) then
        return false
    endif
    if ( not ( GetOwningPlayer(GetAttacker()) == Player(7) ) ) then
        return false
    endif
    return true
endfunction

function Trig_Focused_Anger_7_Func001C takes nothing returns boolean
    if ( not ( GetUnitUserData(GetTriggerUnit()) == 15 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Focused_Anger_7_Actions takes nothing returns nothing
    if ( Trig_Focused_Anger_7_Func001C() ) then
        call DoNothing()
    else
        call IncUnitAbilityLevelSwapped('A06K', GetAttacker())
        call SetUnitUserData(GetTriggerUnit(), ( GetUnitUserData(GetTriggerUnit()) + 1 ))
        call TriggerSleepAction(6.00)
        call DecUnitAbilityLevelSwapped('A06K', GetAttacker())
        call SetUnitUserData(GetTriggerUnit(), ( GetUnitUserData(GetTriggerUnit()) - 1 ))
    endif
endfunction

//===========================================================================
function InitTrig_Focused_Anger_7 takes nothing returns nothing
    set gg_trg_Focused_Anger_7=CreateTrigger()
    call DisableTrigger(gg_trg_Focused_Anger_7)
    call TriggerRegisterPlayerUnitEventSimple(gg_trg_Focused_Anger_7, Player(6), EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddCondition(gg_trg_Focused_Anger_7, Condition(function Trig_Focused_Anger_7_Conditions))
    call TriggerAddAction(gg_trg_Focused_Anger_7, function Trig_Focused_Anger_7_Actions)
endfunction

//===========================================================================
// Trigger: Focused Anger 8
//===========================================================================
function Trig_Focused_Anger_8_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetAttacker()) == 'u00B' ) ) then
        return false
    endif
    if ( not ( GetOwningPlayer(GetAttacker()) == Player(8) ) ) then
        return false
    endif
    return true
endfunction

function Trig_Focused_Anger_8_Func001C takes nothing returns boolean
    if ( not ( GetUnitUserData(GetTriggerUnit()) == 15 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Focused_Anger_8_Actions takes nothing returns nothing
    if ( Trig_Focused_Anger_8_Func001C() ) then
        call DoNothing()
    else
        call IncUnitAbilityLevelSwapped('A06K', GetAttacker())
        call SetUnitUserData(GetTriggerUnit(), ( GetUnitUserData(GetTriggerUnit()) + 1 ))
        call TriggerSleepAction(6.00)
        call DecUnitAbilityLevelSwapped('A06K', GetAttacker())
        call SetUnitUserData(GetTriggerUnit(), ( GetUnitUserData(GetTriggerUnit()) - 1 ))
    endif
endfunction

//===========================================================================
function InitTrig_Focused_Anger_8 takes nothing returns nothing
    set gg_trg_Focused_Anger_8=CreateTrigger()
    call DisableTrigger(gg_trg_Focused_Anger_8)
    call TriggerRegisterPlayerUnitEventSimple(gg_trg_Focused_Anger_8, Player(6), EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddCondition(gg_trg_Focused_Anger_8, Condition(function Trig_Focused_Anger_8_Conditions))
    call TriggerAddAction(gg_trg_Focused_Anger_8, function Trig_Focused_Anger_8_Actions)
endfunction

//===========================================================================
// Trigger: Focused Anger 9
//===========================================================================
function Trig_Focused_Anger_9_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetAttacker()) == 'u00B' ) ) then
        return false
    endif
    if ( not ( GetOwningPlayer(GetAttacker()) == Player(9) ) ) then
        return false
    endif
    return true
endfunction

function Trig_Focused_Anger_9_Func001C takes nothing returns boolean
    if ( not ( GetUnitUserData(GetTriggerUnit()) == 15 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Focused_Anger_9_Actions takes nothing returns nothing
    if ( Trig_Focused_Anger_9_Func001C() ) then
        call DoNothing()
    else
        call IncUnitAbilityLevelSwapped('A06K', GetAttacker())
        call SetUnitUserData(GetTriggerUnit(), ( GetUnitUserData(GetTriggerUnit()) + 1 ))
        call TriggerSleepAction(6.00)
        call DecUnitAbilityLevelSwapped('A06K', GetAttacker())
        call SetUnitUserData(GetTriggerUnit(), ( GetUnitUserData(GetTriggerUnit()) - 1 ))
    endif
endfunction

//===========================================================================
function InitTrig_Focused_Anger_9 takes nothing returns nothing
    set gg_trg_Focused_Anger_9=CreateTrigger()
    call DisableTrigger(gg_trg_Focused_Anger_9)
    call TriggerRegisterPlayerUnitEventSimple(gg_trg_Focused_Anger_9, Player(6), EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddCondition(gg_trg_Focused_Anger_9, Condition(function Trig_Focused_Anger_9_Conditions))
    call TriggerAddAction(gg_trg_Focused_Anger_9, function Trig_Focused_Anger_9_Actions)
endfunction

//===========================================================================
// Trigger: Focused Anger 10
//===========================================================================
function Trig_Focused_Anger_10_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetAttacker()) == 'u00B' ) ) then
        return false
    endif
    if ( not ( GetOwningPlayer(GetAttacker()) == Player(10) ) ) then
        return false
    endif
    return true
endfunction

function Trig_Focused_Anger_10_Func001C takes nothing returns boolean
    if ( not ( GetUnitUserData(GetTriggerUnit()) == 15 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Focused_Anger_10_Actions takes nothing returns nothing
    if ( Trig_Focused_Anger_10_Func001C() ) then
        call DoNothing()
    else
        call IncUnitAbilityLevelSwapped('A06K', GetAttacker())
        call SetUnitUserData(GetTriggerUnit(), ( GetUnitUserData(GetTriggerUnit()) + 1 ))
        call TriggerSleepAction(6.00)
        call DecUnitAbilityLevelSwapped('A06K', GetAttacker())
        call SetUnitUserData(GetTriggerUnit(), ( GetUnitUserData(GetTriggerUnit()) - 1 ))
    endif
endfunction

//===========================================================================
function InitTrig_Focused_Anger_10 takes nothing returns nothing
    set gg_trg_Focused_Anger_10=CreateTrigger()
    call DisableTrigger(gg_trg_Focused_Anger_10)
    call TriggerRegisterPlayerUnitEventSimple(gg_trg_Focused_Anger_10, Player(6), EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddCondition(gg_trg_Focused_Anger_10, Condition(function Trig_Focused_Anger_10_Conditions))
    call TriggerAddAction(gg_trg_Focused_Anger_10, function Trig_Focused_Anger_10_Actions)
endfunction

//===========================================================================
// Trigger: Focused Anger Trigger
//===========================================================================
function Trig_Focused_Anger_Trigger_Conditions takes nothing returns boolean
    if ( not ( GetResearched() == 'R04T' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Focused_Anger_Trigger_Actions takes nothing returns nothing
    call EnableTrigger(gg_trg_Focused_Anger_1)
endfunction

//===========================================================================
function InitTrig_Focused_Anger_Trigger takes nothing returns nothing
    set gg_trg_Focused_Anger_Trigger=CreateTrigger()
    call TriggerRegisterPlayerUnitEventSimple(gg_trg_Focused_Anger_Trigger, Player(0), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    call TriggerAddCondition(gg_trg_Focused_Anger_Trigger, Condition(function Trig_Focused_Anger_Trigger_Conditions))
    call TriggerAddAction(gg_trg_Focused_Anger_Trigger, function Trig_Focused_Anger_Trigger_Actions)
endfunction

//===========================================================================
// Trigger: Focused Anger Trigger Copy
//===========================================================================
function Trig_Focused_Anger_Trigger_Copy_Conditions takes nothing returns boolean
    if ( not ( GetResearched() == 'R04T' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Focused_Anger_Trigger_Copy_Actions takes nothing returns nothing
    call EnableTrigger(gg_trg_Focused_Anger_2)
endfunction

//===========================================================================
function InitTrig_Focused_Anger_Trigger_Copy takes nothing returns nothing
    set gg_trg_Focused_Anger_Trigger_Copy=CreateTrigger()
    call TriggerRegisterPlayerUnitEventSimple(gg_trg_Focused_Anger_Trigger_Copy, Player(1), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    call TriggerAddCondition(gg_trg_Focused_Anger_Trigger_Copy, Condition(function Trig_Focused_Anger_Trigger_Copy_Conditions))
    call TriggerAddAction(gg_trg_Focused_Anger_Trigger_Copy, function Trig_Focused_Anger_Trigger_Copy_Actions)
endfunction

//===========================================================================
// Trigger: Focused Anger Trigger Copy 2
//===========================================================================
function Trig_Focused_Anger_Trigger_Copy_2_Conditions takes nothing returns boolean
    if ( not ( GetResearched() == 'R04T' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Focused_Anger_Trigger_Copy_2_Actions takes nothing returns nothing
    call EnableTrigger(gg_trg_Focused_Anger_3)
endfunction

//===========================================================================
function InitTrig_Focused_Anger_Trigger_Copy_2 takes nothing returns nothing
    set gg_trg_Focused_Anger_Trigger_Copy_2=CreateTrigger()
    call TriggerRegisterPlayerUnitEventSimple(gg_trg_Focused_Anger_Trigger_Copy_2, Player(2), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    call TriggerAddCondition(gg_trg_Focused_Anger_Trigger_Copy_2, Condition(function Trig_Focused_Anger_Trigger_Copy_2_Conditions))
    call TriggerAddAction(gg_trg_Focused_Anger_Trigger_Copy_2, function Trig_Focused_Anger_Trigger_Copy_2_Actions)
endfunction

//===========================================================================
// Trigger: Focused Anger Trigger Copy 3
//===========================================================================
function Trig_Focused_Anger_Trigger_Copy_3_Conditions takes nothing returns boolean
    if ( not ( GetResearched() == 'R04T' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Focused_Anger_Trigger_Copy_3_Actions takes nothing returns nothing
    call EnableTrigger(gg_trg_Focused_Anger_4)
endfunction

//===========================================================================
function InitTrig_Focused_Anger_Trigger_Copy_3 takes nothing returns nothing
    set gg_trg_Focused_Anger_Trigger_Copy_3=CreateTrigger()
    call TriggerRegisterPlayerUnitEventSimple(gg_trg_Focused_Anger_Trigger_Copy_3, Player(3), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    call TriggerAddCondition(gg_trg_Focused_Anger_Trigger_Copy_3, Condition(function Trig_Focused_Anger_Trigger_Copy_3_Conditions))
    call TriggerAddAction(gg_trg_Focused_Anger_Trigger_Copy_3, function Trig_Focused_Anger_Trigger_Copy_3_Actions)
endfunction

//===========================================================================
// Trigger: Focused Anger Trigger Copy 4
//===========================================================================
function Trig_Focused_Anger_Trigger_Copy_4_Conditions takes nothing returns boolean
    if ( not ( GetResearched() == 'R04T' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Focused_Anger_Trigger_Copy_4_Actions takes nothing returns nothing
    call EnableTrigger(gg_trg_Focused_Anger_5)
endfunction

//===========================================================================
function InitTrig_Focused_Anger_Trigger_Copy_4 takes nothing returns nothing
    set gg_trg_Focused_Anger_Trigger_Copy_4=CreateTrigger()
    call TriggerRegisterPlayerUnitEventSimple(gg_trg_Focused_Anger_Trigger_Copy_4, Player(4), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    call TriggerAddCondition(gg_trg_Focused_Anger_Trigger_Copy_4, Condition(function Trig_Focused_Anger_Trigger_Copy_4_Conditions))
    call TriggerAddAction(gg_trg_Focused_Anger_Trigger_Copy_4, function Trig_Focused_Anger_Trigger_Copy_4_Actions)
endfunction

//===========================================================================
// Trigger: Focused Anger Trigger Copy 5
//===========================================================================
function Trig_Focused_Anger_Trigger_Copy_5_Conditions takes nothing returns boolean
    if ( not ( GetResearched() == 'R04T' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Focused_Anger_Trigger_Copy_5_Actions takes nothing returns nothing
    call EnableTrigger(gg_trg_Focused_Anger_6)
endfunction

//===========================================================================
function InitTrig_Focused_Anger_Trigger_Copy_5 takes nothing returns nothing
    set gg_trg_Focused_Anger_Trigger_Copy_5=CreateTrigger()
    call TriggerRegisterPlayerUnitEventSimple(gg_trg_Focused_Anger_Trigger_Copy_5, Player(5), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    call TriggerAddCondition(gg_trg_Focused_Anger_Trigger_Copy_5, Condition(function Trig_Focused_Anger_Trigger_Copy_5_Conditions))
    call TriggerAddAction(gg_trg_Focused_Anger_Trigger_Copy_5, function Trig_Focused_Anger_Trigger_Copy_5_Actions)
endfunction

//===========================================================================
// Trigger: Focused Anger Trigger Copy 6
//===========================================================================
function Trig_Focused_Anger_Trigger_Copy_6_Conditions takes nothing returns boolean
    if ( not ( GetResearched() == 'R04T' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Focused_Anger_Trigger_Copy_6_Actions takes nothing returns nothing
    call EnableTrigger(gg_trg_Focused_Anger_7)
endfunction

//===========================================================================
function InitTrig_Focused_Anger_Trigger_Copy_6 takes nothing returns nothing
    set gg_trg_Focused_Anger_Trigger_Copy_6=CreateTrigger()
    call TriggerRegisterPlayerUnitEventSimple(gg_trg_Focused_Anger_Trigger_Copy_6, Player(7), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    call TriggerAddCondition(gg_trg_Focused_Anger_Trigger_Copy_6, Condition(function Trig_Focused_Anger_Trigger_Copy_6_Conditions))
    call TriggerAddAction(gg_trg_Focused_Anger_Trigger_Copy_6, function Trig_Focused_Anger_Trigger_Copy_6_Actions)
endfunction

//===========================================================================
// Trigger: Focused Anger Trigger Copy 7
//===========================================================================
function Trig_Focused_Anger_Trigger_Copy_7_Conditions takes nothing returns boolean
    if ( not ( GetResearched() == 'R04T' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Focused_Anger_Trigger_Copy_7_Actions takes nothing returns nothing
    call EnableTrigger(gg_trg_Focused_Anger_8)
endfunction

//===========================================================================
function InitTrig_Focused_Anger_Trigger_Copy_7 takes nothing returns nothing
    set gg_trg_Focused_Anger_Trigger_Copy_7=CreateTrigger()
    call TriggerRegisterPlayerUnitEventSimple(gg_trg_Focused_Anger_Trigger_Copy_7, Player(8), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    call TriggerAddCondition(gg_trg_Focused_Anger_Trigger_Copy_7, Condition(function Trig_Focused_Anger_Trigger_Copy_7_Conditions))
    call TriggerAddAction(gg_trg_Focused_Anger_Trigger_Copy_7, function Trig_Focused_Anger_Trigger_Copy_7_Actions)
endfunction

//===========================================================================
// Trigger: Focused Anger Trigger Copy 8
//===========================================================================
function Trig_Focused_Anger_Trigger_Copy_8_Conditions takes nothing returns boolean
    if ( not ( GetResearched() == 'R04T' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Focused_Anger_Trigger_Copy_8_Actions takes nothing returns nothing
    call EnableTrigger(gg_trg_Focused_Anger_9)
endfunction

//===========================================================================
function InitTrig_Focused_Anger_Trigger_Copy_8 takes nothing returns nothing
    set gg_trg_Focused_Anger_Trigger_Copy_8=CreateTrigger()
    call TriggerRegisterPlayerUnitEventSimple(gg_trg_Focused_Anger_Trigger_Copy_8, Player(9), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    call TriggerAddCondition(gg_trg_Focused_Anger_Trigger_Copy_8, Condition(function Trig_Focused_Anger_Trigger_Copy_8_Conditions))
    call TriggerAddAction(gg_trg_Focused_Anger_Trigger_Copy_8, function Trig_Focused_Anger_Trigger_Copy_8_Actions)
endfunction

//===========================================================================
// Trigger: Focused Anger Trigger Copy 9
//===========================================================================
function Trig_Focused_Anger_Trigger_Copy_9_Conditions takes nothing returns boolean
    if ( not ( GetResearched() == 'R04T' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Focused_Anger_Trigger_Copy_9_Actions takes nothing returns nothing
    call EnableTrigger(gg_trg_Focused_Anger_10)
endfunction

//===========================================================================
function InitTrig_Focused_Anger_Trigger_Copy_9 takes nothing returns nothing
    set gg_trg_Focused_Anger_Trigger_Copy_9=CreateTrigger()
    call TriggerRegisterPlayerUnitEventSimple(gg_trg_Focused_Anger_Trigger_Copy_9, Player(10), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    call TriggerAddCondition(gg_trg_Focused_Anger_Trigger_Copy_9, Condition(function Trig_Focused_Anger_Trigger_Copy_9_Conditions))
    call TriggerAddAction(gg_trg_Focused_Anger_Trigger_Copy_9, function Trig_Focused_Anger_Trigger_Copy_9_Actions)
endfunction

//===========================================================================
// Trigger: Feast of Souls
//===========================================================================
function Trig_Feast_of_Souls_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A05Z' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Feast_of_Souls_Actions takes nothing returns nothing
    call SetUnitLifeBJ(GetSpellAbilityUnit(), ( GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) + 700.00 ))
endfunction

//===========================================================================
function InitTrig_Feast_of_Souls takes nothing returns nothing
    set gg_trg_Feast_of_Souls=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Feast_of_Souls, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Feast_of_Souls, Condition(function Trig_Feast_of_Souls_Conditions))
    call TriggerAddAction(gg_trg_Feast_of_Souls, function Trig_Feast_of_Souls_Actions)
endfunction

//===========================================================================
// Trigger: Soul Strike
//===========================================================================
function Trig_Soul_Strike_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A05O' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Soul_Strike_Actions takes nothing returns nothing
    call SetUnitLifeBJ(GetSpellAbilityUnit(), ( GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) + 200.00 ))
endfunction

//===========================================================================
function InitTrig_Soul_Strike takes nothing returns nothing
    set gg_trg_Soul_Strike=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Soul_Strike, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Soul_Strike, Condition(function Trig_Soul_Strike_Conditions))
    call TriggerAddAction(gg_trg_Soul_Strike, function Trig_Soul_Strike_Actions)
endfunction

//===========================================================================
// Trigger: Avatar
//===========================================================================
function Trig_Avatar_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A078' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Avatar_Actions takes nothing returns nothing
    call CreateNUnitsAtLoc(1, 'h04L', GetOwningPlayer(GetTriggerUnit()), GetUnitLoc(GetTriggerUnit()), bj_UNIT_FACING)
    call IssueTargetOrderBJ(GetLastCreatedUnit(), "bloodlust", GetSpellAbilityUnit())
    call UnitApplyTimedLifeBJ(1.00, 'BTLF', GetLastCreatedUnit())
    call SetUnitAbilityLevelSwapped('A067', GetTriggerUnit(), 2)
    call TriggerSleepAction(10.00)
    call SetUnitAbilityLevelSwapped('A067', GetTriggerUnit(), 1)
endfunction

//===========================================================================
function InitTrig_Avatar takes nothing returns nothing
    set gg_trg_Avatar=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Avatar, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(gg_trg_Avatar, Condition(function Trig_Avatar_Conditions))
    call TriggerAddAction(gg_trg_Avatar, function Trig_Avatar_Actions)
endfunction

//===========================================================================
// Trigger: Acidic Blood
//===========================================================================
function Trig_Acidic_Blood_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A05L' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Acidic_Blood_Func001C takes nothing returns boolean
    if ( not ( GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) <= 150.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Acidic_Blood_Actions takes nothing returns nothing
    if ( Trig_Acidic_Blood_Func001C() ) then
        call IssueImmediateOrderBJ(GetSpellAbilityUnit(), "stop")
    else
        call SetUnitLifeBJ(GetSpellAbilityUnit(), ( GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) - 150.00 ))
    endif
endfunction

//===========================================================================
function InitTrig_Acidic_Blood takes nothing returns nothing
    set gg_trg_Acidic_Blood=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Acidic_Blood, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(gg_trg_Acidic_Blood, Condition(function Trig_Acidic_Blood_Conditions))
    call TriggerAddAction(gg_trg_Acidic_Blood, function Trig_Acidic_Blood_Actions)
endfunction

//===========================================================================
// Trigger: Binding Shadows
//===========================================================================
function Trig_Binding_Shadows_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A05M' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Binding_Shadows_Func001C takes nothing returns boolean
    if ( not ( GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) <= 200.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Binding_Shadows_Actions takes nothing returns nothing
    if ( Trig_Binding_Shadows_Func001C() ) then
        call IssueImmediateOrderBJ(GetSpellAbilityUnit(), "stop")
    else
        call SetUnitLifeBJ(GetSpellAbilityUnit(), ( GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) - 200.00 ))
    endif
endfunction

//===========================================================================
function InitTrig_Binding_Shadows takes nothing returns nothing
    set gg_trg_Binding_Shadows=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Binding_Shadows, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(gg_trg_Binding_Shadows, Condition(function Trig_Binding_Shadows_Conditions))
    call TriggerAddAction(gg_trg_Binding_Shadows, function Trig_Binding_Shadows_Actions)
endfunction

//===========================================================================
// Trigger: Cobalt Blood
//===========================================================================
function Trig_Cobalt_Blood_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A068' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Cobalt_Blood_Func001C takes nothing returns boolean
    if ( not ( GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) <= 200.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Cobalt_Blood_Actions takes nothing returns nothing
    if ( Trig_Cobalt_Blood_Func001C() ) then
        call IssueImmediateOrderBJ(GetSpellAbilityUnit(), "stop")
    else
        call SetUnitLifeBJ(GetSpellAbilityUnit(), ( GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) - 200.00 ))
    endif
endfunction

//===========================================================================
function InitTrig_Cobalt_Blood takes nothing returns nothing
    set gg_trg_Cobalt_Blood=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Cobalt_Blood, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(gg_trg_Cobalt_Blood, Condition(function Trig_Cobalt_Blood_Conditions))
    call TriggerAddAction(gg_trg_Cobalt_Blood, function Trig_Cobalt_Blood_Actions)
endfunction

//===========================================================================
// Trigger: Glowing Blood
//===========================================================================
function Trig_Glowing_Blood_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A064' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Glowing_Blood_Func001C takes nothing returns boolean
    if ( not ( GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) <= 50.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Glowing_Blood_Actions takes nothing returns nothing
    if ( Trig_Glowing_Blood_Func001C() ) then
        call IssueImmediateOrderBJ(GetSpellAbilityUnit(), "stop")
    else
        call SetUnitLifeBJ(GetSpellAbilityUnit(), ( GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) - 50.00 ))
    endif
endfunction

//===========================================================================
function InitTrig_Glowing_Blood takes nothing returns nothing
    set gg_trg_Glowing_Blood=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Glowing_Blood, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(gg_trg_Glowing_Blood, Condition(function Trig_Glowing_Blood_Conditions))
    call TriggerAddAction(gg_trg_Glowing_Blood, function Trig_Glowing_Blood_Actions)
endfunction

//===========================================================================
// Trigger: Psychic Slam
//===========================================================================
function Trig_Psychic_Slam_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A063' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Psychic_Slam_Func001C takes nothing returns boolean
    if ( not ( GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) <= 300.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Psychic_Slam_Actions takes nothing returns nothing
    if ( Trig_Psychic_Slam_Func001C() ) then
        call IssueImmediateOrderBJ(GetSpellAbilityUnit(), "stop")
    else
        call SetUnitLifeBJ(GetSpellAbilityUnit(), ( GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) - 300.00 ))
    endif
endfunction

//===========================================================================
function InitTrig_Psychic_Slam takes nothing returns nothing
    set gg_trg_Psychic_Slam=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Psychic_Slam, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(gg_trg_Psychic_Slam, Condition(function Trig_Psychic_Slam_Conditions))
    call TriggerAddAction(gg_trg_Psychic_Slam, function Trig_Psychic_Slam_Actions)
endfunction

//===========================================================================
// Trigger: Soul Rend
//===========================================================================
function Trig_Soul_Rend_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A069' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Soul_Rend_Func001C takes nothing returns boolean
    if ( not ( GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) <= 350.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Soul_Rend_Actions takes nothing returns nothing
    if ( Trig_Soul_Rend_Func001C() ) then
        call IssueImmediateOrderBJ(GetSpellAbilityUnit(), "stop")
    else
        call SetUnitLifeBJ(GetSpellAbilityUnit(), ( GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) - 350.00 ))
        call SetUnitLifeBJ(GetSpellTargetUnit(), ( GetUnitStateSwap(UNIT_STATE_LIFE, GetSpellTargetUnit()) - 500.00 ))
    endif
endfunction

//===========================================================================
function InitTrig_Soul_Rend takes nothing returns nothing
    set gg_trg_Soul_Rend=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Soul_Rend, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(gg_trg_Soul_Rend, Condition(function Trig_Soul_Rend_Conditions))
    call TriggerAddAction(gg_trg_Soul_Rend, function Trig_Soul_Rend_Actions)
endfunction

//===========================================================================
// Trigger: Dark Blood
//===========================================================================
function Trig_Dark_Blood_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A062' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Dark_Blood_Func001C takes nothing returns boolean
    if ( not ( GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) <= 400.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Dark_Blood_Actions takes nothing returns nothing
    if ( Trig_Dark_Blood_Func001C() ) then
        call IssueImmediateOrderBJ(GetSpellAbilityUnit(), "stop")
    else
        call SetUnitLifeBJ(GetSpellAbilityUnit(), ( GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) - 400.00 ))
    endif
endfunction

//===========================================================================
function InitTrig_Dark_Blood takes nothing returns nothing
    set gg_trg_Dark_Blood=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Dark_Blood, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(gg_trg_Dark_Blood, Condition(function Trig_Dark_Blood_Conditions))
    call TriggerAddAction(gg_trg_Dark_Blood, function Trig_Dark_Blood_Actions)
endfunction

//===========================================================================
// Trigger: Shadowlings
//===========================================================================
function Trig_Shadowlings_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetSummonedUnit()) == 'o01T' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Shadowlings_Actions takes nothing returns nothing
    call TriggerSleepAction(20.00)
    call KillUnit(GetSummonedUnit())
endfunction

//===========================================================================
function InitTrig_Shadowlings takes nothing returns nothing
    set gg_trg_Shadowlings=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Shadowlings, EVENT_PLAYER_UNIT_SUMMON)
    call TriggerAddCondition(gg_trg_Shadowlings, Condition(function Trig_Shadowlings_Conditions))
    call TriggerAddAction(gg_trg_Shadowlings, function Trig_Shadowlings_Actions)
endfunction

//===========================================================================
// Trigger: Levelled Drain
//===========================================================================
function Trig_Levelled_Drain_Conditions takes nothing returns boolean
    if ( not ( GetResearched() == 'R043' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Levelled_Drain_Func001002 takes nothing returns nothing
    call IncUnitAbilityLevelSwapped('A065', GetEnumUnit())
endfunction

function Trig_Levelled_Drain_Actions takes nothing returns nothing
    call ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(0), 'u009'), function Trig_Levelled_Drain_Func001002)
endfunction

//===========================================================================
function InitTrig_Levelled_Drain takes nothing returns nothing
    set gg_trg_Levelled_Drain=CreateTrigger()
    call TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Drain, Player(0), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    call TriggerAddCondition(gg_trg_Levelled_Drain, Condition(function Trig_Levelled_Drain_Conditions))
    call TriggerAddAction(gg_trg_Levelled_Drain, function Trig_Levelled_Drain_Actions)
endfunction

//===========================================================================
// Trigger: Levelled Drain Copy
//===========================================================================
function Trig_Levelled_Drain_Copy_Conditions takes nothing returns boolean
    if ( not ( GetResearched() == 'R043' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Levelled_Drain_Copy_Func001002 takes nothing returns nothing
    call IncUnitAbilityLevelSwapped('A065', GetEnumUnit())
endfunction

function Trig_Levelled_Drain_Copy_Actions takes nothing returns nothing
    call ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(1), 'u009'), function Trig_Levelled_Drain_Copy_Func001002)
endfunction

//===========================================================================
function InitTrig_Levelled_Drain_Copy takes nothing returns nothing
    set gg_trg_Levelled_Drain_Copy=CreateTrigger()
    call TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Drain_Copy, Player(1), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    call TriggerAddCondition(gg_trg_Levelled_Drain_Copy, Condition(function Trig_Levelled_Drain_Copy_Conditions))
    call TriggerAddAction(gg_trg_Levelled_Drain_Copy, function Trig_Levelled_Drain_Copy_Actions)
endfunction

//===========================================================================
// Trigger: Levelled Drain Copy 2
//===========================================================================
function Trig_Levelled_Drain_Copy_2_Conditions takes nothing returns boolean
    if ( not ( GetResearched() == 'R043' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Levelled_Drain_Copy_2_Func001002 takes nothing returns nothing
    call IncUnitAbilityLevelSwapped('A065', GetEnumUnit())
endfunction

function Trig_Levelled_Drain_Copy_2_Actions takes nothing returns nothing
    call ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(2), 'u009'), function Trig_Levelled_Drain_Copy_2_Func001002)
endfunction

//===========================================================================
function InitTrig_Levelled_Drain_Copy_2 takes nothing returns nothing
    set gg_trg_Levelled_Drain_Copy_2=CreateTrigger()
    call TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Drain_Copy_2, Player(2), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    call TriggerAddCondition(gg_trg_Levelled_Drain_Copy_2, Condition(function Trig_Levelled_Drain_Copy_2_Conditions))
    call TriggerAddAction(gg_trg_Levelled_Drain_Copy_2, function Trig_Levelled_Drain_Copy_2_Actions)
endfunction

//===========================================================================
// Trigger: Levelled Drain Copy 3
//===========================================================================
function Trig_Levelled_Drain_Copy_3_Conditions takes nothing returns boolean
    if ( not ( GetResearched() == 'R043' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Levelled_Drain_Copy_3_Func001002 takes nothing returns nothing
    call IncUnitAbilityLevelSwapped('A065', GetEnumUnit())
endfunction

function Trig_Levelled_Drain_Copy_3_Actions takes nothing returns nothing
    call ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(3), 'u009'), function Trig_Levelled_Drain_Copy_3_Func001002)
endfunction

//===========================================================================
function InitTrig_Levelled_Drain_Copy_3 takes nothing returns nothing
    set gg_trg_Levelled_Drain_Copy_3=CreateTrigger()
    call TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Drain_Copy_3, Player(3), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    call TriggerAddCondition(gg_trg_Levelled_Drain_Copy_3, Condition(function Trig_Levelled_Drain_Copy_3_Conditions))
    call TriggerAddAction(gg_trg_Levelled_Drain_Copy_3, function Trig_Levelled_Drain_Copy_3_Actions)
endfunction

//===========================================================================
// Trigger: Levelled Drain Copy 4
//===========================================================================
function Trig_Levelled_Drain_Copy_4_Conditions takes nothing returns boolean
    if ( not ( GetResearched() == 'R043' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Levelled_Drain_Copy_4_Func001002 takes nothing returns nothing
    call IncUnitAbilityLevelSwapped('A065', GetEnumUnit())
endfunction

function Trig_Levelled_Drain_Copy_4_Actions takes nothing returns nothing
    call ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(4), 'u009'), function Trig_Levelled_Drain_Copy_4_Func001002)
endfunction

//===========================================================================
function InitTrig_Levelled_Drain_Copy_4 takes nothing returns nothing
    set gg_trg_Levelled_Drain_Copy_4=CreateTrigger()
    call TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Drain_Copy_4, Player(4), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    call TriggerAddCondition(gg_trg_Levelled_Drain_Copy_4, Condition(function Trig_Levelled_Drain_Copy_4_Conditions))
    call TriggerAddAction(gg_trg_Levelled_Drain_Copy_4, function Trig_Levelled_Drain_Copy_4_Actions)
endfunction

//===========================================================================
// Trigger: Levelled Drain Copy 5
//===========================================================================
function Trig_Levelled_Drain_Copy_5_Conditions takes nothing returns boolean
    if ( not ( GetResearched() == 'R043' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Levelled_Drain_Copy_5_Func001002 takes nothing returns nothing
    call IncUnitAbilityLevelSwapped('A065', GetEnumUnit())
endfunction

function Trig_Levelled_Drain_Copy_5_Actions takes nothing returns nothing
    call ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(5), 'u009'), function Trig_Levelled_Drain_Copy_5_Func001002)
endfunction

//===========================================================================
function InitTrig_Levelled_Drain_Copy_5 takes nothing returns nothing
    set gg_trg_Levelled_Drain_Copy_5=CreateTrigger()
    call TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Drain_Copy_5, Player(5), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    call TriggerAddCondition(gg_trg_Levelled_Drain_Copy_5, Condition(function Trig_Levelled_Drain_Copy_5_Conditions))
    call TriggerAddAction(gg_trg_Levelled_Drain_Copy_5, function Trig_Levelled_Drain_Copy_5_Actions)
endfunction

//===========================================================================
// Trigger: Levelled Drain Copy 6
//===========================================================================
function Trig_Levelled_Drain_Copy_6_Conditions takes nothing returns boolean
    if ( not ( GetResearched() == 'R043' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Levelled_Drain_Copy_6_Func001002 takes nothing returns nothing
    call IncUnitAbilityLevelSwapped('A065', GetEnumUnit())
endfunction

function Trig_Levelled_Drain_Copy_6_Actions takes nothing returns nothing
    call ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(7), 'u009'), function Trig_Levelled_Drain_Copy_6_Func001002)
endfunction

//===========================================================================
function InitTrig_Levelled_Drain_Copy_6 takes nothing returns nothing
    set gg_trg_Levelled_Drain_Copy_6=CreateTrigger()
    call TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Drain_Copy_6, Player(7), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    call TriggerAddCondition(gg_trg_Levelled_Drain_Copy_6, Condition(function Trig_Levelled_Drain_Copy_6_Conditions))
    call TriggerAddAction(gg_trg_Levelled_Drain_Copy_6, function Trig_Levelled_Drain_Copy_6_Actions)
endfunction

//===========================================================================
// Trigger: Levelled Drain Copy 7
//===========================================================================
function Trig_Levelled_Drain_Copy_7_Conditions takes nothing returns boolean
    if ( not ( GetResearched() == 'R043' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Levelled_Drain_Copy_7_Func001002 takes nothing returns nothing
    call IncUnitAbilityLevelSwapped('A065', GetEnumUnit())
endfunction

function Trig_Levelled_Drain_Copy_7_Actions takes nothing returns nothing
    call ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(8), 'u009'), function Trig_Levelled_Drain_Copy_7_Func001002)
endfunction

//===========================================================================
function InitTrig_Levelled_Drain_Copy_7 takes nothing returns nothing
    set gg_trg_Levelled_Drain_Copy_7=CreateTrigger()
    call TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Drain_Copy_7, Player(8), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    call TriggerAddCondition(gg_trg_Levelled_Drain_Copy_7, Condition(function Trig_Levelled_Drain_Copy_7_Conditions))
    call TriggerAddAction(gg_trg_Levelled_Drain_Copy_7, function Trig_Levelled_Drain_Copy_7_Actions)
endfunction

//===========================================================================
// Trigger: Levelled Drain Copy 8
//===========================================================================
function Trig_Levelled_Drain_Copy_8_Conditions takes nothing returns boolean
    if ( not ( GetResearched() == 'R043' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Levelled_Drain_Copy_8_Func001002 takes nothing returns nothing
    call IncUnitAbilityLevelSwapped('A065', GetEnumUnit())
endfunction

function Trig_Levelled_Drain_Copy_8_Actions takes nothing returns nothing
    call ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(9), 'u009'), function Trig_Levelled_Drain_Copy_8_Func001002)
endfunction

//===========================================================================
function InitTrig_Levelled_Drain_Copy_8 takes nothing returns nothing
    set gg_trg_Levelled_Drain_Copy_8=CreateTrigger()
    call TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Drain_Copy_8, Player(9), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    call TriggerAddCondition(gg_trg_Levelled_Drain_Copy_8, Condition(function Trig_Levelled_Drain_Copy_8_Conditions))
    call TriggerAddAction(gg_trg_Levelled_Drain_Copy_8, function Trig_Levelled_Drain_Copy_8_Actions)
endfunction

//===========================================================================
// Trigger: Levelled Drain Copy 9
//===========================================================================
function Trig_Levelled_Drain_Copy_9_Conditions takes nothing returns boolean
    if ( not ( GetResearched() == 'R043' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Levelled_Drain_Copy_9_Func001002 takes nothing returns nothing
    call IncUnitAbilityLevelSwapped('A065', GetEnumUnit())
endfunction

function Trig_Levelled_Drain_Copy_9_Actions takes nothing returns nothing
    call ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(10), 'u009'), function Trig_Levelled_Drain_Copy_9_Func001002)
endfunction

//===========================================================================
function InitTrig_Levelled_Drain_Copy_9 takes nothing returns nothing
    set gg_trg_Levelled_Drain_Copy_9=CreateTrigger()
    call TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Drain_Copy_9, Player(10), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    call TriggerAddCondition(gg_trg_Levelled_Drain_Copy_9, Condition(function Trig_Levelled_Drain_Copy_9_Conditions))
    call TriggerAddAction(gg_trg_Levelled_Drain_Copy_9, function Trig_Levelled_Drain_Copy_9_Actions)
endfunction

//===========================================================================
// Trigger: Drain Setup
//
// ncld_Ability - Ability - The ability that will be used to trigger the spell. *** It doesn't have to be based on Life Drain!
// ncld_DrainHP - Real - The amount of HP drained per second at level 1.
// ncld_DrainHPUp - Real - The extra amount of HP drained per second per level.
// ncld_DrainMP - Real - The amount of MP drained per second at level 1.
// ncld_DrainMPUp - Real - The extra amount of MP drained per second per level.
// ncld_Duration - Real - How long the spell will last at level 1.
// ncld_DurationUp - Real - Extra seconds duration per level.
// ncld_Range - Real - The maximum distance between caster and target before cancel at level 1.
// ncld_RangeUp - Real - Range upgrade amount.
// ncld_LightningArt - Lightning Type - The lightning effect art that will be used.
//===========================================================================
function Trig_Drain_Setup_Actions takes nothing returns nothing
    set udg_ncld_Ability='A065'
    set udg_ncld_DrainHP=20.00
    set udg_ncld_DrainHPUp=5.00
    set udg_ncld_DrainMP=0.00
    set udg_ncld_DrainMPUp=0.00
    set udg_ncld_Duration=5.00
    set udg_ncld_Duration_Up=0.00
    set udg_ncld_Range=950.00
    set udg_ncld_RangeUp=0.00
    set udg_ncld_LightningArt="DRAB"
    set udg_ncld_TargetSFXArt="Abilities\\Spells\\Other\\Drain\\DrainTarget.mdl"
    set udg_ncld_CasterSFXArt="Abilities\\Spells\\Other\\Drain\\DrainCaster.mdl"
    // Performance settings - how many loops between the actual drains and the distance checks, respectively
    set udg_ncld_FreqDrain=1
    set udg_ncld_FreqDistance=20
    // Ethereal Bonus
    set udg_ncld_EtherealBonus=1.50
    // Setup all buffs that will break life drain
    set udg_ncld_buffId=( udg_ncld_buffId + 1 )
    set udg_ncld_BuffList[udg_ncld_buffId]='BOwk'
    // Checks - any of these well cancel the spell
    set udg_ncld_CheckImmune=false
    set udg_ncld_CheckResistant=false
    set udg_ncld_CheckVisibile=false
    // Don't edit below, the values are being adjusted to be used more than once a second
    set udg_tempReal=( I2R(udg_ncld_FreqDrain) * 0.03 )
    set udg_ncld_DrainHP=( udg_ncld_DrainHP * udg_tempReal )
    set udg_ncld_DrainHPUp=( udg_ncld_DrainHPUp * udg_tempReal )
    set udg_ncld_DrainMP=( udg_ncld_DrainMP * udg_tempReal )
    set udg_ncld_DrainMPUp=( udg_ncld_DrainMPUp * udg_tempReal )
endfunction

//===========================================================================
function InitTrig_Drain_Setup takes nothing returns nothing
    set gg_trg_Drain_Setup=CreateTrigger()
    call TriggerAddAction(gg_trg_Drain_Setup, function Trig_Drain_Setup_Actions)
endfunction

//===========================================================================
// Trigger: Drain Cast
//===========================================================================
function Trig_Drain_Cast_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == udg_ncld_Ability ) ) then
        return false
    endif
    return true
endfunction

function Trig_Drain_Cast_Func031C takes nothing returns boolean
    if ( not ( IsTriggerEnabled(gg_trg_Drain_Loop) == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_Drain_Cast_Actions takes nothing returns nothing
    // gather data
    set udg_tempUnit=GetTriggerUnit()
    set udg_Key=GetUnitUserData(udg_tempUnit)
    set udg_ncld_Target[udg_Key]=GetSpellTargetUnit()
    call GroupAddUnitSimple(udg_tempUnit, udg_ncld_Group)
    set udg_ncld_Tick[udg_Key]=0
    // set instance's values
    set udg_ncld_TicksRemaining[udg_Key]=R2I(( ( udg_ncld_Duration + ( udg_ncld_Duration_Up * I2R(( GetUnitAbilityLevelSwapped(udg_ncld_Ability, udg_tempUnit) - 1 )) ) ) * 33.00 ))
    set udg_ncld_Hp[udg_Key]=( udg_ncld_DrainHP + ( udg_ncld_DrainHPUp * I2R(( GetUnitAbilityLevelSwapped(udg_ncld_Ability, udg_tempUnit) - 1 )) ) )
    set udg_ncld_Mp[udg_Key]=( udg_ncld_DrainMP + ( udg_ncld_DrainMPUp * I2R(( GetUnitAbilityLevelSwapped(udg_ncld_Ability, udg_tempUnit) - 1 )) ) )
    set udg_ncld_Rng[udg_Key]=( udg_ncld_Range + ( udg_ncld_RangeUp * I2R(( GetUnitAbilityLevelSwapped(udg_ncld_Ability, udg_tempUnit) - 1 )) ) )
    // coords of source unit
    set udg_tempLoc1=GetUnitLoc(udg_tempUnit)
    set udg_tempX1=GetLocationX(udg_tempLoc1)
    set udg_tempY1=GetLocationY(udg_tempLoc1)
    set udg_tempZ1=GetLocationZ(udg_tempLoc1) + GetUnitFlyHeight(udg_tempUnit) + 60
    call RemoveLocation(udg_tempLoc1)
    // coords of target
    set udg_tempLoc1=GetUnitLoc(udg_ncld_Target[udg_Key])
    set udg_tempX2=GetLocationX(udg_tempLoc1)
    set udg_tempY2=GetLocationY(udg_tempLoc1)
    set udg_tempZ2=GetLocationZ(udg_tempLoc1) + GetUnitFlyHeight(udg_ncld_Target[udg_Key]) + 60
    call RemoveLocation(udg_tempLoc1)
    // create lightning, sfx
    set udg_ncld_Lightning[udg_Key]=AddLightningEx(udg_ncld_LightningArt, true, udg_tempX1, udg_tempY1, udg_tempZ1, udg_tempX2, udg_tempY2, udg_tempZ2)
    call AddSpecialEffectTargetUnitBJ("chest", udg_tempUnit, udg_ncld_CasterSFXArt)
    set udg_ncld_CasterSFX[udg_Key]=GetLastCreatedEffectBJ()
    call AddSpecialEffectTargetUnitBJ("chest", udg_ncld_Target[udg_Key], udg_ncld_TargetSFXArt)
    set udg_ncld_TargetSFX[udg_Key]=GetLastCreatedEffectBJ()
    // enable trigger
    if ( Trig_Drain_Cast_Func031C() ) then
        call EnableTrigger(gg_trg_Drain_Loop)
    else
    endif
endfunction

//===========================================================================
function InitTrig_Drain_Cast takes nothing returns nothing
    set gg_trg_Drain_Cast=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Drain_Cast, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Drain_Cast, Condition(function Trig_Drain_Cast_Conditions))
    call TriggerAddAction(gg_trg_Drain_Cast, function Trig_Drain_Cast_Actions)
endfunction

//===========================================================================
// Trigger: Drain Loop
//===========================================================================
function Trig_Drain_Loop_Func001Func005Func023Func001Func002C takes nothing returns boolean
    if ( not ( IsUnitType(udg_ncld_Target[udg_Key], UNIT_TYPE_ETHEREAL) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Drain_Loop_Func001Func005Func023Func001C takes nothing returns boolean
    if ( not ( IsUnitType(udg_ncld_Target[udg_Key], UNIT_TYPE_MAGIC_IMMUNE) == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_Drain_Loop_Func001Func005Func023C takes nothing returns boolean
    if ( not ( ModuloInteger(udg_ncld_Tick[udg_Key], udg_ncld_FreqDrain) == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Drain_Loop_Func001Func005Func025Func002Func001C takes nothing returns boolean
    if ( not ( UnitHasBuffBJ(udg_ncld_Target[udg_Key], udg_ncld_BuffList[udg_LoopBuffs]) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Drain_Loop_Func001Func005Func025Func003Func002C takes nothing returns boolean
    if ( not ( IsUnitType(udg_ncld_Target[udg_Key], UNIT_TYPE_MAGIC_IMMUNE) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Drain_Loop_Func001Func005Func025Func003C takes nothing returns boolean
    if ( not ( udg_ncld_CheckImmune == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Drain_Loop_Func001Func005Func025Func004Func002C takes nothing returns boolean
    if ( not ( IsUnitType(udg_ncld_Target[udg_Key], UNIT_TYPE_RESISTANT) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Drain_Loop_Func001Func005Func025Func004C takes nothing returns boolean
    if ( not ( udg_ncld_CheckResistant == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Drain_Loop_Func001Func005Func025Func005Func002C takes nothing returns boolean
    if ( not ( IsUnitVisible(udg_ncld_Target[udg_Key], GetOwningPlayer(udg_tempUnit)) == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_Drain_Loop_Func001Func005Func025Func005C takes nothing returns boolean
    if ( not ( udg_ncld_CheckVisibile == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Drain_Loop_Func001Func005Func025Func006Func001C takes nothing returns boolean
    if ( ( udg_CheckBool == false ) ) then
        return true
    endif
    if ( ( IsUnitDeadBJ(udg_ncld_Target[udg_Key]) == true ) ) then
        return true
    endif
    if ( ( IsUnitHiddenBJ(udg_ncld_Target[udg_Key]) == true ) ) then
        return true
    endif
    return false
endfunction

function Trig_Drain_Loop_Func001Func005Func025Func006C takes nothing returns boolean
    if ( not Trig_Drain_Loop_Func001Func005Func025Func006Func001C() ) then
        return false
    endif
    return true
endfunction

function Trig_Drain_Loop_Func001Func005Func025Func008C takes nothing returns boolean
    if ( not ( udg_tempDistance > udg_ncld_Rng[udg_Key] ) ) then
        return false
    endif
    return true
endfunction

function Trig_Drain_Loop_Func001Func005Func025C takes nothing returns boolean
    if ( not ( ModuloInteger(udg_ncld_Tick[udg_Key], udg_ncld_FreqDistance) == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Drain_Loop_Func001Func005C takes nothing returns boolean
    if ( not ( udg_ncld_TicksRemaining[udg_Key] >= 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Drain_Loop_Func001A takes nothing returns nothing
    set udg_tempUnit=GetEnumUnit()
    set udg_Key=GetUnitUserData(udg_tempUnit)
    // check spell duration
    set udg_ncld_TicksRemaining[udg_Key]=( udg_ncld_TicksRemaining[udg_Key] - 1 )
    if ( Trig_Drain_Loop_Func001Func005C() ) then
        // increment tick
        set udg_ncld_Tick[udg_Key]=( udg_ncld_Tick[udg_Key] + 1 )
        // every tick: move lightning
        set udg_tempLoc1=GetUnitLoc(udg_tempUnit)
        set udg_tempLoc2=GetUnitLoc(udg_ncld_Target[udg_Key])
        // coords of source unit
        set udg_tempX1=GetLocationX(udg_tempLoc1)
        set udg_tempY1=GetLocationY(udg_tempLoc1)
        set udg_tempZ1=GetLocationZ(udg_tempLoc1) + GetUnitFlyHeight(udg_tempUnit) + 60
        // coords of target
        set udg_tempX2=GetLocationX(udg_tempLoc2)
        set udg_tempY2=GetLocationY(udg_tempLoc2)
        set udg_tempZ2=GetLocationZ(udg_tempLoc2) + GetUnitFlyHeight(udg_ncld_Target[udg_Key]) + 60
        call MoveLightningEx(udg_ncld_Lightning[udg_Key], true, udg_tempX1, udg_tempY1, udg_tempZ1, udg_tempX2, udg_tempY2, udg_tempZ2)
        // transfer hp/mana
        if ( Trig_Drain_Loop_Func001Func005Func023C() ) then
            if ( Trig_Drain_Loop_Func001Func005Func023Func001C() ) then
                call UnitDamageTargetBJ(udg_tempUnit, udg_ncld_Target[udg_Key], 0.00, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL)
                if ( Trig_Drain_Loop_Func001Func005Func023Func001Func002C() ) then
                    call SetUnitLifeBJ(udg_ncld_Target[udg_Key], ( GetUnitStateSwap(UNIT_STATE_LIFE, udg_ncld_Target[udg_Key]) - ( udg_ncld_Hp[udg_Key] * udg_ncld_EtherealBonus ) ))
                    call SetUnitManaBJ(udg_ncld_Target[udg_Key], ( GetUnitStateSwap(UNIT_STATE_MANA, udg_ncld_Target[udg_Key]) - ( udg_ncld_Mp[udg_Key] * udg_ncld_EtherealBonus ) ))
                    call SetUnitLifeBJ(udg_tempUnit, ( GetUnitStateSwap(UNIT_STATE_LIFE, udg_tempUnit) + ( udg_ncld_Hp[udg_Key] * udg_ncld_EtherealBonus ) ))
                    call SetUnitManaBJ(udg_tempUnit, ( GetUnitStateSwap(UNIT_STATE_MANA, udg_tempUnit) + ( udg_ncld_Mp[udg_Key] * udg_ncld_EtherealBonus ) ))
                else
                    call SetUnitLifeBJ(udg_ncld_Target[udg_Key], ( GetUnitStateSwap(UNIT_STATE_LIFE, udg_ncld_Target[udg_Key]) - udg_ncld_Hp[udg_Key] ))
                    call SetUnitManaBJ(udg_ncld_Target[udg_Key], ( GetUnitStateSwap(UNIT_STATE_MANA, udg_ncld_Target[udg_Key]) - udg_ncld_Mp[udg_Key] ))
                    call SetUnitLifeBJ(udg_tempUnit, ( GetUnitStateSwap(UNIT_STATE_LIFE, udg_tempUnit) + udg_ncld_Hp[udg_Key] ))
                    call SetUnitManaBJ(udg_tempUnit, ( GetUnitStateSwap(UNIT_STATE_MANA, udg_tempUnit) + udg_ncld_Mp[udg_Key] ))
                endif
            else
            endif
        else
        endif
        // check distance
        if ( Trig_Drain_Loop_Func001Func005Func025C() ) then
            set udg_tempDistance=DistanceBetweenPoints(udg_tempLoc1, udg_tempLoc2)
            if ( Trig_Drain_Loop_Func001Func005Func025Func008C() ) then
                // end spell
                set udg_ncld_Tick[udg_Key]=0
                set udg_ncld_TicksRemaining[udg_Key]=0
                call GroupRemoveUnitSimple(udg_tempUnit, udg_ncld_Group)
                set udg_ncld_Target[udg_Key]=null
                call DestroyLightningBJ(udg_ncld_Lightning[udg_Key])
                call DestroyEffectBJ(udg_ncld_CasterSFX[udg_Key])
                call DestroyEffectBJ(udg_ncld_TargetSFX[udg_Key])
            else
            endif
        else
            set udg_CheckBool=true
            set udg_LoopBuffs=1
            loop
                exitwhen udg_LoopBuffs > udg_ncld_buffId
                if ( Trig_Drain_Loop_Func001Func005Func025Func002Func001C() ) then
                    set udg_CheckBool=false
                else
                endif
                set udg_LoopBuffs=udg_LoopBuffs + 1
            endloop
            if ( Trig_Drain_Loop_Func001Func005Func025Func003C() ) then
                if ( Trig_Drain_Loop_Func001Func005Func025Func003Func002C() ) then
                    set udg_CheckBool=false
                else
                endif
            else
            endif
            if ( Trig_Drain_Loop_Func001Func005Func025Func004C() ) then
                if ( Trig_Drain_Loop_Func001Func005Func025Func004Func002C() ) then
                    set udg_CheckBool=false
                else
                endif
            else
            endif
            if ( Trig_Drain_Loop_Func001Func005Func025Func005C() ) then
                if ( Trig_Drain_Loop_Func001Func005Func025Func005Func002C() ) then
                    set udg_CheckBool=false
                else
                endif
            else
            endif
            if ( Trig_Drain_Loop_Func001Func005Func025Func006C() ) then
                // end spell
                set udg_ncld_Tick[udg_Key]=0
                set udg_ncld_TicksRemaining[udg_Key]=0
                call GroupRemoveUnitSimple(udg_tempUnit, udg_ncld_Group)
                set udg_ncld_Target[udg_Key]=null
                call DestroyLightningBJ(udg_ncld_Lightning[udg_Key])
                call DestroyEffectBJ(udg_ncld_CasterSFX[udg_Key])
                call DestroyEffectBJ(udg_ncld_TargetSFX[udg_Key])
            else
            endif
        endif
        call RemoveLocation(udg_tempLoc1)
        call RemoveLocation(udg_tempLoc1)
    else
        // end spell
        set udg_ncld_Tick[udg_Key]=0
        call GroupRemoveUnitSimple(udg_tempUnit, udg_ncld_Group)
        set udg_ncld_Target[udg_Key]=null
        call DestroyLightningBJ(udg_ncld_Lightning[udg_Key])
        call DestroyEffectBJ(udg_ncld_CasterSFX[udg_Key])
        call DestroyEffectBJ(udg_ncld_TargetSFX[udg_Key])
    endif
endfunction

function Trig_Drain_Loop_Func002C takes nothing returns boolean
    if ( not ( IsUnitGroupEmptyBJ(udg_ncld_Group) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Drain_Loop_Actions takes nothing returns nothing
    call ForGroupBJ(udg_ncld_Group, function Trig_Drain_Loop_Func001A)
    if ( Trig_Drain_Loop_Func002C() ) then
        call DisableTrigger(GetTriggeringTrigger())
    else
    endif
endfunction

//===========================================================================
function InitTrig_Drain_Loop takes nothing returns nothing
    set gg_trg_Drain_Loop=CreateTrigger()
    call DisableTrigger(gg_trg_Drain_Loop)
    call TriggerRegisterTimerEventPeriodic(gg_trg_Drain_Loop, 0.03)
    call TriggerAddAction(gg_trg_Drain_Loop, function Trig_Drain_Loop_Actions)
endfunction

//===========================================================================
// Trigger: Levelled Slam
//===========================================================================
function Trig_Levelled_Slam_Conditions takes nothing returns boolean
    if ( not ( GetResearched() == 'R043' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Levelled_Slam_Func001002 takes nothing returns nothing
    call IncUnitAbilityLevelSwapped('A063', GetEnumUnit())
endfunction

function Trig_Levelled_Slam_Actions takes nothing returns nothing
    call ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(0), 'u009'), function Trig_Levelled_Slam_Func001002)
endfunction

//===========================================================================
function InitTrig_Levelled_Slam takes nothing returns nothing
    set gg_trg_Levelled_Slam=CreateTrigger()
    call TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Slam, Player(0), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    call TriggerAddCondition(gg_trg_Levelled_Slam, Condition(function Trig_Levelled_Slam_Conditions))
    call TriggerAddAction(gg_trg_Levelled_Slam, function Trig_Levelled_Slam_Actions)
endfunction

//===========================================================================
// Trigger: Levelled Slam Copy
//===========================================================================
function Trig_Levelled_Slam_Copy_Conditions takes nothing returns boolean
    if ( not ( GetResearched() == 'R043' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Levelled_Slam_Copy_Func001002 takes nothing returns nothing
    call IncUnitAbilityLevelSwapped('A063', GetEnumUnit())
endfunction

function Trig_Levelled_Slam_Copy_Actions takes nothing returns nothing
    call ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(1), 'u009'), function Trig_Levelled_Slam_Copy_Func001002)
endfunction

//===========================================================================
function InitTrig_Levelled_Slam_Copy takes nothing returns nothing
    set gg_trg_Levelled_Slam_Copy=CreateTrigger()
    call TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Slam_Copy, Player(1), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    call TriggerAddCondition(gg_trg_Levelled_Slam_Copy, Condition(function Trig_Levelled_Slam_Copy_Conditions))
    call TriggerAddAction(gg_trg_Levelled_Slam_Copy, function Trig_Levelled_Slam_Copy_Actions)
endfunction

//===========================================================================
// Trigger: Levelled Slam Copy 2
//===========================================================================
function Trig_Levelled_Slam_Copy_2_Conditions takes nothing returns boolean
    if ( not ( GetResearched() == 'R043' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Levelled_Slam_Copy_2_Func001002 takes nothing returns nothing
    call IncUnitAbilityLevelSwapped('A063', GetEnumUnit())
endfunction

function Trig_Levelled_Slam_Copy_2_Actions takes nothing returns nothing
    call ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(2), 'u009'), function Trig_Levelled_Slam_Copy_2_Func001002)
endfunction

//===========================================================================
function InitTrig_Levelled_Slam_Copy_2 takes nothing returns nothing
    set gg_trg_Levelled_Slam_Copy_2=CreateTrigger()
    call TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Slam_Copy_2, Player(2), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    call TriggerAddCondition(gg_trg_Levelled_Slam_Copy_2, Condition(function Trig_Levelled_Slam_Copy_2_Conditions))
    call TriggerAddAction(gg_trg_Levelled_Slam_Copy_2, function Trig_Levelled_Slam_Copy_2_Actions)
endfunction

//===========================================================================
// Trigger: Levelled Slam Copy 3
//===========================================================================
function Trig_Levelled_Slam_Copy_3_Conditions takes nothing returns boolean
    if ( not ( GetResearched() == 'R043' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Levelled_Slam_Copy_3_Func001002 takes nothing returns nothing
    call IncUnitAbilityLevelSwapped('A063', GetEnumUnit())
endfunction

function Trig_Levelled_Slam_Copy_3_Actions takes nothing returns nothing
    call ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(3), 'u009'), function Trig_Levelled_Slam_Copy_3_Func001002)
endfunction

//===========================================================================
function InitTrig_Levelled_Slam_Copy_3 takes nothing returns nothing
    set gg_trg_Levelled_Slam_Copy_3=CreateTrigger()
    call TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Slam_Copy_3, Player(3), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    call TriggerAddCondition(gg_trg_Levelled_Slam_Copy_3, Condition(function Trig_Levelled_Slam_Copy_3_Conditions))
    call TriggerAddAction(gg_trg_Levelled_Slam_Copy_3, function Trig_Levelled_Slam_Copy_3_Actions)
endfunction

//===========================================================================
// Trigger: Levelled Slam Copy 4
//===========================================================================
function Trig_Levelled_Slam_Copy_4_Conditions takes nothing returns boolean
    if ( not ( GetResearched() == 'R043' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Levelled_Slam_Copy_4_Func001002 takes nothing returns nothing
    call IncUnitAbilityLevelSwapped('A063', GetEnumUnit())
endfunction

function Trig_Levelled_Slam_Copy_4_Actions takes nothing returns nothing
    call ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(4), 'u009'), function Trig_Levelled_Slam_Copy_4_Func001002)
endfunction

//===========================================================================
function InitTrig_Levelled_Slam_Copy_4 takes nothing returns nothing
    set gg_trg_Levelled_Slam_Copy_4=CreateTrigger()
    call TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Slam_Copy_4, Player(4), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    call TriggerAddCondition(gg_trg_Levelled_Slam_Copy_4, Condition(function Trig_Levelled_Slam_Copy_4_Conditions))
    call TriggerAddAction(gg_trg_Levelled_Slam_Copy_4, function Trig_Levelled_Slam_Copy_4_Actions)
endfunction

//===========================================================================
// Trigger: Levelled Slam Copy 5
//===========================================================================
function Trig_Levelled_Slam_Copy_5_Conditions takes nothing returns boolean
    if ( not ( GetResearched() == 'R043' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Levelled_Slam_Copy_5_Func001002 takes nothing returns nothing
    call IncUnitAbilityLevelSwapped('A063', GetEnumUnit())
endfunction

function Trig_Levelled_Slam_Copy_5_Actions takes nothing returns nothing
    call ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(5), 'u009'), function Trig_Levelled_Slam_Copy_5_Func001002)
endfunction

//===========================================================================
function InitTrig_Levelled_Slam_Copy_5 takes nothing returns nothing
    set gg_trg_Levelled_Slam_Copy_5=CreateTrigger()
    call TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Slam_Copy_5, Player(5), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    call TriggerAddCondition(gg_trg_Levelled_Slam_Copy_5, Condition(function Trig_Levelled_Slam_Copy_5_Conditions))
    call TriggerAddAction(gg_trg_Levelled_Slam_Copy_5, function Trig_Levelled_Slam_Copy_5_Actions)
endfunction

//===========================================================================
// Trigger: Levelled Slam Copy 6
//===========================================================================
function Trig_Levelled_Slam_Copy_6_Conditions takes nothing returns boolean
    if ( not ( GetResearched() == 'R043' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Levelled_Slam_Copy_6_Func001002 takes nothing returns nothing
    call IncUnitAbilityLevelSwapped('A063', GetEnumUnit())
endfunction

function Trig_Levelled_Slam_Copy_6_Actions takes nothing returns nothing
    call ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(7), 'u009'), function Trig_Levelled_Slam_Copy_6_Func001002)
endfunction

//===========================================================================
function InitTrig_Levelled_Slam_Copy_6 takes nothing returns nothing
    set gg_trg_Levelled_Slam_Copy_6=CreateTrigger()
    call TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Slam_Copy_6, Player(7), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    call TriggerAddCondition(gg_trg_Levelled_Slam_Copy_6, Condition(function Trig_Levelled_Slam_Copy_6_Conditions))
    call TriggerAddAction(gg_trg_Levelled_Slam_Copy_6, function Trig_Levelled_Slam_Copy_6_Actions)
endfunction

//===========================================================================
// Trigger: Levelled Slam Copy 7
//===========================================================================
function Trig_Levelled_Slam_Copy_7_Conditions takes nothing returns boolean
    if ( not ( GetResearched() == 'R043' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Levelled_Slam_Copy_7_Func001002 takes nothing returns nothing
    call IncUnitAbilityLevelSwapped('A063', GetEnumUnit())
endfunction

function Trig_Levelled_Slam_Copy_7_Actions takes nothing returns nothing
    call ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(8), 'u009'), function Trig_Levelled_Slam_Copy_7_Func001002)
endfunction

//===========================================================================
function InitTrig_Levelled_Slam_Copy_7 takes nothing returns nothing
    set gg_trg_Levelled_Slam_Copy_7=CreateTrigger()
    call TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Slam_Copy_7, Player(8), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    call TriggerAddCondition(gg_trg_Levelled_Slam_Copy_7, Condition(function Trig_Levelled_Slam_Copy_7_Conditions))
    call TriggerAddAction(gg_trg_Levelled_Slam_Copy_7, function Trig_Levelled_Slam_Copy_7_Actions)
endfunction

//===========================================================================
// Trigger: Levelled Slam Copy 8
//===========================================================================
function Trig_Levelled_Slam_Copy_8_Conditions takes nothing returns boolean
    if ( not ( GetResearched() == 'R043' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Levelled_Slam_Copy_8_Func001002 takes nothing returns nothing
    call IncUnitAbilityLevelSwapped('A063', GetEnumUnit())
endfunction

function Trig_Levelled_Slam_Copy_8_Actions takes nothing returns nothing
    call ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(9), 'u009'), function Trig_Levelled_Slam_Copy_8_Func001002)
endfunction

//===========================================================================
function InitTrig_Levelled_Slam_Copy_8 takes nothing returns nothing
    set gg_trg_Levelled_Slam_Copy_8=CreateTrigger()
    call TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Slam_Copy_8, Player(9), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    call TriggerAddCondition(gg_trg_Levelled_Slam_Copy_8, Condition(function Trig_Levelled_Slam_Copy_8_Conditions))
    call TriggerAddAction(gg_trg_Levelled_Slam_Copy_8, function Trig_Levelled_Slam_Copy_8_Actions)
endfunction

//===========================================================================
// Trigger: Levelled Slam Copy 9
//===========================================================================
function Trig_Levelled_Slam_Copy_9_Conditions takes nothing returns boolean
    if ( not ( GetResearched() == 'R043' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Levelled_Slam_Copy_9_Func001002 takes nothing returns nothing
    call IncUnitAbilityLevelSwapped('A063', GetEnumUnit())
endfunction

function Trig_Levelled_Slam_Copy_9_Actions takes nothing returns nothing
    call ForGroupBJ(GetUnitsOfPlayerAndTypeId(Player(10), 'u009'), function Trig_Levelled_Slam_Copy_9_Func001002)
endfunction

//===========================================================================
function InitTrig_Levelled_Slam_Copy_9 takes nothing returns nothing
    set gg_trg_Levelled_Slam_Copy_9=CreateTrigger()
    call TriggerRegisterPlayerUnitEventSimple(gg_trg_Levelled_Slam_Copy_9, Player(10), EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    call TriggerAddCondition(gg_trg_Levelled_Slam_Copy_9, Condition(function Trig_Levelled_Slam_Copy_9_Conditions))
    call TriggerAddAction(gg_trg_Levelled_Slam_Copy_9, function Trig_Levelled_Slam_Copy_9_Actions)
endfunction

//===========================================================================
// Trigger: LevelUpAura
//===========================================================================
function Trig_LevelUpAura_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'h059' ) ) then
        return false
    endif
    return true
endfunction

function Trig_LevelUpAura_Func003A takes nothing returns nothing
    call SetUnitAbilityLevelSwapped('A09S', GetEnumUnit(), udg_Ziggurats_Count)
    call SetUnitAbilityLevelSwapped('A0A1', GetEnumUnit(), udg_Ziggurats_Count)
endfunction

function Trig_LevelUpAura_Actions takes nothing returns nothing
    call GroupAddUnitSimple(GetTriggerUnit(), udg_Ziggurats)
    set udg_Ziggurats_Count=( udg_Ziggurats_Count + 1 )
    call ForGroupBJ(udg_Ziggurats, function Trig_LevelUpAura_Func003A)
endfunction

//===========================================================================
function InitTrig_LevelUpAura takes nothing returns nothing
    set gg_trg_LevelUpAura=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_LevelUpAura, EVENT_PLAYER_UNIT_UPGRADE_FINISH)
    call TriggerAddCondition(gg_trg_LevelUpAura, Condition(function Trig_LevelUpAura_Conditions))
    call TriggerAddAction(gg_trg_LevelUpAura, function Trig_LevelUpAura_Actions)
endfunction

//===========================================================================
// Trigger: DowngradeAura
//===========================================================================
function Trig_DowngradeAura_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'h059' ) ) then
        return false
    endif
    return true
endfunction

function Trig_DowngradeAura_Func003A takes nothing returns nothing
    call SetUnitAbilityLevelSwapped('A09S', GetEnumUnit(), udg_Ziggurats_Count)
    call SetUnitAbilityLevelSwapped('A0A1', GetEnumUnit(), udg_Ziggurats_Count)
endfunction

function Trig_DowngradeAura_Actions takes nothing returns nothing
    call GroupAddUnitSimple(GetTriggerUnit(), udg_Ziggurats)
    set udg_Ziggurats_Count=( udg_Ziggurats_Count - 1 )
    call ForGroupBJ(udg_Ziggurats, function Trig_DowngradeAura_Func003A)
endfunction

//===========================================================================
function InitTrig_DowngradeAura takes nothing returns nothing
    set gg_trg_DowngradeAura=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_DowngradeAura, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_DowngradeAura, Condition(function Trig_DowngradeAura_Conditions))
    call TriggerAddAction(gg_trg_DowngradeAura, function Trig_DowngradeAura_Actions)
endfunction

//===========================================================================
// Trigger: NerubianSpires
//===========================================================================
// Function to check if a given building is the base version of another
function IsBaseBuilding takes integer baseId,integer upgradedId returns boolean
    // Manually define base-upgrade relationships
    if ( baseId == 'hkee' and upgradedId == 'hcas' ) then // Keep -> Castle
        return true
    elseif ( baseId == 'hbar' and upgradedId == 'hbax' ) then // Barracks -> Advanced Barracks (example)
        return true
    endif

    return false
endfunction

function CheckNearbyUpgrades takes unit u returns boolean
    local group g= CreateGroup()
    local unit b
    local boolean result= false
    local integer newBuildingId= GetUnitTypeId(u)
    call GroupEnumUnitsInRange(g, GetUnitX(u), GetUnitY(u), 2000, null)
    loop
        set b=FirstOfGroup(g)
        exitwhen b == null
        // Check if this nearby building is the base version of the new upgrade
        if GetUnitTypeId(b) == newBuildingId and not ( GetUnitX(u) == GetUnitX(b) and GetUnitY(u) == GetUnitY(b) ) then
            set result=true
            exitwhen true
        endif

        call GroupRemoveUnit(g, b)
    endloop

    call DestroyGroup(g)
    return result
endfunction

function OnConstructionStart takes nothing returns nothing
    local unit u= GetTriggerUnit()
    if GetUnitTypeId(GetTriggerUnit()) == 'h059' then
        if CheckNearbyUpgrades(u) then
            call DisplayTextToPlayer(GetOwningPlayer(u), 0, 0, "Upgrading too close to an existing building!")
            call TriggerSleepAction(0.1) // Small delay before canceling
            call IssueImmediateOrderById(u, 851976) // Cancel upgrade
        endif
    endif

endfunction


//===========================================================================
function InitTrig_NerubianSpires takes nothing returns nothing
    local trigger t= CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_UPGRADE_START)
    call TriggerAddAction(t, function OnConstructionStart)

endfunction


//===========================================================================
// Trigger: Frenzy
//===========================================================================
function Trig_Frenzy_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A09X' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Frenzy_Actions takes nothing returns nothing
    call CreateNUnitsAtLoc(1, 'h04L', GetOwningPlayer(GetTriggerUnit()), GetUnitLoc(GetTriggerUnit()), bj_UNIT_FACING)
    call UnitAddAbilityBJ('A09Y', GetLastCreatedUnit())
    call UnitApplyTimedLifeBJ(2.00, 'BTLF', GetLastCreatedUnit())
    call IssueTargetOrderBJ(GetLastCreatedUnit(), "unholyfrenzy", GetSpellAbilityUnit())
endfunction

//===========================================================================
function InitTrig_Frenzy takes nothing returns nothing
    set gg_trg_Frenzy=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Frenzy, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Frenzy, Condition(function Trig_Frenzy_Conditions))
    call TriggerAddAction(gg_trg_Frenzy, function Trig_Frenzy_Actions)
endfunction

//===========================================================================
// Trigger: Chemical Rage
//===========================================================================
//===========================================================================
// Configuration - Replace these rawcodes with your own
//===========================================================================
constant function CHEMICAL_RAGE_ABILITY takes nothing returns integer
    return 'A0CU' // The Chemical Rage spell that triggers this
endfunction

constant function DUMMY_ABILITY takes nothing returns integer
    return 'A0CV' // Ability that dummy casts (grants range/buff)
endfunction

constant function DUMMY_UNIT_ID takes nothing returns integer
    return 'h04L' // Dummy unit type (must have the ability above)
endfunction

//===========================================================================
// Condition
//===========================================================================
function ChemicalRageCondition takes nothing returns boolean
    return GetSpellAbilityId() == ('A0CU') // INLINED!!
endfunction

//===========================================================================
// Actions
//===========================================================================
function ChemicalRageActions takes nothing returns nothing
    local unit caster= GetTriggerUnit()
    local player p= GetOwningPlayer(caster)
    local unit dummy
    local integer i

    // ----- Spawn dummy and cast ability -----
    set dummy=CreateUnit(p, ('h04L'), GetUnitX(caster), GetUnitY(caster), 0) // INLINED!!
    call UnitAddAbility(dummy, ('A0CV')) // Ensure dummy has the ability // INLINED!!
    call IssueTargetOrder(dummy, "bloodlust", caster) // Order to cast on caster

    // ----- Apply attack speed change -----
    call BlzSetUnitWeaponRealField(caster, UNIT_WEAPON_RF_ATTACK_BASE_COOLDOWN, 0, 1.25)

    // ----- Maintain full size for remaining duration (20 seconds) -----
    call TriggerSleepAction(20.0)

    // ----- Remove dummy after it has cast -----
    call RemoveUnit(dummy)
    set dummy=null

    if caster == null or IsUnitType(caster, UNIT_TYPE_DEAD) then
        set caster=null
        set p=null
        return
    endif

    // ----- Revert attack speed -----
    if caster != null and not IsUnitType(caster, UNIT_TYPE_DEAD) then
        call BlzSetUnitWeaponRealField(caster, UNIT_WEAPON_RF_ATTACK_BASE_COOLDOWN, 0, 1.75)
    endif

    // ----- Clean up -----
    set caster=null
    set p=null
endfunction

//===========================================================================
// Trigger Initialization
//===========================================================================
function InitTrig_Chemical_Rage takes nothing returns nothing
    local trigger t= CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_SPELL_FINISH)
    call TriggerAddCondition(t, Condition(function ChemicalRageCondition))
    call TriggerAddAction(t, function ChemicalRageActions)
endfunction
//===========================================================================
// Trigger: ReduceMagicResist
//===========================================================================
function Trig_ReduceMagicResist_Conditions takes nothing returns boolean
    if ( not ( UnitHasBuffBJ(udg_DamageEventTarget, 'B03O') == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_ReduceMagicResist_Actions takes nothing returns nothing
    call UnitAddAbilityBJ('A0CT', udg_DamageEventTarget)
    call GroupAddUnitSimple(udg_DamageEventTarget, udg_Acided)
endfunction

//===========================================================================
function InitTrig_ReduceMagicResist takes nothing returns nothing
    set gg_trg_ReduceMagicResist=CreateTrigger()
    call h__TriggerRegisterVariableEvent(gg_trg_ReduceMagicResist, "udg_DamageEvent", EQUAL, 1.00)
    call TriggerAddCondition(gg_trg_ReduceMagicResist, Condition(function Trig_ReduceMagicResist_Conditions))
    call TriggerAddAction(gg_trg_ReduceMagicResist, function Trig_ReduceMagicResist_Actions)
endfunction

//===========================================================================
// Trigger: ReduceMagicResist2
//===========================================================================
function Trig_ReduceMagicResist2_Func001Func001C takes nothing returns boolean
    if ( not ( UnitHasBuffBJ(GetEnumUnit(), 'B03O') == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_ReduceMagicResist2_Func001A takes nothing returns nothing
    if ( Trig_ReduceMagicResist2_Func001Func001C() ) then
    else
        call UnitRemoveAbilityBJ('A0CT', GetEnumUnit())
        call GroupRemoveUnitSimple(GetEnumUnit(), udg_Acided)
    endif
endfunction

function Trig_ReduceMagicResist2_Actions takes nothing returns nothing
    call ForGroupBJ(udg_Acided, function Trig_ReduceMagicResist2_Func001A)
endfunction

//===========================================================================
function InitTrig_ReduceMagicResist2 takes nothing returns nothing
    set gg_trg_ReduceMagicResist2=CreateTrigger()
    call TriggerRegisterTimerEventPeriodic(gg_trg_ReduceMagicResist2, 0.50)
    call TriggerAddAction(gg_trg_ReduceMagicResist2, function Trig_ReduceMagicResist2_Actions)
endfunction

//===========================================================================
// Trigger: TargetAcquired
//===========================================================================
function Trig_TargetAcquired_Conditions takes nothing returns boolean
    if ( not ( GetPlayerTechCountSimple('R06S', GetOwningPlayer(udg_DamageEventSource)) == 1 ) ) then
        return false
    endif
    if ( not ( udg_IsDamageAttack == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_TargetAcquired_Func004C takes nothing returns boolean
    if ( not ( GetRandomReal(0.00, 100.00) <= 30.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_TargetAcquired_Actions takes nothing returns nothing
    if ( Trig_TargetAcquired_Func004C() ) then
//textmacro instance: DAMAGE_TRIGGER_CONFIG()
    if not s__DamageTrigger_configured[s__DamageTrigger_eventIndex] then
//end of: DAMAGE_TRIGGER_CONFIG()
        set udg_DamageFilterSourceT='o026'
//textmacro instance: DAMAGE_TRIGGER_CONFIG_END()
        call s__DamageTrigger_configure(s__DamageTrigger_eventIndex)
    endif
    if not s__DamageTrigger_checkConfig(s__DamageTrigger_eventIndex) then
        return
    endif
//end of: DAMAGE_TRIGGER_CONFIG_END()
        set udg_DamageEventAttackT=udg_ATTACK_TYPE_CHAOS
        set udg_DamageEventArmorPierced=10.00
        set udg_TSEDuration=1.00
        set udg_TSEScale=0.75
        set udg_TSEAttachPoint="overhead"
        set udg_TSEEffectName="war3mapImported\\SnipingTarget.mdx"
        set udg_TSETargetUnit=udg_DamageEventTarget
        call ConditionalTriggerExecute(udg_TSE_RegisterTrigger)
    else
    endif
endfunction

//===========================================================================
function InitTrig_TargetAcquired takes nothing returns nothing
    set gg_trg_TargetAcquired=CreateTrigger()
    call h__TriggerRegisterVariableEvent(gg_trg_TargetAcquired, "udg_PreDamageEvent", LESS_THAN, 1.00)
    call TriggerAddCondition(gg_trg_TargetAcquired, Condition(function Trig_TargetAcquired_Conditions))
    call TriggerAddAction(gg_trg_TargetAcquired, function Trig_TargetAcquired_Actions)
endfunction

//===========================================================================
// Trigger: Poisoned Bullets2
//===========================================================================
function Trig_Poisoned_Bullets2_Conditions takes nothing returns boolean
    if ( not ( GetPlayerTechCountSimple('R06R', GetOwningPlayer(GetAttacker())) >= 1 ) ) then
        return false
    endif
    if ( not ( GetUnitTypeId(GetAttacker()) == 'o026' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Poisoned_Bullets2_Actions takes nothing returns nothing
    if ( GetUnitAbilityLevel(GetAttackedUnitBJ(), 'Bspo') == 0 ) then
    	call SetUnitAbilityLevelSwapped('A0CQ', GetAttackedUnitBJ(), 1)
    endif
    call SetUnitAbilityLevelSwapped('A0CO', GetAttacker(), GetUnitAbilityLevel(( GetAttackedUnitBJ() ), 'A0CQ'))
endfunction

//===========================================================================
function InitTrig_Poisoned_Bullets2 takes nothing returns nothing
    set gg_trg_Poisoned_Bullets2=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Poisoned_Bullets2, EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddCondition(gg_trg_Poisoned_Bullets2, Condition(function Trig_Poisoned_Bullets2_Conditions))
    call TriggerAddAction(gg_trg_Poisoned_Bullets2, function Trig_Poisoned_Bullets2_Actions)
endfunction


//===========================================================================
// Trigger: Poisoned Bullets
//===========================================================================
function Trig_Poisoned_Bullets_Conditions takes nothing returns boolean
    if ( not ( GetPlayerTechCountSimple('R06R', GetOwningPlayer(udg_DamageEventSource)) >= 1 ) ) then
        return false
    endif
    if ( not ( GetUnitTypeId(udg_DamageEventSource) == 'o026' ) ) then
        return false
    endif
    if ( not ( udg_IsDamageAttack == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Poisoned_Bullets_Actions takes nothing returns nothing
    local integer var
    if ( GetUnitAbilityLevel(udg_DamageEventTarget, 'Bspo') > 0 ) then
	if ( GetUnitAbilityLevel(udg_DamageEventTarget, 'A0CQ') == 0 ) then
            call UnitAddAbility(udg_DamageEventTarget, 'A0CQ')
        endif
	set var=GetUnitAbilityLevel(( udg_DamageEventTarget ), 'A0CQ')
        call IncUnitAbilityLevelSwapped('A0CQ', udg_DamageEventTarget)
    endif
endfunction

//===========================================================================
function InitTrig_Poisoned_Bullets takes nothing returns nothing
    set gg_trg_Poisoned_Bullets=CreateTrigger()
    call h__TriggerRegisterVariableEvent(gg_trg_Poisoned_Bullets, "udg_PreDamageEvent", EQUAL, 1.00)
    call TriggerAddCondition(gg_trg_Poisoned_Bullets, Condition(function Trig_Poisoned_Bullets_Conditions))
    call TriggerAddAction(gg_trg_Poisoned_Bullets, function Trig_Poisoned_Bullets_Actions)
endfunction


//===========================================================================
// Trigger: Permanent Invisibility
//===========================================================================
function Trig_Permanent_Invisibility_Conditions takes nothing returns boolean
    if ( not ( GetResearched() == 'R06K' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Permanent_Invisibility_Func001A takes nothing returns nothing
    call UnitAddAbilityBJ('A0CK', GetEnumUnit())
    set udg_SilentStrider[GetConvertedPlayerId(GetOwningPlayer(GetResearchingUnit()))]=true
endfunction

function Trig_Permanent_Invisibility_Actions takes nothing returns nothing
    call ForGroupBJ(GetUnitsOfPlayerAndTypeId(GetOwningPlayer(GetResearchingUnit()), 'o026'), function Trig_Permanent_Invisibility_Func001A)
endfunction

//===========================================================================
function InitTrig_Permanent_Invisibility takes nothing returns nothing
    set gg_trg_Permanent_Invisibility=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Permanent_Invisibility, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    call TriggerAddCondition(gg_trg_Permanent_Invisibility, Condition(function Trig_Permanent_Invisibility_Conditions))
    call TriggerAddAction(gg_trg_Permanent_Invisibility, function Trig_Permanent_Invisibility_Actions)
endfunction

//===========================================================================
// Trigger: Permanent Invisibility 2
//===========================================================================
function Trig_Permanent_Invisibility_2_Conditions takes nothing returns boolean
    if ( not ( udg_SilentStrider[GetConvertedPlayerId(GetOwningPlayer(GetEnteringUnit()))] == true ) ) then
        return false
    endif
    if ( not ( GetUnitTypeId(GetEnteringUnit()) == 'o026' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Permanent_Invisibility_2_Func002A takes nothing returns nothing
    call UnitAddAbilityBJ('A0CK', GetEnumUnit())
endfunction

function Trig_Permanent_Invisibility_2_Actions takes nothing returns nothing
    call ForGroupBJ(GetUnitsOfPlayerAndTypeId(GetOwningPlayer(GetResearchingUnit()), 'o026'), function Trig_Permanent_Invisibility_2_Func002A)
endfunction

//===========================================================================
function InitTrig_Permanent_Invisibility_2 takes nothing returns nothing
    set gg_trg_Permanent_Invisibility_2=CreateTrigger()
    call TriggerRegisterEnterRectSimple(gg_trg_Permanent_Invisibility_2, GetPlayableMapRect())
    call TriggerAddCondition(gg_trg_Permanent_Invisibility_2, Condition(function Trig_Permanent_Invisibility_2_Conditions))
    call TriggerAddAction(gg_trg_Permanent_Invisibility_2, function Trig_Permanent_Invisibility_2_Actions)
endfunction

//===========================================================================
// Trigger: Sticky Glue
//===========================================================================
function Trig_Sticky_Glue_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A0CL' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Sticky_Glue_Actions takes nothing returns nothing
    call CreateNUnitsAtLoc(1, 'n010', GetOwningPlayer(GetSpellAbilityUnit()), GetSpellTargetLoc(), bj_UNIT_FACING)
    call UnitApplyTimedLifeBJ(6.00, 'BTLF', GetLastCreatedUnit())
endfunction

//===========================================================================
function InitTrig_Sticky_Glue takes nothing returns nothing
    set gg_trg_Sticky_Glue=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Sticky_Glue, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(gg_trg_Sticky_Glue, Condition(function Trig_Sticky_Glue_Conditions))
    call TriggerAddAction(gg_trg_Sticky_Glue, function Trig_Sticky_Glue_Actions)
endfunction

//===========================================================================
// Trigger: Wood Income
//===========================================================================
function Trig_Wood_Income_Func001002 takes nothing returns nothing
    call AdjustPlayerStateBJ(( GetPlayerState(GetEnumPlayer(), PLAYER_STATE_RESOURCE_FOOD_USED) / 2 ), GetEnumPlayer(), PLAYER_STATE_RESOURCE_LUMBER)
endfunction

function Trig_Wood_Income_Actions takes nothing returns nothing
    call ForForce(udg_Razormane, function Trig_Wood_Income_Func001002)
endfunction

//===========================================================================
function InitTrig_Wood_Income takes nothing returns nothing
    set gg_trg_Wood_Income=CreateTrigger()
    call TriggerRegisterTimerEventPeriodic(gg_trg_Wood_Income, 10.00)
    call TriggerAddAction(gg_trg_Wood_Income, function Trig_Wood_Income_Actions)
endfunction

//===========================================================================
// Trigger: Enter Wood Income
//===========================================================================
function Trig_Enter_Wood_Income_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'o01E' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Enter_Wood_Income_Actions takes nothing returns nothing
    call ForceAddPlayerSimple(GetOwningPlayer(GetTriggerUnit()), udg_Razormane)
endfunction

//===========================================================================
function InitTrig_Enter_Wood_Income takes nothing returns nothing
    set gg_trg_Enter_Wood_Income=CreateTrigger()
    call TriggerRegisterEnterRectSimple(gg_trg_Enter_Wood_Income, gg_rct_Spawn_all)
    call TriggerAddCondition(gg_trg_Enter_Wood_Income, Condition(function Trig_Enter_Wood_Income_Conditions))
    call TriggerAddAction(gg_trg_Enter_Wood_Income, function Trig_Enter_Wood_Income_Actions)
endfunction

//===========================================================================
// Trigger: SeedOfRebirth
//===========================================================================
function Trig_SeedOfRebirth_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A0B9' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SeedOfRebirth_IsSeedTargetType takes unit u returns boolean
    local integer id= GetUnitTypeId(u)
    return id == 'e00E' or id == 'e00C' or id == 'e002' or id == 'e009' or id == 'e00A' or id == 'e00G' or id == 'e00J' or id == 'e00O' or id == 'e00H' or id == 'e00N' or id == 'e00S'
endfunction

function Trig_SeedOfRebirth_Func001Func006002 takes nothing returns nothing
    call RemoveUnit(GetEnumUnit())
endfunction

function Trig_SeedOfRebirth_Func001Func010Func001C takes nothing returns boolean
    if ( not ( IsPlayerEnemy(ConvertedPlayer(udg_SeedPlayedNumber), GetEnumPlayer()) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_SeedOfRebirth_Func001Func010A takes nothing returns nothing
    if ( Trig_SeedOfRebirth_Func001Func010Func001C() ) then
        set udg_StillAlive=( udg_StillAlive + 1 )
        call SetPlayerAllianceStateBJ(udg_DeadPlayer, GetEnumPlayer(), bj_ALLIANCE_ALLIED_VISION)
        call SetPlayerAllianceStateBJ(GetEnumPlayer(), udg_DeadPlayer, bj_ALLIANCE_ALLIED_VISION)
    else
    endif
endfunction

function Trig_SeedOfRebirth_Func001Func011A takes nothing returns nothing
    call SetPlayerAllianceStateBJ(udg_DeadPlayer, GetEnumPlayer(), bj_ALLIANCE_UNALLIED)
    call SetPlayerAllianceStateBJ(GetEnumPlayer(), udg_DeadPlayer, bj_ALLIANCE_UNALLIED)
endfunction

function Trig_SeedOfRebirth_Func001C takes nothing returns boolean
    return Trig_SeedOfRebirth_IsSeedTargetType(GetSpellTargetUnit())
endfunction

function Trig_SeedOfRebirth_Actions takes nothing returns nothing
    if ( (Trig_SeedOfRebirth_IsSeedTargetType(GetSpellTargetUnit())) ) then // INLINED!!
        call TriggerSleepAction(2.00)
        set udg_DeadPlayer=GetOwningPlayer(GetSpellTargetUnit())
        set udg_SeedPlayedNumber=GetConvertedPlayerId(GetOwningPlayer(GetSpellTargetUnit()))
        set udg_SeedUnitPosition=GetUnitLoc(GetSpellTargetUnit())
        call ForGroupBJ(GetUnitsOfPlayerAll(GetOwningPlayer(GetSpellTargetUnit())), function Trig_SeedOfRebirth_Func001Func006002)
        call SetPlayerStateBJ(GetOwningPlayer(GetDyingUnit()), PLAYER_STATE_RESOURCE_GOLD, 0)
        call SetPlayerStateBJ(GetOwningPlayer(GetDyingUnit()), PLAYER_STATE_RESOURCE_LUMBER, 0)
        call CreateNUnitsAtLoc(1, udg_SeedOfRebirth[udg_SeedPlayedNumber], ConvertedPlayer(udg_SeedPlayedNumber), udg_SeedUnitPosition, bj_UNIT_FACING)
        call ForForce(GetPlayersAll(), function Trig_SeedOfRebirth_Func001Func010A)
        call ForForce(GetPlayersAllies(Player(6)), function Trig_SeedOfRebirth_Func001Func011A)
    else
    endif
    call IssueImmediateOrderBJ(GetSpellAbilityUnit(), "stop")
endfunction

//===========================================================================
function InitTrig_SeedOfRebirth takes nothing returns nothing
    set gg_trg_SeedOfRebirth=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_SeedOfRebirth, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_SeedOfRebirth, Condition(function Trig_SeedOfRebirth_Conditions))
    call TriggerAddAction(gg_trg_SeedOfRebirth, function Trig_SeedOfRebirth_Actions)
endfunction
//===========================================================================
// Trigger: Ancient Artifact
//===========================================================================
function Trig_Ancient_Artifact_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A07D' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Ancient_Artifact_Actions takes nothing returns nothing
    call SetUnitLifePercentBJ(GetSpellAbilityUnit(), ( GetUnitLifePercent(GetSpellAbilityUnit()) + 50.00 ))
endfunction

//===========================================================================
function InitTrig_Ancient_Artifact takes nothing returns nothing
    set gg_trg_Ancient_Artifact=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Ancient_Artifact, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(gg_trg_Ancient_Artifact, Condition(function Trig_Ancient_Artifact_Conditions))
    call TriggerAddAction(gg_trg_Ancient_Artifact, function Trig_Ancient_Artifact_Actions)
endfunction

//===========================================================================
// Trigger: Moonstrike
//
// TODO
//===========================================================================
function Trig_Moonstrike_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A07F'
endfunction

function Trig_Moonstrike_Actions takes nothing returns nothing
    local unit target= GetSpellTargetUnit()
    local unit caster= GetTriggerUnit()
    local real damage= GetUnitState(caster, UNIT_STATE_MAX_MANA) * 0.2

    call TriggerSleepAction(0.25)

    if GetUnitTypeId(caster) != 0 and GetUnitTypeId(target) != 0 and GetWidgetLife(target) > 0.405 then
        call UnitDamageTarget(caster, target, damage, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
    endif

    set target=null
    set caster=null
endfunction

//===========================================================================
function InitTrig_Moonstrike takes nothing returns nothing
    set gg_trg_Moonstrike=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Moonstrike, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Moonstrike, Condition(function Trig_Moonstrike_Conditions))
    call TriggerAddAction(gg_trg_Moonstrike, function Trig_Moonstrike_Actions)
endfunction
//===========================================================================
// Trigger: Moonstrike Leveled
//===========================================================================
function Trig_Moonstrike_Leveled_Conditions takes nothing returns boolean
    if ( not ( GetResearched() == 'R051' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Moonstrike_Leveled_Func001002 takes nothing returns nothing
    call IncUnitAbilityLevelSwapped('A07F', GetEnumUnit())
endfunction

function Trig_Moonstrike_Leveled_Actions takes nothing returns nothing
    call ForGroupBJ(GetUnitsOfPlayerAndTypeId(GetTriggerPlayer(), 'h010'), function Trig_Moonstrike_Leveled_Func001002)
endfunction

//===========================================================================
function InitTrig_Moonstrike_Leveled takes nothing returns nothing
    set gg_trg_Moonstrike_Leveled=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Moonstrike_Leveled, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    call TriggerAddCondition(gg_trg_Moonstrike_Leveled, Condition(function Trig_Moonstrike_Leveled_Conditions))
    call TriggerAddAction(gg_trg_Moonstrike_Leveled, function Trig_Moonstrike_Leveled_Actions)
endfunction

//===========================================================================
// Trigger: Moonblast
//===========================================================================

function Trig_Moonblast_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == MOONBLAST_ABILITY_ID
endfunction

function Trig_Moonblast_Cleanup takes timer t returns nothing
    local integer id= GetHandleId(t)
    local effect missile= LoadEffectHandle(udg_MoonblastHash, id, 2)

    call DestroyEffect(missile)
    call FlushChildHashtable(udg_MoonblastHash, id)
    call PauseTimer(t)
    call DestroyTimer(t)

    set missile=null
endfunction

function Trig_Moonblast_Timer takes nothing returns nothing
    local timer t= GetExpiredTimer()
    local integer id= GetHandleId(t)
    local unit caster= LoadUnitHandle(udg_MoonblastHash, id, 0)
    local unit target= LoadUnitHandle(udg_MoonblastHash, id, 1)
    local effect missile= LoadEffectHandle(udg_MoonblastHash, id, 2)
    local real damage= LoadReal(udg_MoonblastHash, id, 3)
    local real x= LoadReal(udg_MoonblastHash, id, 4)
    local real y= LoadReal(udg_MoonblastHash, id, 5)
    local real tx
    local real ty
    local real dx
    local real dy
    local real dist
    local real step= MOONBLAST_SPEED * MOONBLAST_TICK

    if GetUnitTypeId(caster) == 0 or GetUnitTypeId(target) == 0 or GetWidgetLife(target) <= 0.405 then
        call Trig_Moonblast_Cleanup(t)
    else
        set tx=GetUnitX(target)
        set ty=GetUnitY(target)
        set dx=tx - x
        set dy=ty - y
        set dist=SquareRoot(dx * dx + dy * dy)

        if dist <= MOONBLAST_COLLISION or dist <= step then
            call BlzSetSpecialEffectX(missile, tx)
            call BlzSetSpecialEffectY(missile, ty)
            call UnitDamageTarget(caster, target, damage, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
            call Trig_Moonblast_Cleanup(t)
        else
            set x=x + dx / dist * step
            set y=y + dy / dist * step

            call SaveReal(udg_MoonblastHash, id, 4, x)
            call SaveReal(udg_MoonblastHash, id, 5, y)
            call BlzSetSpecialEffectX(missile, x)
            call BlzSetSpecialEffectY(missile, y)
            call BlzSetSpecialEffectYaw(missile, Atan2(dy, dx))
        endif
    endif

    set caster=null
    set target=null
    set missile=null
    set t=null
endfunction

function Trig_Moonblast_Actions takes nothing returns nothing
    local unit target= GetSpellTargetUnit()
    local unit caster= GetTriggerUnit()
    local timer t
    local integer id
    local effect missile
    local real x
    local real y
    local real dx
    local real dy

    if target == null or caster == null then
        set target=null
        set caster=null
        return
    endif

    set t=CreateTimer()
    set id=GetHandleId(t)
    set x=GetUnitX(caster)
    set y=GetUnitY(caster)
    set dx=GetUnitX(target) - x
    set dy=GetUnitY(target) - y
    set missile=AddSpecialEffect(MOONBLAST_MISSILE_MODEL, x, y)

    call BlzSetSpecialEffectYaw(missile, Atan2(dy, dx))

    call SaveUnitHandle(udg_MoonblastHash, id, 0, caster)
    call SaveUnitHandle(udg_MoonblastHash, id, 1, target)
    call SaveEffectHandle(udg_MoonblastHash, id, 2, missile)
    call SaveReal(udg_MoonblastHash, id, 3, GetUnitState(caster, UNIT_STATE_MAX_MANA) * MOONBLAST_DAMAGE_FACTOR)
    call SaveReal(udg_MoonblastHash, id, 4, x)
    call SaveReal(udg_MoonblastHash, id, 5, y)

    call TimerStart(t, MOONBLAST_TICK, true, function Trig_Moonblast_Timer)

    set target=null
    set caster=null
    set missile=null
    set t=null
endfunction

//===========================================================================
function InitTrig_Moonblast takes nothing returns nothing
    set gg_trg_Moonblast=CreateTrigger()

    if udg_MoonblastHash == null then
        set udg_MoonblastHash=InitHashtable()
    endif

    call TriggerRegisterAnyUnitEventBJ(gg_trg_Moonblast, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Moonblast, Condition(function Trig_Moonblast_Conditions))
    call TriggerAddAction(gg_trg_Moonblast, function Trig_Moonblast_Actions)
endfunction
//===========================================================================
// Trigger: Moonblast Leveled
//===========================================================================
function Trig_Moonblast_Leveled_Conditions takes nothing returns boolean
    if ( not ( GetResearched() == 'R051' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Moonblast_Leveled_Func001002 takes nothing returns nothing
    call IncUnitAbilityLevelSwapped('A07H', GetEnumUnit())
endfunction

function Trig_Moonblast_Leveled_Actions takes nothing returns nothing
    call ForGroupBJ(GetUnitsOfPlayerAndTypeId(GetTriggerPlayer(), 'h010'), function Trig_Moonblast_Leveled_Func001002)
endfunction

//===========================================================================
function InitTrig_Moonblast_Leveled takes nothing returns nothing
    set gg_trg_Moonblast_Leveled=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Moonblast_Leveled, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    call TriggerAddCondition(gg_trg_Moonblast_Leveled, Condition(function Trig_Moonblast_Leveled_Conditions))
    call TriggerAddAction(gg_trg_Moonblast_Leveled, function Trig_Moonblast_Leveled_Actions)
endfunction

//===========================================================================
// Trigger: Lunar Assault
//
// TODO
//===========================================================================
function Trig_Lunar_Assault_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A07I'
endfunction

function Trig_Lunar_Assault_Actions takes nothing returns nothing
    local unit target= GetSpellTargetUnit()
    local unit caster= GetTriggerUnit()
    local integer level= GetUnitAbilityLevel(caster, 'A07I')
    local real factor= 0.20 + 0.10 * ( level - 1 )
    local real damage= GetUnitState(caster, UNIT_STATE_MAX_MANA) * factor

    if GetUnitTypeId(caster) != 0 and GetUnitTypeId(target) != 0 and GetWidgetLife(target) > 0.405 then
        call UnitDamageTarget(caster, target, damage, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
    endif

    set target=null
    set caster=null
endfunction

//===========================================================================
function InitTrig_Lunar_Assault takes nothing returns nothing
    set gg_trg_Lunar_Assault=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Lunar_Assault, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Lunar_Assault, Condition(function Trig_Lunar_Assault_Conditions))
    call TriggerAddAction(gg_trg_Lunar_Assault, function Trig_Lunar_Assault_Actions)
endfunction
//===========================================================================
// Trigger: Lunar Assault Leveled
//===========================================================================
function Trig_Lunar_Assault_Leveled_Conditions takes nothing returns boolean
    if ( not ( GetResearched() == 'R051' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Lunar_Assault_Leveled_Func001002 takes nothing returns nothing
    call IncUnitAbilityLevelSwapped('A07I', GetEnumUnit())
endfunction

function Trig_Lunar_Assault_Leveled_Actions takes nothing returns nothing
    call ForGroupBJ(GetUnitsOfPlayerAndTypeId(GetTriggerPlayer(), 'h010'), function Trig_Lunar_Assault_Leveled_Func001002)
endfunction

//===========================================================================
function InitTrig_Lunar_Assault_Leveled takes nothing returns nothing
    set gg_trg_Lunar_Assault_Leveled=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Lunar_Assault_Leveled, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    call TriggerAddCondition(gg_trg_Lunar_Assault_Leveled, Condition(function Trig_Lunar_Assault_Leveled_Conditions))
    call TriggerAddAction(gg_trg_Lunar_Assault_Leveled, function Trig_Lunar_Assault_Leveled_Actions)
endfunction

//===========================================================================
// Trigger: Cascade Leveled
//===========================================================================
function Trig_Cascade_Leveled_Conditions takes nothing returns boolean
    if ( not ( GetResearched() == 'R051' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Cascade_Leveled_Func001002 takes nothing returns nothing
    call IncUnitAbilityLevelSwapped('A07J', GetEnumUnit())
endfunction

function Trig_Cascade_Leveled_Actions takes nothing returns nothing
    call ForGroupBJ(GetUnitsOfPlayerAndTypeId(GetTriggerPlayer(), 'h010'), function Trig_Cascade_Leveled_Func001002)
endfunction

//===========================================================================
function InitTrig_Cascade_Leveled takes nothing returns nothing
    set gg_trg_Cascade_Leveled=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Cascade_Leveled, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    call TriggerAddCondition(gg_trg_Cascade_Leveled, Condition(function Trig_Cascade_Leveled_Conditions))
    call TriggerAddAction(gg_trg_Cascade_Leveled, function Trig_Cascade_Leveled_Actions)
endfunction

//===========================================================================
// Trigger: Nourish
//===========================================================================
function Trig_Nourish_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A07K' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Nourish_Actions takes nothing returns nothing
    call SetUnitLifeBJ(GetSpellTargetUnit(), ( GetUnitStateSwap(UNIT_STATE_LIFE, GetSpellTargetUnit()) + ( GetUnitStateSwap(UNIT_STATE_MAX_MANA, GetSpellAbilityUnit()) * 0.50 ) ))
endfunction

//===========================================================================
function InitTrig_Nourish takes nothing returns nothing
    set gg_trg_Nourish=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Nourish, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Nourish, Condition(function Trig_Nourish_Conditions))
    call TriggerAddAction(gg_trg_Nourish, function Trig_Nourish_Actions)
endfunction

//===========================================================================
// Trigger: Nourish Leveled
//===========================================================================
function Trig_Nourish_Leveled_Conditions takes nothing returns boolean
    if ( not ( GetResearched() == 'R051' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Nourish_Leveled_Func001002 takes nothing returns nothing
    call IncUnitAbilityLevelSwapped('A07K', GetEnumUnit())
endfunction

function Trig_Nourish_Leveled_Actions takes nothing returns nothing
    call ForGroupBJ(GetUnitsOfPlayerAndTypeId(GetTriggerPlayer(), 'h010'), function Trig_Nourish_Leveled_Func001002)
endfunction

//===========================================================================
function InitTrig_Nourish_Leveled takes nothing returns nothing
    set gg_trg_Nourish_Leveled=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Nourish_Leveled, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    call TriggerAddCondition(gg_trg_Nourish_Leveled, Condition(function Trig_Nourish_Leveled_Conditions))
    call TriggerAddAction(gg_trg_Nourish_Leveled, function Trig_Nourish_Leveled_Actions)
endfunction

//===========================================================================
// Trigger: Solar Blast
//
// TODO
//===========================================================================
function Trig_Solar_Blast_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A07L'
endfunction

function Trig_Solar_Blast_Actions takes nothing returns nothing
    local unit target= GetSpellTargetUnit()
    local unit caster= GetTriggerUnit()
    local real mana= GetUnitState(caster, UNIT_STATE_MANA)
    local real damage= mana * 1.33

    if GetUnitTypeId(caster) != 0 and GetUnitTypeId(target) != 0 and GetWidgetLife(target) > 0.405 then
        call UnitDamageTarget(caster, target, damage, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
    endif

    if GetUnitTypeId(caster) != 0 then
        call SetUnitState(caster, UNIT_STATE_MANA, 0.00)
    endif

    set target=null
    set caster=null
endfunction

//===========================================================================
function InitTrig_Solar_Blast takes nothing returns nothing
    set gg_trg_Solar_Blast=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Solar_Blast, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Solar_Blast, Condition(function Trig_Solar_Blast_Conditions))
    call TriggerAddAction(gg_trg_Solar_Blast, function Trig_Solar_Blast_Actions)
endfunction
//===========================================================================
// Trigger: Natural Vigil Leveled
//===========================================================================
function Trig_Natural_Vigil_Leveled_Conditions takes nothing returns boolean
    if ( not ( GetResearched() == 'R051' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Natural_Vigil_Leveled_Func001002 takes nothing returns nothing
    call IncUnitAbilityLevelSwapped('A07M', GetEnumUnit())
endfunction

function Trig_Natural_Vigil_Leveled_Actions takes nothing returns nothing
    call ForGroupBJ(GetUnitsOfPlayerAndTypeId(GetTriggerPlayer(), 'h010'), function Trig_Natural_Vigil_Leveled_Func001002)
endfunction

//===========================================================================
function InitTrig_Natural_Vigil_Leveled takes nothing returns nothing
    set gg_trg_Natural_Vigil_Leveled=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Natural_Vigil_Leveled, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    call TriggerAddCondition(gg_trg_Natural_Vigil_Leveled, Condition(function Trig_Natural_Vigil_Leveled_Conditions))
    call TriggerAddAction(gg_trg_Natural_Vigil_Leveled, function Trig_Natural_Vigil_Leveled_Actions)
endfunction

//===========================================================================
// Trigger: Lifebloom Leveled
//===========================================================================
function Trig_Lifebloom_Leveled_Conditions takes nothing returns boolean
    if ( not ( GetResearched() == 'R051' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Lifebloom_Leveled_Func001002 takes nothing returns nothing
    call IncUnitAbilityLevelSwapped('A07N', GetEnumUnit())
endfunction

function Trig_Lifebloom_Leveled_Actions takes nothing returns nothing
    call ForGroupBJ(GetUnitsOfPlayerAndTypeId(GetTriggerPlayer(), 'h010'), function Trig_Lifebloom_Leveled_Func001002)
endfunction

//===========================================================================
function InitTrig_Lifebloom_Leveled takes nothing returns nothing
    set gg_trg_Lifebloom_Leveled=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Lifebloom_Leveled, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    call TriggerAddCondition(gg_trg_Lifebloom_Leveled, Condition(function Trig_Lifebloom_Leveled_Conditions))
    call TriggerAddAction(gg_trg_Lifebloom_Leveled, function Trig_Lifebloom_Leveled_Actions)
endfunction

//===========================================================================
// Trigger: Suns Fury
//===========================================================================
function Trig_Suns_Fury_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A087' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Suns_Fury_Actions takes nothing returns nothing
    call UnitResetCooldown(GetSpellAbilityUnit())
endfunction

//===========================================================================
function InitTrig_Suns_Fury takes nothing returns nothing
    set gg_trg_Suns_Fury=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Suns_Fury, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Suns_Fury, Condition(function Trig_Suns_Fury_Conditions))
    call TriggerAddAction(gg_trg_Suns_Fury, function Trig_Suns_Fury_Actions)
endfunction

//===========================================================================
// Trigger: Return lumber
//===========================================================================
function Trig_Return_lumber_Conditions takes nothing returns boolean
    if ( not ( GetIssuedOrderIdBJ() == String2OrderIdBJ("harvest") ) ) then
        return false
    endif
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'h00R' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Return_lumber_Actions takes nothing returns nothing
    call SetPlayerStateBJ(GetOwningPlayer(GetTriggerUnit()), PLAYER_STATE_RESOURCE_GOLD, ( GetPlayerState(GetOwningPlayer(GetTriggerUnit()), PLAYER_STATE_RESOURCE_GOLD) + 1 ))
endfunction

//===========================================================================
function InitTrig_Return_lumber takes nothing returns nothing
    set gg_trg_Return_lumber=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Return_lumber, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER)
    call TriggerAddCondition(gg_trg_Return_lumber, Condition(function Trig_Return_lumber_Conditions))
    call TriggerAddAction(gg_trg_Return_lumber, function Trig_Return_lumber_Actions)
endfunction

//===========================================================================
// Trigger: Slash Leveled
//===========================================================================
function Trig_Slash_Leveled_Conditions takes nothing returns boolean
    if ( not ( GetResearched() == 'R030' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Slash_Leveled_Func001002 takes nothing returns nothing
    call IncUnitAbilityLevelSwapped('A042', GetEnumUnit())
endfunction

function Trig_Slash_Leveled_Actions takes nothing returns nothing
    call ForGroupBJ(GetUnitsOfPlayerAndTypeId(GetTriggerPlayer(), 'h00R'), function Trig_Slash_Leveled_Func001002)
endfunction

//===========================================================================
function InitTrig_Slash_Leveled takes nothing returns nothing
    set gg_trg_Slash_Leveled=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Slash_Leveled, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    call TriggerAddCondition(gg_trg_Slash_Leveled, Condition(function Trig_Slash_Leveled_Conditions))
    call TriggerAddAction(gg_trg_Slash_Leveled, function Trig_Slash_Leveled_Actions)
endfunction

//===========================================================================
// Trigger: Bleed Leveled
//===========================================================================
function Trig_Bleed_Leveled_Conditions takes nothing returns boolean
    if ( not ( GetResearched() == 'R030' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Bleed_Leveled_Func001002 takes nothing returns nothing
    call IncUnitAbilityLevelSwapped('A04C', GetEnumUnit())
endfunction

function Trig_Bleed_Leveled_Actions takes nothing returns nothing
    call ForGroupBJ(GetUnitsOfPlayerAndTypeId(GetTriggerPlayer(), 'h00R'), function Trig_Bleed_Leveled_Func001002)
endfunction

//===========================================================================
function InitTrig_Bleed_Leveled takes nothing returns nothing
    set gg_trg_Bleed_Leveled=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Bleed_Leveled, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    call TriggerAddCondition(gg_trg_Bleed_Leveled, Condition(function Trig_Bleed_Leveled_Conditions))
    call TriggerAddAction(gg_trg_Bleed_Leveled, function Trig_Bleed_Leveled_Actions)
endfunction

//===========================================================================
// Trigger: Focused Strike
//===========================================================================
function Trig_Focused_Strike_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetAttacker()) == 'h00R' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Focused_Strike_Actions takes nothing returns nothing
    set udg_WorgenAttack=GetAttacker()
    call TriggerSleepAction(0.50)
    call UnitRemoveBuffBJ('B02U', udg_WorgenAttack)
    set udg_WorgenAttack=null
endfunction

//===========================================================================
function InitTrig_Focused_Strike takes nothing returns nothing
    set gg_trg_Focused_Strike=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Focused_Strike, EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddCondition(gg_trg_Focused_Strike, Condition(function Trig_Focused_Strike_Conditions))
    call TriggerAddAction(gg_trg_Focused_Strike, function Trig_Focused_Strike_Actions)
endfunction

//===========================================================================
// Trigger: FanOfKnivesBasedSpells
//===========================================================================

function BURST_IsSupportedAbility takes integer abilId returns boolean
    return abilId == BURST_DRAGONIC_ABIL_ID or abilId == BURST_LICH_ABIL_ID
endfunction

function BURST_GetMissileModel takes integer abilId returns string
    if abilId == BURST_DRAGONIC_ABIL_ID then
        return "units\\creeps\\RedDragonWelp\\RedDragonWelp.mdl"
    endif

    if abilId == BURST_LICH_ABIL_ID then
        return "Abilities\\Weapons\\LichMissile\\LichMissile.mdl"
    endif

    return ""
endfunction

function BURST_GetMissileSpeed takes integer abilId,integer level returns real
    if abilId == BURST_DRAGONIC_ABIL_ID then
        return 700.00
    endif

    if abilId == BURST_LICH_ABIL_ID then
        return 500.00
    endif

    return 0.00
endfunction

function BURST_GetMissileHeight takes integer abilId,integer level returns real
    if abilId == BURST_DRAGONIC_ABIL_ID then
        return 200.00
    endif

    if abilId == BURST_LICH_ABIL_ID then
        return 70.00
    endif

    return 70.00
endfunction

function BURST_GetMissileScale takes integer abilId,integer level returns real
    if abilId == BURST_DRAGONIC_ABIL_ID then
        return 1.50
    endif

    if abilId == BURST_LICH_ABIL_ID then
        return 1.00
    endif

    return 1.00
endfunction

function BURST_GetHitRange takes integer abilId,integer level returns real
    if abilId == BURST_DRAGONIC_ABIL_ID then
        return 30.00
    endif

    if abilId == BURST_LICH_ABIL_ID then
        return 35.00
    endif

    return 35.00
endfunction

function BURST_GetDamage takes integer abilId,integer level returns real
    // Current Dragonic Burst formula.
    if abilId == BURST_DRAGONIC_ABIL_ID then
        return 100.00 + 25.00 * I2R(level - 1)
    endif

    // New Lich spell. Change this if it should have a different damage formula.
    if abilId == BURST_LICH_ABIL_ID then
        return 100.00 + 25.00 * I2R(level - 1)
    endif

    return 0.00
endfunction

function BURST_GetAoE takes integer abilId,integer level returns real
    if abilId == BURST_DRAGONIC_ABIL_ID then
        return 500.00 + 50.00 * I2R(level - 1)
    endif

    if abilId == BURST_LICH_ABIL_ID then
        return 800.00
    endif

    return 0.00
endfunction

function BURST_UnitExists takes unit u returns boolean
    return GetUnitTypeId(u) != 0
endfunction

function BURST_IsAlive takes unit u returns boolean
    return GetUnitTypeId(u) != 0 and GetWidgetLife(u) > 0.405
endfunction

function BURST_IsValidTarget takes unit caster,unit target returns boolean
    return BURST_IsAlive(target) and IsUnitEnemy(target, GetOwningPlayer(caster)) and not IsUnitType(target, UNIT_TYPE_STRUCTURE) and not IsUnitType(target, UNIT_TYPE_MAGIC_IMMUNE)
endfunction

function BURST_RemoveMissile takes integer i returns nothing
    call DestroyEffect(BURST_MISSILE[i])

    set BURST_CASTER[i]=BURST_CASTER[BURST_COUNT]
    set BURST_TARGET[i]=BURST_TARGET[BURST_COUNT]
    set BURST_MISSILE[i]=BURST_MISSILE[BURST_COUNT]
    set BURST_X[i]=BURST_X[BURST_COUNT]
    set BURST_Y[i]=BURST_Y[BURST_COUNT]
    set BURST_DAMAGE[i]=BURST_DAMAGE[BURST_COUNT]
    set BURST_SPEED[i]=BURST_SPEED[BURST_COUNT]
    set BURST_HEIGHT[i]=BURST_HEIGHT[BURST_COUNT]

    set BURST_CASTER[BURST_COUNT]=null
    set BURST_TARGET[BURST_COUNT]=null
    set BURST_MISSILE[BURST_COUNT]=null
    set BURST_X[BURST_COUNT]=0.00
    set BURST_Y[BURST_COUNT]=0.00
    set BURST_DAMAGE[BURST_COUNT]=0.00
    set BURST_SPEED[BURST_COUNT]=0.00
    set BURST_HEIGHT[BURST_COUNT]=0.00

    set BURST_COUNT=BURST_COUNT - 1
endfunction

function BURST_Periodic takes nothing returns nothing
    local integer i= 1
    local real tx
    local real ty
    local real dx
    local real dy
    local real dist
    local real angle
    local real step

    loop
        exitwhen i > BURST_COUNT

        if not (GetUnitTypeId((BURST_CASTER[i])) != 0) or not BURST_IsAlive(BURST_TARGET[i]) then // INLINED!!
            call BURST_RemoveMissile(i)
        else
            set tx=GetUnitX(BURST_TARGET[i])
            set ty=GetUnitY(BURST_TARGET[i])

            set dx=tx - BURST_X[i]
            set dy=ty - BURST_Y[i]
            set dist=SquareRoot(dx * dx + dy * dy)
            set step=BURST_SPEED[i] * BURST_PERIOD

            if dist <= step then
                if BURST_IsValidTarget(BURST_CASTER[i] , BURST_TARGET[i]) then
                    call UnitDamageTarget(BURST_CASTER[i], BURST_TARGET[i], BURST_DAMAGE[i], false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
                endif

                call BURST_RemoveMissile(i)
            else
                set angle=Atan2(dy, dx)

                set BURST_X[i]=BURST_X[i] + Cos(angle) * step
                set BURST_Y[i]=BURST_Y[i] + Sin(angle) * step

                call BlzSetSpecialEffectPosition(BURST_MISSILE[i], BURST_X[i], BURST_Y[i], BURST_HEIGHT[i])
                call BlzSetSpecialEffectYaw(BURST_MISSILE[i], angle)

                set i=i + 1
            endif
        endif
    endloop

    if BURST_COUNT == 0 then
        call PauseTimer(BURST_TIMER)
    endif
endfunction

function BURST_StartMissile takes unit caster,unit target,integer abilId,integer level returns nothing
    local real x= GetUnitX(caster)
    local real y= GetUnitY(caster)
    local real angle= Atan2(GetUnitY(target) - y, GetUnitX(target) - x)
    local real height= BURST_GetMissileHeight(abilId , level)
    local effect e= AddSpecialEffect(BURST_GetMissileModel(abilId), x, y)

    call BlzSetSpecialEffectScale(e, BURST_GetMissileScale(abilId , level))
    call BlzSetSpecialEffectPosition(e, x, y, height)
    call BlzSetSpecialEffectYaw(e, angle)

    set BURST_COUNT=BURST_COUNT + 1

    set BURST_CASTER[BURST_COUNT]=caster
    set BURST_TARGET[BURST_COUNT]=target
    set BURST_MISSILE[BURST_COUNT]=e
    set BURST_X[BURST_COUNT]=x
    set BURST_Y[BURST_COUNT]=y
    set BURST_DAMAGE[BURST_COUNT]=BURST_GetDamage(abilId , level)
    set BURST_SPEED[BURST_COUNT]=BURST_GetMissileSpeed(abilId , level)
    set BURST_HEIGHT[BURST_COUNT]=height

    if BURST_COUNT == 1 then
        call TimerStart(BURST_TIMER, BURST_PERIOD, true, function BURST_Periodic)
    endif

    set e=null
endfunction

function BURST_OnCast takes nothing returns nothing
    local unit caster= GetTriggerUnit()
    local integer abilId= GetSpellAbilityId()
    local integer level
    local real x
    local real y
    local real aoe
    local unit target

    if not BURST_IsSupportedAbility(abilId) then
        set caster=null
        return
    endif

    set level=GetUnitAbilityLevel(caster, abilId)
    set x=GetUnitX(caster)
    set y=GetUnitY(caster)
    set aoe=BURST_GetAoE(abilId , level)

    call GroupEnumUnitsInRange(BURST_ENUM_GROUP, x, y, aoe, null)

    loop
        set target=FirstOfGroup(BURST_ENUM_GROUP)
        exitwhen target == null

        call GroupRemoveUnit(BURST_ENUM_GROUP, target)

        if BURST_IsValidTarget(caster , target) then
            call BURST_StartMissile(caster , target , abilId , level)
        endif
    endloop

    set caster=null
    set target=null
endfunction

function BURST_Conditions takes nothing returns boolean
    return BURST_IsSupportedAbility(GetSpellAbilityId())
endfunction

function InitTrig_FanOfKnivesBasedSpells takes nothing returns nothing
    local trigger t= CreateTrigger()
    local integer i= 0

    loop
        exitwhen i >= bj_MAX_PLAYER_SLOTS
        call TriggerRegisterPlayerUnitEvent(t, Player(i), EVENT_PLAYER_UNIT_SPELL_EFFECT, null)
        set i=i + 1
    endloop

    call TriggerAddCondition(t, Condition(function BURST_Conditions))
    call TriggerAddAction(t, function BURST_OnCast)

    set t=null
endfunction
//===========================================================================
// Trigger: Realm of darkness
//===========================================================================
function Trig_Realm_of_darkness_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A0B7' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Realm_of_darkness_Func002001002 takes nothing returns boolean
    return ( IsUnitEnemy(GetEnumUnit(), Player(6)) == true )
endfunction

function Trig_Realm_of_darkness_Func002A takes nothing returns nothing
    call UnitAddAbilityBJ('A0B6', GetEnumUnit())
endfunction

function Trig_Realm_of_darkness_Func005001002 takes nothing returns boolean
    return ( IsUnitEnemy(GetEnumUnit(), Player(6)) == true )
endfunction

function Trig_Realm_of_darkness_Func005A takes nothing returns nothing
    call UnitRemoveAbilityBJ('A0B6', GetEnumUnit())
endfunction

function Trig_Realm_of_darkness_Actions takes nothing returns nothing
    call EnableTrigger(gg_trg_Realm_of_darkness_2)
    call ForGroupBJ(GetUnitsInRectMatching(GetPlayableMapRect(), Condition(function Trig_Realm_of_darkness_Func002001002)), function Trig_Realm_of_darkness_Func002A)
    call TriggerSleepAction(60.00)
    call DisableTrigger(gg_trg_Realm_of_darkness_2)
    call ForGroupBJ(GetUnitsInRectMatching(GetPlayableMapRect(), Condition(function Trig_Realm_of_darkness_Func005001002)), function Trig_Realm_of_darkness_Func005A)
endfunction

//===========================================================================
function InitTrig_Realm_of_darkness takes nothing returns nothing
    set gg_trg_Realm_of_darkness=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Realm_of_darkness, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Realm_of_darkness, Condition(function Trig_Realm_of_darkness_Conditions))
    call TriggerAddAction(gg_trg_Realm_of_darkness, function Trig_Realm_of_darkness_Actions)
endfunction

//===========================================================================
// Trigger: Realm of darkness 2
//===========================================================================
function Trig_Realm_of_darkness_2_Conditions takes nothing returns boolean
    if ( not ( IsUnitEnemy(GetTriggerUnit(), udg_AncientPlayer) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Realm_of_darkness_2_Actions takes nothing returns nothing
    call UnitAddAbilityBJ('A0B6', GetEnumUnit())
endfunction

//===========================================================================
function InitTrig_Realm_of_darkness_2 takes nothing returns nothing
    set gg_trg_Realm_of_darkness_2=CreateTrigger()
    call DisableTrigger(gg_trg_Realm_of_darkness_2)
    call TriggerRegisterEnterRectSimple(gg_trg_Realm_of_darkness_2, GetPlayableMapRect())
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Realm_of_darkness_2, EVENT_PLAYER_UNIT_CONSTRUCT_START)
    call TriggerAddCondition(gg_trg_Realm_of_darkness_2, Condition(function Trig_Realm_of_darkness_2_Conditions))
    call TriggerAddAction(gg_trg_Realm_of_darkness_2, function Trig_Realm_of_darkness_2_Actions)
endfunction

//===========================================================================
// Trigger: Thunderstruck
//===========================================================================
function Trig_Thunderstruck_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_DamageEventTarget) == 'O016' ) ) then
        return false
    endif
    if ( not ( udg_IsDamageAttack == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Thunderstruck_Func003C takes nothing returns boolean
    if ( not ( GetRandomReal(0.00, 100.00) <= ( ( 0.75 * I2R(GetUnitLevel(udg_DamageEventTarget)) ) + 0.00 ) ) ) then
        return false
    endif
    return true
endfunction

function Trig_Thunderstruck_Actions takes nothing returns nothing
    set udg_ThunderstruckLevel=GetUnitAbilityLevelSwapped('A03S', udg_DamageEventTarget)
    set udg_ThunderstruckTarget=GetUnitLoc(udg_DamageEventSource)
    if ( Trig_Thunderstruck_Func003C() ) then
        call CreateNUnitsAtLoc(1, 'h04L', GetOwningPlayer(BlzGetEventDamageTarget()), udg_ThunderstruckTarget, bj_UNIT_FACING)
        call UnitAddAbilityBJ('A03S', GetLastCreatedUnit())
        call SetUnitAbilityLevelSwapped('A03S', GetLastCreatedUnit(), udg_ThunderstruckLevel)
        call UnitApplyTimedLifeBJ(2.00, 'BTLF', GetLastCreatedUnit())
        call IssuePointOrderLocBJ(GetLastCreatedUnit(), "flamestrike", udg_ThunderstruckTarget)
    else
    endif
endfunction

//===========================================================================
function InitTrig_Thunderstruck takes nothing returns nothing
    set gg_trg_Thunderstruck=CreateTrigger()
    call h__TriggerRegisterVariableEvent(gg_trg_Thunderstruck, "udg_DamageEvent", EQUAL, 1.00)
    call TriggerAddCondition(gg_trg_Thunderstruck, Condition(function Trig_Thunderstruck_Conditions))
    call TriggerAddAction(gg_trg_Thunderstruck, function Trig_Thunderstruck_Actions)
endfunction

//===========================================================================
// Trigger: Lightning Strike
//===========================================================================
function Trig_Lightning_Strike_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A03S' ) ) then
        return false
    endif
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'O016' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Lightning_Strike_Actions takes nothing returns nothing
    call CreateTimerDialogBJ(udg_LS, "TRIGSTR_7242")
    call StartTimerBJ(udg_LS, false, 25.00)
    call TriggerSleepAction(25.00)
    call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
endfunction

//===========================================================================
function InitTrig_Lightning_Strike takes nothing returns nothing
    set gg_trg_Lightning_Strike=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Lightning_Strike, EVENT_PLAYER_UNIT_SPELL_FINISH)
    call TriggerAddCondition(gg_trg_Lightning_Strike, Condition(function Trig_Lightning_Strike_Conditions))
    call TriggerAddAction(gg_trg_Lightning_Strike, function Trig_Lightning_Strike_Actions)
endfunction

//===========================================================================
// Trigger: RecallStart
//===========================================================================
function Trig_RecallStart_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A0AL' ) ) then
        return false
    endif
    return true
endfunction

function Trig_RecallStart_Actions takes nothing returns nothing
    set udg_RecallTarget=GetSpellTargetUnit()
endfunction

//===========================================================================
function InitTrig_RecallStart takes nothing returns nothing
    set gg_trg_RecallStart=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_RecallStart, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(gg_trg_RecallStart, Condition(function Trig_RecallStart_Conditions))
    call TriggerAddAction(gg_trg_RecallStart, function Trig_RecallStart_Actions)
endfunction

//===========================================================================
// Trigger: Recall
//===========================================================================
function Trig_Recall_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A0AL' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Recall_Actions takes nothing returns nothing
    call SetUnitPositionLoc(udg_RecallTarget, GetRectCenter(gg_rct_Fountain))
endfunction

//===========================================================================
function InitTrig_Recall takes nothing returns nothing
    set gg_trg_Recall=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Recall, EVENT_PLAYER_UNIT_SPELL_FINISH)
    call TriggerAddCondition(gg_trg_Recall, Condition(function Trig_Recall_Conditions))
    call TriggerAddAction(gg_trg_Recall, function Trig_Recall_Actions)
endfunction

//===========================================================================
// Trigger: Time warp
//===========================================================================
function Trig_Time_warp_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A08S' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Time_warp_Func004Func001001 takes nothing returns boolean
    return ( IsUnitEnemy(GetEnumUnit(), GetOwningPlayer(GetSpellAbilityUnit())) == true )
endfunction

function Trig_Time_warp_Func004A takes nothing returns nothing
    if ( (IsUnitEnemy(GetEnumUnit(), GetOwningPlayer(GetSpellAbilityUnit())) == true) ) then // INLINED!!
        call UnitDamageTargetBJ(GetSpellAbilityUnit(), GetEnumUnit(), 300.00, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL)
    else
        call DoNothing()
    endif
endfunction

function Trig_Time_warp_Actions takes nothing returns nothing
    set udg_TimeWarpCaster=GetSpellAbilityUnit()
    set udg_TimeWarp=GetSpellTargetLoc()
    call UnitDamagePointLoc(udg_AncientUnit, 0, 500, GetUnitLoc(udg_TimeWarpCaster), 300.00, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL)
    call ForGroupBJ(GetUnitsInRangeOfLocAll(512, OffsetLocation(udg_TimeWarp, 0, 0)), function Trig_Time_warp_Func004A)
endfunction

//===========================================================================
function InitTrig_Time_warp takes nothing returns nothing
    set gg_trg_Time_warp=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Time_warp, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Time_warp, Condition(function Trig_Time_warp_Conditions))
    call TriggerAddAction(gg_trg_Time_warp, function Trig_Time_warp_Actions)
endfunction

//===========================================================================
// Trigger: Galactic Fury
//===========================================================================
function Trig_Galactic_Fury_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A0F1' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Galactic_Fury_Actions takes nothing returns nothing
    set udg_GalacticFuryCaster=GetSpellAbilityUnit()
endfunction

//===========================================================================
function InitTrig_Galactic_Fury takes nothing returns nothing
    set gg_trg_Galactic_Fury=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Galactic_Fury, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Galactic_Fury, Condition(function Trig_Galactic_Fury_Conditions))
    call TriggerAddAction(gg_trg_Galactic_Fury, function Trig_Galactic_Fury_Actions)
endfunction

//===========================================================================
// Trigger: Galactic Fury 2
//===========================================================================
function Trig_Galactic_Fury_2_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A0F1' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Galactic_Fury_2_Actions takes nothing returns nothing
    call SetUnitLifePercentBJ(udg_GalacticFuryCaster, ( GetUnitLifePercent(udg_GalacticFuryCaster) + 25.00 ))
endfunction

//===========================================================================
function InitTrig_Galactic_Fury_2 takes nothing returns nothing
    set gg_trg_Galactic_Fury_2=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Galactic_Fury_2, EVENT_PLAYER_UNIT_SPELL_FINISH)
    call TriggerAddCondition(gg_trg_Galactic_Fury_2, Condition(function Trig_Galactic_Fury_2_Conditions))
    call TriggerAddAction(gg_trg_Galactic_Fury_2, function Trig_Galactic_Fury_2_Actions)
endfunction

//===========================================================================
// Trigger: Galactic Fury 3
//===========================================================================

function SSZ_IsValidTarget takes unit caster,unit target returns boolean
    return target != null and target != caster and GetWidgetLife(target) > 0.405 and IsUnitEnemy(target, GetOwningPlayer(caster)) and not IsUnitType(target, UNIT_TYPE_DEAD)
endfunction

function SSZ_RemoveSlow takes nothing returns nothing
    local timer t= GetExpiredTimer()
    local integer tid= GetHandleId(t)
    local unit target= LoadUnitHandle(SSZ_HASH, tid, 0)
    local integer uid

    if target != null then
        set uid=GetHandleId(target)
        call UnitRemoveAbility(target, SSZ_SLOW_ID)
        call FlushChildHashtable(SSZ_HASH, uid)
    endif

    call FlushChildHashtable(SSZ_HASH, tid)
    call PauseTimer(t)
    call DestroyTimer(t)

    set target=null
    set t=null
endfunction

function SSZ_ApplySlow takes unit target returns nothing
    local integer uid= GetHandleId(target)
    local timer t= LoadTimerHandle(SSZ_HASH, uid, 0)

    if GetUnitAbilityLevel(target, SSZ_SLOW_ID) == 0 then
        call UnitAddAbility(target, SSZ_SLOW_ID)
    endif

    if t == null then
        set t=CreateTimer()
        call SaveTimerHandle(SSZ_HASH, uid, 0, t)
        call SaveUnitHandle(SSZ_HASH, GetHandleId(t), 0, target)
    endif

    call TimerStart(t, SSZ_SLOW_DURATION, false, function SSZ_RemoveSlow)

    set t=null
endfunction

function SSZ_OnCast takes nothing returns nothing
    local unit caster= GetTriggerUnit()
    local group g= CreateGroup()
    local unit target
    local real x= GetUnitX(caster)
    local real y= GetUnitY(caster)

    call GroupEnumUnitsInRange(g, x, y, SSZ_AOE, null)

    loop
        set target=FirstOfGroup(g)
        exitwhen target == null
        call GroupRemoveUnit(g, target)

        if SSZ_IsValidTarget(caster , target) then
            if not IsUnitType(target, UNIT_TYPE_STRUCTURE) then
                call UnitDamageTarget(caster, target, SSZ_DAMAGE, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
            endif

            if GetWidgetLife(target) > 0.405 then
                call SSZ_ApplySlow(target)
            endif
        endif
    endloop

    call DestroyGroup(g)

    set target=null
    set g=null
    set caster=null
endfunction

function SSZ_Condition takes nothing returns boolean
    return GetSpellAbilityId() == SSZ_SPELL_ID
endfunction

function InitTrig_Galactic_Fury_3 takes nothing returns nothing
    local trigger t= CreateTrigger()
    local integer i= 0

    if SSZ_HASH == null then
        set SSZ_HASH=InitHashtable()
    endif

    loop
        exitwhen i >= bj_MAX_PLAYER_SLOTS
        call TriggerRegisterPlayerUnitEvent(t, Player(i), EVENT_PLAYER_UNIT_SPELL_EFFECT, null)
        set i=i + 1
    endloop

    call TriggerAddCondition(t, Condition(function SSZ_Condition))
    call TriggerAddAction(t, function SSZ_OnCast)

    set t=null
endfunction
//===========================================================================
// Trigger: Cosmic Strike
//===========================================================================
function Trig_Cosmic_Strike_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A08R' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Cosmic_Strike_Actions takes nothing returns nothing
    set udg_CosmicStrikeCaster=GetSpellAbilityUnit()
    set udg_CosmicStrikeCount=1
endfunction

//===========================================================================
function InitTrig_Cosmic_Strike takes nothing returns nothing
    set gg_trg_Cosmic_Strike=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Cosmic_Strike, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Cosmic_Strike, Condition(function Trig_Cosmic_Strike_Conditions))
    call TriggerAddAction(gg_trg_Cosmic_Strike, function Trig_Cosmic_Strike_Actions)
endfunction

//===========================================================================
// Trigger: Cosmic Strike 2
//===========================================================================
function Trig_Cosmic_Strike_2_Conditions takes nothing returns boolean
    if ( not ( udg_DamageEventSource == udg_CosmicStrikeCaster ) ) then
        return false
    endif
    if ( not ( udg_IsDamageAttack == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Cosmic_Strike_2_Func005001 takes nothing returns boolean
    return ( udg_CosmicStrikeCount == 0 )
endfunction

function Trig_Cosmic_Strike_2_Actions takes nothing returns nothing
    call SetUnitManaPercentBJ(udg_CosmicStrikeCaster, ( GetUnitManaPercent(GetEventDamageSource()) + 5.00 ))
    set udg_CosmicStrikeCount=( udg_CosmicStrikeCount - 1 )
    if ( (udg_CosmicStrikeCount == 0) ) then // INLINED!!
        call UnitRemoveBuffBJ('B038', udg_CosmicStrikeCaster)
    else
        call DoNothing()
    endif
    set udg_CosmicStrikeCaster=null
endfunction

//===========================================================================
function InitTrig_Cosmic_Strike_2 takes nothing returns nothing
    set gg_trg_Cosmic_Strike_2=CreateTrigger()
    call h__TriggerRegisterVariableEvent(gg_trg_Cosmic_Strike_2, "udg_DamageEvent", EQUAL, 1.00)
    call TriggerAddCondition(gg_trg_Cosmic_Strike_2, Condition(function Trig_Cosmic_Strike_2_Conditions))
    call TriggerAddAction(gg_trg_Cosmic_Strike_2, function Trig_Cosmic_Strike_2_Actions)
endfunction

//===========================================================================
// Trigger: Cosmic Strike 3
//===========================================================================
function Trig_Cosmic_Strike_3_Conditions takes nothing returns boolean
    if ( not ( UnitHasBuffBJ(udg_DamageEventSource, 'B038') == true ) ) then
        return false
    endif
    if ( not ( udg_IsDamageAttack == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Cosmic_Strike_3_Actions takes nothing returns nothing
    set udg_DamageEventAttackT=udg_ATTACK_TYPE_CHAOS
endfunction

//===========================================================================
function InitTrig_Cosmic_Strike_3 takes nothing returns nothing
    set gg_trg_Cosmic_Strike_3=CreateTrigger()
    call h__TriggerRegisterVariableEvent(gg_trg_Cosmic_Strike_3, "udg_PreDamageEvent", LESS_THAN, 1.00)
    call TriggerAddCondition(gg_trg_Cosmic_Strike_3, Condition(function Trig_Cosmic_Strike_3_Conditions))
    call TriggerAddAction(gg_trg_Cosmic_Strike_3, function Trig_Cosmic_Strike_3_Actions)
endfunction

//===========================================================================
// Trigger: Resillience
//===========================================================================
function Trig_Resillience_Conditions takes nothing returns boolean
    if ( not ( GetLearnedSkillBJ() == 'A088' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Resillience_Actions takes nothing returns nothing
    set udg_Resillence=0.50
    set udg_ResillienceLvler=GetLearningUnit()
    call EnableTrigger(gg_trg_Resillience_3)
    call DisableTrigger(GetTriggeringTrigger())
endfunction

//===========================================================================
function InitTrig_Resillience takes nothing returns nothing
    set gg_trg_Resillience=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Resillience, EVENT_PLAYER_HERO_SKILL)
    call TriggerAddCondition(gg_trg_Resillience, Condition(function Trig_Resillience_Conditions))
    call TriggerAddAction(gg_trg_Resillience, function Trig_Resillience_Actions)
endfunction

//===========================================================================
// Trigger: Resillience 2
//===========================================================================
function Trig_Resillience_2_Actions takes nothing returns nothing
    call SetUnitManaPercentBJ(udg_ResillienceLvler, ( GetUnitManaPercent(udg_ResillienceLvler) + udg_Resillence ))
endfunction

//===========================================================================
function InitTrig_Resillience_2 takes nothing returns nothing
    set gg_trg_Resillience_2=CreateTrigger()
    call TriggerRegisterTimerEventPeriodic(gg_trg_Resillience_2, 1.00)
    call TriggerAddAction(gg_trg_Resillience_2, function Trig_Resillience_2_Actions)
endfunction

//===========================================================================
// Trigger: Resillience 3
//===========================================================================
function Trig_Resillience_3_Conditions takes nothing returns boolean
    if ( not ( GetLearnedSkillBJ() == 'A088' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Resillience_3_Actions takes nothing returns nothing
    set udg_Resillence=( udg_Resillence + 0.50 )
endfunction

//===========================================================================
function InitTrig_Resillience_3 takes nothing returns nothing
    set gg_trg_Resillience_3=CreateTrigger()
    call DisableTrigger(gg_trg_Resillience_3)
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Resillience_3, EVENT_PLAYER_HERO_SKILL)
    call TriggerAddCondition(gg_trg_Resillience_3, Condition(function Trig_Resillience_3_Conditions))
    call TriggerAddAction(gg_trg_Resillience_3, function Trig_Resillience_3_Actions)
endfunction

//===========================================================================
// Trigger: Sandstorm
//===========================================================================
function Trig_Sandstorm_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A07Y' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Sandstorm_Actions takes nothing returns nothing
    call SetUnitLifePercentBJ(GetSpellAbilityUnit(), ( GetUnitLifePercent(GetSpellAbilityUnit()) - 5.00 ))
endfunction

//===========================================================================
function InitTrig_Sandstorm takes nothing returns nothing
    set gg_trg_Sandstorm=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Sandstorm, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Sandstorm, Condition(function Trig_Sandstorm_Conditions))
    call TriggerAddAction(gg_trg_Sandstorm, function Trig_Sandstorm_Actions)
endfunction

//===========================================================================
// Trigger: Sandstorm 2
//===========================================================================
function Trig_Sandstorm_2_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A07Y' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Sandstorm_2_Actions takes nothing returns nothing
    call CreateTimerDialogBJ(udg_LS, "TRIGSTR_8327")
    call StartTimerBJ(udg_LS, false, 45.00)
    call TriggerSleepAction(45.00)
    call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
endfunction

//===========================================================================
function InitTrig_Sandstorm_2 takes nothing returns nothing
    set gg_trg_Sandstorm_2=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Sandstorm_2, EVENT_PLAYER_UNIT_SPELL_FINISH)
    call TriggerAddCondition(gg_trg_Sandstorm_2, Condition(function Trig_Sandstorm_2_Conditions))
    call TriggerAddAction(gg_trg_Sandstorm_2, function Trig_Sandstorm_2_Actions)
endfunction

//===========================================================================
// Trigger: Ancient Grasp
//===========================================================================
function Trig_Ancient_Grasp_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A07Z' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Ancient_Grasp_Actions takes nothing returns nothing
    call SetUnitLifePercentBJ(GetSpellAbilityUnit(), ( GetUnitLifePercent(GetSpellAbilityUnit()) - 10.00 ))
    call TriggerSleepAction(1.00)
    call SetUnitLifePercentBJ(GetSpellAbilityUnit(), ( GetUnitLifePercent(GetSpellAbilityUnit()) + 2.00 ))
    call TriggerSleepAction(1.00)
    call SetUnitLifePercentBJ(GetSpellAbilityUnit(), ( GetUnitLifePercent(GetSpellAbilityUnit()) + 2.00 ))
    call TriggerSleepAction(1.00)
    call SetUnitLifePercentBJ(GetSpellAbilityUnit(), ( GetUnitLifePercent(GetSpellAbilityUnit()) + 2.00 ))
    call TriggerSleepAction(1.00)
    call SetUnitLifePercentBJ(GetSpellAbilityUnit(), ( GetUnitLifePercent(GetSpellAbilityUnit()) + 2.00 ))
    call TriggerSleepAction(1.00)
    call SetUnitLifePercentBJ(GetSpellAbilityUnit(), ( GetUnitLifePercent(GetSpellAbilityUnit()) + 2.00 ))
    call TriggerSleepAction(1.00)
    call SetUnitLifePercentBJ(GetSpellAbilityUnit(), ( GetUnitLifePercent(GetSpellAbilityUnit()) + 2.00 ))
    call TriggerSleepAction(1.00)
    call SetUnitLifePercentBJ(GetSpellAbilityUnit(), ( GetUnitLifePercent(GetSpellAbilityUnit()) + 2.00 ))
    call TriggerSleepAction(1.00)
    call SetUnitLifePercentBJ(GetSpellAbilityUnit(), ( GetUnitLifePercent(GetSpellAbilityUnit()) + 2.00 ))
    call TriggerSleepAction(1.00)
    call SetUnitLifePercentBJ(GetSpellAbilityUnit(), ( GetUnitLifePercent(GetSpellAbilityUnit()) + 2.00 ))
    call TriggerSleepAction(1.00)
    call SetUnitLifePercentBJ(GetSpellAbilityUnit(), ( GetUnitLifePercent(GetSpellAbilityUnit()) + 2.00 ))
endfunction

//===========================================================================
function InitTrig_Ancient_Grasp takes nothing returns nothing
    set gg_trg_Ancient_Grasp=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Ancient_Grasp, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Ancient_Grasp, Condition(function Trig_Ancient_Grasp_Conditions))
    call TriggerAddAction(gg_trg_Ancient_Grasp, function Trig_Ancient_Grasp_Actions)
endfunction

//===========================================================================
// Trigger: Deserts Veil
//===========================================================================
function Trig_Deserts_Veil_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A080' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Deserts_Veil_Actions takes nothing returns nothing
    call SetUnitLifePercentBJ(GetSpellAbilityUnit(), ( GetUnitLifePercent(GetSpellAbilityUnit()) + 30.00 ))
endfunction

//===========================================================================
function InitTrig_Deserts_Veil takes nothing returns nothing
    set gg_trg_Deserts_Veil=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Deserts_Veil, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Deserts_Veil, Condition(function Trig_Deserts_Veil_Conditions))
    call TriggerAddAction(gg_trg_Deserts_Veil, function Trig_Deserts_Veil_Actions)
endfunction

//===========================================================================
// Trigger: Chill
//===========================================================================
function Trig_Chill_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A00A' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Chill_Actions takes nothing returns nothing
    call TriggerSleepAction(0.80)
    call SetUnitLifeBJ(GetSpellAbilityUnit(), ( GetUnitStateSwap(UNIT_STATE_LIFE, GetSpellAbilityUnit()) + ( 0.50 * GetUnitStateSwap(UNIT_STATE_MAX_MANA, GetSpellAbilityUnit()) ) ))
endfunction

//===========================================================================
function InitTrig_Chill takes nothing returns nothing
    set gg_trg_Chill=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Chill, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Chill, Condition(function Trig_Chill_Conditions))
    call TriggerAddAction(gg_trg_Chill, function Trig_Chill_Actions)
endfunction

//===========================================================================
// Trigger: Freeze Zone
//===========================================================================
function Trig_Freeze_Zone_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A0EX' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Freeze_Zone_Actions takes nothing returns nothing
    call CreateTimerDialogBJ(udg_FZ, "TRIGSTR_7241")
    call StartTimerBJ(udg_FZ, false, 60.00)
    call TriggerSleepAction(60.00)
    call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
endfunction

//===========================================================================
function InitTrig_Freeze_Zone takes nothing returns nothing
    set gg_trg_Freeze_Zone=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Freeze_Zone, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Freeze_Zone, Condition(function Trig_Freeze_Zone_Conditions))
    call TriggerAddAction(gg_trg_Freeze_Zone, function Trig_Freeze_Zone_Actions)
endfunction

//===========================================================================
// Trigger: Freeze Zone V2
//
// Replicated behavior of a previous one to avoid causing desyncs
//===========================================================================

function TP_IsValidTarget takes unit caster,unit target returns boolean
    return target != null and target != caster and GetWidgetLife(target) > 0.405 and IsUnitEnemy(target, GetOwningPlayer(caster)) and not IsUnitType(target, UNIT_TYPE_DEAD) and not IsUnitType(target, UNIT_TYPE_STRUCTURE) and not IsUnitType(target, UNIT_TYPE_MAGIC_IMMUNE)
endfunction

function TP_DummyCastDelayed takes nothing returns nothing
    local timer t= GetExpiredTimer()
    local integer tid= GetHandleId(t)
    local unit dummy= LoadUnitHandle(TP_HASH, tid, 0)
    local unit target= LoadUnitHandle(TP_HASH, tid, 1)

    if dummy != null and target != null and GetWidgetLife(target) > 0.405 then
        call IssueTargetOrder(dummy, TP_DEBUFF_ORDER, target)
        call UnitApplyTimedLife(dummy, 'BTLF', TP_DUMMY_LIFETIME)
    elseif dummy != null then
        call UnitApplyTimedLife(dummy, 'BTLF', TP_DUMMY_LIFETIME)
    endif

    call FlushChildHashtable(TP_HASH, tid)
    call DestroyTimer(t)

    set target=null
    set dummy=null
    set t=null
endfunction

function TP_CastDebuff takes unit target,integer level returns nothing
    local timer t= CreateTimer()
    local integer tid= GetHandleId(t)
    local unit dummy= CreateUnit(TP_DUMMY_OWNER, TP_DUMMY_ID, GetUnitX(target) + 150.00, GetUnitY(target), 0.00)

    if dummy == null then
        call DestroyTimer(t)

        set dummy=null
        set t=null
        return
    endif

    call UnitAddAbility(dummy, TP_DEBUFF_ID)
    call SetUnitAbilityLevel(dummy, TP_DEBUFF_ID, level)
    call SetUnitState(dummy, UNIT_STATE_MANA, 9999.00)

    call SaveUnitHandle(TP_HASH, tid, 0, dummy)
    call SaveUnitHandle(TP_HASH, tid, 1, target)
    call TimerStart(t, TP_DUMMY_CAST_DELAY, false, function TP_DummyCastDelayed)

    set dummy=null
    set t=null
endfunction

function TP_OnCast takes nothing returns nothing
    local unit caster= GetTriggerUnit()
    local group g= CreateGroup()
    local unit target
    local real x= GetUnitX(caster)
    local real y= GetUnitY(caster)
    local integer level= GetUnitAbilityLevel(caster, TP_SPELL_ID)
    local real damage= TP_DAMAGE_BASE + TP_DAMAGE_PER_LEVEL * I2R(level - 1)

    call GroupEnumUnitsInRange(g, x, y, TP_AOE, null)

    loop
        set target=FirstOfGroup(g)
        exitwhen target == null
        call GroupRemoveUnit(g, target)

        if TP_IsValidTarget(caster , target) then
            call UnitDamageTarget(caster, target, damage, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)

            if GetWidgetLife(target) > 0.405 then
                call TP_CastDebuff(target , level)
            endif
        endif
    endloop

    call DestroyGroup(g)

    set target=null
    set g=null
    set caster=null
endfunction

function TP_Condition takes nothing returns boolean
    return GetSpellAbilityId() == TP_SPELL_ID
endfunction

function InitTrig_Freeze_Zone_V2 takes nothing returns nothing
    local trigger t= CreateTrigger()
    local integer i= 0

    if TP_HASH == null then
        set TP_HASH=InitHashtable()
    endif

    loop
        exitwhen i >= bj_MAX_PLAYER_SLOTS
        call TriggerRegisterPlayerUnitEvent(t, Player(i), EVENT_PLAYER_UNIT_SPELL_EFFECT, null)
        set i=i + 1
    endloop

    call TriggerAddCondition(t, Condition(function TP_Condition))
    call TriggerAddAction(t, function TP_OnCast)

    set t=null
endfunction
//===========================================================================
// Trigger: Sadism
//===========================================================================
function Trig_Sadism_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A075' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Sadism_Actions takes nothing returns nothing
    local integer iterations= 10
    call SetUnitLifeBJ(GetSpellAbilityUnit(), ( GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) * 0.60 ))
    call TriggerSleepAction(1.00)
    loop
        call SetUnitLifeBJ(GetSpellAbilityUnit(), ( GetUnitStateSwap(UNIT_STATE_LIFE, GetSpellAbilityUnit()) + 1000.00 ))
        set iterations=iterations - 1
        call TriggerSleepAction(1.00)
        exitwhen iterations == 0
    endloop
endfunction

//===========================================================================
function InitTrig_Sadism takes nothing returns nothing
    set gg_trg_Sadism=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Sadism, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Sadism, Condition(function Trig_Sadism_Conditions))
    call TriggerAddAction(gg_trg_Sadism, function Trig_Sadism_Actions)
endfunction


//===========================================================================
// Trigger: Reckoning
//===========================================================================
function Trig_Reckoning_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A06W' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Reckoning_Actions takes nothing returns nothing
    set udg_TSEDuration=5.00
    set udg_TSEScale=0.45
    set udg_TSEAttachPoint="origin"
    set udg_TSEEffectName="war3mapImported\\HolyTornado.mdx"
    set udg_TSETargetUnit=GetSpellAbilityUnit()
    call ConditionalTriggerExecute(udg_TSE_RegisterTrigger)
endfunction

//===========================================================================
function InitTrig_Reckoning takes nothing returns nothing
    set gg_trg_Reckoning=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Reckoning, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Reckoning, Condition(function Trig_Reckoning_Conditions))
    call TriggerAddAction(gg_trg_Reckoning, function Trig_Reckoning_Actions)
endfunction


//===========================================================================
// Trigger: Vanguard Initial
//===========================================================================
function Trig_Vanguard_Initial_Conditions takes nothing returns boolean
    if ( not ( GetLearnedSkillBJ() == 'A06U' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Vanguard_Initial_Actions takes nothing returns nothing
    set udg_VanguardHeal=( udg_VanguardHeal + 100.00 )
    call TriggerSleepAction(5.00)
    call EnableTrigger(gg_trg_Vanguard_Future_Levels)
    call DisableTrigger(GetTriggeringTrigger())
endfunction

//===========================================================================
function InitTrig_Vanguard_Initial takes nothing returns nothing
    set gg_trg_Vanguard_Initial=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Vanguard_Initial, EVENT_PLAYER_HERO_SKILL)
    call TriggerAddCondition(gg_trg_Vanguard_Initial, Condition(function Trig_Vanguard_Initial_Conditions))
    call TriggerAddAction(gg_trg_Vanguard_Initial, function Trig_Vanguard_Initial_Actions)
endfunction

//===========================================================================
// Trigger: Vanguard Future Levels
//===========================================================================
function Trig_Vanguard_Future_Levels_Conditions takes nothing returns boolean
    if ( not ( GetLearnedSkillBJ() == 'A06U' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Vanguard_Future_Levels_Actions takes nothing returns nothing
    set udg_VanguardHeal=( udg_VanguardHeal + 50.00 )
endfunction

//===========================================================================
function InitTrig_Vanguard_Future_Levels takes nothing returns nothing
    set gg_trg_Vanguard_Future_Levels=CreateTrigger()
    call DisableTrigger(gg_trg_Vanguard_Future_Levels)
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Vanguard_Future_Levels, EVENT_PLAYER_HERO_SKILL)
    call TriggerAddCondition(gg_trg_Vanguard_Future_Levels, Condition(function Trig_Vanguard_Future_Levels_Conditions))
    call TriggerAddAction(gg_trg_Vanguard_Future_Levels, function Trig_Vanguard_Future_Levels_Actions)
endfunction

//===========================================================================
// Trigger: Vanguard
//===========================================================================
function Trig_Vanguard_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A06U' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Vanguard_Actions takes nothing returns nothing
    call SetUnitLifeBJ(GetTriggerUnit(), ( GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) + udg_VanguardHeal ))
    call TriggerSleepAction(1.00)
    call SetUnitLifeBJ(GetTriggerUnit(), ( GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) + udg_VanguardHeal ))
    call TriggerSleepAction(1.00)
    call SetUnitLifeBJ(GetTriggerUnit(), ( GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) + udg_VanguardHeal ))
    call TriggerSleepAction(1.00)
    call SetUnitLifeBJ(GetTriggerUnit(), ( GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) + udg_VanguardHeal ))
    call TriggerSleepAction(1.00)
    call SetUnitLifeBJ(GetTriggerUnit(), ( GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) + udg_VanguardHeal ))
    call TriggerSleepAction(1.00)
    call SetUnitLifeBJ(GetTriggerUnit(), ( GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) + udg_VanguardHeal ))
endfunction

//===========================================================================
function InitTrig_Vanguard takes nothing returns nothing
    set gg_trg_Vanguard=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Vanguard, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Vanguard, Condition(function Trig_Vanguard_Conditions))
    call TriggerAddAction(gg_trg_Vanguard, function Trig_Vanguard_Actions)
endfunction

//===========================================================================
// Trigger: Omniscience Initial
//===========================================================================
function Trig_Omniscience_Initial_Conditions takes nothing returns boolean
    if ( not ( GetLearnedSkillBJ() == 'A06X' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Omniscience_Initial_Actions takes nothing returns nothing
    set udg_Div=GetLearningUnit()
    set udg_Omni=1
    call EnableTrigger(gg_trg_Omniscience)
    call EnableTrigger(gg_trg_Omniscience_FL)
    call DisableTrigger(GetTriggeringTrigger())
endfunction

//===========================================================================
function InitTrig_Omniscience_Initial takes nothing returns nothing
    set gg_trg_Omniscience_Initial=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Omniscience_Initial, EVENT_PLAYER_HERO_SKILL)
    call TriggerAddCondition(gg_trg_Omniscience_Initial, Condition(function Trig_Omniscience_Initial_Conditions))
    call TriggerAddAction(gg_trg_Omniscience_Initial, function Trig_Omniscience_Initial_Actions)
endfunction

//===========================================================================
// Trigger: Omniscience FL
//===========================================================================
function Trig_Omniscience_FL_Conditions takes nothing returns boolean
    if ( not ( GetLearnedSkillBJ() == 'A06X' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Omniscience_FL_Actions takes nothing returns nothing
    set udg_Omni=( udg_Omni + 1 )
endfunction

//===========================================================================
function InitTrig_Omniscience_FL takes nothing returns nothing
    set gg_trg_Omniscience_FL=CreateTrigger()
    call DisableTrigger(gg_trg_Omniscience_FL)
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Omniscience_FL, EVENT_PLAYER_HERO_SKILL)
    call TriggerAddCondition(gg_trg_Omniscience_FL, Condition(function Trig_Omniscience_FL_Conditions))
    call TriggerAddAction(gg_trg_Omniscience_FL, function Trig_Omniscience_FL_Actions)
endfunction

//===========================================================================
// Trigger: Omniscience
//===========================================================================
function Trig_Omniscience_Actions takes nothing returns nothing
    call AddHeroXPSwapped(udg_Omni, udg_Div, true)
endfunction

//===========================================================================
function InitTrig_Omniscience takes nothing returns nothing
    set gg_trg_Omniscience=CreateTrigger()
    call DisableTrigger(gg_trg_Omniscience)
    call TriggerRegisterTimerEventPeriodic(gg_trg_Omniscience, 1.00)
    call TriggerAddAction(gg_trg_Omniscience, function Trig_Omniscience_Actions)
endfunction

//===========================================================================
// Trigger: Redemption
//===========================================================================
function Trig_Redemption_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A06Y' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Redemption_Actions takes nothing returns nothing
    call SetUnitLifePercentBJ(GetSpellAbilityUnit(), 100)
    call SetUnitManaPercentBJ(GetSpellAbilityUnit(), 100)
endfunction

//===========================================================================
function InitTrig_Redemption takes nothing returns nothing
    set gg_trg_Redemption=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Redemption, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Redemption, Condition(function Trig_Redemption_Conditions))
    call TriggerAddAction(gg_trg_Redemption, function Trig_Redemption_Actions)
endfunction

//===========================================================================
// Trigger: Refreshing Breeze
//===========================================================================
//===========================================================================
// Trigger: Gale Winds
//===========================================================================
//===========================================================================
// Trigger: WindWalkWispari
//===========================================================================

function WW_Stop takes timer t,unit caster returns nothing
    if caster != null then
        call SaveBoolean(WW_Hash, GetHandleId(caster), 0, false)
    endif

    call FlushChildHashtable(WW_Hash, GetHandleId(t))
    call PauseTimer(t)
    call DestroyTimer(t)
endfunction

function WW_CreateSpawn takes unit caster returns nothing
    local unit spawned= CreateUnit(GetOwningPlayer(caster), WW_SPAWN_ID, GetUnitX(caster), GetUnitY(caster), GetUnitFacing(caster))

    call UnitApplyTimedLife(spawned, 'BTLF', WW_SPAWN_LIFE)

    set spawned=null
endfunction

function WW_Loop takes nothing returns nothing
    local timer t= GetExpiredTimer()
    local unit caster= LoadUnitHandle(WW_Hash, GetHandleId(t), 0)

    if caster == null then
        call WW_Stop(t , caster)
        set t=null
        set caster=null
        return
    endif

    if GetWidgetLife(caster) <= 0.405 then
        call WW_Stop(t , caster)
        set t=null
        set caster=null
        return
    endif

    if GetUnitAbilityLevel(caster, WW_BUFF_ID) <= 0 then
        call WW_Stop(t , caster)
        set t=null
        set caster=null
        return
    endif

    call WW_CreateSpawn(caster)

    set caster=null
    set t=null
endfunction

function WW_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == WW_ABILITY_ID
endfunction

function WW_Actions takes nothing returns nothing
    local unit caster= GetTriggerUnit()
    local integer casterId= GetHandleId(caster)
    local timer t

    if LoadBoolean(WW_Hash, casterId, 0) then
        set caster=null
        return
    endif

    call SaveBoolean(WW_Hash, casterId, 0, true)

    // Immediate first spawn
    call WW_CreateSpawn(caster)

    set t=CreateTimer()
    call SaveUnitHandle(WW_Hash, GetHandleId(t), 0, caster)
    call TimerStart(t, WW_PERIOD, true, function WW_Loop)

    set t=null
    set caster=null
endfunction

function InitTrig_WindWalkWispari takes nothing returns nothing
    local trigger trg= CreateTrigger()
    local integer i= 0

    loop
        exitwhen i >= bj_MAX_PLAYER_SLOTS
        call TriggerRegisterPlayerUnitEvent(trg, Player(i), EVENT_PLAYER_UNIT_SPELL_EFFECT, null)
        set i=i + 1
    endloop

    call TriggerAddCondition(trg, Condition(function WW_Conditions))
    call TriggerAddAction(trg, function WW_Actions)

    set trg=null
endfunction
//===========================================================================
// Trigger: TornadoMove
//===========================================================================

function Tornado_Clear_Caster takes unit caster returns nothing
    if caster != null then
        call FlushChildHashtable(udg_TornadoHash, GetHandleId(caster))
    endif
endfunction

function Tornado_Begin_Death takes timer t returns nothing
    local integer id= GetHandleId(t)
    local effect fx= LoadEffectHandle(udg_TornadoHash, id, TORNADO_KEY_EFFECT)
    local unit caster= LoadUnitHandle(udg_TornadoHash, id, TORNADO_KEY_CASTER)

    if LoadBoolean(udg_TornadoHash, id, TORNADO_KEY_DYING) then
        set fx=null
        set caster=null
        set t=null
        return
    endif

    call SaveBoolean(udg_TornadoHash, id, TORNADO_KEY_DYING, true)

    if caster != null then
        call Tornado_Clear_Caster(caster)
    endif

    if fx != null then
        call DestroyEffect(fx)
    endif

    call FlushChildHashtable(udg_TornadoHash, id)
    call PauseTimer(t)
    call DestroyTimer(t)

    set fx=null
    set caster=null
    set t=null
endfunction

function Tornado_Caster_Channel_Broken takes unit caster,real startX,real startY returns boolean
    local real dx
    local real dy

    if caster == null then
        return true
    endif

    if GetWidgetLife(caster) <= 0.405 then
        return true
    endif

    if IsUnitPaused(caster) then
        return true
    endif

    if IsUnitType(caster, UNIT_TYPE_STUNNED) then
        return true
    endif

    if IsUnitType(caster, UNIT_TYPE_POLYMORPHED) then
        return true
    endif

    if IsUnitType(caster, UNIT_TYPE_SLEEPING) then
        return true
    endif

    set dx=GetUnitX(caster) - startX
    set dy=GetUnitY(caster) - startY

    return dx * dx + dy * dy > TORNADO_MOVE_TOLERANCE * TORNADO_MOVE_TOLERANCE
endfunction

function Tornado_Line_Loop takes nothing returns nothing
    local timer t= GetExpiredTimer()
    local integer id= GetHandleId(t)

    local effect fx= LoadEffectHandle(udg_TornadoHash, id, TORNADO_KEY_EFFECT)
    local unit caster= LoadUnitHandle(udg_TornadoHash, id, TORNADO_KEY_CASTER)

    local real x= LoadReal(udg_TornadoHash, id, TORNADO_KEY_X)
    local real y= LoadReal(udg_TornadoHash, id, TORNADO_KEY_Y)
    local real angle= LoadReal(udg_TornadoHash, id, TORNADO_KEY_ANGLE)
    local real traveled= LoadReal(udg_TornadoHash, id, TORNADO_KEY_TRAVELED)
    local real maxDistance= LoadReal(udg_TornadoHash, id, TORNADO_KEY_MAX_DISTANCE)
    local real speed= LoadReal(udg_TornadoHash, id, TORNADO_KEY_SPEED)

    local boolean channelActive= LoadBoolean(udg_TornadoHash, id, TORNADO_KEY_CHANNEL_ACTIVE)
    local real channelLeft= LoadReal(udg_TornadoHash, id, TORNADO_KEY_CHANNEL_LEFT)
    local real startX= LoadReal(udg_TornadoHash, id, TORNADO_KEY_START_X)
    local real startY= LoadReal(udg_TornadoHash, id, TORNADO_KEY_START_Y)

    local real step= speed * TORNADO_PERIOD
    local real nextX
    local real nextY

    if fx == null then
        call FlushChildHashtable(udg_TornadoHash, id)
        call PauseTimer(t)
        call DestroyTimer(t)

        set caster=null
        set t=null
        return
    endif

    if channelActive and Tornado_Caster_Channel_Broken(caster , startX , startY) then
        call Tornado_Begin_Death(t)

        set fx=null
        set caster=null
        set t=null
        return
    endif

    if traveled + step > maxDistance then
        set step=maxDistance - traveled
    endif

    set nextX=x + step * Cos(angle)
    set nextY=y + step * Sin(angle)

    set x=nextX
    set y=nextY
    set traveled=traveled + step

    call BlzSetSpecialEffectPosition(fx, x, y, 0.00)

    if channelActive then
        set channelLeft=channelLeft - TORNADO_PERIOD

        if channelLeft < 0.00 then
            set channelLeft=0.00
        endif

        call SaveReal(udg_TornadoHash, id, TORNADO_KEY_CHANNEL_LEFT, channelLeft)
    endif

    if traveled >= maxDistance then
        call Tornado_Begin_Death(t)
    else
        call SaveReal(udg_TornadoHash, id, TORNADO_KEY_X, x)
        call SaveReal(udg_TornadoHash, id, TORNADO_KEY_Y, y)
        call SaveReal(udg_TornadoHash, id, TORNADO_KEY_TRAVELED, traveled)
    endif

    set fx=null
    set caster=null
    set t=null
endfunction

function Tornado_Line_Actions takes nothing returns nothing
    local unit caster= GetTriggerUnit()
    local integer casterId= GetHandleId(caster)
    local integer level= GetUnitAbilityLevel(caster, TORNADO_ABILITY_ID)

    local real casterX= GetUnitX(caster)
    local real casterY= GetUnitY(caster)

    local real x= casterX
    local real y= casterY

    local real targetX= GetSpellTargetX()
    local real targetY= GetSpellTargetY()

    local real dx= targetX - casterX
    local real dy= targetY - casterY

    local real angle= Atan2(dy, dx)

    local real maxDistance= 550.00 + I2R(level) * 100.00
    local real channelTime= TORNADO_CHANNEL_BASE + TORNADO_CHANNEL_PER_LEVEL * I2R(level)
    local real speed

    local effect fx
    local timer t
    local timer old= LoadTimerHandle(udg_TornadoHash, casterId, TORNADO_CASTER_KEY_TIMER)
    local integer id

    if old != null then
        call Tornado_Begin_Death(old)
    endif

    if channelTime <= 0.00 then
        set channelTime=TORNADO_PERIOD
    endif

    set speed=maxDistance / channelTime

    set fx=AddSpecialEffect(TORNADO_MODEL_PATH, x, y)
    call BlzSetSpecialEffectScale(fx, TORNADO_EFFECT_SCALE)
    call BlzSetSpecialEffectOrientation(fx, angle, 0.00, 0.00)
    call BlzSetSpecialEffectPosition(fx, x, y, 0.00)
    call BlzPlaySpecialEffect(fx, ANIM_TYPE_STAND)

    set t=CreateTimer()
    set id=GetHandleId(t)

    call SaveEffectHandle(udg_TornadoHash, id, TORNADO_KEY_EFFECT, fx)
    call SaveReal(udg_TornadoHash, id, TORNADO_KEY_X, x)
    call SaveReal(udg_TornadoHash, id, TORNADO_KEY_Y, y)
    call SaveReal(udg_TornadoHash, id, TORNADO_KEY_ANGLE, angle)
    call SaveReal(udg_TornadoHash, id, TORNADO_KEY_TRAVELED, 0.00)
    call SaveReal(udg_TornadoHash, id, TORNADO_KEY_MAX_DISTANCE, maxDistance)
    call SaveUnitHandle(udg_TornadoHash, id, TORNADO_KEY_CASTER, caster)
    call SaveBoolean(udg_TornadoHash, id, TORNADO_KEY_CHANNEL_ACTIVE, true)
    call SaveReal(udg_TornadoHash, id, TORNADO_KEY_CHANNEL_LEFT, channelTime)
    call SaveReal(udg_TornadoHash, id, TORNADO_KEY_START_X, casterX)
    call SaveReal(udg_TornadoHash, id, TORNADO_KEY_START_Y, casterY)
    call SaveReal(udg_TornadoHash, id, TORNADO_KEY_SPEED, speed)
    call SaveBoolean(udg_TornadoHash, id, TORNADO_KEY_DYING, false)

    call SaveTimerHandle(udg_TornadoHash, casterId, TORNADO_CASTER_KEY_TIMER, t)

    call TimerStart(t, TORNADO_PERIOD, true, function Tornado_Line_Loop)

    set caster=null
    set fx=null
    set t=null
    set old=null
endfunction

function Tornado_Line_Endcast_Actions takes nothing returns nothing
    local unit caster= GetTriggerUnit()
    local integer casterId= GetHandleId(caster)
    local timer t= LoadTimerHandle(udg_TornadoHash, casterId, TORNADO_CASTER_KEY_TIMER)
    local integer id= 0
    local real channelLeft= 0.00

    if t != null then
        set id=GetHandleId(t)
        set channelLeft=LoadReal(udg_TornadoHash, id, TORNADO_KEY_CHANNEL_LEFT)

        if channelLeft > TORNADO_ENDCAST_TOLERANCE then
            call Tornado_Begin_Death(t)
        else
            call Tornado_Clear_Caster(caster)
            call SaveBoolean(udg_TornadoHash, id, TORNADO_KEY_CHANNEL_ACTIVE, false)
            call RemoveSavedHandle(udg_TornadoHash, id, TORNADO_KEY_CASTER)
        endif
    endif

    set caster=null
    set t=null
endfunction

function Tornado_Line_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == TORNADO_ABILITY_ID
endfunction

function InitTrig_TornadoMove takes nothing returns nothing
    local trigger trg= CreateTrigger()
    local trigger endTrg= CreateTrigger()

    if udg_TornadoHash == null then
        set udg_TornadoHash=InitHashtable()
    endif

    call TriggerRegisterAnyUnitEventBJ(trg, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(trg, Condition(function Tornado_Line_Conditions))
    call TriggerAddAction(trg, function Tornado_Line_Actions)

    call TriggerRegisterAnyUnitEventBJ(endTrg, EVENT_PLAYER_UNIT_SPELL_ENDCAST)
    call TriggerAddCondition(endTrg, Condition(function Tornado_Line_Conditions))
    call TriggerAddAction(endTrg, function Tornado_Line_Endcast_Actions)

    set trg=null
    set endTrg=null
endfunction
//===========================================================================
// Trigger: Sit tight
//===========================================================================
function Trig_Sit_tight_Actions takes nothing returns nothing
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_549")
endfunction

//===========================================================================
function InitTrig_Sit_tight takes nothing returns nothing
    set gg_trg_Sit_tight=CreateTrigger()
    call TriggerRegisterTimerEventSingle(gg_trg_Sit_tight, 25.00)
    call TriggerAddAction(gg_trg_Sit_tight, function Trig_Sit_tight_Actions)
endfunction

//===========================================================================
// Trigger: ClearOnEsc
//===========================================================================
function Trig_ClearMessagesOnEsc_Actions takes nothing returns nothing
    if GetLocalPlayer() == GetTriggerPlayer() then
        call ClearTextMessages()
    endif
endfunction

function InitTrig_ClearOnEsc takes nothing returns nothing
    local trigger t= CreateTrigger()
    local integer i= 0

    loop
        exitwhen i >= bj_MAX_PLAYER_SLOTS
        call TriggerRegisterPlayerEvent(t, Player(i), EVENT_PLAYER_END_CINEMATIC)
        set i=i + 1
    endloop

    call TriggerAddAction(t, function Trig_ClearMessagesOnEsc_Actions)

    set t=null
endfunction
//===========================================================================
// Trigger: InitialText
//===========================================================================
function Trig_InitialText_Actions takes nothing returns nothing
    local force redForce= CreateForce()

    call ForceAddPlayer(redForce, Player(0))
    call ForceEnumAllies(redForce, Player(0), null)

    call DisplayTimedTextToPlayer(Player(6), 0.00, 0.00, 40.00, "Player 7 (Green) can enable trade by typing -tradeon during pick phase")
    call DisplayTimedTextToPlayer(Player(6), 0.00, 0.00, 40.00, "Player 7 (Green) can make enemies stronger by typing -hardmode during pick phase")

    call DisplayTimedTextToForce(redForce, 40.00, "Player 1 (Red) can change feedrate% of all players to any value within 50 and 200, example: '-setfeed 120'")
    call DisplayTimedTextToForce(redForce, 40.00, "Player 1 (Red) can multiply feedrate of all players by typing -setfeed x1.75")
    call DisplayTimedTextToForce(redForce, 40.00, "Player 1 (Red) can also change feedrate of specific player, like: '-setfeed blue 150' or '-setfeed 2 150'")
    call DisplayTimedTextToForce(redForce, 40.00, "Player 1 (Red) can write '-chopchop' to enable tree chopper for Ancient")
    call DisplayTimedTextToForce(redForce, 40.00, "Player 1 (Red) can ban up to four ancients or expanders by typing '-ban name'")
    call DisplayTimedTextToForce(redForce, 40.00, "For races with multiple words to their name, type the first word (e.g. -ban aethyr).")
    call DisplayTimedTextToForce(redForce, 40.00, "Ban ancients by typing their element or given name. Ancient elements: Darkness, Dragon, Earth, Fire, Ice, Light, Lightning, Nature, Sand, Space, Wind")
    call DisplayTimedTextToForce(redForce, 40.00, "Please note that banned races can still be randomed.")
    call DisplayTimedTextToForce(redForce, 40.00, "For more info check F9")

    call DestroyForce(redForce)
    set redForce=null
endfunction

//===========================================================================
function InitTrig_InitialText takes nothing returns nothing
    set gg_trg_InitialText=CreateTrigger()
    call TriggerAddAction(gg_trg_InitialText, function Trig_InitialText_Actions)
endfunction


//===========================================================================
// Trigger: Welcome
//===========================================================================
function Trig_Welcome_Actions takes nothing returns nothing
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_336")
endfunction

//===========================================================================
function InitTrig_Welcome takes nothing returns nothing
    set gg_trg_Welcome=CreateTrigger()
    call TriggerRegisterTimerEventSingle(gg_trg_Welcome, 20.00)
    call TriggerAddAction(gg_trg_Welcome, function Trig_Welcome_Actions)
endfunction

//===========================================================================
// Trigger: Info Copy
//===========================================================================
function Trig_Info_Copy_Actions takes nothing returns nothing
    call DisplayTimedTextToForce(bj_FORCE_PLAYER[6], 20.00, "TRIGSTR_469")
endfunction

//===========================================================================
function InitTrig_Info_Copy takes nothing returns nothing
    set gg_trg_Info_Copy=CreateTrigger()
    call TriggerRegisterTimerEventSingle(gg_trg_Info_Copy, 40.00)
    call TriggerAddAction(gg_trg_Info_Copy, function Trig_Info_Copy_Actions)
endfunction

//===========================================================================
// Trigger: Info
//===========================================================================
function Trig_Info_Actions takes nothing returns nothing
    call DisplayTimedTextToForce(bj_FORCE_PLAYER[6], 45.00, "TRIGSTR_7352")
endfunction

//===========================================================================
function InitTrig_Info takes nothing returns nothing
    set gg_trg_Info=CreateTrigger()
    call TriggerRegisterTimerEventSingle(gg_trg_Info, 70.00)
    call TriggerAddAction(gg_trg_Info, function Trig_Info_Actions)
endfunction

//===========================================================================
// Trigger: Ping Hint
//===========================================================================
function Trig_Ping_Hint_Actions takes nothing returns nothing
    call DisplayTextToForce(GetPlayersEnemies(Player(6)), "TRIGSTR_3139")
endfunction

//===========================================================================
function InitTrig_Ping_Hint takes nothing returns nothing
    set gg_trg_Ping_Hint=CreateTrigger()
    call TriggerRegisterTimerEventSingle(gg_trg_Ping_Hint, 70.00)
    call TriggerAddAction(gg_trg_Ping_Hint, function Trig_Ping_Hint_Actions)
endfunction

//===========================================================================
// Trigger: Hint2x2
//===========================================================================
function Trig_Hint2x2_Actions takes nothing returns nothing
    call DisplayTextToForce(GetPlayersEnemies(Player(6)), "TRIGSTR_5110")
endfunction

//===========================================================================
function InitTrig_Hint2x2 takes nothing returns nothing
    set gg_trg_Hint2x2=CreateTrigger()
    call TriggerRegisterTimerEventSingle(gg_trg_Hint2x2, 90.00)
    call TriggerAddAction(gg_trg_Hint2x2, function Trig_Hint2x2_Actions)
endfunction

//===========================================================================
// Trigger: HintInvisibility
//===========================================================================
function Trig_HintInvisibility_Actions takes nothing returns nothing
    call DisplayTextToForce(GetPlayersEnemies(Player(6)), "TRIGSTR_5166")
endfunction

//===========================================================================
function InitTrig_HintInvisibility takes nothing returns nothing
    set gg_trg_HintInvisibility=CreateTrigger()
    call TriggerRegisterTimerEventSingle(gg_trg_HintInvisibility, 110.00)
    call TriggerAddAction(gg_trg_HintInvisibility, function Trig_HintInvisibility_Actions)
endfunction

//===========================================================================
// Trigger: HintFeed
//===========================================================================
function Trig_HintFeed_Actions takes nothing returns nothing
    call DisplayTextToForce(GetPlayersEnemies(Player(6)), "TRIGSTR_5775")
endfunction

//===========================================================================
function InitTrig_HintFeed takes nothing returns nothing
    set gg_trg_HintFeed=CreateTrigger()
    call TriggerRegisterTimerEventSingle(gg_trg_HintFeed, 260.00)
    call TriggerAddAction(gg_trg_HintFeed, function Trig_HintFeed_Actions)
endfunction

//===========================================================================
// Trigger: Resource Hint
//===========================================================================
function Trig_Resource_Hint_Actions takes nothing returns nothing
    call DisplayTextToForce(bj_FORCE_PLAYER[0], "TRIGSTR_7317")
endfunction

//===========================================================================
function InitTrig_Resource_Hint takes nothing returns nothing
    set gg_trg_Resource_Hint=CreateTrigger()
    call TriggerRegisterTimerEventPeriodic(gg_trg_Resource_Hint, 300.00)
    call TriggerAddAction(gg_trg_Resource_Hint, function Trig_Resource_Hint_Actions)
endfunction

//===========================================================================
// Trigger: Ping
//===========================================================================
function Trig_Ping_Actions takes nothing returns nothing
    call PingMinimapLocForForce(GetPlayersAllies(GetTriggerPlayer()), GetRectCenter(gg_rct_Ping1), 3.00)
    call PingMinimapLocForForce(GetPlayersAllies(GetTriggerPlayer()), GetRectCenter(gg_rct_Ping2), 3.00)
    call PingMinimapLocForForce(GetPlayersAllies(GetTriggerPlayer()), GetRectCenter(gg_rct_Ping3), 3.00)
    call PingMinimapLocForForce(GetPlayersAllies(GetTriggerPlayer()), GetRectCenter(gg_rct_Ping4), 3.00)
    call PingMinimapLocForForce(GetPlayersAllies(GetTriggerPlayer()), GetRectCenter(gg_rct_Ping5), 3.00)
    call PingMinimapLocForForce(GetPlayersAllies(GetTriggerPlayer()), GetRectCenter(gg_rct_Ping6), 3.00)
    call PingMinimapLocForForce(GetPlayersAllies(GetTriggerPlayer()), GetRectCenter(gg_rct_Ping7), 3.00)
endfunction

//===========================================================================
function InitTrig_Ping takes nothing returns nothing
    set gg_trg_Ping=CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_Ping, Player(0), "-gold", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Ping, Player(1), "-gold", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Ping, Player(2), "-gold", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Ping, Player(3), "-gold", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Ping, Player(4), "-gold", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Ping, Player(5), "-gold", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Ping, Player(7), "-gold", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Ping, Player(8), "-gold", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Ping, Player(9), "-gold", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Ping, Player(10), "-gold", true)
    call TriggerAddAction(gg_trg_Ping, function Trig_Ping_Actions)
endfunction

//===========================================================================
// Trigger: PingForAncient
//===========================================================================
function Trig_PingForAncient_Actions takes nothing returns nothing
    call PingMinimapLocForForce(GetPlayersAllies(Player(6)), GetRectCenter(gg_rct_Ping1), 3.00)
    call PingMinimapLocForForce(GetPlayersAllies(Player(6)), GetRectCenter(gg_rct_Ping2), 3.00)
    call PingMinimapLocForForce(GetPlayersAllies(Player(6)), GetRectCenter(gg_rct_Ping3), 3.00)
    call PingMinimapLocForForce(GetPlayersAllies(Player(6)), GetRectCenter(gg_rct_Ping4), 3.00)
    call PingMinimapLocForForce(GetPlayersAllies(Player(6)), GetRectCenter(gg_rct_Ping5), 3.00)
    call PingMinimapLocForForce(GetPlayersAllies(Player(6)), GetRectCenter(gg_rct_Ping6), 3.00)
    call PingMinimapLocForForce(GetPlayersAllies(Player(6)), GetRectCenter(gg_rct_Ping7), 3.00)
endfunction

//===========================================================================
function InitTrig_PingForAncient takes nothing returns nothing
    set gg_trg_PingForAncient=CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_PingForAncient, Player(6), "-gold", true)
    call TriggerAddAction(gg_trg_PingForAncient, function Trig_PingForAncient_Actions)
endfunction

//===========================================================================
// Trigger: AncientSpells
//===========================================================================
function Ancient_ReplaceAll takes string source,string findText,string replaceText returns string
    local string result= ""
    local integer sourceLength
    local integer findLength
    local integer i= 0

    if source == null then
        return ""
    endif

    set sourceLength=StringLength(source)
    set findLength=StringLength(findText)

    if findLength <= 0 then
        return source
    endif

    loop
        exitwhen i >= sourceLength

        if i + findLength <= sourceLength and SubString(source, i, i + findLength) == findText then
            set result=result + replaceText
            set i=i + findLength
        else
            set result=result + SubString(source, i, i + 1)
            set i=i + 1
        endif
    endloop

    return result
endfunction

function Ancient_CollapseSpaces takes string source returns string
    local string result= ""
    local integer length
    local integer i= 0
    local string c
    local boolean lastWasSpace= false

    if source == null then
        return ""
    endif

    set length=StringLength(source)

    loop
        exitwhen i >= length

        set c=SubString(source, i, i + 1)

        if c == " " then
            if not lastWasSpace then
                set result=result + c
            endif
            set lastWasSpace=true
        else
            set result=result + c
            set lastWasSpace=false
        endif

        set i=i + 1
    endloop

    return result
endfunction

function Ancient_IsHexChar takes string c returns boolean
    return c == "0" or c == "1" or c == "2" or c == "3" or c == "4" or c == "5" or c == "6" or c == "7" or c == "8" or c == "9" or c == "a" or c == "b" or c == "c" or c == "d" or c == "e" or c == "f" or c == "A" or c == "B" or c == "C" or c == "D" or c == "E" or c == "F"
endfunction

function Ancient_RemoveColorCodes takes string source returns string
    local string result= ""
    local integer length
    local integer i= 0
    local string c

    if source == null then
        return ""
    endif

    set length=StringLength(source)

    loop
        exitwhen i >= length

        set c=SubString(source, i, i + 1)

        if i + 10 <= length and c == "|" and SubString(source, i + 1, i + 2) == "c" and Ancient_IsHexChar(SubString(source, i + 2, i + 3)) and Ancient_IsHexChar(SubString(source, i + 3, i + 4)) and Ancient_IsHexChar(SubString(source, i + 4, i + 5)) and Ancient_IsHexChar(SubString(source, i + 5, i + 6)) and Ancient_IsHexChar(SubString(source, i + 6, i + 7)) and Ancient_IsHexChar(SubString(source, i + 7, i + 8)) and Ancient_IsHexChar(SubString(source, i + 8, i + 9)) and Ancient_IsHexChar(SubString(source, i + 9, i + 10)) then
            set i=i + 10
        elseif i + 10 <= length and c == "|" and SubString(source, i + 1, i + 2) == "C" and Ancient_IsHexChar(SubString(source, i + 2, i + 3)) and Ancient_IsHexChar(SubString(source, i + 3, i + 4)) and Ancient_IsHexChar(SubString(source, i + 4, i + 5)) and Ancient_IsHexChar(SubString(source, i + 5, i + 6)) and Ancient_IsHexChar(SubString(source, i + 6, i + 7)) and Ancient_IsHexChar(SubString(source, i + 7, i + 8)) and Ancient_IsHexChar(SubString(source, i + 8, i + 9)) and Ancient_IsHexChar(SubString(source, i + 9, i + 10)) then
            set i=i + 10
        elseif i + 2 <= length and c == "|" and SubString(source, i + 1, i + 2) == "r" then
            set i=i + 2
        elseif i + 2 <= length and c == "|" and SubString(source, i + 1, i + 2) == "R" then
            set i=i + 2
        else
            set result=result + c
            set i=i + 1
        endif
    endloop

    return result
endfunction

function Ancient_RemoveSquareBracketBlocks takes string source returns string
    local string result= ""
    local integer length
    local integer i= 0
    local string c
    local boolean insideBracket= false

    if source == null then
        return ""
    endif

    set length=StringLength(source)

    loop
        exitwhen i >= length

        set c=SubString(source, i, i + 1)

        if c == "[" then
            set insideBracket=true
        elseif c == "]" then
            set insideBracket=false
        elseif not insideBracket then
            set result=result + c
        endif

        set i=i + 1
    endloop

    return Ancient_CollapseSpaces(result)
endfunction

function Ancient_CleanTrailingSeparators takes string source returns string
    local integer length

    if source == null then
        return ""
    endif

    set source=Ancient_CollapseSpaces(source)
    set length=StringLength(source)

    loop
        exitwhen length <= 0

        if SubString(source, length - 1, length) == " " then
            set source=SubString(source, 0, length - 1)
        elseif SubString(source, length - 1, length) == "-" then
            set source=SubString(source, 0, length - 1)
        elseif SubString(source, length - 1, length) == ":" then
            set source=SubString(source, 0, length - 1)
        else
            return source
        endif

        set source=Ancient_CollapseSpaces(source)
        set length=StringLength(source)
    endloop

    return source
endfunction

function Ancient_FormatTooltipText takes string text,integer level returns string
    if text == null then
        return ""
    endif

    set text=Ancient_ReplaceAll(text , "|n" , " ")
    set text=Ancient_ReplaceAll(text , "|N" , " ")
    set text=Ancient_ReplaceAll(text , "\n" , " ")
    set text=Ancient_ReplaceAll(text , "/n" , " ")
    set text=Ancient_ReplaceAll(text , "/N" , " ")
    set text=Ancient_ReplaceAll(text , "%d" , I2S(level))
    set text=Ancient_CollapseSpaces(text)

    return text
endfunction

function Ancient_ClearMessagesForPlayer takes player p returns nothing
    if GetLocalPlayer() == p then
        call ClearTextMessages()
    endif
endfunction

function Ancient_IsCommand takes string chat returns boolean
    local string s= StringCase(chat, false)
    local integer len= StringLength(s)

    if len < 8 then
        return false
    endif

    if SubString(s, 0, 8) != "-ancient" then
        return false
    endif

    if len == 8 then
        return true
    endif

    return SubString(s, 8, 9) == " "
endfunction

function Ancient_GetArgumentText takes string chat returns string
    local integer len= StringLength(chat)
    local integer i= 8

    loop
        exitwhen i >= len or SubString(chat, i, i + 1) != " "
        set i=i + 1
    endloop

    if i >= len then
        return ""
    endif

    return SubString(chat, i, len)
endfunction

function Ancient_GetFirstWord takes string text returns string
    local integer len= StringLength(text)
    local integer i= 0
    local integer start

    loop
        exitwhen i >= len or SubString(text, i, i + 1) != " "
        set i=i + 1
    endloop

    set start=i

    loop
        exitwhen i >= len or SubString(text, i, i + 1) == " "
        set i=i + 1
    endloop

    if start >= len then
        return ""
    endif

    return SubString(text, start, i)
endfunction

function Ancient_GetTextAfterFirstWord takes string text returns string
    local integer len= StringLength(text)
    local integer i= 0

    loop
        exitwhen i >= len or SubString(text, i, i + 1) != " "
        set i=i + 1
    endloop

    loop
        exitwhen i >= len or SubString(text, i, i + 1) == " "
        set i=i + 1
    endloop

    loop
        exitwhen i >= len or SubString(text, i, i + 1) != " "
        set i=i + 1
    endloop

    if i >= len then
        return ""
    endif

    return SubString(text, i, len)
endfunction

function Ancient_GetUnitTypeIdByKeyword takes string keyword returns integer
    if keyword == "darkness" or keyword == "paranoia" then
        return 'O00A'
    elseif keyword == "dragon" or keyword == "dragons" or keyword == "dragos" or keyword == "drago" then
        return 'O00S'
    elseif keyword == "earth" or keyword == "tremor" then
        return 'O00L'
    elseif keyword == "fire" or keyword == "ignite" then
        return 'O004'
    elseif keyword == "ice" or keyword == "avalanche" or keyword == "avalanch" then
        return 'O008'
    elseif keyword == "light" or keyword == "divinity" then
        return 'O01V'
    elseif keyword == "lightning" or keyword == "lighting" or keyword == "zalxon" then
        return 'O016'
    elseif keyword == "nature" or keyword == "eternity" then
        return 'O00D'
    elseif keyword == "sand" or keyword == "pharaoh" or keyword == "pharaon" then
        return 'O01X'
    elseif keyword == "space" or keyword == "nebula" then
        return 'O01Z'
    elseif keyword == "wind" or keyword == "wispari" or keyword == "whispari" or keyword == "whisperi" or keyword == "wisperi" then
        return 'O01D'
    endif

    return 0
endfunction

function Ancient_GetUnitTypeDisplayName takes integer unitTypeId returns string
    if unitTypeId == 'O00A' then
        return "Darkness / Paranoia"
    elseif unitTypeId == 'O00S' then
        return "Dragon"
    elseif unitTypeId == 'O00L' then
        return "Earth / Tremor"
    elseif unitTypeId == 'O004' then
        return "Fire / Ignite"
    elseif unitTypeId == 'O008' then
        return "Ice / Avalanche"
    elseif unitTypeId == 'O01V' then
        return "Light / Divinity"
    elseif unitTypeId == 'O016' then
        return "Lightning / Zalxon"
    elseif unitTypeId == 'O00D' then
        return "Nature / Eternity"
    elseif unitTypeId == 'O01X' then
        return "Sand / Pharaoh"
    elseif unitTypeId == 'O01Z' then
        return "Space / Nebula"
    elseif unitTypeId == 'O01D' then
        return "Wind / Wispari"
    endif

    return "Unknown Ancient"
endfunction

function Ancient_ParsePageFromArgument takes string argument returns integer
    local string lowerArgument= StringCase(argument, false)
    local string firstWord= Ancient_GetFirstWord(lowerArgument)
    local string rest
    local integer page

    if Ancient_GetUnitTypeIdByKeyword(firstWord) != 0 then
        set rest=Ancient_GetTextAfterFirstWord(lowerArgument)
        set page=S2I(Ancient_GetFirstWord(rest))
    else
        set page=S2I(firstWord)
    endif

    if page < 1 then
        set page=1
    endif

    return page
endfunction

function Ancient_ShowPreviewUsage takes player p returns nothing
    call Ancient_ClearMessagesForPlayer(p)
    call DisplayTimedTextToPlayer(p, 0.00, 0.00, 20.00, "|cffffcc00Ancient preview:|r |cffffffffUse |r|cffffcc00-ancient darkness|r|cffffffff, |r|cffffcc00-ancient dragon|r|cffffffff, |r|cffffcc00-ancient earth|r|cffffffff, |r|cffffcc00-ancient fire|r|cffffffff, |r|cffffcc00-ancient ice|r|cffffffff, |r|cffffcc00-ancient light|r|cffffffff, |r|cffffcc00-ancient lightning|r|cffffffff, |r|cffffcc00-ancient nature|r|cffffffff, |r|cffffcc00-ancient sand|r|cffffffff, |r|cffffcc00-ancient space|r|cffffffff, or |r|cffffcc00-ancient wind|r|cffffffff. Add page number after the name if needed, for example |r|cffffcc00-ancient darkness 2|r|cffffffff.|r")
endfunction

function Ancient_GetAbilityCount takes integer unitTypeId returns integer
    if unitTypeId == 'O016' then
        return 6
    endif

    if unitTypeId == 'O00A' then
        return 5
    elseif unitTypeId == 'O00S' then
        return 5
    elseif unitTypeId == 'O00L' then
        return 5
    elseif unitTypeId == 'O004' then
        return 5
    elseif unitTypeId == 'O008' then
        return 5
    elseif unitTypeId == 'O01V' then
        return 5
    elseif unitTypeId == 'O00D' then
        return 5
    elseif unitTypeId == 'O01X' then
        return 5
    elseif unitTypeId == 'O01Z' then
        return 5
    elseif unitTypeId == 'O01D' then
        return 5
    endif

    return 0
endfunction

function Ancient_GetAbilityIdByIndex takes integer unitTypeId,integer index returns integer
    if unitTypeId == 'O00A' then
        if index == 1 then
            return 'A0E9'
        elseif index == 2 then
            return 'A05F'
        elseif index == 3 then
            return 'A058'
        elseif index == 4 then
            return 'A05C'
        elseif index == 5 then
            return 'A05E'
        endif
    elseif unitTypeId == 'O00S' then
        if index == 1 then
            return 'A02B'
        elseif index == 2 then
            return 'A06P'
        elseif index == 3 then
            return 'A02A'
        elseif index == 4 then
            return 'A01J'
        elseif index == 5 then
            return 'A02D'
        endif
    elseif unitTypeId == 'O00L' then
        if index == 1 then
            return 'A06D'
        elseif index == 2 then
            return 'A088'
        elseif index == 3 then
            return 'A05Q'
        elseif index == 4 then
            return 'A01T'
        elseif index == 5 then
            return 'A06F'
        endif
    elseif unitTypeId == 'O004' then
        if index == 1 then
            return 'A002'
        elseif index == 2 then
            return 'A000'
        elseif index == 3 then
            return 'A07A'
        elseif index == 4 then
            return 'A003'
        elseif index == 5 then
            return 'A004'
        endif
    elseif unitTypeId == 'O008' then
        if index == 1 then
            return 'A008'
        elseif index == 2 then
            return 'A0EX'
        elseif index == 3 then
            return 'A074'
        elseif index == 4 then
            return 'A00A'
        elseif index == 5 then
            return 'A075'
        endif
    elseif unitTypeId == 'O01V' then
        if index == 1 then
            return 'A06X'
        elseif index == 2 then
            return 'A06W'
        elseif index == 3 then
            return 'A06V'
        elseif index == 4 then
            return 'A06U'
        elseif index == 5 then
            return 'A06Y'
        endif
    elseif unitTypeId == 'O016' then
        if index == 1 then
            return 'A03U'
        elseif index == 2 then
            return 'A09L'
        elseif index == 3 then
            return 'A03R'
        elseif index == 4 then
            return 'A07B'
        elseif index == 5 then
            return 'A03S'
        elseif index == 6 then
            return 'A03T'
        endif
    elseif unitTypeId == 'O00D' then
        if index == 1 then
            return 'A01M'
        elseif index == 2 then
            return 'A012'
        elseif index == 3 then
            return 'A070'
        elseif index == 4 then
            return 'A06Z'
        elseif index == 5 then
            return 'A013'
        endif
    elseif unitTypeId == 'O01X' then
        if index == 1 then
            return 'A07Y'
        elseif index == 2 then
            return 'A07X'
        elseif index == 3 then
            return 'A07Z'
        elseif index == 4 then
            return 'A080'
        elseif index == 5 then
            return 'A082'
        endif
    elseif unitTypeId == 'O01Z' then
        if index == 1 then
            return 'A08R'
        elseif index == 2 then
            return 'A08I'
        elseif index == 3 then
            return 'A08K'
        elseif index == 4 then
            return 'A0F1'
        elseif index == 5 then
            return 'A08S'
        endif
    elseif unitTypeId == 'O01D' then
        if index == 1 then
            return 'A0EL'
        elseif index == 2 then
            return 'A0EO'
        elseif index == 3 then
            return 'A0EP'
        elseif index == 4 then
            return 'A0ES'
        elseif index == 5 then
            return 'A048'
        endif
    endif

    return 0
endfunction

function Ancient_GetSingleAbilityLine takes unit ancient,integer abilityId returns string
    local integer abilityLevel= 1
    local integer tooltipIndex
    local string abilityName
    local string abilityDescription

    if ancient != null then
        set abilityLevel=GetUnitAbilityLevel(ancient, abilityId)
    endif

    if abilityLevel <= 0 then
        set abilityLevel=1
    endif

    set tooltipIndex=abilityLevel - 1

    set abilityName=Ancient_FormatTooltipText(BlzGetAbilityResearchTooltip(abilityId, tooltipIndex) , abilityLevel)
    set abilityName=Ancient_RemoveColorCodes(abilityName)
    set abilityName=Ancient_RemoveSquareBracketBlocks(abilityName)
    set abilityName=Ancient_CleanTrailingSeparators(abilityName)

    set abilityDescription=Ancient_FormatTooltipText(BlzGetAbilityResearchExtendedTooltip(abilityId, tooltipIndex) , abilityLevel)
    set abilityDescription=Ancient_RemoveColorCodes(abilityDescription)
    set abilityDescription=Ancient_CollapseSpaces(abilityDescription)

    if StringLength(abilityName) == 0 then
        set abilityName="Unknown ability"
    endif

    if StringLength(abilityDescription) == 0 then
        set abilityDescription="No learn tooltip text."
    endif

    return "|cff00ccff" + abilityName + "|r |cffffffff" + abilityDescription + "|r"
endfunction

function Ancient_ShowAbilityPageByType takes player p,unit ancient,integer unitTypeId,string ancientName,integer page,boolean isPreview returns nothing
    local integer abilityCount= Ancient_GetAbilityCount(unitTypeId)
    local integer abilitiesPerPage= 3
    local integer maxPage
    local integer startIndex
    local integer endIndex
    local integer i
    local integer abilityId
    local string pageText

    if abilityCount <= 0 then
        call Ancient_ClearMessagesForPlayer(p)
        call DisplayTimedTextToPlayer(p, 0.00, 0.00, 10.00, "|cffffcc00Ancient:|r This Ancient unit type is not registered: " + I2S(unitTypeId))
        return
    endif

    set maxPage=( abilityCount + abilitiesPerPage - 1 ) / abilitiesPerPage

    if page > maxPage then
        set page=maxPage
    endif

    set startIndex=( page - 1 ) * abilitiesPerPage + 1
    set endIndex=page * abilitiesPerPage

    if endIndex > abilityCount then
        set endIndex=abilityCount
    endif

    if isPreview then
        set pageText="|cffffcc00Ancient preview:|r |cffffffff" + ancientName + "|r |cffaaaaaaPage " + I2S(page) + "/" + I2S(maxPage) + "|r"
    else
        set pageText="|cffffcc00Ancient spells:|r |cffffffff" + ancientName + "|r |cffaaaaaaPage " + I2S(page) + "/" + I2S(maxPage) + "|r"
    endif

    set i=startIndex
    loop
        exitwhen i > endIndex

        set abilityId=Ancient_GetAbilityIdByIndex(unitTypeId , i)

        if abilityId != 0 then
            set pageText=pageText + "\n" + Ancient_GetSingleAbilityLine(ancient , abilityId)
        endif

        set i=i + 1
    endloop

    if page < maxPage then
        if isPreview then
            set pageText=pageText + "\n|cffaaaaaaType |r|cffffcc00-ancient " + Ancient_GetFirstWord(Ancient_GetUnitTypeDisplayName(unitTypeId)) + " " + I2S(page + 1) + "|r|cffaaaaaa to show the next page.|r"
        else
            set pageText=pageText + "\n|cffaaaaaaType |r|cffffcc00-ancient " + I2S(page + 1) + "|r|cffaaaaaa to show the next page.|r"
        endif
    endif

    call Ancient_ClearMessagesForPlayer(p)
    call DisplayTimedTextToPlayer(p, 0.00, 0.00, 45.00, pageText)
endfunction

function Ancient_ShowAbilityPage takes player p,unit ancient,integer page returns nothing
    call Ancient_ShowAbilityPageByType(p , ancient , GetUnitTypeId(ancient) , GetUnitName(ancient) , page , false)
endfunction

function Ancient_Command_Actions takes nothing returns nothing
    local player p= GetTriggerPlayer()
    local string chat= GetEventPlayerChatString()
    local string argument
    local string firstWordOriginal
    local string firstWord
    local integer page
    local integer previewUnitTypeId

    if not Ancient_IsCommand(chat) then
        set p=null
        return
    endif

    set argument=Ancient_GetArgumentText(chat)
    set firstWordOriginal=Ancient_GetFirstWord(argument)
    set firstWord=StringCase(firstWordOriginal, false)
    set previewUnitTypeId=Ancient_GetUnitTypeIdByKeyword(firstWord)

    if udg_AncientPlayer == null then
        call Ancient_ClearMessagesForPlayer(p)
        call DisplayTimedTextToPlayer(p, 0.00, 0.00, 10.00, "|cffffcc00Ancient:|r Ancient player is not set.")
        set p=null
        return
    endif

    if p == udg_AncientPlayer then
        if previewUnitTypeId != 0 then
            set page=Ancient_ParsePageFromArgument(argument)
            call Ancient_ShowAbilityPageByType(p , null , previewUnitTypeId , Ancient_GetUnitTypeDisplayName(previewUnitTypeId) , page , true)
            set p=null
            return
        endif

        if StringLength(firstWordOriginal) > 0 and S2I(firstWord) <= 0 and firstWord != "0" then
            call Ancient_ClearMessagesForPlayer(p)
            call DisplayTimedTextToPlayer(p, 0.00, 0.00, 10.00, "|cffffcc00Ancient preview:|r Cannot find Ancient called |cffff0000" + firstWordOriginal + "|r|cffffffff.|r")
            set p=null
            return
        endif

        call Ancient_ShowPreviewUsage(p)
        set p=null
        return
    endif

    if previewUnitTypeId != 0 then
        call Ancient_ClearMessagesForPlayer(p)
        call DisplayTimedTextToPlayer(p, 0.00, 0.00, 10.00, "|cffffcc00Ancient:|r Only the Ancient player can preview Ancient abilities by name.")
        set p=null
        return
    endif

    if StringLength(firstWordOriginal) > 0 and S2I(firstWord) <= 0 and firstWord != "0" then
        call Ancient_ClearMessagesForPlayer(p)
        call DisplayTimedTextToPlayer(p, 0.00, 0.00, 10.00, "|cffffcc00Ancient:|r Invalid page. Use |cffffcc00-ancient|r|cffffffff or |r|cffffcc00-ancient 2|r|cffffffff.|r")
        set p=null
        return
    endif

    set page=Ancient_ParsePageFromArgument(argument)

    if not IsPlayerEnemy(p, udg_AncientPlayer) then
        call Ancient_ClearMessagesForPlayer(p)
        call DisplayTimedTextToPlayer(p, 0.00, 0.00, 10.00, "|cffffcc00Ancient:|r This command is only available to enemies of the Ancient.")
        set p=null
        return
    endif

    if udg_AncientUnit == null then
        call Ancient_ClearMessagesForPlayer(p)
        call DisplayTimedTextToPlayer(p, 0.00, 0.00, 10.00, "|cffffcc00Ancient:|r There is currently no living Ancient unit.")
        set p=null
        return
    endif

    if GetUnitTypeId(udg_AncientUnit) == 0 or GetWidgetLife(udg_AncientUnit) <= 0.405 then
        call Ancient_ClearMessagesForPlayer(p)
        call DisplayTimedTextToPlayer(p, 0.00, 0.00, 10.00, "|cffffcc00Ancient:|r There is currently no living Ancient unit.")
        set p=null
        return
    endif

    call Ancient_ShowAbilityPage(p , udg_AncientUnit , page)

    set p=null
endfunction

function InitTrig_AncientSpells takes nothing returns nothing
    local trigger t= CreateTrigger()
    local integer i= 0

    loop
        exitwhen i >= bj_MAX_PLAYERS
        call TriggerRegisterPlayerChatEvent(t, Player(i), "-", false)
        set i=i + 1
    endloop

    call TriggerAddAction(t, function Ancient_Command_Actions)

    set t=null
endfunction
//===========================================================================
// Trigger: Start
//===========================================================================
function Trig_Start_Func001C takes nothing returns boolean
    if ( not ( GetPlayerController(udg_AncientPlayer) != MAP_CONTROL_USER ) ) then
        return false
    endif
    return true
endfunction

function Trig_Start_Actions takes nothing returns nothing
    if ( Trig_Start_Func001C() ) then
        call EnableTrigger(gg_trg_Hard_mode_on)
        call EnableTrigger(gg_trg_Select)
        call EnableTrigger(gg_trg_Abilities)
        call EnableTrigger(gg_trg_Attack)
        call TriggerSleepAction(2)
        call DisplayTextToForce(bj_FORCE_PLAYER[0], "TRIGSTR_7143")
    else
        call DoNothing()
    endif
endfunction

//===========================================================================
function InitTrig_Start takes nothing returns nothing
    set gg_trg_Start=CreateTrigger()
    call TriggerAddAction(gg_trg_Start, function Trig_Start_Actions)
endfunction

//===========================================================================
// Trigger: Hard mode on
//===========================================================================
function Trig_Hard_mode_on_Actions takes nothing returns nothing
    call DisplayTextToForce(bj_FORCE_PLAYER[0], "TRIGSTR_7144")
    call DisableTrigger(gg_trg_Attack)
    call EnableTrigger(gg_trg_Hard_Attack)
endfunction

//===========================================================================
function InitTrig_Hard_mode_on takes nothing returns nothing
    set gg_trg_Hard_mode_on=CreateTrigger()
    call DisableTrigger(gg_trg_Hard_mode_on)
    call TriggerRegisterPlayerChatEvent(gg_trg_Hard_mode_on, Player(0), "-hm", true)
    call TriggerAddAction(gg_trg_Hard_mode_on, function Trig_Hard_mode_on_Actions)
endfunction

//===========================================================================
// Trigger: Hard Attack
//===========================================================================
function Trig_Hard_Attack_Conditions takes nothing returns boolean
    if ( not ( IsUnitEnemy(GetTriggerUnit(), udg_AncientPlayer) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Hard_Attack_Func002002001 takes nothing returns boolean
    return ( GetOwningPlayer(GetEnumUnit()) != udg_AncientPlayer )
endfunction

function Trig_Hard_Attack_Func002002002001 takes nothing returns boolean
    return ( GetOwningPlayer(GetEnumUnit()) != Player(PLAYER_NEUTRAL_PASSIVE) )
endfunction

function Trig_Hard_Attack_Func002002002002001 takes nothing returns boolean
    return ( GetOwningPlayer(GetEnumUnit()) != Player(PLAYER_NEUTRAL_AGGRESSIVE) )
endfunction

function Trig_Hard_Attack_Func002002 takes nothing returns nothing
    if ( (GetOwningPlayer(GetEnumUnit()) != udg_AncientPlayer) ) then // INLINED!!
        if ( (GetOwningPlayer(GetEnumUnit()) != Player(PLAYER_NEUTRAL_PASSIVE)) ) then // INLINED!!
            if ( (GetOwningPlayer(GetEnumUnit()) != Player(PLAYER_NEUTRAL_AGGRESSIVE)) ) then // INLINED!!
                set udg_Hardunit=GetUnitLoc(GetEnumUnit())
            else
                call TriggerExecute(gg_trg_Hard_attack_2)
            endif
        else
            call TriggerExecute(gg_trg_Hard_attack_2)
        endif
    else
        call TriggerExecute(gg_trg_Hard_attack_2)
    endif
endfunction

function Trig_Hard_Attack_Func003002 takes nothing returns nothing
    call IssuePointOrderLocBJ(GetEnumUnit(), "attack", udg_Hardunit)
endfunction

function Trig_Hard_Attack_Actions takes nothing returns nothing
    call ForGroupBJ(GetRandomSubGroup(1, GetUnitsInRectAll(GetPlayableMapRect())), function Trig_Hard_Attack_Func002002)
    call ForGroupBJ(GetUnitsOfPlayerAll(udg_AncientPlayer), function Trig_Hard_Attack_Func003002)
    call EnableTrigger(gg_trg_Hard_Attack_Cont)
endfunction

//===========================================================================
function InitTrig_Hard_Attack takes nothing returns nothing
    set gg_trg_Hard_Attack=CreateTrigger()
    call DisableTrigger(gg_trg_Hard_Attack)
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Hard_Attack, EVENT_PLAYER_UNIT_DEATH)
    call TriggerRegisterTimerEventPeriodic(gg_trg_Hard_Attack, 35.00)
    call TriggerAddCondition(gg_trg_Hard_Attack, Condition(function Trig_Hard_Attack_Conditions))
    call TriggerAddAction(gg_trg_Hard_Attack, function Trig_Hard_Attack_Actions)
endfunction

//===========================================================================
// Trigger: Hard Attack Cont
//===========================================================================
function Trig_Hard_Attack_Cont_Conditions takes nothing returns boolean
    if ( not ( IsUnitEnemy(GetDyingUnit(), udg_AncientPlayer) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Hard_Attack_Cont_Func003002001 takes nothing returns boolean
    return ( GetOwningPlayer(GetEnumUnit()) != udg_AncientPlayer )
endfunction

function Trig_Hard_Attack_Cont_Func003002002001 takes nothing returns boolean
    return ( GetOwningPlayer(GetEnumUnit()) != Player(PLAYER_NEUTRAL_PASSIVE) )
endfunction

function Trig_Hard_Attack_Cont_Func003002002002001 takes nothing returns boolean
    return ( GetOwningPlayer(GetEnumUnit()) != Player(PLAYER_NEUTRAL_AGGRESSIVE) )
endfunction

function Trig_Hard_Attack_Cont_Func003002 takes nothing returns nothing
    if ( (GetOwningPlayer(GetEnumUnit()) != udg_AncientPlayer) ) then // INLINED!!
        if ( (GetOwningPlayer(GetEnumUnit()) != Player(PLAYER_NEUTRAL_PASSIVE)) ) then // INLINED!!
            if ( (GetOwningPlayer(GetEnumUnit()) != Player(PLAYER_NEUTRAL_AGGRESSIVE)) ) then // INLINED!!
                set udg_Hardunit=GetUnitLoc(GetEnumUnit())
            else
                call TriggerExecute(gg_trg_Hard_attack_2)
            endif
        else
            call TriggerExecute(gg_trg_Hard_attack_2)
        endif
    else
        call TriggerExecute(gg_trg_Hard_attack_2)
    endif
endfunction

function Trig_Hard_Attack_Cont_Func004002 takes nothing returns nothing
    call IssuePointOrderLocBJ(GetEnumUnit(), "attack", udg_Hardunit)
endfunction

function Trig_Hard_Attack_Cont_Actions takes nothing returns nothing
    call ForGroupBJ(GetRandomSubGroup(1, GetUnitsInRectAll(GetPlayableMapRect())), function Trig_Hard_Attack_Cont_Func003002)
    call ForGroupBJ(GetUnitsOfPlayerAll(udg_AncientPlayer), function Trig_Hard_Attack_Cont_Func004002)
endfunction

//===========================================================================
function InitTrig_Hard_Attack_Cont takes nothing returns nothing
    set gg_trg_Hard_Attack_Cont=CreateTrigger()
    call DisableTrigger(gg_trg_Hard_Attack_Cont)
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Hard_Attack_Cont, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Hard_Attack_Cont, Condition(function Trig_Hard_Attack_Cont_Conditions))
    call TriggerAddAction(gg_trg_Hard_Attack_Cont, function Trig_Hard_Attack_Cont_Actions)
endfunction

//===========================================================================
// Trigger: Hard attack 2
//===========================================================================
function Trig_Hard_attack_2_Func001002001 takes nothing returns boolean
    return ( GetOwningPlayer(GetEnumUnit()) != udg_AncientPlayer )
endfunction

function Trig_Hard_attack_2_Func001002002001 takes nothing returns boolean
    return ( GetOwningPlayer(GetEnumUnit()) != Player(PLAYER_NEUTRAL_PASSIVE) )
endfunction

function Trig_Hard_attack_2_Func001002002002001 takes nothing returns boolean
    return ( GetOwningPlayer(GetEnumUnit()) != Player(PLAYER_NEUTRAL_AGGRESSIVE) )
endfunction

function Trig_Hard_attack_2_Func001002 takes nothing returns nothing
    if ( (GetOwningPlayer(GetEnumUnit()) != udg_AncientPlayer) ) then // INLINED!!
        if ( (GetOwningPlayer(GetEnumUnit()) != Player(PLAYER_NEUTRAL_PASSIVE)) ) then // INLINED!!
            if ( (GetOwningPlayer(GetEnumUnit()) != Player(PLAYER_NEUTRAL_AGGRESSIVE)) ) then // INLINED!!
                set udg_Hardunit=GetUnitLoc(GetEnumUnit())
            else
                call TriggerExecute(gg_trg_Hard_attack_2)
            endif
        else
            call TriggerExecute(gg_trg_Hard_attack_2)
        endif
    else
        call TriggerExecute(gg_trg_Hard_attack_2)
    endif
endfunction

function Trig_Hard_attack_2_Func002002 takes nothing returns nothing
    call IssuePointOrderLocBJ(GetEnumUnit(), "attack", GetUnitLoc(GetFilterUnit()))
endfunction

function Trig_Hard_attack_2_Actions takes nothing returns nothing
    call ForGroupBJ(GetRandomSubGroup(1, GetUnitsInRectAll(GetPlayableMapRect())), function Trig_Hard_attack_2_Func001002)
    call ForGroupBJ(GetUnitsOfPlayerAll(udg_AncientPlayer), function Trig_Hard_attack_2_Func002002)
endfunction

//===========================================================================
function InitTrig_Hard_attack_2 takes nothing returns nothing
    set gg_trg_Hard_attack_2=CreateTrigger()
    call DisableTrigger(gg_trg_Hard_attack_2)
    call TriggerAddAction(gg_trg_Hard_attack_2, function Trig_Hard_attack_2_Actions)
endfunction

//===========================================================================
// Trigger: Select
//===========================================================================
function Trig_Select_Func026002 takes nothing returns nothing
    call RemoveUnit(GetEnumUnit())
endfunction

function Trig_Select_Actions takes nothing returns nothing
    set udg_Ancients[1]='O004'
    set udg_Ancients[2]='O004'
    set udg_Ancients[3]='O004'
    set udg_Ancients[4]='O00A'
    set udg_Ancients[5]='O00A'
    set udg_Ancients[6]='O00A'
    set udg_Ancients[7]='O00S'
    set udg_Ancients[8]='O00S'
    set udg_Ancients[9]='O00S'
    set udg_Ancients[10]='O00L'
    set udg_Ancients[11]='O00L'
    set udg_Ancients[12]='O00L'
    set udg_Ancients[13]='O008'
    set udg_Ancients[14]='O008'
    set udg_Ancients[15]='O008'
    set udg_Ancients[16]='O00D'
    set udg_Ancients[17]='O00D'
    set udg_Ancients[18]='O00D'
    set udg_Ancients[19]='O016'
    set udg_Ancients[20]='O016'
    set udg_Ancients[21]='O016'
    set udg_Ancients[22]='O01D'
    set udg_Ancients[23]='O01V'
    set udg_Ancients[24]='O01V'
    set udg_Ancients[25]='O01V'
    call ForGroupBJ(GetUnitsInRectAll(gg_rct_SpawnDefender), function Trig_Select_Func026002)
    call AdjustPlayerStateBJ(- 1000, udg_AncientPlayer, PLAYER_STATE_RESOURCE_GOLD)
    call CreateNUnitsAtLoc(1, udg_Ancients[GetRandomInt(1, 8)], udg_AncientPlayer, GetRectCenter(gg_rct_Spawner), bj_UNIT_FACING)
    set udg_AncientUnit=GetLastCreatedUnit()
    call EnableTrigger(gg_trg_Slot1_Righteous_Armor)
endfunction

//===========================================================================
function InitTrig_Select takes nothing returns nothing
    set gg_trg_Select=CreateTrigger()
    call DisableTrigger(gg_trg_Select)
    call TriggerRegisterTimerEventSingle(gg_trg_Select, 100.00)
    call TriggerAddAction(gg_trg_Select, function Trig_Select_Actions)
endfunction

//===========================================================================
// Trigger: Attack
//===========================================================================
function Trig_Attack_Func017002 takes nothing returns nothing
    call IssuePointOrderLocBJ(GetEnumUnit(), "attack", GetRectCenter(udg_Moveto[GetRandomInt(1, 16)]))
endfunction

function Trig_Attack_Actions takes nothing returns nothing
    set udg_Moveto[1]=gg_rct_Ping1
    set udg_Moveto[2]=gg_rct_Ping2
    set udg_Moveto[3]=gg_rct_Ping3
    set udg_Moveto[4]=gg_rct_Ping4
    set udg_Moveto[5]=gg_rct_Ping5
    set udg_Moveto[6]=gg_rct_Ping6
    set udg_Moveto[7]=gg_rct_AI_Move_1
    set udg_Moveto[8]=gg_rct_AI_Move_10
    set udg_Moveto[9]=gg_rct_AI_Move_2
    set udg_Moveto[10]=gg_rct_AI_Move_3
    set udg_Moveto[11]=gg_rct_AI_Move_4
    set udg_Moveto[12]=gg_rct_AI_Move_5
    set udg_Moveto[13]=gg_rct_AI_Move_6
    set udg_Moveto[14]=gg_rct_AI_Move_7
    set udg_Moveto[15]=gg_rct_AI_Move_8
    set udg_Moveto[16]=gg_rct_AI_Move_9
    call ForGroupBJ(GetUnitsOfPlayerAll(udg_AncientPlayer), function Trig_Attack_Func017002)
endfunction

//===========================================================================
function InitTrig_Attack takes nothing returns nothing
    set gg_trg_Attack=CreateTrigger()
    call DisableTrigger(gg_trg_Attack)
    call TriggerRegisterTimerEventPeriodic(gg_trg_Attack, 65.00)
    call TriggerAddAction(gg_trg_Attack, function Trig_Attack_Actions)
endfunction

//===========================================================================
// Trigger: Run away
//
// retarded triggering
//===========================================================================
function Trig_Run_away_Actions takes nothing returns nothing
endfunction

//===========================================================================
function InitTrig_Run_away takes nothing returns nothing
    set gg_trg_Run_away=CreateTrigger()
    call DisableTrigger(gg_trg_Run_away)
    call TriggerAddAction(gg_trg_Run_away, function Trig_Run_away_Actions)
endfunction

//===========================================================================
// Trigger: Slot1 Righteous Armor
//===========================================================================
function Trig_Slot1_Righteous_Armor_Actions takes nothing returns nothing
    call UnitAddItemByIdSwapped('I012', udg_AncientUnit)
    call AdjustPlayerStateBJ(- 1500, udg_AncientPlayer, PLAYER_STATE_RESOURCE_GOLD)
    call DisableTrigger(GetTriggeringTrigger())
    call EnableTrigger(gg_trg_Slot2_Valor_Helmet)
endfunction

//===========================================================================
function InitTrig_Slot1_Righteous_Armor takes nothing returns nothing
    set gg_trg_Slot1_Righteous_Armor=CreateTrigger()
    call DisableTrigger(gg_trg_Slot1_Righteous_Armor)
    call TriggerRegisterPlayerStateEvent(gg_trg_Slot1_Righteous_Armor, Player(6), PLAYER_STATE_RESOURCE_GOLD, GREATER_THAN_OR_EQUAL, 1500.00)
    call TriggerAddAction(gg_trg_Slot1_Righteous_Armor, function Trig_Slot1_Righteous_Armor_Actions)
endfunction

//===========================================================================
// Trigger: Slot2 Valor Helmet
//===========================================================================
function Trig_Slot2_Valor_Helmet_Actions takes nothing returns nothing
    call UnitAddItemByIdSwapped('I015', udg_AncientUnit)
    call AdjustPlayerStateBJ(- 1050, udg_AncientPlayer, PLAYER_STATE_RESOURCE_GOLD)
    call DisableTrigger(GetTriggeringTrigger())
    call EnableTrigger(gg_trg_Slot3_Bladed_Gauntlet)
endfunction

//===========================================================================
function InitTrig_Slot2_Valor_Helmet takes nothing returns nothing
    set gg_trg_Slot2_Valor_Helmet=CreateTrigger()
    call DisableTrigger(gg_trg_Slot2_Valor_Helmet)
    call TriggerRegisterPlayerStateEvent(gg_trg_Slot2_Valor_Helmet, Player(6), PLAYER_STATE_RESOURCE_GOLD, GREATER_THAN_OR_EQUAL, 1050.00)
    call TriggerAddAction(gg_trg_Slot2_Valor_Helmet, function Trig_Slot2_Valor_Helmet_Actions)
endfunction

//===========================================================================
// Trigger: Slot3 Bladed Gauntlet
//===========================================================================
function Trig_Slot3_Bladed_Gauntlet_Actions takes nothing returns nothing
    call AdjustPlayerStateBJ(- 1500, udg_AncientPlayer, PLAYER_STATE_RESOURCE_GOLD)
    call UnitAddItemByIdSwapped('I012', udg_AncientUnit)
    call DisableTrigger(GetTriggeringTrigger())
    call EnableTrigger(gg_trg_Slot4_Bladed_Gauntlet)
endfunction

//===========================================================================
function InitTrig_Slot3_Bladed_Gauntlet takes nothing returns nothing
    set gg_trg_Slot3_Bladed_Gauntlet=CreateTrigger()
    call DisableTrigger(gg_trg_Slot3_Bladed_Gauntlet)
    call TriggerRegisterPlayerStateEvent(gg_trg_Slot3_Bladed_Gauntlet, Player(6), PLAYER_STATE_RESOURCE_GOLD, GREATER_THAN_OR_EQUAL, 1500.00)
    call TriggerAddAction(gg_trg_Slot3_Bladed_Gauntlet, function Trig_Slot3_Bladed_Gauntlet_Actions)
endfunction

//===========================================================================
// Trigger: Slot4 Bladed Gauntlet
//===========================================================================
function Trig_Slot4_Bladed_Gauntlet_Actions takes nothing returns nothing
    call AdjustPlayerStateBJ(- 1500, udg_AncientPlayer, PLAYER_STATE_RESOURCE_GOLD)
    call UnitAddItemByIdSwapped('I012', udg_AncientUnit)
    call DisableTrigger(GetTriggeringTrigger())
    call EnableTrigger(gg_trg_Slot5_Bladed_Gauntlet)
endfunction

//===========================================================================
function InitTrig_Slot4_Bladed_Gauntlet takes nothing returns nothing
    set gg_trg_Slot4_Bladed_Gauntlet=CreateTrigger()
    call DisableTrigger(gg_trg_Slot4_Bladed_Gauntlet)
    call TriggerRegisterPlayerStateEvent(gg_trg_Slot4_Bladed_Gauntlet, Player(6), PLAYER_STATE_RESOURCE_GOLD, GREATER_THAN_OR_EQUAL, 1500.00)
    call TriggerAddAction(gg_trg_Slot4_Bladed_Gauntlet, function Trig_Slot4_Bladed_Gauntlet_Actions)
endfunction

//===========================================================================
// Trigger: Slot5 Bladed Gauntlet
//===========================================================================
function Trig_Slot5_Bladed_Gauntlet_Actions takes nothing returns nothing
    call AdjustPlayerStateBJ(- 1500, udg_AncientPlayer, PLAYER_STATE_RESOURCE_GOLD)
    call UnitAddItemByIdSwapped('I012', udg_AncientUnit)
    call DisableTrigger(GetTriggeringTrigger())
    call EnableTrigger(gg_trg_Slot6_Bladed_Gauntlet)
endfunction

//===========================================================================
function InitTrig_Slot5_Bladed_Gauntlet takes nothing returns nothing
    set gg_trg_Slot5_Bladed_Gauntlet=CreateTrigger()
    call DisableTrigger(gg_trg_Slot5_Bladed_Gauntlet)
    call TriggerRegisterPlayerStateEvent(gg_trg_Slot5_Bladed_Gauntlet, Player(6), PLAYER_STATE_RESOURCE_GOLD, GREATER_THAN_OR_EQUAL, 1500.00)
    call TriggerAddAction(gg_trg_Slot5_Bladed_Gauntlet, function Trig_Slot5_Bladed_Gauntlet_Actions)
endfunction

//===========================================================================
// Trigger: Slot6 Bladed Gauntlet
//===========================================================================
function Trig_Slot6_Bladed_Gauntlet_Actions takes nothing returns nothing
    call AdjustPlayerStateBJ(- 1500, udg_AncientPlayer, PLAYER_STATE_RESOURCE_GOLD)
    call UnitAddItemByIdSwapped('I012', udg_AncientUnit)
    call DisableTrigger(GetTriggeringTrigger())
    call EnableTrigger(gg_trg_Level_Up_Tomes)
endfunction

//===========================================================================
function InitTrig_Slot6_Bladed_Gauntlet takes nothing returns nothing
    set gg_trg_Slot6_Bladed_Gauntlet=CreateTrigger()
    call DisableTrigger(gg_trg_Slot6_Bladed_Gauntlet)
    call TriggerRegisterPlayerStateEvent(gg_trg_Slot6_Bladed_Gauntlet, Player(6), PLAYER_STATE_RESOURCE_GOLD, GREATER_THAN_OR_EQUAL, 1500.00)
    call TriggerAddAction(gg_trg_Slot6_Bladed_Gauntlet, function Trig_Slot6_Bladed_Gauntlet_Actions)
endfunction

//===========================================================================
// Trigger: Level Up Tomes
//===========================================================================
function Trig_Level_Up_Tomes_Actions takes nothing returns nothing
    call UnitAddItemByIdSwapped('I003', udg_AncientUnit)
    call AdjustPlayerStateBJ(- 1000, udg_AncientPlayer, PLAYER_STATE_RESOURCE_GOLD)
endfunction

//===========================================================================
function InitTrig_Level_Up_Tomes takes nothing returns nothing
    set gg_trg_Level_Up_Tomes=CreateTrigger()
    call DisableTrigger(gg_trg_Level_Up_Tomes)
    call TriggerRegisterPlayerStateEvent(gg_trg_Level_Up_Tomes, Player(6), PLAYER_STATE_RESOURCE_GOLD, GREATER_THAN_OR_EQUAL, 1000.00)
    call TriggerAddAction(gg_trg_Level_Up_Tomes, function Trig_Level_Up_Tomes_Actions)
endfunction

//===========================================================================
// Trigger: Abilities
//===========================================================================
function Trig_Abilities_Func001Func007Func007Func007Func006Func007Func007Func001Func001C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_AncientUnit) == 'O01V' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Abilities_Func001Func007Func007Func007Func006Func007Func007Func001C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_AncientUnit) == 'O01D' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Abilities_Func001Func007Func007Func007Func006Func007Func007C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_AncientUnit) == 'O016' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Abilities_Func001Func007Func007Func007Func006Func007C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_AncientUnit) == 'O00D' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Abilities_Func001Func007Func007Func007Func006C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_AncientUnit) == 'O008' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Abilities_Func001Func007Func007Func007C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_AncientUnit) == 'O004' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Abilities_Func001Func007Func007C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_AncientUnit) == 'O00L' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Abilities_Func001Func007C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_AncientUnit) == 'O00S' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Abilities_Func001C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_AncientUnit) == 'O00A' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Abilities_Actions takes nothing returns nothing
    if ( Trig_Abilities_Func001C() ) then
        call SelectHeroSkill(udg_AncientUnit, 'A05E')
        call SelectHeroSkill(udg_AncientUnit, 'A05C')
        call SelectHeroSkill(udg_AncientUnit, 'A0E9')
        call SelectHeroSkill(udg_AncientUnit, 'A058')
        call SelectHeroSkill(udg_AncientUnit, 'A05F')
    else
        if ( Trig_Abilities_Func001Func007C() ) then
            call SelectHeroSkill(udg_AncientUnit, 'A02D')
            call SelectHeroSkill(udg_AncientUnit, 'A06P')
            call SelectHeroSkill(udg_AncientUnit, 'A01J')
            call SelectHeroSkill(udg_AncientUnit, 'A02A')
            call SelectHeroSkill(udg_AncientUnit, 'A02B')
        else
            if ( Trig_Abilities_Func001Func007Func007C() ) then
                call SelectHeroSkill(udg_AncientUnit, 'A06F')
                call SelectHeroSkill(udg_AncientUnit, 'A088')
                call SelectHeroSkill(udg_AncientUnit, 'A05Q')
                call SelectHeroSkill(udg_AncientUnit, 'A01T')
                call SelectHeroSkill(udg_AncientUnit, 'A06D')
            else
                if ( Trig_Abilities_Func001Func007Func007Func007C() ) then
                    call SelectHeroSkill(udg_AncientUnit, 'A004')
                    call SelectHeroSkill(udg_AncientUnit, 'A000')
                    call SelectHeroSkill(udg_AncientUnit, 'A003')
                    call SelectHeroSkill(udg_AncientUnit, 'A002')
                else
                    if ( Trig_Abilities_Func001Func007Func007Func007Func006C() ) then
                        call SelectHeroSkill(udg_AncientUnit, 'A075')
                        call SelectHeroSkill(udg_AncientUnit, 'A073')
                        call SelectHeroSkill(udg_AncientUnit, 'A074')
                        call SelectHeroSkill(udg_AncientUnit, 'A00A')
                        call SelectHeroSkill(udg_AncientUnit, 'A008')
                    else
                        if ( Trig_Abilities_Func001Func007Func007Func007Func006Func007C() ) then
                            call SelectHeroSkill(udg_AncientUnit, 'A013')
                            call SelectHeroSkill(udg_AncientUnit, 'A070')
                            call SelectHeroSkill(udg_AncientUnit, 'A01M')
                            call SelectHeroSkill(udg_AncientUnit, 'A012')
                            call SelectHeroSkill(udg_AncientUnit, 'A06Z')
                        else
                            if ( Trig_Abilities_Func001Func007Func007Func007Func006Func007Func007C() ) then
                                call SelectHeroSkill(udg_AncientUnit, 'A03R')
                                call SelectHeroSkill(udg_AncientUnit, 'A03S')
                                call SelectHeroSkill(udg_AncientUnit, 'A03U')
                                call SelectHeroSkill(udg_AncientUnit, 'A03T')
                            else
                                if ( Trig_Abilities_Func001Func007Func007Func007Func006Func007Func007Func001C() ) then
                                    call SelectHeroSkill(udg_AncientUnit, 'A048')
                                    call SelectHeroSkill(udg_AncientUnit, 'A046')
                                    call SelectHeroSkill(udg_AncientUnit, 'A045')
                                    call SelectHeroSkill(udg_AncientUnit, 'A047')
                                else
                                    if ( Trig_Abilities_Func001Func007Func007Func007Func006Func007Func007Func001Func001C() ) then
                                        call SelectHeroSkill(udg_AncientUnit, 'A06Y')
                                        call SelectHeroSkill(udg_AncientUnit, 'A06X')
                                        call SelectHeroSkill(udg_AncientUnit, 'A06U')
                                        call SelectHeroSkill(udg_AncientUnit, 'A06W')
                                        call SelectHeroSkill(udg_AncientUnit, 'A06V')
                                    else
                                        call DoNothing()
                                    endif
                                endif
                            endif
                        endif
                    endif
                endif
            endif
        endif
    endif
endfunction

//===========================================================================
function InitTrig_Abilities takes nothing returns nothing
    set gg_trg_Abilities=CreateTrigger()
    call DisableTrigger(gg_trg_Abilities)
    call TriggerRegisterTimerEventPeriodic(gg_trg_Abilities, 30.00)
    call TriggerAddAction(gg_trg_Abilities, function Trig_Abilities_Actions)
endfunction

//===========================================================================
// Trigger: Staff of insight pickup
//===========================================================================
function Trig_Staff_of_insight_pickup_Conditions takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I01C' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Staff_of_insight_pickup_Actions takes nothing returns nothing
    call BlzItemAddAbilityBJ(GetManipulatedItem(), 'AIms')
endfunction

//===========================================================================
function InitTrig_Staff_of_insight_pickup takes nothing returns nothing
    set gg_trg_Staff_of_insight_pickup=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Staff_of_insight_pickup, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddCondition(gg_trg_Staff_of_insight_pickup, Condition(function Trig_Staff_of_insight_pickup_Conditions))
    call TriggerAddAction(gg_trg_Staff_of_insight_pickup, function Trig_Staff_of_insight_pickup_Actions)
endfunction

//===========================================================================
// Trigger: Dusts Slow
//===========================================================================

function DAS_RegisterInvisBuff takes integer buffId returns nothing
    set DAS_InvisBuff[DAS_InvisBuffCount]=buffId
    set DAS_InvisBuffCount=DAS_InvisBuffCount + 1
endfunction

function DAS_InitInvisBuffs takes nothing returns nothing
    set DAS_InvisBuffCount=0

    call DAS_RegisterInvisBuff('B03X')
    call DAS_RegisterInvisBuff('B026')
    call DAS_RegisterInvisBuff('BOwk')
    call DAS_RegisterInvisBuff('Binv')
    call DAS_RegisterInvisBuff('B001')
endfunction

function DAS_HasSlowAura takes unit target returns boolean
    return GetUnitAbilityLevel(target, DAS_SLOW_AURA_ID) > 0
endfunction

function DAS_TargetCountsAsInvisible takes unit target,player dustOwner returns boolean
    local boolean engineInvisible= false
    local integer i= 0

    if dustOwner != null then
        set engineInvisible=IsUnitInvisible(target, dustOwner)
    endif

    if engineInvisible then
        return true
    endif

    if GetUnitAbilityLevel(target, DAS_PERMANENT_INVIS_ABILITY) > 0 then
        return true
    endif

    loop
        exitwhen i >= DAS_InvisBuffCount

        if GetUnitAbilityLevel(target, DAS_InvisBuff[i]) > 0 then
            return true
        endif

        set i=i + 1
    endloop

    return false
endfunction

function DAS_AddSlowAura takes unit target returns nothing
    if target == null then
        return
    endif

    if not (GetUnitAbilityLevel((target), DAS_SLOW_AURA_ID) > 0) then // INLINED!!
        call UnitAddAbility(target, DAS_SLOW_AURA_ID)
        call BlzUnitHideAbility(target, DAS_SLOW_AURA_ID, true)
    endif
endfunction

function DAS_RemoveSlowAura takes unit target returns nothing
    if target == null then
        return
    endif

    if (GetUnitAbilityLevel((target), DAS_SLOW_AURA_ID) > 0) then // INLINED!!
        call UnitRemoveAbility(target, DAS_SLOW_AURA_ID)
    endif
endfunction

function DAS_StopTracking takes unit target returns nothing
    local timer t

    if target == null then
        return
    endif

    set t=LoadTimerHandle(DAS_Hash, GetHandleId(target), DAS_KEY_TRACK_TIMER)

    if t != null then
        call PauseTimer(t)
        call FlushChildHashtable(DAS_Hash, GetHandleId(t))
        call DestroyTimer(t)
        call RemoveSavedHandle(DAS_Hash, GetHandleId(target), DAS_KEY_TRACK_TIMER)
    endif

    set t=null
endfunction

function DAS_TrackLoop takes nothing returns nothing
    local timer t= GetExpiredTimer()
    local unit target= LoadUnitHandle(DAS_Hash, GetHandleId(t), DAS_KEY_TIMER_TARGET)
    local player dustOwner= LoadPlayerHandle(DAS_Hash, GetHandleId(t), DAS_KEY_TIMER_OWNER)
    local boolean hasDust
    local boolean isInvisible

    if target == null then
        call PauseTimer(t)
        call FlushChildHashtable(DAS_Hash, GetHandleId(t))
        call DestroyTimer(t)
        set t=null
        set dustOwner=null
        return
    endif

    if GetWidgetLife(target) <= 0.405 then
        call DAS_RemoveSlowAura(target)
        call DAS_StopTracking(target)
        set t=null
        set target=null
        set dustOwner=null
        return
    endif

    set hasDust=GetUnitAbilityLevel(target, DAS_DUST_BUFF_ID) > 0
    set isInvisible=DAS_TargetCountsAsInvisible(target , dustOwner)

    if not hasDust then
        if (GetUnitAbilityLevel((target), DAS_SLOW_AURA_ID) > 0) then // INLINED!!
            call DAS_RemoveSlowAura(target)
        endif

        call DAS_StopTracking(target)
    elseif isInvisible then
        if not (GetUnitAbilityLevel((target), DAS_SLOW_AURA_ID) > 0) then // INLINED!!
            call DAS_AddSlowAura(target)
        endif
    else
        if (GetUnitAbilityLevel((target), DAS_SLOW_AURA_ID) > 0) and not isInvisible then // INLINED!!
            call DAS_RemoveSlowAura(target)
        endif
    endif

    set t=null
    set target=null
    set dustOwner=null
endfunction

function DAS_StartTracking takes unit target,player dustOwner returns nothing
    local timer t

    if target == null then
        return
    endif

    set t=LoadTimerHandle(DAS_Hash, GetHandleId(target), DAS_KEY_TRACK_TIMER)

    if t != null then
        call SavePlayerHandle(DAS_Hash, GetHandleId(t), DAS_KEY_TIMER_OWNER, dustOwner)
        set t=null
        return
    endif

    set t=CreateTimer()
    call SaveTimerHandle(DAS_Hash, GetHandleId(target), DAS_KEY_TRACK_TIMER, t)
    call SaveUnitHandle(DAS_Hash, GetHandleId(t), DAS_KEY_TIMER_TARGET, target)
    call SavePlayerHandle(DAS_Hash, GetHandleId(t), DAS_KEY_TIMER_OWNER, dustOwner)
    call TimerStart(t, DAS_PERIOD, true, function DAS_TrackLoop)

    set t=null
endfunction

function DAS_EnumDustTargets takes nothing returns nothing
    local unit target= GetEnumUnit()

    if target != null and GetWidgetLife(target) > 0.405 and IsUnitEnemy(target, DAS_EnumOwner) and not IsUnitType(target, UNIT_TYPE_STRUCTURE) then
        call DAS_StartTracking(target , DAS_EnumOwner)
    endif

    set target=null
endfunction

function DAS_OnCast_Condition takes nothing returns boolean
    return GetSpellAbilityId() == DAS_DUST_CAST_ABILITY_ID
endfunction

function DAS_OnCast_Action takes nothing returns nothing
    local unit caster= GetTriggerUnit()
    local real x= GetUnitX(caster)
    local real y= GetUnitY(caster)

    set DAS_EnumOwner=GetOwningPlayer(caster)

    call GroupEnumUnitsInRange(DAS_EnumGroup, x, y, DAS_RADIUS, null)
    call ForGroup(DAS_EnumGroup, function DAS_EnumDustTargets)
    call GroupClear(DAS_EnumGroup)

    set DAS_EnumOwner=null
    set caster=null
endfunction

function InitTrig_Dusts_Slow takes nothing returns nothing
    local trigger t= CreateTrigger()
    local integer i= 0

    call DAS_InitInvisBuffs()

    loop
        exitwhen i >= bj_MAX_PLAYER_SLOTS
        call TriggerRegisterPlayerUnitEvent(t, Player(i), EVENT_PLAYER_UNIT_SPELL_EFFECT, null)
        set i=i + 1
    endloop

    call TriggerAddCondition(t, Condition(function DAS_OnCast_Condition))
    call TriggerAddAction(t, function DAS_OnCast_Action)

    set t=null
endfunction
//===========================================================================
// Trigger: Firelords Cape usage
//===========================================================================
function Trig_Firelords_Cape_usage_Conditions takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I01T' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Firelords_Cape_usage_Actions takes nothing returns nothing
    call SetUnitLifePercentBJ(GetTriggerUnit(), ( GetUnitLifePercent(GetTriggerUnit()) + ( 0.20 * ( 100.00 - GetUnitLifePercent(GetTriggerUnit()) ) ) ))
endfunction

//===========================================================================
function InitTrig_Firelords_Cape_usage takes nothing returns nothing
    set gg_trg_Firelords_Cape_usage=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Firelords_Cape_usage, EVENT_PLAYER_UNIT_USE_ITEM)
    call TriggerAddCondition(gg_trg_Firelords_Cape_usage, Condition(function Trig_Firelords_Cape_usage_Conditions))
    call TriggerAddAction(gg_trg_Firelords_Cape_usage, function Trig_Firelords_Cape_usage_Actions)
endfunction

//===========================================================================
// Trigger: Firelords Cape pickup
//===========================================================================
function Trig_Firelords_Cape_pickup_Conditions takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I01T' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Firelords_Cape_pickup_Actions takes nothing returns nothing
    call BlzItemAddAbilityBJ(GetManipulatedItem(), 'AIms')
    call BlzItemAddAbilityBJ(GetManipulatedItem(), 'AId0')
endfunction

//===========================================================================
function InitTrig_Firelords_Cape_pickup takes nothing returns nothing
    set gg_trg_Firelords_Cape_pickup=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Firelords_Cape_pickup, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddCondition(gg_trg_Firelords_Cape_pickup, Condition(function Trig_Firelords_Cape_pickup_Conditions))
    call TriggerAddAction(gg_trg_Firelords_Cape_pickup, function Trig_Firelords_Cape_pickup_Actions)
endfunction

//===========================================================================
// Trigger: Bladed Gauntlet vs Hero
//===========================================================================
function Trig_Bladed_Gauntlet_vs_Hero_Func002001 takes nothing returns boolean
    return ( UnitHasItemOfTypeBJ(udg_DamageEventSource, 'I00F') == true )
endfunction

function Trig_Bladed_Gauntlet_vs_Hero_Func002002 takes nothing returns boolean
    return ( UnitHasItemOfTypeBJ(udg_DamageEventSource, 'I01L') == true )
endfunction

function Trig_Bladed_Gauntlet_vs_Hero_Conditions takes nothing returns boolean
    if ( not GetBooleanOr((UnitHasItemOfTypeBJ(udg_DamageEventSource, 'I00F') == true), (UnitHasItemOfTypeBJ(udg_DamageEventSource, 'I01L') == true)) ) then // INLINED!!
        return false
    endif
    if ( not ( udg_IsDamageAttack == true ) ) then
        return false
    endif
    if ( not ( IsUnitType(udg_DamageEventTarget, UNIT_TYPE_HERO) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Bladed_Gauntlet_vs_Hero_Actions takes nothing returns nothing
    call UnitDamageTargetBJ(udg_DamageEventSource, udg_DamageEventTarget, 100.00, ATTACK_TYPE_HERO, DAMAGE_TYPE_NORMAL)
endfunction

//===========================================================================
function InitTrig_Bladed_Gauntlet_vs_Hero takes nothing returns nothing
    set gg_trg_Bladed_Gauntlet_vs_Hero=CreateTrigger()
    call h__TriggerRegisterVariableEvent(gg_trg_Bladed_Gauntlet_vs_Hero, "udg_DamageEvent", EQUAL, 1.00)
    call TriggerAddCondition(gg_trg_Bladed_Gauntlet_vs_Hero, Condition(function Trig_Bladed_Gauntlet_vs_Hero_Conditions))
    call TriggerAddAction(gg_trg_Bladed_Gauntlet_vs_Hero, function Trig_Bladed_Gauntlet_vs_Hero_Actions)
endfunction

//===========================================================================
// Trigger: Cast CL on Banish
//===========================================================================
function Trig_Cast_CL_on_Banish_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A094' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Cast_CL_on_Banish_Actions takes nothing returns nothing
    set udg_Temp_Point=GetUnitLoc(GetSpellAbilityUnit())
    call CreateNUnitsAtLocFacingLocBJ(1, 'h04L', GetOwningPlayer(GetSpellAbilityUnit()), udg_Temp_Point, udg_Temp_Point)
    call UnitApplyTimedLifeBJ(0.50, 'BTLF', GetLastCreatedUnit())
    call IssueTargetOrderBJ(GetLastCreatedUnit(), "chainlightning", GetSpellTargetUnit())
    call RemoveLocation(udg_Temp_Point)
endfunction

//===========================================================================
function InitTrig_Cast_CL_on_Banish takes nothing returns nothing
    set gg_trg_Cast_CL_on_Banish=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Cast_CL_on_Banish, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Cast_CL_on_Banish, Condition(function Trig_Cast_CL_on_Banish_Conditions))
    call TriggerAddAction(gg_trg_Cast_CL_on_Banish, function Trig_Cast_CL_on_Banish_Actions)
endfunction

//===========================================================================
// Trigger: Ledgers XP
//===========================================================================
function Trig_Ledgers_XP_Func001Func001C takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(udg_Ledger, 'I01J') == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Ledgers_XP_Func001C takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(udg_Ledger, 'I01N') == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Ledgers_XP_Actions takes nothing returns nothing
    if ( Trig_Ledgers_XP_Func001C() ) then
        call AddHeroXPSwapped(8, udg_Ledger, true)
    else
        if ( Trig_Ledgers_XP_Func001Func001C() ) then
            call AddHeroXPSwapped(3, udg_Ledger, true)
        else
        endif
    endif
endfunction

//===========================================================================
function InitTrig_Ledgers_XP takes nothing returns nothing
    set gg_trg_Ledgers_XP=CreateTrigger()
    call TriggerRegisterTimerEventPeriodic(gg_trg_Ledgers_XP, 1.00)
    call TriggerAddAction(gg_trg_Ledgers_XP, function Trig_Ledgers_XP_Actions)
endfunction

//===========================================================================
// Trigger: Ledger of Clarity pickup
//===========================================================================
function Trig_Ledger_of_Clarity_pickup_Conditions takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I01J' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Ledger_of_Clarity_pickup_Actions takes nothing returns nothing
    set udg_Ledger=GetManipulatingUnit()
    set udg_XPperSecond=( udg_XPperSecond + 3 )
endfunction

//===========================================================================
function InitTrig_Ledger_of_Clarity_pickup takes nothing returns nothing
    set gg_trg_Ledger_of_Clarity_pickup=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Ledger_of_Clarity_pickup, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddCondition(gg_trg_Ledger_of_Clarity_pickup, Condition(function Trig_Ledger_of_Clarity_pickup_Conditions))
    call TriggerAddAction(gg_trg_Ledger_of_Clarity_pickup, function Trig_Ledger_of_Clarity_pickup_Actions)
endfunction

//===========================================================================
// Trigger: Ledger of Clarity lose
//===========================================================================
function Trig_Ledger_of_Clarity_lose_Conditions takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I01J' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Ledger_of_Clarity_lose_Actions takes nothing returns nothing
    set udg_XPperSecond=( udg_XPperSecond - 3 )
endfunction

//===========================================================================
function InitTrig_Ledger_of_Clarity_lose takes nothing returns nothing
    set gg_trg_Ledger_of_Clarity_lose=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Ledger_of_Clarity_lose, EVENT_PLAYER_UNIT_DROP_ITEM)
    call TriggerAddCondition(gg_trg_Ledger_of_Clarity_lose, Condition(function Trig_Ledger_of_Clarity_lose_Conditions))
    call TriggerAddAction(gg_trg_Ledger_of_Clarity_lose, function Trig_Ledger_of_Clarity_lose_Actions)
endfunction

//===========================================================================
// Trigger: Ledger of Enlightment pickup
//===========================================================================
function Trig_Ledger_of_Enlightment_pickup_Conditions takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I01N' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Ledger_of_Enlightment_pickup_Actions takes nothing returns nothing
    set udg_Ledger=GetManipulatingUnit()
    set udg_XPperSecond=( udg_XPperSecond + 8 )
endfunction

//===========================================================================
function InitTrig_Ledger_of_Enlightment_pickup takes nothing returns nothing
    set gg_trg_Ledger_of_Enlightment_pickup=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Ledger_of_Enlightment_pickup, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddCondition(gg_trg_Ledger_of_Enlightment_pickup, Condition(function Trig_Ledger_of_Enlightment_pickup_Conditions))
    call TriggerAddAction(gg_trg_Ledger_of_Enlightment_pickup, function Trig_Ledger_of_Enlightment_pickup_Actions)
endfunction

//===========================================================================
// Trigger: Ledger of Enlightment lose
//===========================================================================
function Trig_Ledger_of_Enlightment_lose_Conditions takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I01N' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Ledger_of_Enlightment_lose_Actions takes nothing returns nothing
    set udg_XPperSecond=( udg_XPperSecond - 8 )
endfunction

//===========================================================================
function InitTrig_Ledger_of_Enlightment_lose takes nothing returns nothing
    set gg_trg_Ledger_of_Enlightment_lose=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Ledger_of_Enlightment_lose, EVENT_PLAYER_UNIT_DROP_ITEM)
    call TriggerAddCondition(gg_trg_Ledger_of_Enlightment_lose, Condition(function Trig_Ledger_of_Enlightment_lose_Conditions))
    call TriggerAddAction(gg_trg_Ledger_of_Enlightment_lose, function Trig_Ledger_of_Enlightment_lose_Actions)
endfunction

//===========================================================================
// Trigger: Spellcasters Cloak
//===========================================================================
function Trig_Spellcasters_Cloak_Conditions takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(GetTriggerUnit(), 'I00Z') == true ) ) then
        return false
    endif
    if ( not ( UnitHasItemOfTypeBJ(GetTriggerUnit(), 'I01B') == true ) ) then
        return false
    endif
    if ( not ( UnitHasItemOfTypeBJ(GetTriggerUnit(), 'I01U') == true ) ) then
        return false
    endif
    if ( not ( UnitHasItemOfTypeBJ(GetTriggerUnit(), 'I01Q') == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Spellcasters_Cloak_Actions takes nothing returns nothing
    call RemoveItem(GetItemOfTypeFromUnitBJ(GetTriggerUnit(), 'I00Z'))
    call RemoveItem(GetItemOfTypeFromUnitBJ(GetTriggerUnit(), 'I01B'))
    call RemoveItem(GetItemOfTypeFromUnitBJ(GetTriggerUnit(), 'I01U'))
    call RemoveItem(GetItemOfTypeFromUnitBJ(GetTriggerUnit(), 'I01Q'))
    call UnitAddItemByIdSwapped('I01R', GetTriggerUnit())
endfunction

//===========================================================================
function InitTrig_Spellcasters_Cloak takes nothing returns nothing
    set gg_trg_Spellcasters_Cloak=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Spellcasters_Cloak, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddCondition(gg_trg_Spellcasters_Cloak, Condition(function Trig_Spellcasters_Cloak_Conditions))
    call TriggerAddAction(gg_trg_Spellcasters_Cloak, function Trig_Spellcasters_Cloak_Actions)
endfunction

//===========================================================================
// Trigger: Ethereal Scepter
//===========================================================================
function Trig_Ethereal_Scepter_Conditions takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(GetTriggerUnit(), 'I00S') == true ) ) then
        return false
    endif
    if ( not ( UnitHasItemOfTypeBJ(GetTriggerUnit(), 'I01B') == true ) ) then
        return false
    endif
    if ( not ( UnitHasItemOfTypeBJ(GetTriggerUnit(), 'I01O') == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Ethereal_Scepter_Actions takes nothing returns nothing
    call RemoveItem(GetItemOfTypeFromUnitBJ(GetTriggerUnit(), 'I00S'))
    call RemoveItem(GetItemOfTypeFromUnitBJ(GetTriggerUnit(), 'I01B'))
    call RemoveItem(GetItemOfTypeFromUnitBJ(GetTriggerUnit(), 'I01O'))
    call UnitAddItemByIdSwapped('I01P', GetTriggerUnit())
endfunction

//===========================================================================
function InitTrig_Ethereal_Scepter takes nothing returns nothing
    set gg_trg_Ethereal_Scepter=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Ethereal_Scepter, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddCondition(gg_trg_Ethereal_Scepter, Condition(function Trig_Ethereal_Scepter_Conditions))
    call TriggerAddAction(gg_trg_Ethereal_Scepter, function Trig_Ethereal_Scepter_Actions)
endfunction

//===========================================================================
// Trigger: Firelords Cape
//===========================================================================
function Trig_Firelords_Cape_Conditions takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(GetTriggerUnit(), 'I00Z') == true ) ) then
        return false
    endif
    if ( not ( UnitHasItemOfTypeBJ(GetTriggerUnit(), 'I00I') == true ) ) then
        return false
    endif
    if ( not ( UnitHasItemOfTypeBJ(GetTriggerUnit(), 'I01S') == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Firelords_Cape_Actions takes nothing returns nothing
    call RemoveItem(GetItemOfTypeFromUnitBJ(GetTriggerUnit(), 'I00Z'))
    call RemoveItem(GetItemOfTypeFromUnitBJ(GetTriggerUnit(), 'I00I'))
    call RemoveItem(GetItemOfTypeFromUnitBJ(GetTriggerUnit(), 'I01S'))
    call UnitAddItemByIdSwapped('I01T', GetTriggerUnit())
endfunction

//===========================================================================
function InitTrig_Firelords_Cape takes nothing returns nothing
    set gg_trg_Firelords_Cape=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Firelords_Cape, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddCondition(gg_trg_Firelords_Cape, Condition(function Trig_Firelords_Cape_Conditions))
    call TriggerAddAction(gg_trg_Firelords_Cape, function Trig_Firelords_Cape_Actions)
endfunction

//===========================================================================
// Trigger: Ledget of Enlightment
//===========================================================================
function Trig_Ledget_of_Enlightment_Func002Func001C takes nothing returns boolean
    if ( not ( GetItemTypeId(UnitItemInSlotBJ(GetTriggerUnit(), GetForLoopIndexA())) == 'I01J' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Ledget_of_Enlightment_Actions takes nothing returns nothing
    local integer i= 0
    set bj_forLoopAIndex=1
    set bj_forLoopAIndexEnd=6
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        if ( Trig_Ledget_of_Enlightment_Func002Func001C() ) then
            set i=i + 1
        else
        endif
        set bj_forLoopAIndex=bj_forLoopAIndex + 1
    endloop
    if i == 2 then
    set bj_forLoopAIndex=1
    set bj_forLoopAIndexEnd=2
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        call RemoveItem(GetItemOfTypeFromUnitBJ(GetTriggerUnit(), 'I01J'))
        set bj_forLoopAIndex=bj_forLoopAIndex + 1
    endloop
    call UnitAddItemByIdSwapped('I01N', GetTriggerUnit())
    endif
endfunction

//===========================================================================
function InitTrig_Ledget_of_Enlightment takes nothing returns nothing
    set gg_trg_Ledget_of_Enlightment=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Ledget_of_Enlightment, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddAction(gg_trg_Ledget_of_Enlightment, function Trig_Ledget_of_Enlightment_Actions)
endfunction

//===========================================================================
// Trigger: Hammer of might
//===========================================================================
function Trig_Hammer_of_might_Conditions takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(GetTriggerUnit(), 'I006') == true ) ) then
        return false
    endif
    if ( not ( UnitHasItemOfTypeBJ(GetTriggerUnit(), 'I00F') == true ) ) then
        return false
    endif
    if ( not ( UnitHasItemOfTypeBJ(GetTriggerUnit(), 'I01M') == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Hammer_of_might_Actions takes nothing returns nothing
    call RemoveItem(GetItemOfTypeFromUnitBJ(GetTriggerUnit(), 'I00F'))
    call RemoveItem(GetItemOfTypeFromUnitBJ(GetTriggerUnit(), 'I006'))
    call RemoveItem(GetItemOfTypeFromUnitBJ(GetTriggerUnit(), 'I01M'))
    call UnitAddItemByIdSwapped('I01L', GetTriggerUnit())
endfunction

//===========================================================================
function InitTrig_Hammer_of_might takes nothing returns nothing
    set gg_trg_Hammer_of_might=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Hammer_of_might, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddCondition(gg_trg_Hammer_of_might, Condition(function Trig_Hammer_of_might_Conditions))
    call TriggerAddAction(gg_trg_Hammer_of_might, function Trig_Hammer_of_might_Actions)
endfunction

//===========================================================================
// Trigger: Valorous Helmet
//===========================================================================
function Trig_Valorous_Helmet_Conditions takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(GetTriggerUnit(), 'I00H') == true ) ) then
        return false
    endif
    if ( not ( UnitHasItemOfTypeBJ(GetTriggerUnit(), 'I001') == true ) ) then
        return false
    endif
    if ( not ( UnitHasItemOfTypeBJ(GetTriggerUnit(), 'I004') == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Valorous_Helmet_Actions takes nothing returns nothing
    call RemoveItem(GetItemOfTypeFromUnitBJ(GetTriggerUnit(), 'I00H'))
    call RemoveItem(GetItemOfTypeFromUnitBJ(GetTriggerUnit(), 'I004'))
    call RemoveItem(GetItemOfTypeFromUnitBJ(GetTriggerUnit(), 'I001'))
    call UnitAddItemByIdSwapped('I00I', GetTriggerUnit())
endfunction

//===========================================================================
function InitTrig_Valorous_Helmet takes nothing returns nothing
    set gg_trg_Valorous_Helmet=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Valorous_Helmet, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddCondition(gg_trg_Valorous_Helmet, Condition(function Trig_Valorous_Helmet_Conditions))
    call TriggerAddAction(gg_trg_Valorous_Helmet, function Trig_Valorous_Helmet_Actions)
endfunction

//===========================================================================
// Trigger: Bladed Gauntlet
//===========================================================================
function Trig_Bladed_Gauntlet_Conditions takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(GetTriggerUnit(), 'I00G') == true ) ) then
        return false
    endif
    if ( not ( UnitHasItemOfTypeBJ(GetTriggerUnit(), 'I006') == true ) ) then
        return false
    endif
    if ( not ( UnitHasItemOfTypeBJ(GetTriggerUnit(), 'I002') == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Bladed_Gauntlet_Actions takes nothing returns nothing
    call RemoveItem(GetItemOfTypeFromUnitBJ(GetTriggerUnit(), 'I006'))
    call RemoveItem(GetItemOfTypeFromUnitBJ(GetTriggerUnit(), 'I002'))
    call RemoveItem(GetItemOfTypeFromUnitBJ(GetTriggerUnit(), 'I00G'))
    call UnitAddItemByIdSwapped('I00F', GetTriggerUnit())
endfunction

//===========================================================================
function InitTrig_Bladed_Gauntlet takes nothing returns nothing
    set gg_trg_Bladed_Gauntlet=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Bladed_Gauntlet, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddCondition(gg_trg_Bladed_Gauntlet, Condition(function Trig_Bladed_Gauntlet_Conditions))
    call TriggerAddAction(gg_trg_Bladed_Gauntlet, function Trig_Bladed_Gauntlet_Actions)
endfunction

//===========================================================================
// Trigger: Righteous Armor
//===========================================================================
function Trig_Righteous_Armor_Conditions takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(GetTriggerUnit(), 'I011') == true ) ) then
        return false
    endif
    if ( not ( UnitHasItemOfTypeBJ(GetTriggerUnit(), 'I00I') == true ) ) then
        return false
    endif
    if ( not ( UnitHasItemOfTypeBJ(GetTriggerUnit(), 'I00Z') == true ) ) then
        return false
    endif
    if ( not ( UnitHasItemOfTypeBJ(GetTriggerUnit(), 'I004') == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Righteous_Armor_Actions takes nothing returns nothing
    call RemoveItem(GetItemOfTypeFromUnitBJ(GetTriggerUnit(), 'I011'))
    call RemoveItem(GetItemOfTypeFromUnitBJ(GetTriggerUnit(), 'I00I'))
    call RemoveItem(GetItemOfTypeFromUnitBJ(GetTriggerUnit(), 'I00Z'))
    call RemoveItem(GetItemOfTypeFromUnitBJ(GetTriggerUnit(), 'I004'))
    call UnitAddItemByIdSwapped('I012', GetTriggerUnit())
endfunction

//===========================================================================
function InitTrig_Righteous_Armor takes nothing returns nothing
    set gg_trg_Righteous_Armor=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Righteous_Armor, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddCondition(gg_trg_Righteous_Armor, Condition(function Trig_Righteous_Armor_Conditions))
    call TriggerAddAction(gg_trg_Righteous_Armor, function Trig_Righteous_Armor_Actions)
endfunction

//===========================================================================
// Trigger: Arcanum of Hatred
//===========================================================================
function Trig_Arcanum_of_Hatred_Conditions takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(GetTriggerUnit(), 'I016') == true ) ) then
        return false
    endif
    if ( not ( UnitHasItemOfTypeBJ(GetTriggerUnit(), 'I00Z') == true ) ) then
        return false
    endif
    if ( not ( UnitHasItemOfTypeBJ(GetTriggerUnit(), 'I02F') == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Arcanum_of_Hatred_Actions takes nothing returns nothing
    call RemoveItem(GetItemOfTypeFromUnitBJ(GetTriggerUnit(), 'I016'))
    call RemoveItem(GetItemOfTypeFromUnitBJ(GetTriggerUnit(), 'I00Z'))
    call RemoveItem(GetItemOfTypeFromUnitBJ(GetTriggerUnit(), 'I02F'))
    call UnitAddItemByIdSwapped('I015', GetTriggerUnit())
endfunction

//===========================================================================
function InitTrig_Arcanum_of_Hatred takes nothing returns nothing
    set gg_trg_Arcanum_of_Hatred=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Arcanum_of_Hatred, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddCondition(gg_trg_Arcanum_of_Hatred, Condition(function Trig_Arcanum_of_Hatred_Conditions))
    call TriggerAddAction(gg_trg_Arcanum_of_Hatred, function Trig_Arcanum_of_Hatred_Actions)
endfunction

//===========================================================================
// Trigger: Bleeding Scythe
//===========================================================================
function Trig_Bleeding_Scythe_Conditions takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(GetTriggerUnit(), 'I018') == true ) ) then
        return false
    endif
    if ( not ( UnitHasItemOfTypeBJ(GetTriggerUnit(), 'I002') == true ) ) then
        return false
    endif
    if ( not ( UnitHasItemOfTypeBJ(GetTriggerUnit(), 'I02F') == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Bleeding_Scythe_Actions takes nothing returns nothing
    call RemoveItem(GetItemOfTypeFromUnitBJ(GetTriggerUnit(), 'I018'))
    call RemoveItem(GetItemOfTypeFromUnitBJ(GetTriggerUnit(), 'I002'))
    call RemoveItem(GetItemOfTypeFromUnitBJ(GetTriggerUnit(), 'I02F'))
    call UnitAddItemByIdSwapped('I017', GetTriggerUnit())
endfunction

//===========================================================================
function InitTrig_Bleeding_Scythe takes nothing returns nothing
    set gg_trg_Bleeding_Scythe=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Bleeding_Scythe, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddCondition(gg_trg_Bleeding_Scythe, Condition(function Trig_Bleeding_Scythe_Conditions))
    call TriggerAddAction(gg_trg_Bleeding_Scythe, function Trig_Bleeding_Scythe_Actions)
endfunction

//===========================================================================
// Trigger: Staff of Insight
//===========================================================================
function Trig_Staff_of_Insight_Conditions takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(GetTriggerUnit(), 'I01D') == true ) ) then
        return false
    endif
    if ( not ( UnitHasItemOfTypeBJ(GetTriggerUnit(), 'I00I') == true ) ) then
        return false
    endif
    if ( not ( UnitHasItemOfTypeBJ(GetTriggerUnit(), 'I01B') == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Staff_of_Insight_Actions takes nothing returns nothing
    call RemoveItem(GetItemOfTypeFromUnitBJ(GetTriggerUnit(), 'I01B'))
    call RemoveItem(GetItemOfTypeFromUnitBJ(GetTriggerUnit(), 'I01D'))
    call RemoveItem(GetItemOfTypeFromUnitBJ(GetTriggerUnit(), 'I00I'))
    call UnitAddItemByIdSwapped('I01C', GetTriggerUnit())
endfunction

//===========================================================================
function InitTrig_Staff_of_Insight takes nothing returns nothing
    set gg_trg_Staff_of_Insight=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Staff_of_Insight, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddCondition(gg_trg_Staff_of_Insight, Condition(function Trig_Staff_of_Insight_Conditions))
    call TriggerAddAction(gg_trg_Staff_of_Insight, function Trig_Staff_of_Insight_Actions)
endfunction

//===========================================================================
// Trigger: Cosmic Orb
//===========================================================================
function Trig_Cosmic_Orb_Conditions takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(GetTriggerUnit(), 'I000') == true ) ) then
        return false
    endif
    if ( not ( UnitHasItemOfTypeBJ(GetTriggerUnit(), 'I01A') == true ) ) then
        return false
    endif
    if ( not ( UnitHasItemOfTypeBJ(GetTriggerUnit(), 'I01B') == true ) ) then
        return false
    endif
    if ( not ( UnitHasItemOfTypeBJ(GetTriggerUnit(), 'I00S') == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Cosmic_Orb_Actions takes nothing returns nothing
    call RemoveItem(GetItemOfTypeFromUnitBJ(GetTriggerUnit(), 'I000'))
    call RemoveItem(GetItemOfTypeFromUnitBJ(GetTriggerUnit(), 'I01A'))
    call RemoveItem(GetItemOfTypeFromUnitBJ(GetTriggerUnit(), 'I01B'))
    call RemoveItem(GetItemOfTypeFromUnitBJ(GetTriggerUnit(), 'I00S'))
    call UnitAddItemByIdSwapped('I019', GetTriggerUnit())
endfunction

//===========================================================================
function InitTrig_Cosmic_Orb takes nothing returns nothing
    set gg_trg_Cosmic_Orb=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Cosmic_Orb, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddCondition(gg_trg_Cosmic_Orb, Condition(function Trig_Cosmic_Orb_Conditions))
    call TriggerAddAction(gg_trg_Cosmic_Orb, function Trig_Cosmic_Orb_Actions)
endfunction

//===========================================================================
// Trigger: Level up
//===========================================================================
function Trig_Level_up_Conditions takes nothing returns boolean
    if ( not ( GetOwningPlayer(GetTriggerUnit()) == Player(6) ) ) then
        return false
    endif
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I00J' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Level_up_Actions takes nothing returns nothing
    call RemoveItem(GetManipulatedItem())
    call UnitAddItemByIdSwapped('tkno', GetTriggerUnit())
endfunction

//===========================================================================
function InitTrig_Level_up takes nothing returns nothing
    set gg_trg_Level_up=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Level_up, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddCondition(gg_trg_Level_up, Condition(function Trig_Level_up_Conditions))
    call TriggerAddAction(gg_trg_Level_up, function Trig_Level_up_Actions)
endfunction

//===========================================================================
// Trigger: Deliver Gold
//===========================================================================
function Trig_Deliver_Gold_Actions takes nothing returns nothing
    call AdjustPlayerStateBJ(1, Player(0), PLAYER_STATE_RESOURCE_GOLD)
    call AdjustPlayerStateBJ(1, Player(1), PLAYER_STATE_RESOURCE_GOLD)
    call AdjustPlayerStateBJ(1, Player(2), PLAYER_STATE_RESOURCE_GOLD)
    call AdjustPlayerStateBJ(1, Player(3), PLAYER_STATE_RESOURCE_GOLD)
    call AdjustPlayerStateBJ(1, Player(4), PLAYER_STATE_RESOURCE_GOLD)
    call AdjustPlayerStateBJ(1, Player(5), PLAYER_STATE_RESOURCE_GOLD)
    call AdjustPlayerStateBJ(1040, Player(6), PLAYER_STATE_RESOURCE_GOLD)
    call AdjustPlayerStateBJ(1, Player(7), PLAYER_STATE_RESOURCE_GOLD)
    call AdjustPlayerStateBJ(1, Player(8), PLAYER_STATE_RESOURCE_GOLD)
    call AdjustPlayerStateBJ(1, Player(9), PLAYER_STATE_RESOURCE_GOLD)
    call AdjustPlayerStateBJ(1, Player(10), PLAYER_STATE_RESOURCE_GOLD)
endfunction

//===========================================================================
function InitTrig_Deliver_Gold takes nothing returns nothing
    set gg_trg_Deliver_Gold=CreateTrigger()
    call TriggerAddAction(gg_trg_Deliver_Gold, function Trig_Deliver_Gold_Actions)
endfunction

//===========================================================================
// Trigger: Worgens gold
//===========================================================================
function Trig_Worgens_gold_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_DamageEventTarget) == 'h00Q' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Worgens_gold_Func004C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_DamageEventSource) == 'h00R' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Worgens_gold_Actions takes nothing returns nothing
    call AdjustPlayerStateBJ(1, GetOwningPlayer(GetEventDamageSource()), PLAYER_STATE_RESOURCE_GOLD)
    call AddSpecialEffectLocBJ(GetUnitLoc(gg_unit_h00Q_0026), "UI\\Feedback\\GoldCredit\\GoldCredit.mdl")
    call DestroyEffectBJ(GetLastCreatedEffectBJ())
    if ( Trig_Worgens_gold_Func004C() ) then
        call AdjustPlayerStateBJ(1, GetOwningPlayer(GetEventDamageSource()), PLAYER_STATE_RESOURCE_GOLD)
    else
    endif
endfunction

//===========================================================================
function InitTrig_Worgens_gold takes nothing returns nothing
    set gg_trg_Worgens_gold=CreateTrigger()
    call h__TriggerRegisterVariableEvent(gg_trg_Worgens_gold, "udg_DamageEvent", EQUAL, 1.00)
    call TriggerAddCondition(gg_trg_Worgens_gold, Condition(function Trig_Worgens_gold_Conditions))
    call TriggerAddAction(gg_trg_Worgens_gold, function Trig_Worgens_gold_Actions)
endfunction

//===========================================================================
// Trigger: Bounty
//===========================================================================
function Trig_Bounty_Func001A takes nothing returns nothing
    call SetPlayerFlagBJ(PLAYER_STATE_GIVES_BOUNTY, true, Player(0))
    call SetPlayerFlagBJ(PLAYER_STATE_GIVES_BOUNTY, true, Player(1))
    call SetPlayerFlagBJ(PLAYER_STATE_GIVES_BOUNTY, true, Player(2))
    call SetPlayerFlagBJ(PLAYER_STATE_GIVES_BOUNTY, true, Player(3))
    call SetPlayerFlagBJ(PLAYER_STATE_GIVES_BOUNTY, true, Player(4))
    call SetPlayerFlagBJ(PLAYER_STATE_GIVES_BOUNTY, true, Player(5))
    call SetPlayerFlagBJ(PLAYER_STATE_GIVES_BOUNTY, true, Player(6))
    call SetPlayerFlagBJ(PLAYER_STATE_GIVES_BOUNTY, true, Player(7))
    call SetPlayerFlagBJ(PLAYER_STATE_GIVES_BOUNTY, true, Player(8))
    call SetPlayerFlagBJ(PLAYER_STATE_GIVES_BOUNTY, true, Player(9))
    call SetPlayerFlagBJ(PLAYER_STATE_GIVES_BOUNTY, true, Player(10))
endfunction

function Trig_Bounty_Actions takes nothing returns nothing
    call ForForce(GetPlayersAll(), function Trig_Bounty_Func001A)
endfunction

//===========================================================================
function InitTrig_Bounty takes nothing returns nothing
    set gg_trg_Bounty=CreateTrigger()
    call TriggerAddAction(gg_trg_Bounty, function Trig_Bounty_Actions)
endfunction

//===========================================================================
// Trigger: Remove Ancient Lumber
//===========================================================================
function Trig_Remove_Ancient_Lumber_Conditions takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I01F' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Remove_Ancient_Lumber_Actions takes nothing returns nothing
    call SetPlayerStateBJ(Player(6), PLAYER_STATE_RESOURCE_LUMBER, ( GetPlayerState(Player(6), PLAYER_STATE_RESOURCE_LUMBER) - 500 ))
endfunction

//===========================================================================
function InitTrig_Remove_Ancient_Lumber takes nothing returns nothing
    set gg_trg_Remove_Ancient_Lumber=CreateTrigger()
    call TriggerRegisterPlayerUnitEventSimple(gg_trg_Remove_Ancient_Lumber, Player(6), EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddCondition(gg_trg_Remove_Ancient_Lumber, Condition(function Trig_Remove_Ancient_Lumber_Conditions))
    call TriggerAddAction(gg_trg_Remove_Ancient_Lumber, function Trig_Remove_Ancient_Lumber_Actions)
endfunction

//===========================================================================
// Trigger: Ancient Gold income
//===========================================================================
function Trig_Ancient_Gold_income_Actions takes nothing returns nothing
    call AdjustPlayerStateBJ(10, Player(6), PLAYER_STATE_RESOURCE_GOLD)
endfunction

//===========================================================================
function InitTrig_Ancient_Gold_income takes nothing returns nothing
    set gg_trg_Ancient_Gold_income=CreateTrigger()
    call TriggerRegisterTimerEventPeriodic(gg_trg_Ancient_Gold_income, 10.00)
    call TriggerAddAction(gg_trg_Ancient_Gold_income, function Trig_Ancient_Gold_income_Actions)
endfunction

//===========================================================================
// Trigger: Initialization
//===========================================================================
function Trig_Initialization_Func002002 takes nothing returns nothing
    call SetCameraBoundsToRectForPlayerBJ(GetEnumPlayer(), gg_rct_Camera_1)
endfunction

function Trig_Initialization_Actions takes nothing returns nothing
    call SetCreepCampFilterState(false)
    call ForForce(GetPlayersAll(), function Trig_Initialization_Func002002)
endfunction

//===========================================================================
function InitTrig_Initialization takes nothing returns nothing
    set gg_trg_Initialization=CreateTrigger()
    call TriggerAddAction(gg_trg_Initialization, function Trig_Initialization_Actions)
endfunction

//===========================================================================
// Trigger: LimitedTraining
//===========================================================================
function Trig_LimitedTraining_Func002A takes nothing returns nothing
    call SetPlayerTechMaxAllowedSwap('h03A', 1, GetEnumPlayer())
    call SetPlayerTechMaxAllowedSwap('u00E', 1, GetEnumPlayer())
    call SetPlayerTechMaxAllowedSwap('n006', 1, GetEnumPlayer())
    call SetPlayerTechMaxAllowedSwap('n007', 1, GetEnumPlayer())
    call SetPlayerTechMaxAllowedSwap('h05L', 1, GetEnumPlayer())
    call SetPlayerTechMaxAllowedSwap('E00T', 1, GetEnumPlayer())
    call SetPlayerTechMaxAllowedSwap('n00S', 1, GetEnumPlayer())
endfunction

function Trig_LimitedTraining_Actions takes nothing returns nothing
    call MeleeStartingHeroLimit()
    call ForForce(GetPlayersAll(), function Trig_LimitedTraining_Func002A)
endfunction

//===========================================================================
function InitTrig_LimitedTraining takes nothing returns nothing
    set gg_trg_LimitedTraining=CreateTrigger()
    call TriggerAddAction(gg_trg_LimitedTraining, function Trig_LimitedTraining_Actions)
endfunction

//===========================================================================
// Trigger: TimeToExpanderSpawn
//===========================================================================
function Trig_TimeToExpanderSpawn_Actions takes nothing returns nothing
    call StartTimerBJ(udg_ExpanderSpawnTimer, false, 19.00)
    call CreateTimerDialogBJ(GetLastCreatedTimerBJ(), "TRIGSTR_7401")
    call TriggerSleepAction(18.00)
    call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
endfunction

//===========================================================================
function InitTrig_TimeToExpanderSpawn takes nothing returns nothing
    set gg_trg_TimeToExpanderSpawn=CreateTrigger()
    call TriggerRegisterTimerEventSingle(gg_trg_TimeToExpanderSpawn, 1.00)
    call TriggerAddAction(gg_trg_TimeToExpanderSpawn, function Trig_TimeToExpanderSpawn_Actions)
endfunction

//===========================================================================
// Trigger: TimeToAncientSpawn
//===========================================================================
function Trig_TimeToAncientSpawn_Actions takes nothing returns nothing
    call StartTimerBJ(udg_AncientSpawnTimer, false, 40.00)
    call CreateTimerDialogBJ(GetLastCreatedTimerBJ(), "TRIGSTR_7400")
    call TriggerSleepAction(40.00)
    call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
endfunction

//===========================================================================
function InitTrig_TimeToAncientSpawn takes nothing returns nothing
    set gg_trg_TimeToAncientSpawn=CreateTrigger()
    call TriggerRegisterTimerEventSingle(gg_trg_TimeToAncientSpawn, 20.00)
    call TriggerAddAction(gg_trg_TimeToAncientSpawn, function Trig_TimeToAncientSpawn_Actions)
endfunction

//===========================================================================
// Trigger: Unit Indexer
//
// This trigger works in two key phases:
// 1) During map initialization, enumerate all units of all players to give them an index.
// 2) Adds a second event to itself to index new units as they enter the map.
// As a unit enters the map, check for any old units that may have been removed at some point in order to free their index.
//===========================================================================
function Trig_Unit_Indexer_Func017Func004C takes nothing returns boolean
    if ( not ( udg_UDexRecycle == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Unit_Indexer_Func017C takes nothing returns boolean
    if ( not ( udg_UnitIndexerEnabled == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Unit_Indexer_Func030Func005C takes nothing returns boolean
    if ( not ( GetUnitUserData(udg_UDexUnits[udg_UDex]) == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Unit_Indexer_Func030C takes nothing returns boolean
    if ( not ( udg_UDexWasted == 15 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Unit_Indexer_Func034C takes nothing returns boolean
    if ( not ( GetUnitUserData(GetFilterUnit()) == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Unit_Indexer_Actions takes nothing returns nothing
        call ExecuteFunc("InitializeUnitIndexer")
    endfunction
    //  
    // This is the most important function - it provides an index for units as they enter the map
    //  
    function IndexUnit takes nothing returns boolean
        local integer pdex= udg_UDex
    //  
    // You can use the boolean UnitIndexerEnabled to protect some of your undesirable units from being indexed
    // - Example:
    // -- Set UnitIndexerEnabled = False
    // -- Unit - Create 1 Dummy for (Triggering player) at TempLoc facing 0.00 degrees
    // -- Set UnitIndexerEnabled = True
    //  
    // You can also customize the following block - if conditions are false the (Matching unit) won't be indexed.
    //  
    if ( Trig_Unit_Indexer_Func017C() ) then
        //  
        // Generate a unique integer index for this unit
        //  
        if ( Trig_Unit_Indexer_Func017Func004C() ) then
            set udg_UDex=( udg_UDexGen + 1 )
            set udg_UDexGen=udg_UDex
        else
            set udg_UDex=udg_UDexRecycle
            set udg_UDexRecycle=udg_UDexNext[udg_UDex]
        endif
        //  
        // Link index to unit, unit to index
        //  
        set udg_UDexUnits[udg_UDex]=GetFilterUnit()
        call SetUnitUserData(udg_UDexUnits[udg_UDex], udg_UDex)
        //  
        // Use a doubly-linked list to store all active indexes
        //  
        set udg_UDexPrev[udg_UDexNext[0]]=udg_UDex
        set udg_UDexNext[udg_UDex]=udg_UDexNext[0]
        set udg_UDexNext[0]=udg_UDex
        //  
        // Fire index event for UDex
        //  
        set udg_UnitIndexEvent=0.00
        set udg_UnitIndexEvent=1.00
        set udg_UnitIndexEvent=0.00
        set udg_UDex=pdex
    else
    endif
        return false
    endfunction
    //  
    // The next function is called each time a unit enters the map
    //  
    function IndexNewUnit takes nothing returns boolean
        local integer pdex= udg_UDex
        local integer ndex
    //  
    // Recycle indices of units no longer in-play every (15) units created
    //  
    set udg_UDexWasted=( udg_UDexWasted + 1 )
    if ( Trig_Unit_Indexer_Func030C() ) then
        set udg_UDexWasted=0
        set udg_UDex=udg_UDexNext[0]
        loop
            exitwhen udg_UDex == 0
        if ( Trig_Unit_Indexer_Func030Func005C() ) then
            //  
            // Remove index from linked list
            //  
            set ndex=udg_UDexNext[udg_UDex]
            set udg_UDexNext[udg_UDexPrev[udg_UDex]]=ndex
            set udg_UDexPrev[ndex]=udg_UDexPrev[udg_UDex]
            set udg_UDexPrev[udg_UDex]=0
            //  
            // Fire deindex event for UDex
            //  
            set udg_UnitIndexEvent=2.00
            set udg_UnitIndexEvent=0.00
            //  
            // Recycle the index for later use
            //  
            set udg_UDexUnits[udg_UDex]=null
            set udg_UDexNext[udg_UDex]=udg_UDexRecycle
            set udg_UDexRecycle=udg_UDex
            set udg_UDex=ndex
        else
            set udg_UDex=udg_UDexNext[udg_UDex]
        endif
        endloop
        set udg_UDex=pdex
    else
    endif
    //  
    // Handle the entering unit (Matching unit)
    //  
    if ( Trig_Unit_Indexer_Func034C() ) then
        call IndexUnit()
    else
    endif
        return false
    endfunction
    //  
    // The next function initializes the core of the system
    //  
    function InitializeUnitIndexer takes nothing returns nothing
        local integer i= 0
        local region re= CreateRegion()
        local rect r= GetWorldBounds()
    set udg_UnitIndexerEnabled=true
        call RegionAddRect(re, r)
        call TriggerRegisterEnterRegion(CreateTrigger(), re, Filter(function IndexNewUnit))
        call RemoveRect(r)
        set re=null
        set r=null
        loop
            call GroupEnumUnitsOfPlayer(bj_lastCreatedGroup, Player(i), Filter(function IndexUnit))
            set i=i + 1
            exitwhen i == 16
        endloop
    //  
    // This is the "Unit Indexer Initialized" event, use it instead of "Map Initialization" for best results
    //  
    set udg_UnitIndexEvent=3.00
    set udg_UnitIndexEvent=0.00
endfunction

//===========================================================================
function InitTrig_Unit_Indexer takes nothing returns nothing
    set gg_trg_Unit_Indexer=CreateTrigger()
    call TriggerAddAction(gg_trg_Unit_Indexer, function Trig_Unit_Indexer_Actions)
endfunction

//===========================================================================
// Trigger: Spellbringers spells
//===========================================================================
function Trig_Spellbringers_spells_Func001C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetSoldUnit()) == 'O01D' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Spellbringers_spells_Func002C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetSoldUnit()) == 'O00A' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Spellbringers_spells_Func003C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetSoldUnit()) == 'O00S' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Spellbringers_spells_Func004C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetSoldUnit()) == 'O00L' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Spellbringers_spells_Func005C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetSoldUnit()) == 'O004' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Spellbringers_spells_Func006C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetSoldUnit()) == 'O008' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Spellbringers_spells_Func007C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetSoldUnit()) == 'O01V' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Spellbringers_spells_Func008C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetSoldUnit()) == 'O016' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Spellbringers_spells_Func009C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetSoldUnit()) == 'O00D' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Spellbringers_spells_Func010C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetSoldUnit()) == 'O01X' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Spellbringers_spells_Func011C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetSoldUnit()) == 'O01Z' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Spellbringers_spells_Actions takes nothing returns nothing
    if ( Trig_Spellbringers_spells_Func001C() ) then
        call UnitAddAbilityBJ('A0EM', gg_unit_n00B_0266)
    else
    endif
    if ( Trig_Spellbringers_spells_Func002C() ) then
        call UnitAddAbilityBJ('A0EN', gg_unit_n00B_0266)
    else
    endif
    if ( Trig_Spellbringers_spells_Func003C() ) then
        call UnitAddAbilityBJ('A0B4', gg_unit_n00B_0266)
    else
    endif
    if ( Trig_Spellbringers_spells_Func004C() ) then
        call UnitAddAbilityBJ('A0B5', gg_unit_n00B_0266)
    else
    endif
    if ( Trig_Spellbringers_spells_Func005C() ) then
        call UnitAddAbilityBJ('A0B3', gg_unit_n00B_0266)
    else
    endif
    if ( Trig_Spellbringers_spells_Func006C() ) then
        call UnitAddAbilityBJ('A0AZ', gg_unit_n00B_0266)
    else
    endif
    if ( Trig_Spellbringers_spells_Func007C() ) then
        call UnitAddAbilityBJ('A0FB', gg_unit_n00B_0266)
    else
    endif
    if ( Trig_Spellbringers_spells_Func008C() ) then
        call UnitAddAbilityBJ('A0B1', gg_unit_n00B_0266)
    else
    endif
    if ( Trig_Spellbringers_spells_Func009C() ) then
        call UnitAddAbilityBJ('A0AY', gg_unit_n00B_0266)
    else
    endif
    if ( Trig_Spellbringers_spells_Func010C() ) then
        call UnitAddAbilityBJ('A0B2', gg_unit_n00B_0266)
    else
    endif
    if ( Trig_Spellbringers_spells_Func011C() ) then
        call UnitAddAbilityBJ('A0AL', gg_unit_n00B_0266)
    else
    endif
endfunction

//===========================================================================
function InitTrig_Spellbringers_spells takes nothing returns nothing
    set gg_trg_Spellbringers_spells=CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Spellbringers_spells, gg_unit_nmr2_0001, EVENT_UNIT_SELL)
    call TriggerAddAction(gg_trg_Spellbringers_spells, function Trig_Spellbringers_spells_Actions)
endfunction

//===========================================================================
// Trigger: Give orb
//===========================================================================
function Trig_Give_orb_Actions takes nothing returns nothing
    call CreateItemLoc('I000', GetRectCenter(GetPlayableMapRect()))
    call UnitAddItemSwapped(GetLastCreatedItem(), GetSoldUnit())
endfunction

//===========================================================================
function InitTrig_Give_orb takes nothing returns nothing
    set gg_trg_Give_orb=CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Give_orb, gg_unit_nmr2_0001, EVENT_UNIT_SELL)
    call TriggerAddAction(gg_trg_Give_orb, function Trig_Give_orb_Actions)
endfunction

//===========================================================================
// Trigger: Colors
//===========================================================================
function Trig_Colors_Actions takes nothing returns nothing
    set udg_PlayerColorHex[1]=" - |cffff0303"
    set udg_PlayerColorHex[2]=" - |cff0042ff"
    set udg_PlayerColorHex[3]=" - |cff1ce6b9"
    set udg_PlayerColorHex[4]=" - |cff540081"
    set udg_PlayerColorHex[5]=" - |cfffffc01"
    set udg_PlayerColorHex[6]=" - |cfffe8a0e"
    set udg_PlayerColorHex[7]=" - |cff20c000"
    set udg_PlayerColorHex[8]=" - |cffe55bb0"
    set udg_PlayerColorHex[9]=" - |cff959697"
    set udg_PlayerColorHex[10]=" - |cff7ebff1"
    set udg_PlayerColorHex[11]=" - |cff106246"
    set udg_PlayerColorHex[12]=" - |cff4e2a04"
endfunction

//===========================================================================
function InitTrig_Colors takes nothing returns nothing
    set gg_trg_Colors=CreateTrigger()
    call TriggerAddAction(gg_trg_Colors, function Trig_Colors_Actions)
endfunction

//===========================================================================
// Trigger: Name Change
//===========================================================================
function Trig_Name_Change_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'nmer' or GetUnitTypeId(GetTriggerUnit()) == 'n00G' ) ) then
        return false
    endif
    return true
endfunction

function GetPlayerNameWithoutTag takes player p returns string
    local string fullName= GetPlayerName(p)
    local string result= ""
    local integer i= 0
    local integer length= StringLength(fullName)
    
    loop
        exitwhen i >= length // Stop if we've checked all characters
        if ( SubString(fullName, i, i + 1) == "#" ) then
            return result // Return everything before '#'
        endif
        set result=result + SubString(fullName, i, i + 1) // Append current character
        set i=i + 1
    endloop
    
    return result // Return full name if no '#' was found
endfunction

function Trig_Name_Change_Actions takes nothing returns nothing
    call DisplayTextToForce(GetPlayersAll(), ( GetPlayerName(GetOwningPlayer(GetSoldUnit())) + ( " has selected " + GetUnitName(GetSoldUnit()) ) ))
    call SetPlayerName(GetOwningPlayer(GetSoldUnit()), ( GetUnitName(GetSoldUnit()) + ( udg_PlayerColorHex[GetConvertedPlayerId(GetOwningPlayer(GetSoldUnit()))] + GetPlayerNameWithoutTag(GetOwningPlayer(GetSoldUnit())) ) ))
endfunction

//===========================================================================
function InitTrig_Name_Change takes nothing returns nothing
    set gg_trg_Name_Change=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Name_Change, EVENT_PLAYER_UNIT_SELL)
    call TriggerAddCondition(gg_trg_Name_Change, Condition(function Trig_Name_Change_Conditions))
    call TriggerAddAction(gg_trg_Name_Change, function Trig_Name_Change_Actions)
endfunction


//===========================================================================
// Trigger: Name Change III
//===========================================================================
function Trig_Name_Change_III_Actions takes nothing returns nothing
    call SetPlayerName(Player(6), ( "Ancient " + ( udg_PlayerColorHex[7] + GetPlayerName(Player(6)) ) ))
endfunction

//===========================================================================
function InitTrig_Name_Change_III takes nothing returns nothing
    set gg_trg_Name_Change_III=CreateTrigger()
    call TriggerRegisterTimerEventSingle(gg_trg_Name_Change_III, 10.00)
    call TriggerAddAction(gg_trg_Name_Change_III, function Trig_Name_Change_III_Actions)
endfunction

//===========================================================================
// Trigger: RandomExpander
//===========================================================================
function Trig_RandomExpander_Actions takes nothing returns nothing
    set udg_Units[1]='h03D'
    set udg_Units[2]='h016'
    set udg_Units[3]='h02L'
    set udg_Units[4]='h01X'
    set udg_Units[5]='h00F'
    set udg_Units[6]='h01K'
    set udg_Units[7]='h00R'
    set udg_Units[8]='h02U'
    set udg_Units[9]='o005'
    set udg_Units[10]='o000'
    set udg_Units[11]='h000'
    set udg_Units[12]='h03Q'
    set udg_Units[13]='o01E'
    set udg_Units[14]='u007'
    set udg_Units[15]='h010'
    set udg_Units[16]='h05C'
    set udg_Units[17]='n00M'
    set udg_Units[18]='o026'
endfunction

//===========================================================================
function InitTrig_RandomExpander takes nothing returns nothing
    set gg_trg_RandomExpander=CreateTrigger()
    call TriggerAddAction(gg_trg_RandomExpander, function Trig_RandomExpander_Actions)
endfunction

//===========================================================================
// Trigger: RandomExpander2
//===========================================================================
function Trig_RandomExpander2_Conditions takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I00W' ) ) then
        return false
    endif
    return true
endfunction

function Trig_RandomExpander2_Actions takes nothing returns nothing
    set udg_Point1=GetUnitLoc(GetTriggerUnit())
    call CreateNUnitsAtLocFacingLocBJ(1, udg_Units[GetRandomInt(1, 18)], GetOwningPlayer(GetTriggerUnit()), GetRectCenter(gg_rct_Tele_out_E), GetRectCenter(gg_rct_Tele_out_E))
    call RemoveLocation(udg_Point1)
    call RemoveItem(GetManipulatedItem())
    call DisplayTextToForce(GetPlayersAll(), ( GetPlayerName(GetTriggerPlayer()) + " has randomed." ))
    call SetPlayerName(GetOwningPlayer(GetTriggerUnit()), ( GetUnitName(GetLastCreatedUnit()) + ( udg_PlayerColorHex[GetConvertedPlayerId(GetOwningPlayer(GetLastCreatedUnit()))] + GetPlayerNameWithoutTag(GetOwningPlayer(GetLastCreatedUnit())) ) ))
    call KillUnit(GetTriggerUnit())
endfunction

//===========================================================================
function InitTrig_RandomExpander2 takes nothing returns nothing
    set gg_trg_RandomExpander2=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_RandomExpander2, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddCondition(gg_trg_RandomExpander2, Condition(function Trig_RandomExpander2_Conditions))
    call TriggerAddAction(gg_trg_RandomExpander2, function Trig_RandomExpander2_Actions)
endfunction


//===========================================================================
// Trigger: Random Ancient
//===========================================================================
function Trig_Random_Ancient_Conditions takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I00X' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Random_Ancient_Func041002 takes nothing returns nothing
    call RemoveUnit(GetEnumUnit())
endfunction

function Trig_Random_Ancient_Func044C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetLastCreatedUnit()) == 'O01D' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Random_Ancient_Func045C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetLastCreatedUnit()) == 'O00A' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Random_Ancient_Func046C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetLastCreatedUnit()) == 'O00S' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Random_Ancient_Func047C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetLastCreatedUnit()) == 'O00L' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Random_Ancient_Func048C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetLastCreatedUnit()) == 'O004' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Random_Ancient_Func049C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetLastCreatedUnit()) == 'O008' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Random_Ancient_Func050C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetLastCreatedUnit()) == 'O01V' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Random_Ancient_Func051C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetLastCreatedUnit()) == 'O016' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Random_Ancient_Func052C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetLastCreatedUnit()) == 'O00D' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Random_Ancient_Func053C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetLastCreatedUnit()) == 'O01X' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Random_Ancient_Func054C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetLastCreatedUnit()) == 'O01Z' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Random_Ancient_Actions takes nothing returns nothing
    set udg_Ancients[1]='O004'
    set udg_Ancients[2]='O004'
    set udg_Ancients[3]='O004'
    set udg_Ancients[4]='O00A'
    set udg_Ancients[5]='O00A'
    set udg_Ancients[6]='O00A'
    set udg_Ancients[7]='O00S'
    set udg_Ancients[8]='O00S'
    set udg_Ancients[9]='O00S'
    set udg_Ancients[10]='O00L'
    set udg_Ancients[11]='O00L'
    set udg_Ancients[12]='O00L'
    set udg_Ancients[13]='O008'
    set udg_Ancients[14]='O008'
    set udg_Ancients[15]='O008'
    set udg_Ancients[16]='O00D'
    set udg_Ancients[17]='O00D'
    set udg_Ancients[18]='O00D'
    set udg_Ancients[19]='O016'
    set udg_Ancients[20]='O016'
    set udg_Ancients[21]='O016'
    set udg_Ancients[22]='O01D'
    set udg_Ancients[23]='O01D'
    set udg_Ancients[24]='O01D'
    set udg_Ancients[25]='O01V'
    set udg_Ancients[26]='O01V'
    set udg_Ancients[27]='O01V'
    set udg_Ancients[28]='O01Z'
    set udg_Ancients[29]='O01Z'
    set udg_Ancients[30]='O01Z'
    set udg_Ancients[31]='O01X'
    set udg_Ancients[32]='O01X'
    set udg_Ancients[33]='O01X'
    set udg_Point1=GetUnitLoc(GetTriggerUnit())
    call CreateNUnitsAtLocFacingLocBJ(1, udg_Ancients[GetRandomInt(1, 33)], GetOwningPlayer(GetTriggerUnit()), GetRectCenter(gg_rct_Tele_out_D), GetRectCenter(gg_rct_Tele_out_E))
    set udg_AncientUnit=GetLastCreatedUnit()
    call RemoveLocation(udg_Point1)
    call RemoveItem(GetManipulatedItem())
    call DisplayTextToForce(GetPlayersAll(), ( GetPlayerName(GetTriggerPlayer()) + " has randomed." ))
    call KillUnit(GetTriggerUnit())
    call ForGroupBJ(GetUnitsInRectAll(gg_rct_SpawnDefender), function Trig_Random_Ancient_Func041002)
    call CreateItemLoc('I000', GetRectCenter(GetPlayableMapRect()))
    call UnitAddItemSwapped(GetLastCreatedItem(), GetLastCreatedUnit())
    if ( Trig_Random_Ancient_Func044C() ) then
        call UnitAddAbilityBJ('A0EM', gg_unit_n00B_0266)
    else
    endif
    if ( Trig_Random_Ancient_Func045C() ) then
        call UnitAddAbilityBJ('A0EN', gg_unit_n00B_0266)
    else
    endif
    if ( Trig_Random_Ancient_Func046C() ) then
        call UnitAddAbilityBJ('A0B4', gg_unit_n00B_0266)
    else
    endif
    if ( Trig_Random_Ancient_Func047C() ) then
        call UnitAddAbilityBJ('A0B5', gg_unit_n00B_0266)
    else
    endif
    if ( Trig_Random_Ancient_Func048C() ) then
        call UnitAddAbilityBJ('A0B3', gg_unit_n00B_0266)
    else
    endif
    if ( Trig_Random_Ancient_Func049C() ) then
        call UnitAddAbilityBJ('A0AZ', gg_unit_n00B_0266)
    else
    endif
    if ( Trig_Random_Ancient_Func050C() ) then
        call UnitAddAbilityBJ('A0FB', gg_unit_n00B_0266)
    else
    endif
    if ( Trig_Random_Ancient_Func051C() ) then
        call UnitAddAbilityBJ('A0B1', gg_unit_n00B_0266)
    else
    endif
    if ( Trig_Random_Ancient_Func052C() ) then
        call UnitAddAbilityBJ('A0AY', gg_unit_n00B_0266)
    else
    endif
    if ( Trig_Random_Ancient_Func053C() ) then
        call UnitAddAbilityBJ('A0B2', gg_unit_n00B_0266)
    else
    endif
    if ( Trig_Random_Ancient_Func054C() ) then
        call UnitAddAbilityBJ('A0AL', gg_unit_n00B_0266)
    else
    endif
endfunction

//===========================================================================
function InitTrig_Random_Ancient takes nothing returns nothing
    set gg_trg_Random_Ancient=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Random_Ancient, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddCondition(gg_trg_Random_Ancient, Condition(function Trig_Random_Ancient_Conditions))
    call TriggerAddAction(gg_trg_Random_Ancient, function Trig_Random_Ancient_Actions)
endfunction

//===========================================================================
// Trigger: Remove Selection
//===========================================================================
function Trig_Remove_Selection_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetDyingUnit()) == 'ewsp' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Remove_Selection_Actions takes nothing returns nothing
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_4611")
    call RemoveUnit(gg_unit_nmr2_0001)
endfunction

//===========================================================================
function InitTrig_Remove_Selection takes nothing returns nothing
    set gg_trg_Remove_Selection=CreateTrigger()
    call TriggerRegisterPlayerUnitEventSimple(gg_trg_Remove_Selection, Player(6), EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Remove_Selection, Condition(function Trig_Remove_Selection_Conditions))
    call TriggerAddAction(gg_trg_Remove_Selection, function Trig_Remove_Selection_Actions)
endfunction

//===========================================================================
// Trigger: Remove Selector
//===========================================================================
function Trig_Remove_Selector_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == GetUnitTypeId(GetTriggerUnit()) ) ) then
        return false
    endif
    return true
endfunction

function Trig_Remove_Selector_Actions takes nothing returns nothing
    call KillUnit(GetBuyingUnit())
endfunction

//===========================================================================
function InitTrig_Remove_Selector takes nothing returns nothing
    set gg_trg_Remove_Selector=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Remove_Selector, EVENT_PLAYER_UNIT_SELL)
    call TriggerAddCondition(gg_trg_Remove_Selector, Condition(function Trig_Remove_Selector_Conditions))
    call TriggerAddAction(gg_trg_Remove_Selector, function Trig_Remove_Selector_Actions)
endfunction

//===========================================================================
// Trigger: Trade disabled
//===========================================================================
function Trig_Trade_disabled_Actions takes nothing returns nothing
    call SetMapFlag(MAP_LOCK_RESOURCE_TRADING, true)
    call DisableTrigger(gg_trg_Resource_Hint)
endfunction

//===========================================================================
function InitTrig_Trade_disabled takes nothing returns nothing
    set gg_trg_Trade_disabled=CreateTrigger()
    call TriggerRegisterTimerEventSingle(gg_trg_Trade_disabled, 0.10)
    call TriggerAddAction(gg_trg_Trade_disabled, function Trig_Trade_disabled_Actions)
endfunction

//===========================================================================
// Trigger: Trade enabled
//===========================================================================
function Trig_Trade_enabled_Actions takes nothing returns nothing
    call SetMapFlag(MAP_LOCK_RESOURCE_TRADING, false)
    call EnableTrigger(gg_trg_Resource_Hint)
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_3366")
endfunction

//===========================================================================
function InitTrig_Trade_enabled takes nothing returns nothing
    set gg_trg_Trade_enabled=CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_Trade_enabled, Player(6), "-tradeon", true)
    call TriggerAddAction(gg_trg_Trade_enabled, function Trig_Trade_enabled_Actions)
endfunction

//===========================================================================
// Trigger: Disable trade enabled
//===========================================================================
function Trig_Disable_trade_enabled_Actions takes nothing returns nothing
    call DisableTrigger(gg_trg_Trade_disabled)
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_3665")
endfunction

//===========================================================================
function InitTrig_Disable_trade_enabled takes nothing returns nothing
    set gg_trg_Disable_trade_enabled=CreateTrigger()
    call TriggerRegisterTimerEventSingle(gg_trg_Disable_trade_enabled, 80.00)
    call TriggerAddAction(gg_trg_Disable_trade_enabled, function Trig_Disable_trade_enabled_Actions)
endfunction

//===========================================================================
// Trigger: Spawn Races
//
// Beginner Races: h00R = Worgen / h01X = Centaur / h010 = Wildkin / h01K = Nerubian / h03D = Human / h02L = Wisp / h03Q = Kobold / o005 = Ghoul / h000 = Kraken
// Intermediate Races: u007 = Forgotten One / h03S = Aethyr Warp / h016 = Goblin / h00F = Ogre / o000 = Magmide / h02U = Furbolg / o01E = Razormane / h05C = Night Elf /n00M = High Elf
//===========================================================================
function Trig_Spawn_Races_Func001001 takes nothing returns boolean
    return ( udg_BannedWorgen == 0.00 )
endfunction

function Trig_Spawn_Races_Func002001 takes nothing returns boolean
    return ( udg_BannedForgotten == 0.00 )
endfunction

function Trig_Spawn_Races_Func003001 takes nothing returns boolean
    return ( udg_BannedAethyr == 0.00 )
endfunction

function Trig_Spawn_Races_Func004001 takes nothing returns boolean
    return ( udg_BannedGoblin == 0.00 )
endfunction

function Trig_Spawn_Races_Func005001 takes nothing returns boolean
    return ( udg_BannedOgre == 0.00 )
endfunction

function Trig_Spawn_Races_Func006001 takes nothing returns boolean
    return ( udg_BannedMagmide == 0.00 )
endfunction

function Trig_Spawn_Races_Func007001 takes nothing returns boolean
    return ( udg_BannedFurbolg == 0.00 )
endfunction

function Trig_Spawn_Races_Func008001 takes nothing returns boolean
    return ( udg_BannedRazormane == 0.00 )
endfunction

function Trig_Spawn_Races_Func009001 takes nothing returns boolean
    return ( udg_BannedCentaur == 0.00 )
endfunction

function Trig_Spawn_Races_Func010001 takes nothing returns boolean
    return ( udg_BannedWildkin == 0.00 )
endfunction

function Trig_Spawn_Races_Func011001 takes nothing returns boolean
    return ( udg_BannedNerubian == 0.00 )
endfunction

function Trig_Spawn_Races_Func012001 takes nothing returns boolean
    return ( udg_BannedHuman == 0.00 )
endfunction

function Trig_Spawn_Races_Func013001 takes nothing returns boolean
    return ( udg_BannedWisp == 0.00 )
endfunction

function Trig_Spawn_Races_Func014001 takes nothing returns boolean
    return ( udg_BannedKobold == 0.00 )
endfunction

function Trig_Spawn_Races_Func015001 takes nothing returns boolean
    return ( udg_BannedGhoul == 0.00 )
endfunction

function Trig_Spawn_Races_Func016001 takes nothing returns boolean
    return ( udg_BannedKraken == 0.00 )
endfunction

function Trig_Spawn_Races_Func017001 takes nothing returns boolean
    return ( udg_BannedElf == 0.00 )
endfunction

function Trig_Spawn_Races_Func018001 takes nothing returns boolean
    return ( udg_BannedHighElf == 0.00 )
endfunction

function Trig_Spawn_Races_Func019001 takes nothing returns boolean
    return ( udg_BannedRatling == 0.00 )
endfunction

function Trig_Spawn_Races_Func020001 takes nothing returns boolean
    return ( udg_BannedHunter == 0.00 )
endfunction

function Trig_Spawn_Races_Actions takes nothing returns nothing
    if ( (udg_BannedWorgen == 0.00) ) then // INLINED!!
        call AddUnitToStockBJ('h00R', gg_unit_nmer_0000, 1, 1)
    else
        call DoNothing()
    endif
    if ( (udg_BannedForgotten == 0.00) ) then // INLINED!!
        call AddUnitToStockBJ('u007', gg_unit_n00G_0035, 1, 1)
    else
        call DoNothing()
    endif
    if ( (udg_BannedAethyr == 0.00) ) then // INLINED!!
        call AddUnitToStockBJ('h03S', gg_unit_n00G_0035, 1, 1)
    else
        call DoNothing()
    endif
    if ( (udg_BannedGoblin == 0.00) ) then // INLINED!!
        call AddUnitToStockBJ('h016', gg_unit_n00G_0035, 1, 1)
    else
        call DoNothing()
    endif
    if ( (udg_BannedOgre == 0.00) ) then // INLINED!!
        call AddUnitToStockBJ('h00F', gg_unit_n00G_0035, 1, 1)
    else
        call DoNothing()
    endif
    if ( (udg_BannedMagmide == 0.00) ) then // INLINED!!
        call AddUnitToStockBJ('o000', gg_unit_n00G_0035, 1, 1)
    else
        call DoNothing()
    endif
    if ( (udg_BannedFurbolg == 0.00) ) then // INLINED!!
        call AddUnitToStockBJ('h02U', gg_unit_n00G_0035, 1, 1)
    else
        call DoNothing()
    endif
    if ( (udg_BannedRazormane == 0.00) ) then // INLINED!!
        call AddUnitToStockBJ('o01E', gg_unit_n00G_0035, 1, 1)
    else
        call DoNothing()
    endif
    if ( (udg_BannedCentaur == 0.00) ) then // INLINED!!
        call AddUnitToStockBJ('h01X', gg_unit_nmer_0000, 1, 1)
    else
        call DoNothing()
    endif
    if ( (udg_BannedWildkin == 0.00) ) then // INLINED!!
        call AddUnitToStockBJ('h010', gg_unit_nmer_0000, 1, 1)
    else
        call DoNothing()
    endif
    if ( (udg_BannedNerubian == 0.00) ) then // INLINED!!
        call AddUnitToStockBJ('h01K', gg_unit_nmer_0000, 1, 1)
    else
        call DoNothing()
    endif
    if ( (udg_BannedHuman == 0.00) ) then // INLINED!!
        call AddUnitToStockBJ('h03D', gg_unit_nmer_0000, 1, 1)
    else
        call DoNothing()
    endif
    if ( (udg_BannedWisp == 0.00) ) then // INLINED!!
        call AddUnitToStockBJ('h02L', gg_unit_nmer_0000, 1, 1)
    else
        call DoNothing()
    endif
    if ( (udg_BannedKobold == 0.00) ) then // INLINED!!
        call AddUnitToStockBJ('h03Q', gg_unit_nmer_0000, 1, 1)
    else
        call DoNothing()
    endif
    if ( (udg_BannedGhoul == 0.00) ) then // INLINED!!
        call AddUnitToStockBJ('o005', gg_unit_nmer_0000, 1, 1)
    else
        call DoNothing()
    endif
    if ( (udg_BannedKraken == 0.00) ) then // INLINED!!
        call AddUnitToStockBJ('h000', gg_unit_nmer_0000, 1, 1)
    else
        call DoNothing()
    endif
    if ( (udg_BannedElf == 0.00) ) then // INLINED!!
        call AddUnitToStockBJ('h05C', gg_unit_n00G_0035, 1, 1)
    else
        call DoNothing()
    endif
    if ( (udg_BannedHighElf == 0.00) ) then // INLINED!!
        call AddUnitToStockBJ('n00M', gg_unit_n00G_0035, 1, 1)
    else
        call DoNothing()
    endif
    if ( (udg_BannedRatling == 0.00) ) then // INLINED!!
        call AddUnitToStockBJ('o026', gg_unit_nmer_0000, 1, 1)
    else
        call DoNothing()
    endif
    if ( (udg_BannedHunter == 0.00) ) then // INLINED!!
        call AddUnitToStockBJ('h05W', gg_unit_n00G_0035, 1, 1)
    else
        call DoNothing()
    endif
endfunction

//===========================================================================
function InitTrig_Spawn_Races takes nothing returns nothing
    set gg_trg_Spawn_Races=CreateTrigger()
    call TriggerRegisterTimerEventSingle(gg_trg_Spawn_Races, 20.00)
    call TriggerAddAction(gg_trg_Spawn_Races, function Trig_Spawn_Races_Actions)
endfunction


//===========================================================================
// Trigger: Spawn Ancients
//
// Ancients: O01V = Light / O016 = Lightning / O00S = Dragon / O00L = Earth / O00A = Darkness / O008 = Ice / O004 = Fire / O00D = Nature / O01X = Sand / O01D = Wind
//===========================================================================
function Trig_Spawn_Ancients_Func001001 takes nothing returns boolean
    return ( udg_BannedAncientLight == 0.00 )
endfunction

function Trig_Spawn_Ancients_Func002001 takes nothing returns boolean
    return ( udg_BannedAncientLightning == 0.00 )
endfunction

function Trig_Spawn_Ancients_Func003001 takes nothing returns boolean
    return ( udg_BannedAncientDragon == 0.00 )
endfunction

function Trig_Spawn_Ancients_Func004001 takes nothing returns boolean
    return ( udg_BannedAncientEarth == 0.00 )
endfunction

function Trig_Spawn_Ancients_Func005001 takes nothing returns boolean
    return ( udg_BannedAncientDarkness == 0.00 )
endfunction

function Trig_Spawn_Ancients_Func006001 takes nothing returns boolean
    return ( udg_BannedAncientIce == 0.00 )
endfunction

function Trig_Spawn_Ancients_Func007001 takes nothing returns boolean
    return ( udg_BannedAncientFire == 0.00 )
endfunction

function Trig_Spawn_Ancients_Func008001 takes nothing returns boolean
    return ( udg_BannedAncientNature == 0.00 )
endfunction

function Trig_Spawn_Ancients_Func009001 takes nothing returns boolean
    return ( udg_BannedAncientSand == 0.00 )
endfunction

function Trig_Spawn_Ancients_Func010001 takes nothing returns boolean
    return ( udg_BannedAncientSpace == 0.00 )
endfunction

function Trig_Spawn_Ancients_Func011001 takes nothing returns boolean
    return ( udg_BannedAncientWind == 0.00 )
endfunction


function Trig_Spawn_Ancients_Actions takes nothing returns nothing
    if ( (udg_BannedAncientLight == 0.00) ) then // INLINED!!
        call AddUnitToStockBJ('O01V', gg_unit_nmr2_0001, 0, 1)
    else
        call DoNothing()
    endif
    if ( (udg_BannedAncientLightning == 0.00) ) then // INLINED!!
        call AddUnitToStockBJ('O016', gg_unit_nmr2_0001, 0, 1)
    else
        call DoNothing()
    endif
    if ( (udg_BannedAncientDragon == 0.00) ) then // INLINED!!
        call AddUnitToStockBJ('O00S', gg_unit_nmr2_0001, 0, 1)
    else
        call DoNothing()
    endif
    if ( (udg_BannedAncientEarth == 0.00) ) then // INLINED!!
        call AddUnitToStockBJ('O00L', gg_unit_nmr2_0001, 0, 1)
    else
        call DoNothing()
    endif
    if ( (udg_BannedAncientDarkness == 0.00) ) then // INLINED!!
        call AddUnitToStockBJ('O00A', gg_unit_nmr2_0001, 0, 1)
    else
        call DoNothing()
    endif
    if ( (udg_BannedAncientIce == 0.00) ) then // INLINED!!
        call AddUnitToStockBJ('O008', gg_unit_nmr2_0001, 0, 1)
    else
        call DoNothing()
    endif
    if ( (udg_BannedAncientFire == 0.00) ) then // INLINED!!
        call AddUnitToStockBJ('O004', gg_unit_nmr2_0001, 0, 1)
    else
        call DoNothing()
    endif
    if ( (udg_BannedAncientNature == 0.00) ) then // INLINED!!
        call AddUnitToStockBJ('O00D', gg_unit_nmr2_0001, 0, 1)
    else
        call DoNothing()
    endif
    if ( (udg_BannedAncientSand == 0.00) ) then // INLINED!!
        call AddUnitToStockBJ('O01X', gg_unit_nmr2_0001, 0, 1)
    else
        call DoNothing()
    endif
    if ( (udg_BannedAncientSpace == 0.00) ) then // INLINED!!
        call AddUnitToStockBJ('O01Z', gg_unit_nmr2_0001, 0, 1)
    else
        call DoNothing()
    endif
    if ( (udg_BannedAncientWind == 0.00) ) then // INLINED!!
        call AddUnitToStockBJ('O01D', gg_unit_nmr2_0001, 0, 1)
    else
        call DoNothing()
    endif
endfunction

//===========================================================================
function InitTrig_Spawn_Ancients takes nothing returns nothing
    set gg_trg_Spawn_Ancients=CreateTrigger()
    call TriggerRegisterTimerEventSingle(gg_trg_Spawn_Ancients, 20.00)
    call TriggerAddAction(gg_trg_Spawn_Ancients, function Trig_Spawn_Ancients_Actions)
endfunction


//===========================================================================
// Trigger: DisableExpanderBans
//===========================================================================
function Trig_DisableExpanderBans_Actions takes nothing returns nothing
    call DisableTrigger(gg_trg_Worgen)
    call DisableTrigger(gg_trg_Centaur)
    call DisableTrigger(gg_trg_Wildkin)
    call DisableTrigger(gg_trg_Nerubian)
    call DisableTrigger(gg_trg_Human)
    call DisableTrigger(gg_trg_Wisp)
    call DisableTrigger(gg_trg_Kobold)
    call DisableTrigger(gg_trg_Ghoul)
    call DisableTrigger(gg_trg_Kraken)
    call DisableTrigger(gg_trg_Aethyr)
    call DisableTrigger(gg_trg_Forgotten)
    call DisableTrigger(gg_trg_Goblin)
    call DisableTrigger(gg_trg_Ogre)
    call DisableTrigger(gg_trg_Magmide)
    call DisableTrigger(gg_trg_Furbolg)
    call DisableTrigger(gg_trg_Razormane)
    call DisableTrigger(gg_trg_Elf)
    call DisableTrigger(gg_trg_HighElf)
    call DisplayTextToForce(GetPlayersAll(), "Factions can no longer be banned.")
	
endfunction

//===========================================================================
function InitTrig_DisableExpanderBans takes nothing returns nothing
    set gg_trg_DisableExpanderBans=CreateTrigger()
    call TriggerRegisterTimerEventSingle(gg_trg_DisableExpanderBans, 20.00)
    call TriggerAddAction(gg_trg_DisableExpanderBans, function Trig_DisableExpanderBans_Actions)
endfunction


//===========================================================================
// Trigger: Worgen
//===========================================================================
function Trig_Worgen_Func001Func006001 takes nothing returns boolean
    return ( udg_Bans == 0 )
endfunction

function Trig_Worgen_Func001Func006002 takes nothing returns boolean
    return ( udg_BannedWorgen == 1.00 )
endfunction

function Trig_Worgen_Func001C takes nothing returns boolean
    if ( not GetBooleanOr((udg_Bans == 0), (udg_BannedWorgen == 1.00)) ) then // INLINED!!
        return false
    endif
    return true
endfunction

function Trig_Worgen_Actions takes nothing returns nothing
    if ( Trig_Worgen_Func001C() ) then
        call DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        set udg_Bans=( udg_Bans - 1 )
        set udg_BannedWorgen=1.00
        call DisplayTextToForce(GetPlayersAll(), ( "Worgen banned. Bans remaining: " + I2S(udg_Bans) ))
    endif
endfunction

//===========================================================================
function InitTrig_Worgen takes nothing returns nothing
    set gg_trg_Worgen=CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_Worgen, Player(0), "-ban worgen", true)
    call TriggerAddAction(gg_trg_Worgen, function Trig_Worgen_Actions)
endfunction


//===========================================================================
// Trigger: Centaur
//===========================================================================
function Trig_Centaur_Func001Func006001 takes nothing returns boolean
    return ( udg_Bans == 0 )
endfunction

function Trig_Centaur_Func001Func006002 takes nothing returns boolean
    return ( udg_BannedCentaur == 1.00 )
endfunction

function Trig_Centaur_Func001C takes nothing returns boolean
    if ( not GetBooleanOr((udg_Bans == 0), (udg_BannedCentaur == 1.00)) ) then // INLINED!!
        return false
    endif
    return true
endfunction

function Trig_Centaur_Actions takes nothing returns nothing
    if ( Trig_Centaur_Func001C() ) then
        call DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        set udg_Bans=( udg_Bans - 1 )
        set udg_BannedCentaur=1.00
        call DisplayTextToForce(GetPlayersAll(), ( "Centaur banned. Bans remaining: " + I2S(udg_Bans) ))
    endif
endfunction

//===========================================================================
function InitTrig_Centaur takes nothing returns nothing
    set gg_trg_Centaur=CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_Centaur, Player(0), "-ban Centaur", true)
    call TriggerAddAction(gg_trg_Centaur, function Trig_Centaur_Actions)
endfunction


//===========================================================================
// Trigger: Wildkin
//===========================================================================
function Trig_Wildkin_Func001Func006001 takes nothing returns boolean
    return ( udg_Bans == 0 )
endfunction

function Trig_Wildkin_Func001Func006002 takes nothing returns boolean
    return ( udg_BannedWildkin == 1.00 )
endfunction

function Trig_Wildkin_Func001C takes nothing returns boolean
    if ( not GetBooleanOr((udg_Bans == 0), (udg_BannedWildkin == 1.00)) ) then // INLINED!!
        return false
    endif
    return true
endfunction

function Trig_Wildkin_Actions takes nothing returns nothing
    if ( Trig_Wildkin_Func001C() ) then
        call DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        set udg_Bans=( udg_Bans - 1 )
        set udg_BannedWildkin=1.00
        call DisplayTextToForce(GetPlayersAll(), ( "Wildkin banned. Bans remaining: " + I2S(udg_Bans) ))
    endif
endfunction

//===========================================================================
function InitTrig_Wildkin takes nothing returns nothing
    set gg_trg_Wildkin=CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_Wildkin, Player(0), "-ban Wildkin", true)
    call TriggerAddAction(gg_trg_Wildkin, function Trig_Wildkin_Actions)
endfunction


//===========================================================================
// Trigger: Nerubian
//===========================================================================
function Trig_Nerubian_Func001Func006001 takes nothing returns boolean
    return ( udg_Bans == 0 )
endfunction

function Trig_Nerubian_Func001Func006002 takes nothing returns boolean
    return ( udg_BannedNerubian == 1.00 )
endfunction

function Trig_Nerubian_Func001C takes nothing returns boolean
    if ( not GetBooleanOr((udg_Bans == 0), (udg_BannedNerubian == 1.00)) ) then // INLINED!!
        return false
    endif
    return true
endfunction

function Trig_Nerubian_Actions takes nothing returns nothing
    if ( Trig_Nerubian_Func001C() ) then
        call DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        set udg_Bans=( udg_Bans - 1 )
        set udg_BannedNerubian=1.00
        call DisplayTextToForce(GetPlayersAll(), ( "Nerubian banned. Bans remaining: " + I2S(udg_Bans) ))
    endif
endfunction

//===========================================================================
function InitTrig_Nerubian takes nothing returns nothing
    set gg_trg_Nerubian=CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_Nerubian, Player(0), "-ban Nerubian", true)
    call TriggerAddAction(gg_trg_Nerubian, function Trig_Nerubian_Actions)
endfunction


//===========================================================================
// Trigger: Human
//===========================================================================
function Trig_Human_Func001Func006001 takes nothing returns boolean
    return ( udg_Bans == 0 )
endfunction

function Trig_Human_Func001Func006002 takes nothing returns boolean
    return ( udg_BannedHuman == 1.00 )
endfunction

function Trig_Human_Func001C takes nothing returns boolean
    if ( not GetBooleanOr((udg_Bans == 0), (udg_BannedHuman == 1.00)) ) then // INLINED!!
        return false
    endif
    return true
endfunction

function Trig_Human_Actions takes nothing returns nothing
    if ( Trig_Human_Func001C() ) then
        call DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        set udg_Bans=( udg_Bans - 1 )
        set udg_BannedHuman=1.00
        call DisplayTextToForce(GetPlayersAll(), ( "Human banned. Bans remaining: " + I2S(udg_Bans) ))
    endif
endfunction

//===========================================================================
function InitTrig_Human takes nothing returns nothing
    set gg_trg_Human=CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_Human, Player(0), "-ban Human", true)
    call TriggerAddAction(gg_trg_Human, function Trig_Human_Actions)
endfunction


//===========================================================================
// Trigger: Wisp
//===========================================================================
function Trig_Wisp_Func001Func006001 takes nothing returns boolean
    return ( udg_Bans == 0 )
endfunction

function Trig_Wisp_Func001Func006002 takes nothing returns boolean
    return ( udg_BannedWisp == 1.00 )
endfunction

function Trig_Wisp_Func001C takes nothing returns boolean
    if ( not GetBooleanOr((udg_Bans == 0), (udg_BannedWisp == 1.00)) ) then // INLINED!!
        return false
    endif
    return true
endfunction

function Trig_Wisp_Actions takes nothing returns nothing
    if ( Trig_Wisp_Func001C() ) then
        call DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        set udg_Bans=( udg_Bans - 1 )
        set udg_BannedWisp=1.00
        call DisplayTextToForce(GetPlayersAll(), ( "Wisp banned. Bans remaining: " + I2S(udg_Bans) ))
    endif
endfunction

//===========================================================================
function InitTrig_Wisp takes nothing returns nothing
    set gg_trg_Wisp=CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_Wisp, Player(0), "-ban Wisp", true)
    call TriggerAddAction(gg_trg_Wisp, function Trig_Wisp_Actions)
endfunction


//===========================================================================
// Trigger: Kobold
//===========================================================================
function Trig_Kobold_Func001Func006001 takes nothing returns boolean
    return ( udg_Bans == 0 )
endfunction

function Trig_Kobold_Func001Func006002 takes nothing returns boolean
    return ( udg_BannedKobold == 1.00 )
endfunction

function Trig_Kobold_Func001C takes nothing returns boolean
    if ( not GetBooleanOr((udg_Bans == 0), (udg_BannedKobold == 1.00)) ) then // INLINED!!
        return false
    endif
    return true
endfunction

function Trig_Kobold_Actions takes nothing returns nothing
    if ( Trig_Kobold_Func001C() ) then
        call DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        set udg_Bans=( udg_Bans - 1 )
        set udg_BannedKobold=1.00
        call DisplayTextToForce(GetPlayersAll(), ( "Kobold banned. Bans remaining: " + I2S(udg_Bans) ))
    endif
endfunction

//===========================================================================
function InitTrig_Kobold takes nothing returns nothing
    set gg_trg_Kobold=CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_Kobold, Player(0), "-ban Kobold", true)
    call TriggerAddAction(gg_trg_Kobold, function Trig_Kobold_Actions)
endfunction


//===========================================================================
// Trigger: Ghoul
//===========================================================================
function Trig_Ghoul_Func001Func006001 takes nothing returns boolean
    return ( udg_Bans == 0 )
endfunction

function Trig_Ghoul_Func001Func006002 takes nothing returns boolean
    return ( udg_BannedGhoul == 1.00 )
endfunction

function Trig_Ghoul_Func001C takes nothing returns boolean
    if ( not GetBooleanOr((udg_Bans == 0), (udg_BannedGhoul == 1.00)) ) then // INLINED!!
        return false
    endif
    return true
endfunction

function Trig_Ghoul_Actions takes nothing returns nothing
    if ( Trig_Ghoul_Func001C() ) then
        call DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        set udg_Bans=( udg_Bans - 1 )
        set udg_BannedGhoul=1.00
        call DisplayTextToForce(GetPlayersAll(), ( "Ghoul banned. Bans remaining: " + I2S(udg_Bans) ))
    endif
endfunction

//===========================================================================
function InitTrig_Ghoul takes nothing returns nothing
    set gg_trg_Ghoul=CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_Ghoul, Player(0), "-ban Ghoul", true)
    call TriggerAddAction(gg_trg_Ghoul, function Trig_Ghoul_Actions)
endfunction


//===========================================================================
// Trigger: Kraken
//===========================================================================
function Trig_Kraken_Func001Func006001 takes nothing returns boolean
    return ( udg_Bans == 0 )
endfunction

function Trig_Kraken_Func001Func006002 takes nothing returns boolean
    return ( udg_BannedKraken == 1.00 )
endfunction

function Trig_Kraken_Func001C takes nothing returns boolean
    if ( not GetBooleanOr((udg_Bans == 0), (udg_BannedKraken == 1.00)) ) then // INLINED!!
        return false
    endif
    return true
endfunction

function Trig_Kraken_Actions takes nothing returns nothing
    if ( Trig_Kraken_Func001C() ) then
        call DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        set udg_Bans=( udg_Bans - 1 )
        set udg_BannedKraken=1.00
        call DisplayTextToForce(GetPlayersAll(), ( "Kraken banned. Bans remaining: " + I2S(udg_Bans) ))
    endif
endfunction

//===========================================================================
function InitTrig_Kraken takes nothing returns nothing
    set gg_trg_Kraken=CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_Kraken, Player(0), "-ban Kraken", true)
    call TriggerAddAction(gg_trg_Kraken, function Trig_Kraken_Actions)
endfunction


//===========================================================================
// Trigger: Aethyr
//===========================================================================
function Trig_Aethyr_Func001Func006001 takes nothing returns boolean
    return ( udg_Bans == 0 )
endfunction

function Trig_Aethyr_Func001Func006002 takes nothing returns boolean
    return ( udg_BannedAethyr == 1.00 )
endfunction

function Trig_Aethyr_Func001C takes nothing returns boolean
    if ( not GetBooleanOr((udg_Bans == 0), (udg_BannedAethyr == 1.00)) ) then // INLINED!!
        return false
    endif
    return true
endfunction

function Trig_Aethyr_Actions takes nothing returns nothing
    if ( Trig_Aethyr_Func001C() ) then
        call DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        set udg_Bans=( udg_Bans - 1 )
        set udg_BannedAethyr=1.00
        call DisplayTextToForce(GetPlayersAll(), ( "Aethyr Warp banned. Bans remaining: " + I2S(udg_Bans) ))
    endif
endfunction

//===========================================================================
function InitTrig_Aethyr takes nothing returns nothing
    set gg_trg_Aethyr=CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_Aethyr, Player(0), "-ban aethyr", true)
    call TriggerAddAction(gg_trg_Aethyr, function Trig_Aethyr_Actions)
endfunction

 
//===========================================================================
// Trigger: Forgotten
//===========================================================================
function Trig_Forgotten_Func001Func006001 takes nothing returns boolean
    return ( udg_Bans == 0 )
endfunction

function Trig_Forgotten_Func001Func006002 takes nothing returns boolean
    return ( udg_BannedForgotten == 1.00 )
endfunction

function Trig_Forgotten_Func001C takes nothing returns boolean
    if ( not GetBooleanOr((udg_Bans == 0), (udg_BannedForgotten == 1.00)) ) then // INLINED!!
        return false
    endif
    return true
endfunction

function Trig_Forgotten_Actions takes nothing returns nothing
    if ( Trig_Forgotten_Func001C() ) then
        call DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        set udg_Bans=( udg_Bans - 1 )
        set udg_BannedForgotten=1.00
        call DisplayTextToForce(GetPlayersAll(), ( "Forgotten One banned. Bans remaining: " + I2S(udg_Bans) ))
    endif
endfunction

//===========================================================================
function InitTrig_Forgotten takes nothing returns nothing
    set gg_trg_Forgotten=CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_Forgotten, Player(0), "-ban Forgotten", true)
    call TriggerAddAction(gg_trg_Forgotten, function Trig_Forgotten_Actions)
endfunction


//===========================================================================
// Trigger: Goblin
//===========================================================================
function Trig_Goblin_Func001Func006001 takes nothing returns boolean
    return ( udg_Bans == 0 )
endfunction

function Trig_Goblin_Func001Func006002 takes nothing returns boolean
    return ( udg_BannedGoblin == 1.00 )
endfunction

function Trig_Goblin_Func001C takes nothing returns boolean
    if ( not GetBooleanOr((udg_Bans == 0), (udg_BannedGoblin == 1.00)) ) then // INLINED!!
        return false
    endif
    return true
endfunction

function Trig_Goblin_Actions takes nothing returns nothing
    if ( Trig_Goblin_Func001C() ) then
        call DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        set udg_Bans=( udg_Bans - 1 )
        set udg_BannedGoblin=1.00
        call DisplayTextToForce(GetPlayersAll(), ( "Goblin banned. Bans remaining: " + I2S(udg_Bans) ))
    endif
endfunction

//===========================================================================
function InitTrig_Goblin takes nothing returns nothing
    set gg_trg_Goblin=CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_Goblin, Player(0), "-ban Goblin", true)
    call TriggerAddAction(gg_trg_Goblin, function Trig_Goblin_Actions)
endfunction


//===========================================================================
// Trigger: Ogre
//===========================================================================
function Trig_Ogre_Func001Func006001 takes nothing returns boolean
    return ( udg_Bans == 0 )
endfunction

function Trig_Ogre_Func001Func006002 takes nothing returns boolean
    return ( udg_BannedOgre == 1.00 )
endfunction

function Trig_Ogre_Func001C takes nothing returns boolean
    if ( not GetBooleanOr((udg_Bans == 0), (udg_BannedOgre == 1.00)) ) then // INLINED!!
        return false
    endif
    return true
endfunction

function Trig_Ogre_Actions takes nothing returns nothing
    if ( Trig_Ogre_Func001C() ) then
        call DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        set udg_Bans=( udg_Bans - 1 )
        set udg_BannedOgre=1.00
        call DisplayTextToForce(GetPlayersAll(), ( "Ogre banned. Bans remaining: " + I2S(udg_Bans) ))
    endif
endfunction

//===========================================================================
function InitTrig_Ogre takes nothing returns nothing
    set gg_trg_Ogre=CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_Ogre, Player(0), "-ban Ogre", true)
    call TriggerAddAction(gg_trg_Ogre, function Trig_Ogre_Actions)
endfunction


//===========================================================================
// Trigger: Magmide
//===========================================================================
function Trig_Magmide_Func001Func006001 takes nothing returns boolean
    return ( udg_Bans == 0 )
endfunction

function Trig_Magmide_Func001Func006002 takes nothing returns boolean
    return ( udg_BannedMagmide == 1.00 )
endfunction

function Trig_Magmide_Func001C takes nothing returns boolean
    if ( not GetBooleanOr((udg_Bans == 0), (udg_BannedMagmide == 1.00)) ) then // INLINED!!
        return false
    endif
    return true
endfunction

function Trig_Magmide_Actions takes nothing returns nothing
    if ( Trig_Magmide_Func001C() ) then
        call DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        set udg_Bans=( udg_Bans - 1 )
        set udg_BannedMagmide=1.00
        call DisplayTextToForce(GetPlayersAll(), ( "Magmide banned. Bans remaining: " + I2S(udg_Bans) ))
    endif
endfunction

//===========================================================================
function InitTrig_Magmide takes nothing returns nothing
    set gg_trg_Magmide=CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_Magmide, Player(0), "-ban Magmide", true)
    call TriggerAddAction(gg_trg_Magmide, function Trig_Magmide_Actions)
endfunction


//===========================================================================
// Trigger: Furbolg
//===========================================================================
function Trig_Furbolg_Func001Func006001 takes nothing returns boolean
    return ( udg_Bans == 0 )
endfunction

function Trig_Furbolg_Func001Func006002 takes nothing returns boolean
    return ( udg_BannedFurbolg == 1.00 )
endfunction

function Trig_Furbolg_Func001C takes nothing returns boolean
    if ( not GetBooleanOr((udg_Bans == 0), (udg_BannedFurbolg == 1.00)) ) then // INLINED!!
        return false
    endif
    return true
endfunction

function Trig_Furbolg_Actions takes nothing returns nothing
    if ( Trig_Furbolg_Func001C() ) then
        call DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        set udg_Bans=( udg_Bans - 1 )
        set udg_BannedFurbolg=1.00
        call DisplayTextToForce(GetPlayersAll(), ( "Furbolg banned. Bans remaining: " + I2S(udg_Bans) ))
    endif
endfunction

//===========================================================================
function InitTrig_Furbolg takes nothing returns nothing
    set gg_trg_Furbolg=CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_Furbolg, Player(0), "-ban Furbolg", true)
    call TriggerAddAction(gg_trg_Furbolg, function Trig_Furbolg_Actions)
endfunction


//===========================================================================
// Trigger: Razormane
//===========================================================================
function Trig_Razormane_Func001Func006001 takes nothing returns boolean
    return ( udg_Bans == 0 )
endfunction

function Trig_Razormane_Func001Func006002 takes nothing returns boolean
    return ( udg_BannedRazormane == 1.00 )
endfunction

function Trig_Razormane_Func001C takes nothing returns boolean
    if ( not GetBooleanOr((udg_Bans == 0), (udg_BannedRazormane == 1.00)) ) then // INLINED!!
        return false
    endif
    return true
endfunction

function Trig_Razormane_Actions takes nothing returns nothing
    if ( Trig_Razormane_Func001C() ) then
        call DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        set udg_Bans=( udg_Bans - 1 )
        set udg_BannedRazormane=1.00
        call DisplayTextToForce(GetPlayersAll(), ( "Razormane banned. Bans remaining: " + I2S(udg_Bans) ))
    endif
endfunction

//===========================================================================
function InitTrig_Razormane takes nothing returns nothing
    set gg_trg_Razormane=CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_Razormane, Player(0), "-ban Razormane", true)
    call TriggerAddAction(gg_trg_Razormane, function Trig_Razormane_Actions)
endfunction


//===========================================================================
// Trigger: Elf
//===========================================================================
function Trig_Elf_Func001Func006001 takes nothing returns boolean
    return ( udg_Bans == 0 )
endfunction

function Trig_Elf_Func001Func006002 takes nothing returns boolean
    return ( udg_BannedElf == 1.00 )
endfunction

function Trig_Elf_Func001C takes nothing returns boolean
    if ( not GetBooleanOr((udg_Bans == 0), (udg_BannedElf == 1.00)) ) then // INLINED!!
        return false
    endif
    return true
endfunction

function Trig_Elf_Actions takes nothing returns nothing
    if ( Trig_Elf_Func001C() ) then
        call DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        set udg_Bans=( udg_Bans - 1 )
        set udg_BannedElf=1.00
        call DisplayTextToForce(GetPlayersAll(), ( "Elf banned. Bans remaining: " + I2S(udg_Bans) ))
    endif
endfunction

//===========================================================================
function InitTrig_Elf takes nothing returns nothing
    set gg_trg_Elf=CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_Elf, Player(0), "-ban NightElf", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Elf, Player(0), "-ban Elf", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Elf, Player(0), "-ban Night", true)
    call TriggerAddAction(gg_trg_Elf, function Trig_Elf_Actions)
endfunction


//===========================================================================
// Trigger: HighElf
//===========================================================================
function Trig_HighElf_Func001Func006001 takes nothing returns boolean
    return ( udg_Bans == 0 )
endfunction

function Trig_HighElf_Func001Func006002 takes nothing returns boolean
    return ( udg_BannedHighElf == 1.00 )
endfunction

function Trig_HighElf_Func001C takes nothing returns boolean
    if ( not GetBooleanOr((udg_Bans == 0), (udg_BannedHighElf == 1.00)) ) then // INLINED!!
        return false
    endif
    return true
endfunction

function Trig_HighElf_Actions takes nothing returns nothing
    if ( Trig_HighElf_Func001C() ) then
        call DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        set udg_Bans=( udg_Bans - 1 )
        set udg_BannedHighElf=1.00
        call DisplayTextToForce(GetPlayersAll(), ( "Elf banned. Bans remaining: " + I2S(udg_Bans) ))
    endif
endfunction

//===========================================================================
function InitTrig_HighElf takes nothing returns nothing
    set gg_trg_HighElf=CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_HighElf, Player(0), "-ban HighElf", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_HighElf, Player(0), "-ban High Elf", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_HighElf, Player(0), "-ban High", true)
    call TriggerAddAction(gg_trg_HighElf, function Trig_HighElf_Actions)
endfunction


//===========================================================================
// Trigger: Ratling
//===========================================================================
function Trig_Ratling_Func001Func006001 takes nothing returns boolean
    return ( udg_Bans == 0 )
endfunction

function Trig_Ratling_Func001Func006002 takes nothing returns boolean
    return ( udg_BannedRatling == 1.00 )
endfunction

function Trig_Ratling_Func001C takes nothing returns boolean
    if ( not GetBooleanOr((udg_Bans == 0), (udg_BannedRatling == 1.00)) ) then // INLINED!!
        return false
    endif
    return true
endfunction

function Trig_Ratling_Actions takes nothing returns nothing
    if ( Trig_Ratling_Func001C() ) then
        call DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        set udg_Bans=( udg_Bans - 1 )
        set udg_BannedRatling=1.00
        call DisplayTextToForce(GetPlayersAll(), ( "Ratling Stalker banned. Bans remaining: " + I2S(udg_Bans) ))
    endif
endfunction

//===========================================================================
function InitTrig_Ratling takes nothing returns nothing
    set gg_trg_Ratling=CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_Ratling, Player(0), "-ban rat", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Ratling, Player(0), "-ban ratling", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Ratling, Player(0), "-ban stalker", true)
    call TriggerAddAction(gg_trg_Ratling, function Trig_Ratling_Actions)
endfunction


//===========================================================================
// Trigger: Hunter
//===========================================================================
function Trig_Hunter_Func001Func006001 takes nothing returns boolean
    return ( udg_Bans == 0 )
endfunction

function Trig_Hunter_Func001Func006002 takes nothing returns boolean
    return ( udg_BannedHunter == 1.00 )
endfunction

function Trig_Hunter_Func001C takes nothing returns boolean
    if ( not GetBooleanOr((udg_Bans == 0), (udg_BannedHunter == 1.00)) ) then // INLINED!!
        return false
    endif
    return true
endfunction

function Trig_Hunter_Actions takes nothing returns nothing
    if ( Trig_Hunter_Func001C() ) then
        call DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        set udg_Bans=( udg_Bans - 1 )
        set udg_BannedHunter=1.00
        call DisplayTextToForce(GetPlayersAll(), ( "Bounty Hunter banned. Bans remaining: " + I2S(udg_Bans) ))
    endif
endfunction

//===========================================================================
function InitTrig_Hunter takes nothing returns nothing
    set gg_trg_Hunter=CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_Hunter, Player(0), "-ban hunter", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Hunter, Player(0), "-ban bounty", true)
    call TriggerAddAction(gg_trg_Hunter, function Trig_Hunter_Actions)
endfunction


//===========================================================================
// Trigger: AncientLight
//===========================================================================
function Trig_AncientLight_Func001Func006001 takes nothing returns boolean
    return ( udg_Bans == 0 )
endfunction

function Trig_AncientLight_Func001Func006002 takes nothing returns boolean
    return ( udg_BannedAncientLight == 1.00 )
endfunction

function Trig_AncientLight_Func001C takes nothing returns boolean
    if ( not GetBooleanOr((udg_Bans == 0), (udg_BannedAncientLight == 1.00)) ) then // INLINED!!
        return false
    endif
    return true
endfunction

function Trig_AncientLight_Actions takes nothing returns nothing
    if ( Trig_AncientLight_Func001C() ) then
        call DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        set udg_Bans=( udg_Bans - 1 )
        set udg_BannedAncientLight=1.00
        call DisplayTextToForce(GetPlayersAll(), ( "Ancient of Light banned. Bans remaining: " + I2S(udg_Bans) ))
    endif
endfunction

//===========================================================================
function InitTrig_AncientLight takes nothing returns nothing
    set gg_trg_AncientLight=CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_AncientLight, Player(0), "-ban light", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_AncientLight, Player(0), "-ban divinity", true)
    call TriggerAddAction(gg_trg_AncientLight, function Trig_AncientLight_Actions)
endfunction


//===========================================================================
// Trigger: AncientLightning
//===========================================================================
function Trig_AncientLightning_Func001Func006001 takes nothing returns boolean
    return ( udg_Bans == 0 )
endfunction

function Trig_AncientLightning_Func001Func006002 takes nothing returns boolean
    return ( udg_BannedAncientLightning == 1.00 )
endfunction

function Trig_AncientLightning_Func001C takes nothing returns boolean
    if ( not GetBooleanOr((udg_Bans == 0), (udg_BannedAncientLightning == 1.00)) ) then // INLINED!!
        return false
    endif
    return true
endfunction

function Trig_AncientLightning_Actions takes nothing returns nothing
    if ( Trig_AncientLightning_Func001C() ) then
        call DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        set udg_Bans=( udg_Bans - 1 )
        set udg_BannedAncientLightning=1.00
        call DisplayTextToForce(GetPlayersAll(), ( "Ancient of Lightning banned. Bans remaining: " + I2S(udg_Bans) ))
    endif
endfunction

//===========================================================================
function InitTrig_AncientLightning takes nothing returns nothing
    set gg_trg_AncientLightning=CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_AncientLightning, Player(0), "-ban Lightning", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_AncientLightning, Player(0), "-ban Zalxon", true)
    call TriggerAddAction(gg_trg_AncientLightning, function Trig_AncientLightning_Actions)
endfunction


//===========================================================================
// Trigger: AncientDragon
//===========================================================================
function Trig_AncientDragon_Func001Func006001 takes nothing returns boolean
    return ( udg_Bans == 0 )
endfunction

function Trig_AncientDragon_Func001Func006002 takes nothing returns boolean
    return ( udg_BannedAncientDragon == 1.00 )
endfunction

function Trig_AncientDragon_Func001C takes nothing returns boolean
    if ( not GetBooleanOr((udg_Bans == 0), (udg_BannedAncientDragon == 1.00)) ) then // INLINED!!
        return false
    endif
    return true
endfunction

function Trig_AncientDragon_Actions takes nothing returns nothing
    if ( Trig_AncientDragon_Func001C() ) then
        call DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        set udg_Bans=( udg_Bans - 1 )
        set udg_BannedAncientDragon=1.00
        call DisplayTextToForce(GetPlayersAll(), ( "Ancient of Dragons banned. Bans remaining: " + I2S(udg_Bans) ))
    endif
endfunction

//===========================================================================
function InitTrig_AncientDragon takes nothing returns nothing
    set gg_trg_AncientDragon=CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_AncientDragon, Player(0), "-ban Dragon", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_AncientDragon, Player(0), "-ban Dragons", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_AncientDragon, Player(0), "-ban Dragos", true)
    call TriggerAddAction(gg_trg_AncientDragon, function Trig_AncientDragon_Actions)
endfunction


//===========================================================================
// Trigger: AncientEarth
//===========================================================================
function Trig_AncientEarth_Func001Func006001 takes nothing returns boolean
    return ( udg_Bans == 0 )
endfunction

function Trig_AncientEarth_Func001Func006002 takes nothing returns boolean
    return ( udg_BannedAncientEarth == 1.00 )
endfunction

function Trig_AncientEarth_Func001C takes nothing returns boolean
    if ( not GetBooleanOr((udg_Bans == 0), (udg_BannedAncientEarth == 1.00)) ) then // INLINED!!
        return false
    endif
    return true
endfunction

function Trig_AncientEarth_Actions takes nothing returns nothing
    if ( Trig_AncientEarth_Func001C() ) then
        call DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        set udg_Bans=( udg_Bans - 1 )
        set udg_BannedAncientEarth=1.00
        call DisplayTextToForce(GetPlayersAll(), ( "Ancient of Earth banned. Bans remaining: " + I2S(udg_Bans) ))
    endif
endfunction

//===========================================================================
function InitTrig_AncientEarth takes nothing returns nothing
    set gg_trg_AncientEarth=CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_AncientEarth, Player(0), "-ban Earth", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_AncientEarth, Player(0), "-ban Tremor", true)
    call TriggerAddAction(gg_trg_AncientEarth, function Trig_AncientEarth_Actions)
endfunction


//===========================================================================
// Trigger: AncientDarkness
//===========================================================================
function Trig_AncientDarkness_Func001Func006001 takes nothing returns boolean
    return ( udg_Bans == 0 )
endfunction

function Trig_AncientDarkness_Func001Func006002 takes nothing returns boolean
    return ( udg_BannedAncientDarkness == 1.00 )
endfunction

function Trig_AncientDarkness_Func001C takes nothing returns boolean
    if ( not GetBooleanOr((udg_Bans == 0), (udg_BannedAncientDarkness == 1.00)) ) then // INLINED!!
        return false
    endif
    return true
endfunction

function Trig_AncientDarkness_Actions takes nothing returns nothing
    if ( Trig_AncientDarkness_Func001C() ) then
        call DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        set udg_Bans=( udg_Bans - 1 )
        set udg_BannedAncientDarkness=1.00
        call DisplayTextToForce(GetPlayersAll(), ( "Ancient of Darkness banned. Bans remaining: " + I2S(udg_Bans) ))
    endif
endfunction

//===========================================================================
function InitTrig_AncientDarkness takes nothing returns nothing
    set gg_trg_AncientDarkness=CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_AncientDarkness, Player(0), "-ban Darkness", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_AncientDarkness, Player(0), "-ban Paranoia", true)
    call TriggerAddAction(gg_trg_AncientDarkness, function Trig_AncientDarkness_Actions)
endfunction


//===========================================================================
// Trigger: AncientIce
//===========================================================================
function Trig_AncientIce_Func001Func006001 takes nothing returns boolean
    return ( udg_Bans == 0 )
endfunction

function Trig_AncientIce_Func001Func006002 takes nothing returns boolean
    return ( udg_BannedAncientIce == 1.00 )
endfunction

function Trig_AncientIce_Func001C takes nothing returns boolean
    if ( not GetBooleanOr((udg_Bans == 0), (udg_BannedAncientIce == 1.00)) ) then // INLINED!!
        return false
    endif
    return true
endfunction

function Trig_AncientIce_Actions takes nothing returns nothing
    if ( Trig_AncientIce_Func001C() ) then
        call DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        set udg_Bans=( udg_Bans - 1 )
        set udg_BannedAncientIce=1.00
        call DisplayTextToForce(GetPlayersAll(), ( "Ancient of Ice banned. Bans remaining: " + I2S(udg_Bans) ))
    endif
endfunction

//===========================================================================
function InitTrig_AncientIce takes nothing returns nothing
    set gg_trg_AncientIce=CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_AncientIce, Player(0), "-ban Ice", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_AncientIce, Player(0), "-ban Avalanche", true)
    call TriggerAddAction(gg_trg_AncientIce, function Trig_AncientIce_Actions)
endfunction


//===========================================================================
// Trigger: AncientFire
//===========================================================================
function Trig_AncientFire_Func001Func006001 takes nothing returns boolean
    return ( udg_Bans == 1 )
endfunction

function Trig_AncientFire_Func001Func006002 takes nothing returns boolean
    return ( udg_BannedAncientFire == 1.00 )
endfunction

function Trig_AncientFire_Func001C takes nothing returns boolean
    if ( not GetBooleanOr((udg_Bans == 1), (udg_BannedAncientFire == 1.00)) ) then // INLINED!!
        return false
    endif
    return true
endfunction

function Trig_AncientFire_Actions takes nothing returns nothing
    if ( Trig_AncientFire_Func001C() ) then
        call DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        set udg_Bans=( udg_Bans - 1 )
        set udg_BannedAncientFire=1.00
        call DisplayTextToForce(GetPlayersAll(), ( "Ancient of Fire banned. Bans remaining: " + I2S(udg_Bans) ))
    endif
endfunction

//===========================================================================
function InitTrig_AncientFire takes nothing returns nothing
    set gg_trg_AncientFire=CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_AncientFire, Player(0), "-ban Fire", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_AncientFire, Player(0), "-ban Ignite", true)
    call TriggerAddAction(gg_trg_AncientFire, function Trig_AncientFire_Actions)
endfunction


//===========================================================================
// Trigger: AncientNature
//===========================================================================
function Trig_AncientNature_Func001Func006001 takes nothing returns boolean
    return ( udg_Bans == 0 )
endfunction

function Trig_AncientNature_Func001Func006002 takes nothing returns boolean
    return ( udg_BannedAncientNature == 1.00 )
endfunction

function Trig_AncientNature_Func001C takes nothing returns boolean
    if ( not GetBooleanOr((udg_Bans == 0), (udg_BannedAncientNature == 1.00)) ) then // INLINED!!
        return false
    endif
    return true
endfunction

function Trig_AncientNature_Actions takes nothing returns nothing
    if ( Trig_AncientNature_Func001C() ) then
        call DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        set udg_Bans=( udg_Bans - 1 )
        set udg_BannedAncientNature=1.00
        call DisplayTextToForce(GetPlayersAll(), ( "Ancient of Nature banned. Bans remaining: " + I2S(udg_Bans) ))
    endif
endfunction

//===========================================================================
function InitTrig_AncientNature takes nothing returns nothing
    set gg_trg_AncientNature=CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_AncientNature, Player(0), "-ban Nature", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_AncientNature, Player(0), "-ban Eternity", true)
    call TriggerAddAction(gg_trg_AncientNature, function Trig_AncientNature_Actions)
endfunction


//===========================================================================
// Trigger: AncientSand
//===========================================================================
function Trig_AncientSand_Func001Func006001 takes nothing returns boolean
    return ( udg_Bans == 0 )
endfunction

function Trig_AncientSand_Func001Func006002 takes nothing returns boolean
    return ( udg_BannedAncientSand == 1.00 )
endfunction

function Trig_AncientSand_Func001C takes nothing returns boolean
    if ( not GetBooleanOr((udg_Bans == 0), (udg_BannedAncientSand == 1.00)) ) then // INLINED!!
        return false
    endif
    return true
endfunction

function Trig_AncientSand_Actions takes nothing returns nothing
    if ( Trig_AncientSand_Func001C() ) then
        call DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        set udg_Bans=( udg_Bans - 1 )
        set udg_BannedAncientSand=1.00
        call DisplayTextToForce(GetPlayersAll(), ( "Ancient of Sand banned. Bans remaining: " + I2S(udg_Bans) ))
    endif
endfunction

//===========================================================================
function InitTrig_AncientSand takes nothing returns nothing
    set gg_trg_AncientSand=CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_AncientSand, Player(0), "-ban Sand", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_AncientSand, Player(0), "-ban Pharaoh", true)
    call TriggerAddAction(gg_trg_AncientSand, function Trig_AncientSand_Actions)
endfunction


//===========================================================================
// Trigger: AncientSpace
//===========================================================================
function Trig_AncientSpace_Func001Func010001 takes nothing returns boolean
    return ( udg_Bans == 0 )
endfunction

function Trig_AncientSpace_Func001Func010002 takes nothing returns boolean
    return ( udg_BannedAncientSpace == 1.00 )
endfunction

function Trig_AncientSpace_Func001C takes nothing returns boolean
    if ( not GetBooleanOr((udg_Bans == 0), (udg_BannedAncientSpace == 1.00)) ) then // INLINED!!
        return false
    endif
    return true
endfunction

function Trig_AncientSpace_Actions takes nothing returns nothing
    if ( Trig_AncientSpace_Func001C() ) then
        call DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        set udg_Bans=( udg_Bans - 1 )
        set udg_BannedAncientSpace=1.00
        call DisplayTextToForce(GetPlayersAll(), ( "Ancient of Space banned. Bans remaining: " + I2S(udg_Bans) ))
    endif
endfunction

//===========================================================================
function InitTrig_AncientSpace takes nothing returns nothing
    set gg_trg_AncientSpace=CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_AncientSpace, Player(0), "-ban Space", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_AncientSpace, Player(0), "-ban Nebula", true)
    call TriggerAddAction(gg_trg_AncientSpace, function Trig_AncientSpace_Actions)
endfunction


//===========================================================================
// Trigger: AncientWind
//===========================================================================
function Trig_AncientWind_Func001Func011001 takes nothing returns boolean
    return ( udg_Bans == 0 )
endfunction

function Trig_AncientWind_Func001Func011002 takes nothing returns boolean
    return ( udg_BannedAncientWind == 1.00 )
endfunction

function Trig_AncientWind_Func001C takes nothing returns boolean
    if ( not GetBooleanOr((udg_Bans == 0), (udg_BannedAncientWind == 1.00)) ) then // INLINED!!
        return false
    endif
    return true
endfunction

function Trig_AncientWind_Actions takes nothing returns nothing
    if ( Trig_AncientWind_Func001C() ) then
        call DisplayTextToForce(GetPlayersAll(), "Ban failed.")
    else
        set udg_Bans=( udg_Bans - 1 )
        set udg_BannedAncientWind=1.00
        call DisplayTextToForce(GetPlayersAll(), ( "Ancient of Wind banned. Bans remaining: " + I2S(udg_Bans) ))
    endif
endfunction

//===========================================================================
function InitTrig_AncientWind takes nothing returns nothing
    set gg_trg_AncientWind=CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_AncientWind, Player(0), "-ban Wind", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_AncientWind, Player(0), "-ban Wispari", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_AncientWind, Player(0), "-ban Wisperi", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_AncientWind, Player(0), "-ban Whispari", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_AncientWind, Player(0), "-ban Whisperi", true)
    call TriggerAddAction(gg_trg_AncientWind, function Trig_AncientWind_Actions)
endfunction


//===========================================================================
// Trigger: Prevent Attack
//===========================================================================
function Trig_Prevent_Attack_Func002C takes nothing returns boolean
    if ( ( GetUnitTypeId(GetAttackedUnitBJ()) == 'h05B' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetAttackedUnitBJ()) == 'h02B' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetAttackedUnitBJ()) == 'n000' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetAttackedUnitBJ()) == 'n00A' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetAttackedUnitBJ()) == 'h060' ) ) then
        return true
    endif
    return false
endfunction

function Trig_Prevent_Attack_Conditions takes nothing returns boolean
    if ( not Trig_Prevent_Attack_Func002C() ) then
        return false
    endif
    return true
endfunction

function Trig_Prevent_Attack_Actions takes nothing returns nothing
    call IssueImmediateOrderBJ(GetAttacker(), "stop")
endfunction

//===========================================================================
function InitTrig_Prevent_Attack takes nothing returns nothing
    set gg_trg_Prevent_Attack=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Prevent_Attack, EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddCondition(gg_trg_Prevent_Attack, Condition(function Trig_Prevent_Attack_Conditions))
    call TriggerAddAction(gg_trg_Prevent_Attack, function Trig_Prevent_Attack_Actions)
endfunction

//===========================================================================
// Trigger: No Attacking Shops Copy 3
//===========================================================================
function Trig_No_Attacking_Shops_Copy_3_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetAttackedUnitBJ()) == 'h05B' ) ) then
        return false
    endif
    return true
endfunction

function Trig_No_Attacking_Shops_Copy_3_Actions takes nothing returns nothing
    call IssueImmediateOrderBJ(GetAttacker(), "stop")
endfunction

//===========================================================================
function InitTrig_No_Attacking_Shops_Copy_3 takes nothing returns nothing
    set gg_trg_No_Attacking_Shops_Copy_3=CreateTrigger()
    call DisableTrigger(gg_trg_No_Attacking_Shops_Copy_3)
    call TriggerRegisterAnyUnitEventBJ(gg_trg_No_Attacking_Shops_Copy_3, EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddCondition(gg_trg_No_Attacking_Shops_Copy_3, Condition(function Trig_No_Attacking_Shops_Copy_3_Conditions))
    call TriggerAddAction(gg_trg_No_Attacking_Shops_Copy_3, function Trig_No_Attacking_Shops_Copy_3_Actions)
endfunction

//===========================================================================
// Trigger: No Attacking Shops Copy 2
//===========================================================================
function Trig_No_Attacking_Shops_Copy_2_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetAttackedUnitBJ()) == 'h02B' ) ) then
        return false
    endif
    return true
endfunction

function Trig_No_Attacking_Shops_Copy_2_Actions takes nothing returns nothing
    call IssueImmediateOrderBJ(GetAttacker(), "stop")
endfunction

//===========================================================================
function InitTrig_No_Attacking_Shops_Copy_2 takes nothing returns nothing
    set gg_trg_No_Attacking_Shops_Copy_2=CreateTrigger()
    call DisableTrigger(gg_trg_No_Attacking_Shops_Copy_2)
    call TriggerRegisterAnyUnitEventBJ(gg_trg_No_Attacking_Shops_Copy_2, EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddCondition(gg_trg_No_Attacking_Shops_Copy_2, Condition(function Trig_No_Attacking_Shops_Copy_2_Conditions))
    call TriggerAddAction(gg_trg_No_Attacking_Shops_Copy_2, function Trig_No_Attacking_Shops_Copy_2_Actions)
endfunction

//===========================================================================
// Trigger: No Attacking Shops Copy
//===========================================================================
function Trig_No_Attacking_Shops_Copy_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetAttackedUnitBJ()) == 'n000' ) ) then
        return false
    endif
    return true
endfunction

function Trig_No_Attacking_Shops_Copy_Actions takes nothing returns nothing
    call IssueImmediateOrderBJ(GetAttacker(), "stop")
endfunction

//===========================================================================
function InitTrig_No_Attacking_Shops_Copy takes nothing returns nothing
    set gg_trg_No_Attacking_Shops_Copy=CreateTrigger()
    call DisableTrigger(gg_trg_No_Attacking_Shops_Copy)
    call TriggerRegisterAnyUnitEventBJ(gg_trg_No_Attacking_Shops_Copy, EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddCondition(gg_trg_No_Attacking_Shops_Copy, Condition(function Trig_No_Attacking_Shops_Copy_Conditions))
    call TriggerAddAction(gg_trg_No_Attacking_Shops_Copy, function Trig_No_Attacking_Shops_Copy_Actions)
endfunction

//===========================================================================
// Trigger: No Attacking Shops
//===========================================================================
function Trig_No_Attacking_Shops_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetAttackedUnitBJ()) == 'n00A' ) ) then
        return false
    endif
    return true
endfunction

function Trig_No_Attacking_Shops_Actions takes nothing returns nothing
    call IssueImmediateOrderBJ(GetAttacker(), "stop")
endfunction

//===========================================================================
function InitTrig_No_Attacking_Shops takes nothing returns nothing
    set gg_trg_No_Attacking_Shops=CreateTrigger()
    call DisableTrigger(gg_trg_No_Attacking_Shops)
    call TriggerRegisterAnyUnitEventBJ(gg_trg_No_Attacking_Shops, EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddCondition(gg_trg_No_Attacking_Shops, Condition(function Trig_No_Attacking_Shops_Conditions))
    call TriggerAddAction(gg_trg_No_Attacking_Shops, function Trig_No_Attacking_Shops_Actions)
endfunction

//===========================================================================
// Trigger: Ally neutral
//===========================================================================
function Trig_Ally_neutral_Actions takes nothing returns nothing
    call SetPlayerAllianceStateBJ(Player(6), Player(PLAYER_NEUTRAL_AGGRESSIVE), bj_ALLIANCE_ALLIED)
endfunction

//===========================================================================
function InitTrig_Ally_neutral takes nothing returns nothing
    set gg_trg_Ally_neutral=CreateTrigger()
    call TriggerAddAction(gg_trg_Ally_neutral, function Trig_Ally_neutral_Actions)
endfunction

//===========================================================================
// Trigger: Vision
//===========================================================================
function Trig_Vision_Actions takes nothing returns nothing
    call FogMaskEnableOff()
endfunction

//===========================================================================
function InitTrig_Vision takes nothing returns nothing
    set gg_trg_Vision=CreateTrigger()
    call TriggerAddAction(gg_trg_Vision, function Trig_Vision_Actions)
endfunction

//===========================================================================
// Trigger: Death anim
//===========================================================================
function Trig_Death_anim_Actions takes nothing returns nothing
    call RemoveUnit(GetDecayingUnit())
endfunction

//===========================================================================
function InitTrig_Death_anim takes nothing returns nothing
    set gg_trg_Death_anim=CreateTrigger()
    call TriggerRegisterTimerEventPeriodic(gg_trg_Death_anim, 1.00)
    call TriggerAddAction(gg_trg_Death_anim, function Trig_Death_anim_Actions)
endfunction

//===========================================================================
// Trigger: Quests
//===========================================================================
function Trig_Quests_Actions takes nothing returns nothing
    call CreateQuestBJ(bj_QUESTTYPE_REQ_DISCOVERED, "TRIGSTR_973", "TRIGSTR_974", "ReplaceableTextures\\CommandButtons\\BTNSpellBookBLS.blp")
    call CreateQuestBJ(bj_QUESTTYPE_REQ_DISCOVERED, "TRIGSTR_584", "TRIGSTR_653", "ReplaceableTextures\\CommandButtons\\BTNGarithos.blp")
    call CreateQuestBJ(bj_QUESTTYPE_REQ_DISCOVERED, "TRIGSTR_5854", "TRIGSTR_5855", "ReplaceableTextures\\CommandButtons\\BTNSpellBookBLS.blp")
    call CreateQuestBJ(bj_QUESTTYPE_REQ_DISCOVERED, "TRIGSTR_6309", "TRIGSTR_6310", "ReplaceableTextures\\CommandButtons\\BTNTomeBrown.blp")
    call CreateQuestBJ(bj_QUESTTYPE_OPT_DISCOVERED, "TRIGSTR_812", "TRIGSTR_813", "ReplaceableTextures\\CommandButtons\\BTNFlakCannons.blp")
    call CreateQuestBJ(bj_QUESTTYPE_OPT_DISCOVERED, "TRIGSTR_3707", "TRIGSTR_4488", "ReplaceableTextures\\CommandButtons\\BTNTemp.blp")
    call CreateQuestBJ(bj_QUESTTYPE_OPT_DISCOVERED, "TRIGSTR_2160", "TRIGSTR_2162", "ReplaceableTextures\\CommandButtons\\BTNWispSplode.blp")
    call CreateQuestBJ(bj_QUESTTYPE_OPT_DISCOVERED, "TRIGSTR_2142", "TRIGSTR_2143", "ReplaceableTextures\\CommandButtons\\BTNEngineeringUpgrade.blp")
    call CreateQuestBJ(bj_QUESTTYPE_OPT_DISCOVERED, "TRIGSTR_5649", "TRIGSTR_6783", "ReplaceableTextures\\CommandButtons\\BTNChestOfGold.blp")
endfunction

//===========================================================================
function InitTrig_Quests takes nothing returns nothing
    set gg_trg_Quests=CreateTrigger()
    call TriggerAddAction(gg_trg_Quests, function Trig_Quests_Actions)
endfunction

//===========================================================================
// Trigger: Warning few seconds
//===========================================================================
function Trig_Warning_few_seconds_Actions takes nothing returns nothing
    call DisplayTextToForce(GetPlayersAllies(Player(0)), "TRIGSTR_3592")
endfunction

//===========================================================================
function InitTrig_Warning_few_seconds takes nothing returns nothing
    set gg_trg_Warning_few_seconds=CreateTrigger()
    call TriggerRegisterTimerEventSingle(gg_trg_Warning_few_seconds, 40.00)
    call TriggerAddAction(gg_trg_Warning_few_seconds, function Trig_Warning_few_seconds_Actions)
endfunction

//===========================================================================
// Trigger: Camera Copy
//===========================================================================
function Trig_Camera_Copy_Actions takes nothing returns nothing
    call SetCameraBoundsToRectForPlayerBJ(GetOwningPlayer(GetTriggerUnit()), GetEntireMapRect())
    call PanCameraToTimedLocForPlayer(GetOwningPlayer(GetTriggerUnit()), GetUnitLoc(GetTriggerUnit()), 0)
endfunction

//===========================================================================
function InitTrig_Camera_Copy takes nothing returns nothing
    set gg_trg_Camera_Copy=CreateTrigger()
    call TriggerRegisterEnterRectSimple(gg_trg_Camera_Copy, gg_rct_Tele_out_D)
    call TriggerRegisterEnterRectSimple(gg_trg_Camera_Copy, gg_rct_Tele_out_E)
    call TriggerAddAction(gg_trg_Camera_Copy, function Trig_Camera_Copy_Actions)
endfunction

//===========================================================================
// Trigger: LatePickers
//===========================================================================
// ================================================
// Ancient Teleport System
// ================================================


// Function to check if a unit is "Ancient"
function IsUnitAncient takes unit u returns boolean
    if IsUnitType(u, UNIT_TYPE_ANCIENT) then
        return true
    endif
    return false
endfunction

// Function to get a random allied ancient unit
function GetRandomAlliedAncient takes player p returns unit
    local group g= CreateGroup()
    local group ancientUnits= CreateGroup()
    local unit u= null
    local unit result= null
    local integer i= 0
    
    // Enumerate units of all players
    set i=0
    loop
        exitwhen i >= bj_MAX_PLAYER_SLOTS
        call GroupEnumUnitsOfPlayer(g, Player(i), null)
	// Filter for ancient units
	if p != Player(i) then
		loop
        		set u=FirstOfGroup(g)
        		exitwhen u == null
        		call GroupRemoveUnit(g, u)
        
        		if IsUnitAncient(u) then
        	    	call GroupAddUnit(ancientUnits, u)
        		endif
    		endloop
	endif
        set i=i + 1
    endloop
    
    
    
    // Pick random ancient unit
    if CountUnitsInGroup(ancientUnits) > 0 then
        set result=GroupPickRandomUnit(ancientUnits)
    endif
    
    // Cleanup
    call DestroyGroup(g)
    call DestroyGroup(ancientUnits)
    set g=null
    set ancientUnits=null
    set u=null
    
    return result
endfunction

// Main teleport action function
function Trig_AncientTeleport_Actions takes nothing returns nothing
    local unit enteringUnit= GetTriggerUnit()
    local player unitOwner= GetOwningPlayer(enteringUnit)
    local unit targetAncient= null
    local real oldX= 0.0
    local real oldY= 0.0
    local real newX= 0.0
    local real newY= 0.0
    // Find random allied ancient unit
    set targetAncient=GetRandomAlliedAncient(unitOwner)
    
    // Teleport if ancient unit found
    if targetAncient != null then
        // Save original coordinates for effect
        set oldX=GetUnitX(enteringUnit)
        set oldY=GetUnitY(enteringUnit)
        set newX=GetUnitX(targetAncient)
        set newY=GetUnitY(targetAncient)
        
        // Teleport the unit
        call SetUnitPosition(enteringUnit, newX, newY)
        
        // Create teleport effects
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Human\\MassTeleport\\MassTeleportTarget.mdl", oldX, oldY))
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Human\\MassTeleport\\MassTeleportTarget.mdl", newX, newY))
        
        // Optional: Display message to player
        call DisplayTextToPlayer(unitOwner, 0, 0, "|cff00ff00Successfully teleported to allied expander!|r")
    endif
    
    // Cleanup
    set enteringUnit=null
    set unitOwner=null
    set targetAncient=null
endfunction

// Timer function to enable the trigger after X seconds
function EnableTeleportSystem takes nothing returns nothing
    call EnableTrigger(gg_trg_AncientTeleport)
    call DestroyTimer(GetExpiredTimer())
    set TeleportEnableTimer=null
    
    // Display global message
    call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS, 10.0, "|cff00ff00Late Pick Teleportation is now active!|r")
endfunction

// ================================================
// Initialization Function
// ================================================
function InitTrig_LatePickers takes nothing returns nothing
    // Create the trigger
    set gg_trg_AncientTeleport=CreateTrigger()
    
    // Create a region from the rect
    set teleportRegion=CreateRegion()
    call RegionAddRect(teleportRegion, gg_rct_Tele_out_E)
    
    // Register the region event
    call TriggerRegisterEnterRegion(gg_trg_AncientTeleport, teleportRegion, null)
    
    // Add the action
    call TriggerAddAction(gg_trg_AncientTeleport, function Trig_AncientTeleport_Actions)
    
    // Initially disable the trigger
    call DisableTrigger(gg_trg_AncientTeleport)
    
    // Create and start timer to enable after 50 seconds
    set TeleportEnableTimer=CreateTimer()
    call TimerStart(TeleportEnableTimer, ENABLE_DELAY, false, function EnableTeleportSystem)
    
    // Display initial message
    call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS, 10.0, "|cffffcc00Ancient will spawn in 60 seconds, don't take too much time to pick...|r")
endfunction
//===========================================================================
// Trigger: AncientSpawnTele
//===========================================================================
function Trig_AncientSpawnTele_Actions takes nothing returns nothing
    call SetUnitPositionLoc(GetTriggerUnit(), GetRectCenter(gg_rct_Spawn_all))
endfunction

//===========================================================================
function InitTrig_AncientSpawnTele takes nothing returns nothing
    set gg_trg_AncientSpawnTele=CreateTrigger()
    call TriggerRegisterEnterRectSimple(gg_trg_AncientSpawnTele, gg_rct_Tele_out_D)
    call TriggerRegisterEnterRectSimple(gg_trg_AncientSpawnTele, gg_rct_Tele_out_E)
    call TriggerAddAction(gg_trg_AncientSpawnTele, function Trig_AncientSpawnTele_Actions)
endfunction

//===========================================================================
// Trigger: Player group
//===========================================================================
function Trig_Player_group_Func001002 takes nothing returns nothing
    call ForceAddPlayerSimple(GetEnumPlayer(), bj_FORCE_PLAYER[0])
endfunction

function Trig_Player_group_Func003002001001 takes nothing returns boolean
    return ( GetPlayerSlotState(GetFilterPlayer()) == PLAYER_SLOT_STATE_PLAYING )
endfunction

function Trig_Player_group_Func004C takes nothing returns boolean
    if ( not ( GetPlayerSlotState(Player(6)) == PLAYER_SLOT_STATE_PLAYING ) ) then
        return false
    endif
    return true
endfunction

function Trig_Player_group_Actions takes nothing returns nothing
    call ForForce(GetPlayersAll(), function Trig_Player_group_Func001002)
    call ForceRemovePlayerSimple(Player(6), bj_FORCE_PLAYER[0])
    set udg_StillAlive=CountPlayersInForceBJ(GetPlayersMatching(Condition(function Trig_Player_group_Func003002001001)))
    if ( Trig_Player_group_Func004C() ) then
        set udg_StillAlive=( udg_StillAlive - 1 )
    else
    endif
    call DisplayTextToForce(GetPlayersAll(), ( "Loaded " + ( I2S(udg_StillAlive) + " expanders" ) ))
endfunction

//===========================================================================
function InitTrig_Player_group takes nothing returns nothing
    set gg_trg_Player_group=CreateTrigger()
    call TriggerAddAction(gg_trg_Player_group, function Trig_Player_group_Actions)
endfunction

//===========================================================================
// Trigger: Lackey Respawn
//===========================================================================

function LackeyRespawn_IsValidType takes integer unitType returns boolean
    return unitType == 'e00E' or unitType == 'e00C' or unitType == 'e002' or unitType == 'e009' or unitType == 'e00A' or unitType == 'e00G' or unitType == 'e00J' or unitType == 'e00O' or unitType == 'e00H' or unitType == 'e00N' or unitType == 'e00S'
endfunction

function LackeyRespawn_IsPlayerPresent takes integer playerId returns boolean
    return GetPlayerSlotState(Player(playerId)) == PLAYER_SLOT_STATE_PLAYING
endfunction

function LackeyRespawn_OnTimer takes nothing returns nothing
    local timer t= GetExpiredTimer()
    local integer id= GetHandleId(t)
    local integer unitType= LoadInteger(LackeyRespawn_Hash, id, LACK_RESPAWN_KEY_TYPE)
    local integer playerId= LoadInteger(LackeyRespawn_Hash, id, LACK_RESPAWN_KEY_PLAYER)
    local timerdialog td= LoadTimerDialogHandle(LackeyRespawn_Hash, id, LACK_RESPAWN_KEY_DIALOG)
    local real x= GetRectCenterX(gg_rct_Alarm)
    local real y= GetRectCenterY(gg_rct_Alarm)

    if (GetPlayerSlotState(Player((playerId))) == PLAYER_SLOT_STATE_PLAYING) then // INLINED!!
        call CreateUnit(Player(playerId), unitType, x, y, bj_UNIT_FACING)
    endif

    call TimerDialogDisplay(td, false)
    call DestroyTimerDialog(td)

    call FlushChildHashtable(LackeyRespawn_Hash, id)
    call PauseTimer(t)
    call DestroyTimer(t)

    set td=null
    set t=null
endfunction

function Trig_Lackey_Respawn_Conditions takes nothing returns boolean
    return LackeyRespawn_IsValidType(GetUnitTypeId(GetTriggerUnit()))
endfunction

function Trig_Lackey_Respawn_Actions takes nothing returns nothing
    local unit dying= GetTriggerUnit()
    local player owner= GetOwningPlayer(dying)
    local integer unitType= GetUnitTypeId(dying)
    local integer playerId= GetPlayerId(owner)
    local timer t= null
    local timerdialog td= null
    local integer id= 0

    if not (GetPlayerSlotState(Player((playerId))) == PLAYER_SLOT_STATE_PLAYING) then // INLINED!!
        set dying=null
        set owner=null
        return
    endif

    set t=CreateTimer()
    set td=CreateTimerDialog(t)
    set id=GetHandleId(t)

    call SaveInteger(LackeyRespawn_Hash, id, LACK_RESPAWN_KEY_TYPE, unitType)
    call SaveInteger(LackeyRespawn_Hash, id, LACK_RESPAWN_KEY_PLAYER, playerId)
    call SaveTimerDialogHandle(LackeyRespawn_Hash, id, LACK_RESPAWN_KEY_DIALOG, td)

    call TimerDialogSetTitle(td, "Lackey respawn")

    if GetLocalPlayer() == owner then
        call TimerDialogDisplay(td, true)
    endif

    call TimerStart(t, LACK_RESPAWN_DELAY, false, function LackeyRespawn_OnTimer)

    set dying=null
    set owner=null
    set td=null
    set t=null
endfunction

//===========================================================================
function InitTrig_Lackey_Respawn takes nothing returns nothing
    set gg_trg_Lackey_Respawn=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Lackey_Respawn, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Lackey_Respawn, Condition(function Trig_Lackey_Respawn_Conditions))
    call TriggerAddAction(gg_trg_Lackey_Respawn, function Trig_Lackey_Respawn_Actions)
endfunction
//===========================================================================
// Trigger: Death start
//===========================================================================
function Trig_Death_start_Conditions takes nothing returns boolean
    if ( not ( IsUnitType(GetTriggerUnit(), UNIT_TYPE_STRUCTURE) == false ) ) then
        return false
    endif
    if ( not ( IsUnitType(GetTriggerUnit(), UNIT_TYPE_ANCIENT) == true ) ) then
        return false
    endif
    if ( not ( IsUnitEnemy(GetDyingUnit(), Player(6)) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Death_start_Func002002 takes nothing returns nothing
    call RemoveUnit(GetEnumUnit())
endfunction

function Trig_Death_start_Func010Func001C takes nothing returns boolean
    if ( not ( IsPlayerAlly(udg_DeadPlayer, GetEnumPlayer()) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Death_start_Func010A takes nothing returns nothing
    if ( Trig_Death_start_Func010Func001C() ) then
        call SetPlayerAllianceStateBJ(udg_DeadPlayer, GetEnumPlayer(), bj_ALLIANCE_UNALLIED)
        call SetPlayerAllianceStateBJ(GetEnumPlayer(), udg_DeadPlayer, bj_ALLIANCE_UNALLIED)
    else
    endif
endfunction

function Trig_Death_start_Func011Func001C takes nothing returns boolean
    return true
endfunction

function Trig_Death_start_Func011A takes nothing returns nothing
    if ( (true) ) then // INLINED!!
        call SetPlayerAllianceStateBJ(udg_DeadPlayer, GetEnumPlayer(), bj_ALLIANCE_ALLIED_VISION)
        call SetPlayerAllianceStateBJ(GetEnumPlayer(), udg_DeadPlayer, bj_ALLIANCE_ALLIED_VISION)
    else
    endif
endfunction

function Trig_Death_start_Actions takes nothing returns nothing
    set udg_Flags[GetConvertedPlayerId(GetOwningPlayer(GetDyingUnit()))]=false
    call ForGroupBJ(GetUnitsOfPlayerAll(GetOwningPlayer(GetDyingUnit())), function Trig_Death_start_Func002002)
    set udg_StillAlive=( udg_StillAlive - 1 )
    set udg_DeadPlayer=GetOwningPlayer(GetDyingUnit())
    set udg_LocationOfDeath=GetUnitLoc(GetKillingUnitBJ())
    set udg_SeedOfRebirth[GetConvertedPlayerId(GetOwningPlayer(GetDyingUnit()))]=GetUnitTypeId(GetDyingUnit())

    call AddSpecialEffectLocBJ(GetUnitLoc(GetDyingUnit()), "Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl")
    call ConditionalTriggerExecute(gg_trg_Spawn_Lackey)

    call ForForce(GetPlayersAll(), function Trig_Death_start_Func010A)
    call ForForce(GetPlayersAllies(Player(6)), function Trig_Death_start_Func011A)
    call SetPlayerAllianceStateBJ(GetOwningPlayer(GetDyingUnit()), Player(6), bj_ALLIANCE_ALLIED_VISION)
    call SetPlayerAllianceStateBJ(Player(6), GetOwningPlayer(GetDyingUnit()), bj_ALLIANCE_ALLIED_VISION)
endfunction

//===========================================================================
function InitTrig_Death_start takes nothing returns nothing
    set gg_trg_Death_start=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Death_start, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Death_start, Condition(function Trig_Death_start_Conditions))
    call TriggerAddAction(gg_trg_Death_start, function Trig_Death_start_Actions)
endfunction
//===========================================================================
// Trigger: Spawn Lackey
//===========================================================================

function SpawnLackey_EnsureSetup takes nothing returns nothing
    if SpawnLackey_Hash == null then
        set SpawnLackey_Hash=InitHashtable()
    endif

    if SpawnLackey_GameTimer == null then
        set SpawnLackey_GameTimer=CreateTimer()
        call TimerStart(SpawnLackey_GameTimer, 999999.00, false, null)
    endif
endfunction

function SpawnLackey_GetFountainCenterX takes nothing returns real
    return ( GetRectMinX(gg_rct_Fountain) + GetRectMaxX(gg_rct_Fountain) ) * 0.50
endfunction

function SpawnLackey_GetFountainCenterY takes nothing returns real
    return ( GetRectMinY(gg_rct_Fountain) + GetRectMaxY(gg_rct_Fountain) ) * 0.50
endfunction

function SpawnLackey_PanCameraToFountainForPlayer takes player whichPlayer returns nothing
    local real x= (( GetRectMinX(gg_rct_Fountain) + GetRectMaxX(gg_rct_Fountain) ) * 0.50) // INLINED!!
    local real y= (( GetRectMinY(gg_rct_Fountain) + GetRectMaxY(gg_rct_Fountain) ) * 0.50) // INLINED!!

    if GetLocalPlayer() == whichPlayer then
        call PanCameraToTimed(x, y, 0.00)
    endif
endfunction

function SpawnLackey_GetLackeyType takes nothing returns integer
    local integer ancientUnitType= GetUnitTypeId(udg_AncientUnit)

    if ancientUnitType == 'O00A' then
        return 'e00C'
    endif
    if ancientUnitType == 'O00S' then
        return 'e002'
    endif
    if ancientUnitType == 'O00L' then
        return 'e009'
    endif
    if ancientUnitType == 'O004' then
        return 'e00A'
    endif
    if ancientUnitType == 'O008' then
        return 'e00N'
    endif
    if ancientUnitType == 'O01V' then
        return 'e00G'
    endif
    if ancientUnitType == 'O016' then
        return 'e00J'
    endif
    if ancientUnitType == 'O00D' then
        return 'e00O'
    endif
    if ancientUnitType == 'O01X' then
        return 'e00H'
    endif
    if ancientUnitType == 'O01Z' then
        return 'e00E'
    endif
    if ancientUnitType == 'O01D' then
        return 'e00S'
    endif

    return 0
endfunction

function SpawnLackey_CreateAtXY takes player deadPlayer,integer lackeyType,real x,real y returns nothing
    local unit lackey= null

    if lackeyType == 0 then
        return
    endif

    set lackey=CreateUnit(deadPlayer, lackeyType, x, y, bj_UNIT_FACING)

    if lackey != null then
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl", GetUnitX(lackey), GetUnitY(lackey)))
    endif

    set lackey=null
endfunction

function SpawnLackey_CreateAtLoc takes player deadPlayer,integer lackeyType,location spawnLoc returns nothing
    call SpawnLackey_CreateAtXY(deadPlayer , lackeyType , GetLocationX(spawnLoc) , GetLocationY(spawnLoc))
endfunction

function SpawnLackey_DelayedTimerExpires takes nothing returns nothing
    local timer t= GetExpiredTimer()
    local integer timerId= GetHandleId(t)
    local integer playerIndex= LoadInteger(SpawnLackey_Hash, timerId, 0)
    local integer lackeyType= LoadInteger(SpawnLackey_Hash, timerId, 1)
    local player deadPlayer= Player(playerIndex)
    local real x= (( GetRectMinX(gg_rct_Fountain) + GetRectMaxX(gg_rct_Fountain) ) * 0.50) // INLINED!!
    local real y= (( GetRectMinY(gg_rct_Fountain) + GetRectMaxY(gg_rct_Fountain) ) * 0.50) // INLINED!!

    call SpawnLackey_CreateAtXY(deadPlayer , lackeyType , x , y)
    call SpawnLackey_PanCameraToFountainForPlayer(deadPlayer)

    if SpawnLackey_PlayerDialog[playerIndex] != null then
        call TimerDialogDisplay(SpawnLackey_PlayerDialog[playerIndex], false)
        call DestroyTimerDialog(SpawnLackey_PlayerDialog[playerIndex])
        set SpawnLackey_PlayerDialog[playerIndex]=null
    endif

    set SpawnLackey_PlayerTimer[playerIndex]=null

    call FlushChildHashtable(SpawnLackey_Hash, timerId)
    call DestroyTimer(t)

    set t=null
    set deadPlayer=null
endfunction

function SpawnLackey_StartDelayedTimer takes player deadPlayer,integer lackeyType,real remaining returns nothing
    local integer playerIndex= GetPlayerId(deadPlayer)
    local timer t= CreateTimer()

    call SpawnLackey_EnsureSetup()

    if remaining < 0.00 then
        set remaining=0.00
    endif

    if SpawnLackey_PlayerTimer[playerIndex] != null then
        call PauseTimer(SpawnLackey_PlayerTimer[playerIndex])
        call FlushChildHashtable(SpawnLackey_Hash, GetHandleId(SpawnLackey_PlayerTimer[playerIndex]))
        call DestroyTimer(SpawnLackey_PlayerTimer[playerIndex])
        set SpawnLackey_PlayerTimer[playerIndex]=null
    endif

    if SpawnLackey_PlayerDialog[playerIndex] != null then
        call TimerDialogDisplay(SpawnLackey_PlayerDialog[playerIndex], false)
        call DestroyTimerDialog(SpawnLackey_PlayerDialog[playerIndex])
        set SpawnLackey_PlayerDialog[playerIndex]=null
    endif

    set SpawnLackey_PlayerTimer[playerIndex]=t
    set SpawnLackey_PlayerDialog[playerIndex]=CreateTimerDialog(t)

    call TimerDialogSetTitle(SpawnLackey_PlayerDialog[playerIndex], "Time till lackey spawn")

    if GetLocalPlayer() == deadPlayer then
        call TimerDialogDisplay(SpawnLackey_PlayerDialog[playerIndex], true)
    endif

    call SaveInteger(SpawnLackey_Hash, GetHandleId(t), 0, playerIndex)
    call SaveInteger(SpawnLackey_Hash, GetHandleId(t), 1, lackeyType)

    call TimerStart(t, remaining, false, function SpawnLackey_DelayedTimerExpires)

    set t=null
endfunction

function Trig_Spawn_Lackey_Actions takes nothing returns nothing
    local player deadPlayer= udg_DeadPlayer
    local integer lackeyType= 0
    local real elapsed= 0.00
    local real remaining= 0.00

    call SpawnLackey_EnsureSetup()

    set lackeyType=SpawnLackey_GetLackeyType()
    set elapsed=TimerGetElapsed(SpawnLackey_GameTimer)
    set remaining=SPAWN_LACKEY_DELAY_MARK - elapsed

    call DisplayTextToForce(GetPlayersAll(), GetPlayerName(GetOwningPlayer(GetDyingUnit())) + " was killed by " + GetPlayerName(GetOwningPlayer(GetKillingUnitBJ())))
    call SetPlayerStateBJ(GetOwningPlayer(GetDyingUnit()), PLAYER_STATE_RESOURCE_GOLD, 0)
    call SetPlayerStateBJ(GetOwningPlayer(GetDyingUnit()), PLAYER_STATE_RESOURCE_LUMBER, 0)

    call TriggerSleepAction(0.50)

    if lackeyType != 0 then
        if elapsed < SPAWN_LACKEY_DELAY_MARK then
            call SpawnLackey_StartDelayedTimer(deadPlayer , lackeyType , remaining)
        else
            call SpawnLackey_CreateAtLoc(deadPlayer , lackeyType , udg_LocationOfDeath)
        endif
    endif

    set deadPlayer=null
endfunction

//===========================================================================
function InitTrig_Spawn_Lackey takes nothing returns nothing
    call SpawnLackey_EnsureSetup()

    set gg_trg_Spawn_Lackey=CreateTrigger()
    call TriggerAddAction(gg_trg_Spawn_Lackey, function Trig_Spawn_Lackey_Actions)
endfunction
//===========================================================================
// Trigger: MiniMinis
//===========================================================================
function Trig_MiniMinis_Conditions takes nothing returns boolean
    if ( not ( IsUnitEnemy(GetDyingUnit(), Player(6)) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_MiniMinis_Func003C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetKillingUnitBJ()) == 'e00C' ) ) then
        return false
    endif
    return true
endfunction

function Trig_MiniMinis_Func005C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetKillingUnitBJ()) == 'e00G' ) ) then
        return false
    endif
    return true
endfunction

function Trig_MiniMinis_Func007C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetKillingUnitBJ()) == 'e00A' ) ) then
        return false
    endif
    return true
endfunction

function Trig_MiniMinis_Func009C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetKillingUnitBJ()) == 'e00N' ) ) then
        return false
    endif
    return true
endfunction

function Trig_MiniMinis_Func011C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetKillingUnitBJ()) == 'e009' ) ) then
        return false
    endif
    return true
endfunction

function Trig_MiniMinis_Func013C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetKillingUnitBJ()) == 'e00J' ) ) then
        return false
    endif
    return true
endfunction

function Trig_MiniMinis_Func015C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetKillingUnitBJ()) == 'e00O' ) ) then
        return false
    endif
    return true
endfunction

function Trig_MiniMinis_Func017C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetKillingUnitBJ()) == 'e00H' ) ) then
        return false
    endif
    return true
endfunction

function Trig_MiniMinis_Actions takes nothing returns nothing
    if ( Trig_MiniMinis_Func003C() ) then
        call AddSpecialEffectLocBJ(GetUnitLoc(GetDyingUnit()), "Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl")
        call CreateNUnitsAtLoc(1, 'e00D', GetOwningPlayer(GetKillingUnitBJ()), GetUnitLoc(GetDyingUnit()), bj_UNIT_FACING)
    else
    endif
    // 2.
    if ( Trig_MiniMinis_Func005C() ) then
        call CreateNUnitsAtLoc(1, 'e00F', GetOwningPlayer(GetKillingUnitBJ()), GetUnitLoc(GetDyingUnit()), bj_UNIT_FACING)
    else
    endif
    // 4.
    if ( Trig_MiniMinis_Func007C() ) then
        call CreateNUnitsAtLoc(1, 'e00B', GetOwningPlayer(GetKillingUnitBJ()), GetUnitLoc(GetDyingUnit()), bj_UNIT_FACING)
    else
    endif
    // 5.
    if ( Trig_MiniMinis_Func009C() ) then
        call CreateNUnitsAtLoc(1, 'e00P', GetOwningPlayer(GetKillingUnitBJ()), GetUnitLoc(GetDyingUnit()), bj_UNIT_FACING)
    else
    endif
    // 6.
    if ( Trig_MiniMinis_Func011C() ) then
        call CreateNUnitsAtLoc(1, 'e008', GetOwningPlayer(GetKillingUnitBJ()), GetUnitLoc(GetDyingUnit()), bj_UNIT_FACING)
    else
    endif
    // 7.
    if ( Trig_MiniMinis_Func013C() ) then
        call CreateNUnitsAtLoc(1, 'e00K', GetOwningPlayer(GetKillingUnitBJ()), GetUnitLoc(GetDyingUnit()), bj_UNIT_FACING)
    else
    endif
    // 8.
    if ( Trig_MiniMinis_Func015C() ) then
        call CreateNUnitsAtLoc(1, 'e00M', GetOwningPlayer(GetKillingUnitBJ()), GetUnitLoc(GetDyingUnit()), bj_UNIT_FACING)
    else
    endif
    // 9.
    if ( Trig_MiniMinis_Func017C() ) then
        call CreateNUnitsAtLoc(1, 'e00I', GetOwningPlayer(GetKillingUnitBJ()), GetUnitLoc(GetDyingUnit()), bj_UNIT_FACING)
    else
    endif
endfunction

//===========================================================================
function InitTrig_MiniMinis takes nothing returns nothing
    set gg_trg_MiniMinis=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_MiniMinis, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_MiniMinis, Condition(function Trig_MiniMinis_Conditions))
    call TriggerAddAction(gg_trg_MiniMinis, function Trig_MiniMinis_Actions)
endfunction

//===========================================================================
// Trigger: Player Leaves
//===========================================================================
function Trig_Player_Leaves_Func003002 takes nothing returns nothing
    call RemoveUnit(GetEnumUnit())
endfunction

function Trig_Player_Leaves_Actions takes nothing returns nothing
    set udg_Flags[GetConvertedPlayerId(GetTriggerPlayer())]=false
    call DisplayTextToForce(GetPlayersAll(), ( GetPlayerName(GetTriggerPlayer()) + " has left the game." ))
    call ForGroupBJ(GetUnitsOfPlayerAll(GetTriggerPlayer()), function Trig_Player_Leaves_Func003002)
endfunction

//===========================================================================
function InitTrig_Player_Leaves takes nothing returns nothing
    set gg_trg_Player_Leaves=CreateTrigger()
    call TriggerRegisterPlayerEventLeave(gg_trg_Player_Leaves, Player(0))
    call TriggerRegisterPlayerEventLeave(gg_trg_Player_Leaves, Player(1))
    call TriggerRegisterPlayerEventLeave(gg_trg_Player_Leaves, Player(2))
    call TriggerRegisterPlayerEventLeave(gg_trg_Player_Leaves, Player(3))
    call TriggerRegisterPlayerEventLeave(gg_trg_Player_Leaves, Player(4))
    call TriggerRegisterPlayerEventLeave(gg_trg_Player_Leaves, Player(5))
    call TriggerRegisterPlayerEventLeave(gg_trg_Player_Leaves, Player(7))
    call TriggerRegisterPlayerEventLeave(gg_trg_Player_Leaves, Player(8))
    call TriggerRegisterPlayerEventLeave(gg_trg_Player_Leaves, Player(9))
    call TriggerRegisterPlayerEventLeave(gg_trg_Player_Leaves, Player(10))
    call TriggerAddAction(gg_trg_Player_Leaves, function Trig_Player_Leaves_Actions)
endfunction

//===========================================================================
// Trigger: Ancient Leaves
//===========================================================================
function Trig_Ancient_Leaves_Actions takes nothing returns nothing
    local player leavingAncient= GetTriggerPlayer()

    if leavingAncient != udg_AncientPlayer then
        set leavingAncient=null
        return
    endif

    call PlayThematicMusicBJ("Tension")
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_436")
    call TriggerSleepAction(3.00)
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_5283")
    call TriggerSleepAction(120.00)

    if udg_AncientPlayer == leavingAncient then
        call CustomVictoryBJ(Player(0), true, true)
        call CustomVictoryBJ(Player(1), true, true)
        call CustomVictoryBJ(Player(2), true, true)
        call CustomVictoryBJ(Player(3), true, true)
        call CustomVictoryBJ(Player(4), true, true)
        call CustomVictoryBJ(Player(5), true, true)
        call CustomVictoryBJ(Player(7), true, true)
        call CustomVictoryBJ(Player(8), true, true)
        call CustomVictoryBJ(Player(9), true, true)
        call CustomVictoryBJ(Player(10), true, true)
    else
        call DisplayTextToForce(GetPlayersAll(), "|cff80ff80Ancient was taken over. The game will continue.|r")
    endif

    set leavingAncient=null
endfunction

//===========================================================================
function InitTrig_Ancient_Leaves takes nothing returns nothing
    local integer i= 0

    set gg_trg_Ancient_Leaves=CreateTrigger()

    loop
        exitwhen i >= 11
        call TriggerRegisterPlayerEventLeave(gg_trg_Ancient_Leaves, Player(i))
        set i=i + 1
    endloop

    call TriggerAddAction(gg_trg_Ancient_Leaves, function Trig_Ancient_Leaves_Actions)
endfunction
//===========================================================================
// Trigger: Human Dies
//===========================================================================
function Trig_Human_Dies_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'h03D' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Human_Dies_Func001C takes nothing returns boolean
    if ( not ( IsUnitInGroup(udg_HumanFlag, GetUnitsInRectOfPlayer(GetPlayableMapRect(), GetOwningPlayer(GetDyingUnit()))) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Human_Dies_Func003C takes nothing returns boolean
    return true
endfunction

function Trig_Human_Dies_Actions takes nothing returns nothing
    if ( Trig_Human_Dies_Func001C() ) then
    else
    endif
    if ( (true) ) then // INLINED!!
        call PlaySoundBJ(gg_snd_PeasantDeath)
    else
    endif
endfunction

//===========================================================================
function InitTrig_Human_Dies takes nothing returns nothing
    set gg_trg_Human_Dies=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Human_Dies, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Human_Dies, Condition(function Trig_Human_Dies_Conditions))
    call TriggerAddAction(gg_trg_Human_Dies, function Trig_Human_Dies_Actions)
endfunction

//===========================================================================
// Trigger: Wisp Dies
//===========================================================================
function Trig_Wisp_Dies_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'h02L' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Wisp_Dies_Func001C takes nothing returns boolean
    if ( not ( IsUnitInGroup(udg_WispFlag, GetUnitsInRectOfPlayer(GetPlayableMapRect(), GetOwningPlayer(GetDyingUnit()))) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Wisp_Dies_Func003C takes nothing returns boolean
    return true
endfunction

function Trig_Wisp_Dies_Actions takes nothing returns nothing
    if ( Trig_Wisp_Dies_Func001C() ) then
    else
    endif
    if ( (true) ) then // INLINED!!
        call PlaySoundBJ(gg_snd_WispPissed1)
    else
    endif
endfunction

//===========================================================================
function InitTrig_Wisp_Dies takes nothing returns nothing
    set gg_trg_Wisp_Dies=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Wisp_Dies, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Wisp_Dies, Condition(function Trig_Wisp_Dies_Conditions))
    call TriggerAddAction(gg_trg_Wisp_Dies, function Trig_Wisp_Dies_Actions)
endfunction

//===========================================================================
// Trigger: Centaur Dies
//===========================================================================
function Trig_Centaur_Dies_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'h01X' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Centaur_Dies_Func001C takes nothing returns boolean
    if ( not ( IsUnitInGroup(udg_CentaurFlag, GetUnitsInRectOfPlayer(GetPlayableMapRect(), GetOwningPlayer(GetDyingUnit()))) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Centaur_Dies_Func003C takes nothing returns boolean
    return true
endfunction

function Trig_Centaur_Dies_Actions takes nothing returns nothing
    if ( Trig_Centaur_Dies_Func001C() ) then
    else
    endif
    if ( (true) ) then // INLINED!!
        call PlaySoundBJ(gg_snd_CentaurDeath)
    else
    endif
endfunction

//===========================================================================
function InitTrig_Centaur_Dies takes nothing returns nothing
    set gg_trg_Centaur_Dies=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Centaur_Dies, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Centaur_Dies, Condition(function Trig_Centaur_Dies_Conditions))
    call TriggerAddAction(gg_trg_Centaur_Dies, function Trig_Centaur_Dies_Actions)
endfunction

//===========================================================================
// Trigger: Ogre Dies
//===========================================================================
function Trig_Ogre_Dies_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'h00F' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Ogre_Dies_Func001C takes nothing returns boolean
    if ( not ( IsUnitInGroup(udg_OgreFlag, GetUnitsInRectOfPlayer(GetPlayableMapRect(), GetOwningPlayer(GetDyingUnit()))) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Ogre_Dies_Func003C takes nothing returns boolean
    return true
endfunction

function Trig_Ogre_Dies_Actions takes nothing returns nothing
    if ( Trig_Ogre_Dies_Func001C() ) then
    else
    endif
    if ( (true) ) then // INLINED!!
        call PlaySoundBJ(gg_snd_OgreDeath1)
    else
    endif
endfunction

//===========================================================================
function InitTrig_Ogre_Dies takes nothing returns nothing
    set gg_trg_Ogre_Dies=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Ogre_Dies, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Ogre_Dies, Condition(function Trig_Ogre_Dies_Conditions))
    call TriggerAddAction(gg_trg_Ogre_Dies, function Trig_Ogre_Dies_Actions)
endfunction

//===========================================================================
// Trigger: Worgen Dies
//===========================================================================
function Trig_Worgen_Dies_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'h00R' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Worgen_Dies_Func002C takes nothing returns boolean
    return true
endfunction

function Trig_Worgen_Dies_Actions takes nothing returns nothing
    if ( (true) ) then // INLINED!!
        call PlaySoundBJ(gg_snd_SatyrDeath1)
    else
    endif
endfunction

//===========================================================================
function InitTrig_Worgen_Dies takes nothing returns nothing
    set gg_trg_Worgen_Dies=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Worgen_Dies, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Worgen_Dies, Condition(function Trig_Worgen_Dies_Conditions))
    call TriggerAddAction(gg_trg_Worgen_Dies, function Trig_Worgen_Dies_Actions)
endfunction

//===========================================================================
// Trigger: Night Elf Dies
//===========================================================================
function Trig_Night_Elf_Dies_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'h05C' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Night_Elf_Dies_Func002C takes nothing returns boolean
    return true
endfunction

function Trig_Night_Elf_Dies_Actions takes nothing returns nothing
    if ( (true) ) then // INLINED!!
        call PlaySoundBJ(gg_snd_HeroDemonHunterDeath1)
    else
    endif
endfunction

//===========================================================================
function InitTrig_Night_Elf_Dies takes nothing returns nothing
    set gg_trg_Night_Elf_Dies=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Night_Elf_Dies, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Night_Elf_Dies, Condition(function Trig_Night_Elf_Dies_Conditions))
    call TriggerAddAction(gg_trg_Night_Elf_Dies, function Trig_Night_Elf_Dies_Actions)
endfunction

//===========================================================================
// Trigger: Shadow Dancer Dies
//===========================================================================
function Trig_Shadow_Dancer_Dies_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'h05E' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Shadow_Dancer_Dies_Func002C takes nothing returns boolean
    return true
endfunction

function Trig_Shadow_Dancer_Dies_Actions takes nothing returns nothing
    if ( (true) ) then // INLINED!!
        call PlaySoundBJ(gg_snd_DemonHunterDeathAlternate1)
    else
    endif
endfunction

//===========================================================================
function InitTrig_Shadow_Dancer_Dies takes nothing returns nothing
    set gg_trg_Shadow_Dancer_Dies=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Shadow_Dancer_Dies, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Shadow_Dancer_Dies, Condition(function Trig_Shadow_Dancer_Dies_Conditions))
    call TriggerAddAction(gg_trg_Shadow_Dancer_Dies, function Trig_Shadow_Dancer_Dies_Actions)
endfunction

//===========================================================================
// Trigger: Archdruid Dies
//===========================================================================
function Trig_Archdruid_Dies_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'h05D' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Archdruid_Dies_Func002C takes nothing returns boolean
    return true
endfunction

function Trig_Archdruid_Dies_Actions takes nothing returns nothing
    if ( (true) ) then // INLINED!!
        call PlaySoundBJ(gg_snd_DruidOfTheTalonDeath1)
    else
    endif
endfunction

//===========================================================================
function InitTrig_Archdruid_Dies takes nothing returns nothing
    set gg_trg_Archdruid_Dies=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Archdruid_Dies, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Archdruid_Dies, Condition(function Trig_Archdruid_Dies_Conditions))
    call TriggerAddAction(gg_trg_Archdruid_Dies, function Trig_Archdruid_Dies_Actions)
endfunction

//===========================================================================
// Trigger: Engineer Highelf Dies
//===========================================================================
function Trig_Engineer_Highelf_Dies_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'n00M' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Engineer_Highelf_Dies_Func002C takes nothing returns boolean
    return true
endfunction

function Trig_Engineer_Highelf_Dies_Actions takes nothing returns nothing
    if ( (true) ) then // INLINED!!
        call PlaySoundBJ(gg_snd_PeasantDeath)
    else
    endif
endfunction

//===========================================================================
function InitTrig_Engineer_Highelf_Dies takes nothing returns nothing
    set gg_trg_Engineer_Highelf_Dies=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Engineer_Highelf_Dies, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Engineer_Highelf_Dies, Condition(function Trig_Engineer_Highelf_Dies_Conditions))
    call TriggerAddAction(gg_trg_Engineer_Highelf_Dies, function Trig_Engineer_Highelf_Dies_Actions)
endfunction

//===========================================================================
// Trigger: Bounty Hunter Dies
//===========================================================================
function Trig_Bounty_Hunter_Dies_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'h05W' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Bounty_Hunter_Dies_Func002C takes nothing returns boolean
    return true
endfunction

function Trig_Bounty_Hunter_Dies_Actions takes nothing returns nothing
    if ( (true) ) then // INLINED!!
        call PlaySoundBJ(gg_snd_RiflemanDeath)
    else
    endif
endfunction

//===========================================================================
function InitTrig_Bounty_Hunter_Dies takes nothing returns nothing
    set gg_trg_Bounty_Hunter_Dies=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Bounty_Hunter_Dies, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Bounty_Hunter_Dies, Condition(function Trig_Bounty_Hunter_Dies_Conditions))
    call TriggerAddAction(gg_trg_Bounty_Hunter_Dies, function Trig_Bounty_Hunter_Dies_Actions)
endfunction

//===========================================================================
// Trigger: Ghoul Dies
//===========================================================================
function Trig_Ghoul_Dies_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'o005' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Ghoul_Dies_Actions takes nothing returns nothing
    call PlaySoundBJ(gg_snd_GhoulDeath)
endfunction

//===========================================================================
function InitTrig_Ghoul_Dies takes nothing returns nothing
    set gg_trg_Ghoul_Dies=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Ghoul_Dies, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Ghoul_Dies, Condition(function Trig_Ghoul_Dies_Conditions))
    call TriggerAddAction(gg_trg_Ghoul_Dies, function Trig_Ghoul_Dies_Actions)
endfunction

//===========================================================================
// Trigger: Magmide Dies
//===========================================================================
function Trig_Magmide_Dies_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'o000' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Magmide_Dies_Func002C takes nothing returns boolean
    return true
endfunction

function Trig_Magmide_Dies_Actions takes nothing returns nothing
    if ( (true) ) then // INLINED!!
        call PlaySoundBJ(gg_snd_HeroFirelordDeath1)
    else
    endif
endfunction

//===========================================================================
function InitTrig_Magmide_Dies takes nothing returns nothing
    set gg_trg_Magmide_Dies=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Magmide_Dies, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Magmide_Dies, Condition(function Trig_Magmide_Dies_Conditions))
    call TriggerAddAction(gg_trg_Magmide_Dies, function Trig_Magmide_Dies_Actions)
endfunction

//===========================================================================
// Trigger: Goblin Dies
//===========================================================================
function Trig_Goblin_Dies_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'h016' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Goblin_Dies_Func002C takes nothing returns boolean
    return true
endfunction

function Trig_Goblin_Dies_Actions takes nothing returns nothing
    if ( (true) ) then // INLINED!!
        call PlaySoundBJ(gg_snd_TinkerDeathAlt1)
    else
    endif
endfunction

//===========================================================================
function InitTrig_Goblin_Dies takes nothing returns nothing
    set gg_trg_Goblin_Dies=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Goblin_Dies, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Goblin_Dies, Condition(function Trig_Goblin_Dies_Conditions))
    call TriggerAddAction(gg_trg_Goblin_Dies, function Trig_Goblin_Dies_Actions)
endfunction

//===========================================================================
// Trigger: Ratling Dies
//===========================================================================
function Trig_Ratling_Dies_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'o026' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Ratling_Dies_Func002C takes nothing returns boolean
    return true
endfunction

function Trig_Ratling_Dies_Actions takes nothing returns nothing
    if ( (true) ) then // INLINED!!
        call PlaySoundBJ(gg_snd_DuneWormDeath1)
    else
    endif
endfunction

//===========================================================================
function InitTrig_Ratling_Dies takes nothing returns nothing
    set gg_trg_Ratling_Dies=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Ratling_Dies, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Ratling_Dies, Condition(function Trig_Ratling_Dies_Conditions))
    call TriggerAddAction(gg_trg_Ratling_Dies, function Trig_Ratling_Dies_Actions)
endfunction

//===========================================================================
// Trigger: Goblin Ultima Dies
//===========================================================================
function Trig_Goblin_Ultima_Dies_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'n008' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Goblin_Ultima_Dies_Func002C takes nothing returns boolean
    return true
endfunction

function Trig_Goblin_Ultima_Dies_Actions takes nothing returns nothing
    if ( (true) ) then // INLINED!!
        call PlaySoundBJ(gg_snd_TinkerDeathAlt1)
    else
    endif
endfunction

//===========================================================================
function InitTrig_Goblin_Ultima_Dies takes nothing returns nothing
    set gg_trg_Goblin_Ultima_Dies=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Goblin_Ultima_Dies, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Goblin_Ultima_Dies, Condition(function Trig_Goblin_Ultima_Dies_Conditions))
    call TriggerAddAction(gg_trg_Goblin_Ultima_Dies, function Trig_Goblin_Ultima_Dies_Actions)
endfunction

//===========================================================================
// Trigger: Furbolg Shaman Dies
//===========================================================================
function Trig_Furbolg_Shaman_Dies_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'h02Y' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Furbolg_Shaman_Dies_Func002C takes nothing returns boolean
    return true
endfunction

function Trig_Furbolg_Shaman_Dies_Actions takes nothing returns nothing
    if ( (true) ) then // INLINED!!
        call PlaySoundBJ(gg_snd_FurbolgDeath1)
    else
    endif
endfunction

//===========================================================================
function InitTrig_Furbolg_Shaman_Dies takes nothing returns nothing
    set gg_trg_Furbolg_Shaman_Dies=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Furbolg_Shaman_Dies, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Furbolg_Shaman_Dies, Condition(function Trig_Furbolg_Shaman_Dies_Conditions))
    call TriggerAddAction(gg_trg_Furbolg_Shaman_Dies, function Trig_Furbolg_Shaman_Dies_Actions)
endfunction

//===========================================================================
// Trigger: Furbolg Warrior Dies
//===========================================================================
function Trig_Furbolg_Warrior_Dies_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'h02Z' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Furbolg_Warrior_Dies_Func002C takes nothing returns boolean
    return true
endfunction

function Trig_Furbolg_Warrior_Dies_Actions takes nothing returns nothing
    if ( (true) ) then // INLINED!!
        call PlaySoundBJ(gg_snd_FurbolgDeath1)
    else
    endif
endfunction

//===========================================================================
function InitTrig_Furbolg_Warrior_Dies takes nothing returns nothing
    set gg_trg_Furbolg_Warrior_Dies=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Furbolg_Warrior_Dies, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Furbolg_Warrior_Dies, Condition(function Trig_Furbolg_Warrior_Dies_Conditions))
    call TriggerAddAction(gg_trg_Furbolg_Warrior_Dies, function Trig_Furbolg_Warrior_Dies_Actions)
endfunction

//===========================================================================
// Trigger: Furbolg Dies
//===========================================================================
function Trig_Furbolg_Dies_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'h02U' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Furbolg_Dies_Func002C takes nothing returns boolean
    return true
endfunction

function Trig_Furbolg_Dies_Actions takes nothing returns nothing
    if ( (true) ) then // INLINED!!
        call PlaySoundBJ(gg_snd_FurbolgDeath1)
    else
    endif
endfunction

//===========================================================================
function InitTrig_Furbolg_Dies takes nothing returns nothing
    set gg_trg_Furbolg_Dies=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Furbolg_Dies, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Furbolg_Dies, Condition(function Trig_Furbolg_Dies_Conditions))
    call TriggerAddAction(gg_trg_Furbolg_Dies, function Trig_Furbolg_Dies_Actions)
endfunction

//===========================================================================
// Trigger: Nerubian Dies
//===========================================================================
function Trig_Nerubian_Dies_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'h01K' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Nerubian_Dies_Func002C takes nothing returns boolean
    return true
endfunction

function Trig_Nerubian_Dies_Actions takes nothing returns nothing
    if ( (true) ) then // INLINED!!
        call PlaySoundBJ(gg_snd_PitFiendDeath1)
    else
    endif
endfunction

//===========================================================================
function InitTrig_Nerubian_Dies takes nothing returns nothing
    set gg_trg_Nerubian_Dies=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Nerubian_Dies, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Nerubian_Dies, Condition(function Trig_Nerubian_Dies_Conditions))
    call TriggerAddAction(gg_trg_Nerubian_Dies, function Trig_Nerubian_Dies_Actions)
endfunction

//===========================================================================
// Trigger: Kraken Dies
//===========================================================================
function Trig_Kraken_Dies_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'h000' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Kraken_Dies_Func001C takes nothing returns boolean
    if ( not ( IsUnitInGroup(udg_KrakenFlag, GetUnitsInRectOfPlayer(GetPlayableMapRect(), GetOwningPlayer(GetDyingUnit()))) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Kraken_Dies_Func003C takes nothing returns boolean
    return true
endfunction

function Trig_Kraken_Dies_Actions takes nothing returns nothing
    if ( Trig_Kraken_Dies_Func001C() ) then
    else
    endif
    if ( (true) ) then // INLINED!!
        call PlaySoundBJ(gg_snd_HydraDeath1)
    else
    endif
endfunction

//===========================================================================
function InitTrig_Kraken_Dies takes nothing returns nothing
    set gg_trg_Kraken_Dies=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Kraken_Dies, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Kraken_Dies, Condition(function Trig_Kraken_Dies_Conditions))
    call TriggerAddAction(gg_trg_Kraken_Dies, function Trig_Kraken_Dies_Actions)
endfunction

//===========================================================================
// Trigger: Aethyr Warp Dies
//===========================================================================
function Trig_Aethyr_Warp_Dies_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'h03S' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Aethyr_Warp_Dies_Func001C takes nothing returns boolean
    if ( not ( IsUnitInGroup(udg_AethyrFlag, GetUnitsInRectOfPlayer(GetPlayableMapRect(), GetOwningPlayer(GetDyingUnit()))) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Aethyr_Warp_Dies_Func003C takes nothing returns boolean
    return true
endfunction

function Trig_Aethyr_Warp_Dies_Actions takes nothing returns nothing
    if ( Trig_Aethyr_Warp_Dies_Func001C() ) then
    else
    endif
    if ( (true) ) then // INLINED!!
        call PlaySoundBJ(gg_snd_WarlockDeath1)
    else
    endif
endfunction

//===========================================================================
function InitTrig_Aethyr_Warp_Dies takes nothing returns nothing
    set gg_trg_Aethyr_Warp_Dies=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Aethyr_Warp_Dies, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Aethyr_Warp_Dies, Condition(function Trig_Aethyr_Warp_Dies_Conditions))
    call TriggerAddAction(gg_trg_Aethyr_Warp_Dies, function Trig_Aethyr_Warp_Dies_Actions)
endfunction

//===========================================================================
// Trigger: Kobold Dies
//===========================================================================
function Trig_Kobold_Dies_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'h03Q' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Kobold_Dies_Func002C takes nothing returns boolean
    return true
endfunction

function Trig_Kobold_Dies_Actions takes nothing returns nothing
    if ( (true) ) then // INLINED!!
        call PlaySoundBJ(gg_snd_KoboldDeath)
    else
    endif
endfunction

//===========================================================================
function InitTrig_Kobold_Dies takes nothing returns nothing
    set gg_trg_Kobold_Dies=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Kobold_Dies, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Kobold_Dies, Condition(function Trig_Kobold_Dies_Conditions))
    call TriggerAddAction(gg_trg_Kobold_Dies, function Trig_Kobold_Dies_Actions)
endfunction

//===========================================================================
// Trigger: Razormane Dies
//===========================================================================
function Trig_Razormane_Dies_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'o01E' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Razormane_Dies_Func001C takes nothing returns boolean
    if ( not ( IsUnitInGroup(udg_RazormaneFlag, GetUnitsInRectOfPlayer(GetPlayableMapRect(), GetOwningPlayer(GetDyingUnit()))) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Razormane_Dies_Func003C takes nothing returns boolean
    return true
endfunction

function Trig_Razormane_Dies_Actions takes nothing returns nothing
    if ( Trig_Razormane_Dies_Func001C() ) then
    else
    endif
    if ( (true) ) then // INLINED!!
        call PlaySoundBJ(gg_snd_QuillboarDeath)
    else
    endif
endfunction

//===========================================================================
function InitTrig_Razormane_Dies takes nothing returns nothing
    set gg_trg_Razormane_Dies=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Razormane_Dies, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Razormane_Dies, Condition(function Trig_Razormane_Dies_Conditions))
    call TriggerAddAction(gg_trg_Razormane_Dies, function Trig_Razormane_Dies_Actions)
endfunction

//===========================================================================
// Trigger: Wildkin Dies
//===========================================================================
function Trig_Wildkin_Dies_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'h010' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Wildkin_Dies_Func002C takes nothing returns boolean
    return true
endfunction

function Trig_Wildkin_Dies_Actions takes nothing returns nothing
    if ( (true) ) then // INLINED!!
        call PlaySoundBJ(gg_snd_WendigoDeath)
    else
    endif
endfunction

//===========================================================================
function InitTrig_Wildkin_Dies takes nothing returns nothing
    set gg_trg_Wildkin_Dies=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Wildkin_Dies, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Wildkin_Dies, Condition(function Trig_Wildkin_Dies_Conditions))
    call TriggerAddAction(gg_trg_Wildkin_Dies, function Trig_Wildkin_Dies_Actions)
endfunction

//===========================================================================
// Trigger: Forgotten One Dies
//===========================================================================
function Trig_Forgotten_One_Dies_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'u007' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Forgotten_One_Dies_Func002C takes nothing returns boolean
    return true
endfunction

function Trig_Forgotten_One_Dies_Actions takes nothing returns nothing
    if ( (true) ) then // INLINED!!
        call PlaySoundBJ(gg_snd_FacelessDeath1)
    else
    endif
endfunction

//===========================================================================
function InitTrig_Forgotten_One_Dies takes nothing returns nothing
    set gg_trg_Forgotten_One_Dies=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Forgotten_One_Dies, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Forgotten_One_Dies, Condition(function Trig_Forgotten_One_Dies_Conditions))
    call TriggerAddAction(gg_trg_Forgotten_One_Dies, function Trig_Forgotten_One_Dies_Actions)
endfunction

//===========================================================================
// Trigger: Forgotten Bloodmage Dies
//===========================================================================
function Trig_Forgotten_Bloodmage_Dies_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'u009' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Forgotten_Bloodmage_Dies_Func002C takes nothing returns boolean
    return true
endfunction

function Trig_Forgotten_Bloodmage_Dies_Actions takes nothing returns nothing
    if ( (true) ) then // INLINED!!
        call PlaySoundBJ(gg_snd_FacelessDeath1)
    else
    endif
endfunction

//===========================================================================
function InitTrig_Forgotten_Bloodmage_Dies takes nothing returns nothing
    set gg_trg_Forgotten_Bloodmage_Dies=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Forgotten_Bloodmage_Dies, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Forgotten_Bloodmage_Dies, Condition(function Trig_Forgotten_Bloodmage_Dies_Conditions))
    call TriggerAddAction(gg_trg_Forgotten_Bloodmage_Dies, function Trig_Forgotten_Bloodmage_Dies_Actions)
endfunction

//===========================================================================
// Trigger: Forgotten Executioner Dies
//===========================================================================
function Trig_Forgotten_Executioner_Dies_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'u00B' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Forgotten_Executioner_Dies_Func002C takes nothing returns boolean
    return true
endfunction

function Trig_Forgotten_Executioner_Dies_Actions takes nothing returns nothing
    if ( (true) ) then // INLINED!!
        call PlaySoundBJ(gg_snd_FacelessDeath1)
    else
    endif
endfunction

//===========================================================================
function InitTrig_Forgotten_Executioner_Dies takes nothing returns nothing
    set gg_trg_Forgotten_Executioner_Dies=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Forgotten_Executioner_Dies, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Forgotten_Executioner_Dies, Condition(function Trig_Forgotten_Executioner_Dies_Conditions))
    call TriggerAddAction(gg_trg_Forgotten_Executioner_Dies, function Trig_Forgotten_Executioner_Dies_Actions)
endfunction

//===========================================================================
// Trigger: Forgotten Soulreaper Dies
//===========================================================================
function Trig_Forgotten_Soulreaper_Dies_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'u00A' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Forgotten_Soulreaper_Dies_Func002C takes nothing returns boolean
    return true
endfunction

function Trig_Forgotten_Soulreaper_Dies_Actions takes nothing returns nothing
    if ( (true) ) then // INLINED!!
        call PlaySoundBJ(gg_snd_FacelessDeath1)
    else
    endif
endfunction

//===========================================================================
function InitTrig_Forgotten_Soulreaper_Dies takes nothing returns nothing
    set gg_trg_Forgotten_Soulreaper_Dies=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Forgotten_Soulreaper_Dies, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Forgotten_Soulreaper_Dies, Condition(function Trig_Forgotten_Soulreaper_Dies_Conditions))
    call TriggerAddAction(gg_trg_Forgotten_Soulreaper_Dies, function Trig_Forgotten_Soulreaper_Dies_Actions)
endfunction

//===========================================================================
// Trigger: Ignite Dies
//===========================================================================
function Trig_Ignite_Dies_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'O004' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Ignite_Dies_Actions takes nothing returns nothing
    call DisableTrigger(gg_trg_Ancient_Leaves)
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_302")
    call PlayThematicMusicBJ("HeroicVictory")
    call TriggerSleepAction(3.00)
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_5283")
    call DisplayTimedTextToForce(GetPlayersAll(), 120.00, "TRIGSTR_9243")
    call TriggerSleepAction(120.00)
    call CustomVictoryBJ(Player(0), true, true)
    call CustomVictoryBJ(Player(1), true, true)
    call CustomVictoryBJ(Player(2), true, true)
    call CustomVictoryBJ(Player(3), true, true)
    call CustomVictoryBJ(Player(4), true, true)
    call CustomVictoryBJ(Player(5), true, true)
    call CustomVictoryBJ(Player(7), true, true)
    call CustomDefeatBJ(Player(6), "TRIGSTR_4301")
    call CustomVictoryBJ(Player(8), true, true)
    call CustomVictoryBJ(Player(9), true, true)
endfunction

//===========================================================================
function InitTrig_Ignite_Dies takes nothing returns nothing
    set gg_trg_Ignite_Dies=CreateTrigger()
    call TriggerRegisterPlayerUnitEventSimple(gg_trg_Ignite_Dies, Player(6), EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Ignite_Dies, Condition(function Trig_Ignite_Dies_Conditions))
    call TriggerAddAction(gg_trg_Ignite_Dies, function Trig_Ignite_Dies_Actions)
endfunction

//===========================================================================
// Trigger: Avalanche Dies
//===========================================================================
function Trig_Avalanche_Dies_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'O008' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Avalanche_Dies_Actions takes nothing returns nothing
    call DisableTrigger(gg_trg_Ancient_Leaves)
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_446")
    call PlayThematicMusicBJ("HeroicVictory")
    call TriggerSleepAction(3.00)
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_5283")
    call DisplayTimedTextToForce(GetPlayersAll(), 120.00, "TRIGSTR_9243")
    call TriggerSleepAction(120.00)
    call CustomVictoryBJ(Player(0), true, true)
    call CustomVictoryBJ(Player(1), true, true)
    call CustomVictoryBJ(Player(2), true, true)
    call CustomVictoryBJ(Player(3), true, true)
    call CustomVictoryBJ(Player(4), true, true)
    call CustomVictoryBJ(Player(5), true, true)
    call CustomVictoryBJ(Player(7), true, true)
    call CustomDefeatBJ(Player(6), "TRIGSTR_4301")
    call CustomVictoryBJ(Player(8), true, true)
    call CustomVictoryBJ(Player(9), true, true)
endfunction

//===========================================================================
function InitTrig_Avalanche_Dies takes nothing returns nothing
    set gg_trg_Avalanche_Dies=CreateTrigger()
    call TriggerRegisterPlayerUnitEventSimple(gg_trg_Avalanche_Dies, Player(6), EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Avalanche_Dies, Condition(function Trig_Avalanche_Dies_Conditions))
    call TriggerAddAction(gg_trg_Avalanche_Dies, function Trig_Avalanche_Dies_Actions)
endfunction

//===========================================================================
// Trigger: Paranoia Dies
//===========================================================================
function Trig_Paranoia_Dies_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'O00A' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Paranoia_Dies_Actions takes nothing returns nothing
    call DisableTrigger(gg_trg_Ancient_Leaves)
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_418")
    call PlayThematicMusicBJ("HeroicVictory")
    call TriggerSleepAction(3.00)
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_5283")
    call DisplayTimedTextToForce(GetPlayersAll(), 120.00, "TRIGSTR_9243")
    call TriggerSleepAction(120.00)
    call CustomVictoryBJ(Player(0), true, true)
    call CustomVictoryBJ(Player(1), true, true)
    call CustomVictoryBJ(Player(2), true, true)
    call CustomVictoryBJ(Player(3), true, true)
    call CustomVictoryBJ(Player(4), true, true)
    call CustomVictoryBJ(Player(5), true, true)
    call CustomVictoryBJ(Player(7), true, true)
    call CustomDefeatBJ(Player(6), "TRIGSTR_4301")
    call CustomVictoryBJ(Player(8), true, true)
    call CustomVictoryBJ(Player(9), true, true)
endfunction

//===========================================================================
function InitTrig_Paranoia_Dies takes nothing returns nothing
    set gg_trg_Paranoia_Dies=CreateTrigger()
    call TriggerRegisterPlayerUnitEventSimple(gg_trg_Paranoia_Dies, Player(6), EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Paranoia_Dies, Condition(function Trig_Paranoia_Dies_Conditions))
    call TriggerAddAction(gg_trg_Paranoia_Dies, function Trig_Paranoia_Dies_Actions)
endfunction

//===========================================================================
// Trigger: Eternity Dies
//===========================================================================
function Trig_Eternity_Dies_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'O00D' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Eternity_Dies_Actions takes nothing returns nothing
    call DisableTrigger(gg_trg_Ancient_Leaves)
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_680")
    call PlayThematicMusicBJ("HeroicVictory")
    call TriggerSleepAction(3.00)
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_5283")
    call DisplayTimedTextToForce(GetPlayersAll(), 120.00, "TRIGSTR_9243")
    call TriggerSleepAction(120.00)
    call CustomVictoryBJ(Player(0), true, true)
    call CustomVictoryBJ(Player(1), true, true)
    call CustomVictoryBJ(Player(2), true, true)
    call CustomVictoryBJ(Player(3), true, true)
    call CustomVictoryBJ(Player(4), true, true)
    call CustomVictoryBJ(Player(5), true, true)
    call CustomVictoryBJ(Player(7), true, true)
    call CustomDefeatBJ(Player(6), "TRIGSTR_4301")
    call CustomVictoryBJ(Player(8), true, true)
    call CustomVictoryBJ(Player(9), true, true)
endfunction

//===========================================================================
function InitTrig_Eternity_Dies takes nothing returns nothing
    set gg_trg_Eternity_Dies=CreateTrigger()
    call TriggerRegisterPlayerUnitEventSimple(gg_trg_Eternity_Dies, Player(6), EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Eternity_Dies, Condition(function Trig_Eternity_Dies_Conditions))
    call TriggerAddAction(gg_trg_Eternity_Dies, function Trig_Eternity_Dies_Actions)
endfunction

//===========================================================================
// Trigger: Dragos Dies
//===========================================================================
function Trig_Dragos_Dies_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'O00S' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Dragos_Dies_Actions takes nothing returns nothing
    call DisableTrigger(gg_trg_Ancient_Leaves)
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_2030")
    call PlayThematicMusicBJ("HeroicVictory")
    call TriggerSleepAction(3.00)
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_5283")
    call DisplayTimedTextToForce(GetPlayersAll(), 120.00, "TRIGSTR_9243")
    call TriggerSleepAction(120.00)
    call CustomVictoryBJ(Player(0), true, true)
    call CustomVictoryBJ(Player(1), true, true)
    call CustomVictoryBJ(Player(2), true, true)
    call CustomVictoryBJ(Player(3), true, true)
    call CustomVictoryBJ(Player(4), true, true)
    call CustomVictoryBJ(Player(5), true, true)
    call CustomVictoryBJ(Player(7), true, true)
    call CustomDefeatBJ(Player(6), "TRIGSTR_4301")
    call CustomVictoryBJ(Player(8), true, true)
    call CustomVictoryBJ(Player(9), true, true)
    call CustomVictoryBJ(Player(10), true, true)
endfunction

//===========================================================================
function InitTrig_Dragos_Dies takes nothing returns nothing
    set gg_trg_Dragos_Dies=CreateTrigger()
    call TriggerRegisterPlayerUnitEventSimple(gg_trg_Dragos_Dies, Player(6), EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Dragos_Dies, Condition(function Trig_Dragos_Dies_Conditions))
    call TriggerAddAction(gg_trg_Dragos_Dies, function Trig_Dragos_Dies_Actions)
endfunction

//===========================================================================
// Trigger: Tremor Dies
//===========================================================================
function Trig_Tremor_Dies_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'O00L' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Tremor_Dies_Actions takes nothing returns nothing
    call DisableTrigger(gg_trg_Ancient_Leaves)
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_1475")
    call PlayThematicMusicBJ("HeroicVictory")
    call TriggerSleepAction(3.00)
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_5283")
    call DisplayTimedTextToForce(GetPlayersAll(), 120.00, "TRIGSTR_9243")
    call TriggerSleepAction(120.00)
    call CustomVictoryBJ(Player(0), true, true)
    call CustomVictoryBJ(Player(1), true, true)
    call CustomVictoryBJ(Player(2), true, true)
    call CustomVictoryBJ(Player(3), true, true)
    call CustomVictoryBJ(Player(4), true, true)
    call CustomVictoryBJ(Player(5), true, true)
    call CustomVictoryBJ(Player(7), true, true)
    call CustomDefeatBJ(Player(6), "TRIGSTR_4301")
    call CustomVictoryBJ(Player(8), true, true)
    call CustomVictoryBJ(Player(9), true, true)
    call CustomVictoryBJ(Player(10), true, true)
endfunction

//===========================================================================
function InitTrig_Tremor_Dies takes nothing returns nothing
    set gg_trg_Tremor_Dies=CreateTrigger()
    call TriggerRegisterPlayerUnitEventSimple(gg_trg_Tremor_Dies, Player(6), EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Tremor_Dies, Condition(function Trig_Tremor_Dies_Conditions))
    call TriggerAddAction(gg_trg_Tremor_Dies, function Trig_Tremor_Dies_Actions)
endfunction

//===========================================================================
// Trigger: Zalxon Dies
//===========================================================================
function Trig_Zalxon_Dies_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'O016' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Zalxon_Dies_Actions takes nothing returns nothing
    call DisableTrigger(gg_trg_Ancient_Leaves)
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_3657")
    call PlayThematicMusicBJ("HeroicVictory")
    call TriggerSleepAction(3.00)
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_5283")
    call DisplayTimedTextToForce(GetPlayersAll(), 120.00, "TRIGSTR_9243")
    call TriggerSleepAction(120.00)
    call CustomVictoryBJ(Player(0), true, true)
    call CustomVictoryBJ(Player(1), true, true)
    call CustomVictoryBJ(Player(2), true, true)
    call CustomVictoryBJ(Player(3), true, true)
    call CustomVictoryBJ(Player(4), true, true)
    call CustomVictoryBJ(Player(5), true, true)
    call CustomVictoryBJ(Player(7), true, true)
    call CustomDefeatBJ(Player(6), "TRIGSTR_4301")
    call CustomVictoryBJ(Player(8), true, true)
    call CustomVictoryBJ(Player(9), true, true)
    call CustomVictoryBJ(Player(10), true, true)
endfunction

//===========================================================================
function InitTrig_Zalxon_Dies takes nothing returns nothing
    set gg_trg_Zalxon_Dies=CreateTrigger()
    call TriggerRegisterPlayerUnitEventSimple(gg_trg_Zalxon_Dies, Player(6), EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Zalxon_Dies, Condition(function Trig_Zalxon_Dies_Conditions))
    call TriggerAddAction(gg_trg_Zalxon_Dies, function Trig_Zalxon_Dies_Actions)
endfunction

//===========================================================================
// Trigger: Divinity Dies
//===========================================================================
function Trig_Divinity_Dies_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'O01V' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Divinity_Dies_Actions takes nothing returns nothing
    call DisableTrigger(gg_trg_Ancient_Leaves)
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_7140")
    call PlayThematicMusicBJ("HeroicVictory")
    call TriggerSleepAction(3.00)
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_5283")
    call DisplayTimedTextToForce(GetPlayersAll(), 120.00, "TRIGSTR_9243")
    call TriggerSleepAction(120.00)
    call CustomVictoryBJ(Player(0), true, true)
    call CustomVictoryBJ(Player(1), true, true)
    call CustomVictoryBJ(Player(2), true, true)
    call CustomVictoryBJ(Player(3), true, true)
    call CustomVictoryBJ(Player(4), true, true)
    call CustomVictoryBJ(Player(5), true, true)
    call CustomVictoryBJ(Player(7), true, true)
    call CustomDefeatBJ(Player(6), "TRIGSTR_4301")
    call CustomVictoryBJ(Player(8), true, true)
    call CustomVictoryBJ(Player(9), true, true)
    call CustomVictoryBJ(Player(10), true, true)
endfunction

//===========================================================================
function InitTrig_Divinity_Dies takes nothing returns nothing
    set gg_trg_Divinity_Dies=CreateTrigger()
    call TriggerRegisterPlayerUnitEventSimple(gg_trg_Divinity_Dies, Player(6), EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Divinity_Dies, Condition(function Trig_Divinity_Dies_Conditions))
    call TriggerAddAction(gg_trg_Divinity_Dies, function Trig_Divinity_Dies_Actions)
endfunction

//===========================================================================
// Trigger: Pharoah Dies
//===========================================================================
function Trig_Pharoah_Dies_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'O01X' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Pharoah_Dies_Actions takes nothing returns nothing
    call DisableTrigger(gg_trg_Ancient_Leaves)
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_8363")
    call PlayThematicMusicBJ("HeroicVictory")
    call TriggerSleepAction(3.00)
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_5283")
    call DisplayTimedTextToForce(GetPlayersAll(), 120.00, "TRIGSTR_9243")
    call TriggerSleepAction(120.00)
    call CustomVictoryBJ(Player(0), true, true)
    call CustomVictoryBJ(Player(1), true, true)
    call CustomVictoryBJ(Player(2), true, true)
    call CustomVictoryBJ(Player(3), true, true)
    call CustomVictoryBJ(Player(4), true, true)
    call CustomVictoryBJ(Player(5), true, true)
    call CustomVictoryBJ(Player(7), true, true)
    call CustomDefeatBJ(Player(6), "TRIGSTR_4301")
    call CustomVictoryBJ(Player(8), true, true)
    call CustomVictoryBJ(Player(9), true, true)
    call CustomVictoryBJ(Player(10), true, true)
endfunction

//===========================================================================
function InitTrig_Pharoah_Dies takes nothing returns nothing
    set gg_trg_Pharoah_Dies=CreateTrigger()
    call TriggerRegisterPlayerUnitEventSimple(gg_trg_Pharoah_Dies, Player(6), EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Pharoah_Dies, Condition(function Trig_Pharoah_Dies_Conditions))
    call TriggerAddAction(gg_trg_Pharoah_Dies, function Trig_Pharoah_Dies_Actions)
endfunction

//===========================================================================
// Trigger: Nebula Dies
//===========================================================================
function Trig_Nebula_Dies_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'O01Z' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Nebula_Dies_Actions takes nothing returns nothing
    call DisableTrigger(gg_trg_Ancient_Leaves)
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_9096")
    call PlayThematicMusicBJ("HeroicVictory")
    call TriggerSleepAction(3.00)
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_5283")
    call DisplayTimedTextToForce(GetPlayersAll(), 120.00, "TRIGSTR_9243")
    call TriggerSleepAction(120.00)
    call CustomVictoryBJ(Player(0), true, true)
    call CustomVictoryBJ(Player(1), true, true)
    call CustomVictoryBJ(Player(2), true, true)
    call CustomVictoryBJ(Player(3), true, true)
    call CustomVictoryBJ(Player(4), true, true)
    call CustomVictoryBJ(Player(5), true, true)
    call CustomVictoryBJ(Player(7), true, true)
    call CustomDefeatBJ(Player(6), "TRIGSTR_4301")
    call CustomVictoryBJ(Player(8), true, true)
    call CustomVictoryBJ(Player(9), true, true)
    call CustomVictoryBJ(Player(10), true, true)
endfunction

//===========================================================================
function InitTrig_Nebula_Dies takes nothing returns nothing
    set gg_trg_Nebula_Dies=CreateTrigger()
    call TriggerRegisterPlayerUnitEventSimple(gg_trg_Nebula_Dies, Player(6), EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Nebula_Dies, Condition(function Trig_Nebula_Dies_Conditions))
    call TriggerAddAction(gg_trg_Nebula_Dies, function Trig_Nebula_Dies_Actions)
endfunction

//===========================================================================
// Trigger: Wispari Dies
//===========================================================================
function Trig_Wispari_Dies_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'O01D' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Wispari_Dies_Actions takes nothing returns nothing
    call DisableTrigger(gg_trg_Ancient_Leaves)
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_4300")
    call PlayThematicMusicBJ("HeroicVictory")
    call TriggerSleepAction(3.00)
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_5283")
    call DisplayTimedTextToForce(GetPlayersAll(), 120.00, "TRIGSTR_9243")
    call TriggerSleepAction(120.00)
    call CustomVictoryBJ(Player(0), true, true)
    call CustomVictoryBJ(Player(1), true, true)
    call CustomVictoryBJ(Player(2), true, true)
    call CustomVictoryBJ(Player(3), true, true)
    call CustomVictoryBJ(Player(4), true, true)
    call CustomVictoryBJ(Player(5), true, true)
    call CustomDefeatBJ(Player(6), "TRIGSTR_4301")
    call CustomVictoryBJ(Player(7), true, true)
    call CustomVictoryBJ(Player(8), true, true)
    call CustomVictoryBJ(Player(9), true, true)
    call CustomVictoryBJ(Player(10), true, true)
endfunction

//===========================================================================
function InitTrig_Wispari_Dies takes nothing returns nothing
    set gg_trg_Wispari_Dies=CreateTrigger()
    call TriggerRegisterPlayerUnitEventSimple(gg_trg_Wispari_Dies, Player(6), EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Wispari_Dies, Condition(function Trig_Wispari_Dies_Conditions))
    call TriggerAddAction(gg_trg_Wispari_Dies, function Trig_Wispari_Dies_Actions)
endfunction

//===========================================================================
// Trigger: Remove Resources new
//
// Trigger to turn this on can be found under the Victory Folder - Ext On
//===========================================================================
function Trig_Remove_Resources_new_Func001Func001C takes nothing returns boolean
    if ( not ( GetPlayerColor(GetEnumPlayer()) != GetPlayerColor(udg_AncientPlayer) ) ) then
        return false
    endif
    if ( not ( IsPlayerAlly(GetEnumPlayer(), udg_AncientPlayer) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Remove_Resources_new_Func001A takes nothing returns nothing
    if ( Trig_Remove_Resources_new_Func001Func001C() ) then
        call SetPlayerStateBJ(GetEnumPlayer(), PLAYER_STATE_RESOURCE_GOLD, 0)
        call SetPlayerStateBJ(GetEnumPlayer(), PLAYER_STATE_RESOURCE_LUMBER, 0)
    else
        call DoNothing()
    endif
endfunction

function Trig_Remove_Resources_new_Actions takes nothing returns nothing
    call ForForce(GetPlayersAll(), function Trig_Remove_Resources_new_Func001A)
endfunction

//===========================================================================
function InitTrig_Remove_Resources_new takes nothing returns nothing
    set gg_trg_Remove_Resources_new=CreateTrigger()
    call TriggerRegisterTimerEventPeriodic(gg_trg_Remove_Resources_new, 0.50)
    call TriggerAddAction(gg_trg_Remove_Resources_new, function Trig_Remove_Resources_new_Actions)
endfunction

//===========================================================================
// Trigger: DVIC 1
//===========================================================================
function Trig_DVIC_1_Conditions takes nothing returns boolean
    if ( not ( GetUnitLevel(GetLevelingUnit()) == 20 ) ) then
        return false
    endif
    return true
endfunction

function Trig_DVIC_1_Actions takes nothing returns nothing
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_7267")
    call PlayThematicMusicBJ("UndeadVictory")
    call TriggerSleepAction(3.00)
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_7268")
    call DisplayTimedTextToForce(GetPlayersAll(), 120.00, "TRIGSTR_9243")
    call TriggerSleepAction(120.00)
    call CustomVictoryBJ(Player(6), true, true)
    call CustomDefeatBJ(Player(0), "TRIGSTR_7269")
    call CustomDefeatBJ(Player(1), "TRIGSTR_7269")
    call CustomDefeatBJ(Player(2), "TRIGSTR_7269")
    call CustomDefeatBJ(Player(3), "TRIGSTR_7269")
    call CustomDefeatBJ(Player(4), "TRIGSTR_7269")
    call CustomDefeatBJ(Player(5), "TRIGSTR_7269")
    call CustomDefeatBJ(Player(7), "TRIGSTR_7269")
    call CustomDefeatBJ(Player(8), "TRIGSTR_7269")
    call CustomDefeatBJ(Player(9), "TRIGSTR_7269")
    call CustomDefeatBJ(Player(10), "TRIGSTR_7269")
endfunction

//===========================================================================
function InitTrig_DVIC_1 takes nothing returns nothing
    set gg_trg_DVIC_1=CreateTrigger()
    call TriggerRegisterPlayerUnitEventSimple(gg_trg_DVIC_1, Player(6), EVENT_PLAYER_HERO_LEVEL)
    call TriggerAddCondition(gg_trg_DVIC_1, Condition(function Trig_DVIC_1_Conditions))
    call TriggerAddAction(gg_trg_DVIC_1, function Trig_DVIC_1_Actions)
endfunction

//===========================================================================
// Trigger: Ext On
//===========================================================================
function Trig_Ext_On_Actions takes nothing returns nothing
    call EnableTrigger(gg_trg_Extermination)
endfunction

//===========================================================================
function InitTrig_Ext_On takes nothing returns nothing
    set gg_trg_Ext_On=CreateTrigger()
    call TriggerRegisterTimerEventSingle(gg_trg_Ext_On, 65.00)
    call TriggerAddAction(gg_trg_Ext_On, function Trig_Ext_On_Actions)
endfunction

//===========================================================================
// Trigger: Extermination
//===========================================================================
function Trig_Extermination_Conditions takes nothing returns boolean
    if ( not ( udg_StillAlive == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Extermination_Actions takes nothing returns nothing
    call PlayThematicMusicBJ("UndeadVictory")
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_7280")
    call DisplayTimedTextToForce(GetPlayersAll(), 120.00, "TRIGSTR_9243")
    call DisableTrigger(GetTriggeringTrigger())
    call TriggerSleepAction(120.00)
    call CustomVictoryBJ(Player(6), true, true)
    call CustomDefeatBJ(Player(0), "TRIGSTR_7269")
    call CustomDefeatBJ(Player(1), "TRIGSTR_7269")
    call CustomDefeatBJ(Player(2), "TRIGSTR_7269")
    call CustomDefeatBJ(Player(3), "TRIGSTR_7269")
    call CustomDefeatBJ(Player(4), "TRIGSTR_7269")
    call CustomDefeatBJ(Player(5), "TRIGSTR_7269")
    call CustomDefeatBJ(Player(7), "TRIGSTR_7269")
    call CustomDefeatBJ(Player(8), "TRIGSTR_7269")
    call CustomDefeatBJ(Player(9), "TRIGSTR_7269")
    call CustomDefeatBJ(Player(10), "TRIGSTR_7269")
endfunction

//===========================================================================
function InitTrig_Extermination takes nothing returns nothing
    set gg_trg_Extermination=CreateTrigger()
    call TriggerRegisterTimerEventPeriodic(gg_trg_Extermination, 10.00)
    call TriggerAddCondition(gg_trg_Extermination, Condition(function Trig_Extermination_Conditions))
    call TriggerAddAction(gg_trg_Extermination, function Trig_Extermination_Actions)
endfunction

//===========================================================================
// Trigger: Base List Init
//===========================================================================
function Trig_Base_List_Init_Actions takes nothing returns nothing
    set udg_GARATHORbaseList[1]=gg_rct_Base_1
    set udg_GARATHORbaseList[2]=gg_rct_Base_2
    set udg_GARATHORbaseList[3]=gg_rct_Base_3
    set udg_GARATHORbaseList[4]=gg_rct_Base_4
    set udg_GARATHORbaseList[5]=gg_rct_Base_5
    set udg_GARATHORbaseList[6]=gg_rct_Base_6
    set udg_GARATHORbaseList[7]=gg_rct_Base_7
    set udg_GARATHORbaseList[8]=gg_rct_Base_8
    set udg_GARATHORbaseList[9]=gg_rct_Base_9
    set udg_GARATHORbaseList[10]=gg_rct_Base_10
endfunction

//===========================================================================
function InitTrig_Base_List_Init takes nothing returns nothing
    set gg_trg_Base_List_Init=CreateTrigger()
    call TriggerRegisterTimerEventSingle(gg_trg_Base_List_Init, 5)
    call TriggerAddAction(gg_trg_Base_List_Init, function Trig_Base_List_Init_Actions)
endfunction

//===========================================================================
// Trigger: Flagstack Deny
//===========================================================================
function Trig_Flagstack_Deny_IsFlag takes unit u returns boolean
    local integer id= GetUnitTypeId(u)

    if id == 'h04Z' then
        return true
    endif
    if id == 'h050' then
        return true
    endif
    if id == 'h05P' then
        return true
    endif
    if id == 'h04Y' then
        return true
    endif
    if id == 'h04V' then
        return true
    endif
    if id == 'h04W' then
        return true
    endif
    if id == 'h05N' then
        return true
    endif
    if id == 'h04X' then
        return true
    endif
    if id == 'h051' then
        return true
    endif
    if id == 'h052' then
        return true
    endif

    return false
endfunction

function Trig_Flagstack_Deny_Conditions takes nothing returns boolean
    return Trig_Flagstack_Deny_IsFlag(GetTriggerUnit())
endfunction

function Trig_Flagstack_Deny_BaseHasOtherFlag takes rect r,unit newFlag returns boolean
    local group g= CreateGroup()
    local unit u
    local boolean result= false

    call GroupEnumUnitsInRect(g, r, null)

    loop
        set u=FirstOfGroup(g)
        exitwhen u == null or result

        call GroupRemoveUnit(g, u)

        if u != newFlag and GetWidgetLife(u) > 0.405 and not IsUnitType(u, UNIT_TYPE_DEAD) and Trig_Flagstack_Deny_IsFlag(u) then
            set result=true
        endif
    endloop

    call DestroyGroup(g)

    set g=null
    set u=null
    set newFlag=null

    return result
endfunction

function Trig_Flagstack_Deny_Actions takes nothing returns nothing
    local unit newFlag= GetTriggerUnit()
    local integer i= 1
    local effect e

    loop
        exitwhen i > 10

        if RectContainsUnit(udg_GARATHORbaseList[i], newFlag) then
            if Trig_Flagstack_Deny_BaseHasOtherFlag(udg_GARATHORbaseList[i] , newFlag) then
                set e=AddSpecialEffect("Abilities\\Spells\\Human\\ThunderClap\\ThunderClapCaster.mdl", GetUnitX(newFlag), GetUnitY(newFlag))
                call DestroyEffect(e)
                call KillUnit(newFlag)
                call AdjustPlayerStateBJ(2000, GetOwningPlayer(newFlag), PLAYER_STATE_RESOURCE_LUMBER)
                call DisplayTimedTextToForce(GetForceOfPlayer(GetOwningPlayer(newFlag)), 2.00, "TRIGSTR_6274")
            endif

            set e=null
            set newFlag=null
            return
        endif

        set i=i + 1
    endloop

    set e=null
    set newFlag=null
endfunction

//===========================================================================
function InitTrig_Flagstack_Deny takes nothing returns nothing
    set gg_trg_Flagstack_Deny=CreateTrigger()
    call TriggerRegisterEnterRectSimple(gg_trg_Flagstack_Deny, GetPlayableMapRect())
    call TriggerAddCondition(gg_trg_Flagstack_Deny, Condition(function Trig_Flagstack_Deny_Conditions))
    call TriggerAddAction(gg_trg_Flagstack_Deny, function Trig_Flagstack_Deny_Actions)
endfunction

//===========================================================================
// Trigger: Flag no base Deny
//===========================================================================
function Trig_Flag_no_base_Deny_Func001C takes nothing returns boolean
    if ( ( GetUnitTypeId(GetConstructingStructure()) == 'h04Z' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetConstructingStructure()) == 'h050' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetConstructingStructure()) == 'h05P' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetConstructingStructure()) == 'h04Y' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetConstructingStructure()) == 'h04V' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetConstructingStructure()) == 'h04W' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetConstructingStructure()) == 'h05N' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetConstructingStructure()) == 'h04X' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetConstructingStructure()) == 'h051' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetConstructingStructure()) == 'h052' ) ) then
        return true
    endif
    return false
endfunction

function Trig_Flag_no_base_Deny_Conditions takes nothing returns boolean
    if ( not Trig_Flag_no_base_Deny_Func001C() ) then
        return false
    endif
    return true
endfunction

function Trig_Flag_no_base_Deny_Func002C takes nothing returns boolean
    if ( not ( RectContainsUnit(udg_GARATHORbaseList[1], GetConstructingStructure()) == false ) ) then
        return false
    endif
    if ( not ( RectContainsUnit(udg_GARATHORbaseList[2], GetConstructingStructure()) == false ) ) then
        return false
    endif
    if ( not ( RectContainsUnit(udg_GARATHORbaseList[3], GetConstructingStructure()) == false ) ) then
        return false
    endif
    if ( not ( RectContainsUnit(udg_GARATHORbaseList[4], GetConstructingStructure()) == false ) ) then
        return false
    endif
    if ( not ( RectContainsUnit(udg_GARATHORbaseList[5], GetConstructingStructure()) == false ) ) then
        return false
    endif
    if ( not ( RectContainsUnit(udg_GARATHORbaseList[6], GetConstructingStructure()) == false ) ) then
        return false
    endif
    if ( not ( RectContainsUnit(udg_GARATHORbaseList[7], GetConstructingStructure()) == false ) ) then
        return false
    endif
    if ( not ( RectContainsUnit(udg_GARATHORbaseList[8], GetConstructingStructure()) == false ) ) then
        return false
    endif
    if ( not ( RectContainsUnit(udg_GARATHORbaseList[9], GetConstructingStructure()) == false ) ) then
        return false
    endif
    if ( not ( RectContainsUnit(udg_GARATHORbaseList[10], GetConstructingStructure()) == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_Flag_no_base_Deny_Actions takes nothing returns nothing
    if ( Trig_Flag_no_base_Deny_Func002C() ) then
        call AddSpecialEffectLocBJ(GetUnitLoc(GetConstructingStructure()), "Abilities\\Spells\\Human\\ThunderClap\\ThunderClapCaster.mdl")
        call SetPlayerStateBJ(GetOwningPlayer(GetTriggerUnit()), PLAYER_STATE_RESOURCE_LUMBER, ( GetPlayerState(Player(0), PLAYER_STATE_RESOURCE_LUMBER) + 2000 ))
        call DisplayTextToForce(GetForceOfPlayer(GetOwningPlayer(GetTriggerUnit())), "TRIGSTR_6233")
        call RemoveUnit(GetConstructingStructure())
    else
    endif
endfunction

//===========================================================================
function InitTrig_Flag_no_base_Deny takes nothing returns nothing
    set gg_trg_Flag_no_base_Deny=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Flag_no_base_Deny, EVENT_PLAYER_UNIT_CONSTRUCT_START)
    call TriggerAddCondition(gg_trg_Flag_no_base_Deny, Condition(function Trig_Flag_no_base_Deny_Conditions))
    call TriggerAddAction(gg_trg_Flag_no_base_Deny, function Trig_Flag_no_base_Deny_Actions)
endfunction

//===========================================================================
// Trigger: NewFlag
//===========================================================================
function Trig_NewFlag_Conditions takes nothing returns boolean
    local integer unitId= GetUnitTypeId(GetConstructedStructure())
    if ( not ( unitId == 'h04Z' or unitId == 'h050' or unitId == 'h04Y' or unitId == 'h04V' or unitId == 'h04W' or unitId == 'h05N' or unitId == 'h04X' or unitId == 'h051' or unitId == 'h052' or unitId == 'h05P' ) ) then
        return false
    endif
    return true
endfunction

function Trig_NewFlag_Actions takes nothing returns nothing
    call PingMinimapLocForForce(GetPlayersAll(), GetUnitLoc(GetConstructedStructure()), 5.00)
    call DisplayTextToForce(GetPlayersEnemies(udg_AncientPlayer), "A base flag has been constructed! You will receive 1 gold and 50 lumber every 6 seconds. However, should the base fall, the Ancient will receive 1000 gold!")
    call DisplayTextToForce(GetPlayersAllies(udg_AncientPlayer), "A base flag has been constructed! The enemy expanders will recieve 1 gold and 50 lumber every 6 seconds. However, should you destroy this base, you will recieve 1000 gold! Destroy the base before the expanders get too strong.")
    set udg_Flags[GetConvertedPlayerId(GetTriggerPlayer())]=true
endfunction

//===========================================================================
function InitTrig_NewFlag takes nothing returns nothing
    set gg_trg_NewFlag=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_NewFlag, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
    call TriggerAddCondition(gg_trg_NewFlag, Condition(function Trig_NewFlag_Conditions))
    call TriggerAddAction(gg_trg_NewFlag, function Trig_NewFlag_Actions)
endfunction


//===========================================================================
// Trigger: NewFlag2
//===========================================================================
function Trig_NewFlag2_Func001Func001Func001A takes nothing returns nothing
    call AdjustPlayerStateBJ(1, GetEnumPlayer(), PLAYER_STATE_RESOURCE_GOLD)
    call AdjustPlayerStateBJ(50, GetEnumPlayer(), PLAYER_STATE_RESOURCE_LUMBER)
endfunction

function Trig_NewFlag2_Func001Func001C takes nothing returns boolean
    if ( not ( udg_Flags[GetConvertedPlayerId(GetEnumPlayer())] == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_NewFlag2_Func001A takes nothing returns nothing
    if ( Trig_NewFlag2_Func001Func001C() ) then
        call ForForce(GetPlayersAllies(GetEnumPlayer()), function Trig_NewFlag2_Func001Func001Func001A)
    else
    endif
endfunction

function Trig_NewFlag2_Actions takes nothing returns nothing
    call ForForce(GetPlayersAll(), function Trig_NewFlag2_Func001A)
endfunction

//===========================================================================
function InitTrig_NewFlag2 takes nothing returns nothing
    set gg_trg_NewFlag2=CreateTrigger()
    call TriggerRegisterTimerEventPeriodic(gg_trg_NewFlag2, 6.00)
    call TriggerAddAction(gg_trg_NewFlag2, function Trig_NewFlag2_Actions)
endfunction

//===========================================================================
// Trigger: NewFlag3
//===========================================================================
function Trig_NewFlag3_Conditions takes nothing returns boolean
    local integer unitId= GetUnitTypeId(GetDyingUnit())
    if ( not ( unitId == 'h04Z' or unitId == 'h050' or unitId == 'h04Y' or unitId == 'h04V' or unitId == 'h04W' or unitId == 'h05N' or unitId == 'h04X' or unitId == 'h051' or unitId == 'h052' or unitId == 'h05P' ) ) then
        return false
    endif
    if ( not ( GetUnitTypeId(GetKillingUnitBJ()) != 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_NewFlag3_Actions takes nothing returns nothing
    call PingMinimapLocForForce(GetPlayersAll(), GetUnitLoc(GetDyingUnit()), 5.00)
    call DisplayTextToForce(GetPlayersEnemies(udg_AncientPlayer), "TRIGSTR_1774")
    call DisplayTextToForce(GetPlayersAllies(udg_AncientPlayer), "TRIGSTR_1824")
    set udg_Flags[GetConvertedPlayerId(GetOwningPlayer(GetDyingUnit()))]=false
endfunction

//===========================================================================
function InitTrig_NewFlag3 takes nothing returns nothing
    set gg_trg_NewFlag3=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_NewFlag3, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_NewFlag3, Condition(function Trig_NewFlag3_Conditions))
    call TriggerAddAction(gg_trg_NewFlag3, function Trig_NewFlag3_Actions)
endfunction


//===========================================================================
// Trigger: NewFlag4
//===========================================================================
function Trig_NewFlag4_Conditions takes nothing returns boolean
    local integer unitId= GetUnitTypeId(GetConstructingStructure())
    if ( not ( udg_Flags[GetConvertedPlayerId(GetOwningPlayer(GetConstructingStructure()))] == true ) ) then
        return false
    endif

    if ( not ( unitId == 'h04Z' or unitId == 'h050' or unitId == 'h04Y' or unitId == 'h04V' or unitId == 'h04W' or unitId == 'h05N' or unitId == 'h04X' or unitId == 'h051' or unitId == 'h052' or unitId == 'h05P' ) ) then
	return false
    endif
    return true
endfunction

function Trig_NewFlag4_Actions takes nothing returns nothing
    set udg_Flag=GetOwningPlayer(GetTriggerUnit())
    call IssueImmediateOrderBJ(GetTriggerUnit(), "stop")
    call KillUnit(GetConstructingStructure())
    call SetPlayerStateBJ(udg_Flag, PLAYER_STATE_RESOURCE_LUMBER, ( GetPlayerState(udg_Flag, PLAYER_STATE_RESOURCE_LUMBER) + 2000 ))
    call DisplayTextToForce(GetForceOfPlayer(udg_Flag), "You have already constructed a base flag!")
endfunction

//===========================================================================
function InitTrig_NewFlag4 takes nothing returns nothing
    set gg_trg_NewFlag4=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_NewFlag4, EVENT_PLAYER_UNIT_CONSTRUCT_START)
    call TriggerAddCondition(gg_trg_NewFlag4, Condition(function Trig_NewFlag4_Conditions))
    call TriggerAddAction(gg_trg_NewFlag4, function Trig_NewFlag4_Actions)
endfunction


//===========================================================================
// Trigger: NewFlag5
//===========================================================================
function Trig_NewFlag5_Conditions takes nothing returns boolean
    local integer unitId= GetUnitTypeId(GetAttackedUnitBJ())
    if ( not ( unitId == 'h04Z' or unitId == 'h050' or unitId == 'h04Y' or unitId == 'h04V' or unitId == 'h04W' or unitId == 'h05N' or unitId == 'h04X' or unitId == 'h051' or unitId == 'h052' or unitId == 'h05P' ) ) then
        return false
    endif
    return true
endfunction

function Trig_NewFlag5_Func001C takes nothing returns boolean
    if ( not ( GetOwningPlayer(GetAttacker()) == udg_AncientPlayer ) ) then
        return false
    endif
    return true
endfunction

function Trig_NewFlag5_Actions takes nothing returns nothing
    if ( Trig_NewFlag5_Func001C() ) then
        call DoNothing()
    else
        call IssueImmediateOrderBJ(GetAttacker(), "stop")
    endif
endfunction

//===========================================================================
function InitTrig_NewFlag5 takes nothing returns nothing
    set gg_trg_NewFlag5=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_NewFlag5, EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddCondition(gg_trg_NewFlag5, Condition(function Trig_NewFlag5_Conditions))
    call TriggerAddAction(gg_trg_NewFlag5, function Trig_NewFlag5_Actions)
endfunction


//===========================================================================
// Trigger: Gobo Mech Blaster pickup
//===========================================================================
function Trig_Gobo_Mech_Blaster_pickup_Conditions takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I00Q' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Gobo_Mech_Blaster_pickup_Func001C takes nothing returns boolean
    if ( not ( IsUnitType(GetTriggerUnit(), UNIT_TYPE_MELEE_ATTACKER) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Gobo_Mech_Blaster_pickup_Actions takes nothing returns nothing
    if ( Trig_Gobo_Mech_Blaster_pickup_Func001C() ) then
        call SetUnitAbilityLevelSwapped('A0DP', GetTriggerUnit(), 2)
    else
        call SetUnitAbilityLevelSwapped('A0DP', GetTriggerUnit(), 1)
    endif
endfunction

//===========================================================================
function InitTrig_Gobo_Mech_Blaster_pickup takes nothing returns nothing
    set gg_trg_Gobo_Mech_Blaster_pickup=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Gobo_Mech_Blaster_pickup, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddCondition(gg_trg_Gobo_Mech_Blaster_pickup, Condition(function Trig_Gobo_Mech_Blaster_pickup_Conditions))
    call TriggerAddAction(gg_trg_Gobo_Mech_Blaster_pickup, function Trig_Gobo_Mech_Blaster_pickup_Actions)
endfunction

//===========================================================================
// Trigger: Gobo Mech Blaster attack check
//
// this is to prevent transforming from leaving you with the wrong level of ability
//===========================================================================
function Trig_Gobo_Mech_Blaster_attack_check_Conditions takes nothing returns boolean
    if ( not ( UnitHasItemOfTypeBJ(udg_DamageEventSource, 'I00Q') == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Gobo_Mech_Blaster_attack_check_Func001C takes nothing returns boolean
    if ( not ( IsUnitType(udg_DamageFilterSource, UNIT_TYPE_MELEE_ATTACKER) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Gobo_Mech_Blaster_attack_check_Actions takes nothing returns nothing
    if ( Trig_Gobo_Mech_Blaster_attack_check_Func001C() ) then
        call SetUnitAbilityLevelSwapped('A0DP', udg_DamageEventSource, 2)
    else
        call SetUnitAbilityLevelSwapped('A0DP', udg_DamageEventSource, 1)
    endif
endfunction

//===========================================================================
function InitTrig_Gobo_Mech_Blaster_attack_check takes nothing returns nothing
    set gg_trg_Gobo_Mech_Blaster_attack_check=CreateTrigger()
    call h__TriggerRegisterVariableEvent(gg_trg_Gobo_Mech_Blaster_attack_check, "udg_DamageModifierEvent", EQUAL, 1.00)
    call TriggerAddCondition(gg_trg_Gobo_Mech_Blaster_attack_check, Condition(function Trig_Gobo_Mech_Blaster_attack_check_Conditions))
    call TriggerAddAction(gg_trg_Gobo_Mech_Blaster_attack_check, function Trig_Gobo_Mech_Blaster_attack_check_Actions)
endfunction

//===========================================================================
function InitCustomTriggers takes nothing returns nothing
    call InitTrig_Damage_Engine_Config()
    //Function not found: call InitTrig_Damage_Engine()
    call InitTrig_TSEConfig()
    call InitTrig_TSERegister()
    call InitTrig_TSELoop()
    call InitTrig_TSEEmptyEvent()
    call InitTrig_Map_Ini_Testing()
    call InitTrig_Counter_Testing()
    call InitTrig_Start_Counter()
    call InitTrig_Counter()
    call InitTrig_Tradeoff_Detection()
    call InitTrig_TreeChopper_Detection()
    call InitTrig_Takeover()
    call InitTrig_Enable_Overdrive()
    call InitTrig_Disable_Overdrive()
    call InitTrig_Death()
    call InitTrig_Hardmode()
    call InitTrig_Categorization()
    call InitTrig_Fountain_Heal()
    call InitTrig_Ancient_In_Combat()
    call InitTrig_AutoFeedRate()
    call InitTrig_TimeToAncientSpawn_Copy()
    //Function not found: call InitTrig_HandleSetRate()
    call InitTrig_FeedReduction()
    call InitTrig_SetFeed()
    call InitTrig_CheckFeedRates()
    call InitTrig_Detonate()
    call InitTrig_Expander_Hero_XP()
    call InitTrig_Snipe_Shot()
    call InitTrig_Dash()
    call InitTrig_Rome()
    call InitTrig_Basic_Bounty_Hit()
    call InitTrig_Improved_Bounty_Hit()
    call InitTrig_Harvest_Grapes()
    call InitTrig_Bullets_Switch()
    call InitTrig_Limb_Throw()
    call InitTrig_Flesh_Stampede()
    call InitTrig_Amalgamation()
    call InitTrig_Merge()
    call InitTrig_Husk_Detection()
    call InitTrig_Death_Jump()
    call InitTrig_Map_Start()
    call InitTrig_Day()
    call InitTrig_Night()
    call InitTrig_Iron_Hoove()
    call InitTrig_Lightning_Strike_TowerVers()
    call InitTrig_Blizzard()
    call InitTrig_ShovelStrikelevelup()
    call InitTrig_Deepwater_1()
    call InitTrig_Deepwater_2()
    call InitTrig_Genesis()
    call InitTrig_ConjureRefreshment()
    call InitTrig_ShadowDancers()
    call InitTrig_Mana_Burn()
    call InitTrig_Mana_Steal_Dancer()
    call InitTrig_Mana_Steal_Mages()
    call InitTrig_ConjureMana()
    call InitTrig_Blur()
    call InitTrig_Ghoul_Units()
    call InitTrig_Ghoul_lumber()
    call InitTrig_Dutchmen_Trained()
    call InitTrig_Dutchmen()
    call InitTrig_Vampiric_Wyrm()
    call InitTrig_Soul_Hammer()
    call InitTrig_Coup_de_grace()
    call InitTrig_Surge_of_Darkness()
    call InitTrig_Focused_Anger_1()
    call InitTrig_Focused_Anger_2()
    call InitTrig_Focused_Anger_3()
    call InitTrig_Focused_Anger_4()
    call InitTrig_Focused_Anger_5()
    call InitTrig_Focused_Anger_6()
    call InitTrig_Focused_Anger_7()
    call InitTrig_Focused_Anger_8()
    call InitTrig_Focused_Anger_9()
    call InitTrig_Focused_Anger_10()
    call InitTrig_Focused_Anger_Trigger()
    call InitTrig_Focused_Anger_Trigger_Copy()
    call InitTrig_Focused_Anger_Trigger_Copy_2()
    call InitTrig_Focused_Anger_Trigger_Copy_3()
    call InitTrig_Focused_Anger_Trigger_Copy_4()
    call InitTrig_Focused_Anger_Trigger_Copy_5()
    call InitTrig_Focused_Anger_Trigger_Copy_6()
    call InitTrig_Focused_Anger_Trigger_Copy_7()
    call InitTrig_Focused_Anger_Trigger_Copy_8()
    call InitTrig_Focused_Anger_Trigger_Copy_9()
    call InitTrig_Feast_of_Souls()
    call InitTrig_Soul_Strike()
    call InitTrig_Avatar()
    call InitTrig_Acidic_Blood()
    call InitTrig_Binding_Shadows()
    call InitTrig_Cobalt_Blood()
    call InitTrig_Glowing_Blood()
    call InitTrig_Psychic_Slam()
    call InitTrig_Soul_Rend()
    call InitTrig_Dark_Blood()
    call InitTrig_Shadowlings()
    call InitTrig_Levelled_Drain()
    call InitTrig_Levelled_Drain_Copy()
    call InitTrig_Levelled_Drain_Copy_2()
    call InitTrig_Levelled_Drain_Copy_3()
    call InitTrig_Levelled_Drain_Copy_4()
    call InitTrig_Levelled_Drain_Copy_5()
    call InitTrig_Levelled_Drain_Copy_6()
    call InitTrig_Levelled_Drain_Copy_7()
    call InitTrig_Levelled_Drain_Copy_8()
    call InitTrig_Levelled_Drain_Copy_9()
    call InitTrig_Drain_Setup()
    call InitTrig_Drain_Cast()
    call InitTrig_Drain_Loop()
    call InitTrig_Levelled_Slam()
    call InitTrig_Levelled_Slam_Copy()
    call InitTrig_Levelled_Slam_Copy_2()
    call InitTrig_Levelled_Slam_Copy_3()
    call InitTrig_Levelled_Slam_Copy_4()
    call InitTrig_Levelled_Slam_Copy_5()
    call InitTrig_Levelled_Slam_Copy_6()
    call InitTrig_Levelled_Slam_Copy_7()
    call InitTrig_Levelled_Slam_Copy_8()
    call InitTrig_Levelled_Slam_Copy_9()
    call InitTrig_LevelUpAura()
    call InitTrig_DowngradeAura()
    call InitTrig_NerubianSpires()
    call InitTrig_Frenzy()
    call InitTrig_Chemical_Rage()
    call InitTrig_ReduceMagicResist()
    call InitTrig_ReduceMagicResist2()
    call InitTrig_TargetAcquired()
    call InitTrig_Poisoned_Bullets2()
    call InitTrig_Poisoned_Bullets()
    call InitTrig_Permanent_Invisibility()
    call InitTrig_Permanent_Invisibility_2()
    call InitTrig_Sticky_Glue()
    call InitTrig_Wood_Income()
    call InitTrig_Enter_Wood_Income()
    call InitTrig_SeedOfRebirth()
    call InitTrig_Ancient_Artifact()
    call InitTrig_Moonstrike()
    call InitTrig_Moonstrike_Leveled()
    call InitTrig_Moonblast()
    call InitTrig_Moonblast_Leveled()
    call InitTrig_Lunar_Assault()
    call InitTrig_Lunar_Assault_Leveled()
    call InitTrig_Cascade_Leveled()
    call InitTrig_Nourish()
    call InitTrig_Nourish_Leveled()
    call InitTrig_Solar_Blast()
    call InitTrig_Natural_Vigil_Leveled()
    call InitTrig_Lifebloom_Leveled()
    call InitTrig_Suns_Fury()
    call InitTrig_Return_lumber()
    call InitTrig_Slash_Leveled()
    call InitTrig_Bleed_Leveled()
    call InitTrig_Focused_Strike()
    call InitTrig_FanOfKnivesBasedSpells()
    call InitTrig_Realm_of_darkness()
    call InitTrig_Realm_of_darkness_2()
    call InitTrig_Thunderstruck()
    call InitTrig_Lightning_Strike()
    call InitTrig_RecallStart()
    call InitTrig_Recall()
    call InitTrig_Time_warp()
    call InitTrig_Galactic_Fury()
    call InitTrig_Galactic_Fury_2()
    call InitTrig_Galactic_Fury_3()
    call InitTrig_Cosmic_Strike()
    call InitTrig_Cosmic_Strike_2()
    call InitTrig_Cosmic_Strike_3()
    call InitTrig_Resillience()
    call InitTrig_Resillience_2()
    call InitTrig_Resillience_3()
    call InitTrig_Sandstorm()
    call InitTrig_Sandstorm_2()
    call InitTrig_Ancient_Grasp()
    call InitTrig_Deserts_Veil()
    call InitTrig_Chill()
    call InitTrig_Freeze_Zone()
    call InitTrig_Freeze_Zone_V2()
    call InitTrig_Sadism()
    call InitTrig_Reckoning()
    call InitTrig_Vanguard_Initial()
    call InitTrig_Vanguard_Future_Levels()
    call InitTrig_Vanguard()
    call InitTrig_Omniscience_Initial()
    call InitTrig_Omniscience_FL()
    call InitTrig_Omniscience()
    call InitTrig_Redemption()
    //Function not found: call InitTrig_Refreshing_Breeze()
    //Function not found: call InitTrig_Gale_Winds()
    call InitTrig_WindWalkWispari()
    call InitTrig_TornadoMove()
    call InitTrig_Sit_tight()
    call InitTrig_ClearOnEsc()
    call InitTrig_InitialText()
    call InitTrig_Welcome()
    call InitTrig_Info_Copy()
    call InitTrig_Info()
    call InitTrig_Ping_Hint()
    call InitTrig_Hint2x2()
    call InitTrig_HintInvisibility()
    call InitTrig_HintFeed()
    call InitTrig_Resource_Hint()
    call InitTrig_Ping()
    call InitTrig_PingForAncient()
    call InitTrig_AncientSpells()
    call InitTrig_Start()
    call InitTrig_Hard_mode_on()
    call InitTrig_Hard_Attack()
    call InitTrig_Hard_Attack_Cont()
    call InitTrig_Hard_attack_2()
    call InitTrig_Select()
    call InitTrig_Attack()
    call InitTrig_Run_away()
    call InitTrig_Slot1_Righteous_Armor()
    call InitTrig_Slot2_Valor_Helmet()
    call InitTrig_Slot3_Bladed_Gauntlet()
    call InitTrig_Slot4_Bladed_Gauntlet()
    call InitTrig_Slot5_Bladed_Gauntlet()
    call InitTrig_Slot6_Bladed_Gauntlet()
    call InitTrig_Level_Up_Tomes()
    call InitTrig_Abilities()
    call InitTrig_Staff_of_insight_pickup()
    call InitTrig_Dusts_Slow()
    call InitTrig_Firelords_Cape_usage()
    call InitTrig_Firelords_Cape_pickup()
    call InitTrig_Bladed_Gauntlet_vs_Hero()
    call InitTrig_Cast_CL_on_Banish()
    call InitTrig_Ledgers_XP()
    call InitTrig_Ledger_of_Clarity_pickup()
    call InitTrig_Ledger_of_Clarity_lose()
    call InitTrig_Ledger_of_Enlightment_pickup()
    call InitTrig_Ledger_of_Enlightment_lose()
    call InitTrig_Spellcasters_Cloak()
    call InitTrig_Ethereal_Scepter()
    call InitTrig_Firelords_Cape()
    call InitTrig_Ledget_of_Enlightment()
    call InitTrig_Hammer_of_might()
    call InitTrig_Valorous_Helmet()
    call InitTrig_Bladed_Gauntlet()
    call InitTrig_Righteous_Armor()
    call InitTrig_Arcanum_of_Hatred()
    call InitTrig_Bleeding_Scythe()
    call InitTrig_Staff_of_Insight()
    call InitTrig_Cosmic_Orb()
    call InitTrig_Level_up()
    call InitTrig_Deliver_Gold()
    call InitTrig_Worgens_gold()
    call InitTrig_Bounty()
    call InitTrig_Remove_Ancient_Lumber()
    call InitTrig_Ancient_Gold_income()
    call InitTrig_Initialization()
    call InitTrig_LimitedTraining()
    call InitTrig_TimeToExpanderSpawn()
    call InitTrig_TimeToAncientSpawn()
    call InitTrig_Unit_Indexer()
    call InitTrig_Spellbringers_spells()
    call InitTrig_Give_orb()
    call InitTrig_Colors()
    call InitTrig_Name_Change()
    call InitTrig_Name_Change_III()
    call InitTrig_RandomExpander()
    call InitTrig_RandomExpander2()
    call InitTrig_Random_Ancient()
    call InitTrig_Remove_Selection()
    call InitTrig_Remove_Selector()
    call InitTrig_Trade_disabled()
    call InitTrig_Trade_enabled()
    call InitTrig_Disable_trade_enabled()
    call InitTrig_Spawn_Races()
    call InitTrig_Spawn_Ancients()
    call InitTrig_DisableExpanderBans()
    call InitTrig_Worgen()
    call InitTrig_Centaur()
    call InitTrig_Wildkin()
    call InitTrig_Nerubian()
    call InitTrig_Human()
    call InitTrig_Wisp()
    call InitTrig_Kobold()
    call InitTrig_Ghoul()
    call InitTrig_Kraken()
    call InitTrig_Aethyr()
    call InitTrig_Forgotten()
    call InitTrig_Goblin()
    call InitTrig_Ogre()
    call InitTrig_Magmide()
    call InitTrig_Furbolg()
    call InitTrig_Razormane()
    call InitTrig_Elf()
    call InitTrig_HighElf()
    call InitTrig_Ratling()
    call InitTrig_Hunter()
    call InitTrig_AncientLight()
    call InitTrig_AncientLightning()
    call InitTrig_AncientDragon()
    call InitTrig_AncientEarth()
    call InitTrig_AncientDarkness()
    call InitTrig_AncientIce()
    call InitTrig_AncientFire()
    call InitTrig_AncientNature()
    call InitTrig_AncientSand()
    call InitTrig_AncientSpace()
    call InitTrig_AncientWind()
    call InitTrig_Prevent_Attack()
    call InitTrig_No_Attacking_Shops_Copy_3()
    call InitTrig_No_Attacking_Shops_Copy_2()
    call InitTrig_No_Attacking_Shops_Copy()
    call InitTrig_No_Attacking_Shops()
    call InitTrig_Ally_neutral()
    call InitTrig_Vision()
    call InitTrig_Death_anim()
    call InitTrig_Quests()
    call InitTrig_Warning_few_seconds()
    call InitTrig_Camera_Copy()
    call InitTrig_LatePickers()
    call InitTrig_AncientSpawnTele()
    call InitTrig_Player_group()
    call InitTrig_Lackey_Respawn()
    call InitTrig_Death_start()
    call InitTrig_Spawn_Lackey()
    call InitTrig_MiniMinis()
    call InitTrig_Player_Leaves()
    call InitTrig_Ancient_Leaves()
    call InitTrig_Human_Dies()
    call InitTrig_Wisp_Dies()
    call InitTrig_Centaur_Dies()
    call InitTrig_Ogre_Dies()
    call InitTrig_Worgen_Dies()
    call InitTrig_Night_Elf_Dies()
    call InitTrig_Shadow_Dancer_Dies()
    call InitTrig_Archdruid_Dies()
    call InitTrig_Engineer_Highelf_Dies()
    call InitTrig_Bounty_Hunter_Dies()
    call InitTrig_Ghoul_Dies()
    call InitTrig_Magmide_Dies()
    call InitTrig_Goblin_Dies()
    call InitTrig_Ratling_Dies()
    call InitTrig_Goblin_Ultima_Dies()
    call InitTrig_Furbolg_Shaman_Dies()
    call InitTrig_Furbolg_Warrior_Dies()
    call InitTrig_Furbolg_Dies()
    call InitTrig_Nerubian_Dies()
    call InitTrig_Kraken_Dies()
    call InitTrig_Aethyr_Warp_Dies()
    call InitTrig_Kobold_Dies()
    call InitTrig_Razormane_Dies()
    call InitTrig_Wildkin_Dies()
    call InitTrig_Forgotten_One_Dies()
    call InitTrig_Forgotten_Bloodmage_Dies()
    call InitTrig_Forgotten_Executioner_Dies()
    call InitTrig_Forgotten_Soulreaper_Dies()
    call InitTrig_Ignite_Dies()
    call InitTrig_Avalanche_Dies()
    call InitTrig_Paranoia_Dies()
    call InitTrig_Eternity_Dies()
    call InitTrig_Dragos_Dies()
    call InitTrig_Tremor_Dies()
    call InitTrig_Zalxon_Dies()
    call InitTrig_Divinity_Dies()
    call InitTrig_Pharoah_Dies()
    call InitTrig_Nebula_Dies()
    call InitTrig_Wispari_Dies()
    call InitTrig_Remove_Resources_new()
    call InitTrig_DVIC_1()
    call InitTrig_Ext_On()
    call InitTrig_Extermination()
    call InitTrig_Base_List_Init()
    call InitTrig_Flagstack_Deny()
    call InitTrig_Flag_no_base_Deny()
    call InitTrig_NewFlag()
    call InitTrig_NewFlag2()
    call InitTrig_NewFlag3()
    call InitTrig_NewFlag4()
    call InitTrig_NewFlag5()
    call InitTrig_Gobo_Mech_Blaster_pickup()
    call InitTrig_Gobo_Mech_Blaster_attack_check()
endfunction

//===========================================================================
function RunInitializationTriggers takes nothing returns nothing
    call ConditionalTriggerExecute(gg_trg_Damage_Engine_Config)
    call ConditionalTriggerExecute(gg_trg_TSEConfig)
    call ConditionalTriggerExecute(gg_trg_Drain_Setup)
    call ConditionalTriggerExecute(gg_trg_NerubianSpires)
    call ConditionalTriggerExecute(gg_trg_InitialText)
    call ConditionalTriggerExecute(gg_trg_Start)
    call ConditionalTriggerExecute(gg_trg_Deliver_Gold)
    call ConditionalTriggerExecute(gg_trg_Bounty)
    call ConditionalTriggerExecute(gg_trg_Initialization)
    call ConditionalTriggerExecute(gg_trg_LimitedTraining)
    call ConditionalTriggerExecute(gg_trg_Unit_Indexer)
    call ConditionalTriggerExecute(gg_trg_Colors)
    call ConditionalTriggerExecute(gg_trg_RandomExpander)
    call ConditionalTriggerExecute(gg_trg_Ally_neutral)
    call ConditionalTriggerExecute(gg_trg_Vision)
    call ConditionalTriggerExecute(gg_trg_Quests)
    call ConditionalTriggerExecute(gg_trg_Player_group)
endfunction

//***************************************************************************
//*
//*  Players
//*
//***************************************************************************

function InitCustomPlayerSlots takes nothing returns nothing

    // Player 0
    call SetPlayerStartLocation(Player(0), 0)
    call ForcePlayerStartLocation(Player(0), 0)
    call SetPlayerColor(Player(0), ConvertPlayerColor(0))
    call SetPlayerRacePreference(Player(0), RACE_PREF_HUMAN)
    call SetPlayerRaceSelectable(Player(0), false)
    call SetPlayerController(Player(0), MAP_CONTROL_USER)

    // Player 1
    call SetPlayerStartLocation(Player(1), 1)
    call ForcePlayerStartLocation(Player(1), 1)
    call SetPlayerColor(Player(1), ConvertPlayerColor(1))
    call SetPlayerRacePreference(Player(1), RACE_PREF_HUMAN)
    call SetPlayerRaceSelectable(Player(1), false)
    call SetPlayerController(Player(1), MAP_CONTROL_USER)

    // Player 2
    call SetPlayerStartLocation(Player(2), 2)
    call ForcePlayerStartLocation(Player(2), 2)
    call SetPlayerColor(Player(2), ConvertPlayerColor(2))
    call SetPlayerRacePreference(Player(2), RACE_PREF_HUMAN)
    call SetPlayerRaceSelectable(Player(2), false)
    call SetPlayerController(Player(2), MAP_CONTROL_USER)

    // Player 3
    call SetPlayerStartLocation(Player(3), 3)
    call ForcePlayerStartLocation(Player(3), 3)
    call SetPlayerColor(Player(3), ConvertPlayerColor(3))
    call SetPlayerRacePreference(Player(3), RACE_PREF_HUMAN)
    call SetPlayerRaceSelectable(Player(3), false)
    call SetPlayerController(Player(3), MAP_CONTROL_USER)

    // Player 4
    call SetPlayerStartLocation(Player(4), 4)
    call ForcePlayerStartLocation(Player(4), 4)
    call SetPlayerColor(Player(4), ConvertPlayerColor(4))
    call SetPlayerRacePreference(Player(4), RACE_PREF_HUMAN)
    call SetPlayerRaceSelectable(Player(4), false)
    call SetPlayerController(Player(4), MAP_CONTROL_USER)

    // Player 5
    call SetPlayerStartLocation(Player(5), 5)
    call ForcePlayerStartLocation(Player(5), 5)
    call SetPlayerColor(Player(5), ConvertPlayerColor(5))
    call SetPlayerRacePreference(Player(5), RACE_PREF_HUMAN)
    call SetPlayerRaceSelectable(Player(5), false)
    call SetPlayerController(Player(5), MAP_CONTROL_USER)

    // Player 6
    call SetPlayerStartLocation(Player(6), 6)
    call ForcePlayerStartLocation(Player(6), 6)
    call SetPlayerColor(Player(6), ConvertPlayerColor(6))
    call SetPlayerRacePreference(Player(6), RACE_PREF_NIGHTELF)
    call SetPlayerRaceSelectable(Player(6), false)
    call SetPlayerController(Player(6), MAP_CONTROL_USER)

    // Player 7
    call SetPlayerStartLocation(Player(7), 7)
    call ForcePlayerStartLocation(Player(7), 7)
    call SetPlayerColor(Player(7), ConvertPlayerColor(7))
    call SetPlayerRacePreference(Player(7), RACE_PREF_HUMAN)
    call SetPlayerRaceSelectable(Player(7), false)
    call SetPlayerController(Player(7), MAP_CONTROL_USER)

    // Player 8
    call SetPlayerStartLocation(Player(8), 8)
    call ForcePlayerStartLocation(Player(8), 8)
    call SetPlayerColor(Player(8), ConvertPlayerColor(8))
    call SetPlayerRacePreference(Player(8), RACE_PREF_HUMAN)
    call SetPlayerRaceSelectable(Player(8), false)
    call SetPlayerController(Player(8), MAP_CONTROL_USER)

    // Player 9
    call SetPlayerStartLocation(Player(9), 9)
    call ForcePlayerStartLocation(Player(9), 9)
    call SetPlayerColor(Player(9), ConvertPlayerColor(9))
    call SetPlayerRacePreference(Player(9), RACE_PREF_HUMAN)
    call SetPlayerRaceSelectable(Player(9), false)
    call SetPlayerController(Player(9), MAP_CONTROL_USER)

    // Player 10
    call SetPlayerStartLocation(Player(10), 10)
    call ForcePlayerStartLocation(Player(10), 10)
    call SetPlayerColor(Player(10), ConvertPlayerColor(10))
    call SetPlayerRacePreference(Player(10), RACE_PREF_HUMAN)
    call SetPlayerRaceSelectable(Player(10), false)
    call SetPlayerController(Player(10), MAP_CONTROL_USER)

endfunction

function InitCustomTeams takes nothing returns nothing
    // Force: TRIGSTR_5446
    call SetPlayerTeam(Player(0), 0)
    call SetPlayerTeam(Player(1), 0)
    call SetPlayerTeam(Player(2), 0)
    call SetPlayerTeam(Player(3), 0)
    call SetPlayerTeam(Player(4), 0)
    call SetPlayerTeam(Player(5), 0)
    call SetPlayerTeam(Player(7), 0)
    call SetPlayerTeam(Player(8), 0)
    call SetPlayerTeam(Player(9), 0)
    call SetPlayerTeam(Player(10), 0)

    //   Allied
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(7), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(8), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(9), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(10), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(7), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(8), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(9), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(10), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(7), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(8), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(9), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(10), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(7), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(8), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(9), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(10), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(7), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(8), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(9), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(10), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(7), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(8), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(9), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(10), true)
    call SetPlayerAllianceStateAllyBJ(Player(7), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(7), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(7), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(7), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(7), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(7), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(7), Player(8), true)
    call SetPlayerAllianceStateAllyBJ(Player(7), Player(9), true)
    call SetPlayerAllianceStateAllyBJ(Player(7), Player(10), true)
    call SetPlayerAllianceStateAllyBJ(Player(8), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(8), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(8), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(8), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(8), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(8), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(8), Player(7), true)
    call SetPlayerAllianceStateAllyBJ(Player(8), Player(9), true)
    call SetPlayerAllianceStateAllyBJ(Player(8), Player(10), true)
    call SetPlayerAllianceStateAllyBJ(Player(9), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(9), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(9), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(9), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(9), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(9), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(9), Player(7), true)
    call SetPlayerAllianceStateAllyBJ(Player(9), Player(8), true)
    call SetPlayerAllianceStateAllyBJ(Player(9), Player(10), true)
    call SetPlayerAllianceStateAllyBJ(Player(10), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(10), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(10), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(10), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(10), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(10), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(10), Player(7), true)
    call SetPlayerAllianceStateAllyBJ(Player(10), Player(8), true)
    call SetPlayerAllianceStateAllyBJ(Player(10), Player(9), true)

    //   Shared Vision
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(7), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(8), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(9), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(10), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(7), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(8), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(9), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(10), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(7), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(8), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(9), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(10), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(7), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(8), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(9), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(10), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(7), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(8), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(9), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(10), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(7), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(8), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(9), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(10), true)
    call SetPlayerAllianceStateVisionBJ(Player(7), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(7), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(7), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(7), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(7), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(7), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(7), Player(8), true)
    call SetPlayerAllianceStateVisionBJ(Player(7), Player(9), true)
    call SetPlayerAllianceStateVisionBJ(Player(7), Player(10), true)
    call SetPlayerAllianceStateVisionBJ(Player(8), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(8), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(8), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(8), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(8), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(8), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(8), Player(7), true)
    call SetPlayerAllianceStateVisionBJ(Player(8), Player(9), true)
    call SetPlayerAllianceStateVisionBJ(Player(8), Player(10), true)
    call SetPlayerAllianceStateVisionBJ(Player(9), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(9), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(9), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(9), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(9), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(9), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(9), Player(7), true)
    call SetPlayerAllianceStateVisionBJ(Player(9), Player(8), true)
    call SetPlayerAllianceStateVisionBJ(Player(9), Player(10), true)
    call SetPlayerAllianceStateVisionBJ(Player(10), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(10), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(10), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(10), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(10), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(10), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(10), Player(7), true)
    call SetPlayerAllianceStateVisionBJ(Player(10), Player(8), true)
    call SetPlayerAllianceStateVisionBJ(Player(10), Player(9), true)

    // Force: TRIGSTR_5447
    call SetPlayerTeam(Player(6), 1)

endfunction

function InitAllyPriorities takes nothing returns nothing

    call SetStartLocPrioCount(0, 9)
    call SetStartLocPrio(0, 0, 1, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(0, 1, 2, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(0, 2, 3, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(0, 3, 4, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(0, 4, 5, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(0, 5, 7, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(0, 6, 8, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(0, 7, 9, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(0, 8, 10, MAP_LOC_PRIO_HIGH)

    call SetStartLocPrioCount(1, 9)
    call SetStartLocPrio(1, 0, 0, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(1, 1, 2, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(1, 2, 3, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(1, 3, 4, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(1, 4, 5, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(1, 5, 7, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(1, 6, 8, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(1, 7, 9, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(1, 8, 10, MAP_LOC_PRIO_HIGH)

    call SetStartLocPrioCount(2, 9)
    call SetStartLocPrio(2, 0, 0, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(2, 1, 1, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(2, 2, 3, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(2, 3, 4, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(2, 4, 5, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(2, 5, 7, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(2, 6, 8, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(2, 7, 9, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(2, 8, 10, MAP_LOC_PRIO_HIGH)

    call SetStartLocPrioCount(3, 9)
    call SetStartLocPrio(3, 0, 0, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(3, 1, 1, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(3, 2, 2, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(3, 3, 4, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(3, 4, 5, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(3, 5, 7, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(3, 6, 8, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(3, 7, 9, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(3, 8, 10, MAP_LOC_PRIO_HIGH)

    call SetStartLocPrioCount(4, 9)
    call SetStartLocPrio(4, 0, 0, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(4, 1, 1, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(4, 2, 2, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(4, 3, 3, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(4, 4, 5, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(4, 5, 7, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(4, 6, 8, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(4, 7, 9, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(4, 8, 10, MAP_LOC_PRIO_HIGH)

    call SetStartLocPrioCount(5, 9)
    call SetStartLocPrio(5, 0, 0, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(5, 1, 1, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(5, 2, 2, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(5, 3, 3, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(5, 4, 4, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(5, 5, 7, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(5, 6, 8, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(5, 7, 9, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(5, 8, 10, MAP_LOC_PRIO_HIGH)

    call SetStartLocPrioCount(6, 10)
    call SetStartLocPrio(6, 0, 0, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(6, 1, 1, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(6, 2, 2, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(6, 3, 3, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(6, 4, 4, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(6, 5, 5, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(6, 6, 7, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(6, 7, 8, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(6, 8, 9, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(6, 9, 10, MAP_LOC_PRIO_HIGH)

    call SetStartLocPrioCount(7, 9)
    call SetStartLocPrio(7, 0, 0, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(7, 1, 1, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(7, 2, 2, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(7, 3, 3, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(7, 4, 4, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(7, 5, 5, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(7, 6, 8, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(7, 7, 9, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(7, 8, 10, MAP_LOC_PRIO_HIGH)

    call SetStartLocPrioCount(8, 9)
    call SetStartLocPrio(8, 0, 0, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(8, 1, 1, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(8, 2, 2, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(8, 3, 3, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(8, 4, 4, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(8, 5, 5, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(8, 6, 7, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(8, 7, 9, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(8, 8, 10, MAP_LOC_PRIO_HIGH)

    call SetStartLocPrioCount(9, 9)
    call SetStartLocPrio(9, 0, 0, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(9, 1, 1, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(9, 2, 2, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(9, 3, 3, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(9, 4, 4, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(9, 5, 5, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(9, 6, 7, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(9, 7, 8, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(9, 8, 10, MAP_LOC_PRIO_HIGH)

    call SetStartLocPrioCount(10, 9)
    call SetStartLocPrio(10, 0, 0, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(10, 1, 1, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(10, 2, 2, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(10, 3, 3, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(10, 4, 4, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(10, 5, 5, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(10, 6, 7, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(10, 7, 8, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(10, 8, 9, MAP_LOC_PRIO_HIGH)
endfunction

//***************************************************************************
//*
//*  Main Initialization
//*
//***************************************************************************

//===========================================================================
function main takes nothing returns nothing
    call SetCameraBounds(- 8192.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), - 8704.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM), 8192.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), 7680.0 - GetCameraMargin(CAMERA_MARGIN_TOP), - 8192.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), 7680.0 - GetCameraMargin(CAMERA_MARGIN_TOP), 8192.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), - 8704.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM))
    call SetDayNightModels("Environment\\DNC\\DNCLordaeron\\DNCLordaeronTerrain\\DNCLordaeronTerrain.mdl", "Environment\\DNC\\DNCLordaeron\\DNCLordaeronUnit\\DNCLordaeronUnit.mdl")
    call NewSoundEnvironment("Default")
    call SetAmbientDaySound("SunkenRuinsDay")
    call SetAmbientNightSound("SunkenRuinsNight")
    call SetMapMusic("Music", true, 0)
    call InitSounds()
    call CreateRegions()
    call CreateAllDestructables()
    call CreateAllUnits()
    call InitBlizzard()

call ExecuteFunc("jasshelper__initstructs149790140")
call ExecuteFunc("PassiveMissiles__Init")
call ExecuteFunc("SpellLeech__Init")

    call InitGlobals()
    call InitCustomTriggers()
    call RunInitializationTriggers()

endfunction

//***************************************************************************
//*
//*  Map Configuration
//*
//***************************************************************************

function config takes nothing returns nothing
    call SetMapName("TRIGSTR_116")
    call SetMapDescription("TRIGSTR_118")
    call SetPlayers(11)
    call SetTeams(11)
    call SetGamePlacement(MAP_PLACEMENT_TEAMS_TOGETHER)

    call DefineStartLocation(0, 7040.0, 7232.0)
    call DefineStartLocation(1, 7040.0, 7232.0)
    call DefineStartLocation(2, 7040.0, 7232.0)
    call DefineStartLocation(3, 7040.0, 7232.0)
    call DefineStartLocation(4, 7040.0, 7232.0)
    call DefineStartLocation(5, 7040.0, 7232.0)
    call DefineStartLocation(6, 7680.0, 7232.0)
    call DefineStartLocation(7, 7040.0, 7232.0)
    call DefineStartLocation(8, 7040.0, 7232.0)
    call DefineStartLocation(9, 7040.0, 7232.0)
    call DefineStartLocation(10, 7040.0, 7232.0)

    // Player setup
    call InitCustomPlayerSlots()
    call InitCustomTeams()
    call InitAllyPriorities()
endfunction




//Struct method generated initializers/callers:
function sa___prototype2_DamageEngine_RegisterFromHook takes nothing returns boolean
    call DamageEngine_RegisterFromHook(f__arg_trigger1,f__arg_string1,f__arg_limitop1,f__arg_real1)
    return true
endfunction

function jasshelper__initstructs149790140 takes nothing returns nothing
    set st___prototype2[1]=CreateTrigger()
    call TriggerAddAction(st___prototype2[1],function sa___prototype2_DamageEngine_RegisterFromHook)
    call TriggerAddCondition(st___prototype2[1],Condition(function sa___prototype2_DamageEngine_RegisterFromHook))



    call ExecuteFunc("s__Damage_onInit")
endfunction

