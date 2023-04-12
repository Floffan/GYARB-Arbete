extends Control

var current_info

func _process(_delta):
	"""
	Om mellanslags trycks in så visas alla bokstäver, även om de ej hunnit skrivas ut.
	"""
	if Input.is_action_just_pressed("ui_accept"):
		$INFO.visible_characters = len($INFO.text)
		
func display_info(info):
	"""
	Informationen visas.
	Boksväverna kommer up en och en på panelen.
	"""
	current_info = info
	self.visible = true
	$INFO.bbcode_text = info
	while $INFO.visible_characters < len($INFO.text):
		$INFO.visible_characters += 1
		
		$Timer.start()
		yield($Timer, "timeout")
