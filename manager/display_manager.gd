class_name DisplayManager
## Handles all the DisplayServer interactions and has display related constants.


const default_resolution := Vector2i(1920, 1080);


const RESOLUTION_ARRAY : Array[Vector2i] = [
	Vector2i(1280, 720),
	Vector2i(1920, 1080), # Program was natively built for this resolution
	Vector2i(2560, 1440), 
	Vector2i(3840, 2160),
]

const WINDOW_MODE_ARRAY : Array[String] = [
	"FULLSCREEN",
	"WINDOWED"
]


func set_window_resolution(index : int) -> void:
	Global.settings["resolution"] = index;
	DisplayServer.window_set_size(RESOLUTION_ARRAY[index]);


## [code]0[/code]: Fullscreen[br]
## [code]1[/code]: Windowed[br]
## [code]2[/code]: Borderless Windowed[br]
## [code]3[/code]: Borderless Fullscreen, known issues with the Godot engine
func set_window_mode(index : int) -> void:
	Global.settings["window_mode"] = index;
	match index:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN);
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false);
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		2:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
		3:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
		_:
			pass

## Deprecated: (I still keep it for when we might  need it in the future)
## Return the scale for a viewport based on the default and currently selected resolution
#func get_viewport_scale() -> Vector2:
	#var current_resolution := (RESOLUTION_ARRAY[Global.settings["resolution"]] as Vector2);
	#return current_resolution / (default_resolution as Vector2);
