extends Control

func _ready():
	$Panels_cutscene/AnimationPlayer.play("UPPFÄLD")

func _process(delta):
	$Skelett/AnimationPlayer.play("Breathing")
