extends Node

var health = 5
var side = "red"

func _ready():
	add_to_group(side)


func kill():
	queue_free()


func _set_health(value):
	health = value
	if health <= 0:
		kill()


func OnHit(num):
	_set_health(health - num)
