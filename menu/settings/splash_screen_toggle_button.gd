extends CheckBox


func _ready() -> void:
	button_pressed = Global.settings["show_splash_screen"];


func _on_check_box_toggled(toggled_on: bool) -> void:
	Global.settings["show_splash_screen"] = toggled_on;
