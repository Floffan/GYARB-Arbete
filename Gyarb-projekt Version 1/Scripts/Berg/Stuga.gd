extends Node2D

signal can_move
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.

func _ready():
	emit_signal("can_move")
	
func _process(delta):
	$Camera2D.current = true


func _on_Skelett_gate_detected():
	pass # Replace with function body.
