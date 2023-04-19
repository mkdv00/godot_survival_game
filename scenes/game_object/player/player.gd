extends CharacterBody2D

# Max speed of the player
@export var max_speed = 125

# Smooth the player movement
const ACCELERATION_SMOOTHING = 25


func _ready():
	pass # Replace with function body.


func _process(delta):
	# Get a vector and normalize it
	var movement_vector = get_movement_vector()
	var direction = movement_vector.normalized()
	# Add the resulting vector
	var target_velocity = direction * max_speed
	
	# Add linear interpolation to the player movement
	velocity = velocity.lerp(target_velocity, 1 - exp(-delta * ACCELERATION_SMOOTHING))
	
	# Apply velocity
	move_and_slide()


func get_movement_vector():
	# Get the vector direction of the player and return the resulting vector
	var x_movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_movement = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	return Vector2(x_movement, y_movement)
