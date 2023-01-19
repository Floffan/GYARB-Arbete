extends KinematicBody2D
"""

export var speed = 500


var velocity = Vector2()




#func _move_player(delta:float) -> void:
	#if move


func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("Right"):
		velocity.x += 1
	if Input.is_action_pressed("Left"):
		velocity.x -= 1
	if Input.is_action_pressed("Down"):
		velocity.y += 1
	if Input.is_action_pressed("Up"):
		velocity.y -= 1
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
"""
