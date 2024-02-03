extends Node
@export var speed = 850
@export var rot = 0
var side = "blue"
var enemy = "red"
var damage = 1


func _process(delta):
	if self.position.x >= 0:
		queue_free()

func _physics_process(delta):
	#var direction = Vector2.RIGHT.rotated(self.rotation)
	var direction = Vector2.RIGHT.rotated(rot)
	self.global_position += speed * direction * delta


func _on_area_2d_area_entered(area):
	area = area.get_parent()
	if area.is_in_group(enemy):
		area.OnHit(damage)
		queue_free()
