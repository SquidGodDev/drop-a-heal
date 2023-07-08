extends Area2D

var projectileSpeed: float
var projectileDamage: float

func initialize(speed, damage):
	projectileSpeed = speed
	projectileDamage = damage

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position.x += projectileSpeed * delta

func _on_body_entered(body):
	if body.name == "Player":
		body.damage(projectileDamage)
	queue_free()
