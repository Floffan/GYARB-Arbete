extends Node2D

var path = "res://Dialog/tutorial/Case_holder_dia.json"
var interacting = false


var object = "briefcase"
var question = ""

var going_out = false

var gate_path = "res://Scenes/Main/World.tscn"

onready var ui_interaction = get_node("Camera2D/CanvasLayer/Object_interation_menu")
onready var ui_dialog = get_node("Camera2D/CanvasLayer/Dialog")

var dia_location = "Tutorial"
var dia_character = "CaseHolder"
var dia_num : int

var Info_done = false

func _process(delta):
	_display_briefcase()
	if Autoloads.data["have_briefcase"] == false:
		question = "Plocka upp väskan?"
	else:
		question = "Ställ väskan här?"
	if $YSort/Skelett.direction[1] == "up" and Info_done == false and Autoloads.data["have_briefcase"] and Autoloads.data["areas_visited"].has("Hedge") == false:
		_info_init()
		Autoloads.data["areas_visited"].append("Hedge")
			
func _info_init():
	dia_num = 1
	if ui_dialog.dialog_running == false:
		ui_dialog.play_dialog(dia_character, dia_location, dia_num)
		Info_done = true

func _on_Skelett_gate_detected():
	Autoloads.Position = "main_Hedge"
	Transition.load_scene("res://Scenes/Main/World.tscn")
	
func _on_Interact():
	if Input.is_action_just_pressed("ui_accept"):
		ui_interaction.pressed_yes = null
		
	if interacting == true:	
		ui_interaction.on_interaction(question, object)
			
	if Input.is_action_just_pressed("ui_accept"):
		interacting = true
		ui_interaction.on_interaction(question, object)
		
func _on_Skelett_Interaction_detected():
	_on_Interact()
	
func _display_briefcase():
	if Autoloads.data["have_briefcase"]:
		$Briefcase.visible = false
	if Autoloads.data["have_briefcase"] == false:
		$Briefcase.visible = true
	
func _on_Object_interation_menu_pick_up():
	#$Briefcase.visible = false
	Autoloads.update_briefcase(true)
	
	ui_interaction.pressed_yes = false
	
func _on_Object_interation_menu_put_down():
	#$Briefcase.visible = true
	Autoloads.update_briefcase(false)
	
	ui_interaction.pressed_yes = false
	
func _on_Skelett_NPC_detected() -> void:
	pass
