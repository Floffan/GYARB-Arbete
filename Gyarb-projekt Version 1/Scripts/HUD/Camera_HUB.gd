extends Camera2D

onready var player = get_parent().get_node("YSort").get_node("Skelett")
var IV_open = false

onready var briefcase_scene = load("res://Cutscenes/Briefcase_locked.tscn")
#onready var instance = briefcase_scene.instance()

onready var animation_player = $CanvasLayer/AnimationPlayer


func _process(_delta):
	_get_input()
	position = player.position
	_display_briefcase()
	_display_items()
	
func _display_items():
	var text = ""
	for item in Autoloads.Items:
		$CanvasLayer/Panel.get_node(item).get_node(item).visible = true
		
func _display_briefcase():
	if Autoloads.have_briefcase:
		$CanvasLayer/Panel/Briefcase_button.visible = true
		$CanvasLayer/Panel/Briefcase.visible = false
	if Autoloads.have_briefcase == false:
		$CanvasLayer/Panel/Briefcase_button.visible = false
		$CanvasLayer/Panel/Briefcase.visible = true
	
func _ready():
	position = player.position
	$CanvasLayer/dark.visible = false

func _get_input():
	if Input.is_action_just_pressed("Check_briefcase") and IV_open == false:
		animation_player.play("Open_IV")
		$CanvasLayer/dark.visible = true
		IV_open = true
		return
	if Input.is_action_just_pressed("Check_briefcase") and IV_open:
		animation_player.play_backwards("Open_IV")
		$CanvasLayer/dark.visible = false
		IV_open = false

func _on_TextureButton_pressed() -> void:
	var instance = briefcase_scene.instance()
	add_child(instance)
	animation_player.play("RESET")
	IV_open = false
	self.current = true
	
