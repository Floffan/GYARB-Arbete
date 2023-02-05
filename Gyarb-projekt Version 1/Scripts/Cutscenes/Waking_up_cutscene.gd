extends Node2D

func _ready():
	$AnimationPlayer.play("on_nyttspel")
	#$Timer.start()
	#$Skelett/smoke.one_shot = true
	



func _on_Timer_timeout():
	$Skelett/AnimationPlayer.play("waking_up")

func _on_AnimationPlayer_animation_finished(anim_name):
	pass
	Autoloads.Position = "spawn_Awoken"
	Transition.load_scene("res://Scenes/Main/Spawn.tscn")
