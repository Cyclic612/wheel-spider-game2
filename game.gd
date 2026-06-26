extends Node2D

@export var player : Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.gameOver.connect(_gameEnd)
	$Music.play()
	
func _gameEnd():
	var tween = create_tween()
	var death_color = Color.DARK_RED
	
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS) 
	tween.tween_property($CanvasModulate, "color", death_color, 2.0)
	
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)

	await tween.finished
	
	$player/death_screen.visible = true


func _on_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://main_menu.tscn")


func _on_countdown_timer_timeout() -> void:
	get_tree().paused = true
	
	$player/win_screen.visible = true


func _on_menu_button_2_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://main_menu.tscn")
