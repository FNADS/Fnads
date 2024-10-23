extends Node2D

@export var generator_power:int = 100
#changes when the generator power level changes
signal on_power_level_changed(new_level: int)
#changes when power hits zero
signal on_power_changed(power_state: bool)
func _ready():
	break_power(3)
	
func break_power(time: int):
	await get_tree().create_timer(time).timeout
	var breakers = get_tree().get_first_node_in_group('Breakers')
	breakers.break_power(6)
	# break_power(60)

func use_generator_power(power: int):
	generator_power -= power
	if generator_power <= 0:
		generator_power = 0
		on_power_changed.emit(false)
	on_power_level_changed.emit(generator_power)

		
	
