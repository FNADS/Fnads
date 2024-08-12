extends CanvasLayer


@onready var bg := $Background as ColorRect;
@onready var tint := $RedTint as Panel;
@onready var label := $RedTint/Label as Label;
@onready var tv_static := ($TvStatic as TextureRect).material as ShaderMaterial;
var transparency : float = 0;


func _ready() -> void:
	bg.self_modulate.a = 0.0;
	tint.self_modulate.a = 0.0;
	label.self_modulate.a = 0.0;
	
	var tween := create_tween().set_parallel(true);
	tween.tween_property(bg, "self_modulate:a", 1.0, 1.0);
	tween.tween_property(tint, "self_modulate:a", 1.0, 2.0);
	tween.tween_property(label, "self_modulate:a", 1.0, 2.0);
	
	var pulse := create_tween().set_loops();
	pulse.tween_property(tint, "self_modulate:a", 0.6, 0.5);
	pulse.tween_property(tint, "self_modulate:a", 1.0, 1.0);


func _process(delta) -> void:
	if visible && transparency < 0.25:
		transparency += 0.1 * delta;
		tv_static.set_shader_parameter("transparency", transparency);
