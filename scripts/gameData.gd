extends Node

var baseMaxHealth := 50.0
var baseMaxEnergy := 50.0
var baseHealSpeed := 50.0
var baseFallDamageSpeed := 400.0

var maxHealthUpgrade := 10.0
var maxEnergyUpgrade := 10.0
var healSpeedUpgrade := 10.0
var fallDamageUpgrade := 50.0

var maxHealth := baseMaxHealth
var maxEnergy := baseMaxEnergy
var healSpeed := baseHealSpeed
var fallDamageSpeed := baseFallDamageSpeed

var energyDrainSpeed := .5
var fallDamageMinimum := 2.0
var fallDamageScaling := 0.02
var coins := 0
var coinsPerHeal := 3

var healthLevel := 0
var energyLevel := 0
var healLevel := 0
var fallDamageLevel := 0

var maxDepth := 0

func _ready():
	randomize()
