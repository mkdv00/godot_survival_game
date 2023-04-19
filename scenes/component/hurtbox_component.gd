extends Area2D
class_name HurtboxComponent

@export var health_component: Node


func _ready():
	# Connect with on_area_entered signal
	area_entered.connect(on_area_entered)


func on_area_entered(other_area: Area2D):
	
	# Check that other area is a HitboxComponent class name
	if not other_area is HitboxComponent:
		return
	
	# Check that health_component is not none
	if health_component == null:
		return
	
	# Call the damage from the hitbox component
	var hitbox_component = other_area as HitboxComponent
	health_component.damage(hitbox_component.damage)
