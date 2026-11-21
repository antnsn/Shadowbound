-- Poison cards, one per hand: the weapon has no poison (or other temporary enchant), or it runs
-- out soon. A click applies the poison picked for that hand from your bags, the best rank you
-- carry (out of combat). A hand with no weapon is skipped. Nothing shows until you carry a poison
-- (rogues learn poisons at level 20). Quiet in combat.
local _, ns = ...
if ns.disabled then return end
local D = ns.DATA
local Bound = LibStub("LibBound-1.0")

local KINDS = { "Instant", "Deadly", "Crippling", "Mind-numbing", "Wound" }
ns.POISON_CHOICES = { "Auto", "Instant", "Deadly", "Crippling", "Mind-numbing", "Wound" }
-- "Auto": the first of these you carry. Instant on the main hand for damage, Deadly (else
-- Crippling) on the off hand.
local AUTO = {
	main = { "Instant", "Deadly", "Crippling", "Wound", "Mind-numbing" },
	off = { "Deadly", "Crippling", "Instant", "Wound", "Mind-numbing" },
}
local ROMAN = { "", " II", " III", " IV", " V", " VI" }

local HANDS = {
	{ key = "main", slot = 16, frame = "ShadowboundMainHandFrame", title = "Main-hand poison", point = "mhPoint" },
	{ key = "off", slot = 17, frame = "ShadowboundOffHandFrame", title = "Off-hand poison", point = "ohPoint" },
}
ns.HANDS = HANDS

local function Count(id)
	local ok, n = pcall(C_Item.GetItemCount, id)
	return (ok and not ns.IsSecret(n) and n) or 0
end

-- "Instant Poison", "Deadly Poison III": the item's name (the game's own names, no lookup)
function ns.PoisonName(kind, rank)
	return kind .. " Poison" .. (ROMAN[rank or 1] or "")
end

-- the best rank of a poison kind in your bags: item ID, rank, and how many of that kind you
-- carry (every rank); nil, nil, 0 when you carry none
function ns.BestPoison(kind)
	local best, rank, total = nil, nil, 0
	for i, id in ipairs(D.poisons[kind] or {}) do
		local n = Count(id)
		if n > 0 then best, rank, total = id, i, total + n end
	end
	return best, rank, total
end

-- true while you carry any poison: the cards stay quiet before that
function ns.CarriesPoison()
	for _, k in ipairs(KINDS) do
		if select(3, ns.BestPoison(k)) > 0 then return true end
	end
	return false
end

-- the poison kind for a hand ("main" or "off"): the one picked, or for Auto the first one you
-- carry in that hand's order (its first choice when you carry none)
function ns.PoisonKind(hand)
	local choice = ns.db[hand .. "Choice"]
	if choice ~= "Auto" and D.poisons[choice] then return choice end
	for _, k in ipairs(AUTO[hand]) do
		if select(3, ns.BestPoison(k)) > 0 then return k end
	end
	return AUTO[hand][1]
end

-- true when the slot holds a weapon (an off-hand item that isn't a weapon can't take poison)
function ns.HasWeapon(slot)
	local ok, id = pcall(GetInventoryItemID, "player", slot)
	if not ok or ns.IsSecret(id) or not id then return false end
	local ok2, classID = pcall(function() return select(6, C_Item.GetItemInfoInstant(id)) end)
	if ok2 and classID and not ns.IsSecret(classID) and classID ~= 2 then return false end
	return true
end

-- per hand: seconds left on its temporary enchant (nil when there is none), and true when the
-- answer can't be read (secret values: nothing is claimed then)
function ns.PoisonLeft(slot)
	local ok, mh, mms, _, _, oh, oms = pcall(GetWeaponEnchantInfo)
	if not ok then return nil, true end
	local has, ms = mh, mms
	if slot == 17 then has, ms = oh, oms end
	if ns.IsSecret(has) or ns.IsSecret(ms) then return nil, true end
	if not has then return nil end
	return (ms or 0) / 1000
end

local M = {}
ns.modules[#ns.modules + 1] = M
local cards, overlays = {}, {}

local function UpdateHand(h)
	local card, overlay = cards[h.key], overlays[h.key]
	if ns.unlocked then
		card:SetStatus("Missing: Instant Poison"); card:Show(); card:Glow(false)
		if not InCombatLockdown() then overlay:Sync(nil) end
		return
	end
	local show, status, urgent, macro, name = false, nil, false, nil, nil
	if ns.db[h.key .. "Poison"] and not ns.InCombat() and ns.HasWeapon(h.slot) and ns.CarriesPoison() then
		local left, unknown = ns.PoisonLeft(h.slot)
		local need = (not left and not unknown) or (left and left <= ns.db.poisonMinutes * 60)
		if need then
			local kind = ns.PoisonKind(h.key)
			local id, rank = ns.BestPoison(kind)
			show = true
			card:SetIcon(C_Item.GetItemIconByID(id or D.poisons[kind][1]))
			if id then
				name = ns.PoisonName(kind, rank)
				macro = ("/use item:%d\n/use %d"):format(id, h.slot)
				status = (left and (Bound.FormatTime(left) .. " left") or "Missing") .. ": " .. name -- the click is in the explanation
				urgent = not left
			else
				status, urgent = "No " .. ns.PoisonName(kind) .. " in your bags", true
			end
		end
	end
	if show then
		card:SetStatus(status, urgent)
		card:Show(); card:Glow(true)
	else
		card:Glow(false); card:Hide()
	end
	if not InCombatLockdown() then overlay:Sync(macro and name or nil, "player", ns.Help[h.key .. "Poison"], macro) end
end

function M:Update()
	if not cards.main then return end
	for _, h in ipairs(HANDS) do UpdateHand(h) end
end

function M:Init()
	for _, h in ipairs(HANDS) do
		local card = ns.MakeCard(h.frame, { width = 300 }) -- room for "12:41 left: Mind-numbing Poison III"
		card:SetIcon(C_Item.GetItemIconByID(D.poisons.Instant[1]))
		card:SetTitle(h.title)
		card:SetExplain(ns.Help[h.key .. "Poison"])
		ns.MakeMovable(card, h.point)
		ns.ApplyPoint(card, h.point)
		cards[h.key] = card
		overlays[h.key] = ns.CastOverlay(card) -- main hand first: the buff key takes the top card
	end
	local f = CreateFrame("Frame")
	for _, e in ipairs({ "BAG_UPDATE_DELAYED", "PLAYER_REGEN_ENABLED", "PLAYER_REGEN_DISABLED", "PLAYER_ENTERING_WORLD",
		"PLAYER_EQUIPMENT_CHANGED" }) do f:RegisterEvent(e) end
	f:RegisterUnitEvent("UNIT_INVENTORY_CHANGED", "player")
	f:SetScript("OnEvent", function() M:Update() end)
	C_Timer.NewTicker(1, function() M:Update() end)
	M:Update()
end
