class_name TimeManager


var start_time :  int;


func _ready() -> void:
	start_time = Time.get_ticks_msec();
	print(start_time);
