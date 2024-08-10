extends Node

var is_splash_screen_enabled: = false #the variable to control if the splash screen is shown on startup, defaults to true

var splash_has_played: = false  # Flag to track if the splash screen has been played

var current_night: = 1 # current night, defaults to wan

var current_am: int # current am, doesn't need to default to anything 

@export var selected_cam:= 0

var previous_cam: int
