class_name AIManager


var catber: CatberAI = preload("res://ai/catber.gd").new();

#const max_ai:int = 20 #max ai level
#var ai_levels:Array[int] = [20] #levels of agro, defaults to 0(disabled) 
#var ai_move_speeds:Array[float] = [1]
#var ais_moving:Array[bool] = [false] #if ais are moving or not
#var ai_positions:Array[int]= [Global.room_mapping.ART,0,0,0,0] #ai positions
#var ai_move_timers:Array[float] = [0.0] #time between ai's last move
#const room_connection:Array[Array] = [ [1] , [0,2,6,7] , [1,4,3] , [2,8,9] , [2,5] , [4] , [1] , [1] , [3] , [3] ]
#var default_kill_Time = 10 #default delay before death
#signal purrbert_updated


func process(delta: float) -> void:
	catber.process(delta);


#func move_to(room_id,ai_id):
	#ai_positions[ai_id] = room_id
	#return ai_positions[ai_id]
#
#func get_pos(ai_id): return ai_positions[ai_id]
