extends Node2D
	
var skelett_position = Autoloads.Position

onready var minigame_path = "res://Scenes/Minigames/Bollplank.tscn"

onready var ui_dialog = get_node("Camera2D/CanvasLayer/Dialog")
onready var ui_minigame = get_node("Camera2D/CanvasLayer/minigame_menu")

onready var ui_new_item = get_node("Camera2D/CanvasLayer/New_item")

var dia_location = "Berg"
var dia_character = "Mouse"
var dia_num : int

var item = "Shirt"

func _on_Skelett_NPC_detected():
	#if Autoloads.areas_visited.has("Grotta") == false:
	#	dia_num = 1
	if Autoloads.games_played.has("Bollplank"):
		if dia_num == 2 and ui_dialog.dialog_running == false:
			ui_new_item.on_new_item("Shirt")
			Autoloads.Items.append("Shirt")
			dia_num = 3
		if Autoloads.Items.has("Shirt"):
			dia_num = 3
		if Autoloads.Items.has("Shirt") != true:
			dia_num = 2
			if ui_dialog.dialog_running == false:
				ui_dialog.play_dialog(dia_character, dia_location, dia_num)
				ui_minigame.menu_active = false
	else:
		dia_num = 1
	
	if Input.is_action_just_pressed("ui_accept") and ui_dialog.dialog_running == false:
		ui_dialog.play_dialog(dia_character, dia_location, dia_num)
		ui_minigame.menu_active = true

	if ui_minigame.menu_active and dia_num != 2:
		ui_minigame.play_minigame(minigame_path)
		
func _on_Skelett_gate_detected():
	Autoloads.Position = "berg_Grotta"
	Transition.load_scene("res://Scenes/Berg/Berg.tscn")
	
func _get_position():
	if skelett_position == "grotta_Berg":
		$YSort/Skelett.position = $Positioner/grotta_Berg.position
	if skelett_position == "grotta_Minigame":
		$YSort/Skelett.position = $Positioner/grotta_Minigame.position
		
func _ready():
	_get_position()
		
