class_name CamButton extends Button


var cam_id: Global.room_mapping;


func _ready() -> void:
	cam_id = Global.room_mapping.get(self.text);
	
	self.pivot_offset = self.size / 2;
	
	match tr(self.text).length():
		0: printerr("Camera button name cannot be empty!");
		1, 2: add_theme_font_size_override("font_size", 36);
		3, 4: add_theme_font_size_override("font_size", 28);
		5, 6: add_theme_font_size_override("font_size", 24);
		_: add_theme_font_size_override("font_size", 22);


signal cam_selected(id: Global.room_mapping);


func deselect() -> void:
	self.disabled = false;
	self.scale = Vector2.ONE;


func _on_pressed() -> void:
	self.disabled = true;
	self.scale = Vector2(1.1, 1.1);
	emit_signal("cam_selected", cam_id);
