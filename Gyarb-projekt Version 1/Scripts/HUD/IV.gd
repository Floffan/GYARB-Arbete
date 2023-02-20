extends Control

var IV_open = false

func _get_input():
	if Input.is_action_just_pressed("Check_briefcase") and IV_open:
		$AnimationPlayer.play_backwards("on_IV")
		IV_open = false
		return
	if Input.is_action_just_pressed("Check_briefcase") and IV_open == false:
		$AnimationPlayer.play("on_IV")
		IV_open = true
		return
		
func _check_briefcase():
	if Autoloads.have_briefcase:
		$Panel/Have_briefcase.visible = true
		$Panel/No_briefcase.visible = false
	else:
		$Panel/Have_briefcase.visible = false
		$Panel/No_briefcase.visible = true
		
		
		
func _process(delta):
	_check_briefcase()
	_get_input()
