extends Control

@onready var player = $"../../../Player"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var playerVelocity = max(player.velocity.y, 0.0)
	$Speed.text = str(floor(playerVelocity / 1500 * 200))
