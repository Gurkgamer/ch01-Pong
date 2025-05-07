extends CharacterBody2D

@export var player_id: int:
	set(value):
		player_id = value if value >= 0 else 0

const SPEED = 300.0
var movement
var up_key: String
var down_key: String

func _ready() -> void:
	_set_player_inputs()

func _physics_process(delta: float) -> void:
	var direction = Input.get_axis(up_key, down_key)
	velocity.y = direction * SPEED
	
	move_and_slide()
		
func _set_player_inputs() -> void:
	match player_id:
		0:
			up_key = "player1_up"
			down_key = "player1_down"
		1:
			up_key = "player2_up"
			down_key = "player2_down"
