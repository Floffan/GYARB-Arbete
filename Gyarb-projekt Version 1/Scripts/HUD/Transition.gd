extends CanvasLayer


onready var animation_player = $AnimationPlayer

onready var svart = $Control/Svart


#func load_scene(path):
	#animation_player.play("Fade")
	#yield(animation_player, "animation_finished")
	#get_tree().change_scene(path)
	#animation_player.play_backwards("Fade")
	#print("klar")
	

func load_scene(path, delay = 0.5):
	#yield(get_tree().create_timer(delay), "timeout")
	animation_player.play("Fade")
	#yield(animation_player, "animation_finished")
	assert(get_tree().change_scene(path) == OK)
	animation_player.play_backwards("Fade")
	
	
