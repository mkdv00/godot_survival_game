extends Node

# Raduis to spawn enemies
@export var spawn_radius = 380
# Basic enemy scene
@export var basic_enemy_scene: PackedScene


func _ready():
	# Connect time on timeout signal
	$Timer.timeout.connect(on_timer_timeout)


func on_timer_timeout():
	# Get first node of player group in main node
	var player = get_tree().get_first_node_in_group("player") as Node2D
	
	# Check that player node is exist in main node
	if player == null:
		return
	
	# Random direction from 0 degrees to 360 degrees (TAU)
	var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	# Get random spawn position for the enemy
	var spawn_position = player.global_position + (random_direction * spawn_radius)
	
	# Create enemy instance and add to the EnemyManager node
	var enemy = basic_enemy_scene.instantiate() as Node2D
	get_parent().add_child(enemy)
	enemy.global_position = spawn_position
