class_name AIManager


var catber: CatberAI = preload("res://ai/catber.gd").new();


func process(delta: float) -> void:
	catber.process(delta);
