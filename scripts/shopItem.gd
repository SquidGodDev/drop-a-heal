extends Node2D

enum UpgradeType {Health, Energy, Heal, FallDamage}
@export var type: UpgradeType

@onready var gameData: GameData = get_node("/root/GameData")

@onready var nameLabel = $CanvasLayer/Name
@onready var costLabel = $CanvasLayer/Cost
@onready var levelLabel = $CanvasLayer/Level

var heartTexture = preload("res://assets/images/ui/heart.png")
var energyTexture = preload("res://assets/images/ui/energy.png")
var bandageTexture = preload("res://assets/images/ui/bandage.png")
var featherTexture = preload("res://assets/images/ui/feather.png")

const COST_BASE = 10
const COST_SCALING = 10
const MAX_LEVEL = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasLayer.visible = false
	match type:
		UpgradeType.Health:
			$Sprite2D.texture = heartTexture
			setValues("Health", gameData.healthLevel)
		UpgradeType.Energy:
			$Sprite2D.texture = energyTexture
			setValues("Energy", gameData.energyLevel)
		UpgradeType.Heal:
			$Sprite2D.texture = bandageTexture
			setValues("Heal Speed", gameData.healLevel)
		UpgradeType.FallDamage:
			$Sprite2D.texture = featherTexture
			setValues("Fall Damage", gameData.fallDamageLevel)

func _process(_delta):
	if $CanvasLayer.visible and Input.is_action_just_pressed("down"):
		buyUpgrade()

func setValues(_name, _level):
	if _name:
		nameLabel.text = _name
	levelLabel.text = "Lvl: " + str(_level)
	if _level >= MAX_LEVEL:
		levelLabel.text = "Lvl: MAX"
	costLabel.text = ": %03d" % calculateCost(_level)

func buyUpgrade():
	if getLevel() >= MAX_LEVEL:
		return
	if gameData.coins >= getCost():
		$BuySound.play()
		gameData.coins -= getCost()
		incrementLevel()
		setValues(null, getLevel())
	else:
		$ErrorSound.play()
		pass

func getCost():
	return calculateCost(getLevel())

func incrementLevel():
	match type:
		UpgradeType.Health:
			gameData.healthLevel += 1
			gameData.maxHealth = gameData.baseMaxHealth + gameData.healthLevel * gameData.maxHealthUpgrade
		UpgradeType.Energy:
			gameData.energyLevel += 1
			gameData.maxEnergy = gameData.baseMaxEnergy + gameData.energyLevel * gameData.maxEnergyUpgrade
		UpgradeType.Heal:
			gameData.healLevel += 1
			gameData.healSpeed = gameData.baseHealSpeed + gameData.healLevel * gameData.healSpeedUpgrade
		UpgradeType.FallDamage:
			gameData.fallDamageLevel += 1
			gameData.fallDamageSpeed = gameData.baseFallDamageSpeed + gameData.fallDamageLevel * gameData.fallDamageUpgrade

func getLevel():
	match type:
		UpgradeType.Health:
			return gameData.healthLevel
		UpgradeType.Energy:
			return gameData.energyLevel
		UpgradeType.Heal:
			return gameData.healLevel
		UpgradeType.FallDamage:
			return gameData.fallDamageLevel

func calculateCost(level):
	return COST_BASE + (level)*COST_SCALING

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		$AlertSound.play()
		$CanvasLayer.visible = true

func _on_area_2d_body_exited(body):
	if body.name == "Player":
		$CanvasLayer.visible = false
