-- Shadowbound's option pages; LibBound adds Extras and Skin, and builds the window.
local _, ns = ...
if ns.disabled then return end
local Bound = LibStub("LibBound-1.0")

local function PoisonPage(UI)
	local p = UI.NewPage("Poisons", "A card when a weapon has no poison or it runs out soon. Click it to apply the poison from your bags (out of combat).")
	local W = UI.CONTENT_W
	for _, h in ipairs(ns.HANDS) do
		p:Add(UI.Section(p, p.y - 4, h.title) + 2)
		p:Add(select(2, UI.DBToggle(p, 0, p.y, W, h.key .. "Poison", "Show when this weapon has no poison")) + 6)
		p:Add(select(2, UI.Cycle(p, p.y, "Poison to apply", ns.POISON_CHOICES,
			function() return ns.db[h.key .. "Choice"] end,
			function(v) ns.db[h.key .. "Choice"] = v; ns.Refresh() end,
			function()
				local kind = ns.PoisonKind(h.key)
				local id, rank = ns.BestPoison(kind)
				return id and ("Now: " .. ns.PoisonName(kind, rank)) or ("No " .. ns.PoisonName(kind) .. " in your bags.")
			end)) + 8)
	end
	p:Add(select(2, UI.Slider(p, p.y, "Warn with time left", "poisonMinutes", 1, 15, 1, " min")) + 8)
	p:Add(UI.Note(p, p.y, "Auto: Instant Poison on the main hand, Deadly Poison on the off hand (Crippling when you carry no Deadly), else any poison you carry. The cards show once you carry a poison."))
end

local function ReagentPage(UI)
	local p = UI.NewPage("Reagents", "Flash Powder for Vanish, Blinding Powder for Blind, and your poisons.")
	local W = UI.CONTENT_W
	p:Add(select(2, UI.DBToggle(p, 0, p.y, W, "flash", "Warn when Flash Powder runs low", "Once you know Vanish.")) + 6)
	p:Add(select(2, UI.Slider(p, p.y, "Flash Powder: warn at", "flashLow", 0, 20, 1, " left")) + 8)
	p:Add(select(2, UI.DBToggle(p, 0, p.y, W, "blinding", "Warn when Blinding Powder runs low", "Once you know Blind.")) + 6)
	p:Add(select(2, UI.Slider(p, p.y, "Blinding Powder: warn at", "blindingLow", 0, 20, 1, " left")) + 8)
	p:Add(select(2, UI.DBToggle(p, 0, p.y, W, "poisonStock", "Warn when your poisons run low", "The poison picked for each weapon, all ranks counted.")) + 6)
	p:Add(select(2, UI.Slider(p, p.y, "Poisons: warn at", "poisonLow", 0, 20, 1, " left")) + 8)
end

local function TravelPage(UI)
	local p = UI.NewPage("Travel", "Your Hearthstone beside the game menu (Escape).")
	p:Add(select(2, UI.DBToggle(p, 0, p.y, UI.CONTENT_W, "travel", "Show the travel panel when the game menu opens")) + 8)
end

ns.optionPages[#ns.optionPages + 1] = PoisonPage
ns.optionPages[#ns.optionPages + 1] = ReagentPage
ns.optionPages[#ns.optionPages + 1] = TravelPage
Bound.InstallOptions(ns, { header = "Rogue helper", launcher = "Rogue helper: poisons, reagents." })
