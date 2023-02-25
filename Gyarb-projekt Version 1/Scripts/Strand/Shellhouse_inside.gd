extends Node2D

var going_out = false

onready var ui_gate = get_node("Camera2D/CanvasLayer/Gate_menu")
onready var ui_dialog = get_node("Camera2D/CanvasLayer/Dialog")

var dia_character = "Fishman"
var dia_location = "Strand"
var dia_num : int

func _on_Skelett_gate_detected():
	if Input.is_action_just_pressed("ui_accept"):
		ui_gate.walking_out = null
		
	if going_out == true:	
		ui_gate.on_walkout("strand_Shellhouse","res://Scenes/Strand/Strand.tscn", "out")
			
	if Input.is_action_just_pressed("ui_accept"):
		going_out = true
		ui_gate.on_walkout("strand_Shellhouse","res://Scenes/Strand/Strand.tscn", "out")
		
func _on_Skelett_NPC_detected():
	
	if Autoloads.flowers == 3:
		dia_num = 2
	else:
		dia_num = 1
	
	var collider = $YSort/Skelett/NPC_detector.get_collider().name
	
	if Input.is_action_just_pressed("ui_accept") and ui_dialog.dialog_running == false:
		ui_dialog.play_dialog(dia_character, dia_location, dia_num)
		
	
	
	
	
