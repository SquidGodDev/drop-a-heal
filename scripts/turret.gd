extends Sprite2D

@export var projectile: PackedScene
@export var flipped := false

@export var projectileSpeed := 30.0
@export var projectileDamage := 5.0
@export var shootTime := 2.0

func _ready():
	$ShootTimer.wait_time = shootTime

func _on_shoot_timer_timeout():
	var projectileInstance = projectile.instantiate()
	var speed = projectileSpeed if flipped else -projectileSpeed
	projectileInstance.initialize(speed, projectileDamage)
	projectileInstance.position = $ShootPoint.position
	add_child(projectileInstance)
	$ShootSound.play()
