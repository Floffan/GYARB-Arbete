extends Camera2D

onready var player = get_parent().get_node("YSort/Skelett")


func _process(delta):
	position = player.position
	
