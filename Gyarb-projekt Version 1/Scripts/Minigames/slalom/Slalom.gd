extends Node2D

func _process(delta: float) -> void:
	$Camera2D.position = $YSort/Spelare_skidor/Skelett_bak.position
