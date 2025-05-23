class_name Player
extends CharacterBody2D

signal scored()

@export var is_bot: bool = false
var is_player2_enabled: bool = false

@onready var ball_spawn_point: BallSpawnPoint = %BallSpawnPoint

const SPEED = 300.0

var movement
var up_key: String
var down_key: String

func _ready() -> void:
	if not is_bot:
		spawn_ball()
	else:
		EventBus.toggle_second_player.connect(
			func(toggled_on: bool) -> void: is_player2_enabled = toggled_on)

func _physics_process(delta: float) -> void:
	if not is_bot:
		var direction = Input.get_axis("player1_up", "player1_down")
		velocity.y = direction * SPEED
	elif is_player2_enabled:
		var direction = Input.get_axis("player2_up", "player2_down")
		velocity.y = direction * SPEED
	else:
		_ai_move()
	move_and_slide()
		
func get_ball_spawn_point() -> Vector2:
	return ball_spawn_point.global_position
		
func spawn_ball() -> void:
	ball_spawn_point.spawn_new_ball.call_deferred(is_bot, is_player2_enabled)
	
func _ai_move() -> void:
	var direction = randf_range(-1,1)
	velocity.y = direction * SPEED
	move_and_slide()
