extends Navigation2D
"""
var speed = 400
var rotation_speed = 3
var rotation_direction = 0

onready var pos_finishline = $pos_finishline
onready var pos_1 = $pos_1
onready var pos_2 = $pos_2

var path = [pos_finishline, pos_1, pos_2]
#var path = []

var number = 0
onready var boat = $Boat_green

func _process(delta):
	var walk_distance = speed * delta
	move_along_path(walk_distance)


func _unhandled_input(event):
	#if not event.is_action_pressed("Klick"):
		#return
	number += 1
	_update_navigation_path(boat.position, path[number])


func move_along_path(distance):
	var last_point = boat.position
	while path.size():
		var distance_between_points = last_point.distance_to(path[0])
		# The position to move to falls between two points.
		if distance <= distance_between_points:
			boat.position = last_point.linear_interpolate(path[0], distance / distance_between_points)
			return
		# The position is past the end of the segment.
		distance -= distance_between_points
		last_point = path[0]
	# The character reached the end of the path.
	boat.position = last_point
	set_process(false)


func _update_navigation_path(start_position, end_position):
	# get_simple_path is part of the Navigation2D class.
	# It returns a PoolVector2Array of points that lead you
	# from the start_position to the end_position.
	path = get_simple_path(start_position, end_position, true)
	# The first point is always the start_position.
	# We don't need it in this example as it corresponds to the character's position.
	set_process(true)
"""
