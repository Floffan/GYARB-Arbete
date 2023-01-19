extends Node2D

var going_out = false

func _process(delta):
	print(Autoloads.Position)
	



func _on_Skelett_NPC_detected():
	var path = "res://Dialog/Mouse_dia.json"
	if Input.is_action_just_pressed("ui_accept"):
		var dialog_player = get_node_or_null("Camera2D/Dialog")
		var minigame_menu = get_node_or_null("Camera2D/minigame_menu")
		
		if dialog_player:
			dialog_player.play_dialog(path, 0.05)
			"""
			lista ut ett sätt för dialogplayern att visa sin meny, så att spelare kan spela spelet OM de vill
			"""
			if dialog_player.visible == false:
				if minigame_menu:
					minigame_menu.play_minigame("res://Scenes/Minigames/Bollplank.tscn")


func _on_Skelett_gate_detected():
	Autoloads.Position = "berg_Grotta"
	Transition.load_scene("res://Scenes/Berg/Berg.tscn")
