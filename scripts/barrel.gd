extends Node2D

const EXPLOSION_DAMAGE := 20.0
const EXPLOSION_WAIT_TIME := 1.0

var player_body

func _on_detection_area_body_entered(body):
	if body.name == "Player":
		$DetectionArea.set_deferred("monitoring", false)
		$ExplosionTimer.start(EXPLOSION_WAIT_TIME)
		$FuseParticles.emitting = true
		$FuseSound.play()

func _on_explosion_area_body_entered(body):
	if body.name == "Player":
		player_body = body

func _on_explosion_area_body_exited(body):
	if body.name == "Player":
		player_body = null

func _on_explosion_timer_timeout():
	if player_body:
		player_body.damage(EXPLOSION_DAMAGE)
	$ExplosionSound.play()
	$ExplosionParticles.emitting = true
	$FuseParticles.emitting = false
	$Sprite2D.visible = false
	await get_tree().create_timer($ExplosionParticles.lifetime).timeout
	queue_free()
