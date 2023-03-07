extends Control



func _on_Nytt_spel_button_down():
	$AnimationPlayer.play("on_nyttspel")

func _on_Fortstt_spel_button_down():
	Autoloads.load_game()
	Autoloads.Position = Autoloads.data["init_pos"]
	Transition.load_scene(Autoloads.data["init_loc"])

func _on_AnimationPlayer_animation_finished(anim_name):
	Autoloads.reset_data()
	get_tree().change_scene("res://Cutscenes/Waking_up_cutscene.tscn")
