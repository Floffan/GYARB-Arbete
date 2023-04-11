extends Node2D

var game = "Bollplank"

onready var path_follow_horizontal = $IndicatorPath_horizontal/PathFollow2D

onready var raycast_horizontal_1 = $IndicatorPath_horizontal/PathFollow2D/Indikator1/RayCast2D1
onready var raycast_horizontal_2 = $IndicatorPath_horizontal/PathFollow2D/Indikator1/RayCast2D2

onready var path_follow_vertical = $IndicatorPath_vertical/PathFollow2D

onready var raycast_vertical_1 = $IndicatorPath_vertical/PathFollow2D/Indikator2/RayCast2D1
onready var raycast_vertical_2 = $IndicatorPath_vertical/PathFollow2D/Indikator2/RayCast2D2

export var speed = 7

var function_running = true

var hole_horizontal = []
var hole_vertical = [] 

# Hålets namn, om ett hål har träffats eller inte
var current_hole = ["hole", false]

onready var holes = {
	"Area_1" : $Areor_holes/Area_1,
	"Area_2" : $Areor_holes/Area_2,
	"Area_3" : $Areor_holes/Area_3,
	"Area_4" : $Areor_holes/Area_4,
	"Area_5" : $Areor_holes/Area_5,
	"Area_6" : $Areor_holes/Area_6	
}
var closed_holes = []


var time_for_next = false

var run_game = false

func _ready():
	$Ready_screen.visible = true
	Transition.get_node("AnimationPlayer").play("RESET")
	Autoloads.Position = "grotta_Minigame"
	
	$Winscreen.game_path = "res://Scenes/Minigames/Bollplank.tscn"
	$Winscreen.world_path = "res://Scenes/Berg/Grotta.tscn"
	
	$Loose_screen.game_path = "res://Scenes/Minigames/Bollplank.tscn"
	$Loose_screen.world_path = "res://Scenes/Berg/Grotta.tscn"
	

func _get_input():
	if time_for_next == true and Input.is_action_just_pressed("Stop"):
		time_for_next = false
		if raycast_vertical_1.is_colliding(): # Om en av dem kolliderar betyder det att båda kolliderar
			if hole_vertical.has(raycast_vertical_1.get_collider().name) != true:
				hole_vertical.append(raycast_vertical_1.get_collider().name)
			
			if hole_vertical.has(raycast_vertical_2.get_collider().name) != true:
				hole_vertical.append(raycast_vertical_2.get_collider().name)
		return
			
	if Input.is_action_just_pressed("Stop"):
		function_running = false
		time_for_next = true
		if raycast_horizontal_1.is_colliding():
			if hole_horizontal.has(raycast_horizontal_1.get_collider().name) != true:
				hole_horizontal.append(raycast_horizontal_1.get_collider().name)
			
			if hole_horizontal.has(raycast_horizontal_2.get_collider().name) != true: 
				hole_horizontal.append(raycast_horizontal_2.get_collider().name)
			
func _process(delta):
	if run_game:
		_get_input()
		_sight_position()
		
		if len(closed_holes) == 6:
			win_screen()
	
	if time_for_next == false and function_running == false: # Följande kod körs bara när båda pilarna har körts
		var position = $Sight.position
		if len(hole_vertical) > 0: # Följande statements körs inte när man missar alla vertikala hål; detta för att spelet ej ska krasha när den försöker söka efter hole_vertical[[0]
			if hole_horizontal.has(hole_vertical[0]):
				_close_hole(hole_vertical[0])
			if len(hole_vertical) == 2:
				if hole_horizontal.has(hole_vertical[1]):
					_close_hole(hole_vertical[1])
				else:	
					_set_new_run()
					_kick_ball(position)
			else:
				_set_new_run()
				_kick_ball(position)
				
		else: # Om inget matchande hål har påträffats händer ingenting, och variablerna resettas för att kunna spela igen.
			current_hole[1] = false
			_kick_ball(position)
			_set_new_run()
				
func _close_hole(hole):
	var position_hole
		
	position_hole = holes[str(hole)].position
	_kick_ball(position_hole)
		
	if closed_holes.has(hole) != true:
		current_hole[1] = true
		closed_holes.append(hole)
		current_hole[0] = hole
		#$Areor_holes/AnimationPlayer.play(hole)

	#print("closed holes:")
	#print(closed_holes)

	_set_new_run()
	
func _kick_ball(position_ballhit):
	var tween = get_node("Tween")
	tween.interpolate_property($Ball, "position",
	Vector2($Ball_pos.position), Vector2(position_ballhit), 0.4,
	Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	
func _set_new_run():
	"""
	Denna funktion resettar variablerna
	"""
	function_running = true
	time_for_next = false
	hole_vertical.clear()
	hole_horizontal.clear()
		
func _physics_process(delta):
	if run_game:
		if function_running:
			_move_along_path(delta, path_follow_horizontal)
		if time_for_next:
			_move_along_path(delta, path_follow_vertical)
		
func win_screen():
	if Autoloads.data["games_played"].has(game) == false:
		Autoloads.add_game_played(game)
		
	run_game = false
	$Winscreen.visible = true
	$Winscreen/AnimationPlayer.play("WIN")

func loose_screen():
	run_game = false
	$Loose_screen.visible = true
	$Loose_screen/AnimationPlayer.play("LOOSE")
		
func _sight_position():
	if function_running == true:
		$Sight.position.x = $IndicatorPath_horizontal/PathFollow2D.position.x
	
	if time_for_next == true:
		$Sight.position.y = $IndicatorPath_vertical/PathFollow2D.position.y
	
func _move_along_path(delta, path):
	path.set_offset(path.get_offset() + speed + delta)

func _on_Tween_tween_completed(object, key):
	yield(get_tree().create_timer(0.3), "timeout")
	if current_hole[1]:
		$Areor_holes/AnimationPlayer.play(current_hole[0])
		current_hole[1] = false
	$Ball.position = $Ball_pos.position

func _on_Ready_screen_ready_done():
	run_game = true
	$Ready_screen.rect_position.x += 20
	yield(get_tree().create_timer(2), "timeout")
	"""
	TA BORT READY-SCREENEN
	"""
