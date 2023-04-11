extends Control

export var dialog_path = ""
export(float) var text_speed = 0.05
 
var dialog
 
var phrase_num = 0
var finished = false

var dialog_running = false
 

func play_dialog(character, location, num):
	"""
	Funktionen kallas när dialog ska spelas upp, dialogboxen görs synlig, dialog_pathen sätts ihop och det kollas om dialogen finns.
	"""
	# Pathen sätts ihop i denna funktion, beroende på vad "num" är säger karaktärerna olika saker
	dialog_path = "res://Dialog/" + str(location) + "/" + character + "_dia_" + str(num) + ".json"

	dialog_running = true
	yield(get_tree().create_timer(0.01), "timeout")
	self.visible = true
	$Timer.wait_time = text_speed
	dialog = _get_dialog(dialog_path, num)
	assert(dialog, "Dialogen hittades ej")
	_next_phrase()
 
func _ready():
	"""
	Grundtillståndet är att dialogrutan inte syns
	"""
	self.visible = false
	
func _process(_delta):
	"""
	Om dialogen är färdiguppspelad kommer nästa fras upp om man trycker mellanslag
	"""
	if Input.is_action_just_pressed("ui_accept"):
		if finished:
			$AnimationPlayer.play("RESET")
			_next_phrase()
		else:
			$Text.visible_characters = len($Text.text)
 
func _get_dialog(dialog_path, num) -> Array:
	"""
	Kollar om filen som refereas av pathen finns --> om inte returnas ett felmeddelande
	
	Filen läses sedan och konverteras till en lista som godot kan läsa
	"""
	var f = File.new()
	assert(f.file_exists(dialog_path), "Filsökvägen hittades ej")
	
	f.open(dialog_path, File.READ)
	var json = f.get_as_text()
	
	var output = parse_json(json)
	
	if typeof(output) == TYPE_ARRAY:
		return output
	else:
		return []
 
func _next_phrase() -> void:
	"""
	
	"""
	if phrase_num >= len(dialog):
		_reset()
		return
	
	finished = false
	
	$Name.bbcode_text = dialog[phrase_num]["Name"]
	$Text.bbcode_text = dialog[phrase_num]["Text"]
	
	$Text.visible_characters = 0
	
	while $Text.visible_characters < len($Text.text):
		$Text.visible_characters += 1
		
		$Timer.start()
		yield($Timer, "timeout")
	
	finished = true
	$AnimationPlayer.play("Done")
	phrase_num += 1
	return
	
func _reset():
	"""
	Resettar alla variabler så att man kan spela ny dialog nästa gång systemet används
	"""
	dialog_path = ""
 
	phrase_num = 0
	finished = false
	self.visible = false 
	
	dialog_running = false
	


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	$AnimationPlayer.play("jumping")
