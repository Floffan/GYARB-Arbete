extends Node2D

var going_out = false

var minigame_path = "res://Scenes/Minigames/Benchpress.tscn"

func _on_Skelett_gate_detected():
	var menu_player = get_node_or_null("Camera2D/CanvasLayer/Gate_menu")
	
	if Input.is_action_just_pressed("ui_accept"):
		menu_player.walking_out = null
		
	if going_out == true:	
		menu_player.on_walkout("stad_Gym","res://Scenes/Stad/Stad.tscn" , "out")
			
	if Input.is_action_just_pressed("ui_accept"):
		going_out = true
		if menu_player:
			menu_player.on_walkout("main_Gym", "res://Scenes/Main/World.tscn", "out")
	
func _on_Skelett_NPC_detected():
	var path = ""
	var collider = $YSort/Skelett/NPC_detector.get_collider().name
	var dialog_player = get_node("Camera2D/CanvasLayer/Dialog")
	var minigame_player = get_node("Camera2D/CanvasLayer/minigame_menu")
		
	if collider == "Squat_grodan":
		path = "res://Dialog/Gym/SquatFrog_dia.json"
	if collider == "Curl_grodan":
		path = "res://Dialog/Gym/CurlFrog_dia.json"
	if collider == "Polack_padda":
		path = "res://Dialog/Gym/Coach_dia.json"
			
	if Input.is_action_just_pressed("ui_accept") and dialog_player.dialog_running == false:
		dialog_player.play_dialog(path, 0.05, "1")
		minigame_player.menu_active = true
		
	if minigame_player.menu_active and collider == "Polack_padda":
		minigame_player.play_minigame(minigame_path)
	else:
		minigame_player.menu_active = false
			
