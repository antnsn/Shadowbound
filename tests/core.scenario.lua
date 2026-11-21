--@moods: rogue warlock
local T = dofile(wb.dir .. "/tests/_rogue.lua")
if wb.mood == "rogue" then
	T.rogue({ 1856 })
	wb.login()
	wb.advance(7)
	wb.slash("/shadow")
	wb.check(wb.shown("ShadowboundOptions"), "/shadow opens the options")
	local titles = {}
	for _, p in ipairs(wb.ns.optionsState.pages) do titles[#titles + 1] = p.title end
	wb.expect("pages", table.concat(titles, ", "), "Poisons, Reagents, Combo points, Travel, Extras, Skin")
	-- run from git, the version is still the packager's placeholder: show none rather than "v@project-version@"
	local ver = wb.ns.optionsState.version
	wb.check(ver ~= nil, "the header has a version line")
	wb.check(not (ver:GetText() or ""):find("@", 1, true), "no raw version placeholder in the header")
	wb.openGameMenu()
	wb.expect("the travel panel (Hearthstone only) with the menu", wb.shown("ShadowboundTravel"), true)
else
	wb.state.player.classFile, wb.state.player.class = "WARLOCK", "Warlock"
	wb.login()
	wb.slash("/shadow")
	wb.check(wb.printed("only does something on a rogue"), "a warlock is told why")
end
