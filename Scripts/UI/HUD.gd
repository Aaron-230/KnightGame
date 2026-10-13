extends CanvasLayer

func _ready() -> void:
	$CoinMeter.text = "Coins: 0"

func _process(_delta: float) -> void:
	$CoinMeter.text = "Coins: " + str(Game.Coins)
