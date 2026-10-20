extends Control

@export_file(".tscn") var nextScene: String

func _on_start_pressed() -> void:
	if nextScene != "":
		get_tree().change_scene_to_file(nextScene)
	else:
		print("No File Specified!")

func _on_exit_pressed() -> void:
	get_tree().quit()
