extends CanvasLayer

# Comment to make git recognize the file rename

# Function to return to the main menu screen
func _on_back_pressed() -> void:
	Global.load_save_manager.save_game();
	get_tree().change_scene_to_file("res://menu/menu.tscn");
