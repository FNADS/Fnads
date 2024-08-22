class_name CamButton extends Button


var cam_id: int;


func _ready() -> void:
	cam_id = Global.room_mapping[self.text];
	
	match tr(self.text).length():
		0: printerr("Camera button name cannot be empty!");
		1, 2: add_theme_font_size_override("font_size", 36);
		3, 4: add_theme_font_size_override("font_size", 28);
		5, 6: add_theme_font_size_override("font_size", 24);
		_: add_theme_font_size_override("font_size", 22);


signal cam_selected(id);


func _on_pressed() -> void:
	disabled = true;
	emit_signal("cam_selected", cam_id);
