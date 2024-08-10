@tool
class_name  AnimatedTextureRect extends TextureRect

@export var sprite_frames : SpriteFrames:
	get: return sprite_frames;
	set(value):
		sprite_frames = value;
		sprite_frames.changed.connect(Callable(self, "_on_spriteframes_change"));
@export var animation : String = "default":
	get: return animation;
	set(value):
		if !sprite_frames.has_animation(value):
			printerr("SpriteFrame does not have the given animation!");
			return;
		animation = value;
		frame = 0;
		texture = sprite_frames.get_frame_texture(animation, frame);
@export var frame : int = 0:
	get: return frame;
	set(value):
		if sprite_frames.get_frame_count(animation) < 1:
			printerr("SpriteFrame does not have any frames");
			return;
		frame = value;
		if frame >= sprite_frames.get_frame_count(animation):
			if !looping: playing = false;
			frame = 0;
		texture = sprite_frames.get_frame_texture(animation, frame);
@export_range(0 , 100, 0.001, "or_greater") var speed_scale : float = 1;
@export var auto_play : bool = false;
@export var looping : bool = false;
@export var playing : bool = false;

var refresh_rate : float = 1;
var fps : float = 30;
var frame_delta : float = 0;


func _on_spriteframes_change() -> void:
	if sprite_frames.has_animation(animation) && sprite_frames.get_frame_count(animation) >= 1:
		texture = sprite_frames.get_frame_texture(animation, frame);


func _ready() -> void:
	if auto_play: play();
	

func _process(delta) -> void:
	if sprite_frames != null && playing:
		frame_delta += speed_scale * delta;
		if frame_delta >= refresh_rate / fps: next_frame();


func next_frame() -> void:
	frame += 1;
	refresh_rate = sprite_frames.get_frame_duration(animation, frame);
	frame_delta = 0;


## Plays the animation with key name.[br]
## If this method is called with no name parameter it will play the current selected animation again.[br]
func play(new_animation : String = "") -> void:
	frame = 0;
	frame_delta = 0;
	if new_animation != "": animation = new_animation;
	fps = sprite_frames.get_animation_speed(animation);
	refresh_rate = sprite_frames.get_frame_duration(animation, frame);
	playing = true;
	

func resume() -> void: playing = true;


func pause() -> void: playing = false;


func stop() -> void:
	frame = 0;
	playing = false;
