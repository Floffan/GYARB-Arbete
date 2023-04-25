extends Control

func _ready():
	$Panels_cutscene/AnimationPlayer.play("UPPFÄLD")
	$AnimationPlayer_glow.play("Glow_up")
	$fade_timer.start()

func _process(delta):
	$Skelett/AnimationPlayer.play("Breathing")


func _on_fade_timer_timeout() -> void:
	$AnimationPlayer.play("Fade_out")
	yield(get_tree().create_timer(3), "timeout")
	get_tree().change_scene("res://Scenes/Ending/End_game.tscn")


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	$AnimationPlayer.play("vitt")
	yield(get_tree().create_timer(1.8), "timeout")
