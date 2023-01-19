extends Camera2D

onready var player = get_parent().get_node("YSort").get_node("Skelett")


func _process(delta):
	position = player.position
	
