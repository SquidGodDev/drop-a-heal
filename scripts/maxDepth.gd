extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	var gameData = get_node("/root/GameData")
	$Label.text = "Max Depth:\n" + str(gameData.maxDepth) + "m"
