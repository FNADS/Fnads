extends Node
var AI_Level :int= 20
var Ai_Move_Speed = 5
const x = 20  #max ai level before move speed changes
var door_Time = 0 #time till attack
var Cat_Timer = 0 #timer between move attempts
var Checker   #stores a random integer
var moving:= false #checks if she is moving could be boolean
var room_Connection = [ [1] , [0,2,6,7] , [1,4,3] , [2,8,9] , [2,5] , [4] , [1] , [1] , [3] , [3] ] #all room connections catber can go to
var undestroyed = [0,0,0,0,1,1,0,1,0,1] #1 = undestroyed room etc
var room = 6 #current catber room
var z = 0 #temps for a method
var c = 0
var v = 0
var destroying = 0 #if catber is currently destroying something
var destroy_timer = 0 #timer for when catber will destroy room
var All_Destroyed_Checker = 11 #checks if all rooms are destroyed

#temporary value
var kill_Time = 10
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#sets the global position to her current position
	Global.CharPositons[0] = room
#if she is outside of the room
	if room != 0:
		#coded timer
		Cat_Timer += delta
		if Cat_Timer > Ai_Move_Speed:
			#generates a random integer between 0 and max AI level
			Checker = randi() % x
			#Sets timer to 0 to prevent repeats
			Cat_Timer = 0
			#if the random integer is smaller than the Ai level a move will take place
			if Checker < AI_Level:
				moving = true
		#if the move is taking place
		if moving:
			#goes through all undestroyed rooms
			for i in undestroyed.size():
				#if the current room is undestroyed exits for loop
				if undestroyed[room] == 1:
					i = undestroyed.size()
					destroying = 1
				#else checks if a neighboring room is destroyed
				else:
					z = undestroyed[i]
					if z == 1:
						moveTo(i)
			#if no neighboring rooms are undestroyed default moves towards the hallway 
			if undestroyed[room] == 0:
				if moving:
					match room:
						5: 
							room = 4
							moving = false
						1: 
							await CheckAll()
							room = 2
							moving = false
						2: 
							Dchecker()
							moving = false
						4:
							room = 2
							moving = false
						3:
							room = 2
							moving = false
						6:
							room = 1
							moving = false
						7:
							room = 1
							moving = false
						8:
							room = 3
							moving = false
				print(room)
		moving = false
	#code for destroying a room simple timer till destroyed
	if destroying == 1:
		moving = false
		destroy_timer += delta
		if destroy_timer > 20:
			undestroyed[room] = 0
			destroying = 0
			destroy_timer = 0
	#if she is at the office kill timer needs work once door is done
	if room == 0:
		door_Time += delta
		if door_Time > kill_Time:
			print("add jumpscare here")

func moveTo(X):
	c = room_Connection[room]
	for k in c.size():
		c = room_Connection[room]
		v = c[k]
		if v == X:
			print("found")
			room = v
			print(room)
			return room
#decides if to move to top corridoor or the bottom
func Dchecker():
	c = room_Connection[3]
	for L in c.size():
		if undestroyed[c[L]] == 1:
			room = 3
	if room != 3:
		if undestroyed[5] == 1:
			room = 4
		else:
			room = 1

#checks if she can mpve into the office doorway
func CheckAll():
	All_Destroyed_Checker = 1
	for p in undestroyed.size():
		if undestroyed[p] == 1:
			All_Destroyed_Checker = 0
	if All_Destroyed_Checker == 1:
		room = 0
	else:
		room = 2



