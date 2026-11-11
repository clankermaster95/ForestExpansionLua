# Forest Expansion 3.2.0 — Testing reference

A separate reference for solo testing. Use Find (Ctrl+F) to locate an item, unit or code. These lists are not added to the in-game Information menu.

## How to use

- Start a new match with exactly one human; computer slots are allowed. Test commands are unavailable in matches that started with multiple humans.
- Select your own unit before issuing commands. Items spawn on the ground nearby; pick them up. Spawned heroes do not replace your chosen role.
- Codes are case-sensitive. A capital `I` is different from the digit `1`.
- `-test help`, `-test items <name>`, `-test units <name>` and `-test find <name>` also work in chat.
- Test recipes by purchasing from the real shop. Spawning a recipe scroll does not simulate paying for it.

## Commands

| Command | Effect |
|---|---|
| `-test help` | Show commands |
| `-test skip` (or `-skip`) | Unlock hero/race picks immediately, respecting bans; skip only the picking wait |
| `-gold 10000`, `-lumber 10000` | Add resources; negative amounts remove them; final amount clamped to 0–1,000,000 |
| `-xp 1000`, `-lvl 10` | Add XP / set hero level, 1–20 |
| `-test find human`, `-test find hammer` | Find case-sensitive unit/item IDs by name |
| `-test items`, `-test items 2`, `-test items armor` | Browse all item IDs in pages of 12 or search items |
| `-test units`, `-test units 2`, `-test units human` | Browse all unit IDs or search units |
| `-spawn h000 3` | Spawn three units nearby, maximum 20 |
| `-item I001`, `-item I004` | Spawn Helm of Devotion / Valor Armor on the ground nearby |
| `-item I00I`, `-item I00H` | Spawn completed Valorous Helmet / its recipe scroll; spawned scrolls do not simulate a shop payment |
| `-test heal`, `-test mana`, `-test cooldown` | Restore HP/mana or reset cooldowns once |
| `-test invul`, `-test vul` | Enable/disable invulnerability |
| `-test kill`, `-test revive`, `-test destroy` | Kill, revive a hero, or remove your target |
| `-test copy 3` | Spawn fresh units of the target type; does not copy items/levels |
| `-test reveal`, `-test hide` | Enable/disable map reveal |
| `-test speed 522`, `-test time 12` | Set speed / time of day |
| `-test unitid`, `-test itemid`, `-test loc` | Show target ID, first-slot item ID, coordinates |
| `-test shop` | All shop sales, recipe sales/completions/refunds, actual buyer, range and delivery result |
| `-test shop on`, `-test shop off` | Toggle automatic shop buy/pickup/drop/delivery messages; off by default; solo only |

## Items (89)

All entries come from the map catalog, including internal, dummy and legacy objects. A spawnable object is not necessarily a playable race or hero.

| Name | Code | Spawn command |
|---|---|---|
| [Recipe] Arcanum of Hatred (1050) | `I016` | `-item I016` |
| [Recipe] Bladed Gauntlet (900) | `I00G` | `-item I00G` |
| [Recipe] Bleeding Scythe (1200) | `I018` | `-item I018` |
| [Recipe] Cosmic Orb (600) | `I01A` | `-item I01A` |
| [Recipe] Ethereal Scepter (700) | `I01O` | `-item I01O` |
| [Recipe] Firelord's Cape (1150) | `I01S` | `-item I01S` |
| [Recipe] Hammer of Might (1550) | `I01M` | `-item I01M` |
| [Recipe] Righteous Armor (1500) | `I011` | `-item I011` |
| [Recipe] Spellcaster's Cloak (950) | `I01Q` | `-item I01Q` |
| [Recipe] Staff of Insight (950) | `I01D` | `-item I01D` |
| [Recipe] Valorous Helmet (500) | `I00H` | `-item I00H` |
| Agility training | `I009` | `-item I009` |
| Amulet of Dominance | `I00S` | `-item I00S` |
| Ancient Artifact | `I01H` | `-item I01H` |
| Arcanum of Hatred | `I015` | `-item I015` |
| Armor Plates | `I01Z` | `-item I01Z` |
| Barricade | `I02B` | `-item I02B` |
| Bladed Gauntlet | `I00F` | `-item I00F` |
| Bleeding Scythe | `I017` | `-item I017` |
| Bracer of Agility | `I02F` | `-item I02F` |
| Cheese | `I022` | `-item I022` |
| Clarity Potion | `I01W` | `-item I01W` |
| Cosmic Orb | `I019` | `-item I019` |
| Dark Transmutation | `I01F` | `-item I01F` |
| Deadly Axe | `I00O` | `-item I00O` |
| Ethereal Scepter | `I01P` | `-item I01P` |
| Experience Point | `I007` | `-item I007` |
| Farseer Trinket | `I026` | `-item I026` |
| Firelord's Cape | `I01T` | `-item I01T` |
| Flaming Staff | `I00E` | `-item I00E` |
| Galiant Armor | `I00Z` | `-item I00Z` |
| Gauntlet of Might | `I006` | `-item I006` |
| Gem of Life | `I00D` | `-item I00D` |
| Gilnean Boots | `I02D` | `-item I02D` |
| Grapes | `I027` | `-item I027` |
| Hammer of Might | `I01L` | `-item I01L` |
| Heated Armor | `I00C` | `-item I00C` |
| Helm of Devotion | `I001` | `-item I001` |
| Horn of Speed | `I00R` | `-item I00R` |
| Hungering Blade | `I01G` | `-item I01G` |
| I01V | `I01V` | `-item I01V` |
| I01X | `I01X` | `-item I01X` |
| I023 | `I023` | `-item I023` |
| I024 | `I024` | `-item I024` |
| I029 | `I029` | `-item I029` |
| I02E | `I02E` | `-item I02E` |
| IE-27 Mech Blaster | `I00Q` | `-item I00Q` |
| Intelligence Training | `I008` | `-item I008` |
| Iron Blade | `I002` | `-item I002` |
| Ledger of Clarity | `I01J` | `-item I01J` |
| Ledger of Enlightenment | `I01N` | `-item I01N` |
| Lion Shield | `I00T` | `-item I00T` |
| Lunar Crystal | `I01I` | `-item I01I` |
| Magical Biscuit | `I021` | `-item I021` |
| Magmide Blood | `I005` | `-item I005` |
| Majestic Sapphire | `I00V` | `-item I00V` |
| Message Of The Day - 3.1.0 | `I02C` | `-item I02C` |
| Monocle of Truth | `I014` | `-item I014` |
| Mystic Lava Rock | `I00B` | `-item I00B` |
| Nature's Leaf | `I00L` | `-item I00L` |
| Nerubian-Alchemy Gem | `I00U` | `-item I00U` |
| Orb of God | `I00M` | `-item I00M` |
| Orb of God Recipe | `I00N` | `-item I00N` |
| Orb of Mana | `I01B` | `-item I01B` |
| Orb of Revealing | `I000` | `-item I000` |
| Potion of Greater Invisibility | `I02G` | `-item I02G` |
| Potion of Invisibility | `I01U` | `-item I01U` |
| Potion of Mana | `I01Y` | `-item I01Y` |
| Protector Seed | `I010` | `-item I010` |
| Random | `I00W` | `-item I00W` |
| Random (A) | `I00X` | `-item I00X` |
| Rending Blade | `I01K` | `-item I01K` |
| Repair Bot | `I020` | `-item I020` |
| Righteous Armor | `I012` | `-item I012` |
| Rum | `I02A` | `-item I02A` |
| Scout Eagle | `I028` | `-item I028` |
| Seed of Destruction | `I00K` | `-item I00K` |
| Soul Hammer | `I01E` | `-item I01E` |
| Spellcaster's Cloak | `I01R` | `-item I01R` |
| Staff of Insight | `I01C` | `-item I01C` |
| Strength Training | `I00A` | `-item I00A` |
| Teleportation Wand | `I00Y` | `-item I00Y` |
| Thriving Razorvine Seed | `I013` | `-item I013` |
| Tome of Power | `I00J` | `-item I00J` |
| Training Lesson | `I003` | `-item I003` |
| Tree Chopper - Macko | `I025` | `-item I025` |
| Valor Armor | `I004` | `-item I004` |
| Valorous Helmet | `I00I` | `-item I00I` |
| Wand of Escape | `I00P` | `-item I00P` |

## Units (436)

All entries come from the map catalog, including internal, dummy and legacy objects. A spawnable object is not necessarily a playable race or hero.

| Name | Code | Spawn command |
|---|---|---|
| Abomination | `H01R` | `-spawn H01R` |
| Advanced Nerubian Harvester | `u00H` | `-spawn u00H` |
| Advanced Tunnel | `o00C` | `-spawn o00C` |
| Aethyr Warp | `h03S` | `-spawn h03S` |
| Altar | `h05I` | `-spawn h05I` |
| Altar of Cryptlord | `h03B` | `-spawn h03B` |
| Altar of Spider Queen | `h055` | `-spawn h055` |
| Altar of Technologies | `n00P` | `-spawn n00P` |
| Altar of the Thing | `h06D` | `-spawn h06D` |
| Amalgamation | `H064` | `-spawn H064` |
| Ancient of Corruption | `h02C` | `-spawn h02C` |
| Ancient of Darkness | `O00A` | `-spawn O00A` |
| Ancient of Destruction | `H01P` | `-spawn H01P` |
| Ancient of Dragons | `O00S` | `-spawn O00S` |
| Ancient of Earth | `O00L` | `-spawn O00L` |
| Ancient of Fire | `O004` | `-spawn O004` |
| Ancient of Forest | `O029` | `-spawn O029` |
| Ancient of Ice | `O008` | `-spawn O008` |
| Ancient of Light | `O01V` | `-spawn O01V` |
| Ancient of Lightning | `O016` | `-spawn O016` |
| Ancient of Nature | `O00D` | `-spawn O00D` |
| Ancient of Sand | `O01X` | `-spawn O01X` |
| Ancient of Space and Time | `O01Z` | `-spawn O01Z` |
| Ancient of Wind | `O01D` | `-spawn O01D` |
| Ancient Protector | `h043` | `-spawn h043` |
| Ancient Selection | `nmr2` | `-spawn nmr2` |
| Ancient Wall | `h02E` | `-spawn h02E` |
| Arcane Academy | `h05K` | `-spawn h05K` |
| Arcane Golem | `O024` | `-spawn O024` |
| Arcane Library | `h05J` | `-spawn h05J` |
| Arcane Mage | `o023` | `-spawn o023` |
| Archdruid | `h05D` | `-spawn h05D` |
| Arrow Tower | `h005` | `-spawn h005` |
| Attacker Dummy | `h057` | `-spawn h057` |
| Avatar Dummy | `h04L` | `-spawn h04L` |
| Avenger | `e004` | `-spawn e004` |
| Awards | `n00A` | `-spawn n00A` |
| Awards II | `n000` | `-spawn n000` |
| Azjol'Nerub | `h053` | `-spawn h053` |
| Barricade | `h00U` | `-spawn h00U` |
| Barricade | `h061` | `-spawn h061` |
| Base Flag | `h04V` | `-spawn h04V` |
| Base Flag | `h04W` | `-spawn h04W` |
| Base Flag | `h04X` | `-spawn h04X` |
| Base Flag | `h04Y` | `-spawn h04Y` |
| Base Flag | `h04Z` | `-spawn h04Z` |
| Base Flag | `h050` | `-spawn h050` |
| Base Flag | `h051` | `-spawn h051` |
| Base Flag | `h052` | `-spawn h052` |
| Base Flag | `h05N` | `-spawn h05N` |
| Base Flag | `h05P` | `-spawn h05P` |
| Beginner Races | `nmer` | `-spawn nmer` |
| Black Hole | `h03X` | `-spawn h03X` |
| Black Hole | `h054` | `-spawn h054` |
| Blacksmith | `h004` | `-spawn h004` |
| Blockade | `h04N` | `-spawn h04N` |
| blocker | `n001` | `-spawn n001` |
| Blood Pool | `h049` | `-spawn h049` |
| Boney Wall | `h00E` | `-spawn h00E` |
| Boulder Tower | `h00P` | `-spawn h00P` |
| Bounty Hunter | `h05W` | `-spawn h05W` |
| Burrowed Nerubian Harvester | `nbnb` | `-spawn nbnb` |
| Camp | `h003` | `-spawn h003` |
| Camp | `o01F` | `-spawn o01F` |
| Cannon Tower | `h006` | `-spawn h006` |
| Cenarius Grove | `h05L` | `-spawn h05L` |
| Centaur | `h01X` | `-spawn h01X` |
| Centaur Archer | `u003` | `-spawn u003` |
| Centaur Barracks | `h02G` | `-spawn h02G` |
| Centaur Base | `h032` | `-spawn h032` |
| Centaur Burrow | `o00M` | `-spawn o00M` |
| Centaur Champion | `u001` | `-spawn u001` |
| Centaur Crossbowman | `u005` | `-spawn u005` |
| Centaur Destruction Tower | `h02S` | `-spawn h02S` |
| Centaur Guard Tower | `h023` | `-spawn h023` |
| Centaur Haste Tower | `h02T` | `-spawn h02T` |
| Centaur Hide-out | `h02I` | `-spawn h02I` |
| Centaur Magical Tower | `h028` | `-spawn h028` |
| Centaur Military HQ | `h02H` | `-spawn h02H` |
| Centaur Militia | `u000` | `-spawn u000` |
| Centaur Protector | `u004` | `-spawn u004` |
| Centaur Sorcerer Tower | `h02V` | `-spawn h02V` |
| Centaur Speed Tower | `h029` | `-spawn h029` |
| Centaur Ultimate Tower | `h02K` | `-spawn h02K` |
| Centaur Wall | `h020` | `-spawn h020` |
| Centaur War Tower | `h027` | `-spawn h027` |
| Centaur Warcaller | `E000` | `-spawn E000` |
| Centaur Warrior | `u002` | `-spawn u002` |
| Centaur Watch Tower | `h024` | `-spawn h024` |
| Centaur Wood Harvester | `h01Z` | `-spawn h01Z` |
| Ceramic Wall | `h05Q` | `-spawn h05Q` |
| Chaos Bringer | `e006` | `-spawn e006` |
| Cheese Wall | `h05U` | `-spawn h05U` |
| Cheesy Laboratory | `o027` | `-spawn o027` |
| Combat Hunter | `h06C` | `-spawn h06C` |
| Coral Research Center | `n002` | `-spawn n002` |
| Corpse | `o02D` | `-spawn o02D` |
| Corrupted Nature Tower | `h01G` | `-spawn h01G` |
| Cove | `h03E` | `-spawn h03E` |
| Crypt Lord | `h03A` | `-spawn h03A` |
| Crypt Lord's Cove | `h039` | `-spawn h039` |
| Cultist | `h063` | `-spawn h063` |
| Dark Figure | `h047` | `-spawn h047` |
| Dark Templar | `e00E` | `-spawn e00E` |
| Dark Tower I | `o01Q` | `-spawn o01Q` |
| Dark Tower II | `o01O` | `-spawn o01O` |
| Dark Tower III | `o01P` | `-spawn o01P` |
| Dark Tower IV | `o01S` | `-spawn o01S` |
| Dark Tower V | `o01R` | `-spawn o01R` |
| Darkness Spawn | `e00D` | `-spawn e00D` |
| Darkness's Lackey | `e00C` | `-spawn e00C` |
| Davy Jones' Locker | `h03O` | `-spawn h03O` |
| Deathly Necromancer | `o01L` | `-spawn o01L` |
| Deathly Necromancer II | `o01M` | `-spawn o01M` |
| Deathly Necromancer III | `o01N` | `-spawn o01N` |
| Defense Center | `h021` | `-spawn h021` |
| Depth's Shop | `h03N` | `-spawn h03N` |
| Divine Golem | `e00F` | `-spawn e00F` |
| Dmg Test Dummy | `o02A` | `-spawn o02A` |
| Dome | `o00B` | `-spawn o00B` |
| Dragon Whelp | `e007` | `-spawn e007` |
| Dragon's Lackey | `e002` | `-spawn e002` |
| Druides | `n00E` | `-spawn n00E` |
| Druids Den | `h05M` | `-spawn h05M` |
| Dummy | `emtg` | `-spawn emtg` |
| Dune Worm | `e00I` | `-spawn e00I` |
| e00R | `e00R` | `-spawn e00R` |
| E00T | `E00T` | `-spawn E00T` |
| e00U | `e00U` | `-spawn e00U` |
| e00V | `e00V` | `-spawn e00V` |
| Eagle | `n014` | `-spawn n014` |
| Earth Elemental | `u00C` | `-spawn u00C` |
| Earth Rootling | `e00L` | `-spawn e00L` |
| Earth Wall | `h00M` | `-spawn h00M` |
| Earth's Lackey | `e009` | `-spawn e009` |
| Edmm | `Edmm` | `-spawn Edmm` |
| Elf Engineer | `n00M` | `-spawn n00M` |
| Elite Bounty Hunter | `h06H` | `-spawn h06H` |
| Elite Eagle | `n015` | `-spawn n015` |
| Elven Basement | `h05G` | `-spawn h05G` |
| Elven Lumbermill | `n00Q` | `-spawn n00Q` |
| Elven Merchant | `h05H` | `-spawn h05H` |
| Empowered Spirit Totem | `h05O` | `-spawn h05O` |
| Engineer's Shop | `n00R` | `-spawn n00R` |
| Engineer's Worker | `h05T` | `-spawn h05T` |
| Enhanced Sea Barrier Reef | `h03F` | `-spawn h03F` |
| Enhanced Tidal Tower | `h03M` | `-spawn h03M` |
| Enraged Ent | `h04T` | `-spawn h04T` |
| Ethereal Sustainer | `h03V` | `-spawn h03V` |
| Ethereal Tower | `h041` | `-spawn h041` |
| Even Cheesier Wall | `h05V` | `-spawn h05V` |
| Executioner's Domain | `h04B` | `-spawn h04B` |
| Exoskeleton Wall | `h00H` | `-spawn h00H` |
| Factory | `h01U` | `-spawn h01U` |
| Fire Pit | `o009` | `-spawn o009` |
| Fire Sprite | `o002` | `-spawn o002` |
| Flag Aura Dummy | `n013` | `-spawn n013` |
| Flak Cannon | `h01J` | `-spawn h01J` |
| Flame Elemental | `o003` | `-spawn o003` |
| Flame Tower | `n00T` | `-spawn n00T` |
| Flaming Wall | `h00B` | `-spawn h00B` |
| Follower | `h06B` | `-spawn h06B` |
| Forgotten Bloodmage | `u009` | `-spawn u009` |
| Forgotten Executioner | `u00B` | `-spawn u00B` |
| Forgotten One | `u007` | `-spawn u007` |
| Forgotten Soulreaper | `u00A` | `-spawn u00A` |
| Forgotten Vault | `o01U` | `-spawn o01U` |
| Fortified Barricade | `h062` | `-spawn h062` |
| Fountain of Corruption | `h04H` | `-spawn h04H` |
| Freeze Zone Dummy | `h06G` | `-spawn h06G` |
| Frigate Zeppelin | `u006` | `-spawn u006` |
| Frost Tower | `n00U` | `-spawn n00U` |
| Frost Tower | `o014` | `-spawn o014` |
| Furbolg | `h02U` | `-spawn h02U` |
| Furbolg Base | `h02J` | `-spawn h02J` |
| Furbolg Shaman | `h02Y` | `-spawn h02Y` |
| Furbolg Warrior | `h02Z` | `-spawn h02Z` |
| Furbolg Worker | `n00C` | `-spawn n00C` |
| Gamma Ray | `h045` | `-spawn h045` |
| Gate | `h01I` | `-spawn h01I` |
| Ghoul | `o005` | `-spawn o005` |
| Ghoul Worker | `h00D` | `-spawn h00D` |
| Gilnean Castle | `o018` | `-spawn o018` |
| Gilnean House | `o017` | `-spawn o017` |
| Gilnean Shop | `o019` | `-spawn o019` |
| Gilnean Wall | `o01A` | `-spawn o01A` |
| Goblin | `h016` | `-spawn h016` |
| Goblin Battle Mech Alpha | `n005` | `-spawn n005` |
| Goblin Battle Mech Beta | `n004` | `-spawn n004` |
| Goblin Battle Mech Ultima | `n008` | `-spawn n008` |
| Goblin Engineer | `n006` | `-spawn n006` |
| Goblin Factory | `h02P` | `-spawn h02P` |
| Goblin Observer | `o00X` | `-spawn o00X` |
| Goblin Worker Mech | `n003` | `-spawn n003` |
| Gold | `h00Q` | `-spawn h00Q` |
| Golden Nerubian Harvester | `u00G` | `-spawn u00G` |
| Grave | `h00C` | `-spawn h00C` |
| Graveyard | `o007` | `-spawn o007` |
| Great Temple | `h04Q` | `-spawn h04Q` |
| Greater Blood Pool | `h04E` | `-spawn h04E` |
| Greater Husk | `u00J` | `-spawn u00J` |
| Greater Nightmare | `h04G` | `-spawn h04G` |
| Greater Skull Pile | `h067` | `-spawn h067` |
| Growth | `h017` | `-spawn h017` |
| Growth of Destruction | `h02D` | `-spawn h02D` |
| Growth Ward | `o00J` | `-spawn o00J` |
| Guard Tower | `n00W` | `-spawn n00W` |
| Guarded Tidal Tower | `h03J` | `-spawn h03J` |
| Guarded Tidal Tower of Destruction | `h03K` | `-spawn h03K` |
| Hardened Root | `o00P` | `-spawn o00P` |
| Haunted Ship | `H03P` | `-spawn H03P` |
| hfoo | `hfoo` | `-spawn hfoo` |
| Human | `h03D` | `-spawn h03D` |
| Human Worker | `h002` | `-spawn h002` |
| Hurricane | `ntor` | `-spawn ntor` |
| Husk Sanctuary | `u00L` | `-spawn u00L` |
| Ice Elemental | `e00P` | `-spawn e00P` |
| Ice's Lackey | `e00N` | `-spawn e00N` |
| Ignite's Lackey | `e00A` | `-spawn e00A` |
| Ignite's Minion | `e00B` | `-spawn e00B` |
| Improved Blockade | `h04P` | `-spawn h04P` |
| Improved Ceramic Wall | `h05R` | `-spawn h05R` |
| Improved Nature Tower | `h01F` | `-spawn h01F` |
| Improved Nature Wall | `h01C` | `-spawn h01C` |
| Improved Nerubian Wall | `h036` | `-spawn h036` |
| Intermediate Races | `n00G` | `-spawn n00G` |
| Jippy | `h00T` | `-spawn h00T` |
| Kobold | `h03Q` | `-spawn h03Q` |
| Kobold Library | `h025` | `-spawn h025` |
| Kobold Warrior | `h026` | `-spawn h026` |
| Kraken | `h000` | `-spawn h000` |
| Laboratory | `o00V` | `-spawn o00V` |
| Labratory | `o00E` | `-spawn o00E` |
| Large Razorvine | `o01G` | `-spawn o01G` |
| Laser Tower | `h01H` | `-spawn h01H` |
| Lava Shop | `o00N` | `-spawn o00N` |
| Lava Warrior | `o00O` | `-spawn o00O` |
| Lesser Husk | `u00I` | `-spawn u00I` |
| Light House | `h00Y` | `-spawn h00Y` |
| Light House | `h012` | `-spawn h012` |
| Light House | `h013` | `-spawn h013` |
| Light House | `h014` | `-spawn h014` |
| Light House | `h015` | `-spawn h015` |
| Light Revenant | `e00G` | `-spawn e00G` |
| Lightning Elemental | `e00K` | `-spawn e00K` |
| Lightning Revenant | `e00J` | `-spawn e00J` |
| Lightning Tower | `n00V` | `-spawn n00V` |
| Maexxna | `u00E` | `-spawn u00E` |
| Magma Lord | `H01M` | `-spawn H01M` |
| Magma Rock | `h01L` | `-spawn h01L` |
| Magmide | `o000` | `-spawn o000` |
| Manor | `o028` | `-spawn o028` |
| Mass Grave | `h04C` | `-spawn h04C` |
| Meat Tosser | `h00I` | `-spawn h00I` |
| Meat Wagon | `h01Q` | `-spawn h01Q` |
| Mecha-Wrecker | `O00W` | `-spawn O00W` |
| Meerkatking | `n00F` | `-spawn n00F` |
| Mega Tower | `h02A` | `-spawn h02A` |
| Merchant | `o00U` | `-spawn o00U` |
| Metalic Pile | `h02O` | `-spawn h02O` |
| Military Camp | `h02F` | `-spawn h02F` |
| Mind Controller | `o006` | `-spawn o006` |
| Missile Tower | `h007` | `-spawn h007` |
| Molten Core | `o011` | `-spawn o011` |
| Molten Wall | `h02R` | `-spawn h02R` |
| Moosetackler | `n00I` | `-spawn n00I` |
| Mortar Team | `h01W` | `-spawn h01W` |
| Mud Golem | `e008` | `-spawn e008` |
| n00X | `n00X` | `-spawn n00X` |
| Nature Tower | `h01E` | `-spawn h01E` |
| Nature Wall | `h01B` | `-spawn h01B` |
| Nature's Lackey | `e00O` | `-spawn e00O` |
| Nature's Spawn | `e00M` | `-spawn e00M` |
| Nerubian | `h01K` | `-spawn h01K` |
| Nerubian Harvester | `h056` | `-spawn h056` |
| Nerubian Merchant | `h03C` | `-spawn h03C` |
| Nerubian Spire | `h059` | `-spawn h059` |
| Nerubian Swarmer | `u00F` | `-spawn u00F` |
| Nerubian Tower | `h05A` | `-spawn h05A` |
| Nerubian Wall | `h037` | `-spawn h037` |
| Nerubian Ziggurat | `h058` | `-spawn h058` |
| Nether Obelisk | `h03U` | `-spawn h03U` |
| Nether Portal | `h03T` | `-spawn h03T` |
| Nether Rip | `h03W` | `-spawn h03W` |
| Nether Tower | `h040` | `-spawn h040` |
| nfoh | `nfoh` | `-spawn nfoh` |
| ngbl | `ngbl` | `-spawn ngbl` |
| Night Elf | `h05C` | `-spawn h05C` |
| Nightmare | `h04F` | `-spawn h04F` |
| Nikkone | `n00D` | `-spawn n00D` |
| nmoo | `nmoo` | `-spawn nmoo` |
| nmr3 | `nmr3` | `-spawn nmr3` |
| npgr | `npgr` | `-spawn npgr` |
| o00G | `o00G` | `-spawn o00G` |
| o00H | `o00H` | `-spawn o00H` |
| o00I | `o00I` | `-spawn o00I` |
| Observatory | `n00S` | `-spawn n00S` |
| Ogre | `h00F` | `-spawn h00F` |
| Ogre Head Smasher | `o010` | `-spawn o010` |
| Ogre Overlord | `O00Z` | `-spawn O00Z` |
| Ogre Worker | `h00G` | `-spawn h00G` |
| Ogre-Rider | `n007` | `-spawn n007` |
| Old Workshop | `h060` | `-spawn h060` |
| otot | `otot` | `-spawn otot` |
| Outpost | `h035` | `-spawn h035` |
| Outpost | `h065` | `-spawn h065` |
| Partial Shinigami Manifestation | `h06E` | `-spawn h06E` |
| Pharaoh's Servant | `e00H` | `-spawn e00H` |
| Pit of Endless Ravening | `h04D` | `-spawn h04D` |
| Plague House | `h038` | `-spawn h038` |
| Power Generator | `n00O` | `-spawn n00O` |
| Primordial Ooze | `h048` | `-spawn h048` |
| Quicksand Trap | `o01Y` | `-spawn o01Y` |
| Raging Growth | `n00L` | `-spawn n00L` |
| Raging Thorn | `o00Q` | `-spawn o00Q` |
| Raging Ward | `o01W` | `-spawn o01W` |
| Rat | `n00Z` | `-spawn n00Z` |
| Ratling Stalker | `o026` | `-spawn o026` |
| Razor Den | `h044` | `-spawn h044` |
| Razormane | `o01E` | `-spawn o01E` |
| Razormane Brute | `o01J` | `-spawn o01J` |
| Razorvine | `n00H` | `-spawn n00H` |
| Recipe Shop | `h02B` | `-spawn h02B` |
| Repair Bot | `n00Y` | `-spawn n00Y` |
| Research Center | `h02X` | `-spawn h02X` |
| Research Center | `n00N` | `-spawn n00N` |
| Rocky Tower | `h00O` | `-spawn h00O` |
| Rocky Wall | `h00L` | `-spawn h00L` |
| Roots | `h019` | `-spawn h019` |
| Sand Tower | `h00N` | `-spawn h00N` |
| Scout | `o01K` | `-spawn o01K` |
| Scrap pile | `h02N` | `-spawn h02N` |
| Sea Barrier | `h03G` | `-spawn h03G` |
| Sea Barrier Reef | `h03H` | `-spawn h03H` |
| Seaweed Plant | `o015` | `-spawn o015` |
| Seedling | `h018` | `-spawn h018` |
| Selector | `ewsp` | `-spawn ewsp` |
| Sewers | `h05S` | `-spawn h05S` |
| Shadow Dancer | `h05E` | `-spawn h05E` |
| Shadowling | `o01T` | `-spawn o01T` |
| Shady Vendor | `o025` | `-spawn o025` |
| Shaman Encampent | `h031` | `-spawn h031` |
| Shaman Hub | `o00F` | `-spawn o00F` |
| Shed | `h00A` | `-spawn h00A` |
| Shrine | `h06A` | `-spawn h06A` |
| Silvester | `h05Y` | `-spawn h05Y` |
| Skeletal Archer | `h01T` | `-spawn h01T` |
| Skeletal Warrior | `h01S` | `-spawn h01S` |
| Skull Pile | `h066` | `-spawn h066` |
| Soft Razorvine | `o01C` | `-spawn o01C` |
| Solar Flare | `h03Z` | `-spawn h03Z` |
| Solar Tower | `h042` | `-spawn h042` |
| Soul | `e00Q` | `-spawn e00Q` |
| Soul Beacon | `h04A` | `-spawn h04A` |
| Spark | `o00R` | `-spawn o00R` |
| Speed Tower | `h01O` | `-spawn h01O` |
| Spell dummy | `hFDM` | `-spawn hFDM` |
| Spellbringer | `n00B` | `-spawn n00B` |
| Spirit Shrine | `h04O` | `-spawn h04O` |
| Spirit Totem | `h05F` | `-spawn h05F` |
| Spirit Tree: Defense | `h01A` | `-spawn h01A` |
| Spirit Tree: Offense | `h01D` | `-spawn h01D` |
| Spirit Tree: Speed | `h01N` | `-spawn h01N` |
| Squid Harvester | `h00Z` | `-spawn h00Z` |
| Stalker | `h046` | `-spawn h046` |
| Stash | `h05B` | `-spawn h05B` |
| Stasis Trap (Bounty Hunter) | `o02B` | `-spawn o02B` |
| Steam Wagon | `H01V` | `-spawn H01V` |
| Sticky Glue | `n010` | `-spawn n010` |
| Storm Spirit | `e00S` | `-spawn e00S` |
| Strong Barricade | `h00V` | `-spawn h00V` |
| Strong Razorvine | `o01I` | `-spawn o01I` |
| Sun | `o020` | `-spawn o020` |
| Sun | `o021` | `-spawn o021` |
| Sun | `o022` | `-spawn o022` |
| Supernova | `h03Y` | `-spawn h03Y` |
| Supreme Husk | `u00K` | `-spawn u00K` |
| Suspicious Bush | `h03R` | `-spawn h03R` |
| Tavern | `o02C` | `-spawn o02C` |
| Technology Center | `h00K` | `-spawn h00K` |
| Teleporter | `h02Q` | `-spawn h02Q` |
| Temple of Tides | `h03I` | `-spawn h03I` |
| Tent | `h001` | `-spawn h001` |
| Tent | `h00J` | `-spawn h00J` |
| Tent | `h01Y` | `-spawn h01Y` |
| Tent | `h02W` | `-spawn h02W` |
| Tent | `h05X` | `-spawn h05X` |
| Tentacle | `u008` | `-spawn u008` |
| Test Dummy | `h04R` | `-spawn h04R` |
| Testing Station | `n012` | `-spawn n012` |
| Thick Razorvine | `o01H` | `-spawn o01H` |
| Thriving Razorvine | `n00K` | `-spawn n00K` |
| Tidal Tower | `h03L` | `-spawn h03L` |
| Totem | `h04K` | `-spawn h04K` |
| Totem of Destruction | `o013` | `-spawn o013` |
| Totem of Life | `o012` | `-spawn o012` |
| Tower of Death | `h069` | `-spawn h069` |
| Towering Skull Pile | `h068` | `-spawn h068` |
| Training Range | `h05Z` | `-spawn h05Z` |
| Transport Zeppelin | `n009` | `-spawn n009` |
| Tree Chopper | `n011` | `-spawn n011` |
| Tree of Life | `e001` | `-spawn e001` |
| Tree Spirit | `h00W` | `-spawn h00W` |
| Tunnel | `h00S` | `-spawn h00S` |
| u00D | `u00D` | `-spawn u00D` |
| uloc | `uloc` | `-spawn uloc` |
| Upgraded Centaur Wall | `h022` | `-spawn h022` |
| Upgraded Gilnean Wall | `o01B` | `-spawn o01B` |
| Upgraded Wall | `h009` | `-spawn h009` |
| Upgraded Wall | `h034` | `-spawn h034` |
| Vampiric Wyrm | `e005` | `-spawn e005` |
| Volcano | `o001` | `-spawn o001` |
| Wall | `h008` | `-spawn h008` |
| Wall | `h033` | `-spawn h033` |
| War Base | `o00Y` | `-spawn o00Y` |
| War Center | `h04S` | `-spawn h04S` |
| Warpling | `e003` | `-spawn e003` |
| Warrior Encampent | `h030` | `-spawn h030` |
| Watchful Eye | `nwad` | `-spawn nwad` |
| Water Sprite | `h00X` | `-spawn h00X` |
| Waterfall of Defense | `h011` | `-spawn h011` |
| Wildkin | `h010` | `-spawn h010` |
| Wildkin Hive | `h04M` | `-spawn h04M` |
| Wildkin Shaman | `h04U` | `-spawn h04U` |
| Wildkin Worker | `h04J` | `-spawn h04J` |
| Wildkin's Den | `h04I` | `-spawn h04I` |
| Wind Burst Dummy | `h06F` | `-spawn h06F` |
| Wind Trail | `u00M` | `-spawn u00M` |
| Wisp | `h02L` | `-spawn h02L` |
| Worgen | `h00R` | `-spawn h00R` |
| Worgen Lumber Counter | `h06I` | `-spawn h06I` |
| Workshop | `h02M` | `-spawn h02M` |
| Workshop | `o02E` | `-spawn o02E` |
| You may only train one hero | `o00K` | `-spawn o00K` |
| Young Razorvine | `n00J` | `-spawn n00J` |
| Zeppelin Tower | `o00T` | `-spawn o00T` |
