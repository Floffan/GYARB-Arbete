extends KinematicBody2D

onready var path = get_parent()
onready var speed = 10

onready var can_start = false


func _process(delta):
	"""
	båten följer dess path när can_start variabeln är sann
	"""
	if can_start:
		path.set_offset(path.get_offset() + speed + delta)

func _on_Btrace_ready_done():
	"""
	Båten kan starta  när ready-screenen är klar
	"""
	can_start = true


func _on_Btrace_game_over():
	"""
	Båten kan inte röra sig när spelet är över
	"""
	can_start = false
