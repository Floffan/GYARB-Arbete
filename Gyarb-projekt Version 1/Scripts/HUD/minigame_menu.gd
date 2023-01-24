extends Control
var playing_game

var menu_active = false

func _ready():
	playing_game = false
	self.visible = false
	
func play_minigame(path):
	self.visible = true
	if playing_game == true:
		Transition.load_scene(path)

func _on_YES_button_up():
	playing_game = true

func _on_NO_button_down():
	playing_game = false
	self.visible = false
	menu_active = false
