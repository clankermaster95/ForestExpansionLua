# Proactive gameplay review — r15

This pass starts from published r14 (`f4c7aa3`). It scans all 77 active modules for the existing synchronization/lifetime rules and the new temporary-allocation rule, then exercises the concrete defects below. Seventeen gameplay modules changed. This is not a claim that every gameplay path was manually proved correct or that all bugs/desyncs have been eliminated.

## Repairs

| Area | Failure | Regression coverage |
|---|---|---|
| Nebula Recall | A single global target was shared by simultaneous casts; cancelled casts retained that target. | Two casters, reversed completion, cancellation, dead/removed targets, caster death and scripted removal. Per-caster targets clear on every exit. |
| Galactic Fury | Completion healed whichever caster most recently started the spell. | Two independent casters finish; only the finishing caster heals. Dead casters are not healed. |
| Time Warp | Origin damage used the global Ancient instead of the actual caster; locations and a group leaked. | Actual caster, unchanged origin radius/damage, enemy-only destination damage, repeated cleanup. |
| Soulreaper Avatar, Blur, Surge of Darkness, Conjure Mana | An earlier cast's delayed cleanup removed a newer cast's bonus. | Recast before expiry, independent casters, latest expiry and removal. Existing durations and damage/mana formulas remain. |
| Ratling Chemical Rage | Earlier expiry cancelled a recast; expiry while dead skipped attack-cooldown restoration. | Latest cast owns expiry; original cooldown is restored on corpses as well as living units. Each dummy is removed. |
| Realm of Darkness | Earlier expiry ended a recast; targets changing ownership/alliance could escape cleanup. | Track applied recipients through ownership changes, entering units and direct removal. Latest expiry clears the debuff and destroys the retained group. |
| Kobold revival | Shovel Strike returned to its base level despite retained research. | Real Wisp rebirth path at zero/max research, owner/type checks, absent abilities preserved. The spell is in Kobold's A01Y spellbook; A086 has 11 levels and R004 has 10 research levels. |
| Takeover research | Copying technology does not invoke the scripted research-finish handlers. Inherited units and survivors could retain lower ability levels. | Actual takeover with both higher/lower research: Wildkin, Worgen, Bloodmage, Kobold, Silent Strider and Deepwater. The greater research level applies to both armies. |
| Temporary resources | Repeated research, spells, regular AI, death queries and MiniMini spawns retained groups, locations or effects. | Ten research handlers, seven flag predicates, all eight MiniMini types, item drop/stun/summon locations, AI selection/roaming, empty groups and repeated uses. |

The temporary-resource repair preserves existing target filters, random bounds/draw order, spawn coordinates and item restrictions. It releases owned handles after their last use. The Recall removal wrapper chains the existing native/wrapper and preserves its return value; it does not replace the earlier Nerubian spire cleanup.

## Checks and evidence

- `tests/poke.lua`: **8,714 assertions across 34 scenarios** in each Lua numeric mode. All 34 scenarios fail against the unchanged r14 source. These are scenario failures, not a count of distinct bugs.
- `tests/runtime_audit.lua`: **212 assertions**, including Kobold's actual rebirth path. The new rebirth regression fails on r14.
- `tests/gameplay_patch.lua`: **77 assertions**, including merged research on both armies. The new takeover regression fails on r14.
- `tools/resource_audit.py`: disallows temporary group/location allocations hidden inside another call, where their handles cannot be explicitly released. Five negative and three positive probes cover the guard. A captured handle still needs lifetime review; this is not a general leak detector.
- Full current-map tests pass: historical preservation fixtures, startup/bans/shops/flags, timers, source/editor correspondence, native object schemas, tooltips, binary codecs and MPQ readback. No object balance or selector data changes are part of this pass.
- `poke-r15.json` records the source hashes, exact existing callback changes, all-module allocation inventory and failures against the published baseline. Native editor evidence is recorded separately in `editor-validation-r15.json` and `editor-object-roundtrip-r15.json`.

## Remaining checks

Native multiplayer desyncs remain unreproduced. These doubles cannot establish Warcraft's event ordering, rendering, pathing, actual frame rate or client synchronization. The maintainer should test interrupted/completed Recall, buffs through death/revival, takeover research and sustained combat in a fresh match; see `PATCH_TESTING.md`.

The earlier uncertain findings are still explicit: Ancient learn handlers enabling another handler during the same native event need an event-order check; the AI's 25-entry list sampled over 1–8 needs a design decision before changing its variety; the periodic Death_anim callback has no decay-event context, but rebinding it could change corpse/resurrection behavior. They are not silently counted as fixed. Other spells and unusual multi-caster combinations remain subject to gameplay testing.
