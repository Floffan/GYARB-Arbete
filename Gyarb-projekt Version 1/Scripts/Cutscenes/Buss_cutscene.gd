extends Node2D

onready var buskar = $Bakgrund/Buskar
onready var road = $Bakgrund/Road
onready var berg = $Bakgrund/Berg_fram
onready var berg_background = $Bakgrund/Berg_mitt


onready var buss_anim = $Bus/AnimationPlayer_wheel

var heading = ""

func _ready():
	if Autoloads.Position == "berg_Buss":
		heading = "Berg"
		#spelaa anim
	else:
		heading = "Stad"
		# spela anim

func _process(delta):
	buskar.motion_offset.x += 300*delta
	road.motion_offset.x += 300*delta
	berg.motion_offset.x += 200*delta
	berg_background.motion_offset.x += 100*delta
	
	buss_anim.play("driving")

func _on_Timer_timeout():
	if heading == "Stad":
		Transition.load_scene("res://Scenes/Stad/Stad.tscn")
	if heading == "Berg":
		Transition.load_scene("res://Scenes/Berg/Berg.tscn")
