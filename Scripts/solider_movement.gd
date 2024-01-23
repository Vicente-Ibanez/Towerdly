extends CharacterBody2D
## This script controls the movement of soldiers

var speed = 700
var accel = 150
var friction = 700
var direction = 1

var side = "blue"
var enemy = "red"
var damage = 1.0
var attack_speed = 15.0
var target = NAN
var last_attack = 0.0

var is_attacking = false
var input_movement = Vector2(5, 0)

func _ready():
	add_to_group(side)

func _process(delta):
	# If not attacking, perform normal walk
	if not is_attacking:
		if input_movement == Vector2.ZERO:
			if velocity.length() > (friction*delta):
				velocity -= velocity.normalized() * (friction*delta)
			else:
				velocity = Vector2.ZERO
		else:
			velocity += direction * (input_movement * accel * delta)
			velocity = velocity.limit_length(speed)

			move_and_slide()
	# If attacking, perform attack
	if is_attacking:
		if last_attack <= 0.0:
			attack()
		else:
			last_attack -= 1.0
			

func attack():
	# Reset last attack, using attack speed to shorted the value
	last_attack = 1000.0/attack_speed
	# Last attack cannot be below 0
	last_attack = clamp(last_attack, 0.0, 1000.0)
	
	# Perform the attack
	if target:
		target.OnHit(damage)
	else:
		# If theres no target, reset attacking
		target = NAN
		is_attacking = false
	
	
func _on_area_2d_area_entered(area):
	area = area.get_parent()
	# If the object collided with is an enemy
	if area.is_in_group(enemy):
		target = area
		is_attacking = true
	

func _on_area_2d_area_exited(area):
	area = area.get_parent()
	# If target is killed or no longer in range
	if area == target:
		target = NAN
		is_attacking = false
		
