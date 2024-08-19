class_name CassettePlayer extends Node2D


const rewind_time : float = 5.0; # The time it needs to rewind the whole tape


@onready var music := $CassetteMusic as AudioStreamPlayer2D;
@onready var sfx_rewind := $CassetteRewindSFX as AudioStreamPlayer2D;
@onready var sfx_button_in := $CassettePlayerButtonInSFX as AudioStreamPlayer2D;
@onready var sfx_button_out := $CassettePlayerButtonOutSFX as AudioStreamPlayer2D;
@onready var sfx_cassette_change := $CassetteChangeSFX as AudioStreamPlayer2D;
@onready var va_instruction_speech := $InstructionSpeechVA as AudioStreamPlayer2D;
@onready var rewind_step: float = music.stream.get_length() / rewind_time; # The time it rewinds each second
var audio_time: float = 0.0;
var is_rewinding: bool = false;
var hover_over := NONE;
var cassette_front_side: bool = true;


enum {
	NONE,
	CASSETTE,
	REWIND,
	STOP,
	PLAY,
}


signal music_playing_changed(is_playing);

func emit_music_playing_changed() -> void: if !cassette_front_side: emit_signal("music_playing_changed", music.playing);


func _process(delta) -> void:
	
	#DEBUG
	#print("Audio Time: ", audio_time);
	#print("Is Rewinding: ", is_rewinding);
	#print("Cassette Front Side: ", cassette_front_side);
	#print();
	
	
	if get_current_cassette_side().playing: audio_time = get_current_cassette_side().get_playback_position();
		
	if is_rewinding && audio_time > 0.0:
		audio_time -= rewind_step * delta;
		if audio_time < 0.0:
			audio_time = 0.0;
			sfx_rewind.stop();


func  _input(_event) -> void:
	if Input.is_action_just_pressed("LEFT_CLICK"): use_cassette_player();
	if Input.is_action_just_released("LEFT_CLICK"): stop_use_cassette_player();


func use_cassette_player() -> void:
	match hover_over:
		CASSETTE when cassette_front_side && !get_current_cassette_side().playing: cassette();
		REWIND when !get_current_cassette_side().playing: rewind();
		STOP: stop();
		PLAY when !get_current_cassette_side().playing: play();


func stop_use_cassette_player() -> void:
	if hover_over == REWIND:
		sfx_rewind.stop();
		is_rewinding = false;


func cassette() -> void:
	stop();
	sfx_cassette_change.play();
	cassette_front_side = false;
	audio_time = 0.0;


func rewind() -> void:
	sfx_button_in.play();
	is_rewinding = true;
	if (audio_time > 0.0): sfx_rewind.play();


func stop() -> void:
	sfx_button_out.play();
	if get_current_cassette_side().playing:
		get_current_cassette_side().stop();
		emit_music_playing_changed();


func play() -> void:
	sfx_button_in.play();
	if audio_time < get_current_cassette_side().stream.get_length():
		get_current_cassette_side().play(audio_time);
		emit_music_playing_changed();


func get_current_cassette_side() -> AudioStreamPlayer2D:
	if cassette_front_side: return va_instruction_speech;
	else: return music;


func _on_cassette_enter() -> void:
	Global.cursor.set_cursor_index(1);
	hover_over = CASSETTE;


func _on_rewind_enter() -> void:
	Global.cursor.set_cursor_index(1);
	hover_over = REWIND;


func _on_stop_enter() -> void:
	Global.cursor.set_cursor_index(1);
	hover_over = STOP;


func _on_play_enter() -> void:
	Global.cursor.set_cursor_index(1);
	hover_over = PLAY;


func _on_mouse_exit_any() -> void:
	Global.cursor.set_cursor_index(0);
	stop_use_cassette_player();
	hover_over = NONE;


func _on_audio_finished() -> void:
	audio_time = music.stream.get_length();
	sfx_button_out.play();
	emit_music_playing_changed();


func _on_start_timer_finish() -> void: get_current_cassette_side().play();
