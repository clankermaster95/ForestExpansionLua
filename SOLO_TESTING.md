# Solo testing in 3.2.0

Cultist is available only in this solo test mode. It is hidden in multiplayer,
and does not unlock when a multiplayer match is reduced to one player.
Use `-test skip` to skip the picking wait; no `-teston` command is needed.

The separate [Testing reference](DEBUG_REFERENCE.md) contains the complete item and unit lists with names and spawn commands. Use Ctrl+F to find a name or code. Codes are case-sensitive: capital `I` is not the digit `1`.

In-game, use `-test help`, `-test items <name>`, `-test units <name>` or `-test find <name>`. The Information/F9 menu does not contain generated debug pages.

Start a **new match** with **Forest Expansion 3.2.0 Lua r8** in Warcraft III → Maps → Forest Expansion. Exactly one human must be present at match start; computer slots are allowed. Select the Ancient lobby slot for Ancient shopping. Red is an expander. The opening message must say **3.2.0 r8: SOLO TEST MODE ON. Victory timers OFF.** No command is needed to enable solo mode. The user runs these tests; the agent must not launch or control Warcraft.

If using World Editor's Test Map, first reopen the latest `dist/Forest_Expansion_3.2.0_Lua.w3x`. An editor already holding an older map continues to test that older copy. Installing a new build does not update the editor's memory or a running match. If an old installed copy is still locked by Warcraft, the cleanup worker can remove it after Warcraft releases it; closing Warcraft releases that file.

Select your own unit before unit commands. Selecting a shop/enemy retains your last owned target. Spawned heroes do not replace the match's Ancient or chosen expander. Ability and death gameplay still runs, but automatic victory/defeat and their countdowns are disabled in solo testing. Multiplayer-started matches retain normal results.

| Command | Effect |
|---|---|
| `-test help` | Show commands |
| `-test skip` (or `-skip`) | Unlock hero/race picks immediately, respecting bans; skip only the picking wait |
| `-gold 10000`, `-lumber 10000` | Add resources; negative amounts remove them; final amount clamped to 0–1,000,000 |
| `-xp 1000`, `-lvl 10` | Add XP / set hero level, 1–20 |
| `-test find human`, `-test find hammer` | Find case-sensitive unit/item IDs by name |
| `-test items`, `-test items 2`, `-test items armor` | Browse all item IDs in pages of 12 or search items |
| `-test units`, `-test units 2`, `-test units human` | Browse all unit IDs or search units |
| `-spawn h000 3` | Spawn three units nearby, maximum 20 |
| `-item I001`, `-item I004` | Spawn Helm of Devotion / Valor Armor on the ground nearby |
| `-item I00I`, `-item I00H` | Spawn completed Valorous Helmet / its recipe scroll; spawned scrolls do not simulate a shop payment |
| `-test heal`, `-test mana`, `-test cooldown` | Restore HP/mana or reset cooldowns once |
| `-test invul`, `-test vul` | Enable/disable invulnerability |
| `-test kill`, `-test revive`, `-test destroy` | Kill, revive a hero, or remove your target |
| `-test copy 3` | Spawn fresh units of the target type; does not copy items/levels |
| `-test reveal`, `-test hide` | Enable/disable map reveal |
| `-test speed 522`, `-test time 12` | Set speed / time of day |
| `-test unitid`, `-test itemid`, `-test loc` | Show target ID, first-slot item ID, coordinates |
| `-test shop` | All shop sales, recipe sales/completions/refunds, actual buyer, range and delivery result |
| `-test shop on`, `-test shop off` | Toggle automatic shop buy/pickup/drop/delivery messages; off by default; solo only |

All commands support `-test`. Short aliases also exist for gold, lumber, xp, lvl, unit/spawn, item, heal, mana, invul/vul, mh/nomh and cheats.

## Recipe retest

The Ancient shops use corrected native stock fields. Test the screenshot's **Spellcaster's Cloak** recipe: with none of its ingredients owned, a successful purchase should produce the finished cloak and charge **950 total gold** (350 scroll + 600 missing ingredients). With 1,050 gold this leaves 100, excluding income ticks. Already-owned ingredients reduce that charge. The sale counter should increase; use `-test shop` to inspect it.

Shop messages are off by default. To troubleshoot, enter `-test shop on`, then test an ordinary item with a free inventory slot. With tracing enabled, selecting a shop prints the intended Ancient, distance, activation radius and native order return value. Buying prints the order, then the **actual buyer from the sale event**, followed by pickup/delivery. An accepted selection order is not proof of the actual recipient. If it drops a treasure chest again, the trace distinguishes no sale event, no buyer, full inventory, a subsequent drop, and a rejected insertion. All-sale counters include ordinary items; recipe counters only include recognized recipe scrolls. Use F12 to read lines that faded.

1. As Ancient, get into Recipe Shop range and use `-gold 10000`.
2. With an empty inventory, buy Valorous Helmet's recipe. Expected: one completed helmet, **500 total gold** charged, including the 300-gold scroll.
3. Spawn/pick up `I001` and `I004`, then buy the recipe. Expected: both ingredients consumed, **300 gold** charged.
4. Fill all six slots, including `I001`, then buy the recipe if Warcraft permits it. A ground scroll should be consumed after delivery, and the result should occupy the ingredient's freed slot; **400 total gold** charged. Six unrelated items should produce a scroll refund without destroying anything.
5. If a scroll remains, run `-test shop` and report the counters, last result and recipe name. This helps distinguish a missing sale event from a rejected transaction.

Income ticks can change visible gold between observations. Test nested recipes and insufficient resources too. In a two-human match, no test commands should be available.
