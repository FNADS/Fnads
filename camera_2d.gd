extends Camera2D


func _input(event):
	if event is InputEventMouseMotion:
		global_position.x = ((event.position.x / 500) - 1) * 200
		global_position.y = ((event.position.y / 320) - 1) * 60
