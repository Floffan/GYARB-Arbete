extends AnimatedSprite



func _ready():
	playing = false
	$Timer.start()

func _on_Timer_timeout():
	playing = true
	$Timer2.start()

func _on_Timer2_timeout():
	playing = false
