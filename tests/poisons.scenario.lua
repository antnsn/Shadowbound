--@moods: fresh missing bestrank choice nochosen fallback poisoned expiring nooff heldoff off combat
-- one poison card per hand: shown when the weapon has no poison (or it runs out soon), a click
-- applies the picked poison from the bags, best rank carried; quiet before you carry any poison
local T = dofile(wb.dir .. "/tests/_rogue.lua")
local m = wb.mood
T.rogue({})
local s, b = wb.state, wb.state.bags
if m ~= "fresh" then b[6947] = 4; b[2892] = 4 end -- Instant Poison, Deadly Poison
if m == "bestrank" then b[6950] = 2; b[2893] = 1 end -- Instant Poison III, Deadly Poison II
if m == "fallback" then b[6947] = nil; b[2892] = nil; b[3775] = 3 end -- only Crippling Poison
if m == "nooff" then s.slots[17] = nil end
if m == "heldoff" then s.slots[17] = 7608; s.items[7608] = { name = "Seer's Fine Stein", classID = 4 } end
local db = {}
if m == "choice" then db.mainChoice = "Crippling"; db.offChoice = "Instant"; b[3776] = 2 end
if m == "nochosen" then db.offChoice = "Wound" end
if m == "off" then db.offPoison = false end
wb.login({ saved = { ShadowboundDB = db } })
if m == "poisoned" then wb.setWeaponEnchant(1800, 7, "main"); wb.setWeaponEnchant(1800, 8, "off") end
if m == "expiring" then wb.setWeaponEnchant(60, 7, "main"); wb.setWeaponEnchant(1800, 8, "off") end
wb.advance(3)
local mh, oh = wb.shown("ShadowboundMainHandFrame"), wb.shown("ShadowboundOffHandFrame")
local function status(frame) return wb.frame(frame).statusText:GetText() or "" end

if m == "fresh" then
	wb.expect("no poison in the bags yet: no main-hand card", mh, false)
	wb.expect("and no off-hand card", oh, false)
elseif m == "poisoned" then
	wb.expect("main hand poisoned: no card", mh, false)
	wb.expect("off hand poisoned: no card", oh, false)
elseif m == "expiring" then
	wb.expect("main hand runs out soon: card", mh, true)
	wb.check(status("ShadowboundMainHandFrame"):find("left: Instant Poison", 1, true), "time left and the poison")
	wb.expect("off hand has plenty: no card", oh, false)
else
	wb.expect("main-hand card", mh, true)
	wb.expect("titled", wb.frame("ShadowboundMainHandFrame").titleText:GetText(), "Main-hand poison")
	local main = ({ bestrank = { 6950, "Instant Poison III" }, choice = { 3776, "Crippling Poison II" },
		fallback = { 3775, "Crippling Poison" } })[m] or { 6947, "Instant Poison" }
	local id, name = main[1], main[2]
	wb.expect("status names the poison", status("ShadowboundMainHandFrame"), "Missing: " .. name)
	wb.expect("a card wide enough for the longest poison name", wb.frame("ShadowboundMainHandFrame"):GetWidth(), 300)
	wb.check(T.macroFor("/use item:" .. id .. "\n/use 16"), "a click applies it to the main hand (16)")
	if m == "nooff" or m == "heldoff" then
		wb.expect("no off-hand weapon: no off-hand card", oh, false)
	elseif m == "off" then
		wb.expect("off-hand card turned off", oh, false)
	elseif m == "nochosen" then
		wb.expect("off-hand card", oh, true)
		wb.expect("says the picked poison is missing", status("ShadowboundOffHandFrame"), "No Wound Poison in your bags")
		wb.check(not T.macroFor("/use 17"), "and offers no click")
	else
		wb.expect("off-hand card", oh, true)
		wb.expect("titled", wb.frame("ShadowboundOffHandFrame").titleText:GetText(), "Off-hand poison")
		local off = ({ bestrank = { 2893, "Deadly Poison II" }, choice = { 6947, "Instant Poison" },
			fallback = { 3775, "Crippling Poison" } })[m] or { 2892, "Deadly Poison" }
		local offId, offName = off[1], off[2]
		wb.expect("off-hand status", status("ShadowboundOffHandFrame"), "Missing: " .. offName)
		wb.check(T.macroFor("/use item:" .. offId .. "\n/use 17"), "a click applies it to the off hand (17)")
	end
	if m == "combat" then
		wb.combat(true)
		wb.advance(1)
		wb.expect("quiet in combat", wb.shown("ShadowboundMainHandFrame") or wb.shown("ShadowboundOffHandFrame"), false)
		wb.combat(false)
		wb.advance(1)
		wb.expect("back after", wb.shown("ShadowboundMainHandFrame"), true)
		wb.check(T.macroFor("/use 16"), "clickable again after combat")
	end
	if m == "missing" then
		-- applied: the card goes away
		wb.setWeaponEnchant(1800, 7, "main")
		wb.advance(1)
		wb.expect("gone once the poison is on", wb.shown("ShadowboundMainHandFrame"), false)
		wb.expect("the off hand still asks", wb.shown("ShadowboundOffHandFrame"), true)
	end
end
