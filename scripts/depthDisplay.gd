extends Control

@onready var player = $"../../../Player"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var playerDepth = getDepth()
	$Depth.text = str(floor(playerDepth))

func getDepth():
	return (player.position.y - 81) / 80
