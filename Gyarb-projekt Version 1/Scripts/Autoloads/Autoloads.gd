extends Node

var Position = ""
var Current_scene = ""

var Gate_collider = ""

var NPC_collider = ""

#var keys = ["key_grotta"]
var keys = []

var flowers = 0

var have_briefcase : bool

func _process(_delta):
	if Input.is_action_pressed("Escape"):
		get_tree().quit()
	if flowers == 3:
		print("jippie!")
