extends Control

@export var timer : Node
@export var label : Control

func _ready():
	timer.start()
