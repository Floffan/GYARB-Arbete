extends Control

#onready var skelett = get_parent().get_parent().get_parent().get_node("YSort/Skelett")

var walking_out
#var menu_showing : bool

var standing_still = false

signal can_move
signal stand_still

func _ready():
	self.visible = false

	
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

	
	"""
	self.visible = true
		
	if heading == "in":
		$Heading.text = "Gå in?"
	if heading == "here":
		$Heading.text = "Gå hit?"
		
	"""

#func walk_out(position_in_new_world, path):
#	Autoloads.Position = position_in_new_world
#	Transition.load_scene(path)
	
	

	
	
	
	"""
	if standing_still == false:
		emit_signal("stand_still")
		self.visible = true
		#$Gate_timer.start()
		standing_still = true
	
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
	"""


func _on_NO_button_up():
	walking_out = false
	#menu_showing = false
	self.visible = false

func _on_YES_button_down():
	walking_out = true
