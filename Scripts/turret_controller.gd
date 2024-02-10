extends Sprite2D
var rotation_amt = .01
#var rotation_amt = 1

var max_up_rotation = -1
var max_down_rotation = .75
var current_rotation = 0

var turret_firing = false
const projectile_path: String = "res://Full_Assets/Projectile_Full.tscn"
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var projectile_preload = preload(projectile_path)
var gamescene
var fire_speed = 1
var fire_delay = 1000
var fire_delay_tracker = fire_delay/fire_speed

# For controlling amount of bolts
var enemy="red"
var side = "blue"
var max_turret_ammo = 20
var current_turret_ammo

func _ready():
	gamescene = self.get_parent().get_parent()
	gamescene.connect("nodeRemoved", update_turret_amount)
	current_turret_ammo = max_turret_ammo


func update_turret_amount(signal_troop_type, signal_side):
	if signal_troop_type == "troop" and signal_side==enemy:
		current_turret_ammo += 1
	else:
		current_turret_ammo -=1
	print_debug("turret amt", current_turret_ammo)

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
	if(fire_delay_tracker <= 0 and current_turret_ammo > 0):
		update_turret_amount("fire", side)
		fire_delay_tracker = fire_delay/fire_speed
		
		var instance = projectile_preload.instantiate()
		instance.rot = self.rotation
		instance.position.x = self.get_parent().position.x
		instance.position.y = self.get_parent().position.y 
		
		gamescene.add_child(instance)
		if(animation_player):
			animation_player.play("turret_fire")
	else:
		fire_delay_tracker -= 10
