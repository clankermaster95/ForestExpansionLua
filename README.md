# Forest Expansion 3.2.0 — Lua project

See the [3.1.2a → 3.2.0 changelog](CHANGELOG.md), [solo testing guide](SOLO_TESTING.md) and [complete testing reference](DEBUG_REFERENCE.md).

The playable map is `dist/Forest_Expansion_3.2.0_Lua.w3x`. A shareable map, changelog and testing documents are bundled in `dist/Forest_Expansion_3.2.0_Community.zip`.

Gameplay code is organized into **60 named modules** by system, expander race and Ancient. Start with `src/game/selection.lua`, `src/game/victory.lua`, `src/players/roles.lua`, `src/items/recipes.lua` and `src/commands/solo_test.lua`; see [ARCHITECTURE.md](ARCHITECTURE.md) for navigation.

Shop diagnostics are off by default, and generated testing catalogs are kept outside the Information menu. The user runs native game tests; the agent must never launch or control Warcraft III on this PC. Successful local builds install in Warcraft III Maps; `reports/build.json` records the current revision, installed filename and checksum.

For continuing on the Windows desktop with Warcraft III and World Editor, start with [HANDOFF_WINDOWS.md](HANDOFF_WINDOWS.md).

All 1,662 functions in the executable JASS script were translated to Lua, including the compiled vJASS libraries. Another 89 functions from the 25 originally disabled triggers were translated and remain disabled. The original download has not been changed.

**Validation boundary:** the archive, binary formats, Lua 5.3 syntax, initialization, and selected behavior have been tested offline. Warcraft III and World Editor are not installed on the Mac where this port was made. A real open/save/test cycle in the current editor, gameplay, multiplayer synchronization, and game save/load still need validation. This project does not claim that those tests have happened or that full in-engine 1:1 equivalence has been proved.

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

The dependencies are already installed locally in this project on the current Mac:

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
| `src/disabled/` | The 25 disabled triggers and a separately disabled globals module |
| `data/object-index.json` | Searchable names, rawcodes, base IDs, and paths for 3,138 object/skin override records |
| `data/objects/` | One JSON file per object record; gameplay and skin overrides remain separate |
| `data/terrain/` | Terrain metadata and 129 rows of 129 vertices (128 × 128 cells) |
| `data/editor/` | Native placements, regions, sounds, cameras, map information, imports, and pathing as JSON |
| `map/ForestExpansion.w3x/` | Editor work folder and the latest editor-generated creation/configuration script |
| `original/` | Unchanged original archive, extracted payloads, and original editor data |
| `reports/` | Function coverage, hashes, binary round trips, behavior comparisons, and remaining test limits |

Edit Lua in `src/`, then build. Do not edit `build/converted/`: those files are regeneration/test artifacts. Do not rerun `assemble_port.py` to make gameplay changes; it records the one-time migration.

`project.json` defines module inclusion and order. Folder order does not control initialization. The numbered filenames remain as traceability to the original map. Add a new module through that manifest and its matching editor/script storage deliberately; the builder rejects missing or duplicated module markers rather than silently dropping code.

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

Each visible Lua module has an empty editor initializer. One final `FE_Bootstrap` initializer invokes the original library initializers, original `InitGlobals`, original `InitCustomTriggers`, and original `RunInitializationTriggers`, in their original order. Those last three functions are renamed with an `FE_` prefix so the editor cannot overwrite them. Original trigger names, callbacks, registration order, and vJASS-generated data structures remain intact. The original Damage Engine has not been replaced with a different Lua library/version.

The editor owns creation functions and main/config generation. The builder replaces only marked project code inside its saved script, preserving the editor's current creation/configuration code.

`FE_EditorObjectReferences` is an additional **disabled GUI trigger** that retains references to the five placed units used by Lua. Keep it disabled. It contains no gameplay code that is executed and allocates no runtime trigger. This addresses the editor's [generated-global reference bookkeeping](https://www.hiveworkshop.com/threads/when-does-editor-create-or-remove-gg-generated-global-variables.324467/). The reference names are checked against the actual placement records. Its behavior on a current live editor save still belongs to the live validation boundary above.

## Patch and format handling

Blizzard added Lua trigger conversion and substantial editor/data features with [Forsaken Kingdom / 3.0](https://us.forums.blizzard.com/en/warcraft3/t/warcraft-iii-reforged-forsaken-kingdom-patch-notes/38400/). This project uses native Reforged map formats, modern trigger storage, and [War3Net 6.1.2](https://github.com/Drake53/War3Net) codecs rather than downgrading the map to a classic editor format.

The supplied archive records map-info format 33 and last-save game version **2.0.4.23745**. That is metadata about its last save, not a claim that it only works on that patch. Its formats and version values are preserved; only the language byte in map information changes. All modern object skin files and unknown/imported files are retained. A current editor save may upgrade these versions, and subsequent imports must preserve those upgrades.

`tools/reference-api/` contains War3Net's 1.32.9 JASS declarations/fixtures used to resolve types for this particular source and run deterministic tests. Every function used by the active original source resolves against them. They are **not packaged as a replacement runtime** and do not pin the map to 1.32.9. New Lua calls resolve against the installed game's API. If reconverting new JASS that uses newer APIs, supply matching current declarations.

Warcraft's Lua uses 32-bit integers and floating-point numbers, as also checked in game by the [wc3-lib author](https://jsr.io/@mdlsvensson/wc3-lib/doc/persistence/format). The compatibility helpers detect the VM's numeric sizes: game arithmetic retains those native widths, while standalone standard Lua explicitly reproduces them. Integer division is adjusted to JASS truncation, including negative values and the minimum signed integer. The game path does not require `string.pack`/`string.unpack` for rounding. Tests run under both standard Lua and a separate `LUA_32BITS` build; neither substitutes for testing the actual game VM.

## Validation and remaining live tests

```sh
make test
# Also enforce the initial port's unchanged non-code data:
make verify-port
```

Passed for the delivered baseline:

- 514 original payload files byte-identical; only the script, WCT/WTG, and Lua language byte differ.
- All 26 supported editor binary files survive binary → JSON → binary exactly, including rebuilt trigger storage.
- All 1,662 executable-source functions accounted for; 410 Lua chunks compile under both Lua 5.3.6 numeric configurations.
- A fresh translation matches every assembled function body, every global declaration, and the extracted startup sequence. Conservative analysis found no reads of uninitialized local variables in the original functions.
- 4,068 startup native/helper calls match an independent evaluation of the original JASS, including argument values and order.
- 300 additional behavior cases match, covering feed rates, parsing, damage-event names, spell duration, projectile ability values, and text handling.
- The same comparisons pass when rebuilding executable Lua exclusively from WCT plus simulated editor-generated functions, in both numeric configurations.
- Explicit compiler edge cases pass for signed integer wrap, negative division, float32 rounding, integer-to-real conversion, escaping, short-circuiting, unreachable code, defaults, and Lua keyword collisions.
- 3,000 seeded integer/real arithmetic assertions pass in each numeric configuration, including signed integer boundaries. The converter also preserves the minimum integer literal as an integer in small Lua.
- 129 stateful scenario steps, 82 observations, and 6,277 native/helper calls including startup match. Scenarios cover missile impacts and invalidation, structure damage, delayed volleys, tornado ownership, spell-leech healing/expiry, Damage Engine callbacks including lethal damage, and bounty scaling. All declared globals and nondefault array entries match after startup and after the scenarios.
- Object HP and terrain-height edits survive compilation and readback with their intended values.
- Seven isolated workflow checks pass: rebuilding without a project build cache, local Lua changes, object/terrain CLI changes, protection of pending JSON changes, adoption of disabled and conflicting editor Lua, placement regeneration requirements, and rejection of inconsistent editor saves. A fresh work directory using the installed tool dependencies reproduces the delivered archive byte for byte.

The startup harness registers timers without advancing them and suspends waits. The stateful harness explicitly advances selected timer callbacks and supplies controlled event values, unit health, groups, and hashtable storage. It executes 497 of the 1,662 original functions across startup and these scenarios; compilation and assembly checks cover all functions. It does not reproduce the complete Warcraft event scheduler, combat engine, pathfinding, rendering, serialization, or multiplayer. See `reports/validation.json`, `reports/event-differential.json`, and `reports/workflow-validation.json` for the exact boundary.

Before treating the map as release-certified, use the current World Editor to open and save it, reload that save, change an object and terrain, and test the map in Warcraft III. Compare the original and port for player selection, game initialization, resource/feed settings, combat/Damage Engine, triggered spells, passive missiles, timed systems, victory/defeat, and save/load. Include a multiplayer session for synchronization validation.

The original disabled triggers contain broken references: a removed integer array, an invalid `ABILITY_RLF_MANA_COST` identifier, and references to removed `h06I` placements. Their Lua is retained without enabling them or changing active gameplay. Details are in `reports/disabled-original-issues.json`.
