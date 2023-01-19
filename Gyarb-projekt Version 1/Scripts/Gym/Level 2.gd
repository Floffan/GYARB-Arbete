extends Node2D

var going_out = false

func _on_Skelett_gate_detected():
	var menu_player = get_node_or_null("Camera2D/Gate_menu")
	
	if Input.is_action_just_pressed("ui_accept"):
		menu_player.walking_out = null
		
	if going_out == true:	
		menu_player.on_walkout("main_Gym", "res://Scenes/Main/World.tscn", "out")
			
	if Input.is_action_just_pressed("ui_accept"):
		going_out = true
		if menu_player:
			menu_player.on_walkout("main_Gym", "res://Scenes/Main/World.tscn", "out")
	

func _on_Skelett_NPC_detected():
	var path = ""
	var collider = $YSort/Skelett/NPC_detector.get_collider().name
	if Input.is_action_just_pressed("ui_accept"):
		if collider == "Squat_grodan":
			path = "res://Dialog/SquatFrog_dia.json"
		if collider == "Curl_grodan":
			path = "res://Dialog/CurlFrog_dia.json"
		
		var dialog_player = get_node_or_null("Camera2D/Dialog")
		if dialog_player:
			dialog_player.play_dialog(path, 0.05)
