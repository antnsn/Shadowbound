<p align="center"><img src="Shadowbound.png" width="180" alt="Shadowbound: two crossed daggers, one dripping green poison"></p>

# Shadowbound

A rogue helper for **WoW: Forever**, part of the Bound family: one addon per class on the same
core (Lightbound, Chronobound, Stormbound, Packbound, Spiritbound, Felbound, Dreambound, Ragebound, Shadowbound).

Full guide: https://antnsn.github.io/Shadowbound/

- **Poisons**: a card for each weapon when it has no poison or the poison runs out soon. Click it
  to apply the poison you picked for that hand, the best rank in your bags. Auto picks Instant
  Poison for the main hand and Deadly Poison (else Crippling) for the off hand.
- **Reagents**: says when Flash Powder (Vanish), Blinding Powder (Blind) or the poisons you use
  run low.
- **Travel**: press Escape, and beside the game menu you get your Hearthstone.
- **Buff key** (Extras page): out of combat, each press applies the poison the top card asks for.
- **Well-Rested and Well Fed** timers, plain-word explanations in tooltips, movable frames
  (`/shadow unlock`), three skins (Shadow, Blizzard, Flat).

Type `/shadow` for the options, `/shadow help` for the commands.

## Install

1. Open [Releases](https://github.com/antnsn/Shadowbound/releases) and download
   `Shadowbound-<version>.zip` (not the green "Code > Download ZIP" button).
2. Unzip it into `World of Warcraft/_forever_/Interface/AddOns/`, so you get `AddOns/Shadowbound`.
3. Restart the game. Shadowbound only loads on rogues.

## Development

Built on [LibBound](https://github.com/antnsn/LibBound), developed in the folder next to it.

```bash
tools/sync-libbound.sh
for f in *.lua; do luac5.1 -p "$f"; done
~/.luarocks/bin/luacheck .
wowbench check . && wowbench test .
wowbench pack . --set-version 0.1.0
python3 tools/make_media.py
```

## License

GPL-3.0-or-later: GNU General Public License, version 3 or (at your option) any later
version; see [LICENSE](LICENSE). LibBound-1.0 (in `Libs/LibBound`) is MIT, see its own LICENSE.
