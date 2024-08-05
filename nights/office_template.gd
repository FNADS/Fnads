extends CanvasLayer


@onready var bg := $Bg as TextureRect;


func _ready() -> void:
	scale = Global.display_manager.get_viewport_scale();
