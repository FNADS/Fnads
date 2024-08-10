extends Control

var popup_popped_up:= false

func _ready() -> void:
	Splash.connect("on_transition_finished", Callable(self, "_on_splash_finished"))
	if Global.is_splash_screen_enabled:
		Splash.transition()
	else:
		emit_signal("on_transition_finished")
		Global.splash_has_played = true
	DisplayServer.window_set_min_size(Vector2i(1280,720))

func _process(delta):
	var current_res:= DisplayServer.screen_get_size()
	if current_res < Vector2i(1280,720) && !popup_popped_up:
		$ConfirmationDialog.show()
	if current_res >= Vector2i(1280,720):
		$ConfirmationDialog.hide()
	$Background.set_size(DisplayServer.window_get_size() * 2)

func _on_splash_finished():
	print("Splash finished")
# Perform any additional setup needed after the splash screen finishes

func _on_play_pressed():
	get_tree().change_scene_to_file("res://menu/level_select_screen.tscn")


func _on_settings_pressed():
	get_tree().change_scene_to_file("res://menu/settings/options_menu.tscn")


func _on_credits_pressed():
	get_tree().change_scene_to_file("res://menu/credits/credits.tscn")


func _on_quit_pressed():
	DisplayServer.window_set_title(". . .noos uoy eeS")
	get_tree().quit()


func _on_confirmation_dialog_confirmed():
	get_tree().quit()


func _on_confirmation_dialog_canceled():
	popup_popped_up = true
