extends Node

@export var upgrade_pool: Array[AbilityUpgrade]
@export var experience_manager: Node
@export var upgrade_screen_scene: PackedScene

var current_upgrades = {}


func _ready():
	experience_manager.level_up.connect(on_level_up)


func on_level_up(current_level: int):
	# Get random Upgrade
	var chosen_upgrade = upgrade_pool.pick_random() as AbilityUpgrade
	
	if chosen_upgrade == null:
		return
	
	# Create new upgrade scene card
	var upgrade_scene_instance = upgrade_screen_scene.instantiate()
	add_child(upgrade_scene_instance)
	upgrade_scene_instance.set_ability_upgrades([chosen_upgrade] as Array[AbilityUpgrade])
	upgrade_scene_instance.upgrade_selected.connect(on_upgrade_selected)


func apply_upgrade(upgrade: AbilityUpgrade):
	# Check that Upgrade in the current_upgrades by id
	var has_upgrade = current_upgrades.has(upgrade.id)
	# If there is no Upgrade we add new Update to the current_upgrades
	if !has_upgrade:
		current_upgrades[upgrade.id] = {
			"resource": upgrade,
			"quantity": 1
		}
	else:
		# If there is the Upgrade we add quantity of the Upgrade
		current_upgrades[upgrade.id]["quantity"] += 1
	
	# Add ability upgrade
	GameEvents.emit_ability_upgrade_added(upgrade, current_upgrades)


func on_upgrade_selected(upgrade: AbilityUpgrade):
	apply_upgrade(upgrade)
