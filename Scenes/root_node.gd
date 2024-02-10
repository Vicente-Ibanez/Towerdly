extends Node2D

signal nodeRemoved
var troop_group = "troop"
var enemy_side = "red"


func _on_child_exiting_tree(node):
	# When a node leaves the scene, check if it's an enemy soldier
	if node.is_in_group(troop_group) and node.is_in_group(enemy_side):
		emit_signal("nodeRemoved", troop_group, enemy_side)
