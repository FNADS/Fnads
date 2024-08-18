class_name Cursor extends AtlasTexture


## Cursor dimensions in pixels
var cursor_size: int;
var hotspots: Array[Vector2];


func _init(spritesheet: Texture2D, _hotspots: Array[Vector2]) -> void:
	self.atlas = spritesheet;
	cursor_size = spritesheet.get_height();
	hotspots = _hotspots;
	@warning_ignore("integer_division")
	assert(hotspots.size() == spritesheet.get_width() / cursor_size, "Cursor texture count and hotspot count must be equal");
	set_cursor_index(0);


## Returns the index of the current selected cursor icon.
func get_cursor_index() -> int: return self.region.position.x / cursor_size;


## Sets the cursor texture to the given index.
func set_cursor_index(index: int) -> void:
	@warning_ignore("integer_division")
	if index < self.atlas.get_width() / cursor_size:
		push_warning("Index out of bounds. The cursor texture does not have that many textures. Index was clamped to the last possible entry");
	
	var position := Vector2(clamp(cursor_size * index, 0, self.atlas.get_width() - cursor_size), 0);
	var size := Vector2(cursor_size, cursor_size);
	self.region = Rect2(position, size);
	
	DisplayServer.cursor_set_custom_image(self, DisplayServer.CURSOR_ARROW, hotspots[index]);
