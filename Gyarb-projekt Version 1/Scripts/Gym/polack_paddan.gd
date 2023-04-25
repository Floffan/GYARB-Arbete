extends AnimatedSprite

func _ready():
	"""
	Timern startar i början, och framesen körs ej
	"""
	playing = false
	$Timer.start()

func _on_Timer_timeout():
	"""
	Animationen körs när tiden tar slut, och timer 2 startas
	"""
	playing = true
	$Timer2.start()

func _on_Timer2_timeout():
	"""
	När timer2-tiden är slut så börjar animationen spelas igen
	"""
	playing = false
