extends Node

## The main manager node for the whole game. It handles often used functions and holds references to other scripts that also need to be accessed gloably but don't fit in the global script directly

enum room_mapping {
	ART,
	C1,
	C2,
	C3,
	C4,
	CAFE,
	HALL1,
	HALL2,
	HALL3,
	GYM,
	JC,
	VENT,
	STAFF,
	BATHROOM,
	KITCHEN
}


var settings: Dictionary;
var game_state: Dictionary;
var load_save_manager: LoadSaveManager = preload("res://manager/load_save_manager.gd").new();
var display_manager: DisplayManager = preload("res://manager/display_manager.gd").new();
var time_manager: TimeManager = preload("res://manager/time_manager.gd").new();
var ai_manager: AIManager = preload("res://manager/ai_manager.gd").new();
var cursor: Cursor = preload("res://cusrom_resources/cursor.gd").new(preload("res://assets/cursor.png"), [Vector2(0,0), Vector2(16,16), Vector2(16,16)]);


func _ready() -> void:
	display_manager.adjust_max_fps();
	# Tries to load last save or initializes all necessary values and saves them if there are none
	if (!load_save_manager.load_game()):
		init_default_settings();
		init_default_game_state();
		load_save_manager.save_game();


func _process(delta) -> void:
	time_manager.process(delta);


## Sets the settings dict to the default values
func init_default_settings() -> void:
	var default_settings: Dictionary = {
		"show_splash_screen": true,
		"window_mode": 1,
		"volume": [],
	}
	for i in AudioServer.bus_count:
		print(i);
		default_settings["volume"].append(1);
	
	settings = default_settings;


## Sets the game_state dict to the default values
func init_default_game_state():
	game_state = {
		"unlocked_nights": 1, 
	};
