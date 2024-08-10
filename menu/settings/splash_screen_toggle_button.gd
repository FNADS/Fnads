extends Control


func _ready():
	$HBoxContainer/CheckBox.button_pressed = Global.is_splash_screen_enabled

func _on_check_box_toggled(toggled_on):
	Global.is_splash_screen_enabled = toggled_on
