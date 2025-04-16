extends CharacterBody2D

@export_range(2.0,30.0) var width: float = 10.0:
	set(value):
		value = clampf(value, 2.0, 30.0)
		width = value
		%CollisionShape.shape.size.x = value
		%PhisicalShape.polygon[1].x = value
		%PhisicalShape.polygon[2].x = value
		%PhisicalShape.position.x = -(value / 2)
@export_range(10.0,300.0) var height: float = 200.0:
	set(value):
		value = clampf(value, 10.0, 300.0)
		height = value
		%CollisionShape.shape.size.y = value
		%PhisicalShape.polygon[2].y = value
		%PhisicalShape.polygon[3].y = value
		%PhisicalShape.position.y = -(value / 2)

const SPEED = 300.0
	

func _physics_process(delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_up", "ui_down")
	if direction:
		velocity.y = direction * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	var collision = move_and_slide()
	if collision:
		for next_collision in get_slide_collision_count():
			var collision_dude = get_slide_collision(next_collision)
			print(collision_dude.get_collider() is RigidBody2D)
				
