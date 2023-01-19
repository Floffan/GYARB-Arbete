extends KinematicBody2D

onready var path = get_parent()
onready var speed = 10

onready var can_start = false


func _process(delta):
	if can_start:
		path.set_offset(path.get_offset() + speed + delta)


func _on_Btrace_ready_done():
	can_start = true
