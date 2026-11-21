-- The combo point bar: five drops (Marius' painted art), one lit for each combo point on your
-- target, greyed out for the rest. Shown while you have points or are in combat (or always, if
-- picked), with a short pulse when you reach 5. Movable and resizable like the cards.
-- Points the addon can't read (a secret value) hide the bar rather than show a wrong count.
local _, ns = ...
if ns.disabled then return end

local MAX, SIZE, GAP = 5, 30, 4
local DIM = { 0.30, 0.30, 0.30, 0.55 }

-- combo points on the target, or nil when they can't be read
function ns.ComboPoints()
	local ok, n
	if GetComboPoints then
		ok, n = pcall(GetComboPoints, "player", "target")
	else
		ok, n = pcall(UnitPower, "player", Enum.PowerType.ComboPoints)
	end
	if not ok or ns.IsSecret(n) or type(n) ~= "number" then return nil end
	return n
end

local M = {}
ns.modules[#ns.modules + 1] = M
local bar, last

local function Light(n)
	for i, p in ipairs(bar.pips) do
		p.lit = i <= n
		if p.lit then p:SetVertexColor(1, 1, 1, 1) else p:SetVertexColor(DIM[1], DIM[2], DIM[3], DIM[4]) end
	end
end

function M:Update()
	if not bar then return end
	if ns.unlocked then Light(3); bar:Show() return end
	local n = ns.db.comboBar and ns.ComboPoints()
	if not n then bar.pulse:Stop(); bar:Hide(); last = nil return end
	Light(n)
	if n > 0 or ns.InCombat() or ns.db.comboAlways then bar:Show() else bar:Hide() end
	if n >= MAX and (last or 0) < MAX and ns.db.comboPulse then bar.pulse:Play() end
	if n < MAX then bar.pulse:Stop() end
	last = n
end

function M:Init()
	bar = CreateFrame("Frame", "ShadowboundComboFrame", UIParent)
	bar:SetSize(MAX * SIZE + (MAX - 1) * GAP, SIZE)
	bar:SetFrameStrata("MEDIUM")
	bar.pips = {}
	for i = 1, MAX do
		local p = bar:CreateTexture(nil, "ARTWORK")
		p:SetTexture(ns.MEDIA .. "ComboPoint")
		p:SetSize(SIZE, SIZE)
		p:SetPoint("LEFT", bar, "LEFT", (i - 1) * (SIZE + GAP), 0)
		bar.pips[i] = p
	end
	-- the pulse: the whole bar swells a little and back, twice
	bar.pulse = bar:CreateAnimationGroup()
	bar.pulse:SetLoopType("NONE")
	for k = 0, 1 do
		local up = bar.pulse:CreateAnimation("Scale")
		up:SetScale(1.15, 1.15); up:SetDuration(0.15); up:SetOrder(2 * k + 1)
		local down = bar.pulse:CreateAnimation("Scale")
		down:SetScale(1 / 1.15, 1 / 1.15); down:SetDuration(0.15); down:SetOrder(2 * k + 2)
	end
	ns.MakeMovable(bar, "cpPoint")
	ns.ApplyPoint(bar, "cpPoint")
	bar:EnableMouse(false)
	bar:Hide()
	local f = CreateFrame("Frame")
	f:RegisterUnitEvent("UNIT_POWER_FREQUENT", "player")
	for _, e in ipairs({ "PLAYER_TARGET_CHANGED", "PLAYER_REGEN_ENABLED", "PLAYER_REGEN_DISABLED",
		"PLAYER_ENTERING_WORLD" }) do f:RegisterEvent(e) end
	f:SetScript("OnEvent", function() M:Update() end)
	M:Update()
end
