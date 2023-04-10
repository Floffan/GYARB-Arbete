extends Camera2D

onready var player = get_parent().get_node("YSort").get_node("Skelett")
var IV_open = false

onready var briefcase_scene = load("res://Cutscenes/Briefcase_locked.tscn")
onready var options_scene = load("res://Scenes/UI/Options.tscn")

onready var animation_player = $CanvasLayer/AnimationPlayer


func _process(_delta):
	_get_input()
	position = player.position

	
func _ready():
	position = player.position
	$CanvasLayer/dark.visible = false
	Transition.get_node("AnimationPlayer").play("RESET")

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
	
func _on_Avsluta_button_down() -> void:
	Transition.load_scene("res://Scenes/UI/Main_menu.tscn")


func _on_Instllningar_button_down() -> void:
	var instance = options_scene.instance()
	add_child(instance)


func _on_IV_reset() -> void:
	animation_player.play("RESET")
