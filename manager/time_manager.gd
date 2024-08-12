class_name TimeManager


## Default length of a night in seconds
const default_time_per_nigth: float = 540;


 ## Variation that get's multiplied with the default time 
var variation: float = randf_range(0.8, 1.2);
var time_elapsed: float = 0.0; #time passed in seconds
var is_running: bool = false:
	get: return is_running;
	set(value):
		is_running = value;
		emit_signal("time_running_changed", value);
var time_per_hour: float;
var time_per_night: float;


signal time_running_changed(is_running);


func _ready() -> void:
	time_per_night = default_time_per_nigth * variation;
	time_per_hour = time_per_night / 6;


func _process(delta): #run every game tick
	if is_running: #if time is started
		time_elapsed += delta #update time elapsed
	
	if gethour() >= 8: #if its 8am, end night
		is_running = false #stop time
		
#region This does not belong in this skript
		#if gethour() == 8: #if the current time is 8am
			#Global.current_night += 1 # unlock next night
		#time_elapsed = 0.00 #reset time elapsed#end night
	#Global.current_am = gethour() # update global variable "current_am" to reflect the current time(am)
#endregion


## Returns the current in game hour
func gethour(): return floor(time_elapsed / time_per_hour) + 2;
