--@moods: none flash noblind blind both poisons enough off nopoisons
-- powders only once the spell is known, each at its own warn-at; the picked poisons while you carry any
local T = dofile(wb.dir .. "/tests/_rogue.lua")
local m = wb.mood
local known = ({ none = {}, flash = { 1856 }, noblind = { 1856 }, blind = { 2094 }, both = { 1856, 1857, 2094 },
	poisons = {}, enough = { 1856, 2094 }, off = { 1856, 2094 }, nopoisons = {} })[m]
T.rogue(known)
local b = wb.state.bags
b[6947], b[2892] = 20, 20 -- plenty of Instant and Deadly Poison
if m == "none" then b[5140] = 0; b[5530] = 0 end -- powders don't matter without Vanish or Blind
if m == "flash" then b[5140] = 2 end
if m == "noblind" then b[5140] = 20; b[5530] = 0 end -- Blind not known: no Blinding Powder warning
if m == "blind" then b[5530] = 3 end
if m == "both" then b[5140] = 1; b[5530] = 0 end
if m == "poisons" then b[6947] = 2; b[6949] = 1; b[2892] = 9 end -- Instant: 3 over two ranks
if m == "enough" then b[5140] = 20; b[5530] = 20 end
if m == "nopoisons" then b[6947], b[2892] = nil, nil end -- no poison at all: no poison warning
local db = {}
if m == "off" then db.flash = false; db.blinding = false; db.poisonStock = false end
wb.login({ saved = { ShadowboundDB = db } })
wb.setWeaponEnchant(1800, 7, "main"); wb.setWeaponEnchant(1800, 8, "off") -- the poison cards stay out of the way
wb.advance(3)
local card = wb.frame("ShadowboundReagentsFrame")
local shown = wb.shown("ShadowboundReagentsFrame")
if m == "none" or m == "noblind" or m == "enough" or m == "off" or m == "nopoisons" then
	wb.expect("no reagent card", shown, false)
else
	wb.expect("reagent card", shown, true)
	local want = ({ flash = "Flash Powder 2", blind = "Blinding Powder 3", both = "Flash Powder 1 · Blinding Powder 0",
		poisons = "Instant Poison 3" })[m]
	wb.expect("says what runs low", card.statusText:GetText(), want)
end
if m == "both" then
	wb.expect("a wider card", card:GetWidth(), 320)
	wb.ns.db.flashLow = 0
	wb.ns.db.blindingLow = 0
	wb.ns.Refresh()
	wb.expect("warn-at lowered: only the empty one", card.statusText:GetText(), "Blinding Powder 0")
end
