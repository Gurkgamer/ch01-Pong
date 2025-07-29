extends RigidBody2D

var ball_direction: Vector2
var ball_max_speed: float = 400.4
var ball_velocity: Vector2

func _ready() -> void:
	ball_direction = Vector2(1,1)
	ball_velocity = ball_max_speed * ball_direction
	apply_central_impulse(ball_velocity.normalized() * 10)
	
func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	state.linear_velocity = ball_velocity
