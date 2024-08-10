extends Control

const LEVEL_BTN = preload("res://menu/lvl_btn.tscn")

@export_dir var dir_path

@onready var grid = $MarginContainer/VBoxContainer/GridContainer

func _ready() -> void:
	get_levels(dir_path)

func _process(delta):
	$Panel.size.y = DisplayServer.window_get_size().y

func get_levels(path) -> void:
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			print(file_name)
			if file_name.ends_with(".tscn") && file_name.begins_with("night_"):
				create_level_btn("%s/%s" % [dir.get_current_dir(), file_name], file_name)
			file_name = dir.get_next()
		dir.list_dir_end()
	else:
		print("An error occurred when trying to access the path")

func create_level_btn(lvl_path: String, lvl_name: String) -> void:
	var btn = LEVEL_BTN.instantiate()
	btn.text = lvl_name.trim_suffix(".tscn").replace("_", " ")
	btn.level_path = lvl_path
	grid.add_child(btn)
