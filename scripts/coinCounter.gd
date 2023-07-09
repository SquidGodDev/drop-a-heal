extends Control

@onready var gameData: GameData = get_node("/root/GameData")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$Label.text = str(gameData.coins)
