extends Node

var Position = ""

var Gate_collider = ""

var NPC_collider = ""

#var keys = ["key_grotta"]
var keys = []

func _process(_delta):
	if Input.is_action_pressed("Escape"):
		get_tree().quit()
