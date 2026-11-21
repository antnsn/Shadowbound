--@moods: none some five nopulse combat always off secret unlocked change warrior
-- the combo point bar: five drops, lit for each point on your target; shown while you have points
-- or are in combat (or always, if picked); a short pulse when you reach 5
local T = dofile(wb.dir .. "/tests/_rogue.lua")
local m = wb.mood
if m == "warrior" then
	wb.state.player.classFile, wb.state.player.class = "WARRIOR", "Warrior"
else
	T.rogue({})
end
local db = {}
if m == "nopulse" then db.comboPulse = false end
if m == "always" then db.comboAlways = true end
if m == "off" then db.comboBar = false end
wb.login({ saved = { ShadowboundDB = db } })
wb.setWeaponEnchant(1800, 7, "main"); wb.setWeaponEnchant(1800, 8, "off") -- the poison cards stay out of the way
local G = wb.G
local points = ({ none = 0, some = 3, five = 5, nopulse = 5, combat = 0, always = 0, off = 3, secret = 0,
	unlocked = 0, change = 0, warrior = 3 })[m]
G.GetComboPoints = function(unit, target)
	if unit ~= "player" or target ~= "target" then return 0 end
	if m == "secret" then return wb.SECRET end
	return points
end
local function Set(n) points = n; wb.fire("UNIT_POWER_FREQUENT", "player", "COMBO_POINTS") end
if m == "combat" then wb.combat(true) end
wb.fire("PLAYER_TARGET_CHANGED")
wb.advance(1)

if m == "warrior" then
	wb.expect("no bar on a warrior", wb.frame("ShadowboundComboFrame"), nil)
	return
end
local bar = wb.frame("ShadowboundComboFrame")
wb.check(bar ~= nil, "the bar exists")
local function Lit()
	local n = 0
	for _, p in ipairs(bar.pips) do if p.lit then n = n + 1 end end
	return n
end
wb.expect("five drops", #bar.pips, 5)
local shown = wb.shown("ShadowboundComboFrame")

if m == "none" then
	wb.expect("no points, out of combat: hidden", shown, false)
elseif m == "some" then
	wb.expect("shown with points", shown, true)
	wb.expect("three lit", Lit(), 3)
	local glows = 0
	for i, p in ipairs(bar.pips) do
		wb.check(p.glow ~= nil, "drop " .. i .. " has a glow")
		if p.glow:IsShown() then glows = glows + 1 end
	end
	wb.expect("a green glow round each lit drop only", glows, 3)
	local c = bar.pips[1].glow.__color or {}
	wb.check((c[2] or 0) > (c[1] or 0) and (c[2] or 0) > (c[3] or 0), "and it is green")
	wb.expect("no pulse below 5", bar.pulse:IsPlaying(), false)
elseif m == "five" then
	wb.expect("all lit", Lit(), 5)
	wb.expect("a pulse at 5", bar.pulse:IsPlaying(), true)
	wb.advance(1)
	wb.expect("a short one: still again after a moment", bar.pulse:IsPlaying(), false)
	wb.expect("still all lit", Lit(), 5)
elseif m == "nopulse" then
	wb.expect("all lit", Lit(), 5)
	wb.expect("no pulse when turned off", bar.pulse:IsPlaying(), false)
elseif m == "combat" then
	wb.expect("shown in combat, even with no points", shown, true)
	wb.expect("none lit", Lit(), 0)
elseif m == "always" then
	wb.expect("shown always when picked", shown, true)
elseif m == "off" then
	wb.expect("hidden when the bar is off", shown, false)
elseif m == "secret" then
	wb.expect("points the addon can't read: hidden", shown, false)
	wb.expect("and no error", #wb.takeErrors(), 0)
elseif m == "unlocked" then
	wb.ns.ToggleMove()
	wb.expect("shown while unlocked, to place it", wb.shown("ShadowboundComboFrame"), true)
	wb.check(Lit() > 0, "with some drops lit, to see its size")
	local moved = false
	for _, mv in ipairs(wb.ns.movers) do if mv.frame == bar then moved = mv.key == "cpPoint" end end
	wb.check(moved, "it can be moved (saved as cpPoint)")
	wb.ns.ToggleMove()
	wb.expect("hidden again once locked", wb.shown("ShadowboundComboFrame"), false)
elseif m == "change" then
	Set(2)
	wb.expect("points come in: shown", wb.shown("ShadowboundComboFrame"), true)
	wb.expect("two lit", Lit(), 2)
	Set(5)
	wb.expect("five lit", Lit(), 5)
	wb.expect("pulse on reaching 5", bar.pulse:IsPlaying(), true)
	bar.pulse:Stop()
	Set(5)
	wb.expect("no second pulse while it stays at 5", bar.pulse:IsPlaying(), false)
	Set(0)
	wb.expect("spent: hidden again", wb.shown("ShadowboundComboFrame"), false)
	Set(5)
	wb.expect("a new 5: a new pulse", bar.pulse:IsPlaying(), true)
end

-- the pulse uses only animation calls the game has (LibBound's cards use them in game):
-- AnimationGroup:SetLoopType and Scale:SetScale don't exist on Forever and broke loading
for _, bad in ipairs({ "AnimGroup:SetLoopType", "Anim:SetScale" }) do
	wb.check(not wb.gaps[bad], "no " .. bad .. " (not in the game)")
end
