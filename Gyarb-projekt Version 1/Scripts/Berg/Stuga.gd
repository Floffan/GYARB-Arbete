extends Node2D

var skelett_position = Autoloads.Position

var going_out = false

onready var ui_gate = get_node("Camera2D/CanvasLayer/Gate_menu")
onready var ui_dialog = get_node("Camera2D/CanvasLayer/Dialog")

signal can_move

func _ready():
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
