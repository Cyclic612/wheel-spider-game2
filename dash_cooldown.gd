extends TextureProgressBar

signal dashReplenished

@export var timer : Timer
@export var cooldown : float = 5.0
@export var player : Node2D
var started : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	max_value = 100.0
	value = 0.0
	timer.wait_time = cooldown
	

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("dash"):
		timer.start()
		started = true
		visible = true
	if not timer.is_stopped():
		var percentage: float = (timer.time_left / cooldown) * 100.0
		value = percentage
	else:
		visible = false
		if started == true:
			emit_signal("dashReplenished")
