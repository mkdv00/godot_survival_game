extends Node

# Init signal for experience vial
signal experience_vial_collected(number: float)
signal ability_upgrades_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary)


func emit_experience_vial_collected(number: float):
	# Emit signal experience_vial_collected
	experience_vial_collected.emit(number)


func emit_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	ability_upgrades_added.emit(upgrade, current_upgrades)
