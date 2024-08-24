extends Node


var AI_Level :int= 20 #current ai level
var AI_Move_Speed = 4.8 #time between checking for a move lowered to make evil more agressive
const x = 20  #max ai level before move speed changes
var door_Time = 0 #time till attack currently not in use as door isnt implemented nor is an attack
var Evil_Timer = 0 #timer between move attempts
var Checker   #stores a random integer
var ventConnection = [4,6,7,8,9,12,13,14] #lists all the rooms with vent
var memory = [987,987,987,987] #stores the current room and the past 3 rooms
var room = 6 #current Evil room
var in_Vent :bool= false 
var Cam_chance #chance of not moving to the room being checked
var Vent_move_chance #the number generated that has to be less than the cam chance to move away from the room being checked
var room_being_checked #room which Evil will avoid if cams has been on that room for too long
#temps for now but should be replaced with the actual values
var cam_times = [0, 10, 10 , 10 , 10 ,10 , 20 , 10 ,10 ,10 ,10 ,10 ,10 ,10 ,10] 
var Total_cam_time = 100 

var Vent_Office_Attack = false #indicates if Evil is attacking the office from the vent evil should do the opposite
var Vent_Attack = false # chooses if Evil is going through vent or hallway

func _process(delta):
	#sets the global position to her current position
	Global.char_positions[1] = room
	#prevents an infinite value
	if AI_Level > 0:
		#increases the timer
		Evil_Timer += delta 
		memory[0] = room
		#once the timer is greater than the move speed the move attempt is made
		if Evil_Timer > AI_Move_Speed:
			print(room)
			print(memory)
			#resets timer so if statement doesnt repeat
			Evil_Timer = 0
			#generates random int 
			Checker = randi() % 20 + 1
			#if the random int is below the ai level then a move will take place
			if Checker < AI_Level:
				#updates Evil's memory to add the latest event
				memory_update()
				#all movement types
				if in_vent_room() == true:
					Enter_Vent_Chance()
				elif in_Vent == true:
					In_vent_move()
				else:
					Normal_Move()
		if room == 105:
			print(room)
			room = 0
			in_Vent = false
		if room ==0 :
			room = randi()%14 +1
			print("made to office resetting to random")

func Enter_Vent_Chance():
	#generates a random int between 1 and 100
	Vent_move_chance = randi() % 100 + 1 
	#all the room scenarios which attatch to a vent
	if room == 4:
		room_being_checked = 2
		#if vent move chance is lower than the generated camchance it'll move through vent 
		if Vent_move_chance < Cam_time(room_being_checked):
			room = 10
		else:
			room = 2
	#grouped together as they function the same
	elif room == 6 || room == 7:
		if Vent_move_chance < 100 - roundi(10/AI_Level):
			room = 1
			in_Vent = false
		else:
			room = 101
			in_Vent = true
	#grouped together as they function the same
	elif room == 8 || room == 9:
		room_being_checked = 3
		if Vent_move_chance < Cam_time(room_being_checked) :
			room = 101
			in_Vent = true
		else:
			room = 3
	#set of moves where neuro will always go to the vent
	elif room == 12:
		room = 102
		in_Vent = true
	elif room == 13:
		room = 103
		in_Vent = true
	elif room == 14:
		room = 104
		in_Vent = true

func In_vent_move():
	#generates random int between 1 and 100
	Vent_move_chance = randi() % 100 + 1 
	if room == 101:
		room_being_checked = 1
		if Vent_move_chance < Cam_time(room_being_checked):
			in_Vent = false
			if randi()%2 ==0:
				room = 6
			else:
				room = 7
		else:
			room = 2
			in_Vent = false
	#set of moves where she always goes towards the office
	elif room == 102:
		room = 105
	elif room == 103:
		room = 105
	elif room == 104:
		room = 105
	elif room == 105:
		Vent_Office_Attack = true


#simple calculations to check likelyhood of moving into a vent and away from a camera thats been looked at a lot
func Cam_time(RBC):
	Cam_chance = (cam_times[RBC] / Total_cam_time)*100
	for v in memory.size():
		if RBC == memory[v]:
			Cam_chance += 50
	return Cam_chance
#checks if evil is in a vent room or not 
func in_vent_room():
	for i in ventConnection.size():
		if ventConnection[i] == room:
			return true
	return false
#basic movement for non vent movement
func Normal_Move():
	if room == 1:
		#randomly attacks door or vent needs to be changed to make sure its opposite of neuro
		Checker = randi() %2
		if Checker == 1:
			Vent_Attack = true
		else: 
			Vent_Attack = false
		if Vent_Attack == true:
			Checker = randi() %3
			if Checker == 0:
				room = 12
			elif Checker == 1:
				room = 13
			else:
				room = 14
		else:
			room = 0
	elif room == 2:
		Checker = randi() % 100 +1
		if Checker  < 3:
			room = 3
		elif Checker < 7:
			room = 101
		elif Checker <10:
			room = 4
		else: room = 1
	elif room == 3:
		#very long and convoluted nested if to basically check probability of evil moving away from position 2 and away from position 11 
		Checker = randi() % 100 +1
		if Checker < cam_times[2]/(cam_times[2]+cam_times[8]+cam_times[9]+cam_times[11])*100:
			Checker = randi() % 100 +1
			if Checker < cam_times[11]/(cam_times[11]+cam_times[8]+cam_times[9]):
				if Checker % 2 == 1:
					room = 8
				else:
					room = 9
			else:
				room = 11
		else:
			room = 2
	elif room == 5:
		room = 4
	elif room == 10:
		room = 1
	elif room == 11:
		room = 1
#updates her memory
func memory_update():
	memory[3] = memory[2]
	memory[2] = memory[1]
	memory[1] = room
