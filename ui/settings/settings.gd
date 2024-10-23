extends Control

var ui_manager

func _ready():
	ui_manager = get_tree().get_first_node_in_group('UI')

func _input(_event):
	if Input.is_action_just_pressed("ui_cancel") and get_tree().get_first_node_in_group('Game') != null:
		ui_manager.toggle_settings()

func quit_game():
	get_tree().quit()

func resume():
	ui_manager.toggle_settings()
