extends CanvasLayer


func _ready():
	get_tree().paused = true
	$%RestartButton.pressed.connect(on_restart_button_pressed)
	$%QuitButton.pressed.connect(on_quit_button_pressed)


func set_defeat():
	$%TitleLabel.text = "Проигрыш"
	$%DescriptionLabel.text = "Вы проиграли!"


func on_restart_button_pressed():
	# Restart the main scene
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")


func on_quit_button_pressed():
	# Quit the game
	get_tree().quit()
