extends Node2D


func _ready():
	# Connect signal on the on_area_entered
	$Area2D.area_entered.connect(on_area_entered)


func on_area_entered(other_area: Area2D):
	# Increment experience
	GameEvents.emit_experience_vial_collected(1)
	# Delete Experience Vial object
	queue_free()
