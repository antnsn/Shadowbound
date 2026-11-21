---
title: Poisons
parent: Features
nav_order: 1
description: A card for each weapon when it has no poison or the poison runs out soon. Click it to apply the poison from your bags.
---

# Poisons

Poison on both weapons, watched for you. When a coat runs low or is gone, a card shows up, and one click puts a new one on from your bags.

## What it does

![The main-hand poison card]({{ '/screenshots/frames/mhpoint.png' | relative_url }})
![The off-hand poison card]({{ '/screenshots/frames/ohpoint.png' | relative_url }})

Shadowbound has one card per hand: **Main-hand poison** and **Off-hand poison**. A card shows when all of this is true:

- the card is turned on for that hand (both are on by default),
- you are out of combat,
- that slot holds a weapon,
- you carry at least one poison of any kind,
- the weapon has no poison on it, or its poison has the set time left or less (3 minutes by default).

What the card says:

- **Gone.** `Missing: click for Instant Poison IV`, in the warning color.
- **Running out.** The time left and the poison, for example `2:41 left: click for Deadly Poison II`.
- **Not in your bags.** `No Wound Poison in your bags`, in the warning color. The card can't be clicked then.

Click the card out of combat and Shadowbound applies the poison to that weapon. It uses the best rank of that poison you carry. The card goes away as soon as the poison is on.

### Which poison each hand gets

On the **Poisons** page you pick a poison per hand: **Auto**, Instant, Deadly, Crippling, Mind-numbing or Wound. The default for both hands is **Auto**.

Auto takes the first poison in this list that you carry:

| Hand | Auto order |
| --- | --- |
| Main hand | Instant, Deadly, Crippling, Wound, Mind-numbing |
| Off hand | Deadly, Crippling, Instant, Wound, Mind-numbing |

So with Instant and Deadly in your bags, the main hand gets Instant Poison and the off hand gets Deadly Poison. With only Crippling Poison, both hands get Crippling.

When you pick a poison yourself, that hand always asks for it. If you don't carry it, the card says so (`No Wound Poison in your bags`) instead of using another poison.

### Ranks

Shadowbound knows these ranks and always uses the highest one in your bags:

| Poison | Ranks |
| --- | --- |
| Instant Poison | I to VI |
| Deadly Poison | I to V |
| Crippling Poison | I and II |
| Mind-numbing Poison | I to III |
| Wound Poison | I to IV |

## How to use it

1. Carry a poison. Nothing shows before that.
2. When a card shows, click it out of combat. Hover over it first if you want to see which poison it will apply.
3. If the weapon still has poison on it, the game asks whether to replace the current enchantment. Confirm, and the new coat goes on.
4. Want a different poison on a hand? Open `/shadow`, page **Poisons**, and click the **Poison to apply** button under that hand.

To move the cards, see [Frames and minimap](frames-and-minimap.html).

## Settings

![The Poisons page]({{ '/screenshots/options-poisons.png' | relative_url }})

In `/shadow`, page **Poisons**. The main hand and the off hand each have their own section:

| Setting | Default | What it does |
| --- | --- | --- |
| Show when this weapon has no poison | On | Watches this hand at all. Off means no card for it, and its poison is left out of the [reagents card](reagents.html). |
| Poison to apply | Auto | The poison for this hand. Click to step through the list, right-click to go back. The line under it shows what a click applies now, for example `Now: Instant Poison IV`, or `No Wound Poison in your bags.` |

One slider for both hands:

| Setting | Default | What it does |
| --- | --- | --- |
| Warn with time left | 3 min | The card shows when the poison has this much time left or less, 1 to 15 minutes. |

## Good to know

**Can I click the card in combat?**
No. The game does not let addons use items for you in combat. The cards hide when a fight starts and come back after it.

**The card asks me to replace a poison that is still on.**
That is the "running out" card. With the set time left or less, a click puts a fresh coat on, and the game asks you to confirm the replacement. Shadowbound doesn't answer that question for you. Lower **Warn with time left** if the card comes too early.

**I have a sharpening stone on my weapon and no card shows.**
Shadowbound reads the weapon's temporary enchant, and a stone or other temporary enchant counts. The card shows once that enchant has the set time left or less, or is gone.

**My off hand has no card.**
A hand with no weapon is skipped, and so is an off-hand item that isn't a weapon. Also check **Show when this weapon has no poison** for the off hand.

**I used my last poison and the cards went away.**
The cards only show while you carry at least one poison of any kind. With none left there is nothing to apply, so they stay hidden until you buy or make more.

**The card says a poison is not in my bags, but I have other poisons.**
You picked that poison for this hand. Picked poisons are never swapped for another one. Set the hand to **Auto** if you want it to use whatever you carry.
