extends PathFollow2D

onready var path = get_parent()
var speed = 100


func _process(delta):
	pass
	#path.set_offset(path.get_offset() + speed + delta)
