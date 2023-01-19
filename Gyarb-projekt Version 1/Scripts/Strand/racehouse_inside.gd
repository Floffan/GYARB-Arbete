extends Node2D

func _on_Skelett_NPC_detected():
	var collider = $YSort/Skelett/NPC_detector.get_collider().name
	if Input.is_action_just_pressed("ui_accept"):
		var path = "res://Dialog/Squid_dia.json"
		
		var dialog_player = get_node_or_null("Camera2D/Dialog")
		var minigame_menu = get_node_or_null("Camera2D/minigame_menu")
		if dialog_player:
			dialog_player.play_dialog(path, 0.05)
			
			if dialog_player.visible == false:
				if minigame_menu:
					minigame_menu.play_minigame("res://Scenes/Minigames/Boatrace.tscn")
