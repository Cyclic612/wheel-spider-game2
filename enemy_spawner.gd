extends Node2D

@export var enemy_prefab : PackedScene
@export var target : Node2D
@export var time_label : Control

func _ready():
	time_label.MoreEnemies.connect(_update)

func _on_timer_timeout() -> void:
	var enemy = enemy_prefab.instantiate()
	
	var random_x = randi_range(0, 1152)
	var random_y = randi_range(0, 648)
	enemy.position = Vector2(random_x, random_y)
	
	enemy.player = target
	add_child(enemy)
	
func _update():
	print("stuff")
