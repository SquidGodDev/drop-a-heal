extends Control

@onready var gameData = get_node("/root/GameData")

func _ready():
	updateCoinCount(gameData.coins)

func updateCoinCount(amount):
	$Label.text = "%03d" % amount

func _on_player_add_coin(amount):
	gameData.coins += amount
	updateCoinCount(gameData.coins)
