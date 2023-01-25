extends Node2D


var keys_hit_sucessfully = false

onready var points_detector = $Bench_movement/Points_detector

onready var w_screen = $Winscreen
onready var l_screen = $Loose_screen

signal reset_lift
signal game_over

var score_red_area = 20
var score_yellow_area = 10
var minus_score = 10

var scored = ""

var health = 3
var health_indicator = ["Heart1", "Heart2", "Heart3"]


var score = 0

func _ready():
	w_screen.world_path = "res://Scenes/Stad/Gym.tscn"
	w_screen.game_path = "res://Scenes/Minigames/Benchpress.tscn"
	
	l_screen.world_path = "res://Scenes/Stad/Gym.tscn"
	l_screen.game_path = "res://Scenes/Minigames/Benchpress.tscn"

func _process(delta):
	for child in get_node("Health").get_children():
		if health_indicator.has(str(child.name)):
			child.visible = true
		else:
			child.visible = false
	_check_raycasts()
	if score >= 10:
		game_won()
	if health <= 0:
		game_over()
	keys_hit_sucessfully = false
	_draw_score()

func game_won():
	#$Bench_movement.ready_to_start = false
	emit_signal("game_over")
	$Winscreen.visible = true
	$Winscreen/AnimationPlayer.play("WIN")
	
func game_over():
	emit_signal("game_over")
	$Loose_screen.visible = true
	$Loose_screen/AnimationPlayer.play("LOOSE")

func _check_raycasts():
	if points_detector.is_colliding():	
		if points_detector.get_collider().name == "area_red" and keys_hit_sucessfully == true:
			score += score_red_area
			scored = "red"
		if points_detector.get_collider().name == "area_yellow" and keys_hit_sucessfully == true:
			score += score_yellow_area
			scored = "yellow"
		if points_detector.get_collider().name == "area_early" and keys_hit_sucessfully == true:
			scored = "early"

func _draw_score():
	$Scoretext.text = str(score)

func _on_Bench_movement_keys_hit_sucessfully():
	if points_detector.is_colliding():
		keys_hit_sucessfully = true
		#if scored == "early":
		#	print("early")
			#$Encouragement_screen/GREAT.bbcode_text = "[b][shake rate=5 level=10]TOO[/shake][/b]"
			#$Encouragement_screen/plus_score.bbcode_text = "[b][shake rate=5]" + "EARLY!" + "[/shake][/b]"
		if scored == "red":
			$Encouragement_screen/GREAT.bbcode_text = "[b][shake rate=5 level=10]GREAT![/shake][/b]"
			$Encouragement_screen/plus_score.bbcode_text = "[b][shake rate=5]+" + str(score_red_area) + "[/shake][/b]"
		if scored == "yellow":
			$Encouragement_screen/GREAT.bbcode_text = "[b][shake rate=5 level=10]GOOD![/shake][/b]"
			$Encouragement_screen/plus_score.bbcode_text = "[b][shake rate=5]+" + str(score_yellow_area) + "[/shake][/b]"
		if scored != "early":
			$Encouragement_screen.visible = true
			$Encouragement_screen/Explosion.emitting = true
			yield(get_tree().create_timer(1), "timeout")
			$Encouragement_screen.visible = false

func _on_Bench_movement_failed_lift():
	health -= 1
	health_indicator.erase(health_indicator[0])
	score -= 10
	$Failed_lift_screen.visible = true
	$Failed_lift_screen/Explosion.emitting = true
	yield(get_tree().create_timer(1), "timeout")
	emit_signal("reset_lift")
	$Failed_lift_screen.visible = false
