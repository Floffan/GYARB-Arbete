extends Node

var Position = ""
var Current_scene = ""

var Gate_collider = ""

var NPC_collider = ""

#var keys = ["key_grotta"]
#var keys = []

var areas_visited = []
var games_played = []
#var games_played = ["Boatrace", "Bollplank", "Benchpress", "Slalom"]

var Items = []
#var Items = ["Medal", "Key", "Plate", "Shirt"]
var ok = false

var flowers = 3

#var have_briefcase : bool
var have_briefcase = true

func _process(_delta):
	if Input.is_action_pressed("Escape"):
		get_tree().quit()
	if flowers == 3:
		print("jippie!")
