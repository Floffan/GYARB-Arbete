extends Node2D



func _on_Skelett_gate_detected():
	Autoloads.Position = "main_Dwelling"
	Transition.load_scene("res://Scenes/Main/World.tscn")
