extends Node2D

var path = "res://Dialog/tutorial/Case_holder_dia.json"
var interacting = false


var object = "briefcase"
var question = ""

onready var animation_player = $YSort/Skelett/AnimationPlayer
var going_out = false

var gate_path = "res://Scenes/Main/World.tscn"

onready var interaction_menu = $Camera2D/CanvasLayer/Object_interation_menu

func _ready() -> void:
	Autoloads.have_briefcase = true
	animation_player.play("Stå-animation_bakifrån")
	$YSort/Skelett.direction[1] = "up"

func _process(delta):
	if Autoloads.have_briefcase == false:
		question = "Plocka upp väskan?"
	else:
		question = "Ställ väskan här?"


func _on_Skelett_NPC_detected():
	var collider = $YSort/Skelett/NPC_detector.get_collider().name
	var dialog_player = get_node("Camera2D/CanvasLayer/Dialog")
	if Input.is_action_just_pressed("ui_accept") and dialog_player.dialog_running == false:
		dialog_player.play_dialog(path, 0.05, 1)

func _on_Skelett_gate_detected():
	Autoloads.Position = "main_Hedge"
	Transition.load_scene("res://Scenes/Main/World.tscn")
	
func _on_Interact():
	var menu_player = get_node("Camera2D/CanvasLayer/Object_interation_menu")
	
	if Input.is_action_just_pressed("ui_accept"):
		menu_player.pressed_yes = null
		
	if interacting == true:	
		menu_player.on_interaction(question, object)
			
	if Input.is_action_just_pressed("ui_accept"):
		interacting = true
		menu_player.on_interaction(question, object)
		
func _on_Skelett_Interaction_detected():
	_on_Interact()
	
func _on_Object_interation_menu_pick_up():
	$Briefcase.visible = false
	Autoloads.have_briefcase = true
	
	interaction_menu.pressed_yes = false
	
func _on_Object_interation_menu_put_down():
	$Briefcase.visible = true
	Autoloads.have_briefcase = false
	
	interaction_menu.pressed_yes = false
	
