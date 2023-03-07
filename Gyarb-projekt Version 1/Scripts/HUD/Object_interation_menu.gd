extends Control

var pressed_yes = false

signal put_down
signal pick_up
signal walk_in
signal walk_out
signal get_on_bus

func _ready():
	self.visible = false
	
func on_interaction(question, object):
	if pressed_yes == false:
		return false
	$Question.text = question
	self.visible = true

	if pressed_yes:
		if object == "briefcase":
			if Autoloads.data["have_briefcase"]:
				emit_signal("put_down")
				self.visible = false
				return
			if Autoloads.data["have_briefcase"] == false:
				emit_signal("pick_up")
				self.visible = false
				return
		if object == "flower":
			emit_signal("pick_up")
			self.visible = false
			return
		if object == "in":
			emit_signal("walk_in")
		if object == "out":
			emit_signal("walk_out")
		if object == "buss":
			emit_signal("get_on_bus")

func _on_YES_button_down():
	pressed_yes = true
	
func _on_NO_button_down():
	pressed_yes = false
	self.visible = false
