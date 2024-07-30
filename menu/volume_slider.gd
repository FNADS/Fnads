extends HSlider


@export
# Name of the audio bus to control, exported to the editor for easy assignment
var bus_name: String

# Index of the audio bus, will be set in _ready()
var bus_index: int

# Called when the node is added to the scene
func _ready() -> void:
	# Get the index of the audio bus with the given name
	bus_index = AudioServer.get_bus_index(bus_name)
	# Connect the slider's value_changed signal to the _on_value_changed function
	value_changed.connect(_on_value_changed)
	# Initializing the slider to the current bus volume so that the options menu can be shared on different screens while still reflecting the current volume
	value = db_to_linear(
		AudioServer.get_bus_volume_db(bus_index)
	)

# Called when the slider's value changes
func _on_value_changed(new_value: float) -> void:
	# Set the audio bus volume, converting the linear value from the slider to decibels
	AudioServer.set_bus_volume_db(
		bus_index,
		# Converts from linear energy to decibels, more user friendly since volume ins't linear and is actually logarithmic
		linear_to_db(new_value)
	)
