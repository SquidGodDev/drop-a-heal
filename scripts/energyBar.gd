extends Control

@onready var gameData = get_node("/root/GameData")

@onready var maxEnergy = gameData.maxEnergy

# Called when the node enters the scene tree for the first time.
func _ready():
	$EnergyBar.max_value = maxEnergy
	updateEnergyBar(maxEnergy)

func updateEnergyBar(amount):
	$EnergyBar.value = amount

func _on_player_energy_changed(amount):
	updateEnergyBar(amount)
