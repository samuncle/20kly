extends Control


var CURRENT_DAY = 0
var CURRENT_HOUR = 0
var GAME_SPEED = 1.5

func _ready():
	set_process(true)
	
func _process(delta):
	CURRENT_HOUR += (delta * GAME_SPEED)
	
	
	if CURRENT_HOUR > 24:
		CURRENT_HOUR = 0
		CURRENT_DAY += 1
	
	get_node("timekeeper/data").set_text(
		"Day: " + str(CURRENT_DAY) + " Hours: " + str(round(CURRENT_HOUR)))

