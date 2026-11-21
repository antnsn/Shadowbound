-- Shadowbound's look, "Shadow": near-black panels with a deep purple edge and teal light, a
-- drifting smoke layer, small blades in the corners, a slow violet rim while a card needs you.
-- LibBound derives the Blizzard and Flat skins from it.
-- Textures: tools/make_media.py.
local _, ns = ...
if ns.disabled then return end
local Bound = LibStub("LibBound-1.0")
local F = Bound.FONTS

local shadow = {
	name = "Shadow",
	font = { ui = F.friz, title = F.friz, narrow = F.arialn, card = F.morpheus },
	color = {
		bg = { 0, 0, 0, 0 },
		side = { 0.03, 0.02, 0.05, 0.45 },
		header = { 0.03, 0.02, 0.05, 0.40 },
		border = { 0.56, 0.42, 0.78, 0.9 },
		hover = { 0.14, 0.09, 0.22, 1 },
		selected = { 0.12, 0.08, 0.19, 1 },
		text = { 0.93, 0.91, 0.98 },
		dim = { 0.64, 0.62, 0.74 },
		accent = { 0.42, 0.88, 0.84 },
		track = { 0.09, 0.07, 0.14, 1 },
		button = { 0.05, 0.04, 0.08, 1 },
		navGlow = { 0.40, 0.86, 0.82, 0.60 },
		row = { 0.08, 0.06, 0.12, 0.8 },
		rowWarn = { 0.40, 0.30, 0.05, 0.5 },
		rowBad = { 0.45, 0.08, 0.10, 0.55 },
		highlight = { 0.82, 0.76, 1, 0.08 },
		cell = { 0.07, 0.05, 0.11, 0.85 },
		cdText = { 0.92, 0.90, 1 },
		glow = { 0.66, 0.50, 0.98 },
		gridLine = { 0.82, 0.76, 1, 0.08 },
		gridCentre = { 0.40, 0.86, 0.82, 0.45 },
	},
	box = {
		backdrop = {
			bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
			tile = true, tileSize = 16, edgeSize = 14,
			insets = { left = 3, right = 3, top = 3, bottom = 3 },
		},
		bg = { 0.04, 0.03, 0.06 },
		border = { 0.60, 0.46, 0.82, 1 },
	},
	dialog = {
		backdrop = {
			bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background-Dark",
			edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
			tile = true, tileSize = 32, edgeSize = 32,
			insets = { left = 11, right = 11, top = 12, bottom = 11 },
		},
		outset = 10,
		border = { 0.62, 0.50, 0.86, 1 },
		under = { 0.03, 0.02, 0.05, 1 },
		plate = false,
	},
	tex = Bound.STOCK_TEX,
	card = {
		panel = { 0.04, 0.03, 0.06, 0.95 },
		gilt = { 0.52, 0.38, 0.74, 1 },
		giltFaint = { 0.24, 0.40, 0.42, 0.9 },
		light = { 0.70, 0.95, 0.92, 0.06 },
		rays = { 0.74, 0.62, 1 },
		raysFaded = { 0.50, 0.46, 0.60 },
		title = { 0.92, 0.90, 1 },
		status = { 0.74, 0.88, 0.88 },
		urgent = { 1, 0.62, 0.42 },
		glowEdge = { 0.72, 0.58, 1, 1 },
		iconEdge = { 0.46, 0.36, 0.64, 0.9 },
		frost = "Smoke", frostTint = { 0.62, 0.70, 0.90, 0.14 },
		crest = "Crest", crestTint = { 0.70, 0.62, 1, 0.14 },
		shards = "Blade", shardTint = { 0.46, 0.90, 0.86, 0.9 },
		rim = "Rim", breathe = true, breatheTime = 3.2,
		burst = false, studs = false, ring = false, round = false,
	},
	widgets = "blizzard",
}

Bound.InstallSkin(ns, {
	skins = { shadow = shadow },
	order = { "shadow", "blizzard", "flat" },
	default = "shadow",
	about = { shadow = "Near-black with a purple edge, teal light, smoke and small blades." },
})
Bound.InstallBuffTimers(ns)
Bound.InstallMinimap(ns)
