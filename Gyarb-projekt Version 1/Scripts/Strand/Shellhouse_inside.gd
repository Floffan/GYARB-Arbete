extends Node2D

var going_out = false



func _process(delta):
	#self.modulate = Color(0.85,0.81,0,75) cool ppc code
	pass

func _on_Skelett_gate_detected():
	var menu_player = get_node_or_null("Camera2D/CanvasLayer/Gate_menu")
	
	if Input.is_action_just_pressed("ui_accept"):
		menu_player.walking_out = null
		
	if going_out == true:	
		menu_player.on_walkout("strand_Shellhouse","res://Scenes/Strand/Strand.tscn", "out")
			
	if Input.is_action_just_pressed("ui_accept"):
		going_out = true
		if menu_player:
			menu_player.on_walkout("strand_Shellhouse","res://Scenes/Strand/Strand.tscn", "out")
		

func _on_Skelett_NPC_detected():
	var path = "res://Dialog/Strand/Fishman_dia.json"
	var num : int
	if Autoloads.flowers == 3:
		num = 2
	else:
		num = 1
	
	var collider = $YSort/Skelett/NPC_detector.get_collider().name
	var dialog_player = get_node("Camera2D/CanvasLayer/Dialog")
		
	if Input.is_action_just_pressed("ui_accept") and dialog_player.dialog_running == false:
		dialog_player.play_dialog(path, 0.05, num)
	
	
	
	
