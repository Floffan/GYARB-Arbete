extends Node2D
var going_out = false
var interacting = false

var skelett_position = Autoloads.Position

var question = "Plocka up väskan?"

onready var dialog_player = get_node("Camera2D/CanvasLayer/Dialog")
var dialog_path = "res://Dialog/Tutorial/Uggla_dia.json"

func _ready():
	_get_position()
	#Autoloads.Current_scene = "res://Scenes/Main/Spawn.tscn"
	yield(get_tree().create_timer(3), "timeout")
	if dialog_player.dialog_running == false:
		dialog_player.play_dialog(dialog_path, 0.05, 1)
	
func _on_Skelett_gate_detected():
	var menu_player = get_node_or_null("Camera2D/CanvasLayer/Gate_menu")
	
	if Input.is_action_just_pressed("ui_accept"):
		menu_player.walking_out = null
		
	if going_out == true:	
		menu_player.on_walkout("main_Spawn","res://Scenes/Main/World.tscn" , "out")
			
	if Input.is_action_just_pressed("ui_accept"):
		going_out = true
		if menu_player:
			menu_player.on_walkout("main_Spawn","res://Scenes/Main/World.tscn" , "out")
			
func _get_position() -> void:
	if skelett_position == "spawn_Main":
		$YSort/Skelett.position = $Positioner/spawn_Main.position
	if skelett_position == "spawn_Awoken":
		$YSort/Skelett.position = $Positioner/spawn_Awoken.position

func _on_Skelett_Interaction_detected():
	if Autoloads.have_briefcase == false:
		var menu_player = get_node("Camera2D/CanvasLayer/Object_interation_menu")
		
		if Input.is_action_just_pressed("ui_accept"):
			menu_player.pressed_yes = null
			
		if interacting == true:	
			menu_player.on_interaction(question, "briefcase")
				
		if Input.is_action_just_pressed("ui_accept"):
			interacting = true
			menu_player.on_interaction(question, "briefcase")


func _on_Object_interation_menu_pick_up():
	$YSort/Coffin_open/Briefcase.visible = false
	Autoloads.have_briefcase = true
