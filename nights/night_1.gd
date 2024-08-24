extends Control


# TODO: Rewrite this and restructure the scene:
# 		- Move it to office template and pout office template in each night instead
# 		- Change Control root node to Canvaslayer and adjust the rest


@export var label: Label

func _ready() -> void:
	Global.time_manager.is_running = true

func _process(delta: float) -> void:
	if Global.time_manager.is_running:
		Global.ai_manager.purrbert.update(delta)
