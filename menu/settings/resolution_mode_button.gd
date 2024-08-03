# RESOLUTION SIZE AND RESOLUTION SCALING ARE TWO VERY DIFFERENT THINGS, THIS COVERS RESOLUTION SIZE
# This is very specific and will do what you tell it to, but creating save data from it can be an annoyance.
# The easiest way to create save data for this will be through signaling out to a master controller.

extends Control

@onready var option_button = $HBoxContainer/OptionButton as OptionButton

func _ready() -> void:
	add_resolution_items();
	option_button.select(Global.settings["resolution"]);
	option_button.item_selected.connect(on_resolution_selected)


func add_resolution_items() -> void:
	for resolution_size in Global.display_manager.RESOLUTION_ARRAY:
		option_button.add_item("%d x %d" % [resolution_size.x, resolution_size.y]);


func on_resolution_selected(index : int) -> void:
	Global.display_manager.set_window_resolution(index); # This kinda sucks for scaling, match statements would be much better
