extends Area2D

@export_file("*.tscn") var nextLevel: String

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if nextLevel != "":
			Game.resetHealth()
			get_tree().change_scene_to_file(nextLevel)
		else:
			print("No Level Linked!")
