extends Node2D

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		$EnterSound.play()
		$CanvasLayer/SceneTransitionRect.transition_to()
