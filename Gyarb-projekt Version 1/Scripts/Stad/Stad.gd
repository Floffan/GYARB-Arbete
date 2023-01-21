extends Node2D

var skelett_position = Autoloads.Position

var going_out = false

func _ready():
	_get_position()
	
	
func _get_position() -> void:
	if skelett_position == "stad_Gym":
		$YSort/Skelett.position = $Positioner/stad_Gym.position
	if skelett_position == "stad_Berg":
		$YSort/Skelett.position = $Positioner/stad_Berg.position

func _on_Skelett_gate_detected():
	#var path = ""
	
	if Autoloads.Gate_collider == "gate_Gym":
		_open_gate_menu("main_Gym", "res://Scenes/Stad/Gym.tscn", "in")
	if Autoloads.Gate_collider == "gate_Berg":
		Autoloads.Position = "berg_Stad"
		Transition.load_scene("res://Scenes/Berg/Berg.tscn")
	if Autoloads.Gate_collider == "gate_Redhouse":
		_go_up_house()
	
func _open_gate_menu(position_in_new_world, path, heading):
	var menu_player = get_node_or_null("Camera2D/Gate_menu")
	
	if Input.is_action_just_pressed("ui_accept"):
		menu_player.walking_out = null
		
	if going_out == true:	
		menu_player.on_walkout(position_in_new_world, path, heading)
			
	if Input.is_action_just_pressed("ui_accept"):
		going_out = true
		if menu_player:
			menu_player.on_walkout(position_in_new_world, path, heading)

func _go_up_house():
	pass

func _on_Skelett_NPC_detected():
	var path = ""
	var collider = $YSort/Skelett/NPC_detector.get_collider().name
	if Input.is_action_just_pressed("ui_accept"):
		if collider == "NPC_Bully":
			path = "res://Dialog/Bully_dia.json"
		if collider == "NPC_sten":
			path = "res://Dialog/Mysterious_stone_dia.json"
		
		var dialog_player = get_node_or_null("Camera2D/Dialog")
		if dialog_player:
			dialog_player.play_dialog(path, 0.05)
