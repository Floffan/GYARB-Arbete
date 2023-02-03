extends Control

var pressed_yes = false

signal put_down
signal pick_up

func _ready():
	self.visible = false
	
func on_interaction(question, object):
	if pressed_yes == false:
		return false
	$Question.text = question
	self.visible = true

	if pressed_yes:
		if object == "briefcase":
			if Autoloads.have_briefcase:
				emit_signal("put_down")
				self.visible = false
				return
			if Autoloads.have_briefcase == false:
				emit_signal("pick_up")
				self.visible = false
				return
		if object == "flower":
			emit_signal("pick_up")
			self.visible = false
			return

func _on_YES_button_down():
	pressed_yes = true
	
func _on_NO_button_down():
	pressed_yes = false
	self.visible = false
