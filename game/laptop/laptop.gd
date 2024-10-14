extends Node2D


@onready var btn = $LaptopBtn
@onready var sprite = $Sprite2D

func _ready():
	get_tree().get_first_node_in_group('Game').connect('on_power_change', can_interact)

func can_interact(state: bool):
	if !state:
		btn.disabled = true
		sprite.frame = 1
	else:
		btn.disabled = false
		sprite.frame = 0


func show_screen(screen: String):
	match screen:
		'desktop':
			UIManager.show_screen('Desktop')
		'cameras', 'monitoring':
			UIManager.show_screen('Cameras')
		_:
			return
