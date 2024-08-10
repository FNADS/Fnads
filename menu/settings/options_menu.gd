extends Control

# Function to return to the main menu screen
func _on_back_pressed():
	get_tree().change_scene_to_file("res://menu/menu.tscn")
func _process(_delta):
	$Background.set_size(DisplayServer.window_get_size() * 2)
