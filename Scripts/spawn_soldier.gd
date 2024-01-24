extends Node
var soldier_template = preload("res://Full_Assets/Blue_Soldier_Full.tscn") 
var gamescene 
@onready var side_castle 
var rng 
var y_offset

func _ready():
	#var gamescene = get_node(".")
	gamescene = self.get_parent().get_parent()
	side_castle = $"../../Blue_Tower_Full"
	rng = RandomNumberGenerator.new()
	rng.randomize()
	
	
func _on_pressed():
	var instance = soldier_template.instantiate()
	
	y_offset = rng.randi_range(-2, 2)
	
	instance.position.x = side_castle.position.x
	instance.position.y = side_castle.position.y + 825 + 150*y_offset

	gamescene.add_child(instance)
