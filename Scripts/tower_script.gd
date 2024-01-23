extends Node

var max_health = 5
var health 
var side = "red"

func _ready():
	health = max_health	
	add_to_group(side)


func kill():
	queue_free()


func _set_health(value):
	health = value
	if health <= 0:
		kill()


func OnHit(num):
	_set_health(health - num)
