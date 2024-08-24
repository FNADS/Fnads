class_name CatberAI extends AI


const movement_level_up: int = 20;  #max ai level before move speed changes


var ai_lv: int = 20;
var move_wait_time: int = 3;
var next_move_timestamp: float = 0.0;
var inaccessible_rooms: Array[Global.room_mapping] = [Global.room_mapping.VENT];
var rooms_to_destroy: Array[Global.room_mapping] = [];
var current_room := Global.room_mapping.HALL1;
var target_room: Global.room_mapping;


#var count: int = 0; #DEBUG


func _init() -> void:
	# Gets all available rooms and fills the rooms_to_destroy array unless they are on the inaccessible rooms list (Office excuded)
	for room in Global.room_mapping.values():
		if inaccessible_rooms.has(room) || room == Global.room_mapping.OFFICE: continue;
		else: rooms_to_destroy.append(room);
		
	target_room = current_room;


func process(delta: float) -> void:
	if Global.time_manager.time >= next_move_timestamp:
		next_move_timestamp = Global.time_manager.time + move_wait_time;
		
		if target_room == current_room && !rooms_to_destroy.has(current_room):
			#print("I'm getting a new room"); #DEBUG
			#count = 0; #DEBUG
			get_new_target_room(current_room);
			#print("Count: ", count);
		if target_room != current_room && randi_range(0, movement_level_up) < ai_lv: current_room = target_room;
		if rooms_to_destroy.has(current_room): rooms_to_destroy.erase(current_room);
		
		#DEBUG	
		#print("Curr Room: ", current_room);
		#print("Target Room: ", target_room);
		#print("Rooms intact: ", rooms_to_destroy);
		#print();


func get_new_target_room(room: Global.room_mapping) -> void:
	if rooms_to_destroy.is_empty(): target_room = Global.room_mapping.OFFICE;
	else: target_room = get_closest_undestroyed_room(room, 1);


func get_closest_undestroyed_room(room: Global.room_mapping, distance: int) -> Global.room_mapping:
	#count += 1; #DEBUG
	if distance == 5: return room;
	for connected_room in Global.room_connections[Global.room_mapping.find_key(room)]:
		if rooms_to_destroy.has(connected_room):
			return connected_room;
	
	for connected_room in Global.room_connections[Global.room_mapping.find_key(room)]:
		return get_closest_undestroyed_room(connected_room, distance + 1);
	
	return target_room;
