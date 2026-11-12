# Gameplay patch testing

The maintainer runs Warcraft and World Editor. The agent must not launch either.

## Quick solo setup

Start with one human and use `-test skip`, `-gold 10000`, and `-lumber 100000`.
Select your owned unit before using a test command. Full codes remain in
[DEBUG_REFERENCE.md](DEBUG_REFERENCE.md).

| Check | Setup and expected result |
|---|---|
| Picking | Without skipping, eligible choices are visible but have no purchasable stock. Cultist appears only in solo test mode; in multiplayer it stays absent, including after other players leave. An unavailable Cultist ban must not spend a ban. Try clicking races at 1, 10 and 19 seconds: no race spawns and no gold is spent. The countdown stays until 20 seconds, when Expanders unlock; Ancients stay locked until 60. Red can ban Cultist or another choice on each selector; only that choice disappears and stays gone after unlock or solo skip. Unbanned choices must still work. Random is on the first selector and must never select a banned faction; check the Ancient random option too. |
| Lobby | Ancient is slot 11 / Dark Green; its shops and starting selector belong to that slot. Slot 7 is an Expander. |
| Cultist | In a match started with one human, pick Cultist, or use `-spawn h063`. Use `-spawn h06D` for the Altar. Research the three abilities and five Profane Reach levels. Open **Blood Rites** for the abilities. Base range is 200; fully researched range is 575, with +375 damage. |
| Cultist projectile | Before upgrades, the attack panel should show 100 damage. Attack from maximum range: a green projectile should travel from the Cultist to its target, then show its impact. Repeat with Chaotic Burst on and off, and after range upgrades. |
| Cultist menus | Main card: worker commands, Death Jump (Q), Summon Shinigami (W), Blood Rites (R). The book also shows Darkness Vigor and Magical Cloak. Check that the night speed/regen and 75% magic resistance still work with the book closed. All eight Altar researches and the Amalgamation button must be visible; inspect Shrine, Sanctuary and Outpost hotkeys too. |
| Aura | Damage Cultist to 50% health. Friendly units within 1000 range gain 25% attack/movement speed. Two Cultists use the stronger aura. Leaving range or killing the last source removes it. |
| Sacrifice | Toggle it on with damaged allies within 400 range. They gain 50 HP/s; Cultist takes 100 magic damage/s and receives no self-heal. Toggle off and confirm both stop. |
| Chaotic Burst | Right-click autocast. Each successful hit converts normal attack damage to pure damage and costs 4% of current HP. A single manual cast empowers one hit; autocast off restores ordinary damage. |
| Amalgamation | Use two Altars and try queueing two `H064` units. Only one should be allowed. |
| Bleed / poison | Research Bleed on Worgen and Poisoned Bullets on Ratling. Confirm they work alongside another orb/item attack effect. Poison grows to six stacks, refreshes on a landed hit, and resets after expiry. Dispel must not stop either debuff; damage over time alone leaves at least 2 HP. |
| Wildkin | Research Lunar Power, die, then revive through Wisp's Seed of Rebirth. Check all researched ability levels. |
| Ice | Use `-spawn O008`, select it and use `-level 20`. Sadism retains its 40% initial HP cost, heals 400 each second for 25 seconds, slows enemies within 2000 by 20% movement only, and blocks enemy healing. Check regeneration, a healing item and a triggered heal; allies must still heal. |
| Light | Use `-spawn O01V`. Cast Vanguard, dispel it, and check armor still lasts six seconds. During Nuke, normal attacks must damage targets in addition to the spin damage. |
| Lightning | Use `-spawn O016`, learn Lightning Strike through all seven levels and take repeated attacks. Check retaliation and normal casts. The reported native crash has not been reproduced by the offline tests. |
| Income | Red types `-bringiton`. Ancient passive income becomes 20 gold every 10 seconds. Repeating the command must not multiply it again. |

## Multiplayer takeover

Have an Expander leave and confirm their units remain. A dead or unpicked
Expander can type `-takeover`; if several players left, choose `-takeover <slot>`.
Repeat with the Ancient. Both windows last 60 seconds. Check that inherited
research works and that neither the transferred army nor the taker's previous
units disappear at the old deadline. The old race-selection token is removed
to prevent buying an extra race. If nobody takes over, remaining leaver units
are removed after 60 seconds.

## Multiplayer desync retest

Use the same fresh r11 archive for every player. Verify the opening build label;
record the SHA-256 from the release checksum file. A running match cannot adopt
an updated archive. Play beyond the previous failure time with the same races
and Ancient, using shops, Cultist abilities, Ice, damage-over-time attacks and
leaver takeover when practical.

If a player drops, record the exact message, approximate match time, involved
units/abilities, player count, operating systems, and Classic/Reforged graphics.
Keep the replay if Warcraft produces one. These details distinguish a state
mismatch from a crash or connection loss. The timer fixes remove known-risk code
patterns; the friend's reported midgame desync has not been reproduced.
See the [desync audit](https://github.com/clankermaster95/ForestExpansionLua/blob/main/reports/desync-audit-r11.json) for reviewed systems, findings and limits.

### Historical problem actors

| Actor | Focused check |
|---|---|
| Ghoul hero / Abomination | Train from Graveyard; attack with and without researched Plague, trigger critical strikes, and Blink during combat. Its combat abilities are native object data. |
| Lightning Ancient | Cast Lightning Strike and take attacks at every learned level; test several attackers and repeated retaliation. |
| Sand Ancient | Exercise each spell individually, especially Sandstorm levels 1–7; overlap countdowns with another cast and use Ancient Grasp repeatedly. |
| Ice Ancient | Repeated Freeze Zone casts on groups, targets dying during the delayed slow, Freezing Breath impacts, Chill and Sadism; overlap with other damage and heals. |

The code review found no proven cause of the old JASS-era desyncs. Relevant
references include the [Lua GUI timer reproduction](https://us.forums.blizzard.com/en/warcraft3/t/lua-gui-timers-always-desync-minimal-repro/36941)
(LAN reproduced; Battle.net trials did not), and a [solved Flame Strike freeze](https://www.hiveworkshop.com/threads/solved-game-freezing-only-with-one-hero.362010/)
caused by a zero half-damage interval. Lightning and Sand do not have that zero
interval. Their mechanics were preserved while Lua timer ownership was hardened.

## Implementation choices and limits

- Red is the command authority, matching existing map commands. The map has no
  reliable synchronized API for identifying the actual lobby host.
- Cultist ability research is single-level: Aura 30 gold / 750 lumber, Sacrifice
  25 / 750, Burst 35 / 1000. Existing Altar upgrades cost roughly 20–35 gold and
  500–1000 lumber; the new abilities use that range. Research times are 30/30/40
  seconds. Profane Reach takes 20 seconds per level and totals 175 gold / 8750
  lumber. There are no extra prerequisites beyond Altar access.
- Ice rejects script-driven healing writes. Warcraft has no general healing
  event, so native regeneration/healing is capped every 1/32 second and before
  damage, while damage losses are tracked. Native HP bars may show a transient
  increase within a frame. Verify native spell interactions in the game.
- Lightning now uses a captured Damage Engine target/owner, ignores unlearned
  strikes, uses a dedicated dummy and explicitly defines all seven strike
  levels. These fix identifiable hazards; they do not prove the original 3.0
  crash is resolved.
- The offline suites exercise state transitions, timing, source/data consistency
  and archive readback. They do not simulate native buff stacking, command cards,
  autocast AI, dispels or multiplayer synchronization.

Technical references: [Blizzard Moon Well statistics](https://classic.battle.net/war3/nightelf/buildings/moonwell.shtml),
[ability damage-type experiments](https://www.hiveworkshop.com/threads/spell-ability-damage-types-and-what-they-mean.316271/),
[native Flame Strike data/timing audit](https://corepunch.github.io/open-realm/games/warcraft-3/ability-verification-review/).
Poison's non-dispellable/nonlethal rules follow [Blizzard's spell basics](https://classic.battle.net/war3/basics/spellbasics.shtml).
Passive effects in a closed book follow the original [Spellbook tutorial](https://www.hiveworkshop.com/threads/the-mysteries-of-the-spellbook.33039/).
Armor research uses the unit's Defense Upgrade Bonus; see the [ArmorUtils author's explanation](https://www.hiveworkshop.com/threads/system-vjass-armorutils-v2-0-1.319734/).
The pick preview uses empty stock with a zero cap, following a [tested zero-stock shop technique](https://www.hiveworkshop.com/threads/legion-td-mega-3-5-b4-3-41-unprotect.194224/page-12). Unlock replaces only unbanned previews with purchasable stock. Projectile speed and damage-dice field IDs are checked independently against Blizzard's declarations in `tools/reference-api/common.j`.

## Tooltip review

- Compare build/train tooltips with newly created, unupgraded units: Gate (750 HP), Wildkin Den (400 HP), Nerubian Ziggurat/Tower (300 HP), and Bounty Hunter (1.7 attack cooldown).
- Check both learn menus and learned spells: Sadism (25 seconds), Vanguard (undispellable armor), and Reckoning/Nuke (normal attacks allowed).
- Check Bleed and Poisoned Bullets across levels, summon descriptions, item ground/shop text, and color/hotkey rendering.
- Psychic Drain combines native channeling with a scripted drain; its exact live tick-rate total is not claimed in the tooltip. Spellcaster's Cloak reads its inherited resistance directly through the ability reference.
