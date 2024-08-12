extends Control
@export var button1: Button
@export var button2: Button
@export var button3: Button
var current_pc_tab:= 1

func _process(_delta):
	match current_pc_tab:
		1:
			button1.disabled = true
			button2.disabled = false
			button3.disabled = false
		2:
			button1.disabled = false
			button2.disabled = true
			button3.disabled = false
		3:
			button1.disabled = false
			button2.disabled = false
			button3.disabled = true

func _on_tab_1_pressed():
	current_pc_tab = 1
	print("pc tab changed to 1")

func _on_tab_2_pressed():
	current_pc_tab = 2
	print("pc tab changed to 2")

func _on_tab_3_pressed():
	current_pc_tab = 3
	print("pc tab changed to 3")
