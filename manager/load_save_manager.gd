class_name LoadSaveManager


func save_game() -> void:	
	var save_data : Dictionary = {
		"settings": Global.settings,
		"game_state": Global.game_state
	}
	
	var save_str : String = JSON.stringify(save_data, "\t");
	var save_file := FileAccess.open("user://save_data.json", FileAccess.WRITE);
	save_file.store_string(save_str);
	save_file.close();
	
	
## Tries to load the last saved gamestate[br]
## [br]
## Returns: success
func load_game() -> bool:
	var load_file:= FileAccess.open("user://save_data.json", FileAccess.READ);
	
	if FileAccess.get_open_error() != Error.OK: return false;
	
	var load_str: String = load_file.get_as_text();
	load_file.close();
	var load_data := JSON.parse_string(load_str) as Dictionary;
	
	load_settings(load_data["settings"]);
	load_game_state(load_data["game_state"]);
	return true;
	
	
func load_settings(settings_data: Dictionary) -> void:
	for key in Global.settings.keys():
		var data: Variant = settings_data.get(key);
		if data == null: continue;
		
		if typeof(data) == TYPE_ARRAY:
			for i in Global.settings[key].size():
				Global.settings[key][i] = data[i];
		else: Global.settings[key] = data;
	
	Global.display_manager.set_window_mode(Global.settings["window_mode"] as int);
	for i in AudioServer.bus_count:
		AudioServer.set_bus_volume_db(i, linear_to_db(Global.settings["volume"][i] as float));
		
	
func load_game_state(game_state_data: Dictionary) -> void:
	for key in Global.game_state.keys():
		var data: Variant = game_state_data.get(key);
		if data == null: continue;
		
		if typeof(data) == TYPE_ARRAY:
			for i in Global.game_state[key].size():
				Global.game_state[key][i] = data[i];
		else: Global.game_state[key] = data;
	
