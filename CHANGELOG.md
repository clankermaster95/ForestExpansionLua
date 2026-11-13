# Forest Expansion 3.2.0 — Lua edition

Cumulative **3.1.2a → 3.2.0** patch notes, through r13.

## General

- Ported JASS gameplay to Lua; preserved terrain, layout and assets.
- Moved Ancient to slot 11 (Dark Green); removed fixed-color ownership checks.
- Selectors show choices immediately; picking unlocks at 20 seconds for Expanders, 60 for Ancient.
- Bans apply to selectors and random picks, including after unlock/skip. Added Random to the first race selector.
- Fixed Worgen becoming unavailable after skipping and Random disappearing after a purchase. Skipping unlocks all eligible choices immediately.
- All leavers' armies remain for 60 seconds. Dead/unpicked Expanders can use `-takeover [slot]` to inherit units, resources and research without losing their surviving units.
- Added `-bringiton`: Red can double Ancient passive income to 20 gold/10 seconds, once per match.

## Shops and items

- Shops select your nearby Ancient as buyer without changing unit selection. Fixed stock settings causing ground drops.
- Recipes use owned ingredients and buy missing components, including nested recipes. Failed purchases refund scrolls and preserve ingredients.
- Aligned finished-item values and AI purchase costs with actual prices. Corrected item names and recipe ingredient/cost tooltips.
- Removed Protector Seed's unintended Keep requirement.
- Fixed multi-ledger crafting and XP going to the wrong carrier.
- Shop tracing is off by default; enable with `-test shop on`.

## Cultist — solo testing only

- Available with one starting human only. Excluded from multiplayer selectors/random; unavailable bans cost nothing.
- Green attack projectiles: 900 speed, 200 base range, 100 base damage.
- Added single-level **Blood Rites** upgrades at the Altar; no extra prerequisites:

| Upgrade | Cost | Effect |
|---|---|---|
| Sacrificial Aura | 30 gold, 750 lumber | Allies within 1000 range gain 5% attack/movement speed per full 10% missing Cultist HP, capped at 45%. Strongest aura only. |
| Bloody Sacrifice | 25 gold, 750 lumber | Toggle: heal other allies within 400 range for 50 HP/s; take 100 magic damage/s. Can kill the Cultist. |
| Chaotic Burst | 35 gold, 1000 lumber | Manual/autocast: converts attack damage to pure damage, bypassing armor/magic resistance. Costs 4% current HP per landed hit; misses cost nothing. |

- Profane Reach: five levels, each granting +75 damage and +75 range. Costs per level: **5/20/35/50/65 gold**, **250/1000/1750/2500/3250 lumber**. Total: 175 gold, 8750 lumber.
- Limited Amalgamation to one per player, including all Altar queues.
- Standardized builder/unit/building tooltips, research buttons and hotkeys; removed stray debug text.

## Ancients

- **Ice — Sadism:** healing reduced from 1000 to 400 HP/s; duration increased from 10 to 25 seconds. Enemies within 2000 range lose 20% movement speed and cannot heal. Initial 40% current-HP cost retained.
- **Light — Vanguard:** its six-second armor bonus can no longer be dispelled.
- **Light — Nuke:** normal attacks now deal damage during the ability.
- **Lightning:** corrected retaliation's damage source, invalid targets and unlearned-level handling; completed higher-level strike values.

## Other gameplay fixes

- Bleed and Poisoned Bullets no longer conflict with orb effects. Poison stacks up to six times per target; both damage-over-time effects remain nonlethal and undispellable.
- Removed the unintended +1 attack from Worgen's Bleed and Ratling's Poisoned Bullets.
- Fixed duplicate base-flag refunds, refunds using another player's lumber, and rejected flags leaving corpses/effects behind. Flag income follows surviving completed flags through ownership changes.
- Fixed Worgen gaining gold from harvest orders without harvesting; world-tree hits still award two gold.
- Upgraded Aethyr walls now feed 20 gold.
- Wildkin, Worgen and Bloodmage retain researched ability levels after Wisp revival. Executioner and Bloodmage upgrades now work in every Expander slot and after takeover.
- Fixed Shadow Dancer mana theft and restoration creating mana or failing to remove it.
- Fixed Ratling corrosion expiry and invisibility on replacement units, Deepwater on wells built after research, and dead Nerubian spires blocking nearby upgrades. Spire aura counts update when defeat or leaver cleanup removes units.
- Fixed Mech Blaster's melee scaling and mage mana restoration selecting the wrong attacker.
- Fixed Focused Anger corrupting unit tracking and misassigning stacks.
- Fixed delayed spell data for Conjure Mana, Ancient Grasp, Chill, Sadism, Vanguard, Worgen's strike and Shadowlings.
- Fixed Lightning Strike, Sandstorm and Freeze Zone interfering with other countdowns.
- Fixed Cosmic Strike using the wrong mana source and Realm of Darkness targeting the wrong units.
- Fixed living-player counts, rebirth ownership/type, environmental-death lackeys and stale respawns after revival/takeover.
- Fixed late-pick targets, unrelated purchases removing selectors and Fire ignoring the ban window.
- Fixed saved feed settings arriving late or out of order and overwriting manual choices. Bounties no longer compound after prevented deaths or revival.
- Corrected Nature's Grasp formatting, Spirit Tree's 5-armor description and missing Moon Well statistics.
- Fixed blank map names/descriptions and the first picking timer's label and early disappearance.
- Corrected Ancient hint and gold-ping recipients. Fixed Hard AI targeting loops and missed periodic attacks.
- Corrected unit/building stats, spell cooldowns, research-time labels, learn-menu descriptions, summon references, item effects, spelling, colors and duplicate hotkeys across tooltips; unit stat blocks now identify values before upgrades. Updated Sadism, Vanguard, Nuke, Bleed and Poisoned Bullets descriptions to match their current effects.

## Solo testing

- Automatically enabled with one starting human, including matches with computers; disables victory/defeat timers. Multiplayer departures never unlock testing.
- Added resource, XP, level, spawn, heal, revive, cooldown, vision and other commands: `-test help`. Both roles can skip picking waits with `-test skip`.
- Moved spawn codes and command instructions out of the Information menu into [DEBUG_REFERENCE.md](https://github.com/clankermaster95/ForestExpansionLua/blob/main/DEBUG_REFERENCE.md).

## Code and stability

- Consolidated 375 scripts into 60 named gameplay modules with shared data/handlers; removed redundant helpers.
- Corrected native initialization, timer ownership, GUI timer conflicts, shared player-group corruption and temporary-resource leaks in spells, research, picking, flags, income effects and AI targeting. Corrected a zero damage interval in the unused Arcane Strike definition.
- Corrected ability data fields so Warcraft reads the intended values for Bleed, Poisoned Bullets, Cultist abilities, Ice's slow, Vanguard and Lightning Strike.
- Added editor-save, gameplay/data and map-package checks. Build/LLM instructions: [LLM_GUIDE.md](https://github.com/clankermaster95/ForestExpansionLua/blob/main/LLM_GUIDE.md). Configured builds install the latest map and prune older managed copies.

**Testing:** Offline checks and World Editor load/save/reopen validation pass. Reported desyncs remain unreproduced; multiplayer gameplay testing is still needed.
