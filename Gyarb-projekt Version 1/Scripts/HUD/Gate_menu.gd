extends Control

#var position_in_new_world 
#var path
var walking_out 

func _ready():
	self.visible = false
	

#func _process(delta):
	#on_walkout(position_in_new_world, path)
	
func on_walkout(position_in_new_world, path, heading):
	if walking_out == false:
		return false
	if heading == "in":
		$Heading.text = "Gå in?"
	if heading == "here":
		$Heading.text = "Gå hit?"
	
	self.visible = true
	if walking_out == true:
		Autoloads.Position = position_in_new_world
		Transition.load_scene(path)


func _on_NO_button_up():
	walking_out = false
	self.visible = false


func _on_YES_button_down():
	walking_out = true
