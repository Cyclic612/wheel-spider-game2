extends CharacterBody2D
class_name Enemy

const SPEED = 300.0
const ACCELERATION = 0.05
@export var player : Node2D
var health : int = 15
var damage : int = 10

func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	var top_speed = direction * SPEED
	
	velocity = velocity.lerp(top_speed, ACCELERATION)
	

	move_and_slide()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area is Orb:
		health -= 5
		area.queue_free()
		velocity = Vector2.ZERO
		if health == 0:
			queue_free()
