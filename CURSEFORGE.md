<!-- summary (CurseForge "Summary" field, at most 256 characters):
Rogue helper for WoW: Forever: a card per weapon when its poison is missing or running out (click to apply the best rank in your bags), warnings before Flash Powder, Blinding Powder or your poisons run out, and a combo point bar.
-->

# Shadowbound

**The rogue helper for World of Warcraft: Forever: your poisons, reagents and combo points.**

Shadowbound keeps poison on your weapons and your bags stocked: a card for each weapon when its poison is missing or running out, and a warning before Flash Powder, Blinding Powder or your poisons run out.

**Full guide:** https://antnsn.github.io/Shadowbound/

## Poisons
- **One card per weapon**: shows when the main-hand or off-hand weapon has no poison, or it runs out within the minutes you set. A hand with no weapon is skipped.
- **Click to apply** the poison you picked for that hand (Instant, Deadly, Crippling, Mind-numbing or Wound), the best rank in your bags.
- **Auto** picks Instant Poison for the main hand and Deadly Poison (else Crippling) for the off hand, or any other poison you carry.
- The cards show once you carry a poison (rogues learn poisons at level 20).

## Reagents
- Says when your **Flash Powder** (for Vanish) or **Blinding Powder** (for Blind) runs low, once you know the spell.
- Says when the **poisons you picked** run low (all ranks counted).

## Combo points
- **Five drops**, one lit for each combo point on your target. Shown while you have points or are in combat.
- **A pulse at 5**: time for a finisher.
- Move and resize it like the cards.

## Travel
- **Press Escape**: beside the game menu you get your Hearthstone.

## Also in it
- **Lockbox service**: post your lockbox offer in Trade with one key press, with your Lockpicking skill; a sound and [Invite]/[Whisper] in chat when someone asks.
- **Buff key** (Extras page): out of combat, each press applies the poison the top card asks for.
- **Well Rested and Well Fed**: a countdown before they run out, with a sound if you like.
- **Camp Benefits**: a countdown before the campfire buff runs out, and which ticked camp features it lacks.
- **Carrot on a Stick** (Extras page, off by default): worn while you ride, in the trinket slot you pick; your own trinket goes back on when you get off. Not in instances, and never in combat.
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
Shadowbound is one of the Bound addons, one per class, built on the same core: Lightbound (paladin), Chronobound (mage), Stormbound (shaman), Packbound (hunter), Spiritbound (priest), Felbound (warlock), Dreambound (druid), Ragebound (warrior) and Shadowbound (rogue). They look like their class but work the same way, so if you know one, you know them all.

## Changelog
<!-- changelog:start -->
### 0.1.0

- **Camp Benefits** (Forever's campfire buff, new **Camp** page): a warning before it runs out, and a chat line naming the camp features you ticked that the campfire lacks (Camp Chair, First Aid Kit, Mana Well, ...). From LibBound, the same in every Bound addon.

### 0.1.0 beta 7

- **Lockbox service** (new page in `/shadow`): post your lockbox offer in Trade with one key press or `/shadow announce`, with your Lockpicking skill filled in. When someone asks ("anyone open lockbox?") you hear it and get a chat line with [Invite] and [Whisper]. Optional auto-whisper reply, off by default.
- **Carrot on a Stick** (Extras page, off by default): put it on when you mount, in the trinket slot you pick, and your own trinket back when you get off. Not in instances; in combat it waits until the fight is over. From LibBound, the same as in Lightbound.
- The Extras page is tidier: the Well-Rested and Well Fed switches sit in one row each.

### 0.1.0 beta 6

- Built on the latest LibBound, the shared core of the Bound addons, with its small fixes. Published on CurseForge straight from GitHub now.

### 0.1.0 beta 5

- In the Blizzard and Flat skins the combo points take a plain look: five squares, lit green.
- The options header shows no version number when the addon runs from a git copy.

### 0.1.0 beta 4

- **Combo points glow**: each lit drop has a soft green glow round it.
- **Poison cards** are wider and say just the poison (`Missing: Instant Poison IV`), so the line is no longer cut off. The tooltip says a click applies it.

### 0.1.0 beta 3

- **Fixed**: beta 2 failed to load (`ComboPoints.lua:60: attempt to call a nil value`): the combo point pulse used an animation call Forever doesn't have. The drops now flash a few times at 5 points instead.

### 0.1.0 beta 2

- **Combo point bar**: five drops, one lit for each combo point on your target, shown while you have points or are in combat, with a pulse when you reach 5. Movable and resizable; settings on the new Combo points page.
- The guide has screenshots now.

### 0.1.0 beta 1

- First test build: a poison card for each weapon (click to apply the poison you picked, best rank in your bags), Flash Powder, Blinding Powder and poison stock warnings, the Hearthstone beside the Escape menu, the buff key (applies your poisons), Well-Rested and Well Fed, explanations, movable frames, Shadow, Blizzard and Flat skins. Built on LibBound-1.0.
<!-- changelog:end -->
