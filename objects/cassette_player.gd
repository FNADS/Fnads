extends Node2D


const rewind_time : float = 5.0; # The it needs to rewind the whole tape


@onready var music := $CassetteMusic as AudioStreamPlayer2D;
@onready var rewind := $CassetteRewind as AudioStreamPlayer2D;
@onready var buttons := $CassettePlayerButtons as AudioStreamPlayer2D;
var music_time : float = 0.0;
var rewind_step : float; # The time it rewinds each second
var rewind_tape : bool = false;
var hover_over := NONE;


enum {
	NONE,
	CASSETTE,
	REWIND,
	STOP,
	PLAY,
}


func _ready() -> void:
	rewind_step = music.stream.get_length() / rewind_time;
	
	
func _process(delta):
	#DEBUG:
	#print(music.get_playback_position());
	#print(music_time);
	#print();
	
	if rewind_tape && music_time > 0.0:
		music_time -= rewind_step * delta;
		if music_time < 0.0:
			music_time = 0.0;
			rewind.stop();


func  _input(event) -> void:
	if Input.is_action_just_pressed("LEFT_CLICK"): use_cassette_player();
	if Input.is_action_just_released("LEFT_CLICK"): stop_use_cassette_player();


func use_cassette_player() -> void:
	match hover_over:
		CASSETTE: pass
		REWIND:
			if !music.playing:
				buttons.play();
				rewind_tape = true;
				if (music_time > 0.0): rewind.play();
		STOP:
			buttons.play();
			music_time = music.get_playback_position();
			music.stop();
		PLAY:
			if !music.playing:
				buttons.play();
				music.play(music_time);


func stop_use_cassette_player() -> void:
	if hover_over == REWIND:
		rewind.stop();
		rewind_tape = false;


func _on_cassette_enter() -> void: hover_over = CASSETTE;

func _on_rewind_enter() -> void: hover_over = REWIND;

func _on_stop_enter() -> void: hover_over = STOP;

func _on_play_enter() -> void: hover_over = PLAY;

func _on_mouse_exit_any() -> void:
	stop_use_cassette_player();
	hover_over = NONE;
