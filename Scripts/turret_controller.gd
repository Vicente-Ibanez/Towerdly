extends Sprite2D
var rotation_amt = .01
var max_up_rotation = -1
var max_down_rotation = .75
var current_rotation = 0

func _process(delta):
	# Rotate the turret upward
	if Input.is_action_pressed("move_turret_up"):
		# Enforce max rotation upward
		if(current_rotation >= max_up_rotation):
			rotate(-rotation_amt)
			current_rotation -= rotation_amt 
		print_debug(current_rotation)
	# Rotate the turret downward
	elif Input.is_action_pressed("move_turret_down"):
		# Enforce max rotation downward
		if(current_rotation <= max_down_rotation):
			rotate(rotation_amt)
			current_rotation += rotation_amt
		print_debug(current_rotation)
