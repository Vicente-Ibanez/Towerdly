extends CharacterBody2D
## This script controls the movement of soldiers

var speed = 70
var accel = 150
var friction = 700

var is_attacking = false
var input_movement = Vector2(5, 0)

func _process(delta):
	if not is_attacking:
		if input_movement == Vector2.ZERO:
			if velocity.length() > (friction*delta):
				velocity -= velocity.normalized() * (friction*delta)
			else:
				velocity = Vector2.ZERO
		else:
			velocity += (input_movement * accel * delta)
			velocity = velocity.limit_length(speed)

			move_and_slide()
