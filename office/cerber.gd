class_name Cerber extends Node2D


## The maximum time cerber can be without music or headpats
const max_time_without_care: float = 90.0;


@onready var cerber := $Texture as AnimatedSprite2D;
@onready var headpat := $Texture/Headpat as AnimatedSprite2D;
@onready var sfx_waking_up := $WakingUpSFX as AudioStreamPlayer2D;
@onready var headpat_cursor := AtlasTexture.new();
var time_is_running: bool = false;
var variation_max_time_without_care: float;
#region Muisc vars
var music_playing: bool = true;
var last_music_played: float = 0.0;
#endregion
#region Headpat vars
var in_headpat_area: bool = false;
var last_headpat: float = 0.0;
var oldest_headpat_expired: float = 0.0;
var headpat_count: int = 0;
#endregion
var last_music_state: int;
var last_headpat_state: int; 
var headpat_count_state: int;


func kill_player(): #This is just placeholder function.
	Global.time_manager.is_running = false;


func _ready() -> void:
	var cassette_player := $"../CassettePlayer" as CassettePlayer;
	if cassette_player == null: printerr("Node CassettePlayer not found relative to Cerber");
	else: cassette_player.connect("music_playing_changed", _on_music_playing_changed);
	
	variation_max_time_without_care = max_time_without_care * Global.time_manager.variation;
	
	var headpat_tex := load("res://assets/headpat.png") as Texture2D;
	headpat_cursor.atlas = headpat_tex;
	headpat_cursor.region = Rect2(Vector2.ZERO, Vector2(headpat_tex.get_size().y, headpat_tex.get_size().y));


func _process(_delta) -> void:
	if !Global.time_manager.is_running: return
	
	#region Music
	if music_playing: last_music_played = Global.time_manager.time;
	#endregion
	
	#region Headpats
	if Global.time_manager.hours_since_timestamp(oldest_headpat_expired) >= 0.5:
		oldest_headpat_expired = Global.time_manager.time;
		if headpat_count > 0: headpat_count -= 1;
	#endregion
	
	update_expression();
	
	
	#DEBUG
	#print("Time Elapsed: ", Global.time_manager.time);
	#print("Music Playing: ", music_playing);
	#print("Last Music: ", last_music_played);
	#print("Last Headpat: ", last_headpat);
	#print("Oldest Headpat Expired: ", oldest_headpat_expired);
	#print("Headpat Count: ", headpat_count);
	#print("ms: ", last_music_state);
	#print("hs: ", last_headpat_state);
	#print("hcs: ", headpat_count_state);
	#print();


func _input(event) -> void:
	if Input.is_action_pressed("LEFT_CLICK") && in_headpat_area: start_headpat();
	if (event.is_action_released("LEFT_CLICK") || !in_headpat_area): stop_headpat();


## Updates the expression by calculating the current state of cerbers stats and picks the highest of all stats as the new expression frame
func update_expression() -> void:
	last_music_state = int(Global.time_manager.hours_since_timestamp(last_music_played) >= 0.5) +\
			int(Global.time_manager.hours_since_timestamp(last_music_played) >= 0.75) +\
			int(Global.time_manager.hours_since_timestamp(last_music_played) >= 1.0);
			
	last_headpat_state = int(Global.time_manager.hours_since_timestamp(last_headpat) >= 0.5) +\
			int(Global.time_manager.hours_since_timestamp(last_headpat) >= 0.75) +\
			int(Global.time_manager.hours_since_timestamp(last_headpat) >= 1.0);
			
	headpat_count_state = int(headpat_count >= 3) + int(headpat_count >= 4) + int(headpat_count >= 5);
	
	var new_expression_frame: int = max(last_music_state, last_headpat_state, headpat_count_state);
	
	if cerber.frame == new_expression_frame: return;
	
	cerber.frame = new_expression_frame;
	if new_expression_frame >= 1: sfx_waking_up.play();
	if new_expression_frame == 3: kill_player();


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
	DisplayServer.cursor_set_custom_image(headpat_cursor, DisplayServer.CURSOR_ARROW, Vector2(headpat_cursor.region.get_center()));


func _on_cursor_exit() -> void:
	in_headpat_area = false;
	Global.cursor.set_cursor_index(0);


func _on_headpat() -> void:
	headpat_count += 1;
	last_headpat = Global.time_manager.time;


func _on_music_playing_changed(is_playing: bool) -> void: music_playing = is_playing;
