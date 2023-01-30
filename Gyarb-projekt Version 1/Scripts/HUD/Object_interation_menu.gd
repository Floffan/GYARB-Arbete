extends Control

var pressed_yes = false

func _ready():
	self.visible = false
	
func on_interaction(question):
	if pressed_yes == false:
		return false
	
	self.visible = true
	if pressed_yes == true:
		$Question.text = question

func _on_YES_button_down():
	pressed_yes = true
	
func _on_NO_button_down():
	pressed_yes = false
	self.visible = false
