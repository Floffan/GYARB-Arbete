extends Node2D

var going_out = false

onready var ui_gate = get_node("Camera2D/CanvasLayer/Gate_menu")
onready var ui_dialog = get_node("Camera2D/CanvasLayer/Dialog")

onready var ui_new_item = get_node("Camera2D/CanvasLayer/New_item")

var dia_character = "Fishman"
var dia_location = "Strand"
var dia_num : int

var item = "Key"

func _on_Skelett_gate_detected():
	if Input.is_action_just_pressed("ui_accept"):
		ui_gate.walking_out = null
		
	if going_out == true:	
		ui_gate.on_walkout("strand_Shellhouse","res://Scenes/Strand/Strand.tscn", "out")
			
	if Input.is_action_just_pressed("ui_accept"):
		going_out = true
		ui_gate.on_walkout("strand_Shellhouse","res://Scenes/Strand/Strand.tscn", "out")
		
func _on_Skelett_NPC_detected():
#	if Autoloads.data["flowers"] == 3:
#		#Autoloads.add_flower()
#		if Autoloads.data["items"].has(item):
#			dia_num = 3
#		if Autoloads.data["items"].has(item) == false:
#			dia_num = 2
#	else:
#		dia_num = 1
		
	Autoloads.data["items"].has("key")
		
	if len(Autoloads.data["flowers"]) == 3:
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
	else:
		dia_num = 1
		
	if Input.is_action_just_pressed("ui_accept") and ui_dialog.dialog_running == false:
		ui_dialog.play_dialog(dia_character, dia_location, dia_num)
