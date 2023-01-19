extends KinematicBody2D

export var speed = 700


var velocity = Vector2()
var direction = ["direction i x-led", "direction i y-led"]
var moving_y = false

#var direction = null




func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("Right"):
		velocity.x += 1
		moving_y = false
	if Input.is_action_pressed("Left"):
		velocity.x -= 1
		moving_y = false
	if Input.is_action_pressed("Down"):
		velocity.y += 1
		moving_y = true
	if Input.is_action_pressed("Up"):
		velocity.y -= 1
		moving_y = true
		
		
	velocity = velocity.normalized() * speed
	
func _assign_animation():
	var animation = "Stå-animation"
	if velocity.x > 0:
		$polygons_sidan.scale.x = 1
		$Skelett_sidan.scale.x = 1
		#direction = "right"
		#direction[0] = "right" #BYT x-led till RIGHT
		
		$Skelett_collision.position.x = 74
		animation = "Gå-animation"
	elif velocity.x < 0:
		$polygons_sidan.scale.x = -1
		$Skelett_sidan.scale.x = -1
		
		#direction[0] = "left"
		
		#direction = "left"
		#BYT x-led till LEFT
		
		$Skelett_collision.position.x = -74
		animation = "Gå-animation"
		
	elif velocity.y > 0:
		$polygons_sidan.scale.x = 0
		$Skelett_sidan.scale.x = 0
		#direction = "down"
		
		#direction[1] = "down"
		animation = "Gå-animation_framifrån"
	elif velocity.y > 0:
		pass
		
		#if direction == "right":
			#$Skelett_fram.position.x = 20
			#$polygons_fram.position.x = 20
			
			#animation = "Gå-animation_framifrån"
		#if direction == "left":
			#$Skelett_fram.position.x = -70
			#$polygons_fram.position.x = -70
			
			
			#animation = "Gå-animation_framifrån"
		#else:
			#animation = "Stå-animation_framifrån"
		
	#_assigned_direction(direction)	
		
	if $AnimationPlayer.assigned_animation != animation:
		$AnimationPlayer.play(animation)
		
		
func _assigned_direction(direction):
	var animation = "Stå-animation"
	if direction[0] == "right" and direction[1] == "down":
		$Skelett_fram.position.x = 20
		$polygons_fram.position.x = 20
			
		animation = "Gå-animation_framifrån"
	if direction[0] == "left" and direction[1] == "down":
		$Skelett_fram.position.x = -70
		$polygons_fram.position.x = -70
	if direction[0] == "right" and not moving_y:
		animation = "Gå-animation"
	if direction[0] == "left" and not moving_y:
		animation = "Gå-animation"
		
		animation = "Gå-animation_framifrån"
		
	# IF LEFT OCH DOWN:
	# SPELA IDLE ANIMATIONEN MED SKELETT_FRONT
		
		
	if $AnimationPlayer.assigned_animation != animation:
		$AnimationPlayer.play(animation)
	

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
	
	_assign_animation()




#var collsiion = get_slide_collision(1)
#if collision_collider is Area2D:
	#print("kolliderade med ", collision.collider.name)
