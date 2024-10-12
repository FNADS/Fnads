extends Node2D

signal on_power_change(new_power_state: bool)

func _ready():
	break_power(3)

func break_power(time: int):
	await get_tree().create_timer(time).timeout
	var breakers = get_tree().get_first_node_in_group('Breakers')
	breakers.break_power(6)
	# break_power(60)
