extends KinematicBody2D

export (int) var speed = 400
export (float) var rotation_speed = 3

var velocity = Vector2()
var rotation_dir = 0
onready var can_start = false

func get_input():
	"""
	Denna funktion tar emot input från spelaren
	Spelaren kan styra åt höger, vänster och gasa med mellanslag
	"""
	rotation_dir = 0
	velocity = Vector2()
	if Input.is_action_pressed("Right"):
		rotation_dir += 1
	if Input.is_action_pressed("Left"):
		rotation_dir -= 1
	if Input.is_action_pressed("Boost"):
		velocity = Vector2(speed, 0).rotated(rotation)

func _physics_process(delta):
	"""
	Om can start variabeln är true så kan spelaren köra, eftersom programmet kan ta emot input då
	"""
	if can_start:
		get_input()
		rotation += rotation_dir * rotation_speed * delta
		velocity = move_and_slide(velocity)

func _on_Btrace_ready_done():
	"""
	Spelaren kan starta  när ready-screenen är klar
	"""
	can_start = true

func _on_Btrace_game_over():
	"""
	Spelaren kan inte röra sig när spelet är över
	"""
	can_start = false
