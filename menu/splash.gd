extends CanvasLayer

signal on_transition_finished

@onready var black_screen = $Black_Screen
@onready var splash_fade = $Splash_Fade

func _ready():
	black_screen.visible = false
	splash_fade.animation_finished.connect(_on_animation_finished)

func _on_animation_finished(_anim):
	emit_signal("on_transition_finished")
	hide()
	

func transition():
	if Global.splash_has_played:
		emit_signal("on_transition_finished")
	else:
		Global.splash_has_played = true
		black_screen.visible = true
		splash_fade.play("Splash_Animation")
		show()  # Ensure the splash screen is visible
