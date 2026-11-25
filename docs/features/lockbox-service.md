---
title: Lockbox service
parent: Features
nav_order: 10
description: Post your lockbox opening offer in Trade with one key press, and hear it when someone asks. Click Invite or Whisper in chat.
---

# Lockbox service

Sell lockbox opening to other players. Post your offer in Trade with one key press, and when someone asks for it in chat you hear a sound and get a line with **[Invite]** and **[Whisper]** to click.

## Posting your offer

- Set a key under **Lockbox service** in the `/shadow` window (**Announce key**), click **Announce now** there, or type `/shadow announce`.
- The game only lets addons post in Trade when you press a key or click, so there is no automatic posting on a timer.
- Your message, with the placeholders filled in, goes to the Trade channel. Outside a city there is no Trade channel, and you get a note instead.
- To keep you out of trouble for spamming, it waits at least 60 seconds between posts (you can set 30 to 300).

The example message:

```
Lockpicking {skill}: opening lockboxes! Whisper me, tips welcome
```

Write your own in the box on the page. Placeholders: `{skill}` (your Lockpicking skill), `{zone}` (where you are) and `{level}` (your level). **Reset to example** brings the example back, and the line under the box shows what will be posted.

You need Pick Lock (level 16); before that the addon says so instead of posting, and gives no alerts. The skill comes from the game. If the game shows 0, type your skill under **Skill, when the game doesn't tell it** on the page.

## Alerts

When someone asks in Trade, General, LookingForGroup, say, yell or a whisper, you get a sound and one chat line:

```
[Shadowbound] Thrall: anyone open lockbox?  [Invite] [Whisper]
```

Click **[Invite]** to invite them to your group, or **[Whisper]** to start a whisper.

- In public chat it needs a request, not just the word: "anyone open lockbox?", "wtb lockpicking", "need junkbox opened", or a linked lockbox with "wtb open". "lockbox" alone in Trade does nothing, but in a whisper it is enough.
- Other players' offers ("WTS ...", "/w me", "tips welcome") don't count.
- The same person again within a minute gives no second line.
- Your own posts never alert you.
- Add your own words under **Extra words** (comma between them).

## Auto-whisper

Off by default. Turned on, the addon whispers your reply (on the page, with `{name}` for their name) to each person who asks, once per person per 10 minutes, never while you are in combat.

## Settings

![The Lockbox service page]({{ '/screenshots/options-lockbox-service.png' | relative_url }})

| Setting | Default | What it does |
| --- | --- | --- |
| Alerts | on | the sound and chat line when someone asks |
| Sound | on | a sound with each alert |
| Auto-whisper | off | whisper your reply to each person who asks |
| Announce key | none | the key that posts your message |
| Wait between posts | 60 s | 30 to 300 seconds |
| Channel | Trade | the channel to post in |
| Extra words | none | more words that count as a request |
