class_name Player
extends CharacterBody2D

signal scored()

@export var is_bot: bool = false

@onready var ball_spawn_point: BallSpawnPoint = %BallSpawnPoint

const SPEED = 300.0

var movement
var up_key: String
var down_key: String

func _ready() -> void:
	if not is_bot:
		spawn_ball()

func _physics_process(delta: float) -> void:
	if not is_bot:
		var direction = Input.get_axis("player1_up", "player1_down")
		velocity.y = direction * SPEED
		
		move_and_slide()
		
func get_ball_spawn_point() -> Vector2:
	return ball_spawn_point.global_position
		
func spawn_ball() -> void:
	ball_spawn_point.spawn_new_ball.call_deferred(is_bot)
