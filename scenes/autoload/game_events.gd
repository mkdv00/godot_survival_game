extends Node

# Init signal for experience vial
signal experience_vial_collected(number: float)


func emit_experience_vial_collected(number: float):
	# Emit signal experience_vial_collected
	experience_vial_collected.emit(number)
