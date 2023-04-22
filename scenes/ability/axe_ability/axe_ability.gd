extends Node2D

const MAX_RADIUS = 100

@onready var hitbox_component = $HitboxComponent

var base_rotation = Vector2.RIGHT


func _ready():
	base_rotation = Vector2.RIGHT.rotated(randf_range(0, TAU))
	
	# Make AXE animation
	var tween = create_tween()
	tween.tween_method(tween_method, 0.0, 2.0, 3)
	tween.tween_callback(queue_free)


func tween_method(rotations: float):
	# Make rotation animation for AXE around the player
	var percent = rotations / 2
	# Take radius from 0 to MAX_RADIUS
	var current_radius = percent * MAX_RADIUS
	var current_direction = base_rotation.rotated(rotations * TAU)
	
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	
	# Spawn AXE from player global position
	global_position = player.global_position + (current_direction * current_radius)
