extends Camera2D


func _ready():
	# Make the camera as current camera
	make_current()


func _process(delta):
	var target_vector = acquire_target()
	# Use lerp to move the camera smoothly
	global_position = global_position.lerp(target_vector, 1.0 - exp(-delta * 20))


func acquire_target():
	# Get first node of player group in main node
	var player_nodes = get_tree().get_nodes_in_group("player")
	
	# Check that player node is exist in main node
	if player_nodes.size() == 0:
		return null
	
	# Calculating the position of the target (Player)
	var player = player_nodes[0] as Node2D
	var target_position = player.global_position
	
	return target_position
