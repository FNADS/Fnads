var destroying = false #if catber is currently destroying something
var destroy_timer = 0 #timer for when catber will destroy room
var all_destroyed_checker = 11 #checks if all rooms are destroyed
var destroyed:Array[bool] = [false,false,false,false,false,false,false,false,false,false]
var door_Time = 0 #time till attack
var checker   #stores a random integer
var default_destroy_time:= 0.2 #20

# Called every frame. 'delta' is the elapsed time since the previous frame.
func update(delta: float):
	if Global.ai_manager.get_pos(0) != 0:
		#coded timer
		Global.ai_manager.ai_move_timers[0] += delta
		if Global.ai_manager.ai_move_timers[0] > Global.ai_manager.ai_move_speeds[0]:
			#generates a random integer between 0 and max AI level
			checker = randi() % Global.ai_manager.max_ai
			#Sets timer to 0 to prevent repeats
			Global.ai_manager.ai_move_timers[0] = 0
			#if the random integer is smaller than the Ai level a move will take place
			if checker < Global.ai_manager.ai_levels[0]:
				Global.ai_manager.ais_moving[0] = true
		#if the move is taking place
		if Global.ai_manager.ais_moving[0]:
			#goes through all undestroyed rooms
			for i in destroyed.size():
				#if the current room is undestroyed exits for loop
				if !destroyed[Global.ai_manager.get_pos(0)]:
					destroying = true
				#else checks if a neighboring room is destroyed
				else:
					for index in Global.ai_manager.room_connection[Global.ai_manager.get_pos(0)].size():
						if index <= Global.ai_manager.room_connection[Global.ai_manager.get_pos(0)].size() - 1:
							if !destroyed[Global.ai_manager.room_connection[Global.ai_manager.get_pos(0)][index]]:
								Global.ai_manager.move_to(Global.ai_manager.room_connection[Global.ai_manager.get_pos(0)][index],0)
						else: break
			#if no neighboring rooms are undestroyed default moves towards the hallway 
			if destroyed[Global.ai_manager.get_pos(0)]:
				if Global.ai_manager.ais_moving[0]:
					match Global.ai_manager.get_pos(0):
						5: 
							Global.ai_manager.move_to(4,0)
							Global.ai_manager.ais_moving[0] = false
						1: 
							await check_all()
							Global.ai_manager.ais_moving[0] = false
						2: 
							d_checker()
							Global.ai_manager.ais_moving[0] = false
						4,3:
							Global.ai_manager.move_to(2,0)
							Global.ai_manager.ais_moving[0] = false
						6,7:
							Global.ai_manager.move_to(1,0)
							Global.ai_manager.ais_moving[0] = false
						8:
							Global.ai_manager.move_to(3,0)
							Global.ai_manager.ais_moving[0] = false
		Global.ai_manager.ais_moving[0] = false
	#code for destroying a room simple timer till destroyed
	if destroying:
		Global.ai_manager.ais_moving[0] = false
		destroy_timer += delta
		if destroy_timer > default_destroy_time:
			destroyed[Global.ai_manager.get_pos(0)] = true
			destroying = 0
			destroy_timer = 0
	#if she is at the office kill timer needs work once door is done
	if Global.ai_manager.get_pos(0) == 0:
		door_Time += delta
		if door_Time > Global.ai_manager.default_kill_Time:
			print("add jumpscare here")

#decides if to move to top corridoor or the bottom
func d_checker():
	for index in Global.ai_manager.room_connection[3].size():
		if !destroyed[Global.ai_manager.room_connection[3][index]]:
			Global.ai_manager.move_to(3,0)
	if Global.ai_manager.get_pos(0) != 3:
		if !destroyed[5]:
			Global.ai_manager.move_to(4,0)
		else:
			Global.ai_manager.move_to(1,0)

#checks if she can mpve into the office doorway
func check_all():
	all_destroyed_checker = 1
	for p in destroyed.size():
		if !destroyed[p]:
			all_destroyed_checker = 0
	if all_destroyed_checker == 1:
		Global.ai_manager.move_to(0,0)
	else:
		Global.ai_manager.move_to(2,0)
