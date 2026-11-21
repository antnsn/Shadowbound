-- Every plain-word explanation in one place (tooltips show them while "Explain things" is on).
local _, ns = ...
if ns.disabled then return end

ns.Help = {
	mainPoison = "Poison on your main-hand weapon adds its effect to your hits. It lasts 30 minutes or until its charges are used up.",
	offPoison = "Poison on your off-hand weapon adds its effect to your hits. It lasts 30 minutes or until its charges are used up.",
	flash = "Vanish uses one Flash Powder, sold by reagent vendors and poison vendors.",
	blinding = "Blind uses one Blinding Powder. Rogues make it from Fadeleaf with the Poisons skill.",
	poisonStock = "Each poison item coats one weapon once. Rogues make poisons with the Poisons skill; poison vendors sell the vials and reagents.",
}
