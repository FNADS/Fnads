extends TabContainer


var previous_tab: int = 0;


func _ready():
	get_tab_bar().focus_mode = Control.FOCUS_NONE;
	for tab in get_children():
		match tab.name:
			"CamTab": set_tab_title(tab.get_index(), tr("CAMERAS"));
			"Back": set_tab_title(tab.get_index(), tr("BACK"));


func _on_tab_selected(id: int) -> void:
	if get_child(id).name == "Back":
		current_tab = previous_tab;
		get_parent().visible = false;
