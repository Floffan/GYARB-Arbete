extends Node2D

var skelett_position = Autoloads.Position

var going_out = false
var interacting = false

var int_question = ""
var int_object

onready var ui_cutscene_panels = get_node("Camera2D/CanvasLayer/Panels_cutscene/AnimationPlayer")

onready var ui_gate = get_node("Camera2D/CanvasLayer/Gate_menu")
onready var ui_dialog = get_node("Camera2D/CanvasLayer/Dialog")
onready var ui_interact = get_node("Camera2D/CanvasLayer/Object_interation_menu")

onready var ui_new_item = get_node("Camera2D/CanvasLayer/New_item")

var dia_character = ""
var dia_location = "Stad"
var dia_num : int

func _ready():
	#$Camera2D.current = true
	$VisibilityNotifier2D.connect("screen_entered", self, "show")
	$VisibilityNotifier2D.connect("screen_exited", self, "hide")
	visible = false
	_get_position()
	
func _get_position() -> void:
	if skelett_position == "stad_Gym":
		$YSort/Skelett.position = $Positioner/stad_Gym.position
	if skelett_position == "stad_Buss":
		$AnimationPlayer.play("bus_arriving")
		#$YSort/Skelett.position = $Positioner/stad_Buss.position

func _on_Skelett_gate_detected():
	if Autoloads.Gate_collider == "gate_Gym":
		_open_gate_menu("gym_Stad", "res://Scenes/Stad/Gym.tscn", "in")
	if Autoloads.Gate_collider == "gate_Redhouse":
		_house_movement("in")
	if Autoloads.Gate_collider == "gate_Balkong":	
		_house_movement("out")
	
func _open_gate_menu(position_in_new_world, path, heading):
	if Input.is_action_just_pressed("ui_accept"):
		ui_gate.walking_out = null
		
	if going_out == true:	
		ui_gate.on_walkout(position_in_new_world, path, heading)
			
	if Input.is_action_just_pressed("ui_accept"):
		going_out = true
		ui_gate.on_walkout(position_in_new_world, path, heading)

func _house_movement(heading):
	if heading == "in":
		int_question = "Gå in i huset?"
	if heading == "out":
		int_question = "Gå ner på gatan?"
		
	_on_Interact(heading, int_question)

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
		_on_Interact(int_object, int_question)		
		
func _on_Skelett_Interaction_detected():
	var collider = $YSort/Skelett/Interact_detector.get_collider().name
	
	if collider == "Blomma_red":
		int_question = "Plocka blomman?"
		int_object = "flower"
		_on_Interact(int_object, int_question)
		
func _on_Interact(int_object, int_question):
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
	get_node("YSort/Hus/Sprite/Blomma_red").queue_free()
	ui_interact.pressed_yes = false

func _on_Object_interation_menu_walk_in():
	ui_interact.visible = false
	ui_cutscene_panels.play_backwards("ready")
	$AnimationPlayer.play("Red_house_visit")
	ui_interact.pressed_yes = false

func _on_AnimationPlayer_animation_finished(anim_name):
	if Autoloads.Position == "berg_Buss":
		Transition.load_scene("res://Cutscenes/Buss_scen.tscn")
	else:
		ui_cutscene_panels.play("ready")

func _on_Object_interation_menu_walk_out():
	ui_interact.visible = false
	ui_cutscene_panels.play_backwards("ready")
	$AnimationPlayer.play_backwards("Red_house_visit")
	ui_interact.pressed_yes = false

func _on_VisibilityNotifier2D_screen_exited() -> void:
	$YSort/Bus.position = $Positioner/pos_Buss.position
	$YSort/Bus.scale.x = -1

func _on_Object_interation_menu_get_on_bus():
	ui_interact.visible = false
	ui_interact.pressed_yes = false
	Autoloads.Position = "berg_Buss"
	$AnimationPlayer.play("get_on_bus")
