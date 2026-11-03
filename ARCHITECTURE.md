# Code organization and Ancient roles

The editable gameplay source now has **60 named modules**, consolidated from the original **375 numbered trigger files**. Related callbacks live together: selection in `src/game/selection.lua`, results in `src/game/victory.lua`, and each race/Ancient's abilities in its named module. Shared services such as roles, recipes, shopping and the solo sandbox remain separate modules. The built map has always contained one executable `war3map.lua`; source modules are for maintenance, not separate scripts loaded by Warcraft.

`265_Remove_Selector.lua` was the old source file for removing the selection wisp after a hero/race purchase. It no longer exists in active source. Its corrected callbacks are in `src/game/selection.lua`, beside the other picking code. Historical function names remain because triggers and cross-system calls reference them. Section comments and `reports/consolidation.json` retain provenance without requiring 375 editable files.

The historical consolidation preserved all 1,543 functions from those files, including compiled instructions. The current readability refactor goes further: it retires 238 unreferenced/replaced generated helpers and shares repeated implementations. `src/initialization.lua` and `src/bootstrap.lua` still retain their exact pre-consolidation bytes and execution order. `reports/readability-refactor.json` records changed sections and explicitly superseded identity checks; the frozen r7 fixture and old reports remain intact.

## Readable gameplay services

`data/gameplay/factions.json` owns picker stock, ban aliases/messages and ordered random pools. `tools/faction_data.py` generates the marked catalog in `src/game/selection.lua`; edit the JSON rather than the generated block. `FE_Factions` resolves shop handles and mutable ban flags when an event runs. The solo catalog reads the same data, so formatting the stock code no longer breaks its generator. Historical random weights, slot coverage and cutoff behavior remain explicit data.

Bloodmage and Focused Anger share per-player research/action helpers while keeping independent trigger handles and registration order. Base flags and death sounds use shared classifications. Drain cleanup, timed-effect callback publication/compaction and AI target operations have named helper boundaries; numeric formulas, timer cadence and RNG behavior remain unchanged except the documented temporary-handle cleanup fixes.

Ancient previews use one metadata catalog, solo commands have named handlers, and recipe pickup adapters share registration code without merging their ordered listeners. `FE_Shops.traceDefault` owns optional diagnostic routing. The eleven Ancient death triggers call one result sequence. Compatibility callbacks remain where native events or ordered initialization reference them; arbitrary generated predicate names are no longer a design requirement.

`tools/lua_source.py` tracks local and anonymous function boundaries as well as named globals. Synchronization checks cover those bodies; moving code into a closure cannot silently remove it from review. `tests/selection_cleanup.lua`, `game_cleanup.lua`, `gameplay_cleanup.lua` and `systems_cleanup.lua` compare current behavior with frozen r7 in both numeric modes. Resource-allocation changes have explicit expected deltas. See [REFACTOR_PLAN.md](REFACTOR_PLAN.md) for scope and preservation rules.

| Folder | Responsibility |
|---|---|
| `src/game` | Startup, selection, bans, match victory |
| `src/players` | Role identity, takeover, leaving, alliances, death/lackeys |
| `src/races` | Expander abilities grouped by race/subclass |
| `src/ancients` | Ancient abilities grouped by Ancient |
| `src/combat`, `src/effects` | Shared combat and timed-effect systems |
| `src/economy` | Feeding, income, base flags |
| `src/items`, `src/commands`, `src/ui`, `src/ai` | Items, commands, presentation, AI |
| `src/libraries` | Preserved original engine/helper libraries |
| `src/disabled` | Original disabled code; stays disabled |

`src/runtime.lua`, `src/globals.lua`, `src/initialization.lua`, and `src/bootstrap.lua` remain the compatibility and startup boundary. `project.json` lists the 60 modules in deterministic order. Grouping changes definition placement; the actual trigger initialization order stays in `src/initialization.lua`. World Editor exposes the same 60 named gameplay modules, with empty editor adapters leaving actual initialization to `FE_Bootstrap`. The 25 originally disabled triggers and their declarations remain separately disabled.

## Identity and presentation

Use `FE_Roles.ancient()` to get the current Ancient and `FE_Roles.isAncient(player)` to test identity. Assign through `FE_Roles.setAncient(player)`. The sole backing state is the original `udg_AncientPlayer`, so old global-based state remains compatible. New gameplay code should use the API, not write the global directly.

`initialAncientSlot = 6` is the default zero-based lobby slot. It is configured once in `src/players/roles.lua`. The native lobby still has its original slot/team/placement setup; changing the lobby layout requires the editor workflow. Player colors and display names are presentation. Several original display strings still use a palette indexed by slot; they no longer decide gameplay roles.

For Ancient-only events, use `registerAncientUnitEvent`, `registerAncientChatEvent`, or `registerAncientStateEvent`. These register the eleven participants once and check identity when the event occurs. Registering only `Player(6)`, or only the current Ancient during initialization, would leave listeners behind after takeover. The helper adds a condition, so do not use it on triggers intended to listen to several unrelated roles.

The four remaining `Player(6)` references in ordinary source are parts of explicit lists covering **all** players: Cultist day/night upgrades and bounty setup. They do not select the Ancient. Native editor-generated lobby code is also allowed to specify individual slots.

## Deliberate behavior changes

- Ancient-only subscriptions, combat/alliance checks, income, item checks, messages, and result handling follow the current Ancient.
- Allied-player resource cleanup compares handles instead of colors. An ally sharing the Ancient's color is still subject to the ally rule.
- Generic player-leave cleanup preserves the current Ancient's units for takeover, regardless of slot.
- Shared victory/defeat handling covers all eleven participants. Four original death handlers omitted player 11.

This is not a complete redesign of takeover, player teams, race data, or the original GUI-style code. The existing takeover still controls unit/resource transfer and alliance changes. The shopping/audit revision below now handles roster counting. Technology transfer, AI state across takeover, repeated per-player spell modules, remaining resource leaks, and live multiplayer behavior still need broader investigation.

## Ancient shopping and audit revision

`data/gameplay/recipes.json` defines eleven sold recipes and the two-ledger combination. `tools/recipe_data.py` generates `src/items/recipe_data.lua` using current object-data prices; do not hand-edit the generated Lua. Some finished-item sell values differ from ingredient totals in the original map. Auto-buy charges the component/scroll totals, preserving the existing prices.

`FE_Recipes` plans the entire craft before changing inventory or gold. It uses distinct owned item handles first, recursively fills missing ingredients, and charges only the remainder. A sold scroll has already been paid for by Warcraft. If the purchase cannot complete, it removes and refunds that scroll while keeping existing ingredients. A full inventory can craft if consumed ingredients free a slot. Owned-component crafting still works for other players. Nested pickup/sale callbacks are guarded against duplicate consumption.

`FE_Shops` checks the three Ancient shop types every 0.25 seconds, reads their actual Select Unit/Select Hero activation radius, and issues a synchronized `neutralinteract` order for the current Ancient owner. It also reasserts that buyer when the owner selects a shop. It does not select the shop or hero in the player's UI. Role changes and leaving/re-entering range reset the binding. Other players' selection is independent.

The reference for recursive purchasing is [Island Defense Lua's shop system](https://github.com/Rogoeu/Island-Defense-Lua/blob/cbc987c39e3151a1968830ec15fe4af7910bab05/items/ShopSystemAutoBuy.lua). Forest's implementation is independent and uses its own objects, role API, native shop UI and recipe catalog.

`FE_Roster` owns living expander membership and a dedicated force. `FE_FocusedAnger` owns per-attacker stacks without touching Unit Indexer custom data. `FE_Ledgers` tracks all carriers from their inventories. Compatibility callbacks now live inside their named system modules. `reports/shopping-audit.json` lists the historical fix groups; `reports/consolidation.json` maps those old paths to current modules and verifies the preserved bodies.

`tools/sync_audit.py` guards the reviewed local-player functions, delayed event responses, random/time/I/O use, iteration order and Unit Indexer ownership. The local branches are UI/file operations; feed settings enter gameplay through synchronized messages bound to the sender and original lobby identity. This is a review guard, not a proof that Warcraft cannot desync.

## Live shopping test

Use **Forest Expansion 3.2.0 Lua r8**, installed in Maps → Forest Expansion; `reports/build.json` identifies its exact path and hash. The earlier `editor-validation/Forest_Expansion_AncientShop_Test.w3x` is obsolete. To use World Editor's Test Map, reopen the current `dist/Forest_Expansion_3.2.0_Lua.w3x` first; an already-open editor retains its older map in memory. For solo Ancient testing, create a custom lobby with one human in the Ancient slot (default Player 7). The opening banner must identify **3.2.0 r8** and **SOLO TEST MODE ON**; see `SOLO_TESTING.md`. Use two humans when testing normal multiplayer results.

1. Move the Ancient outside shop range, then approach and click the recipe shop. Its buyer should become your Ancient automatically; your camera/hero selection should not be forced.
2. With empty inventory and at least 500 gold, buy **Valorous Helmet Recipe**. Expect the completed helmet, no leftover scroll, and a total cost of **500 gold** (300 scroll + 100 helm + 100 armor).
3. With **Helm of Devotion** and **Valor Armor** already owned, buying that recipe should cost only **300 gold**, consuming those ingredients once.
4. Buy **Hammer of Might Recipe** with no ingredients and at least 1,550 gold. Expect the completed hammer and a **1,550 gold** total cost, including its nested Bladed Gauntlet recipe.
5. With enough gold for the scroll but too little for its missing ingredients, expect an explanation, a refunded scroll, unchanged ingredients, and no finished item. With a full inventory that includes the required ingredients, crafting should use the freed slots; the engine may refuse the initial sale before a trigger can run if there is no sale slot.
6. Check two real clients buying/entering range, a player leaving, `-takeover` after the Ancient disconnects, and subsequent shopping. Compare inventory/gold on both clients and watch for disconnects or divergence. Also test overlapping spells, death/rebirth and save/load in a longer match.

The test doubles cover both pickup-before-sale and sale-before-pickup ordering, recursive costs, duplicate components, capacity/refunds, role transfer, three local-client traces, independent ledger carriers, overlapping timers/spells, rebirth and feed synchronization. Actual shop selection, native inventory events, local preload execution and multiplayer remain engine tests.

## Build and validation

On this prepared Windows workspace, run from the repository root:

```powershell
.\tools\windows.ps1 build
.\tools\windows.ps1 test
.\tools\windows.ps1 workflow
.\tools\windows.ps1 layout
```

The wrapper selects the available bundled Python or accepts `-Python C:\path\to\python.exe`; it enables UTF-8 for child processes. `build` rebuilds the current map; `test` runs role, shopping, bug and package checks in both Lua numeric configurations; `workflow` verifies isolated editor/data conflicts; `layout` runs the original preservation suite against the separate layout-only archive. On macOS/Linux the corresponding targets are `make build`, `make test`, and `make verify-port`.

`tests/verify.py --baseline` and `make test-original` retain the original strict JASS contract. Running them directly against the role-refactored map is expected to fail because the changes are intentional. Their expectations have not been weakened. `tests/layout_baseline.py` extracts the layout-only WCT into an isolated project and runs those same checks there.

Read `reports/refactor-validation.json`, `reports/layout-only-validation.json`, and `reports/workflow-validation.json` for evidence. Historical port reports remain historical. Tests use controlled native doubles; live editor save/reload, actual gameplay, save/load, and multiplayer still need testing.

Live checks should cover ordinary startup, the shopping sequence above, `-takeover` after the Ancient leaves, Ancient commands and income after takeover, item pickups, Ancient death, level-20 victory, and player 11's result. Victory/defeat checks require a multiplayer-started match because the solo sandbox suppresses results. Always use the current installed release, not historical editor-validation copies.

## Migration records

`reports/reorganization.json` records every move and original source hash. `reports/role-refactor.json` records deliberate module edits and backups. `tools/reorganize.py` and `tools/refactor_roles.py` document the checked migrations; they are not routine build commands. Never rerun the original one-time JASS assembler.

`tools/consolidate.py` is the completed one-time consolidation. `reports/consolidation.json` records its backup, every old-to-new section mapping and compiled-function comparisons. Edit current named modules directly; do not rerun migrations. `tools/source_index.py` lets audit/tests inspect the original event boundaries inside those modules, so merging files does not weaken event-context checks.

`project.json` owns `version` and `revision`. After a release-label change, run `tools/release_info.py --write` to preserve WTS encoding while updating the two visible titles. Builds reject inconsistent titles and generate the same revision for the runtime banner. A successful offline build is not a live-test result.
