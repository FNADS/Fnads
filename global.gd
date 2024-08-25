extends Node

## The main manager node for the whole game. It handles often used functions and holds references to other scripts that also need to be accessed gloably but don't fit in the global script directly

enum room_mapping {
	OFFICE = 0,
	STAFF = 1,
	BATHROOM = 2,
	JC = 3,
	ART = 4,
	CAFE = 5,
	KITCHEN = 6,
	GYM = 7,
	C1 = 8,
	C2 = 9,
	C3 = 10,
	C4 = 11,
	HALL1 = 12,
	HALL2 = 13,
	HALL3 = 14,
	VENT = 15,
};


enum vent_mappings {
	#TODO add vent mappings
};


const room_connections: Dictionary = {
	"OFFICE" : [room_mapping.HALL3],
	"STAFF" : [room_mapping.HALL3],
	"BATHROOM" : [room_mapping.HALL3],
	"JC" : [room_mapping.HALL3],
	"ART" : [room_mapping.HALL3],
	"CAFE" : [
		room_mapping.KITCHEN,
		room_mapping.HALL2
	],
	"KITCHEN" : [room_mapping.CAFE],
	"GYM" : [
		room_mapping.HALL1,
		room_mapping.HALL3
	],
	"C1" : [room_mapping.HALL1],
	"C2" : [room_mapping.HALL1],
	"C3" : [room_mapping.HALL3],
	"C4" : [room_mapping.HALL3],
	"HALL1" : [
		room_mapping.HALL2,
		room_mapping.C1,
		room_mapping.C2,
		room_mapping.GYM
	],
	"HALL2" : [
		room_mapping.HALL1,
		room_mapping.HALL3,
		room_mapping.CAFE,
	],
	"HALL3" : [
		room_mapping.ART,
		room_mapping.JC,
		room_mapping.HALL2,
		room_mapping.BATHROOM,
		room_mapping.C3,
		room_mapping.C4,
		room_mapping.OFFICE,
		room_mapping.STAFF,
		room_mapping.GYM
	],
	"VENT" : [
		#TODO add vent connectsions
	],
};


var settings: Dictionary = init_default_settings();
var game_state: Dictionary = init_default_game_state();
var load_save_manager: LoadSaveManager = preload("res://manager/load_save_manager.gd").new();
var display_manager: DisplayManager = preload("res://manager/display_manager.gd").new();
var time_manager: TimeManager = preload("res://manager/time_manager.gd").new();
var ai_manager: AIManager = preload("res://manager/ai_manager.gd").new();
var cursor: Cursor = preload("res://cusrom_resources/cursor.gd").new(preload("res://assets/cursor.png"), [Vector2(0,0), Vector2(16,16), Vector2(16,16)]);


func _ready() -> void:
	display_manager.adjust_max_fps();
	
	load_save_manager.load_game();
	load_save_manager.save_game();


func _process(delta) -> void:
	time_manager.process(delta);
	ai_manager.process(delta);


## Returns the settings dict with its default values
func init_default_settings() -> Dictionary:
	var default_settings: Dictionary = {
		"show_splash_screen": true,
		"window_mode": 1,
		"volume": [],
	}
	for i in AudioServer.bus_count: default_settings["volume"].append(1);
	
	return default_settings;


## Returns the game_state dict with its default values
func init_default_game_state() -> Dictionary:
	var game_state: Dictionary = {
		"unlocked_nights": 1, 
	};
	
	return game_state;


# PLACEHOLDER FUNCTION
func kill_player():
	Global.time_manager.is_running = false;
	print("\nYou died\n");
