extends Control


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_button_pressed() -> void:
	$AudioStreamPlayer.play()
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://game.tscn")


func _on_exit_button_pressed() -> void:
	$AudioStreamPlayer.play()
	await get_tree().create_timer(0.5).timeout
	get_tree().quit()
