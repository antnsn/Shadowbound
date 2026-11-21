<!-- summary (CurseForge "Summary" field, at most 256 characters):
Rogue helper for WoW: Forever: a card per weapon when its poison is missing or running out (click to apply the best rank in your bags), and warnings before Flash Powder, Blinding Powder or your poisons run out.
-->

# Shadowbound

**The rogue helper for World of Warcraft: Forever: your poisons and reagents, explained.**

Shadowbound keeps poison on your weapons and your bags stocked: a card for each weapon when its poison is missing or running out, and a warning before Flash Powder, Blinding Powder or your poisons run out.

**Beta:** Shadowbound is new. Spell and item IDs come from Classic and are checked on Forever before 0.1.0; tell us what doesn't work.

## Poisons
- **One card per weapon**: shows when the main-hand or off-hand weapon has no poison, or it runs out within the minutes you set. A hand with no weapon is skipped.
- **Click to apply** the poison you picked for that hand (Instant, Deadly, Crippling, Mind-numbing or Wound), the best rank in your bags.
- **Auto** picks Instant Poison for the main hand and Deadly Poison (else Crippling) for the off hand, or any other poison you carry.
- The cards show once you carry a poison (rogues learn poisons at level 20).

## Reagents
- Says when your **Flash Powder** (for Vanish) or **Blinding Powder** (for Blind) runs low, once you know the spell.
- Says when the **poisons you picked** run low (all ranks counted).

## Travel
- **Press Escape**: beside the game menu you get your Hearthstone.

## Also in it
- **Buff key** (Extras page): out of combat, each press applies the poison the top card asks for.
- **Well Rested and Well Fed**: a countdown before they run out, with a sound if you like.
- **Explained**: hover over a card or button for a plain-word explanation of what it does and why (can be turned off).
- **Your layout**: every frame can be moved, snapped to a grid and scaled (`/shadow unlock`).
- **Three skins**: the rogue look (Shadow), Blizzard and Flat.
- Loads on rogues only.

## Commands
- `/shadow`: open the options
- `/shadow help`: list every command
- `/shadow unlock`: show every frame so you can drag it into place
- `/shadow lock`: lock the frames again
- `/shadow reset`: put every frame back where it started
- `/shadow grid [size]`: snap to a grid while moving, or set its size
- `/shadow minimap`: show or hide the minimap button
- `/shadow explain`: turn the plain-word explanations in tooltips on or off

## Ideas and contributions
- **Missing something?** New features are added on request: leave a comment here.
- **Feel free to contribute**: the code is on GitHub, https://github.com/antnsn/Shadowbound (issues and pull requests welcome).
- **Want a Bound addon for another class?** The shared core, LibBound, has a guide and API reference: https://antnsn.github.io/LibBound/

## The Bound family
Shadowbound is one of the Bound addons, one per class, built on the same core: Lightbound (paladin), Chronobound (mage), Stormbound (shaman), Packbound (hunter), Spiritbound (priest), Felbound (warlock), Dreambound (druid) and Shadowbound (rogue). They look like their class but work the same way, so if you know one, you know them all.

## Changelog
<!-- changelog:start -->
### 0.1.0 beta 1

- First test build: a poison card for each weapon (click to apply the poison you picked, best rank in your bags), Flash Powder, Blinding Powder and poison stock warnings, the Hearthstone beside the Escape menu, the buff key (applies your poisons), Well-Rested and Well Fed, explanations, movable frames, Shadow, Blizzard and Flat skins. Built on LibBound-1.0.
<!-- changelog:end -->
