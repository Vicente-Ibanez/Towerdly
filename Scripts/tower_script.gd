extends Node

var max_health = 5
var health
@export var side = "red"
var health_bar_updated = false
signal healthChanged

func _ready():
	add_to_group(side)
	health = max_health

func _process(delta):
		if !health_bar_updated:
			emit_signal("healthChanged", (health/max_health)*100)	
			health_bar_updated = true


func kill():
	queue_free()
	get_tree().change_scene_to_file("res://Scenes/lobby.tscn")


func _set_health(value):
	health = value
	emit_signal("healthChanged", (health/max_health)*100, side)	
	if health <= 0:
		kill()


func OnHit(num):
	_set_health(health - num)
