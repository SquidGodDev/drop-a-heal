extends Node2D

const ENERGY_AMOUNT := 5

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		body.addEnergy(ENERGY_AMOUNT)
		queue_free()
