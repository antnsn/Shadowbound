# Changelog

## 0.1.0

- **Camp Benefits** (Forever's campfire buff, new **Camp** page): a warning before it runs out, and a chat line naming the camp features you ticked that the campfire lacks (Camp Chair, First Aid Kit, Mana Well, ...). From LibBound, the same in every Bound addon.

## 0.1.0 beta 7

- **Lockbox service** (new page in `/shadow`): post your lockbox offer in Trade with one key press or `/shadow announce`, with your Lockpicking skill filled in. When someone asks ("anyone open lockbox?") you hear it and get a chat line with [Invite] and [Whisper]. Optional auto-whisper reply, off by default.
- **Carrot on a Stick** (Extras page, off by default): put it on when you mount, in the trinket slot you pick, and your own trinket back when you get off. Not in instances; in combat it waits until the fight is over. From LibBound, the same as in Lightbound.
- The Extras page is tidier: the Well-Rested and Well Fed switches sit in one row each.

## 0.1.0 beta 6

- Built on the latest LibBound, the shared core of the Bound addons, with its small fixes. Published on CurseForge straight from GitHub now.

## 0.1.0 beta 5

- In the Blizzard and Flat skins the combo points take a plain look: five squares, lit green.
- The options header shows no version number when the addon runs from a git copy.

## 0.1.0 beta 4

- **Combo points glow**: each lit drop has a soft green glow round it.
- **Poison cards** are wider and say just the poison (`Missing: Instant Poison IV`), so the line is no longer cut off. The tooltip says a click applies it.

## 0.1.0 beta 3

- **Fixed**: beta 2 failed to load (`ComboPoints.lua:60: attempt to call a nil value`): the combo point pulse used an animation call Forever doesn't have. The drops now flash a few times at 5 points instead.

## 0.1.0 beta 2

- **Combo point bar**: five drops, one lit for each combo point on your target, shown while you have points or are in combat, with a pulse when you reach 5. Movable and resizable; settings on the new Combo points page.
- The guide has screenshots now.

## 0.1.0 beta 1

- First test build: a poison card for each weapon (click to apply the poison you picked, best rank in your bags), Flash Powder, Blinding Powder and poison stock warnings, the Hearthstone beside the Escape menu, the buff key (applies your poisons), Well-Rested and Well Fed, explanations, movable frames, Shadow, Blizzard and Flat skins. Built on LibBound-1.0.
