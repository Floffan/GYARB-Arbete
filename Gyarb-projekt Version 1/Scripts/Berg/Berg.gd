extends Node2D

var skelett_position = Autoloads.Position

var going_out = false

var cave_access = false

onready var ui_cutscene_panels = get_node("Camera2D/CanvasLayer/Panels_cutscene/AnimationPlayer")

onready var ui_gate = get_node("Camera2D/CanvasLayer/Gate_menu")
onready var ui_interact = get_node("Camera2D/CanvasLayer/Object_interation_menu")
onready var ui_dialog = get_node("Camera2D/CanvasLayer/Dialog")

onready var ui_new_item = get_node("Camera2D/CanvasLayer/New_item")

onready var anim_player_bus_wheels = get_node("Bus/AnimationPlayer_wheel")

# Dialog-variabler (prefix : dia)
var dia_location = "Berg"
var dia_character = ""
var dia_num : int

# Interaction-variabler (prefix : int)
var int_question = ""
var int_object = ""
var interacting = false


func _ready():
	_get_position()
	if Autoloads.Items.has("Key"):
		cave_access = true
		$Bergsfot/Lock.visible = false

func _get_position() -> void:	
	if skelett_position == "berg_Main":
		$YSort/Skelett.position = $Positioner/berg_Main.position
	if skelett_position == "berg_Grotta":
		$YSort/Skelett.position = $Positioner/berg_Grotta.position
	if skelett_position == "berg_Stad":
		$YSort/Skelett.position = $Positioner/berg_Stad.position
	if skelett_position == "berg_Buss":
		pass

func _on_Skelett_gate_detected():
	if Autoloads.Gate_collider == "gate_Main":
		Autoloads.Position = "main_Berg"
		Transition.load_scene("res://Scenes/Main/World.tscn")
		#_open_gate_menu("main_Berg", "res://Scenes/Main/World.tscn", "here")
	if Autoloads.Gate_collider == "gate_Grotta" and cave_access:
		_open_gate_menu("grotta_Berg", "res://Scenes/Berg/Grotta.tscn", "in")
	if Autoloads.Gate_collider == "gate_Stad":
		Autoloads.Position = "stad_Berg"
		Transition.load_scene("res://Scenes/Stad/Stad.tscn")
		
func _open_gate_menu(position_in_new_world, path, heading):
	if Input.is_action_just_pressed("ui_accept"):
		ui_gate.walking_out = null
		
	if going_out == true:	
		ui_gate.on_walkout(position_in_new_world, path, heading)
			
	if Input.is_action_just_pressed("ui_accept"):
		going_out = true
		ui_gate.on_walkout(position_in_new_world, path, heading)
			
func _on_Skelett_Interaction_detected():
	var collider = $YSort/Skelett/Interact_detector.get_collider().name
	
	if collider == "Blomma_red":
		int_question = "Plocka blomman?"
		int_object = "flower"
	
		_on_interact(int_question, int_object)
		
func _on_interact(int_question, int_object):
	if Input.is_action_just_pressed("ui_accept"):
		ui_interact.pressed_yes = null
		
	if interacting == true:	
		ui_interact.on_interaction(int_question, int_object)
			
	if Input.is_action_just_pressed("ui_accept"):
		interacting = true
		ui_interact.on_interaction(int_question, int_object)

func _on_Object_interation_menu_pick_up():
	Autoloads.flowers += 1
	ui_new_item.on_new_item("Flower")
	get_node("YSort/Blomma_red").queue_free()
	ui_interact.pressed_yes = false

func _on_Skelett_NPC_detected():
	var collider = $YSort/Skelett/NPC_detector.get_collider().name
	
	if collider == "NPC_Dino":
		dia_character = "Dino"
		dia_num = 1
		int_question = "Kliv på bussen?"
		int_object = "buss"
		
	if Input.is_action_just_pressed("ui_accept") and ui_dialog.dialog_running == false:
		ui_dialog.play_dialog(dia_character, dia_location, dia_num)
		interacting = true
	if interacting == true:
		_on_interact(int_question, int_object)

func _on_Object_interation_menu_get_on_bus():
	ui_interact.visible = false
	#ui_cutscene_panels.play_backwards("ready")
	ui_interact.pressed_yes = false
	$AnimationPlayer_bus.play("Get_on_bus")
	#anim_player_bus_wheels.play_backwards("slowing_down")


func _on_AnimationPlayer_bus_animation_finished(anim_name):
	Autoloads.Position = "stad_Buss"
	Transition.load_scene("res://Cutscenes/Buss_scen.tscn")
