# r13 code and native editor audit

This pass used three independent reviewers for picking/bans, native object data,
and runtime systems, with a separate integration review of base flags and the
release build. The runtime inventory covers all 77 active modules. Coverage means
source review plus the named regressions below, not execution of every possible
game state.

## Why the previous checks missed these bugs

- Object tests checked values such as zero bonus damage, but did not validate the
  native field pointer/type that makes Warcraft read that value. A valid JSON
  round trip can preserve an invalid Warcraft override perfectly.
- Picker tests did not model the unit's native initial-stock delay. Worgen's
  delayed stock and very long refill still blocked an otherwise unlocked pick.
- Separate flag rejection triggers could both refund the same construction.
  Their interaction, resource owner, corpse creation and retained effects were
  not covered by a full registered-event stress test.
- Research and damage callbacks retained assumptions from the old slot layout
  and native event responses. Those require event-specific cases, not only
  syntax checks or comparison with historically buggy behavior.

The historical fixtures remain unchanged. New behavior is identified explicitly
in `gameplay-patch.json` and `../data/migrations/r13-object-fixes.json`; historical
preservation tests now run against their frozen target rather than claiming later
gameplay fixes are unchanged.

## Repaired and checked

- Picking/Random stock: immediate native stock data with script-owned phase caps,
  ban retention, repeated/late skip, both roles, every lobby slot, and either
  ordering of item pickup/removal and sale.
- Base flags: one construction rejection/refund, actual owner's resources,
  immediate removal, effect/group/location cleanup, pending construction limits,
  takeover with multiple surviving flags, environmental deaths and bulk removal.
  The 50,000-rejection test shows no resource growth or retained simulated handles.
  Reversing Lua handle-table traversal yields identical owner/income state.
- Native definitions: repaired data pointers, inconsistent gameplay/skin bases,
  and Lightning dummy numeric types. Metadata checks examine 10,842 ability and
  22,948 unit/item/buff/upgrade modifications; modern schema exceptions are named.
- Runtime: research on all Expander slots and after rebirth/takeover, Ratling
  corrosion/invisibility, Deepwater, Nerubian tracking, damage-event references,
  tree income, melee Mech Blaster, hints/gold pings, bounded Hard AI selection,
  and bounty restoration. See [runtime review](runtime-review-r13.md).

Current regressions pass on standard Lua 5.3.6 and binary32/int32 Lua. The runtime
suite has 203 behavioral assertions across 18 scenarios; published r12 fails all
18 scenarios. Source, generated Lua/WCT, binary data, archive payloads, tooltip
checks and immutable historical evidence are checked by the full suite.

## Actual World Editor verification

World Editor **3.0.1.24371** loaded, saved and reopened a separate copy of the
release map. No error dialog or crash was observed. The actual saved archive was
decoded and compared with the build:

- All 103 stored Lua modules and 1,649 named function bodies remained unchanged.
- All 520 payloads and 3,178 object records remained present.
- Terrain, placements, imports and map metadata remained byte-identical.
- Lua stayed selected; the map name and description remained present.
- Native default stripping and text relocation were reviewed separately; see
  [editor object readback](editor-object-roundtrip-r13.json).

[Exact artifact hashes and readback evidence](editor-validation-r13.json) bind
this check to the release build. The validation copy was not imported over the
authoritative project. Only the temporary editor instance was closed afterward.

## Remaining limits

Warcraft/Test Map was not launched or controlled. The editor does not execute a
multiplayer match, measure FPS, or prove native damage/bounty/stock event timing.
Reported random desyncs remain unreproduced. Existing single-caster spell
assumptions and inherited lower-frequency handle leaks are listed in the runtime
review rather than presented as repaired. `../PATCH_TESTING.md` identifies the
live checks still needed.
