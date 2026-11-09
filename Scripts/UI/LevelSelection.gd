extends HBoxContainer

func _on_tutorial_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/Test.tscn")

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/UI/Home.tscn")

func _on_one_pressed() -> void:
	if Game.Level >= 1:
		get_tree().change_scene_to_file("res://Scenes/Levels/Level-1.tscn")

func _on_two_pressed() -> void:
	if Game.Level >= 2:
		get_tree().change_scene_to_file("res://Scenes/Levels/Level-2.tscn")

func _on_three_pressed() -> void:
	if Game.Level >= 3:
		get_tree().change_scene_to_file("res://Scenes/Levels/Level-3.tscn")

func _on_four_pressed() -> void:
	if Game.Level >= 4:
		get_tree().change_scene_to_file("res://Scenes/Levels/Level-1.tscn")
