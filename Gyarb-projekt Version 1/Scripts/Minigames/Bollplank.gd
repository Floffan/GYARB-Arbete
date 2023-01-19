extends Node2D

onready var path_follow_horizontal = $IndicatorPath_horizontal/PathFollow2D

onready var raycast_horizontal_1 = $IndicatorPath_horizontal/PathFollow2D/Indikator1/RayCast2D1
onready var raycast_horizontal_2 = $IndicatorPath_horizontal/PathFollow2D/Indikator1/RayCast2D2

onready var path_follow_vertical = $IndicatorPath_vertical/PathFollow2D

onready var raycast_vertical_1 = $IndicatorPath_vertical/PathFollow2D/Indikator2/RayCast2D1
onready var raycast_vertical_2 = $IndicatorPath_vertical/PathFollow2D/Indikator2/RayCast2D2

"""
FUNDERA PÅ HUR MAN KAN LÖSA PROBLEMET:
	Raycasten returnar bara den första arean som den stötet på, inte de andra. 
	Därför går det inte att nå de bakre hålen utan att trixa
	hjälp!
	
LÖSNING:
	Jag satte en Raycast åt andra hållet också, och jag la in både det hålet som raycasten 
	frammåt identifierade, och det hålet som raycasten bakåt identifierade. Sedan checkar man om något item är
	detsamma ur de två listorna.
	
KVAR ATT GÖRA:
	Hitta ett sätt för pilarna att gå tillbaka till startpositionen när en omgång är klar
	"""

export var speed = 5

var function_running = true

var hole_horizontal = []
var hole_vertical = [] 

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


func _get_input():
	if time_for_next == true and Input.is_action_just_pressed("Stop"):
		time_for_next = false
		#print(raycast_vertical_1.get_collider())
		if raycast_vertical_1.is_colliding(): # Om en av dem kolliderar betyder det att båda kolliderar
			hole_vertical.append(raycast_vertical_1.get_collider().name)
			
		
			if hole_vertical.has(raycast_vertical_2.get_collider().name) != true:
				hole_vertical.append(raycast_vertical_2.get_collider().name)
				
		print("vertical:")
		print(hole_vertical)
			
		return
			
	if Input.is_action_just_pressed("Stop"):
		function_running = false
		time_for_next = true
		# Kollar om hålet ifråga redan finns på listan, annars läggs det till
		if raycast_horizontal_1.is_colliding():
			if hole_horizontal.has(raycast_horizontal_1.get_collider().name) != true:
				hole_horizontal.append(raycast_horizontal_1.get_collider().name)
			
			if hole_horizontal.has(raycast_horizontal_2.get_collider().name) != true: 
				hole_horizontal.append(raycast_horizontal_2.get_collider().name)
			
		print("horizontal:")
		print(hole_horizontal)
			
func _process(delta):
	_get_input()
	_sight_position()
	
	if time_for_next == false and function_running == false: # Följande kod körs bara när båda pilarna har körts
		if len(hole_vertical) > 0: # Följande statements körs inte när man missar alla vertikala hål; detta för att spelet ej ska krasha när den försöker söka efter hole_vertical[[0]
			if hole_horizontal.has(hole_vertical[0]):
				_close_hole(hole_vertical[0])
			if len(hole_vertical) == 2:
				if hole_horizontal.has(hole_vertical[1]):
					_close_hole(hole_vertical[1])
				_set_new_run()
		else: # Om inget matchande hål har påträffats händer ingenting, och variablerna resettas för att kunna spela igen.
			_set_new_run()
			
func _close_hole(hole):
	var position_hole
	if len(closed_holes) == 6:
		win_screen()
		
	position_hole = holes[str(hole)].position
	_kick_ball(position_hole)
		
	if closed_holes.has(hole) != true:
		closed_holes.append(hole)
		$Areor_holes/AnimationPlayer.play(hole)

	print("closed holes:")
	print(closed_holes)


	_set_new_run()
	
func _kick_ball(position_hole):
	"""
	Här 
	"""
	$Ball.position = position_hole
	
	#draw_line($Ball.position, position_hole, 255,255,255)
	
func _set_new_run():
	"""
	Denna funktion resettar variablerna
	"""
	function_running = true
	time_for_next = false
	hole_vertical.clear()
	hole_horizontal.clear()
		
func _physics_process(delta):
	if function_running:
		_move_along_path(delta, path_follow_horizontal)
	if time_for_next:
		_move_along_path(delta, path_follow_vertical)
		
func win_screen():
	"""
	Här 
	"""
	pass
		
func _sight_position():
	if function_running == true:
		$Sight.position.x = $IndicatorPath_horizontal/PathFollow2D.position.x
	
	if time_for_next == true:
		$Sight.position.y = $IndicatorPath_vertical/PathFollow2D.position.y
	
func _move_along_path(delta, path):
	path.set_offset(path.get_offset() + speed + delta)
