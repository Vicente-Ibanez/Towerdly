extends Node

var health = 5
@export var side = "red"

func _ready():
	add_to_group(side)


func kill():
	queue_free()
	get_tree().change_scene_to_file("res://Scenes/lobby.tscn")
	

func _set_health(value):
	health = value
	if health <= 0:
		kill()


func OnHit(num):
	_set_health(health - num)
