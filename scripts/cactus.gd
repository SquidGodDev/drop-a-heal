extends Node2D

const DAMAGE := 5.0
var player

func _on_timer_timeout():
	if player:
		player.damage(DAMAGE)
	$CactusSound.play()
	$SpikeParticles.emitting = true

func _on_hitbox_body_entered(body):
	if body.name == "Player":
		player = body

func _on_hitbox_body_exited(body):
	if body.name == "Player":
		player = null
