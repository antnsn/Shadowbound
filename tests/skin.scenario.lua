--@moods: shadow blizzard flat
local T = dofile(wb.dir .. "/tests/_rogue.lua")
T.rogue({})
wb.state.bags[6947] = 5
wb.login({ saved = { ShadowboundDB = { skin = wb.mood } } })
wb.advance(7)
local want = ({ shadow = "Shadow", blizzard = "Blizzard", flat = "Flat" })[wb.mood]
wb.expect("active skin", wb.ns.UI.Active().name, want)
wb.check(wb.shown("ShadowboundMainHandFrame"), "a card builds in this skin")
wb.slash("/shadow")
wb.check(wb.shown("ShadowboundOptions"), "the options build in this skin")
