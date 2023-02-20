extends Node2D
	
onready var minigame_path = "res://Scenes/Minigames/Bollplank.tscn"

func _on_Skelett_NPC_detected():
	var path = "res://Dialog/Mouse_dia.json"

	var dialog_player = get_node("Camera2D/CanvasLayer/Dialog")
	var minigame_player = get_node("Camera2D/CanvasLayer/minigame_menu")
		
	if Input.is_action_just_pressed("ui_accept") and dialog_player.dialog_running == false:
		dialog_player.play_dialog(path, 0.05, 1)
		minigame_player.menu_active = true

	if minigame_player.menu_active:
		minigame_player.play_minigame(minigame_path)
		
func _on_Skelett_gate_detected():
	Autoloads.Position = "berg_Grotta"
	Transition.load_scene("res://Scenes/Berg/Berg.tscn")
