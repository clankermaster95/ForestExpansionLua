# Gameplay readability and robustness plan

Behavior target: current 3.2.0 r7, frozen in `tests/fixtures/refactor-r7.zip`.
The original JASS archive and its historical validation remain unchanged.

## Implementation

- [x] Run the existing suites in both numeric configurations and freeze the current source.
- [x] Replace picker/ban duplication with an ordered faction catalog; make the solo catalog consume data instead of parsing Lua spelling.
- [x] Share repeated per-slot spell, research, classification, death-sound and delayed-pulse logic while preserving event boundaries.
- [x] Extract named Drain, timed-effect and AI operations with explicit state/ownership boundaries and unchanged ordering.
- [x] Centralize Ancient preview metadata, command handlers, recipe adapters and repeated UI operations.
- [x] Remove proven unused generated predicates and simplify mechanical syntax under compiled-code or behavior comparison.
- [x] Extend the source audit to cover local/anonymous functions and retain exact checks for untouched code.
- [x] Record the explicit migration, run old/new comparisons and existing regressions, build and verify the editor/archive round trip.
- [x] Update architecture, changelog and testing guidance; install the newest verified map using the existing installer.

## Before and after

| Area | Previous structure | Implemented structure | Preservation check |
|---|---|---|---|
| Selection and bans | Per-faction predicate functions, repeated stock/ban actions and source-text parsing for solo discovery | Ordered `data/gameplay/factions.json`, shared `FE_Factions` operations, thin event adapters | Every faction/alias, budget, mutable flag, stock order, cutoff and random-pool trace |
| Bloodmage and Focused Anger | Ten copies of player-slot spell/research actions | Named operations parameterized by player slot; existing trigger handles retained | Native traces, arrays, scratch values and trigger state against frozen r7 |
| Base flags, death sounds and Ancient defeat | Repeated classifications and nearly identical result actions | Shared ordered classifications, sound dispatch and match-result operation | Native call order, messages, delays and slot coverage |
| Drain and timed effects | Cleanup/parallel-array bookkeeping mixed into large actions | Named teardown, context publication and compaction helpers | Overlapping spells, callback/state order and explicit handle-release deltas |
| AI and pulse spells | Repeated candidate/order logic and repeated delayed pulses | Named target operations and bounded pulse loops | Exact RNG calls, retries, timer cadence and effect count |
| Ancient metadata and commands | Four overlapping metadata tables and a large command branch | One metadata table, named text/command handlers and dispatch tables | Preview text, malformed input, aliases, ownership and solo eligibility |
| Recipes and UI pings | Repeated registration boilerplate and inline temporary allocations | Shared pickup-registration adapter, diagnostic interface and owned ping resources | Listener/recipe priority, inventories, refund behavior and resource lifetime |
| Generated syntax and audit | Hundreds of helper wrappers; scans focused on named global functions | 238 helpers explicitly retired; simpler syntax; lexical spans and whole-module classification | Immutable baseline, migration hashes, compiler checks and expression edge cases |

The active source changed across 68 modules, removing a net 4,633 lines. The
60 gameplay module boundaries remain stable. Historical callback names remain
where initialization or native callbacks reference them; generated names are
not themselves a reason to alter event wiring.

For example, `Trig_Spawn_Races_Actions` now calls
`FE_Factions.stock("expanders")`. Adding or inspecting a faction's stock, ban
aliases or picker metadata starts in one JSON catalog. Ordered random pools
remain explicit, including their existing weights and exclusions.

## Verification evidence

`reports/readability-refactor.json` records 372 changed historical sections,
238 retired helpers, each changed module hash and its validation suite.
`tests/refactor.py` checks the archive/editor representation, 77 active source
modules, initialization order and both numeric configurations. The four new
differential suites compare 51,798 observations/assertions per runtime with
frozen r7; existing role, shop, bug and solo regressions also run. The narrow
normalizer is tested separately for values, return arity, evaluation counts,
operator precedence and multiline-string preservation.

Completed offline validation: all nine Lua suites pass in both numeric modes,
1,053 syntax edge cases pass per runtime, and all 13 isolated workflow checks
pass. The packed archive matches every map-folder payload; 510 original
non-code payloads remain unchanged. The r8 map was copied to the configured
Warcraft Maps folder and its checksum verified. Exactly one managed Forest
map is present, with no locked older copies pending cleanup. See
`reports/build.json` for the path and checksum and
`reports/workflow-validation.json` for the workflow checks. Warcraft and World
Editor were not launched.

## Preservation contract

Preserve initialization, native event registration and action order; numeric coercion and intermediate rounding; random draw count/bounds/order; timer cadence; per-slot exclusions; aliases/messages; inventory ownership, recipe priority and refund rules; Unit Indexer ownership; local-player presentation boundaries; and disabled code status. Historical callbacks may remain as thin compatibility entry points. Names that are actually unreferenced can be explicitly retired with reference evidence.

Hash/bytecode identity proves mechanical preservation only. Changed algorithms also need current-baseline native/state traces and focused event tests; a clean syntax check is insufficient. The migration must identify changed/retired functions and preserve the old fixture and untouched-section checks instead of silently resetting historical expectations.

## Distinct gameplay questions

The audit identified incomplete ban cutoff, random choices ignoring bans, AI retry/selection inconsistencies, transferred recipe-scroll behavior, and passive-missile revive handling. Those are existing rule/lifecycle behaviors, not stylistic equivalences. Keep them visible and separate from this exact-behavior refactor. Broad Damage Engine, numeric compatibility or serialization redesign is not justified merely by generated names: improve interfaces/documentation and retain proven semantics.

Warcraft and World Editor must never be launched by the agent. Offline tests cannot prove native multiplayer or save/load equivalence; the user performs live validation.
