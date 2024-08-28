class_name CarouselMenuItem extends PanelContainer

@export var identifier: int = 0;
@export var animation_duration: float = 0.5;

var is_current: bool = false;

@onready var nBackground_NotCurrent = $Background/NotCurrent;
@onready var nBackground_Current = $Background/Current;
@onready var nCurrentLayer = $CurrentLayer;

func _ready() -> void:
	set_is_current(is_current);

func set_is_current(p_is_current: bool) -> void:
	is_current = p_is_current;
	
	if not is_visible_in_tree():
		return;
	
	var tween: Tween = create_tween().set_parallel();
	
	tween.tween_property(nBackground_NotCurrent, "modulate:a", int(not p_is_current), animation_duration * 2)
	tween.tween_property(nBackground_Current, "modulate:a", int(p_is_current), animation_duration * 2)
	tween.tween_property(nCurrentLayer, "modulate:a", int(p_is_current), animation_duration * 2)
