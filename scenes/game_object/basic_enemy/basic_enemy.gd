extends CharacterBody2D

@onready var visuals = $Visuals
@onready var velocity_component = $VelocityComponent


func _process(delta):
	velocity_component.accelerate_to_player()
	velocity_component.move(self)
	
	# Flip enemy to the player
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
