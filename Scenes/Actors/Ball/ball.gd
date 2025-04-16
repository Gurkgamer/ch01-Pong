class_name Ball extends RigidBody2D

enum possible_ball_owners{
	NONE,
	PLAYER1,
	PLAYER2
}

@export var _ball_owner: possible_ball_owners = possible_ball_owners.NONE

var speed: float = -100.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	linear_velocity = Vector2(speed, 0)

func get_ball_owner() -> int:
	return _ball_owner
