class_name AI


#var recursion_iteration_count: int = 0; #DEBUG


const max_ai_level: int = 20;

var ai_lv: int = 20;
var kill_timer: float = 5.0
var move_wait_time: float = 3.0; # In seconds
var next_move_timestamp: float = 0.0;
var inaccessible_rooms: Array[Global.room_mapping] = [];
var current_room: Global.room_mapping = Global.room_mapping.OFFICE;
## The last entry in the target path ([code]target_path[-1][/code]) is the target room.
var target_path: Array[Global.room_mapping];
var available_paths: Array[Array] = [];
var shortest_path_length: int = 4;


func _init() -> void:
	assert(current_room != Global.room_mapping.OFFICE);


func reset_shortest_path_length() -> void: shortest_path_length = 4;


## This function will find and create a path according to the conditions set in the given checker callable and pass it to[code]target_path[/code].[br]
## - [code]room[/code]: the room from where the path should start[br]
## - [code]checker[/code]: a callable comparing the connected rooms with specified target rooms[br]
## - [code]path[/code]: NO MANUAL INPUT NEEDED[br]
## - [code]distance[/code]: NO MANUAL INPUT NEEDED
func generate_new_path(room: Global.room_mapping, checker: Callable, path: Array[Global.room_mapping] = [], distance: int = 1) -> void:
	if distance > shortest_path_length: return;
	#recursion_iteration_count += 1; #DEBUG
	var has_direct_neighbours: bool = false;
	for connected_room in Global.room_connections[Global.room_mapping.find_key(room)]:
		if checker.call(connected_room):
			var new_path := path.duplicate();
			new_path.append(connected_room);
			shortest_path_length = new_path.size();
			available_paths.append(new_path);
			has_direct_neighbours = true;
	
	if !has_direct_neighbours:
		for connected_room in Global.room_connections[Global.room_mapping.find_key(room)]:
			var new_path := path.duplicate();
			new_path.append(connected_room);
			generate_new_path(connected_room, checker, new_path, distance + 1);
	
	if distance == 1:
		var shortest_paths_available = available_paths.filter(func(available_path: Array): return available_path.size() <= shortest_path_length);
		print("New Available Paths: ", shortest_paths_available); #DEBUG
		target_path = shortest_paths_available.pick_random();
		reset_shortest_path_length();


## Move the ai along the path until she's in her target room
func move() -> bool:
	if current_room != target_path[-1] && randi_range(0, max_ai_level) < ai_lv:
		if current_room == target_path[0]: target_path.remove_at(0);
		current_room = target_path[0];
		return true;
	else: return false;
