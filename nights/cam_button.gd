class_name CamButton extends Button


var cam_id: int;


func _ready() -> void:
	cam_id = name.trim_prefix("CamButton") as int; 
	
	print(tr(text).length(), " - ", tr(text));
	match tr(text).length():
		0: printerr("Camera button name cannot be empty!");
		1, 2: add_theme_font_size_override("font_size", 36);
		3, 4: add_theme_font_size_override("font_size", 28);
		5, 6: add_theme_font_size_override("font_size", 24);
		_: add_theme_font_size_override("font_size", 22);


signal cam_selected(id);


func _on_pressed() -> void:
	disabled = true;
	emit_signal("cam_selected", cam_id);
