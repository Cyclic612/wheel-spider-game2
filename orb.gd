extends Area2D
class_name Orb

var speed = 2000.0
var direction : Vector2 = Vector2.ZERO
var velocity : Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	translate(speed * direction * delta)
