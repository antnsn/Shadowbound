--@moods: api manual nolock
-- The lockbox service (LibBound Service.lua): {skill} from the game, or typed in when it gives 0.
local T = dofile(wb.dir .. "/tests/_rogue.lua")
local m = wb.mood
T.rogue({ 1804 })
wb.state.spells[1804] = "Pick Lock"
if m == "nolock" then wb.state.known[1804] = false else wb.state.known[1804] = nil end
wb.login()
wb.advance(2)
local G = wb.G
rawset(G, "GetChannelList", function() return 2, "Trade - City", false end)
rawset(G, "C_TradeSkillUI", { GetProfessionInfoBySkillLineID = function(id)
	if id ~= 633 then return nil end
	return { professionName = "Lockpicking", skillLevel = m == "api" and 75 or 0, maxSkillLevel = m == "api" and 80 or 0 }
end })
local function Posts()
	local out = {}
	for _, c in ipairs(wb.chat) do if c.kind == "CHANNEL" then out[#out + 1] = c.msg end end
	return out
end
local function Lines() local n = 0 for _, l in ipairs(wb.log) do if l:find("[Invite]", 1, true) then n = n + 1 end end return n end
local function Trade(text, who) wb.fire("CHAT_MSG_CHANNEL", text, who, "", "2. Trade - City", "", "", 2, 2, "Trade - City") end
local db = wb.saved("ShadowboundDB")

if m == "nolock" then
	wb.slash("/shadow announce")
	wb.check(wb.printed("can't pick locks yet"), "no Pick Lock: says why")
	wb.expect("no Pick Lock: nothing posted", #Posts(), 0)
	Trade("anyone open lockbox?", "Thrall")
	wb.expect("no Pick Lock: no alerts", Lines(), 0)
	return
end
if m == "manual" then db.serviceSkill = 70 end
wb.slash("/shadow announce")
wb.expect("filled with the skill", Posts()[1],
	("Lockpicking %d: opening lockboxes! Whisper me, tips welcome"):format(m == "api" and 75 or 70))

Trade("anyone open lockbox?", "Thrall")
wb.expect("a request: a line", Lines(), 1)
Trade("WTS lockbox opening, tips", "Valeera")
wb.expect("a rival's ad: no line", Lines(), 1)
Trade("wtb open |cff1eff00|Hitem:4632::::::::20:::::::|h[Ornate Bronze Lockbox]|h|r", "Garona")
wb.expect("a linked lockbox: a line", Lines(), 2)

wb.slash("/shadow")
local titles = {}
for _, p in ipairs(wb.ns.optionsState.pages) do titles[#titles + 1] = p.title end
wb.check(table.concat(titles, ", "):find("Lockbox service", 1, true), "the Lockbox service page")
