class_name TimeManager

##


## Default length of a night in seconds
const default_time_per_nigth: float = 540;


 ## Variation that get's multiplied with the default time 
var variation: float = randf_range(0.8, 1.2);
var time: float = 0.0; #time passed in seconds
var is_running: bool = false:
	get: return is_running;
	set(value):
		is_running = value;
		emit_signal("time_running_changed", value);
var time_per_hour: float;
var time_per_night: float;


signal time_running_changed(is_running);


func _init() -> void:
	time_per_night = default_time_per_nigth * variation;
	time_per_hour = time_per_night / 6;


func process(delta) -> void:
	if is_running: time += delta;


#region This does not belong in this skript
		#if gethour() == 8: #if the current time is 8am
			#Global.current_night += 1 # unlock next night
		#time = 0.00 #reset time elapsed#end night
	#Global.current_am = gethour() # update global variable "current_am" to reflect the current time(am)
#endregion


## Returns the current in game hour
func gethour() -> int: return floori(time / time_per_hour) + 2;


func hours_since_timestamp(timestamp: float) -> float: return (time - timestamp) / time_per_hour;
