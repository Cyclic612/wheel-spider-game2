extends Node2D

@export var player : Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.gameOver.connect(_gameEnd)
	
func _gameEnd():
	var tween = create_tween()
	var death_color = Color("#303040") 
	
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS) 
	tween.tween_property($CanvasModulate, "color", death_color, 2.0)
	
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)

	await tween.finished
	
	$player/death_screen.visible = true
