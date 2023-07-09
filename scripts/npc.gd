extends Area2D

@export var npcSprites: Array[CompressedTexture2D]

@onready var playerHealSpeed = get_node("/root/GameData").healSpeed

var player
var HEAL_MAX := 100.0
var healValue := 0.0
var healed := false

# Called when the node enters the scene tree for the first time.
func _ready():
	var randomSprite = npcSprites[randi() % npcSprites.size()]
	$Sprite2D.texture = randomSprite
	$ActionInputPopup.visible = false
	$ProgressBar.visible = false
	if randf() > 0.5:
		$Sprite2D.flip_h = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if healed:
		return
	if player:
		if Input.is_action_pressed("down"):
			if not $ProgressBar.visible:
				$HealStartSound.play()
			$ProgressBar.visible = true
			$ActionInputPopup.visible = false
			healValue += delta * playerHealSpeed
			$ProgressBar.value = $ProgressBar.max_value * (healValue / HEAL_MAX)
			if healValue >= HEAL_MAX:
				healed = true
				$AnimationPlayer.play("healed")
				$ActionInputPopup.visible = false
				$ProgressBar.visible = false
				player.npcHealed()
				$HealedSound.play()
		else:
			$ActionInputPopup.visible = true
			$ProgressBar.visible = false

func _on_body_entered(body):
	if body.name == "Player":
		$AlertSound.play()
		player = body

func _on_body_exited(body):
	if body.name == "Player":
		player = null
		$ActionInputPopup.visible = false
		$ProgressBar.visible = false
