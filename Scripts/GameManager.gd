extends Node

var Coins = 0
var Health = 100
var Level = 0

func addCoins(value):
	Coins += value

func resetGame():
	Coins = 0
	Health = 100

func resetHealth():
	Health = 100

func levelUpgrade(value):
	Level = value
