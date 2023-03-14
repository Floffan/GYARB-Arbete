extends Node2D

var game = "Skidshop"

onready var w_screen = $Winscreen
onready var l_screen = $Loose_screen

onready var glow_scene = load("res://Scenes/Minigames/Glow_skidor.tscn")

onready var colours = {
	"Green" : [$Skidor/Skidor_bak/Green2, $Skidor/Skidor_mitt/Green],
	"Blue" : [$Skidor/Skidor_bak/Blue2, $Skidor/Skidor_mitt/Blue],
	"Turquise" : [$Skidor/Skidor_bak/Turquise2, $Skidor/Skidor_fram/Turquise],
	"Red" : [$Skidor/Skidor_bak/Red2, $Skidor/Skidor_fram/Red],
	"Pink" : [$Skidor/Skidor_mitt/Pink],
	"Yellow" : [$Skidor/Skidor_fram/Yellow],
	}

var request = []
var request_nodes = []

var rounds_to_win = 2

# gör till dic
var buttons_pressed = []
var buttons_instances = []

var num = 0

var rounds_won_num = 0

var num_difficulty = 2

var health = 3
var health_indicator = ["Heart1", "Heart2", "Heart3"]

signal stand_still

signal shrug
	
func _ready():
	Autoloads.Position = "Stuga_Minigame"
	emit_signal("stand_still")
	_set_wl_screen_path()
	
	yield(get_tree().create_timer(1), "timeout")
	_get_request()
	
func _process(delta):
	_draw_health()
	
func _set_wl_screen_path():
	w_screen.game_path = "res://Scenes/Minigames/Skidshop.tscn"
	w_screen.world_path = "res://Scenes/Berg/Stuga.tscn"
	
	l_screen.game_path = "res://Scenes/Minigames/Skidshop.tscn"
	l_screen.world_path = "res://Scenes/Berg/Stuga.tscn"
	
func _draw_health():
	for child in get_node("Health").get_children():
		if health_indicator.has(str(child.name)):
			child.visible = true
		else:
			child.visible = false
	
func _incorrect_code():
	emit_signal("shrug")
	$Shrug_timer.start()
	health -= 1
	health_indicator.erase(health_indicator[0])
	
	if health == 0:
		_loose_screen()
	else:
		_reset()
		_get_request()
	
func _check_if_correct(button):
	if request_nodes[num] != button:
		_incorrect_code()
	else:
		num += 1
	if num == num_difficulty:
		_won_round()
	
func _won_round():
	rounds_won_num += 1
	num_difficulty += 1
	
	if rounds_won_num == rounds_to_win:
		_win_screen()
	else:
		_reset()
		_get_request()
		
		
func _reset():
	for instance in buttons_instances:
		instance.get_node("AnimationPlayer").play("fade_out")
		
	buttons_instances = []	
	request = []
	request_nodes = []
	
	num = 0
	
	
func _win_screen():
	get_node("WorldEnvironment").queue_free()
	$Winscreen.visible = true
	$Winscreen/AnimationPlayer.play("WIN")
	if Autoloads.data["games_played"].has(game) == false:
		Autoloads.add_game_played(game)
		
		
func _loose_screen():
	$Loose_screen.visible = true
	$Loose_screen/AnimationPlayer.play("LOOSE")
	
func _get_request():
	yield(get_tree().create_timer(1), "timeout")
	randomize()
	for i in range(num_difficulty):
		var colour = colours.keys()[randi() % colours.size()]
		request.append(colour)
		var colour_node = colours[colour][randi() % colours[colour].size()]
		request_nodes.append(colour_node)
		
	_draw_request_text(request)
	_draw_request(request_nodes)
		
func _draw_request_text(request):
	var request_text = []
	for colour in request:
		var string = ""	
		if colour == "Pink":
			string = "[color=fuchsia]rosa[/color]"
		if colour == "Green":
			string = "[color=lime]gröna[/color]"
		if colour == "Turquise":	
			string = "[color=aqua]turkosa[/color]"
		if colour == "Yellow":	
			string = "[color=yellow]gula[/color]"
		if colour == "Blue":
			string = "[color=blue]blåa[/color]"
		if colour == "Red":
			string = "[color=red]röda[/color]"
			
		request_text.append(string)
			
	if num_difficulty == 2:
		$Skylt/Request.bbcode_text = "jag vill ha " + str(request_text[0]) + " och " + str(request_text[1]) + " skidor"
	if num_difficulty == 4:
		$Skylt/Request.bbcode_text = "jag vill ha " + str(request_text[0]) + ", " + str(request_text[1]) + ", " + str(request_text[2]) + ", " + str(request_text[3]) + " och " + str(request_text[4]) + " skidor"

func _draw_request(request_nodes):
	for i in range(len(request_nodes)):
		var instance = glow_scene.instance()
		
		$Skidor.add_child(instance)
		instance.position = request_nodes[i].rect_position
		if request_nodes[i].is_in_group("Bak"):
			instance.z_index = -3
		if request_nodes[i].is_in_group("Mitt"):
			instance.z_index = -2
		if request_nodes[i].is_in_group("Fram"):
			instance.z_index = -1
		
		yield(get_tree().create_timer(0.7), "timeout")
		instance.get_node("AnimationPlayer").play("fade_out")

func _add_pressed_button(button, layer):
	var instance = glow_scene.instance()
	get_node("Skidor").get_node(layer).add_child(instance)
	instance.position = button.rect_position
	
	buttons_pressed.append(button)
	buttons_instances.append(instance)
	_check_if_correct(button)

func _on_Turquise2_pressed():
	var button = $Skidor/Skidor_bak/Turquise2
	_add_pressed_button(button, "Skidor_bak")
	
func _on_Green2_pressed():
	var button = $Skidor/Skidor_bak/Green2
	_add_pressed_button(button, "Skidor_bak")

func _on_Red2_pressed():
	var button = $Skidor/Skidor_bak/Red2
	_add_pressed_button(button, "Skidor_bak")
	
func _on_Blue2_pressed():
	var button = $Skidor/Skidor_bak/Blue2
	_add_pressed_button(button, "Skidor_bak")

func _on_Pink_pressed():
	var button = $Skidor/Skidor_mitt/Pink
	_add_pressed_button(button, "Skidor_mitt")

func _on_Green_pressed():
	var button = $Skidor/Skidor_mitt/Green
	_add_pressed_button(button, "Skidor_mitt")

func _on_Blue_pressed():
	var button = $Skidor/Skidor_mitt/Blue
	_add_pressed_button(button, "Skidor_mitt")

func _on_Yellow_pressed():
	var button = $Skidor/Skidor_fram/Yellow
	_add_pressed_button(button, "Skidor_fram")

func _on_Red_pressed():
	var button = $Skidor/Skidor_fram/Red
	_add_pressed_button(button, "Skidor_fram")

func _on_Turquise_pressed():
	var button = $Skidor/Skidor_fram/Turquise
	_add_pressed_button(button, "Skidor_fram")

func _on_Orange_pressed():
	var button = $Skidor/Skidor_fram/Orange
	_add_pressed_button(button, "Skidor_fram")


func _on_Shrug_timer_timeout():
	emit_signal("stand_still")
