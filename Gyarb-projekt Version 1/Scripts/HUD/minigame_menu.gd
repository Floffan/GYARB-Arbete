extends Control
var playing_game



func _ready():
	#playing_game = false
	self.visible = false
	
func play_minigame(path):
	print("oahahahaha")
	#self.visible = true
	#if playing_game == true:
	Transition.load_scene(path)


func _on_YES_button_up():
	playing_game = true


func _on_NO_button_down():
	playing_game = false
	self.visible = false
