---
title: Reagents
parent: Features
nav_order: 3
description: A card when your Flash Powder, Blinding Powder or poisons run low.
---

# Reagents

Vanish uses Flash Powder, Blind uses Blinding Powder, and each coat of poison uses one poison item. Shadowbound tells you before you run out, so you can stock up.

## What it does

One card, **Reagents running low**, shows when one of these is at or below its limit:

| Part | Shows once | Counts | Warns at (default) |
| --- | --- | --- | --- |
| Flash Powder | you know Vanish | Flash Powder | 5 |
| Blinding Powder | you know Blind | Blinding Powder | 3 |
| Poisons | you carry any poison | the poison picked for each weapon, all ranks together | 5 |

- **Poisons.** For each hand with its poison card on and a weapon in it, Shadowbound counts the poison that hand uses: the one you picked, or what **Auto** chose (see [Poisons](poisons.html#which-poison-each-hand-gets)). When both hands use the same poison, it is listed once. All ranks of a poison add up, so 3 Instant Poison and 2 Instant Poison II count as 5.
- The card shows the counts, for example `Flash Powder 2` or `Blinding Powder 1 · Deadly Poison 4`. Poisons are shown by name without the rank.
- When one of them is at 0, the text turns to the warning color (red, or a warm orange in the Shadow skin).
- The card is hidden in combat and comes back after the fight.
- It updates when your bags change, so it goes away as soon as you buy or make more.

## How to use it

1. Nothing to set up: all three warnings are on by default.
2. When the card shows, buy Flash Powder from a reagent or poison vendor, make Blinding Powder, or restock your poisons.
3. Want more warning? Raise the limits on the **Reagents** page.

Shadowbound does not buy or make reagents for you.

## Settings

In `/shadow`, page **Reagents**:

| Setting | Default | What it does |
| --- | --- | --- |
| Warn when Flash Powder runs low | On | The Flash Powder part of the card. Once you know Vanish. |
| Flash Powder: warn at | 5 | Warns at this many or fewer, 0 to 20. |
| Warn when Blinding Powder runs low | On | The Blinding Powder part of the card. Once you know Blind. |
| Blinding Powder: warn at | 3 | Warns at this many or fewer, 0 to 20. |
| Warn when your poisons run low | On | The poison part of the card: the poison picked for each weapon, all ranks counted. |
| Poisons: warn at | 5 | Warns at this many or fewer of each poison, 0 to 20. |

## Good to know

**Set to 0, does it turn the warning off?**
No. At 0 it still warns when you have none left. Use the switch to turn a warning off.

**No powder warning before I learn the spell.**
That is on purpose. The Flash Powder warning starts once you know Vanish, the Blinding Powder warning once you know Blind.

**I used my last poison and the card doesn't say Poison 0.**
The poison part only shows while you carry at least one poison of any kind. With no poison left at all, it stays quiet, like the [poison cards](poisons.html).

**The card says Wound Poison 0, but I have plenty of Instant Poison.**
You picked Wound Poison for one of your hands, so that is the poison Shadowbound counts. Set the hand to **Auto** on the **Poisons** page to count what you carry.

**My off-hand poison isn't counted.**
A hand only counts while its poison card is on and it holds a weapon.
