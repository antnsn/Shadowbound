"""Draws Shadowbound's textures into Media/ (TGA, power-of-two sizes).

Run from the addon folder:  python3 tools/make_media.py
Card textures are white with alpha so the game can tint them; the emblem comes from the painted art.
"""
import math
import random
from PIL import Image, ImageChops, ImageDraw, ImageFilter


OUT = "Media/"
ART = "Shadowbound.png"  # painted by Marius: the logo, icon and crest are made from it
# The combo point drop (ComboPoint.png, painted by Marius) is made by LibBound's tool:
#   python3 ../LibBound/tools/make_combo_media.py ComboPoint.png Media


def smoke(size=128, seed=13):
    """Drifting smoke, tileable, white on alpha: long thin wisps, blurred, over a faint haze."""
    rnd = random.Random(seed)
    img = Image.new("L", (size, size), 0)
    d = ImageDraw.Draw(img)
    for _ in range(26):
        x, y = rnd.randrange(size), rnd.randrange(size)
        length, amp = rnd.randint(30, 70), rnd.uniform(3, 9)
        phase, v, w = rnd.uniform(0, 6.28), rnd.randint(40, 95), rnd.randint(2, 5)
        pts = [(x + t, y + amp * math.sin(phase + t / 11.0)) for t in range(length)]
        for dx in (-size, 0, size):
            for dy in (-size, 0, size):
                d.line([(px + dx, py + dy) for px, py in pts], fill=v, width=w)
    img = img.filter(ImageFilter.GaussianBlur(3.5))
    haze = Image.new("L", (size, size), 0)
    hd = ImageDraw.Draw(haze)
    for _ in range(18):
        x, y, r = rnd.randrange(size), rnd.randrange(size), rnd.randint(12, 26)
        for dx in (-size, 0, size):
            for dy in (-size, 0, size):
                hd.ellipse([x + dx - r, y + dy - r, x + dx + r, y + dy + r], fill=rnd.randint(15, 35))
    haze = haze.filter(ImageFilter.GaussianBlur(9))
    img = ImageChops.lighter(img, haze)
    out = Image.new("RGBA", (size, size), (255, 255, 255, 0))
    out.putalpha(img)
    return out


def blade(size=32):
    """A small dagger blade lying out of the top-left corner: a curved edge, a bright ridge."""
    s = size * 4
    img = Image.new("L", (s, s), 0)
    d = ImageDraw.Draw(img)
    x0, y0, x1, y1 = s * 0.05, s * 0.05, s * 0.82, s * 0.82
    left, right = [], []
    steps = 24
    for k in range(steps + 1):
        t = k / steps
        cx, cy = x0 + (x1 - x0) * t, y0 + (y1 - y0) * t
        w = s * 0.10 * (t ** 0.7)  # widest at the hilt, a point at the corner
        bow = s * 0.05 * math.sin(math.pi * t)  # the edge curves out a little
        left.append((cx + (w + bow) * 0.707, cy - (w + bow) * 0.707))
        right.append((cx - w * 0.5 * 0.707, cy + w * 0.5 * 0.707))
    d.polygon(left + right[::-1], fill=140)
    d.line([(x0, y0), (x1, y1)], fill=255, width=int(s * 0.02))
    # the guard
    gx, gy, g = x1, y1, s * 0.12
    d.line([(gx + g * 0.707, gy - g * 0.707), (gx - g * 0.707, gy + g * 0.707)], fill=220, width=int(s * 0.04))
    img = img.filter(ImageFilter.GaussianBlur(s * 0.006)).resize((size, size), Image.LANCZOS)
    out = Image.new("RGBA", (size, size), (255, 255, 255, 0))
    out.putalpha(img)
    return out


def rim(size=64, width=5):
    img = Image.new("L", (size, size), 0)
    d = ImageDraw.Draw(img)
    for i in range(width * 2):
        v = int(255 * (1 - i / (width * 2)) ** 2)
        d.rectangle([i, i, size - 1 - i, size - 1 - i], outline=v)
    img = img.filter(ImageFilter.GaussianBlur(1.2))
    out = Image.new("RGBA", (size, size), (255, 255, 255, 0))
    out.putalpha(img)
    return out


def emblem(size=256, art=ART):
    """The emblem, from the painted art in Shadowbound.png (also the CurseForge project picture)."""
    return Image.open(art).convert("RGBA").resize((size, size), Image.LANCZOS)


def crest(size=256, art=ART):
    """The card crest: the same art as a white shape for the game to tint, its light parts
    brighter, so the faint motif behind the cards matches the icon."""
    art = emblem(size, art)
    lum = art.convert("L").point([int(70 + v * 185 / 255) for v in range(256)])
    alpha = ImageChops.multiply(art.getchannel("A"), lum)
    out = Image.new("RGBA", (size, size), (255, 255, 255, 0))
    out.putalpha(alpha)
    return out


def icon(size, art=ART):
    """The emblem on a near-black purple gradient (the minimap and addon list icon)."""
    bg = Image.new("RGBA", (size, size), (0, 0, 0, 255))
    d = ImageDraw.Draw(bg)
    for y in range(size):
        t = y / size
        d.line([(0, y), (size, y)], fill=(int(14 + 26 * (1 - t)), int(10 + 12 * (1 - t)), int(22 + 38 * (1 - t)), 255))
    e = emblem(size * 2, art).resize((size, size), Image.LANCZOS)
    return Image.alpha_composite(bg, e)


def save(img, name):
    img.save(OUT + name + ".tga")
    print("wrote", OUT + name + ".tga", img.size)


if __name__ == "__main__":
    save(smoke(), "Smoke")
    save(blade(), "Blade")
    save(crest(), "Crest")
    save(rim(), "Rim")
    save(emblem(256), "Logo256")
    save(emblem(64), "Logo64")
    save(icon(64), "Icon64")
    save(icon(128), "Icon128")
