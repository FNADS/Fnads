extends Control

@export var panel_size: Vector2 = Vector2(1920,77):
	get: return panel_size
	set(value):
		panel_size = value
func _process(_delta):
		$Panel.size = panel_size
