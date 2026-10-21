extends Area2D

@export var healAmount = 10

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" and body.has_method("Heal"):
		body.Heal(healAmount)
		await get_tree().create_timer(1).timeout
		queue_free()
