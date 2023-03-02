extends Control

onready var light_effect = load("res://Scenes/Effects/LIGHT.tscn")

var Item

func _ready():
	self.visible = false
	var number_of_lights = 18
	var angle = 0
	for i in range(number_of_lights):
		var instance = light_effect.instance()
		get_node("effect").add_child(instance)
		instance.position = $effect_pos.position
		instance.rotation_degrees = angle
		angle += 360/number_of_lights
		
		
func _process(delta):
	$effect.rotation_degrees += 1

func on_new_item(item):
	Item = item
	self.visible = true
	$AnimationPlayer.play(item)


func _on_AnimationPlayer_animation_finished(anim_name):
	self.visible = false
