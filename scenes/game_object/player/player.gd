extends CharacterBody2D

# Max speed of the player
@export var max_speed = 125

@onready var damage_interval_timer = $DamageIntervalTimer

# Smooth the player movement
const ACCELERATION_SMOOTHING = 25

var number_colliding_bodies = 0


func _ready():
	$CollisionArea2D.body_entered.connect(on_body_entered)
	$CollisionArea2D.body_exited.connect(on_body_exited)
	
	damage_interval_timer.timeout.connect(on_damage_interval_timer_timeout)


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


func check_deal_damage():
	if number_colliding_bodies == 0 or !damage_interval_timer.is_stopped():
		return
	
	$HealthComponent.damage(1)
	damage_interval_timer.start()
	


func on_body_entered(other_body: Node2D):
	number_colliding_bodies += 1
	check_deal_damage()


func on_body_exited(other_body: Node2D):
	number_colliding_bodies -= 1


func on_damage_interval_timer_timeout():
	check_deal_damage()
