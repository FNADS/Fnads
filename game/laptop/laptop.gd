extends Node2D

@export var isInMainMenu: bool = false

@onready var btn = $LaptopBtn

func _ready():
	get_tree().get_first_node_in_group('Game').connect('on_power_change', can_interact)

func can_interact(state: bool):
	if !state:
		btn.disabled = true
		btn.text = 'ERROR'
	else:
		btn.disabled = false
		btn.text = ''

func _input(_event):
	# Input.ESC:
	if !isInMainMenu:
		if visible:
			hide()
		else:
			show()
	else:
		UIManager.change_scene('main menu')
	pass

func show_screen(screen: String):
	match screen:
		'desktop':
			UIManager.show_screen('Desktop')
		'cameras', 'monitoring':
			UIManager.show_screen('Cameras')
		_:
			return
