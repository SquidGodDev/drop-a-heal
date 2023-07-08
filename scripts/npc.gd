extends Area2D

@export var npcSprites: Array[CompressedTexture2D]

@onready var playerHealSpeed = get_node("/root/GameData").getHealSpeed()

var touchingPlayer := false
var HEAL_MAX := 100.0
var healValue := 0.0
var healed := false

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
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
	if touchingPlayer:
		if Input.is_action_pressed("down"):
			$ActionInputPopup.visible = false
			$ProgressBar.visible = true
			healValue += delta * playerHealSpeed
			$ProgressBar.value = $ProgressBar.max_value * (healValue / HEAL_MAX)
			if healValue >= HEAL_MAX:
				healed = true
				$AnimationPlayer.play("healed")
				$ActionInputPopup.visible = false
				$ProgressBar.visible = false
		else:
			$ActionInputPopup.visible = true
			$ProgressBar.visible = false

func _on_body_entered(body):
	if body.name == "Player":
		touchingPlayer = true

func _on_body_exited(body):
	if body.name == "Player":
		touchingPlayer = false
		$ActionInputPopup.visible = false
		$ProgressBar.visible = false
