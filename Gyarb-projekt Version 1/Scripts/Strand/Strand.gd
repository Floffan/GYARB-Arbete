extends Node2D
"""

"""
var skelett_position = Autoloads.Position

onready var ui_gate = get_node("Camera2D/CanvasLayer/Gate_menu")

var going_out = false

func _ready():
	$VisibilityNotifier2D.connect("screen_entered", self, "show")
	$VisibilityNotifier2D.connect("screen_exited", self, "hide")
	visible = false
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
	if Autoloads.Gate_collider == "gate_Shellhouse":
		_open_gate_menu("strand_Shellhouse","res://Scenes/Strand/Shellhouse_inside.tscn" , "in")
	if Autoloads.Gate_collider == "gate_Racehouse":
		_open_gate_menu("strand_Racehouse", "res://Scenes/Strand/racehouse_inside.tscn", "in")
	if Autoloads.Gate_collider == "gate_Main":
		Autoloads.Position = "main_Strand"
		Transition.load_scene("res://Scenes/Main/World.tscn")
		
func _open_gate_menu(position_in_new_world, path, heading):
	if Input.is_action_just_pressed("ui_accept"):
		ui_gate.walking_out = null
	if going_out == true:	
		ui_gate.on_walkout(position_in_new_world, path, heading)
	if Input.is_action_just_pressed("ui_accept"):
		going_out = true
		ui_gate.on_walkout(position_in_new_world, path, heading)

