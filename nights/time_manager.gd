extends Node #extends current node

var time_elapsed: float = 0.0 #time passed since starting (irl)
var variation: float = randf_range(-0.2, 0.2) #the variation added/removed from the total amount of time 
var default_night_time: float = 16 #16 for testing, use 540 for real time
var time_per_hour: float = 0.0 #time per hour
var started: = false #is time started

func _ready(): #when node is ready
	variation = randf_range(-0.2, 0.2) #set random variation
	started = true #start time
	time_elapsed = 0.0 #resets time elapsed
	print("Time starting") #print to console that time is starting

func gethour(): #gets current time as am (without "am")
	return floor(time_elapsed / time_per_hour) + 2 # get the current time(am) and add 2 (cus night starts at 2am)

func _process(delta): #run every game tick
	if started: #if time is started
		time_elapsed += delta #update time elapsed
		time_per_hour = (default_night_time / 6) * (1 + variation) #update time per hour to reflect variation and other changes
		
		#for testing, comment when not needed
		#print(gethour(), " AM", "[", round(time_per_hour * 100.0) / 100.0, "s]", "{", round((variation * 100) * 100.0) / 100.0, "%} (", round(time_elapsed * 100.0) / 100.0, ")")
		
	if gethour() >= 8: #if its 8am, end night
		print("night ending") #print to console that the night is ending
		started = false #stop time
		if gethour() == 8: #if the current time is 8am
			Global.current_night = Global.current_night + 1 # unlock next night
			print("Night unlocked: ",Global.current_night) #print that a new night was unlocked
		time_elapsed = 0.00 #reset time elapsed#end night
	Global.current_am = gethour() # update global variable "current_am" to reflect the current time(am)
