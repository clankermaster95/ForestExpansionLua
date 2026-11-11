# Development and LLM guide

Use this guide to modify and build Forest Expansion 3.2.0. The [README](README.md) is the short player-facing entry point.

## Start here

1. Read [AGENTS.md](AGENTS.md) for project constraints and `project.json` for the current version, module order and output path.
2. Use [ARCHITECTURE.md](ARCHITECTURE.md) to find the relevant gameplay system. [REFACTOR_PLAN.md](REFACTOR_PLAN.md) explains the cleanup and preservation checks.
3. Edit authoritative Lua in `src/` or data in `data/`, then use the build and validation commands below. Do not restart the original JASS conversion.
4. Describe the final change, checks performed and remaining live tests. Keep [CHANGELOG.md](CHANGELOG.md) as the net 3.1.2a → 3.2.0 release notes.

The repository is public at [clankermaster95/ForestExpansionLua](https://github.com/clankermaster95/ForestExpansionLua). Local tool caches, backups and `local-build.json` stay ignored. Original content retains its ownership and notices; see [THIRD_PARTY.md](THIRD_PARTY.md).

For an LLM, start with a concrete request such as:

> Read AGENTS.md, LLM_GUIDE.md, ARCHITECTURE.md and project.json. Implement [specific change] in the existing source. Preserve unrelated gameplay, initialization order and synchronization. Build and run the relevant offline checks, then summarize the files changed and tests performed. Do not launch Warcraft III or World Editor on the maintainer's PC; the maintainer runs live tests.

## Gameplay boundaries

- Preserve event and initialization order, random draw order, timer cadence and numeric compatibility helpers unless the requested change requires different behavior.
- Use `FE_Roles` for Ancient ownership. Keep gameplay mutations synchronized, outside local-player UI branches.
- Allocate native handles during bootstrap or events, not Lua chunk loading. Keep recurring timers in their owning modules; use `FE_Timers.create/destroy` for transient timers with static callbacks. Avoid GUI timer globals. See `reports/desync-audit-r11.json` and the lifetime regressions.
- Faction picks, ban aliases and ordered random pools live in `data/gameplay/factions.json`; recipes live in `data/gameplay/recipes.json`. Build regenerates their Lua catalogs.
- Keep originally disabled triggers disabled and `original/` immutable. Preserve WTS UTF-8 BOM/CRLF through `tools/map_strings.py`.
- Read [SOLO_TESTING.md](SOLO_TESTING.md) for the solo sandbox and [DEBUG_REFERENCE.md](DEBUG_REFERENCE.md) for spawn codes. Shop tracing is off by default.

Gameplay is organized into 60 named modules. Historical section markers and migration reports preserve provenance; 238 generated helpers were explicitly retired. Start with `src/game/selection.lua`, `src/game/victory.lua`, `src/players/roles.lua`, `src/items/recipes.lua` and `src/commands/solo_test.lua`.

The requested gameplay patch is tracked in `PATCH_PLAN.md`, with maintainer test steps in `PATCH_TESTING.md`. Its immutable r8 fixtures preserve the old source/data and test code. `tools/gameplay_patch_audit.py` checks an explicit list of changed callbacks and records object/payload hashes; `tests/refactor.py` validates that migration, runs historical suites against the frozen source, and tests current shopping, startup and patch behavior separately. Do not rewrite the old refactor report to absorb gameplay changes.

## Open and edit

Open `dist/Forest_Expansion_3.2.0_Lua.w3x` in the current World Editor. Reopen this file before using Test Map if the editor still holds an older build. Terrain, the Object Editor, placements, regions, sounds, cameras, and imported assets use their native map formats. Scenario options should show **Lua** as the script language.

The editor also supports a map folder ending in `.w3x`. Open/drag `map/ForestExpansion.w3x` into the editor; when saving as a folder, select **Warcraft III Scenario Folder – Expansion**. The folder workflow is documented by the [w3ts project](https://cipherxof.github.io/w3ts/docs/editor-support/).

After saving directly into the project folder:

```sh
cd ForestExpansionLua
python3 tools/project.py export-data
python3 tools/project.py build
```

`export-data` replaces the readable JSON views with the editor's current binary data. Finish or reconcile pending JSON edits before using it.

If you edited Lua in the Trigger Editor, `export-data` stops before overwriting those edits. Review them and run `python3 tools/project.py export-data --accept-code` to adopt them into `src/`. This includes disabled triggers. A backup preserves the previous map, source, and JSON data. Builds reject conflicting editor/source edits, code outside the source-module markers, and unmanaged editor triggers instead of silently dropping them.

If you saved a separate archive or folder instead:

```sh
python3 tools/project.py import-editor "/path/to/edited-map.w3x"
python3 tools/project.py build
```

Import creates a backup first. If you also edited Lua in the Trigger Editor, review those edits and add `--accept-code` to import them into `src/`. Objects and terrain do not need that option.

## Build and tools

On the prepared Windows workspace, run `tools/windows.ps1 build` and `tools/windows.ps1 test`. With the documented dependencies installed, the portable commands are:

```sh
python3 tools/project.py build
# or: make build
```

The build checks for conflicting editor/JSON/Lua edits, imports changed object/terrain data, updates `war3map.lua` and the editor's `war3map.wct`/`war3map.wtg`, sets the Lua flag, checks Lua syntax, builds an MPQ archive, and reads every packed payload back for comparison. It does not need the game installed. `data/code-baseline.json` records synchronized Lua module hashes and is maintained by these tools.

On a fresh macOS/Linux checkout, install Python 3.11+, Git, Make, and a C/C++ compiler, then run:

```sh
python3 tools/bootstrap.py
python3 tools/project.py build
```

Bootstrap installs .NET SDK 10.0.403, CMake 4.4.4, pinned StormLib source, Lua 5.3.6 in both standard and 32-bit-number configurations, and locked NuGet dependencies into the project. No game binaries are downloaded. Warcraft III itself supplies the runtime native functions and Blizzard helper functions.

The editor can open the delivered archive on Windows without build tools. The prepared Windows workspace now builds and tests with local Python, .NET 10, Lua 5.3 in both numeric configurations, and StormLib. Use `tools/windows.ps1` as described in ARCHITECTURE.md. Automatic fresh-machine Windows dependency bootstrap remains separate from this prepared toolchain.

## Where to make changes

| Location | Purpose |
|---|---|
| `src/game/`, `src/players/` | Match startup, selection, bans, victory, takeover, leaving, and lackeys; `players/roles.lua` owns Ancient identity |
| `src/races/`, `src/ancients/` | Abilities grouped by expander race or Ancient |
| `src/combat/`, `src/effects/`, `src/economy/` | Damage, shared spells, timed effects, feeding, income, and base flags |
| `src/items/`, `src/commands/`, `src/ui/`, `src/ai/` | Items, chat commands, messages/names, and Ancient AI |
| `src/libraries/` | Damage Engine, Passive Missiles, Spell Leech, and other original helper functions |
| `src/globals.lua` | Original global declarations, in original order |
| `src/initialization.lua` | Original variable, trigger, and startup-action initialization |
| `src/bootstrap.lua` | Preserves the original initialization sequence after editor-generated map objects |
| `src/runtime.lua` | JASS numeric, array-default, and string-concatenation compatibility operations |
| `data/gameplay/factions.json` | Ordered picker stock, ban aliases and legacy random pools; shared by the map and solo catalog generator |
| `src/disabled/` | The 25 disabled triggers and a separately disabled globals module |
| `data/object-index.json` | Searchable names, rawcodes, base IDs, and paths for 3,138 object/skin override records |
| `data/objects/` | One JSON file per object record; gameplay and skin overrides remain separate |
| `data/terrain/` | Terrain metadata and 129 rows of 129 vertices (128 × 128 cells) |
| `data/editor/` | Native placements, regions, sounds, cameras, map information, imports, and pathing as JSON |
| `map/ForestExpansion.w3x/` | Editor work folder and the latest editor-generated creation/configuration script |
| `original/` | Unchanged original archive, extracted payloads, and original editor data |
| `reports/` | Function coverage, hashes, binary round trips, behavior comparisons, and remaining test limits |

Edit Lua in `src/`, then build. Do not edit `build/converted/`: those files are regeneration/test artifacts. Do not rerun `assemble_port.py` to make gameplay changes; it records the one-time migration.

Use `\x25` for percent characters inside quoted Lua strings, including command
patterns and displayed percentages. The installed editor corrupted raw percent
characters in custom code and crashed while saving; the build rejects them.
Remainder operators need a separate behavior review because `math.fmod` and Lua
modulo differ for negative results. `tests/editor_safety.py` covers the reviewed
uses and literal equivalence in both Lua numeric modes.

`project.json` defines module inclusion and order. Folder order does not control initialization. Numbered section comments and historical audit reports preserve traceability; active files have descriptive names. Add a new module through that manifest and its matching editor/script storage deliberately; the builder rejects missing or duplicated module markers rather than silently dropping code.

### Object changes by an LLM

Search `data/object-index.json` by name or rawcode, then edit the referenced record. Fields retain their original type, level/pointer information, and sanity values. `_field` provides a readable four-character field ID; `_name` and `_resolvedText` show text from the original WTS. These underscore properties are annotations: modify the real `Value` property.

For a single existing field with no ambiguous levels:

```sh
# Example only: set custom unit h000 (Kraken) to 750 base hit points.
python3 tools/project.py object-set units h000 uhpm 750
python3 tools/project.py build
```

Names and visual overrides frequently live in the matching `units_skin`, `abilities_skin`, etc. records. String values may refer to `TRIGSTR_...`; replacing such a Value with literal text is supported, or edit the corresponding entry in `map/ForestExpansion.w3x/war3map.wts` and refresh the JSON annotations with `export-data`.

For a new object, copy a suitable record, assign a distinct four-character NewId (stored as a little-endian integer), and add its path to the appropriate `New...` list in `data/index.json`. Keep its base OldId and field metadata consistent. The index lists preserve native object ordering; unlisted files are not compiled.

### Terrain changes by an LLM

The rows run south to north, and vertices within each row run west to east. World X/Y are `Left + 128*x` and `Bottom + 128*y`. `Texture` indexes `TerrainTypes` in `data/terrain/map.json`. A normalized `Height` increment of 1 is 128 game units; storage precision is 1/512 of that increment.

```sh
# Example only: raise a 4 × 4 vertex rectangle by 32 world units.
python3 tools/project.py terrain-rect 60 60 4 4 --height-delta 0.25
python3 tools/project.py build
```

This edits actual terrain data. Cliff/water/ramp changes also require a World Editor save to regenerate derived pathing, shadows, and the minimap. The tools preserve those files rather than inventing a replacement for the current editor's terrain processing.

### Placements and other generated map objects

Warcraft creates placed units, some destructables, regions, sounds, cameras, and configuration through generated script. Editing only their binary records would leave that script stale. For those JSON files use:

```sh
python3 tools/project.py apply-data
# Open and save map/ForestExpansion.w3x in the current World Editor.
python3 tools/project.py export-data
python3 tools/project.py build
```

The tool records a pending editor-save requirement and refuses to package stale creation code. Preserve `CreationNumber` when moving an existing placement; Lua references such as `gg_unit_...` use that identity. Editing these objects directly in World Editor and importing the saved map also works.

## Why editor saves retain the Lua

World Editor regenerates `war3map.lua` when saving. Changing only that file would lose the port. This project also writes all live Lua into the editor's custom-script header and custom-text trigger storage.

Each visible Lua module has an empty editor initializer. One final `FE_Bootstrap` initializer first allocates deferred native globals, then invokes the original library initializers, original `InitGlobals`, original `InitCustomTriggers`, and original `RunInitializationTriggers`, in their original order. Those last three functions are renamed with an `FE_` prefix so the editor cannot overwrite them. Required trigger entry points, registration order, and vJASS-generated data structures remain compatible. The readability refactor explicitly retires unused/replaced helpers; see `reports/readability-refactor.json`. The original Damage Engine has not been replaced with a different Lua library/version.

The editor owns creation functions and main/config generation. The builder replaces only marked project code inside its saved script, preserving the editor's current creation/configuration code.

`FE_EditorObjectReferences` is an additional **disabled GUI trigger** that retains references to the five placed units used by Lua. Keep it disabled. It contains no gameplay code that is executed and allocates no runtime trigger. This addresses the editor's [generated-global reference bookkeeping](https://www.hiveworkshop.com/threads/when-does-editor-create-or-remove-gg-generated-global-variables.324467/). The reference names are checked against the actual placement records. Its behavior on a current live editor save still belongs to the live validation boundary above.

## Patch and format handling

Blizzard added Lua trigger conversion and substantial editor/data features with [Forsaken Kingdom / 3.0](https://us.forums.blizzard.com/en/warcraft3/t/warcraft-iii-reforged-forsaken-kingdom-patch-notes/38400/). This project uses native Reforged map formats, modern trigger storage, and [War3Net 6.1.2](https://github.com/Drake53/War3Net) codecs rather than downgrading the map to a classic editor format.

The original archive records map-info format 33 and last-save game version **2.0.4.23745**. The maintainer's November 8 editor save upgraded the working map to format 39 / **3.0.1.24371** while moving the Ancient to slot 11. These are last-save metadata, not a compatibility guarantee. Preserve the current native versions, modern object skins and imported files. The historical layout-only port still verifies its original one-byte Lua-language change separately.

`tools/reference-api/` contains War3Net's 1.32.9 JASS declarations/fixtures used to resolve types for this particular source and run deterministic tests. Every function used by the active original source resolves against them. They are **not packaged as a replacement runtime** and do not pin the map to 1.32.9. New Lua calls resolve against the installed game's API. If reconverting new JASS that uses newer APIs, supply matching current declarations.

Warcraft's Lua uses 32-bit integers and floating-point numbers, as also checked in game by the [wc3-lib author](https://jsr.io/@mdlsvensson/wc3-lib/doc/persistence/format). The compatibility helpers detect the VM's numeric sizes: game arithmetic retains those native widths, while standalone standard Lua explicitly reproduces them. Integer division is adjusted to JASS truncation, including negative values and the minimum signed integer. The game path does not require `string.pack`/`string.unpack` for rounding. Tests run under both standard Lua and a separate `LUA_32BITS` build; neither substitutes for testing the actual game VM.

## Validation and delivery

On the prepared Windows workspace:

```powershell
.\tools\windows.ps1 build
.\tools\windows.ps1 test
.\tools\windows.ps1 workflow
```

With the dependencies installed on macOS/Linux:

```sh
make build
make test
```

Run the relevant regressions for the change. Use `make verify-port` or `tools/windows.ps1 layout` when checking the original preservation contract against the separate layout-only archive. Those historical tests are distinct from the current map's intentional fixes; never silently reset their expectations.

Current offline evidence lives in:

- `reports/refactor-validation.json`: source/editor synchronization, archive readback, and gameplay regressions in both Lua numeric configurations.
- `reports/readability-refactor.json`: explicit changes against `tests/fixtures/refactor-r7.zip`, including retired helpers and temporary-resource cleanup.
- `reports/workflow-validation.json`: isolated build, installation, editor-import and conflict checks.
- `reports/build.json`: current artifact checksum, release label and configured Maps installation result.

The original port's reports, including `reports/validation.json` and `reports/event-differential.json`, remain historical evidence. Offline doubles do not reproduce Warcraft's complete scheduler, combat, pathfinding, rendering, serialization or multiplayer. The maintainer must perform live editor, gameplay, multiplayer and save/load checks; agents must not launch or control Warcraft or World Editor on this PC.

Version and revision are set in `project.json`. After changing a release label, run `python3 tools/release_info.py --write`, then build and validate. Package the verified map and player notes with:

```sh
python3 tools/package_community.py
```

The playable output is `dist/Forest_Expansion_3.2.0_Lua.w3x`; the shareable bundle is `dist/Forest_Expansion_3.2.0_Community.zip`. Builds copy the map to Warcraft Maps only when configured through ignored `local-build.json`. The installer removes older managed Forest copies, preserves unrelated maps and reports any locked copy still awaiting cleanup. A new build does not update an ongoing match or an editor's already-open map.

The 25 originally disabled triggers contain known broken references and remain disabled; see `reports/disabled-original-issues.json`. For this workspace's historical continuation notes, see [HANDOFF_WINDOWS.md](HANDOFF_WINDOWS.md); current instructions in AGENTS.md take precedence over old handoff steps.
