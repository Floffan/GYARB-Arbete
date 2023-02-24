extends Node2D

var skelett_position = Autoloads.Position

var going_out = false
var interacting = false

var question = ""

onready var ui_cutscene_panels = $Camera2D/CanvasLayer/Panels_cutscene/AnimationPlayer

func _ready():
	_get_position()
	
	
func _get_position() -> void:
	if skelett_position == "stad_Gym":
		$YSort/Skelett.position = $Positioner/stad_Gym.position
	if skelett_position == "stad_Berg":
		$YSort/Skelett.position = $Positioner/stad_Berg.position

func _on_Skelett_gate_detected():
	if Autoloads.Gate_collider == "gate_Gym":
		_open_gate_menu("main_Gym", "res://Scenes/Stad/Gym.tscn", "in")
	if Autoloads.Gate_collider == "gate_Berg":
		Autoloads.Position = "berg_Stad"
		Transition.load_scene("res://Scenes/Berg/Berg.tscn")
	if Autoloads.Gate_collider == "gate_Redhouse":
		_house_movement("in")
	if Autoloads.Gate_collider == "gate_Balkong":	
		_house_movement("out")
	
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

func _house_movement(heading):
	if heading == "in":
		question = "Gå in i huset?"
	if heading == "out":
		question = "Gå ner på gatan?"
		
	var menu_player = get_node("Camera2D/CanvasLayer/Object_interation_menu")
	
	if Input.is_action_just_pressed("ui_accept"):
		menu_player.visible = true
		menu_player.pressed_yes = null
		
	if interacting == true:	
		menu_player.on_interaction(question, heading)
			
	if Input.is_action_just_pressed("ui_accept"):
		interacting = true
		menu_player.on_interaction(question, heading)

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
			
func _on_Skelett_Interaction_detected():
	var collider = $YSort/Skelett/Interact_detector.get_collider().name
	
	if collider == "Blomma_red":
		question = "Plocka blomman?"
		_on_Interact()
		
func _on_Interact():
	var menu_player = get_node("Camera2D/CanvasLayer/Object_interation_menu")
	
	if Input.is_action_just_pressed("ui_accept"):
		menu_player.pressed_yes = null
		
	if interacting == true:	
		menu_player.on_interaction(question, "flower")
			
	if Input.is_action_just_pressed("ui_accept"):
		interacting = true
		menu_player.on_interaction(question, "flower")

func _on_Object_interation_menu_pick_up():
	Autoloads.flowers += 1
	$YSort/Hus/Sprite/Blomma_red.visible = false
	$Camera2D/CanvasLayer/Object_interation_menu.pressed_yes = false

func _on_Object_interation_menu_walk_in():
	$Camera2D/CanvasLayer/Object_interation_menu.visible = false
	ui_cutscene_panels.play_backwards("ready")
	$AnimationPlayer.play("Red_house_visit")
	$Camera2D/CanvasLayer/Object_interation_menu.pressed_yes = false

func _on_AnimationPlayer_animation_finished(anim_name):
	ui_cutscene_panels.play("ready")

func _on_Object_interation_menu_walk_out():
	$Camera2D/CanvasLayer/Object_interation_menu.visible = false
	ui_cutscene_panels.play_backwards("ready")
	$AnimationPlayer.play_backwards("Red_house_visit")
	$Camera2D/CanvasLayer/Object_interation_menu.pressed_yes = false
