extends CharacterBody2D

const SPEED = 100.0
const ACCELERATION = 15.0
const FRICTION = 20.0
const AIR_FRICTION = 3.0
const JUMP_VELOCITY = -200.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		$PlayerSprite.flip_h = direction < 0
		$AnimationPlayer.play("run")
		var curSpeed = velocity.x
		if (direction < 0 and curSpeed > 0) or (direction > 0 and curSpeed < 0): 
			velocity.x = move_toward(0, direction * SPEED, ACCELERATION)
		else:
			velocity.x = move_toward(velocity.x, direction * SPEED, ACCELERATION)
	else:
		$AnimationPlayer.play("idle")
		if is_on_floor():
			velocity.x = move_toward(velocity.x, 0, FRICTION)
		else:
			velocity.x = move_toward(velocity.x, 0, AIR_FRICTION)

	move_and_slide()
