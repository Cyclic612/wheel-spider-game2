extends Marker2D

var orb_prefab = preload("res://orb.tscn")
@export var player : Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Finds which direction the orb will be shot
	var direction = global_position.direction_to(get_global_mouse_position())
		
	# Shoots orbs from the player when the corresponding button is pressed
	if Input.is_action_pressed("shoot_orb") and $OrbCooldown.is_stopped():
		$OrbCooldown.start()
		$OrbSFX.play()
		var orb = orb_prefab.instantiate()
		orb.position = global_position
		orb.direction = direction
		get_tree().root.add_child(orb)
		
		
