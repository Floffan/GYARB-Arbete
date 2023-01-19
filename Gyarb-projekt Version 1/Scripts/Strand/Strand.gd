extends Node2D
"""

"""
var skelett_position = Autoloads.Position

var going_out = false

func _ready():
	_get_position()

func _process(delta: float) -> void:
	$Havet/Lager1.motion_offset.x += -50*delta

func _get_position() -> void:
	if skelett_position == "strand_Shellhouse":
		$YSort/Skelett.position = $Positioner/strand_Shellhouse.position
	if skelett_position == "strand_Racehouse":
		$YSort/Skelett.position = $Positioner/strand_Racehouse.position
	if skelett_position == "strand_Main":
		$YSort/Skelett.position = $Positioner/strand_Main.position

func _on_Skelett_gate_detected():
	var path = ""
	
	if Autoloads.Gate_collider == "gate_Shellhouse":
		_open_gate_menu("strand_Shellhouse","res://Scenes/Strand/Shellhouse_inside.tscn" , "in")
	if Autoloads.Gate_collider == "gate_Racehouse":
		_open_gate_menu("strand_Racehouse", "res://Scenes/Strand/racehouse_inside.tscn", "in")
	if Autoloads.Gate_collider == "gate_Main":
		Autoloads.Position = "main_Strand"
		Transition.load_scene("res://Scenes/Main/World.tscn")
		
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

