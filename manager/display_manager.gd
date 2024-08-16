class_name DisplayManager


## Handles all the DisplayServer interactions and has display related constants.


const WINDOW_MODE_ARRAY : Array[String] = [
	"FULLSCREEN",
	"WINDOWED"
]

## Sets the games fps to what the monitor can display
func adjust_max_fps() -> void:
	var max_fps : int = (DisplayServer.screen_get_refresh_rate() as int) + 20;
	Engine.max_fps = max_fps if max_fps > 0 else 60;


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
