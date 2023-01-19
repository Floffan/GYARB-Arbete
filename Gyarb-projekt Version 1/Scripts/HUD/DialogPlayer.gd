extends CanvasLayer

#export var dialogPath = "res://Dialog/Dialog.json"
export var dialogPath = ""
export(float) var textSpeed = 0.05
 
var dialog
 
var phraseNum = 0
var finished = false
 

func play_dialog(dialogPath, textSpeed):
	$Dialog.visible = true
	$Dialog/Timer.wait_time = textSpeed
	dialog = getDialog(dialogPath)
	assert(dialog, "Dialogen hittades ej")
	nextPhrase()
 

func _ready():
	$Dialog.visible = false
#	$Timer.wait_time = textSpeed
#	dialog = getDialog()
#	assert(dialog, "Dialogen hittades ej")
#	nextPhrase()
 
func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		if finished:
			nextPhrase()
		else:
			$Dialog/Text.visible_characters = len($Dialog/Text.text)
 
func getDialog(dialogPath) -> Array:
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
		queue_free()
		return
	
	finished = false
	
	$Dialog/Name.bbcode_text = dialog[phraseNum]["Name"]
	$Dialog/Text.bbcode_text = dialog[phraseNum]["Text"]
	
	$Dialog/Text.visible_characters = 0
	
	#var f = File.new()
	#var img = dialog[phraseNum]["Name"] + dialog[phraseNum]["Emotion"] + ".png"
	#if f.file_exists(img):
	#	$Portrait.texture = load(img)
	#else: $Portrait.texture = null
	
	while $Dialog/Text.visible_characters < len($Dialog/Text.text):
		$Dialog/Text.visible_characters += 1
		
		$Dialog/Timer.start()
		yield($Dialog/Timer, "timeout")
	
	finished = true
	phraseNum += 1
	return
	
