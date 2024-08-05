extends Node


var load_save_manager : LoadSaveManager = preload("res://manager/load_save_manager.gd").new();
var display_manager : DisplayManager = preload("res://manager/display_manager.gd").new();


var settings : Dictionary;
var game_state : Dictionary;


func _ready() -> void:
	# Tries to load last save or initializes all necessary values and saves them if there are none
	if (!load_save_manager.load_game()):
		init_default_settings();
		init_default_game_state();
		load_save_manager.save_game();
		
	
## Sets the settings dict to the default values
func init_default_settings() -> void:
	var default_settings : Dictionary = {
		"show_splash_screen": true,
		"window_mode": 1,
		"resolution": 0,
		"volume": [],
	}
	for i in AudioServer.bus_count:
		default_settings["volume"].append(1);
	
	settings = default_settings;

## Sets the game_state dict to the default values
func init_default_game_state():
	game_state = {};
