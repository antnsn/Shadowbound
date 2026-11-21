-- The combo point bar: five drops (Marius' painted art), one lit with a green glow for each combo
-- point on your target, greyed out for the rest. Shown while you have points or are in combat (or
-- always, if picked), with a few quick flashes when you reach 5. Movable and resizable like the cards.
-- Points the addon can't read (a secret value) hide the bar rather than show a wrong count.
local _, ns = ...
if ns.disabled then return end

local MAX, SIZE, GAP = 5, 30, 4
local DIM = { 0.30, 0.30, 0.30, 0.55 }
local GLOW = { 0.30, 1, 0.30, 0.85 } -- the green glow round a lit drop

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
local bar, last, pulses = nil, nil, 0

local function Light(n)
	for i, p in ipairs(bar.pips) do
		p.lit = i <= n
		p.glow:SetShown(p.lit)
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
	if n >= MAX and (last or 0) < MAX and ns.db.comboPulse then
		bar.pulse:Play()
		pulses = pulses + 1
		local mine = pulses
		C_Timer.After(1.2, function() if pulses == mine then bar.pulse:Stop() end end) -- three flashes, then still
	end
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
		-- the glow: the drop's shape grown and blurred (Media/ComboGlow), added behind it
		local g = bar:CreateTexture(nil, "BACKGROUND")
		g:SetTexture(ns.MEDIA .. "ComboGlow")
		g:SetSize(SIZE / 0.6, SIZE / 0.6) -- the drop fills 3/5 of the glow texture
		g:SetPoint("CENTER", p, "CENTER")
		g:SetBlendMode("ADD")
		g:SetVertexColor(GLOW[1], GLOW[2], GLOW[3], GLOW[4])
		g:Hide()
		p.glow = g
		bar.pips[i] = p
	end
	-- the pulse: the drops flash bright and dim a few times (only animation calls LibBound's cards
	-- already use in game; Forever has no AnimationGroup:SetLoopType)
	bar.pulse = bar:CreateAnimationGroup()
	bar.pulse:SetLooping("BOUNCE")
	local a = bar.pulse:CreateAnimation("Alpha")
	a:SetFromAlpha(1); a:SetToAlpha(0.35); a:SetDuration(0.2); a:SetSmoothing("IN_OUT")
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
