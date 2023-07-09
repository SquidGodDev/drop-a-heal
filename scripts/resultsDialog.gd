extends Control

@onready var gameData: GameData = get_node("/root/GameData")
@onready var coinsPerHeal = gameData.coinsPerHeal
@onready var npcCounter = $"../NPCCounter"
@onready var depthDisplay = $"../DepthDisplay"
@onready var sceneTransition = $"../../SceneTransitionRect"
@onready var darken = $"../Darken/AnimationPlayer"

const DEPTH_BONUS = 0.1

var displayVisible := false

func _ready():
	position.y = 300

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if displayVisible:
		if Input.is_action_just_pressed("down") or Input.is_action_just_pressed("jump"):
			sceneTransition.transition_to()

func runEnded():
	darken.play("darken")
	var npcCount = npcCounter.getNPCCount()
	var npcCoins = coinsPerHeal * npcCount
	var depth = floor(depthDisplay.getDepth())
	$NPCCount.text = "x" + str(npcCount)
	$DepthBonus.text = "Depth: %dm" % depth
	var depthCoins = ceil(DEPTH_BONUS * depth)
	var totalCoins = depthCoins + npcCoins
	gameData.coins += totalCoins
	$Total.text = "Total: " + str(totalCoins)
	$AnimationPlayer.play("enter")
	await $AnimationPlayer.animation_finished
	displayVisible = true

func _on_player_run_ended():
	runEnded()
