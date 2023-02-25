extends Node2D
	
onready var minigame_path = "res://Scenes/Minigames/Bollplank.tscn"

onready var ui_dialog = get_node("Camera2D/CanvasLayer/Dialog")
onready var ui_minigame = get_node("Camera2D/CanvasLayer/minigame_menu")

var dia_location = "Berg"
var dia_character = "Mouse"
var dia_num : int

func _on_Skelett_NPC_detected():
	dia_num = 1
	
	if Input.is_action_just_pressed("ui_accept") and ui_dialog.dialog_running == false:
		ui_dialog.play_dialog(dia_character, dia_location, dia_num)
		ui_minigame.menu_active = true

	if ui_minigame.menu_active:
		ui_minigame.play_minigame(minigame_path)
		
func _on_Skelett_gate_detected():
	Autoloads.Position = "berg_Grotta"
	Transition.load_scene("res://Scenes/Berg/Berg.tscn")
