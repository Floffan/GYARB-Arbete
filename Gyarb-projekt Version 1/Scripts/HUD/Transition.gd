extends CanvasLayer

onready var animation_player = $AnimationPlayer

func load_scene(path, delay = 0.5):
	animation_player.play("Fade")
	assert(get_tree().change_scene(path) == OK)
	animation_player.play_backwards("Fade")
	
func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	animation_player.play("RESET")
