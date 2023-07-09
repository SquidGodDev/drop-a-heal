extends Node2D

const HEAL_AMOUNT := 5

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		body.heal(HEAL_AMOUNT)
		queue_free()
