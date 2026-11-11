# Requested gameplay patch — November 8

Baseline: 3.2.0 r8, commit a775b1d. This is an intentional gameplay patch,
separate from the completed behavior-preserving refactor. Historical evidence
and the frozen r8 source/data remain immutable. Warcraft and World Editor must
not be launched by the agent.

## Confirmed decisions

- All leaving players, including the Ancient, have a 60-second takeover window.
- Race stock is visible immediately; purchases stay locked for the 20-second ban phase.
- Ice's healing prevention affects enemies only.
- Cultist is added to the selectors. Random remains on the first selector to leave room for all 11 choices in the second.
- The maintainer delegated Cultist research pricing to comparison with existing upgrades.
- Chaotic Burst converts an empowered attack's normal damage into pure damage,
  ignoring armor and magic resistance, and charges 4% of current HP on a successful hit.
- Attack research has five levels, each adding 75 damage and 75 range. Per-level
  costs are 5/20/35/50/65 gold and 250/1000/1750/2500/3250 lumber.

## Implementation checklist

- [x] Remove orb/buff-placement conflicts from Poisoned Bullets and Bleed.
- [x] Show faction stock at startup; bans remove stock; retain pick unlock timing.
- [x] Investigate Lightning passive crash; fix demonstrated unsafe operations and document native verification limits.
- [x] Correct upgraded Aethyr wall feed values.
- [x] Correct Nature's Grasp, Spirit Tree Defense and Moon Well descriptions.
- [x] Restore Wildkin research ability levels after Wisp rebirth.
- [x] Add an authorized, non-stacking `-bringiton` command doubling Ancient passive gold only.
- [x] Move the actual Ancient lobby role to slot 11/dark green, keeping map configuration and ownership consistent.
- [x] Implement 60-second leaver takeover for dead/unpicked players, with messages and cleanup cancellation.
- [x] Cultist green projectile, base range 200, three researched abilities and five attack upgrades.
- [x] Cultist role/stat tooltip, complete ability descriptions, research hotkeys and command-card layout across its buildings.
- [x] Enforce one Amalgamation per player, including multiple production buildings and queued orders.
- [x] Ice: 400 HP/s for 25 seconds, enemy movement slow 20% and enemy healing prevention in radius 2000.
- [x] Light: non-dispellable Vanguard; normal attack damage during Nuke.
- [x] Add focused behavior/object regressions and explicit patch migration evidence; preserve existing checks for unchanged behavior.
- [x] Update patch notes/testing reference, build, verify archive and install only the latest map.

## Review and delivery

The maintainer completed the native World Editor save on November 8. The map
now uses native format v39 / 3.0.1.24371. All 45 placements were checked, including
the Ancient's five buildings in slot 11 (Dark Green), with unchanged placement
identities and coordinates. The pending-save guard has been cleared by export.

Two editor interoperability problems were repaired: percent characters in custom
Lua corrupted the first save attempt; depth-first WTG/WCT ordering was necessary
to retain the correct script associations. The final source uses equivalent safe
spellings. The successful native save is backed up, and the repair preserved its
creation/configuration code while restoring all 103 unchanged source modules.
See `reports/editor-roundtrip-repair.json` and the immutable editor-save fixture.

The r10 build passed both Lua numeric configurations, 438 editor-safe source
assertions per configuration, 496 startup assertions, 1,883 shopping assertions,
68 patch assertions, and 6,618 object checks. The build/import workflow last passed
all 13 isolated checks on November 8; these presentation changes did not alter that
workflow. Every packed payload was read back and checked. Frozen historical
r8 suites remain separate evidence, not coverage of changed gameplay.

Playable artifact: `dist/Forest_Expansion_3.2.0_Lua.w3x`.
SHA-256: `e1a0c0fa6c3777a4c2d69fff9304327a5f3adeee8911d09ac047892ab2d35ecd`.
The installed r9 file was locked, so the installer copied r10 with the suffix
`-build-e1a0c0fa6c37.w3x` and queued checksum-guarded removal of the old copy.
See the installer result in `reports/build.json`; a pending cleanup is not a
completed removal. Build and validation reports pin the exact archive above.
The editor's in-memory copy must be reopened before further editing.

Do not rerun `tools/ancient_slot.py --apply` or the old `work/nov8_objects.py`
migration: the final data includes native editor format and string-table changes.
The poison object finalizer has already run. Future ordinary builds use the normal
workflow; future placement/configuration edits still require a native editor save.

Live gameplay, multiplayer synchronization, native autocast/dispels and Lightning's
reported engine crash still require maintainer testing. The implementation
checklist records completed changes, not a claim of exhaustive native correctness.
Use `PATCH_TESTING.md` for the remaining live checks.
