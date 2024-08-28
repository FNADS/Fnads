class_name CarouselMenuItem extends PanelContainer

@export var identifier: int = 0;
@export var animation_duration: float = 0.5;

var is_current: bool = false;

@onready var n_background_not_current := $Background/NotCurrent as PanelContainer;
@onready var n_background_current := $Background/Current as PanelContainer;
@onready var n_current_layer := $CurrentLayer as Control;

func _ready() -> void:
	set_is_current(is_current);

func set_is_current(p_is_current: bool) -> void:
	is_current = p_is_current;
	
	if not is_visible_in_tree():
		return;
	
	var tween: Tween = create_tween().set_parallel();
	
	tween.tween_property(n_background_not_current, "modulate:a", int(not p_is_current), animation_duration * 2)
	tween.tween_property(n_background_current, "modulate:a", int(p_is_current), animation_duration * 2)
	tween.tween_property(n_current_layer, "modulate:a", int(p_is_current), animation_duration * 2)
