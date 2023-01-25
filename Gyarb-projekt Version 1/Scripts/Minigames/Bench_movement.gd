extends KinematicBody2D

var current_animation = "down"

var key_hit
var required_key
var required_letter

var key_hit_list = []

var letter_1 = []
var letter_2 = []

signal keys_hit_sucessfully
signal keys_hit_wrong
signal failed_lift

var ready_to_start = false
var failed_lift = false

#$AnimationPlayer.playback_speed = 5


func get_input():
	if Input.is_action_just_pressed("Right"):
		key_hit = "Right"
		_action_pressed(key_hit)
	elif Input.is_action_just_pressed("Left"):
		key_hit = "Left"
		_action_pressed(key_hit)
	elif Input.is_action_just_pressed("Down"):
		key_hit = "Down"
		_action_pressed(key_hit)
	elif Input.is_action_just_pressed("Up"):
		key_hit = "Up"
		_action_pressed(key_hit)
	
func _action_pressed(key_hit):
	key_hit_list.append(key_hit)
	if key_hit_list.has(letter_1[0]) and key_hit_list.has(letter_2[0]) and failed_lift == false and current_animation == "down":
		current_animation = "up"
		$Timer.start()
		letter_1.clear()
		letter_2.clear()
		key_hit_list.clear()
		emit_signal("keys_hit_sucessfully")

		_draw_required_key()
	
func _assign_animation():
	$AnimationPlayer.playback_speed = 2.5
	if current_animation == "up":
		$AnimationPlayer.play_backwards("Bänk")
	if current_animation == "down":
		$AnimationPlayer.play("Bänk")
	if current_animation == "läge upp":
		$AnimationPlayer.play("Läge_upp")
	if current_animation == "läge ner":
		$AnimationPlayer.play("Läge_ner")

func _on_Timer_timeout():
	current_animation = "down"
	
func _on_AnimationPlayer_animation_finished(anim_name):
	if current_animation == "up":
		current_animation = "läge_upp"
		#gör läge upp animationen lite mer lifelike, trembling armar och andetag
	if current_animation == "down":
		current_animation = "läge_ner"
		failed_lift = true
		emit_signal("failed_lift")
		
func _get_required_key():
	var key
	var keys = {"Up":"B","Down" :"b", "Left":"a", "Right":"A"} # Up, Down, Left, Right
	
	randomize()
	key = keys.keys()[randi() % keys.keys().size()]
	
	required_key = key
	required_letter = keys[key]
	
	return required_letter and required_key
	
func _draw_required_key():
	for i in range(0,2):
		_get_required_key()
		if i == 0:
			letter_1.append(required_key)
			letter_1.append(required_letter)
		if i == 1:
			letter_2.append(required_key)
			letter_2.append(required_letter)
	
	get_parent().get_node("Control/Panel/Label").text = letter_1[1] + letter_2[1] #required_letter #Detta blir en bokstav

func _process(delta):
	if ready_to_start:
		get_input()
		_assign_animation()


func _on_Ready_screen_ready_done():
	ready_to_start = true
	get_parent().get_node("Control/Information").visible = false
	_draw_required_key()
	get_parent().get_node("Ready_screen").queue_free()


func _on_Bench_scene_reset_lift():
	letter_1.clear()
	letter_2.clear()
	key_hit_list.clear()
	_draw_required_key()
	current_animation = "down"
	failed_lift = false


func _on_Bench_scene_game_over():
	ready_to_start = false
