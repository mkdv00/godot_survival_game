extends Node

# Chance of dropping a vial
@export_range(0, 1) var drop_percent: float = .6
@export var health_component: Node
@export var vial_scene: PackedScene


func _ready():
	# Connect died method on the died signal
	(health_component as HealthComponent).died.connect(on_died)


func on_died():
	var adjusted_drop_percent = drop_percent
	var experience_gain_upgrade_count = MetaProgression.get_upgrade_count("experience_gain")
	if experience_gain_upgrade_count > 0:
		adjusted_drop_percent += .1
	
	# Check rand float number more then Chance of dropping a vial
	if randf() > adjusted_drop_percent:
		return
	
	if vial_scene == null:
		return
	
	if not owner is Node2D:
		return
	
	# Get spawn position from owner global position
	var spawn_position = (owner as Node2D).global_position
	# Vial instance
	var vial_instance = vial_scene.instantiate() as Node2D
	var enteties_layer = get_tree().get_first_node_in_group("enteties_layer")
	
	# Add vial on the owner scene
	enteties_layer.add_child(vial_instance)
	# Set spawn_position on the vial instance
	vial_instance.global_position = spawn_position
