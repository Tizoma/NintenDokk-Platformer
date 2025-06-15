extends Node

var deaths = 0
var time = 0
var in_game = false
var lastCheckpoint

var timer = Timer.new()

func _ready():
	add_child(timer)
	timer.start(1)
	timer.timeout.connect(on_timer_timeout)

func _process(delta):
	if DisplayServer.is_touchscreen_available():
		DisplayServer.screen_set_orientation(DisplayServer.SCREEN_SENSOR_LANDSCAPE)
func on_timer_timeout():
	if(in_game):
		time=time+1
	timer.start(1)
	#print(time)
