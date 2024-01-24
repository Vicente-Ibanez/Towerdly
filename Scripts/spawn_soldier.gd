extends Node
const soldier_path: String = "res://Full_Assets/Blue_Soldier_Full.tscn"
var soldier_preload = preload(soldier_path)
var gamescene 
@onready var side_castle 
var rng 
var y_offset

# Variables for mana
var mana 
var start_mana = 10
var mana_gain = 1
var mana_speed = 10
var mana_delay = 100 / mana_speed 
var mana_delay_tracker 


func _ready():
	gamescene = self.get_parent().get_parent()
	side_castle = $"../../Blue_Tower_Full"
	rng = RandomNumberGenerator.new()
	rng.randomize()
	
	mana = start_mana
	mana_delay_tracker = mana_delay
	
func _process(delta):
	if mana_delay_tracker  <= 0.0:
		# Reset mana delay to restart the cooldown before next mana gain
		mana_delay_tracker = mana_delay
		add_mana(mana_gain)
	else:
		mana_delay_tracker  -= 0.1
	

func add_mana(amount):
	mana += amount
	print_debug("mana", mana)

	
func _on_pressed():
	var instance = soldier_preload.instantiate()
	if(mana >= instance.get_cost()):
		mana -= instance.get_cost()
		y_offset = rng.randi_range(-2, 2)
		
		instance.position.x = side_castle.position.x
		instance.position.y = side_castle.position.y + 825 + 150*y_offset

		gamescene.add_child(instance)
