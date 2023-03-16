extends Node2D
var skelett_position = Autoloads.Position
onready var skelett = get_node("YSort/Skelett")

var going_out = false
var interacting = false
var question = ""

onready var interact_ui = $Camera2D/CanvasLayer/Object_interation_menu 
onready var gate_ui = $Camera2D/CanvasLayer/Gate_menu
onready var dialog_ui = $Camera2D/CanvasLayer/Dialog

onready var ui_new_item = get_node("Camera2D/CanvasLayer/New_item")

var dia_character = ""
var dia_location = "Tutorial"
var dia_num : int

var num = 0

func _ready():
	Music.play_music("1")
	_get_position()
	$Havet/Lager1.position.x = 3118
	$Havet/Lager1.position.y = 1980
	
	$Havet/Lager1/Sprite.position.x = 0
	$Havet/Lager1/Sprite.position.y = 0
	
func _process(delta: float) -> void:
	$Havet/Lager1.motion_offset.x += -50*delta
	
func _get_position() -> void:
	#$YSort/Skelett.position = get_node("Positioner").get_node(str(skelett_position)).position
	
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
	if Autoloads.Gate_collider == "gate_Spawn":
		_open_gate_menu("spawn_Main","res://Scenes/Main/Spawn.tscn", "in")
	if Autoloads.Gate_collider == "gate_Strand":
		Autoloads.Position = "strand_Main"
		Transition.load_scene("res://Scenes/Strand/Strand.tscn")
		
	
func _open_gate_menu(position_in_new_world, path, heading):
	#if skelett.can_move == true:
		#gate_ui.on_walkout(position_in_new_world, path, heading)
		
	#if gate_ui.on_walkout(position_in_new_world, path, heading):
	if Input.is_action_just_pressed("ui_accept"):
		gate_ui.walking_out = null
		
	if going_out == true:	
		gate_ui.on_walkout(position_in_new_world, path, heading)
			
	if Input.is_action_just_pressed("ui_accept"):
		going_out = true
		gate_ui.on_walkout(position_in_new_world, path, heading)
	"""
	if gate_ui.menu_showing == false:
		gate_ui.menu_showing = true
		gate_ui.on_walkout(heading)
		
	if gate_ui.walking_out:
		print(position_in_new_world)
		print(path)
		gate_ui.walk_out(position_in_new_world, path)
	"""

	"""
	if Input.is_action_just_pressed("ui_accept"):
		gate_ui.walking_out = null
		
	if going_out == true:	
		gate_ui.on_walkout(position_in_new_world, path, heading)
			
	if Input.is_action_just_pressed("ui_accept"):
		going_out = true
		gate_ui.on_walkout(position_in_new_world, path, heading)
	"""

func _on_Skelett_NPC_detected():
	var collider = $YSort/Skelett/NPC_detector.get_collider().name
	dia_location = "Main"

	if collider == "NPC_Bully":
		dia_character = "Bully"
		dia_num = 1
	if collider == "NPC_sten":
		dia_character = "Mysterious_stone"
		dia_num = 1
		
	if Input.is_action_just_pressed("ui_accept") and dialog_ui.dialog_running == false:
		dialog_ui.play_dialog(dia_character, dia_location, dia_num)

func _on_Skelett_Interaction_detected():
	var collider = $YSort/Skelett/Interact_detector.get_collider().name
	
	if collider == "Blomma_red":
		question = "Plocka blomman?"
		_on_Interact()
		
func _on_Interact():
	if Input.is_action_just_pressed("ui_accept"):
		interact_ui.pressed_yes = null
		
	if interacting == true:	
		interact_ui.on_interaction(question, "flower")
			
	if Input.is_action_just_pressed("ui_accept"):
		interacting = true
		interact_ui.on_interaction(question, "flower")

func _on_Object_interation_menu_pick_up():
	Autoloads.add_flower()
	ui_new_item.on_new_item("Flower")
	$YSort/Blomma_red.visible = false
	$Camera2D/CanvasLayer/Object_interation_menu.pressed_yes = false


func _on_Bully_checkpoint_body_entered(body):
	get_node("Bully").queue_free()
	get_node("Bully_checkpoint").queue_free()
