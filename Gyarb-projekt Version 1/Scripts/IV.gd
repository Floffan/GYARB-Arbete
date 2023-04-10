extends Panel

onready var briefcase_scene = load("res://Cutscenes/Briefcase_locked.tscn")

onready var camera = get_parent().get_parent()

signal reset

func _process(_delta):
	_display_briefcase()
	_display_items()

func _display_items():
	var text = ""
	$Flower/Antal.bbcode_text = str(len(Autoloads.data["flowers"]))
	if len(Autoloads.data["flowers"]) > 0:
		$Flower/Flower.visible = true
		$Flower/Antal.visible = true
	for item in Autoloads.data["items"]:
		get_node(item).get_node(item).visible = true
		
func _display_briefcase():
	if Autoloads.data["have_briefcase"]:
		$Briefcase_button.visible = true
		$Briefcase.visible = false
	if Autoloads.data["have_briefcase"] == false:
		$Briefcase_button.visible = false
		$Briefcase.visible = true

func _on_Briefcase_button_pressed() -> void:
	if camera.briefcase_scene_open == false:
		camera.briefcase_scene_open = true
		var instance = briefcase_scene.instance()
		camera.add_child(instance)
		emit_signal("reset")
		camera.IV_open = false
		camera.current = true
