extends Node

var Coins = 0
var Health = 100

func addCoins(value):
	Coins += value

func resetGame():
	Coins = 0
	get_tree().reload_current_scene()
