extends Node2D

var button_1_pressed = false
var button_2_pressed = false

var info1 = "Skriv in den fyrsiffriga koden..."
var info2 = "Fel kod! Kom tillbaks när du listat ut koden..."

var code = {
	$number_green : 0,
	$number_blue : 0,
	$number_yellow : 0,
	$number_pink : 0
	}
	
var correct_code = [0, 7, 1 , 0]
var putting_code = true
var num = 0

func _process(delta):
	_get_code()
	$Leaves/AnimationPlayer.play("Default")
#	print("1:")
#	print(button_1_pressed)
#	print("2:")
#	print(button_2_pressed)
	
func _ready():
	$Cutscene_camera/Info.display_info(info1)

func _get_code():
	#if Input.is_action_just_pressed("ui_accept"):
		#$Cutscene_camera/Info.display_info(info1)
	if putting_code:
		for i in range(10):
			if Input.is_action_just_pressed("ui_"+str(i)):
				code.append(i)
				
				num += 1
	
	if num == 4:
		putting_code = false
		if _check_code(code):
			print("JIPPIE")
		else:
			$Cutscene_camera/Info.display_info(info2)
		code.clear()
		
func _check_code(code):
	if code == correct_code:
		return true

func _on_TextureButton2_toggled(button_pressed):
	button_2_pressed = true


func _on_TextureButton1_toggled(button_pressed):
	button_1_pressed = true


func _on_TextureButton1_button_up():
	button_1_pressed = false


func _on_TextureButton2_button_up():
	button_2_pressed = false
