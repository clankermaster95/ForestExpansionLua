# Forest Expansion 3.2.0 — Lua edition

Changes from **Forest Expansion 3.1.2a** to **3.2.0**.

## Lua and code organization

- Converted the map's gameplay code from JASS to Lua while preserving the original terrain, placements and imported assets.
- Consolidated 375 numbered gameplay scripts into 60 named modules organized by system, expander race and Ancient.
- Centralized Ancient ownership checks so role-dependent behavior follows the Ancient player rather than a hardcoded player color or slot.

## Ancient shops and recipes

- Shops automatically choose your nearby Ancient as the item recipient without changing your selected unit.
- Buying a recipe uses ingredients already in your inventory and purchases missing components, including nested recipes, to create the finished item.
- Owned ingredients reduce the price. Failed completion refunds the purchased scroll and retains your ingredients.
- Corrected the Ancient shops' stock configuration associated with purchased items dropping on the ground.
- Recipe tooltips now distinguish full price, scroll price and component requirements. Corrected inconsistent finished-item values and several item names.
- Automatic shop debug messages are off. Solo troubleshooting can be enabled explicitly with `-test shop on`.

## Solo testing

- Matches that start with exactly one human automatically enable testing commands and disable automatic victory/defeat timers. Computer slots are allowed.
- Added gold, lumber, XP, level, unit/item spawning, healing, cooldown, visibility and other testing commands. Use `-test help` in chat.
- `-test skip` unlocks hero/race picking immediately for testing.
- Complete spawn codes and command instructions are supplied in a separate **DEBUG_REFERENCE.md** document. The Information menu contains no generated debug catalogs.
- Matches that start with multiple humans never unlock test commands when players leave.

## Fixes and presentation

- Corrected string-table encoding used for map names and descriptions, and added a label to the first picking countdown.
- Fixed selector removal so unrelated unit purchases are not affected.
- Corrected several ownership, delayed-event, resource-price and combat-calculation issues.
- Added offline regression tests, native map-data validation and archive readback checks to the build process.

## Validation

Offline checks pass. Live shop confirmation and multiplayer desync testing remain outstanding. Please include the map build, reproduction steps and screenshots when reporting an issue.
