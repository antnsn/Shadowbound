-- One reagent card: Flash Powder for Vanish and Blinding Powder for Blind (each once the spell is
-- known), and the poisons picked for your weapons (while you carry any poison), each below its
-- threshold. Quiet in combat.
local _, ns = ...
if ns.disabled then return end
local D = ns.DATA

local function Count(id)
	local ok, n = pcall(C_Item.GetItemCount, id)
	return (ok and not ns.IsSecret(n) and n) or 0
end

-- what runs low: list of { text, urgent }
function ns.LowReagents()
	local out = {}
	local function Check(on, spells, item, name, low)
		if not (on and ns.BestRank(spells)) then return end
		local n = Count(item)
		if n <= low then out[#out + 1] = { name .. " " .. n, n == 0 } end
	end
	Check(ns.db.flash, D.vanish, D.flashPowder, "Flash Powder", ns.db.flashLow)
	Check(ns.db.blinding, D.blind, D.blindingPowder, "Blinding Powder", ns.db.blindingLow)
	if ns.db.poisonStock and ns.CarriesPoison() then
		local seen = {}
		for _, h in ipairs(ns.HANDS) do
			if ns.db[h.key .. "Poison"] and ns.HasWeapon(h.slot) then
				local kind = ns.PoisonKind(h.key)
				if not seen[kind] then
					seen[kind] = true
					local n = select(3, ns.BestPoison(kind))
					if n <= ns.db.poisonLow then out[#out + 1] = { ns.PoisonName(kind) .. " " .. n, n == 0 } end
				end
			end
		end
	end
	return out
end

local M = {}
ns.modules[#ns.modules + 1] = M
local card

function M:Update()
	if not card then return end
	if ns.unlocked then card:SetStatus("Flash Powder: 3"); card:Show(); card:Glow(false) return end
	local low = (not ns.InCombat()) and ns.LowReagents() or {}
	if #low > 0 then
		local parts, urgent = {}, false
		for _, r in ipairs(low) do parts[#parts + 1] = r[1]; urgent = urgent or r[2] end
		card:SetStatus(table.concat(parts, " · "), urgent)
		card:Show(); card:Glow(true)
	else
		card:Glow(false); card:Hide()
	end
end

function M:Init()
	card = ns.MakeCard("ShadowboundReagentsFrame", { width = 320 }) -- room for three counts on one line
	card:SetIcon(C_Item.GetItemIconByID(D.flashPowder))
	card:SetTitle("Reagents running low")
	card:SetExplain(ns.Help.flash .. " " .. ns.Help.blinding .. " " .. ns.Help.poisonStock)
	ns.MakeMovable(card, "rgPoint")
	ns.ApplyPoint(card, "rgPoint")
	local f = CreateFrame("Frame")
	for _, e in ipairs({ "BAG_UPDATE_DELAYED", "SPELLS_CHANGED", "PLAYER_REGEN_ENABLED", "PLAYER_REGEN_DISABLED",
		"PLAYER_ENTERING_WORLD", "PLAYER_EQUIPMENT_CHANGED" }) do f:RegisterEvent(e) end
	f:SetScript("OnEvent", function() M:Update() end)
	M:Update()
end
