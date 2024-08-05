class_name DisplayManager
## Handles all the DisplayServer interactions and has display related constants.


const RESOLUTION_ARRAY : Array[Vector2i] = [
	Vector2i(1920, 1080), # Program was natively built for this resolution
	Vector2i(3840, 2160), # Just gives a lot of blank space
	Vector2i(1280, 720), # Doesn't really work all that well
]

const WINDOW_MODE_ARRAY : Array[String] = [
	"Fullscreen",
	"Windowed Mode",
	"Borderless Window",
	"Borderless Fullscreen"
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
