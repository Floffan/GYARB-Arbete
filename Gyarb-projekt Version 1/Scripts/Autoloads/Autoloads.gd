extends Node

var Position = ""

var Gate_collider = ""

var NPC_collider = ""

func _process(delta):
	if Input.is_action_pressed("Escape"):
		get_tree().quit()
