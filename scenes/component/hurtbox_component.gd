extends Area2D
class_name HurtboxComponent

@export var health_component: Node

var floating_text_scene = preload("res://scenes/ui/floating_text.tscn")


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
	
	# Spawn floating damage text
	var floating_text = floating_text_scene.instantiate() as Node2D
	get_tree().get_first_node_in_group("foreground_layer").add_child(floating_text)
	
	floating_text.global_position = global_position + (Vector2.UP * 16)
	floating_text.start(str(hitbox_component.damage))
