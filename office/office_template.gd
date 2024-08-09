extends Node2D


@onready var bg := $Bg as Sprite2D;
@export var head_movement := NONE;


enum {
	NONE,
	LEFT,
	RIGHT
}


func _process(delta) -> void:
	match head_movement:
		LEFT: bg.global_position.x += 300 * delta
		RIGHT: bg.global_position.x -= 300 * delta


func set_left_movement() -> void: head_movement = LEFT;

func set_right_movement() -> void: head_movement = RIGHT;

func stop_movement() -> void: head_movement = NONE;
