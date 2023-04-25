extends CanvasLayer


func _ready():
	$%PlayButton.pressed.connect(on_play_button)
	$%OptionsButton.pressed.connect(on_options_button)
	$%QuitButton.pressed.connect(on_quit_button)


func on_play_button():
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")


func on_options_button():
	pass


func on_quit_button():
	get_tree().quit()
