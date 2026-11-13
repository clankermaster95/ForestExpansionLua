# Resume Forest Expansion Lua on Windows

Current revision: **3.2.0 r13**. Read `AGENTS.md`, `LLM_GUIDE.md` and `project.json` before editing. Continue the existing source; do not restart the JASS conversion.

## Permissions and delivery

- Do not launch or control the Warcraft III game, Test Map, or the prepared game probe. The user supplies gameplay observations.
- The user explicitly authorized World Editor validation on November 12: load, save and reopen a separate copy, then inspect saved payloads. **The r13 check passed in World Editor 3.0.1.24371:** [evidence](reports/editor-validation-r13.json). No game or Test Map was launched. Keep the authoritative work folder safe and reconcile editor changes before importing them.
- Push completed, validated changes to the public repository `clankermaster95/ForestExpansionLua`. Publish matching map and community ZIP assets, update download links and verify uploaded files. Do not use the old personal account.
- Keep only the newest managed play copy in Warcraft Maps. The installer preserves unrelated maps; report locked copies still awaiting cleanup accurately.

## Current work and evidence

The code/data review repairs picker stock timing, Random purchases, flag refunds and cleanup, native ability pointers, and confirmed runtime defects. `reports/runtime-review-r13.md` lists fixed systems and remaining findings; its JSON companion inventories all 77 active modules. It does not claim every path was tested or every desync eliminated.

Native ability fields are checked by `tools/object_metadata.py` against `tools/reference-data/ability-metadata.json`, including data pointers that ordinary JSON/binary round trips cannot validate. Unit/item/buff/upgrade field types are checked separately against `tools/reference-data/object-field-types.json`. The guard covers 10,842 ability and 22,948 other object modifications, with 14 negative cases. The r13 migration also corrects two skin base IDs and two Lightning dummy field types. `reports/native-data-fixes-r13.json` records those corrections. The immutable `tests/fixtures/gameplay-r12.zip` and exact manifest `data/migrations/r13-object-fixes.json` feed `tools/revision_audit.py`; never replace a fixture to absorb new behavior. The earlier r12 tooltip-only claim remains historical evidence.

Read `reports/refactor-validation.json`, `reports/build.json` and `reports/workflow-validation.json` for the actual completed checks and delivered artifact. Offline doubles do not reproduce Warcraft rendering, all native event ordering or multiplayer synchronization. The full offline suite passes in both Lua numeric modes. The recorded editor save/reopen preserves 103 modules, 1,649 named function bodies, the 520-payload inventory and all 3,178 object identities; terrain, placements, imports and map metadata are byte-identical. Editor object normalization is reviewed separately in `reports/editor-object-roundtrip-r13.json`. Multiplayer gameplay validation is still needed; the editor check is not native combat/rendering or desync proof.

The November 8 editor save established Ancient slot 11 / Dark Green and native format v39 / game metadata 3.0.1.24371. Do not rerun the slot permutation. `reports/editor-roundtrip-repair.json` records that historical save and the trigger/text association repair. Preserve depth-first WTG/WCT ordering and use `\x25` in Lua strings where a percent character is needed.

## Files and commands

- Playable map: `dist/Forest_Expansion_3.2.0_Lua.w3x`
- Shareable bundle: `dist/Forest_Expansion_3.2.0_Community.zip`
- Editor work folder: `map/ForestExpansion.w3x/`
- Authoritative Lua: `src/`; editable objects and terrain: `data/`
- Original evidence: `original/` — immutable
- Player notes: `CHANGELOG.md`, `SOLO_TESTING.md`, `DEBUG_REFERENCE.md`, `PATCH_TESTING.md`

The prepared Windows toolchain uses local Python, .NET, StormLib and both Lua numeric modes:

```powershell
.\tools\windows.ps1 build
.\tools\windows.ps1 test
.\tools\windows.ps1 workflow
```

`project.json` owns the release label; use `tools/release_info.py --write` after changing it. Builds use ignored `local-build.json` for installation. Package only the verified map with `tools/package_community.py`. A rebuilt file does not update a running match or an editor's already-open map.

For an editor save elsewhere, use `tools/project.py import-editor <saved-map.w3x>` after reviewing it. For an intentional save into the work folder, use `export-data`. Add `--accept-code` only after reviewing editor Lua changes. Both paths back up previous state; preserve module markers and `data/code-baseline.json`. Placement/configuration edits still require a real editor save before packaging.

The public changelog compares **3.1.2a to 3.2.0**, without development iterations. Shop tracing stays off by default; `-test shop on` enables solo diagnostics. Spawn lists stay in `DEBUG_REFERENCE.md`, not Information/F9. Cultist is available only in matches that started with one human. Original content retains its ownership and notices; see `THIRD_PARTY.md`.
