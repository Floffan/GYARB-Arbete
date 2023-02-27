extends CanvasLayer

var button_1_pressed = false
var button_2_pressed = false

var info1 = "Skriv in den fyrsiffriga koden..."
var info2 = "Fel kod! Kom tillbaks när du listat ut koden..."

onready var code_dic = {
	1 : $number_green,
	2 : $number_blue,
	3 : $number_yellow,
	4 : $number_pink
	}
	
var code_list = []
	
var correct_code = [0, 7, 1 , 0]
var putting_code = true
var num = 0
	

func _process(delta):
	_get_code()
	$Leaves/AnimationPlayer.play("Default")
	
func _ready():
	$Panels_cutscene/AnimationPlayer.play_backwards("ready")
	$Cutscene_camera/Info.display_info(info1)
	$ESC.visible = false

func _get_code():
	#if Input.is_action_just_pressed("ui_accept"):
		#$Cutscene_camera/Info.display_info(info1)
	if putting_code:
		for i in range(10):
			if Input.is_action_just_pressed("ui_"+str(i)):
				code_list.append(i)
				num += 1
				code_dic[num].text = str(i)		
	if num == 4:
		putting_code = false
		if _check_code(code_list):
			$Cutscene_camera/Info.visible = false
			#PLAY SOUND
			$Briefcase/AnimationPlayer.play("Open_up")
			
			$Light_effect.visible = true
			return
		else:
			$Cutscene_camera/Info.display_info(info2)
		$ESC.visible = true
		code_list.clear()
		
func _check_code(code):
	if code == correct_code:
		return true

func _on_ESC_button_down():
	self.queue_free()

func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().change_scene("res://Cutscenes/Opens_briefcase.tscn")
