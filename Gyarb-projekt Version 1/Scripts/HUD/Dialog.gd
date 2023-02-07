extends Control

export var dialogPath = ""
export(float) var textSpeed = 0.05
 
var dialog
 
var phraseNum = 0
var finished = false

var dialog_running = false
 

func play_dialog(dialogPath, textSpeed, num):
	#dialogPath = dialogPath + str(num)
	
	print(dialogPath)
	
	dialog_running = true
	yield(get_tree().create_timer(0.01), "timeout")
	self.visible = true
	$Timer.wait_time = textSpeed
	dialog = getDialog(dialogPath, num)
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
 
func getDialog(dialogPath, num) -> Array:
	var f = File.new()
	assert(f.file_exists(dialogPath), "Filsökvägen hittades ej")
	
	f.open(dialogPath, File.READ)
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
	dialogPath = ""
 
	phraseNum = 0
	finished = false
	self.visible = false 
	
	dialog_running = false
	
