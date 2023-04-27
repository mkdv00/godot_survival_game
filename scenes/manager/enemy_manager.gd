extends Node

@export var spawn_radius = 380
@export var basic_enemy_scene: PackedScene
@export var wizard_enemy_scene: PackedScene
@export var arena_timer_manager: Node

@onready var timer = $Timer

var base_spawn_time = 0
var enemy_table = WeightedTable.new()


func _ready():
	enemy_table.add_item(basic_enemy_scene, 10)
	base_spawn_time = timer.wait_time
	# Connect time on timeout signal
	timer.timeout.connect(on_timer_timeout)
	arena_timer_manager.arena_dificulty_increased.connect(on_arena_dificulty_increased)


func get_spawn_position():
	# Get first node of player group in main node
	var player = get_tree().get_first_node_in_group("player") as Node2D
	
	# Check that player node is exist in main node
	if player == null:
		return Vector2.ZERO
	
	var spawn_position = Vector2.ZERO
	# Random direction from 0 degrees to 360 degrees (TAU)
	var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	for i in 4:
		# Get random spawn position for the enemy
		spawn_position = player.global_position + (random_direction * spawn_radius)
		var additional_check_offset = random_direction * 20
		
		# Check rectangles in arena for spawn enemies only in arena
		var query_parameters = PhysicsRayQueryParameters2D.create(player.global_position, spawn_position + additional_check_offset, 1)
		var result = get_tree().root.world_2d.direct_space_state.intersect_ray(query_parameters)
	
		if result.is_empty():
			break
		else:
			# Spawn enemies in 90 degres
			random_direction = random_direction.rotated(deg_to_rad(90))
	
	return spawn_position


func on_timer_timeout():
	# Restart timer
	timer.start()
	
	# Get first node of player group in main node
	var player = get_tree().get_first_node_in_group("player") as Node2D
	
	# Check that player node is exist in main node
	if player == null:
		return
	
	var enemy_scene = enemy_table.pick_item()
	var enemy = enemy_scene.instantiate() as Node2D
	
	var enteties_layer = get_tree().get_first_node_in_group("enteties_layer")
	enteties_layer.add_child(enemy)
	enemy.global_position = get_spawn_position()


func on_arena_dificulty_increased(arena_dificulty: int):
	# Add spawn time enemies with arena dificulity
	var time_off = (.1 / 12) * arena_dificulty
	time_off = min(time_off, .7)
	timer.wait_time = base_spawn_time - time_off
	
	if arena_dificulty == 6:
		enemy_table.add_item(wizard_enemy_scene, 20)
