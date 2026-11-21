---
title: Buff key
parent: Features
nav_order: 2
description: One key that applies the poison a card asks for, out of combat.
---

# Buff key

Press one key, out of combat, and Shadowbound applies the poison a card asks for. No need to aim the mouse at a card.

## What it does

- Each press does **one** thing: what the top [poison card](poisons.html) would do if you clicked it.
- With both cards up, the main hand comes first. Press again for the off hand.
- A card only offers a click when it can apply something: the weapon has no poison, or its poison has the set time left or less, and you carry the poison picked for that hand.
- Rogues have no group buff, so the key never does anything for your party or raid.
- When there is nothing to do, a press says `nothing to buff right now.` in chat.

## How to use it

1. Type `/shadow` and open the **Extras** page.
2. Under **Buff key**, click the button next to **Key**, then press the key you want (for example a mouse button). Esc cancels.
3. Out of combat, press the key until it says there is nothing to buff. Each press applies one poison.

## Settings

![The Extras page with the buff key]({{ '/screenshots/options-extras.png' | relative_url }})

In `/shadow`, page **Extras**, section **Buff key**:

| Setting | Default | What it does |
| --- | --- | --- |
| Key | Not set | The key itself. **Clear** removes it. |

Which poison the key applies follows the **Poison to apply** setting for each hand on the **Poisons** page. See [Poisons](poisons.html#settings).

## Good to know

**Does it work in combat?**
No. The game does not let addons use items for you in combat, so the key does nothing until combat ends. Poison up before the pull.

**A poison is still on and the key asks to replace it.**
The key does what the card does. With the set time left or less, the card offers a fresh coat, and the game asks you to confirm the replacement.

**The Extras page mentions a group buff.**
That note is shared by all Bound addons. Shadowbound has no group buff, so for a rogue the key only applies poisons.

**My key does something else in the game too.**
Shadowbound binds the key on top of your normal bindings while it is set. Pick a key you don't use for anything else, or **Clear** it to get the old binding back.
