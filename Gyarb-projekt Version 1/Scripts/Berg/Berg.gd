extends Node2D

var skelett_position = Autoloads.Position

var going_out = false

var cave_access = false

var question = ""
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

func _on_Skelett_gate_detected():
	if Autoloads.Gate_collider == "gate_Main":
		Autoloads.Position = "main_Berg"
		Transition.load_scene("res://Scenes/Main/World.tscn")
		#_open_gate_menu("main_Berg", "res://Scenes/Main/World.tscn", "here")
	if Autoloads.Gate_collider == "gate_Grotta" and cave_access:
		_open_gate_menu("berg_Grotta", "res://Scenes/Berg/Grotta.tscn", "in")
	if Autoloads.Gate_collider == "gate_Stad":
		Autoloads.Position = "stad_Berg"
		Transition.load_scene("res://Scenes/Stad/Stad.tscn")
		

func _open_gate_menu(position_in_new_world, path, heading):
	var menu_player = get_node_or_null("Camera2D/CanvasLayer/Gate_menu")
	if Input.is_action_just_pressed("ui_accept"):
		menu_player.walking_out = null
	if going_out == true:	
		menu_player.on_walkout(position_in_new_world, path, heading)
			
	if Input.is_action_just_pressed("ui_accept"):
		going_out = true
		if menu_player:
			menu_player.on_walkout(position_in_new_world, path, heading)
			
			
func _on_Skelett_Interaction_detected():
	var collider = $YSort/Skelett/Interact_detector.get_collider().name
	
	if collider == "Blomma_red":
		question = "Plocka blomman?"
		_on_Interact()
		
func _on_Interact():
	var menu_player = get_node("Camera2D/CanvasLayer/Object_interation_menu")
	
	if Input.is_action_just_pressed("ui_accept"):
		menu_player.pressed_yes = null
		
	if interacting == true:	
		menu_player.on_interaction(question, "flower")
			
	if Input.is_action_just_pressed("ui_accept"):
		interacting = true
		menu_player.on_interaction(question, "flower")

func _on_Object_interation_menu_pick_up():
	Autoloads.flowers += 1
	$YSort/Blomma_red.visible = false
	$Camera2D/CanvasLayer/Object_interation_menu.pressed_yes = false
