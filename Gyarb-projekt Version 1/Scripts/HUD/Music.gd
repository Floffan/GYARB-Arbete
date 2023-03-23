extends CanvasLayer

var play_music = true

var playing_minigame = false

func _process(delta: float) -> void:
	if playing_minigame:
		for node in self.get_children():
			node.playing = false
			
		#$Music_main.playing = false		
		#$Music_2_theme.playing = false

func play_music(theme):
	if play_music:
		if theme == "1":
			$Music_main.playing = true
			$Music_2_theme.playing = false
		if theme == "2":
			$Music_2_theme.playing = true
			$Music_main.playing = false
