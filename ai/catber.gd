class_name CatberAI extends AI


var rooms_to_destroy: Array[Global.room_mapping] = [];
## The time that gets added to [code]next_move_timestamp[/code] when catber starts destroying a room.
var destruction_duration: float = 5;
var is_destroying: bool = false;


func _init() -> void:
	current_room = Global.room_mapping.HALL1;
	inaccessible_rooms = [Global.room_mapping.VENT];
	super._init();
	
	target_path = [current_room];
	
	# Gets all available rooms and fills the rooms_to_destroy array unless they are on the inaccessible rooms list (Office excluded)
	for room in Global.room_mapping.values():
		if inaccessible_rooms.has(room) || room == Global.room_mapping.OFFICE: continue;
		else: rooms_to_destroy.append(room);


func process(delta: float) -> void:
	if Global.time_manager.time >= next_move_timestamp:
		next_move_timestamp = Global.time_manager.time + move_wait_time;
		
		if current_room == Global.room_mapping.OFFICE:
			Global.kill_player();
			return;
		
		new_target_path();
		move();
		destroy_room();
		
		if current_room == Global.room_mapping.OFFICE: move_wait_time += kill_timer;
		
		#region DEBUG	
		#print("Iteration Count: ", recursion_iteration_count);
		#recursion_iteration_count = 0;
		#print("Rooms Intact: ", rooms_to_destroy);
		#print("Is Destroying:  ", is_destroying);
		#print("Curr Room: ", current_room);
		#print("Path: ", target_path);
		#print();
		#endregion


## Removes the curren room from the list of destroyable rooms and [code]is_destroying[/code] is set to false again.
func destroy_room() -> void:
	if rooms_to_destroy.has(current_room) && is_destroying: 
		is_destroying = false;
		rooms_to_destroy.erase(current_room);
	elif current_room == target_path[-1]:
		is_destroying = true;
		next_move_timestamp += destruction_duration;


## Decides what path she wants to search for: closest undestroyed room or office.
func new_target_path() -> void:
	if current_room == target_path[-1] && !rooms_to_destroy.has(current_room):
		if rooms_to_destroy.is_empty(): new_path(current_room, check_for_office);
		else:
			available_paths.clear();
			new_path(current_room, check_for_undestroyed_room);

func check_for_undestroyed_room(connected_room: Global.room_mapping) -> bool: return rooms_to_destroy.has(connected_room);

func check_for_office(connected_room: Global.room_mapping) -> bool: return connected_room == Global.room_mapping.OFFICE;
