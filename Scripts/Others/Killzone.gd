extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		await get_tree().create_timer(2).timeout
		Game.resetGame()
		get_tree().reload_current_scene()
