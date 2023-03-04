extends Node2D

var colours = ["Green", "Blue", "Turquise", "Red", "Pink", "Yellow"]

var request = []

signal stand_still

signal shrug


func _ready():
	emit_signal("stand_still")
