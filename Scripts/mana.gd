extends Node

# Variables for mana
var mana 
var start_mana = 10
var mana_gain = 1
var mana_speed = 10
var mana_delay = 100 / mana_speed 
var mana_delay_tracker 

#var label = $"Label"

func _ready():
	mana = start_mana
	mana_delay_tracker = mana_delay


func _process(delta):
	if mana_delay_tracker  <= 0.0:
		# Reset mana delay to restart the cooldown before next mana gain
		mana_delay_tracker = mana_delay
		set_mana(mana_gain)
	else:
		mana_delay_tracker  -= 0.1


func set_mana(amount):
	mana += amount
	self.text = str(mana)
	print_debug("mana", mana)

func get_mana():
	return mana
