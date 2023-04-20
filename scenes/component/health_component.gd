extends Node
class_name HealthComponent

# Make the signal
signal died
signal health_changed

@export var max_health: float = 10
var current_health


func _ready():
	# Set current health
	current_health = max_health


func damage(damage_amount: float):
	# Make the limit of health not less than 0
	current_health = max(current_health - damage_amount, 0)
	#Call health_chaged signal when we take the damage
	health_changed.emit()
	# Call check_death in deferred mode, i.e. during the idle frame
	Callable(check_death).call_deferred()


func get_health_percent():
	# Return current health in percent
	if max_health <= 0:
		return 0
	
	return min(current_health / max_health, 1)


func check_death():
	# Check health to death
	if current_health == 0:
		# Emit the death signal
		died.emit()
		# Delete owner node from memory and the scene
		owner.queue_free()
