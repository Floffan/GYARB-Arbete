extends Node2D

var going_out = false

var skelett_position = Autoloads.Position

var minigame_path = "res://Scenes/Minigames/Benchpress.tscn"

onready var ui_gate = get_node("Camera2D/CanvasLayer/Gate_menu")
onready var ui_dialog = get_node("Camera2D/CanvasLayer/Dialog")
onready var ui_minigame = get_node("Camera2D/CanvasLayer/minigame_menu")

onready var ui_new_item = get_node("Camera2D/CanvasLayer/New_item")

var dia_character = ""
var dia_location = "Gym"
var dia_num : int

var item = "Plate"

func _ready():
	_get_input()

func _on_Skelett_gate_detected():
	if Input.is_action_just_pressed("ui_accept"):
		ui_gate.walking_out = null
		
	if going_out == true:	
		ui_gate.on_walkout("stad_Gym","res://Scenes/Stad/Stad.tscn" , "out")
			
	if Input.is_action_just_pressed("ui_accept"):
		going_out = true
		ui_gate.on_walkout("main_Gym", "res://Scenes/Main/World.tscn", "out")
	
func _get_input():
	if skelett_position == "gym_Stad":
		$YSort/Skelett.position = $Positioner/gym_Stad.position
	if skelett_position == "gym_Minigame":
		$YSort/Skelett.position = $Positioner/gym_Minigame.position

func _on_Skelett_NPC_detected():
	var collider = $YSort/Skelett/NPC_detector.get_collider().name
	
	if collider == "Squat_grodan":
		dia_character = "SquatFrog"
		dia_num = 1
	if collider == "Curl_grodan":
		dia_character = "CurlFrog"
		dia_num = 1
	if collider == "Polack_padda":
		dia_character = "Coach"
		#dia_num = 1
		if Autoloads.games_played.has("Benchpress"):
			if dia_num == 2 and ui_dialog.dialog_running == false:
				ui_new_item.on_new_item(item)
				Autoloads.Items.append(item)
				dia_num = 3
			if Autoloads.Items.has(item):
				dia_num = 3
			if Autoloads.Items.has(item) != true:
				dia_num = 2
				if ui_dialog.dialog_running == false:
					ui_dialog.play_dialog(dia_character, dia_location, dia_num)
					ui_minigame.menu_active = false
		else:
			dia_num = 1
			
	if Input.is_action_just_pressed("ui_accept") and ui_dialog.dialog_running == false:
		ui_dialog.play_dialog(dia_character, dia_location, dia_num)
		ui_minigame.menu_active = true
		
	if ui_minigame.menu_active and collider == "Polack_padda" and dia_num != 2:
		ui_minigame.play_minigame(minigame_path)
	else:
		ui_minigame.menu_active = false
			
