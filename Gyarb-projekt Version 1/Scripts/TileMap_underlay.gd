extends Node2D

func _process(delta: float) -> void:
	$Havet/Lager1.motion_offset.x += -50*delta
