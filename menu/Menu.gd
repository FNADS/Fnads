extends CanvasLayer

func _on_splash_finished():
	print("Splash finished")
# Perform any additional setup needed after the splash screen finishes

func _on_play_pressed():
	get_tree().change_scene_to_file("res://menu/Menu.tscn")


func _on_settings_pressed():
	get_tree().change_scene_to_file("res://menu/settings/Options_Menu.tscn")


func _on_credits_pressed():
	get_tree().change_scene_to_file("res://menu/credits/credits.tscn")


func _on_quit_pressed():
	get_tree().quit()
