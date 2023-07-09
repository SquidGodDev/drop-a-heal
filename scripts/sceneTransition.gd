extends ColorRect

# Path to the next scene to transition to
@export_file var next_scene_path

# Reference to the _AnimationPlayer_ node
@onready var _anim_player := $AnimationPlayer

func _ready() -> void:
	# Plays the animation backward to fade in
	self_modulate.a = 1.0
	_anim_player.play_backwards("fade")
	
func transition_to() -> void:
	# Plays the Fade animation and wait until it finishes
	_anim_player.play("fade")
	await _anim_player.animation_finished
	# Changes the scene
	get_tree().change_scene_to_file(next_scene_path)
