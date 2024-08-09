extends Node2D


@onready var headpat := $Texture/Headpat as AnimatedSprite2D
@onready var cursor_atlas := AtlasTexture.new();
var in_headpat_area : bool = false;


func _ready() -> void:
	var headpat_tex := load("res://assets/headpat.png") as Texture2D;
	cursor_atlas.atlas = headpat_tex;
	cursor_atlas.region = Rect2(Vector2.ZERO, Vector2(headpat_tex.get_size().y, headpat_tex.get_size().y));


func _input(event) -> void:
	if Input.is_action_pressed("LEFT_CLICK") && in_headpat_area: start_headpat();
	if (event.is_action_released("LEFT_CLICK") || !in_headpat_area): stop_headpat();


func start_headpat() -> void:
	headpat.visible = true;
	headpat.play();
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_HIDDEN);


func stop_headpat() -> void:
	headpat.visible = false;
	headpat.pause();
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_VISIBLE);


func _on_cursor_enter() -> void:
	in_headpat_area = true;
	DisplayServer.cursor_set_custom_image(cursor_atlas, 0, Vector2(cursor_atlas.region.get_center()));


func _on_cursor_exit() -> void:
	in_headpat_area = false;
	DisplayServer.cursor_set_custom_image(null);
