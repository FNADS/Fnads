# RESOLUTION SIZE AND RESOLUTION SCALING ARE TWO VERY DIFFERENT THINGS, THIS COVERS RESOLUTION SIZE
# This is very specific and will do what you tell it to, but creating save data from it can be an annoyance.
# The easiest way to create save data for this will be through signaling out to a master controller.

extends Control

@onready var option_button = $HBoxContainer/OptionButton as OptionButton

const RESOLUTION_DICTIONARY : Dictionary = {
	"1920 x 1080" : Vector2i(1920, 1080), # Program was natively built for this resolution
	"3840 x 2160" : Vector2i(3840, 2160), # Just gives a lot of blank space
	"1280 x 720" : Vector2i(1280, 720) # Doesn't really work all that well
}

func _ready():
	option_button.item_selected.connect(on_resolution_selected)
	add_resolution_items()	

func add_resolution_items() -> void:
	for resolution_size_text in RESOLUTION_DICTIONARY:
		option_button.add_item(resolution_size_text)

func on_resolution_selected(index : int) -> void:
	DisplayServer.window_set_size(RESOLUTION_DICTIONARY.values()[index]) # This kinda sucks for scaling, match statements would be much better
