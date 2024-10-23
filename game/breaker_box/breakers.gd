extends Node2D

@onready var screen = $BreakersScreen
@onready var container = $BreakersScreen/Control/HBoxContainer

@export var breakers_count: int = 4

var breaker = preload("res://game/breaker_box/breaker.tscn")
var states = []
var is_power_on = true
var rng = RandomNumberGenerator.new()

func _ready():
	for i in breakers_count:
		var breakerInstance = breaker.instantiate()
		states.append(breakerInstance)
		container.add_child(breakerInstance)
		breakerInstance.breaker_id = i
		breakerInstance.connect('change_breakers_state', change_state)
	
	screen.hide()

func change_state(id: int, state: bool):
	# print('Changing state of: ' + str(id) + ' - new state: ' + str(state))
	# states[id] = state
	check_breakers()

func break_power(chance: int):
	for i in breakers_count:
		var n = rng.randi_range(0, 10)
		if n > chance:
			states[i].change_state(false)
	check_breakers()

func check_breakers():
	var new_power_state = true
	for s in states:
		if s.isOn == false:
			new_power_state = false
			break
	if new_power_state != is_power_on:
		is_power_on = new_power_state
		if is_power_on:
			print("Power is back ON")
		else:
			print("Power is OFF")
		get_tree().get_first_node_in_group('Game').on_power_state_changed.emit(is_power_on)

func open_breakers(open: bool):
	if open:
		screen.show()
	else:
		screen.hide()
