extends Node2D

var skelett_position = Autoloads.Position

var going_out = false

var cave_access = false

func _ready():
	_get_position()
	if Autoloads.keys.has("key_grotta"):
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
	var menu_player = get_node_or_null("Camera2D/Gate_menu")
	if Input.is_action_just_pressed("ui_accept"):
		menu_player.walking_out = null
	if going_out == true:	
		menu_player.on_walkout(position_in_new_world, path, heading)
			
	if Input.is_action_just_pressed("ui_accept"):
		going_out = true
		if menu_player:
			menu_player.on_walkout(position_in_new_world, path, heading)
