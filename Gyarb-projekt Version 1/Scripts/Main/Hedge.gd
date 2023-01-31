extends Node2D

var path = "res://Dialog/tutorial/Case_holder_dia.json"
var interacting = false

var question = "Ställ väskan här?"

onready var animation_player = $YSort/Skelett/AnimationPlayer
var going_out = false

var gate_path = "res://Scenes/Main/World.tscn"

func _ready() -> void:
	animation_player.play("Stå-animation_bakifrån")
	$YSort/Skelett.direction[1] = "up"



func _on_Skelett_NPC_detected():
	var collider = $YSort/Skelett/NPC_detector.get_collider().name
	var dialog_player = get_node("Camera2D/Dialog")
	if Input.is_action_just_pressed("ui_accept") and dialog_player.dialog_running == false:
		dialog_player.play_dialog(path, 0.05)

func _on_Skelett_gate_detected():
	Autoloads.Position = "main_Hedge"
	Transition.load_scene("res://Scenes/Main/World.tscn")
	
	
	
	
func _on_Interact():
	var menu_player = get_node("Camera2D/Object_interation_menu")
	
	#if Input.is_action_just_pressed("ui_accept"):
		#menu_player.walking_out = null
		
	if interacting == true:	
		menu_player.on_interaction(question)
			
	if Input.is_action_just_pressed("ui_accept"):
		interacting = true
		menu_player.on_interaction(question)
