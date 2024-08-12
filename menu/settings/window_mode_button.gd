extends Control


@onready var option_button = $OptionButton as OptionButton


func _ready() -> void:
	add_window_mode_items();
	option_button.select(Global.settings["window_mode"]);


func add_window_mode_items() -> void:
	for window_mode in Global.display_manager.WINDOW_MODE_ARRAY:
		option_button.add_item(tr(window_mode));


func on_window_mode_selected(index : int) -> void:
	Global.display_manager.set_window_mode(index);
