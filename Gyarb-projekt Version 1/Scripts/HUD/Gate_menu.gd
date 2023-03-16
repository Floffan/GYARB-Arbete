extends Control

#onready var skelett = get_parent().get_parent().get_parent().get_node("YSort/Skelett")

var walking_out 

signal can_move
signal stand_still

func _ready():
	self.visible = false
	

#func _process(delta):
	#on_walkout(position_in_new_world, path)
	
func on_walkout(position_in_new_world, path, heading):
	emit_signal("stand still")
	if walking_out == false:
		return false
	if heading == "in":
		$Heading.text = "Gå in?"
	if heading == "here":
		$Heading.text = "Gå hit?"
	
	self.visible = true
	if walking_out == true:
		emit_signal("can_move")
		Autoloads.Position = position_in_new_world
		Transition.load_scene(path)


func _on_NO_button_up():
	emit_signal("can_move")
	walking_out = false
	self.visible = false


func _on_YES_button_down():
	walking_out = true
