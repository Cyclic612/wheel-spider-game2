extends TextureProgressBar

@export var player : Node2D

func _ready():
	player.healthChanged.connect(_update)
	_update()

func _update():
	value = (player.current_health * 100) / player.max_health
