extends ProgressBar

@onready var towerNode = get_node('../../Blue_Tower_Full')

# Called when the node enters the scene tree for the first time.
func _ready():
	towerNode.connect("healthChanged", updateBar)

func updateBar(num):
	self.value = num
