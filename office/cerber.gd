class_name Cerber extends Node2D


@onready var cassette_player: CassettePlayer;
@onready var headpat := $Texture/Headpat as AnimatedSprite2D
@onready var cursor_atlas := AtlasTexture.new();
var in_headpat_area: bool = false;
var music_playing: bool = true;
var max_time_without_music: float;


func _ready() -> void:
	cassette_player = get_parent().get_node("CassettePlayer");
	if cassette_player == null: printerr("Node CassettePlayer not found relative to Cerber");
	else: cassette_player.connect("music_playing_changed", _on_music_playing_changed);
	
	max_time_without_music = 90 * (1 + Global.time_manager.variation);
	
	var headpat_tex := load("res://assets/headpat.png") as Texture2D;
	cursor_atlas.atlas = headpat_tex;
	cursor_atlas.region = Rect2(Vector2.ZERO, Vector2(headpat_tex.get_size().y, headpat_tex.get_size().y));


func _process(delta):
	if music_playing:
		pass
	else:
		pass


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
	DisplayServer.cursor_set_custom_image(cursor_atlas, DisplayServer.CURSOR_ARROW, Vector2(cursor_atlas.region.get_center()));


func _on_cursor_exit() -> void:
	in_headpat_area = false;
	DisplayServer.cursor_set_custom_image(null);
	
func _on_headpat() -> void:
	pass
	
func _on_music_playing_changed(is_playing: bool) -> void:
	pass
