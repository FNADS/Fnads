extends Control

@export var onTexture: Texture
@export var offTexture: Texture
@export var isOn: bool = true

@onready var button = $Button

@export var breaker_id: int = 0

signal change_breakers_state(id: int, state: bool)

func _ready():
	change_state(isOn)

func change_state(state: bool = !isOn):
	isOn = state
	change_breakers_state.emit(breaker_id, isOn)
	if state:
		button.icon = onTexture
	else:
		button.icon = offTexture
