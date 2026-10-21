extends HBoxContainer

func _on_tutorial_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/Test.tscn")

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/UI/Home.tscn")

func _on__pressed() -> void:
	pass
