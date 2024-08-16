class_name CassettePlayer extends Node2D


const rewind_time : float = 5.0; # The time it needs to rewind the whole tape


@onready var music := $CassetteMusic as AudioStreamPlayer2D;
@onready var sfx_rewind := $CassetteRewindSFX as AudioStreamPlayer2D;
@onready var sfx_button_in := $CassettePlayerButtonInSFX as AudioStreamPlayer2D;
@onready var sfx_button_out := $CassettePlayerButtonOutSFX as AudioStreamPlayer2D;
var music_time : float = 0.0;
var rewind_step : float; # The time it rewinds each second
var is_rewinding : bool = false;
var hover_over := NONE;


enum {
	NONE,
	CASSETTE,
	REWIND,
	STOP,
	PLAY,
}


signal music_playing_changed(is_playing);

func emit_music_playing_changed() -> void: emit_signal("music_playing_changed", music.playing);


func _ready() -> void:
	rewind_step = music.stream.get_length() / rewind_time;
	music.play();
	
	
func _process(delta):
	if music.playing: music_time = music.get_playback_position();
		
	if is_rewinding && music_time > 0.0:
		music_time -= rewind_step * delta;
		if music_time < 0.0:
			music_time = 0.0;
			sfx_rewind.stop();


func  _input(_event) -> void:
	if Input.is_action_just_pressed("LEFT_CLICK"): use_cassette_player();
	if Input.is_action_just_released("LEFT_CLICK"): stop_use_cassette_player();


func use_cassette_player() -> void:
	match hover_over:
		CASSETTE: pass
		REWIND when !music.playing: rewind();
		STOP: stop();
		PLAY when !music.playing: play();


func stop_use_cassette_player() -> void:
	if hover_over == REWIND:
		sfx_rewind.stop();
		is_rewinding = false;


func cassette() -> void: pass

func rewind() -> void:
	sfx_button_in.play();
	is_rewinding = true;
	if (music_time > 0.0): sfx_rewind.play();

func stop() -> void:
	sfx_button_out.play();
	if music.playing:
		music.stop();
		emit_music_playing_changed();

func play() -> void:
	sfx_button_in.play();
	if music_time < music.stream.get_length():
		music.play(music_time);
		emit_music_playing_changed();


func _on_cassette_enter() -> void: hover_over = CASSETTE;

func _on_rewind_enter() -> void: hover_over = REWIND;

func _on_stop_enter() -> void: hover_over = STOP;

func _on_play_enter() -> void: hover_over = PLAY;

func _on_mouse_exit_any() -> void:
	stop_use_cassette_player();
	hover_over = NONE;

func _on_music_finished() -> void:
	music_time = music.stream.get_length();
	sfx_button_out.play();
	emit_music_playing_changed();
