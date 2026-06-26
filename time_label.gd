extends Label

@export var timer : Timer
signal MoreEnemies

func _process(_delta):
	var time_left = int(timer.time_left)
	var minutes = time_left / 60
	var seconds = time_left % 60
	
	text = "%02d:%02d" % [minutes, seconds]
