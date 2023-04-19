extends CanvasLayer

@export var arena_time_manager: Node
@onready var label = $%Label


func _process(delta):
	# Check arena_timer_manager in the main scene
	if arena_time_manager == null:
		return
	
	# Wait time - Time left
	var time_elapsed = arena_time_manager.get_time_elapsed()
	# Time in string
	label.text = format_seconds_to_string(time_elapsed)


func format_seconds_to_string(seconds: float):
	# Minutes from the seconds
	var minutes = floor(seconds / 60)
	# Remaining seconds from the minutes
	var remaining_seconds = seconds - (minutes * 60)
	
	return str(minutes) + ":" + ("%02d" % floor(remaining_seconds))
