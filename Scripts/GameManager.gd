extends Node

var Coins = 0
var Health = 100

func addCoins(value):
	Coins += value

func resetGame():
	Coins = 0
	Health = 100

func resetHealth():
	Health = 100
