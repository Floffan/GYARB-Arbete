extends StaticBody2D

export (bool) var Light_enabled = false

onready var light_H = $Light_H
onready var light_V = $Light_V

func _process(_delta):
	$AnimationPlayer.play("Dino_breathing")
	if Light_enabled == false:
		light_H.enabled = false
		light_V.enabled = false
