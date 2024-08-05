extends HSlider

@export var bus_name: String
var bus_index: int

func _ready() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)
	value = Global.settings["volume"][bus_index];
<<<<<<< HEAD
	value_changed.connect(_on_value_changed);
=======
>>>>>>> 9276dc2cb6eb348ad467a4d7080d00437785b8c1

func _on_value_changed(new_value: float) -> void:
	Global.settings["volume"][bus_index] = new_value;
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(new_value));
