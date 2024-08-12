extends Control


# TODO: Rewrite this and restructure the scene:
# 		- Use TabContainer  insteadof manually managing the tabs
# 		- Move it to office template and pout office template in each night instead
# 		- Change Control root node to Canvaslayer and adjust the rest


@export var label: Label
@export var pc_tab1: Node
@export var pc_tab2: Node
@export var pc_tab3: Node
@export var tabs: Node

func _process(delta):
	label.text = str(Global.current_am,"AM")
	match tabs.current_pc_tab:
		0:
			tabs.visible = false
			pc_tab1.visible = false
			pc_tab2.visible = false
			pc_tab3.visible = false
		1:
			pc_tab1.visible = true
			pc_tab2.visible = false
			pc_tab3.visible = false
		2:
			pc_tab1.visible = false
			pc_tab2.visible = true
			pc_tab3.visible = false
		3:
			pc_tab1.visible = false
			pc_tab2.visible = false
			pc_tab3.visible = true
