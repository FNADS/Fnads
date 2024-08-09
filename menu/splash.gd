extends CanvasLayer

# Comment to make git recognize the file rename

@onready var godot := $Godot as TextureRect
@onready var minawan_prod := $MinawanProductions as TextureRect
@onready var yippee := $Yippee as AudioStreamPlayer

func _ready() -> void:
	var tween = create_tween();
	
	if (Global.settings["show_splash_screen"]):
		tween.tween_property(godot, "modulate:a", 1, 1.1);
		tween.tween_property(godot, "modulate:a", 0, 1.1);
		tween.tween_callback(Callable(yippee, "play"));
		tween.tween_property(minawan_prod, "modulate:a", 1, 1.1);
		tween.tween_property(minawan_prod, "modulate:a", 0, 1.1);
		
	tween.tween_callback(Callable(self, "goto_main_menu"));
	
	
func goto_main_menu() -> void: get_tree().change_scene_to_file("res://menu/menu.tscn");
