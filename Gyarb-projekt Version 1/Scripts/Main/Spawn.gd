extends Node2D
var going_out = false
var interacting = false

var skelett_position = Autoloads.Position

var question = "Plocka up väskan?"

onready var ui_dialog = get_node("Camera2D/CanvasLayer/Dialog")
onready var ui_interaction = get_node("Camera2D/CanvasLayer/Object_interation_menu")

var dia_character = "Uggla"
var dia_location = "Tutorial"
var dia_num : int

var dialog_path = "res://Dialog/Tutorial/Uggla_dia.json"

signal looking_around
signal can_move
signal give_prompt

var heard_briefcase_info = false

func _ready():
	_get_position()
	if !Autoloads.data["areas_visited"].has("spawn"):
		emit_signal("looking_around")
		dia_num = 1
		yield(get_tree().create_timer(5), "timeout")
		if ui_dialog.dialog_running == false:
			ui_dialog.play_dialog(dia_character, dia_location, dia_num)
	
func _on_Skelett_gate_detected():
	if !Autoloads.data["areas_visited"].has("spawn"):
		Autoloads.add_area_visited("spawn")
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
	if Autoloads.data["have_briefcase"] == false:
		if Input.is_action_just_pressed("ui_accept"):
			ui_interaction.pressed_yes = null
			
		if interacting == true:	
			ui_interaction.on_interaction(question, "briefcase")
				
		if Input.is_action_just_pressed("ui_accept"):
			interacting = true
			ui_interaction.on_interaction(question, "briefcase")

func _on_Object_interation_menu_pick_up():
	$YSort/Coffin_open/Briefcase.visible = false
	Autoloads.update_briefcase(true)
	
func _process(delta):
	if heard_briefcase_info:
		emit_signal("can_move")
	if Autoloads.data["have_briefcase"] == true and not ui_dialog.dialog_running and not heard_briefcase_info and !Autoloads.data["areas_visited"].has("spawn"):
		dia_num = 2
		ui_dialog.play_dialog(dia_character, dia_location, dia_num)
		heard_briefcase_info = true
		emit_signal("give_prompt")
	if Autoloads.data["areas_visited"].has("spawn"):
		$YSort/Coffin_open/Briefcase.visible = false
		$NPC_uggla.visible = false
		
