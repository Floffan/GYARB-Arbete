extends Node2D


var keys_hit_sucessfully = false

onready var popup = $Encouragement_popup

onready var points_detector = $Bench_movement/Points_detector

signal reset_lift

var score_red_area = 20
var score_yellow_area = 10
var minus_score = 10

var scored = ""


var score = 0

func _process(delta):
	 #popup.rect_global_position = self.position
	_check_raycasts()
	keys_hit_sucessfully = false
	_draw_score()





func _check_raycasts():
	if points_detector.is_colliding():	
		if points_detector.get_collider().name == "area_red" and keys_hit_sucessfully == true:
			score += score_red_area
			scored = "red"
		if points_detector.get_collider().name == "area_yellow" and keys_hit_sucessfully == true:
			score += score_yellow_area
			scored = "yellow"
	
		
	# Är det ens en bra ide med raycasts? kanske en area är bättre?
	# när stången är emellan 2 raycasts så verkar det som att den inte ger någon score alls
		
func _draw_score():
	$Scoretext.text = str(score)



func _on_Bench_movement_keys_hit_sucessfully():
	keys_hit_sucessfully = true
	
	if scored == "red":
		$Encouragement_screen/GREAT.bbcode_text = "[b][shake rate=5 level=10]GREAT![/shake][/b]"
		$Encouragement_screen/plus_score.bbcode_text = "[b][shake rate=5]" + str(score_red_area) + "[/shake][/b]"
	if scored == "yellow":
		$Encouragement_screen/GREAT.bbcode_text = "[b][shake rate=5 level=10]GOOD![/shake][/b]"
		$Encouragement_screen/plus_score.bbcode_text = "[b][shake rate=5]" + str(score_yellow_area) + "[/shake][/b]"
		
	$Encouragement_screen.visible = true
	$Encouragement_screen/Explosion.emitting = true
	yield(get_tree().create_timer(1), "timeout")
	$Encouragement_screen.visible = false

func _on_Bench_movement_failed_lift():
	print("failed")
	score -= 10
	$Failed_lift_screen.visible = true
	$Failed_lift_screen/Explosion.emitting = true
	yield(get_tree().create_timer(1), "timeout")
	emit_signal("reset_lift")
	$Failed_lift_screen.visible = false
