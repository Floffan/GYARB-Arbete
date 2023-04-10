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
var num_pos = 0
	

func _process(delta):
	"""
	Ambiansen av löven som rör sig litegrann spelas som default, för att scenen ska verka lite mer levande
	"""
	_get_code()
	$Leaves/AnimationPlayer.play("Default")
	
func _ready():
	"""
	Panelerna kommer upp för att indikera att detta är en cutscene
	
	ESC-krysset syns inte förrens man har slagit in en kod
	"""
	$Panels_cutscene/IV/AnimationPlayer.play("showing_items")
	$Panels_cutscene/AnimationPlayer.play_backwards("ready")
	$Cutscene_camera/Info.display_info(info1)
	$ESC.visible = false

func _get_code():
	#if Input.is_action_just_pressed("ui_accept"):
		#$Cutscene_camera/Info.display_info(info1)
	"""
	Koden som spelaren provar fås i denna funktion.
	Här kallas även funktionen som kollar om fnktionen slagits in fel.
	
	"""
	if putting_code:
		for i in range(10): # Det finns 10 siffror att välja på, 0-9
			if Input.is_action_just_pressed("ui_" + str(i)): # om inputen motsvarar vad ui-syntaxet för motsvarande siffra är...
				code_list.append(i) # så läggs den till i den lista som spelarens kod är
				num_pos += 1
				code_dic[num_pos].text = str(i) # positionen som eftersöks motsvarar en nod i dictionaryt, och dennes text sätts till numret i fråga
	if num_pos == 4:
		putting_code = false
		if _check_code(code_list):
			$Cutscene_camera/Info.visible = false
			#PLAY SOUND
			$Briefcase/AnimationPlayer.play("Open_up")
			return
		else:
			$Cutscene_camera/Info.display_info(info2)
		$ESC.visible = true
		code_list.clear()
		
func _check_code(code):
	"""
	Om koden som spelaren slår in är rätt returneras true
	"""
	if code == correct_code:
		return true

func _on_ESC_button_down():
	"""
	Om man kryssar ner cutscenen så stängs scenen ner
	"""
	self.queue_free()

func _on_AnimationPlayer_animation_finished(anim_name):
	"""
	När väskan börjar öppnas klipps det till en annan cutscene
	"""
	get_tree().change_scene("res://Cutscenes/Opens_briefcase.tscn")
