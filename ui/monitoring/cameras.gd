extends Control

@onready var camera = $ColorRect

@export var color1: Color
@export var color2: Color
@export var color3: Color
@export var color4: Color
@export var color5: Color

func show_camera(room: String):
	match room:
		'1':
			camera.color = color1
		'2':
			camera.color = color1
		'3':
			camera.color = color3
		'4':
			camera.color = color4
		_:
			camera.color = color5
