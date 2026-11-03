# Resume Forest Expansion Lua on Windows

**Current user restriction:** never launch or control Warcraft III on this PC. The user reports live results. The shop probe in workspace `work/` was prepared but never run; approval to run it was revoked. Use offline checks and solo-mode diagnostics instead.

## Current — 3.2.0

**Latest revision: r7.** Generated debug pages were removed from Information/F9. DEBUG_REFERENCE.md contains all 524 spawn entries and commands. The public changelog is a net 3.1.2a to 3.2.0 comparison only. Shop diagnostic messages are off by default; `-test shop on` enables them only for solo troubleshooting. `COMMUNITY_CHANGELOG.md` is the player-facing release note. The user requested a new private `clankermaster95/ForestExpansionLua` repository, not a push to the old account.

**r5 shop fix.** The user supplied an r4 trace: in range, inventory 1/6, order accepted, gold deducted, no sale event. All three Aall shops used usei instead of umki. r5 moves exact stock lists to umki, clears usei, and clears Protector Seed's inherited Keep requirement. New build guards and packed-data regressions cover this mismatch. See `reports/shop-stock-r5.json`. Live r5 confirmation is still pending.

**Historical r4 changes.** See `reports/shop-delivery-r4.json` and `SOLO_TESTING.md`. The user reports purchases dropping next to a shop even with a visible recipient, and zero old recipe counters. Do not assume the buyer is missing: r3 counted recipe sales only. r4 adds all-sale/order/pickup/drop/delivery traces in solo mode, owned-shop numeric selection with shared fallback, post-selection reassertion and safe delivery of an already-paid ordinary ground item to the native buyer. The subsequent trace showed no sale event; no native shop probe was run. Earlier r3 organization evidence remains historical and unchanged.

**Current source organization: Lua r3.** All 375 numbered gameplay files are consolidated into 60 named modules. `src/game/selection.lua` now contains the former `265_Remove_Selector` callbacks. The migration verifies all 1,543 function instructions in both Lua modes, plus unchanged initialization/bootstrap bytes. The source/editor/runtime manifests are synchronized; `reports/consolidation.json` preserves old-path provenance. Do not run old migration tools or reintroduce numbered files. See `ARCHITECTURE.md` for navigation.

The r2 fixes remain: solo mode blocks result announcements/countdowns and final victory/defeat, including the 65-second Extermination re-enable; selector removal filters the actual selection-wisp buyer. `tests/solo_startup.lua` exercises real bootstrap/picker/result callbacks with an engine double for both roles and multiplayer gating. Current map title and opening solo banner identify **r7** from `project.json`; native retesting by the user remains necessary.

During diagnosis, Windows Restart Manager confirmed Warcraft held installed build `805374729374`, which has no solo commands. The editor validation copy and `WorldEditTestMap.w3x` both matched historical `86e1a4f...`, also without these features. The newer installed `8c05af7...` had debug/skip, but was not the held old file. Do not confuse installed, editor-memory and running-match versions. Closing Warcraft is needed if its old-map lock persists; do not close it without the user's instruction. Latest reports, not these historical hashes, identify the current build.

Use `dist/Forest_Expansion_3.2.0_Lua.w3x`; see `reports/build.json` for its current hash and exact installed Maps filename. A running game locked the first 3.2.0 copy, so builds can install hash-suffixed siblings. Do not restart/close Warcraft or the editor without the user's request. Start a new match with the latest file to test changes.

Read `CHANGELOG.md` and `SOLO_TESTING.md`. Costs/tooltips, AI pricing, charged ingredients, WTS BOM/CRLF preservation, the first countdown title and solo commands are implemented. The user reported a recipe scroll dropping on the ground as the Ancient; purchased-recipe replacement is now deferred until native delivery settles and full-inventory regression cases were added. This fix needs live retesting. `-test shop` reports purchase diagnostics. Current offline evidence is in the release/refactor/workflow reports; older sections below are historical.

Latest features: F9 Debug / Solo Testing plus complete Debug Items and Debug Units name/command catalogs, paginated chat lookups, and `-test skip` to unlock picks immediately. Latest-only Maps cleanup is explicitly authorized; a hidden bounded worker retries exact older locked copies after the game releases them. Current artifact hash is in `reports/build.json` (do not use historical hashes below). The completed balance workbook is `../ForestExpansion-balance/Forest_Expansion_3.2.0_Balance.xlsx`; its export checks and scope live in that folder's `support/` directory. Run `tools/source_triage.py` for reproducible whole-source lexical review in addition to the regular tests.

## November 2 — Ancient shopping and bug audit

- Current archive SHA-256: `86e1a4f463346d5367a192f3a70f5111c6518221941fe9d5ebfbc6c694fafa50`.
- Added recursive auto-buy for all eleven active shop recipes, owned-component crafting, ledger combination and Ancient shop buyer assignment for its owner. Read ARCHITECTURE.md for module responsibilities and manual test steps.
- Fixed 14 concrete issue groups across 56 existing modules and six new modules. `reports/shopping-audit.json` records the exact source changes, scope and remaining limits. Disabled modules remain disabled; original archive remains unchanged.
- Current checks passed: 8,058 role assertions, 196 shopping assertions (38 purchases and three local-client traces), and 54 bug assertions in each Lua numeric mode; 418 Lua chunks compile per mode. All 514 non-code payloads remain identical. All seven workflow checks pass. The full original preservation suite also passes against the separate layout-only map.
- Reviewed all eight local-player functions and checked all 39 active functions with waits for unstable event getters. `tools/sync_audit.py` records that boundary. This is not proof of zero desyncs or exhaustive bug elimination.
- At the user's explicit request, World Editor 3.0.1.24371 opened and responded with `../editor-validation/Forest_Expansion_AncientShop_Test.w3x` (same hash as current archive). Initial plain `-loadfile` launch handed off to Battle.net; direct `-launch -uid w3 -loadfile` opened the editor. The existing Warcraft game process was not stopped or restarted.
- No save or in-game result was observed. Next: let the user perform editor save and the live shopping/multiplayer tests. Do not overwrite their test save; import it through the existing reviewed editor workflow if needed.
- This remains an extracted repository ZIP, not a Git checkout; no changes were pushed.

## Desktop continuation — November 1, 2026

Read `ARCHITECTURE.md` first for the current layout and role API. The prior handoff below records the original port baseline.

- This directory came from the private repository ZIP, commit `9cdaf8bbcb87d2fafe166072593622ff8f962537`. It is not a Git checkout; these changes have not been pushed.
- Reorganized all 375 trigger modules into system/race folders and matching WTG categories while retaining manifest order, original function names, and disabled status. The layout-only artifact is `dist/Forest_Expansion_3.1.2a_Organized.w3x`.
- The current `dist/Forest_Expansion_3.1.2a_Lua.w3x` also contains intentional Ancient-role fixes. `FE_Roles` uses the original `udg_AncientPlayer` as its sole backing state; slot 6 is just the default at initialization. Events filter the current role, resource cleanup uses identity, and income/results follow takeovers. Four original Ancient death handlers omitted player 11; shared results include all eleven players.
- See `reports/refactor-validation.json` for current role tests and packaging checks, `reports/layout-only-validation.json` for original preservation checks against the separate layout archive, and `reports/workflow-validation.json` for editor/build conflict checks. Historical `reports/validation.json` is not evidence of unchanged behavior in the role-refactored map.
- Native Windows builds now use local .NET 10.0.403, official Unicode StormLib 9.40 x64 DLL, and Lua 5.3.6 compiled with GCC 16.2 in standard and `LUA_32BITS` configurations. Use `tools/windows.ps1 build`, `test`, `layout`, or `workflow`. Automatic fresh-machine bootstrap remains separate from this prepared local toolchain.
- Warcraft III / World Editor 3.0.1.24371 was detected. A separate baseline copy was opened in the editor at `../editor-validation/Forest_Expansion_3.1.2a_Lua-editor-check.w3x`. No editor save, game test, multiplayer test, or save/load result was observed. No editor or game was launched for this reorganization/refactor.
- Original archive remains immutable. Changes have local backups under `backups/`; the map already open in the editor was not modified. Ask for live gameplay testing only when the user is ready to stop playing.

The user's next goal is to validate and continue this existing map port on a desktop with the current Warcraft III and World Editor. Read `AGENTS.md`, `README.md`, and `project.json` before changing anything. Do not restart the conversion.

The repository is intended to be private. It includes the original map, the port, all imported assets, editor files, editable JSON, Lua modules, build-tool source, pinned dependency definitions, and verification reports. Original map content retains its existing ownership and notices; see `THIRD_PARTY.md`. Installed `.tools/` and `.venv/` dependencies and temporary build/backup files are reproducible local state, excluded from Git.

## Files and current status

- Original archive: `original/Forest_Expansion_3.1.2a.w3x`
- Lua archive to open: `dist/Forest_Expansion_3.1.2a_Lua.w3x`
- Editable native map folder: `map/ForestExpansion.w3x/`
- Authoritative gameplay source: `src/`
- Readable object/terrain data: `data/`
- Full workflow: `README.md`
- Checks and limits: `reports/validation.json`, `reports/event-differential.json`, `reports/source-audit.json`, `reports/workflow-validation.json`

At this handoff, original archive SHA-256 is `0fb5a2b67cf9c126bdba91e14930946ea9ffb94a655920719da42a2dea9ac0a5`; port archive SHA-256 is `2b5345d30e7079f04a5aa53ff5bfa903e02880612cbdb605315ef8d297aae1d6`.

The source map records W3I format 33 and last-save version 2.0.4.23745; the user reports it works with the latest patch/expansion. These metadata values were preserved. Do not downgrade files to accommodate older tools. A current editor save may legitimately upgrade versions.

All 1,662 executable-source functions were translated using a typed JASS syntax tree. This is a preservation port: gameplay cleanup and bug fixes were not a general objective. Compiled vJASS data structures, callback/initialization order, and original function names remain. There are another 89 functions in 25 originally disabled triggers, still disabled. Their known broken references are in `reports/disabled-original-issues.json`.

Offline checks passed on macOS:

- 514 original payload files remain byte-identical. Only the runtime script, trigger storage, and script-language byte changed.
- 26 binary/JSON codecs round-trip exactly; 410 Lua chunks compile under standard Lua 5.3 and `LUA_32BITS`.
- All original function bodies and global declarations match a fresh translation.
- 4,068 startup calls and 300 selected behavior cases match an independent JASS evaluator.
- 129 controlled combat/timer scenario steps, 82 observations, and 6,277 calls including startup match; complete declared-global/array state matches too. This harness executes 497 original functions, not every gameplay path.
- 3,000 seeded arithmetic assertions pass in each numeric configuration.
- Object/terrain edits and seven isolated editor/build workflow checks pass.

**No real World Editor save, game launch, multiplayer, or game save/load has been tested yet.** Neither Warcraft III nor World Editor was installed on the Mac. Offline doubles do not emulate the complete game. Do not describe full in-game 1:1 equivalence as established.

## First work on the desktop

1. Inspect the installed Warcraft III and World Editor versions. Record their exact versions in the verification report. Use the current editor, as requested by the user.
2. Open the delivered Lua archive in World Editor. Confirm Lua is selected, and inspect terrain, objects/skins, imports, and triggers. The archive can be opened without installing the build toolchain.
3. Save a separate copy, reload it, then launch it. Preserve the original and committed baseline. Capture actual editor/compiler/runtime errors, and fix port defects without silently altering gameplay.
4. Inspect the saved script. Confirm `InitTrig_FE_Bootstrap` runs once after map-object creation, that its library initializers retain their order, and that the five `gg_unit_...` references still receive their placed units. Keep `FE_EditorObjectReferences` disabled.
5. Make and verify an object-stat change, a terrain change, and a placed-unit movement in a throwaway copy. Exercise editor import/rebuild/reopen. The live result is needed in addition to the simulated workflow tests already present.
6. Compare original and Lua maps under the same lobby/settings. Exercise selection/startup, feed/resource settings, combat and lethal damage, triggered spells, passive missiles and tornadoes, spell leech, timed systems, victory/defeat, and save/load. Multiplayer synchronization needs an actual multiplayer test.
7. Update the reports with what was actually observed. Keep untested areas explicitly marked. Commit verified changes and push to this private repository.

## Toolchain on Windows

The map itself opens in Windows World Editor without the build tools. The automated bootstrap and test scripts were validated on macOS; `tools/bootstrap.py` also targets Linux, but explicitly does not automate native Windows setup. Several test paths assume Unix executable names/symlinks. Do not claim native Windows support without implementing and testing it.

If WSL2 is available, it provides a Linux environment for the existing toolchain while World Editor runs on Windows. Inspect that environment first. The prerequisites are Python 3.11+, Git, Make, and a C/C++ compiler. From the repository in that environment:

```sh
python3 tools/bootstrap.py
python3 tools/project.py build
make verify-port
```

This downloads project-local, pinned .NET SDK, CMake, StormLib, Lua 5.3 builds, and locked NuGet dependencies. The Linux/WSL route has not been exercised on this desktop yet. Ensure the Windows editor and the build commands operate on the intended checkout, or transfer/import saved archives explicitly.

For a fully native Windows build, adapt and verify executable discovery, test paths, StormLib DLL calling/path conventions, and dependency bootstrap. Do not merely rename paths and assume it works. The existing README describes the component dependencies.

## Retain editor/source synchronization

For an editor archive saved elsewhere:

```sh
python3 tools/project.py import-editor "/path/to/editor-save.w3x"
python3 tools/project.py build
```

For a save directly into the native work folder:

```sh
python3 tools/project.py export-data
python3 tools/project.py build
```

If Lua was deliberately changed in the Trigger Editor, review it and add `--accept-code` to the import/export command. Both enabled and disabled modules are synchronized, with backups. Finish/reconcile pending JSON changes first. Preserve module markers and `data/code-baseline.json`; do not bypass conflicts. Placement/region/camera/configuration JSON edits require `apply-data`, an actual editor save to regenerate creation code, then `export-data` before building.

The Git attributes preserve native map payload bytes even with Windows newline conversion enabled. Source files use LF. `.tools/`, `.venv/`, `build/`, and `backups/` are intentionally untracked. The distributed map remains tracked for immediate editor testing.

Suggested first instruction to the next session:

> Read HANDOFF_WINDOWS.md, AGENTS.md, and README.md. Continue this existing Warcraft III Lua port on this Windows desktop. Prioritize real current-World-Editor open/save and in-game parity checks against the original. Fix demonstrated port defects, preserve original gameplay, record evidence and remaining gaps, and keep the repository private.
