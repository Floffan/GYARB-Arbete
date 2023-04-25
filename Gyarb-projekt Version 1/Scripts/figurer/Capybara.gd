extends Node2D

func _ready():
	"""
	Animationen spelas så att hon ser lite mer levande ut
	"""
	$AnimationPlayer.play("breathing")
