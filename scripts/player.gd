extends CharacterBody2D

signal healthChanged(amount)
signal energyChanged(amount)
signal addCoin(amount)
signal hitFlash

@onready var gameData: GameData = get_node("/root/GameData")

@onready var maxHealth = gameData.maxHealth
@onready var health = maxHealth

@onready var maxEnergy = gameData.maxEnergy
@onready var energy = maxEnergy

@onready var energyDrainSpeed = gameData.energyDrainSpeed

@onready var fallDamageMinimum = gameData.fallDamageMinimum
@onready var fallDamageSpeed = gameData.fallDamageSpeed
@onready var fallDamageScaling = gameData.fallDamageScaling
@onready var coinsPerHeal = gameData.coinsPerHeal

const SPEED = 100.0
const ACCELERATION = 15.0
const FRICTION = 20.0
const AIR_FRICTION = 3.0
const JUMP_VELOCITY = -200.0

var lastVelocity := 0.0
var coyoteTimeActive := false
var justLeftGround := false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
const PARACHUTE_SPEED := 30.0
const PARACHUTE_AIR_FRICTION := 20.0

func _physics_process(delta):
	# Add the gravity.
	if is_on_floor():
		if not justLeftGround:
			coyoteTimeActive = true
			justLeftGround = true
			if lastVelocity >= fallDamageSpeed:
				var fallDamage = fallDamageMinimum + (lastVelocity - fallDamageSpeed) * fallDamageScaling
				damage(fallDamage)
		$CoyoteTimer.stop()
		if $Parachute.visible and not Input.is_action_pressed("jump"):
			$Parachute.visible = false
	else:
		if justLeftGround:
			justLeftGround = false
			$CoyoteTimer.start()
		if not Input.is_action_just_pressed("jump") and Input.is_action_pressed("jump") and velocity.y >= 0:
			velocity.y = move_toward(velocity.y, PARACHUTE_SPEED, PARACHUTE_AIR_FRICTION)
			$Parachute.visible = true
		else:
			$Parachute.visible = false
			velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and (is_on_floor() or coyoteTimeActive):
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		$PlayerSprite.flip_h = direction < 0
		$AnimationPlayer.play("run")
		var curSpeed = velocity.x
		if (direction < 0 and curSpeed > 0) or (direction > 0 and curSpeed < 0): 
			velocity.x = move_toward(0, direction * SPEED, ACCELERATION)
		else:
			velocity.x = move_toward(velocity.x, direction * SPEED, ACCELERATION)
	else:
		$AnimationPlayer.play("idle")
		if is_on_floor():
			velocity.x = move_toward(velocity.x, 0, FRICTION)
		else:
			velocity.x = move_toward(velocity.x, 0, AIR_FRICTION)
	
	lastVelocity = velocity.y

	move_and_slide()

func _process(delta):
	removeEnergy(delta * energyDrainSpeed)

func addEnergy(amount):
	updateEnergy(energy + amount)
	
func removeEnergy(amount):
	updateEnergy(energy - amount)
	
func updateEnergy(newEnergy):
	energy = newEnergy
	if energy >= maxEnergy:
		energy = maxEnergy
	energyChanged.emit(energy)
	if energy <= 0:
		endRun()

func npcHealed():
	addCoin.emit(coinsPerHeal)

func damage(amount):
	health -= amount
	healthChanged.emit(health)
	hitFlash.emit()
	$PlayerSprite.self_modulate = Color(1, 0, 0, 1)
	$HitFlashTimer.start()
	if health <= 0:
		endRun()

func endRun():
	# TODO
	pass

func _on_coyote_timer_timeout():
	coyoteTimeActive = false

func _on_hit_flash_timer_timeout():
	$PlayerSprite.self_modulate = Color(1, 1, 1, 1)
