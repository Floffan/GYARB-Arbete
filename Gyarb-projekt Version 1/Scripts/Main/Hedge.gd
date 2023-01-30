extends Node2D

var path = "res://Dialog/tutorial/Case_holder_dia.json"
var interacting = false

var question = "Ställ väskan här?"


func _on_Skelett_NPC_detected():
	var collider = $YSort/Skelett/NPC_detector.get_collider().name
	var dialog_player = get_node("Camera2D/Dialog")
	if Input.is_action_just_pressed("ui_accept") and dialog_player.dialog_running == false:
		dialog_player.play_dialog(path, 0.05)

func _on_Skelett_gate_detected():
	var menu_player = get_node("Camera2D/Object_interation_menu")
	
	#if Input.is_action_just_pressed("ui_accept"):
		#menu_player.walking_out = null
		
	if interacting == true:	
		menu_player.on_interaction(question)
			
	if Input.is_action_just_pressed("ui_accept"):
		interacting = true
		menu_player.on_interaction(question)
