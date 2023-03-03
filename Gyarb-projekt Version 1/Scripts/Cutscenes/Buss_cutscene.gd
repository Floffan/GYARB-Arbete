extends Node2D

onready var buskar = $Bakgrund/Buskar
onready var road = $Bakgrund/Road
onready var berg = $Bakgrund/Berg_fram
onready var berg_background = $Bakgrund/Berg_mitt


onready var buss_anim = $Bus/AnimationPlayer_wheel

var heading = ""

"""
Variabeln num avgör åt vilket håll bakgrunden rör sig så att det ser ut som att bussen rör sig
Den är positiv åt stadshållet, och negativt åt bergshållet
"""
var num : int

func _ready():
	
	if Autoloads.Position == "berg_Buss":
		heading = "Berg"
		$AnimationPlayer.play("to_berg")
		num = -1
	if Autoloads.Position == "stad_Buss":
		heading = "Stad"
		$AnimationPlayer.play("to_stad")
		num = 1
		

func _process(delta):
	buskar.motion_offset.x += 300 * delta * num
	road.motion_offset.x += 300 *delta * num
	berg.motion_offset.x += 200 *delta * num
	berg_background.motion_offset.x += 100 *delta * num
	
	buss_anim.play("driving")

func _on_Timer_timeout():
	if heading == "Stad":
		Transition.load_scene("res://Scenes/Stad/Stad.tscn")
	if heading == "Berg":
		Transition.load_scene("res://Scenes/Berg/Berg.tscn")
