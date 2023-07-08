extends CharacterBody2D

const SPEED = 70.0
const DAMAGE = 5.0
@onready var direction := -1.0 if randf() < 0.5 else 1.0

func _physics_process(_delta):
	if is_on_wall():
		direction *= -1
	velocity.x = direction * SPEED
	move_and_slide()

func _on_hitbox_body_entered(body):
	if body.name == "Player":
		body.damage(DAMAGE)
