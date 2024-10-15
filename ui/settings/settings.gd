extends Control

func _input(_event):
	if Input.is_action_just_pressed("ui_cancel") and get_tree().get_first_node_in_group('Game') != null:
		UIManager.toggle_settings()

func quit_game():
	get_tree().quit()

func resume():
	UIManager.toggle_settings()
