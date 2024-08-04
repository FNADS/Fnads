extends CanvasLayer


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://menu/menu.tscn");


func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://menu/settings/options_menu.tscn");


func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://menu/credits/credits.tscn");


func _on_quit_pressed() -> void:
	get_tree().quit();
