extends Sprite2D


@onready var computer_screen := $ComputerScreen as CanvasLayer;
var mouse_on_pc: bool = false;


func _input(event) -> void:
	if mouse_on_pc && event.is_action_pressed("LEFT_CLICK"):
		computer_screen.visible = true;


func _on_mouse_enter() -> void: mouse_on_pc = true;
	
func _on_mouse_exit() -> void: mouse_on_pc = false;
