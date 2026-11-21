-- Shadowbound: the Rogue addon of the Bound family, built on LibBound-1.0 (the shared core).
-- This file sets the addon up; every other file returns at once on a non-rogue (ns.disabled).
local addonName, ns = ...
local Bound = LibStub("LibBound-1.0")

-- Spells and items, lowest rank first. Classic IDs; Forever follows Classic content.
-- Checked in game before each release.
ns.DATA = {
	-- poison items by kind, lowest rank first
	poisons = {
		Instant = { 6947, 6949, 6950, 8926, 8927, 8928 },
		Deadly = { 2892, 2893, 8984, 8985, 20844 },
		Crippling = { 3775, 3776 },
		["Mind-numbing"] = { 5237, 6951, 9186 },
		Wound = { 10918, 10920, 10921, 10922 },
	},
	vanish = { 1856, 1857 }, blind = { 2094 },
	flashPowder = 5140, blindingPowder = 5530,
}

ns.disabled = Bound:NewAddon(addonName, ns, {
	class = "ROGUE",
	title = "Shadowbound",
	prefix = "b48cff",
	db = "ShadowboundDB",
	slash = { "/shadow", "/shadowbound" },
	media = "Interface\\AddOns\\Shadowbound\\Media\\",
	defaults = {
		skin = "shadow",
		-- one poison card per hand: on/off, which poison, warn with this many minutes left
		mainPoison = true, mainChoice = "Auto",
		offPoison = true, offChoice = "Auto",
		poisonMinutes = 3,
		mhPoint = { "CENTER", "UIParent", "CENTER", -250, 200 },
		ohPoint = { "CENTER", "UIParent", "CENTER", -250, 140 },
		flash = true, flashLow = 5, blinding = true, blindingLow = 3, poisonStock = true, poisonLow = 5,
		rgPoint = { "CENTER", "UIParent", "CENTER", 250, 200 },
		-- the combo point bar: on, pulse at 5, shown only with points or in combat
		comboBar = true, comboPulse = true, comboAlways = false,
		cpPoint = { "CENTER", "UIParent", "CENTER", 0, -180 },
		travel = true,
		wrPoint = { "CENTER", "UIParent", "CENTER", 0, 320 },
		wfPoint = { "CENTER", "UIParent", "CENTER", 0, 260 },
	},
})
