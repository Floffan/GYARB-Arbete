extends Node2D
	
func _on_Skelett_NPC_detected():
	var path = "res://Dialog/Mouse_dia.json"

	var dialog_player = get_node("Camera2D/Dialog")
	var minigame_menu = get_node("Camera2D/minigame_menu")
		
	if Input.is_action_just_pressed("ui_accept") and dialog_player.dialog_running == false:
		dialog_player.play_dialog(path, 0.05)
		
		#minigame_menu.play_minigame("res://Scenes/Minigames/Bollplank.tscn")

func _on_Skelett_gate_detected():
	Autoloads.Position = "berg_Grotta"
	Transition.load_scene("res://Scenes/Berg/Berg.tscn")
