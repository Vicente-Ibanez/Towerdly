extends Sprite2D
var rotation_amt = .01
var max_up_rotation = -1
var max_down_rotation = .75
var current_rotation = 0

var turret_firing = false
const projectile_path: String = "res://Full_Assets/Projectile_Full.tscn"
var projectile_preload = preload(projectile_path)
var gamescene
var fire_speed = 1
var fire_delay = 1000
var fire_delay_tracker = fire_delay/fire_speed

func _ready():
	gamescene = self.get_parent().get_parent()

func _process(delta):
	# Rotate the turret upward
	if Input.is_action_pressed("move_turret_up"):
		# Enforce max rotation upward
		if(current_rotation >= max_up_rotation):
			rotate(-rotation_amt)
			current_rotation -= rotation_amt 
	# Rotate the turret downward
	elif Input.is_action_pressed("move_turret_down"):
		# Enforce max rotation downward
		if(current_rotation <= max_down_rotation):
			rotate(rotation_amt)
			current_rotation += rotation_amt
	elif Input.is_action_just_pressed("switch_turret_action"):
		# Switch turret action
		turret_firing = !turret_firing
		
	if turret_firing: 
		turret_action_control()
		
		
func turret_action_control():
	if(fire_delay_tracker <= 0):
		fire_delay_tracker = fire_delay/fire_speed
		
		var instance = projectile_preload.instantiate()
		instance.rot = self.rotation
		instance.position.x = self.get_parent().position.x
		instance.position.y = self.get_parent().position.y
		
		gamescene.add_child(instance)
	else:
		fire_delay_tracker -= 10
