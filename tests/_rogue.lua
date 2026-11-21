-- shared setup: a rogue with the given spells known and a dagger in each hand (loaded with dofile)
local M = {}
local NAMES = {
	[1856] = "Vanish", [1857] = "Vanish", [2094] = "Blind", [429959] = "Well-Rested",
}
function M.rogue(known)
	local s = wb.state
	s.player.classFile, s.player.class, s.player.classId = "ROGUE", "Rogue", 4
	for id, n in pairs(NAMES) do s.spells[id] = n; s.known[id] = false end
	for _, id in ipairs(known or {}) do s.known[id] = nil end
	s.known[429959] = nil
	s.slots[16], s.slots[17] = 2092, 2092 -- a Worn Dagger in each hand
	s.items[2092] = { name = "Worn Dagger", classID = 2, equipLoc = "INVTYPE_WEAPON" }
end
function M.macroFor(text)
	for _, f in ipairs(wb.frames()) do
		local m = f:GetAttribute("macrotext")
		if m and f.__shown and m:find(text, 1, true) then return f end
	end
end
return M
