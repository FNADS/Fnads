extends CanvasLayer

signal on_transition_finished

@onready var black_screen = $Black_Screen
@onready var splash_fade = $Splash_Fade

func _ready():
	black_screen.visible = false
	splash_fade.animation_finished.connect(_on_animation_finished)

func _on_animation_finished(_anim):
	self.queue_free()
	

func transition():
	black_screen.visible = true
	splash_fade.play("Splash_Animation")
