extends CanvasLayer


@onready var scroll := $Background/Scroll as ScrollContainer;
@export var scroll_speed : float = 50; 
var scroll_step : float = 0.0;


func _process(delta) -> void:
	scroll_step += scroll_speed * delta;
	if (scroll_step >= 1.0):
		var previous_scroll : int = scroll.scroll_vertical;
		scroll.scroll_vertical += 1;
		if scroll.scroll_vertical == previous_scroll: _on_back_pressed();
		scroll_step = 0.0; 


# Function to return to the main menu screen
func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://menu/menu.tscn");
