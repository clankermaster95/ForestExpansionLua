# Runtime review for r13

This review traces active Lua event handlers and shared systems against published r12 (`3908a13`). It is not a claim that every gameplay interaction is correct or that the map cannot desync. Warcraft and World Editor were not launched by this reviewer.

The companion `runtime-review-r13.json` inventories all 77 active modules, distinguishes reviewed paths from generated-data inventory and delegated work, and lists the exact changed existing function names. Picking/startup/solo commands, base flags and object metadata belong to the other reviewers.

## Confirmed and repaired

| System | Failure | Repair and regression evidence |
| --- | --- | --- |
| Worgen income | Issuing a harvest order granted gold without completing any work. | Removed the order reward. 10,000 orders grant zero gold; a qualifying world-tree hit still grants two. |
| World-tree income | A Damage Engine callback used the native damage-source response, which is not the engine's authoritative source during replay/failsafe dispatch. Each hit also allocated an unreleased location. | Use `udg_DamageEventSource` and coordinate effects; ordinary/Worgen payouts remain one/two. Stress exercises 10,000 hits with no remaining effect handles. |
| Bounty Hunter | Damage feedback used the same native-source mismatch; Harvest Grapes leaked a location. | Feedback uses the matched engine source and still expires. The created grape and pickup order use explicit item/caster handles and coordinates. |
| Ratling corrosion | Cleanup removed magic-resistance reduction while its buff existed and retained it after expiry. | Remove the ability/tracking only after the buff expires. Repeated application/expiry leaves no tracked targets. |
| Ratling invisibility | Research was recorded only inside existing-unit enumeration; the entering-unit callback queried a researching unit in a region event. | Record research independently, release the enumeration group, and apply the ability to the actual entering unit. Tests distinguish owners and unrelated unit types. |
| Deepwater | Research completed without a current well did not persist for later construction. | Record the owner flag before enumeration and release the temporary group. Later wells receive the researched ability. |
| Nerubian spires | Death added the dead spire back into persistent tracking; duplicate/untracked events could corrupt the count; corpses blocked nearby upgrades; defeat/leaver cleanup removed spires without updating the count. | Remove tracked deaths and direct removals before native invalidation, reject duplicate/untracked count changes, and use live unit identity for proximity. Bulk removal updates surviving auras immediately. Original global count and radius rules remain. |
| Feed bounty | Repeated lethal callbacks and revived units scaled already modified bounty fields again. | Capture native baseline values per unit for the current damage turn; derive repeated writes from that baseline, then restore on an owned zero-delay timer and release the pending state. Tests cover prevented deaths, revival/rate changes, zero feed, independent targets, external field/type changes, removed targets and 1,000 repeated turns. |
| Mech Blaster | Melee/ranged logic read a configuration field that Damage Engine clears, so melee holders reverted to the ranged level on damage. | Read the actual damage source. Tests cover melee, ranged and non-holders. |
| Mage mana restoration | The predicate checked the damage victim's native trigger unit instead of the attacking mage. | Use the engine source; tests cover researched enemy attacks, non-mages hitting a mage, spells and allied targets. |
| Forgotten research | Executioner and Bloodmage research families still omitted the former Ancient slot, now an Expander slot. | Resolve Expander ordinals through `FE_Roles`; cover every Expander and changing Ancient ownership. Focused Anger queries current technology so copied takeover research works. Bloodmage research releases temporary groups. |
| Rebirth research | Wisp recreated Worgen and Bloodmage with base ability levels despite retained player research. | Restore their existing manually leveled abilities from the new owner's technology. The real rebirth handler is exercised at zero and maximum research; unrelated or absent abilities remain untouched. Object levels are 21 for Worgen and 11 for Bloodmage, matching research maxima of 20 and 10. |
| Role-specific UI | Ancient hints still targeted the former slot; gold pings omitted that Expander and fired twice for the current Ancient. | Use the current role for hints and mutually exclusive ping registrations. All 11 players receive one seven-ping set before/after role transfer, with temporary handles released. |
| Hard AI | Rejected random targets recursively retried with no bound; the retry callback read a filter unit outside filtering; periodic events failed a unit-event condition. | Filter the same eligible owners before uniform selection, stop cleanly with no candidates, issue orders to the chosen location, and distinguish periodic/death context. A 1,000-call stress check leaves no temporary groups/locations. Relative weights among eligible units remain uniform; rejected-draw RNG consumption intentionally changes. |

## Verification

`tests/runtime_audit.lua` exercises real module functions and trigger registrations with event-specific native doubles. It passes **203 behavioral assertions across 18 scenario groups** on both the default Lua 5.3.6 build and the binary32/int32 build. The unchanged r12 source fails all 18 scenario groups under the same suite. All 15 edited runtime modules pass `luac -p`.

The bounty fix uses strongly retained pending entries and explicitly owned timers, never weak-key gameplay state. Scaling and restoration preserve the original rounding, base/sides policy and dice count. Repository searches found no other runtime bounty-field writers or bounty-changing research records; changed native fields or unit types are nevertheless retained. The restoration assumes Warcraft awards the native bounty during the completed damage/death turn, before a zero-delay timer fires. The test double models that order; only a live game can confirm it. Check a normal kill and a revived unit at changed feed rates. The `RemoveUnit` wrapper is installed once during initialization, retains native return behavior, and reconciles spires before calling the captured native; current defeat and takeover cleanup resolve that global at execution time.

The source trace also reviewed the Damage Engine's native, nested, failsafe and deferred callback paths, spell timer/effect cleanup, local-only UI branches, synchronized feed-data receipt, recipe planning/consumption/delivery, player takeover/respawn paths, Ancient abilities, race callbacks and command handlers. No new client-local gameplay mutation was introduced. Those source observations and native doubles are not a multiplayer simulation or native rendering test.

## Remaining findings and limits

These were not included in this scoped patch and must not be described as fixed or established desync causes:

- Several inherited low-frequency GUI spell paths still allocate unowned locations or groups. Examples: Worgen/Wildkin/Kobold research enumeration, Ratling Sticky Glue, Nerubian Frenzy, Shadow Dancer Conjure Refreshment, Soulreaper Avatar, Nebula Recall/Time Warp, regular AI roaming, selected death-message predicates and MiniMinis. The reviewed branches show missing cleanup; runtime impact was not measured.
- Legacy Ancient learn handlers enable a second handler during the same skill event (for example Resilience and Omniscience). Whether the newly enabled handler also receives that first native event needs a targeted native event-order check; no double-level claim is made here.
- Nebula Recall/Galactic Fury and several temporary-stat spells retain global/single-instance assumptions. Concurrent duplicate casters or cooldown-reset recasts need explicit overlap tests before a state rewrite.
- The AI's initial Ancient pool is populated with 25 entries but sampled using `1..8`; several later skill IDs/loadout choices also retain legacy behavior. Intended AI variety/loadouts were not inferred or changed.
- `ui/animations.lua` still queries `GetDecayingUnit()` from a periodic timer, which has no decay event context. Rebinding it to decay events could affect resurrection/corpse mechanics, so it was not silently changed.

Native multiplayer desync reproduction, client resource lifetime behavior, rendering and real game balance remain unverified by this reviewer. The parent integration workflow owns complete build, historical audit allowlists, packaging, release notes and publication.
