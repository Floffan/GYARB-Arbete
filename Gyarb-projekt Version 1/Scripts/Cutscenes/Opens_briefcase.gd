extends Control

func _ready():
	$Panels_cutscene/AnimationPlayer.play("UPPFÄLD")
	$fade_timer.start()

func _process(delta):
	$Skelett/AnimationPlayer.play("Breathing")


func _on_fade_timer_timeout() -> void:
	$AnimationPlayer.play("Fade_out")


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	$AnimationPlayer.play("vitt")
