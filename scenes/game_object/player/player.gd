extends CharacterBody2D

# Max speed of the player
@export var max_speed = 125

@onready var damage_interval_timer = $DamageIntervalTimer
@onready var health_component = $HealthComponent
@onready var health_bar = $HealthBar
@onready var abiliteis = $Abilities

# Smooth the player movement
const ACCELERATION_SMOOTHING = 25

var number_colliding_bodies = 0


func _ready():
	$CollisionArea2D.body_entered.connect(on_body_entered)
	$CollisionArea2D.body_exited.connect(on_body_exited)
	
	damage_interval_timer.timeout.connect(on_damage_interval_timer_timeout)
	health_component.health_changed.connect(on_health_changed)
	
	GameEvents.ability_upgrades_added.connect(on_ability_upgrade_added)
	
	update_health_display()


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
	
	health_component.damage(1)
	damage_interval_timer.start()


func update_health_display():
	health_bar.value = health_component.get_health_percent()


func on_body_entered(other_body: Node2D):
	number_colliding_bodies += 1
	check_deal_damage()


func on_body_exited(other_body: Node2D):
	number_colliding_bodies -= 1


func on_damage_interval_timer_timeout():
	check_deal_damage()


func on_health_changed():
	update_health_display()


func on_ability_upgrade_added(ability_upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	if not ability_upgrade is Ability:
		return
	
	var ability = ability_upgrade as Ability
	abiliteis.add_child(ability.ability_controller_scene.instantiate())
