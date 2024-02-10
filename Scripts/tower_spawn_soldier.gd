extends Node

const soldier_path: String = "res://Full_Assets/Red_Soldier_Full.tscn"
var soldier_preload = preload(soldier_path)
var mana_controller 
var gamescene 
@onready var side_castle 
var rng 
var y_offset
var bonus_mana_delay = 200
var bonus_mana_delay_tracker
var bonus_mana

func _ready():
	gamescene = self.get_parent().get_parent()
	side_castle = $".."
	rng = RandomNumberGenerator.new()
	rng.randomize()
	mana_controller = get_node("../ManaController")
	bonus_mana_delay_tracker = bonus_mana_delay
	
func _process(delta):
	if(bonus_mana_delay_tracker <= 0):
		bonus_mana = rng.randi_range(0, 3)
		mana_controller.set_mana(bonus_mana)
		bonus_mana_delay_tracker = bonus_mana_delay
	else:
		bonus_mana_delay_tracker -= 1
	
	if(mana_controller.get_mana() >= soldier_preload.instantiate().get_cost()):
		spawn_soldier()
	
func spawn_soldier():
	var instance = soldier_preload.instantiate()
	
	if(mana_controller.get_mana() >= instance.get_cost()):
		mana_controller.set_mana(-instance.get_cost())
		y_offset = rng.randi_range(-2, 2)
		
		instance.position.x = side_castle.position.x
		instance.position.y = side_castle.position.y + 625 + 150*y_offset
		
		instance.z_index = y_offset+5

		gamescene.add_child(instance)
