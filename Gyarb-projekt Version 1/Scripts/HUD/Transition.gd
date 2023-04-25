extends CanvasLayer

onready var animation_player = $AnimationPlayer

func load_scene(path):
	animation_player.play("Fade")
	get_tree().change_scene(path)
	#assert(get_tree().change_scene(path) == OK)
	animation_player.play_backwards("Fade")
	
func _on_AnimationPlayer_animation_finished(_anim_name: String) -> void:
	animation_player.play("RESET")
