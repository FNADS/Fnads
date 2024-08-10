extends CanvasLayer

var time_in_cams:= {}
var cam_variations:= {}

# Called when the node enters the scene tree for the first time.
func _ready():
	var button_id:= 0
	for button in $TextureRect.get_children():
			if button.name.begins_with("CamButtonButton"):
				button_id = int(button.name.trim_prefix("CamButtonButton"))
				time_in_cams[button_id] = 0.00
				cam_variations[button_id] = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.visible:
		time_in_cams[Global.selected_cam] += delta
		
		if cam_variations[Global.selected_cam] != 0:
			pass
		else: $AnimatedTextureRect.frame = Global.selected_cam
