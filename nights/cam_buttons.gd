extends Button

#ask walmart wan to add comments if needed
var camera_id:= 0
@export_category("Button Settings")
@export var button_text: String
@export var button_enabled_sprite: Node
@export var button_disabled_sprite: Node
@export var button_label: Node
@export_category("Label")
@export_subgroup("Label size")
@export var use_size_override:= false
@export var button_text_size_override:= 36
@export_subgroup("Label position")
@export var use_x_override:= false
@export var button_text_x_override:= 4.0
@export var use_y_override:= false
@export var button_text_y_override:= 6.0

func _ready():
	camera_id = int(self.name.trim_prefix("CamButtonButton"))
	if use_size_override:
		button_label.add_theme_font_size_override("font_size",button_text_size_override)
	if use_x_override:
		button_label.position.x = button_text_x_override
	if use_y_override:
		button_label.position.y = button_text_y_override
	Global.previous_cam = Global.selected_cam
	if button_text.length() <= 6: button_label.text = button_text
	else: button_label.text = "ERR"
	update_texture()

func _on_pressed():
	if Global.selected_cam != camera_id:
		Global.selected_cam = camera_id
	if Global.selected_cam != Global.previous_cam:
		print("current camera changed, prev: ",Global.previous_cam," new: ",Global.selected_cam)
		update_texture()
		Global.previous_cam = Global.selected_cam

func update_texture():
	var button_id:= 0
	for button in get_parent().get_children():
			if button.name.begins_with("CamButtonButton"):
				button_id = int(button.name.trim_prefix("CamButtonButton"))
				button.button_pressed = false
				if button_id == Global.selected_cam:
					button.button_pressed = true
				if button.button_pressed:
					button.button_enabled_sprite.visible = true
					button.button_disabled_sprite.visible = false
				elif !button.button_pressed:
					button.button_enabled_sprite.visible = false
					button.button_disabled_sprite.visible = true 
