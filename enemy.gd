extends CharacterBody2D
class_name Enemy

const SPEED = 300.0
const ACCELERATION = 0.05
@export var player : Node2D


func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	var top_speed = direction * SPEED
	
	velocity = velocity.lerp(top_speed, ACCELERATION)
	

	move_and_slide()
