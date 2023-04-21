extends CharacterBody2D

@export var max_speed = 40

@onready var health_componet: HealthComponent = $HealthComponent
@onready var visuals = $Visuals


func _process(delta):
	# Get the calculated distance to the player and use the enemy in velocity and apply it
	var direction = get_direction_to_player()
	velocity = direction * max_speed
	move_and_slide()
	
	var move_sign = sign(velocity.x)
	if move_sign != 0:
		visuals.scale = Vector2(-move_sign, 1)


func get_direction_to_player():
	# Get first node of player group in main node
	var player_node = get_tree().get_first_node_in_group("player") as Node2D
	
	# Counting the distance to the player
	if player_node != null:
		return (player_node.global_position - global_position).normalized()
	
	return Vector2.ZERO
