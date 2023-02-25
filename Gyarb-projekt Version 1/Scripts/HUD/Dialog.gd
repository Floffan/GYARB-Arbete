extends Control

export var dialog_path = ""
export(float) var text_speed = 0.05
 
var dialog
 
var phraseNum = 0
var finished = false

var dialog_running = false
 

func play_dialog(character, location, num):
	#dialogPath = dialogPath + str(num)
	
	dialog_path = "res://Dialog/" + str(location) + "/" + character + "_dia_" + str(num) + ".json"
	print(dialog_path)
	#var path = "res://Dialog/Strand/Squid_dia.json"
	
	dialog_running = true
	yield(get_tree().create_timer(0.01), "timeout")
	self.visible = true
	$Timer.wait_time = text_speed
	dialog = getDialog(dialog_path, num)
	assert(dialog, "Dialogen hittades ej")
	nextPhrase()
 
func _ready():
	self.visible = false
	
func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		if finished:
			nextPhrase()
		else:
			$Text.visible_characters = len($Text.text)
 
func getDialog(dialog_path, num) -> Array:
	var f = File.new()
	assert(f.file_exists(dialog_path), "Filsökvägen hittades ej")
	
	f.open(dialog_path, File.READ)
	var json = f.get_as_text()
	
	var output = parse_json(json)
	
	if typeof(output) == TYPE_ARRAY:
		return output
	else:
		return []
 
func nextPhrase() -> void:
	if phraseNum >= len(dialog):
		_reset()
		return
	
	finished = false
	
	$Name.bbcode_text = dialog[phraseNum]["Name"]
	$Text.bbcode_text = dialog[phraseNum]["Text"]
	
	$Text.visible_characters = 0
	
	while $Text.visible_characters < len($Text.text):
		$Text.visible_characters += 1
		
		$Timer.start()
		yield($Timer, "timeout")
	
	finished = true
	phraseNum += 1
	return
	
func _reset():
	dialog_path = ""
 
	phraseNum = 0
	finished = false
	self.visible = false 
	
	dialog_running = false
	
