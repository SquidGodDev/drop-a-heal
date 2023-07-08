extends Area2D

const SPIKE_DAMAGE := 5.0

func _on_body_entered(body):
	if body.name == "Player":
		if body.velocity.y != 0.0:
			body.damage(SPIKE_DAMAGE)
