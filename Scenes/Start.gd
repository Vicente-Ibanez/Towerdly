extends Button

func _on_button_down():
	get_tree().change_scene_to_file("res://Scenes/game_scene.tscn")
