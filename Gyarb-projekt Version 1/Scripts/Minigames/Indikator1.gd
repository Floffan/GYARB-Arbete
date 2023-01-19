extends StaticBody2D

onready var path_follow = get_parent()
export var speed = 5


func _ready():
	pass
	
func _physics_process(delta):
	path_follow.set_offset(path_follow.get_offset() + speed + delta)
	
	# Är denhär koden necessary?
	
	
