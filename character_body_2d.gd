extends CharacterBody2D

# Variable initialization for movement and dashing
const SPEED : float = 500.0
const DASH_SPEED : float = 1500.0
const ACCELERATION : float = 0.05
var dashing : bool = false
var can_dash : bool = true

# Variable initialization for grappling
# BIG IMPORTANT NOTE: grappling will not work until tileset is added
# DO NOT use obstacle2d or any of the other experimental stuff, i don't
# know how to implement that into this code or how they work at all
@export var swing_speed : float = 600.0
var is_grappling : bool = false
var grapple_point : Vector2 = Vector2.ZERO
var rope_length : float = 0.0
@onready var rope_line : Line2D = $GrappleLine

func _physics_process(delta: float) -> void:
	# Takes movement inputs and gives player ice physics with a lerp
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if is_grappling:
		_process_grapple_swing(direction, delta)
	else:
		_process_normal_movement(direction)
		
	_handle_grapple_input()
	
	# Starts dash
	if Input.is_action_just_pressed("dash") and can_dash:
		dashing = true
		can_dash = false
		$DashCooldown.start()
		$DashDuration.start()
	
	move_and_slide()
	_update_rope_visual()
	
# Ends dash
func _on_dash_timer_timeout() -> void:
	dashing = false


func _on_dash_cooldown_timeout() -> void:
	can_dash = true

func _process_normal_movement(direction : Vector2):
	var top_speed = Vector2.ZERO
	
	if dashing:
		top_speed = DASH_SPEED * direction
	else:
		top_speed = SPEED * direction
		
	velocity = velocity.lerp(top_speed, ACCELERATION)

# handles the actual swinging physics of the grapple
func _process_grapple_swing(direction : Vector2, delta : float):
	var to_anchor = grapple_point - global_position
	var current_distance = to_anchor.length()
	
	if direction != Vector2.ZERO:
		var rope_tangent = to_anchor.orthogonal().normalized()
		if direction.dot(rope_tangent) < 0:
			rope_tangent = -rope_tangent
		velocity += rope_tangent * swing_speed * delta
		
	var rope_direction = to_anchor.normalized()
	var velocity_along_rope = velocity.dot(rope_direction)
	
	velocity -= rope_direction * velocity_along_rope
	
	if current_distance > rope_length:
		global_position = grapple_point - rope_direction * rope_length

# updates the raycast when the grapple button is hit to check for a valid
# object, and starts grappling if there is.
func _handle_grapple_input():
	if Input.is_action_just_pressed("grapple"):
		var raycast: RayCast2D = $GrappleRayCast
		raycast.look_at(get_global_mouse_position())
		raycast.force_raycast_update()
		
		if raycast.is_colliding():
			grapple_point = raycast.get_collision_point()
			rope_length = global_position.distance_to(grapple_point)
			is_grappling = true
			dashing = false
			
	if Input.is_action_just_released("grapple"):
		is_grappling = false

# Shows the actual grapple web with a Line2D
func _update_rope_visual():
	if is_grappling and has_node("GrappleLine"):
		rope_line.visible = true
		rope_line.clear_points()
		rope_line.add_point(Vector2.ZERO)
		rope_line.add_point(to_local(grapple_point))
	elif has_node("GrappleLine"):
		rope_line.visible = false
	
