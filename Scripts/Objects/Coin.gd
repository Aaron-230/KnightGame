extends Area2D

@export var CoinValue: int = 1

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		$Sound.play()
		await $Sound.finished
		queue_free()
		Game.addCoins(CoinValue)
