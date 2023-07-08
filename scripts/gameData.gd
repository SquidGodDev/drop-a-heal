extends Node

var healSpeed := 50.0
var energyDrainSpeed := 0.4
var maxHealth := 50.0
var maxEnergy := 50.0
var fallDamageMinimum := 2.0
var fallDamageSpeed := 400.0
var fallDamageScaling := 0.02
var coins := 0
var coinsPerHeal := 3

func _ready():
	randomize()
