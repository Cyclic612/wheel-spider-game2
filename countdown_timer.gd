extends Timer

func _ready():
	$CountdownTimer.start()

func _process(_delta):
	$TimeLabel.text = str(int($TimeLabel.time_left))
