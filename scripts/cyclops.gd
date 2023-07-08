extends CharacterBody2D

const SPEED = 30.0
const DAMAGE = 5.0
@onready var direction := -1.0 if randf() < 0.5 else 1.0

func _ready():
	if direction == -1:
		$Sprite2D.flip_h = true

func _physics_process(_delta):
	var approachingCliff = false
	if direction == -1:
		approachingCliff = !$LeftRayCast.is_colliding()
	else:
		approachingCliff = !$RightRayCast.is_colliding()
	if is_on_wall() or approachingCliff:
		direction *= -1
		$Sprite2D.flip_h = direction == -1
	velocity.x = direction * SPEED
	move_and_slide()

func _on_hitbox_body_entered(body):
	if body.name == "Player":
		body.damage(DAMAGE)
