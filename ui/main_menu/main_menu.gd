extends CanvasLayer

@onready var main_menu = $Screen1
@onready var settings = $Screen2

var game_scene = 'res://game/game.tscn'

# Called when the node enters the scene tree for the first time.
func _ready():
	_hide_screens()
	main_menu.show()


func _hide_screens():
	main_menu.hide()
	settings.hide()

func change_screen(screen: String):
	_hide_screens()
	match screen:
		'game':
			get_tree().change_scene_to_file(game_scene)
		'settings':
			settings.show()
		_:
			main_menu.show()
