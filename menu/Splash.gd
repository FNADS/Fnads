extends CanvasLayer

@onready var godot := $Godot
@onready var minawan_prod := $Minawan_Productions

func _ready():
	var tween = create_tween();
	tween.connect("finished", Callable(self, "_on_splash_finish"));
	tween.tween_property(godot, "modulate:a", 1, 1.1);
	tween.tween_property(godot, "modulate:a", 0, 1.1);
	tween.tween_property(minawan_prod, "modulate:a", 1, 1.1);
	tween.tween_property(minawan_prod, "modulate:a", 0, 1.1);

# Signal Callback
func _on_splash_finish():
	get_tree().change_scene_to_file("res://menu/Menu.tscn");
