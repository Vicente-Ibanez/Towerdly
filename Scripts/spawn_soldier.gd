extends Node
const soldier_path: String = "res://Full_Assets/Blue_Soldier_Full.tscn"
var soldier_preload = preload(soldier_path)
var mana_controller 
var gamescene 
@onready var side_castle 
var rng 
var y_offset

## Variables for mana
#var mana 
#var start_mana = 10
#var mana_gain = 1
#var mana_speed = 10
#var mana_delay = 100 / mana_speed 
#var mana_delay_tracker 


func _ready():
	gamescene = self.get_parent().get_parent()
	side_castle = $"../../Blue_Tower_Full"
	rng = RandomNumberGenerator.new()
	rng.randomize()
	mana_controller = get_node("../Mana_Display")
	
	
func _on_pressed():
	var instance = soldier_preload.instantiate()
	
	if(mana_controller.get_mana() >= instance.get_cost()):
		mana_controller.set_mana(-instance.get_cost())
		y_offset = rng.randi_range(-2, 2)
		
		instance.position.x = side_castle.position.x
		instance.position.y = side_castle.position.y + 825 + 150*y_offset

		gamescene.add_child(instance)
