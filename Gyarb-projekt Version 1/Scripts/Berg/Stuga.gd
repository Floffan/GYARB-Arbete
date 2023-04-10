extends Node2D

var skelett_position = Autoloads.Position

var going_out = false

var minigame_path = "res://Scenes/Minigames/Skidshop.tscn"

onready var ui_gate = get_node("Camera2D/CanvasLayer/Gate_menu")
onready var ui_dialog = get_node("Camera2D/CanvasLayer/Dialog")
onready var ui_minigame = get_node("Camera2D/CanvasLayer/minigame_menu")

onready var ui_new_item = get_node("Camera2D/CanvasLayer/New_item")

var dia_location = "Stuga"
var dia_character = ""
var dia_num : int

signal can_move

var item = "Hat"

func _ready():
	$NPCs_anim.play("default")
	_get_position()
	emit_signal("can_move")
	
	
func _process(delta):
	$Camera2D.current = true
	
func _get_position():
	if skelett_position == "stuga_Minigame":
		$YSort/Skelett.position = $Positioner/stuga_Berg.position
	if skelett_position == "stuga_Berg":
		$YSort/Skelett.position = $Positioner/stuga_Berg.position

func _on_Skelett_gate_detected():
	if Input.is_action_just_pressed("ui_accept"):
		ui_gate.walking_out = null
		
	if going_out == true:	
		ui_gate.on_walkout("berg_Stuga", "res://Scenes/Berg/Berg.tscn", "out")
			
	if Input.is_action_just_pressed("ui_accept"):
		going_out = true
		ui_gate.on_walkout("berg_Stuga", "res://Scenes/Berg/Berg.tscn", "out")


func _on_Skelett_NPC_detected():
	var collider = get_node("YSort/Skelett/NPC_detector").get_collider().name
	
	if collider == "Capybara":
		dia_character = "Capybara"
		
	play_dialog()
	
func play_dialog():
	if Autoloads.data["games_played"].has("Skidshop"):
		if dia_num == 2 and ui_dialog.dialog_running == false:
			ui_new_item.on_new_item(item)
			Autoloads.add_item(item)
			dia_num = 3
		if Autoloads.data["items"].has(item):
			dia_num = 3
		if Autoloads.data["items"].has(item) != true:
			dia_num = 2
			if ui_dialog.dialog_running == false:
				ui_dialog.play_dialog(dia_character, dia_location, dia_num)
				ui_minigame.menu_active = false
	else:
		dia_num = 1
		
	if Input.is_action_just_pressed("ui_accept") and ui_dialog.dialog_running == false:
		ui_dialog.play_dialog(dia_character, dia_location, dia_num)
		ui_minigame.menu_active = true
	if ui_minigame.menu_active and dia_num != 2:
		ui_minigame.play_minigame(minigame_path)
		
