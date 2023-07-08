extends Control

@onready var gameData = get_node("/root/GameData")

@onready var maxHealth = gameData.maxHealth

# Called when the node enters the scene tree for the first time.
func _ready():
	$HealthBar.max_value = maxHealth
	updateHealthBar(maxHealth)

func updateHealthBar(amount):
	$HealthBar.value = amount

func _on_player_health_changed(amount):
	updateHealthBar(amount)
