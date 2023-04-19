extends Node

@export var max_range: float
@export var sword_ability: PackedScene
var damage = 5


func _ready():
	# Connect Timer with timeout on_timer_timeout 
	$Timer.timeout.connect(on_timer_timeout)


func on_timer_timeout():
	"""
	A function that is called when the timer ends.
	Todo: attacking an enemy with a sword ability
	"""
	# Get groups of enemies and a player
	var player = get_tree().get_first_node_in_group("player") as Node2D
	
	if player == null:
		return
	
	var enemies = get_tree().get_nodes_in_group("enemy")
	
	# Filtering enemies that are further than {max_range} from the player
	# We get the distance squared from the enemy to the player
	# and check with the permissible distance squared
	enemies = enemies.filter(func(enemy: Node2D):
		return enemy.global_position.distance_squared_to(player.global_position) < pow(max_range, 2)
	)
	
	# We do not return anything if the enemies are missing in the scene tree
	if enemies.size() == 0:
		return
	
	# Sort by enemy so that enemy A is closer to the player than enemy B. 
	# That is, we sort the enemy A first
	enemies.sort_custom(func(a: Node2D, b: Node2D):
		var a_distance = a.global_position.distance_squared_to(player.global_position)
		var b_distance = b.global_position.distance_squared_to(player.global_position)
		return a_distance < b_distance
	)
	
	# Creating a sword object
	var sword_instance = sword_ability.instantiate() as SwordAbility
	player.get_parent().add_child(sword_instance)
	sword_instance.hitbox_component.damage = damage
	
	sword_instance.global_position = enemies[0].global_position
	sword_instance.global_position += Vector2.RIGHT.rotated(randf_range(0, TAU)) * 4
	
	# Get angle from enemy direction and sword direction
	var enemy_direction = enemies[0].global_position - sword_instance.global_position
	# Set the angle to the sword rotation
	sword_instance.rotation = enemy_direction.angle()