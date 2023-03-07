extends Node2D

onready var minigame_path = "res://Scenes/Minigames/Boatrace.tscn"

onready var ui_dialog = get_node("Camera2D/CanvasLayer/Dialog")
onready var ui_minigame = get_node("Camera2D/CanvasLayer/minigame_menu")

onready var ui_new_item = get_node("Camera2D/CanvasLayer/New_item")

var going_out = false

var dia_num : int
var dia_character = "Squid"
var dia_location = "Strand"

var item = "Medal"

func _on_Skelett_NPC_detected():
	if Autoloads.data["games_played"].has("Boatrace"):
		if dia_num == 2 and ui_dialog.dialog_running == false:
			ui_new_item.on_new_item(item)
			Autoloads.add_item(item)
			dia_num = 3
		if Autoloads.data["items"].has(item):
			dia_num = 3
		if Autoloads.data["items"].has(item) != true:
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
	Autoloads.Position = "strand_Racehouse"
	Transition.load_scene("res://Scenes/Strand/Strand.tscn")
