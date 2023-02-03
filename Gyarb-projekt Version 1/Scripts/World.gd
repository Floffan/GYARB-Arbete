extends Node2D
var skelett_position = Autoloads.Position

var going_out = false
var interacting = false
var question = ""

func _ready():
	_get_position()
	
	
func _get_position() -> void:
	if skelett_position == "main_Spawn":
		$YSort/Skelett.position = $Positioner/main_Spawn.position
	if skelett_position == "main_Hedge":
		$YSort/Skelett.position = $Positioner/main_Hedge.position
	if skelett_position == "main_Strand":
		$YSort/Skelett.position = $Positioner/main_Strand.position
	if skelett_position == "main_Berg":
		$YSort/Skelett.position = $Positioner/main_Berg.position
	if skelett_position == "main_Dwelling":
		$YSort/Skelett.position = $Positioner/main_Dwelling.position

func _on_Skelett_gate_detected():
	if Autoloads.Gate_collider == "gate_Dwelling":
		_open_gate_menu("main_Dwelling","res://Scenes/Main/Dwelling.tscn" , "in")
	if Autoloads.Gate_collider == "gate_Hedge":
		_open_gate_menu("main_Hedge","res://Scenes/Main/Hedge.tscn", "in")
	if Autoloads.Gate_collider == "gate_Berg":
		Autoloads.Position = "berg_Main"
		Transition.load_scene("res://Scenes/Berg/Berg.tscn")
		#_open_gate_menu("berg", "res://Scenes/Berg/Berg.tscn", "here")
	if Autoloads.Gate_collider == "gate_Strand":
		Autoloads.Position = "strand_Main"
		Transition.load_scene("res://Scenes/Strand/Strand.tscn")
	
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

func _on_Skelett_NPC_detected():
	var path = ""
	var collider = $YSort/Skelett/NPC_detector.get_collider().name
	var dialog_player = get_node("Camera2D/Dialog")
	
	if collider == "NPC_Bully":
		path = "res://Dialog/Bully_dia.json"
	if collider == "NPC_sten":
		path = "res://Dialog/Mysterious_stone_dia.json"
		
	if Input.is_action_just_pressed("ui_accept") and dialog_player.dialog_running == false:
		dialog_player.play_dialog(path, 0.05)

func _on_Skelett_Interaction_detected():
	var collider = $YSort/Skelett/Interact_detector.get_collider().name
	
	if collider == "Blomma_red":
		question = "Plocka blomman?"
		_on_Interact()
		
func _on_Interact():
	var menu_player = get_node("Camera2D/Object_interation_menu")
	
	if Input.is_action_just_pressed("ui_accept"):
		menu_player.pressed_yes = null
		
	if interacting == true:	
		menu_player.on_interaction(question, "flower")
			
	if Input.is_action_just_pressed("ui_accept"):
		interacting = true
		menu_player.on_interaction(question, "flower")

func _on_Object_interation_menu_pick_up():
	Autoloads.flowers += 1
	$YSort/Blomma_red.visible = false
	$Camera2D/Object_interation_menu.pressed_yes = false
