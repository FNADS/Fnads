extends Button


@export var tabs:= Node
@export var button:= Node

func _on_pressed():
	tabs.visible = true
	button.visible = true
	self.visible = false


func _on_button_2_pressed():
	tabs.visible = false
	button.visible = false
	self.visible = true
