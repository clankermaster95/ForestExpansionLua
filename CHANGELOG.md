# Forest Expansion 3.2.0 — Lua edition

Changes from **Forest Expansion 3.1.2a** to **3.2.0**.

## Lua and code organization

- Converted the map's gameplay code from JASS to Lua while preserving the original terrain, map layout and imported assets.
- Consolidated 375 numbered gameplay scripts into 60 named modules organized by system, expander race and Ancient.
- Replaced repeated picker/ban logic with a shared faction catalog, consolidated spell/research handlers and Ancient metadata, organized test commands, and removed unused generated helper functions.
- Centralized Ancient ownership checks so role-dependent behavior follows the Ancient player rather than a hardcoded player color or slot.

## Ancient shops and recipes

- Shops automatically choose your nearby Ancient as the item recipient without changing your selected unit.
- Buying a recipe uses ingredients already in your inventory and purchases missing components, including nested recipes, to create the finished item.
- Owned ingredients reduce the price. Failed completion refunds the purchased scroll and retains your ingredients.
- Corrected the Ancient shops' stock configuration associated with purchased items dropping on the ground.
- Recipe tooltips now distinguish full price, scroll price and component requirements. Corrected inconsistent finished-item values and several item names.
- Automatic shop debug messages are off. Solo troubleshooting can be enabled explicitly with `-test shop on`.

## Solo testing

- Matches that start with exactly one human automatically enable testing commands and disable automatic victory/defeat timers. Computer slots are allowed.
- Added gold, lumber, XP, level, unit/item spawning, healing, cooldown, visibility and other testing commands. Use `-test help` in chat.
- `-test skip` unlocks hero/race picking immediately for testing.
- Complete spawn codes and command instructions are supplied in a separate **DEBUG_REFERENCE.md** document. The Information menu contains no generated debug catalogs.
- Matches that start with multiple humans never unlock test commands when players leave.

## Fixes and presentation

- Corrected string-table encoding used for map names and descriptions, and added a label to the first picking countdown.
- Fixed selector removal so unrelated unit purchases are not affected.
- Corrected several ownership, delayed-event, resource-price and combat-calculation issues, including Cosmic Strike reading the wrong damage-event mana source.
- Corrected temporary-location/group cleanup in Drain, fountain healing and gold-location pings.
- Removed a zero damage interval from the unused Arcane Strike spell definition and added guards for authored Flame Strike intervals.
- Added offline regression tests, native map-data validation and archive readback checks to the build process.
- Hardened Lua timer initialization and ownership: native objects are allocated during map initialization, recurring and delayed systems retain their timers until cleanup, and gameplay avoids GUI timer globals. Added initialization and forced-garbage-collection regression checks.
- Stored Lua uses editor-safe percent characters, with checks that preserve command patterns, displayed text and arithmetic during editor saves.

## Picking, takeover and balance

- The Ancient uses lobby slot 11 (Dark Green), including its starting units and shops.
- Race and Ancient choices are visible immediately with purchasing blocked until their phase opens. Bans remove choices from stock and from random selection, and remain applied after unlock or solo skip. Expanders unlock after the 20-second ban phase, and the Ancient keeps its 60-second start. Cultist is available only in solo test mode and is hidden in multiplayer. Random is available on the first race selector.
- Leaving players' armies remain for 60 seconds, including the Ancient's. Dead or unpicked Expanders can use `-takeover` (or `-takeover <slot>` when several players leave). Successful takeover preserves their own surviving units and transfers the departed player's units, resources and research.
- Red can enable `-bringiton` once to double the Ancient's passive income from 10 to 20 gold every 10 seconds. Starting gold and kill rewards are unchanged.
- Bleed and Poisoned Bullets use landed-hit debuffs rather than native orb effects. Poison stacks up to six times on each target; their damage over time remains nonlethal and cannot be dispelled.
- Upgraded Aethyr walls now feed 20 gold. Wildkin regains researched ability levels after Wisp rebirth.
- Corrected Nature's Grasp's tooltip, Spirit Tree's 5-armor description and Moon Well's building statistics.
- Hardened Lightning's retaliation against invalid damage-event context and unlearned spell levels; its strike data explicitly defines higher-level values.

## Cultist

- Available only when the match starts with one human and the existing solo test mode is enabled automatically. Multiplayer departures do not unlock it. Unavailable Cultist bans do not consume a ban.
- Builder description follows the other races' role, difficulty and stat layout. Corrected summon, worker and tower details; organized building research buttons, hotkeys and ability descriptions, and removed a stray spell debug message.
- Green projectiles travel at 900 speed; 200 base attack range and 100 unupgraded attack damage.
- New Altar research, with abilities grouped under **Blood Rites**: Sacrificial Aura (30 gold / 750 lumber), Bloody Sacrifice (25 / 750), and Chaotic Burst (35 / 1000). Each has one research level and no additional prerequisite beyond access to the Altar.
- Sacrificial Aura grants allied units within 1000 range 5% attack and movement speed per full 10% of the Cultist's missing health, up to 45%. The strongest nearby Cultist aura applies.
- Bloody Sacrifice toggles 50 HP/s healing to other allies within 400 range, costing the Cultist 100 magic damage each second. It can kill the Cultist.
- Chaotic Burst supports manual attacks and autocast. It converts the attack's normal damage to pure damage, bypassing armor and magic resistance, and charges 4% of the Cultist's current HP on a successful empowered hit. Misses cost no HP.
- Profane Reach adds 75 attack damage and 75 range per level, up to five levels. Costs: 5/20/35/50/65 gold and 250/1000/1750/2500/3250 lumber; total 175 gold and 8750 lumber.
- One Amalgamation per player, using the native training limit across Altars and queues.

## Ancient abilities

- Ice's Sadism heals 400 HP/s for 25 seconds, retaining its initial 40% current-health cost. During it, enemies within 2000 range are slowed by 20% movement speed and cannot heal. Allies remain unaffected.
- Light's Vanguard grants armor for six seconds through an undispellable ability. Nuke retains its area damage while allowing normal attacks to deal damage.

## Validation

Offline checks do not establish native engine behavior. Lightning crash reproduction, spell interactions and multiplayer desync testing still need live matches. Please include the map build, reproduction steps and screenshots when reporting an issue.
