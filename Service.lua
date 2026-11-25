-- The lockbox service (LibBound Service.lua): announce lockbox opening in Trade with your
-- Lockpicking skill, and an alert with [Invite]/[Whisper] when someone asks ("anyone open lockbox?").
local _, ns = ...
if ns.disabled then return end
local Bound = LibStub("LibBound-1.0")

local PICK_LOCK, LOCKPICKING = 1804, 633 -- the spell, and the Lockpicking skill line

-- the Lockpicking skill from the game; when it says 0 (seen on Forever before the skill is learned),
-- the number typed on the options page
local function Skill()
	local get = C_TradeSkillUI and C_TradeSkillUI.GetProfessionInfoBySkillLineID
	if get then
		local ok, info = pcall(get, LOCKPICKING)
		local v = ok and type(info) == "table" and info.skillLevel
		if type(v) == "number" and not ns.IsSecret(v) and v > 0 then return v end
	end
	return ns.db and ns.db.serviceSkill or nil
end
ns.LockpickingSkill = Skill

Bound.InstallService(ns, {
	label = "Lockboxes",
	page = "Lockbox service",
	example = "Lockpicking {skill}: opening lockboxes! Whisper me, tips welcome",
	reply = "Hi {name}! Trade me the box, I'm in {zone}.",
	keywords = { "lockbox", "lockboxes", "junkbox", "junkboxes", "lockpick", "lockpicking", "open box" },
	available = function()
		local ok, k = pcall(IsPlayerSpell, PICK_LOCK)
		return ok and not ns.IsSecret(k) and k and true or false
	end,
	unavailable = "You can't pick locks yet (Pick Lock at level 16).",
	fill = { skill = Skill },
	skillField = true,
	help = ns.Help.service,
})
