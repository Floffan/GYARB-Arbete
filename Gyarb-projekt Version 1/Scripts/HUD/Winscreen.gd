extends Control
var game_path = ""
var world_path = ""

func win():
	self.visible = true
	$AnimationPlayer.play("WIN")
	$Hurray.play()

func _on_Spela_igen_button_down():
	Transition.load_scene(game_path)

func _on_tillbaka_button_down():
	Transition.load_scene(world_path)
