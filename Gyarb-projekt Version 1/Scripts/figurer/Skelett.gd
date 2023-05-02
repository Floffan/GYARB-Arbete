extends KinematicBody2D

signal gate_detected
signal NPC_detected
signal Interaction_detected

var speed = 700

var velocity = Vector2()
export var direction = ["direction i x-led", "direction i y-led"]

onready var detectors = [$Gate_detector, $NPC_detector]

var only_moving_y

var moving_x = false
var moving_y = false

export var gate_collider = ""

var animation = "Stå-animation"

var can_move = true


func get_input():
	velocity = Vector2()
	moving_x = false
	
	if Input.is_action_pressed("Right"):
		velocity.x += 1
		moving_x = true
		moving_y = false
	if Input.is_action_pressed("Left"):
		velocity.x -= 1
		moving_x = true
		moving_y = false
	if Input.is_action_pressed("Down"):
		velocity.y += 1
		moving_y = true
	if Input.is_action_pressed("Up"):
		velocity.y -= 1
		moving_y = true

	if moving_y == true and moving_x == false:
		only_moving_y = true
	else:
		only_moving_y = false
		
	velocity = velocity.normalized() * speed
	
func _assign_direction():
	if velocity.x > 0:
		direction[0] = "right"
		
	elif velocity.x < 0:	
		direction[0] = "left"

	elif velocity.y > 0:
		direction[1] = "down"
		
	elif velocity.y < 0:
		direction[1] = "up"
		
	_assign_animation()	
		
func _assign_animation():

	"""
	Denna funktion assignar animationer
	"""
	
	"""
	Om spelaren ej kan röra sig (den är i en cutscene t.ex) kan inga nya animationsdirektiv tas om de inte manuellt läggs in
	Detta är använbart på vissa ställen där skelettet t.ex ska rycka på axlarna
	"""
	if can_move == false:
		$AnimationPlayer.play(animation)
		velocity.y = 0
		velocity.x = 0
		return
	
	"""
	Höger/Vänster-hantering [x-led]
	"""
	if direction[0] == "right" and not only_moving_y:
		$polygons_sidan.scale.x = 1
		$Skelett_sidan.scale.x = 1
		
		# Ändrar positionen relativt tll föräldernoden för att kompensera för den felsatta pivot-punkten
		$polygons_sidan.position.x = -36
		$Skelett_sidan.position.x = -36

		
		animation = "Gå-animation"
	if direction[0] == "left" and not only_moving_y:
		$polygons_sidan.scale.x = -1
		$Skelett_sidan.scale.x = -1
		
		# Ändrar positionen relativt tll föräldernoden för att kompensera för den felsatta pivot-punkten
		$polygons_sidan.position.x = 36
		$Skelett_sidan.position.x = 36

		
		animation = "Gå-animation"
		
	"""
	Gå-animationen ersätts av en Idle-animation
	"""
	if velocity.x == 0 and not only_moving_y:
		animation = "Stå-animation"
	
	"""
	Höger/Vänster-hantering [Nedåt]
	"""
	if direction[1] == "down" and direction[0] == "right" and only_moving_y: 
		$polygons_sidan.scale.x = 0
		#$Skelett_sidan.scale.x = 0
		
		animation = "Gå-animation_framifrån"
	if direction[1] == "down" and direction[0] == "left" and only_moving_y:

		$polygons_sidan.scale.x = 0
		#$Skelett_sidan.scale.x = 0
		
		animation = "Gå-animation_framifrån"
	if direction[1] == "down" and direction[0] == "direction i x-led" and only_moving_y:

		$polygons_sidan.scale.x = 0
		#$Skelett_sidan.scale.x = 0
		
		animation = "Gå-animation_framifrån"
	"""
	Höger/Vänster-hantering [Uppåt]
	"""
	if direction[1] == "up" and direction[0] == "right" and only_moving_y: 

		$polygons_sidan.scale.x = 0
		#$Skelett_sidan.scale.x = 0
		
		animation = "Gå-animation_bakifrån"
	if direction[1] == "up" and direction[0] == "left" and only_moving_y:

		$polygons_sidan.scale.x = 0
		#$Skelett_sidan.scale.x = 0

		animation = "Gå-animation_bakifrån"
	if direction[1] == "up" and direction[0] == "direction i x-led" and only_moving_y:

		$polygons_sidan.scale.x = 0
		#$Skelett_sidan.scale.x = 0

		animation = "Gå-animation_bakifrån"
	
	"""
	Gå-animationen ersätts av en Idle-animation
	"""
	if velocity.y == 0 and direction[1] == "down" and only_moving_y:
		animation = "Stå-animation_framifrån"
	if velocity.y == 0 and direction[1] == "up" and only_moving_y:
		animation = "Stå-animation_bakifrån"

	"""
	Om nya animationsdirektiv tillkommer spelas den nya animationen
	"""
	if $AnimationPlayer.assigned_animation != animation:
		if animation == "Gå-animation_bakifrån":
			#$AnimationPlayer.playback_speed = 2
			$AnimationPlayer.play(animation)
		else:
			#$AnimationPlayer.playback_speed = 1
			$AnimationPlayer.play(animation)
		
func _check_raycasts():
	if $Gate_detector.is_colliding():
		Autoloads.Gate_collider = $Gate_detector.get_collider().name
		emit_signal("gate_detected")
	if $NPC_detector.is_colliding():
		emit_signal("NPC_detected")
	if $Interact_detector.is_colliding():
		emit_signal("Interaction_detected")
		
func _check_case():
	"""
	Fixa snyggare lol
	"""
	if Autoloads.data["have_briefcase"]:
		$polygons_bak/case.visible = true
		$polygons_fram/case.visible = true
		$polygons_sidan/case.visible = true
		
		$polygons_bak/vante_v.visible = false
		$polygons_fram/vante_v.visible = false
		$polygons_sidan/vante_v.visible = false
	else:
		$polygons_bak/vante_v.visible = true
		$polygons_fram/vante_v.visible = true
		$polygons_sidan/vante_v.visible = true
		
		$polygons_bak/case.visible = false
		$polygons_fram/case.visible = false
		$polygons_sidan/case.visible = false
		
func _align_detectors():
	"""
	Ser till att detector-raycastsen riktas åt det håll som spelaren är vänd mot
	"""
	for detector in detectors:
		if direction[0] == "left": # if-satsen ser till att spelaren kan upptäcka NPC:s om de står vända mot dem
			detector.rotation_degrees = 90
		if direction[0] == "right":
			detector.rotation_degrees = -90
		if direction[1] == "up":
			detector.rotation_degrees = -180
		if direction[1] == "down":
			detector.rotation_degrees = 180
	
func _physics_process(_delta):
	"""
	Processfunktionen -> körs hela tiden
	Här fås riktningen på skeletett, och raycastsen lägger sig rätt.
	"""
	_check_case()
	if can_move:
		get_input()
	_check_raycasts()
	
	velocity = move_and_slide(velocity)
	
	_assign_direction()
	_align_detectors()

func _on_Spawn_looking_around():
	can_move = false
	animation = "Look_around"
	$Timer.start()
	
func _on_Timer_timeout():
	animation = "Stå-animation_framifrån"


func _on_Skidshop_shrug():
	animation = "Shrug"


func _on_Skidshop_stand_still():
	animation = "Stå-animation_framifrån"
	can_move = false


func _on_Spawn_can_move():
	can_move = true


func _on_Stuga_can_move():
	can_move = true


func _on_Gate_menu_can_move() -> void:
	can_move = true

func _on_Gate_menu_stand_still() -> void:
	animation = "Stå-animation_bakifrån"
	can_move = false
