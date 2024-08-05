extends Control


@onready var option_button = $HBoxContainer/OptionButton as OptionButton

func _ready() -> void:
	add_window_mode_items();
	option_button.select(Global.settings["window_mode"]);
<<<<<<< HEAD
	option_button.item_selected.connect(on_window_mode_selected);
=======
>>>>>>> 9276dc2cb6eb348ad467a4d7080d00437785b8c1


func add_window_mode_items() -> void:
	for window_mode in Global.display_manager.WINDOW_MODE_ARRAY:
		option_button.add_item(window_mode);


func on_window_mode_selected(index : int) -> void:
	Global.display_manager.set_window_mode(index);
