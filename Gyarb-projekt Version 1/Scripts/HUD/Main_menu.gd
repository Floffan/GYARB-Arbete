extends Control



func _on_Nytt_spel_button_down():
	$AnimationPlayer.play("on_nyttspel")

func _on_Fortstt_spel_button_down():
	Transition.load_scene("res://Scenes/Main/World.tscn")

func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().change_scene("res://Cutscenes/Waking_up_cutscene.tscn")
