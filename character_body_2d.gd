extends CharacterBody2D

# Variable initialization
const SPEED = 500.0
const DASH_SPEED = 1500.0
const ACCELERATION = 0.05
var dashing = false
var can_dash = true


func _physics_process(delta: float) -> void:
	# Takes movement inputs and gives player ice physics with a lerp
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var top_speed = Vector2.ZERO
	
	# Checks which speed value to use to update the player's velocity
	if dashing:
		top_speed = DASH_SPEED * direction
	else:
		top_speed = SPEED * direction
	velocity = velocity.lerp(top_speed, ACCELERATION)
	
	# Starts dash
	if Input.is_action_just_pressed("dash") and can_dash:
		dashing = true
		can_dash = false
		$DashCooldown.start()
		$DashDuration.start()
	
	move_and_slide()
	
	
# Ends dash
func _on_dash_timer_timeout() -> void:
	dashing = false


func _on_dash_cooldown_timeout() -> void:
	can_dash = true
