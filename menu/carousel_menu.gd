extends Control

@export var animation_duration = 0.5;

@onready var n_placeholders := %Placeholders as Control;
@onready var n_items := %Items as Control;
@onready var n_placements := %Placements as Control;

var current_index: int = 3;

var is_busy: bool = false;

func _ready() -> void:
	n_placeholders.hide();
	n_items.hide();
	
	var diff: int = 8 - n_items.get_child_count();
	
	if diff > 0:
		for i in range(diff):
			var index: int = (n_items.get_child_count() + i) % n_items.get_child_count();
			var n_source := n_items.get_child(index) as CarouselMenuItem;
			var n_item: CarouselMenuItem = n_source.duplicate();
			n_items.add_child(n_item);
	
	for i in n_items.get_child_count():
		var n_item := n_items.get_child(i) as CarouselMenuItem;
		n_item.identifier = i
		n_item.animation_duration = animation_duration
	
	init_placements();

func init_placements() -> void:
	var source_items := n_placements.get_children();
	var new_items: Array[CarouselMenuItem] = [];
	
	var ci: int;
	var n_current: CarouselMenuItem;
	
	ci = current_index - 3;
	for i in range(4):
		var aci: int = ci;
		if aci < 0:
			aci = n_items.get_child_count() + ci;
		if aci == n_items.get_child_count():
			aci = 0;
		var n_item := n_items.get_child(ci) as CarouselMenuItem;
		var n_to_place: CarouselMenuItem = n_item.duplicate();
		n_current = n_to_place;
		var n_placeholder := n_placeholders.get_child(i) as CarouselMenuItem;
		n_placements.add_child(n_to_place);
		new_items.append(n_to_place);
		move_item_to_other(n_to_place, n_placeholder);
		
		ci += 1;
	
	n_current.set_is_current(true);
	
	ci = current_index;
	for i in range(3):
		ci = (ci + 1) % n_items.get_child_count();
		var n_item := n_items.get_child(ci) as CarouselMenuItem;
		var n_to_place: CarouselMenuItem = n_item.duplicate();
		var n_placeholder := n_placeholders.get_child(4 + i) as CarouselMenuItem;
		n_placements.add_child(n_to_place);
		new_items.append(n_to_place)
		move_item_to_other(n_to_place, n_placeholder);
	
	for node in source_items:
		node.queue_free();
	
	for i in range(new_items.size()):
		var n_item := new_items[i] as CarouselMenuItem;
		if i in [0, 6]:
			n_item.modulate.a = 0;
		else:
			n_item.modulate.a = 1;

func go_left() -> void:
	if is_busy:
		return;
	
	current_index -= 1;
	if current_index < 0:
		current_index = n_items.get_child_count() + current_index;
	if current_index == n_items.get_child_count():
		current_index = 0;
	tween_items(current_index);

func go_right() -> void:
	if is_busy:
		return;
	
	current_index = (current_index + 1) % n_items.get_child_count();
	tween_items(current_index);

func tween_items(p_current_index: int = current_index, p_animation_duration: float = animation_duration, p_reversed: bool = false):
	init_placements();
	
	is_busy = true;
	
	var placeholder_indexes: Array = range(n_placeholders.get_child_count());
	var item_indexes: Array[int] = [];
	
	var ci: int;
	
	ci = p_current_index - 3;
	for i in range(4):
		var aci: int = ci;
		if aci < 0:
			aci = n_items.get_child_count() + ci;
		if aci == n_items.get_child_count():
			aci = 0;
		if aci == 7:
			pass
		item_indexes.append(aci);
		ci += 1;
	
	ci = p_current_index;
	for i in range(3):
		ci = (ci + 1) % n_items.get_child_count();
		if ci == 7:
			pass
		item_indexes.append(ci);
	
	var new_items: Array[CarouselMenuItem] = tween_by_indexes(placeholder_indexes, item_indexes, p_animation_duration, p_reversed);
	var ad_tween: Tween = create_tween().set_parallel();
	
	for i in range(new_items.size()):
		var n_item := new_items[i] as CarouselMenuItem;
		if i in [0, n_placeholders.get_child_count() - 1]:
			ad_tween.tween_property(n_item, "modulate:a", 0, animation_duration);
		else:
			ad_tween.tween_property(n_item, "modulate:a", 1, animation_duration);


func tween_by_indexes(p_placeholder_indexes: Array, p_item_indexes: Array[int], p_animation_duration: float = animation_duration, p_reversed: bool = false) -> Array[CarouselMenuItem]:
	var source_items = n_placements.get_children();
	var new_items: Array[CarouselMenuItem] = [];
	
	var ircs: Dictionary = {};
	
	for i in p_placeholder_indexes.size():
		var placeholder_index: int = i;
		var item_index: int = p_item_indexes[i];
		
		var n_placeholder: CarouselMenuItem = n_placeholders.get_child(placeholder_index);
		if not ircs.has(item_index):
			ircs[item_index] = 0;
		var nStatic := n_items.get_child(item_index) as CarouselMenuItem;
		var n_source: CarouselMenuItem = get_placement_by_item(nStatic, ircs[item_index], p_reversed);
		ircs[item_index] = ircs[item_index] + 1;
		var n_item: CarouselMenuItem = n_source.duplicate();
		n_item.set_is_current(false);
		n_placements.add_child(n_item);
		new_items.append(n_item);
		move_item_to_other(n_item, n_source);
		
		var tween: Tween = create_tween().set_parallel();
		tween.finished.connect(_on_tween_finished);
		
		tween.tween_property(n_item, "position", n_placeholder.position, p_animation_duration);
		tween.tween_property(n_item, "anchor_left", n_placeholder.anchor_left, p_animation_duration);
		tween.tween_property(n_item, "anchor_right", n_placeholder.anchor_right, p_animation_duration);
		tween.tween_property(n_item, "anchor_top", n_placeholder.anchor_top, p_animation_duration);
		tween.tween_property(n_item, "anchor_bottom", n_placeholder.anchor_bottom, p_animation_duration);
		tween.tween_property(n_item, "offset_left", n_placeholder.offset_left, p_animation_duration);
		tween.tween_property(n_item, "offset_right", n_placeholder.offset_right, p_animation_duration);
		tween.tween_property(n_item, "offset_top", n_placeholder.offset_top, p_animation_duration);
		tween.tween_property(n_item, "offset_bottom", n_placeholder.offset_bottom, p_animation_duration);
		tween.tween_property(n_item, "z_index", n_placeholder.z_index, p_animation_duration);
	
	for node in source_items:
		node.queue_free();
	
	var n_current := new_items[3] as CarouselMenuItem;
	n_current.set_is_current(true);
	
	return new_items;

func get_placement_by_item(n_item: CarouselMenuItem, irc: int = 0, reversed: bool = false) -> CarouselMenuItem:
	var items := n_placements.get_children() as Array[Node];
	if reversed:
		items.reverse();
	
	var irc_i: int = 0;
	
	for node in items:
		if n_item.identifier == node.identifier:
			if irc_i >= irc:
				return node;
			irc_i += 1;
	
	return null;

func move_item_to_other(p_n_item: CarouselMenuItem, p_nDest: CarouselMenuItem) -> void:
	p_n_item.position = p_nDest.position;
	p_n_item.anchor_left = p_nDest.anchor_left;
	p_n_item.anchor_right = p_nDest.anchor_right;
	p_n_item.anchor_top = p_nDest.anchor_top;
	p_n_item.anchor_bottom = p_nDest.anchor_bottom;
	p_n_item.offset_left = p_nDest.offset_left;
	p_n_item.offset_right = p_nDest.offset_right;
	p_n_item.offset_top = p_nDest.offset_top;
	p_n_item.offset_bottom = p_nDest.offset_bottom;
	p_n_item.z_index = p_nDest.z_index;

func _on_LeftButton_pressed() -> void:
	go_left();

func _on_RightButton_pressed() -> void:
	go_right();

func _on_tween_finished() -> void:
	is_busy = false;
