extends Control


var selected_cam: Global.room_mapping = Global.room_mapping.ART;
var time_in_cams: Dictionary = {};
#var variation: Array[int] = [] This has nothing to do in the cam tab skript
@onready var cam_map := $CamMap as TextureRect;
@onready var cam_display := $AnimatedTextureRect as AnimatedTextureRect;


func _ready() -> void:
	for cam in cam_map.get_children():
		if !(cam is CamButton): continue;
		cam.connect("cam_selected", change_cam);
		time_in_cams[cam.text] = 0.0;
		# variation.append(0)  This has nothing to do in the cam tab skript


func _process(delta):
	if self.visible:
		time_in_cams[Global.room_mapping.find_key(selected_cam)] += delta;
		
	#region This does not belong in the cam tab skript
	#print(variation)
	#for pos in Global.char_positions:
		#variation[pos] = Global.char_positions[pos]
	#endregion	
	
		


func change_cam(cam_id: Global.room_mapping) -> void:
	var old_cam := selected_cam	
	var cam_node_name := (Global.room_mapping.find_key(selected_cam) as String).to_pascal_case();
	var cam := cam_map.get_node(cam_node_name) as CamButton;
	cam.deselect();
	selected_cam = cam_id;
	#cam_display.frame = selected_cam
	print("cam changed, old: ",old_cam," new: ",selected_cam)
