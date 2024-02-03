extends Node2D

const MOVE_SPEED = 750
var left_limit = 600
var right_limit = 2800


func _process(delta):
	if Input.is_action_pressed("move_camera_left"):
		if(global_position.x >= left_limit):
			global_position += Vector2.LEFT * delta * MOVE_SPEED
	elif Input.is_action_pressed("move_camera_right"):
		if(global_position.x <= right_limit):
			global_position += Vector2.RIGHT * delta * MOVE_SPEED
