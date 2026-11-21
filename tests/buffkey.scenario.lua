--@moods: main off nothing nopoison combat bind
-- the buff key (LibBound): each press does what the top card asks: the main-hand poison first,
-- then the off hand; no group buffs for a rogue
local T = dofile(wb.dir .. "/tests/_rogue.lua")
local m = wb.mood
T.rogue({ 1856 })
local b = wb.state.bags
if m ~= "nopoison" then b[6947] = 5; b[2892] = 5 end
wb.login()
if m == "off" then wb.setWeaponEnchant(1800, 7, "main") end
if m == "nothing" then wb.setWeaponEnchant(1800, 7, "main"); wb.setWeaponEnchant(1800, 8, "off") end
local G = wb.G
local bound = {}
G.SetOverrideBindingClick = function(owner, prio, key, button) bound[key] = button end
G.ClearOverrideBindings = function() bound = {} end
G.UnitCanAssist = function(_, unit) return wb.unit(unit) ~= nil end -- not in the stub
wb.join({ { unit = "party1", name = "Friend", classFile = "WARRIOR" } }) -- nothing to give them
wb.advance(3)
local key = wb.frame("ShadowboundBuffKey")
wb.check(key ~= nil, "the buff key button exists")
local macro = key and key:GetAttribute("macrotext") or ""

if m == "main" then
	wb.expect("the main-hand poison first (the top card)", macro, "/use item:6947\n/use 16")
elseif m == "off" then
	wb.expect("then the off hand", macro, "/use item:2892\n/use 17")
elseif m == "nothing" or m == "nopoison" then
	wb.expect("nothing to do (" .. m .. ")", macro, "")
	key:GetScript("PostClick")(key, "LeftButton", false)
	wb.check(wb.printed("nothing to buff"), "a press says there's nothing to do")
elseif m == "combat" then
	wb.combat(true)
	wb.advance(2)
	wb.check(key:GetAttribute("type") ~= "macro", "the key does nothing in combat")
	wb.combat(false)
	wb.advance(1)
	wb.expect("it works again after the fight", key:GetAttribute("type"), "macro")
	wb.expect("with the poison again", key:GetAttribute("macrotext"), "/use item:6947\n/use 16")
elseif m == "bind" then
	wb.ns.db.buffKey = "F"
	wb.ns.BindBuffKey()
	wb.expect("the key clicks the button", bound.F, "ShadowboundBuffKey")
	wb.ns.db.buffKey = nil
	wb.ns.BindBuffKey()
	wb.expect("and is let go when cleared", bound.F, nil)
end
